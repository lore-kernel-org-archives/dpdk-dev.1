Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F01CCA472
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 11:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BC384060F;
	Tue,  7 Oct 2025 13:54:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3746C402B6
 for <dev@dpdk.org>; Tue,  7 Oct 2025 13:54:11 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973Bj5F016513;
 Tue, 7 Oct 2025 04:54:10 -0700
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021123.outbound.protection.outlook.com
 [40.93.194.123])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49mtr88upy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 04:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk9ieZueWSx5O2wG5iJHudjC6GrHyhzZ5JpIKOtO14MT/ZKPF7PcT6xsm4tUEvaLuo+EblvHvaavrmbtOIu2UiDr0w4+wSS3CP5NRsN3dPPXUYUCDhjVW232jCyNbxMkh5qDEt9hZP+qFwMsNCneBrRA/kgJaZkardqlON0KHq2vT4Ah6TftbZUKuVcHAebw1fhacfySZDmXaYrJ4Lbjt29mhHE6Gev6ZWCxecS/dYp1cgLxlHdwa/lui+0WKCMdACVh7UDytZi7bUXgG6jsOMitVBQY10sV2Kr3NynRz6QO0GMwmCwrU9mMJzBIlGN7RHRM4ZKe/aTMfni2Nh/Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es1ZbUDj/0XtVOTE1x+ZHu3tJMUeuWVee0AGLaGLBJk=;
 b=acc90/KWcZ7J685SCkRzwWT1RmCvrD9OhW22HgTfOJYMNceYpMQ7YgN4dItumvWM9C6RzSN6krE0gPthwy2ljF5NVXLzotNxB/9ia72Alocv6H7EoUKgkwAnZ8dDEiN6D29NdlnKl5q+ossPdmoCYPDH2nxpSoCrfVAfObWMOb8ok+7pzRx3Tz7amYiC+OF/LSn7lvoB4i5RL4KBY9cPc2evlAadTcSxm8JHHcPBNScikHpxNl1ZO+7vmUYX+wvWbJLbyomBsVMO6mUnXbdRaQ8DwZ/maEpO8qYzJzlS8HCCYsJRGFVRThQrzjifzyZ4/0acCwGG+g+VPawhHq73VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es1ZbUDj/0XtVOTE1x+ZHu3tJMUeuWVee0AGLaGLBJk=;
 b=cStDFcmAGx2yMtZYd7A+33vYyOsXPfHWoyusIwKSu9Cfk7WgqWMZaF57R6v6vlYvkVn/KY4nxy3EdXxu9jhl0NUxGYLFi/BL/vKL5zuhMR0q++oHRRaY5eSdSWXNswm0vImJHrEZ9gscrfouYQPEfJsAKx7/xo2eKpHIaRpH+hM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB4791.namprd18.prod.outlook.com (2603:10b6:806:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 11:54:03 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:54:03 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>, Tejasree
 Kondoj <ktejasree@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: RE: [PATCH] app/crypto-perf: add ECDSA P192/P224/P521 support
Thread-Topic: [PATCH] app/crypto-perf: add ECDSA P192/P224/P521 support
Thread-Index: AQHcNBfb8jGDjmylV0aBC/VTbneIELS2meKQ
Date: Tue, 7 Oct 2025 11:54:02 +0000
Message-ID: <CO6PR18MB4484ED60D690C120C2DF2DABD8E0A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251003034233.2964182-1-rchiluka@marvell.com>
In-Reply-To: <20251003034233.2964182-1-rchiluka@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB4791:EE_
x-ms-office365-filtering-correlation-id: 3dba0e74-1fd3-47f4-4da8-08de059835e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Rirn1G9OmuFEtwdmgKtyPVTiZ3p8vJjRU1YJ7AJ4Jbogt8vRxG6QPVmy4JZR?=
 =?us-ascii?Q?qrNQBLB2u44wGd3S4idQmmFg1A8EDt0yBvvzvM7R3Hd3MBr6xXPHYrbD0X45?=
 =?us-ascii?Q?YboB2nEEWWAovLUmzBlqduujvvm5iaioka4WMY36HMY3zxC72u6fZ3t0TXHf?=
 =?us-ascii?Q?IHEuwwMkxBak5r8QhldbBAkMZUvlVYM2QKQOz3POZk08PhxsTynRjiskL3/2?=
 =?us-ascii?Q?tWVhwDyRIpYGOXvRtf5UvMlCw9z2eUrGfaO5tMyJdjEWUI7L3rGwFm8I/a4W?=
 =?us-ascii?Q?030B12FZIhgjDYjF4Mjq5TqU1WBkHht54hfyQlHDldh1U90lR7TsGSi38faG?=
 =?us-ascii?Q?v5e8ecIDM1qbO0gkofL+zdJD7aSxw52nbhh15u9dVNFZqHW7PCDfZv0RBhsc?=
 =?us-ascii?Q?1DYq1r83Fn3TPZDHWRx7/u+JmsBRPHUboezg+nQrtY7OeFLDLg8QypjMFFRT?=
 =?us-ascii?Q?fhwAy+Jd8A1Q09XpPLNxNupyTvrDiqzCZWexlF0NIX9Y2z3TjF2wr3o0Amb8?=
 =?us-ascii?Q?XQqDPlL24MZ7xklGNaMjNgof8j5u94fOYHNOteQP5j+7bPd5zcHsZOeHv6/y?=
 =?us-ascii?Q?lLs3Qef3Wwl8e3qVRF7Dz51CYcj7pm/qT9wBsT1SX6a0xSZogNAnIMA4NS7k?=
 =?us-ascii?Q?vuQCL03RER71sKIWYmf50aXVTEzfbU2sTM46DfU+C+2Qtlmwx/9faQffM4rN?=
 =?us-ascii?Q?JKRF/qnLedl9JgMwpsgmgnMhs7atSeWKH1/ZUOwouQlHTDCyzrYDIL9kdbH9?=
 =?us-ascii?Q?DK7lIoHR1odPQPGPRCtoIgvfdVyBQMHXnEvEiujH9PwCCIiCfJEk7GAbcbz1?=
 =?us-ascii?Q?U856jL8wqRNO8EAGYqCIbNMqCVYbo7Gmt5T6d6RoqDuQg9hsxmfyD7OSBXZR?=
 =?us-ascii?Q?kwpIbXDsIFuaaRT/88sWJJhT74XrxWJm6yGsPcVOm3LzV0CQCkKY7EXw39T/?=
 =?us-ascii?Q?SYVMBHfgsRRJsLKYjuptnXarLpHZvxfrYXxXQ81BapuGmSyzc4tRvLEqxupD?=
 =?us-ascii?Q?yLcl8PhTDrkg2MxjPpBW/nhE9jP172GCSBStgxBo5l1HySP2vR79P+z3BiYy?=
 =?us-ascii?Q?HNeHXIgFb+/Dd4etmtZ3BgJZRN6/9bV6wbc7stoJ8EXxqOXC95lfZWnq6P7L?=
 =?us-ascii?Q?vdHoJIWMCgn7D+AxdqDm8uwg3kVt+ykQUNjYiPyVWZHGl85D0+BMZy6++8R6?=
 =?us-ascii?Q?vM4pGYKTw9/o4eyt/C/pVtTo+G/tPKFkfnooWIEC+YoFx9U85TfGrpKZ+ucp?=
 =?us-ascii?Q?EgnuGloux13uTPrqHPWeMoBAcQPmoryO36NPeHuNJRByQM9UF3HlfoZHhdzA?=
 =?us-ascii?Q?McQK4EvctcBwS/dVXfhv6oDsKeyL0HVf3hFcHlGihMCNMfg8nDbzK6JYJCGh?=
 =?us-ascii?Q?SnRSo9dZrKnJPgMnfkaKP5ed2lYo9gYgBT96v0SVj12RlynVzkbvAyMF2izP?=
 =?us-ascii?Q?h1wZ4T5kshXxjwGdXWC2BQNb2iIScCPXwOojJqwBaM1BT5+VNysDHollnj3k?=
 =?us-ascii?Q?DsT5IWeLnC4WfpIdzV55TINB4KfCHYfrIAeo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lsk4zeiEeTMWJlpHf79fosMDgVKqZrp4jCiCxZtFVuW474XqXprb5/ovxhgu?=
 =?us-ascii?Q?T0bWjHhyxmxDgO671ydMO/tT8/1Cmc0Iq/47LqN5Pnor17i+fTN1OIx59cYS?=
 =?us-ascii?Q?9cFHokIUPrXSeuDIxXsFyLEK1e3hjEIH95fjgcOe9CmrV7EacGz84ruy98qC?=
 =?us-ascii?Q?jjP0nLJKY9oHAsOkN7BB3zCdrepTlngahQ1poFdIr5DLNaVpE+RgBo1duPQd?=
 =?us-ascii?Q?hDA5fvaWf0DF0vTqKkzKn7s2IE+J0CiOSxkDs6czC16hrVpOe1PLzGtwMKTv?=
 =?us-ascii?Q?TRNs3/wGUI2HGzblhO61tcU01BVvbFvqzAcmCeH4f8SoRLpt3lHJyXHb8eZR?=
 =?us-ascii?Q?GUVxDYgUekfSIQd1ItSkE+Nx4cDV9TDRrvMA7h9Q2T5k2ADqLti8s1azIQR1?=
 =?us-ascii?Q?obMBWod8iqJlbPxnVXHgdB8FTb1iA45zkB6tz2tU4oS5Gspla+mGKe35kTS8?=
 =?us-ascii?Q?5fna8IQDfHtwNzZmX7AOZNJ7qSqezSCwpV2qGhrurqYj7KpJQNnabAPamNNN?=
 =?us-ascii?Q?oNNpzTxeD8LMSLNlrr9oggHiOuSyjnNeWm1JYdH/MvuTY6EasjT2UcWcI6Vi?=
 =?us-ascii?Q?uA44L//uc0P0c8S24bYZuGG469//Lv+eVJAaLBUF6C25jHXkAAsNPZ0gPmT7?=
 =?us-ascii?Q?avPF+GS8b0bzOpZ3CcpWMGuKifM2RU+Po07ct0jfuj0xQ49I7dj4dRATwVyk?=
 =?us-ascii?Q?y10IVdKWnrWLwE9+fnEtgeiHSmz8m9/LG1R7pfZdts3HsfBlhRuYW/ITwocU?=
 =?us-ascii?Q?kUc+7G4ycmJOeAxr7gzMHIyPQmu8FgRYj8rHuxOAE1XL4Pr31bkFNIn6pzd/?=
 =?us-ascii?Q?XvvvHBN98k7C4AjGOkFbqfMCGO44t2w4JV9gPWbiu+nqZT+pyQfUIjVNBklT?=
 =?us-ascii?Q?WXNWTdtEdZjuFGVRgtSfU45y32zq2fpAur5Am5NR1p4V6cnhYZEkuE/y8raX?=
 =?us-ascii?Q?fKoVG5qqaoy2+2FCo4+PLHSi54lNIVk7fLdIxq30rBVMjpp57wD+lF7Fg23O?=
 =?us-ascii?Q?cbitVdKF1ky2MJpM/sdcr4eoZGjFwCf2YRyLeB9cIhAkV92itP22XoZRoXp+?=
 =?us-ascii?Q?33gVV8PMeEikLsJeMAs9rYn13nyETNJsvGBotLK4eNif9XuSScYLmJAWgpWv?=
 =?us-ascii?Q?rSB2HHBNurzfNQYO8zleFThoru7d6wEOpZAqhVwMoYY1odc81cbbNSk2ryFG?=
 =?us-ascii?Q?3zwPDQZXPENw/Eophvz74vboUHydWfZcJU1x7ZQHKe0ZwmZWF7vjxAdOY9od?=
 =?us-ascii?Q?4YJbwdcE9CTCwlKWwzpujhvCnpYxT2I+D3ViVtsNWuoZspXH79GEKhpdl6IM?=
 =?us-ascii?Q?s15W8XXtAPjZ3wadNMaIxK+hxqqTVPqoZWqpw6eDz+HNBsQLyA8trejXjVlm?=
 =?us-ascii?Q?swIM0t2GhBU+rFn+azEhH2HVLPxjXowe78F5i7lNtOg5hIzElAzLc9rgT49k?=
 =?us-ascii?Q?ynDVhNQng/q3vuUNQ8884k8xbptg4yMK5S1WKZFVJ7EUz5WMFa0220YuyqBx?=
 =?us-ascii?Q?ieirTEyy9/0X3zdRjBz8sG+F99v02SmuxAW6gOtPXNpV8H0dQjIEh4HUCksX?=
 =?us-ascii?Q?z88moegPHX/IA1apNCAzGkfDZEnOIvbv+iDEoBpM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dba0e74-1fd3-47f4-4da8-08de059835e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:54:02.9864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ztbze/kqLyrBXTDxroRUBA0KBoj5odUXzH2mjDv8AS3OivUZwQ+U2oiw3rIFcaujYpEy0yXLtsr8YiM0N2NEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4791
X-Authority-Analysis: v=2.4 cv=R5MO2NRX c=1 sm=1 tr=0 ts=68e4ff62 cx=c_pps
 a=1pmWRJemPF16E+bttNzokw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=jJzs4CfI3ZC2gsNvO5UA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: A4mID5qdMZWB-ORieV8r4kZSjj4UKHFX
X-Proofpoint-ORIG-GUID: A4mID5qdMZWB-ORieV8r4kZSjj4UKHFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDAyNCBTYWx0ZWRfX+PcH+8nS2Woh
 F2NALcIF5cOTPsL0qIg/VkQ8bl/wEkKk2xWTeqYWukS6ucLLrQYxDi3lq9+DRWsIrobi2jZDwsd
 owmrOOaEnxkz7eQ6XKkk0W0Vijr1af/8kUgGboOpAyM4B030ObbLjV4iO0RBtWkyQesonZx11uf
 KENkrkSVkrpOeGV7dRlSZkSetZEpK/TKD1c+SU9lz3ayKRlab0q5t+2hOaOQfYlVlRtIsgi0uQ/
 X65m2RFy0aWXK4vGkwnAM5ZcBLkpU1u6IGULMU33cFW1rbaGowAB2mpTM995vHsY0KTADSqTzcD
 LSnpHFqW24ORmgCSnzgJx/rLd4WaJ/o2YoCQPVoz2KTqRvpDu1+CVRP6MkSnGaHzztX4ENQaHcU
 kQxhfV7gWMPZBBnm/kPrb1p9ZV9Ldw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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



> -----Original Message-----
> From: Rupesh Chiluka <rchiluka@marvell.com>
> Sent: Friday, October 3, 2025 9:13 AM
> To: Kai Ji <kai.ji@intel.com>
> Cc: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>; Rupesh
> Chiluka <rchiluka@marvell.com>
> Subject: [PATCH] app/crypto-perf: add ECDSA P192/P224/P521 support
>=20
> Add support for ECDSA SECP192R1, SECP224R1, SECP521R1 curve SIGN and
> VERIFY operations
>=20
> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
> ---
Fix compilation
