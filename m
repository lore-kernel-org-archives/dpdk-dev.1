Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28126CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 07:40:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6FB40656;
	Mon, 22 Sep 2025 09:40:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 63A964060A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 09:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758526840; x=1790062840;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KrN+plcXnaeJLJ9/knjyq4SXU/+STozy5bm5TjXsoFw=;
 b=gOH805u3MRzr4rW6aaH8dXu3toFQ8P7JgE8aS2/SWRBq7YrznjYqX/IF
 fLpQPgtMZhKBEI2PLX9staIcQGCY50JeA0bw/4qHo+VISynGVgo26NbNx
 PM+Q1ATL8mkUzfULhQbkwmT7ojFx1RrgKTBYO4/M5d9LJ2qPRW7DAii4w
 61N8QzBxaNzuP8alzYfgxh6McbTBoYF4Y/QfNCRjzp6sXRWEF15EY6dSG
 +pTjMsiT81ydnIEyfQTfB4N4fxTFNRvnDNPxJFizmv7j8Ri1pBriZeLaR
 vTezqAqmneE2ED1YAlyoW1gfZ1Z+Ltmfjz6ZUdyDNsLdr3GptVjABYTkq A==;
X-CSE-ConnectionGUID: 6ACHc9cjSI6teJpu9CzICw==
X-CSE-MsgGUID: OmASW65hRyW7xVVySXInrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="72148361"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="72148361"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 00:40:39 -0700
X-CSE-ConnectionGUID: NKehEUPnTx6L1Nw+z2SbDw==
X-CSE-MsgGUID: JIpjsyhZSt+VES2R9fpClw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="176848924"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 00:40:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 00:40:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 00:40:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 00:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5Gze+IdeqM1V3AMeKfePiRcTCOVffHVLDNk5pHLZA25/qwepF0IxvJGcf0UxY+y0nHHzulddZ9ScIdyS534fXK1EjdwN+W7pPT23kERbduR7NFb4vJZJZkoXT+QOgpwF87qUIYyOHy3YeTTI4GsoDyM1oWOHZ3xdM0xubBPW2Cvjjmg2UW+XsC5G8TuojwUYx+f/SswxB0iIGDsCtBqet5L2auFn09YtAeohPmZfBxOFXnLk+HTB2X+aqSkRjEi04b9cJ7sBFleb0wYS87wj/ricSfTec/hBpjLbEKaq+xxuc9r4feAk1+PMYcuovbCzzLUtOwLLBzCvaT4hBdEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGfecDt/iFxq08oa21msy5QlqpeBF4GKjgPFlO/7vFc=;
 b=qsNkM4oHWFfwoi1zZbg45etpfKfBN034hLe0pU+ZcYnnPDm3ssX9ngyguPWRP0FomnsycyI9TVv6SjDSZAHv/m1Jlo6I6pcdtkPeLsNB1l5LdCAdv9QxjLHu6Yg3Vx8X/+Qb1FbIuhHOIr0psUWyDXMdW/oYnF6/Lbfw5s8TYxslDYDVvBKwzZR38DiL9BgRah6GMaz7V57BDUmgDzDCMjGIQB7A89Z0fhX1r1KPgy11wWuV5oornsQ2pxduZy9OHuregW/WV3NXZ71HGCJC9VMbrMrZI2Ob85Fwwn7zwbGjpQupjhvWMtwygSW9+VCVTr5bAupg9/fzx6Uq218ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Mon, 22 Sep
 2025 07:40:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:40:36 +0000
Date: Mon, 22 Sep 2025 08:40:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>, "Sameh
 Gobriel" <sameh.gobriel@intel.com>
