Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1975FC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E84F40E64;
	Tue,  3 Jun 2025 18:15:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 885B540E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967324; x=1780503324;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DdFBEDGX8wrIp18i+a+N2rpMlqHhuTglT12/rhdZWz0=;
 b=g0c1gsb8eFRvig8OIPtN7PvxC8oiM0oxGO7txzxuEt/BuzhwXIQp9/kM
 qjKAVPtZ3QitFlpVO6J0yfBF/VuDAJGNW5yvEX24+cFuxXyIHXWXy+kg2
 td0GW67F8BprClKdKClumm5WAQ5VRDyzgZYL+CKTM1R4FB5mjWhVjjXen
 7bi3Gkd5/ayDx8Os+xObcKq7LOwc2Zv2ghceTKXCxZIjMHE5h/u7EhSjn
 RZe1ILnLyJ74qE9OHdmjhY8DYyTn1EcmA3iPTG9BO+DmjahiJtho2+Vyn
 F/nvfVSlWBStZy1ytQgyX8VJUMqYyfI81vpIMwqMo4gWO3L2xrp5756eD g==;
X-CSE-ConnectionGUID: 9lHy/GSPSa2fGulST3An5w==
X-CSE-MsgGUID: L6HuOqW7QdWRihJaAT67bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68569905"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68569905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:15:22 -0700
X-CSE-ConnectionGUID: LZQte1n1QbWlvABNnSJl4Q==
X-CSE-MsgGUID: VKkGTAS7RImY0g9F2OuNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="144937792"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:15:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:15:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:15:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.75) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:15:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP6aiz+4raFFXv/pO51re3yHjQLLMAsp3KDqy1YA0yQrcpZfNo3pRQKJF61F6dMtjv2rvQ1NeDkzaPjgQY0UkZPpB/mpNy9kuDKcvFh9C1nn/SA214UE+VFATJuhgC6E/nos5DnxvSuQJLfJMQzyYUvfO9kIuA0GkP6qsUdkseiUmOwf9VvLJGMgFAmpSQoWZuyaaTlG1MbHGJbnJdKRULGEUgTRZdV/LMlFIQ4PTTKgp8BNGbzbbYOKk9nQEeNXQn8vZwuOAHcRdPeloqLlYi8/n2tiv9+pq/RuDczLia+zSFQGuammgk04AI4cGvKjr2HSVSzdP9YZVTKyNRde4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUMib/fK+Mu65QACSaEsdPDIGi64c4HUDKhSdFgJzgE=;
 b=LRQRPuGY8byg+1jy0qltyjAEfrjR/ZJUdYSmBvbHpPHkEQ1+PKP1LFv8iVlBna/vonDDoDn9a46Mdmiyt+OkobQHXBMJ8ikRTqpW65wi/RgoDfyQUSi8VZuGs6q22rXlySRoHNWXUri5G+nlvMCzK3uZJSWAyOD9AC2yHuoVTacMGS6sSYMiR7QMARQXOf0YzSuIzZLCRgf8agPbluzs6auK056SYWQZ0IPoYgZWLluUJfYrD7+UPaW3qNjpRRjs2XqGbuRzkVuvam26ct6n9yIb4wL/6NI7l22Y6L2X2WWAOKqef1z6IQbt5LbAO2Z3AEl4Y4FPi5C+wBwA0W91Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFEDAA4523C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 16:15:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:15:19 +0000
