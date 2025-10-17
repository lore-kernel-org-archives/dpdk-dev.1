Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D784CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 08:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8DB5427DC;
	Fri, 17 Oct 2025 10:59:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D19AC40269;
 Fri, 17 Oct 2025 10:59:22 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8tFbR009115;
 Fri, 17 Oct 2025 01:59:22 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023111.outbound.protection.outlook.com
 [40.93.201.111])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49ts2auuj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 01:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4OdE55FuXg0aRDFsFCH/f0hfAiePS/XpwgDIWsB+K9pd8TdAD/bjtIx3eFRQ0I4+lIvbkIoV/KOcbASAhaSymG/pHY642hehT1llQlsoLM6qdUzcbxVKFR2RexFZxG5wq37ljYFEXzEY/sZeYqY521jxAuOb+oqMkG2f9TB9rqff8RO+oXsYn4zANz9/77uLcaShRKoEMP5v3+A69tOccb4s0gWmb5eZ6HYui9NDFsuecA/s1aVsnh3BJ8+YmH7Z2tyQSeKYvnj6oeSGLlb4hO1aSZxh0SGxF5mypxGLTFaan/2WBwYqSSrZ14Qo1VwlzXPIDNOLMCKFGnK8NpZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZYci2vve4e833hTPe+BuMUOe6dhUs5/nFN+dsRu+RM=;
 b=LTk5qEMLZiemJMJIQ3J9mWAU3WJyv3emSvnmg3JmP5OhLUrecfrzXtCezYvh0Q0I3drjCeaSt+uQqc2aEOpWgjYnvz4rheyQqRJvPCqevPc++sIhPXuPhrxAFoq5ZJLsBUdZ63Yt8PazX16HLZj9OnNVDUHO02XNsKabRaAsBILcq4Q67SKGG9q91NQ2CGOja79ODdIggu/Cb+RBf+cBBncINQHBl80+GAh9YOPORBrITAWX8TIJFDjMkjfctiw4OT/Mlzn4nk4MutED3IppyUykbb2sFyYmhXsqMrPNWPDP/wNQyjTabsnyJQU8Uw9itZdUO5srySYd3qXmQabXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZYci2vve4e833hTPe+BuMUOe6dhUs5/nFN+dsRu+RM=;
 b=akVdXnhy52a3rSbg1XyK5SAgsvlDHs9uckItOPR50aI0a91ugrm2IwBbj0D/OOVK/OR82WLOIV1EGyHDl6oVOv5o2fiGJThJKtIkpLvrZq3VMdA6qkuuVrx6vua/pjQfCJwZz8w8LPOPJZK5UHiyNDN6ZDWAqlnOSeKpdke8vt4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA0PR18MB3471.namprd18.prod.outlook.com (2603:10b6:806:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 08:59:07 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:59:07 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Ashish Gupta <ashishg@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2] compressdev: update device ID validation
 check
Thread-Topic: [EXTERNAL] [PATCH v2] compressdev: update device ID validation
 check
Thread-Index: AQHcODpVBngPsdUVg0yK6NX28bmtJbTGGAww
Date: Fri, 17 Oct 2025 08:59:07 +0000
Message-ID: <CO6PR18MB4484C7703491D2774F3A6307D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251008074532.3066685-1-ashishg@marvell.com>
 <20251008095950.3078552-1-ashishg@marvell.com>
