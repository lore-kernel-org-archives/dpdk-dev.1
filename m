Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7FC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:36:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4038402D8;
	Wed,  4 Jun 2025 13:36:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4EE4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:36:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553NUhLD006902;
 Wed, 4 Jun 2025 04:36:46 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2104.outbound.protection.outlook.com [40.107.220.104])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 472as418t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 04:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfeIc79gFKTb6ZHI1IMyR++9Ze9wbpdEGDieU78Unj0ic+MqqpplRf5iNhb1eC8pRz9X+9ZeJSp/Znd1ElwZxhh3Uc6N1CXN+/T4/iFIAmYjwJzdFAawTtVezv40PVdZHF9rX+wEiVXyGAOXcA3/XLm+0t8HqHyqBu7EuOcknDVMu0cMvjztOkmRvJObu4hKh0CWWXwuYsO4i6EV2LG/8ZeUOFgVkAKZQ9AB+IgGzYrzJJ+jnwKJVpDW5vLiwtxc1mOGws/j48Etx8BEJD5U/ZeXXDEU4zV4mh7NzUNPiY5FERVmzZckLWiN5620lvr3yy4+PlvjXd32mPS+49DPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0i6LymQVRB5IpLuB2DfNweEpWFrNEejXgNJs8c26Yw=;
 b=KSXCEs6M7xc5NEVhBgkNl5j57aCfOVgutg8GNK+sRzzj1iwPAu1YpaX++HpYgjeJDI6qY9cjPqV7bFR3tvTGuN14C5WEWJ8enTfT5T3/9ylqyPTvaGIfZbJ7u7KtzRM9TnQhGe2XU+NZrFeROO8nWSIariXHXawadanGnKEyEEdZq02neb7dvlK8kK3s6tbzExSFA58oPqYPv+KUQ2MVAg+EOoatOltO+HKjBja0hM1u+uisll4ClG5b7eOvuH1DBYJaBrijZY1RqOCuTJTlX2L/+TuV3DQBtrxi9SEx2TV2wAF89wcIL6e3KhnZ/lhsPAaHjAn87YIJcyapNbUggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0i6LymQVRB5IpLuB2DfNweEpWFrNEejXgNJs8c26Yw=;
 b=jmDV+A9+WcsGwuUxw8QDdOIzkqEt9t4vO6BC9/nGh4J+08F9hJYgY8lUHG4Zp5qbnd9U9WVNlvda58/1yG4ELiMgKtDTcNCjss/u5KkedlmrZsQHL7wAWQQ0eFAsE0t7i36uvi1BYVZfGsLqboeAD+SmXozgrBULgu994aOxrRM=
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::68d) by CH0PR18MB5482.namprd18.prod.outlook.com
 (2603:10b6:610:18e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 4 Jun
 2025 11:36:39 +0000
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052]) by DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 11:36:39 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v10 4/7] graph: add feature enable/disable APIs
Thread-Topic: [PATCH v10 4/7] graph: add feature enable/disable APIs
Thread-Index: AQHb1TlezWQqN2YvOUKtJl6gVYZ4QLPy3dtw
Date: Wed, 4 Jun 2025 11:36:39 +0000
Message-ID: <DM3PPF17CE793AB02EC69BFE7CB25E94EB3AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-5-nsaxena@marvell.com>
In-Reply-To: <20250604101259.4181992-5-nsaxena@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF17CE793AB:EE_|CH0PR18MB5482:EE_
x-ms-office365-filtering-correlation-id: fbd55024-3558-49dc-bcfe-08dda35c1241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Hz+0BFHFu1Bv0x0URXANRCUWgVIYG6HwFfleOda2dYmfLk/qHxGx90Iy8d9U?=
 =?us-ascii?Q?uOPeKZKqYKlMuNtWxsJ904h5FmF/KFv2BdDqnaymMMEsdCTcx7F311K0a+GG?=
 =?us-ascii?Q?9+c7GgSd9BiISICsvbU5sEd44ONqFgul+xoFWDE7FhjKxI/71N7VeLcrpZCl?=
 =?us-ascii?Q?lJTpnJlCE7UCXBZHDRS4DR7Hd+9EsmFD9wslabFddSOd2QTKQvMp5rMtwE68?=
 =?us-ascii?Q?bCSEdDFlVPCEEAzsYtZEjd+VmQaRp09wNJ3/6cYYNmsm9VSy+bVplCcv8ebY?=
 =?us-ascii?Q?eUCtKbYZ5NJjaWZsH6AbvQbp7Gpdi3Kb/I72EHRsZPgkovqYNe/iKXrWpVNp?=
 =?us-ascii?Q?tcOIrGNo1/UKtkQ7rjDjgtiNrCaM1zcNgA68YdqggSNCowzX1wXuBvOdLbLl?=
 =?us-ascii?Q?Lf3CeOZsOEDZhMKwLdCT/66rVPyIKIMZndJdSWwLkDtCy5eGPzkNPlvAAcBZ?=
 =?us-ascii?Q?boSjZIfJDvnB/mtQGmVrZpHTB4vPwg0hddtA+nH9qkCH9QrP7jyNaSoaFn9i?=
 =?us-ascii?Q?YRq85j1f6rJ6HJOyyXtksL/qqUGOP4OBOVgpLuo00ldI+J8i/knJYIxtHEp7?=
 =?us-ascii?Q?wISzj42LUeLRJm4AhKBaI/g0I1aCsOL1oBeAJNuL19Ny8/lgDgBdLZ3JI+32?=
 =?us-ascii?Q?byJs9AKYWDZej5wjcsVvPyy5xISdFGVib7CSRM5nI8pQWIKmP9RHBjrb/WCr?=
 =?us-ascii?Q?X1qTMhIU88zP/wHU3hACATsNSviAwJ/RzFZWYOIWsd9fDWQWnfr4vZTO0bZS?=
 =?us-ascii?Q?NzJFUeTvE4bujrj4wm0/FZAJbdfauDi6b687HPbvEtEJoyhHYqvMhG7Vdibq?=
 =?us-ascii?Q?P6d2TQGmUQDEpdLc3vx9f8rgBRAc2dOLnOqRB3eEhuSSJacQTpvQZKTvRok5?=
 =?us-ascii?Q?aeOAuIziULa8MQvRAGWgKW5HsDHY/PcyofD/eyT8OmkSyNTQJQFIW/IzInLv?=
 =?us-ascii?Q?0rAyru14wJFvv/fMcwhpXiLMDSzuT0CxJMjnteBcr6mOpujBt/w/fdbm/D4B?=
 =?us-ascii?Q?akIdok6+PFnQcryrpHtgshRjuJodVGpuBQtbEBgyKjfVosn9NQcHkbSBm6ix?=
 =?us-ascii?Q?tdbd9axi//JIa6hAOhEF0X0vvpEdK2Q/GXyXrA9dAKV+euiaazqOT0e3h7H1?=
 =?us-ascii?Q?MrcAx9EivVAFcXKh0r6VLpZk6pucKy8eAfrB68hfFK6J75iNsvRs42aaczeD?=
 =?us-ascii?Q?RkQdLmdbU2dgPTBsJ3H3u+Ym83v6CA0r1mPiFFR+KYbHnRkRWS2MDkG+knJd?=
 =?us-ascii?Q?FgLY7Bsrxy2v4v7HVlabnZrVlHlRsl5UKwNFVs0eSP8NLJdKuWtYNvH7jz6l?=
 =?us-ascii?Q?jfjyN/RLZA6LsxqOAuFCjOQFIMAy8FU5kIsJb+uMhhxZFIewxar2Ys8uIm2c?=
 =?us-ascii?Q?Iok9xQejl3tcPbc+qQ5YA3HQ8itjkJIup4l5011a5ZEFYqx3j4oKpn/V1M5X?=
 =?us-ascii?Q?J/FJCjLeQ8l4Z93tFbVzPyb/77leiwTpDbVVpIVVrDjCuS+2yyT28Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF17CE793AB.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYa7TifZI/Os7PXdTd0I7bSBDLlLSq5I38UVInF+sgbzhzFCPd53Qey0XDMK?=
 =?us-ascii?Q?TvUG5V9PJLUceLBGaanuLt0Kft1TNJbNs9OS2KIT2nA0GubI/USpOWWLQEYe?=
 =?us-ascii?Q?S/z4PSbmdpYXnTRaBN40iLQ59fha2bEBf8nMyGZNjJFICVxbvis/uaFFDybC?=
 =?us-ascii?Q?VVR0nM3xgYDjyIc5qEi8Uc3rajG4ub65df0DiuM1/90BTOoLrquqlw5ydgWk?=
 =?us-ascii?Q?wAfo3vh35PY2ajnzE7NakW2cfqHZOex+qYRWmV/DsCBP7Lhq6AmF5KXV3sZc?=
 =?us-ascii?Q?RX5DLRfvPa+nK9/EsTbJEAOKhXCpsK3mAUhp6q6Kx1WtbNf1FXWjUYLU+y/D?=
 =?us-ascii?Q?mANe08RkYP8BVSiGMPeQOi5Z653DfABsFBI291hmWuhOhqRT+wStRlO7exac?=
 =?us-ascii?Q?N6RbHL5kh4aJWg/1D7V2RurSBf/p90aVgtKr6XAOS8vxqI2VoNMOGm38gUV5?=
 =?us-ascii?Q?m5haOiBmWdWyTP/mRUMny254PjQhQvy9LRbOxsQZilu5f7XN7YzHoLIlKTKY?=
 =?us-ascii?Q?uqLMPog00K2V/FEvJK7VhdXM65UcAksGz18UQGHtQR8rC6oW2Du/6ZOBL1yS?=
 =?us-ascii?Q?RE+A0yeruxZs/FCEaWbMX6L4DhY6vjQYpOJYLRnwENBldzQPpHotX/RdqTYq?=
 =?us-ascii?Q?d8zy4e2YSDT6ls+dstYhTV+g2zJVdqgQTXidz8bgn9Rf1/+hApR7NPWS9TvM?=
 =?us-ascii?Q?YaveVxaIOW3D3q7a5nMaREjHTU8MUjydViE3l2w1iTI+Tg30Pihe6PVZ04Q+?=
 =?us-ascii?Q?GIOmOdjbJ69SsiJu04u021dJxJMwTH3tFeThezz6dVMf0M0kJUw2khHU/bDx?=
 =?us-ascii?Q?/DwsWWNgeKVsY3VDztBATb6FmJUenzR0mxjb1Dmc6oZ6cWEtXdhejIAp5o73?=
 =?us-ascii?Q?UVLdYYwjdCu+5jH20QV6EPQy3/3tnIsGdcu0b3g//CwXFGnpMupymx3EJfJC?=
 =?us-ascii?Q?/VvpMUSc8nwHvIeRW7OP9RW2WsqgUxYx2yXU3RrtZYO9GGovhMbxr5V6gWAb?=
 =?us-ascii?Q?+pSS/OPG4bEpBKDhSRqHAd+1kOiN2pLuCE1/hl/uDZh9voFDrCttO3RbvxCv?=
 =?us-ascii?Q?ZXVReB+6wWx8nRbwl+aUUdsLYq/hTgN29HRXGnPG/gMZVhSBpJgI3dntAqUB?=
 =?us-ascii?Q?x4U27P8zg6QKZyix5SRbGfsHSj2Hk1CKU5JQkjcdFseg2y2KOj5zt2wcfT3A?=
 =?us-ascii?Q?pRlHfzAuK6QHyhuMr07kowMDFFBEZPjOjhk8SEJDkBKdQpxmYl/ysL76TcsD?=
 =?us-ascii?Q?fmfhwVTEbnCoSeBg7VEXQ7BQx0LiZSSGuQ97d2tj4MHGNaJWi7dBDrLwIDJj?=
 =?us-ascii?Q?jWJBHSO2EaWR6rwlR6x3qrUQya0NqfMVnNU0F3l7S93cEM35bifouSyfLZlB?=
 =?us-ascii?Q?04xkmMCWY/4USmAzDuRrRvyAYeQOVQXHZU7mo2vAbuoKQ6Fkp355XjzGa3fX?=
 =?us-ascii?Q?unrUjVXA4VgRBiNsDfLz2FKtC55ttJAfgRvcXCKm9gMLRItdFEuV0uQmtrVC?=
 =?us-ascii?Q?/H9qZoKV4WgntRj/m/0xOmN3lqCRys1ZUeBuKY0/DjVHeyaYvEcq0rHulhhd?=
 =?us-ascii?Q?UQOWJJyVeNJ49BiJI8d0toknU4/OYkVnBfZwY1xY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF17CE793AB.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd55024-3558-49dc-bcfe-08dda35c1241
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 11:36:39.4887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n15hOX+y3nNjmSQS/U+9dNJLsZc4xkySi5DyTUHwSsEd/Gu8BAsjK35JazbRKWrsJIRKXIPLcK2Xb5Qkx4x98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5482
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4OCBTYWx0ZWRfX+egJ/AGStUYB
 PSV3LHygDeWYmOXSlX4eEWui4capbrmHzj8KpVjSfOKF65AwX5XTvKOgHMOLhxFOblwEkhmaWG+
 r1a9GHuvpp4+MkMzYH+KUq2FW5E1Jtim/WZ0XpVqv0QVu2FFsExMykJstELrZa5TuSE72LiYB2M
 4JqVBd2DiS6b87rU0dmG+BwcrmRjktfblPi1Q773Zot0aF/YBvCvQnKBOej1dNqg2D3z1ecvzDp
 0T3PJ/JgQaPD/qskMijlumBX+xwW3H4qOgSY4H1+WjR55OaKLgPfr32zMYZnX4f1h2AQU+qY2J+
 3gi/MTS/6wWrIAq9OIx4MYPHE74V4fDguksDm1F/oM3ztzJbsfGohzfBJN77k6vBRKsR2nB+rUZ
 bbIAaq58OEDaOhwjWJpqmq1uSw4pB5CPTudCQyNNpUyFBF4t3s2WzGb16xQee7tDrpNeLqCi
