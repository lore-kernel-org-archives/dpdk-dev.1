Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A06E6BF00
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:12:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2919240274;
	Fri, 30 Jan 2026 12:12:35 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6A76D40150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:12:33 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60TNXMII1035259; Fri, 30 Jan 2026 03:12:32 -0800
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020135.outbound.protection.outlook.com [52.101.85.135])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c0h8617ks-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 03:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siRs6BG6jbD3hEZ5E7iL6H0ySPC6JClyE8hxAsPZGAxl9C+BR+76KyORCGHOLKIO4ePEIH3mpPxPiY3vF1YSDdrJnU+bldSXTIAgQw/TgiG7Vwi7LnTZTWDieevVstX378amrmlLAF72HufOp0Z2k80Gp+iabtCUStALjBg2Vbag5OuypFVc1Mk7sUcdy6EIOC/PC7FAlkehdkl6dFSyi9fy9Ui61/H86jHmTg8/eKTNsz5lDbZpZekICCR3051lNDXMYephn0ENxwvZAC4gqFq9uk1ElOWWF73Nr7xpCPlOXoA7lOoPPoLaj+MZ0D27miuCBR8e1rKkKN9hTh8rIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uttt2B2fp+Bj4DgKFsqQWCqCcquLqU3z1JQcxiNXNyY=;
 b=spIze3rfp00HZ7xfYLc9E3Y9NdiM0EQ6OcnkstnDALl79HiJyMq1zRYw1n4T42SUzaT4iOKfYBQKG31NsJp740qasfXWA8dLN9dWOpZKVWZl80d2IDYU+SmfREtJwwnS0+ri6rrRd6uzqEma3hUOJyqgqMcbP1fKJPuBrUVzcAJLFcVfSBQ0mB0GfZFsw3XZLgjBti1/zz7SeAAEzbGv4Ecng3QQ7apvX6lx5tTvfWA/TqKMY2wfs6cs9zdfWTLvCInIcW12ZygOFv0cnvG2EXLIfzo6MgWCUBZ1604JJYUdn7ukLe6esHw9otoMeBW+yyehk4bk4oQ9l63RMlw8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uttt2B2fp+Bj4DgKFsqQWCqCcquLqU3z1JQcxiNXNyY=;
 b=sWuYvVtAP2O81u1uuc9QC8+D/1si6gCYY0u1giNo/YHlMAME0/CinvoriJZNiSfe/w9d7FKskvgiCuqN3lSpG+vIUweBg30X6JM4ZmhzmiZ4qa5+tpiRWdALgYn2/2lJt2iyyNp8my9aFksB+X49sTbnetUXSFgllppklcMQG0Q=
Received: from PH3PPF1E92D74AA.namprd18.prod.outlook.com
 (2603:10b6:518:1::c8b) by SA3PR18MB5319.namprd18.prod.outlook.com
 (2603:10b6:806:2ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:12:29 +0000
Received: from PH3PPF1E92D74AA.namprd18.prod.outlook.com
 ([fe80::ca95:1c3:c1c2:d049]) by PH3PPF1E92D74AA.namprd18.prod.outlook.com
 ([fe80::ca95:1c3:c1c2:d049%7]) with mapi id 15.20.9587.004; Fri, 30 Jan 2026
 11:12:29 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v7 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH v7 2/2] test/crypto: add tests for
 256-NxA4/5/6 algorithms
Thread-Index: AQHckRbX07Ffd8NCG0CTtc9KyXb0PbVqjvNg
Date: Fri, 30 Jan 2026 11:12:29 +0000
Message-ID: <PH3PPF1E92D74AAA2929CD056723554B9B2C99FA@PH3PPF1E92D74AA.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260129120001.73511-1-radu.nicolau@intel.com>
 <20260129120001.73511-2-radu.nicolau@intel.com>
