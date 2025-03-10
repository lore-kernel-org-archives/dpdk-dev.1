Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C781C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 16:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9A7B40279;
	Mon, 10 Mar 2025 17:13:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id EF8BA40270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 17:13:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741623238; x=1773159238;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=atBfl4WqVsT9DsOAPaT3yN/dBUylDP2LtAM7WwPeaqE=;
 b=NUl82ea1/WDzQne00J2g0oUDuYtxB1kRhRDnv4iA1Bw9tZjIlnulZxtA
 /E9eBNMtewCbG2spDdJYUZvJyXP24C4i+drXWBk6YlP29KjXSCDXnc8Bc
 vMglSvCjmCtu4hccFddRbW3IWR0UlrVOKzey7u4xZMeD544QM//kQHHhc
 PQetxgrJkPKV08XEJMON3aVsfIjloADvOCbfuwEOF9SWLbLycc/S0EstM
 FQswfkdyAhMi+4J3fcB3aohuzeWM+OsTnv3pftgCz8xB8xmcsXmcmD6J7
 so7TMIX+jzb9pYe7ZCvCaFEZDsktYLgB6wdU4fCidMi52BLEw3fPN9Gjm A==;
X-CSE-ConnectionGUID: mmLyA8Y+Td+Vkh7OtPkUlA==
X-CSE-MsgGUID: JX7vk+epTOKnXdKSidrhPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53617446"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="53617446"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 09:13:56 -0700
X-CSE-ConnectionGUID: ayCZlNEWRRy6lG3oOaGmDw==
X-CSE-MsgGUID: HVkTJICNRiqexC43Km/zeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="124192732"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 09:13:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 09:13:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 09:13:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 09:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx5+xn9bmDQ1dokboIXE3US4jlQAFefFOyi4i4i4n2HwF5Op4t0k8FAS8Ve906+4LxR+vgIE2WWf2NMbSRvGruLjBkfj8+EheWP7Nurr/1R5+S07/snQncLI4JPSx0mbz5vIO6FgusIOY4j01b5Hw2F0ZMAcfHW6PMsOPU3lvNxmFJUEt16FSIpuUI6d75t0+wtTA3cwGQBeiyh5Y7R0HdkdQFRXcoNU5wyFr2K1vD4S1+/Bv60QlCobb679lf+YS2nrY3II6qWmaqo5/lDCsm2/y0/kUof+kNaDmd0IJZtjGo2waTlOPZSu1fTRJv3t7fQ31oD4sFodXWn9bnFkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQLNQJYlmVwzysgjkjfMy6EK3a3t6lG9/IV9IJBTCfc=;
 b=hJDAOhAXwQQal1swHa/CkgIv9goW5IMVCkmjO9oGYKy5xybDMxdi2Ld8VLCl8VaXCDnox4yuwT/Y6kQkXP0taOpCFwkDYmMD2+c1pNCTx2+ox7M5cQHcc8lxt98IBw2Nd0q658mvuk7DDmFAPy9Jm2BUpqTFmb3y4wV4i+QcJDzIDfu7y/Hv098+Ikqk6cLPXHvxnnPoemmcovo1f0zvkIjYlMQ23S5WQM88IE5AWtkShbp3NFihbr8aWmmofqj6rs6XlW7VKOiwmCvCP682L0WqtEzHBguKmh4F11ehowWg1mVhIdz74wsNBICr6HfWdg/GyrPZZimUooNGuKRKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:13:21 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 16:13:21 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Gregory Etelson <getelson@nvidia.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mkashani@nvidia.com" <mkashani@nvidia.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "igootorov@gmail.com" <igootorov@gmail.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH v2] rust: support raw DPDK API
