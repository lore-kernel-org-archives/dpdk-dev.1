Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF85C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 11:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 045DB4025E;
	Fri, 30 May 2025 13:08:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 34FD74021E
 for <dev@dpdk.org>; Fri, 30 May 2025 13:08:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U4PULt009121;
 Fri, 30 May 2025 04:07:52 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2111.outbound.protection.outlook.com [40.107.100.111])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46y5mu8r2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 May 2025 04:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e57osDTp6Cmu6IpF1P21XahaY6hn4cogohk7qaK+GKVTd+mQnEmmF0RZ0SUrxgITvpJ5BjDVt87534sCG4wEqGs8+da0MkLT0P0EB4RiTwk1YqbSM3CI4vAsFDaGm5LqbNRypMiPMH6JZI8otPbxK1RIbMdcYPVmhkG3FGIxtqgjJNX3j2Dj8W+Hgh3klSRihH62r9qL5tq3cLgmZ5BDqndUaMFRz9GpBdQMzxlRBox37wRn7QZ+pJUj9ic9WL6PD6PEPUXWKh0TQjTwV4wo0wYxCAkrTJk69OE48cfTaXsSbXcq6fKMZrTrYYxzZJLBsOEgNPQeCQ4lPju61fwmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6JQCWpbhq+Q6+sIRK/RvbBbTE/UmJ9UDPlIB9/k9RE=;
 b=rgk+P5tAImu2n65krY6EwD3/hlm4VkJSIIcNyvSxLPT4eluHU9SHMHJzU+ps3AMSpJYD1hbinsf2qqC7Pp28owIsD/+vRwZ3yrSDiVsnn9kfRnFWMeqAMOmk0wt4FmqL/A4e0RjVoiZb0kCdez2cFa6VVICBMZZWiHH0VpWczdJfFZ511Kg4oXR6nkUlYSOlDFtAl/JB1xfP53kfj08g2i9BdYxAdI6+6H/7jybLmoo6mu1yJf5S+UOuJkWDgNjRuYudkf01yKzgT3MKowCPNK572yhjjUviYjEWgpyRSZV+VUH56JFzUmiojiLoV4F/pZx81UeqDl2esYmBsxZDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6JQCWpbhq+Q6+sIRK/RvbBbTE/UmJ9UDPlIB9/k9RE=;
 b=iD8ze69wzSkiZzVApgIJ+x7VmMS0RTRYS4QkaVipnmGp29oN/aC+OMzW+gOxUG9RdWhVaGh1ItDmdVJdPYUEEHbVaZRX0jN+2kCOnX7qrRq4WkHOdEa5StttQl0pkFSaS0OQ6ttHS9NM2nkUq8livBX8rvrXQw8sJYNeuX5ffgI=
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::68d) by PH7PR18MB5202.namprd18.prod.outlook.com
 (2603:10b6:510:15d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 11:07:49 +0000
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052]) by DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052%4]) with mapi id 15.20.8769.019; Fri, 30 May 2025
 11:07:49 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v7 1/3] graph: avoid global node ID counter
Thread-Topic: [PATCH v7 1/3] graph: avoid global node ID counter
Thread-Index: AQHbvYZghl9olwKK7UeJ6rddp3jUk7PrKksw
Date: Fri, 30 May 2025 11:07:49 +0000
Message-ID: <DM3PPF17CE793AB453C9313CD9B479463FDAC61A@DM3PPF17CE793AB.namprd18.prod.outlook.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
 <20250505062422.588450-1-kirankumark@marvell.com>
