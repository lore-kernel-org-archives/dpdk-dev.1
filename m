Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE58CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 14:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFDBD402A2;
	Fri,  3 Oct 2025 16:24:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EF80040277
 for <dev@dpdk.org>; Fri,  3 Oct 2025 16:24:40 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592MDVi5031638;
 Fri, 3 Oct 2025 07:24:40 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020074.outbound.protection.outlook.com [52.101.201.74])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49j20e9kg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 07:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWFHW7u/JsViyHvdrLxjMJT3RFXLZ1ZqnaChBI9Z4hPhk04ksdr7rVZZNgDWmBvp5ziEOlwciMu272+T/idiOJMzS5bx5FMC4PLdfPbThXbxOZpgJ8U+5qZWsEE582VPBYKEYHQlkTp9zUAHoKXAcuohe1TOVwxsYDD/Up13a1fzR6NQjNGmFi79g0RXhHKBY3YVM8zgIAKwnT4QQWVZ80TMd33S6bEdXPXgQq7iyM5Ypjgs11U4smh5L9M8AnyQnwqdNPQbZVewnRfbKTggsHcxOUG7PXIxmzDg+XQsDdYNMTTBK9A6CEwS8RhgiLzEvDViuIhrY6nEw1q7XALhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsZuQFxuhcBD2+07yn3kCCADfA05mS/6FdFmpYK7nww=;
 b=AIi5MicwoAcGix2S8F/SrUab0oyG0SGrKDVeqLUK6CietGG+48fiXPcffVoLdvomfj69foVPaH4TwwJ8KdUqLEVav/QE7yxGFqEhSd1/wK78x5zsAe51o+QTuUmee5gEnbUPHrFL7EQF0k4kNQxNvVQJsPM09effS1pxs41uvq+Pn6wc5qBEN3yXvNZ1W4u0+2WrX6H4NHRWr6QVIshuCYB5IyH44g5l7gYXTpUK0oDzukLRv8nxK7AGtnTSgZ+UcufbMQbTxW3zM7XKqEacG4dsB3f+X6KLliPrIZHNvS+hxGz40/SbukMIsDaeyzo+L/a3UwPEV5QFFuCsacz2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsZuQFxuhcBD2+07yn3kCCADfA05mS/6FdFmpYK7nww=;
 b=mwPLNjj4HBv/1KmL5yBWAWDz7CjG4bUnYcdOXgo0qTqDYJRC27YvnWWO8AOXZ+Hko4JD6BWWgPskLdsghAQ7DHoyBFIU4vDi1+dfuoMbMOb3frdw1H26gqgq3mn2pgqi8raAGeXEVEzFYMQ4SnZtezAubufjLwy7pG5QKT8gZno=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB4387.namprd18.prod.outlook.com (2603:10b6:5:342::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Fri, 3 Oct 2025 14:24:33 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 14:24:33 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v3 1/3] cryptodev: support PQC ML algorithms
Thread-Topic: [PATCH v3 1/3] cryptodev: support PQC ML algorithms
Thread-Index: AQHcMvzUBZM+AJSlg0umVh42D6xnPrSwPjvQ
Date: Fri, 3 Oct 2025 14:24:33 +0000
Message-ID: <CO6PR18MB44849B4D2140404AD4EDCBAED8E4A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251001073758.1295-1-gmuthukrishn@marvell.com>
 <20251001175658.2303-1-gmuthukrishn@marvell.com>
 <20251001175658.2303-2-gmuthukrishn@marvell.com>