X-Proofpoint-GUID: lH-GmdSt4ri2E5OGpvtEGVmNbcOqwRO0
X-Proofpoint-ORIG-GUID: lH-GmdSt4ri2E5OGpvtEGVmNbcOqwRO0
X-Authority-Analysis: v=2.4 cv=It4ecK/g c=1 sm=1 tr=0 ts=68402fce cx=c_pps
 a=GF2TSOjHMZi50w8zQVBjaA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=YYYMuCqpuIFcsrxszooA:9
 a=4cqGfol8HbH7Ssuz:21 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Wednesday, June 4, 2025 3:43 PM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> Subject: [PATCH v10 4/7] graph: add feature enable/disable APIs
>=20
> This patch also adds feature arc fast path APIs as well along with
> documentation
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  doc/guides/prog_guide/graph_lib.rst      | 180 ++++++
>  lib/graph/graph_feature_arc.c            | 701 ++++++++++++++++++++++-
>  lib/graph/meson.build                    |   2 +-
>  lib/graph/rte_graph_feature_arc.h        | 134 ++++-
>  lib/graph/rte_graph_feature_arc_worker.h | 305 +++++++++-
>  5 files changed, 1314 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/guides/prog_guide/graph_lib.rst
> b/doc/guides/prog_guide/graph_lib.rst
> index c9ac9e7ae0..fef384d836 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -609,6 +609,8 @@ provides application to overload default node path by
> providing hook
>  points(like netfilter) to insert out-of-tree or another protocol nodes i=
n
>  packet path.
>=20
> +.. _Control_Data_Plane_Synchronization:
> +
>  Control/Data plane synchronization
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  Feature arc does not stop worker cores for any runtime control plane upd=
ates.
> @@ -839,6 +841,11 @@ which might have allocated during feature enable.
>  notifier_cb() is called, at runtime, for every enable/disable of ``[feat=
ure,
>  index]`` from control thread.
>=20
> +If RCU is provided to enable/disable APIs, notifier_cb() is called after
> +``rte_rcu_qsbr_synchronize()``. Application also needs to call
> +``rte_rcu_qsbr_quiescent()`` in worker thread (preferably after every
> +``rte_graph_walk()`` iteration)
> +
>  override_index_cb()
>  ....................
>  A feature arc is :ref:`registered<Feature_Arc_Registration>` to operate =
on
> @@ -869,3 +876,176 @@ sub-system. If not called, feature arc has no impac=
t
> on application.
>     ``rte_graph_feature_arc_init()`` API should be called before
>     ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
>     application.
> +
> +Runtime feature enable/disable
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +A feature can be enabled or disabled at runtime from control thread usin=
g
> +``rte_graph_feature_enable()`` and ``rte_graph_feature_disable()`` APIs
> +respectively.
> +
> +.. code-block:: c
> +
> +    struct rte_rcu_qsbr *rcu_qsbr =3D app_get_rcu_qsbr();
> +    rte_graph_feature_arc_t _arc;
> +    uint16_t app_cookie;
> +
> +    if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> +        RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> +        return -ENOENT;
> +    }
> +    app_cookie =3D 100; /* Specific to ['Feature-1`, `port-0`]*/
> +
> +    /* Enable feature */
> +    rte_graph_feature_enable(_arc, 0 /* port-0 */,
> +                             "Feature-1" /* Name of the node feature */,
> +                             app_cookie, rcu_qsbr);
> +
> +    /* Disable feature */
> +    rte_graph_feature_disable(_arc, 0 /* port-0 */,
> +                              "Feature-1" /* Name of the node feature*/,
> +                              rcu_qsbr);
> +
> +.. note::
> +
> +   RCU argument is optional argument to enable/disable APIs. See
> +   :ref:`control/data plane
> +   synchronization<Control_Data_Plane_Synchronization>` and
> +   :ref:`notifier_cb<Feature_Notifier_Cb>` for more details on when RCU =
is
> +   needed.
> +
> +Fast path traversal rules
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +``Start node``
> +**************
> +If feature arc is :ref:`initialized<Feature_Arc_Initialization>`,
> +``start_node_feature_process_fn()`` will be called by ``rte_graph_walk()=
``
> +instead of node's original ``process()``. This function should allow pac=
kets to
> +enter arc path whenever any feature is enabled at runtime
> +
> +.. code-block:: c
> +
> +    static int nodeA_init(const struct rte_graph *graph, struct rte_node=
 *node)
