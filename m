Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11217CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36D6E4025E;
	Tue,  9 Jun 2026 16:53:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0B164400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781016825; x=1812552825;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RFTvZo/2S7nNQWSV0J8u0QXgqESNKr/S+5l7YYA/uUM=;
 b=fU1m8yR60gfFvOIghxFsl+SaUcSDSHK/UZ8+qhyPfQCI/302LW8DxHIy
 9H+DS5Edh4kTNuS2taiz0zm/GuMYuGxJMs314JOoHpRK3AlqsJwEIdoo5
 5C92kp+KgNGUMAT1o4UBJa0bo9aHpfHuOL6cw4LQanNTANeIjoN1chEPb
 kazNa8l3rfWNjNuSS+FcFApI6YqF7rCgbg7TqJBE9uR38gWO37QSA5G4w
 xBy4EjjYOl3MAFpXP0FDry3KaDOgfcLPkWAHZc3v/q471byXCl6/mGngp
 gS+KKzTl6lZSZ4+49KcSY36yy7wC9495Oo4g6X54IZy57iIzK2kMmfWH6 w==;
X-CSE-ConnectionGUID: XAaA5a25SDKp6sJx2qc/XA==
X-CSE-MsgGUID: QV26AW0BTlSP8PvMyrqDtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84347741"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="84347741"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:53:44 -0700
X-CSE-ConnectionGUID: A/tEDG0CQNanoeE1o/jdUA==
X-CSE-MsgGUID: RI4+F/VKTJKMTtGz/nKr9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="243425316"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:53:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:53:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 07:53:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0z84BwufC30c3smS8GPyD9dBz5NwWMw4NMZUcM9DBMnAcE4XJtJr6dOb6bl3gkZmlTavtmSm50NQvGYBOOmNnHzJVduUNUp5RUA8K0pmWEMB8sHa0FQgJR1QW9TUnP9h02cevujZuEkia4YJw4guDHZyXW9h4STljFkzB8xOhPB9MrY68RAVTBraGrQN3oE0oFb2pnC0uOT7Nx0OTdQGdVc4NZDECk0fWrQTyUwF2Ezzr+ZSMoE5Cy41WafeyoVfxvxPJzOfINkm2bCLzRkJOOBKnShZMLzY4V5FC7VSDTSNCoAE0g5uKtQC1KVaPkje5cEQyea6Vr6E0Vn3e16nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0bqlotf8yZfVW89tvTyxAoJOtkLJkf/WH7B5MzeXLg=;
 b=llhsfxKRS5zPsP+LWmkDl5AROOB2aIS6Ia3Yu15rUIGIO3CmBJZhjHv5jmcv55GQgn5BTlSpq6r3bzRECOuHMOnh+aLLf6LsxJTtDQoN1m0f26vNDdOdYXosem7zU8j0ClBDpE1Yl6bEeDvR/jfBS3kYgu1QfaIpMqE9ktOaUHXCtCccGL0wUmRTsTImVerhDb6+3748ANA8GYMpdLMfgu2EpW+hJZGDWG95tc6yBXJMTsu0RYJOuHlI0lPucdlN7WhSa9mtBAMZWedNbUMNJ5tCOqILx/m+FTRTy8l+XBIb00EwtcXcB7z2YVU0o3FdFy9Nt2jzgB4sTSDeSVlYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 14:53:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:53:41 +0000
