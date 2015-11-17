import string
import logging
logger = logging.getLogger(__name__)

def set_from_dict(d):
        return frozenset(
            (k, set_from_dict(v) if isinstance(v, dict) else v if not isinstance(v, list) else frozenset((k, set_from_dict(elem)) for elem in v))
            for k, v in d.iteritems())


class Big_Mech(object):

    def __init__(self, database):
        self.db = database
        self.mycollection_SRI = database.SRI_Datums
        self.mycollection_UniProt = database.nameToUniProtId    


    def get_uniprot_ids(self, mystring):
        id_list = []
        cursor = self.mycollection_UniProt.find({ "name": mystring }, { "id":1, "_id":0 })
        if cursor.count() > 0:
            for each_name in cursor:
                id_list.extend(each_name["id"])
        return id_list


    def get_PMCID_details(self, query):
        pmid_details = []
        cursor = self.mycollection_SRI.find(
        {
            "Datums":
             {
                "$elemMatch": query                    
             }
        },
        { "PMCID":1, "Title":1, "PubDate":1, "Volume":1, "Issue":1, "Pages":1, "FullJournalName":1, "Authors":1, "Datums":1, "_id":0 }
        )
        if cursor.count() > 0:
            for each_doc in cursor:     # each_doc is a dictionary                
                each_doc["Datums"] = {v["evidence"][0]:v for v in each_doc["Datums"]}.values()
                pmid_details.append(each_doc)
        return pmid_details


    def get_PMCID_datums(self, query1, query2, selected_datums, srno_datumid):
        #logger.info('Inside get_PMID_datums')
        pmcid_datums = []
        cursor = self.mycollection_SRI.aggregate(
        [
        { "$match": {
            "Datums":
            {
                "$elemMatch": query1                
                        
            }
        }},
        { "$project": { "PMCID":1, "Title":1, "PubDate":1, "Volume":1, "Issue":1, "Pages":1, "FullJournalName":1, "Authors":1, "Datums.map.assay.Text":1, "Datums.map.change.Text":1, "Datums.map.subject.Entity.strings":1, "Datums.map.subject.Entity.uniprotSym":1, "Datums.map.treatment.Entity.strings":1, "Datums.map.treatment.Entity.uniprotSym":1, "Datums.datum_id":1, "_id":0 }},
        { "$unwind": "$Datums" },
        { 
          "$match": query2
        },
        { "$project": { "PMCID":1, "Title":1, "PubDate":1, "Volume":1, "Issue":1, "Pages":1, "FullJournalName":1, "Authors":1, "Datums.map.assay.Text":1, "Datums.map.change.Text":1, "Datums.map.subject.Entity.strings":1, "Datums.map.treatment.Entity.strings":1, "Datums.datum_id":1, "_id":0 }},        
        { "$group": { "_id": {"PMCID": "$PMCID", "Title": "$Title", "PubDate": "$PubDate", "Volume": "$Volume", "Issue": "$Issue", "Pages": "$Pages", "FullJournalName": "$FullJournalName", "Authors": "$Authors"}, "Datums": { "$addToSet": "$Datums" }}}
        ] 
        #{ allowDiskUse: 1 }
        )

        for each_doc in cursor:     # each_doc is a dictionary 
            seen = set(); reprsn_datumid = {}        
            result = []; datum_ids = []; reprsn_srno = {}
            for srno,d in enumerate(each_doc["Datums"]): 
                datum_ids.append(d["datum_id"])
                d.pop("datum_id", None)           
                representation = set_from_dict(d)
                if representation in reprsn_datumid:
                    reprsn_datumid[representation].append(datum_ids[-1])
                else:
                    reprsn_datumid[representation] = [datum_ids[-1]]
                if representation in seen:                    
                    continue
                d["sr_no"] = str(srno+1); result.append(d)
                seen.add(representation); reprsn_srno[representation] = d["sr_no"]

            srno_datumid[each_doc["_id"]["PMCID"]] = {}
            for repre in seen:
                srno_datumid[each_doc["_id"]["PMCID"]][reprsn_srno[repre]] = reprsn_datumid[repre]
            each_doc["Datums"] = result; each_doc["Uniq_Datums"] = len(result)
            selected_datums["PMC" + each_doc["_id"]["PMCID"]] = datum_ids                           
            pmcid_datums.append(each_doc)

        return pmcid_datums 

        
