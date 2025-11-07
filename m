Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5ACCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:48:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2102540264;
	Fri,  7 Nov 2025 17:48:42 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12]) by mails.dpdk.org (Postfix) with ESMTP id A40304021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:48:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9T5fB8kfaslV7ap3gmdqxtFcmFSbPmEmQ5tK5gofniEUGPsdwz2UBUzR9GohyFv1qprqzNfH0BqaHt7c/kYM++nzqZ+GH9fvk1kwjk2dNkAswOL/CQ3uzrQGKWIi+2SRwSnna7LQy/EvENtDOXMEcntV4+U7slSpKSZ1Fts9PCoB+qKZpATiY3qyGzaFLKNpjk018QwfgRDaOmzzazZhyfZMKSQGboLcflrPx//HL36sCV9UDvrRt+5moN6bflRGweq2cysnFQiJ8qMgG06ZxfpLUI6QYOya1u549M/u9743EgjjzVdyOTgrsD/Wq9g+dHiK9nOyZ3QMBzr2YHF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKr7hV//fM4vR85yGy4TWmH6eYMMh9CxjuF39HuM26c=;
 b=WgMP0YrSGYhTU9dgMTS2cKSvsn04dwEUMtbORORQCwavsruJyt9cK3auY+0THYb4JuKd3HfIKkRl8vNzTwhWxEenVlDuXhRUclDVoVjBRvesEd75/bag80P9YPGfdXmvL78zuNe1ZheHpp4StpRQJP8Tu7AkkhUg9mmM2OplN5SOTVGrRF7prl1m19wMapGM7EvGreGPYJSzhP7mGvSWvcJ7yW30lUGs9cPg1gIZNnCLY2qaZt0hYwJ5AUJozm4LzI4KHQOoEDaWdwL4AmRFywk3cifSDAZFhdoS9RVG0fMzgNWmh60iVfnOS2QnJP3oxmt4Dv9GXZUWNDTboEx29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKr7hV//fM4vR85yGy4TWmH6eYMMh9CxjuF39HuM26c=;
 b=WylRj556UW8ewFZyzYSHW0QZt6CXndAfNIX8RLnDWBS0l+5a98YsAF6+mt1QDBE2MxZagSryg2FH/7nG2ecYYmUZm18K5nqKK0hmtOit74Tnhal2Jfxq4dfbhgn7uzQCIftxAslyfqsF34qr1EGJmNwDTiqdum4YydD7Fh56y5b9g6tX1UwT79b+/ix++TnoeOC7FKnZ7bc8LlNy4D8yrPMECovjtovr70GakiywZxwRYdWAL1S3JCrZWMwTjt8lGXj7g75UsFxdopn6XHqrYxNbjUd/dbXaUM5fQWLEqKjHoJ+1NdKSWbPF3dJzYeY0TRk2CgkFFn2hdUFFFVK6/A==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:48:38 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::6174:9905:2d31:8901]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::6174:9905:2d31:8901%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:48:38 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yang Ming <mosesyyoung@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 2/2] net/mlx5: improve debug dump file path handling
