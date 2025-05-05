Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC3DC3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 17:20:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FBC24025D;
	Mon,  5 May 2025 19:20:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C85934003C
 for <dev@dpdk.org>; Mon,  5 May 2025 19:20:09 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545FJ7De000405;
 Mon, 5 May 2025 10:20:09 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46djnjkfsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 10:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRIw3m/4xTbZbqF+9g5Z1aEEsDmGpcXvEH+09wsPuOnNrMSN4kvZIgxdqK69WmYeHBTqiW/1GPaJcSOkBdERT2w6C3h1+S1OWxmzWRW/4UxDeWHhFBAfXeivGhicUKco4Fce5L2FkHoNFeFoBhCJK/UfcqLiSyf43JXiXHcl2yozQdFVrgWDNPQXa6QcSnm/St4VQwCbKwCmAkkQfAQGFtmfe490ITQeK0uHGi6B2R+QV9RvzTsF1am87HFoO54AtG3y/eTljeBZk9Iky/Y2/aChXgZuUIew3jhD2hEShxhfManETGv9qDLRe56py9xVOE6TUjdhTCepyIIyfo20DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St6XOwq7q8SMrFtipjnD7JlBeuj3aM7wHdMN/nvXofk=;
 b=WuioIZu+5+o3WAJcPYOrSbO33WB95VaXsr150zZjpTtQzPtQA845Qo9i4+ad0gbH1GlnEtQ+XLF4wt8YJOyZy8plr9rpNd2jNjLudbbyIC0XOqgMQf2uLSiAXN5KV/qYqap6w2vh991/YNpjEQhc+RijcBLaLpn+l5Utfzf592wJ8yQNbaKRJjgNUK7KiUYDur6XliTJXtpt/6cm6h9+flEpJZe7oICmS/Jld1IotHs3/12tkJgONLUpKV/xPju7fjuodyB47wslql8sw1CwowXqWiExr+3SUSKzoJ12FCya8UPakTw4FzQKnRwBy4VCxPaWX/KoNtBazy0NXhfAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St6XOwq7q8SMrFtipjnD7JlBeuj3aM7wHdMN/nvXofk=;
 b=PZ3v3asnogGSYzp4OISkCaCijS4b4QEF0lSmQtgzOVqFmyAYSANkdvVaN2xYM7W5bRyn0L4oTqUooo1oxeo6akD5IAJHotSDjXAywXh4uum1LUfaWA6z3XCH5H9NFXAXRac0eUNIhoSkhgrQfAM2QUDKHkrEo7vqANarMmcru0A=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MWHPR18MB6368.namprd18.prod.outlook.com (2603:10b6:303:28a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 17:20:05 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 17:20:05 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Robin Jarry <rjarry@redhat.com>, Christophe
 Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin
 Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
Thread-Topic: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
Thread-Index: AQHbuCmE8FMhrG2R+0O/+i1EBplpB7PEU0ow
Date: Mon, 5 May 2025 17:20:04 +0000
Message-ID: <PH0PR18MB4086935DAE2F110A18D2059CDE8E2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
In-Reply-To: <20250428103711.3317231-1-nsaxena@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MWHPR18MB6368:EE_
x-ms-office365-filtering-correlation-id: 85c1c4db-afe6-4c9e-2dd0-08dd8bf913bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YBCW7O3TW8OToFxycRVAnHAdPK1aidM4ITYsCpSvz8kyq2qwb8sj1ZsL1Eyo?=
 =?us-ascii?Q?l5k6jZB43LHlyZNPEx0NnlGHfg7fD6tbUcOYQ8EvTkndv233vxf73gvwKDmV?=
 =?us-ascii?Q?xREfU4bsU5xZL2aK/OcDywkbZXH6ZpgQKEwgkZ6boc57chipYld25K1tRgC4?=
 =?us-ascii?Q?gUYjaav2WoCVPaBm2XYM1/rjMmqL4jDoj66p2hi3eSVT02bOhE62aeXPWulc?=
 =?us-ascii?Q?+ICYlG278dWGGH2emK7lcS4ypJcEqk32QMED3iljnv+BWWAj36hoGraFSr9w?=
 =?us-ascii?Q?nylt+hY6m5i+y8fsThVQb73+x0Haqrjev1i6vEyOn/U+TUzR8lKReDXAiMpN?=
 =?us-ascii?Q?0Y/tXXDBzElruYMQ34/bsbKmv3/h49p95y75wtiP9WH+dGO3iIIrJQ8IXjMu?=
 =?us-ascii?Q?1qi89hU2UF6+YuzIqvF/r7SPC9UTjz+k/T2dPbRViolUGKwPOhGG7LQBFcd5?=
 =?us-ascii?Q?X57IeDwrm05Z08Tw3DginhugikDpSv+TqNN+nFRGSbUqpPpFh09MDTBEsx78?=
 =?us-ascii?Q?nHkdOx+1ArUhTjDqJfkW07A1ISn9WZ+A9oFrsryQ+O0ggbAgnAkNsV132mNI?=
 =?us-ascii?Q?jytT5h1BL3SQf5Zp4tXKgpPoatq/bOrCklBpxvHvY/UnyM2iqaUfkMzcjMJE?=
 =?us-ascii?Q?4IVsH/BYCtrUplB2cCN0U21Sv08Wi2idivWcPe/nRbEopPYTivXdYDUa6CXo?=
 =?us-ascii?Q?C/8Lda4K23CkdDNkyhhkMU10P4tIIgOmIR+NZ5KtwIPCwGBdHseYEOm466HY?=
 =?us-ascii?Q?c+oQn5WXGQ5A5slg0b5VAZNDK/ep3cXfZ3C+YWlNgD3fHR1w4SXBggUNiQVN?=
 =?us-ascii?Q?Ydgqx6TdeuQu+rGWS5QThbR/hCeonOXNlOBfU3shBpOw7g9yclLjmUgQt57H?=
 =?us-ascii?Q?JXveKXTWwqYijflMkBISMud2wgOkqO5hQ5W5Rc4epfr2rnMf7ZmBAGtY+5uo?=
 =?us-ascii?Q?z61e4sfrDPpyaEniu/uMVHikpYSe3Jexv7YdL1RMZfhWN1lYB6NJPa1vrkOE?=
 =?us-ascii?Q?VPfQfghJZUZP2MGC1dURX3BFMAUjKJVfIfrZ3QmTXg9A5PSPne4NNjtbhM84?=
 =?us-ascii?Q?ePFvegUrkxrU2dd9AneZBNCyM5HpLta9w25F2oSN3rhEBfotao3xEXtFFAMm?=
 =?us-ascii?Q?w7qLbwA6BaIeU+XYAFELKmUu5CGGZrPop6TwYCk66FGQxgNEy+mnnzob0jFl?=
 =?us-ascii?Q?ameVc/QmDEIbToyd9ZJFOmKbDb+3reET7Pm7Gr68fPFYHZfXjMzBIcXGVnuO?=
 =?us-ascii?Q?r/5HH+PxaybMvJjoKoWoeq+KdrzXN6HFCudhUEWoYxFxkDDTx5Redpqbw8SA?=
 =?us-ascii?Q?u84j2yrTx5rjvP9cBo7SZ1U0Rmm9F/+ei+UJIqYGU3QF8eO3zb6W+ja1ivY1?=
 =?us-ascii?Q?zxUUfAckjQCb7DNQW31qgu1fra3pk+YyGWEI4KLwfIuHI7TTfuZ/Cqkdm2Zm?=
 =?us-ascii?Q?Qqk55V+hOWNckz7f4D4kLRazBABdpk5hlWjdvkb4KvrmVSCfjp7JKASN4E2M?=
 =?us-ascii?Q?CbIbTqdxiKT3hoU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d/MlGAjJbKy19OuZi4u2J29/fxRmr28EEItYnf1G6pHBcQ2U8b7Gh/svcpuI?=
 =?us-ascii?Q?YpwYGo1b2hziMWr/si9xa3pSr9bYHg21Va5CvlczrO8ITBFWasxyJlNVauC6?=
 =?us-ascii?Q?XXnAe0wBQqQrfUfkQeYjma6OGevPQXDQphhnapIdGpJ8LUfD7EaKpse4MDdh?=
 =?us-ascii?Q?1J/cFrRb2bULR0K9M9zT7cXKuWQPShv+fexwJlP45lkeMMfZRoM39ddrH5qD?=
 =?us-ascii?Q?NE0zH+Ha4dAEEc4z38RkGyFKEyKTTtrGRiaauXtyOsfevhsthW9qnOG+Lyty?=
 =?us-ascii?Q?Nc5KIFJ55MKsnzjozLeAFP8bSzfUdOYkvQtLyurbFIxDFfUFdlBOHJDLPd/B?=
 =?us-ascii?Q?uL5xn3lDGfE+HtKioeUnFDSpO2RGZQuv5qA/vzptTIyxGgDWeRE1aVTJugyM?=
 =?us-ascii?Q?egPVngh0r4uqK2QjUG+SPutsORd13M4oLL6e+HPIatf2G9PMgN/20NOUulDw?=
 =?us-ascii?Q?YwI2Wfyz9vi/ZrWsfX0kMllv9vU/iVAxsx1JuCokM8hXhPpTYdPfRmqBILcq?=
 =?us-ascii?Q?nZXxWAu7joFVVafRbBaI+4d4eaXh/6kBFrvkhF1xDrRdGF5TlvNgrwwj/hDt?=
 =?us-ascii?Q?ceHOerw9IzLP8vMJZOmqKsIuuol12nKB0wJ8U4xyp+MPUFkiC+uw3n5Gdp69?=
 =?us-ascii?Q?guReo+Uo/+D9LOcLFPc2usAnvA51YOHegtyLIrtBByr/RiboFKsqAEvRZFQU?=
 =?us-ascii?Q?VzHJkjXoCfMbj1nm+33NgE+HeX2jQVIevnCBCbbEpEsfDny80iyoUlNm2V8C?=
 =?us-ascii?Q?4kpX0RlcU3KQXALLmqurZTdWrYevfr/4YLhcUJOc7PVdcjDCuqrpyGelsWhl?=
 =?us-ascii?Q?wQBN38N5n0PJcO+lyyXSm0XvMIaxK6PYR4CXAbzZfmITmxfpoPYPl3WH1sLr?=
 =?us-ascii?Q?QYX3kkfASiMlQ9pnkgiMhKI+vfs1LxqXWBhV4aW0U77XZhhIa7OR0YmjgSSw?=
 =?us-ascii?Q?NKN3YBhqLiJXVvWS7EtE8XQy4Rb+ZkTJlW19yP1hhowEEfRNlLIwSpqZigeS?=
 =?us-ascii?Q?MGyj2VCr4M5tRIKUgRKIX9fdYUsjU7i7lK4amTOaxM/PnbrLCYbz853jbTs7?=
 =?us-ascii?Q?AN/Hrq2o/DDjF7ryzNsSs1qTF26skr7WMJUL6fuwU3Dwrq64DPYqE9zEv367?=
 =?us-ascii?Q?CDyKs1qh5t80qIdDQ2hmBkGEnp3lwiXgCaaR7VGhDjnna7XMFo2CQK7HYnQ+?=
 =?us-ascii?Q?k/a+PATs4eZJ55kdWf5vMLbRojsg3oArZTQlyqTMNvUYPgw337httDd5RgIQ?=
 =?us-ascii?Q?q6xSnP0zBwnQS5X0iCEL7kHT0xb3evCeQ2qpuRPjLc7eu2xhJ6/GmuiYFTzX?=
 =?us-ascii?Q?R8g6d95iMf+vrSicDgKueTT09tIy2J8mHWcsrM5UuAVrfaM6WgAzg/PmUVDb?=
 =?us-ascii?Q?jeOQHsjR82RfxZbdfuG+/NxWj/cW4XYc6ScVzg9zt6k5seN47Fz/RkhnqUwW?=
 =?us-ascii?Q?vsGzk7H9XVKv9wbRhmlaK4sER7zv0LNAmjYajKCFBXOckN1IOVwm1w0y8IrY?=
 =?us-ascii?Q?Vw/caU3U/sPeMZke0OqybejjRFnMi1f6k81ONi6OGFKUSBOyhtNOv2AzPhCH?=
 =?us-ascii?Q?coNEqLEzwNATMYNcHYqIphsqkkIUb9yOan+C/coW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c1c4db-afe6-4c9e-2dd0-08dd8bf913bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 17:20:05.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUSsWWfZDBHXcFZnNLMyd1N1+7XHmFaJ16VADPms9mWIjTi2lYM9xpVxJE7e0dt4Oa1hmEg8Grr+ffN32ApZiQyQwN2UMAcNiewfCoKRfZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB6368
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE2NCBTYWx0ZWRfXxle0jkdzFz+x
 mF2xUteJUpnfCro7XLAOqX1k01p/YoMYyYla+k9n4NcUVFLIXKuLpqpLUYE2uRc+Klld/clS4vE
 e/Vcd3oywovcfUjhYUHd6Dp5jir61JHqtbqJpHkr3MKS91YqNwtYnlAIe58orK+delZrzaShr7c
 ZdQ4v7AbGDFI9BvGommhCQq7EgKE2XH6ouy2/TE6saFwMYMSzVAXnUyV19En+etJ4CMSOusaDSo
 j2SsreELjRKSNzs6rQauKtgohZICzhfl6vJ6wAlX2lnOW0h40stJ6m/gjB3dFMAnnpuoKbQS3l1
 le0HhD1c80wLqY6XBt0YLd/nyHDUwpk7pssSu+JewM20gUC9TXjdBpcb+KkMs58gA7Y19X2gt1G
 PSBZOXtY1j/UkSvAv7uNvRJBzCb6QGG05xFPS6qGPXxuGwh8qgI/YwVh0Hs8bSKPMlCT9eq2
X-Proofpoint-ORIG-GUID: H99RHxtKaSenwa9QHCSvYA2nDMxbIrtQ
X-Proofpoint-GUID: H99RHxtKaSenwa9QHCSvYA2nDMxbIrtQ
X-Authority-Analysis: v=2.4 cv=XNwwSRhE c=1 sm=1 tr=0 ts=6818f348 cx=c_pps
 a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=eRU0rlFC7nD1RhsVKvkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_07,2025-05-05_01,2025-02-21_01
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
> Sent: Monday, April 28, 2025 4:07 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>; Robin Jarry
> <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Nitin Saxena
> <nsaxena16@gmail.com>
> Subject: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
>=20
> Currently each rte_node registers separate mbuf dynamic fields for their
> own purpose. This leads to wastage of mbuf space as once mbuf get passed
> a particular node, the registered dynamic field(by that node) is no
> longer used.
>=20
> This patch series adds a global/common mbuf dynamic field which is
> reusable by all the nodes(including out-of-tree nodes). This helps to
> repurpose same mbuf dynamic field for other nodes. It contains two types
> of fields: (a) persistent (b) overloadable.
>=20
> While persistent fields are those which does not often changes during a
> graph walk such as rx/tx interface, buffer flags etc. Currently there
> are no persistent fields added but they can be added later
>=20
> Overloadable fields are those which can be used by two adjacent nodes.
> Same overloadable fields can be repurposed by other two adjacent nodes.
>=20
> This patch series also updates ip4/ip6 lookup/rewrite nodes to use
> overlaodable mbuf dynamic fields.
>=20

Series-acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