In-Reply-To: <20250505062422.588450-1-kirankumark@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF17CE793AB:EE_|PH7PR18MB5202:EE_
x-ms-office365-filtering-correlation-id: d3635773-5d62-4175-dbf4-08dd9f6a36df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3JqMvrjdNwzBibw0VOYpT0kvhXYN5Aw+P1WaolZSEp46Avija5VDxVPjvLoY?=
 =?us-ascii?Q?7JR0+3BY6hbU9R2CTthS+7V+8EQHmMv5sYXEQNzd6Lhdpa5lFYu4N1LixtM/?=
 =?us-ascii?Q?4gs6Ysajb/PalNb7qNarYc+jkYpfNRmTo5bCSyNvsMFVkIihUeYksmiMCnVQ?=
 =?us-ascii?Q?9nsTuhYJDZJartCctjjZD7vizwTnk2X2fsrBO1eshmtC6flh3chBLQMYPvvE?=
 =?us-ascii?Q?vq8e/gwIFsiZRJ58UBwcbRKxetCfPQWb8RXMkUX8noyNf2FLh3h7V3ZZQRcx?=
 =?us-ascii?Q?BznI6JylZ23dmbAXfLd9OhNXvS0vb2V2gunteRovxdQiCOVnPC+i6Z+bGA9z?=
 =?us-ascii?Q?H++IBbH+UMteR5safKUeOoHm+eB262KL5DK/+x6HEZzG80FnM6szpXrDWBKH?=
 =?us-ascii?Q?wHkUmCIDRZ86SkIux1odlugqzVQrQKrJa6QpzMHvsHTT0zkNyPLFmmpH3HUp?=
 =?us-ascii?Q?PW+cvK6gXzxjcb9eoJLKE8XRmMBaHdcb0lPw/DyTKv08XmI3kDjYaQPjGw2n?=
 =?us-ascii?Q?8TxkLTo18SHiBSlMSTelD2Opk6qY83yR+uuw/mc0UEd8rc2A9N+ngebwASYD?=
 =?us-ascii?Q?lpALw9ovctqqoPfPaX4+zM0WEjFgzeJ0JbSVC5gqgyl4hhp+sL3IU8k/RFgS?=
 =?us-ascii?Q?EctB2Ou3iP+1trMrRUFlmj/3oZjSq5JvS8m5du0yZe4JKbDIvFa+Lu/FZEUR?=
 =?us-ascii?Q?1ZzQWkSPu2MhRTqa8s1hn5WX5mkqwZNcSN5KYKg9GrtiVlaQIUVquu6WhuQZ?=
 =?us-ascii?Q?r1E1ZHiAuptasUbeKk0k3AFsr90HLCdyT5GAg2/oT8HNnToFKeYVynd2O/1S?=
 =?us-ascii?Q?604Xbrg6OiDMOXYQMIXYhrS8ZFph0/YADcCpVK9b5yGlmkKm7v6PG6l2cHkY?=
 =?us-ascii?Q?48KpvtDLXRsaO7V/wbwGhLhZO94emigUNYLlJzSl6XVT+fDbONUIxATfYiP0?=
 =?us-ascii?Q?/yC+Q9Ke/vr2yMVniAiVkFWzr2dzBEyWYmUL+jj+4aNIFR4N7wyUSofMwg83?=
 =?us-ascii?Q?A8uYBL8dY+NLcmB9fWMrYhLuOeryedt4dd9t7IByx9KHNHb49lDAxSEhiwJ2?=
 =?us-ascii?Q?EzfzuFm/xLTKN2Po5arF6Tvr11HiLmCQ6htWsr8YvdtPAqZBsXguJL2J2m1Q?=
 =?us-ascii?Q?7uWFh2FBrQD9WX4CYQ4gSFFC0eifppHktOGBcFa1wP85jHMI38EBE1jFtVwm?=
 =?us-ascii?Q?B4EW8CZtUAvb/vgYqHQTXYB0D4Tp5BO2r3qJ2r6sdWNdGhcRdHip/ks6RIK4?=
 =?us-ascii?Q?JHP93t/7FJa7JaYYQjpu4I3MZA4/JDJF7VDi3FemENbDxeSEYPn8mqcWXf1v?=
 =?us-ascii?Q?ipt4dmwAEJjC11PGPVQkMxIqJ+wXldADC5PC7asYvm2+YdQj2osBUZqyFxEH?=
 =?us-ascii?Q?X+5GO3QWMCsLXwybllvB7oWKXTrgSsbHfgDn+uQ6NDjjWNx90l4z2ien5ZBl?=
 =?us-ascii?Q?/nM6tTN0P8xUC5mwJIO1WS9Y8yamxOyBZjGtdiJm1EfTMtD2XZVVug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF17CE793AB.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f7p0ZG5spuHKNYh7lMXGKddCLIwgNYzWxU/OMjMIi3fHZQyB+Dg4iO41slpR?=
 =?us-ascii?Q?V5dwBuZEnFK07h0DxlM294uoUC7u1eR6j/4B5L4BScGOKtx1w54ET02coKNJ?=
 =?us-ascii?Q?cY/7NW0aZvjdH2HwPBGELEXl1wmqCR8ljYOBQMuyngs56bYFAeCx4NotmsLa?=
 =?us-ascii?Q?Iaw7l5nOQd1ommIDoeHpAqb3svwy9OWyW8giNx08+ooa5iLTM3WUdQr9eAPf?=
 =?us-ascii?Q?Le/abGxaubPKSL1C6KVSIzi7/dLfIaCQnhfi+HAcUxB5Y4cxjhpAMn3/Hlkc?=
 =?us-ascii?Q?M9uZhQDorOfZ+KGW8a5QxOYX0bIGDxPrWIPd7XXYtAETNFKskG+I5A0PpmiQ?=
 =?us-ascii?Q?Kk1NhxnCFEhuSsCFp2/6vNg6C9kv+bW4Uk8XQf/qmVu1u3czdpMbvLaaOjiy?=
 =?us-ascii?Q?0nyzGQukIoEu0RrqJ15ZbgramdOtmICISWywpP0ogNvlMPDJG1PSIrXbQmoB?=
 =?us-ascii?Q?1L/UUCJtnxu9SjN/DVWRoIboUb8A/cTSjyBpvut/XZQ9guyZMeJNMLU386wo?=
 =?us-ascii?Q?gDjpPgnY7zKascjcFBtT8bLKgsc+J9/UO+9WHIwhli2U/KbJCHn3924YnfHQ?=
 =?us-ascii?Q?8yGQwGL+bGkuRYekyA76kUl7lWWh+JZwS4u/8yhqhka9QYYOgm2ZiphI8PPe?=
 =?us-ascii?Q?Zx6YTijrZJY1j/ZjK068AlIQUH5xDUAR5HI8+8cBdHNQqIceG8uiG0EPY1pW?=
 =?us-ascii?Q?+/BArKjP/uIjAb0+b2WO3wyMBiKCdE5fKjLQibS6cSaRcBcGXJqW0fivIGKH?=
 =?us-ascii?Q?9xnsWFo/yHWYNN6kkyV2me1ipUU04TXXA+jMgqGiAvnQ2S6adGpjEzD2mDiA?=
 =?us-ascii?Q?h84uLvmUtbhPnZTSExtOhvEMg0QE7BjDev+TJJ+97hEiNdUiXnksilaPe55M?=
 =?us-ascii?Q?JNI2KVY4MHYbk3HkbG5DuHafRuHIgvQOoFsBBLiTlVJJceg4wp3uOkMa4sCx?=
 =?us-ascii?Q?aUNtXxxFIdamM8KV1IIoSSupE5ag62b3SDgSRBuBoDYX27OwgdrKUEK/83wZ?=
 =?us-ascii?Q?g2+UHYAibfZgXR2+9/GGGMTOG60CoM+Z9d2PpcNT7eqOe/pg9P+2bgrT66Yu?=
 =?us-ascii?Q?F5T5xnaNkm9UPJYaKyjWeZpzn09hlBarffpgpKJKsGULDb2RXpUMeTXfvYRP?=
 =?us-ascii?Q?Ci7G0hCNg0zqqgBzL1gyZXtYsjmDBx2UdnYbpiIaP+wIYrBUZbkP6cflQ8z/?=
 =?us-ascii?Q?w+7lh6z83KJ+niRSrAy7pFXIDJJ8ZZUqL/azNOdN4hvQARZNoEq8BTbr0mMi?=
 =?us-ascii?Q?Xd4oDUqXSTbk2Ni+taSiclo8x8p/c4dCvepfGbB+vHbHbS+BAw8DkdU4RnN4?=
 =?us-ascii?Q?qvhErOc1o2m/17VysUqPAH/lTNsWAxnmo1zUowwTC1efXP1JpVh6AOuCpab1?=
 =?us-ascii?Q?GCgEbZDn/UH3SjDOk5dXFV2YgONjc4NE6X4HoA3Q0Dvd/HtTNvSPArmMt+kK?=
 =?us-ascii?Q?fscoM7PSzXqvyLnVsiYVb5cujrjHChVfdwfvzmyeYZK/BAFZ3Wbd5SltGQ1W?=
 =?us-ascii?Q?6oGZX+7BNHPdbOdDaAZYy2gNR6dSEWRPRRS8cSdOltwuB2UgBz0ag40xcUrn?=
 =?us-ascii?Q?UawWkupeyBYOfhxU1Tp5jvZdNQYq0ZPoZPm+Daq6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF17CE793AB.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3635773-5d62-4175-dbf4-08dd9f6a36df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:07:49.2147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYE6mZuSOtHjrfvT4iO3zqGoc6sGqyCRoaZWzSU71pTu+TGNbUkTznDMgbZq+3E8F9qGzo4oIyUqJW4P8NgttA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5202
