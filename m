Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417F1CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F5C5402E5;
	Tue, 16 Sep 2025 16:25:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 945D5402E0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 16:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032719; x=1789568719;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kqt8MmYnXbXxbwrn6Fmr1hvBIp8+HsT0fLhZGxorbK8=;
 b=hr0qS4DvyCLrCKnDnC0jHxQLiHqUXq2250N4K7ZlZY+g7ElYa3vEjH+5
 FnwqGRRbxbzq0CVZQhOGamVwefVlldCu4WagXUNANy+N2mUzxYirqmw6Z
 KAntcflR+QUN417HIRI0vn55aJRLTi4Qu+61L7Mez/lO9nMEpBs53hQpZ
 NDyyatfcjTAQfhgnye0oXQPIwco+MoR9XR6F44c0S0+EuXmnkAqPBgbmZ
 htO+0hAVeGkVi9xn86LtDWki+l/wfQgc5KxPQlQD3HSCHE144nPJm+IOa
 IN0SrOgCSggxWs9P5k8jXu12ZbSP0Y4SGqmjxgtlIgQLqie4pkIrEJPIO g==;
X-CSE-ConnectionGUID: Ka7d6F+SSRmql/uNrJ081Q==
X-CSE-MsgGUID: oq8FAhyeTxSDSHMb3thEeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59536541"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="59536541"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:25:18 -0700
X-CSE-ConnectionGUID: mQoLHpKfRIyXqSzU/2Mw6A==
X-CSE-MsgGUID: qvvNc0AxT0CgD6DvS+K50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="205736423"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:25:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 07:25:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 07:25:18 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 07:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1HOt1JnzRPImoWavNhtiANHAbqdUeNZH9qScNVoqTAKTMUMYsvOEiBoECYvf2VWG2zrClgTGOrTdcJlyiRHbiWGp8cF1o+AroLYmFfDjFe0eMI7EQhpCcNoL4mhnEt3ZLgoR2W/xihODWvcTInBKXIZmFgUA2XEDCfSueALc8Mi5pA2SRIdduBIKKO8p+8BdrWcaXMyWtU5QPGojUPsFEdAANueJWwrKE5d16SKzBz4VtRllVp3wpIC/1/xuqNTHNxDEWTYcR4V/kXDPUQ9IC/PRnx1JAtUoKjzea75qiAFCPNjZDKPJLECm8cujA+eonOTr7SnLa5SNCmJp3PTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ2211HmBIyLcYouxoiZeBjQmUOzw1cMm9RdBTHx6CQ=;
 b=nWdhw4F39gxNr7FwLPs1S3+Wj6+qCNS47aVG3eH8GOjyT+UPToGqzDWWLcNp899aepXhkGiID2VyHQ2m9KFUWLsElNpr3T+cN6nQgY5lQWxdh0mpybhqwtclk7BFPVrwhxzrAAw4peYPCyO6RPYmy6nIjgj3XY4zPSyl4zXf0JHlsMR6VIaIn844bF232IVUV05g2YOTTrFVEzsbudt/M8bUdIlhzluInhbOccSouEqF6LFYyXsawB4948ATAvux4CqgpGzFKJytjgWYt2plhg9ALjf54Hm3vbUcSQG273bgowgUuI9BPS8leqW+iHM6+zDHv/yRCiQfJjKfStkZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA4PR11MB8890.namprd11.prod.outlook.com
 (2603:10b6:208:55d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:25:15 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%8]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:25:15 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/intel: remove unused Tx struct member