Thread-Topic: [PATCH v2] rust: support raw DPDK API
Thread-Index: AQHbkFsX0wEasGJJXkSh58WFPgC4fbNsfkLC
Date: Mon, 10 Mar 2025 16:13:21 +0000
Message-ID: <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250308185031.979893-1-getelson@nvidia.com>
In-Reply-To: <20250308185031.979893-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|SA3PR11MB7582:EE_
x-ms-office365-filtering-correlation-id: 8873055f-6611-4500-7ee2-08dd5fee7a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zYvEzcRNeIE/jelbz+cgRQp84WF+Vy1hnQ35kzW99beCXF0du+f12FIYDR?=
 =?iso-8859-1?Q?DJnfu0g9nsRzk37T0PCOd6OID1YtXw5pPfYBmrhVsCdOTQz3VgintkDrii?=
 =?iso-8859-1?Q?PXjZyVw09a5jN/qU0cq1q/AvM3lrA7RWYMmj7TjhzkKeR0h2WwgNpwcCh/?=
 =?iso-8859-1?Q?2/41lsxRZRC1f8tDvsPOu2ZBMyiTFatnuH/wfDc0yQRABu7/+qIMP9WueN?=
 =?iso-8859-1?Q?QWEaDQV9T+Yq/T9+cR06bvFCMW2En9t4g9s7kD7pLn38FR+i1lkrhqDqGv?=
 =?iso-8859-1?Q?wFxzcfbFeYfABrbep6lwleIgn1tODj6hkjHme19EToFlAf30c5oH18ot5e?=
 =?iso-8859-1?Q?8sviX/YnT/gCH5QAZ4qxPUdM7AXWCXvSeHxO9TgRHYWM1oau2oANTc2E/S?=
 =?iso-8859-1?Q?x8v97M12LFEpue7TJaraFwRiR8BzBh7VDFslv4wf+iy4lVbitFiNw5367N?=
 =?iso-8859-1?Q?lzN4zqUdmBFBft/frbBulBma7xnWCm7B7y1Cbbp41RvOQz6KCfAzX7rDZQ?=
 =?iso-8859-1?Q?m8YTiPwYj9tFcl9nYVDW6VBW17iCLL0kLfcORKvnRjIxgdOAkiuyOlFYXp?=
 =?iso-8859-1?Q?fbrI55lWHomd4sHNTlVMLMYvQRPneh9sZqfhBdsoxh239DpxwAgDLEtQAD?=
 =?iso-8859-1?Q?6wqbeltAtRp+co+LsnoJmkIYZaiouSw2ncttHUmix00RYzojeK8rW1GnGB?=
 =?iso-8859-1?Q?uhS3ippse88p2m/nBd0Ux51yoyEDX9ZtS38Tw9u5uNY8R8kkpMkLbttia1?=
 =?iso-8859-1?Q?LDFH5kuIbDkcUNqtr6HED7XWmoWt6bhkGSs4RKCyrVA0nze+uhv6TolHjL?=
 =?iso-8859-1?Q?nJx1mUh0hf1eHbDgkNniQdQjZBrK1SUbSzAnsVqgAzasscl+TLcaQvghzt?=
 =?iso-8859-1?Q?/XrIweJW0Pqu5UOy/rb6NOesVm+kY3GPtD9RBReWv17bU89evdvgfl7VQ7?=
 =?iso-8859-1?Q?NKo1gfwbj8a0LS7JKu9PqRb8JVtUAocXcJNrka2r3WLd8Ni4F9gZVTudiX?=
 =?iso-8859-1?Q?+CWBPCw8nFxYW3Wh+PUeOBEa68iiF3FMLBT3nlPTxPQ5wNpfaflUEHpTcg?=
 =?iso-8859-1?Q?JMArnYm+xSywgQBnMpO+hazxXkLQit+rAYU2X8avDXUFDbstGh8mCW6bjv?=
 =?iso-8859-1?Q?OyLwPMSetr8yi6gkj2tHZdTTcVWThZnQtxGzUpyhZEF9yqIMvwdRCnsNPV?=
 =?iso-8859-1?Q?556I8L6B7JrQVpsJBV1t3IenKfTzJ/dZdcis94al4RqOmW3W+qRD+qXPh0?=
 =?iso-8859-1?Q?546oiLPFHW5Yi3J64Yzt/yShDUvS+d6WrxzTncV9hUbkCyPVtqLfdAZavz?=
 =?iso-8859-1?Q?4DrbfUceBxGv5sGkcVGjPAzZQrv43Rz/iDHpaB06EoAj4Ob4jrHyLX9so6?=
 =?iso-8859-1?Q?1HQJ0yYDAAg7u7zS2oGDTJRk27BMwF28OQh6Jqn7AV4kCITjxuqViSJn7t?=
 =?iso-8859-1?Q?nb9+aes1L29YET+iZzkNSdr0HNExOQzCKW9LgQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h9eLSsfWu6e5DRv6vqd0Z4+/Dufl6Tm0rs3myd/S8anSo56xmw9B0BRcXr?=
 =?iso-8859-1?Q?Zl8tCA3PamBgxWHMXQ2PgT0b5M5KZozvVJdQbuBmmFlIo+X4w7LPdVPv+o?=
 =?iso-8859-1?Q?PQmlogqR/EsZNIi/nKdMOxpT41gKG0O2GBZrJihSSBq8AWWtuICVLupjii?=
 =?iso-8859-1?Q?nSM0nHLTTauw9OBEUGSlUdtVAr8M5DCcpFdwNTdYXnc8b+Zz++VkPbdGyN?=
 =?iso-8859-1?Q?zWYWo7VTY+LzviFcrUzsYaF5RUgTeWj5bByKPE3WCKp5iPkn5uGtoJlHCA?=
 =?iso-8859-1?Q?+qQmkAvt/uP3KaknlmZ4MkIyFzg7OrPipUgG6Pk9K25X4//R9GTHDhexpB?=
 =?iso-8859-1?Q?yg6BbgO6fC0fRf22WyNDojhDX1DKFSTYRb1PrESwwpowk5iX8ohVtnYRWS?=
 =?iso-8859-1?Q?s3LiXpg0G/T6XuvXltRRgIE+LF418fqJek4il+bIpTrsJL2fEaDcKRYJLD?=
 =?iso-8859-1?Q?1xCnd3irGgVWpjI7vR9YiFjJyLko61GEC/gJX2zeV3LLR8Aq6FRWCT7lfO?=
 =?iso-8859-1?Q?FheIhOaj5eXzcKv2xcVlj6CJ99lk9Ul4QOxD1uHiWIkt8TLjNUtmIYlkms?=
 =?iso-8859-1?Q?BvH8NGQp8QGnKPVoulumaAEk1ZmNvpJsn99qqza9LLGY4V0eo/thseMNnw?=
 =?iso-8859-1?Q?eJ2ONav6EKtF8XkmmRG8PhRORkvQXZ63rjxzsYFqCgh5if/86K5Z4rpiyL?=
 =?iso-8859-1?Q?SbOaiUwJK0T++e5MPk2KlkSP8vD3xcRc+WCEofk7ky22cLt9SKuFTr4Crr?=
 =?iso-8859-1?Q?G+BzWWsplxQOJuiWl8sLHBLbuw2Yl5HksR6uJfbjBxiT6eAx/+FBfSwhjH?=
 =?iso-8859-1?Q?bGo6MSpMBfDlwnjC+sWM5CCDKlah1Sz/SsrNUZLvHolawcfkIbmGrrf26O?=
 =?iso-8859-1?Q?TcqUJiLcKmBUVH7io3Rzf8IuzKgHfgc3jhrr5er0HZRahaGQ2m5w+PoZdR?=
 =?iso-8859-1?Q?umgUOmLUinAiMLOoa17HUyusxCA3UskeVgs+EecgcTuGbu5IedNzFLIavv?=
 =?iso-8859-1?Q?a1GCcWVBkQSPMomdCeMnKJYdBjDSkL9eghFwzsa6m/EDeAzxTr2WWGWS8j?=
 =?iso-8859-1?Q?kCKfEaVyF8NhqHxRWWIR/Ll9kVWLrgwFTxR4kQpJ/pWYGL3rFTzGSG1HyQ?=
 =?iso-8859-1?Q?QQQmh1Bq2HdFQ1wtnMIhAciYCk/wlz6HXt3yexjHzde8ejPXIa30pNJEfq?=
 =?iso-8859-1?Q?WiJqmKPkT9J8Y9hibCN8YdDJUjqPdB4mFA7eP6/glpnhHAJPP5BoXd3lr5?=
 =?iso-8859-1?Q?P7H4l+Ra3gOaK8CLdjCZluld+R9duJVzIupWAGCavTMrXMZ3Bqj9+4twGb?=
 =?iso-8859-1?Q?VMVI5G+RK/092EyptGACSAGoxg+Tfu/1iUi62GCYAqXxT4BNaPBo7oqMv/?=
 =?iso-8859-1?Q?Dw/E9SqQhrkPd73cgCO+r6QTsYPhJx/DNSN/woqPyGOur5RyBAMuWMbGdA?=
 =?iso-8859-1?Q?xb4pJetrPm1IdmYc0e6ue+Ecb2iNiRXxgZEo8kRWtdsgR4dwB2C4EsvbPV?=
 =?iso-8859-1?Q?XHUpvWxUSYg+VKkUs689ZJEHr6NqpkokFszTnb/WutwF8//V/tcj6LyX5h?=
 =?iso-8859-1?Q?qawcCz4dEjZEXCbSIFR4SRHsisPAON05DPaMn5evniDw/aTTqcFQ7f/Uei?=
 =?iso-8859-1?Q?gvRAN5Xj9DiKc0VB6PTszT3G+yMRven0kG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8873055f-6611-4500-7ee2-08dd5fee7a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 16:13:21.2333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVLF8LHjscNueCRGn4SKcFqhZf4xmDKrdXXMk9Ndm89DyZ3ZJ5ozMZEKzwMDHUhZOkcF+XAiBFL/P+uJ2OHW9REhXWIYl+uEyTvqwlfQvM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com
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