In-Reply-To: <20251001175658.2303-2-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB4387:EE_
x-ms-office365-filtering-correlation-id: 58d39aa3-5c15-4eb0-6868-08de028892af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LTCeMhbD969ytBsZzmhC1bCB6k0YQiyyGJYrnV8CVJ2FCKGUhpZPCHoIcVdR?=
 =?us-ascii?Q?bpBi4V+KeIC1gW4mKgFSyXMfW8S/hNAk3UO86cc7EABYIBdT9HZaCeRxnwZU?=
 =?us-ascii?Q?wn4g+x2ogYlNqtRNnvdLV+nl9h9KCg+Jo0K8Voj9g+DheVDQ5IVZd11i0TMC?=
 =?us-ascii?Q?DvPNVLop7iT0Cf2eno8ijopPyyn0a3QxSysisD/a0G9MVQbx78HRqCkqaKOa?=
 =?us-ascii?Q?rm+jees693+I0UpbrFv9YtU5GwwbXV9kr56YOnsFj0S/69YzYIcrar79ghwV?=
 =?us-ascii?Q?qBBLE8GKPNxFrLc8tS5oERRp+4TaL0UKJ40lhUwQ9DffWltBJEheVlGnGpal?=
 =?us-ascii?Q?4A25gX1u6v4DTDSAtl9Tkdk8lFIF2WJR5nFlx16ZBNXg5IBnVni9enJTU7fb?=
 =?us-ascii?Q?fmIT44I1jr/977mqflCmYlMM8xl/u6uf1D5D3m+GOP3sGLG78/ULNTj7PY2f?=
 =?us-ascii?Q?pDo0LZdy7INi4R5jRu7HRw4nkYXktfNAv4HOq43zL0Z7CVH7X8vkV2TwRtBU?=
 =?us-ascii?Q?OydHCdWIupzZ24OJL3XSRtC6ClXzaty3aCPRUnSs+mTrv+uYERLlxWTXX3GR?=
 =?us-ascii?Q?mcNY+3Eaah1BYMCes2s5a5ow++I4fOoPoBMfGqRkZkY/eJ4L2Rhh6HO+cvJ3?=
 =?us-ascii?Q?Z5meQewryDrMItzsMyiyy2dfuoprvi1OT2+PyaNKWiqNUein9qFH7IjvhNdn?=
 =?us-ascii?Q?4lC1yWqD0lobZadF8/kwysm6s2M29IzXbQcUigX7l0l75Z7zLfbybbVr8ZWA?=
 =?us-ascii?Q?e6QOVSSW80L5ZlewumEVe3y9ZRJxZ2YLr5liwTkhj6cMM0QKK9XoLJoGIh3l?=
 =?us-ascii?Q?rofOgXSyZzjHXqlgUfL5uln36U2QpqKNg3eNf93l8TqAMu7w7Nk5rWUraL9q?=
 =?us-ascii?Q?dzVh6yPquRjIRjeWar/Ar/u273ntZhVW2Hayo0M7Gftp+IEJpzWReMUiV/ZI?=
 =?us-ascii?Q?MR188eiNTxa9DaE0qyeMZL8y4dGNVf8I6wb3+IyAI7VXi19BwbpVkBZLp6kV?=
 =?us-ascii?Q?wOc8EFnbcIXEssH0PQVPAgdwyz1p/BoH96K6hn1rNbXDm/Enw4ciHq//x22X?=
 =?us-ascii?Q?Vs5xpf26HaaZcBjUaVJIjOQAatFNtyIAPuIjy7Lth70FAJJIZ+qMA5+DI9ej?=
 =?us-ascii?Q?DtDCYBaiDYD+v/JQdJtAeSpB1lu+bBLVrJx1dapuGIN4x6vXF5Y7Zj43WVTe?=
 =?us-ascii?Q?p+84M7ehEWVoMzFCqe8AGdk8zWdFWJmHqgzL8J6e85odylMCsQPFHGWl1rfX?=
 =?us-ascii?Q?Nt2PRzsgl1MF141IvpsJ7YPeXrZabU4J/0qKFL5FFt4UYvurwOFkTmAMZCUi?=
 =?us-ascii?Q?2S9PhW9mFocyY5TBTjKkNCZac+bGeMnw963OGjlxPGWl0BphC/pUTEqBCqkz?=
 =?us-ascii?Q?sH8jdW703pY3Hf0WNqy8E4tZ99D67HWiejOQWIwZP4l1+JPjgUvRykiPJiSg?=
 =?us-ascii?Q?TTECy5t8IfmQRKzKmW2v+zbDMkZ27FeJbhi7Im9pvNyWKsw91qQnAcTIrUnL?=
 =?us-ascii?Q?HMOp6DKSe3Ls2nmZ9pOdlqO/hf63kbqZ6SOs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0QtGIoGbWdbhoHtP0n6MYEARRXeGtgajwnFeT4LlURVLWbVeulFnt9Uowh2q?=
 =?us-ascii?Q?ASobo0SIxToqrhXpk4yBIGdhBqf0o2Gvzo4cbs4zWwAg0px8uqBNFa9Nyj0U?=
 =?us-ascii?Q?PfMLCjASlj1FN18bMjAxurSYEohUp9JMvfygVTNYnxPMP3pYi/2O09b0rDCq?=
 =?us-ascii?Q?S2FZk6wpkxw++I6tayWoVtLLKAnrytrmnApmfSxIIuh1Rg+PF5U/0MWd6dbC?=
 =?us-ascii?Q?6/TiqBgx4xAliLTGU5baCsqKIf1J6b0lh76b0dYuUmJXK+8ddmfQPCV8nxeA?=
 =?us-ascii?Q?XDHnsFBdmJ1BLQcAxh9yDgvZeMlBoR3eeKVqhPz5CKoYxRpyDZIBdsVFrgnz?=
 =?us-ascii?Q?4XQSKKD86TC8RzCi5Tnebn58snW6ERakFanfczmRxwYnY1BqRwhUCADmboT6?=
 =?us-ascii?Q?PSm9QNJDywSaAyPm83jJAA5MWY0QMLYYHN258HBiigHsWMfTVhilu53uxCZS?=
 =?us-ascii?Q?7jTThnB5tXrdJQbJdw1OnDr/wRJzob5Y4uUSGXgeHt/FIyYS4ELdqOgWXCPJ?=
 =?us-ascii?Q?/q7osmcdjtUiSa2HsQxip6bhVYYwKGQ9cRDVljMkUAj6Vkid8ELwTIyoPsvg?=
 =?us-ascii?Q?TDonfXr1KgYjT8F8Y5gMaYxhYa0WXTmQQTD1TNu4vGAfaDNB5dXUUlmAXgc5?=
 =?us-ascii?Q?ojGf/BLCXCQ1X+7z/O9v+vTJIwO2nSFMhZcBdvPXwcaBz36vv1tlRN1u3QvK?=
 =?us-ascii?Q?OQm5rxHZFxgUDJq2iHuKTgw62vfxWHpdBdfWHiu7FoySSH+cXo7vrKZJ03lW?=
 =?us-ascii?Q?/w9u2HxvRfS1AzmovGy5s06+JaspRegj1sILlHy/mXCmbXJv/UsarasEv8zJ?=
 =?us-ascii?Q?plwQGCH0p3GlBqMuxO32mzFa9KvW19wjk3gU6UrUt/Tj+w3aP7uhNXx/05BM?=
 =?us-ascii?Q?Xyz/4YhiIOx9B1vlDv+SG4Kfu1316Q/9WgCE6sRf37KYIFj62aKPbueBTO5s?=
 =?us-ascii?Q?PKIfgCDXkln9EKfF0Juu75LUHePGzTUy7wAOznEg/KjjH7cO7Dxf8LrtTAbr?=
 =?us-ascii?Q?ZFbn11RoaNif9bY8WU1Cg2GiuvsOgfDgpeogjQmeQya22hFYS44mkho8s6lM?=
 =?us-ascii?Q?C1UsbUmobt0o23NdUyF7QRdeE8CIn0sJdAz663QGtAQMo29X5B8QTU8N1PPF?=
 =?us-ascii?Q?44/7XhXWxlufZCmungv489R4EU7EphCCtjheZALZLJP2R9bKWZxGLHFQB9O8?=
 =?us-ascii?Q?0+AGVUfd6SqLMZN7ClzIoAghgzcf/cUBKDASKfgA+vC9IiBoKxgmRiUJvJAT?=
 =?us-ascii?Q?kFGmvDoECaUqzB2SV6UxVD9o2A0n61qWFnNedbVBCCRIVp87G9X1Jp1lSQz5?=
 =?us-ascii?Q?DQpvMnppjPry4MDveBNgCeFXonn0jz4CEfC4hFQhhspwUecmLHCGLgsyVQK9?=
 =?us-ascii?Q?s2L9w71chB1n7PYfllJQDCRpgRDDg/m7LMN5WyybRGwV0/URQcJ0xioAz8eK?=
 =?us-ascii?Q?VDBtspjEIfZIEqW6a6a9y8WHLb82XP8/Yvg6HTAUyaIjY3SpI0/Pd2xkzI41?=
 =?us-ascii?Q?sPLb4JcqjXMRp7cZ1BjuiEScaupKizqDckfaWUY0I6EYu5ddAkPqJaEAMTdm?=
 =?us-ascii?Q?cuAxkQumjOXVSRIR9ac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d39aa3-5c15-4eb0-6868-08de028892af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 14:24:33.2915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7xIj2Q36Zk4lBWGLrKbNRdcgSnMgy6aRzjaENA0VihQQKzo9+utB95eHYkzAK6AHUw34uAhIIrvOGs7ynm1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4387