In-Reply-To: <20260129120001.73511-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF1E92D74AA:EE_|SA3PR18MB5319:EE_
x-ms-office365-filtering-correlation-id: 5f7b9035-c0f1-4656-94cc-08de5ff074e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K01GV05YYXgvNEhXZ3l1NGFBODJlKzJFelpZYVR6ZVZWSDFhWEVhSWlaKzNq?=
 =?utf-8?B?dTZzZ3lGdjZnbFJjSmIwbmdpa2srUk8vMTFhMHRPK3RFUWVCVHd6UUJ3VmFS?=
 =?utf-8?B?MWphMk1jYnVhcnBWWnlUWEtrMVMwNCs1NFFTYThjaG5TVWNpM1poZTV5R1RL?=
 =?utf-8?B?R0djUWxKQmNuS3lIcVlQS1FBbHAvRnFTTHRFNk5iUjRENVcvM1NMRXk1b0or?=
 =?utf-8?B?OFBab3ozTHFIbFZwUFQ3MEcyL0lDUitKNUdqRnB1SHFXT0xHUy9lVU0vMHc4?=
 =?utf-8?B?NXVMK0g3TWx2aWxCcGMvampIVXFCOFh4UndYdTY2dGlaaFJZU1hJYkhhSGpm?=
 =?utf-8?B?aTRIOWc0UDk3WHlkYm1qdkxuV3dRc1p3VWplVTg3elB0aHNKNWs3dWYxMjNz?=
 =?utf-8?B?Tnorb3BYYnNLMm9WbUE3d1d5VFVyYTRETjNLM3pPK3JrV3VuVGdOTHFlSWNX?=
 =?utf-8?B?NEUybHdrQXV3Z29kYy8yeml1ZHFIU21YTEUrU3g2aDRXdDcrQ0s3YmhOSENB?=
 =?utf-8?B?eDYwc2VCblh1UUJUcW9kMk5yRThCRWtJbkpMdXhRcGZGVlk0MFBHcHBoditE?=
 =?utf-8?B?RDBRQnJFSkpUREVSNk1ZY2lORm9KbUFZYm0xblQ0WkZ3OEVFaENJT0hOMitM?=
 =?utf-8?B?T3MvSDRwVjlqMVhGaTZnOGZ0b29SRi9BclUzVjAwYVFRY3BvNWpBSEN5cEI0?=
 =?utf-8?B?LzN6a3RNdkdyRGNMRWJoVCtldStBWkxUcW1KVjUrSnk2bkRPSVZGTHd4RVla?=
 =?utf-8?B?VjFJZEJkYTFDcmNYM2tVQmFNOGl2aS9HWHZMNk1jSmNIU3dROVhpNFJKaGQ3?=
 =?utf-8?B?RmlWSXBvUFJ0NEYvV21EL3pRZ21SWW55RmUycGpPSHdmdjV0cFQ1OHlnRTU4?=
 =?utf-8?B?cjBZa1lLMGJLQ1pybGdlbUw4VHhjWjRiS1NPTVBFVWV0S2hLWnNDZkN0UGEw?=
 =?utf-8?B?Qm0rZ0sxODdyTld1QVo5alA5Um1BK1U4Um9KS2xOZlpoNDJncTJLNXVvVWpt?=
 =?utf-8?B?YVhNTm5KUkZrQXA2T0RCZGs0S0VFME9EY1U1N05kdFl3NDhhbjFGM05rcFZM?=
 =?utf-8?B?VHJtVHJ3S25RSURLWVdtZXF4YTFQQVNQU2lnZWR5U1Q0QWNOQktONTZkWVZZ?=
 =?utf-8?B?NmNIZENWOS9Ucy9INU9ENWFXQ1RvVUQrUXJjeTUvREVvOGhkUGFmb2lUQUdC?=
 =?utf-8?B?dkJnMVdoSW5WWXdJbmEvLzNQb3ZMTnFsQXNuQVRzeE1scWV5NXFsSWJ3c0Jl?=
 =?utf-8?B?QTVZN2E5aW5raGJwY2p3Rzdwa0xiNVRTUW1PZ3FJZHl0N29ybFBjbzFIeC93?=
 =?utf-8?B?WUtEcXdBamdla1I1em1SZmlPRE5QeHJxMXd0MzgwY0ZNVTYyN0NSZlQ5bTlY?=
 =?utf-8?B?TCtQUDN0U3pXSTlzOWN5c0pSV0ZpUUhVZDN5WGxKd0lha1ZRbHZaWUR0aWZT?=
 =?utf-8?B?U0xWaFg2V295a0FXcVNOVGQrTDVNb1ZNYUYzRHFoY3RSdVdZdjdPN1VvQXpH?=
 =?utf-8?B?NzltSnY1WjNLTmUzS2JKelE1NllhTmJvWUtMZE5LSFVWekRJa2xHeWkyUG5Q?=
 =?utf-8?B?bnk1NUtTZGh3UFBJVTFZeTE0YjVjWkk5KzhjeXRPSk1PVHQxM3hqd0tvVFRE?=
 =?utf-8?B?UEZ2NTFoUlJobXBXellOVHV6VFJVSkZKbzJDZ3NMdm5hSWZvWWN4MGFLQnEy?=
 =?utf-8?B?OVJ1ai9KNjJndDJrd1JQMWRyUW00aHhKTGo4TTBMNXZBYjFOWkFHRGpEU1J5?=
 =?utf-8?B?WHNudytMMzJTZDdyaVRtbUd4R3d5NUdtVTJORkNOSnZnamRLWWdsZDMxK2pG?=
 =?utf-8?B?akhvK2ptSC9adGtpcHZ3enFiaFE3Syt6RGwyd2tYUjBmOXo5L2FJT25kcjVH?=
 =?utf-8?B?SVk3aXZjT1hEZ0c4SE1yZk5pMitQM1QybHVkT1FKSFdSOUdKQVB0Q01tZ1NB?=
 =?utf-8?B?bmtoNWIyenBVOTk5WXNZWkF1MVJteDJKK0Q5akxvQ3lpY0puakcxQlhZVVFT?=
 =?utf-8?B?RkFoT0g0N1NTcW5pMzc1NjU0T1lGTVFFSGJXeXE4cUlsU0szNnB0Nk5xYk80?=
 =?utf-8?B?UmlpcmRnVzk2VktkWFJzNlJMWUg1ZXlCak5tNE8yeU93ZGw5aUxtMnNKMXlL?=
 =?utf-8?B?YTFPMENCakRxYTljK0Z0ZWQ5Tk1INGZVRHhmVnhJZ3NLSDUwUGNQMjNMVURi?=
 =?utf-8?Q?pbACkiQ2jgJkXj8GPaeAaxk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF1E92D74AA.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0YvMWlJblorZTRHbXZlaytYdFpuT3IyMnRCbUxmQ0w3QllpNXQ3MExubFZa?=
 =?utf-8?B?T0dPY1FBTG9aRk80Ry9YcHFycVNzeFNHeG5QOG80aVM4TnpZUUpaYkFOOW9K?=
 =?utf-8?B?Y253NTVaSXlNVm52ZFZldlAxS1FsVXhzZ1JRMC9OaWNDWnpkLzhCL0ExRDI5?=
 =?utf-8?B?L1o1NDVBQnRqWE5EbTRHdlVnK3FEUGFBRDY4cUc0dm13YmN6YVE2aVNNUEVU?=
 =?utf-8?B?Y1F2M3A4UDB4cW9CYW9LRlY1NUpBTXBCRWdtQTM2VTdxbkNNV3hMUDk1LzMv?=
 =?utf-8?B?SkdScWV3ZFFncDEwRlU4SklzL2h1ZldxYjNFRDF3WHYyVzljZXBjbldMbmlv?=
 =?utf-8?B?ZkRpVEFzTzhaNHgwWWFNY1prVWRHUXZDQ0thT2UzWmM3RWFoaWV3UmZ3Zitz?=
 =?utf-8?B?dmtWSU0xUThSSndYNUxmcXBNaHQyZGJ3NTNUalVDa3VmOTRsMWRzbW5SdGlG?=
 =?utf-8?B?V1BTek9MYXBSMFcxQ0tWMURsNGViOU1KU2xsUVoxTHZZQzdIcHlzZm5NNFhw?=
 =?utf-8?B?MUtabXNDMkxYQjFvZjZydS9sVmc2VG13eTg4ZTFlelYzazYxYjhiYTRhSGpP?=
 =?utf-8?B?dmZicjBoa1lCMWNJZURwRlkyakI4cURJQkpmUTFPWURuV3BJdVJPTHRzTmtX?=
 =?utf-8?B?TUZaWXhCZkgwSzBpQmZmaDBVQ2V6UGxJZVU5MjNUcWhnVGdDcDNrenFINmFU?=
 =?utf-8?B?OXRIdjk1M2NVU2JodnB6Mm9Bblp2WXB1SmVaZk9vVHlVSkVsMWhieFFmd0JJ?=
 =?utf-8?B?RG1mUnlBUHVuVkZERm5DRmJiK1JDYzZxWmpMZWJUc3hFQWtweFowOERIY0l2?=
 =?utf-8?B?WnBQaTAvb0xVbFRLU0JMak9BREF3VnkxZ0NWZksyOExqMk1FbVNiMGV6NTdj?=
 =?utf-8?B?YWJMY2dTSysxZ2tyZkxMY0JNaE5DTmg4SHBuV3hsWFFBWXhxQXN5bi9heWlx?=
 =?utf-8?B?b2d6NEZVQWgrQ0pIbWo5REhsdVdESW9xZ1JZR2NwNFNZU2JkV21vcnYyWUlB?=
 =?utf-8?B?cTlaQXRqUGk2L3dKQjhaTVpkRmVDakFKZURTeTk0STRPcko2ZWVMdURlV1lE?=
 =?utf-8?B?NkRqZ3FKWXlrV0V5ZkxqQy9GbUdnbWNjcjlGckpZa0QveHczcTFlQUNRMXdT?=
 =?utf-8?B?anBYL2phWmlERURkZDFiS3dRcTBlUmpRcUMrV1B2aG9CUDROemMyNnd5Sk1O?=
 =?utf-8?B?KzgxQml1M3FvZVJDd0VFdnArV3NFa0VYbVB0NnBJeURsemJYMHliQkV6SlJ5?=
 =?utf-8?B?TGkveGJ6azJhQmNicDdFYzNsNm8rTTRsdEUwbWJVNXZCRmdOR3FVZ0pRb3Vj?=
 =?utf-8?B?OVJSMmphNDlMdmRxMEZiK3IrV050OVBMRExLSkMxbmRMc3FUa09Mcm1wMVdY?=
 =?utf-8?B?YkZCRkxKTUZ0QVUrZWJ5K0VMUXVVNDQrK3g3c1FPV2FtWVdUNTBKbFJFbWsx?=
 =?utf-8?B?cSsvWDIyOG90OFhhSE84aGl0MjhyRno2NS8wNVBSOFRudnNtNnpEN1hiU2c4?=
 =?utf-8?B?Ry9zcUFWYlhveDVIakM4QWpBcHBTdVBiSy9HdUJMRi8wNldGY2Q3Zk5sSWFu?=
 =?utf-8?B?Ylh6SkNxclZwVDB5NCtLbG14RnZyczl1Z3JnVnJBU05MektCRXFGc2JuQXZD?=
 =?utf-8?B?OWh2NGd2S2swWE45SW1hd1FMMnJQS3hhSUp5NEpIbWoraUhYS3M4TWgraWg2?=
 =?utf-8?B?SENKT0dUNDJvcitGZlVEN3F2cldMQWdJd0hMbm1CcUgzSlRjdWJQc2FaMUZp?=
 =?utf-8?B?Z3dCMVJmYm01L2tROCt6RG05ZlFiSlNIaTJ2TXY3Q3FTbVJNMUo3eGN1dFg2?=
 =?utf-8?B?akFPOW82dlNZcnFJUHg2MVVQQVJOYXdmS0w5NHdZL3JYUzlIMk1pUnRVaUJP?=
 =?utf-8?B?U1hleFA4T01HTWNMVEZTK1BLUWhjNVpEZmhITU1lNGZMSGEvbHd1WkF2Y24z?=
 =?utf-8?B?VmtObXEzT05tWFVjN01melNWSVpSZ2xPR2lIUXo4SzBGUnRSMWhJN0RCQnFQ?=
 =?utf-8?B?VTZpeU5VeGUzSHVzVjJHaHcvR0pFMm9TYWEzNmVsY1lQZTVvQmZDKzR5WFNw?=
 =?utf-8?B?R2t1TVExOEg5cXMzSDVrc3JvcG1Xci81Zno4RkFQY2lFLy8vMGFRclRkNHhn?=
 =?utf-8?B?RGR4d0x0OVZjVEtWVmVRc2R5UHE5eTcxcDRZRnp3VjdZUG5uRU91clVodVdK?=
 =?utf-8?B?ZlpaSHhmOWlydTJ2R2lQd3ljd3dyZmU4UXpRVUVWZ09GWUI4eTUzVitEVGZK?=
 =?utf-8?B?ZEU4YkRBOHk0aUNPMkYxeitHZENFb2JPa3h5blpiekgrTDJSaW45WHgyL1hy?=
 =?utf-8?B?NzZmM0lmN29UL1ZMTkl4TlZlRDNhREo4dlBub0dKenRzYUs0RGRxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF1E92D74AA.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b9035-c0f1-4656-94cc-08de5ff074e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 11:12:29.1004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHYsIPBiDp3vUkwxbjjJiTskPFZPsQvCR/92zbcIrCBj0jFWFeSc+1VJ7Monqv+n3B3aRISsoNk8bWI4W+twxBJ8MSpVAmxnk5raaanY5e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5319