> From: Gregory Etelson <getelson@nvidia.com>=0A=
> Sent: Saturday, March 8, 2025 6:50 PM=0A=
> To: Van Haaren, Harry <harry.van.haaren@intel.com>; Richardson, Bruce <br=
uce.richardson@intel.com>; dev@dpdk.org <dev@dpdk.org>=0A=
> Cc: getelson@nvidia.com <getelson@nvidia.com>; mkashani@nvidia.com <mkash=
ani@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>=0A=
> Subject: [PATCH v2] rust: support raw DPDK API=0A=
>  =0A=
> The patch converts include files with DPDK API to RUST and binds new=0A=
> RUST API files into raw module under dpdk crate.=0A=
> =0A=
> The RUST files and DPDK libraries build from C sources=0A=
> allow creation of DPDK application in RUST.=0A=
> =0A=
> RUST DPDK application must specify the `dpdk` crate as=0A=
> dependency in Cargo.toml file.=0A=
> =0A=
> RUST `dpdk` crate is installed into=0A=
> $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust directory.=0A=
> =0A=
> Software requirements:=0A=
> - clang=0A=
> - RUST installation=0A=
> - bindgen-cli crate=0A=
> =0A=
> RUST dpdk installation instructions:=0A=
> 1. Configure DPDK with `-Deanble_rust=3Dtrue`=0A=
> 2. Build and install DPDK. The installation procedure will create=0A=
>    $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust crate.=0A=
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.=0A=
> =0A=
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
=0A=
Please include a "revision change" summary, this helps reviewers understand=
=0A=
what changes you have addressed, and what changes are not present. This usu=
ally=0A=
is formatted below a --- line, so Git doesn't include it in commit notes.=
=0A=
=0A=
Also add to CC any participants of the wider email discussion.=0A=
(+CC Igor and Stephen here now)=0A=
=0A=
--- =0A=
v2:=0A=
- update rust crate name to "dpdk" from "dpdklib" (Bruce)=0A=
- update binding generation to use dpdk::raw::* namespace (Bruce)=0A=
- <were other comments/notes fixed?>=0A=
--- e.g. "rte_ethdev" -> "ethdev" namespace change?=0A=
--- e.g. "cargo fmt"?=0A=
--- e.g. "build.rs" simplification & fix?=0A=
=0A=
Pulling comments from "detailed review" email thread (see v1 on patchwork)=
=0A=
- Gregory: "The idea was to provide generic DPDK API and let application to=
 resolve unsafe interfaces."=0A=