> +    {
> +        rte_graph_feature_arc_t _arc;
> +
> +        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> +            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> +            return -ENOENT;
> +        }
> +
> +        /* Save arc in node context */
> +        node->ctx =3D _arc;
> +        return 0;
> +    }
> +
> +    int nodeA_process_inline(struct rte_graph *graph, struct rte_node *n=
ode,
> +                             void **objs, uint16_t nb_objs,
> +                             struct rte_graph_feature_arc *arc,
> +                             const int do_arc_processing)
> +    {
> +        for(uint16_t i =3D 0; i < nb_objs; i++) {
> +            struct rte_mbuf *mbuf =3D objs[i];
> +            rte_edge_t edge_to_child =3D 0; /* By default to Node-B */
> +
> +            if (do_arc_processing) {
> +                struct rte_graph_feature_arc_mbuf_dynfields *dyn =3D
> +                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc-
> >mbuf_dyn_offset);
> +
> +                if (rte_graph_feature_data_first_feature_get(mbuf, mbuf-=
>port,
> +                                                             &dyn->featu=
re_data,
> +                                                             &edge_to_ch=
ild) < 0) {
> +
> +                    /* Some feature is enabled, edge_to_child is overloa=
ded*/
> +                }
> +            }
> +            /* enqueue as usual */
> +            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
> +       }
> +    }
> +
> +    int nodeA_feature_process_fn(struct rte_graph *graph, struct rte_nod=
e
> *node,
> +                                 void **objs, uint16_t nb_objs)
> +    {
> +        struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(=
node-
> >ctx);
> +
> +        if (unlikely(rte_graph_feature_arc_has_any_feature(arc)))
> +            return nodeA_process_inline(graph, node, objs, nb_objs, arc,=
 1 /* do
> arc processing */);
> +        else
> +            return nodeA_process_inline(graph, node, objs, nb_objs, NULL=
, 0 /*
> skip arc processing */);
> +    }
> +
> +``Feature nodes``
> +*****************
> +Following code-snippet explains fast path traversal rule for ``Feature-1=
``
> +:ref:`feature node<Feature_Nodes>` shown in :ref:`figure<Figure_Arc_2>`.
> +
> +.. code-block:: c
> +
> +    static int Feature1_node_init(const struct rte_graph *graph, struct
> rte_node *node)
> +    {
> +        rte_graph_feature_arc_t _arc;
> +
> +        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> +            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> +            return -ENOENT;
> +        }
> +
> +        /* Save arc in node context */
> +        node->ctx =3D _arc;
> +        return 0;
> +    }
> +
> +    int feature1_process_inline(struct rte_graph *graph, struct rte_node
> *node,
> +                                void **objs, uint16_t nb_objs,
> +                                struct rte_graph_feature_arc *arc)
> +    {
> +        for(uint16_t i =3D 0; i < nb_objs; i++) {
> +            struct rte_mbuf *mbuf =3D objs[i];
> +            rte_edge_t edge_to_child =3D 0; /* By default to Node-B */
> +
> +            struct rte_graph_feature_arc_mbuf_dynfields *dyn =3D
> +                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc-
> >mbuf_dyn_offset);
> +
> +            /* Get feature app cookie for mbuf */
> +            uint16_t app_cookie =3D rte_graph_feature_data_app_cookie_ge=
t(mbuf,
> &dyn->feature_data);
> +
> +            if (feature_local_lookup(app_cookie) {
> +
> +                /* Packets is relevant to this feature. Move packet from=
 arc path */
> +                edge_to_child =3D X;
> +
> +            } else {
> +
> +                /* Packet not relevant to this feature. Send this packet=
 to
> +                 * next enabled feature
> +                 */
> +                 rte_graph_feature_data_next_feature_get(mbuf, &dyn-
> >feature_data,
> +                                                         &edge_to_child)=
;
> +            }
> +
> +            /* enqueue as usual */
> +            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
> +       }
> +    }
> +
> +    int feature1_process_fn(struct rte_graph *graph, struct rte_node *no=
de,
> +                           void **objs, uint16_t nb_objs)
> +    {
> +        struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(=
node-
> >ctx);
> +
> +        return feature1_process_inline(graph, node, objs, nb_objs, arc);
> +    }
> +
> +``End feature node``
> +********************
> +An end feature node is a feature node through which packets exits featur=
e arc
> +path. It should not use any feature arc fast path APIs.
> +
> +Feature arc destroy
> +^^^^^^^^^^^^^^^^^^^
> +``rte_graph_feature_arc_destroy()`` can be used to free a arc object.
> +
> +Feature arc cleanup
> +^^^^^^^^^^^^^^^^^^^
> +``rte_graph_feature_arc_cleanup()`` can be used to free all resources
> +associated with feature arc module.
> diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.=
c
> index b28f0ec321..9cad82947a 100644
> --- a/lib/graph/graph_feature_arc.c
> +++ b/lib/graph/graph_feature_arc.c
> @@ -19,6 +19,9 @@
>=20
>  #define graph_uint_cast(f)		((unsigned int)f)
>=20
> +#define fdata_fix_get(arc, feat, index)	\
> +			RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feat,
> index)
> +
>  #define feat_dbg graph_dbg
>=20
>  #define FEAT_COND_ERR(cond, ...)                                        =
   \
