Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CFCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2456F40E2A;
	Thu, 16 Oct 2025 10:10:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id D02F1402C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760602235; x=1792138235;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y9C6KEASRFtfKj/o2bE/xZnP6ydIZmNWURdhp2+NiEQ=;
 b=H6P5pKJZOF2bxuCB12ucNSUye+TVTw6u5h7WUjY7Uo0EZ7G5Y757IfQa
 8SgqdGWOqsyokaHb4mrTMjMUt8MaSWowWLceZ6nuye1+qt22niTNHF2gG
 Dt4OxSQBhGORZB6kTigY/vttaSTFricIVvT/reWY8qrpo5MDXwdXc6Dx8
 Ot0XPy2a+wTncn3pATi2zltlUOYJO1GmmTxF2VqLBHU8laK7HjZ3tsbUd
 atKhFFBLqdxlF2TCdIvN92TvgRTQ+NimEnHAyTZWb24anXCZEG+Ig8wuQ
 I20OTfmOhySyL+Bm0w3im31nqYMmJ1/yo4tAZDCo9CylVFG3y+ImGCGrD A==;
X-CSE-ConnectionGUID: dUwFiV5aR52s+XSomzt5BA==
X-CSE-MsgGUID: v0LpBkvsS4y63Kj5XpTHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="50353998"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="50353998"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:10:34 -0700
X-CSE-ConnectionGUID: qw/jphcvRUe2eZ2yuNLeBQ==
X-CSE-MsgGUID: EO89UJoGS5CWEQzvi7Y8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="186664044"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:10:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:10:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 01:10:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jtpb5xntNFCWkXqglq8C/NnKKh/8LWna+4jZez87KBMj29MJnYMySsS2BxZFI1w6Q0g6p7h4B7x4PvbgXCB8OfNIrb2mupfYI1VwAiacl3FCb4CPf7R4G7tva3goERnWhuiNWQRnijKZZtlPUbvkaeGN23paQxVh3TR3UD4iNEvWmQ1jfI/Hv/9OwV2ysbxSCLZ6fsfzBIbVco2IqrdlAEpoV0VXOjdtwyWNZnHDsiHSagP0InHdYcBeLdxgNXs3XgYWUKvheba7muizeh0atOelBFaKNaoSu7fitauwxzgy09UkGEmfDG752QWQq7cV9JZEdaZhzKw3FVEb/mhz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18CT8Dz71FNR8Mh7DRGh2i4rJwKOMh7ndh11+JYAxO4=;
 b=h2kRnFAZCH5lDxcws2kz6Sy92AnKYdUHff+XKeCq0AQmnqgyUHLrlMixaUT2ZE3c+oipjA5sbxCDfJeC1/FZnDRrpbnngP5ckKOijd+jSfTkLt/eKskAhca6EFCBWBqQg0yj+f83JLz6cc8CnekJ1Z+AQ4x8CPySSB+JH8/VCba91UtqW9HhIkCzzk1r7YgdA8CuTWaikcLWlfXjnPCLxMOATdGJcRzngq67H8MSqlxwHhExs6kEhZNhANZP65AYzHGah/pgsp+umA1mzZjPG7NgOhaluP/tYuvJ4jqCR5MHlrTfjfH+vXwFI6TokTTgPNQmC1gpJWm5iiK2S1ewQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 08:10:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 08:10:30 +0000
Date: Thu, 16 Oct 2025 09:10:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, <dev@dpdk.org>, <shperetz@nvidia.com>,
 <viacheslavo@nvidia.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
Message-ID: <aPCocj7Kn4KMTBm4@bricha3-mobl1.ger.corp.intel.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-8-thomas@monjalon.net>
 <20251015105025.573f5d3b@hermes.local> <2946607.ECZNHGQPT7@thomas>
 <DDJ5GW4K1EPR.1KCSDT2O9LO5G@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DDJ5GW4K1EPR.1KCSDT2O9LO5G@redhat.com>
