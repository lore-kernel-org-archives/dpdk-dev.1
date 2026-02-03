Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADABE8784E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 17:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D9424029D;
	Tue,  3 Feb 2026 18:18:56 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by mails.dpdk.org (Postfix) with ESMTP id 8F79B4013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 18:18:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg5rSCNveAhWTGhzqKU2GfPwZLBgPcz8mD3rLXhS9Naer+B7fW/Xw4JqOzRam5Eksvz03KcKG90vOzAqx2Dy1V9wlFM9vIVa9WKSqraOaP5CPheQfHgbBCwOY/m7C2UBadHFXMVdPQKpVi/ZNfPNzkP+TyhsqzC7FVDSUPuQ6+6w+LvrmuLldTPc9GcLm9YgKtjzazJaVQQGgI1pYlgQc0jSWlK+khGtchZ0N2Wcbn+VBbVLm4UfHWFRSyMJdHqxBY8ZNMK/b+UQWMONP5mPrcMvLxCWmRl/XqQ5UCGvi8AmrelHasTvWZ60igj4g+SRPTr+xb2DcgOyuQ6QmDKP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1H6LmdN29Rk5enJnv8NG7v2C6jmRp4tcvEkRXRJY9c=;
 b=N51Oh+t2hOTWvAhDWhk79iaZfMQ11u2INYEXCpbF8Cd0yoelepuon2Z27jBeT4bGO7uQfvpA3uLHIifualAfLT202T/qztE2jWL73Bx7I2h6+EsxaX/WchUYCKLxPrLcBoiEKvEXovWJcRPImnLqoBucn4OISIQ3JFhQG6TZEVR6SUAlgwCE0Q1YfgpNSXoDiPPKGR0QihDPixSCQZ9KTCoGKxT5xOJH1DAfszml/PvEH05ezcsm+JJGIEyPzJj3sZdH18ypA4Tc33SR4/5DTqzFO1glNzVGrdUB1wwkgTD4vL4Bymyg189ryL938ocDCccAFYGjM8oGVYyFFXFNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1H6LmdN29Rk5enJnv8NG7v2C6jmRp4tcvEkRXRJY9c=;
 b=NHr+lDebwhwSbeJQlPoYWcXFwajohMKIajR5LWxVz0nJhm1Tr3kpusrGotOzKXH0rEhpfLq0W3NDKR/wCc8JmMB0bHMhVkX0WWO6Ca2ugXNBpwVaZT5ppDkxehyqv1fuflEnjCM/ULN+dbWRVz1Eh6hUagPt6hj3zMZ9Ze5iPNwv1zFanJHBad1KtBv7wy6WAx0uwZf43eu7q3LXvBH/fIQpmPobLrr1C4gtcuNZtpMFGs36zvUVD5Cb4NPqKTDTJSC6hRQaoM9+TL3myHRDS1Oh5PvvxDNoWXo5ibYhEOov3U/qmmdHhoXHksGr7AVIoE5igL4jiGP4GMyOUn/sqQ==
