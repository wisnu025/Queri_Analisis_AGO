select * from AGODIST.trans_pengiriman where mat_doc_sap in (
'4913501081',
'4914404926',
'4916397006',
'4917014537',
'4917259682');

select * from AGODIST.trans_penerimaan where material_document_pengiriman in(
'45804913501081',
'45804914404926',
'45804916397006',
'45804917014537',
'45804917259682');

select * from AGODIST.mutasi_stock where material_document in (
'411111805144734');

select * from AGODIST.mutasi_stock where plant='5323' and stor_loc='3020'  and material_no='000000000003060130';