Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECC3C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 11:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A390402D4;
	Tue, 10 Jun 2025 13:16:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3258E4026D;
 Tue, 10 Jun 2025 13:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749554166; x=1781090166;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ILnbuD9euGFfVbaYZb1ZedXgUu004YXJ0v/+JyK9Sew=;
 b=XWo16q/kVSnrciVfhYm70OyjhqOT0NOyPiE90X2r39HwuYkHKdkoXLfc
 Eb1gWY99W+RN9fuhzLAXJgmEanTD6fsbPoynWQd5uzbsvNCV+KZ9OktpD
 PqO6MP+/povE6kU9vG8VDvBhhqcJUOp2AwdpYX4HjxElB+yia7cWm++Ui
 W8pthmn5mnx7wUXJB5YyuZziX6gLz89xBZmE/UCW+POvgjUNyYfe0Cush
 W+FziBVwfgntkEyMiG+BeSMuOKr6QF8uO/dm3WnzyRHMRK3nmu92mbh2F
 A54PIoryDEWQEVilxur3IPR1xMa8u5UG0YsAR8lpqUemJ8XCiOriWfWk4 A==;
X-CSE-ConnectionGUID: Wnbf40NrTZm7J5qIrHsaUw==
X-CSE-MsgGUID: wwl+k+RPS5epGAo6Ntzx4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62693149"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="62693149"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:16:05 -0700
X-CSE-ConnectionGUID: etPYJqrqRPyPv3C+wrftNw==
X-CSE-MsgGUID: jHKbg0aES02Ukhg7LwNMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="147380289"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 04:16:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 04:16:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 04:16:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.62) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 04:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOYVqmNcihYQ8Gjg3iQ3+3jiS0v5sBQW+VHYmJezd5YBk+qRSCTb3o4cqq7yCkgkXTeNGPkap8SD5MZ4Sw3hBFMM5Y4BkX4DA59iJmJuPl5FT/VyZnVDCwLK2n3Je5LL4D7bNk61szTUJCR6hqP/cwmhgpzp3BQHghehgsLoLepKezR2J0wji/Zi+7MytO4GTlLpfyS1PR/QAd/A2/Apu65O2WJqnI6OoIJIathz4KjonueKaqOoTl4VnvvNQRtLPoIYiRrB/T57spk6omVdAn40Y7Hf8VGTlLfbv4tJ9tmU2jExHFgLZFa9vmy6riJFOtj3Ug1fzGf1eSGSbsrfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCtGlhxm/immCKdX0U7EjDl2ppfA0zas0F9mBdzrFm8=;
 b=GYJuFG7eRm3v9JK8mRHKoZCq7bVcDbUujDEoahpFSwutih+zII4Db/55F0oPIO6FD9EqYic3yJLZ+tF3V8Mj7aD1XTbwi8yKXUWeKCQ7QvZhU68DH/vQmDWHKK2dO+mCf1DOT8hcW7NgdPpqGbOJU4YP85hm9+fhGbUIaU8INezoqzpOVM+Ao2x/QHa7BaU92pPQ8UdQpwYzy7U/m+RPcgxATlNAuINMaQ2mUNUXVNR4TYqnpVMqsGe+Ymf6LM8mXzh+lWyC8wRe13P0et17Y8jjuHDp+bGj2JJU1JzwxQqb3tUC/N+lEBqNSg7vC8khCEzFQ4AKboUfeAJZexyOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.30; Tue, 10 Jun 2025 11:15:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 11:15:56 +0000
