-- WARNING: This schema and data is tailored to PredictFathmmTest and verified only for those test cases.
-- MySQL dump is not compatible with H2 and there has been lots of modifications to make this file work.
-- Do not reuse for anything out of this context. 

--
-- Table structure for table `DOMAINS`
--

DROP TABLE IF EXISTS `DOMAINS`;
CREATE TABLE `DOMAINS` (
  `id` int(11) NOT NULL,
  `hmm` char(15) NOT NULL,
  `score` double NOT NULL,
  `seq_begin` int(11) NOT NULL,
  `seq_end` int(11) NOT NULL,
  `hmm_begin` int(11) NOT NULL,
  `align` varchar(500) NOT NULL,
  KEY `id` (`id`),
  KEY `hmm` (`hmm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `LIBRARY`
--

DROP TABLE IF EXISTS `LIBRARY`;
CREATE TABLE `LIBRARY` (
  `id` char(15) NOT NULL,
  `accession` char(30) NOT NULL,
  `description` varchar(200),
  PRIMARY KEY (`id`),
  KEY `accession` (`accession`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `ONTOLOGIES`
--

DROP TABLE IF EXISTS `ONTOLOGIES`;
CREATE TABLE `ONTOLOGIES` (
  `id` char(2) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `PHENOTYPES`
--

DROP TABLE IF EXISTS `PHENOTYPES`;
CREATE TABLE `PHENOTYPES` (
  `id` char(30) NOT NULL,
  `type` char(2) NOT NULL,
  `accession` char(30) NOT NULL,
  `description` char(150) NOT NULL,
  `score` double NOT NULL,
  `origin` char(1) NOT NULL,
  KEY `accession2` (`accession`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `PROBABILITIES`
--

DROP TABLE IF EXISTS `PROBABILITIES`;
CREATE TABLE `PROBABILITIES` (
  `id` char(15) NOT NULL,
  `position` int(11) NOT NULL,
  `A` double NOT NULL,
  `C` double NOT NULL,
  `D` double NOT NULL,
  `E` double NOT NULL,
  `F` double NOT NULL,
  `G` double NOT NULL,
  `H` double NOT NULL,
  `I` double NOT NULL,
  `K` double NOT NULL,
  `L` double NOT NULL,
  `M` double NOT NULL,
  `N` double NOT NULL,
  `P` double NOT NULL,
  `Q` double NOT NULL,
  `R` double NOT NULL,
  `S` double NOT NULL,
  `T` double NOT NULL,
  `V` double NOT NULL,
  `W` double NOT NULL,
  `Y` double NOT NULL,
  `information` double NOT NULL,
  PRIMARY KEY (`id`,`position`),
  KEY `id2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `PROTEIN`
--

DROP TABLE IF EXISTS `PROTEIN`;
CREATE TABLE `PROTEIN` (
  `id` int(11) NOT NULL,
  `name` char(100) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `id3` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `SEQUENCE`
--

DROP TABLE IF EXISTS `SEQUENCE`;
CREATE TABLE `SEQUENCE` (
  `id` int(11) NOT NULL,
  `sequence` varchar(6000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `VARIANTS`
--

DROP TABLE IF EXISTS `VARIANTS`;
CREATE TABLE `VARIANTS` (
  `id` char(25) NOT NULL,
  `protein` char(100) NOT NULL,
  `substitution` char(10) NOT NULL,
  KEY `id4` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `WEIGHTS`
--

DROP TABLE IF EXISTS `WEIGHTS`;
CREATE TABLE `WEIGHTS` (
  `id` char(15) NOT NULL,
  `type` char(60) NOT NULL,
  `disease` double NOT NULL,
  `other` double NOT NULL,
  PRIMARY KEY (`id`,`type`),
  KEY `id5` (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `DCC_CACHE`
--

DROP TABLE if exists `DCC_CACHE`;
CREATE TABLE `DCC_CACHE` (
   `translation_id` varchar(64) NOT NULL,
   `aa_mutation` varchar(64) NOT NULL,
   `score` varchar(16),
   `prediction` varchar(16)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data.
--

INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_12036',3e-77,1490,1699,651,'PKVDINAPDVEVHGPDWHLKMPKVKMPKFSMPGFKGEGPEVDMNLPKADLGVSGPKVDIDVPDVNLEAPEGKLKGPKFKMPSmnIQTHKISMPDVGLNLKAPKLKTDVDVSLPKVEGdlkgpeiDVKAPKMDVNVGDIDIEGPEGKLKGPKFKMPEMhfKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKVPDVDIKGPKVDIDAP');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_3055',4.5e-27,1556,1760,2048,'EAPEGKLKGPKFKMPSMNIQTHKISMpDVGLNLKAPKLKTdvDVSLPKVEGDLKGPEIDVKAPKMDV--NVGDIDIEGPEG-------------KLKGPKFKMPEMHFKAPKISMPDVDLHLKGPKVK---GDMDVSVPKVEGEMKVPDVDIKGPKVDIDAP--DVEVHDPDWHLKMPKMKMPKFSMPGF-KAEGPEVDVNLPKADIDVSGPSVDTD--APDLDIEGP');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_3370',1.7e-17,1570,1765,1331,'PSMNIQTHK--ISMPDVGLNLkaPKLKTDVDVSLPKVEGDLKGPEIDVKAPKMDVNVGDIDIEG--PEGKLkgPKFKMPEMhfKAPKIsmPDVDlhLKGPKVkgdmDVSVPKVEgeMKVPDVDIKGPKVDIDAPD---VEVHDPDWHlkMPKMKMPKfsMPGFKAEGPEVDVNLPKADIdvSGPSVDTDAPDLDIEGPEGKLK');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_3051',9.4e-25,1586,1810,281,'LNLKAPKLK---TDVDVSLPKVEGDLKGPEIDVKAPKM--DVNVGDIDIEGPEGKLKGPKFKMPEMHFKAPKISMpDVDLHLKGPKVKgdMDVSVPKVEGEMKVPDVDIKGPKVDI--DAPDVEVHDPDWHL--------KMPKMKMPKFSMPGFKAEGPEVDVNLPKADidVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMpDVDLNLKGPKlkgEIDASVPELEGDL');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_3665',1.2e-16,1608,1698,9,'LKGPEIDVKAPKMDVNVG----DIDIEGPEGKLKGPKFKMPEmhFKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKVPDvdikgPKVDIDA');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_292',2.9e-117,1612,1835,635,'EIDVKAPKMDVNVGDIDIEGPEGKLKGPKFKMPEMHFKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKVPDVDIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADIDVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMPDVDLNLKGPKLKGEIDASVPELEGDLRGPQVDVKGPFVEAEVPDVDLECPD');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_817',1.4e-117,1614,1822,505,'DVKAPKMDVNVGDIDIEGPEGKLKGPKFKMPEMHFKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKvpdvdikGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAegpEVDVNLPKADIDVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMPDVDLNLKGPKLKGEIDASVPELEGDLRGPQVDVKGPFV');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_1592',0.00011,1629,1751,227,'IEGPEGKLKGpKFKMPEMHFKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKvpdvDIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNL-PKADIDVSGPSVDTD');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_2880',0.0000002,1657,1736,1008,'DVDLHLKGPKVKGDMDVSvpkvegEMKVPDVDIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKaeGPEVDVNL');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_9042',0.000001,1679,1795,65,'EGEMKVPDV-------------DIKGPKVDIDApdveVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADIDVSGPSVDTD---APDLDIEGPEGKlkGSKFKMPKLNIKAPKVSMPDVDLNLKGPKL');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_18095',4.5e-73,1683,1819,187,'KVPDVDIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADIDVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMPDVDLNLKGPKLKGEIDASVPELEGDLRGPQVDVKG');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_15799',0.0000000000000022,1688,1787,107,'DIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPE--VDVNLPKADIDVSGPSVDTDA----PDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMPDVD');
INSERT INTO `DOMAINS` VALUES (20160,'Pfam-B_12036',6.8e-73,1693,1898,652,'KVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADIDVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKlnIKAPKVSMPDVDLNLKGPKLKGEIDASVPELEGDLRGPQVDVKGPfveaevpDVDLECPDAKLKGPKFKMPEMhfKAPKISMPDVDLHLKGPKVKGDADVSVPKLEGDLTGPSVGVEVPDVEL');
INSERT INTO `DOMAINS` VALUES (2125,'Pfam-B_16349',0.00017,106,234,69,'EGVGEACEEDGVDTSEEDPTLAGEEDVKDTREEDGADASEEDLTRARQEEGADASEEDPTPAGEEDVKDAREEDGVDTIEEDLTRAGEEDGKDTREEDGADASEEDPTWAGEEEGADSGEEDGADASEE');
INSERT INTO `DOMAINS` VALUES (2127,'Pfam-B_16349',0.00032,200,328,69,'EGVGEACEEDGVDTSEEDPTLAGEEDVKDTREEDGADASEEDLTRARQEEGADASEEDPTPAGEEDVKDAREEDGVDTIEEDLTRAGEEDGKDTREEDGADASEEDPTWAGEEEGADSGEEDGADASEE');
INSERT INTO `DOMAINS` VALUES (31761,'0052775',1.83e-142,89,463,1,'PAAHGVLRLVMELSGEMVRKCDPHIGLLHRGTEKLIEYKTYLQALPYFDRLDYVSMMCNEQAYSLAVEKLLNIRPPPRAQWIRVLFGEITRLLNHIMAVTTHALDLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDRYLCRVEEMRQSLRIIAQCLNKMPPGEIKVDDAKVSPPKRAEMKTSMESLIHHFKLYTEGYQVPPGATYTAIEAPKGEFGVYLVSDGSSRPYRCKIKAPGFAHLAGLDKMSKGHMLADVVAIIGTQDIVFGEVDR');
INSERT INTO `DOMAINS` VALUES (31761,'Complex1_49kDa',2.7e-138,193,463,1,'DLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDRYLCRVEEMRQSLRIIAQCLNKMPPGE-IKVDDAKVSPPKRAEMKTSMESLIHHFKLYTEGYQVPPGATYTAIEAPKGEFGVYLVSDGSSRPYRCKIKAPGFAHLAGLDKMSKGHMLADVVAIIGTQDIVFGEVDR');
INSERT INTO `DOMAINS` VALUES (31763,'0052775',4.32e-89,2,231,12,'ELSGEMVRKCDPHIGLLHRGTEKLIEYKTYLQALPYFDRLDYVSMMCNEQAYSLAVEKLLNIRPPPRAQWIRVLFGEITRLLNHIMAVTTHALDLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDR');
INSERT INTO `DOMAINS` VALUES (31763,'Complex1_49kDa',1.9e-68,95,231,1,'DLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDR');
INSERT INTO `DOMAINS` VALUES (47241,'0040854',0.000000000235,187,223,2,'TRHPKYKTELCRTFHTIGFCPYGPRCHFIHNADERRP');
INSERT INTO `DOMAINS` VALUES (47241,'zf-CCCH',0.0000000000094,192,217,1,'YKTELCRTFHTIGFCPYGPRCHFIHN');
INSERT INTO `DOMAINS` VALUES (60531,'0046753',0.000000000000456,20,213,28,'RLIRNARYAEAVQLLGGELQRSPRSRAGLSLLGYCYYRLQEFALAAECYEQLGQLHPELEQYRLYQAQALYKACLYAEATRVAFL-LLDNPAYHSRVLRLQAA-------IKYSEGDLPGSRSLVEQLPS--REGGEESGGENETDGQINLGCLLYKEGQYEAACSKFFAALQASGYQPDLSYNLALAYYSSRQYASALK----------------------------------HIAE');
INSERT INTO `DOMAINS` VALUES (6215,'0050784',1.11e-23,254,311,1,'AFTRSGSFRYHERTHTGEKPYEC--KQCGKAFRSAPNLQLHGR-THTGEKPYQCKECGKAF');
INSERT INTO `DOMAINS` VALUES (6215,'zf-H2C2_2',0.0000000016,261,284,2,'FRYHERTHTGEKPYECKQCGKAFR');
INSERT INTO `DOMAINS` VALUES (6215,'Pfam-B_11295',0.00004,268,354,449,'HTGEKpyeCKQCGKAFRSAPNLQLHGRTHTGEKPYQCK--ECGKAFRSASQLRIHRRIHTGEKPYECKKCGKAFRYVQN-FRFHERTQTH');
INSERT INTO `DOMAINS` VALUES (6217,'0050784',1.88e-23,390,447,1,'AFTRSGSFRYHERTHTGEKPYEC--KQCGKAFRSAPNLQLHGR-THTGEKPYQCKECGKAF');
INSERT INTO `DOMAINS` VALUES (6217,'zf-H2C2_2',0.0000000023,397,420,2,'FRYHERTHTGEKPYECKQCGKAFR');
INSERT INTO `DOMAINS` VALUES (6217,'Pfam-B_11295',0.000067,405,490,450,'TGEKpyeCKQCGKAFRSAPNLQLHGRTHTGEKPYQCK--ECGKAFRSASQLRIHRRIHTGEKPYECKKCGKAFRYVQN-FRFHERTQTH');

INSERT INTO `LIBRARY` VALUES ('0040854','90229','CCCH zinc finger');
INSERT INTO `LIBRARY` VALUES ('0046753','48452','TPR-like');
INSERT INTO `LIBRARY` VALUES ('0050784','57667','beta-beta-alpha zinc fingers');
INSERT INTO `LIBRARY` VALUES ('2125','','');
INSERT INTO `LIBRARY` VALUES ('2127','','');
INSERT INTO `LIBRARY` VALUES ('Complex1_49kDa','PF00346.14','Respiratory-chain NADH dehydrogenase, 49 Kd subunit');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_11295','PB011295','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_12036','PB012036','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_15799','PB015799','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_1592','PB001592','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_16349','PB016349','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_18095','PB018095','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_2880','PB002880','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_292','PB000292','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_3051','PB003051','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_3055','PB003055','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_3370','PB003370','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_3665','PB003665','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_817','PB000817','');
INSERT INTO `LIBRARY` VALUES ('Pfam-B_9042','PB009042','');
INSERT INTO `LIBRARY` VALUES ('zf-CCCH','PF00642.19','Zinc finger C-x8-C-x5-C-x3-H type (and similar)');
INSERT INTO `LIBRARY` VALUES ('zf-H2C2_2','PF13465.1','Zinc-finger double domain');
INSERT INTO `LIBRARY` VALUES ('0052775', '56762', 'HydB/Nqo4-like');

INSERT INTO `PROBABILITIES` VALUES ('0040854',26,0.0661129920501,0.00733021816665,0.0781324355824,0.0692556880072,0.0263889478112,0.0642605092814,0.0338211138973,0.0194521047773,0.0898754909832,0.0391204472934,0.0113283142661,0.096192873894,0.0351110283449,0.0512986932418,0.101396165918,0.0936922316305,0.0599568585229,0.025953468952,0.00940127462965,0.0221134335983,0.196511425593);
INSERT INTO `PROBABILITIES` VALUES ('0046753',128,0.052777516649,0.0142990811361,0.102954308085,0.0875994990205,0.00951933771834,0.209217687936,0.0238323828301,0.00633725227238,0.0888229692239,0.0156148951963,0.00967229176676,0.095926788332,0.0385819781054,0.0502778830182,0.0416389188412,0.0750020374361,0.0478305845479,0.0111955376968,0.00486640406324,0.0142595274884,0.448971246945);
INSERT INTO `PROBABILITIES` VALUES ('0050784',18,0.0502432032449,0.00744799805613,0.0673616105327,0.268888092217,0.0218544656664,0.0445657344996,0.0188547576822,0.0409517800813,0.067830047754,0.0584794423105,0.0182629657345,0.0369078874037,0.0328051422489,0.0450001255147,0.0408103317689,0.0454074087011,0.041523323399,0.0605836635883,0.00856141327703,0.0241483312657,0.313051271971);
INSERT INTO `PROBABILITIES` VALUES ('2125',157,0.144756826937,0.00898274288089,0.0412155362608,0.0702011911602,0.0176327025789,0.030946666241,0.02249932433,0.0334120054157,0.129918233434,0.0467809130528,0.0201439758611,0.0436212876033,0.0686461657827,0.051001001969,0.0491863073555,0.0649868719165,0.0542186680973,0.0795977064491,0.00477596132837,0.0174769921039,0.160871358981);
INSERT INTO `PROBABILITIES` VALUES ('2127',251,0.127656782901,0.00823336893448,0.0453815338532,0.0777590761257,0.0170424157204,0.0308296003559,0.0248000403202,0.031792972633,0.141181356325,0.0461734648405,0.0200100626391,0.0473565565041,0.0205127219991,0.0840208749251,0.0593484069443,0.0656406572409,0.0545498672638,0.0749885382843,0.00484726815373,0.0178741454239,0.197183305709);
INSERT INTO `PROBABILITIES` VALUES ('Complex1_49kDa',101,0.0669539640156,0.0134257603946,0.0197131372502,0.0328721330464,0.0332570002568,0.0250084877934,0.0152842865685,0.0831424397922,0.0372475167801,0.248296917739,0.0344422937605,0.0249697546632,0.0158144689764,0.0273551628028,0.0287919340147,0.0902537618581,0.0501212604814,0.124022782551,0.00658052993272,0.0224469619302,0.27999648564);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_11295',452,0.0397271677157,0.00467301876337,0.0709209076241,0.505053961985,0.0086316465357,0.0308542739043,0.016531626089,0.014060581992,0.0487402549491,0.0214908073585,0.00813092976274,0.0436025344818,0.0165811296219,0.0361980510499,0.0316793572838,0.0413732807094,0.0291465128829,0.0197844302822,0.0028227039667,0.0099985019721,1.11974399849);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_12036',656,0.0416872480126,0.00490578577509,0.0731509620397,0.481962002995,0.00912643620107,0.0319852634321,0.0172704211656,0.0150107300041,0.0512530577156,0.0228046686188,0.00863838184642,0.0452691270912,0.0172409139812,0.0378550835622,0.0333949696374,0.0432905895068,0.0306255699401,0.0210479944274,0.00295847898244,0.0105224942896,1.03532460443);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_12036',847,0.0454614756809,0.00345017611988,0.127443773985,0.36866017287,0.00681444946451,0.0736014906541,0.0196531037792,0.0109682559602,0.0536099818339,0.0183936460017,0.00799547118079,0.0568351674273,0.0180810653776,0.04558940208,0.0296483145503,0.0507994373625,0.0341354105821,0.0170859293368,0.00214115473432,0.00963117544378,0.795852721104);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_15799',116,0.0932258719298,0.00717300933809,0.044049556269,0.144070862464,0.0152893312154,0.0281218057005,0.0225551919015,0.0276989714014,0.0749405609742,0.0931261735949,0.0179694892673,0.0445394484714,0.018832145543,0.0710564960033,0.047583462718,0.0612060033696,0.129971510831,0.0380608151441,0.00429334126302,0.0162370436837,0.219366113487);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_1592',290,0.0609897171701,0.0105900542143,0.0318677739759,0.0575638794999,0.0555040104766,0.0458894516442,0.0169961233358,0.0291745069703,0.0525200645759,0.0409628385547,0.0488275781364,0.0317113695982,0.104495632783,0.079639904415,0.0428191434296,0.108752567511,0.0919647433352,0.0382833577778,0.0366489683408,0.0147999718536,0.229198824676);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_16349',120,0.219524815102,0.0115000948019,0.0734816179471,0.0686949218668,0.01819733726,0.0396549300267,0.0205242123404,0.0405795919533,0.0608124950764,0.0486706061953,0.0198923508608,0.0450974308377,0.0222256111422,0.0447927044464,0.0401983230259,0.0735794135186,0.0588554995114,0.0723601171115,0.00459764988777,0.0167606734962,0.190879037485);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_18095',201,0.051833428501,0.00425300281851,0.292231202684,0.115907826833,0.008416257727,0.0391752542756,0.0218380809621,0.0129728054635,0.0572424226939,0.0210642076244,0.00889549775913,0.134718212074,0.0207192926642,0.0497432750196,0.0316581392233,0.0573231914384,0.0381240485665,0.0200401002557,0.00251649051721,0.0113253692872,0.727143380929);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_2880',1042,0.0456587506627,0.0039920515791,0.0351022516849,0.0606891709277,0.00786785348705,0.035597139339,0.0339879237936,0.0134347586681,0.180174401491,0.0915912074909,0.0103061961155,0.141717448919,0.122326693211,0.0423752844763,0.0380908950681,0.0678700792903,0.036238977967,0.0201917737019,0.00255005589613,0.0102351234335,0.467665358913);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_292',720,0.0697707787095,0.0052433744967,0.172423779178,0.11004895134,0.0103805647003,0.0383189778613,0.0250838767451,0.0174120984702,0.101033816636,0.0285405327593,0.012956858722,0.091552747261,0.0217041889043,0.0596954187132,0.0467912059859,0.0971062052461,0.0485170498265,0.0263667904025,0.00328332056929,0.01376866391,0.375656361494);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_3051',396,0.0521954475282,0.00568775306927,0.0491474655173,0.0750755754605,0.0107783045849,0.0289521735018,0.0254148914295,0.0192152700681,0.175604670632,0.0323364565332,0.0136734401909,0.0466207293931,0.0187090109911,0.21494136693,0.0912137158607,0.0531259377568,0.0422897727975,0.0269481669672,0.00397965558445,0.0140890130733,0.584009968199);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_3055',2204,0.058998692284,0.00568485305477,0.308192713035,0.108785198175,0.00985516101603,0.0409972617948,0.0215327553188,0.0158562743333,0.0569449652212,0.024135294687,0.0101165761244,0.0623164402225,0.0214880137352,0.0485175349995,0.0325844532021,0.0925043137885,0.0421184243926,0.0243600690885,0.00282335326327,0.0121854824369,0.640214200858);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_3370',1446,0.0847898022416,0.0133988017187,0.0296773841404,0.0378232986436,0.017289947772,0.0429211743596,0.0137820259935,0.0408924430299,0.0399654479264,0.047037976166,0.0165460148619,0.0311833805739,0.0210646289128,0.0270567166371,0.0310166847978,0.0692508402787,0.362174188205,0.056066880848,0.00414111584369,0.0139191456734,0.674112825052);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_3665',95,0.0574959941823,0.0060035759237,0.159584773923,0.0726486842453,0.110538655021,0.0692861672148,0.0211112332215,0.0224045772383,0.114273566402,0.0340501786399,0.0151863238934,0.0427806235371,0.0174790894687,0.0494585665161,0.0434471509583,0.0567391971121,0.0454782995391,0.0314656123779,0.00381284366299,0.0267540343551,0.310922586249);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_817',581,0.0530224431183,0.00448879943229,0.303297835746,0.103696180151,0.00855781823846,0.0353311594652,0.0215433089544,0.0141362904125,0.0851534803111,0.0229251664554,0.0100336583774,0.0585625421055,0.0196725699861,0.0500671587403,0.036223760792,0.097875403703,0.039841348458,0.0215793163381,0.00263482108164,0.0113563297872,0.65880388878);
INSERT INTO `PROBABILITIES` VALUES ('Pfam-B_9042',96,0.0575788480544,0.00781211144653,0.0606915985431,0.06694793843,0.0144090326743,0.0372527317975,0.0173863476248,0.0185887262057,0.0513145983018,0.0269007799062,0.0103399525385,0.399788348765,0.0192485412566,0.0358995686098,0.0358687082527,0.0540811274309,0.0390614199948,0.0275412609665,0.0039711879393,0.0153148857306,0.985686751686);
INSERT INTO `PROBABILITIES` VALUES ('zf-CCCH',20,0.0785531353293,0.0103549563448,0.0484239864603,0.053614270804,0.0373273118163,0.00273692568851,0.0111740628868,0.00154250123737,0.111136066951,0.0210610482302,0.00125388317875,0.0613113682833,0.00184657999889,0.111030537821,0.248886079315,0.102534084907,0.0698440765017,0.00960664723316,0.000311808918026,0.0174502727515,0.766917066669);
INSERT INTO `PROBABILITIES` VALUES ('zf-H2C2_2',12,0.0106606061474,0.000270596980724,0.0433161384908,0.345787795458,0.0211038455827,0.00957901989159,0.0152235760021,0.0111316820225,0.137820936222,0.0257551673041,0.0197980862499,0.0371649190103,0.117175789197,0.0811561664188,0.0163812154502,0.028644896051,0.0294344359278,0.0437274162262,0.00244703057429,0.0034224110189,0.903309665671);
INSERT INTO `PROBABILITIES` VALUES ('0052775',205,0.145699353936,0.00971261230909,0.0187764848107,0.027093267871,0.0331023831732,0.0544120305366,0.0156799884605,0.107772796924,0.0246728951559,0.240828552276,0.0298127239027,0.0166085110692,0.0190650206984,0.0230366235777,0.0327599023753,0.0398321860016,0.0357248054838,0.0782411151827,0.0120993929144,0.0353551928241,0.289470479908);