> @@ -61,6 +64,139 @@ static STAILQ_HEAD(, rte_graph_feature_arc_register)
> feature_arc_list =3D
>  static STAILQ_HEAD(, rte_graph_feature_register) feature_list =3D
>=20
> 	STAILQ_HEAD_INITIALIZER(feature_list);
>=20
> + /*
> +  * feature data index is not fixed for given [feature, index], although=
 it can
> +  * be, which is calculated as follows (fdata_fix_get())
> +  *
> +  * fdata =3D (arc->max_features * feature ) + index;
> +  *
> +  * But feature data index should not be fixed for any index. i.e
> +  * on any index, feature data can be placed. A slow path array is
> +  * maintained and within a feature range [start, end] it is checked whe=
re
> +  * feature_data_index is already placed.
> +  *
> +  * If is_release =3D=3D false. feature_data_index is searched in a feat=
ure range.
> +  * If found, index is returned. If not found, then reserve and return.
> +  *
> +  * If is_release =3D=3D true, then feature_data_index is released for f=
urther
> +  * usage
> +  */
> +static rte_graph_feature_data_t
> +fdata_dyn_reserve_or_rel(struct rte_graph_feature_arc *arc,
> rte_graph_feature_t f,
> +			 uint32_t index, bool is_release,
> +			 bool fdata_provided, rte_graph_feature_data_t fd)
> +{
> +	rte_graph_feature_data_t start, end, fdata;
> +	rte_graph_feature_t next_feat;
> +
> +	if (fdata_provided)
> +		fdata =3D fd;
> +	else
> +		fdata =3D fdata_fix_get(arc, f, index);
> +
> +	next_feat =3D f + 1;
> +	/* Find in a given feature range, feature data is stored or not */
> +	for (start =3D fdata_fix_get(arc, f, 0),
> +	     end =3D fdata_fix_get(arc, next_feat, 0);
> +	     start < end;
> +	     start++) {
> +		if (arc->feature_data_by_index[start] =3D=3D fdata) {
> +			if (is_release)
> +				arc->feature_data_by_index[start] =3D
> RTE_GRAPH_FEATURE_DATA_INVALID;
> +
> +			return start;
> +		}
> +	}
> +
> +	if (is_release)
> +		return RTE_GRAPH_FEATURE_DATA_INVALID;
> +
> +	/* If not found, then reserve valid one */
> +	for (start =3D fdata_fix_get(arc, f, 0),
> +	     end =3D fdata_fix_get(arc, next_feat, 0);
> +	     start < end;
> +	     start++) {
> +		if (arc->feature_data_by_index[start] =3D=3D
> RTE_GRAPH_FEATURE_DATA_INVALID) {
> +			arc->feature_data_by_index[start] =3D fdata;
> +			return start;
> +		}
> +	}
> +
> +	/* This should not happen */
> +	if (!fdata_provided)
> +		RTE_VERIFY(0);
> +

Why panic? Return error.


> +	return RTE_GRAPH_FEATURE_DATA_INVALID;
> +}
> +
> +static rte_graph_feature_data_t
> +fdata_reserve(struct rte_graph_feature_arc *arc,
> +	      rte_graph_feature_t feature,
> +	      uint32_t index)
> +{
> +	return fdata_dyn_reserve_or_rel(arc, feature + 1, index, false, false, =
0);
> +}
> +
> +static rte_graph_feature_data_t
> +fdata_release(struct rte_graph_feature_arc *arc,
> +	      rte_graph_feature_t feature,
> +	      uint32_t index)
> +{
> +	return fdata_dyn_reserve_or_rel(arc, feature + 1, index, true, false, 0=
);
> +}
> +
> +static rte_graph_feature_data_t
> +first_fdata_reserve(struct rte_graph_feature_arc *arc,
> +		    uint32_t index)
> +{
> +	return fdata_dyn_reserve_or_rel(arc, 0, index, false, false, 0);
> +}
> +
> +static rte_graph_feature_data_t
> +first_fdata_release(struct rte_graph_feature_arc *arc,
> +		    uint32_t index)
> +{
> +	return fdata_dyn_reserve_or_rel(arc, 0, index, true, false, 0);
> +}
> +
> +static rte_graph_feature_data_t
> +extra_fdata_reserve(struct rte_graph_feature_arc *arc,
> +		    rte_graph_feature_t feature,
> +		    uint32_t index)
> +{
> +	rte_graph_feature_data_t fdata, fdata2;
> +	rte_graph_feature_t f;
> +
> +	f =3D arc->num_added_features + NUM_EXTRA_FEATURE_DATA - 1;
> +
> +	fdata =3D fdata_dyn_reserve_or_rel(arc, f, index,
> +					 false, true, fdata_fix_get(arc, feature +
> 1, index));
> +
> +	/* we do not have enough space in as
> +	 * extra fdata accommodates indexes for all features
> +	 * Needed (feature * index) space but has only (index) number of
> space.
> +	 * So dynamic allocation can fail.  When fail use static allocation
> +	 */
> +	if (fdata =3D=3D RTE_GRAPH_FEATURE_DATA_INVALID) {
> +		fdata =3D fdata_fix_get(arc, feature + 1, index);
> +		fdata2 =3D fdata_fix_get(arc, f, index);
> +		arc->feature_data_by_index[fdata2] =3D fdata;
> +	}
> +	return fdata;
> +}
> +
> +static rte_graph_feature_data_t
> +extra_fdata_release(struct rte_graph_feature_arc *arc,
> +		    rte_graph_feature_t feature,
> +		    uint32_t index)
> +{
> +	rte_graph_feature_t f;
> +
> +	f =3D arc->num_added_features + NUM_EXTRA_FEATURE_DATA - 1;
> +	return fdata_dyn_reserve_or_rel(arc, f, index,
> +					true, true, fdata_fix_get(arc, feature +
> 1, index));
> +}
> +
>  /* feature registration validate */
>  static int
>  feature_registration_validate(struct rte_graph_feature_register *feat_en=
try,
> @@ -341,7 +477,10 @@ graph_first_feature_data_ptr_get(struct
> rte_graph_feature_arc *arc,
>  static int
>  feature_arc_data_reset(struct rte_graph_feature_arc *arc)
>  {
> +	rte_graph_feature_data_t first_fdata;
> +	struct rte_graph_feature_data *fdata;
>  	rte_graph_feature_data_t *f =3D NULL;
> +	rte_graph_feature_t iter;
>  	uint16_t index;
>=20
>  	arc->runtime_enabled_features =3D 0;
> @@ -351,6 +490,15 @@ feature_arc_data_reset(struct
> rte_graph_feature_arc *arc)
>  		*f =3D RTE_GRAPH_FEATURE_DATA_INVALID;
>  	}
>=20
> +	for (iter =3D 0; iter < arc->max_features + NUM_EXTRA_FEATURE_DATA;
> iter++) {
> +		first_fdata =3D fdata_fix_get(arc, iter, 0);
> +		for (index =3D 0; index < arc->max_indexes; index++) {
> +			fdata =3D rte_graph_feature_data_get(arc, first_fdata +
> index);
> +			fdata->next_feature_data =3D
> RTE_GRAPH_FEATURE_DATA_INVALID;
> +			fdata->app_cookie =3D UINT16_MAX;
> +			fdata->next_edge =3D RTE_EDGE_ID_INVALID;
> +		}
> +	}
>  	return 0;
>  }
>=20
> @@ -479,6 +627,102 @@ get_existing_edge(const char *arc_name,
> rte_node_t parent_node,
>  	return -1;
>  }
>=20
> +
> +/* prepare feature arc after addition of all features */
> +static int
> +prepare_feature_arc_before_first_enable(struct rte_graph_feature_arc *ar=
c)
> +{
> +	struct rte_graph_feature_node_list *lfinfo =3D NULL;
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	char name[2 * RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +	uint32_t findex =3D 0, iter;
> +	uint16_t num_fdata;
> +	rte_edge_t edge;
> +	size_t sz =3D 0;
> +
> +	STAILQ_FOREACH(lfinfo, &arc->all_features, next_feature) {
> +		lfinfo->finfo_index =3D findex;
> +		findex++;
> +	}
> +	if (!findex) {
> +		graph_err("No feature added to arc: %s", arc-
> >feature_arc_name);
> +		return -1;
> +	}
> +	arc->num_added_features =3D findex;
> +	num_fdata =3D arc->num_added_features +
> NUM_EXTRA_FEATURE_DATA;
> +
> +	sz =3D num_fdata * arc->max_indexes *
> sizeof(rte_graph_feature_data_t);
> +
> +	snprintf(name, sizeof(name), "%s-fdata", arc->feature_arc_name);
> +
> +	arc->feature_data_by_index =3D rte_malloc(name, sz, 0);
> +	if (!arc->feature_data_by_index) {
> +		graph_err("fdata/index rte_malloc failed for %s", name);
> +		return -1;
> +	}
> +
> +	for (iter =3D 0; iter < (num_fdata * arc->max_indexes); iter++)
> +		arc->feature_data_by_index[iter] =3D
> RTE_GRAPH_FEATURE_DATA_INVALID;
> +
> +	/* Grab finfo corresponding to end_feature */
> +	nodeinfo_lkup_by_index(arc, arc->num_added_features - 1, &lfinfo,
> 0);
> +
> +	/* lfinfo should be the info corresponding to end_feature
> +	 * Add edge from all features to end feature node to have exception
> path
> +	 * in fast path from all feature nodes to end feature node during
> enable/disable
> +	 */
> +	if (lfinfo->feature_node_id !=3D arc->end_feature.feature_node_id) {
> +		graph_err("end_feature node mismatch [found-%s: exp-%s]",
> +			  rte_node_id_to_name(lfinfo->feature_node_id),
> +			  rte_node_id_to_name(arc-
> >end_feature.feature_node_id));
> +		goto free_fdata_by_index;
> +	}
> +
> +	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
> +		if (get_existing_edge(arc->feature_arc_name, arc-
> >start_node->id,
> +				      finfo->feature_node_id, &edge)) {
> +			graph_err("No edge found from %s to %s",
> +				  rte_node_id_to_name(arc->start_node->id),
> +				  rte_node_id_to_name(finfo-
> >feature_node_id));
> +			goto free_fdata_by_index;
> +		}
> +		finfo->edge_to_this_feature =3D edge;
> +
> +		if (finfo =3D=3D lfinfo)
> +			continue;
> +
> +		if (get_existing_edge(arc->feature_arc_name, finfo-
> >feature_node_id,
> +				      lfinfo->feature_node_id, &edge)) {
> +			graph_err("No edge found from %s to %s",
> +				  rte_node_id_to_name(finfo-
> >feature_node_id),
> +				  rte_node_id_to_name(lfinfo-
> >feature_node_id));
> +			goto free_fdata_by_index;
> +		}
> +		finfo->edge_to_last_feature =3D edge;
> +	}
> +	/**
> +	 * Enable end_feature in control bitmask
> +	 * (arc->feature_bit_mask_by_index) but not in fast path bitmask
> +	 * arc->fp_feature_enable_bitmask. This is due to:
> +	 * 1. Application may not explicitly enabling end_feature node
> +	 * 2. However it should be enabled internally so that when a feature is
> +	 *    disabled (say on an interface), next_edge of data should be
> +	 *    updated to end_feature node hence packet can exit arc.
> +	 * 3. We do not want to set bit for end_feature in fast path bitmask as
> +	 *    it will void the purpose of fast path APIs
> +	 *    rte_graph_feature_arc_is_any_feature_enabled(). Since enabling
> +	 *    end_feature would make these APIs to always return "true"
> +	 */
> +	for (iter =3D 0; iter < arc->max_indexes; iter++)
> +		arc->feature_bit_mask_by_index[iter] |=3D (1 << lfinfo-
> >finfo_index);
> +
> +	return 0;
> +
> +free_fdata_by_index:
> +	rte_free(arc->feature_data_by_index);
> +	return -1;
> +}
> +
>  /* feature arc sanity */
>  static int
>  feature_arc_sanity(rte_graph_feature_arc_t _arc)
> @@ -588,6 +832,229 @@
> feature_arc_main_init(rte_graph_feature_arc_main_t **pfl, uint32_t
> max_feature_a
>  	return 0;
>  }
>=20
> +static int
> +feature_enable_disable_validate(rte_graph_feature_arc_t _arc, uint32_t
> index,
> +				const char *feature_name,
> +				int is_enable_disable, bool emit_logs)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	uint32_t slot, last_end_feature;
> +
> +	if (!arc)
> +		return -EINVAL;
> +
> +	/* validate _arc */
> +	if (arc->feature_arc_main !=3D __rte_graph_feature_arc_main) {
> +		FEAT_COND_ERR(emit_logs, "invalid feature arc: 0x%x", _arc);
> +		return -EINVAL;
> +	}
> +
> +	/* validate index */
> +	if (index >=3D arc->max_indexes) {
> +		FEAT_COND_ERR(emit_logs, "%s: Invalid provided index: %u
> >=3D %u configured",
> +			      arc->feature_arc_name, index, arc->max_indexes);
> +		return -1;
> +	}
> +
> +	/* validate feature_name is already added or not  */
> +	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot)) {
> +		FEAT_COND_ERR(emit_logs, "%s: No feature %s added",
> +			      arc->feature_arc_name, feature_name);
> +		return -EINVAL;
> +	}
> +
> +	if (!finfo) {
> +		FEAT_COND_ERR(emit_logs, "%s: No feature: %s found to
> enable/disable",
> +			      arc->feature_arc_name, feature_name);
> +		return -EINVAL;
> +	}
> +
> +	/* slot should be in valid range */
> +	if (slot >=3D arc->num_added_features) {
> +		FEAT_COND_ERR(emit_logs, "%s/%s: Invalid free slot
> %u(max=3D%u) for feature",
> +			      arc->feature_arc_name, feature_name, slot, arc-
> >num_added_features);
> +		return -EINVAL;
> +	}
> +
> +	/* slot should be in range of 0 - 63 */
> +	if (slot > (GRAPH_FEATURE_MAX_NUM_PER_ARC - 1)) {
> +		FEAT_COND_ERR(emit_logs, "%s/%s: Invalid slot: %u", arc-
> >feature_arc_name,
> +			      feature_name, slot);
> +		return -EINVAL;
> +	}
> +
> +	last_end_feature =3D rte_fls_u64(arc-
> >feature_bit_mask_by_index[index]);
> +	if (!last_end_feature) {
> +		FEAT_COND_ERR(emit_logs, "%s: End feature not enabled",
> arc->feature_arc_name);
> +		return -EINVAL;
> +	}
> +
> +	/* if enabled feature is not end feature node and already enabled */
> +	if (is_enable_disable &&
> +	    (arc->feature_bit_mask_by_index[index] & RTE_BIT64(slot)) &&
> +	    (slot !=3D (last_end_feature - 1))) {
> +		FEAT_COND_ERR(emit_logs, "%s: %s already enabled on
> index: %u",
> +			      arc->feature_arc_name, feature_name, index);
> +		return -1;
> +	}
> +
> +	if (!is_enable_disable && !arc->runtime_enabled_features) {
> +		FEAT_COND_ERR(emit_logs, "%s: No feature enabled to
> disable",
> +			      arc->feature_arc_name);
> +		return -1;
> +	}
> +
> +	if (!is_enable_disable && !(arc->feature_bit_mask_by_index[index] &
> RTE_BIT64(slot))) {
> +		FEAT_COND_ERR(emit_logs, "%s: %s not enabled in bitmask
> for index: %u",
> +			      arc->feature_arc_name, feature_name, index);
> +		return -1;
> +	}
> +
> +	/* If no feature has been enabled, avoid extra sanity checks */
> +	if (!arc->runtime_enabled_features)
> +		return 0;
> +
> +	if (finfo->finfo_index !=3D slot) {
> +		FEAT_COND_ERR(emit_logs,
> +			      "%s/%s: lookup slot mismatch for finfo idx: %u and
> lookup slot: %u",
> +			      arc->feature_arc_name, feature_name, finfo-
> >finfo_index, slot);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +refill_fastpath_data(struct rte_graph_feature_arc *arc, uint32_t feature=
_bit,
> +		     uint16_t index /* array index */, int is_enable_disable)
> +{
> +	struct rte_graph_feature_data *gfd =3D NULL, *prev_gfd =3D NULL, *fdptr=
 =3D
> NULL;
> +	struct rte_graph_feature_node_list *finfo =3D NULL, *prev_finfo =3D NUL=
L;
> +	RTE_ATOMIC(rte_graph_feature_data_t) * first_fdata =3D NULL;
> +	uint32_t fi =3D 0, prev_fi =3D 0, next_fi =3D 0, cfi =3D 0;
> +	uint64_t bitmask =3D 0, prev_bitmask, next_bitmask;
> +	rte_graph_feature_data_t *__first_fd =3D NULL;
> +	rte_edge_t edge =3D RTE_EDGE_ID_INVALID;
> +	rte_graph_feature_data_t fdata, _fd;
> +	bool update_first_feature =3D false;
> +
> +	if (is_enable_disable)
> +		bitmask =3D RTE_BIT64(feature_bit);
> +
> +	/* set bit from (feature_bit + 1) to 64th bit */
> +	next_bitmask =3D UINT64_MAX << (feature_bit + 1);
> +
> +	/* set bits from 0 to (feature_bit - 1) */
> +	prev_bitmask =3D ((UINT64_MAX & ~next_bitmask) &
> ~(RTE_BIT64(feature_bit)));
> +
> +	next_bitmask &=3D arc->feature_bit_mask_by_index[index];
> +	prev_bitmask &=3D arc->feature_bit_mask_by_index[index];
> +
> +	/* Set next bit set in next_bitmask */
> +	if (rte_bsf64_safe(next_bitmask, &next_fi))
> +		bitmask |=3D RTE_BIT64(next_fi);
> +
> +	/* Set prev bit set in prev_bitmask*/
> +	prev_fi =3D rte_fls_u64(prev_bitmask);
> +	if (prev_fi)
> +		bitmask |=3D RTE_BIT64(prev_fi - 1);
> +
> +	/* for each feature set for index, set fast path data */
> +	prev_gfd =3D NULL;
> +	while (rte_bsf64_safe(bitmask, &fi)) {
> +		_fd =3D fdata_reserve(arc, fi, index);
> +		gfd =3D rte_graph_feature_data_get(arc, _fd);
> +
> +		RTE_VERIFY(!nodeinfo_lkup_by_index(arc, fi, &finfo, 1));
> +
> +		/* Reset next edge to point to last feature node so that packet
> +		 * can exit from arc
> +		 */
> +		rte_atomic_store_explicit(&gfd->next_edge,
> +					  finfo->edge_to_last_feature,
> +					  rte_memory_order_relaxed);
> +
> +		/* If previous feature_index was valid in last loop */
> +		if (prev_gfd !=3D NULL) {
> +			/*
> +			 * Get edge of previous feature node connecting
> +			 * to this feature node
> +			 */
> +			RTE_VERIFY(!nodeinfo_lkup_by_index(arc, prev_fi,
> &prev_finfo, 1));
> +
> +			if (!get_existing_edge(arc->feature_arc_name,
> +					      prev_finfo->feature_node_id,
> +					      finfo->feature_node_id, &edge)) {
> +				feat_dbg("\t[%s/index:%2u,cookie:%u]: (%u-
> >%u)%s[%u] =3D %s",
> +					 arc->feature_arc_name, index,
> +					 gfd->app_cookie, prev_fi, fi,
> +					 rte_node_id_to_name(prev_finfo-
> >feature_node_id),
> +					 edge, rte_node_id_to_name(finfo-
> >feature_node_id));
> +
> +				rte_atomic_store_explicit(&prev_gfd-
> >next_edge,
> +							  edge,
> +
> rte_memory_order_relaxed);
> +
> +				rte_atomic_store_explicit(&prev_gfd-
> >next_feature_data, _fd,
> +
> rte_memory_order_relaxed);
> +			} else {
> +				/* Should not fail */
> +				RTE_VERIFY(0);
> +			}
> +		}
> +		/* On first feature
> +		 * 1. Update fdata with next_edge from start_node to feature
> node
> +		 * 2. Update first enabled feature in its index array
> +		 */
> +		if (rte_bsf64_safe(arc->feature_bit_mask_by_index[index],
> &cfi)) {
> +			update_first_feature =3D (cfi =3D=3D fi) ? true : false;
> +
> +			if (update_first_feature) {
> +				feat_dbg("\t[%s/index:%2u,cookie:%u]: (-
> >%u)%s[%u]=3D%s",
> +					 arc->feature_arc_name, index,
> +					 gfd->app_cookie, fi,
> +					 arc->start_node->name, finfo-
> >edge_to_this_feature,
> +					 rte_node_id_to_name(finfo-
> >feature_node_id));
> +
> +				/* Reserve feature data @0th index for first
> feature */
> +				fdata =3D first_fdata_reserve(arc, index);
> +				fdptr =3D rte_graph_feature_data_get(arc,
> fdata);
> +
> +				/* add next edge into feature data
> +				 * First set feature data then first feature
> memory
> +				 */
> +				rte_atomic_store_explicit(&fdptr->next_edge,
> +							  finfo-
> >edge_to_this_feature,
> +
> rte_memory_order_relaxed);
> +
> +				rte_atomic_store_explicit(&fdptr-
> >next_feature_data,
> +							  _fd,
> +
> rte_memory_order_relaxed);
> +
> +				__first_fd =3D
> graph_first_feature_data_ptr_get(arc, index);
> +				first_fdata =3D
> (RTE_ATOMIC(rte_graph_feature_data_t) *)__first_fd;
> +
> +				/* Save reserved feature data @fp_index */
> +				rte_atomic_store_explicit(first_fdata, fdata,
> +
> rte_memory_order_relaxed);
> +			}
> +		}
> +		prev_fi =3D fi;
> +		prev_gfd =3D gfd;
> +		/* Clear current feature index */
> +		bitmask &=3D ~RTE_BIT64(fi);
> +	}
> +	/* If all features are disabled on index, except end feature
> +	 * then release 0th index
> +	 */
> +	if (!is_enable_disable &&
> +	    (rte_popcount64(arc->feature_bit_mask_by_index[index]) =3D=3D 1))
> +		first_fdata_release(arc, index);
> +
> +	return 0;
> +}
> +
>  /* feature arc initialization, public API */
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07);
>  int
> @@ -1130,6 +1597,197 @@
> rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char
> *feature_name,
>  	return -1;
>  }
>=20
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_enable, 25.07);
> +int
> +rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t index,
> +			 const char *feature_name, uint16_t app_cookie,
> +			 struct rte_rcu_qsbr *qsbr)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	struct rte_graph_feature_data *gfd =3D NULL;
> +	uint64_t bitmask;
> +	uint32_t slot;
> +
> +	if (!arc) {
> +		graph_err("Invalid feature arc: 0x%x", _arc);
> +		return -1;
> +	}
> +
> +	feat_dbg("%s: Enabling feature: %s for index: %u",
> +		 arc->feature_arc_name, feature_name, index);
> +
> +	if ((!arc->runtime_enabled_features &&
> +	    (prepare_feature_arc_before_first_enable(arc) < 0)))
> +		return -1;
> +
> +	if (feature_enable_disable_validate(_arc, index, feature_name, 1 /*
> enable */, true))
> +		return -1;
> +
> +	/** This should not fail as validate() has passed */
> +	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot))
> +		RTE_VERIFY(0);
> +
> +	gfd =3D rte_graph_feature_data_get(arc, fdata_reserve(arc, slot, index)=
);
> +
> +	/* Set current app_cookie */
> +	rte_atomic_store_explicit(&gfd->app_cookie, app_cookie,
> rte_memory_order_relaxed);
> +
> +	/* Set bitmask in control path bitmask */
> +	rte_bit_relaxed_set64(graph_uint_cast(slot), &arc-
> >feature_bit_mask_by_index[index]);
> +
> +	refill_fastpath_data(arc, slot, index, 1 /* enable */);
> +
> +	/* On very first feature enable instance */
> +	if (!finfo->ref_count) {
> +		/* If first time feature getting enabled
> +		 */
> +		bitmask =3D rte_atomic_load_explicit(&arc-
> >fp_feature_enable_bitmask,
> +
> rte_memory_order_relaxed);
> +
> +		bitmask |=3D RTE_BIT64(slot);
> +
> +		rte_atomic_store_explicit(&arc->fp_feature_enable_bitmask,
> +					  bitmask,
> rte_memory_order_relaxed);
> +	}
> +
> +	/* Slow path updates */
> +	arc->runtime_enabled_features++;
> +
> +	/* Increase feature node info reference count */
> +	finfo->ref_count++;
> +
> +	/* Release extra fdata, if reserved before */
> +	extra_fdata_release(arc, slot, index);
> +
> +	if (qsbr)
> +		rte_rcu_qsbr_synchronize(qsbr, RTE_QSBR_THRID_INVALID);
> +
> +	if (finfo->notifier_cb)
> +		finfo->notifier_cb(arc->feature_arc_name, finfo-
> >feature_name,
> +				   finfo->feature_node_id, index,
> +				   true /* enable */, gfd->app_cookie);
> +
> +	return 0;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_disable, 25.07);
> +int
> +rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t index,
> const char *feature_name,
> +			  struct rte_rcu_qsbr *qsbr)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +	struct rte_graph_feature_data *gfd =3D NULL, *extra_gfd =3D NULL;
> +	struct rte_graph_feature_node_list *finfo =3D NULL;
> +	rte_graph_feature_data_t extra_fdata;
> +	uint32_t slot, last_end_feature;
> +	uint64_t bitmask;
> +
> +	if (!arc) {
> +		graph_err("Invalid feature arc: 0x%x", _arc);
> +		return -1;
> +	}
> +	feat_dbg("%s: Disable feature: %s for index: %u",
> +		 arc->feature_arc_name, feature_name, index);
> +
> +	if (feature_enable_disable_validate(_arc, index, feature_name, 0,
> true))
> +		return -1;
> +
> +	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot))
> +		return -1;
> +
> +	last_end_feature =3D rte_fls_u64(arc-
> >feature_bit_mask_by_index[index]);
> +	if (last_end_feature !=3D arc->num_added_features) {
> +		graph_err("%s/%s: No end feature enabled",
> +			  arc->feature_arc_name, feature_name);
> +		return -1;
> +	}
> +
> +	/* If feature is not last feature, unset in control plane bitmask */
> +	last_end_feature =3D arc->num_added_features - 1;
> +	if (slot !=3D last_end_feature)
> +		rte_bit_relaxed_clear64(graph_uint_cast(slot),
> +					&arc-
> >feature_bit_mask_by_index[index]);
> +
> +	/* we have allocated one extra feature data space. Get extra feature
> data
> +	 * No need to reserve instead use fixed  extra data for an index
> +	 */
> +	extra_fdata =3D extra_fdata_reserve(arc, slot, index);
> +	extra_gfd =3D rte_graph_feature_data_get(arc, extra_fdata);
> +
> +	gfd =3D rte_graph_feature_data_get(arc, fdata_reserve(arc, slot, index)=
);
> +
> +	/*
> +	 * Packets may have reached to feature node which is getting disabled.
> +	 * We want to steer those packets to last feature node so that they can
> +	 * exit arc
> +	 * - First, reset next_edge of extra feature data to point to
> last_feature_node
> +	 * - Secondly, reset next_feature_data of current feature getting
> disabled to extra
> +	 *   feature data
> +	 */
> +	rte_atomic_store_explicit(&extra_gfd->next_edge, finfo-
> >edge_to_last_feature,
> +				  rte_memory_order_relaxed);
> +	rte_atomic_store_explicit(&extra_gfd->next_feature_data,
> RTE_GRAPH_FEATURE_DATA_INVALID,
> +				  rte_memory_order_relaxed);
> +	rte_atomic_store_explicit(&gfd->next_feature_data, extra_fdata,
> +				  rte_memory_order_relaxed);
> +	rte_atomic_store_explicit(&gfd->next_edge, finfo-
> >edge_to_last_feature,
> +				  rte_memory_order_relaxed);
> +
> +	/* Now we can unwire fast path*/
> +	refill_fastpath_data(arc, slot, index, 0 /* disable */);
> +
> +	finfo->ref_count--;
> +
> +	/* When last feature is disabled */
> +	if (!finfo->ref_count) {
> +		/* If no feature enabled, reset feature in u64 fast path bitmask
> */
> +		bitmask =3D rte_atomic_load_explicit(&arc-
> >fp_feature_enable_bitmask,
> +
> rte_memory_order_relaxed);
> +		bitmask &=3D ~(RTE_BIT64(slot));
> +		rte_atomic_store_explicit(&arc->fp_feature_enable_bitmask,
> bitmask,
> +					  rte_memory_order_relaxed);
> +	}
> +
> +	if (qsbr)
> +		rte_rcu_qsbr_synchronize(qsbr, RTE_QSBR_THRID_INVALID);
> +
> +	/* Call notifier cb with valid app_cookie */
> +	if (finfo->notifier_cb)
> +		finfo->notifier_cb(arc->feature_arc_name, finfo-
> >feature_name,
> +				   finfo->feature_node_id, index,
> +				   false /* disable */, gfd->app_cookie);
> +
> +	/*
> +	 * 1. Do not reset gfd for now as feature node might be in execution
> +	 *
> +	 * 2. We also don't call fdata_release() as that may return same
> +	 * feature_data for other index for case like:
> +	 *
> +	 * feature_enable(arc, index-0, feature_name, cookie1);
> +	 * feature_enable(arc, index-1, feature_name, cookie2);
> +	 *
> +	 * Second call can return same fdata which we avoided releasing here.
> +	 * In order to make above case work, application has to mandatory use
> +	 * RCU mechanism. For now fdata is not released until arc_destroy
> +	 *
> +	 * Only exception is
> +	 * for(i=3D0; i< 100; i++) {
> +	 *   feature_enable(arc, index-0, feature_name, cookie1);
> +	 *   feature_disable(arc, index-0, feature_name, cookie1);
> +	 * }
> +	 * where RCU should be used but this is not valid use-case from
> control plane.
> +	 * If it is valid use-case then provide RCU argument
> +	 */
> +
> +	/* Reset app_cookie later after calling notifier_cb */
> +	rte_atomic_store_explicit(&gfd->app_cookie, UINT16_MAX,
> rte_memory_order_relaxed);
> +
> +	arc->runtime_enabled_features--;
> +
> +	return 0;
> +}
> +
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy,
> 25.07);
>  int
>  rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
> @@ -1137,6 +1795,8 @@
> rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
>  	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
>  	rte_graph_feature_arc_main_t *dm =3D __rte_graph_feature_arc_main;
>  	struct rte_graph_feature_node_list *node_info =3D NULL;
> +	struct rte_graph_feature_data *fdptr =3D NULL;
> +	rte_graph_feature_data_t fdata;
>  	int iter;
>=20
>  	if (!arc) {
> @@ -1155,11 +1815,28 @@
> rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
>  				    RTE_BIT64(node_info->finfo_index)))
>  					continue;
>=20
> -				node_info->notifier_cb(arc-
> >feature_arc_name,
> -						       node_info->feature_name,
> -						       node_info-
> >feature_node_id,
> -						       iter, false /* disable */,
> -						       UINT16_MAX /* invalid
> cookie */);
> +				/* fdata_reserve would return already
> allocated
> +				 * fdata for [finfo_index, iter]
> +				 */
> +				fdata =3D fdata_reserve(arc, node_info-
> >finfo_index, iter);
> +				if (fdata !=3D
> RTE_GRAPH_FEATURE_DATA_INVALID) {
> +					fdptr =3D
> rte_graph_feature_data_get(arc, fdata);
> +					node_info->notifier_cb(arc-
> >feature_arc_name,
> +							       node_info-
> >feature_name,
> +							       node_info-
> >feature_node_id,
> +							       iter, false /*
> disable */,
> +							       fdptr-
> >app_cookie);
> +				} else {
> +					node_info->notifier_cb(arc-
> >feature_arc_name,
> +							       node_info-
> >feature_name,
> +							       node_info-
> >feature_node_id,
> +							       iter, false /*
> disable */,
> +							       UINT16_MAX /*
> invalid cookie */);
> +				}
> +				/* fdata_release() is not used yet, use it for
> sake
> +				 * of function unused warnings
> +				 */
> +				fdata =3D fdata_release(arc, node_info-
> >finfo_index, iter);
>  			}
>  		}
>  		rte_free(node_info);
> @@ -1239,6 +1916,20 @@ rte_graph_feature_arc_lookup_by_name(const
> char *arc_name, rte_graph_feature_arc
>  	return -1;
>  }
>=20
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_enable
> d_features, 25.07);
> +uint32_t
> +rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t
> _arc)
> +{
> +	struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_get(_arc);
> +
> +	if (!arc) {
> +		graph_err("Invalid feature arc: 0x%x", _arc);
> +		return 0;
> +	}
> +
> +	return arc->runtime_enabled_features;
> +}
> +
>=20
> RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_features,
> 25.07);
>  uint32_t
>  rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
> diff --git a/lib/graph/meson.build b/lib/graph/meson.build
> index 6a6d570290..d48d49122d 100644
> --- a/lib/graph/meson.build
> +++ b/lib/graph/meson.build
> @@ -27,4 +27,4 @@ indirect_headers +=3D files(
>          'rte_graph_worker_common.h',
>  )
>=20
> -deps +=3D ['eal', 'pcapng', 'mempool', 'ring']
> +deps +=3D ['eal', 'pcapng', 'mempool', 'ring', 'rcu']
> diff --git a/lib/graph/rte_graph_feature_arc.h
> b/lib/graph/rte_graph_feature_arc.h
> index f25f77df3c..2b90f0111b 100644
> --- a/lib/graph/rte_graph_feature_arc.h
> +++ b/lib/graph/rte_graph_feature_arc.h
> @@ -18,6 +18,7 @@
>  #include <rte_compat.h>
>  #include <rte_debug.h>
>  #include <rte_graph.h>
> +#include <rte_rcu_qsbr.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -87,7 +88,9 @@ extern "C" {
>   *
>   * A feature arc in a graph is represented via *start_node* and *end_nod=
e*.
>   * Feature nodes are added between start_node and end_node. Packets ente=
r
> - * feature arc traversal via start_node while they exits from end_node.
> + * feature arc traversal via start_node while they exits from end_node.
> Packets
> + * steering from start_node to feature nodes are controlled in control p=
lane
> + * via rte_graph_feature_enable()/rte_graph_feature_disable().
>   *
>   * This library facilitates rte graph based applications to implement st=
ack
>   * functionalities described above by providing "edge" to the next enabl=
ed
> @@ -103,6 +106,8 @@ extern "C" {
>   * - Before calling rte_graph_create(), rte_graph_feature_arc_init() API=
 must
>   *   be called. If rte_graph_feature_arc_init() is not called by applica=
tion,
>   *   feature arc library has no affect.
> + * - Features can be enabled/disabled on any index at runtime via
> + *   rte_graph_feature_enable()/rte_graph_feature_disable()
>   * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
>   *
>   * If a given feature likes to control number of indexes (which is highe=
r than
> @@ -112,10 +117,64 @@ extern "C" {
>   * called and with maximum value returned by any of the feature is used =
for
>   * rte_graph_feature_arc_create()
>   *
> + * Before enabling a feature, control plane might allocate certain resou=
rces
> + * (like VRF table for IP lookup or IPsec SA for inbound policy etc). A
> + * reference of allocated resource can be passed from control plane to
> + * dataplane via *app_cookie* argument in @ref rte_graph_feature_enable(=
).
> A
> + * corresponding dataplane API @ref
> rte_graph_feature_data_app_cookie_get() can
> + * be used to retrieve same cookie in fast path.
> + *
> + * When a feature is disabled, resources allocated during feature enable=
 can
> be
> + * safely released via registering a callback in
> + * RTE_GRAPH_FEATURE_REGISTER::notifier_cb(). See fast path
> synchronization
> + * section below for more details.
> + *
> + * While *app_cookie* can be known corresponding to current feature node
> via
> + * @ref rte_graph_feature_data_app_cookie_get(), however if current
> feature
> + * node is not consuming packet it might want to send it to next enabled
> + * feature using, it can do if current feature node is a:
> + * - start_node (via @ref rte_graph_feature_data_first_feature_get())
> + * - feature nodes added between start_node and end_node (via @ref
> + *   rte_graph_feature_data_next_feature_get())
> + * - end node (must not call any feature arc steering APIs) as from this=
 node
> + *   packet exits feature arc
> + *
> + * Above APIs deals with fast path object: feature_data(struct
> + * rte_graph_feature_data), which is unique for every index per feature =
with
> in
> + * a feature arc. It holds three data fields: next node edge, next enabl=
ed
> + * feature data and app_cookie.
> + *
> + * rte_mbuf carries [feature_data] into feature arc specific mbuf dynami=
c
> + * field
> + *
> + * Fast path synchronization
> + * -------------------------
> + * Any feature enable/disable in control plane does not require stopping=
 of
> + * worker cores. rte_graph_feature_enable()/rte_graph_feature_disable()
> APIs
> + * are almost thread-safe avoiding any RCU usage. Only condition when ra=
ce
> + * condition could occur is when application is trying to enable/disable
> + * feature very fast for [feature, index] combination. In that case,
> + * application should use rte_graph_feature_enable()/disable() APIs with=
 RCU
> + * argument
> + *
> + * RCU synchronization may also be required when application needs to fr=
ee
> + * resources (using RTE_GRAPH_FEATURE_REGISTER:notifier_cb()) which it
> may have
> + * allocated during feature enable. Resources can be freed only when no
> worker
> + * core is not acting on it.
> + *
> + * If RCU argument to rte_graph_feature_enable()/disable() is non-NULL:
> + *  - rte_rcu_qsbr_synchronize(rte_rcu_qsbr *) to synchronize all worker
> cores
> + *  - Calls RTE_GRAPH_FEATURE_REGISTER()->notifier_cb((), if set, and he=
lps
> + *  application to safely release resources associated with [feature, in=
dex]
> + *
> + * It is application responsibility to pass valid RCU argument to APIs
> + *
>   * Constraints
>   * -----------
>   *  - rte_graph_feature_arc_init(), rte_graph_feature_create() and
>   *  rte_graph_feature_add() must be called before rte_graph_create().
> + *  rte_graph_feature_enable()/rte_graph_feature_disable() should be cal=
led
> + *  after rte_graph_create()
>   *  - Not more than 63 features can be added to a feature arc. There is =
no
>   *  limit to number of feature arcs i.e. number of
>   *  RTE_GRAPH_FEATURE_ARC_REGISTER()
> @@ -359,6 +418,9 @@ int rte_graph_feature_arc_lookup_by_name(const
> char *arc_name, rte_graph_feature
>   * Pointer to struct rte_graph_feature_register
>   *
>   * <I> Must be called before rte_graph_create() </I>
> + * <I> rte_graph_feature_add() is not allowed after call to
> + * rte_graph_feature_enable() so all features must be added before they =
can
> be
> + * enabled </I>
>   * <I> When called by application, then feature_node_id should be
> appropriately set as
>   *     freg->feature_node_id =3D freg->feature_node->id;
>   * </I>
> @@ -370,6 +432,63 @@ int rte_graph_feature_arc_lookup_by_name(const
> char *arc_name, rte_graph_feature
>  __rte_experimental
>  int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg);
>=20
> +/**
> + * Enable feature within a feature arc
> + *
> + * Must be called after @b rte_graph_create().
> + *
> + * @param _arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or
> @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + * @param index
> + *   Application specific index. Can be corresponding to interface_id/po=
rt_id
> etc
> + * @param feature_name
> + *   Name of the node which is already added via @ref rte_graph_feature_=
add
> + * @param app_cookie
> + *   Application specific data which is retrieved in fast path
> + * @param qsbr
> + *   RCU QSBR object.  After enabling feature, API calls
> + *   rte_rcu_qsbr_synchronize() followed by call to struct
> + *   rte_graph_feature_register::notifier_cb(), if it is set, to notify =
feature
> + *   caller This object can be passed NULL as well if no RCU synchroniza=
tion is
> + *   required
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t inde=
x,
> const
> +			     char *feature_name, uint16_t app_cookie,
> +			     struct rte_rcu_qsbr *qsbr);
> +
> +/**
> + * Disable already enabled feature within a feature arc
> + *
> + * Must be called after @b rte_graph_create(). API is *NOT* Thread-safe
> + *
> + * @param _arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or
> @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + * @param index
> + *   Application specific index. Can be corresponding to interface_id/po=
rt_id
> etc
> + * @param feature_name
> + *   Name of the node which is already added via @ref rte_graph_feature_=
add
> + * @param qsbr
> + *   RCU QSBR object.  After disabling feature, API calls
> + *   rte_rcu_qsbr_synchronize() followed by call to struct
> + *   RTE_GRAPH_FEATURE_ARC_REGISTER::notifier_cb(), if it is set, to not=
ify
> feature
> + *   caller. This object can be passed NULL as well if no RCU synchroniz=
ation is
> + *   required
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t ind=
ex,
> +			      const char *feature_name, struct rte_rcu_qsbr
> *qsbr);
> +
>  /**
>   * Get rte_graph_feature_t object from feature name
>   *
> @@ -425,6 +544,19 @@ int rte_graph_feature_arc_cleanup(void);
>  __rte_experimental
>  uint32_t rte_graph_feature_arc_num_features(rte_graph_feature_arc_t
> _arc);
>=20
> +/**
> + * Slow path API to know how many features are currently enabled within =
a
> + * feature arc across all indexes. If a single feature is enabled on all=
 interfaces,
> + * this API would return "number_of_interfaces" as count (but not "1")
> + *
> + * @param _arc
> + *  Feature arc object
> + *
> + * @return: Number of enabled features across all indexes
> + */
> +__rte_experimental
> +uint32_t
> rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t _arc);
> +
>  /**
>   * Slow path API to get feature node name from rte_graph_feature_t objec=
t
>   *
> diff --git a/lib/graph/rte_graph_feature_arc_worker.h
> b/lib/graph/rte_graph_feature_arc_worker.h
> index b2fc539402..060c4f8c6d 100644
> --- a/lib/graph/rte_graph_feature_arc_worker.h
> +++ b/lib/graph/rte_graph_feature_arc_worker.h
> @@ -159,6 +159,45 @@ struct __rte_cache_aligned rte_graph_feature_arc {
>  	 */
>  	int mbuf_dyn_offset;
>=20
> +	/** Fast path arc data starts */
> +	/*
> +	 * Arc specific fast path data
> +	 * It accommodates:
> +	 *
> +	 *	1. first enabled feature data for every index
> (rte_graph_feature_data_t or fdata)
> +	 *	+--------------------------------------------------------------+ <-
> cache_aligned
> +	 *	|  0th Index    | 1st Index   |  ... | max_index - 1           |
> +	 *	+--------------------------------------------------------------+
> +	 *	|  Startfdata0  | Startfdata1 |  ... | Startfdata(max_index-1) |
> +	 *	+--------------------------------------------------------------+
> +	 *
> +	 *	2. struct rte_graph_feature_data per index per feature
> +	 *	+----------------------------------------+ ^ <- Start (Reserved,
> cache aligned)
> +	 *	|  struct rte_graph_feature_data[Index0] | |
> +	 *	+----------------------------------------+ | feature_size
> +	 *	|  struct rte_graph_feature_data[Index1] | |
> +	 *	+----------------------------------------+ ^ <- Feature-0
> (cache_aligned)
> +	 *	|  struct rte_graph_feature_data[Index0] | |
> +	 *	+----------------------------------------+ | feature_size
> +	 *	|  struct rte_graph_feature_data[Index1] | |
> +	 *	+----------------------------------------+ v <- Feature-1 (cache
> aligned)
> +	 *	|  struct rte_graph_feature_data[Index0] | ^
> +	 *	+----------------------------------------+ | feature_size
> +	 *	|  struct rte_graph_feature_data[Index1] | |
> +	 *	+----------------------------------------+ v
> +	 *	|         ...            ....            |
> +	 *	|         ...            ....            |
> +	 *	|         ...            ....            |
> +	 *	+----------------------------------------+ v <- Feature Index-1
> (cache aligned)
> +	 *	|  struct rte_graph_feature_data[Index0] | ^
> +	 *	+----------------------------------------+ | feature_size
> +	 *	|  struct rte_graph_feature_data[Index1] | |
> +	 *	+----------------------------------------+ v <- Extra (Reserved,
> cache aligned)
> +	 *	|  struct rte_graph_feature_data[Index0] | ^
> +	 *	+----------------------------------------+ | feature_size
> +	 *	|  struct rte_graph_feature_data[Index1] | |
> +	 *	+----------------------------------------+ v
> +	 */
>  	RTE_MARKER8 fp_arc_data;
>  };
>=20
> @@ -193,13 +232,15 @@ typedef struct rte_feature_arc_main {
>   *  It holds
>   *  - edge to reach to next feature node
>   *  - next_feature_data corresponding to next enabled feature
> + *  - app_cookie set by application in rte_graph_feature_enable()
>   */
>  struct rte_graph_feature_data {
>  	/** edge from this feature node to next enabled feature node */
>  	RTE_ATOMIC(rte_edge_t) next_edge;
>=20
>  	/**
> -	 * app_cookie
> +	 * app_cookie set by application in rte_graph_feature_enable() for
> +	 * current feature data
>  	 */
>  	RTE_ATOMIC(uint16_t) app_cookie;
>=20
> @@ -216,6 +257,18 @@ struct rte_graph_feature_arc_mbuf_dynfields {
>  /** Name of dynamic mbuf field offset registered in
> rte_graph_feature_arc_init() */
>  #define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME
> "__rte_graph_feature_arc_mbuf_dynfield"
>=20
> +/** log2(sizeof (struct rte_graph_feature_data)) */
> +#define RTE_GRAPH_FEATURE_DATA_SIZE_LOG2	3
> +
> +/** Number of struct rte_graph_feature_data per feature*/
> +#define RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc)
> 			\
> +	(arc->feature_size >> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)
> +
> +/** Get rte_graph_feature_data_t from rte_graph_feature_t */
> +#define RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feature, index)
> 		\
> +		((rte_graph_feature_data_t)
> 	\
> +		 ((RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc) *
> (feature)) + (index)))
> +
>  /**
>   * @internal macro
>   */
> @@ -271,6 +324,23 @@ rte_graph_feature_is_valid(rte_graph_feature_t
> feature)
>  	return (feature !=3D RTE_GRAPH_FEATURE_INVALID);
>  }
>=20
> +/**
> + * API to know if feature data is valid or not
> + *
> + * @param feature_data
> + *  rte_graph_feature_data_t
> + *
> + * @return
> + *  1: If feature data is valid
> + *  0: If feature data is invalid
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_is_valid(rte_graph_feature_data_t feature_data)
> +{
> +	return (feature_data !=3D RTE_GRAPH_FEATURE_DATA_INVALID);
> +}
> +
>  /**
>   * Get pointer to feature arc object from rte_graph_feature_arc_t
>   *
> @@ -297,6 +367,239 @@
> rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
>  		NULL : (struct rte_graph_feature_arc *)fa;
>  }
>=20
> +/**
> + * Get rte_graph_feature_t from feature arc object without any checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *   Pointer to feature data object
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_data*
> +__rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> +			     rte_graph_feature_data_t fdata)
> +{
> +	return ((struct rte_graph_feature_data *) ((uint8_t *)arc + arc-
> >fp_feature_data_offset +
> +						   (fdata <<
> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
> +}
> +
> +/**
> + * Get next edge from feature data pointer, without any check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  next edge
> + */
> +__rte_experimental
> +static __rte_always_inline rte_edge_t
> +__rte_graph_feature_data_edge_get(struct rte_graph_feature_data *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->next_edge,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get app_cookie from feature data pointer, without any check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  app_cookie set by caller in rte_graph_feature_enable() API
> + */
> +__rte_experimental
> +static __rte_always_inline uint16_t
> +__rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_data
> *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->app_cookie,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get next_enabled_feature_data from pointer to feature data, without a=
ny
> check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  next enabled feature data from this feature data
> + */
> +__rte_experimental
> +static __rte_always_inline rte_graph_feature_data_t
> +__rte_graph_feature_data_next_feature_get(struct rte_graph_feature_data
> *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->next_feature_data,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get app_cookie from feature data object with checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  app_cookie set by caller in rte_graph_feature_enable() API
> + */
> +__rte_experimental
> +static __rte_always_inline uint16_t
> +rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_arc *arc,
> +				      rte_graph_feature_data_t fdata)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D
> __rte_graph_feature_data_get(arc, fdata);
> +
> +	return __rte_graph_feature_data_app_cookie_get(fdata_obj);
> +}
> +
> +/**
> + * Get next_enabled_feature_data from current feature data object with
> checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  Pointer to feature data object
> + * @param[out] next_edge
> + *  next_edge from current feature to next enabled feature
> + *
> + * @return
> + *  1: if next feature enabled on index
> + *  0: if no feature is enabled on index
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_next_feature_get(struct rte_graph_feature_arc *ar=
c,
> +					rte_graph_feature_data_t *fdata,
> +					rte_edge_t *next_edge)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D
> __rte_graph_feature_data_get(arc, *fdata);
> +
> +	*fdata =3D __rte_graph_feature_data_next_feature_get(fdata_obj);
> +	*next_edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> +
> +	return rte_graph_feature_data_is_valid(*fdata);
> +}
> +
> +/**
> + * Get struct rte_graph_feature_data from rte_graph_feature_dat_t
> + *
> + * @param arc
> + *   feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *   NULL: On Failure
> + *   Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_data*
> +rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> +			   rte_graph_feature_data_t fdata)
> +{
> +	if (rte_graph_feature_data_is_valid(fdata))
> +		return __rte_graph_feature_data_get(arc, fdata);
> +	else
> +		return NULL;
> +}
> +
> +/**
> + * Get feature data corresponding to first enabled feature on index
> + * @param arc
> + *   feature arc
> + * @param index
> + *   Interface index
> + * @param[out] fdata
> + *  feature data object
> + * @param[out] edge
> + *  rte_edge object
> + *
> + * @return
> + *  1: if any feature enabled on index, return corresponding valid featu=
re data
> + *  0: if no feature is enabled on index
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_first_feature_get(struct rte_graph_feature_arc *a=
rc,
> +					 uint32_t index,
> +					 rte_graph_feature_data_t *fdata,
> +					 rte_edge_t *edge)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D NULL;
> +	rte_graph_feature_data_t *fd;
> +
> +	fd =3D (rte_graph_feature_data_t *)((uint8_t *)arc + arc-
> >fp_first_feature_offset +
> +					  (sizeof(rte_graph_feature_data_t) *
> index));
> +
> +	if (unlikely(rte_graph_feature_data_is_valid(*fd))) {
> +		fdata_obj =3D __rte_graph_feature_data_get(arc, *fd);
> +		*edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> +		*fdata =3D
> __rte_graph_feature_data_next_feature_get(fdata_obj);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Fast path API to check if any feature enabled on a feature arc
> + * Typically from arc->start_node process function
> + *
> + * @param arc
> + *   Feature arc object
> + *
> + * @return
> + *  0: If no feature enabled
> + *  Non-Zero: Bitmask of features enabled.
> + *
> + */
> +__rte_experimental
> +static __rte_always_inline uint64_t
> +rte_graph_feature_arc_is_any_feature_enabled(struct rte_graph_feature_ar=
c
> *arc)
> +{
> +	if (unlikely(arc =3D=3D NULL))
> +		return 0;
> +
> +	return (rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
> +					 rte_memory_order_relaxed));
> +}
> +
> +/**
> + * Prefetch feature arc fast path cache line
> + *
> + * @param arc
> + *   RTE_GRAPH feature arc object
> + */
> +__rte_experimental
> +static __rte_always_inline void
> +rte_graph_feature_arc_prefetch(struct rte_graph_feature_arc *arc)
> +{
> +	rte_prefetch0((void *)arc->fast_path_variables);
> +}
> +
> +/**
> + * Prefetch feature data related fast path cache line
> + *
> + * @param arc
> + *   RTE_GRAPH feature arc object
> + * @param fdata
> + *   Pointer to feature data object
> + */
> +__rte_experimental
> +static __rte_always_inline void
> +rte_graph_feature_arc_feature_data_prefetch(struct rte_graph_feature_arc
> *arc,
> +					    rte_graph_feature_data_t fdata)
> +{
> +	if (unlikely(fdata =3D=3D RTE_GRAPH_FEATURE_DATA_INVALID))
> +		return;
> +
Do we need above condition? Do we ever run into this? Avoid un necessary ch=
ecks in fast path.


> +	rte_prefetch0((void *)__rte_graph_feature_data_get(arc, fdata));
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.43.0