In-Reply-To: <20251008095950.3078552-1-ashishg@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA0PR18MB3471:EE_
x-ms-office365-filtering-correlation-id: 938ba959-c5c9-4102-d272-08de0d5b6e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cnlnRDVJNFRDVG8rU3FvaVpKbFhYZ0hJTCtBSmdXMG1PdGhJdDZ2NkNOQ21w?=
 =?utf-8?B?VVgyei9pc1NuVFk5UmRzUUp2V05PbFZRSW1qcnRpaEY5eWhPVTNHV3VBNjB5?=
 =?utf-8?B?Rm5VWHp1WnN4Q3JBMUZFWENwSVROZVBvOGJVTGNNRkhnOUQ1TFpncmZjS3lj?=
 =?utf-8?B?QWVIRkhyMUhqZmJnelFxL1hFTENYVXJ1ZkJYUmZsRWdicXBYSEJDbmJQYy82?=
 =?utf-8?B?MjNYbVByYjBkbWhLb3A2Y1BHc2FHZk1yS3JneUJuM1NNaGRBM1VSdUlpZDQr?=
 =?utf-8?B?K21RS3BYaWNNdU56VGdVVUx6enUrWDhUek5LZGRTd0NqVmRKMnFLRjNuNGFD?=
 =?utf-8?B?OTdxNUhNVys3cnR5MXBnTVRWOXd5bzZrM21WdXgrckludURuclR1SzY3TThI?=
 =?utf-8?B?NU12YnNEbDdYcHhvMm5uNVZKajVDQ0V3RHl5WlVuVzZ5MWwxQitFVFlsS0N4?=
 =?utf-8?B?Zm1PSU5rRzhKODBpRWNaUkVOdWhnZGpRRDdMRXhENTEwT3F2OTJwbzQvK2Z4?=
 =?utf-8?B?UWJwQ0RlK3pGcHgyM1VOcEthY1hFQzJlLzhJRXk1bjFDY0V6bEMrS01qQ0Ra?=
 =?utf-8?B?dWExVFhYUzh5SU5SY3NVRU5udGtsYWdHS3I4dTdRTTloMUN1MHBUNEdCb3Vv?=
 =?utf-8?B?ZVFJbW0zMnhrcWg4eEgvbHJ3NE8wMWxEa3BNL0RCSGk2MVRybVg0RlNZVXc1?=
 =?utf-8?B?Q294aGtJMmtzU3A3TzdwUHhaUVhDLzdmRTRhYTR6cmU5QmMyaUhoRnRQMzRM?=
 =?utf-8?B?RGx1VW1PUXNrWE1Ldk9xUjJmNEM5dm5kU1RwZGhKenp0OEZYN25WWmRKUjlj?=
 =?utf-8?B?a2s2ekNGcUlXTzdMdC9LUWJXMFhSTnc3STlDdzZFNXBkMHpwOGJ2TjQ5SGZQ?=
 =?utf-8?B?TFR1MlR1UUg1WFVNSFU0SDZJdUJYZEVpbDN6NXA0ektBTkFYbjNrVHgrN3BN?=
 =?utf-8?B?blhrQXFOeWhZUHlxM3JNczM1SnZ6YTBtMXhhQTVTMURaOVMzY0NRVzVML243?=
 =?utf-8?B?N2RHSGFVQWtpN0RLR1pLbTBGT0xlTEFJVWxuaUx1NkdlRFRrbHhZcGFRRHJG?=
 =?utf-8?B?V04zU0V0WE5oOXNiNHovMG5VcWlnZ2ZubGZEdU1ka0dZVUN2K3l0eXp4UnNQ?=
 =?utf-8?B?SzIzN3Joem0wbVljSVMvWFBVdjdWUTZwZ3BTLzJCU2xPdnFkU1ZLZmQ5dDF0?=
 =?utf-8?B?TVRTejc2S3ptemVaanNtdW83MVhhQnI1cjNmVmo3RlV2QkI3c2NGeURhVks0?=
 =?utf-8?B?b24wS0krR0JjUVgrUzZjYmxBVVRrSzJmSGwzUnJwZFdxTkNTVjdZTVVKQlBr?=
 =?utf-8?B?b3RiakhOVnR3RWFvN3RhSDE0SzQvUVp3U2dIdDdzNDQ1M29iWFllNzVSRnNB?=
 =?utf-8?B?T2lOM3dqQm0zSnBJNERnQ3dienMrNld6bnJpZnE1RzRFWm51MHM1Z0FPU0h3?=
 =?utf-8?B?NXNpK0pqNHhTelY2M0RpTEcxT3JDeWt5elJZeHpNTzdOL1lDdkhSYkl3OUtk?=
 =?utf-8?B?YjJFWXhGb2k3YmhDekxIZm1jelppQUxQVnFnM1kyTzVBdTlGYlBzOE1hc1d4?=
 =?utf-8?B?aW0yeTlxMlVuQ291SURSWHJaUDZFTWdKdWN6cUxjV3FpMUdTL0t2UkVBd21y?=
 =?utf-8?B?TDY3Y0Vwc2lqR3haWVVtdzlRVmdpcm5acGRvMC85MGdVQ0ltREl0RXBCM0Vr?=
 =?utf-8?B?aWhRTXBNM0RUQmFEZFpha2dBQ1pYcHRYcGIrNzVJc2lUUTZCTDhtbVF0NU9n?=
 =?utf-8?B?R0JFMWF2dXhXaElWVUxoK2Z0aWZqMXdHdjd1QzlaQVMwNUVYMlc1SldFRVc3?=
 =?utf-8?B?c1FHaVh1R2lOOVV0VDI0UHFqUWpFNXl2NFl2bGhlTWlxM1RmL09NU0phOTZB?=
 =?utf-8?B?K21xd1YrVmh0MTZmYWh2YW5vbXRDbU9DTW5iQVVvdE14ZkFGeDF4QnBxOWxB?=
 =?utf-8?B?NDVTMW9ERkhoSzVVeWJyOHZKenY3QjhCZnR2akU3aWt1YzZWN0FhYkJjeDBv?=
 =?utf-8?B?Y0gxUjBzOEwxTTZ2bThkcHNnUGd1SS9KWDZoc0w3dmw4ZkZLallWaW5PeFJX?=
 =?utf-8?Q?PbRla4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW1xZ0FQV0c5SytYOUc1Y01Hak4wRy9KZWF3bUVtcFZRWHhUUmNxVVNVdTNj?=
 =?utf-8?B?WEl6S1BJM0d4dUlpdEZicWN2U0ZVWDFxeEozR3BhSDJvVzhjbHppbUR6dUt0?=
 =?utf-8?B?YkxTLzlOWDMzNHBObUVYbFJqR1BaVVFwMWtRUlYvYnY2WEphNFlsMElvK0Ew?=
 =?utf-8?B?VUhhZ1NCTDNqWkhyZVV4YjRxaFlEZDg4OTFpd1dFMzQrUEorYVV5Z25uNEVF?=
 =?utf-8?B?dkdXWHI4VlhoMnRMWHptRkNXNWNMb0NUNFd2YWxUWk1sL2JFMGNnZ0NBd1p0?=
 =?utf-8?B?aEZBeXlhQmtSSk5tZmNZNVMrUzFoTFo2WW1zSCtPZkN5Y2s4YS80YWdlRGkv?=
 =?utf-8?B?a1JZMS9DaGwxKyt1VnVKa05OUjB5YjVqejhPbGFuNmVSaTk3RTBYT1lKVUc0?=
 =?utf-8?B?UTVFbzVoU3l2c0E3Y0Nrd29IaVNyS2NhVVBLTFFXWXE3bWllMlMzbW52bTl5?=
 =?utf-8?B?bkVrM3Vla25GT3VlaUN5cmc2eWtYejRwZXdDdWI1bVJpVWlHMCt0OXZjVlNC?=
 =?utf-8?B?Rk5va3I1NlNualpDR1h1dm5FSU05L0ZZUXVhUkxKT0R5Tk40dTNGYitxaDZx?=
 =?utf-8?B?R0pQM3FCbnEzS3JiK3pEZCtuZ0VQZk1ZalFIZ0RIbjFoTUQ4ZXRKakRBNy9K?=
 =?utf-8?B?T0FpamNVbHRuMGl1dHY2NFAzekxvRGpSWE04Yks4TmNlZXVGVHB1ZVc0TXA0?=
 =?utf-8?B?VTczeUdOaTVRSXhMQVFIcEg2UEdvRU9XdEJmU0szZmlpMU1ZcGV5dTNYN1gx?=
 =?utf-8?B?NzVjVGN6ZmVxbjJxWnV5elhnTTFGU1NTQncxdHlkUllJZXNjRHFzeFdPUGcw?=
 =?utf-8?B?NWlEdjFxNGUyTXYxTUQxRXhhWWl3dzFMcFVhTmJEY0dJc0hHdlRNTngwVC91?=
 =?utf-8?B?VkVvMzNIbStwSkMrbUQ4c3I3NTJSSExRazIyci9lb25GL3AxU29zT3JPa0Qz?=
 =?utf-8?B?ZERROWFrUkZrdVlQMHc2b08wc1htNXloN21XajI0WFA2SnF2ZkE5bE9HcE5i?=
 =?utf-8?B?SmhCU3pMNGJVS3p3Ykd6b3p5bjgxWnFCbTFwMWZ2M3g5dUFmcDNXQis2dkRv?=
 =?utf-8?B?OWhvaXBCM0MrTnBFN0V5QUZlWk5MUHExLzVsY3c3MGlxS2N6cnJxQmdYWk5J?=
 =?utf-8?B?N0pKT1ZDQnBBTldRejRvbUVTSW1tekZFRHdoREtKamFURzAxa2plTWx3OUtm?=
 =?utf-8?B?UlpsQmFOQkgra0diZGM5OFM1cVZyZ2xpZ094alpDeGUrRTFOYlZkM0ZWVGxw?=
 =?utf-8?B?TWxMSktsWEU5NHkxTVhKWUJSWjVqeW5GeVl2bUVXT3R0S05mVllnOEpzQWl1?=
 =?utf-8?B?SVRGbmg5NzgyYUYrcVdhUm5hTEN4cHhtbU1XNXdqMS9XMU5CUTJzQ1o0MVpF?=
 =?utf-8?B?bWwxMnJqWFNpZmFCeXpLRWVZdmxKYXZacHJSdHphN001cDZ0WGFiS2RER1dS?=
 =?utf-8?B?U2RWT1daVFZNdWRXbVZTUFc3QkgxQldUbUtuazZCbzM3SGhYWmZaTGNod3lR?=
 =?utf-8?B?cVFBNWw2OXBDUk9NMUg0eXdnUFlOTTV0amI2Q2dwTWVTV0JGTllWUjFVRGRz?=
 =?utf-8?B?TFNGU3I0RnN0d2NDSWFxanE4aXZiUjFFS3ZoL3c5RmJNNkgwUDFRMDJtVU14?=
 =?utf-8?B?Z1hkSXVYNTljbHNMSVFuNzYrUGRUb1RCdDZ6WFducGdWQmlzU1hWVXdSSnNx?=
 =?utf-8?B?WExFSEQyUFdPU01EWXpWK0ZTUnJhNlMweGpZMnN6aWRkQ0lraktod09zMWoy?=
 =?utf-8?B?WWhmVjdqZGVoeXBOMnQxMjhPVStZTkttYWZtVHdDQnFKYU95Wm5xZU9KYjRt?=
 =?utf-8?B?SGZseWU0dHljaU5mejZuSXlKdzc0K0xBR0JpazdxMTBVUjFRRGo4T2NzTERl?=
 =?utf-8?B?S0x5NGQvRkZNMmROYnh1azAzQlN1UlpXTjd3SjNHVkVvenFpcHdhUXZoZktS?=
 =?utf-8?B?eUVGTjVQaHZBdW1IYkozb1l6Y0xpRitMZHFUaUZlNGx2QjNqTmtJaTB5SEx1?=
 =?utf-8?B?R24rZ00xN2NCWFdaSVRFeW1ScGU0YWZXblg4TU55WXlManpDeU9GYktuUUJF?=
 =?utf-8?B?dDFJQ3NBRjhSU1VjVnhuRm9JbGtkS0xZY0JUNGUzQXNqZ1B5bVJtc3JVeE1s?=
 =?utf-8?Q?4mTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938ba959-c5c9-4102-d272-08de0d5b6e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 08:59:07.5112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0J1hm1OB7SrgZn2JgysxrkVok81R2eYBp91snopBuyMIZ9JBTQxCXYlmfAiZ/cE2ASTGZ1kPW0xYDo8NGktMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3471