=0A=
For this patch, OK. But we (DPDK project) should take the next steps, and p=
rovide a "Safe Rust" API. The main reasons are that:=0A=
1) DPDK APIs have many rules around multithreading; (lcore concepts, rx_bur=
st() threading requirements, etc).=0A=
2) Cross-language bindings are hard, FFI is hard (even though C/Rust is one=
 of the "easier" ones)=0A=
=0A=
Overall, I'd like to set the "goal" of Rust in DPDK to be "if it compiles, =
it is correct".=0A=
For example, if compiler allows "rxq.rx_burst()" to be called, it must ensu=
re that a &mut reference is valid at that point.=0A=
That gives a Rust bindings *actual value*, as opposed to "allowing DPDK usa=
ge from Rust (with all threading/unsafety just like in C)".=0A=
=0A=
The bindings are the required base for that: making it available. But it is=
 important state=0A=
that these raw bindings are NOT ready for Rust folks to go build applicatio=
ns in "safe Rust".=0A=
=0A=
=0A=
- Igor "Indentation/styling is a bit off or inconsistent. I'd suggest to ru=
n `cargo fmt` to format the code."=0A=
=0A=
Big +1. Rust has a default formatting engine, and using it means everybody =
wins (no checkpatch, no manual style rework).=0A=
By reworking (and auto-saving..) my updates of the first patch, it reformat=
ted a bunch of code, losing my own changes.=0A=
Small things like this really hinder productivity. (Off topic: I'd like to =
see a DPDK auto-formatted for C code too!)=0A=
=0A=
- Igor "I'd make `init_port_config` and `start_port` a method on `Port`, ra=
ther than a free function, but that's just my preference."=0A=
=0A=
+1 here too. There is a logical "ownership" of functions to structs. For va=
lue added Rust APIs, we must=0A=
not copy the existing DPDK namespacing (it does not capture "ownership" in =
the way that Rust API should).=0A=
Instead, logically understanding the thread-requirements and boundaries of =
concepts like an "Rxq" struct instance,=0A=
and ensuring appropriate Rust "Send" and "Sync" bounds are applied is key t=
o a good Rust API (as per https://youtu.be/lb6xn2xQ-NQ?t=3D702).=0A=
=0A=
<snip>=0A=
=0A=
=0A=
> diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/hellowo=
rld/src/main.rs=0A=
> new file mode 100644=0A=
=0A=
<snip>=0A=
=0A=
> +pub type DpdkPort =3D u16;=0A=
> +pub struct Port {=0A=
> +    pub port_id:DpdkPort,=0A=
> +    pub dev_info:rte_eth_dev_info,=0A=
> +    pub dev_conf:rte_eth_conf,=0A=
> +    pub rxq_num:u16,=0A=
> +    pub txq_num:u16,=0A=
> +}=0A=
> +=0A=
> +impl Port {=0A=
> +    unsafe fn new(id:DpdkPort) -> Self {=0A=
> +        Port {=0A=
> +            port_id:id,=0A=
> +            dev_info: unsafe {=0A=
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> =
=3D ::std::mem::MaybeUninit::zeroed().assume_init();=0A=
> +                *uninit.as_ptr()=0A=
> +            },=0A=
> +            dev_conf: unsafe {=0A=
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> =3D ::=
std::mem::MaybeUninit::zeroed().assume_init();=0A=
> +                *uninit.as_ptr()=0A=
> +            },=0A=
> +            rxq_num:1,=0A=
> +            txq_num:1,=0A=
> +        }=0A=
> +    }=0A=
> +}=0A=
> +=0A=
> +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<I=
tem=3DDpdkPort> {=0A=
=0A=
Looking at the above parts of "Port abstraction in Rust", I'm not sure it r=
eally adds anything.=0A=
It feels a bit "middle of the road" (aka, adding some "abstraction", but no=
t going far enough).=0A=
=0A=
What if we took an even smaller step: remove the Rust struct concepts, and =
just call the "dpdk::raw::*" unsafe=0A=
functions directly, as if they were C code. No "struct Port, impl Port", an=
d no "Iterator<DpdkPort" concepts at all.=0A=
That would show "correct" usage of the raw generated bindings, and provide =
raw API unit-tests.=0A=
=0A=
In a future patch, we can start to build "Safe Rust" essential-basics of EA=
L, and Ethdev. This is to abstract over the=0A=
"dpdk::raw::*" APIs, "compiles =3D=3D correct", end-user documentation, etc=
 all as is normal in Rust ecosystem. Example:=0A=
=0A=
Today: V2 patch (note the "Port" struct in Rust):=0A=
  pub unsafe fn init_port_config(port: &mut Port) { ... }=0A=
=0A=
Future Raw API (note the raw u16 like C APIs):=0A=
  unsafe fn init_port_config(port: u16) { ... }=0A=
=0A=
Future Safe API (mockup, this needs thought):=0A=
  let ports =3D eal.get_eth_ports();=0A=
  for p in &mut ports {=0A=
     p.initialize(rxqs, txqs, ...)?;=0A=
  }=0A=
=0A=
Thoughts?=0A=
=0A=
Regards, -Harry=
