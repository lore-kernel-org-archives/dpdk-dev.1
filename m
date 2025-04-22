Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270EC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 04:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE89402A9;
	Tue, 22 Apr 2025 06:56:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C913540299
 for <dev@dpdk.org>; Tue, 22 Apr 2025 06:56:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M1TJ0N014699;
 Mon, 21 Apr 2025 21:56:25 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46496qcpfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 21:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkpkcKIRa6hQzvNHu7neAHhkiRFEzYlUoTllnehJ5TfZQH2Vh37l7NxkvVqRybf5TNfubV1eslKoOOgN7pWEqeBKH5qbfZcsYGPg7osT4FEjma+XQlGbeTud+P1IKITOcU6lBzCwZu4RQTgKSc4pg1+wZpggPhghNIJLehxX7OuGsa2gcXSX4bq+HIvNsNsoiE7/8RRreUgszQOTAn6ThJVuyQZ1nnQWzNweTtMziohS9pUf3rYi/wAbXgdVtaCgAW7u56Ke4eAA+kUEdp0PNrebNBzPtGrn9iqZzBIIhwmjTgEolGl7WVgqtVbzqffiwniZPe3dK4qHSHHJ8iWXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O59FdXIEXKecOjA21Dz8kLdtMqXH/VbUAumpsnSa74=;
 b=hIoRjJHhlc98YG9AR56l1ThjQ+d0e4uOmwAXO9Z786WCgsWgre8FBWiAuRbl0cBa2XS3oANk2HAgRCjkXeu/0wi4nyJiCxMq6X+SQB2lPf19PvnNiYDskBd4uLbUz6YWsGwow5qM3tZvRe0GUEmkTRxPkjFOEQEAf7OpWLKLmDF/YzhgfdY2XYn9wnSXRplZDnaYJATVRudKWXmjFuzkqJggW72rxEb+XxhMGnpsOzs2vrWzphrrz3Bz+e5jlJXGwhhOpRpnZYIJuGtkBIlV91cTKgBRFiQKBIXwUPExeQUHfxxuKyfjk5DwTk8hu9/M0pRAGpnmyjlZA6+MVbzQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O59FdXIEXKecOjA21Dz8kLdtMqXH/VbUAumpsnSa74=;
 b=YTLASF/10K5wttKvuf+fllUtr9sIu/jjVuD70/9MpF4xS7sS5g42NHDZcSkWOh2hgaNfkyaTkjEUi41jhawBX3wQummPxQHNL2wJgH5Y2ByE0/Z4DRJ0HdV9nib85lpooE0Uyr9RI4WgMAae5LPCj1LpWab05xVa9fLV7gKvx+g=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by BL1PR18MB4245.namprd18.prod.outlook.com (2603:10b6:208:308::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 04:56:21 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 04:56:21 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] test/crypto: add test case for modex group 24
