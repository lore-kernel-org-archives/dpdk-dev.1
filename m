Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26219C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 00:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD11A402E1;
	Tue,  1 Apr 2025 02:27:44 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by mails.dpdk.org (Postfix) with ESMTP id F0874402B1
 for <dev@dpdk.org>; Tue,  1 Apr 2025 02:27:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upUynsccdOJUqXEAq/tlpoxFLknrz1ZnN2O4xfPdxRZsHpVuwb6zR2d/bitdp0biM5bm0JJRSfSkwg3SIrMHzzDBPCzkPP6YHnunyscm/7RZoEarvU5xc81OqNL0zULm/Gi1r7f1GXSG+x5LE01LZoFCPICaJ83ctpWvnw1wAgC9yroeqgomGFGp6g6QTLhe+Vmavt/2FCIumdKMsKJNnja3Xe9MdYNcaM8NEKJKlkC0LR++8j52q9JKeJvfoxwDd0pYx5G31jMwbiW79KvQo29vRz+u8f42F3A1VbvdlYPq4EErdVllkyUQoPSd6IJC3BGBp0a6Iqf2EPlaGumoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLr2LZ8m6D6LQlK9U75j31Cnv6JOOGjE6FZL5eaCabw=;
 b=URLwHWT4Mt3jkPen3un31eXbyhr2/6drJrZxm3a85pDYrdCW8nnk3UYBKzUY+Fz6epTk4zBZoabROIMWBDYj9l4FRn8qxTqJE76ffz6YmDGcY8wiotBUqAX88ZyDBwkvIEIR9Sqji26WhqdeismiW/GS11WTKbFcomttAryNdam1QihsP+vafKVf1t4B5AjKZxyejkZKLP3NXTljpDDzHxk2d2pHGmZqxpJbSffnYGtW+p4vtK9Ml+DQtqKQmk6q615WodFOeE8Nvi8LnxIaC+PL48lVl2RswhfDgzFPktYlpPIJYk95r3VeTb9YmMe+9ABjpquLJh5jYOtniMPD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLr2LZ8m6D6LQlK9U75j31Cnv6JOOGjE6FZL5eaCabw=;
 b=AzCoyQH/y4rX5Om6ii3NJfDUDlFTghKN8JDTd5Jkm2qOzKyvaz2EiyL+8xybuGm3GQH1vcyg/6p/dp4MJZzNkAqnuJYcZaXZGMAsT0wlr4YQQDzGviQFCUW74g8BLBuZCVz2FQmdABWBbvIKyA1BcJ7KdbUbczkRULNzTZi5VPh2DsuzZlaF3/tvCTSELCO4dFZ9xedZrxgY18QNo5IdKU/IInLYM3WEVGSw2YLWuwRFa6+CYfS/2bS2jTdssRpuIo4oboNXBVHuU/0hecHqzlBB1XTLFJ9QZ+4XTS1vK8CbhSLt++x9l/gJ91L23JEZWAogRN/Pw1Y3ZBoXz2KMLg==
Received: from SA1PR03MB6531.namprd03.prod.outlook.com (2603:10b6:806:1c6::11)
 by MN6PR03MB7648.namprd03.prod.outlook.com (2603:10b6:208:4f7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 00:27:41 +0000
Received: from SA1PR03MB6531.namprd03.prod.outlook.com
 ([fe80::6dfd:728b:fac8:d7c8]) by SA1PR03MB6531.namprd03.prod.outlook.com
 ([fe80::6dfd:728b:fac8:d7c8%5]) with mapi id 15.20.8534.027; Tue, 1 Apr 2025
 00:27:41 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 10/10] raw/ifpga: use common base code build handling
