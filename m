Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD34E9A74C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 09:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2462402BE;
	Tue, 24 Mar 2026 10:29:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 15CD34025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:29:51 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O9EaJA2903079; Tue, 24 Mar 2026 02:29:51 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022081.outbound.protection.outlook.com
 [40.93.195.81])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d1tugnynx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 02:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pvx7YnzCdOwqdOaPVy24ktOYkw3W+/DHDK//e8jmkqHPDg0OE6w/lVRsTgZ2oZk1rDNQYdSJcCudFH4csCJpljgooEUxFw3ynZaLiwJWuWYkJ0Ww138X7LVDg6VAsQVf184/UngI0yvHkG5GzWy51c5slCSeTiESpbsRMnchS2d5xxRHOXrL/nFz2DLuNb52SpgLTiLJN5o8Gi/wlkmEy2lmqSMqPPuyrbr+1TxpoPVuhU0la+N7nRbz0Es9uoIz/H12RiRA6R1/jYa+KeaUQgEuBPJLoDL+2jqmTM76Kj0lyAkBGTHeAEY1NncCG88VvQ54nLI40n80K8s8DxWDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akhLLv6oJR3mWbJeRSu1nz2SiXFA57NreSsIe/xegYs=;
 b=x+HcYqVR/crQWTJGy1alS5+eGjFuo7y1woPE/7YAZDLn1nEWf9+AnazHOokfMeNLKWfB/iiMEJzpxmAskJp7gy8WoZ0ZqbzTZeRQGwzChvdvlFm3jZu2iix0qSbObDztfNVpYwB7DAOKCR96XOetETstiXGLQn8Q2RzQYM/SafCEyPhaNbEzVy/WU03amxu5gqaXi0K/L+BZtKvkTUbWLGClS6Qlo0l1ylXFumYnWbvh8KJz65qZsTjsB5dBGGfJj+fuEzlD2HJgUUbpJLfvFcPDI0G1BKhtMWvDIGczM9Ek77oq4u7mrWRHU9LYiQEuj51lGxlz9vAWPiHBvMlmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akhLLv6oJR3mWbJeRSu1nz2SiXFA57NreSsIe/xegYs=;
 b=BQmuMg/awGWd2iR0c1B+bUbcraAzlwso6kZiRWPs4K+bMGMYxyP38vhq6phC8sZ3/eY5J8pX71hP6O6fdIRG+OPMd5/djE2HoHdG9y4lVz1v0iE5NBwJmXvhoD9WD6hrsbHMaM3afqE1T/RHQ8pZWWLpk9J/8h3EO2mi+DCuLKk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM8PR18MB4486.namprd18.prod.outlook.com (2603:10b6:8:26::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 09:29:48 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:29:48 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, Emma Finn <emma.finn@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validation
 and gen4 EC caps
Thread-Topic: [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validation
 and gen4 EC caps
Thread-Index: AQHcutcEzwB0w0Zp+0Ou4j4Wy9r+orW9RFYAgAAnY8A=
Date: Tue, 24 Mar 2026 09:29:48 +0000
Message-ID: <CO6PR18MB44842996BCDFA85C9C935406D848A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260323150854.2394000-1-emma.finn@intel.com>
 <PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48A@PH3PPFC694D094E.namprd18.prod.outlook.com>
In-Reply-To: <PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48A@PH3PPFC694D094E.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM8PR18MB4486:EE_
x-ms-office365-filtering-correlation-id: a487cb77-4594-41b6-b0ed-08de8987e4b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zpcxYJmdKcbIl2o8EENBonNCmb4egXWNNp0ymfuGzXJzrhJCzVMrwydf4Da3AAvJrE9O35ZyOQN7mfs4b/O/9JlfAnsgxohnbu9dXcRXsqaOigkWLbkuVEzKfTqPHg1WGdMyE2U2CpRuw/+ZEDim4OcMhVfedlOqXAaVd1OAoyo26ue9EkwwHuEU6vL7D4QJK7qUO+zft2TJbZaepcC9hUp0AanRrQI0/R0xKV6eXuRffD4dnQqYyKExVCPhQBFpPMobDD1O1j5mtoh4tJE3Kdlb0tbazWLB01q8FpWsmD7vDC/HYKsSeN8lvef3k8zXPi3AjMqOvx7zDaoKEY5P0jDzhRcv7dwWQXdpgZOJBOXhXMrS07US1eCqQIpwikgbZDItRo8QPYNq9H6zQ9Tc/VXszam3qXapZX14noBdlM8VOV8WhOVRTY+0y92IobBV8sT02gyWrAn7c4bZrK7ckdGGF09Fx5p32lr0pUZkSQN9u6Cs0LYx/TjLlKJojP7155WUr44YbT23heM0p+4ebub+YwaSCLtybaI3BfWdh1tGNPVNPjsd+URJpCdO/0rs1gGZ/h86oIY3PtXhlv49W8zt4xZTg/AQHUA7f5592tUvHpN6lT/cnu5NrZ+fmdqXAGIEPt1Rq9Q4agWJO6KyB143mmq77NrMmu9cHEtB1xEkGlGxigdwJ21r6FXAKwfydl2FSTFNxXwobsfCtAEeC5zRou1IYF9K3A2OhNXh4j+QPgmnc8cYR9DERH29qnegxEPICdQHKVJs3Rm3VURKOK1OcMBDVCF9MS/BpG75c4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HXg1S/6yxFRHD7db1HyyYlA0xPAO36V9aIRdn3TrDjWp9XeiPsMrhyLrUjgz?=
 =?us-ascii?Q?D6TxizsrR/6zY3Jx5SDTk6sr2UcWqf951Jg4oLKcPKvf1efYr2jBLbuPi1Wj?=
 =?us-ascii?Q?gE5Ad8H7T9xTCeXUOXbO+ay5Au8aZ1jkef9uAJy8az2eihnzSjfCoPkB9RzE?=
 =?us-ascii?Q?QenyPqOhVEghXGHIHgg+KCxhrV2bXBhT78OyYzfTWq+GddVOQ5lGNQcra7LN?=
 =?us-ascii?Q?du4+63cWQYdjws3lmdc+GKt5zRuuXQSEDouds3/eCtt8lUKB47IPuQHGk+qf?=
 =?us-ascii?Q?rw8ilMAR901/Zom1uKR1a7rpYfU/xABUTZaSZGqTP7xpqkGHNAwEqNFPUw8e?=
 =?us-ascii?Q?MaLgM2Xa4VJd0oGvTSSMLYy4buxkLuBnwnYy8adHzZBg0fuvXVfwcg2V4060?=
 =?us-ascii?Q?bwm3GsFAXBYmadB+rCtgvzZbGNr75S5x6bIqad0Xcjkk4zRJH4ivpNxjWDST?=
 =?us-ascii?Q?1GMgDl3rfmWhRC35ODAdbB07Otam0uf5Q8W/wSIi3hZk9GcEkk53pysvTqJn?=
 =?us-ascii?Q?znG4kiysD8n4CgCEzUGMP9LjtPftiiaIXuWhpxX4FR0sry+81XKVAIyhcErz?=
 =?us-ascii?Q?VL8ThtMIR1hM2XmAXnnOa9xrqZsg+z3oXg2YcIzKzgD98D1qAtmsFSS7H4/P?=
 =?us-ascii?Q?AaJQcD7yshPQ7A5AamkaGAf3ZR+Ysd5Mo5dmB95S3bJUC2gMyQe6PSy+3PIH?=
 =?us-ascii?Q?IzD66GALbmexXEUA62napLC7SsxMkAiG7Ec6UxTYgBtHiL+ZSh/DjS7M3hUY?=
 =?us-ascii?Q?5dM6WCin+XGfEsUWkZCntzaCwIfhaH4FS04nWDEk6UfEMF4+AzynM8OmJQKL?=
 =?us-ascii?Q?Y5r8I4pMyBLf/M5OneopaORQwZ1UO+So9/prle8yLrDW4zkXn1mwv/YGhUub?=
 =?us-ascii?Q?o4dqa1itQc0d5IG5QcDDa3FEeVDINFHZ35d4DLHBr4jECgipfmDJGvRXvraH?=
 =?us-ascii?Q?jol4KsQwSGJfLuu1WWYSRdDV8luMJ3BqrewgI0/cbApFzUbYYzhAGHb2m7Ax?=
 =?us-ascii?Q?Plx59sq02xJptF3PRzOZ87ry3ybaugNWdeWvf+ET/4JryFppB3rTDlWdFVyX?=
 =?us-ascii?Q?cNewEzuMoNSPPbIZh26x8GmXetzGH8rp8HDZmA9V34+ibwATDn9iU7PI/qXC?=
 =?us-ascii?Q?IPRfuheg+6glw6JA+KdH+3nduwhz6vJ2iUh4rPWwoKc+MBmks3wzaCS+BdwM?=
 =?us-ascii?Q?lrNIIND8nX/eO5QAXew0bWQXjr2roUNc2VhqfslCgM5Lx3CEnJ9habYN1INE?=
 =?us-ascii?Q?HNhONi513ZF8YrZ/+vOZRiAbKRLfxv5PZ7kCvy+wRMZSqkZYHzOMhcFU3H5d?=
 =?us-ascii?Q?mC3Rtzf4L/LKD3i+xSE3aTKaSNA3OH5Q/JwYk0Th1wUfEGKmjPwf6QSoj6Us?=
 =?us-ascii?Q?bVzmD0FvbrBV2l2LcjwtDByrH2o+x4qdyblZwTWGmLcNHVJUgd0h/JZLd7lY?=
 =?us-ascii?Q?9A19j88XePOntPINCBDPN2gPf7im+1+x9x3Mf4vURT8SpAmuj17TardbQ9IH?=
 =?us-ascii?Q?YPpVAwibtrI0QgBboCg6xVD6LZqYuqk5c5NDkmdsIeSXQ90hA1tPzSflnKmI?=
 =?us-ascii?Q?WClr9BnXdm25054vhiN4GVwyAXlP0m1HraLV954OPfOFPbL0VzFi/tLG3XC5?=
 =?us-ascii?Q?uij7YS1O3a5RRfUcwiaW6BnNDr48MtODBR9c0oR7jFTFRrym1qCSbLItJ7Wr?=
 =?us-ascii?Q?BfiwdOUz8m9cB+rAym9h5YV39+gR+8nNJeOAQXboCgG54Vco?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WIVwHy58hUPkw32xaF0n5XOo4XAMFT5GO5G4LeqlxA6CpP/S+yiNAkY+hs2RTkCfwEvdZVtWLGHbOGBI800cxQ/AktYBTrN9h2NgNWhrCTaYnCfKC5AWaOMnDMTyYNE8rbAUrqA8KJ2pmF8sSYNmH154ZxI2QhRGY3cyx5adKRkXrq7S2m8fqxT7WnRz0i0xeZ4hkUWG/ZpNk3WSEe1Qc101vXeqiXTiJz7bglgeau9mIL7IQiJCDCcQOmeaLFcej0JuFRdfHvrP+vJTKZk0yfEWap0JjC/7iEE6l8iFme8MqeU5XUAffZlbAvxqs+3jCa0hdM5252VRrCkJ1Gdplw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a487cb77-4594-41b6-b0ed-08de8987e4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 09:29:48.3282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zROOmA3KYFKtpFC1LsH44j7waKrHQzjwpojJfJRwW5mwB4Ddj1t9PbvBgnwOBmT6A6SlRPujeE/cWk2782WaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4486
X-Proofpoint-ORIG-GUID: NAJYh8G9P_0C0-IxgIvRABJfsaRL-1pO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NSBTYWx0ZWRfXzChAGopNa8qs
 F1e6xbPVYuxdMOgHMhZsywKKyXRC6W8y6DsJHnuDWNjGAJk27xCAt0bK8HEaURp10ufR5sdVQVa
 cUoZn3HwviY0AihqKIvctmLQf1XOYhfHnU5Inedxd4uXgoPUDqe7UOWDCES1Ojh8FF/9WZhhZGi
 bHebK3HZfAXZa/HpdHh8sP0bZinYoJ5dv7m/0bGhYXP4+H6Z2Qimvq9XxyWipiMIIM5dlYscJ8N
 StHZTaHCkWI68najxBj+txS/WQmk7e5lZ87TRPayU4RndigqHdnvSRq6LPo6GKKKVwuCFxrg0h/
 4o4MdzUR+nGTWLf6ZRotv6YEHlXFGyKkzqzvZIe5fVAvu1tIufkImpEnJgkRhKcJQ7sTA+fiQyR
 p1ylAoOf61cu+I7wtVC8xvSSdFqj/XQjc2MTbs6lGWLPTS0zzLksGoYi/abVDTqkVEe/2WEUrJN
 XXkfSRK3F5vJKt8fmiA==
X-Proofpoint-GUID: NAJYh8G9P_0C0-IxgIvRABJfsaRL-1pO
X-Authority-Analysis: v=2.4 cv=Pu6ergM3 c=1 sm=1 tr=0 ts=69c2598f cx=c_pps
 a=kzlga8Pj6Xs+ezKxcisf3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=X68QyoZsPiVu6VvwW48A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> Fix asym tests to return TEST_SKIPPED when session
> creation returns -ENOTSUP. Add missing ECDH, ECDSA and ECPM
> capabilities to GEN4 asym caps table. Reject unsupported RSA
> padding and EC curves at session configure time with -ENOTSUP.
>=20
> Bugzilla ID: 1903
> Fixes: 064ef1b098d1 ("test/crypto: remove PMD-specific asym test suites")
>=20
> Signed-off-by: Emma Finn <emma.finn@intel.com>
Applied to dpdk-next-crypto
Thanks.