X-Authority-Analysis: v=2.4 cv=S4PUAYsP c=1 sm=1 tr=0 ts=68dfdca7 cx=c_pps
 a=9mF5moCRh3baUhQ7ZsOuTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=tpm3l12kxqjV73H0KZkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: nH1OfZGWoFuNTEVxyva5opWrmGsw-Y9s
X-Proofpoint-ORIG-GUID: nH1OfZGWoFuNTEVxyva5opWrmGsw-Y9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDE5NCBTYWx0ZWRfX5LqxTi4fzh0l
 AeIYz+U7SZWqtr9KVzsjeNabykH6W+D7wfDFpXrOYbMl5K3hHOGaSfzWAMzpxI//gJDbxvv1Pqc
 DxXaN8IAzGrtiNy0WR9+zrWOJtVH+u5AVrktyUG2yXM7SJaSkjGXdV1L68U8hdfp3AXdW4pR+Fi
 68E+Q71Zfn2E5Lmh3TvBZ5QbgTwXePD8PPZlhdK7eaMb3JGQ+ydMFiT8iYXL/tfrzbK8Nfbbz+X
 0U/AW4NHuXcs6UnV9dU27XdywJYqEE176koaaxhZdra6DYSXF5UWfbPzqwQxiS4eS0WNOMj4Ihh
 uTrjw3tAnFlejck75S5uSrQpEe4juxXO8O8mEFpH6ZNjj7yb3jiYpV5fQMGU4Wt4DbmfT2ACGv/
 TEy6yTtf2IoydWHMmuaBrqiAbA53zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_04,2025-10-02_03,2025-03-28_01
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