X-Proofpoint-GUID: DbfGS2YGCdSqBpKAZwH0fM6hYb7Z98FE
X-Proofpoint-ORIG-GUID: DbfGS2YGCdSqBpKAZwH0fM6hYb7Z98FE
X-Authority-Analysis: v=2.4 cv=T/qBjvKQ c=1 sm=1 tr=0 ts=68f20568 cx=c_pps
 a=f+i8kFYBc78eCJt0xtd1Rg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=Mzj3_a-jBasFrWr7Y04A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAyNyBTYWx0ZWRfXwyy/J/iLXf78
 I7ac6gkv7ORt4fdzd9OGWZh9oF7wYEegwJUK3nTm8i+NZCfBvK2LiDP9BH80RLSCjl7QIaNbN/i
 B/lSZ+eb7pV2ELeXV0Ijhov+Rw5fejs5oggqnF0Vo52popEwv1qVeb2Z0ZKlcySLQOlFrsH7AVJ
 EjDUyi/TsOD2G0ZbltnqnYDoro65qkVyKAHM1ErCnmCftRinPNYdAyZvkNfnmRNn2ptQh6KGLg/
 U7eZWbqJPMiWDXUrlEDUlxde53QuIMJ1iYgQqjlmk19sZ2FN0pYXrewu5gR63jH+KF6VsnNLGHe
 ppIEudbboIBiOQtXs5SKqNQAnIt77bU5uqVez53Y1lhkq01AGlQCUYh0CfMMiWSROx1lrnaOPY3
 KlvW0vxQBH7PDVEmXsW5zA8rqKg/Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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