Thread-Topic: [PATCH 10/10] raw/ifpga: use common base code build handling
Thread-Index: AQHboleGrMrtu+uoGU6y92FA43OyzrON9Pvg
Date: Tue, 1 Apr 2025 00:27:41 +0000
Message-ID: <SA1PR03MB65311E333EA928EBBCCF558EFCAC2@SA1PR03MB6531.namprd03.prod.outlook.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250331161000.9886-12-bruce.richardson@intel.com>
In-Reply-To: <20250331161000.9886-12-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6531:EE_|MN6PR03MB7648:EE_
x-ms-office365-filtering-correlation-id: ca8cfe83-8845-418b-cb14-08dd70b403cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GuZ8L1WlNldyEymKE/lSFPDmgJahX8EQBcUl74iAHKFbGOvCvpEIMcUHLS+n?=
 =?us-ascii?Q?AljGpZ8o3zS7RkbCXBTSAmxf9cBBl5Xck2aQEao582cqc+E2ZN4dEyfjhqzk?=
 =?us-ascii?Q?auIh1x2Dndik/x7m+K7iLxTqdTwEu4oYhHI96IlpBQzFG6dhWMMTUEEvZb1C?=
 =?us-ascii?Q?fUQaYW7RE1NI6v0CTrdCklpvSCdKabuVTeMOfE/gbhfx00xXvkwMvKdme+0S?=
 =?us-ascii?Q?azTJ4nMCYavT25F8Qst1TmsGCGErtdcYLqYWYjaPc/FHCyUEVt9MdyBevM+3?=
 =?us-ascii?Q?K/mNZEczdhaiqdkH0Kg+GFw9ESLc9E5lZtI/T/gTDUFu9tLTrSAZKsZqe4cB?=
 =?us-ascii?Q?w3e3FHravKqR6IFtnQ7mdiCJ1TTR6Aw93hOJj5shrnrj8KWIRHuqcItfV51K?=
 =?us-ascii?Q?42PEYBpfajSyLht0tzEt07V/chTJ1jCpy5GcYHEG1aFrXhohi7yrkqP+kvrw?=
 =?us-ascii?Q?5j/dwqHJJ/AyTlxfF6T5nTThb19wgUtVvm1WHaHNsxS6KFEsClKlnsIsU7Hq?=
 =?us-ascii?Q?SE+lzkIOmKbMirZ9e66YvhBcKW00YN+ciA+NE+fa96yq2IkKneR56gWyJSbc?=
 =?us-ascii?Q?fHuDh5ypQ/CdlGHNSUIW2+O25g3gvHyTSh+Evy4XAm7HH3ca4CDUo13Z3h7w?=
 =?us-ascii?Q?Pmu2Lu8g8H7mkfj5Q+U8p+OIvPsjo/V8/WnEJ5UISTbqTA3zNKtbX1DlxHWI?=
 =?us-ascii?Q?/a0QZpu5USI/oSQAflQTP1FzFnKQx/jYGZk1qPgX3D0gqAlDMv18a5lqhk3j?=
 =?us-ascii?Q?2890/JUAjVmMcOh3omPjzKx2DTdCyw5bvOOMQadjsSyb4D54dn13PcrP8o8M?=
 =?us-ascii?Q?Tpd9+lHPKuxj0yau6x0UY986c9cn2wONIPgfUvnBGvcoeyGxOn9LJOQen9vn?=
 =?us-ascii?Q?88rxVA9F/y/w4j+t3+M6yWwMkEb/HxQM4paFLjkvyBJQWORdGNj80P/VZiWE?=
 =?us-ascii?Q?b/NO/OzsDjpXW46DlPiNv6SqUUsiDg3rrVlt4yLQa5woPyw/phlJIuCQuBfi?=
 =?us-ascii?Q?eHvX2BRr2WEXvvG+Lyh+K0ysRNp6OonQMK84jrNy+Xld1nDLuRCZVxwLK2Pj?=
 =?us-ascii?Q?n3Vs0afm4L1pq91WvZgUf/y+0Ux+zgfYuAW6gxkwn3ZKkoPC7tDmONpV8zzx?=
 =?us-ascii?Q?NnvKFzvOdMzHNfiIhqMPOwY958rOxZNQiZR4K2O5v4A59v8mkuVBfZosf8wm?=
 =?us-ascii?Q?t8XhzvVkVzSOTRsQKrk1R9NsZLwGJUXzEm0J0VFPbn2TiJCk6tSHV54z8ES0?=
 =?us-ascii?Q?HiwgDCBjZ0E19afXU2kQ/QaH0VwJvdlM+ZXU+q9yTiuHunAXgIvwPNwoA1Yk?=
 =?us-ascii?Q?1gOJtNkIEk1Y8p5wiJVcRDOFqoPE9jCZLXyeM9Wp0wtuAKmzL45QF6Ok1MK3?=
 =?us-ascii?Q?1B77OMRy1Fd/XtT8L1UyLNYXxVDTPrFiJp52dWnrF3U+Gg2qgO348uPaYMEG?=
 =?us-ascii?Q?bQBr750AL1aNmmdu2xprUHJrZXJgwMCl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6531.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yb7LAinX8XMbaKyrXosE4c66FUj/J9bVT/0L2UErXNMUlAkBTXT9Y8Zg9bp+?=
 =?us-ascii?Q?keb5ZbXzA3fFR11ilmJJu8GdzT4sUn7gkJz9urnY7K+BrCluTRgOZsUFbB2/?=
 =?us-ascii?Q?G/pim+U8BUA5osHX2ihQjJL0uYQyXZjjJDOeWFSlAIEf7z1zQ4O/KtrTpubh?=
 =?us-ascii?Q?WhrYBIcMIXHhZAnfbUlkncj0llACmHPdXlhDbT8UcbF79Ah9aU83Cb5Jj1x8?=
 =?us-ascii?Q?2Fov+UOAUbkL0w21rq6pnRgxSQw+SRQhKNBB+7shxrKwPUP/2mqF57P321KV?=
 =?us-ascii?Q?yH9FNnWhwoDjtYJ4n8nPo6TD7c7kojjo2LCgjYKXfXRFrGxc65XK/fwTOk9k?=
 =?us-ascii?Q?rpOKzsVJMHRvNci7hwmyo3zoTACQILGL/Qj29mujZPbAtID26761H1R5BaGk?=
 =?us-ascii?Q?Pzn3RSjOrM5y4sdzioUjS9nAtgiOwu02svNAvax2Hi/WRZSDHoKq45GjOYvR?=
 =?us-ascii?Q?3PSTjiU6VlCh3YywIhqTF43vgqvfzmeuyT5kstGzS3aCTuQzP9b9X0OhQMkc?=
 =?us-ascii?Q?k78FMRUBNVSE0lF7lH9QkjQHmHmn7nsqryFD4jbv3uwx+nnWnVh2wYta1qMX?=
 =?us-ascii?Q?BaHQI8TBBiUTM5zbMyCxzg3SBgJpalihjy5ae+YguW8w4mdY4f5x7IY8+CQi?=
 =?us-ascii?Q?M9ADak7XzTmge7ddrKmIRICeYkH2mgVcK2pzzoZa3HbWOEJ/AnsG40DrxIbY?=
 =?us-ascii?Q?kTUXatm7u97Nj9C2v73ZLo6mUqrYscIdMAR2pFlmDl9dhVLHXEv6XtjcaPd2?=
 =?us-ascii?Q?0Ez/zcxebWakQ4zK9Pv7vEX7U4g000LnvZbItwcMHMzsqYqsgxs2X2C/Tj/5?=
 =?us-ascii?Q?1anhV93EkYMFzQqnUlQ2JOax2LbD+FqTmzspceo2iicJOaclwb/nCxMc4rwR?=
 =?us-ascii?Q?8xagupFmhfgXnen7R1AACQvyLCyAUCi6I/yPzGKjaG4emu2HRxXsysZErDDu?=
 =?us-ascii?Q?bXFbUhzLtwOGcNnLZ6ZVmjUwdpl49SxinWo1VLXAkFmjYOA1IrV9jZvQtuJJ?=
 =?us-ascii?Q?PasXlZcwI2ZUkhWWe25jFvc0VR4mZzO+x2usAv4e+7RrI5tsutawQkWkgG6J?=
 =?us-ascii?Q?WAYfqEyAn0d/SSq0vQzoHKcajcdnKMNxACqal5OAdAwq3CsYxfxh/OlxJxPq?=
 =?us-ascii?Q?umWJucdfXPxmCpeaJVgVaeuekdvHv17bOcEYBb//nO9VwOKUyQ876nl+5xZc?=
 =?us-ascii?Q?WKEjT/jMdI4DYzbmG3iCCT4FZyeodf8vfma+RaO4A9VREYPXPiUBRgzQCYYk?=
 =?us-ascii?Q?90/ZLlbE6daRDp75CK71b4p+MxadWiuEp6bpUWObr7lY1lGOCWG6DOKURQZo?=
 =?us-ascii?Q?xOgus/S01+LhmtSqsPsFJdDSOuUHYrFgRc7729UfSj2vEClOPAdDy4ct2ZOu?=
 =?us-ascii?Q?tGp6wbn/EUBxusVzDwNiW2mSsz6ggCe4NIE5NJ1ki0+CO79lR9qq6i4LeERU?=
 =?us-ascii?Q?PMsgrDk/lq5iZakhtX5rYxfyEPNvNGjy0b8Z7PTNVnB4GCqb0/TA3rgJ8b6G?=
 =?us-ascii?Q?wAG1mQBdg1FFRj9IsUHHp4xv5nyqlrtPbG5sxIt8F1igVamVmiNi206l5fn/?=
 =?us-ascii?Q?En/R5lR1w9dHbTDQMTLPCBA6sMgaOpTEjRVqKYwA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6531.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8cfe83-8845-418b-cb14-08dd70b403cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 00:27:41.6619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWuX+3VprzUeH2U4+XBe/t0xIIYjXWj6BvmtLeBcDwF/Z6zoZPSa6SgpmfRMxjUFJOAweAXAgmt2Q2jOokhxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7648
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday, April 1, 2025 12:10 AM
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>; Xu, Rosen
> <rosen.xu@altera.com>
> Subject: [PATCH 10/10] raw/ifpga: use common base code build handling
>=20
> [You don't often get email from bruce.richardson@intel.com. Learn why thi=
s
> is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Use the base code build handling logic in the drivers/meson.build file, r=
ather
> than re-implementing it in the driver itself.
>=20
> While making changes similar to that in other drivers, also move content
> around dependencies from the base/meson.build file to the main driver
> meson.build file, so that the base code file only contains the list of ba=
se code
> files.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/raw/ifpga/base/meson.build | 21 ++-------------------
>  drivers/raw/ifpga/meson.build      | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/raw/ifpga/base/meson.build
> b/drivers/raw/ifpga/base/meson.build
> index 2de8e7ea22..efebff94e9 100644
> --- a/drivers/raw/ifpga/base/meson.build
> +++ b/drivers/raw/ifpga/base/meson.build
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause  # Copyright(c) 2018 Intel
> Corporation
>=20
> -sources =3D [
> +base_sources =3D files(
>          'ifpga_api.c',
>          'ifpga_enumerate.c',
>          'ifpga_feature_dev.c',
> @@ -23,21 +23,4 @@ sources =3D [
>          'opae_i2c.c',
>          'opae_at24_eeprom.c',
>          'opae_eth_group.c',
> -]
> -
> -rtdep =3D dependency('librt', required: false) -if not rtdep.found()
> -    rtdep =3D cc.find_library('rt', required: false)
> -endif
> -if not rtdep.found()
> -    build =3D false
> -    reason =3D 'missing dependency, "librt"'
> -    subdir_done()
> -endif
> -
> -ext_deps +=3D rtdep
> -
> -base_lib =3D static_library('ifpga_rawdev_base', sources,
> -    dependencies: static_rte_eal,
> -    c_args: cflags)
> -base_objs =3D base_lib.extract_all_objects(recursive: true)
> +)
> diff --git a/drivers/raw/ifpga/meson.build b/drivers/raw/ifpga/meson.buil=
d
> index 444799cfb2..4295ec04bd 100644
> --- a/drivers/raw/ifpga/meson.build
> +++ b/drivers/raw/ifpga/meson.build
> @@ -7,8 +7,19 @@ if not has_libfdt
>      subdir_done()
>  endif
>=20
> +rtdep =3D dependency('librt', required: false) if not rtdep.found()
> +    rtdep =3D cc.find_library('rt', required: false) endif if not
> +rtdep.found()
> +    build =3D false
> +    reason =3D 'missing dependency, "librt"'
> +    subdir_done()
> +endif
> +
> +ext_deps +=3D rtdep
> +
>  subdir('base')
> -objs =3D [base_objs]
>=20
>  deps +=3D ['ethdev', 'rawdev', 'pci', 'bus_pci', 'kvargs',
>      'bus_vdev', 'bus_ifpga', 'net', 'net_i40e', 'net_ipn3ke'] @@ -17,6 +=
28,4 @@
> sources =3D files('ifpga_rawdev.c', 'rte_pmd_ifpga.c', 'afu_pmd_core.c',
>      'afu_pmd_n3000.c', 'afu_pmd_he_lpbk.c', 'afu_pmd_he_mem.c',
>      'afu_pmd_he_hssi.c')
>=20
> -includes +=3D include_directories('base')
> -
>  headers =3D files('rte_pmd_ifpga.h')
> --
> 2.45.2

Acked-by: Rosen Xu <rosen.xu@altera.com>
