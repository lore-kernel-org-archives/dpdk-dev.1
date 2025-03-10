Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D97C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 14:23:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50BAD402D0;
	Mon, 10 Mar 2025 15:23:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 90F8A402C5
 for <dev@dpdk.org>; Mon, 10 Mar 2025 15:23:36 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AE4llH008548;
 Mon, 10 Mar 2025 07:23:32 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 459r0y95xw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 07:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEJOF9CRubQrfdWQCtnNDj3dj5aXSAIdwf3ZbPVh9t4llckFhJgpYC35v4H1MHJw3Xt+plAjzsLf0d7rld85E0sfcexkIot7Fv19IqBRaU4k982OWb7T67fZqXK4a4ZfevxXkotLX1u7ror80ZV61zPCZqGiRBg7mTU6H5JfvYyEMzWKeT6/FZJ74Id7yu11XXQgjaFCrhFvgqMMRjp23KtEjRHHrjS5tbv5NtCr0oFK1WPDN+AF4GPCye9DhJmireTxIhf7ecGuB1etQcZN0kaw4xJD+T6q3aLYnGKGPHoztkYsFF3i2VxXl8zTX3DSePLdbwf8hS1ybdp8BaSloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcoViMu4UsYrZfRQmJZd5hG7q67IMPYypDQe1iSi398=;
 b=V5G+4rpP6UqyVTsxKnv39l81jRUtFzko8M9Tpll0DApNqtjdw+kLg0mEv7eJhj+Jd/eFE9qtS6J98mpRGrJKR/9gdpr1HgZPpOTvR6KsK69zyi3C4jnQkJhFzqD0wwssgzvOcRoi3Ns8iBxWurC0Yz4dBhyBbFmRXviQro0CXmwZ9DpjMDfVg0wytE9fXEzLDts/hWLOkDTcQwI0tv62DHt/DkLCbsW55yhGLPdvyGeEttN6UPhs9NNWJPVo7Hj4EeCOZUSk3DpVVxWrZisr+S0laWsgWnbb4QalqkrtWwSbHmP/oYaqh1q/qff2yt1waTKn4c6WYGgM7kRTdqPOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcoViMu4UsYrZfRQmJZd5hG7q67IMPYypDQe1iSi398=;
 b=WTDfjSwQLDnnHyAExzOJpCGiysLym+Ajm3eU5v8w2R1qhsTj3KmoGjacTB4llnkE1DA8rfRkTlVeOBUI8s1F19FmsXZvutqnolHS+kn5OEX72CPq04BaXZl9/NThfsQAaGlP8eo6if1OnP2oNz4ejtiDEiv87H138amUFdV7s5w=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BL1PR18MB4135.namprd18.prod.outlook.com (2603:10b6:208:31a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:23:27 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:23:27 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>, Thomas Monjalon <thomas@monjalon.net>, Honnappa
 Nagarahalli <Honnappa.Nagarahalli@arm.com>
Subject: RE: [PATCH] config/arm: fix march features not being set
Thread-Topic: [PATCH] config/arm: fix march features not being set
Thread-Index: AQHbkAhb8X7tMvbM6U+GZ95o1C1i4bNsb07g
Date: Mon, 10 Mar 2025 14:23:27 +0000
Message-ID: <BY3PR18MB4785BC97AD137F9FFFACAABDC8D62@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
In-Reply-To: <20250308085902.4383-1-pbhagavatula@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BL1PR18MB4135:EE_
x-ms-office365-filtering-correlation-id: 55a6bd74-987f-437f-fe1a-08dd5fdf1fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gA71AW1SkpS+G175pPR4OP8wwbwopp5lEIbaBgwPD8GWaYmp9ngCugOR6z48?=
 =?us-ascii?Q?YRy6dK+C/Razg8YGV9I/OU4wkxOthi8KnmC5Qqfbf9sDhDRdVN/kY8HAtjiv?=
 =?us-ascii?Q?zIvlwBiJgQuX4C06QmO3Om6YoEsbsYMrNPkQw+L6zaqKPUNpzHVRVZZaLah2?=
 =?us-ascii?Q?ftRxJ+3piLZn6r+d3rfzO/KBxEGeCSwIclF9fHX0NYTZi0P8kFlyGHSIOcKr?=
 =?us-ascii?Q?hULsEN/FcQ088khdtmq8cKnWrhshBiasHs5ylkPmgV8lv5b4f8lBWgafbkvG?=
 =?us-ascii?Q?2KCjtoThKBU6POHgbng20HgRsT6ZxpZUHNrV6eAB5m3pZ+5VaX5cNIW9aS8I?=
 =?us-ascii?Q?VITHxnFTbPPacRjSNZmcuriMIlyFL1yxg7z63JXNd0wF/eltbbRueqbZ0Ilx?=
 =?us-ascii?Q?g+RwMF5Q2INi6WexjA0fcC6TqI4irPdJcaKQGAQA8WhlvLUaRIzjgFQf1BqE?=
 =?us-ascii?Q?kIj2yLZ+f4M5I1PhjP0R6CN6QQDzeMXKP2XWWqKO+WrJg2yrzDbWF1971eNI?=
 =?us-ascii?Q?z+xiK5wBOQyXrWY73vabftuFYX0sGRurKIadDbjRTs/WbDCiuq61qn9iRMX7?=
 =?us-ascii?Q?9ZLDwMY+eAos1XiFK0SRnN96glDB6uQ7whnEhPLQQ5UZK+NiGT+8Yqx0Pt6q?=
 =?us-ascii?Q?HsD+MZbFyCh4dwtHvBlPhR8eWc9vt2yyUv/rx0ODbGHyOpKtFr5eHP4Lh3qp?=
 =?us-ascii?Q?XVou2411LKPdPOwNjVHO3w8whsc5naiLEsG7esiyGydeQHnTEWWYcjQk0nXz?=
 =?us-ascii?Q?FPapGbfZX7NoyYhCnyNH6Lh5ab45xawn92ZpYeclyxb7alNNyZvM1t+KrU3N?=
 =?us-ascii?Q?8/cNlCMiZ88MUL78dd6MutNZOQPd3cRawhIJ6Hw0v/JIvNWm0QOmGZbfX45i?=
 =?us-ascii?Q?D8D6ty2X1PMNmMB/iiIYrHsqezo7IyQOZjB1ZT5gHijAwVDAsfMTJc0/5mzf?=
 =?us-ascii?Q?Q2pZ/Iv3aWp7hLTCacwFGztyDEbah1XIwYo3UrYFW+fjFfWvRNUAesIocWZe?=
 =?us-ascii?Q?maq233lJVJJfQ3suMY7OX4IgODNvNB54v/04sRAHeSWYFC7D6h55BqNecW4D?=
 =?us-ascii?Q?7JWGt10qvH+JGmsnJjlhn+cKHYTAvbcxIfyhMluUQmRj71AME0gPrjfZ7yG6?=
 =?us-ascii?Q?5YFiC0TimTjl6/mFfQm6MZHzkzfWak9puRyEBk9LKrdCaB+VG96846uRcSyt?=
 =?us-ascii?Q?JuyIRYpHl1jejF6CgoR3m7tTAZ8oxyu+F3KmWa5FzxoUg12663oowFsUOTV0?=
 =?us-ascii?Q?nAR4nlnFofmSQklL0s0mPhENE+uUYOLgz0aPsMEM7kXCgNtFW2tcMN8aX41C?=
 =?us-ascii?Q?o6Fq2d7PGOh7B4q1t3MXw51Tm/HU2VaWyVvJRjU/GkiKuG34J/e3oayf0SyT?=
 =?us-ascii?Q?OuL7JKkIrD5t4GSeJ1we+OX2KME/EviMairBDAaDc0MEz7zYsvQTsI36r/Vf?=
 =?us-ascii?Q?eeZU0z8lMMob0bhOutaeX1kFjRPIY8Cs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vLhRFseFFn6o56Z39oBbNiqD4MxMmsjGfM+DGjM9bB7evtVP0SPgLrEDUHH7?=
 =?us-ascii?Q?/WCGTLSCJUuhrJtjNnYhN1Uwmb1xHpBQCwgvhyNXW9txoYLWV7NKwPtYSO8j?=
 =?us-ascii?Q?VClmIrUrQWRSQu40vavDmthkV3c2wcNaFmdjEC9LR6JAliN1tQZTiE3rHUlH?=
 =?us-ascii?Q?rnEWDeVHGWJUHvjqnD+G+TUF5S6CiyMJ6AjXxsExMuyrkj0/oYhe+pcjv8SA?=
 =?us-ascii?Q?9OAsHCg/PCakVGVcFhkfx8xQaLWowS+jLZhWgL+bISS0FL3K/WP9CM+B0QL5?=
 =?us-ascii?Q?VHzKpneXhEgbRrttJjVGbxfxbXOPgbpfLriI/TEzERjBO9M2AXm11bMV7Nkx?=
 =?us-ascii?Q?YgwcevLzC6d9l4u9q8aTB5dHahSyhpOACPnohcZJjPDUWUhEPEmalusj1115?=
 =?us-ascii?Q?vS/g/jmAEndAFrqp1YmWA8pGzUjkYYLyzB/QrK3SP5cr2oI0oiHLl+d0Kf/r?=
 =?us-ascii?Q?ujA+UAUAGoAbCIpex1PTkdIP0ZIhbg7b+BMXhn/Vh526Df0KCc5S1CqL0Myr?=
 =?us-ascii?Q?1zrbiSOSryUNLVm2Jh9x5934E17anc9XDVztACSsSkX6v9TS/xef3hds1yo/?=
 =?us-ascii?Q?ywuf9FWVdC4JEpJKRsLf+Ezzcii4uf9X9Cxn5Nw2lFoihKEeypnIc1p4j7Hl?=
 =?us-ascii?Q?0U6L2zSlzJS0VD5lLNo9tyabyJ0HVYbwK9Wh528O0xq3nM9rL4RoUDeX0bcv?=
 =?us-ascii?Q?uSCEijlL7eRdFdAX5IbAFQMNxCt+k/ihI9ERG17BlotYAkRMPl65x0nG/uuq?=
 =?us-ascii?Q?Q3RQDkR7cBh8Ifk3ekspOB1ZP7dk6SfVFSd2482lJr3aIWlvKR7GU2ADHBt5?=
 =?us-ascii?Q?gVSpOlCRoP/eOvd3ZuOA+DJsR8FZ07NxSo7JhvyM/lZN8xsqbJcP/j9m6Jc7?=
 =?us-ascii?Q?hkx8HseNKQ7gzIuRFLndIyqd5gPpQc5xlCjoksk0MCiDPpI0pb3wbdwm42dL?=
 =?us-ascii?Q?giTEJLnD/F8tSERo1maVDsl7ETUuHTQbPiunCqGXqJPItkNdMVfKzIcEnxx/?=
 =?us-ascii?Q?PjYh67uRC+xoUcvk71ltSecA/tQgjro3StM2EhCz93wdQLys0uq3acjp44vm?=
 =?us-ascii?Q?nfhGjqnTgE+X5+Qzh/q3/8jTA9YyfPRooZyL3VGzIVHkPJfDm/y7F4a14tPO?=
 =?us-ascii?Q?tGMQ+Og+geq7ixOeI2khEooRRXozdIfE0Lo1qXvfVFAAaCSCahEq62dpUVDu?=
 =?us-ascii?Q?ACteqa/bM/xh+24tbHTv461YDS+M4+OJ2Eg7aLc7fe3rabRWatuYKiDAhxUY?=
 =?us-ascii?Q?ZPomQN+Bev0mn/hrB40/689E4StcvuHzoJSiyyJv8ohfK+2B3hPE9yp/sEcl?=
 =?us-ascii?Q?PpGw1D5lToVB6tJ4rI2Xy+8G0h1WD7t3sjB5ImYAOoRrUXV4ElenRQsAV8k7?=
 =?us-ascii?Q?82Y61sTGrvndZIkXrtbAZoELH56QflxYIkaDpcAU0X1hAKioSnBi5XruExwy?=
 =?us-ascii?Q?hBtvop/hYJNZ0Segw9TkoAI+uV5BqszkaYuQX1ssylsDMc8GHPj4HL8sq68X?=
 =?us-ascii?Q?PGrLsWgvRXnlo5WCXy0QrqRoWXkW37aG1PQIFN0de83qUcD24fIkyw3TUOPK?=
 =?us-ascii?Q?higkjK7qf7LkiDQprcuaEn/oKsKDtZn6jlb6KJkE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a6bd74-987f-437f-fe1a-08dd5fdf1fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 14:23:27.3543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxzbONSeUZpf9Buypb1TAnaMAp25M/I8Z5df80MbDz8ok+0o4vit1dRlA2EjIDzm8F+8apFktntRzEufgekL+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4135
X-Proofpoint-ORIG-GUID: FRdqmqonNEeE5HrG2kuGKLjlawh-kyp6
X-Authority-Analysis: v=2.4 cv=LtBoymdc c=1 sm=1 tr=0 ts=67cef5e4 cx=c_pps
 a=E4Q64eWPmlOcdHW0GAz4hQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=7CQSdrXTAAAA:8
 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=8ajjB3yPAOb3uVARH7cA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: FRdqmqonNEeE5HrG2kuGKLjlawh-kyp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
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
> From: pbhagavatula@marvell.com <pbhagavatula@marvell.com>
> Sent: Saturday, March 8, 2025 2:29 PM
> To: Jerin Jacob <jerinj@marvell.com>; Wathsala Vithanage
> <wathsala.vithanage@arm.com>; Bruce Richardson
> <bruce.richardson@intel.com>
> Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
> Subject: [PATCH] config/arm: fix march features not being set
>=20
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Fix extra_march_features not being added to mcpu flags when SoC
> configuration advertises them.
>=20
> Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported=
")

Acked-by: Jerin Jacob <jerinj@marvell.com>

Wathsala, Could you review this patch so that it can be part of rc3. Follow=
ing machines configs are broken

[main]dell[dpdk.org] $ git grep -p extra_march_features
config/arm/meson.build=3Dsoc_cn10k =3D {
config/arm/meson.build:    'extra_march_features': ['crypto'],
config/arm/meson.build=3Dsoc_grace =3D {
config/arm/meson.build:    'extra_march_features': ['crypto'],
config/arm/meson.build=3Dsoc_graviton3 =3D {
config/arm/meson.build:    'extra_march_features': ['crypto'],
config/arm/meson.build=3Dsoc_graviton4 =3D {
config/arm/meson.build:    'extra_march_features': ['crypto'],
config/arm/meson.build=3Dsoc_odyssey =3D {
config/arm/meson.build:    'extra_march_features': ['crypto'],