> Subject: [PATCH v3 1/3] cryptodev: support PQC ML algorithms
>=20
> Add support for PQC ML-KEM and ML-DSA algorithms.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
>  doc/guides/cryptodevs/features/default.ini |   2 +
>  doc/guides/prog_guide/cryptodev_lib.rst    |   3 +-
>  doc/guides/rel_notes/release_25_11.rst     |  11 +
>  lib/cryptodev/rte_crypto_asym.h            | 306 +++++++++++++++++++++
>  lib/cryptodev/rte_cryptodev.c              |  60 ++++
>  lib/cryptodev/rte_cryptodev.h              |  15 +-
>  6 files changed, 394 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/features/default.ini
> b/doc/guides/cryptodevs/features/default.ini
> index 116ffce249..64198f013a 100644
> --- a/doc/guides/cryptodevs/features/default.ini
> +++ b/doc/guides/cryptodevs/features/default.ini
> @@ -134,6 +134,8 @@ ECPM                    =3D
>  ECDH                    =3D
>  SM2                     =3D
>  EdDSA                   =3D
> +ML-DSA                  =3D
> +ML-KEM                  =3D
>=20
>  ;
>  ; Supported Operating systems of a default crypto driver.
> diff --git a/doc/guides/prog_guide/cryptodev_lib.rst
> b/doc/guides/prog_guide/cryptodev_lib.rst
> index b54efcb74e..f0ee44eb54 100644
> --- a/doc/guides/prog_guide/cryptodev_lib.rst
> +++ b/doc/guides/prog_guide/cryptodev_lib.rst
> @@ -928,7 +928,8 @@ Asymmetric Cryptography
>  The cryptodev library currently provides support for the following asymm=
etric
>  Crypto operations; RSA, Modular exponentiation and inversion, Diffie-Hel=
lman
> and
>  Elliptic Curve Diffie-Hellman public and/or private key generation and s=
hared
> -secret compute, DSA and EdDSA signature generation and verification.
> +secret compute, DSA and EdDSA signature generation and verification,
> +PQC ML-KEM and ML-DSA algorithms.
>=20
>  Session and Session Management
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/doc/guides/rel_notes/release_25_11.rst
> b/doc/guides/rel_notes/release_25_11.rst
> index c3b94e1896..9d47f762d7 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -76,6 +76,14 @@ New Features
>    * Added multi-process per port.
>    * Optimized code.
>=20
> +* **Added PQC ML-KEM and ML-DSA support.**
> +
> +  * Added PQC ML-KEM support with reference to FIPS203.
> +  * Added PQC ML-DSA support with reference to FIPS204.
> +
> +* **Updated openssl crypto driver.**
> +
> +  * Added support for PQC ML-KEM and ML-DSA algorithms.