X-ClientProxiedBy: DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 785ab9e2-debb-4b5c-61dd-08de0c8b790b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SSzn3ATJeZTVQTl8zMUTep5Nu7rvqkDiytm2rtDXDZO3eS1t8Czz2JKdNSEx?=
 =?us-ascii?Q?cSlaRic1dgrDbyNretqfaV/Ytfvn+RG7ZTvM+dC6Kx/1EnpL4ezQ9Smbt6Yh?=
 =?us-ascii?Q?3ajWRI/Q35cgg/IZv8L1E6A3UsbPAcXZB94PdduoYa7gSjjmNA9C3jVgESXB?=
 =?us-ascii?Q?dEuyMWtKefPld/esyO6xsm6XNrCrph+B/NhVU9/GCG6t3yR68yqczXIWxs1J?=
 =?us-ascii?Q?HT57OKkzq+DziNZC/ADMh03jN61jhLnocmxcwUWf1X4NpdZnVlkSlsRV8eFc?=
 =?us-ascii?Q?uuW2dKVPeupiajusEh4f2YtUM8ZqshjbWRY3PPBFnb/mTOJRm5XjnyDA5Qvz?=
 =?us-ascii?Q?d977rQR56cqc2fVUhQkOoEU08nP0BN831ZOUTHmrIvqjs5ldV8X+9QfSvZyF?=
 =?us-ascii?Q?R4NHOwQj2m3Ph/AJvV2jJLtLg3Al9rG/7crdQGMDAbhc5w0aRbz1PaTaQJLs?=
 =?us-ascii?Q?sgbMCsMS+3RgfwWgsdZYCK+RpsCuRhh+fvo2e6h7miZLoZVFdQ7+HLm2MIES?=
 =?us-ascii?Q?D480H+GU2rSOzQB6YxhxvLPIWSI70nTGdrudPstBkGmEccIXYS97Wl2uF4eg?=
 =?us-ascii?Q?16jqz2dvTTk7GirzrGfR5XJHBYOZZjxI+wxMSKfHovF27rHOMFtKanztRfE4?=
 =?us-ascii?Q?rwJxwRxnhQpOxzZ2iKc5evG3bYEB+HKmB9HU+hNXw8snb55GQwbiB9hGjFcL?=
 =?us-ascii?Q?EfUih9zB/roPCxroXcEZxrR6RiVvqNUxQOuDUX7aLrRCcHA6N2GDLJ/P/d6B?=
 =?us-ascii?Q?p2UnfTaB4GenxVGKd1ls9l6+kc109UWzwZc7ayBVsGeKq23yUkpRLuNP27JC?=
 =?us-ascii?Q?tUsjc5i2wTdhQLGmSAG1MI+22y466hCMUn8fSMDqfUyu41F4aGvItIa35x2O?=
 =?us-ascii?Q?lGoLIu/Kvip5rp2ak/lLmYr6pM+tSbHittwg3F8MKBvIAfvzemiTp9Ac2Zqb?=
 =?us-ascii?Q?EYMcqfHYv99Ij75rCCP3d6C+/f/LahO8madeFgakqymRKmXdO2XDaK86sFFz?=
 =?us-ascii?Q?x3cXgy2ZuE2jWSg+V1kiR8CeYFuqGgVGRhWBdFbyL9uikpW1xCEBhrWxxV+R?=
 =?us-ascii?Q?LpB0oHHqAyUzviXCbOStVe75mI/buPQD43dCacLrgj4Nc9rhkNdxeYKEWnkO?=
 =?us-ascii?Q?bu6RvFnWmUXulofsXySGUOGGgHlNDe8I6qE+i9o0cb3Intn54W+7HFhe6trJ?=
 =?us-ascii?Q?n0aL88OiERi2tD4iWnWcUy/H0FO0MNc6XLRpztvmD1CZct5F8rXQ8HXht2Ph?=
 =?us-ascii?Q?3dYXEZ7ESz3PcT3FRiWVErgmPjzmFLcU8G4y8YXmv9SCn20yB2XJaXUZtn6x?=
 =?us-ascii?Q?iwfxTd+3WV3N9yH+/nXeyH6rViZ89l9gunCNlslHCYMi5jNBL1KEZ6IzxurE?=
 =?us-ascii?Q?huX6WFE5A2bEI1M36MvbHLHbeG+cH49QmcePlPLuOshOIbpi6KuV6pkRGSuO?=
 =?us-ascii?Q?1La+rfnoNwq1c/NNWuqApmgtuk9hoLGV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYRtu29X/cY0g9CU1X9ujdCQyS2miy1Tk2AYyjMD2juFLuX8gEVwlpr/4vE6?=
 =?us-ascii?Q?z6WHgVw96jQyC8H8LBwjBLXqyOIgX9fdK0XFxsRReDSuBoJe8ZnLxJE1yteC?=
 =?us-ascii?Q?ttH0qVKi3knewDdN0SasjsSlHlrvMsX8EbNnS5Xk+gITNNIwsfJjsTepHTNU?=
 =?us-ascii?Q?3mLzLVcJJxCqe/pC0lfkm6v2gXJhBSIiV7dqGZhdDGblSOxwfvv96uhvpXuh?=
 =?us-ascii?Q?QJMlMnROSzLLbKjl/nZqyTK7tnd0xsvab74hiEX7k6u1NdnVop3OJvxw2gBz?=
 =?us-ascii?Q?8xRDsQcl/4pCWX6aap9ihAvwmTiAsibt1jgjfFRiHj0MOATyEwbjDm52BlgT?=
 =?us-ascii?Q?La7kGQmNYeshA48TRlOFPpzKVGvyG9GoZO5aYO578pG6JawBBMm4ZLKuYv0J?=
 =?us-ascii?Q?15blXVZLerYkjYEDkb0Er06omwwPgerbxptGoTHQR+rjoslQSf5VOEpc23wG?=
 =?us-ascii?Q?crkwIP0pZbUF0eI4quQtgY1Mm49rRyshfgQI4kZ1NOCIoKdvTo0Ylsbp/dNn?=
 =?us-ascii?Q?NCL/7lqzD0UH6lUs2mwAdTkWn8ir1pq4FBthfyauus3+3biylyeRoTblN2TY?=
 =?us-ascii?Q?wWsuYk7acseL6Mo1uq3/gBK3VCtnUDker4LHLIrhPzKWDf1c2M/Ply8/FW5Y?=
 =?us-ascii?Q?ZkQv4NeCTmatLbcXnQT6DN7O2mT2d2kcpdJi1AfuXQGtiw6GfQ+qUvaeRV/1?=
 =?us-ascii?Q?sGP6DC+cnZWvispEu6Yh6fcrTzJQhaYaKCKRgfr2pe0rhJ/bNgLna0B1Ozm4?=
 =?us-ascii?Q?B6G1abTkCF4RCH+5new1kh+aJzz3OmkcgfS84YP6kb0YdGkZLEGMMktMeTnq?=
 =?us-ascii?Q?OUQiVC7aPHaqmfFmq9PAM5T+WylclcjLD7n3vz+zEcjqasZ9X3QtIdhCW7qc?=
 =?us-ascii?Q?BYmgwsnVYLqKO390GtRxB3g5AzVNNz3Ef/WLZDBtDBikmCwwnyfuOO0/Vxam?=
 =?us-ascii?Q?FADX+z6H/6kSXYZY/uzT1sC9/FDq1RS/G3iHH7akslFt31LqgA05bLOi3XWe?=
 =?us-ascii?Q?v0+xvHP6vlFZbgg0TdBax7bsEDITexSrYFZVxBIbECU31WGSi8zp74Syq0rZ?=
 =?us-ascii?Q?vgC3Q9Itut5+g1fQDirP530dHiz2IX1Y0Bn4BurjWuDvTifg65ZAHW1E2yes?=
 =?us-ascii?Q?WwQEycr3mRX5SDFr2melufMmPCXOyh2Q+JmRmjYQfC2uDVsCHYlwYhpEjvaF?=
 =?us-ascii?Q?YQX4kD8ug5y2PHpzNEl7H/yeJMlz4fnl42of7NTuopCCERNCyvw8IKacEMdi?=
 =?us-ascii?Q?A1cDhe/vbDcx8Bl7S3RbV01OkuEotdL6CLi4dnGAP9PgITQD+R5chbJCqTke?=
 =?us-ascii?Q?JWZK8caA5zHKjN3mnO6rEjyeW15gmY5ElMuVibd8z6h2qXoBnVlAs0U+nskq?=
 =?us-ascii?Q?krQwrEuolHl4wEkDd0lRGO6AezUhGjbRbQYTHrG9DFZaRvNbGjfaPRnJdDyT?=
 =?us-ascii?Q?cwgryNQVTdO/7cLSuc5c6jhtE2Y76I97FuExl82Xz8EOyN/GEGU9g6vOIh6x?=
 =?us-ascii?Q?zZyqP+nkgo7rAlrHm8zMmCP0eHazg3ijwGQybAencjoi2pyHUeeu2p1xLNIJ?=
 =?us-ascii?Q?MglUBjEIkYVPctF4KQvVc+EahtEcCvfgpu/lgHkjrRJC13qxFj3uIeJ/gR2/?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 785ab9e2-debb-4b5c-61dd-08de0c8b790b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:10:30.6557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCULW5Szk0Dyfbphb/W2c02OttA6ZZcX1qntfRlH63aykg+s4DJXqDnmAoRGGusnM0+mLPjXo6ycJqxmlvw/cO91Urwlp/BWJJ2W/JEwtIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
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

On Wed, Oct 15, 2025 at 09:41:18PM +0200, Robin Jarry wrote:
> Thomas Monjalon, Oct 15, 2025 at 21:11:
> > 15/10/2025 19:50, Stephen Hemminger:
> >> Minor stuff.
> >> 
> >> $ flake8 --max-line-length=100 dpdk-mbuf-history-parser.py 
> >> dpdk-mbuf-history-parser.py:14:1: F401 'sys' imported but unused
> >> dpdk-mbuf-history-parser.py:29:27: E203 whitespace before ':'
> >
> > Interesting, thanks.
> >
> > I'm a bit lost about Python linters.
> > I ran black, should I run flake8 + black? something else?
> 
> Just black. Flake8 style is completely obsolete. The unused import
> warning is legit though.
> 
> We should have a centralized python linter process in DPDK. The main
> issue is that most of the code will not pass as it is :D
> 
... yet!

For python scripts in DPDK I wouldn't have a major issue about having a
patchset with the results of a black run on them. History tracking of the
python files is not as important as for the C files, since they don't have
that many bug fixes on them to root cause. Once we get everything nicely
formatted then we can mandate proper formatting going forward (and
integrate into CI perhaps).

/Bruce