Thread-Topic: [PATCH v3 2/2] net/mlx5: improve debug dump file path handling
Thread-Index: AQHcGPRAf8wYZzRvkk2WvJ3khsxLNbTn2p6A
Date: Fri, 7 Nov 2025 16:48:37 +0000
Message-ID: <CH2PR12MB95411F9B282130E9B0D4B29AA4C3A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20250829144954.2576-2-mosesyyoung@gmail.com>
In-Reply-To: <20250829144954.2576-2-mosesyyoung@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|CH8PR12MB9765:EE_
x-ms-office365-filtering-correlation-id: 320ba0c6-93ad-4d3a-b9a9-08de1e1d7fca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?88f5JOAPomuGBTVzrZoLOwWI199BYS+nziZqu1OlNykjulxHMLadnyg2mfdV?=
 =?us-ascii?Q?O1q8qTQ01PHU9KWdKrsKHq8bjXLJMh/XqtCWdQNUM+d82EyPv7nwn4hbULow?=
 =?us-ascii?Q?iu0hlsrznOyIw1ZuCSOv1DYOBtRmOiRL6tPabiJZRk/iH667F/Fu+C1F9e8L?=
 =?us-ascii?Q?hXO1hdu5aJptskfThcrdtEStdt0syCNDctZUUIUd0T28hADT1tVnuiBIdY3p?=
 =?us-ascii?Q?WLGsGkaDLT8InUhHUXpAvsUlZFZ+h3RavmGRbCmkSGoFIIr3XfLQCnmf7A4x?=
 =?us-ascii?Q?6N88ulN4ErKHKhLDIHMptJB0uGrOXhwVaUWMRL8TIscbgVwivvUgetLbqmj/?=
 =?us-ascii?Q?RiIh795PiT/CPFuUsLNpzD5EAalPytCQ0vSmuyssMBxP77phIIZoGMui2UTm?=
 =?us-ascii?Q?gqVKfIqKzXtOFl7WKw5zgnsM4WaTTee8AbQO12NWGP/KfYeaVgbdTFyupEhv?=
 =?us-ascii?Q?YYJdAFaQiGFpemlteuiIX8v84s9WcGBbdhsplI53dk+QBnEs5d1EZ9YHrWRt?=
 =?us-ascii?Q?TmMO3hXRt8/ei5y91GXYVZYPcNbExjWgsyxvepwr9/EZLX0Hv/5wfWqYpJDW?=
 =?us-ascii?Q?l+g6jFP0xgkTUcIxUAOd0dJOUg+dByw4STNRjdyABDVKTI4La2SBPXtJzE24?=
 =?us-ascii?Q?cvY3hu0H5T/AF0/V1PAnM5CHfVMfBj5y+ZVGd8ixs3Ki0bSrBFQkA3ocEREo?=
 =?us-ascii?Q?6a95qYcV6aQQXRdpySs1129jaSVJhSA0ZzQbMy/gyT60Kggjk5MfbAjfIblh?=
 =?us-ascii?Q?zxDgZQPWnD93xYevpJDimyiQCpnz1sbQdWK9KF60GAVOuP1Ll7562CTAQ+7W?=
 =?us-ascii?Q?/Ol21b6TzDRLtBjwP4p7eSEWrVDFwcwgOFrItnXsys/ew83jahQXZQdwjEiM?=
 =?us-ascii?Q?yz+lf4fGToebgI7wSo8FGEZsV+S5a8L/BUBiKpp9Fhvc2WVff93DqKqdfGtJ?=
 =?us-ascii?Q?NLZHjOKGcKyFTs4QiHVWXvQHCqtfsl1k+MTiq0TgTWW+rzvMCU18mPwCt+pK?=
 =?us-ascii?Q?tivcL43Gy0DBP0B23AJhVogyppJyrPYq5Wfg/dFAsKTxyym7Ai/+wMODQVwF?=
 =?us-ascii?Q?+OWDKqZ5Yo+F0R4tOjUdBUoYPbybCrf6ECXDIvZzE/jRCW+GhpG9yiyuAtch?=
 =?us-ascii?Q?y7CC+2xXFNaN2sYyacvJwqKnfDgKC2iy6BWAx9t2xJKn0A09ct+cOgj1UIwO?=
 =?us-ascii?Q?Nqg/j6GnkixoniZv4WcSrtTE2CKglI+5dlxLemNZqWvvTADVZkhaUO3uVqnR?=
 =?us-ascii?Q?93E9dFrOxBsmBw4TzrJA9UBMIkdyHeYLS+YCX3/I0tNHf/RsW0eWxmp2xluG?=
 =?us-ascii?Q?ejd7fIpFZmKRxLXjuGOfH/RYqs5PC9yrCnLQ36xoKebn4HY84LYiegpixmsU?=
 =?us-ascii?Q?cr3uWTEIz5cVS5jCgfKCA4q+iCQfLZC8AjgG4be5F7tM/DvVAH1//bUTp0c4?=
 =?us-ascii?Q?QaK9Fzz6RerhwC+Ke374B7VpPBwrFicAfXaTAcGPf9h+ekkaHh9Sxji/LFp2?=
 =?us-ascii?Q?jhpAKydeImVM7vrIII7SJCmfFS2SrjRY/dkB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cfpUalHNffylMgjf8V5uk/IExcg4soTvjcMNuKQw8zWoTcZdV67HkxWYL0FI?=
 =?us-ascii?Q?ZnXmaVagjy2Pww8TmmZXjcovZicrxexyzood0gBdSBQxbClr1p/po/RsQZOR?=
 =?us-ascii?Q?8PauW8VcnZGx9VFmLbNCoi/uSbBUzhq5qVdSygWQnj0JfGuLXpsyKDye/QcM?=
 =?us-ascii?Q?VpMhnb/IXZ4VvdHE+EU8mZWnYYySxQqxDBFbIN6EFQ/V5WbFGWiV6cnLqFR+?=
 =?us-ascii?Q?t+F1sg5IeBV0pKpxKtHArJAYsGTB0EXECAUmJVWdgc3Cv3AAjh8AUlSZXuGu?=
 =?us-ascii?Q?0D0Emmt/JjCKR7CDzvpMINHIBYhZAdTQ1OXBTazBHez5jOc6ijRw5IfFjh6V?=
 =?us-ascii?Q?o5IL5+xW4Ka2p+brtpzarbL34wh2hcnisI0Y6hajI87LbGQDLU9frMi9vSeA?=
 =?us-ascii?Q?xzbcxuevchVpu3L8Vg8mGG0kaqaFj2ljhJyyZf09FTFWkJQTeD52hhNEVwvK?=
 =?us-ascii?Q?N8YnzpsxCg9ieMGlwja4GrzDc6IXOTgtFqSC4k6UyL5Tke0LzE2MCArzoT16?=
 =?us-ascii?Q?934JoIcay5mvPixX45aseST3P4KMtoORkB3OaR7UMPEWwokoQp74kBfAfZ/r?=
 =?us-ascii?Q?igKpEQntAGoXYAVfeUrFk9mUhyBAdk3I3edL53oBtz5m/ZlWOq5yoKQtCF3X?=
 =?us-ascii?Q?uoW9m9sMsmxq0r+7c3wPuF3u2x6ht7Lrj6x0ACHj/6w92pJ9l0e4qblpi7FA?=
 =?us-ascii?Q?cTby594GvmtD7fuASSskQIe37/bLZD+MAJcK1/8kecEhjGSEKqJkFYq/wZFM?=
 =?us-ascii?Q?dyFZ9ex03Va8jiT/i6rMABhJ3j/cgGR3J3PLM6Rofq4euPnhJFt6NguprTCT?=
 =?us-ascii?Q?SLKqJncAYfneGLwQRqYk1UqpTSBmmze8ItP8ecgvlH0IzjjHukis6OLLCoWk?=
 =?us-ascii?Q?2RcPFDOa0uHp0n2xkTdEdAnE9HAJQUR8NeCULyjFULfEhp8i+DiDEdrlRZ8X?=
 =?us-ascii?Q?FOpUbQ7U9rO+bVPPkwO7SxEwAJYcg9DxQ6yqKcrF7Ow0xRh3VF4YiwfBJlzj?=
 =?us-ascii?Q?PZpGd7n+FDgZXJe0gHF/hTVa7cm97H1xQhDrbc2f2uxgtkmHE9uqN9nVrB3K?=
 =?us-ascii?Q?0Tn4Ctc6zXzqHQogSnsgQ2TFZQG6oRc9oPhQm0MpF//hLIWpSTUroleOkEvQ?=
 =?us-ascii?Q?gg/g0hXPVggui9XHHv6nq8t4k++fj2vQ1aA79T0VHLXZw13tpgCRLZOwgqiS?=
 =?us-ascii?Q?CuQMVx0hT0rNAsNWPbedGwmfMrNb8qsBG+Gmlz49hbbYnwiisizvzk1seN1n?=
 =?us-ascii?Q?UinJ62meYi13TNYP8hves299BhK7Tvje/OuFkNc9/okqL3YIsRsiNiciEnvz?=
 =?us-ascii?Q?N+RhEUgr3C0CV/0F6JduTsR93k9Y4d7t8B4sVsDUFcZjFNQddXrRSBxNDDBR?=
 =?us-ascii?Q?8cwr+hqDOsFpXrhYAGqsYTkh0ev+OUKROF5ZojHbuEIdXi8SLZWKc/UH09uM?=
 =?us-ascii?Q?loH9awAz1HuKp2oSHs/2d6FTQM0qGcMBP3n3tpHJBBhzpSAZAkl0SGCPiI0Z?=
 =?us-ascii?Q?+Y4Bw5wqczskfZHeh1hWRGMUA2z7ey7B1SREiNKXSoD/h2OT88h6VKPr6HWT?=
 =?us-ascii?Q?hZHDcK+KceuklwYPzQgskj37MooqJ6DTxwHPAnzl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ba0c6-93ad-4d3a-b9a9-08de1e1d7fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 16:48:37.9349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbGDxrORyYPl8g4BRvnGWWsBAXSlN6Ty/Wg9Y9f6MMVZEYkJUkQ4XI4LBJMJf1kG/RJ/NYt1x+l0SAOiI1GK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

Hi,

> -----Original Message-----
> From: Yang Ming <mosesyyoung@gmail.com>
> Sent: Friday, August 29, 2025 4:50 PM
> To: dev@dpdk.org
> Subject: [PATCH v3 2/2] net/mlx5: improve debug dump file path handling
>=20
> The current implementation always tries to open debug dump files under
> /var/log, which may not be writable in containerized or restricted
> environments (e.g. when the filesystem is mounted as read-only).
>=20
> This patch introduces an OS-specific helper function
> mlx5_os_debug_dump_file_open() to unify the logic:
>=20
> * On Linux:
>   1. Try /var/log if it is writable (kept for backward
>      compatibility).
>   2. Fallback to the DPDK runtime directory.
>   3. Finally, use the current working directory.
>=20
> * On Windows:
>   1. Use the DPDK runtime directory.
>   2. Fallback to the current working directory.
>=20
> This preserves the previous directory preference while ensuring debug dum=
ps
> can still be written in restricted environments such as containers. The s=
tructure
> of the open logic is kept unchanged so that test cases and expected logs
> remain valid.
>=20
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