PiBGcm9tOiBBc2hpc2ggR3VwdGEgPGFzaGlzaGdAbWFydmVsbC5jb20+DQo+IA0KPiBuYl9kZXZz
IGlzIGluY3JlbWVudGVkIC8gZGVjcmVtZW50ZWQgZWFjaCB0aW1lIGEgY29tcHJlc3NkZXYgaXMN
Cj4gY3JlYXRlZC9yZWxlYXNlZC4gSG93ZXZlciwgcmVsZWFzaW5nIGRldmljZSAxIGluY29ycmVj
dGx5IG1ha2UgZGV2aWNlDQo+IE4gaW52YWxpZCBhbmQgaW5hY2Nlc3NpYmxlLiBTaW1pbGFybHkg
d2hlbiBmaXJzdCBoYWxmIG9mIHRoZSBkZXZpY2VzDQo+IGFyZSByZWxlYXNlZCwgcmVzdCBoYWxm
IG9mIHRoZSBkZXZpY2VzIGJlY29tZSBpbmFjY2Vzc2libGUuIFRoaXMgcGF0Y2gNCj4gdXBkYXRl
cyB0aGUgdmFsaWRhdGlvbiBjaGVjayB0byBlbnN1cmUgY29ycmVjdCBiZWhhdmlvci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFzaGlzaCBHdXB0YSA8YXNoaXNoZ0BtYXJ2ZWxsLmNvbT4NCj4gLS0t
DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCg==
