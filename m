Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D9E81A26
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 13:00:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF18740261;
	Tue, 17 Feb 2026 14:00:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AAEBE400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 14:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771333246; x=1802869246;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wMQ3OAreBIgM0PgnQeeRSferlL6jc5oBzUmdm7x4mnM=;
 b=T6yoJZ+C1hWWgem2gF87JSwSKwiX+3IlqQ0LS/pnV9fZZXUQ55fVWQby
 crDwRvSXybkk+KxmSz1525Wz+hjo263bkq+39ZBClGFMxgpCcC+3gjw4y
 Naxww/sN97KKs9d9u/9CyOwr18lzgnDdfTmmj+Dy3FvJf/kwVYWxWM6ZP
 oQoi23YKm1Q4w9l7qbYQ0DlC+aavupx0jzMmhluv+ghEc7IaCOBFHO6gR
 /8zQOD9+lls7cZDJAgYs3gru+3ch/Jm9sv0QRRVAw4FxwUykQ6/FUPG3s
 pcSPg6Z+G2JdLaH9Qz5fGsjRta+3TPLMGQ+DUvrQMnd9GR25DHFg37ka+ w==;
X-CSE-ConnectionGUID: 0QVkLNe1SbOGotoeUZRfRg==
X-CSE-MsgGUID: 3B0BFFK3Q8CiTtmV8LgUew==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72306903"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72306903"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:00:45 -0800
X-CSE-ConnectionGUID: /6j0q2v8RRiMHWu9vFQr7g==
X-CSE-MsgGUID: TWfxcIJfRTSSts+20uxbMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213887878"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 05:00:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:00:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 05:00:44 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 05:00:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8HzfFyCagREdh0Dp+xZYiOS5gUSuQXfKbWJENBQWDHAMYYjKxQNE+pobLhgn8puHCzzR9r8M07O9kjQqCK+1g8SkXr4S0wmz7s+kmZaO0HYiDESQj8aD0ixH0m7sFY5vSj4TnVDT8HL07ydC1VKMf/pEPP3QHoO352sUEDORqT0NKqTyCc4F3u/RwpjWAQIYgiBNuRlzOOxn5B54BcEGLXmfGBKtlfTRrRe4ac4lwcBV23s9Ubxt0tlcKotfhzDOH8u2xx8wmPldYQkwc0Icgke/o6JgBq2Y/5l5VFuvl7XZxsGjW3CjJaIwF8NG3jsfKVqjZEbNofpG9kk4H1vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00bmd9wjYqz06wuHdg4RazCnNMpITGRQp9k140Zyn6M=;
 b=DaT1c4PzFfu6+8mwM8N1d3OTERQMn80eVthbxIkZBUzDO1o900NkVbTxMZdVO3LjAYuyO3UhVYlXYdEJ7eDEPDtwBl4KbTzh0bP7duEpV+hn/u/TS/QYj2mMPmci0MXhCnF55bPJiWf6z2cOxsDJ7wWsNcRMmyK+GRUjJq7EoEn/wF+slxdRsYDIQVrIt4bmszMhr3FLHtdGCJ7qTNad7JQakCzKMdU05bxrVRYEtpSkbHnEJK7hucbVWfHs7DzcTy5MIAoh59BWCSa/QzrYjoroQf2XJCheVfcxCHDC3D11HFzAAwNd1Fn+gmHOev26ygwyHe84nwYoBJr4L1Sryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 13:00:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 13:00:35 +0000