Split the openssl update into your 2/3 patch.
>=20
>  Removed Items
>  -------------
> @@ -138,6 +146,9 @@ ABI Changes
>  * stack: The structure ``rte_stack_lf_head`` alignment has been updated =
to 16
> bytes
>    to avoid unaligned accesses.
>=20
> +* cryptodev: The enum ``rte_crypto_asym_xform_type``, struct
> ``rte_crypto_asym_xform``
> +  and struct ``rte_crypto_asym_op`` are updated to include new values to
> support
> +  ML-KEM and ML-DSA.
>=20
>  Known Issues
>  ------------
> diff --git a/lib/cryptodev/rte_crypto_asym.h b/lib/cryptodev/rte_crypto_a=
sym.h
> index 9787b710e7..14a0e57467 100644
> --- a/lib/cryptodev/rte_crypto_asym.h
> +++ b/lib/cryptodev/rte_crypto_asym.h
> @@ -37,6 +37,20 @@ rte_crypto_asym_ke_strings[];
>  extern const char *
>  rte_crypto_asym_op_strings[];
>=20
> +/** PQC ML crypto op parameters size */
> +extern const uint16_t
> +rte_crypto_ml_kem_pubkey_size[];
> +extern const uint16_t
> +rte_crypto_ml_kem_privkey_size[];
> +extern const uint16_t
> +rte_crypto_ml_kem_cipher_size[];
> +extern const uint16_t
> +rte_crypto_ml_dsa_pubkey_size[];
> +extern const uint16_t
> +rte_crypto_ml_dsa_privkey_size[];
> +extern const uint16_t
> +rte_crypto_ml_dsa_sign_size[];
> +
>  #ifdef __cplusplus
>  }
>  #endif
> @@ -144,6 +158,14 @@ enum rte_crypto_asym_xform_type {
>  	/**< Edwards Curve Digital Signature Algorithm
>  	 * Perform Signature Generation and Verification.
>  	 */
> +	RTE_CRYPTO_ASYM_XFORM_ML_KEM,
> +	/**< Module Lattice based Key Encapsulation Mechanism
> +	 * Performs Key Pair Generation, Encapsulation and Decapsulation.
> +	 */
> +	RTE_CRYPTO_ASYM_XFORM_ML_DSA
> +	/**< Module Lattice based Digital Signature Algorithm
> +	 * Performs Key Pair Generation, Signature Generation and Verification.
> +	 */
>  };
>=20
>  /**
> @@ -720,6 +742,282 @@ struct rte_crypto_sm2_op_param {
>  	 */
>  };
>=20
> +/**
> + * PQC ML-KEM algorithms
> + *
> + * List of ML-KEM algorithms used in PQC
> + */
> +enum rte_crypto_ml_kem_param_set {
> +	RTE_CRYPTO_ML_KEM_PARAM_NONE,
> +	RTE_CRYPTO_ML_KEM_PARAM_512,
> +	RTE_CRYPTO_ML_KEM_PARAM_768,
> +	RTE_CRYPTO_ML_KEM_PARAM_1024,
> +};

Can we drop PARAM and use RTE_CRYPTO_ML_KEM_512

> +
> +/**
> + * PQC ML-KEM op types
> + *
> + * List of ML-KEM op types in PQC
> + */
> +enum rte_crypto_ml_kem_op_type {
> +	RTE_CRYPTO_ML_KEM_OP_KEYGEN,
> +	RTE_CRYPTO_ML_KEM_OP_KEYVER,
> +	RTE_CRYPTO_ML_KEM_OP_ENCAP,
> +	RTE_CRYPTO_ML_KEM_OP_DECAP,
> +	RTE_CRYPTO_ML_KEM_OP_END
> +};
> +
> +/**
> + * PQC ML-KEM transform data
> + *
> + * Structure describing ML-KEM xform params
> + */
> +struct rte_crypto_ml_kem_xform {
> +	enum rte_crypto_ml_kem_param_set param;
> +};
Doxygen comments missing.