INSERT INTO `PROTEIN` VALUES (2127,'ENSP00000262109');
INSERT INTO `PROTEIN` VALUES (47241,'ENSP00000282388');
INSERT INTO `PROTEIN` VALUES (6217,'ENSP00000305077');
INSERT INTO `PROTEIN` VALUES (31761,'ENSP00000356972');
INSERT INTO `PROTEIN` VALUES (20160,'ENSP00000367263');
INSERT INTO `PROTEIN` VALUES (60531,'ENSP00000386181');
INSERT INTO `PROTEIN` VALUES (6215,'ENSP00000395632');
INSERT INTO `PROTEIN` VALUES (2128,'ENSP00000428556');
INSERT INTO `PROTEIN` VALUES (2125,'ENSP00000428635');
INSERT INTO `PROTEIN` VALUES (31763,'ENSP00000446447');

INSERT INTO `SEQUENCE` VALUES (2127,'MAAHRKHVFVEKVLQRLFPPVPSGQGKREPQTLAVQNPPKKVTSEKVSQKHAEPLTDTGSETPTARRLYTASGPPEGYVPCWPEPSSCGSPENASSGDDTEDQDPHDQPKRRRIRKHKSKKKFKNPNNVLIEQAELEKQQSLLQEKSQRQHTDGTTISKNKKRKLKKKQQIKRKKAAGLAAKAAGVSFMYQPEDSSNEGEGVGEACEEDGVDTSEEDPTLAGEEDVKDTREEDGADASEEDLTRARQEEGADASEEDPTPAGEEDVKDAREEDGVDTIEEDLTRAGEEDGKDTREEDGADASEEDPTWAGEEEGADSGEEDGADASEEDDTITNEKAHSILNFLKSTQEMYFYDGVSRDAASAALADAAEELLDRLASHSMLPSDVSILYHMKTLLLLQDTERLKHALEMFPEHCTMPPDHARVISAFFSYWITHILPEKSSD');
INSERT INTO `SEQUENCE` VALUES (47241,'MSTTLLSAFYDVDFLCKTEKSLANLNLNNMLDKKAVGTPVAAAPSSGFAPGFLRRHSASNLHALAHPAPSPGSCSPKFPGAANGSSCGSAAAGGPTSYGTLKEPSGGGGTALLNKENKFRDRSFSENGDRSQHLLHLQQQQKGGGGSQINSTRYKTELCRPFEESGTCKYGEKCQFAHGFHELRSLTRHPKYKTELCRTFHTIGFCPYGPRCHFIHNADERRPAPSGGASGDLRAFGTRDALHLGFPREPRPKLHHSLSFSGFPSGHHQPPGGLESPLLLDSPTSRTPPPPSCSSASSCSSSASSCSSASAASTPSGAPTCCASAAAAAAAALLYGTGGAEDLLAPGAPCAACSSASCANNAFAFGPELSSLITPLAIQTHNFAAVAAAAYYRSQQQQQQQGLAPPAQPPAPPSATLPAGAAAPPSPPFSFQLPRRLSDSPVFDAPPSPPDSLSDRDSYLSGSLSSGSLSGSESPSLDPGRRLPIFSRLSISDD');
INSERT INTO `SEQUENCE` VALUES (6217,'MLSLSPILLYTCEMFQDPVAFKDVAVNFTQEEWALLDISQKNLYREVMLETFWNLTSIGKKWKDQNIEYEYQNPRRNFRSVTEEKVNEIKEDSHCGETFTPVPDDRLNFQKKKASPEVKSCDSFVCEVGLGNSSSNMNIRGDTGHKACECQEYGPKPWKSQQPKKAFRYHPSLRTQERDHTGKKPYACKECGKNIIYHSSIQRHMVVHSGDGPYKCKFCGKAFHCLSLYLIHERTHTGEKPYECKQCGKSFSYSATHRIHERTHIGEKPYECQECGKAFHSPRSCHRHERSHMGEKAYQCKECGKAFMCPRYVRRHERTHSRKKLYECKQCGKALSSLTSFQTHIRMHSGERPYECKTCGKGFYSAKSFQRHEKTHSGEKPYKCKQCGKAFTRSGSFRYHERTHTGEKPYECKQCGKAFRSAPNLQLHGRTHTGEKPYQCKECGKAFRSASQLRIHRRIHTGEKPYECKKCGKAFRYVQNFRFHERTQTHKNALWRKTL');
INSERT INTO `SEQUENCE` VALUES (31761,'MAALRALCGFRGVAAQVLRPGAGVRLPIQPSRGVRQWQPDVEWAQQFGGAVMYPSKETAHWKPPPWNDVDPPKDTIVKNITLNFGPQHPAAHGVLRLVMELSGEMVRKCDPHIGLLHRGTEKLIEYKTYLQALPYFDRLDYVSMMCNEQAYSLAVEKLLNIRPPPRAQWIRVLFGEITRLLNHIMAVTTHALDLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDRYLCRVEEMRQSLRIIAQCLNKMPPGEIKVDDAKVSPPKRAEMKTSMESLIHHFKLYTEGYQVPPGATYTAIEAPKGEFGVYLVSDGSSRPYRCKIKAPGFAHLAGLDKMSKGHMLADVVAIIGTQDIVFGEVDR');
INSERT INTO `SEQUENCE` VALUES (20160,'MEKEETTRELLLPNWQGSGSHGLTIAQRDDGVFVQEVTQNSPAARTGVVKEGDQIVGATIYFDNLQSGEVTQLLNTMGHHTVGLKLHRKGDRSPEPGQTWTREVFSSCSSEVVLSGDDEEYQRIYTTKIKPRLKSEDGVEGDLGETQSRTITVTRRVTAYTVDVTGREGAKDIDISSPEFKIKIPRHELTEISNVDVETQSGKTVIRLPSGSGAASPTGSAVDIRAGAISASGPELQGAGHSKLQVTMPGIKVGGSGVNVNAKGLDLGGRGGVQVPAVDISSSLGGRAVEVQGPSLESGDHGKIKFPTMKVPKFGVSTGREGQTPKAGLRVSAPEVSVGHKGGKPGLTIQAPQLEVSVPSANIEGLEGKLKGPQITGPSLEGDLGLKGAKPQGHIGVDASAPQIGGSITGPSVEVQAPDIDVQGPGSKLNVPKMKVPKFSVSGAKGEETGIDVTLPTGEVTVPGVSGDVSLPEIATGGLEGKMKGTKVKTPEMIIQKPKISMQDVDLSLGSPKLKGDIKVSAPGVQGDVKGPQVALKGSRVDIETPNLEGTLTGPRLGSPSGKTGTCRISMSEVDLNVAAPKVKGGVDVTLPRVEGKVKVPEVDVRGPKVDVSAPDVEAHGPEWNLKMPKMKMPTFSTPGAKGEGPDVHMTLPKGDISISGPKVNVEAPDVNLEGLGGKLKGPDVKLPDMSVKTPKISMPDVDLHVKGTKVKGEYDVTVPKLEGELKGPKVDIDAPDVDVHGPDWHLKMPKMKMPKFSVPGFKAEGPEVDVNLPKADVDISGPKIDVTAPDVSIEEPEGKLKGPKFKMPEMNIKVPKISMPDVDLHLKGPNVKGEYDVTMPKVESEIKVPDVELKSAKMDIDVPDVEVQGPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADVDISGPKVGVEVPDVNIEGPEGKLKGPKFKMPEMNIKAPKISMPDVDLHMKGPKVKGEYDMTVPKLEGDLKGPKVDVSAPDVEMQGPDWNLKMPKIKMPKFSMPSLKGEGPEFDVNLSKANVDISAPKVDTNAPDLSLEGPEGKLKGPKFKMPEMHFRAPKMSLPDVDLDLKGPKMKGNVDISAPKIEGEMQVPDVDIRGPKVDIKAPDVEGQGLDWSLKIPKMKMPKFSMPSLKGEGPEVDVNLPKADVVVSGPKVDIEAPDVSLEGPEGKLKGPKFKMPEMHFKTPKISMPDVDLHLKGPKVKGDVDVSVPKVEGEMKVPDVEIKGPKMDIDAPDVEVQGPDWHLKMPKMKMPKFSMPGFKGEGREVDVNLPKADIDVSGPKVDVEVPDVSLEGPEGKLKGPKFKMPEMHFKAPKISMPDVDLNLKGPKLKGDVDVSLPEVEGEMKVPDVDIKGPKVDISAPDVDVHGPDWHLKMPKVKMPKFSMPGFKGEGPEVDVKLPKADVDVSGPKMDAEVPDVNIEGPDAKLKGPKFKMPEMSIKPQKISIPDVGLHLKGPKMKGDYDVTVPKVEGEIKAPDVDIKGPKVDINAPDVEVHGPDWHLKMPKVKMPKFSMPGFKGEGPEVDMNLPKADLGVSGPKVDIDVPDVNLEAPEGKLKGPKFKMPSMNIQTHKISMPDVGLNLKAPKLKTDVDVSLPKVEGDLKGPEIDVKAPKMDVNVGDIDIEGPEGKLKGPKFKMPEMHFKAPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKVPDVDIKGPKVDIDAPDVEVHDPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADIDVSGPSVDTDAPDLDIEGPEGKLKGSKFKMPKLNIKAPKVSMPDVDLNLKGPKLKGEIDASVPELEGDLRGPQVDVKGPFVEAEVPDVDLECPDAKLKGPKFKMPEMHFKAPKISMPDVDLHLKGPKVKGDADVSVPKLEGDLTGPSVGVEVPDVELECPDAKLKGPKFKMPDMHFKAPKISMPDVDLHLKGPKVKGDVDVSVPKLEGDLTGPSVGVEVPDVELECPDAKLKGPKFKMPEMHFKTPKISMPDVDLHLKGPKVKGDMDVSVPKVEGEMKVPDVDIKGPKMDIDAPDVDVHGPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADVVVSGPKVDVEVPDVSLEGPEGKLKGPKLKMPEMHFKAPKISMPDVDLHLKGPKVKGDVDVSLPKLEGDLTGPSVDVEVPDVELECPDAKLKGPKFKMPEMHFKTPKISMPDVNLNLKGPKVKGDMDVSVPKVEGEMKVPDVDIRGPKVDIDAPDVDVHGPDWHLKMPKMKMPKFSMPGFKGEGPEVDVNLPKADVDVSGPKVDVEVPDVSLEGPEGKLKGPKFKMPEMHFKTPKISMPDVDFNLKGPKIKGDVDVSAPKLEGELKGPELDVKGPKLDADMPEVAVEGPNGKWKTPKFKMPDMHFKAPKISMPDLDLHLKSPKAKGEVDVDVPKLEGDLKGPHVDVSGPDIDIEGPEGKLKGPKFKMPDMHFKAPNISMPDVDLNLKGPKIKGDVDVSVPEVEGKLEVPDMNIRGPKVDVNAPDVQAPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADVDISGPKVDIEGPDVNIEGPEGKLKGPKLKMPEMNIKAPKISMPDFDLHLKGPKVKGDVDVSLPKVEGDLKGPEVDIKGPKVDINAPDVGVQGPDWHLKMPKVKMPKFSMPGFKGEGPDGDVKLPKADIDVSGPKVDIEGPDVNIEGPEGKLKGPKFKMPEMNIKAPKISMPDIDLNLKGPKVKGDVDVSLPKVEGDLKGPEVDIKGPKVDIDAPDVDVHGPDWHLKMPKIKMPKISMPGFKGEGPDVDVNLPKADIDVSGPKVDVECPDVNIEGPEGKWKSPKFKMPEMHFKTPKISMPDIDLNLTGPKIKGDVDVTGPKVEGDLKGPEVDLKGPKVDIDVPDVNVQGPDWHLKMPKMKMPKFSMPGFKAEGPEVDVNLPKADVDVSGPKVDVEGPDVNIEGPEGKLKGPKFKMPEMNIKAPKIPMPDFDLHLKGPKVKGDVDISLPKVEGDLKGPEVDIRGPQVDIDVPDVGVQGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVNLPKADLDVSGPKVDIDVPDVNIEGPEGKLKGPKFKMPEMNIKAPKISMPDIDLNLKGPKVKGDMDVSLPKVEGDMKVPDVDIKGPKVDINAPDVDVQGPDWHLKMPKIKMPKISMPGFKGEGPEVDVNLPKADLDVSGPKVDVDVPDVNIEGPDAKLKGPKFKMPEMNIKAPKISMPDLDLNLKGPKMKGEVDVSLANVEGDLKGPALDIKGPKIDVDAPDIDIHGPDAKLKGPKLKMPDMHVNMPKISMPEIDLNLKGSKLKGDVDVSGPKLEGDIKAPSLDIKGPEVDVSGPKLNIEGKSKKSRFKLPKFNFSGSKVQTPEVDVKGKKPDIDITGPKVDINAPDVEVQGKVKGSKFKMPFLSISSPKVSMPDVELNLKSPKVKGDLDIAGPNLEGDFKGPKVDIKAPEVNLNAPDVDVHGPDWNLKMPKMKMPKFSVSGLKAEGPDVAVDLPKGDINIEGPSMNIEGPDLNVEGPEGGLKGPKFKMPDMNIKAPKISMPDIDLNLKGPKVKGDVDISLPKLEGDLKGPEVDIKGPKVDINAPDVDVHGPDWHLKMPKVKMPKFSMPGFKGEGPEVDVTLPKADIDISGPNVDVDVPDVNIEGPDAKLKGPKFKMPEMNIKAPKISMPDFDLNLKGPKMKGDVVVSLPKVEGDLKGPEVDIKGPKVDIDTPDINIEGSEGKFKGPKFKIPEMHLKAPKISMPDIDLNLKGPKVKGDVDVSLPKMEGDLKGPEVDIKGPKVDINAPDVDVQGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVNLPKADLDVSGPKVDIDVPDVNIEGPEGKLKGPKFKMPEMNIKAPKISMPDIDLNLKGPKVKGDMDVSLPKVEGDMQVPDLDIKGPKVDINAPDVDVRGPDWHLKMPKIKMPKISMPGFKGEGPEVDVNLPKADLDVSGPKVDVDVPDVNIEGPDAKLKGPKFKMPEMNIKAPKISMPDFDLHLKGPKVKGDVDVSLPKMEGDLKAPEVDIKGPKVDIDAPDVDVHGPDWHLKMPKVKMPKFSMPGFKGEGPEVDVNLPKADIDVSGPKVDIDTPDIDIHGPEGKLKGPKFKMPDLHLKAPKISMPEVDLNLKGPKMKGDVDVSLPKVEGDLKGPEVDIKGPKVDIDVPDVDVQGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVNLPKADLDVSGPKVDIDVPDVNIEGPDAKLKGPKFKMPEMNIKAPKISMPDFDLHLKGPKVKGDVDVSLPKVEGDLKGPEVDIKGPKVDIDAPDVDVHGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVTLPKADIEISGPKVDIDAPDVSIEGPDAKLKGPKFKMPEMNIKAPKISMPDIDFNLKGPKVKGDVDVSLPKVEGDLKGPEIDIKGPSLDIDTPDVNIEGPEGKLKGPKFKMPEMNIKAPKISMPDFDLHLKGPKVKGDVDVSLPKVESDLKGPEVDIEGPEGKLKGPKFKMPDVHFKSPQISMSDIDLNLKGPKIKGDMDISVPKLEGDLKGPKVDVKGPKVGIDTPDIDIHGPEGKLKGPKFKMPDLHLKAPKISMPEVDLNLKGPKVKGDMDISLPKVEGDLKGPEVDIRDPKVDIDVPDVDVQGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVNLPKADIDVSGPKVDVDVPDVNIEGPDAKLKGPKFKMPEMSIKAPKISMPDIDLNLKGPKVKGDVDVTLPKVEGDLKGPEADIKGPKVDINTPDVDVHGPDWHLKMPKVKMPKFSMPGFKGEGPDVDVSLPKADIDVSGPKVDVDIPDVNIEGPDAKLKGPKFKMPEINIKAPKISIPDVDLDLKGPKVKGDFDVSVPKVEGTLKGPEVDLKGPRLDFEGPDAKLSGPSLKMPSLEISAPKVTAPDVDLHLKAPKIGFSGPKLEGGEVDLKGPKVEAPSLDVHMDSPDINIEGPDVKIPKFKKPKFGFGAKSPKADIKSPSLDVTVPEAELNLETPEISVGGKGKKSKFKMPKIHMSGPKIKAKKQGFDLNVPGGEIDASLKAPDVDVNIAGPDAALKVDVKSPKTKKTMFGKMYFPDVEFDIKSPKFKAEAPLPSPKLEGELQAPDLELSLPAIHVEGLDIKAKAPKVKMPDVDISVPKIEGDLKGPKVQANLGAPDINIEGLDAKVKTPSFGISAPQVSIPDVNVNLKGPKIKGDVPSVGLEGPDVDLQGPEAKIKFPKFSMPKIGIPGVKMEGGGAEVHAQLPSLEGDLRGPDVKLEGPDVSLKGPGVDLPSVNLSMPKVSGPDLDLNLKGPSLKGDLDASVPSMKVHAPGLNLSGVGGKMQVGGDGVKVPGIDATTKLNVGAPDVTLRGPSLQGDLAVSGDIKCPKVSVGAPDLSLEASEGSIKLPKMKLPQFGISTPGSDLHVNAKGPQVSGELKGPGVDVNLKGPRISAPNVDFNLEGPKVKGSLGATGEIKGPTVGGGLPGIGVQGLEGNLQMPGIKSSGCDVNLPGVNVKLPTGQISGPEIKGGLKGSEVGFHGAAPDISVKGPAFNMASPESDFGINLKGPKIKGGADVSGGVSAPDISLGEGHLSVKGSGGEWKGPQVSSALNLDTSKFAGGLHFSGPKVEGGVKGGQIGLQAPGLSVSGPQGHLESGSGKVTFPKMKIPKFTFSGRELVGREMGVDVHFPKAEASIQAGAGDGEWEESEVKLKKSKIKMPKFNFSKPKGKGGVTGSPEASISGSKGDLKSSKASLGSLEGEAEAEASSPKGKFSLFKSKKPRHRSNSFSDEREFSGPSTPTGTLEFEGGEVSLEGGKVKGKHGKLKFGTFGGLGSKSKGHYEVTGSDDETGKLQGSGVSLASKKSRLSSSSSNDSGNKVGIQLPEVELSVSTKKE');
INSERT INTO `SEQUENCE` VALUES (60531,'MAGLSGAQIPDGEFTAVVYRLIRNARYAEAVQLLGGELQRSPRSRAGLSLLGYCYYRLQEFALAAECYEQLGQLHPELEQYRLYQAQALYKACLYAEATRVAFLLLDNPAYHSRVLRLQAAIKYSEGDLPGSRSLVEQLPSREGGEESGGENETDGQINLGCLLYKEGQYEAACSKFFAALQASGYQPDLSYNLALAYYSSRQYASALKHIAEIIERGIRQHPELGVGMTTEGIDVRSVGNTLVLHQTALVEAFNLKAAIEYQLRNYEAAQEALTDMPPRAEEELDPVTLHNQALMNMDARPTEGFEKLQFLLQQNPFPPETFGNLLLLYCKYEYFDLAADVLAENAHLIYKFLTPYLYDFLDAVITCQTAPEEAFIKLDGLAGMLTEVLRKLTIQVQEARHNRDDEAIKKAVNEYDETMEKYIPVLMAQAKIYWNLENYPMVEKIFRKSVEFCNDHDVWKLNVAHVLFMQENKYKEAIGFYEPIVKKHYDNILNVSAIVLANLCVSYIMTSQNEEAEELMRKIEKEEEQLSYDDPDKKMYHLCIVNLVIGTLYCAKGNYDFGISRVIKSLEPYNKKLGTDTWYYAKRCFLSLLENMSKHTIMLRDSVIQECVQFLEHCELHGRNIPAVIEQPLEEERMHVGKNTVTYESRQLKALIYEIIGWNI');
INSERT INTO `SEQUENCE` VALUES (6215,'MNIRGDTGHKACECQEYGPKPWKSQQPKKAFRYHPSLRTQERDHTGKKPYACKECGKNIIYHSSIQRHMVVHSGDGPYKCKFCGKAFHCLSLYLIHERTHTGEKPYECKQCGKSFSYSATHRIHERTHIGEKPYECQECGKAFHSPRSCHRHERSHMGEKAYQCKECGKAFMCPRYVRRHERTHSRKKLYECKQCGKALSSLTSFQTHIRMHSGERPYECKTCGKGFYSAKSFQRHEKTHSGEKPYKCKQCGKAFTRSGSFRYHERTHTGEKPYECKQCGKAFRSAPNLQLHGRTHTGEKPYQCKECGKAFRSASQLRIHRRIHTGEKPYECKKCGKAFRYVQNFRFHERTQTHKNALWRKTL');
INSERT INTO `SEQUENCE` VALUES (2128,'XDGADASEEDLTRARQEEGADASEEDPTPAGEEDVKDAREEDGVDTIEEDLTRAGEEDGKDTREEDGADASEEDPTWAGEEEGADSGEEDGADASEEDDTITNEKAHSILNFLKSTQEMYFYDGVSRDAASAALADAAEELLDRLASHSMLPSDVSILYHMKTLLLLQDTERLKHALEMFPEHCTMPPGKYRTIYSRSCLRYSHRGLPLKDLHATKTAMSWKI');
INSERT INTO `SEQUENCE` VALUES (2125,'MAAHRKHDQDPHDQPKRRRIRKHKSKKKFKNPNNVLIEQAELEKQQSLLQEKSQRQHTDGTTISKNKKRKLKKKQQIKRKKAAGLAAKAAGVSFMYQPEDSSNEGEGVGEACEEDGVDTSEEDPTLAGEEDVKDTREEDGADASEEDLTRARQEEGADASEEDPTPAGEEDVKDAREEDGVDTIEEDLTRAGEEDGKDTREEDGADASEEDPTWAGEEEGADSGEEDGADASEEDDTITNEKAHSILNFLKSTQEMYFYDGVSRDAASAALADAAEELLDRLASHSMLPSDVSILYHMKTLLLLQDTERLKHALEMFPEHCTMPPGVLSRLKAKKIRRGKREGLP');
INSERT INTO `SEQUENCE` VALUES (31763,'MELSGEMVRKCDPHIGLLHRGTEKLIEYKTYLQALPYFDRLDYVSMMCNEQAYSLAVEKLLNIRPPPRAQWIRVLFGEITRLLNHIMAVTTHALDLGAMTPFFWLFEEREKMFEFYERVSGARMHAAYIRPGGVHQDLPLGLMDDIYQFSKNFSLRLDELEELLTNNRIWRNRTIDIGVVTAEEALNYGFSGVMLRGSGIQWDLRKTQPYDVYDQVEFDVPVGSRGDCYDR');

INSERT INTO `WEIGHTS` VALUES ('0046753','INHERITED',10,4);
INSERT INTO `WEIGHTS` VALUES ('0052775','INHERITED',14,2);
INSERT INTO `WEIGHTS` VALUES ('2125','INHERITED',0,2);
INSERT INTO `WEIGHTS` VALUES ('2127','INHERITED',0,2);
INSERT INTO `WEIGHTS` VALUES ('Pfam-B_11295','INHERITED',53,131);
INSERT INTO `WEIGHTS` VALUES ('Pfam-B_12036','INHERITED',0,47);
INSERT INTO `WEIGHTS` VALUES ('zf-CCCH','INHERITED',0,1);