Date: Tue, 17 Feb 2026 13:00:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 16/27] net/iavf: remove remnants of pipeline mode
Message-ID: <aZRmbs6m63PUrJEn@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <d54db10b682851454ef5ec632e415225dae6b993.1770978324.git.anatoly.burakov@intel.com>
 <aZNQ9zSmorlmiSmo@bricha3-mobl1.ger.corp.intel.com>
 <3f6d1116-e3f6-470e-b87b-b2e0731a74c7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f6d1116-e3f6-470e-b87b-b2e0731a74c7@intel.com>
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8c1868-dbe2-4d5e-fc54-08de6e248a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNMYUBwSlNfwOx8UmJGLLIp5W35Qa5Zs+tjfb9vqUNHs5BaX+iI5fitA1uYg?=
 =?us-ascii?Q?x4k2ZnLi9l95hjfEOMTjeQXXlBQmaIN/V0q+axAkJoIx2xKoM/Xi1uh7kwsc?=
 =?us-ascii?Q?8SsXrEmsQbAv7PaybaQJ3Zs2CfnSmpHPyR8xa0LJK8Sz3J7fwWKosSQ2Y3Fq?=
 =?us-ascii?Q?tb40mtlXGP0CWlqI+9xDgx7bOdGq8GgFnnCHA1yWejEzzI87Pg2XC4aksjVg?=
 =?us-ascii?Q?SyWstX1QRxlFJSgWkTXqN+c+9P7bdfI6Cc1ru+puqvvlBB0FibS0MmYocM6A?=
 =?us-ascii?Q?HQkvLgQAz4Dz9xy2DzYfdktlM/I+4Di4Cv5GglfaBlvHWPHB2UGJ11fyl1De?=
 =?us-ascii?Q?CdwMRKE+PbU6o+jf2UMnIzG/9Sln0O6aqkhL2IWdRMbF83xbCI6tDMu5r9jj?=
 =?us-ascii?Q?dpnWnW0OZHU707Ivlsi6EoFiyQ3NUaO3LrBscRQkvTMXQmWWDsOljjcBRcp5?=
 =?us-ascii?Q?9+bjmhIlVMEvPNkZ9lbDyQpwpjEvnmyZMmH/mOTkPjG8bLee3Rn228zUiZvN?=
 =?us-ascii?Q?0iFCywp/GcAqTeFn2XupD2Mglb2LzG/clrH3yo6By74gW8xNzOFE1gtYOc9U?=
 =?us-ascii?Q?pOaOvWu0gKaHHanZ9enj8un9cphmrOoU80ymtAdo2eezoNxeQfdHHW7s0qe3?=
 =?us-ascii?Q?hcU4sNMrvYgMoVo49Zgz6ECJWqtf4weeq4aCClg0HSriCSR0000O70UAc1dD?=
 =?us-ascii?Q?RJ8kFim7V4hwcXTza2zpRFWe+i3nrx20l06TEfH99xywCDdvXIsUT2YcJ7/l?=
 =?us-ascii?Q?cTBNQMm1QKH4ERYMpS9JsLa8xdkOivsJps8/P3XDN4lMNIsFYWKgCxWDCRbG?=
 =?us-ascii?Q?BPJ3jcQbQNnK3emF4ppCVSwxbl97QjFiqWawTsyo2FeZSSf5rqDw3gMSi8yp?=
 =?us-ascii?Q?BHcbN0iBvGOj+Pli0zeIQHI2UHwpjldlajXFtVLn5twnG37ul2qoiKH6LsV/?=
 =?us-ascii?Q?OYkgNl8N6qAUMDvyz4MYx++gdCy8+jSqT7+h1jt0ONKNFt1MOsBNxJkGWW25?=
 =?us-ascii?Q?r13qllNFzD3P5n2CKo1roJ2Yjl2WncLwNe8UeIHG2T02IieeLh7/dpH5AcWG?=
 =?us-ascii?Q?yX+7fU+DVBB3YL7wucbiT/oyETWYeQKMDMLlGceDJ6CZ63+LI4fKQLt5aMSK?=
 =?us-ascii?Q?dt2SDjMeri/6GFLeXXNRi9p7nzXz9y9nVpfCGXt06R2KFGH5JniGI/3lS/NK?=
 =?us-ascii?Q?qT2aNIa1izHPBTg/utxSARKd9W3QhmWp29xF4cA4p9LMraU3EFckGQsBDYdn?=
 =?us-ascii?Q?hRHi0WphGw07S/lumiUJnBKKylyF/+G6CNrs4sIpoOf+t8Jm2U32eY4d8nY7?=
 =?us-ascii?Q?RlPDfcyQQvMbQjjbyRxWHMp/qh8VHMemyiOfzuL+Z8XCpXSEl9aZ8paS2D/N?=
 =?us-ascii?Q?b+jHMTRhVBBabzI5omPGzJuCMGyZoo14dC0B1jJNyf7m3Gjs865kwNELJ4lA?=
 =?us-ascii?Q?BEzL+7X26KnyXu+kiAQQZaH+Qoh9fVHUEOuiE9fLiR2unaODmUedgLCR5Mn9?=
 =?us-ascii?Q?sfrMZn3qv/SIJ2hbIAL13fPFu9d85rVmet8xd1n8WuxYNynsrI9fR+zEIW9d?=
 =?us-ascii?Q?oY4viY0ysFRRmVkjVDc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EO3YWaNW3kNsG3dQwid/Qkac4D8QoRRR7bRLRJrjBE3xNJx0gfHtGXz7AFGM?=
 =?us-ascii?Q?YFuCdOCpof6xWnB2n6lBG//O9xNkIQe1uPj9WMe0Ldyq2R9KLvz5pFqMOR48?=
 =?us-ascii?Q?lWHUh5DNCuqHF42yuzuHJ23ICybBDIGABgZCowBspsTgm9GtiAjJErssRMLI?=
 =?us-ascii?Q?phQ4OioJVfLl2YinOwdNfaNMDbAAmUOG/Zw3TyVScp0rWRbJ/x33CF2UmJMZ?=
 =?us-ascii?Q?R++Veu59comnx+40kZhTR6v6jRkiuk0juzJCYsgU+DOX9T5ZAoTur4Jz8K25?=
 =?us-ascii?Q?s1tYx8Doe+SZV4FyhhEiD2wBejNBp+mJzOWUE4V2KS67WH0fFibVQQtSo8+B?=
 =?us-ascii?Q?QUYCFM8mxrAXDkfNL52AoJLxHPFBByoUilahonYYU/tH/GbiiAfDbHyS1rRC?=
 =?us-ascii?Q?mbon8trzreWr93ed3gTajZCED8BmTO6fT1WupXJ8CTGjmOIs8SXRm5N2He9C?=
 =?us-ascii?Q?0dl9Ng1ZX/nXXZ3YkdoihoWUelFTVv28HPRRBE09Kwejd6CuRm5qb6o3Lm2p?=
 =?us-ascii?Q?5Yw0RKNgZXHycenyzpgLVl++ABGJW7aWdHWfmLz/6LoSViz38sbDuxAefFGG?=
 =?us-ascii?Q?2S9bVYgDpoGSg7s2X6V1KtidJm+q+itdBpDtEub8MkDXEIbfInQsYOqTVrG+?=
 =?us-ascii?Q?v+v+xykJEy/ypcGe66pYRVJJlxbLIaX0sqbiSLzJrxDubVoqYLP8R1DLgJnl?=
 =?us-ascii?Q?0S9s6R4M5masd+YrCmg8Ud/JrEMCrwFTl9G3mhSuekGBbyN9H64/wkewvW2V?=
 =?us-ascii?Q?LyIm5uVPJYeL4RfKhM+lFdpcKtnWIhVxlCcLAZH31uwpX+hOQyazlI1h2A8v?=
 =?us-ascii?Q?Z6IsXMDFkKho3RFGBktVhmaoGrZALHAs3W1SStfyNlUr4Hm/y6rPpYKGRhzt?=
 =?us-ascii?Q?520cB2YpgV1wBizPiYBGnyEc5EY0zk5HWbMufaoqvl8aNP6B0KsUj5jQzyAI?=
 =?us-ascii?Q?KqmbptqXQbIPFWINts3w5yb5J7hrEs9cOp3/1Qke6Tf8ZPCdaIsEvpkWWt0v?=
 =?us-ascii?Q?+gd2SCEePqqEBKF1YwJna2pURD4ihtDcWj7i5e3W0EP0gZuGxCy0JR8AMme1?=
 =?us-ascii?Q?LcOemJhA0js8BvqQ3vISIPV2NrOp9+JzMU1pEA8neDeMMYhf6wEiIGwj44G9?=
 =?us-ascii?Q?unPA3xtKxkUHVgZ0S6lskEpp75TlKCO+hiJOTcnxItoxvfgL6zHfAaxPYe6w?=
 =?us-ascii?Q?SFDBPv13jBNFTW2x6SAox0kMcSj47WUFaV4KBMigQaGoRwMBWDJdXbGPhisC?=
 =?us-ascii?Q?Xf8RUw/td54lDLBzn7XLk4H6Vn3lIMiHzId/FZd3gOhBEfd6pw7k793k7V7V?=
 =?us-ascii?Q?40pcKmvpVopN2EO+/wOFPLXND+9jQGM1uqMWHWDvzHk8LkaP27ifus2TQlZV?=
 =?us-ascii?Q?/FOOUwZrLTO30ys54uN+Z2FOGXV6LO9IUyuObActL+Z1x+EDp/VokXFzXFeh?=
 =?us-ascii?Q?dRUNzsu3i94iKDuusBUC2ZnHz9ie51i6n0a+iVY8OnN3OelfV77aYZ4yWUQq?=
 =?us-ascii?Q?b1zA7abbZxqZT4xz1OcuRR+Y6nhplKz0mOQ0HXlXeM3bl8Xfpa4JDIsg2F+v?=
 =?us-ascii?Q?eMIVTI0Cl0G1RffpZ0bHpU4gJUYwiWnQUYL5cgNF3kmPRCaClnKuRRdETY74?=
 =?us-ascii?Q?cT3MkZAGsdsFwdaO8AyS5BX4MIIokSTZry8NRBRCAwmGFhUMVg5rdaaUSX/V?=
 =?us-ascii?Q?AsaWqre4kjLzyFAeKitbfQkIK+xnFIhWEEG22h274bmKWQ/gzS+VRfxF+9xJ?=
 =?us-ascii?Q?FmwInD10qVpGumRnnTJPhTi3pMuHH7Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8c1868-dbe2-4d5e-fc54-08de6e248a64
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:00:35.7117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHtordjOi8a3FF6VvS52BsxKNA2OLQvk+30su061ia7XWaDnnXYNrV0XNBEafZQ6n+/013v6TVO8BVLkE/d9Gc2rIUAZeAzKqBk2br36/Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
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

On Tue, Feb 17, 2026 at 01:51:54PM +0100, Burakov, Anatoly wrote:
> On 2/16/2026 6:16 PM, Bruce Richardson wrote:
> > On Fri, Feb 13, 2026 at 10:26:27AM +0000, Anatoly Burakov wrote:
> > > When pipeline mode was removed, some of the things used by pipelines were
> > > left in the code. Remove them as they are unused.
> > > 
> > 
> > This needs a fixes tag to point to the removal.
> > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/iavf/iavf_fdir.c         |  1 -
> > >   drivers/net/intel/iavf/iavf_fsub.c         |  1 -
> > >   drivers/net/intel/iavf/iavf_generic_flow.h | 15 ---------------
> > >   drivers/net/intel/iavf/iavf_hash.c         |  1 -
> > >   drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
> > >   5 files changed, 19 deletions(-)
> > > 
> 
> Well it's technically not a *bug* so I'm not sure if having a Fixes: tag is
> worth it here. We're not fixing anything that is broken.
> 
Well, I'd view it as a bug, but agreed that it has no user visible
consequences so no point in Ccing stable and backporting etc. Therefore
omitting a fixes is ok, I suppose.

/Bruce