X-Proofpoint-GUID: 6DtlKx6Bv2b0nkUK4aM2IfsG-do4fmvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA5NiBTYWx0ZWRfX/eUJysckuKPs
 GSx7SLOezalyM9tT45BrakFVmCPCDKCPTUJnHY/y1Cd4MiJwTI1KpCNQ++w9rDo7Gq/+3qn2Bv2
 1gozCWvYwr1Lb/l6qXWrHA+su59uGcn0rHBqLI4mRgHN6wFw7zaoI9cNVHzdDPIebknH+rLuPtU
 C0b4uXZbHkJty2UMfT98XjjsJX5uhawfJoZYpm/J8UHJj4E44TJPP5z77/Gli0PoGvBZtMxpQLh
 IHwvs5JLFlHCOqOvdJTuiFPb4KEGRbQzfvaPdXhYLs4kR41o/2vOBDtzOD7CgP2pbKmT6Oa0B2R
 94rjKY7WNO4S+wdMg8d5diNMH7YsULdGicsWp/FIvaiB2MKEFplCB5h7C7D0UAxgWDdg433spkJ
 oaitD3eo78hNUUl79Y6pqPhUDv/b94QIddWIJ4AjPPh/JI0dh7z31pxVELYKHuomfdW+CGLq
X-Proofpoint-ORIG-GUID: 6DtlKx6Bv2b0nkUK4aM2IfsG-do4fmvc
X-Authority-Analysis: v=2.4 cv=OvFPyz/t c=1 sm=1 tr=0 ts=68399188 cx=c_pps
 a=bAeXHJjZkRTLwzvh8qItYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=8rWy6zfcAAAA:8 a=dwPmDu8uqmBhdjTsj-YA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-29_01,2025-03-28_01
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

