Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE89C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F31427A0;
	Mon, 10 Feb 2025 17:48:02 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CC18A4279E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:48:00 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NICjF007889;
 Mon, 10 Feb 2025 08:47:53 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44pw2r285y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 08:47:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efKCHt5silCg1I2SvP+QRfk9aUvm3nmdWyT47xAbLkhW7leJnyAAyaG8sY5TEqVSh0PThOKJDKvEA/4iGhLsw5NU3HrYNXeDAqImk03i56yT6y+MF84178w67U/Ca9zvBf/+Trjno7wbpmOjUrMZxHlIHiV+RagItKupotacaQP1T07ZS414vbFopPDQg+R5ZOtaskef2tbIvz0iK6yQfItOvcRuvS1UDL6YY7wCBrTVHV/20M4dE7z7M+bOwORxwETQyj7Nxm3KNEkJPUX+L0csxE1mvQ3oA51ByZ8iMURrKYyVugKTGcf4IXod3sKo75f/EIcK8Gch3iqoeftT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOfdK3X3gfixA1kJ/FQJQROU6nsn76lKAYd0VQYEuvY=;
 b=XQX2AMRlMvY6gyqQCMMuZp19YteLBFeyDZMmXOvSA1iAumExbA2Dae4vbioAs76eTademnnpWDtiDcA/R/7DsE5o9cx8WYg+KVA158fkQtzsay9IjNp1JoCxh4DKUJdhqM2p6OwMaF7/QfJJdiD/RZToMygRxM39BPXvRs3cCI9plqxccp/lAwMbPHdGYpP/rmLs2oAmQ9Hl5BGQ3wVxlJtqqVV6Osex/8ZbBnOHKN/Dye7YWy+vJnkLc81chUCMSSPS6GTsNyPaUyokhbFgsGzLKfMOsVv51x0QI6WFZpjILiM8nHGlx46o1gDj0bq+wyYUGAPU6GWgta0AN4XpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOfdK3X3gfixA1kJ/FQJQROU6nsn76lKAYd0VQYEuvY=;
 b=o2NqxXY78rR7o5OoceiJdeJEdYu5rKp/jwP4vkUhLgjLJcyHUPRqdbLUrIs6GaIJIzhQdIiOXZyxgWFHxpHA5UHlrt9anHD2hrK9/2TUuD0wdOqcHa5zUViFsj72i1pVkWhT4XiDO3EkgW8FCVUsnoJDLNJ7lLHSCkgdeTgqJW4=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BN9PR18MB4329.namprd18.prod.outlook.com (2603:10b6:408:11e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 16:47:51 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 16:47:50 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "chcchc88@163.com" <chcchc88@163.com>
Subject: RE: [PATCH v5 3/3] test/graph: fix graph autotest second run test
 failure
Thread-Topic: [PATCH v5 3/3] test/graph: fix graph autotest second run test
 failure
Thread-Index: AQHbP73cNgUVpBu3h0mYUcOotazZwbNBN2jQ
Date: Mon, 10 Feb 2025 16:47:50 +0000
Message-ID: <BY3PR18MB478595BF492EF2FC60582944C8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20241114070432.3152188-1-kirankumark@marvell.com>
 <20241126044402.1209998-1-kirankumark@marvell.com>
 <20241126044402.1209998-3-kirankumark@marvell.com>
In-Reply-To: <20241126044402.1209998-3-kirankumark@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BN9PR18MB4329:EE_
x-ms-office365-filtering-correlation-id: b068726d-91df-4bec-98d3-08dd49f2a82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jV7vmzMn+L/C3qSionyK6Ckp1935mJvksyTGBu2KFXuO0rzLc/PuyWaxT/X+?=
 =?us-ascii?Q?/KokDck51krcoEnSFH9K17ytnn++0CajxX8yDASn7hgjU9LZiWWqZY76a7Wm?=
 =?us-ascii?Q?XRVZw4wkakaaGtwm9nnX03rCo/vs9xqAUpTRtC9c0s/uYkkFUHzvh6wBHRZ/?=
 =?us-ascii?Q?6NAWXSbvqX8XMMv/zoexTY8D8BC4HkXM5XRzACafvEnwW6TEs3mq24sUhc2q?=
 =?us-ascii?Q?4xaZfOw7ENJAdJcyOO/J5utbyuOgznpoQkj8HnzgPyUS3Xj2NdCzhtBrGJ9U?=
 =?us-ascii?Q?8mEnuekQT5HLHPCmtKb+IGJd63Uk/HvZdjh3gOLD2RhNHDUwDmkUZuc4pNkz?=
 =?us-ascii?Q?3TFqzEKyLQ0aR+iyr8tsYEhvI25VVkV+BXAlt8pqZ3Dnt+3cPriG6BHLf1aQ?=
 =?us-ascii?Q?S5aYg/UIQMRx4mUVq9hot2dawTCS+JPYH6h38bmCbqA+mD2I1tlHJhpR7UFY?=
 =?us-ascii?Q?G9dxMpoGV3q89mYFlZ6hYnhjOrPGrll8mBWdx64OOTT6TnCyqIyCOSKHtpY5?=
 =?us-ascii?Q?hbE7ZDB+cHyA4y57YlbGKI4oQNcCkmqi1mWZ+y1ubj9R3MHlAm33nXDGjZrJ?=
 =?us-ascii?Q?iRClURE4vzBpF5epGI1BmpFSezPTA4L7B1SPhfWIpMeE6OhMW9AAhAtUOVjg?=
 =?us-ascii?Q?VHkrlunDVOY2Kr+JE8K658re4FkQ2VQLetKQCz2YUTfiB5IEQBogP6B5LQnQ?=
 =?us-ascii?Q?IykX76/Q7QnMd+kgQO2BO3eBRIlOqJVWF+H1RZLZln1Ts2Yu2UY6rHYYLIuq?=
 =?us-ascii?Q?vn9N7Cs1+FmoKZvTWhlm/Jur8kAWjy/tHVgV5U/3JWTmF9Hk5UIzYhrLaq5b?=
 =?us-ascii?Q?PzDqPUksrGmH3jEMQxeA/NA38dYDFvgKpGA9OuNPjk411dHjpjposfNkJqtq?=
 =?us-ascii?Q?IsruNBD0an5YylpGnFzi+p9zC/OaBpUmPwe8LMede1l+mMRfoVIPzEkfUzm7?=
 =?us-ascii?Q?EufrWWYoa+mTvmAaO2AyOv6wUXC8qw7AtZ0Jf9qOw+TH+5OtFcoxexGJzLMC?=
 =?us-ascii?Q?bB4b4kVxn5NF83wvV4vQZu6CwLJRnZz+Ee+lHwUQlHTboRmQ721cL8sa2oD8?=
 =?us-ascii?Q?8+60gU0mW6aSAle5JgjiJy0nTAaIM49EmgHbatBKeZljZI0suj8tsh1OlKj8?=
 =?us-ascii?Q?rcDB3rJG5HzBG4wiN8Gy/gQKWL9Rl6bsVhCFVTMQMHGaV7T1MuQYx7qGK8Oq?=
 =?us-ascii?Q?3k6BHCLKFra30FvhGot+e7a1kEwXWypwo/V7NUa9RR9ASIZqnPlSG3oNU0ms?=
 =?us-ascii?Q?yor5W/oXJ5D3w1T6ORGBT1U/A/ggKHhg5JKA7/QmIOajf7sf3FcQwpLKiPLg?=
 =?us-ascii?Q?SoUeRTOKnYRgtCTgu9KbVW8lWQAY/cwFzQ2VRFSBHLMVAOSoAoV5Qas09UlL?=
 =?us-ascii?Q?HzJjrT32O/6gjNnUj6U6wcib27m483DgcK6GSldLNp93qguNKzrdyBZuF/Fj?=
 =?us-ascii?Q?E54KADhtzZnQUJq7ayQ9UcgbMtodmde7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0f+gn6x8gRm91/oEyT5K6apps/swDECO1xeE8HUAchMlpbUBmrNCN9i/6fd7?=
 =?us-ascii?Q?Hvypk+TDUjkQNOHL1Z5TNx3C+eLDFMs4GFsimewS6WNQ7kaIev76zLbBqfgv?=
 =?us-ascii?Q?+yg+UcnE5oq3mMxvwKPxd/9RJbfMCCm6DvqrHmjs3enn07hBiroka9zajA2q?=
 =?us-ascii?Q?6m8YgtUB8XllY3RPappi13gXsbAG3sWMcXv6esuWn82Vl5gNM3oJGJDVlqfN?=
 =?us-ascii?Q?ke9DHl20Rbh0V7tp0M6hB12tqQeinF/r1f5EMwoY/Z/BfeCv+u3GCQ1nwcmA?=
 =?us-ascii?Q?deAjWiqfMSUV9v0kZL2m+n3991xgZtf3/IsPaOzQqTXU1DbZv29bc76zq9Yv?=
 =?us-ascii?Q?gX/eP+L8do1lU6x8B2+zso6WEhF+tUSBZrQNypbr8I0QIYi2NH6vkEjJTV3o?=
 =?us-ascii?Q?8AcFBQu3MhVSc35yqG7Qq6PH8YuxtgSdmelTJSOrtJBTS1wzC3txF5lxthPb?=
 =?us-ascii?Q?vWMruw7MKURPV0RNhfBjD6udAHh+ozy2ADhz912TcXEG9S0+iWOmQBnrkhpd?=
 =?us-ascii?Q?2ei45jEDU26CRygdXvm47Olfh1POljVniYlCmzw6bz58X+bHKh9ZkZqztA1o?=
 =?us-ascii?Q?8vjJRirQuaht+JakCIz1/vjNSFDNna/P5Few2BCMt3Ame+2f36KkEs6TpbOL?=
 =?us-ascii?Q?+4I4Rt9nYp8pqRmQjJXh0uWrGPhWrvR3JoUtB5mSNMkKAAx7nLFmuSclAtHn?=
 =?us-ascii?Q?huqSHQo+GcFKK0/486Ku1GeantuKt+EL9fKXO1rzTh0YO7nlP7ZN3uxtCxJy?=
 =?us-ascii?Q?aukV3kpeJ4vrxJXfPvRBuH4JIdN4zP2xrRhuW4BKjpAXH7JJByuMrAIxfGGK?=
 =?us-ascii?Q?0DkymJbVkjwLAfetFNemzFT7AfVe9RjRMKIMkb2nsoLT6wiCzZ7i2zOtk7yT?=
 =?us-ascii?Q?GOg2AdpzTw3vuqNZoo4xZ5zLrqTa64cL22J1LGywbHRS1wkHPr1lLXD1L34z?=
 =?us-ascii?Q?WGPblRSqe43b1KsgQzwZ415RVuJN8IB7jpyY+ZSpkm+rObyHLJ9pAmiVcDb5?=
 =?us-ascii?Q?IOzLMSW9e0lo/Trtp5dzI6SI3jkU6DvJG9stijUuXLGE0yXfPxtWazpUcEL8?=
 =?us-ascii?Q?LoKAZKUmmkjLp/EMdS0nJxatKLhh/d2P4bxnKXBvK9zQ4M7XrTvgL40d5yRP?=
 =?us-ascii?Q?YayM7FOpd+EMB6H0lKRglfU9jgU/2THlVup6J1HH40HULQfOKmF2sKTQqgkM?=
 =?us-ascii?Q?rGMCNzmEpLfGaW0TQdrzH5GA1cQr6Mv6vof5FZHSC9ypLPjDyRDn21vXvhaI?=
 =?us-ascii?Q?FgnEPsRcaaNPPfA60G+Z96+A4RTTBXGwBinahqyywlEJ3pUlIRlgLh2XBn01?=
 =?us-ascii?Q?FuLxui5bg1y4xM25YEDk02vDIEckrto6bbWi+9iUM/p0+SyB9Ha6VjBB6T25?=
 =?us-ascii?Q?it1ntdKRS8zlkWcl5uUlak45esviUeKH1ipqdwqxBT4cc1y7ZFg9XFQWR5D3?=
 =?us-ascii?Q?Ac0gbdQVqcEwouNwf3Cfrv6LYDc0VpzVtgXOruSxjtbNRzTC0szZtxoEKOPh?=
 =?us-ascii?Q?vtLC9COR9SXEqWLxsCv9p7z2Oyi109UYmiEfU+506HiwUmCBkvDH0bO/yXAZ?=
 =?us-ascii?Q?qkIMHT7Blzp4D8WmUIThjq/+FGHezGoFd9VnwxP5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b068726d-91df-4bec-98d3-08dd49f2a82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 16:47:50.8915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4oxQBBT9lDmVOO76fCSessLTnaW9jvJ5WnmsM6uYkdQQmmOJg3pA9/zyO/EAZX5KRk6pOVRAIy+R8CAXf/GZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4329
X-Proofpoint-GUID: oY677bGx6RURoJnyaaL_oOIXrtD0EbSu
X-Proofpoint-ORIG-GUID: oY677bGx6RURoJnyaaL_oOIXrtD0EbSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
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
> From: kirankumark@marvell.com <kirankumark@marvell.com>
> Sent: Tuesday, November 26, 2024 10:14 AM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Cc: dev@dpdk.org; rjarry@redhat.com; chcchc88@163.com
> Subject: [PATCH v5 3/3] test/graph: fix graph autotest second run test fa=
ilure
>=20
> From: Kiran Kumar K <kirankumark@marvell.com>
>=20
> The graph autotest second run test is failing due to the node name is alr=
eady
> present in the node list. Adding changes to free nodes at the time of tes=
t
> cleanup.
>=20
> Fixes: 6b89650418fe ("test/graph: add functional tests")
>=20
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>

Series-Acked-by: Jerin Jacob <jerinj@marvell.com>