Date: Tue, 3 Jun 2025 17:15:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 10/25] net/ixgbe: replace always-true check
Message-ID: <aD8fkl-lj1e4fP1R@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <68fd21f49d489deb96300f3fd488f8162eaf79b3.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68fd21f49d489deb96300f3fd488f8162eaf79b3.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFEDAA4523C:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb417b2-8d71-4dee-0804-08dda2b9d55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q1d+hjrANwGJsvTxoM7Z9e9Qbe6dQzKeWA/by6RdnFdlCtoIqrRlQwROtzqC?=
 =?us-ascii?Q?rOPCH2HmkplWtA5YFkyeDG9yNIYKkjbugzGiWKdfhwjYcEiZB+Ab8Ehu2HzM?=
 =?us-ascii?Q?LY5/JC41rCfcJqjTBo8jnEBHFxN066UbNnKSoaeGqsXru78wQwY3RF2N134y?=
 =?us-ascii?Q?oOFbndNlaMfjDArfnR7emXVsUxAQb8xeRvlsIFX84/WsyqsQMzJnBSo5hUsT?=
 =?us-ascii?Q?t/p694H4I5grXe0GwyaosPB2Zk+T1pbbvA5hdoYe+OViy0uCslvd1C+iGcqS?=
 =?us-ascii?Q?x2truGt33mt31jKPzgAIj8iwspmL8j0UDXQiC3zQogs9QiRrrRlZBog11R7D?=
 =?us-ascii?Q?slp9+HSWBbhUbnpGmoc7ZV0OfjXh9mu5qhUGl+4YgT0dfLlLKzcN6Hdxfz5+?=
 =?us-ascii?Q?apYHNXlpcgAZAMVk2TXPEBHaJUssosoB3+YAOofV60G0RveiGDlMKHTTTPX8?=
 =?us-ascii?Q?zz1owd7voCvnALiA+dn3zFVl7eOds8xGIwYtYDsO6Qx0NvR51wx6i5sBCF7K?=
 =?us-ascii?Q?52XqmXgqZtFgxY8+zAXVGfyNGWam+B/v2DHzZ53leWsPvPeeNkEiXhO44vUo?=
 =?us-ascii?Q?SGgA2Kq8LJaKK7xykiwtKWuWL/dAzcI5u2VeOgg3z/pU0NxmJ4c0o9yKgtjh?=
 =?us-ascii?Q?yFDYKrjezFbgcAnwC25jxsZYvOxzj8AgdCpIUHHR8LHEG8nl/1sTKLIF8ZLi?=
 =?us-ascii?Q?e+fvrHsF3fPCLX0d3GPKBLGR0A/yjY56JnZ/1cKx0T0mw8fPJ5fBApgdLBVP?=
 =?us-ascii?Q?fMm7JOYj4V8WG2O6f1l/92je+vUPEny32nl7A2emsAq3UYawtXBDRViomvsY?=
 =?us-ascii?Q?iOjhmL03ZsyITzwSUn+ZWwii/jwsPMpVHkO5n7kV8DOaPsKXYDYtfESOkZ52?=
 =?us-ascii?Q?ICdJiLBl55KG0u4E44HgFuE90y94fx1kXQIbgSa/jKtXy7Us7U+i3zHp1aFQ?=
 =?us-ascii?Q?SJfZVQB2UgdIUga0DMLEB+CpoorToYKlfA0X1MWRtiYwMxlqS1kmblWHstIY?=
 =?us-ascii?Q?K2a7HZGujcZCoPpRGCX75odSt9yAyi7OgGtTK3SF01rO138d/9sprE/WrD9+?=
 =?us-ascii?Q?ZN2eXRb3px4Vt9oe9HdlsoyXTkTfi82MfZvUYLGEwxIsol3PkQZI4GrqTS88?=
 =?us-ascii?Q?eK6wMmt9oOS7LB5PpCL5XveNYaVdP9Nhw7GMyPgaNIHC5l6CaCICUGMiCNer?=
 =?us-ascii?Q?u8CBgdrKl9kmC25vq+j1T7dkYrfgUeExewVUP3ZDiJy9GbVq++n/M0ZKlFBZ?=
 =?us-ascii?Q?b8/J7K0E4L5o7JP/R0BEbwICUI3Fnt7gr/SjuczQhOOfJii4+wH9QsM79EXw?=
 =?us-ascii?Q?KWtZvyLpBFzdSh2znYAUkq2k6L/+l3vi7lTDwcKpAa8p06ycnBpWk8oEij/n?=
 =?us-ascii?Q?DF/Ju6FjIW417x1MTc/q79YFNQIqrfGnOEICozUY2Jpih3wFkwJaGGcG2QOW?=
 =?us-ascii?Q?EOA1e0ruiHs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vi2+AGZI5ojf9OD8WTjNlE3Fd0Sz1AViTuqgX0ZGJeUFuYdrRzwGEcqwm/tQ?=
 =?us-ascii?Q?KFLzp7bQhay1Z6MpPW+JOgWGyAfhtdguticKfM9j6kOMlO4xwjUHrF7vrQcy?=
 =?us-ascii?Q?Jcr3zk9K+JukF72sQ5FcgBTs3ki56B31q8Ey9gLgzu3SzH3JYEqPMWGtqnH7?=
 =?us-ascii?Q?F1hGwtB2s1LQER3lcsD5NPx6/z/5h+F0SrQplUd9odlVsfyiXOsfjn+p2yDf?=
 =?us-ascii?Q?2C5ligczZCLSoB2oKvl2+jU32VR8nWMzXT0ImNTyOWAurJQzdGLz8afP3VcG?=
 =?us-ascii?Q?/XC8DhNb+iqFY4S8bBVVZOAs6vZbRkYU7knH4+OPJ5aRbyN87yxnKNMalwCU?=
 =?us-ascii?Q?aDYKuaRqV97E+xcDTbUOIzpU3rzePlG1Qsx9AxBjE++CIZy6Cz/SeB3Byl89?=
 =?us-ascii?Q?vcgIx5mBnW+26o5JYXMz9Hjmdfyof+3mtR+gx1BOJyprWPXUUUaRe3pTM5MZ?=
 =?us-ascii?Q?+8g782xdsWTS3BRj21tsE65DKrTXQwCOZ/eKh2NRPjyZOPB2IQ8VUC4UOnJw?=
 =?us-ascii?Q?qmru+cTQGJdw4PK7XF9Z4YIgVqAElEfzRW0OQr53+aa4LzGKQrwR4gegxEV1?=
 =?us-ascii?Q?t34XiLBnM010BEO3ka+S8RqT5K8VaqqLcrKKVyHTpNIPJOvcBjXWdykoKd7I?=
 =?us-ascii?Q?TqkJzv+8UR3wH6NJD+IAjdszm3XU8skPZfKPWmdxpj3DRyOXPyezcAx7H/W+?=
 =?us-ascii?Q?KLhsBe8qiQg558Had8mdSkNd4Yn8ZbRYgEbq4iliPMZvDR1hTruSeigfPY4Q?=
 =?us-ascii?Q?3jm4eYAP4e9IsBEUVOx1AENvajcFy4oyxVyotZZCAFz/viDtzuEC8N+f5soc?=
 =?us-ascii?Q?mJXH5+JJ6yWigJ6qABCTwui+KNVeg+WTlWQmGNxNZzpJo+ZCUeLQDdcy5LoT?=
 =?us-ascii?Q?aijAwiA2ri0SeI0Bh3hJNjeZyYx3DNi5ukyZbxAxREE35H38dtiCslxk/fGd?=
 =?us-ascii?Q?JZXU8NIaqPsbkoXgUK9SKSuHwNEjeYYn94iB5TN/1I+GxpVWBktWP7IUir3t?=
 =?us-ascii?Q?OXTusjCR/YxfCLZG3fFXrROnE4BZaH+Uui6zgBGx/bodZ5zl5d0AeqdR8M7S?=
 =?us-ascii?Q?26Xa6EtVRb7UQkqPM37hx9VuHpngyfFJ4eir9g9NYijW1ReLiubpP/h1M5tR?=
 =?us-ascii?Q?UIBwJ3VtVYMBNXq1pfy3J1m23/ewFhqtJOFvlRX6d+AEPaXtUps++hDw4TGn?=
 =?us-ascii?Q?ZqpKE9LTZmmg3vVO1KXR3UVH5pvyM9oPo4XCOKfb6UsA6X+snLLhXiBKPXY1?=
 =?us-ascii?Q?veLFzS9Jv5OIfH3MzKPyZmaAI2cprAsjLTpDPPnek0g806Mpki/LbpTebOMa?=
 =?us-ascii?Q?Bjd1j6aynmX79dnuFx6/ciUaZHw6rFc9KQ9whKSaZ0o6St1c40SoeIBi1NRa?=
 =?us-ascii?Q?iyehpzyC717H8gaVmHftq+uEsZmqcOOgT94kC7k6LTYu2bk4adcig01t4D1L?=
 =?us-ascii?Q?fMoKC8C4KmOq6NZIcyJ4MxXCqDZu09+E3wJ3iHzT6Q8RlESls/P8PhkUSiPl?=
 =?us-ascii?Q?+LyqK8rSw/skNKsvKlh6DpHkZCjogZvGbXnl6Kf6m9GWwNVrTAUiI0orWuHI?=
 =?us-ascii?Q?+3LNel/+clQh7CeszmDhj6h4XFcmP+EFBSxex4W3UPIic15tt1mbdpbsqFan?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb417b2-8d71-4dee-0804-08dda2b9d55b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:15:19.0874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZvgU9XE4VUNtA5wtvBShkYCW2yr2zO3EzCtb5i/n8dkjqCjZj2IhPq+PtrGHRbMdhzR3xSRzOtWcCKiWAG8oEcSCOCV6I5XDhQ+yNk3Cbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEDAA4523C
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

On Fri, May 30, 2025 at 02:57:06PM +0100, Anatoly Burakov wrote:
> There is an option `RTE_PMD_PACKET_PREFETCH` in `rte_config.h` that is
> always set to 1 by default, and that controls some prefetch behavior in the
> driver. However, there's another prefetch behavior that is controlled by
> `RTE_PMD_USE_PREFETCH`, which is always defined unconditionally (literally
> using `#if 1` construct).
> 
> Replace the check to also use `RTE_PMD_PACKET_PREFETCH` to allow turning it
> off at build time.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
