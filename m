Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D1CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 20:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FF8340665;
	Tue, 30 Sep 2025 22:06:22 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F1060400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 22:06:19 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJe0pt022044;
 Tue, 30 Sep 2025 13:06:19 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022094.outbound.protection.outlook.com [40.107.209.94])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49gnjgr225-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 13:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEM7pQVS98gj835zRNG+cEYhvQuDoNnbd943ZnOqfUedL1afrMliUwk3Npg15RbM7DHBlJbtpqbf694r9vhyNebWch/aW14ijB7dqOshiBBOxG1+Ddr+oLIzUwGuDFwaxmdC3rrHTO1tXncxS1O8brN+z09UjCbNLxpf1di3LDG+du2JROxSP2D6RxNv6E3cD6pj01mbQ53ZZqCuWonVw8DGRQlEa8BfK5v2xfYzD4dSWJddNLeDAlQKYM1XLYZW7Fz7uet3f97cl1fIyKg+ehkhEP6TVC4NgOojeHvVpYUYWEvOB88U8WpJNIeZnqoR9/LQLs+c87cB9H/ZZxr7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQkNMr69YpqT5mDozx1i4BSIUE2ragjqJuY6iZ/PrbU=;
 b=v6tAw/m8jxbFzM7AwiOMh36ajeWJ0m66/rk/NYfH3wY+dn28L61G5JqdqqfVDzmEhBupgckZGnLidqxDobbjWFeDEG5qGsiKV2sOtHdFrDjx1+hsBG7Ucz2mVOL7AfiYz0JOnOWsHURv03JhiCmSDq1VGIdko9HMcckPKfcQtHqDlCpV3YA2/l2wHQWslEL2CDHtX5ciMe3vrTPNZzm+q50OmUU0UH1KGCZutTGrzgmYCddKOMyIpEEmwGYxq3m/cBoPlRaINZKzHoabQBKf/IDAxZ+Kee3mVPIUICzRTmqglotW0KcCRML46yb6rcTRiUkwfROGYkHTnWmFqRrWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQkNMr69YpqT5mDozx1i4BSIUE2ragjqJuY6iZ/PrbU=;
 b=HFeVgJZP208JcK69SFwRvZLhZt/qe8zwp4q0fZFxqC5e0RGxzYURda+WyUbaN/yVx5W/xLxOYGpvqZ3EvR3q6i2OzUIuy0kin4qtnhFZRkVQ30Rxm1CbdrAcb4OO8U2Q25FCg18H/tLO6ScrQcjeNyRuAtrzwT7swpQd2IppnCI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4186.namprd18.prod.outlook.com (2603:10b6:408:137::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 20:06:14 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:06:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0TUsyVBQ3cr3r0uK/R8h31ucUrPrq/gAgAeQrQCAFL6XkICSJcuAgACCXNCAALcjAIARQJMAgABNDgA=
Date: Tue, 30 Sep 2025 20:06:14 +0000
Message-ID: <CO6PR18MB4484D68CADFBD91B21C51064D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <CO6PR18MB4484973EF4D64751A206D8BED811A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB97954EB015631E1817D6E3628911A@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <SJ2PR02MB9795463C7D404C59ABE617B5891AA@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB9795463C7D404C59ABE617B5891AA@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4186:EE_
x-ms-office365-filtering-correlation-id: cb5407d9-ca79-4cda-a801-08de005ccf49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RjhMWng2RkFuZXFOYldJQkJzRWFTTHNqWnRtWkx1Uko3T2N3cTFvTUs0QnFB?=
 =?utf-8?B?UGV4S3NhbytCbkoxbmN6WExuRWdXV0IvemhIcXA3N0IyVU5MSnI0aTRoTDBH?=
 =?utf-8?B?MDVwbjBlTkZUenduYUJINUtIby84WG43SEpSMVluLzlMWlhOencxSGd0QUF0?=
 =?utf-8?B?d3AyTVQ3Y1NRMUdSS0cvTmVZQzBEcElReTVPZ0IrOHVwdThEWVQrSFdCOEtS?=
 =?utf-8?B?YWZUM1JtdFdyMmY3QXpLL2JiUmxYcHAvZmZlVE9LRVV1K0JhRnNaejdlWE81?=
 =?utf-8?B?NVRaTzdIdjliY2Z1cUZsZldNdUhZUEIxcWdXMmhSSzBqdzVXVVh5czE4azFa?=
 =?utf-8?B?Rlp2YUxVUlpHSXFvb0xhWEVXUENXN1ZYam9LQkRlK3BhUFZ5bVplK2NLSm9z?=
 =?utf-8?B?KzA4cDF4cm9XMlZiY1hVNTI1bkR5SE55b2xBNTIzQTJXb0VmUmVpMHR3SDVI?=
 =?utf-8?B?TlN0NXpKMmpPbmc0ZXJsK0k2dElvZVJJS1g1cVBSUE8zL2haWlJoK0JtVVg4?=
 =?utf-8?B?UUZ0aG9GSkRuWUhkbzFJckxibVBRVERpajc3YlhhTTlWY1hrMC9PYkJVdVVv?=
 =?utf-8?B?UkhGMG0rRVpPcGM4WHlubTRXOFRFVC9TRzJjMDFlTS9oR3pOUVE0a0NZV1VQ?=
 =?utf-8?B?RDVYWGQ1cDZ5NFQzYXg5VFJpQkFaWkxwQjFhRVJNeS9KRlJIM0ZFcENFakdv?=
 =?utf-8?B?UFVJY1YxVVUxU2Ixc2FlUm93aW1jTDhhbTJ2VEZPcmlsZGZrS3BKOHh2clZw?=
 =?utf-8?B?SldtcjhNYVA1RFphbWtocU4zNkF3U2RlK2dpUllBR0IyRlRldHBXdjFiRFkr?=
 =?utf-8?B?Y2JXV1Y2VnpmMmJUVXZ3K0p0ZzA5YnE2RHNFeERMMDg2NmZIVW1tOW05ckhF?=
 =?utf-8?B?eXY4d0NCb21mWWZaUUhCUGZLNXB2aHBucXJNQ0p4RTd4enVZMnl4WjkrRDJH?=
 =?utf-8?B?UWhoN3NkcXZYYU9GOVk1dTJLT1dJTzhzbHh0S0xlVTQ1cWM4Y1JicGZ2Tjc3?=
 =?utf-8?B?SCtHaU9NK0YvTEd2OUZJMGdMSWkwSzJ5YUFkVmZyaWFVdTVmUHBQNkNJYkx0?=
 =?utf-8?B?Vm4xNG54VlMzNkl1bHkwS2k5Y3NwNFExcE1ZUnZHbVhRczA0Y2pBR0lQbStB?=
 =?utf-8?B?U0czaER0eFEvSXFnNzlMeFhDSnN5RVpMV1RKTTY5Q2ZHZHRYREd4RUNLb1hX?=
 =?utf-8?B?SzJxS1Y3M1hZVEtEQmQzSTVmcVZBMkVkOTZJN240NDR6WlRLTmJaSm9EK3pw?=
 =?utf-8?B?N1R2RkJPRHJWSFVHZDM0TzdHVFZ2aVRjcXJRc3E1dnNiaTlwZFFnZGdaa3FV?=
 =?utf-8?B?RmUwYzlqcDlHWEhJWUhpZ3VXOVRYcU5ueGtWSjZSeEFldzVIN2RQaUpWN0xz?=
 =?utf-8?B?aVNqZ2orS2k1K05NcnBEMmNZL2IwTENSS2lSQ1JQRHptQlBYV3gxdllMdEg5?=
 =?utf-8?B?dHhjS2dMSUJkRWdJeS8zT1BuWkJHeWx0QkJweHZKY09MU3p4MWJGdnJMU3BN?=
 =?utf-8?B?UFo1d2hyQUVuTWJweWdGdzl5VkxYYWg5elNacURxeTJvME5SS0ZhcVJ5c1VV?=
 =?utf-8?B?Vlc2YU5yNlF5dUZlR1VlV1laeS8rRktDL3ZIb3pUSDBhc2srRk11R3JsUFMy?=
 =?utf-8?B?MmFJTUE5cElDYWpseGZjemZKZWNFeFVpNVBXKy9CSElsZ1ZPYVMwSDFQTzFa?=
 =?utf-8?B?WGs4M2pVMEY1eEJoc0t3SjNodkxjd3hTVm1TNnhVZzRIbWpUTlkzMllHeXcz?=
 =?utf-8?B?T2lxdFBYVTFXeWRxRmtudkhRVXZIbDBFdW5hR1hzODlwWVFJMHdJdndhZjdD?=
 =?utf-8?B?bm9MWlBaZEdIQ3BtdGpTdmxmcmNvN3Zqa0ZsaTllL1pNazdhaWJHbXVYbFRo?=
 =?utf-8?B?bGphZ2J2b3gvOXdnUnVibk4zZ0kyc1g3Ym9TL3hmYjk4ZjhBMnFpc3JJZVlW?=
 =?utf-8?B?UUp6S1hnZGhFTFd6Zi9UNWl3eDNERitMTi9IRnFYc3ByOXUzUkFVeHR1Z08v?=
 =?utf-8?B?cE8vdUlzMnAvczFqWVRDcEFmbWNYQnVRTUd4TkFJZU5qa3lwYS9Ud0FQei9a?=
 =?utf-8?Q?NGChhW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHJaS0FxdXd5RGZXbWhqc3AxMGp3WmxaNDBUczNtQ1VSdmRqZEdQbWdMbjdU?=
 =?utf-8?B?TGw5L1dldjYwTGF5cS85aCtpM2ZBRWNSQk4vb21EY25lazk0enhtY2xna1l0?=
 =?utf-8?B?MlpKQnhHcUVMckx4Qk05NlE1azhta24xaHRObHduZFFQRzRLM2UxOGQxeW9i?=
 =?utf-8?B?U2ZnK082ZjZKRkZoRWNaUTBPU3p2R3QzY1JBbFpydW1ia0IxdDdIUG5XZVlr?=
 =?utf-8?B?Z05TRW80L2ttUzh3amFtZnZlemxCVi84dkJ3ZEF5YUpyNmlhUHRBc21zQTZ4?=
 =?utf-8?B?ckQ4QnR3VzIydElrMGNPcWRJQ1BFVTU2NzlJOC84cWF0L1JJNXA5VlNEdjd4?=
 =?utf-8?B?TjV2SCt0dDlYNGZINFhqMnVMK1VwcGtsL0lkZlpTdExVYnAwNDc0UUVqYjFy?=
 =?utf-8?B?YzN6b1ZXK2ZxYXc4TVlaNW1YdVJuTW9sbHZnRGRpVmJPMWVLV2JKQ25xdnYz?=
 =?utf-8?B?UWVabTRRUUxlVnh6VkwwNnNhQXMyS3NvMVg1MEtFMkFISFh4VlFBUVpQZTA1?=
 =?utf-8?B?QlRpdWR2VTdmQStWZHVVOWJpbFFFUXdLMmFzbmZ2N25aS05EUE5iS1JWbSt1?=
 =?utf-8?B?Y3dvbjlDLzczQnJUY0x5d055d2ptaFhOZk96NFlmTzVaSHAwQ3VTOHU4MTdv?=
 =?utf-8?B?KzhvS1JxK3QxNGRVbWh3N1pSOSt4YXBlZnJnWGdOMlpPSTFkbHYxZ2RTalgx?=
 =?utf-8?B?U3VvTjcyZHlvVU16MXJZUmkzeUo4WTNCUzZpSUlUQkl4UExNaXhpTEdKNzlE?=
 =?utf-8?B?N0VsT1p0WTZBMmRqK1ZtOG1rSU5nejJweDVZK3oyUStqalZRdUlYT3E3UlVj?=
 =?utf-8?B?eGlvYTVobEtWaS8yYURENlBOaE0yQkptcHhDV21oUlJpdGhFYVliSW52TVp6?=
 =?utf-8?B?L2M0QW1OUFg1NHdzZFltSlJtL0h1UXR5LzU4M09ndFpESGdGOEQ5QUdNVnhw?=
 =?utf-8?B?aGZ6T0FBR084ZlpZejVleEhHWnFhaUI4M011dUNwejFWVGx4Z2g2NlM0ZXVR?=
 =?utf-8?B?TkNlbEZ0N056UDlBVlo2VDVKTFVoUHBDK3Y2NEZyS3BHRWp6YmRXOEhOK2gy?=
 =?utf-8?B?THV6TGprUVdPZ0dJcDRpNnhtcmNnN24zTnVkNXM0VkhmNWpOelJDK1R4V2d1?=
 =?utf-8?B?ZmlDb0R6ZG5JbmNMa3V4V2wvSFNKQU9pVWRLUW9KUVRQRVFZSXd1blJJclkx?=
 =?utf-8?B?ZG93N2ZteXdTOE1lM0FMdUNrdnJsLytLeWhoYXlVckR3bXRFSldvZUZqZjE3?=
 =?utf-8?B?aUtZcWFlbUZaMGp6dTVsbjJWZU8xOC91ZmJwUFg2ZEpNZFcwcXMxM0ZwOGlv?=
 =?utf-8?B?S0FvZ1pPRjgwZ0hML3FCL3czdFNEbkVtRGh4T0Jkb25LNU9kYTNWSTFXQUFN?=
 =?utf-8?B?QjJOMjRrb2F2ZGowVzRaOWdOK0RWOXBGcjQrTjJWbHhoMmpreEFpMStjTGtN?=
 =?utf-8?B?V2RhanNlNFRENWh2RGFPQlhycTdlL0poZGpQR0ZUdzlseTJGeWloeVBvVEk4?=
 =?utf-8?B?WG5NeUIrOFhGMXhqVmhhanNPR3RybVRxdnl6QjRWZlVybDY5dDVhSUlCTUkr?=
 =?utf-8?B?dFpIb0o2ejBVN0ZGY1lFbUg5NW81N0JZUUVSVjRhUFl6QklkLzA4em9sT2VP?=
 =?utf-8?B?QW9zeFVyNnFySEJZTzJRL1prL2xRbkdIZHgvenpQaTdjNWs5MjNuVTVXWjR5?=
 =?utf-8?B?Z3hHSjBvdFNKZVp2SCtTdk1KTkxRNlJTNjIxQTBTdlRtVERMU0VlZ2Rtbys2?=
 =?utf-8?B?Rk1xeEhOamFsUnBnMUpBWkI1UHpHMjBlb2J5Wlo1cFdjQmdrUWh5SFBHdEZT?=
 =?utf-8?B?LzFlZDdpak5PME1iRXRMZVR1em5zOG1jbi80RHJ0eG4rSUZHSVMxdlRXWGNh?=
 =?utf-8?B?cy80QVBTSnNlUGwrTXMyd05Gb3liU3VSbEg3YjJEMHBNRytrT1dYZEJQZ3pM?=
 =?utf-8?B?OWRYRllHeGd1cjlFd1Z2Ylphb1BVL0RVQnBNSEVBRDlDZHo0VU5ta3Y3YkxE?=
 =?utf-8?B?QVo2NGV6UkxUQjRPNjU0MUdFS2pNbTFKTFlyNEtVeDBmM2tuUjM3YWtNZmNu?=
 =?utf-8?B?QkliTXBLVEpweUN6d01PTjkwTnZIL1JMdHFuM3VCOVZRTWdKSTZKNXE1U3FX?=
 =?utf-8?Q?u5Do=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5407d9-ca79-4cda-a801-08de005ccf49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 20:06:14.7845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmiAcvX5OJqQg8yN+Rmg1KTXec0J6wr0yHMYtzBVi5GmCY3iIdJOkPSpgumBUBtM/mQQpYqcf0dwPUM+YVGbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4186
X-Authority-Analysis: v=2.4 cv=TJhIilla c=1 sm=1 tr=0 ts=68dc383b cx=c_pps
 a=xEISQLFg+j67td7pU4ma9Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=SJ1ajRd0ObDbDZvkhJ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nM5y9CUu5FOUtjbsMjxCsuKIPFEK8-dW
X-Proofpoint-ORIG-GUID: nM5y9CUu5FOUtjbsMjxCsuKIPFEK8-dW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3OSBTYWx0ZWRfX48EXIHfx1Y8n
 7Ic2gPi+JPPcamCtSh8M8T8WkYPJ5S4qmwSNOPy4jSeKIg0yU8mA7/dTc+PpL48Lcz9bitWiilh
 WfqfHgS1yc8KU8m2nwaiUYuP1yuWBv93vu6KG9nHKKOiq6i1MplHzRj/we5ev+1al4fP5iOK6LH
 fL1G1cpIM/DN7ExvuutmDG7maBMHxCG1y4O2euDfQfMTeqjV/pXrhlNKqZVbl359A7rJY+7XxGC
 pjvgwgvoj4fZaMtqsTxzBLQay9TABkgEEnlbB9+VyaNaiy23aKGcRtPj0c39PvLWNElMvcjvpM+
 jLA5P2b91FtJIHaFW5acQdmISxNKDYIMf+6QtRksdNpl+yZCUjaTx6ZARnFYrksMIrvm9VnfObh
 /dshqKpms4EorJxOfLv8YJ1Sbu7S9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
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

SGkgU2FtZWVyLA0KPiBIZXkgQWtoaWwsDQo+IA0KPiBJIHdhcyBhYmxlIHRvIGdldCB0aGUgY2hh
bmdlcyBhcyBhIHNlcmllcy4gTG9va3MgbGlrZSBpdCBpcyBub3cgcGFzc2luZyB0aGUgQ0kgYnVp
bGQNCj4gYW5kIHRlc3Qgc3RlcHMgYWZ0ZXIgUGF0cmljayBmaXhlZCB0aGUgdHJhZmZpYyBnZW5l
cmF0b3IgYW5kIHJldHJpZ2dlcmVkIGEgYnVpbGQuIExldA0KPiBtZSBrbm93IGlmIHlvdSBoYXZl
IGFueSBjb21tZW50cyBmb3IgdGhlIGNoYW5nZXM6DQo+IA0KPiANClJlcGxpZWQgdG8geW91ciBs
YXRlc3QgcGF0Y2guDQpQbGVhc2UgZm9sbG93IGNoYWluaW5nIGJldHdlZW4gZGlmZmVyZW50IHZl
cnNpb25zIG9mIHlvdXIgc2VyaWVzLg0KSXQgaXMgdmVyeSBkaWZmaWN1bHQgdG8gZmluZCB3aGlj
aCBwYXRjaCBJIHNoYWxsIHJldmlldyBhbmQgY29tbWVudC4NCg0KUmVnYXJkcywNCkFraGlsDQo=
