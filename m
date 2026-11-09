Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C157606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=ZxOB5oqW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B04E406B6;
	Mon,  9 Nov 2026 20:57:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A2F440265;
 Mon,  9 Nov 2026 20:57:57 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HKCgF789458; Mon, 9 Nov 2026 11:57:56 -0800
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022074.outbound.protection.outlook.com
 [40.107.200.74])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hujfgrpbw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:57:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBDaceVQUAUMeB+8/nuZAhq32PpHmTPq6eXJ1bnyHOPvu6di9JwtKLZHdIfkVXxghgijstlUK4KdkP0kVRqOFli32NvI85G5FI/ipCM81FyqVt2tc5eTTZxqWeZwImznTkuSOU3kRfvFvbuWNKseIwVGUShXvqm/Hr9cznBcGtJ6xPXmomUgoHJ3yEc+N1goc0bjitbgquW4f8UTlzlcvEXgiOxv/eUMDU8CoIJZWVLuNTNtPtYeqPn5jqI2jhx2TslEceZh0HqMJ68WVooNOZPYS3TUUTFzhXso+S7aPioJsKjeNCHhU4FBNqrgMPhuHoWHbPSV/AKwcsV4EIs+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTFTzLHRO/NrUmbzyyZWhRx8gBIHHMeKh4nV2jRdjr8=;
 b=iEBJ4vKrW5FaZyiauQaQmwS3wtWeglphw22pSiFejV4ABbDBG630U7mOpyZ2vevE8HfRXpzD79ej/RgR3xNV/i+k9ts/e0bOcrA8Z5rsdIfqTqmDdaqDAkbWYOP+M7mcalAO5HABmFIAF9KKmRa4UJzObei/P2/64vWT6iet/HIF9CNskeSjpo6p6ZLwkNU856CqxeZEnnEE5tfIAoihAjVZIJ+7oRiB6uSeFupK7OX2t58zMcqvRQ1VxzpGO1kTg1fq5Oa2lAGJxoIPi8fTMOdJuMdOnLnVB8J3ArGUwgtIVlHuvnLGSYAIdF02qHI6gVHR3cnXsdkq60e0KpBV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTFTzLHRO/NrUmbzyyZWhRx8gBIHHMeKh4nV2jRdjr8=;
 b=ZxOB5oqWH5Ee1Ov52HPdGh/r/szXjkddvxcJIEuIPS/9YFMOBOfOvUoj4Ov6msF3+9W9OxyaavLjAa7OOjX8px7+q/QeEfwamX+T96dBY+sjLHlsgCh7ddYzGaWrpd+JCBNrJK7Qx8Wy+gOvTFCdyYExSviSaawfb4SXl/EZ3qk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM6PR18MB3523.namprd18.prod.outlook.com (2603:10b6:5:2ab::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 19:57:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:57:51 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>,
 Tejasree Kondoj <ktejasree@marvell.com>,
 "kai.ji@intel.com" <kai.ji@intel.com>, "jianjay.zhou@huawei.com"
 <jianjay.zhou@huawei.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: fix AE table get on unprobed device
Thread-Topic: [PATCH] crypto/cnxk: fix AE table get on unprobed device
Thread-Index: AQHdV+MyKyVJv2mUBkOfsRvToGCvnrcmWUIA
Date: Mon, 9 Nov 2026 19:57:51 +0000
Message-ID: <CO6PR18MB4484D98A6E162FEEFBA1B607D8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261009114142.2598690-1-ssarananaga@marvell.com>
In-Reply-To: <20261009114142.2598690-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM6PR18MB3523:EE_
x-ms-office365-filtering-correlation-id: 1316951a-6152-448f-9526-08df3e9bbc98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|10067099003|38070700021|11063799006|261028144727099003|261009223027099003|261022105027099003|56012099006|261026140227099003;
x-microsoft-antispam-message-info: AmkZEP6rlwbB9gteu5XQlkPZiDwthm19XW9i6vuty6p9hd0gCcKCI9xe4VdJlut1mI/OJ3AU5BpUUVALNzS7j3DQu5tiZaD2dmlRb0Pm3eDvClMTk3nSpk/4WBz0P+T6Ll+osEeJK7tytF353X5uVBAVAYsH0c3OMBThowDAXYE25H6yKOdR7D+pv3elI265cCFMZ/UMZC/OQCNfamzrdDJXE2zD9wjveVjUCaCNl/NzUA1TPeeccIsfSNKJTHALXiOxQWbs7gk39Q3kY0iSIJwHkz00G+fyaRD5Vllpc79xOPVyaYpr2Z+uI80Iggb+1HC7lynnPU8A9wuR+UVpLCqlEDzhgMyVbvdhSjSArDaefj2dBcNdDeVJrTu8QHvNdYPqD5hT1o2FFsxLKT6z5Qid73JIP8wdzA3R+lg/8HRIt5Tb84n9k8JCdvpP99Rw+g4pP2IBEbzjWycx10ewmDB/3CptRx/Eut//82TrlFGtsIY1TTwL/kNRVpt9zPc2Pf6l6Z8rG1wmjD9x1Qg+kyR+PTM6MM2W35C9QD4tDr+4KSTMLMZnjUu1EQgc6USMt5rFiKvNmy4gg/ZqmDWeoUFM+QzD9VzvKVkpEtZpmITpwYcSuuhpW+EGx5Sq1/I8MeH5dWK4aw+MBS973+yrV7qwP4HNkWXdr39cz5iYS9FT83Q+rq7kU82c9TXJC+sb/w90claKWJTZ84yMjNZphPAMJ0Hcts6P+22d8UPk41I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(261028144727099003)(261009223027099003)(261022105027099003)(56012099006)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/8HugD44N/+Incx8A3W9Do1w1jAySgo7DZ8P6qtoCVgaZRQdgpEJcHEgUVxv?=
 =?us-ascii?Q?06Vbvpcitjj5YtVc4+D6Eg85wBsQCJEdKsIcTgLqb3wDJ5gdQU4X9LEQDD3Z?=
 =?us-ascii?Q?S15VPqlYBbtnysGtRKgA4j5t2HwYO2zoe7kcS6riQMiZaDgZBHOLtqMy7SmS?=
 =?us-ascii?Q?s2T+JJSTy3YYz0247qjtW8SdCQlJ8/0Fg7hS/wUDAW+Hdp5btMH5NT2xIEKw?=
 =?us-ascii?Q?VHTVpHpHyug3bSJYSNS0RU2OZ/0rVYWELkgVzJ3/AEInm5kYaThE0515QQpt?=
 =?us-ascii?Q?4A+zyY67q5UzCNzNv9AyxaYmwbxl9aEXqi1bev/BEmxrnvLd/ST0yePFTeGZ?=
 =?us-ascii?Q?Ppte70vD0tPikTwCdxAr+lqqo/zCUI2s25Pou6wSKWYcYK2AdJ4LmpKznIYE?=
 =?us-ascii?Q?WyMawc9Rn2GVyAElUF9BhbGa06ooU6foistrZKYTuumk89mSIhPVp+P0fMd8?=
 =?us-ascii?Q?cJoRWBqTgKDO+gBjBrJ48I7DyXcRv4or7uOKBw3Ed0sSRBiPuEDdf1dF5+NQ?=
 =?us-ascii?Q?f/wyaLIcZZzSMEBlHG1vxzpDgIxSmFGDA/Fau/F+P+UzbtVomj80blNNVQbm?=
 =?us-ascii?Q?JbtwCwMo1MkdZ8TXS2sum71fCqFnHRDoYr0OqUiSFu+D79QatCbEM3VHefeZ?=
 =?us-ascii?Q?U5FXp25bLh4xWnP+AmPPMshSpTR5AdPNZih79xPzwJn1CKBiy+uquZINRLIZ?=
 =?us-ascii?Q?/Vp2+Bc4tdAs9JPQvpLTMLGXiuNSk32oXJwtCPPpVed4IkoVkPhCPN/Sv52h?=
 =?us-ascii?Q?O6Ywrd5vw9pqMVpgPhJQVRoZq+tK0cAx9YponO6mI/NCdXnQNbCceRcKzi0Q?=
 =?us-ascii?Q?yeZ7+Z5c+mlDoh6XZVG4ilvDHAZgOb856MZsQoU/+C9Lccvs3YYMFJQP/DTn?=
 =?us-ascii?Q?1pjW4LQB3h4OBP8uuVp0qywRVTT1Ak8pt6PndGOoHAryOgMvBzRXrlreWIKl?=
 =?us-ascii?Q?uoMv2xKtqY6452BE7Oh9RlvjyQmjD9EN8WX1pLIRuwCk7c4Cj30jy+6OFDA/?=
 =?us-ascii?Q?9fc/5+NIdQMlpckZW7ujKG4nX0HJIZG+Y/a8NCwPeOScMBKRkav9ISZiAwLl?=
 =?us-ascii?Q?u3dpztwMVw8hSdjb8MclqRc3iLW7+2yTixLXI4HEhQXqlP6hs6Ankb4SOUIe?=
 =?us-ascii?Q?T92apL299M8POhf4Wg5jBkTO2wjnNjdrk5IiYoDiCk5T0EEhdwptZfEPyM3X?=
 =?us-ascii?Q?1YdOpts6XCrQ/knl+svoS4Z96oPUYkPiDiALcXd5d/EDf9D6Sk8H0RleFUBg?=
 =?us-ascii?Q?Nu3/8buPr5cRMePEukcQYX4yYKJLio1oDHVZtzlQpwBFWV6Ou86JUjrhqMg6?=
 =?us-ascii?Q?gWxRtPvZ2GU2dlrdJdS24gC5I9ltvegmqjHq2JkShYm+SjdmEARQRHSyD3je?=
 =?us-ascii?Q?njJrG0XMgXOK9n5R3PoTg46jwXiNfkRxG2ckIcVsROx/JklbJZGI3JQvA24+?=
 =?us-ascii?Q?OCQv1MvT7uX6cOkuh9ZgLk6PfnQYdg12FaN5C6SCc1nlY3MrUYESJhxsqFyf?=
 =?us-ascii?Q?vMjFyyBNSLQYOIk8LEuDCw9tQfLGly3UG1T6NVA2ywLZnyjtcEneMspXPT9H?=
 =?us-ascii?Q?/UqixD500L941xuzhOf4rsb7/J1NlcOVGSw42pCVWUL5N8Znu4wGrJ02B7gS?=
 =?us-ascii?Q?P2vt2B4KTgCPSirV3gxM6i4YpSXhWCFo/zDNS4UuHsue/9W1tR37pHB9CKD/?=
 =?us-ascii?Q?SFMagZvfWtUIBmTxuW3Abr4AY8KnMK/bcRuBxlI4G8OaDQ6o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s/LqoRKI+plVmi8KFv3UdXx5dpiGep1J4T+gFwSzIKtN9BV7a/AsMK4CXKTJHXwxuTsy8BK9qOnrA71Z9rkWCGYfUG2QhQF25P3ZMQ44UGNuHb1e/V//RDCmP1ru1JVVWyrsPavv9Mw+9Tzd5RDazRJqghXVd6qg8BkWHiPnYpALpbZkD1qEpdFCOsJ2tO+e/E+I4I/1MHs7BwZ8HEJTrrZAYJJsZdx5N7A9urD/jCt+DOrXXbUW3tJ7L2jbuTpK0TSfFr7gLNIW9DePXGDcqsPAUzK9Mh2S75HWbVr2YvPQ9k9Yi+6XEn3wS7VlLJPpSDUDIJIZkEyPUxGtNJHTbw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1316951a-6152-448f-9526-08df3e9bbc98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:57:51.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qFMEKPArgUTvCR0pHvoMlDQ/sq1g+y7VUwFA0J8xlIEus3tmnizhdrrf1gln8HgqW9hJStrAoJdSUlIFg8hZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3523
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX4GIxhdf4MmTL
 qoGAyvgrBmQmmly6dzD2TGG4j5BwVik1IAzisUl1bSs/unuOF+L30Qlu6PgN4CUEmFYFXBw8zgX
 Lse65ZDI14iweGoJ0lzXl9NSiEElw9E=
X-Proofpoint-GUID: QqFPz01bW-gx9FIuK2ZkFM5P5RcRnSLc
X-Authority-Analysis: v=2.4 cv=F5nC5ahN c=1 sm=1 tr=0 ts=6af225c3 cx=c_pps
 a=yafsvPyTBqI1YZ6v0bsx/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=a5XQCXLgeJ86HsEqIBYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: QqFPz01bW-gx9FIuK2ZkFM5P5RcRnSLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX/CW5U+FVgktn
 Da7/mCJEJ9uCdo+FOBk76Z0x3YUYxhrpDgiHjveDo1MuXta1VNyCSZlJ9yA4pl5QPhk3gsdBhOV
 7JFMh/r8zAt+dFNsjLaom8WJ184b4F2/lrt9J6mJC28lNeJzfqBmZemY0S7EHXhIdA/Ggx0Gqgx
 ZgI4XF9IKLBl8jjaJheKX2vSsTJ15DUAUPO21kIQF1ssbv4Ntpys/+MRFkNzkuSitVQeaR1Bpup
 RzWh6+d3gmH/Lp4w1iL6XTV6Kiql3WgkqmXqYFJfTSsen6XYPTLUCwiLsHW/WY4y5w95nmFWEd6
 HOJfrQ5ZfGxXL27enWElbyVAD3BQp9pLshICTsjkLYL4pgvdwSWI4kTdIWn/XYTiVtGj0SGBQ79
 v+DLtAnnizn0gPmM63xdCuQGZn9TWoTNv1RxN/ATeET5IRSFeRjLrWWU3hZZw2TiNVn2J0muzu3
 PMnlXpAAYBJvWPfqrMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] crypto/cnxk: fix AE table get on unprobed device
>=20
> rte_pmd_cnxk_ae_ec_grp_table_get() and rte_pmd_cnxk_ae_fpm_table_get()
> checked rte_cryptodev_pmd_get_dev() against NULL, but that helper
> always returns a valid pointer into the static device array, even for
> an unprobed dev_id. This led to a NULL dereference on dev->data when
> called with a dev_id that has no probed device.
>=20
> Use rte_cryptodev_is_valid_dev() to validate dev_id before
> dereferencing dev->data, and reject a NULL nb_max_entries pointer in
> rte_pmd_cnxk_ae_ec_grp_table_get().
>=20
> Fixes: 53ff25b1086b ("crypto/cnxk: add API to get EC group table address"=
)
> Fixes: a1b4cc32591d ("crypto/cnxk: add API to get FPM table address")
>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
Cc: stable@dpdk.org
Applied to dpdk-next-crypto