Received: from SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 17:18:51 +0000
Received: from SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464]) by SN7PR12MB6960.namprd12.prod.outlook.com
 ([fe80::faca:1bd8:d3be:a464%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 17:18:51 +0000
From: Cliff Burdick <cburdick@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH 0/2] support dmabuf
Thread-Topic: [PATCH 0/2] support dmabuf
Thread-Index: AQHcj7S45AxgIZ1VJ0G6JCY0uXRSrrVms92AgAqOvaA=
Date: Tue, 3 Feb 2026 17:18:51 +0000
Message-ID: <SN7PR12MB69603FAA887B53976CD3582BAB9BA@SN7PR12MB6960.namprd12.prod.outlook.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260127160415.05d07d56@phoenix.local>
In-Reply-To: <20260127160415.05d07d56@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6960:EE_|MN2PR12MB4173:EE_
x-ms-office365-filtering-correlation-id: a89068b2-dfec-4d91-e1cf-08de63484d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?QZQDvCgXfIGqpZBn4UB/ON76uzj6SguBa120iU/8znYKDkd+KTkItSaCb3oN?=
 =?us-ascii?Q?7pjO6NZSFJQy8md4P5Jel3bq/6zyg5a0XYV+SW2jQqb1E6KeBYGPCxloMkvs?=
 =?us-ascii?Q?0OZ8GiPZ6AHxQDCS1kCGFrQsmaERNVEZBunwbNIGrnz/+kCzyTOwIsnLBxtr?=
 =?us-ascii?Q?WcZdVzALkwDDG6NLRQ1LCedT3+GCB/JoxjDdQ1jkjqNb4IlX/6yr6/GTS/NR?=
 =?us-ascii?Q?a1JikGG2ByvbTERFC2iJhbLkh4nU2YpEnocNDxuSEJ7iPJ5iyJzpUFQ6iKmt?=
 =?us-ascii?Q?mjDyKVHWZx28ClVq/5nnRYmOD0fcIk2UKDrmJjl/9DYVv+kNq0vHpvTUA1Rk?=
 =?us-ascii?Q?3JQJzBxaw9akaxr8jaYt5sb7yXycaAsUjYHByIomwMEKtKfBwI/uz8tf2NXs?=
 =?us-ascii?Q?BvGrdO5sZfJRbt8+Yl24ynWqykks25kn4LqKqVv96HuuEEVBVZzBdNRw28/0?=
 =?us-ascii?Q?9Pl1V00LC82NTnCv4t0DlVMvadnebpZw/iEN41Db1e4Htxk3xVUflgTuwgXh?=
 =?us-ascii?Q?LJj08W4+q9cBrxNeqQk+pPJ3nHQf6XzAcaXh/HRFKSRXBa3NXETwzpbRSA4Z?=
 =?us-ascii?Q?M9fYtYfdwX5tdY0Vhuobu4/5Ljp9LoLSMG52aad6bjeaycWzHP6oyYdjg3vn?=
 =?us-ascii?Q?0YsEfATm0miAEBnjtPhHtYYZAoHORBGPTniTDOk6TmcisV3LtSaPzgkcnYKB?=
 =?us-ascii?Q?vFkXNR8KKAzYjk2Clt635M5nl+j7dHIbpwW64xSkBuapJaAgyYM/Ctac19cQ?=
 =?us-ascii?Q?B8rYEL4PUChcPjLdFP60D3S+yZ1eXzErTfF0Zh5btOJsGLud2aXiZqSvSqCs?=
 =?us-ascii?Q?7JVSVKhHjmpNq8j9VwgflUQUx2ksPDP8tsxPqw8YO4Expo+C9m8V0VmzkjQk?=
 =?us-ascii?Q?pzDFCjh00gqXXefHRoZYDZRoFzJ2uWjj0YBQJyx59fl5NM/kWfSLqpa2I+Hy?=
 =?us-ascii?Q?iKbU7+EOIqoILOG3YIL/QjxkAQ8EbgH10OPI6aDVICCY49bpxtyDLT2W9Mlh?=
 =?us-ascii?Q?kx9c1g8b/5cipkHEZgYZLTvTVn0ZOBrA4WdE+T+qHBMmCIzHRYRS4zOaWdzy?=
 =?us-ascii?Q?mO0EuAGWDZMZyGJD+kOTfPPH5IHJ9v5aL7k+MXFA0lL6XUVUr4/6altPv0NR?=
 =?us-ascii?Q?zNF/t1uvUevYTYQTRINKfl5Tm2VoKLxcfwqmPYGneXNC9xKrBmcuud1fcymR?=
 =?us-ascii?Q?J+4dAE9C+xBp++V8h4grTF4RNhFWffApqaUFqZKV3L6yQLLqX6XIO+JEi+KN?=
 =?us-ascii?Q?6aDWm7MGXKN0JXRzjLBODgOA9vzPe1fovO0kRCkx/4kI2LXkMTx0SaBO7D41?=
 =?us-ascii?Q?O8hjG9vqwtVQZZtyUmsmaoLOL4EeD4Oqrbh+DeOossfmd0HIs/froyFBUqDm?=
 =?us-ascii?Q?h4l8jEMPzttN5320k0kG7hEuMaW6FIkI91+JiVsJvshHOg0yHvzEPGz3mCyA?=
 =?us-ascii?Q?cExE+cQ+GsmpfJ2Uku631tgZFxSQqq8pVRqAbyQHiAZEgLq+UFOUw5pLdl2l?=
 =?us-ascii?Q?mrjmHG21Vup5SvZ8o4NYC+/OHbFsK7XC60ttgyFPjkMFNm9sTMK9KX0ryjQo?=
 =?us-ascii?Q?NMgVvNCC6aiOgiYPCus+CiWZSf7pR3tJ0ydIXPyhBSeMJThwP9UemFHdRXQe?=
 =?us-ascii?Q?d9tCx1mvLwwodlTqHoz7GJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6960.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VuqY6VO+VAMWmVz35cSoDFI+Az6K08arLPMNBsqgvrtkbJJbJnyyW2an5rCD?=
 =?us-ascii?Q?jIBCXhEVPZ49arBU9QvrZJ7GWejGN+87T3wtnFw5BR1WP0lLMYatGa1AU+Hc?=
 =?us-ascii?Q?PlAqbpoj0F4OgkS0Nc2GotKQHzc7X6H6YY7dcWWcj6ZBQBnWyy+edUFuBxJV?=
 =?us-ascii?Q?Co9UF6iYY5quBXbYZZst3qvbNpzhfBBxR8nDcaYRlJlYL/WgJS7WKxLiOTWx?=
 =?us-ascii?Q?Azbcc2026f2oa7jrHsYwmm1JyXFohX5iqWmNadRg7Ggqjj0HpTjBbk3j1UO4?=
 =?us-ascii?Q?YIA7wBboFB8yWnZZLYoCyBJCCVA5AIMrM9AyzJkD+OeV5PzJI4VbTQny2SDx?=
 =?us-ascii?Q?NcFFYP/JBjLRFWx4f++RZA83CUoJ/LDoLSxgOelxyP+lLnfW6KYyrCr8hT8a?=
 =?us-ascii?Q?RXuEZL9E4dkuecUPAq+0J8avR7llEeVfVPZwldpN5O60s9+HkQ6JdQdcvz9S?=
 =?us-ascii?Q?KpChKr2OlF6QjZ63UxZdZHQCxgA0+Veun2ZzxVMkckQC2hP8N+f4f7YU2IvC?=
 =?us-ascii?Q?NAw++eldUrw3CEXWOZUWkNCdhHbeB4XU/Kpj9/A4N4kWsrl+lrMB/PrDzsZ3?=
 =?us-ascii?Q?BL+u8c8X8AmqHiIvXHofSttZWiB+MKj3p7t/B6MkRjIfGGROhKs76XYAwlPA?=
 =?us-ascii?Q?2qpDOlSBJipOUG/8pmjaW3AW7Wibv56LHu09+croY0ALW5ZY+39mT8L5Nkb6?=
 =?us-ascii?Q?pyCj5gVQEKQ6jsdkENTh/PUpUQ32vJpbbQxbdJ1EHijbXkKsZcERlEbYCTpf?=
 =?us-ascii?Q?XVVmgxI4G5zx4QfsRTaqVSdz311vgk2xYRiPE1d9mVVkFaUy6glXNkiSd+a2?=
 =?us-ascii?Q?cjo2QV2zh1IqRocPxSmijU9ohMWD5E8SmMo1l9fpvabRbtGabLl9TXssR7si?=
 =?us-ascii?Q?uoEUUeIQVx6vRIx5XiqkViqOfP45GJ15ap9WY8yopj43Ts+ZpE2ZI+slEm2+?=
 =?us-ascii?Q?4OdlSvHsMoFrUqQGQHr0I8XTBkJVZUaENMUSwvKPM0vZ/b8DFI+wv81ZFQp2?=
 =?us-ascii?Q?JDMJPEhPp3oXn5LTNeRB5McOSFMH1i+keoFykR7oXK37macUgBXUr2lmlxzd?=
 =?us-ascii?Q?NUjMAAUmP3V8vDEtfNtYf9z0FYTKNthFsW2CctZfdfC/h+TJ1tdAhgulm+OC?=
 =?us-ascii?Q?lV+k9G27bFSCH6Dqb5/bNW+G3cdnD2sD4awQZhG0gwiaW6UmyzJsS/BDNdXg?=
 =?us-ascii?Q?weoOxKOmYnKkwAHAcgaXwO8fKaiuSlcxALQrnGGef0HuA2xoj7hU4ZbdKCoQ?=
 =?us-ascii?Q?i2TxaRB0B9BOpWrBAxd5tjC7YA8M++zb/srM8yQtw1taplIU4QCvjLQ0dJiK?=
 =?us-ascii?Q?j7Gj1S17jVDkjmFdJ4/9d2GTzKfayt7Eef2d9mG/58VfnvsM1vgYAkaOPsZD?=
 =?us-ascii?Q?O3hcEo1p/sPhPCQ+PQcHOyZsO5Aeg9qpGgKb1+juXdrmfhP/4qjK5wSL7G1p?=
 =?us-ascii?Q?zcyEICQEx9wlCMRJJIU+1YwfCLMd8/WNb/qMCf8QFpAW1bumwQdh4+GuAFAC?=
 =?us-ascii?Q?wkYfKA/UYf5mltQjwK1fqaN9GXXRVd8malcIt9JDtH9KMw7EQKGeiQsNDtQA?=
 =?us-ascii?Q?ygb2rfy7pMPYy7OwV91HrnOvORvBdaP03ztZV58hq04oDEgOLVjOBulyB67T?=
 =?us-ascii?Q?rH88U2DiTXJ+FsteCZ3YMNqMHEYfyrZDwF7jblderdgL4yXS8zvKEENAigNW?=
 =?us-ascii?Q?VZbJfxFD8iZfobzoU/3CSN1fRrmyMO2P8+yNtylRILNa/KMUfeTs2EyGfDOG?=
 =?us-ascii?Q?xNcnxPVwMg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6960.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89068b2-dfec-4d91-e1cf-08de63484d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 17:18:51.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbRU68uqbUkLIBdBfXHVGSvfWd/rj+iLGZj0VgO4UaPRSKdtCaEx2JgEmCX6OxSo8gtRQ/QW+zI1afCGcVgKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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
> From: Stephen Hemminger <stephen@networkplumber.org>=20
> Sent: Tuesday, January 27, 2026 4:04 PM
> To: Cliff Burdick <cburdick@nvidia.com>
> Cc: dev@dpdk.org; anatoly.burakov@intel.com
> Subject: Re: [PATCH 0/2] support dmabuf
>
> External email: Use caution opening links or attachments
>
>
> On Tue, 27 Jan 2026 17:44:07 +0000
> Cliff Burdick <cburdick@nvidia.com> wrote:
>
> > Add support for kernel dmabuf feature and integrate it in the mlx5 driv=
er.
> >  This feature is needed to support GPUDirect on newer kernels.
> >
> >  Cliff Burdick (2):
> >   eal: support dmabuf
> >   common/mlx5: support dmabuf
> >
> >  .mailmap                                      |   1 +
> >  drivers/common/mlx5/linux/meson.build         |   2 +
> >  drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
> >  drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
> >  drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
> >  drivers/common/mlx5/mlx5_common.c             |  28 ++-
> >  drivers/common/mlx5/mlx5_common_mr.c          | 108 ++++++++++-
> >  drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
> >  drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
> >  drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
> >  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
> >  lib/eal/common/eal_common_memory.c            | 168 ++++++++++++++++++
> >  lib/eal/common/eal_memalloc.h                 |  21 +++
> >  lib/eal/common/malloc_heap.c                  |  27 +++
> >  lib/eal/common/malloc_heap.h                  |   5 +
> >  lib/eal/include/rte_memory.h                  | 125 +++++++++++++
> >  16 files changed, 576 insertions(+), 8 deletions(-)
> >
>
> Build fails (on MSVC) fix and resubmit.
>
> "cl" "-Ilib\librte_eal.a.p" "-Ilib" "-I..\lib" "-Ilib\eal\common" "-I..\l=
ib\eal\common" "-I." "-I.." "-Iconfig" "-I..\config" "-Ilib\eal\include" "-=
I..\lib\eal\include" "-Ilib\eal\windows\include" "-I..\lib\eal\windows\incl=
ude" "-Ilib\eal\x86\include" "-I..\lib\eal\x86\include" "-Ilib\eal" "-I..\l=
ib\eal" "-Ilib\argparse" "-> I..\lib\argparse" "-Ilib\log" "-I..\lib\log" "=
-Ilib\kvargs" "-I..\lib\kvargs" "/MD" "/nologo" "/showIncludes" "/utf-8" "/=
W3" "/WX" "/std:c11" "/O2" "/Gw" "/wd4244" "/wd4267" "/wd4146" "/experiment=
al:c11atomics" "/d1experimental:typeof" "/experimental:statementExpressions=
" "/FI" "rte_config.h" "-> D_GNU_SOURCE" "-D_WIN32_WINNT=3D0x0A00" "-DALLOW=
_EXPERIMENTAL_API" "-DALLOW_INTERNAL_API" "-DABI_VERSION=3D\"26.1\"" "-DRTE=
_LOG_DEFAULT_LOGTYPE=3Dlib.eal" "/Fdlib\librte_eal.a.p\eal_common_eal_commo=
n_memory.c.pdb" /Folib/librte_eal.a.p/eal_common_eal_common_memory.c.obj > =
"/c" ../lib/eal/common/eal_common_memory.c
>../lib/eal/common/eal_common_memory.c(56): error C2143: syntax error: miss=
ing ']' before '...'
>../lib/eal/common/eal_common_memory.c(56): error C2059: syntax error: '...=
'
>../lib/eal/common/eal_common_memory.c(57): error C2059: syntax error: '}'

Fixed by moving to an init function