Thread-Topic: [PATCH] net/intel: remove unused Tx struct member
Thread-Index: AQHcIing0otFJtmnPUqhkcgWSGNfULSV5uLw
Date: Tue, 16 Sep 2025 14:25:15 +0000
Message-ID: <DM3PPF7D18F34A19FFE77AEF41CA5280A638E14A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250910080616.892711-1-bruce.richardson@intel.com>
In-Reply-To: <20250910080616.892711-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA4PR11MB8890:EE_
x-ms-office365-filtering-correlation-id: 3075ab77-b175-4704-0182-08ddf52cdad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?9cZlPHQjYjBF/OESWgrHyyn8OfIOeHhVRSi9E7jpROCCsgC2A+4NMK/H6PJK?=
 =?us-ascii?Q?LuWRRiATe1c8JGc8IveUy3NO3C/mePgYLhRWq/zx5TYfRThCHNFofxDyX0sm?=
 =?us-ascii?Q?v4nJuKXyuChy6/CCvfcvcVDOLJImQ0qfMEQ5SzZ8xIAniCD/mDkkZQtuctpR?=
 =?us-ascii?Q?oLzLG6dlLhl/UQTAKWA8q1IU2i/rUYUbGwMwAWPABA+0f1+gi3pkbcOrQlIx?=
 =?us-ascii?Q?qDy3K110qnI5QeKfwH1518bKVZPZt+4wH0Wa347/acKxtJSFzw1kfxvIWfgW?=
 =?us-ascii?Q?r3c/eUhlRVtvrMQhp45asQBACr2gGUHRSAP78urtoj5RDvpiHTVkTocM/eT5?=
 =?us-ascii?Q?abcjurHMveRqOyRH5Sv5zQD69eBjo00i6YcJsPtlaKjTJLmUbQurhkbEYmvF?=
 =?us-ascii?Q?fliTp3E4O3OY/sBDB3Swx7PVuDK2uOnIpHh2s+keDKwDEygPlUON2/zbB2us?=
 =?us-ascii?Q?SZx+07oaQRSpw3RbbQQTgxQwNiPYbCnBEfqcws5t4Z3cMQkpdpS2bdb1wX23?=
 =?us-ascii?Q?oyS689m0Ce6xYt71cdZ0n+T1hGYT0SahjLWSvbbDRUIPWFWMS/f5gCCo/jMT?=
 =?us-ascii?Q?9jgOdq9F0uwuDzVKClbBMN2HXREvRK/GFFwIPJTbz6QULqgza3851ooecM7/?=
 =?us-ascii?Q?I4M0xtweeUg9JJaafmirhGdahJwbpshARJIAG18vh2Ng4zj87DRdgiM0oQbO?=
 =?us-ascii?Q?q9Pu6jHEx09ELyNCfSd8o624sUKkYfSw+wGhh60avlhHFe6TxwcGJX9/xxwf?=
 =?us-ascii?Q?i3mG+MSR7OFevZtYBMh2nWt2ZFTpxY7EupSYisD+FgInOP1UZKPWXTn1VrDt?=
 =?us-ascii?Q?5MEpoFbCIykEL0uebS2Ero9Km/IWGwCmByiWNaSvC8WGbutMYLDgg4p7KtPy?=
 =?us-ascii?Q?6e4QLaeH5mb/5Ey5nDTKbC3nGaxhw9js4WwhiZ3jM4b+faeZK4BU7gnPNAEd?=
 =?us-ascii?Q?u0d53YoWh1/YSeaLdT2HyFmT9a+PxuRc+eApNCPdMm30drku2dylUiVrT84T?=
 =?us-ascii?Q?UfqUlcwROIqm32V1II9tjnOVy5koBg056clx+81wiECbZdVCP+sNXEr8Rvac?=
 =?us-ascii?Q?H5qqJNNzm4uZGZtyjNAlzfUWqD8HVz5TRWCCs+ah0GmHfeUqXVnmDmKQ50J+?=
 =?us-ascii?Q?LAk0ieNRZnA1V4BFWC6UsS4YmTUkA+HUdvDZtCaKUSx/aXI5DYcgMCEuPAYp?=
 =?us-ascii?Q?CUx7cgAW+SjDYuY2CodDHUnz0EKnMDJsfgL7t1T3wvcXYFu3rs86Jmp2Xfx0?=
 =?us-ascii?Q?lh5rMJoeamKm4MoZpjrPibWGw5NXCurKvFA/8DYeZqI3oFsFwXoUNaDbnCSW?=
 =?us-ascii?Q?kFHgZUd+7g4Zr3uRnGzhzeXovCWLu5xOJwvaE3p4lD7pTqbGF6ZZFJ03OKCJ?=
 =?us-ascii?Q?W2tVO/NOI6Dk2uIxBrgEJu4lBqrWmQdbybJqZ87BkTxCQ2UzrddxXBZduUEE?=
 =?us-ascii?Q?DBxlcT/MHsDhwVkueEeTEY9ZOoADXFRpPrNDdJLYRluQyHfAN3U1gQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljMeOefN4ZL6tIcCeDFhvDaQa7PXmmBraqfBTTJjVbRo+/1hrtqcsXluC3sS?=
 =?us-ascii?Q?f97RRM9hb9inFG921p7aEhrjyuIpA2/GbHJXIc0IlwFknkg5okYaaM0APfMb?=
 =?us-ascii?Q?91xEjK5JBHqD87SaeDWala4LhmRBsyZFn+QBl65ty9EXRfZO5s6YkkTPrSyO?=
 =?us-ascii?Q?93RoiMIHk0hEJSTAUo5n7UMl5MLysN6w8DUnHaJOA04ANMHFifabu14Cg5oT?=
 =?us-ascii?Q?FmgTHHwPiaqgp9Q/Q51EV1FSPvWcs3xsomDGn/OhEXy64ZxFp0iSiO6Fc+M3?=
 =?us-ascii?Q?0l6pIBaFiLko/Aa1My/VyxZ595HxfN6XWHkDaGvGOfXT9gv6LRepd6uFNmZ5?=
 =?us-ascii?Q?+maGJue7HLU+3PLPQ66QWi0N5emRACJpd6hYHQhz+aG3Qo3DBzsgyj65UAJi?=
 =?us-ascii?Q?4Vk4YL4FBmwnl6CqgM7/b7CvyNLGXTKTkgG06hYsRwwOIFh0D5f/ea/o3dmy?=
 =?us-ascii?Q?jp5rhvp0VExdDF4P5fkGAZzGGKaZpKlBC1xEpjNfUwbENaNbbEWt8aHY138K?=
 =?us-ascii?Q?S8UTkg4gpeqsaY7fAHU7lKKGkkrGYAHMK1RELS7xvxOSbYE/eIhtDNEC/rJy?=
 =?us-ascii?Q?qh18Bta0V7sg7NZzOrJTA87ns4idYSG32F0kXUi+h4IT6tiyOJ4P+Jg5U/po?=
 =?us-ascii?Q?rYlIfz0xrM/9FbwSrhoRlKbqaDOBsftUVFZgTvKfU+Sml1x0lh1PpU0YCGVl?=
 =?us-ascii?Q?ffD0O+AWgztq7l0Z+Zu9al3lo+uDBFatmjV6wrUDAoNoQWEH0aX3GW17WBXq?=
 =?us-ascii?Q?dTEYF+Mks2BsixJsnptgpL8VuFJ7XqXME8VGvFlrbdZLaDxz/HyCP8hHG04n?=
 =?us-ascii?Q?XndNV2TuTe2G3herpZ/rFSe6mW3VgViqYIGdw3oZs7suC/EEJjdTD1RAaHct?=
 =?us-ascii?Q?uGp6lZf95uT5qTzbhFZ00ejYkXw9ZdoY2DRWeZ1zphBw7nGFIC1hrz80IPro?=
 =?us-ascii?Q?vHq9YM7uv/5z/e/oVnhwXSQqRNI+ceT3zPerwvXEjKK1l5ipjy4tfuixdLc9?=
 =?us-ascii?Q?JfKMp5V5ho66nM5PaUJHTLP63i1ng7+IAWxIiG75BuQ6jEuaBwoG9Nbd5egO?=
 =?us-ascii?Q?ZZ0T++hDfgvyfBGgeQW8aGUAJlv9tMRXSVfi822oHYNpCQEeKd93j4TP8kxC?=
 =?us-ascii?Q?kUKcQNtv2eAOE4TeRwBfqzDV6tFjBMTla7b0qJlc5mCgjths8LlAG2QpF493?=
 =?us-ascii?Q?zEVB2Vy9iO8mWfFu/ZENQDEEWMHl8FO1XyE85dodXlkUFz9YtrHi1OcWo0gh?=
 =?us-ascii?Q?t6GCMsTF4rb5RqTimY1+pry7a0I5I49AHNKVQrO0c4qXrUjyD11RxqpYGlxc?=
 =?us-ascii?Q?KKTuKRkMvyP77Rd173HhyaX5C7Dld2NYY1ELuHbbgGemByrp42Vef/i69Ca4?=
 =?us-ascii?Q?5nB4OsXccA39y7o16jF7rwsKlxq/hTrq/NNFNUKFRkHS0NZZIbpSFdugDpjY?=
 =?us-ascii?Q?LhK7VXBlSLdHI33OoHbx42+0Zk8752G+R6ifyaO7sWMV7C8GRbknWwWLa0Pj?=
 =?us-ascii?Q?j/75XJE70JwL7JeppfXTjLUWBG+bHrV26a2T6oRhMMFWaO0bDb/dxN5dmodx?=
 =?us-ascii?Q?GLBLDZN1tgK8HYJlh6nX1J+dQ2SEZHAGTwoYcB1S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3075ab77-b175-4704-0182-08ddf52cdad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 14:25:15.4665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQZHcWnRh5tKvsllGjp7qJto4qrO1dyxJhE4ZJ4jRVqHQyoN2CFOVcuryqvQjkLhEZTPhsjxej8+pneWpzGVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8890
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

>=20
> The rel_mbufs_type value for tracking the Tx cleanup function is no
> longer used in the iavf code. Therefore it can be removed.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index 7dc84da170..22eca21f65 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -84,7 +84,6 @@ struct ci_tx_queue {
>  		};
>  		struct { /* iavf driver specific values */
>  			uint16_t ipsec_crypto_pkt_md_offset;
> -			uint8_t rel_mbufs_type;
>  #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 BIT(0)
>  #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
>  			uint8_t vlan_flag;
> --
> 2.48.1