Hi Thomas,
   This series has been under review for a long time and has been acknowled=
ged. Can we merge it for the next release?

> -----Original Message-----
> From: kirankumark@marvell.com <kirankumark@marvell.com>
> Sent: Monday, May 5, 2025 11:54 AM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Cc: dev@dpdk.org
> Subject: [PATCH v7 1/3] graph: avoid global node ID counter
>=20
> From: Kiran Kumar K <kirankumark@marvell.com>
>=20
> The node id is determined based on a global variable that is incremented =
every
> time a node is created. Adding changes to remove the global counter. Make
> sure that the node list is always ordered by increasing node ids. When cr=
eating
> a new node, pick a free id which is not allocated.
>=20
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> Acked-by: Jerin Jacob <jerinj@marvell.com>
> ---
> * V7 Changes:
>  - Updated Acked-by
>  lib/graph/graph_populate.c | 11 +++--
>  lib/graph/graph_private.h  |  8 ----
>  lib/graph/node.c           | 86 ++++++++++++++++++++++++++++++++------
>  3 files changed, 82 insertions(+), 23 deletions(-)
>=20
> diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c inde=
x
> 1e6b08319e..026daecb21 100644
> --- a/lib/graph/graph_populate.c
> +++ b/lib/graph/graph_populate.c
> @@ -78,7 +78,6 @@ graph_nodes_populate(struct graph *_graph)
>  	struct rte_graph *graph =3D _graph->graph;
>  	struct graph_node *graph_node;
>  	rte_edge_t count, nb_edges;
> -	const char *parent;
>  	rte_node_t pid;
>=20
>  	STAILQ_FOREACH(graph_node, &_graph->node_list, next) { @@ -
> 94,8 +93,14 @@ graph_nodes_populate(struct graph *_graph)
>  		memcpy(node->name, graph_node->node->name,
> RTE_GRAPH_NAMESIZE);
>  		pid =3D graph_node->node->parent_id;
>  		if (pid !=3D RTE_NODE_ID_INVALID) { /* Cloned node */
> -			parent =3D rte_node_id_to_name(pid);
> -			memcpy(node->parent, parent,
> RTE_GRAPH_NAMESIZE);
> +			struct node *pnode;
> +
> +			STAILQ_FOREACH(pnode, node_list_head_get(), next)
> {
> +				if (pnode->id =3D=3D pid) {
> +					memcpy(node->parent, pnode-
> >name, RTE_GRAPH_NAMESIZE);
> +					break;
> +				}
> +			}
>  		}
>  		node->id =3D graph_node->node->id;
>  		node->parent_id =3D pid;
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h index
> 813dd78b9d..3529640abf 100644
> --- a/lib/graph/graph_private.h
> +++ b/lib/graph/graph_private.h
> @@ -29,14 +29,6 @@ extern int rte_graph_logtype;  #define graph_info(...)
> GRAPH_LOG(INFO, __VA_ARGS__)  #define graph_dbg(...)
> GRAPH_LOG(DEBUG, __VA_ARGS__)
>=20
> -#define ID_CHECK(id, id_max)                                            =
       \
> -	do {                                                                   =
\
> -		if ((id) >=3D (id_max)) {                                        \
> -			rte_errno =3D EINVAL;                                    \
> -			goto fail;                                             \
> -		}                                                              \
> -	} while (0)
> -
>  #define SET_ERR_JMP(err, where, fmt, ...)                               =
       \
>  	do {                                                                   =
\
>  		graph_err(fmt, ##__VA_ARGS__);                                 \
> diff --git a/lib/graph/node.c b/lib/graph/node.c index
> 101981ec24..53a3f3f2d4 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -16,9 +16,56 @@
>  #include "graph_private.h"
>=20
>  static struct node_head node_list =3D STAILQ_HEAD_INITIALIZER(node_list)=
;
> -static rte_node_t node_id;
>=20
> -#define NODE_ID_CHECK(id) ID_CHECK(id, node_id)
> +static struct node *
> +node_from_id(rte_node_t id)
> +{
> +	struct node *node =3D NULL;
> +
> +	graph_spinlock_lock();
> +	rte_errno =3D EINVAL;
> +	STAILQ_FOREACH(node, &node_list, next) {
> +		if (node->id =3D=3D id) {
> +			rte_errno =3D 0;
> +			goto exit;
> +		}
> +	}
> +exit:
> +	graph_spinlock_unlock();
> +	return node;
> +}
> +
> +static rte_node_t
> +next_next_free_id(void)
> +{
> +	struct node *node;
> +	rte_node_t id =3D 0;
> +
> +	STAILQ_FOREACH(node, &node_list, next) {
> +		if (id < node->id)
> +			break;
> +		id =3D node->id + 1;
> +	}
> +	return id;
> +}
> +
> +static void
> +node_insert_ordered(struct node *node)
> +{
> +	struct node *after, *g;
> +
> +	after =3D NULL;
> +	STAILQ_FOREACH(g, &node_list, next) {
> +		if (g->id < node->id)
> +			after =3D g;
> +		else if (g->id > node->id)
> +			break;
> +	}
> +	if (after =3D=3D NULL)
> +		STAILQ_INSERT_HEAD(&node_list, node, next);
> +	else
> +		STAILQ_INSERT_AFTER(&node_list, after, node, next); }
>=20
>  /* Private functions */
>  struct node_head *
> @@ -118,10 +165,10 @@ __rte_node_register(const struct
> rte_node_register *reg)
>  	}
>=20
>  	node->lcore_id =3D RTE_MAX_LCORE;
> -	node->id =3D node_id++;
> +	node->id =3D next_next_free_id();
>=20
> -	/* Add the node at tail */
> -	STAILQ_INSERT_TAIL(&node_list, node, next);
> +	/* Add the node in ordered list */
> +	node_insert_ordered(node);
>  	graph_spinlock_unlock();
>=20
>  	return node->id;
> @@ -197,7 +244,9 @@ rte_node_clone(rte_node_t id, const char *name)  {
>  	struct node *node;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
> +
>  	STAILQ_FOREACH(node, &node_list, next)
>  		if (node->id =3D=3D id)
>  			return node_clone(node, name);
> @@ -225,7 +274,8 @@ rte_node_id_to_name(rte_node_t id)  {
>  	struct node *node;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>  	STAILQ_FOREACH(node, &node_list, next)
>  		if (node->id =3D=3D id)
>  			return node->name;
> @@ -240,7 +290,8 @@ rte_node_edge_count(rte_node_t id)  {
>  	struct node *node;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>  	STAILQ_FOREACH(node, &node_list, next)
>  		if (node->id =3D=3D id)
>  			return node->nb_edges;
> @@ -310,7 +361,8 @@ rte_node_edge_shrink(rte_node_t id, rte_edge_t
> size)
>  	rte_edge_t rc =3D RTE_EDGE_ID_INVALID;
>  	struct node *node;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>  	graph_spinlock_lock();
>=20
>  	STAILQ_FOREACH(node, &node_list, next) { @@ -338,7 +390,8 @@
> rte_node_edge_update(rte_node_t id, rte_edge_t from, const char
> **next_nodes,
>  	rte_edge_t rc =3D RTE_EDGE_ID_INVALID;
>  	struct node *n, *prev;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>  	graph_spinlock_lock();
>=20
>  	prev =3D NULL;
> @@ -373,7 +426,8 @@ rte_node_edge_get(rte_node_t id, char
> *next_nodes[])
>  	rte_node_t rc =3D RTE_NODE_ID_INVALID;
>  	struct node *node;
>=20
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>  	graph_spinlock_lock();
>=20
>  	STAILQ_FOREACH(node, &node_list, next) { @@ -397,7 +451,8 @@
> node_scan_dump(FILE *f, rte_node_t id, bool all)
>  	struct node *node;
>=20
>  	RTE_ASSERT(f !=3D NULL);
> -	NODE_ID_CHECK(id);
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
>=20
>  	STAILQ_FOREACH(node, &node_list, next) {
>  		if (all =3D=3D true) {
> @@ -429,5 +484,12 @@ RTE_EXPORT_SYMBOL(rte_node_max_count)
>  rte_node_t
>  rte_node_max_count(void)
>  {
> +	rte_node_t node_id =3D 0;
> +	struct node *node;
> +
> +	STAILQ_FOREACH(node, &node_list, next) {
> +		if (node_id < node->id)
> +			node_id =3D node->id;
> +	}
>  	return node_id;
>  }
> --
> 2.48.1

