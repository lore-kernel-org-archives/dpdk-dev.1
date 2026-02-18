Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB2E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E7E940395;
	Wed, 18 Feb 2026 11:05:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2C451402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409136; x=1802945136;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=38bt1YiXH6vNawQQ/EP4nNhEsg6USbbign4ApgmvRII=;
 b=DPoxiqz32mOGlJvfj54dWdeWcjWPxYBWACvzO2Jhyd4R/BbrRFnUIy5S
 z997RD2IwVSL6lll23H9OqV8/NS4nk6QZxvo1yTOTVHRRPgJUCSO1Rt8A
 3eUbFWPly5/JkG7LKNaVnIhmxC6sZV/B5Aph/enYFbJrz83wGpxA0Qovy
 vgjkcS0s4VKe2gXJZPMdX9EO+bKzLYmwdkEEdNUKKlzPMiw1cvslrndio
 rHSONd6H3EBIxeGqGzTiiyOSDE9adYS7YhqZQ8/a7DwpSvfn7AhsxzrJE
 OXksyorAEJRg3k2eia+6gn9pFBDpP30VqoCDeInoTcqSnaV/91+Ol5fDg A==;
X-CSE-ConnectionGUID: S0wvRb7pR22cpEfNw7QRtA==
X-CSE-MsgGUID: VERwQOmFTo6qV62mmRfyTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60051874"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60051874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:05:35 -0800
X-CSE-ConnectionGUID: Dv6RUpFmQmOAhJHq94rKOw==
X-CSE-MsgGUID: k+kZnK05RdaWzCAbbDbAJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214005718"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:05:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:05:35 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:05:35 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:05:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdiqM2a+mnVMVzDt9B8mDHLioQpHZbvyruYBoeddJBBBWF7W6JxmG0aHEZKVjVNAigF+5efrkngVoqvmAvkPd95g2OUTRVuLx8ZWjtKILXUNhzewoHEuX6wCjKVQztHqaC/DkfTvBlPU+Vsh+XzVHCBGzd5SZf3n3DGEmUw4al9Atgaa6+FoiOQkYuhQziG099WxddONgG1IWE7HCWS5lcVM5iKLGRCPv7TokeoFmEloweK/WFcEAz06mxfloaZ++um0qB+vW9yNaQGddyDJcY5MKZHHfXqMOI2fEUoOIuQILM8hHtvcgFSF2wEhtFsDR0Xmp9oJgEMMR5GTUKVuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMwjy56Jj93kcfgw493Op8WxWhoTAOG10ABxHaGwBXA=;
 b=CDRJk5FlM/cPjYCqg4eQFk7Oh7jL6tJ88D6PvD9r8/FlHbBXY3VnQMu70hE2yDQi6KGpM0W81cYHtyf2tI9VZaCSnDBE19u6I9hj9o2xLBALNg84MlJEHi3Mx9ycOM0HNe71Es4FitsJRnzPZbZ67xeE6brHYjCOHr1emMmeY2/UU3mXGDi23igva12mDX/z2jIoSY5eUH7yeKZ1Kgi/1+qAqfzQIyYGrxKv7MD8cU5lo3Uu4KkUDRCFj+Cg5AfwuuxKMq81ljfDogPhgk/BVz+vQup2IHkZ2ORdY3kxyTMHkKewRrL/vN8CWjWNK+ye5IVzEvczIN08bTagLms1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:05:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:05:33 +0000
Date: Wed, 18 Feb 2026 10:05:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 06/10] net/i40e: permit secondary process Tx path
 selection