Date: Tue, 9 Jun 2026 15:53:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] net/iavf: vf reset fixes
Message-ID: <aigo8NEMrRhhWaqX@bricha3-mobl1.ger.corp.intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608145518.1705524-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0fece-9216-4b02-a3f2-08dec636e541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: NnD8po9plk4asINLTfsj+9dC+8IyAjicw1JhR1CdqYO+5EEkXQQPds96YX6sueOdtdZ2hVcg2JvOczidT/kTVyFQxu8tC1DKC3bohe5FvwUfIkyTNEvO0BjdfFPdaWI/SsbrKU6hTwWOBm64y4JPfjQ9sSOgjb+0HDpFNpzlQXZkOVleZHpi4c9TFVF10JHZofnpvIN6vuNbRutM3skW5MIXi5Ho1e5Klqqpn2P8KD62ZF8UWyAWuKdpS7G0mDjZTRb8q7Sy60jK1kltdS5LGidW/xJKFKNF9yWoFS7v0v1Z6SiRgqSVx2uYhosusVYlXkYxdcgZHnhWU0UDma6fhsZ1rQIA0osC9x+k/MmSdL4M7lVQewZNb2iQzx5lueL2lTl9TwDI5DgmTUHa742vn/DND3hgr6D6ElxX0alHIYw6vyvB2eYy60WN9Etqqok/xig1V9WbjQ12MO8TgR+sdrNC94EhBnU2PIctid3RPRrNDrN4Y/SWqGo45e6Q0oI66MhhEJNv4DuKWQJmvoKi5RQNG6mfLO5fG1iOqOLWjeIGMB0LpURo3CC16e0zwUMD/NhuIZs6EZEoDuL1Qji3UC58JHHTl6fJtgXPzYbp5MMMDDmj9KNj81QoReyhpFvZp9c8e8UYxvTT0uCb7ELXz+tmB1eBMLt1BhUw3OD8xITio0Uc6fGdKPCWHozvqe/I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdfBZkM237WIV22BgbAhwSqHcuH5Z+GUGIdG07NkCWTAovTmLu1+XxtP9tnB?=
 =?us-ascii?Q?mroz+6CMgaguBH+6LY3yuz/rO1q7cENbKGC+QAOEoqviiRxP6lBBKutUXRA+?=
 =?us-ascii?Q?zVxgUUPeYdZ0PP7T01ixCdfXUd4O/R0TnNDij5EuHHwdkSpa2vO1o4nruHFP?=
 =?us-ascii?Q?99/QMxTavTY91WPqg+13aTv0MxcsLUNjUfsYd4zOcOHhH04borwl/B31pp8P?=
 =?us-ascii?Q?wtRFBQRiylOcBiIkkGm+3ZVW/SxJoEhdiWqm5PZZS6B7/WKG/l2OLFYSlZk8?=
 =?us-ascii?Q?bc2ElxdqEz9wzsscHZxlkLdZQJXH8cPW+sKtGY3Y7yBeo2xKV7PHv2vIXp4I?=
 =?us-ascii?Q?n1Z07tN7GQsLnIarPps8SgHdfzwsG4tAVucgDWNy5uAwCvvjglIgGX5Tpw6T?=
 =?us-ascii?Q?JVFQPS6UBvCiusaSqdT57Wn+co1N0Fwnz4Gg6sY/Vr7ZHhUxAHek6j0k277N?=
 =?us-ascii?Q?VuRTNSYPwPfs3aX2PiIlCTdIwL0f51Mm9BE7cELxrAiuix4OP2nUFpUejMso?=
 =?us-ascii?Q?/7VYb4d77yRH2r5p7KwJMwo61xng+xMPP1awNZK6kscSB9lmwggAuNiGszCH?=
 =?us-ascii?Q?J30fhKOwwNBfMejHDL1OXhdJpMYSiyE/0eUyHqbru7BLhWobrPHms/7AHvtF?=
 =?us-ascii?Q?HpGvUzIKs7xNhaXTuT4GVHV1hdgBx9YhjPNeOSYDvWt7ZM0dsSXonIWGJiGr?=
 =?us-ascii?Q?8OHOTxcyMdvA0XgqBgg0lqojFaLhYp3Q4WppX/O+6LJc+hFFa8i3vg+pHgUa?=
 =?us-ascii?Q?HvkLakC5qtCuRw0XjGeIfJnx/vI5zgsCI+IkkkNRedUiPu+EdJaqHIQg8bTT?=
 =?us-ascii?Q?G8UfH07cfF0n2dQg7XNWFNcQ04S4Y3V2owjM4BFOeH2PVvbiyPgT2Wm/S8Hb?=
 =?us-ascii?Q?vGTnWM5HiTMFJPtf+QrCqIJNivuIK2uOJtGtks3vzGlAs5B98yE4Th+pUqLd?=
 =?us-ascii?Q?KJqZVzwkHQkAsObMCiarEsEhxo/31ow7MA+ls+8zskJmb7Bneq3XgsOr8Rws?=
 =?us-ascii?Q?hXiUsp4w6sLnoq2s5FnxToh/xZ+zV/Fidu/nUZf+j18zhIZpeyeKVSU4uHYr?=
 =?us-ascii?Q?qBGwiWFzywMpz5sCFfb75oTtMTvUWzXCv2LlMt//OGUGFWz/3YUr74zWXA1n?=
 =?us-ascii?Q?0V22U9hLHiYwT26C36ZZ1l1DBHoOyWbY6YuXxnRxC9jRdr8i9a1Rr+JUM/6a?=
 =?us-ascii?Q?NPLJMv1aGGG35Gz0LNk9HTINGTDD6AJnD7e72/lF5IRqqR9Wcw3c+0tL0IHB?=
 =?us-ascii?Q?A0zV6pXq298HZDgk8ODdCeG/zjnELI2McoqWDvh8WOm7MCnjxxl+AdYrQvwy?=
 =?us-ascii?Q?dVncNPRgBrbzNa0hh4B79ugWTIPTaNVJYp1MkoxH+FH/0hsfl7oLiaTbSwFb?=
 =?us-ascii?Q?9II1LsSYFDe9RcjDw6zs/y/FVuGpdolEwgvrh3/O/gOPpgD+LfNq8z3NaOfQ?=
 =?us-ascii?Q?/V7Vg/4l8JjD8cKGtQBDyJ3gvt3eCKfVt7484lLdOlDKdf6iSKX5f9ECuncI?=
 =?us-ascii?Q?Jiv266goMpbSEfMO2sTcLqdcgEDt13Zb+9VOy9WeeiXFBHtxJhQEvXbEbp6e?=
 =?us-ascii?Q?ugwXAJNRRuG70WJZ5LPEGBmKoQlEB7PIbO5zND/cmBPDNmQD1PNmj5jDHQ5V?=
 =?us-ascii?Q?kGjdJSEPUJJ2rCPypD7wqcQwClggSQNNhljG1TF77oE1FAp8smo5kWkWNPj8?=
 =?us-ascii?Q?o+Q3LOOzBPXEjRpDoIBwXuNA5JhRH7I0p20I/cclDMZKXmgWJBtsbnIDVS1z?=
 =?us-ascii?Q?yCjXMK+qU+Dox18lFv3UMtPtpDu3UXE=3D?=
