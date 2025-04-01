Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BAC36018
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 09:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34EE740DC9;
	Tue,  1 Apr 2025 11:50:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6BF434067E
 for <dev@dpdk.org>; Tue,  1 Apr 2025 11:50:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315kbhe031708
 for <dev@dpdk.org>; Tue, 1 Apr 2025 02:50:43 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45ra9w0d8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 01 Apr 2025 02:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR8tr8woSKc+IrvJXUQfskmarLOKq/KTWP6yQV0eTGmglWnc03cuamfddH71oE0/Cd3rEIRvxqXwMwqXjv3lPi+6CovSx7xlQa6FvCb5sk/7tHI1U9YnGOZvhhld8LcfFeC+WEXcAGkkdt2X1VRfiawrbtN37KYuvSLTe+f8+j0sf7+5d31mZR9I2TOcR8lyLFDY8iQp68/SxfR0w6Sbbp6xvKOTruk/MpnCQssGw77WRj7T0vR/qzkIEX0PZSmV3U0pkKz7LCSSXUxaFMxAhCixzbGbi64BIJZaPEwRCeOKBIuRyGeYCtp85c3YAx/X8Pdtxg+9SOQIl6nWW+cafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkjApc5ID88E2KmvQLeA0j5jAo4bYXzBUCyuThkWLVQ=;
 b=LSkBWQSeg/Nb97HH0dQ0yLFgor/wkiHwkbyeQMi09B0v2YgtLs1P9hd9OPbkNh4O7YEejQFgx9OmkvQbE0mmznJot5IqZOrSTlhpegG7hM6K2WA3vA716BUIF10J3EmXlnywv/qIsQFW522coWMKEtNike1weuudqvmBbBbP4paCbwSW0+msEmdZxc6Xw8ZbRLn92nQ1fAJJc6922l0I+cChMMCO8hIbLBSUFcx4sJgt0gzUjF60eaMT7oKiwZze88jr/GnckQwvUlY6kWLOJXTz1WiI3cNfEFVD/BHTTzcAHhnHS8EPZj6B5nOOBMgV5hJQTXVr/qRm/21K7sO72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkjApc5ID88E2KmvQLeA0j5jAo4bYXzBUCyuThkWLVQ=;
 b=c4KHq5S42X57iGwIrzHI3YZeCrmMgu/Jcxa/GWaZNFCStIYWhKLVYBPjhL43g9EFu+xM8/qScKNzpHNc0YYxD/KWCMdAUbGe+IS/cSjWhYpd65wB6k7d8b2oU9r3KUxp8feduRSTXjMJhe1ssJ65HmUpqPfbpNygf5ZEziDph1s=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA3PR18MB6355.namprd18.prod.outlook.com (2603:10b6:208:51b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 09:50:39 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 09:50:39 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nawal Kishor <nkishor@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: Ashwin Sekhar T K <asekhar@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: RE: [PATCH] common/cnxk: add flag for enabling opaque mode
Thread-Topic: [PATCH] common/cnxk: add flag for enabling opaque mode
Thread-Index: AQHbjMXiDtRGAlMGmUWfVfo/rFVRXbOOvSiw
Date: Tue, 1 Apr 2025 09:50:39 +0000
Message-ID: <BY3PR18MB4785B675C998CABE6CF2C279C8AC2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250304052525.796933-1-nkishor@marvell.com>
In-Reply-To: <20250304052525.796933-1-nkishor@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA3PR18MB6355:EE_
x-ms-office365-filtering-correlation-id: dbe0d6d1-baf6-44c9-71c0-08dd7102a919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IdYzr3Ap9DtTe9Ead2DydDRp6U6dUM//jbU1sX0NqTvwf98qL3h8Np7PJipM?=
 =?us-ascii?Q?QlQb3dG7fdFPRhyGbFFNBiqhi7y7TmzScIEjYb+c6La3nT9t1FLtoJxWzj0N?=
 =?us-ascii?Q?5DanpKZtnzLJJ3qZ1EaexUlM5ApjKMepkdZV1B11r+Na4goWBukvv1tBgqtN?=
 =?us-ascii?Q?wXrJ8H4Qft98Gnii0unJIT9IABQmG54owNUyR17hi6ldzLo1u9PDVnSPprPe?=
 =?us-ascii?Q?xoTVjowXov0WVoKZAkHS68D/kjiAjkt1yk7fmvktv+/bcpsy2IjRHHEV/Mqp?=
 =?us-ascii?Q?40QpzmDxHnnazS/d9C+OXx4NzQZ12FtROQ1y7OmGIYs5amUuFKOBMOS2Clty?=
 =?us-ascii?Q?JpI8Byqmm5Fi3n0VtnVH05Pgsda6lOK97IEVnJYMmUg7qpe/ChbqR7PoK4qo?=
 =?us-ascii?Q?Yp++ujbqIB4C7nKk++mprjChuOnkGa1EVbKqVmpO13fcBIC3eFPahj5ikNDs?=
 =?us-ascii?Q?r+L+KDk3grQpQfWRBZ0AugcwDpxXo2+qtnjQ00zANJ0QK6hKoEMUJC4e4KEi?=
 =?us-ascii?Q?aXbh4AjwxXagLb5KjrjyYxp6CRwNqj9O8zzeYntAyMNZyuiU6/f9IJcTMpxM?=
 =?us-ascii?Q?F0bZD7ZwUofqfVyl0qJk6XvQ9BYe4b0x/pLT7BSEsS18IK6lM/bQ6+m65B0k?=
 =?us-ascii?Q?psuot4529flqHlHa515QcH451cTAYYJHSnBGK65R7p53j3dJYARfuRN6HSlW?=
 =?us-ascii?Q?z6fsLd0uf+4BjiaqB8fLgFF3guIq3dQmqRbTmY0prBCDKBYi96xpUSqMlUJE?=
 =?us-ascii?Q?I6QK/Fr6/m9lkJoOKQN04GbNVQHkCXPOAmCWNRvA4BaTUi11lVDSw+Peh6v9?=
 =?us-ascii?Q?3TYwIMzZXh1i0YyYXYOMkq4aHyXSPI50jcixyAyYHc9b8QtWXumwPiqVA8CO?=
 =?us-ascii?Q?X1SQ4JAPogWcc3ESfKHgCIf9hgkyi5EWbDiQ6yYXiVVt8n3T9Z+xATEL0FZn?=
 =?us-ascii?Q?ceSO7NyYsvV9i1ZJQjm/9fX0bN2XEPGaLkhzWLIGjMRaVgu3st8aQ0gMiCVb?=
 =?us-ascii?Q?O5hKX18ks+EpMw7mQXWaBjzLnBTHR9BV1MOOwq8VMEE9D65QGGnItWbFzaA1?=
 =?us-ascii?Q?9YYLSFob8hnjh4PwNFsA4uU8k/4DQg7tN7mmgbtamBF9x6rVAf1ixp9AOi8l?=
 =?us-ascii?Q?o4UfgaTSTVaPjUFTR/SEM9Kty0AQgxHZYa0aS4PjduVxNkSZvqzxWMZxFpUd?=
 =?us-ascii?Q?mF/qRWIaTVexNxz3uKtvIifC4VbhD6UMXaLhURYPP18+0K8O0FLohXW/Yvf+?=
 =?us-ascii?Q?xX44a81rGgbwHVgmQl5AFkUBy6TT1/XtswxbfARNbMedrooNl1404/Cqc1p2?=
 =?us-ascii?Q?m9Gy7dXOuCAf3wS4pCyzhBipsSad5rm/DlqoNXZvJUjPuHQY9gomBuvNIixh?=
 =?us-ascii?Q?ceTnTb/BlBF6Ply4Q6O6o/7sGSaiQ6L4P7vPYmAbOWQZ5uM9Ydyn22QWYqZR?=
 =?us-ascii?Q?g4Pe3jyp2ZKOm6xenn7bcle3QXwD+3pl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ch5Id5cphT8l82URUXgfAlbmWcBtfv1hbkzYUM1QWHqLbyRguEXyW3y06+8M?=
 =?us-ascii?Q?Y77welEjOcs5ihDsI4KgFOf8RlddCNvoz/slNcWdZ/lNn/zJojeKLtqcGE/x?=
 =?us-ascii?Q?e90XzdLQUBd8k5EDzCHHIcTBbDs+/kZKf5F9DPsGAGMAzx/EKxn5D18Y0oqx?=
 =?us-ascii?Q?yb5SkX+3pch+WRD9wgvuqGTdmgFbPL2yq83uvjcL8a0JzOSA3IK3GZwOHCYs?=
 =?us-ascii?Q?nTK4lX9murx4izDxXe8amC3bg4yvTbmPnauZibcsuV5w0T5IIv7JguheE4FK?=
 =?us-ascii?Q?9lSfoRpTUDsVNDQ2Dn/dq9diGB9i1HtSgIJnS1wlEaGekm/funESk/8DsFUt?=
 =?us-ascii?Q?UOJVRQw3YqkJ3GLwgv5wUSEZamaukGIukn1D39Kz/O2QGm7z1kwV4q93GHQH?=
 =?us-ascii?Q?j0PYd5SuejyNMjv/7U3YKA99+0liEocxCv51Ce8WRvb1ooVwRd4Tx29bfvp2?=
 =?us-ascii?Q?0k8+ju7IKxxleKDc0xsxshv66b5+h3fiiJM+AYe2GsTGiRjuwzdqx00DsYXu?=
 =?us-ascii?Q?JXDLThyH4cmPUqRlVrQteTYnLPRzHNS9ND3XrucykKWDO0Wcv9ACQoJb0m+b?=
 =?us-ascii?Q?XJUdk/uvFHBMjbHOWivlxECTVGCFLdSUW9i0iJlvamdtB79ZnQIJzn29loG4?=
 =?us-ascii?Q?rb5dPA5uK+o1QIJHHDtRtmIeG9utAyjw0v/oR//rX9l4P+vZhHyDRWu9oEo9?=
 =?us-ascii?Q?czg6cWuKkGlPoEQ9MkRtz1VZEVju9Ap48uWm/mMG3P63vtPQAXbCT+pn9wnb?=
 =?us-ascii?Q?f0igqmvzaunuXjwwkvY0zNs2iWZgg3JzlsPu/rYZsKm+Vm7M9bqKhxxatx7g?=
 =?us-ascii?Q?qFcwcid/79DZZjcKE5eJ6WlOPE1ywXxNVVBNbz8OVRSJ/LGZA0T120QVc1uz?=
 =?us-ascii?Q?x0xJ7C/aaod3tfPS2Ud+bU7KK7/jcjIRcH675TrL96KlyWU5qPCKK/0c0COw?=
 =?us-ascii?Q?NhfBXNk76YXvXNk/XZUojLry9FcHlSnEUyCyxs5SzoQ/DwdHsIIrIudLodSq?=
 =?us-ascii?Q?ncLJe0xD4E8BuI7TxkSL7dkEZFGHQ8Y5buhnb0er71ESo+O6rBGkEPR2/ZZ4?=
 =?us-ascii?Q?ZGUo60h2Rm6yqhtJRcfny2/SYMkgXGYqsbevAiLPJYBlDFVZd5LwaxjRZK1P?=
 =?us-ascii?Q?IEceTUrzCewBGQfqN9WEQmep5ffn6kVWRN8vErUsx92mxp7dzB9IpJcc8IB6?=
 =?us-ascii?Q?MhQ9NKt5wfVvwT6al/ROyTrDGD/pzSmevEPPDhQaShG3D1Bdbg2sJ64SMzrK?=
 =?us-ascii?Q?9T/lSf9cK5jCtrtjYDnCdS4MuUthj7joeIv/HzJLb8tcpgEsEAjUx/0xnPtb?=
 =?us-ascii?Q?U2bEg1/fEoVNySqDI6kTcx6393HCbsg3y9v3qoD9NcQ/QWC7aB6aUfH4Q44r?=
 =?us-ascii?Q?/hLAm4hx81bO2/rU2VrAZMcD9BQvmyej6YRUjQHaXTC+P5GGPeceLIGFRAry?=
 =?us-ascii?Q?zybwij2h7++7SpPdeFbltZDqjpnG6No7S/Rg6LfIoFdRniyGM58tpfjf71FV?=
 =?us-ascii?Q?y/bzlsPqGdnge4Hg87XBFMMVwX+aoGBduvFIP8KKqf7Gysoi3HVhlXYmniNP?=
 =?us-ascii?Q?TRD0ZqP31gOXMwlFWR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe0d6d1-baf6-44c9-71c0-08dd7102a919
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 09:50:39.7105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pftVhnG+ZPg6b3FUC5RbEapgN4Y76C7yBVf171FhNEO8S9OguW5hszdXbywkPED4Y8de0Bc/b/nmDxnrs7rf4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6355
X-Proofpoint-GUID: WxEiwGQaHMwRGiskd3ic97g2Jz03GnLw
X-Authority-Analysis: v=2.4 cv=feqty1QF c=1 sm=1 tr=0 ts=67ebb6f3 cx=c_pps
 a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=9TA2egXG1a20E2iNmoYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: WxEiwGQaHMwRGiskd3ic97g2Jz03GnLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
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
> From: Nawal Kishor <nkishor@marvell.com>
> Sent: Tuesday, March 4, 2025 10:55 AM
> To: dev@dpdk.org; Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>;
> Kiran Kumar Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Ashwin Sekhar T K
> <asekhar@marvell.com>; Nawal Kishor <nkishor@marvell.com>
> Subject: [PATCH] common/cnxk: add flag for enabling opaque mode
>=20
> Added flag that overrides the default natural alignment mode and uses opa=
que
> mode.
>=20
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Updated the git commit as follows and applied to dpdk-next-net-mrvl/for-mai=
n. Thanks

    common/cnxk: support enabling opaque mode

    Added flag that overrides the default natural alignment mode and uses
    opaque mode.

    Signed-off-by: Nawal Kishor <nkishor@marvell.com>


> ---
>  drivers/common/cnxk/roc_npa.c | 3 +++
>  drivers/common/cnxk/roc_npa.h | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.=
c
> index a33f9a8499..d5ebfbfc11 100644
> --- a/drivers/common/cnxk/roc_npa.c
> +++ b/drivers/common/cnxk/roc_npa.c
> @@ -669,6 +669,9 @@ roc_npa_pool_create(uint64_t *aura_handle, uint32_t
> block_size,
>  		pool =3D &defpool;
>  	}
>=20
> +	if (flags & ROC_NPA_FORCE_OPAQUE_MODE_F)
> +		pool->nat_align =3D 0;
> +
>  	rc =3D npa_aura_pool_pair_alloc(lf, block_size, block_count, aura, pool=
,
>  				      aura_handle, flags);
>  	if (rc) {
> diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.=
h
> index 8525038810..853c0fed43 100644
> --- a/drivers/common/cnxk/roc_npa.h
> +++ b/drivers/common/cnxk/roc_npa.h
> @@ -767,7 +767,8 @@ int __roc_api roc_npa_dev_init(struct roc_npa
> *roc_npa);  int __roc_api roc_npa_dev_fini(struct roc_npa *roc_npa);
>=20
>  /* Flags to pool create */
> -#define ROC_NPA_ZERO_AURA_F BIT(0)
> +#define ROC_NPA_ZERO_AURA_F	    BIT(0)
> +#define ROC_NPA_FORCE_OPAQUE_MODE_F BIT(1)
>=20
>  /* Enumerations */
>  enum roc_npa_buf_type {
> --
> 2.34.1