> +
> +/**
> + * PQC ML-KEM KEYGEN op
> + *
> + * Parameters for PQC ML-KEM key generation operation
> + */
> +struct rte_crypto_ml_kem_keygen_op {
> +	rte_crypto_param d;
> +	/**< The seed d value (of 32 bytes in length) to generate key pair.*/
> +
> +	rte_crypto_param z;
> +	/**< The seed z value (of 32 bytes in length) to generate key pair.*/
> +
> +	rte_crypto_param ek;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed encapsulation key.
> +	 * - Refer `rte_crypto_ml_kem_pubkey_size` for size of buffer.
> +	 */
> +
> +	rte_crypto_param dk;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed decapsulation key.
> +	 * - Refer `rte_crypto_ml_kem_privkey_size` for size of buffer.
> +	 */
> +};
> +
> +/**
> + * PQC ML-KEM KEYVER op
> + *
> + * Parameters for PQC ML-KEM key verification operation
> + */
> +struct rte_crypto_ml_kem_keyver_op {
> +	enum rte_crypto_ml_kem_op_type op;
> +	/**<
> +	 * Op associated with key to be verified is one of below:
> +	 * - Encapsulation op
> +	 * - Decapsulation op
> +	 */
> +
> +	rte_crypto_param key;
> +	/**<
> +	 * KEM key to check.
> +	 * - ek in case of encapsulation op.
> +	 * - dk in case of decapsulation op.
> +	 */
> +};
> +
> +/**
> + * PQC ML-KEM ENCAP op
> + *
> + * Parameters for PQC ML-KEM encapsulation operation
> + */
> +struct rte_crypto_ml_kem_encap_op {
> +	rte_crypto_param message;
> +	/**< The message (of 32 bytes in length) for randomness.*/
> +
> +	rte_crypto_param ek;
> +	/**< The encapsulation key.*/
> +
> +	rte_crypto_param cipher;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed cipher.
> +	 * - Refer `rte_crypto_ml_kem_cipher_size` for size of buffer.
> +	 */
> +
> +	rte_crypto_param sk;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed shared secret key (32 bytes).
> +	 */
> +};
> +
> +/**
> + * PQC ML-KEM DECAP op
> + *
> + * Parameters for PQC ML-KEM decapsulation operation
> + */
> +struct rte_crypto_ml_kem_decap_op {
> +	rte_crypto_param cipher;
> +	/**< The cipher to be decapsulated.*/
> +
> +	rte_crypto_param dk;
> +	/**< The decapsulation key.*/
> +
> +	rte_crypto_param sk;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed shared secret key (32 bytes).
> +	 */
> +};
> +
> +/**
> + * PQC ML-KEM op
> + *
> + * Parameters for PQC ML-KEM operation
> + */
> +struct rte_crypto_ml_kem_op {
> +	enum rte_crypto_ml_kem_op_type op;
> +	union {
> +		struct rte_crypto_ml_kem_keygen_op keygen;
> +		struct rte_crypto_ml_kem_keyver_op keyver;
> +		struct rte_crypto_ml_kem_encap_op encap;
> +		struct rte_crypto_ml_kem_decap_op decap;
> +	};
> +};
> +
> +/**
> + * PQC ML-DSA algorithms
> + *
> + * List of ML-DSA algorithms used in PQC
> + */
> +enum rte_crypto_ml_dsa_param_set {
> +	RTE_CRYPTO_ML_DSA_PARAM_NONE,
> +	RTE_CRYPTO_ML_DSA_PARAM_44,
> +	RTE_CRYPTO_ML_DSA_PARAM_65,
> +	RTE_CRYPTO_ML_DSA_PARAM_87,
> +};
Can we drop PARAM?
> +
> +/**
> + * PQC ML-DSA op types
> + *
> + * List of ML-DSA op types in PQC
> + */
> +enum rte_crypto_ml_dsa_op_type {
> +	RTE_CRYPTO_ML_DSA_OP_KEYGEN,
> +	RTE_CRYPTO_ML_DSA_OP_SIGN,
> +	RTE_CRYPTO_ML_DSA_OP_VERIFY,
> +	RTE_CRYPTO_ML_DSA_OP_END
> +};
> +
> +/**
> + * PQC ML-DSA transform data
> + *
> + * Structure describing ML-DSA xform params
> + */
> +struct rte_crypto_ml_dsa_xform {
> +	enum rte_crypto_ml_dsa_param_set param;

Add missing doxygen comments.
> +
> +	bool sign_deterministic;
> +	/**< The signature generated using deterministic method. */
> +
> +	bool sign_prehash;
> +	/**< The signature generated using prehash or pure routine. */
> +};
> +
> +/**
> + * PQC ML-DSA KEYGEN op
> + *
> + * Parameters for PQC ML-DSA key generation operation
> + */
> +struct rte_crypto_ml_dsa_keygen_op {
> +	rte_crypto_param seed;
> +	/**< The random seed (of 32 bytes in length) to generate key pair.*/
> +
> +	rte_crypto_param pubkey;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed public key.
> +	 * - Refer `rte_crypto_ml_dsa_pubkey_size` for size of buffer.
> +	 */
> +
> +	rte_crypto_param privkey;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed secret key.
> +	 * - Refer `rte_crypto_ml_dsa_privkey_size` for size of buffer.
> +	 */
> +};
> +
> +/**
> + * PQC ML-DSA SIGGEN op
> + *
> + * Parameters for PQC ML-DSA sign operation
> + */
> +struct rte_crypto_ml_dsa_siggen_op {
> +	rte_crypto_param message;
> +	/**< The message to generate signature.*/
> +
> +	rte_crypto_param mu;
> +	/**< The mu to generate signature.*/
> +
> +	rte_crypto_param privkey;
> +	/**< The secret key to generate signature.*/
> +
> +	rte_crypto_param seed;
> +	/**< The seed to generate signature.*/
> +
> +	rte_crypto_param ctx;
> +	/**< The context key to generate signature.*/
> +
> +	enum rte_crypto_auth_algorithm hash;
> +	/**< Hash function to generate signature. */
> +
> +	rte_crypto_param sign;
> +	/**<
> +	 * Pointer to output data
> +	 * - The computed signature.
> +	 * - Refer `rte_crypto_ml_dsa_sign_size` for size of buffer.
> +	 */
> +};
> +
> +/**
> + * PQC ML-DSA SIGVER op
> + *
> + * Parameters for PQC ML-DSA verify operation
> + */
> +struct rte_crypto_ml_dsa_sigver_op {
> +	rte_crypto_param pubkey;
> +	/**< The public key to verify signature.*/
> +
> +	rte_crypto_param message;
> +	/**< The message used to verify signature.*/
> +
> +	rte_crypto_param sign;
> +	/**< The signature to verify.*/
> +
> +	rte_crypto_param mu;
> +	/**< The mu used to generate signature.*/
> +
> +	rte_crypto_param ctx;
> +	/**< The context key to generate signature.*/
> +
> +	enum rte_crypto_auth_algorithm hash;
> +	/**< Hash function to generate signature. */
> +};
> +
> +/**
> + * PQC ML-DSA op
> + *
> + * Parameters for PQC ML-DSA operation
> + */
> +struct rte_crypto_ml_dsa_op {
> +	enum rte_crypto_ml_dsa_op_type op;
> +	union {
> +		struct rte_crypto_ml_dsa_keygen_op keygen;
> +		struct rte_crypto_ml_dsa_siggen_op siggen;
> +		struct rte_crypto_ml_dsa_sigver_op sigver;
> +	};
> +};
> +
>  /**
>   * Asymmetric crypto transform data
>   *
> @@ -751,6 +1049,12 @@ struct rte_crypto_asym_xform {
>  		/**< EC xform parameters, used by elliptic curve based
>  		 * operations.
>  		 */
> +
> +		struct rte_crypto_ml_kem_xform mlkem;
> +		/**< PQC ML-KEM xform parameters */
> +
> +		struct rte_crypto_ml_dsa_xform mldsa;
> +		/**< PQC ML-DSA xform parameters */
>  	};
>  };
>=20
> @@ -778,6 +1082,8 @@ struct rte_crypto_asym_op {
>  		struct rte_crypto_ecpm_op_param ecpm;
>  		struct rte_crypto_sm2_op_param sm2;
>  		struct rte_crypto_eddsa_op_param eddsa;
> +		struct rte_crypto_ml_kem_op mlkem;
> +		struct rte_crypto_ml_dsa_op mldsa;
>  	};
>  	uint16_t flags;
>  	/**<
> diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.=
c
> index bb7bab4dd5..fd40c8a64c 100644
> --- a/lib/cryptodev/rte_cryptodev.c
> +++ b/lib/cryptodev/rte_cryptodev.c
> @@ -229,6 +229,66 @@ const char *rte_crypto_asym_ke_strings[] =3D {
>  	[RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY] =3D "pub_ec_key_verify"
>  };
>=20
> +/**
> + * Public key size used in PQC ML-KEM based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_pubkey_size)
> +const uint16_t rte_crypto_ml_kem_pubkey_size[] =3D {
> +	[RTE_CRYPTO_ML_KEM_PARAM_512] =3D 800,
> +	[RTE_CRYPTO_ML_KEM_PARAM_768] =3D 1184,
> +	[RTE_CRYPTO_ML_KEM_PARAM_1024] =3D 1568,
> +};
> +
> +/**
> + * Private key size used in PQC ML-KEM based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_privkey_size)
> +const uint16_t rte_crypto_ml_kem_privkey_size[] =3D {
> +	[RTE_CRYPTO_ML_KEM_PARAM_512] =3D 1632,
> +	[RTE_CRYPTO_ML_KEM_PARAM_768] =3D 2400,
> +	[RTE_CRYPTO_ML_KEM_PARAM_1024] =3D 3168,
> +};
> +
> +/**
> + * Cipher size used in PQC ML-KEM based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_cipher_size)
> +const uint16_t rte_crypto_ml_kem_cipher_size[] =3D {
> +	[RTE_CRYPTO_ML_KEM_PARAM_512] =3D 768,
> +	[RTE_CRYPTO_ML_KEM_PARAM_768] =3D 1088,
> +	[RTE_CRYPTO_ML_KEM_PARAM_1024] =3D 1568,
> +};
> +
> +/**
> + * Public key size used in PQC ML-DSA based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_pubkey_size)
> +const uint16_t rte_crypto_ml_dsa_pubkey_size[] =3D {
> +	[RTE_CRYPTO_ML_DSA_PARAM_44] =3D 1312,
> +	[RTE_CRYPTO_ML_DSA_PARAM_65] =3D 1952,
> +	[RTE_CRYPTO_ML_DSA_PARAM_87] =3D 2592,
> +};
> +
> +/**
> + * Private key size used in PQC ML-DSA based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_privkey_size)
> +const uint16_t rte_crypto_ml_dsa_privkey_size[] =3D {
> +	[RTE_CRYPTO_ML_DSA_PARAM_44] =3D 2560,
> +	[RTE_CRYPTO_ML_DSA_PARAM_65] =3D 4032,
> +	[RTE_CRYPTO_ML_DSA_PARAM_87] =3D 4896,
> +};
> +
> +/**
> + * Sign size used in PQC ML-KEM based crypto ops.
> + */
> +RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_sign_size)
> +const uint16_t rte_crypto_ml_dsa_sign_size[] =3D {
> +	[RTE_CRYPTO_ML_DSA_PARAM_44] =3D 2420,
> +	[RTE_CRYPTO_ML_DSA_PARAM_65] =3D 3309,
> +	[RTE_CRYPTO_ML_DSA_PARAM_87] =3D 4627,
> +};
> +
>  struct rte_cryptodev_sym_session_pool_private_data {
>  	uint16_t sess_data_sz;
>  	/**< driver session data size */
> diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.=
h
> index eaf0e50d37..37a6a5e49b 100644
> --- a/lib/cryptodev/rte_cryptodev.h
> +++ b/lib/cryptodev/rte_cryptodev.h
> @@ -167,10 +167,13 @@ struct rte_cryptodev_asymmetric_xform_capability {
>  	uint32_t op_types;
>  	/**<
>  	 * Bitmask for supported rte_crypto_asym_op_type or
> +	 * rte_crypto_ml_kem_op_type or rte_crypto_ml_dsa_op_type or
>  	 * rte_crypto_asym_ke_type. Which enum is used is determined
>  	 * by the rte_crypto_asym_xform_type. For key exchange algorithms
> -	 * like Diffie-Hellman it is rte_crypto_asym_ke_type, for others
> -	 * it is rte_crypto_asym_op_type.
> +	 * like Diffie-Hellman it is rte_crypto_asym_ke_type,
> +	 * for ML-KEM algorithms it is rte_crypto_ml_kem_op_type,
> +	 * for ML-DSA algorithms it is rte_crypto_ml_dsa_op_type,
> +	 * or others it is rte_crypto_asym_op_type.
>  	 */
>=20
>  	__extension__
> @@ -188,6 +191,12 @@ struct rte_cryptodev_asymmetric_xform_capability {
>=20
>  		uint32_t op_capa[RTE_CRYPTO_ASYM_OP_LIST_END];
>  		/**< Operation specific capabilities. */
> +
> +		uint32_t mlkem_capa[RTE_CRYPTO_ML_KEM_OP_END];
> +		/**< Bitmask of supported ML-KEM parameter sets. */
> +
> +		uint32_t mldsa_capa[RTE_CRYPTO_ML_DSA_OP_END];
> +		/**< Bitmask of supported ML-DSA parameter sets. */
>  	};
>=20
>  	uint64_t hash_algos;
> @@ -577,6 +586,8 @@ rte_cryptodev_asym_get_xform_string(enum
> rte_crypto_asym_xform_type xform_enum);
>  /**< Support inner checksum computation/verification */
>  #define RTE_CRYPTODEV_FF_SECURITY_RX_INJECT		(1ULL << 28)
>  /**< Support Rx injection after security processing */
> +#define RTE_CRYPTODEV_FF_MLDSA_SIGN_PREHASH		(1ULL << 29)
> +/**< Support Pre Hash ML-DSA Signature Generation */
>=20
>  /**
>   * Get the name of a crypto device feature flag
> --
> 2.37.1

