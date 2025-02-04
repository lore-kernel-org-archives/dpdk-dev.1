Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AEDC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 17:00:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19A6B400EF;
	Tue,  4 Feb 2025 18:00:11 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0C7D2400D7
 for <dev@dpdk.org>; Tue,  4 Feb 2025 18:00:08 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514EEpZc007199
 for <dev@dpdk.org>; Tue, 4 Feb 2025 09:00:08 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44kmg4gcs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Feb 2025 09:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhx766Y8Rz3vGcPVOCCOxs5P1ThZdyB/bUwQEHqWtI/Rp1SDxmGh9AId86pXmU2Kvec9QA5fUnK7oThY2zY41RvWDIEcicgTyXvM6aamwROwL7Cdh0XRqTsvubig+yoRv9ddRRbEjq7nAriMe+hTTjY0Xpji2wNZ2pqeShrNzHeKnp4/7N7n7ZzphONQxj7kgOxpaZ9O9IMVrYO4ys2S1HhjBB7Jg6JjDEGtJPoUXvKNoVJlzSy73563zV1KybMDEnoL9PAeSguEjt2L0MdWg/OnTiaHtehhvc2xoS3ZL9wpPsiACSmaX404mv1JG7bajDTkbxqYl2ZUar6ERB5bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GEFmnS0pNsUn4dh9kfnZl767xykC1jcaWwJF+3NHbk=;
 b=N31EttLvLU9xkVmhE02PiZeYCYzo871dg+1ERhpMgsmhawio/KMQ+yYzAKmpc53jgJ7kYn+MpuYXCUpC9fVF4XTYi5zqqXqdC+v88po9cgvDLJ5bHZ/LQKVxIalWyp9shvuNeHNkQnaHiy7J/XNxLDiGRIgV0OHp7+R7PrNjfllPto96Eq2GWMnFzzd+7HEa6+hEywR/rApZhQpioh+TvU9azu7VCw8bk9IdzUsmUWYMZU0izitE35I+ZuCLClnxiTEtKnbx8yyNm0NINzYxOIqGX7PjrR0jYRm5c2IvzxiLUnLTaEPGngS9XoyUfpQ5CKH9kkt0i09P5PEfCgdMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GEFmnS0pNsUn4dh9kfnZl767xykC1jcaWwJF+3NHbk=;
 b=d+bw5ndm3pnVzU7daJ+AyLio4jSqBHWUYGiYfx11Ccwkw9NIZqqR+noeZtv+iHubq7sj8gu9iEZg1ZC4HsAeYFG8KYrHB3eCDniXU8iPDnA5Oy2VJ6GwFI/czracrsUBo4A2XgqO9Cy0TdjE8Hv86i8xD0DPIfyk6UtyjhdkZk0=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DM6PR18MB3634.namprd18.prod.outlook.com (2603:10b6:5:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 17:00:05 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 17:00:04 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Rahul Bhansali <rbhansali@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>,
 Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 Rahul Bhansali <rbhansali@marvell.com>
Subject: RE: [PATCH v2] net/cnxk: fix of NIX send header L3 type
Thread-Topic: [PATCH v2] net/cnxk: fix of NIX send header L3 type
Thread-Index: AQHbcw3h7YiNli8Tkkalm5psRdGUMLM3ZjZw
Date: Tue, 4 Feb 2025 17:00:04 +0000
Message-ID: <BY3PR18MB4785CCF9298A723023F358C3C8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250127063335.405019-1-rbhansali@marvell.com>
 <20250130115526.1023855-1-rbhansali@marvell.com>
In-Reply-To: <20250130115526.1023855-1-rbhansali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DM6PR18MB3634:EE_
x-ms-office365-filtering-correlation-id: fdf0a830-3fe7-4297-9bde-08dd453d5f02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?W+s9VDDVT5dxZyQ0YrdIQ5KfhKHmXxpIfvMwjBPbBE8gvLF440ni1V5v9KSd?=
 =?us-ascii?Q?oVaeGWOJVz2HK3KVXmURMD0YsYsz+ijgjXSG8SDXPuCrg9scBqlgOGmgzSXX?=
 =?us-ascii?Q?OA0AAjdnI+PPWF+dPTNc2NLD2ZmqZXMnipD8kKt6eZpfZ5jlgXsYjqrdEwek?=
 =?us-ascii?Q?ZmJGoSLULJG3BFpbn1RRfmAwg+17wYE/aD7NVlBgYtRQSX1xv/bx9lsIMj7t?=
 =?us-ascii?Q?pzqwz8TMBFS5tCJK4m3izUXUleHiU2iMWtq8zB9MRBHJaiWrUvDvMm0xzvJE?=
 =?us-ascii?Q?z/prJsE8ER7qlxd/rPqveGQc2lY0b6Y0RYK86whbmHSQwdq3QOHBb9HoN7Vk?=
 =?us-ascii?Q?IX4lgvlATHL8HkNT3hauCySEA86qVk0kJxIfuI5EFLv1ICoDB626qiTUjhyU?=
 =?us-ascii?Q?cUpqPVe1hX58aZQtxIZezfyHs6w9KGkZKWngzR0R52S6rf+HUAaRlvtQ3K9A?=
 =?us-ascii?Q?C0cUoopO6LzZhYr/8w6bvQEBTiCtmHZiyWw06CvbvAy24V1bjX46d6gUor6w?=
 =?us-ascii?Q?dKH3LGB6P9fAmK+mF2bfgfVzcqCWP3imG7EUHHnMd4u4hLSW547OINNbfTF5?=
 =?us-ascii?Q?/1Q0vtx/QQPC8nknylxiIRTPUI7kxTrGz994tFYuzoM/FT/fnTRLGeFoCJvx?=
 =?us-ascii?Q?efoZfDVfUCJzTcmq5U/VpbxqWEC/HaR8rFLXaukBc8dZrH+6ARJcbklNTBR3?=
 =?us-ascii?Q?Qva7AKbzEoKl1EKuSsy0X0n+S5evaiikLXKAMDL3kPxpr/086TeXmIuzDxdE?=
 =?us-ascii?Q?CfTvWpwEOl1dO5GTle0+7xGW0lY/y0R2f2CcElRQb/5eeetvAAKk8B4Ob37t?=
 =?us-ascii?Q?8giNbIbvabpAsuITst3Z5w6OvuR9DnQS5mZd6PmJeMptz9/n+ck1cfHx+YFM?=
 =?us-ascii?Q?0p0ioNSi7zFLfufUHepUhYvnWSmEAU5KmKYgIWom8MTJlNEjYNipdt2skKAF?=
 =?us-ascii?Q?sCwji1yRp2up5w8No+4Zeyfv2gDCwvxhiCQaEyjP3oLA1/GoDPTQKyUsnCdv?=
 =?us-ascii?Q?/Z2BKalaUl0FMc/RlqDHKXTXA79cWzzNno23+0Fbsr4mEOlYIQCub1sCW1tw?=
 =?us-ascii?Q?54fsTlFxUceB+aPN9+XdhHyp63hGa87MXVnPsatH5d4MI0ZOt2WdBAf0Ik/Z?=
 =?us-ascii?Q?NuSFrNpzxQMiUPFDAjKy92A/B5k/KfB9/fJTPQiyd6p/8azuxt4xBFI0GnYo?=
 =?us-ascii?Q?I2+pW/V80JSZ3k0NuUCiDwKTcwcvBPBvTevXHvV3Gz+kEHFb8q3Q21wm6oyw?=
 =?us-ascii?Q?HzItpKZuyTGGOpMS0eCTAgbSHn7G4DnYcvD8SnfPtLgmCKo1iZsuBHTTfunX?=
 =?us-ascii?Q?ybyac1wKNGLcCHWn1npUcN7WFv27KQp//tBai9RJjdvRGr1GZU85TA0vue02?=
 =?us-ascii?Q?vplwo4lBkrvRRZqpavQ90R17P/6tnWHaLa4XmaSgqA5X6UP6LerhLQ5n6MjN?=
 =?us-ascii?Q?LnyYFZcSP9n6eX9dlXODLks2YGxbH3aR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gQiPKDToNQ3/nzxS0d/uEcMYF9nGQflPbRhU9Fm90BU4TRlh0BllQC6lWd2R?=
 =?us-ascii?Q?l92lDW8pBZdMs/zgQeUhfhrHfk8ppsqRx/gXO6xK4eN9qaQFP7fQOnBzIy/S?=
 =?us-ascii?Q?lNs91OXDeJsyIQEwBif3PEzpDS25p+T9BfyQ69hLs1eGB5XfjUtYvmxFVhsc?=
 =?us-ascii?Q?HRHLNpYkm0BF8oZipBvgoHJxyw8XmJmMe0YesXjUHqWISOOeS3YH85OIu0Vr?=
 =?us-ascii?Q?FkUJxMdKwZyd9bK20Qj5WGuH0X2onPof565AVaBdWntbadwoTYbxoU+GjEBD?=
 =?us-ascii?Q?3s1bMXY5pQaSLOnVz89mr9290aIftBez1MCcPiI9Ty5Pu4+TkaXj4rk9GshE?=
 =?us-ascii?Q?DbT+pCZnmhIvlnjnG8yMempfiXQ1tPPd9ruxd43Q+xSlA8bA1jClBTj8FSo6?=
 =?us-ascii?Q?z/OgnV/yBJGm6TBcaHS2QnSU1poQwtXFzppYSVmgaCbgC7Tdk15108zvuK74?=
 =?us-ascii?Q?4AQoYqwiLAgfSrLeMvBMP6urvo/N20kpJFaJwy7z2Pb8J6WBrgi+T8wmcge3?=
 =?us-ascii?Q?mKlZR6X6WQM8aaY/PfRV8j1mx6VHlGhJvfEc7j023NwHmBEQmHPNvZd5dISg?=
 =?us-ascii?Q?Q5ABsZrasqgkrwc1rmT+ETsIROWvBp9pSNzkZMCZmrq7L190v3q/5PrEY0o4?=
 =?us-ascii?Q?EJnBSGqW7umBuW16fzqQR/KMcSYldUc/AkXxWndjv0vaij2+3JN76K3iC80E?=
 =?us-ascii?Q?tE6/kKr/QkgN5Cg7Ii4Hj5QtY5aQXgb9o4AC7nvI3WxoxeWhKrcgq2nn0Fu5?=
 =?us-ascii?Q?/0pt3JyBwlYIrg/FomOpMOA/uCOirvaUbEPYMnaYXzABUEXXpu31cw0VXkV6?=
 =?us-ascii?Q?8hhwyhEZyMiEpoC1+Hm7aPY7kSdhkr9w/zoAQJwuiOm56RA6/A4nAYGUzu2s?=
 =?us-ascii?Q?isA0QkKTdJwS9K+QkOze61TahZwPPmYYHZrkIVqtcKdL/cFS1qZImYdyIkzL?=
 =?us-ascii?Q?sS2bdUqZLpk9C6HaOYnYuc/jp8GuzWZy1PJq2dpahrPmRkIKaXXCLJG4LA+3?=
 =?us-ascii?Q?DC9d9NtHDr7ZqlLGTehBiAecLibLKX/r7t/dmVcA+CjZCHAVxlnyejJYLW2c?=
 =?us-ascii?Q?TjPN0gPJ5uyLQPrOx+xF/SHJvnAop1ooNx/ynZUcwfO48/zz3N16zOIys8WX?=
 =?us-ascii?Q?0/peaCs9x1UgQJIi7gCl+WA8IpaKUiQPlzxRLvH5pKCzdq8UbztUUobcqtn2?=
 =?us-ascii?Q?F73rRRrGuCvCcM/SD+skGs61fefKm9cz8sLaHrfgZ8/4SpfpeHYZ955v2qjb?=
 =?us-ascii?Q?XJkkdla77wKIhxA4dIgoNlCUAmMBcQjA4ej32EsltxIfDFMn/SjgQ4fdhMFF?=
 =?us-ascii?Q?LSHGaRFBp5soe4x20DRTtLJ5ACaKvtiD8x9PdOuhR0WjydjpXCLdck5BoTNC?=
 =?us-ascii?Q?6lcRgqaguoMAjmmI5pjlVVBzDL6kPa74Fp2QwoMtaOOPxuLSxExZ4giP79Hs?=
 =?us-ascii?Q?sXCSXlYBFG3ocknXxSfIDVjqKrTPo77/+6M8MiO7V7ZWPMHaMuB+T/3RUULV?=
 =?us-ascii?Q?pMlvyEY3gkhnrhxEwKW1CbgBsJBklrpaKIVknrblWKHLaEiSIzWeGR00nShJ?=
 =?us-ascii?Q?siJip+l6dYES0YsJ70g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0a830-3fe7-4297-9bde-08dd453d5f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 17:00:04.5410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMeXuPg00/8kf725sysVDbV+Dvuxd/xLi9RE2W8gsDfdTJqWAcs/c1+Ut7rKOI2/oxVQBhrZbV4zMEoD60yL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3634
X-Proofpoint-GUID: qd7PXGQnt-Y73ESlq9h9CFmaL7sbEMuD
X-Proofpoint-ORIG-GUID: qd7PXGQnt-Y73ESlq9h9CFmaL7sbEMuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
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
> From: Rahul Bhansali <rbhansali@marvell.com>
> Sent: Thursday, January 30, 2025 5:25 PM
> To: dev@dpdk.org; Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>;
> Kiran Kumar Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>; Pavan
> Nikhilesh Bhagavatula <pbhagavatula@marvell.com>; Jerin Jacob
> <jerinj@marvell.com>; Rahul Bhansali <rbhansali@marvell.com>
> Subject: [PATCH v2] net/cnxk: fix of NIX send header L3 type
>=20
> For small packets less than 55 bytes, SQ error interrupts are observed.
> When checksum offload flag is enabled and mbuf ol_flags are not set, then
> default L3 type will be set to IPv6 in vector processing. Based on this, =
HW will
> still validate for minimum header size and generate send header error if
> mismatch.
>=20
> To address this, will set default L3 type to none. Mbuf ol_flags
> RTE_MBUF_F_TX_IPV6 will set with offload feature TSO or L4 checksum only,=
 so
> handled in corresponding routine.
>=20
> Fixes: f71b7dbbf04b ("net/cnxk: add vector Tx for CN10K")
> Fixes: e829e60c6917 ("net/cnxk: support Tx burst vector for CN20K")
> Fixes: 862e28128707 ("net/cnxk: add vector Tx for CN9K")
>=20
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
