Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF21CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E6B140612;
	Fri,  5 Sep 2025 17:12:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 81BD6402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757085174; x=1788621174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=155NsYHiB37021UxPQ//iNQqEBcPmsZKsGo1uobbOgw=;
 b=Ub9M+ioYIZ9qHYcegEguGYpzyPJHdi+eM/k7zPbVxmCh2vtajm2EnfQC
 LAWSm3ZjsfQdFOJHfSowDlmkeSs/fJDU6z1b51G+eAbcW/7doIWye8AZZ
 rkqXgq3LhDA7f27qtlbHyqqRMPQncIKIiaXWaIWvzrBRObudUxipLFMzN
 ck3CviJ/yvtz1fF97TMBl0pJKSxFgmiw2S6dxsI4Y2VKvIjFzCVBVOXyl
 lCFmTS1G0fBmS3UXrX3H8ty9Ucs1imiRFmc+HXoZpXtAEAWcfVeEOK+xU
 Ifdj4L7QkO/3kh3zSNqVHRz3Wm80mLYXNmzRPnPGLitK2C4oOcz0vuXen A==;
X-CSE-ConnectionGUID: 5bWd566lSLi2e+VjnDgB6A==
X-CSE-MsgGUID: kyysUt8nQES+4/PRbWThCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="84874101"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="84874101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:12:53 -0700
X-CSE-ConnectionGUID: hse8dPP1RC+xC3FlJy9kpQ==
X-CSE-MsgGUID: B8o69d+MSF+rk1qWfLdfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171464641"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:12:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:12:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:12:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:12:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwB1gDgSQTYDRnWd8MyG9lSHadTWObhSBCMQqOnj7jicHjiauQq27gp7DkUIZsfIIayHxFb0ShzFPosq2rCPuxsQJLoBUIfYOME5iCKiLfh8W2OuxLrewovP4KW/BpTMQEOE4l6PQCAsruLmsncxY0akRivfUV0tGuAbyOApQFjrPCkw9WPmi+CUivVdgjhY1RWr6nrew3yEbLyEYmLuPn3OT1rRsYOTkzkWYe7/tBdOEtYC9F2EUZRz+Sw8MozEtxALcyuiEoFEapA4w7d7B6AmMuq1EF9AXULaB8dap0daoMpIuz/GMbt37wT9mtWknO/hw20rSRsObARCAglVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVXWeAbsc8K0vN47XbmqscJ/jg0diJyb45zCSS9Iyjk=;
 b=M5YfsO1O1St0LkVAFyexx0qVV9GsMRmqhvWft91UbMsuBUDirlLGTy6IfnmKw1uQSdZBmvMM6VemKICA6GU4tI9aFjkvd0CVeYHl5IF7DPjrFY+QXChnfVkmvLxXNlg+S30EGkv7pKqMVcZEVT/o7V86/d0pEnb7pFtxuIzrcYPCVLuZ0NHye9NVvoIcODRZmJsFaXGXb1SAY0XxR/oTcUmcmWT1BrBRfEcKVt80zO08SYv22TJEox+LmARil3qDkKoRlL7PnZbSQa8ggX0usD/VgdfXP7L1rTasrKfSTF6Gmp3f6oKeTNFFqDm6BruqpaCrx+PjJyljgxgNNNs7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9396.namprd11.prod.outlook.com (2603:10b6:208:56a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:12:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:12:50 +0000
Date: Fri, 5 Sep 2025 16:12:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 06/12] net/ice/base: add 40G speed
Message-ID: <aLr97GXkuoa3Zr_L@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <b5b3a1611701074aa4d14b12e0024f498f5e9432.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5b3a1611701074aa4d14b12e0024f498f5e9432.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:10:72::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e5030d-f894-49dc-d262-08ddec8eadad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0WRvvEaT1fVqvW++mjUtwpPZ6oMf1mNoIyorH1TEdsdnbwKVoU1r3ptzPY/?=
 =?us-ascii?Q?/wvsWJEyTH9HexTH/Xhhka2qKPK5rBp/RD6auHPpWh394EzizdhkknW2eP4z?=
 =?us-ascii?Q?WtltCwqJ7ZLg7A6FlYbZyXgBQ7pEC0GLBz9J4b9HCrDh4tPvKPxD90BQRvnL?=
 =?us-ascii?Q?dGIgLkktJzlZk5Z118fbLteaf0TuuZrNwXUW7ElU5fq5Ks/uCawWPdfH9LgD?=
 =?us-ascii?Q?poZjdWaJEAqYxHIDo3HWOOc1pOFfYBeAyiRIR545kRBpk98vE0HeQfpRSphJ?=
 =?us-ascii?Q?dkGZ7G3IM6duE/2P7YiO/q9rAkRd5MNfb56WNVxJaU1S1YuF4S5GyaLzv5J2?=
 =?us-ascii?Q?hCDV6CDzk2ZWqVT70H3r9qY4H8bldPplgdHji/BkK+InCkd7I6AI0/KDs8Tr?=
 =?us-ascii?Q?U2uv3Vj6kmdMWhif0TzAUp6rx53adsLEZ8IZ9SKOjYbZr7mRmZIR7x0RnJQ9?=
 =?us-ascii?Q?X9JoYrHB68uVhpHDWlUe4T5NC+gGjuE9fhUaQR5tt7X7pV1GCsWWghpgQIwU?=
 =?us-ascii?Q?/I7y+NB36RM3u2/JyE2XkRLwHm0+JoPMk/cDZet3I68mIl7JGSARb5IrisMr?=
 =?us-ascii?Q?aLW4v0qif9HT1o/ohwC27PYwdIPf6ieGka4bLMWhoJqJ1xcu7jQW0dMsl+Wt?=
 =?us-ascii?Q?J6aYsZCKBEOmSKiEDX0vTDaebG4s5Wlbfe1BVgCEuLLFKDnsEH9nSAeHx04r?=
 =?us-ascii?Q?siF1S58PtJc7HaCHUlmkujEY3p0jpPjvOdWwHsIDtcl4Wdd8F0bQ27ld4X9N?=
 =?us-ascii?Q?O/kciYF274HK+MQD69oQVjI0ld6Ix09KBstkzh+Omu+IqR6ylLlnw7Qed7zM?=
 =?us-ascii?Q?jsil8RLDhKhdzmD+eptXs0YmQCT0TNU8ruNDZokbWvNcRC4gOdiMcqpt5csc?=
 =?us-ascii?Q?tvOW7KHK3qHUYQOxjsdVIFBfa3uUOg+lcVlYZHdEND17hT/TFTlA3vXsceSI?=
 =?us-ascii?Q?Afpbg0abXN1DbGK6Bdj5Cu1qTJPX2/9IyE2/UAf2MH48UbGa2WGlv9GUulei?=
 =?us-ascii?Q?tDAgTFrmWEpAaWnB6cYli3AHm7LtrD34UAQeDizHwUB05K3aqfCQUlg8vnDo?=
 =?us-ascii?Q?IxGa8I6ovr74feYly+LGrCwdoRbcX2p+V6YCgi2lF2dH21r5Fw7ZCbqjIzjR?=
 =?us-ascii?Q?sqNI3/o0oScbr2k+xEc71Nf48sH62RW89foNx80yJAu1oaduD+k95I0a4D9d?=
 =?us-ascii?Q?Or3/fgcjK1GBubUEsEVIC6RPYV6nG2e5NjZA/zm0tsair+BvogjT/K8+24zt?=
 =?us-ascii?Q?AQcAY93AovpVDSepWMA5lzugtJOOJgqsgrYfk5TISnVHV5SNnfg1SxFYUtjm?=
 =?us-ascii?Q?uVtfi7AxMT3ypAgmZqjNBMCtl66/NXbh586Wj3d9KhlzH3SvMIq5/XzDmMH+?=
 =?us-ascii?Q?smFi1qwiQIERFeFxdjIPwDmhXsC6fXsO2F+bjsyiie4DCzbbNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rFDQFZRxy8sXHM4t4+m04qrlxjV5+8GiCttVosqMk1D9GExA5UPBPDr8Pgkr?=
 =?us-ascii?Q?kxYoCsNZCAJ8EhD8IMe2h33iw9Jakb7t5PYWndxS2O4d64CWP1VkLIW9Qo+4?=
 =?us-ascii?Q?rOHQAHQxw52yd9gDsg8VL97lvIx1q3a4u9uFRZrydyVo+hHs2I6qoWtyic8d?=
 =?us-ascii?Q?E6aJ6iivLqGpsI5OnbAa4ht8JBYzAAfBPaFeGr+auDzSS7J2my2to4JICZTO?=
 =?us-ascii?Q?6O8WFXexLdWLRUTJnuP++nSZP1kVk4nlV73TuJJGz/GKYAzzvOiAi2HV51ac?=
 =?us-ascii?Q?+lRdPEr8hA6E1M7XwWR6Yuh53QtC2C1P25W43GgCxcY32cs7iZkUzXYrYNnG?=
 =?us-ascii?Q?Tv1zEBK/qdaBMxf+CDwNcfViGadjc8fmA3VE8QisxfxPtWiStOVpXtOuvSb1?=
 =?us-ascii?Q?bggPWMvEo48ho/gtZkp9hv2aJ4FC1KOvNKdEeBzT5enthg/f4C5I4izGYeIw?=
 =?us-ascii?Q?Oy7q2ccNreO3dtTKkjnwcFLpGV/OrcWRAQC4AI3DPSzksoh/K00sDKH9yZuv?=
 =?us-ascii?Q?gOrojIkaD70CPmx96rijuFxnmbg3xQEQQ4elQ12MSko60J+RbvOl819EnneS?=
 =?us-ascii?Q?6RG4NVCqna/z1qXaWi2//j2fNRGzSHAMaG/AEtbEFwZwenUhzuvJSgN0wf3d?=
 =?us-ascii?Q?yONwhlnvJk8qhnyr0gEf/sGhKmplCGzEYDfY6ENB2c94jRMbXkDzZAKtGBFs?=
 =?us-ascii?Q?8pVRuAifu4RH1+nvs0Kw6qTzABq/JvRszNT+ixPcFjaN25E5D5o4t6/tDXQj?=
 =?us-ascii?Q?QBsqLkjwvLAu9QMkCLhgI12HpgfLyFIHgkb+w0Ae7jVwU8Y87E8OjPizFybN?=
 =?us-ascii?Q?tPb/IeT/MAdRM/fnevxtcf034tmh0OUQHhh9PjtY3X52D810rqk0VPVy+DlT?=
 =?us-ascii?Q?7E4duXd+rGcdStptlpogkFhxSr+KK9LOsUbLN3yLlf7fcp3zEXmCc71Q2ZOy?=
 =?us-ascii?Q?i+MGK3pL2kc6tLhZOo2zY7IbhOSHyYw1QBMGEDcabTFVIkqts0RXW9ktqgNU?=
 =?us-ascii?Q?S4IBPf7B70D2txcgZ28GwNYCUsK/DMaepUNdW0pvvNUmYqzFPg4KtqgUOi8e?=
 =?us-ascii?Q?LZqAXwgpTO9efLVhM9ptijrhiMy/FRVcg8jme/wM1nFwreZHNlZ/KvVFcJo8?=
 =?us-ascii?Q?2Qui/+XuXWUL/aRjw9KGGzwMMZ5nV07gTbtju3rzTq+lKPTn4nZX2j/ZO8zB?=
 =?us-ascii?Q?0w2dOVLO99Pm1XcnSVCIvK6vPq1FJcHfRJlnnZpcuFeuXov44pZJZ9zp6qYO?=
 =?us-ascii?Q?SuhCpWrkK0kw15UVND67o7fEkhcglFZak7Ns4fBwEw0dCd8LJ+BhEiqjSTql?=
 =?us-ascii?Q?YjJK5DmTRxsux3KX+mM2xBRgxHwOrQcUwBT1yLEpH/R/YhKCIzeBNsVlgPza?=
 =?us-ascii?Q?Fggu5PE+qLCEkg59RkoMHeCdfr1O1qZvPrtIgESndFp9/zKhhY9q1pLP8E/l?=
 =?us-ascii?Q?85M52eB3qLIRZto7flJ2yQIUmxDHZ8p4LLUDsOY3MH5cY7t2SloXRw2rRLuW?=
 =?us-ascii?Q?w6vVH3sR+Uvd87kyKDAAyllSx2wCe/7E/w3/Kaa52yRDDbZdtusmsiDd21cO?=
 =?us-ascii?Q?nqZqmX+/Ddis6vRg6zbprkCFprAMqmsZTgJxKWmvDNr+jlia29ngQ52pGmbi?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5030d-f894-49dc-d262-08ddec8eadad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:12:50.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9sLlhtiV2DA7ZT8D/IoIesG06UoXIqHXkThXRDzoYGXCG7844fxiMCGA0oB5JBZ0ViRetG9rIM+hY7UyisALuWSob8jO1gbvs8GCMAMySo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9396
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

On Tue, Sep 02, 2025 at 06:26:56PM +0100, Anatoly Burakov wrote:
> From: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
> 
> Added 40G speed for port options
> 
> Signed-off-by: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