Message-ID: <aZWO6Gs44xX7ZQsT@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DB3PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:8:1::38)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 95859eac-c5ab-47c6-5852-08de6ed54114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MmxFqqRoCb/zJ5bu9Bkmzqm38r35MxBOZw5wdIpIw/RsH0YvSR9xtixTX5BG?=
 =?us-ascii?Q?UTZdB7bbyt+MMrfPAM9ntchdJ//dknikDGQhXmRxYmuz5BEcSVvd6MbPKWy3?=
 =?us-ascii?Q?8otNpssIOorDhJZY7e5kIL+3gwohlKTKVb98yLR1DLDyclppJCyDPLRx1qhq?=
 =?us-ascii?Q?CwZJGFeDHKhPtA7HmDuQkyruCRde/eEPh8QMxmWqBeMFoOOp9CdJ/SS2SGnN?=
 =?us-ascii?Q?Oav4mtThChM9WB6w59Kwl2hNrRvmLfuZX0H0BuVKekXUyEEkMfJEnVOEAvyi?=
 =?us-ascii?Q?dzheGUiaXn6TtsSQ7/hLmWG6EbKVwj/WGpvF8+7gzcKeEqpaYlbgF58RwqgU?=
 =?us-ascii?Q?F/0w+VlA/VVrGxCld2svIAZ4QMYmaWrEvnQkjXZokk+edZrJKaVaZitE9IQm?=
 =?us-ascii?Q?2Yqp0y+5MYQ2liYBIebRQq0Xj04k1Y/RNMppTG6vCx8uO+or0J9UlAxPXAup?=
 =?us-ascii?Q?RWRij9DrMDAf6Myci7QqRR6I6MYCTpZbbYdhYb/w4ZxkWlCOo8pvwfiU7eRT?=
 =?us-ascii?Q?tYZmOtohZbIyI0m9Vb9ZyBFG6O8TIDzeeSgulyH2si/WHVzEyTYhyjX9hNRG?=
 =?us-ascii?Q?PXcWm37TRBjp/97hOlwKMg1ldRQILobQ3GaL8DPbLc2QbrOOpdVjvlr+lbib?=
 =?us-ascii?Q?RiEKVGSt6UQpGn6hkPG0UurOMrHFUqD6WQnvRpnL6M4gfM0K/24cRTXIQ8P5?=
 =?us-ascii?Q?u+XAPtBxzW2uHp5dOxbAQhEGsPbFGcEi1wI9XidHXAVnFb9my5GiiTvCZ9lh?=
 =?us-ascii?Q?Pox54Ic1TC0vxqFUyEvysdsTbHyM9Oh2bBPKbXTcBed3/P2y2pE9Yhxr4Wsk?=
 =?us-ascii?Q?TH4ZKPwkM+2PdlnwyYia+F77aB20SK5dt0SslM+nN62IepazjQAsabfFj+Rm?=
 =?us-ascii?Q?j10bNSVNkBjUoW/+eyPGyz/1mIdEXw9YcQCIdQS6t8PWdhf887M39qkyJIoj?=
 =?us-ascii?Q?0zNks7TX067Pkyr16GxE1+qCpJPC1ss2yQipA7OnAJCMDdeBcYs3Ym6WCP4e?=
 =?us-ascii?Q?TiazGV+rZExn7Y7vBNfniFOWAKO6ix8zX7V+6lAU30Yt6XT95uAAVZe9KmAu?=
 =?us-ascii?Q?PmK//plW3nljEpLm2H8LSNZA/ZbeCMT/4b4PZBE2iPgmrkfSlXPOoUrPsdka?=
 =?us-ascii?Q?x6PAUszLfZTUhEk3JMqjM++O88yb0fcFWysIsBpUq/1JP0RVM1aQooqFvu3U?=
 =?us-ascii?Q?JoBxM/AhgkEhdh9DgTI9Rj1JKBv+QjY3EvRvPVR4n/hwg9ulKamtZfyMWVUc?=
 =?us-ascii?Q?Ao9eg6fGQWCoRdoCeFJBNvJ/S4X/CkkKIa0yBqbt9/sLNWmdw0JlGJAqrBP1?=
 =?us-ascii?Q?iTA4mboPYZ+0tTvqFMaSS+PVsDAgwHDoX47dkk0YIUPtH+LkonJTiLrFKfcf?=
 =?us-ascii?Q?xlgHhObYmf04cTWwhvZKa9no9nK+pw9hGkPLsgMvUd1V7LpD4i0XMoJG8Oe4?=
 =?us-ascii?Q?pZD5wNkABE0Tjc7tHc4BTv12TNDh9jMSWdTMQ5x3WxFckfpdImxruDOr/p3h?=
 =?us-ascii?Q?MRq7wcD9MYQDPShYW7cDpbXHacJZyb5ij0mj40HA96f9SizDxM7LGBonINp3?=
 =?us-ascii?Q?F6B4qQvKVjwVh/bxWuc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGVB5XVuhWrDrJYPxS1hkUoKxCJRVrgMQLxC5dVHWfm1BmaVNdTP3PKcyyDE?=
 =?us-ascii?Q?AHVOE9KwkHuYG2R8CjaJGQVVuL5MZRSFR6JttV9H++b1qKj3+uKVUtJSkTU7?=
 =?us-ascii?Q?6Cf/uv/ygSbYXkZV0vMnBPEJl83O/m1SxSTZg6sao8IZ8EWx2JuEMnbv0eKM?=
 =?us-ascii?Q?onF2zHbAYhzcT2e2omENh0dp8jZABXTqYfIhMxzjzU6QuXci8ap8posSMib7?=
 =?us-ascii?Q?VxwNV8ujUIxTB2Iq27gdM33crgtQY8Q9FgF+M8scg8TZfpH3PaVDQKB5dXWD?=
 =?us-ascii?Q?bndxV+TKofy5rRWrbanRn2Lj6DjswvE5UrpHmxbkPdJq6Fu8Hu5kF1Kw9RUx?=
 =?us-ascii?Q?Dtee30y4TGSWg2yNf1Pr3mV8KJk6UMovxKV751Z3Cq3QWk9hdybmctQQD+om?=
 =?us-ascii?Q?SPlNSPCEcGQgyjtFRRwxxpxqmq75mtqkBccQvHLtoEM8TtZiMNk38q5Qu9f+?=
 =?us-ascii?Q?BSvAPKqllCvguiDbhEHjN+rzHbJGBKQzAYEna4g4A14DpEGywgAhd/h6Q4mS?=
 =?us-ascii?Q?NJCtJmnAvwYsj9Tvr45IIYEhY7nwRGVl6Ikq/MFBB4I+e8kWVnjPwH0cXXWr?=
 =?us-ascii?Q?3RIKSD+rHm4ewSdFCmmAGOvLvNe6l/U6WOgCCk1Z6u1NZs5b/dMYDkRVLb8H?=
 =?us-ascii?Q?3ktPCXGghrC3EQEzAW4Px1FZMtirX+GJs0ZwLB3yvw6J/6Ig7HZP/Z4UT5oc?=
 =?us-ascii?Q?41a2HkB5nOndZ5EtKubzRKmQ5u12qybAmmzhFu5p1PeAsv3UJWpzow4E005S?=
 =?us-ascii?Q?Xguof6+mO30r+9C3kbCV6r4XOW7wyB+2Fi7qA5O5QSqMO52VDbg9wusaPifB?=
 =?us-ascii?Q?0zX12UZlAUi0YjOXK2UHIaPuQrFhcAoPLusaGZgC3IqcjYsTIkOiakYRNmED?=
 =?us-ascii?Q?s6D36s7l72Yd5bSVKlCSUf09zWks/mCiM0ZKhnZgqj2fZcG7hctcD3II+LXf?=
 =?us-ascii?Q?hvvPI8CP54KOetinEzbifmyH+4ievsiB+PNUp4BDkZIDPcla+GZ+KP/jYNGP?=
 =?us-ascii?Q?wG8X/iU7jMSh5mmPEx5d6NehWie6BDeJbYg4DAgN2r6yUPyFjPcmncaxaAnY?=
 =?us-ascii?Q?ARSPR65TIh+7nEXunRxkzkYWqAuHGpQocUO7+J5YFZ76qhW8A6ygmzJj9by5?=
 =?us-ascii?Q?opEVCL2c/lYfPey1XiGm0PkBR0SNKYIi+eCnmeMZRKwxE7rcCooBJ6haw/92?=
 =?us-ascii?Q?/C1LVcDJoOI7wiA44f1KHd7LR3P/b/KRpOkBZ/SmZxbTIibuWa2x+f4CULfw?=
 =?us-ascii?Q?fDadHgeJdjcr6Bu/uTyGnV3fK8PR5V++NsiUvRXECEYabtNvf7X8qWBgIcgw?=
 =?us-ascii?Q?ooL4YElyjTKKA+D+OXI56PgAiQUTo9gmpSpFy9rC1RRGQv0HOms7uyHGFCre?=
 =?us-ascii?Q?i3w9OCS//KHOV9Iv2yiiGwRapZjJBClDNtQgPMElr6rHHwMLZnmfLAxQr5vH?=
 =?us-ascii?Q?zohRtD7nf09MV1yYfPufJZmZD1tjRDi5cnUqKzcBfgtn3Bd7ATtWj+Z+zIaE?=
 =?us-ascii?Q?nQQah52+82KlQ93f/M6FLyAy49HwTMLnw4osQJEMUyoiM3ngobgKzXikyy7y?=
 =?us-ascii?Q?ogg45/s1xVX54IoyIxljaYDSeaEK9VItjKbsSyK/bGIjjO16vNODxJfLbaTH?=
 =?us-ascii?Q?9VDb1EVRH52jguVCsVgcqccw+2pmlvgIciW96vXyvoQnvL8Og+T9JLCs0+AQ?=
 =?us-ascii?Q?RePEiYxjxWiWukJ+TF4q7NjHUW4te4sq3EphclLuBL6E3MZySsCjmPwc8B31?=
 =?us-ascii?Q?pbwpaa1Uk1YH66EoV5xcL8eXbH96aAU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95859eac-c5ab-47c6-5852-08de6ed54114
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:05:33.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWlVQ6sqEMRwehiDPiyv+rmkSw/bg47HkqeBVialeyNR/Aj8Od+3iLRrf5FBfiqCoIkqYVAg14k4h0r1WxwUmw5fEKSA6OwYg4p9bKuquYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:33AM +0000, Ciara Loftus wrote:
> Commit 8d57c1788806 ("net/i40e: use common Tx path selection
> infrastructure") changed the way that secondary processes selected their
> Tx burst function. Instead of letting secondary processes select their
> own function, they now used the function selected by the primary
> process. However, the primary process only selects the function at
> device start, so if the primary process hadn't started the device by the
> time the secondary process was selecting its Tx burst function, the
> secondary process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