Subject: Re: [PATCH] eal/x86: remove useless include from spinlock header
Message-ID: <aND9b4QpcXHAaC2o@bricha3-mobl1.ger.corp.intel.com>
References: <20250919190226.1840008-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919190226.1840008-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa19f2a-6025-4da1-1eb8-08ddf9ab51aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k45pXIoMsJFzJGVyNawDhH/3Ae2V1fPvOiYUpp1mhayQS290dVu6IqlX14cF?=
 =?us-ascii?Q?fjRZJ/osdWdVbM5Czg93Ty4RILw8N6D0LreltdoZt8LzNto8XNglyjFZLfWD?=
 =?us-ascii?Q?kBHq3SXFoHApvhsJc2+LQsrdNQrjohdtnJxV0GP/aeYEyoGR+mSDvCt3tg9U?=
 =?us-ascii?Q?0dKO06SK7/zKt4Ud/tTUwXJRp3B2OegSeV4LUMMPFidH2+pezEniAPQxqXW4?=
 =?us-ascii?Q?STMnJHl9CYs2oKj684+/xDryy2AwOv2cfJNFmeRc/+1L23KvTNNrTPJBW8Ws?=
 =?us-ascii?Q?moxaa2QaFQdlHRRQSU7p9eZBYMXZes2vbgLNgYBQdHIsORq5WaZYrZZaQdn4?=
 =?us-ascii?Q?gR/sEpde3KstQMr1VjXJNUy9iCEG1dlLJE1Wov9BN5aKqQCxqvgNJg5LzfPl?=
 =?us-ascii?Q?hL+OemJkS5OnfkI652GDwtIHVDkzIF9Rz/zNXxKdJrEbV+32fSTVSQdCKHQo?=
 =?us-ascii?Q?gA8sStBdKz9Y6zmXOLpcDKGq17YGpZXJYbEqf8J6TqmMNWR+ERKj/Mecrzmg?=
 =?us-ascii?Q?KrEBYqbuQpG88jQPnx7je667bmQ9/KNE3e699VGrVslGEINaaniKebmWqbco?=
 =?us-ascii?Q?c4IuwTz5/0rwqI/Q+rghnW0mia6miXVua5uk39+h3+sYahL6IVSsB9GmPVLl?=
 =?us-ascii?Q?v8cgm+mfqPaDGCDvTQQzVAQ1sQ3sFtIiZY6ggHcuwCVhVWnq4fZcFB+5y+w/?=
 =?us-ascii?Q?bUJF2D+jaO2stnmfyPHBgBA/r9X+aYHDm+QZX7fj9QfbBSIjdaGfIrsguwjk?=
 =?us-ascii?Q?cDiR7bOMIegEGCL1vYBB0tgj+izS+07/8uwlhzgVhA02egUtL9coXqhZx6W1?=
 =?us-ascii?Q?OafbRGdYHZwYTVxLZ4iiwAEOAIkhWBgIn0pR7ApyNX7c7K6SdGbJW7FhXHUR?=
 =?us-ascii?Q?5F/wwS7mNHlkvBedo5+bUcev/J90t9fYyinLqxprsLUqKQV/Y1f9TtDYEdAz?=
 =?us-ascii?Q?ZuzSnI6xWTORNE+9W61rchT8cXt14t7Pn9wihElG0MKie9iEtrc8XKVKCGne?=
 =?us-ascii?Q?syOERVrRvXjxveqGpxdDfKjxJtVn9N/SGtTSPSQnjCIKRootzi6Be1vnkXHG?=
 =?us-ascii?Q?ygn86L1FzYqFcUziYnLW0ySluQpILyF5vF0hHwmIEg9kTqIJMO2pQr+nZ1ZM?=
 =?us-ascii?Q?kBzhgySJD4/H1c3Mm6AjNo+A8+dNn6gaBb/iVvRKYZazFKXEiNVTaxQD3NsV?=
 =?us-ascii?Q?/m04RT0VYl1hSWePLk0LOuLfJSkW5pHQpBGWWarpbhKkPnBs7TlirYJGgsmb?=
 =?us-ascii?Q?US3jQgWR8l6+OReQYQuth8b49H4yi+FUy3vtiqrCywHwtDcU2SV/EKW4aNBJ?=
 =?us-ascii?Q?PRVJmihm0HAEz2MOPNX6tcIRCH5rCGSIovj4mpFg5sj6wB61fQQekgPB81o4?=
 =?us-ascii?Q?TJ3mKsOb1oJqtCa3MyBvM1IA7fByPZ2jnYfkC25VTxEGq6APWFF9MzZn/kVt?=
 =?us-ascii?Q?IHmtKPoP0TY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/0RWG2vCH5tJwdBbf4Of6yifvAHYvEBl9u5UYIRwq+HS2DvH6cKsR9RRgJ2?=
 =?us-ascii?Q?P8gsPo/o92ohoA1QMevuG/+WiWUd0IvcS8/zd00fMhvFdYkOdwBNGqhB7HBX?=
 =?us-ascii?Q?8ilrGsaflxxcNYj9FJgwitGeEp9u+jGnIXytbqP9uEwnO9VAtynJKhHTQzbi?=
 =?us-ascii?Q?fA07nHSoGJt/QZEcu9/eHoJXwpKeDbj2WaG4IVrhbnIQat+inmb06iEtnpzV?=
 =?us-ascii?Q?/ibKcA7iMTXm/Ls7LLiCEfAZovzPtKzkLWpjVj0CUQFFTyRDvMmbf+sZCYAB?=
 =?us-ascii?Q?x362CkGhDan2ZvDFCQ2b7r8fVQWTdsPULiEptVSahicKmJUbMfv6+1QRzuBX?=
 =?us-ascii?Q?9UZxJ2zWW0H1rPjPjWLQe5rarKc0TimWrZMlWCPSbHGUiYWZcribb9RMzJzs?=
 =?us-ascii?Q?KWqE5sn/KNrt3TZc/1A9A0wR9tjlqz/+t4+3t5jZ0bzzLaGaEVVsIv2O3GHA?=
 =?us-ascii?Q?lUnf0+nsXmZ2BHk/PSXNgvHa+iJJDONCSA/ECNNrVbTYTpdPPaQ3voqM2dEe?=
 =?us-ascii?Q?i58UDedEpPkh1MTOBh4XobJ6qq1kykry5VUHXsr8Z7bIViIZef4U7r1ngDvU?=
 =?us-ascii?Q?JWzdAhAnbbSrDYAWgvKcLOk5mV+ghE73Uu/cx86Re82Xmizp1VnV6hP9Zf8v?=
 =?us-ascii?Q?Vdo30uw50dIMhgIzchHhdDwid2pZRZ50w66FOfF9H5e+nd+YS0XW7N1iTG+q?=
 =?us-ascii?Q?M5DIYlVrluG9S+++saqx7zHWGXe5pjd+utMBgU+W2eJ+bFChD5XmGXd/bOeg?=
 =?us-ascii?Q?TA64TWfNzfuG7IIERX62YsgM8BcAwZu7aCVvMcDweSNYwwR9keC6x+IfrvOz?=
 =?us-ascii?Q?1u0NfoBj9nTfyeoNuUOT8cirNICslAnLFX5z6Q/f7F1VpYILEM9LG3ZrliCH?=
 =?us-ascii?Q?1GHJR0nfj8+Kr7gS0RuAo9l4qPprIFuCjvMGBIkM8nmydeVOBRZnnAXQr1Ny?=
 =?us-ascii?Q?oHNZmU/eW5AR+7oWt4k8AbuqoaXFASGFJZ2BGVR7dDhb1ub2qYZ+kvEsqo2W?=
 =?us-ascii?Q?oSVryEQ7ZL9NiblbBkUdUTybr5tmM1J9s+l0cGB5z8LZpHrMQwwYDjjXVRet?=
 =?us-ascii?Q?9BKcpn3OviS78TzcVaDIF1pB9bo+fLWuOVR6IwG06eg6DVofCUxiH2DWKW7N?=
 =?us-ascii?Q?vNO6+VXz2j1iW6+jXEGlgraP9iNqhJxjXOU+zaqM7ioQuqYmkKib0edhGBKm?=
 =?us-ascii?Q?67Kx561kfr8iN3ChSMligfj6jT23OzSf6rcPBOtqp90CKfVvK5J1FCBM29ed?=
 =?us-ascii?Q?/0o3CJ6UOFGARKRygC+jL9R26MT4+TdgZ2WTsGO4eNlX5aBWMwm23/a4XGct?=
 =?us-ascii?Q?2CcCBecVba2Sf8QGvHcADGNqxDcA/1Bn4qsnzw/uxts2bLFdhuddxJLRLvAe?=
 =?us-ascii?Q?kNHSd/8Aocn6Ddprn6JfvMZoUngUgFXsEd+fBP7PRHG6wB1rAe1RaqQPiT4a?=
 =?us-ascii?Q?Lf23cLjrK3HeRXEuTl9XuD/HVBFN5/lWqNwbwtxe0Up6sMy3S/FnRr8IWVqP?=
 =?us-ascii?Q?h2Z2jLCcKCkthHAbc0sI0o16H5xQCjggHwpGLpvIPuYcJvL6PFftu0fye/6n?=
 =?us-ascii?Q?FagaNCo6bd+19W9k9kvifqtXtc5GDRsMpY0k/6YwOhWslKKsM4ok2tmH7TL/?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa19f2a-6025-4da1-1eb8-08ddf9ab51aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:40:36.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMVbra/yVvSYBd4o4hvWzFo2x4T+/3wqqIt3sZOck5TB1E0OwSCTCzkEmVAfCmivRp04suTpdp1Igzx8r2NjR3YtHaOOEWLQBLjawZhVXn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
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

On Fri, Sep 19, 2025 at 09:02:26PM +0200, Thomas Monjalon wrote:
> rte_cpuflags.h is not used in rte_spinlock.h,
> so it is removed, and added back in .c files where needed.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