X-Authority-Analysis: v=2.4 cv=MPZtWcZl c=1 sm=1 tr=0 ts=697c9220 cx=c_pps
 a=gLGM17pEjTTnGae4oH5VFw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AjegBmmS6xiNIuSVnvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8AH1YZ9fSSNWhta_rdNsZzT8d0mB4d41
X-Proofpoint-GUID: 8AH1YZ9fSSNWhta_rdNsZzT8d0mB4d41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5MCBTYWx0ZWRfX8wHzm71uzGTf
 yfxT+VNnipDG6QBG8SabmEeouyWZq1MBiK39B0jbzxaiKrie2ZjO13HgO80tq1k8sokLf97KR6e
 9ilr0YrsbablBeVzsbekTMUtsE2T1WdWGiw/dyoErJ9vKOzVCEqKzr7jRQ/RdD9vyHgfSV249br
 KtghsGji8hq81PsaFrYY1Uw2zWOpzIyq+kW0G7mR5TrGP7iRWF0VPwI3jI+u9jFhs+rvkAVsvpB
 hXgaq19+rAPfK04R0nSRiot2+GQChNR8PammAZoMQFEWdaVhfVdYT2boRTr5MKmp2INDWbX1d71
 FHpCeN1XAty+0LrIpmA5Ht6FsOFrJFJFnKqV0rUP+EJ7gtp63lcZt2CqSSIAS1MpYS2orBTc8Ca
 mo/XlKV6jkk/3XeoQ//8IQmILMU2Wcw/t6FzdnX98oPtjeIgkdj8jjV35UcykKOE6pV3w71o2rU
 V6vOvzX27cMrG0vbVzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
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

