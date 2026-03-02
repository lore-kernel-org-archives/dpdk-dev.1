Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F115E9B365
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:19:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3D3E402B0;
	Mon,  2 Mar 2026 12:19:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 303C84028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772450377; x=1803986377;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XXGao90D90TNDyY2C2/uHWgrBeuQNTLDRezUGoyIX+c=;
 b=D0RKxCMQuVLLdxlg9xZbXLkRBXjaps97p2dwEyi+GK8yDnQcRvYVttYA
 o4e58vx6Q02B59/v/MVqGs07S97SJGXC1kOnQUi4O+Beo2H0sndS7Wg3p
 zpUuucnGNVjtZg2p27lOfplhtHz9dKXVdA6YhxhuoelOTTgzi9U9XADtq
 CE5oLuJhfz9MUsEcFXb8ooQhQ5La9kEUgdtm2T/21/w3yELVddssn+jio
 uOucFc1XYn1/Skrv96NMOkthmPAYYxVYDhrJUTf84zOr1PQQrsM9vdT78
 ZYFPorIM3MrGqobVML5VhXmSs4ZMnmug5VWq1U9OUzfql9GeXg3Mp/gcV w==;
X-CSE-ConnectionGUID: +0IZ4pIGRQaJnZ+wqFq99w==
X-CSE-MsgGUID: 5eW1iXBtSu+rag54G1+imQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73419706"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73419706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:19:35 -0800
X-CSE-ConnectionGUID: xR45paKiRci/gDOgjbV4gg==
X-CSE-MsgGUID: NQQ/Fd/BSoSjJxOBeay5SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="222594788"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:19:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 03:19:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 03:19:34 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 03:19:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTcIBy+0X9s6TTiBljRjkORMDKH5hFBKa2tNdO8Tj8Z/9YW2yXCPxvSlJqshV5mSZNOMTpxRdLUeVZ0FZqBI+PIazmXTmcweeKu1XrJ5naNfvbBeD7YAAujwbjXIv1y5JZ7IlGir1aEHJcceOGKOan0HRJIrDj/WWkN9tiZE5olFrzYzignrW7o3fPTPNG9GKU287BDp4kcgMGJ8gR//PiyXsg96qE5YaC2HT4mUfe2V12eeQcjE03lWp13Bx3BJOv7qWbbhATfhU7kP70VDM2JVSmpaAs7THbI93pTteGFP6BILknLczOqIwk107pqDvnkntlMr6xMMMrCl9KIErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dxDnMEFwOHcOcQaPgMiFPN0Os8qriRtqtNnyn6WVN4=;
 b=YRySsAgKEKwAhnkSrJOw5L1MKnHJhoWEPcMzZuEsK2GwlcnhOZtoCOHJYjbjDE/d/b8kmVNtYpnqcwnmJeGXZr3ujVM5gdNSzPA+mDQkwgjCo6+yaMQj4zdzvelwmcjNHYl7LtqYBWmURJXbbNrX0Q3p4WdNkLpg5k/X5K65rbQhBNBdGX+HcVNJCAlZMPlTwJdh07Qdua6EoyGK9s5WeVZuQV/p233Xr4+FCRybHeQqRqlTwv4TyIOAVfw6ZZfSGlabHItsPq2QpzL4s2v7O6oil953avfV/blfmovSTCsJepM2zg+dGAicPCzz0SIFeVk2ZfoVkKAd8OdH9NgxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 11:19:31 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 11:19:31 +0000