Date: Tue, 10 Jun 2025 12:15:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix unexpected data in the xstats info
Message-ID: <aEgT6PLHNpK7P8Jz@bricha3-mobl1.ger.corp.intel.com>
References: <20250520011316.561890-1-kaiwenx.deng@intel.com>
 <20250610054225.988840-1-kaiwenx.deng@intel.com>
 <aEgTHW0dEjJmL62g@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aEgTHW0dEjJmL62g@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d7d237-9374-4f51-26ae-08dda8102bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M1DLVkZuAfS1vp1tjnr22NfMvsf6YtKYa6xDhmW74/0f6wl+KANvJ0qMbbWA?=
 =?us-ascii?Q?t612cldThnJrhq3Chcp2FFR3foCT84fSO/CECKPQJY6yep/HW/h1NZQ0F0XB?=
 =?us-ascii?Q?qnZRShHrWhYCAP1hMJvpwAUaR2UqAV7zLPyfC9g3xVrLn+jeadvKM7IAf1RI?=
 =?us-ascii?Q?I1XB+LH4gaG59LOd91nRKsgn8u4VgdLpD+SceqmBOFHRh1KMgHpw79ckvuc1?=
 =?us-ascii?Q?Cay7/c2fdyP07IyV7YT6tqAmjMe1zaBMwqAJJDZFclxTmjklXAFGdbZkKgwZ?=
 =?us-ascii?Q?Tsp/3Q5ij4QkOPr+Ty5qfrM2tL94Cai46x1rUL6FfU9naAro7NCewD+JP4rW?=
 =?us-ascii?Q?oByMN7Elxc8BXrxg93IwWZXoMVFp0/vqu3XYEPEDpZcPSFp0TrMma/nNBNLt?=
 =?us-ascii?Q?c8Uk9wNJefg34oY45+ZwearCoQD3ePvjV9wmo93T0lp96zNQoe9ZTxjd9BQE?=
 =?us-ascii?Q?v1gb1bJzra5vaWWrPXkhrSZPW1kXlEUdjvlMSTito7bClRL9F4B0rL0pBdCz?=
 =?us-ascii?Q?2ek+uMqZwJhkedObicdiTvSIk8u325MwVXwvqq1UPNkP5AZOmFzfdfu/z/dQ?=
 =?us-ascii?Q?U+M44fZ12Kr3XF0CxvC5Rc7gpwyUsIA3WNgpd11Io2HAjCnKYtIuIDAcsk4W?=
 =?us-ascii?Q?w/Yt/26VWKVrcskvKbFOJgDUliAGSNIcMMmAoOwsmFkJGqNIY02i4Z+G/AyO?=
 =?us-ascii?Q?higXWODlORwtp8pif5v8rJ3pkZr77ixA3mGL+gmcuB7r6i9vZtaANpy5o1eU?=
 =?us-ascii?Q?9ljXZ89Xyfc6vb00jxGwEmV3A+3Lrm6isDACTH7yVqlR1FH00SHRWujP4KCY?=
 =?us-ascii?Q?IrFXAqFJIWKl6Ccs5kHEy4Nf2ttCdZ/oXfSLc2OepBsE43nRMmVuZ6ZKjrZJ?=
 =?us-ascii?Q?DrVX2LfsrZgT2ElqQGt2AHi+ZyPnGY94Y21KkC2JVK3ApYnUMOtlxM/Kjhxl?=
 =?us-ascii?Q?9U4Tnd57E66MXub3oEYosNkBE8OtCEAif5o6JZUJ845hQeLIccxZzHPcaYcB?=
 =?us-ascii?Q?dHD27wRJlRW06Njxw082zKr6Qu7/ljoqtChFNqPJTDd+JB7X1yOl6FYiehLY?=
 =?us-ascii?Q?xdKNJ6jVtRyo7NWqvi6te1rK7pryWobVCYKb4axrbKu/DvT7KevQmCrI5YbJ?=
 =?us-ascii?Q?TmZwk+QGjzJxRnLD2YfCmJgbacmXmi0L07pr7XNGpiDiGjdU1BcIr/4mrKYs?=
 =?us-ascii?Q?1ZHOx0APg1OmBDQom8ZXylL550Lb8dZ2zYlcB3fb5qPRDwRjRLLuSqNBKous?=
 =?us-ascii?Q?GUA6YyFfa47nKikZ2yZaQkuZJZ9i2xka6+lW26d85ORrGsTh5yjzcea4tHzT?=
 =?us-ascii?Q?WTn/CpSWwGA8vbf+NLJVOOke2cs1rl+hzTTkyTF6z6/AXvsDtUqYtYTUr6EZ?=
 =?us-ascii?Q?qM19/aLFWiKQWQ8BzRS7Gp+/f74oxrwvJJKyDqoc+KAE/q4Z4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVzWGOhyHxWHxK0GEIb/UttcmtjMGKICp9ed6df12Kvix6h4lbPzYt+bI8Fr?=
 =?us-ascii?Q?MuvAHv9Gofxr58C+Omw8MtIRHvrDPx1kjm2oRo96ivZyKEfZM44CRNsaXBDw?=
 =?us-ascii?Q?hIlPDL5QhW7rjhY+SVA0bTbn86UxdDatbS1bhY6OQ4R1yls7sFiEr2AIrLHv?=
 =?us-ascii?Q?j1DHQgY+X6CDAthCjaGicY0eJGOEdxxumb56HYMaaTtQ+gwp/oHuEHgQpQio?=
 =?us-ascii?Q?rwYnMC5R4mzvxMWeb/z8qIWLSIYn5LkiTNhAEQhIDMP0JBdPcoccRutxj6n6?=
 =?us-ascii?Q?ZJzWwmDFYfLhxqWMFadTTTofQQ3gPDr+YzqG8G682ZPOc5gCWUvNv50VwNaJ?=
 =?us-ascii?Q?/htSEanqwloeeWvg4LaFHY0ZJvtSawUB0R25IWC/kFWE7Ke6ahs4CwOY6wB8?=
 =?us-ascii?Q?8e8Gcrv8vNK/bXYpMlBqjXrjjl3BHVQ3V1GmK+pbZIaDcQlL/O+T73MOrBVU?=
 =?us-ascii?Q?+8jeAt6SstwC0dRAKq9bmNl7eRTUkfnStYlKK8TPpBLE+mo6VY2g578yd2Xi?=
 =?us-ascii?Q?LwA3soDOl0wTNKwX5uwDb3lF6mp401Op5PYveZdhMg0DcxIACAssOYgoAmot?=
 =?us-ascii?Q?lzY94q2J1qCd4hg0TEsDstArCX5/kwL89btgsP2czUfqndZl4D3DXvwPWSCh?=
 =?us-ascii?Q?X5JKTJ9W16D1pU9qQj9WjwT9JAEb4n3klqWsrsAXgU2gDGDGcmA05DZ5q0PK?=
 =?us-ascii?Q?mh3LveyjDAMUQB114Wxo2tBTqJGIVv+CQyOpWiILwYPCwLSG+lixlO4AsOHJ?=
 =?us-ascii?Q?UkQW+eH1J2hz0lSjOwo9aDMrJhJXv6JBhqz+9tJbZuY2HCVtb1KnPDLZdKl3?=
 =?us-ascii?Q?kS9YYbe5k1MYPwpoLpomz3/6j/VwZgXcYcK+95hIOZsPMgdOBb1iNVQ+mARi?=
 =?us-ascii?Q?xHoZP3dluVBNIUHgZujfDyviKAcGwZc/xqsoytszsvEDmx3aaKPEBHAgjWru?=
 =?us-ascii?Q?aZrKJVVWcn+T34axLK5+BCNRQFjiO6o6dueSblHmgjSkKJBX42y9sMUYcbtb?=
 =?us-ascii?Q?O7HEIzVuis/OpKNHaZM0CzS0xadZl2z0R65zaMxkkDn4DVOW2VGoylAwDdgD?=
 =?us-ascii?Q?1OeaFHpXa4XWhklLmQ/nrVIgbmU/J4I1yuX9VJXw1U9+AaOZCTJYiLJleEgH?=
 =?us-ascii?Q?H12eEstp4Fm/q9ffksDUpW1XlPm5tEvzmcNzq0LX1ft62EKeaQUWkvRnLNS1?=
 =?us-ascii?Q?x5Oto1F5JSBgaL1PORlmiyVITKZGhYAoWIN0Y3M3a/gXCYiikFiO7aDAcE6A?=
 =?us-ascii?Q?4ouBM+CS6n7CLYGgw/pfecLA5uF7op0X727ZrJcRbeSU5jjp9lamrfhdPMpn?=
 =?us-ascii?Q?LLGdmVl2zEMw373/FxfGSIpLM3YdrJF9zhFvhmaA7fQ3SF70bbCOs0vn1h5e?=
 =?us-ascii?Q?15dnRb710QQxuIL2jzQ6aWhgepphs3HZJ4fousAu6i2Vx6eMx1vju0nLsqTJ?=
 =?us-ascii?Q?IqOSLMcHAeqJNIRjKPS1r/azeJ7zYBKuCNleWDxzYFbXgKjrLJf0Up6XOR4d?=
 =?us-ascii?Q?wrGk47DRcoT8/XwY8eo6iYYWWEGwkng4WQMrF4bKPRDypyU8KmeB72r6aIg5?=
 =?us-ascii?Q?iEBVg8iyIB9nXidnLQrEPN6olmwKX4i0xE4mQ+/dwT3/edJNOtzYDuCVYqwY?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d7d237-9374-4f51-26ae-08dda8102bf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:15:56.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ga1RYp4k+JDIqe4HoOij4yiI4/Woc5NEvdIHR5cg5E6+R5XZVi6dVcvmAcx3CX9452/b6fPvAwqS1ERUvYVRUVVp3kWqt3+MUr05TO4Mpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Tue, Jun 10, 2025 at 12:12:29PM +0100, Bruce Richardson wrote:
> On Tue, Jun 10, 2025 at 01:42:25PM +0800, Kaiwen Deng wrote:
> > E610 device does not support MACsec.
> > 
> > This commit will excluding MACsec stats from the xstats info
> > display for E610 device.
> > 
> > Fixes: b35d309710fe ("net/ixgbe: add MACsec offload")
> > Cc: stable@dpdk.org
> > 
> 
> Since E610 wasn't around when the MACsec stats support was added, I think
> a better commit to identify is '316637762a5f ("net/ixgbe/base: enable E610 device")'
> since that is where we should have put in these workarounds originally.
> 
> 
> > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
>
Applied to dpdk-next-net-intel

Thanks,
/Bruce 