SGkgUmFkdSwNCg0KSnVzdCBhIG1pbm9yIGNvbW1lbnQuIE90aGVyd2lzZSB0aGUgY2hhbmdlcyBs
b29rcyBnb29kLg0KDQpSZWdhcmRzLA0KTml0aGluIFNlbg0KDQo+ICsJCXJldHVybiBURVNUX1NL
SVBQRUQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQoNCltOaXRoaW5zZW5dIEhl
cmUgZnVuY3Rpb25zIGFyZSBub3Qgc2VwYXJhdGVkIGJ5IGxpbmUgc3BhY2UuIFNhbWUgYXBwbGlj
YWJsZSBiZXR3ZWVuIG5lYV90ZXN0c3VpdGVfc2V0dXAsIG5pYV90ZXN0c3VpdGVfc2V0dXAsIG5j
YV90ZXN0c3VpdGVfc2V0dXANCg0KPiArc3RhdGljIGludA0KPiArbmVhX3Rlc3RzdWl0ZV9zZXR1
cCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBueGFuX3Rlc3RzdWl0ZV9zZXR1cChSVEVfQ1JZUFRP
X1NZTV9YRk9STV9DSVBIRVIpOw0KPiArfQ0KPiArc3RhdGljIGludA0KPiArbmlhX3Rlc3RzdWl0
ZV9zZXR1cCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBueGFuX3Rlc3RzdWl0ZV9zZXR1cChSVEVf
Q1JZUFRPX1NZTV9YRk9STV9BVVRIKTsNCj4gK30NCj4gK3N0YXRpYyBpbnQNCj4gK25jYV90ZXN0
c3VpdGVfc2V0dXAodm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gbnhhbl90ZXN0c3VpdGVfc2V0dXAo
UlRFX0NSWVBUT19TWU1fWEZPUk1fQUVBRCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQNCj4g
K3Rlc3RfTkVBX2hlbHBlcigNCj4gKwljb25zdCBzdHJ1Y3QgbnhhXzI1Nl90ZXN0X2RhdGEgKnRk
YXRhLA0KPiArCWVudW0gcnRlX2NyeXB0b19jaXBoZXJfb3BlcmF0aW9uIG9wKQ0KDQo=