Thread-Topic: [PATCH] test/crypto: add test case for modex group 24
Thread-Index: AQHbsokh4kScNNEmm0KNl6aP48AjxbOvIJHA
Date: Tue, 22 Apr 2025 04:56:21 +0000
Message-ID: <PH0PR18MB46725A21348C76EAE90D6C6DDFBB2@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20250421064629.1743-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250421064629.1743-1-gmuthukrishn@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|BL1PR18MB4245:EE_
x-ms-office365-filtering-correlation-id: 82c24d37-27a6-42c6-62a8-08dd815a06a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?REc0dtRR+FVv5v/Fu77EXFPu2ZVsf8/8i3fdXYctueTuVUIjz5cywHpSWcZu?=
 =?us-ascii?Q?g2pXYgW9fiW45iGk+Q9PVykLQOa4yMBh0eQQ0MNZJaue5MqNqN0rer2K4Hp/?=
 =?us-ascii?Q?C0NoSYmWdYjR1T1UpAXThieiR50KJBKORzQcPum47vxvjdyljgZVBZZ4nq/g?=
 =?us-ascii?Q?sZ/5f6DS13ogEqj4Nt9NdC4kWFoNPHnwRl96FEMQ6KZUphJ0pXty0Gdn0HsD?=
 =?us-ascii?Q?04g7J97BR/bCbYbSO0hCwtUwnDQmD1qzmxV72fNDulRk3U+tVdjRaLOBvrl5?=
 =?us-ascii?Q?hWhgAvaOD5V9YO0DJ2O+WCoXv5usTLkoxy3RzWgZOWOnOKdVv1Lp/05hYXCJ?=
 =?us-ascii?Q?1KKBE36TLToU9KqglsUP4VFYS0nEZeEVnCMwxKo4T4z5VYn+lI9EJZtIHZqg?=
 =?us-ascii?Q?qTj77jjkEWe3gygvq2/T9Q3YAXi37lTnP3zPsPQ9ssXT/EcocNsahrtR4ps9?=
 =?us-ascii?Q?DJBjl5h3XIxdyWGxs9X5WF4NDFHp9iOP0zWgMYQ/YKLHRZbAHLU2rTOh5sn1?=
 =?us-ascii?Q?Jb+juH66mYAJ2xp47w+tS9NUWixto5S/hbvcxcdBA5rDSYUmzNXtEeTxPo8V?=
 =?us-ascii?Q?BLaZpR4WByZmffC3nX+DDbGKkNF32SuZqjMTGL21MKv7j6WQ1ETBxxUEB4RB?=
 =?us-ascii?Q?sEzJebR6pxoCn8pnFnXDB60uspLTSnilxwgCCOpRXSKizI4i3gU7ybxp187g?=
 =?us-ascii?Q?RTYFxyBxE1FMcYcyB0qJ7mHLSno2veY8pDH//E1eB15rwns8kLokCzHHA78N?=
 =?us-ascii?Q?Tvbkwbt7+FoZlR/ZN08eneWisl1So/N9gvnKwjRmgrLSIuLKEFl9xs7zn75Q?=
 =?us-ascii?Q?tZ+YKeF8P1YzSc84LAUXGsd9/qkgkAgVOnv4LqhwvMKmeTi6MKdBa4zLbK2p?=
 =?us-ascii?Q?97EmI6fsyyWqhMZspV7fuwa0McMUEOVcKhIEa6Uu9CS7c1zZx3Z433Id1nJx?=
 =?us-ascii?Q?Ok6f+SDkWQ8GyjkEAiMykpiQfeRlzNdjXawh6LF2E8IfYmQ01B+E/QpBNnud?=
 =?us-ascii?Q?6hvDxT4+nqeJHtAt0hwk0FQH7ckVgM+DtOzz8RkyOcRGFLz81Vw+r7Q108gj?=
 =?us-ascii?Q?SJDzTp2n8+KDtjrCqko7FqwBnuzvtGl0mqhOu0aqTZaHU7PIMKnU/B0vLcAd?=
 =?us-ascii?Q?PCB+QuPzuBupmwlGfKYGFPUyizI6cyZL1hlk3PFDBPaPdk/uV58K0FNIh6+W?=
 =?us-ascii?Q?ZH3kFCzkwJQN7V4XfhZtTIPN8FKhWKvBhyGIdph2+vWnmVaCCp1fQENs+i0T?=
 =?us-ascii?Q?K7BcvhIViY+bSEz42UdvQsWCZXxSh5OLs9lG4loQMkCQLtVS0K+Ql/QAC07Q?=
 =?us-ascii?Q?YJLvanM5HwCX5I5aXUbS8lbtsYrH985ODXq8t78ye+oB9OtiTwZjHU/DHvV7?=
 =?us-ascii?Q?+fGfSMcLktVGJbd2iEo4HspZ8yV0pb7nyb+KXKi35+llmSBntDytdKTTOM8L?=
 =?us-ascii?Q?zsysrtm+B4fBaPZ3xvDZfg24mB7uAq9TnZXMrWhH2XBle1DHhlbmcGQxEp0e?=
 =?us-ascii?Q?cE3ISjDebX+Z2CI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RU0hafMBWEgbetzH81iBtZyW1C3yAgL6BK3uCD5tzl+xacVGAPCSaN/HMllk?=
 =?us-ascii?Q?jmBKcqHolKzz5LRdEKJtSdUaTUtSMyGxpy9rG/xiSBaNxhhNQyhW4iWFtknE?=
 =?us-ascii?Q?iS9i9altipfanaw3wd3LkWdrad0vuD/aGmIOUykhgKhwNfcozyW/KsYJJZdL?=
 =?us-ascii?Q?KlIICy+zYJtRhsBHWJwyoEU6bcx1MfRy7Ap2MNougrjifLk+gVv3OUhKiEFn?=
 =?us-ascii?Q?18qTsPMUXEV/SSoehFMoylkyJBXv9LpaTwLd/05vB+ONZqknDFZJp63wu7z6?=
 =?us-ascii?Q?NB/kh4HjAu4yxGXLSyNsCfsK+sFYEGo4p9flemllbWbDylUk8JUAQ6qVisLC?=
 =?us-ascii?Q?e7/rrrgCTq1lXKQL0DOvXXuvT8lQm3cUqK5WeDgzrsUxdDdVWkmUc2IS4F7S?=
 =?us-ascii?Q?qYV5/sG0Nnt1ikip6Sxhejx1shQj2orVFSf3945Obh18bygTwH9VXPLlxAC2?=
 =?us-ascii?Q?6CBE6CgcOA2lrFge0yAyLEZTjmDohX4Ut1FAUbpxOTULKLrCVfosjl2AVv8f?=
 =?us-ascii?Q?p6ibHasmw1yErwjzjAq40T3f2TtrAyZKj1+gvCJw55Ns7ZUjiXZHN0ixazF7?=
 =?us-ascii?Q?z+qmLk4k/tRRnAQS/8qjjlm6oppnll28q1YS14tFQuiRzoHN06WBMYC6x7gg?=
 =?us-ascii?Q?s9iIoCbWkR5g5zyIxxi/3L+ZSDdYO5zg2gyGXgwP4S2U4cUacrAHITgzRQrO?=
 =?us-ascii?Q?A9d4f+x8pLCnOZb/ex6B1wiVElzcutk3SuTuX5sp0Vi0DkeqPlVW3hjpYl7f?=
 =?us-ascii?Q?W4KMP3gXSzyT6kGx+5QSOhDa9FbU6ayEJ9KwzhLsaH9yZ2N88B718u1NLVWm?=
 =?us-ascii?Q?ZaDVSDadckwq+OOf13NiFGwqcAJJOBDeitokguDRXn8Hh8M7EbTAmK8XWSY0?=
 =?us-ascii?Q?bbQqfq/nOjf1D5sjKiBxbll0No0NPfjXrxAGAq899wMPP2Q+n8/7+FZA9RP0?=
 =?us-ascii?Q?xSn8AVlD2W55PpHDkN7DyQ0uVaDKL5/bOWbvYV6WtzCI+aFE7anV/xHya3JJ?=
 =?us-ascii?Q?YmZk6KRuxMghYc2TV1JZPvhX6su/1E1hQB/3TUddE3/aKz8J8mGZQ6h1wsbI?=
 =?us-ascii?Q?pUuJ/9DoPRlYiEhbb1dE/Idqwx6F9a/3hnyQwUZ3m2c2x+MTlMgTg7mJvyxy?=
 =?us-ascii?Q?ecCo+48Ch9Gxl8rTOzvmKbNnFuHuigKmB0UJWu7OiyHJ8TNVofBUwS5OG1V0?=
 =?us-ascii?Q?v13wF0Dpx7dVtedCop4pzlayVFtbPTUmIw2sdN73NYwEemn72xE5xO8y1KYJ?=
 =?us-ascii?Q?D79zzJcLWxK7yxJg0nj1cjvyWGlZda2pzcn2/nOvrVBeRI9vrb1rN27G8zvx?=
 =?us-ascii?Q?AOxit5VvAS/GBOBNyCmGbxOYQY5NSPhxWVLqhL4u8kxKK9SCJ3odzT5pVpOV?=
 =?us-ascii?Q?Cp6PxWp9WBx8qsllhUrDaq1lWzpdcMV0Ms03IKRsIDIwr6jUP2lWTr4ImF6L?=
 =?us-ascii?Q?eeiZJuVURu8ShiSz8nmByeMp9HUO9nMUMjUYfjTFyqtBK5hJPvF28ZTFXyd0?=
 =?us-ascii?Q?nUabg5CY2DsZ+Y9Wh4L98jdUqhUPRbn1RzdpcD2ZMMRt41p4KvJxdRzbapIq?=
 =?us-ascii?Q?rq3R7zSPH+U1EMlN4z0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c24d37-27a6-42c6-62a8-08dd815a06a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 04:56:21.4645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BYhP0phmG84kflKTJ4GiEIIWqvqEmO0EXJH83V1b7/O7v0VHMd4k/AB0N2XWjX7M1y3Gqk8d1aGsWBdK3Zbvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4245
X-Proofpoint-ORIG-GUID: xN0JzNo9gdH_cYreN08AGpvR52xO0HKz
X-Authority-Analysis: v=2.4 cv=LoiSymdc c=1 sm=1 tr=0 ts=68072179 cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=cj3rNB23CWmxVBcjK5gA:9
 a=CjuIK1q_8ugA:10 a=OXoeHldmKWcA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xN0JzNo9gdH_cYreN08AGpvR52xO0HKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
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

> Subject: [PATCH] test/crypto: add test case for modex group 24
>=20
> Add test case for modex group 24.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Acked-by: Anoob Joseph <anoobj@marvell.com>