Date: Mon, 2 Mar 2026 11:19:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v8 0/4] Enable PTP feature for MEV
Message-ID: <aaVyPt-RBitCJ9BF@bricha3-mobl1.ger.corp.intel.com>
References: <20260227003314.439267-5-soumyadeep.hore@intel.com>
 <20260301091040.10647-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260301091040.10647-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ2PR11MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: a40c25c0-b584-47b7-b47f-08de784d938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: l83ri7eTqisQzw3K5NLhEr5FgiBUqAWCAjICLOogOjUluqJPDZKyrzZzcjUCJfHn/NpDocmmTl1+k4AAzKckP732s8rokO7+nyIM6r8WMsR9l0HGSPCvk5xTgw6d4BGWhx9djBkB4Bq4N+0rOL2x9H8340oEa5y36zx1v6BBT3xIOewn+yaRd1tZ5aDpgEgJqk5/etKaIGe/jyL/uLfQH4af8FAu+Qox5Gbwm4F9G92dDpyms+gieDoTh4Zer67j7ISRFI0Op5DwNSOYtgNmT5U3kgR6O6uvv+KOpgbFZAe+bK2tyvx33iTtWya160k5fbvV7kpagpHYMezzDXNvew9Wy/Hwz0cHvW78uKJJc7VXfU/OyVGDm9hbhVo7Rnea8lBkUeIumAuRNsHSj7TjcweeG7/MmJ6VERrKKV+VdCww51cqP6vI5wX7Sc/OjT/+ZGp0q8vyKUzAzyiW+4kMA3gywqK5vEhE/OQapp5BVakcbLJS4pV7pQ9zAh1WBdaCtqYJ5fL5+U8aBS42DeqdeTe9RgFNCnHgOKJVi0ozmtQ9sEYlIZoz3nzdNEm0avtOMLrM2W9ieasOL6/rVpaI1W0X7j5AJ+VJQ1v4BvPs4AVu8a03b/Gp8769uroU2qF+GJ+v9HN5fvY94unjL0uXVDbgHc62lfmAowCWtFD+M+PfXW8SJ1y4hbR/6KXLU9PtVGArAc255MYSOVlj/PJBvQcdEJnYq5EZxH0cDFjlq6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LrbMV3xdPBYrkoIZytTdRlssqOVHve4X5klyE88TUHWRwfh6FPzQAIPsiZ6R?=
 =?us-ascii?Q?WAVHNvOXoEY4o4l0vO2XWSq02RDPZm5fzQ1Eg4fNWPywEA/+AK2h4t5exIzn?=
 =?us-ascii?Q?ruKw5lEDHuVW+04TruaSIJzecAq631mSbMi5KNqu94ZmG7X60S9noqg7kzUn?=
 =?us-ascii?Q?9cDMqZm9o5Bx1y03J+MAqrQ34i9XDYF8ndCHzB84V27qqq9Mnwj/fDyC0oB/?=
 =?us-ascii?Q?88XfUltTYgXEdJzIMjRdYXByOZ0jYVtoZRhDHrLVg/Y0cxZROpSd2AnHvJyh?=
 =?us-ascii?Q?YCQA++l/0guwfeyIvuIjSoDDv6wRPAGw+9KRl5SUhUhh2hocTT5oZui11Ckm?=
 =?us-ascii?Q?slIXC1mxgoPugTzJvDvMYWX6UAzsTlJPv8fzj3PNycDEk3Rb9GMPQ+OPcWQt?=
 =?us-ascii?Q?H/GbkVrc/L0fX5RPwxUf2c986pHMOq95TeKc/s0xgWfU+vM4DOJMvgaR+0PC?=
 =?us-ascii?Q?+F5J5gGWB994Qn4+noZdr/s6nhf0Z8ltdYJYgXLLTUvjstQjrSdGH60B4BI0?=
 =?us-ascii?Q?GTC6F5TN+CsSwSPFXJhRNWto0BOs5djTsLmJPkpHjtMDBlkMJalqLcovsXJc?=
 =?us-ascii?Q?PE2+GIgrTdNuubWgbm39V6se2GtxZ4rGHXiMrmKUUFyt2OKeLa+b2RuxuRX+?=
 =?us-ascii?Q?aRdoEsMmsaunzv0uPHV/Z8pis7vq5aJunEzgaI6Whf4Mk166BgJ0edVv6sXg?=
 =?us-ascii?Q?vB+yLYyBWzko237ULLFpOBwxlvJyaAf1g/noH4/1eqLO0lm2JkjpXCsDDOMD?=
 =?us-ascii?Q?iG/CwwestkO7IjDZei3WobjccUMUHc3wbzkj6WmCLEqFRi8RUEmsMxNlr6UG?=
 =?us-ascii?Q?2yDjh27x6NsqQThj/Xv2ETprkAjhpKo79cXjtT4WjIGaARhEjrYRHaBBJxKV?=
 =?us-ascii?Q?zqi1Mpb4m6PKl7nMyNUaZF0SIw/2o9JWKGM/DnyrLws4sbbcuFlogDyFULW1?=
 =?us-ascii?Q?2aVicx4PifKekvpHxXj3GWBwqhSOvKolGGO+C6IxPCf+/juAZSbA63A4iOOD?=
 =?us-ascii?Q?y4r9bPewWmCLq9D13rc9/g3OdaiIxkHI9Kos1L92ugVr841RWtUjq1HBSWUc?=
 =?us-ascii?Q?JTZY25UykoafGIVF5tmztAVLia+5Ca0uy94F4Ao0p8W09G6oLwDwJa70+Efa?=
 =?us-ascii?Q?h8eEJStKpKbXsOWfK9v/9Du3tQKXINhhmQkt/N5R9zBUKxtIxrj4E1JIGZt4?=
 =?us-ascii?Q?VbL1LuTwi0jD5Rd4g2aOAMfe+60+IQSTdE00mgRCFYCxQH4Kcmx9UrsCyRpn?=
 =?us-ascii?Q?GwMmLfwjXL5WwrqsPGpUqgoaChSojLeQABgLbdfVJPIBkXdaLrAUDOASWfsk?=
 =?us-ascii?Q?w9FKzV4gYCpNvCXgmaWmfu3mjmgmWbSCFKB+McZm3kT4nQmXPloxKX2BI8NB?=
 =?us-ascii?Q?xwAUujKRvII7g1kzm/CXlUJSoXchOSNdIq+iBQPK8QHl5JSWOMRtSiKS1waN?=
 =?us-ascii?Q?kn5XL+xdK0xs7dITw7snapXo0pyGT9z3fHaB88fVXI/StYqvQipmotu94S1o?=
 =?us-ascii?Q?deUnC95slsVXEBNVZ0w7/lgocOGU75ZZ4ZgpE9cs1JqUfxWosm1t1CwUs6Ng?=
 =?us-ascii?Q?l/yTr8Idpcf1UO8YS1qu1oO+RhyImeTMRW2vKZBtpBbah7U0dhryJTYAfQO8?=
 =?us-ascii?Q?2pTeaeXuLIv8X9YQOPktCsKanu6/55ElVE+L1tRoxhnp8Z2JYdCXuCffkdeg?=
 =?us-ascii?Q?H2AJhLCRG8RheIVIsQ1ehvjvrWpVkleCLS4/97/Awn91BKIuF7D6j6YZSY/u?=
 =?us-ascii?Q?Yu65c1K4nLk24a7vUVvpzyukn5AJWN8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a40c25c0-b584-47b7-b47f-08de784d938f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:19:31.7811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84bKDuEg0TFKBV9yKlcKiDjWKZ7QdH6j3Jb4+ePFOKlkqbYVDlzZNG+FZ0uhPfgdo3EnC7kkx9E7m0D6s4Tus8ydSAn2xgz80iZiH1Xu19U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
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

On Sun, Mar 01, 2026 at 04:10:36AM -0500, Soumyadeep Hore wrote:
> Enabling basic PTP feature in IDPF PMD using virtchnl messages.
> 
> ---
> v8:
> - Refactored code based on Bruce's commit 025b898
> ---
> v7:
> - Addressed Rajesh's comments
> ---
> v6:
> - Addressed Bruce's comments
> - Addressed AI comments
> ---
> v5:
> - Addressed AI comments
> ---
> v4:
> - Addressed Bruce's comments
> ---
> v3:
> - Fixed checkpatch warnings
> - Addressed Bruce's comments
> ---
> v2:
> - Fixed essential checkpatch warnings
> ---
> 
> 
> Milena Olech (1):
>   net/idpf/base: add a new API for PTP support
> 
> Soumyadeep Hore (3):
>   net/idpf: add PTP virtchnl2 support
>   net/idpf: add timesync support
>   doc/guides: add PTP IDPF documentation
> 
Fixed documentation build issue, and pushed to next-net-intel tree. Also
squashed doc patch (patch 4) into feature code patch (patch 3).

Thanks,
/Bruce