X-Exchange-RoutingPolicyChecked: BOGoc6RA/tZBUupT5svgCBMKI7y942lciReXcVwcZL97bWtFx43BqY0k9EHLgBhfIMq6GEs2lJ10zeDUt7taxwFOXVfAq1oLdvIdypf1aAByl1Tp9Z3j0shiTFpKSIXYAbtCKV+TcnbKiwQ1YkT2XXmmEr1dnspF9sGTOD9Ng43hhJfmiLYBQdykwshuD7pIF/N7qR+okJHbls0HMamaZunNOJ+yt3V+iEEtGWhDURCPcXxAngA9wrYju1N1DXQxQ0sDn1qxatKiPL5LTXEv10nX10Awi7zu02xIE4MIpDSSbSjwXVgI4nGM1ysdg4qzdBC4+RdYqUNnbiwG+Caukw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0fece-9216-4b02-a3f2-08dec636e541
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:53:41.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxwWnfHfTmRr2NcQ43OIh/PbUO0zXSsrEMsdzaBMI00VQsGfYpv/7V2oqwOzYEf1uQApXSJrevh9CPWk2MH+pQnKtTk+PXIozdXD9vDovjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
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

On Mon, Jun 08, 2026 at 02:55:15PM +0000, Ciara Loftus wrote:
> The patch [1] aimed to address a race condition in the iavf driver
> during a reset and also reduced noisy logging during resets.
> Patch 1 of this series extracts the noisy logging fix into its own
> commit.
> Patch 2 offers an alternative approach to fixing the race condition.
> Patch 3 fixes a pre-existing refcount imbalance in the shared event
> handler thread that became visible while investigating the reset path.
> 
> [1] https://patches.dpdk.org/project/dpdk/patch/20260605123646.1328492-1-chaitanyababux.talluri@intel.com/
> 
> Ciara Loftus (2):
>   net/iavf: wait for PF reset start before reinitializing
>   net/iavf: fix event handler refcount leak on HW reset
> 
> Talluri Chaitanyababu (1):
>   net/iavf: downgrade opcode 0 ARQ log to debug
> 
>  drivers/net/intel/iavf/iavf.h        |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 14 +++++++++++++-
>  drivers/net/intel/iavf/iavf_vchnl.c  | 11 +++++++++--
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
