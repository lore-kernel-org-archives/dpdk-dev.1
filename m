Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1FFC9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 884A240A6E;
	Mon, 28 Sep 2026 15:44:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 41494402A4;
 Mon, 28 Sep 2026 15:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790603092; x=1822139092;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UKvvwitvpmSE/I+Sym3kBq4TXHrypTNZpOyVv8EhlnM=;
 b=Ag16DRggDXwCPFXfXk3xy9POjB4F4ClWbknhoY+mCcqSmBELKo6dT6+Z
 BLTGt+tC5mrR21WfcCv+hqxN/y4Hl4rWuSQ4hBIeTx5AmHMvYm6W9Pq4X
 JQQELkRyLMM03XTSyTxO4LUl5v+z1eUr1o3fMqB4HuTffY5/qcNCUqGG9
 0ICbpTRhT50RBEwODmfTtwMA8YOaSyBc7k/V3Qwc8/0ZkFQao3lTUrrEZ
 DjIwuNQrgqC6Ic6N89i+2kH7LNYBEG3y/PfMKq/DVLvtQ8EBd0wAEqt5t
 HTPRs+meGUPwBpJCpQ2c4PXW3RH4V1IzMmUT6Q1O23I67g9CUxFQHtq1G Q==;
X-CSE-ConnectionGUID: ntXOWsLISpKNvPBNB/g2dA==
X-CSE-MsgGUID: J3vn2RoxR6qrKvMiyacQkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90429831"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90429831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:44:49 -0700
X-CSE-ConnectionGUID: K6RFyjG7S2+y0Lw/KoVvOg==
X-CSE-MsgGUID: HXFiErCUTOuZD9gmOdr8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="312976899"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:44:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 06:44:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 06:44:48 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 06:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p76gX4vmwWpSEF3nlGjT8wzSCVQu1eRNSbFBm0X3l1B5QFX2dM2zBk4qPZET7EYheyu46tqjELLozY7NO8Osbo/ZX8jU5bOOhF7emSRj1ExT4qDi8SMUXS/XO/fpeQ5FC6q+SNhUzyA8QYVW7N1OzZq3pgmhWDlQHUPMpbLG3A98xWvI9iIG5xgI9X9w6hFokqx4b9TrItCJPWARS6aYjdbfaGHG4/vL5wIJ3qs3AOLJlwgQqKNs6P/grYnVBd0+J219Hoh3ZgYYMXzMU3Mc8Ox99TmNaAdZu9DPcsNu9KvT6OgfQn/W8k0Ayxgm1+Af0uygm/5BGh5ORDFVZdQIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHdDfsFun5HeHnPXdNS6Mn4x6p+1PsIvx8yx3SSwYKw=;
 b=KZPmwimRtVfWQqZXRjVLMPiF6OsI02kO3rJSAWvczzbWSIITpCf0xIFeO+yo6LC1remZHbQzwc0pe0PHK+R8sOKyUyDeGIlUSZW5jf8fn4UULbUNJ0oUY3lacbKvytMBlAIKhSCs7kSG5UA0S4FUTQvBRGA8wBm15TcT7qg3XhlRq2Bi09UvXSUPwqkRsqR5oFOrlrFsUrV2ibNfCr3s0xwRJiQaRQc0n7VTBu3e3TJMSxe5bUcb9N2TlC3vmhXioUOwC7UK63/ctJw5WxmGyx1t6lSq3OimK7YBQoIOaQ7tGSirfFRBPhhB4r8I8IjV8N5o+s7/qAlfigv9J0mHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:44:46 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 13:44:46 +0000
Date: Mon, 28 Sep 2026 14:44:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ixgbe: fix null dereference on EEPROM write for
 E610
Message-ID: <arpvScl2Kh_nt2cj@bricha3-mobl1.ger.corp.intel.com>
References: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
 <20260928201253.45484-1-sandeep.penigalapati@intel.com>
 <arpoI5ltCdcblnwI@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arpoI5ltCdcblnwI@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0288.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: d342ba70-967c-40c2-3d3d-08df1d66a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: boASLPQlFGePDXvtPOwmsWoo8m1EfERxFBJHWu0VA/X2ewlb8szVqd6iNzBStx0Z7PMBxpg9SIAlWvz2/HqORIF3O8OQh4pqtjZLYs8uotE8ubeT5QKPJvtIVYROF5c20coewZaM3qIuVIQcgi4b2u4GuBXJi5kWt+jkIW0AlMSnbFosWezpwg33jQYJ/B1IycPuMiHItNII4Q9MeMN5aAA4oFxclMNbqwuCBUFUFqRml4//5Z2BnXnmSCg9DbGfJBigBO8TE+Iru8YNIb33xwq/ZHm8JKWE9MgwRkZudCX2oMpuiITPKIABjJfKZuKOw8rM6NLwj/7H3QKgtMDI3/do2bZAlvtHgxPtk72Bd+196nUaaQG0Wu+zejDIO7vf4APn/IFEVR/zFcYLJPJePc+SOZStAsy0V7bSadGuCuUQvI5cTyXfcMRnE8g1cK4U1kSIlXSXVCCmavY+adWfMHLTl3ApfHZ7ikrnDr3xElWjps5kF+hosCWdc0slJFYsIt4z+7loPzjMfMR48JFIs+E3jkOx7tzA8Xkia7dt3ddw+yS7/Ysm5GihhspMEnMl54fmKnGhky/07zh0lVGx1+f4zEF200EYihEHPdIW/MTAfBkhpb/UeT65JmuwGmWHd8FFKMliina1o+gp4ZsnErfqjPI9oppr/r3l46iWwXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH2oSISqIjgqRBeQQ444QI7aneMEW/EVmKCS5BPNi1ZBffUeSJpj9dITMWWZ?=
 =?us-ascii?Q?ozFaS/KqpRqsY1ygZAu0XtXSaRy9DpHvLO+dFzd9jaSBrcrnMJ0DP22bv9EE?=
 =?us-ascii?Q?XdA4Maf/RNtxqp8efzBJijxbhHAo1cxJtPL8GZX6kfgSY0a0zca20V7f7l5V?=
 =?us-ascii?Q?1dZNQcX/tilfhtcOFZY/Wjach1mi885u9je+WZEt/2Q50YIDZFo1zFgpswKv?=
 =?us-ascii?Q?+X9LvCcy49kp23TOlk4OrGIm/++ElTTIC1cJ2FAy2YplQ0XBzuLglkzqVkLK?=
 =?us-ascii?Q?IfoavClYKDfK1ZznZlUxNUtqhiqXXj4zW15itbGZqKKOKpwQ8jE+dX1RBl1C?=
 =?us-ascii?Q?vY/wWw84agFZnKmz3fcnhPRGeipXd5qqwETb9VvADZRfhW6jEaHa1RGBHLlM?=
 =?us-ascii?Q?9McwBnVbCUHRQzHn23cC+b99pzwgBv7y6D4yT3EtOMt2GYqsgGuPOGxouhqn?=
 =?us-ascii?Q?Z9rgIelgr74n0wOQajZXuSlFcvaLCjOA44fK5CA+liLZkFnYdgjo2ZqN5YQ/?=
 =?us-ascii?Q?WNOwJm2+uhtHkPm0yqdLCnbmsaeGOxhlzNOAULnxGzdsvpsCziQz+OPx/F8Q?=
 =?us-ascii?Q?Lb9q0jTXKVMZRTXdV5l8QwRy1sUY9zZIdjUxb0SLCCFJpBNW7Dn3Uyjyr0D6?=
 =?us-ascii?Q?7rSUEuk0Q0GWZAkQZwK0I92za+HIWZQver1uLpxRuUPHHuh2GzraBtm6j4YF?=
 =?us-ascii?Q?fiLA9d9nHAvv04F5+/yn9c2/0lw60iRDgbmgqTvHX3GamGx9Dkxs+bCAs2rr?=
 =?us-ascii?Q?qSqCSMwFwe5cd0MxsBubdn/bGNazpzGEWGWMDqg12jsWfEomHdIMPZKG/j0L?=
 =?us-ascii?Q?u0Ed4vT7oP3GVNRVNLYKMAwRUtRgk7QVziLLct1Snev7Hv1HzYgOnUzFl8Rc?=
 =?us-ascii?Q?RjvG3JD8tf89DDN/l4pc/jiL9Ih3HF08vx/YAKkj7QAm8b9PhzRdVcalc6ci?=
 =?us-ascii?Q?r5tDNVjgcOUpbM/OnVxbAISD/1aeUfIRSf4tFbBu/yaksnAvmCQQPUWKWqZM?=
 =?us-ascii?Q?4gZM1cfP8zR8tiEeF3LQ5qLt1Uh5SrDboHGjQI4hVFUaVcx7vlBjS8YmIDdy?=
 =?us-ascii?Q?T3HOu0qmyD5QfI7RiF99bQDmlfuAVPwqBMzwXIRsiCaxSxN5QrGRbYGgZYu/?=
 =?us-ascii?Q?uYz0Xw6f0gH2fVVoTnwNUBrQu0hHisPx54aX5Pw7P3nJj5HuKmzTO2brULGx?=
 =?us-ascii?Q?vL5ycaE0Q3VVwbKfArfqkpYS1wFr6sC4UB9JhdTl3r2Z9NpB8bCD/iDnEMNT?=
 =?us-ascii?Q?N65fnqHC4OgFxpcLxzRquUTrdM4Seks6IvCFYSIeq52ciboOLkMeZlmKJw3c?=
 =?us-ascii?Q?0Ja46CmHdstrSGTVcafoeB6zH/E+JZ86S7v/udK76IZ3wIPlOIOp6c5fU+YU?=
 =?us-ascii?Q?m4gWdeMHYvg0xvmJaNO/S//PuWtsJfE3/1ZiqdSALUctvsY7DLFyq2+L8bqC?=
 =?us-ascii?Q?EQNT/bxQBiifArGHcrR5T37RORdKKRkDfwEcJUWXmX91tSOyp194LYAvmjqb?=
 =?us-ascii?Q?cgvcDTVQsAmR6QKOT0iONsih9eB8lYvYB6lfZu1C20CtiyvRml5kOORNa6AS?=
 =?us-ascii?Q?mMizFvYAVcM9t70Ls+JRm6k+4GoEcsu0ActHy/0UVFy9wxToXp7thZMNaqBY?=
 =?us-ascii?Q?tG52Ak9uttKbppgRkcnedDHWIg4BnpRsXnt9Mi7DOXK3m1pgZEm1U4uMHFW0?=
 =?us-ascii?Q?O0AYh5/9y17Kj23TpdBhPCjTQw/9V25nlwJGl4vIytL8UxYzdSJMuN/g+wVp?=
 =?us-ascii?Q?jmJxbRZTh8pGa7cnruEYrrCQkT/SEDc=3D?=
X-Exchange-RoutingPolicyChecked: 4mmvoadcHbkv/0AV0a16oAIBoveJgg7BtcjJH8CfhxZ8Fuzo2dSo4qaqhgWnLpFO/2FvFzC1Nqz4I+UeXntEwi7BXzdQZHrw5A6HxppOHGK4e6gut8Spu4bHtG9Z2yBBoEoyNqbbiukV222o/EeE2b+BQLFpbEHk0poAJAfDz/bjz1pjp/0dT6yEv6sLCVPSqEqIH0JlIzuVYrFG0AEWFtwqDNPzJccr8/jJwAtL1apUTiV0zGibaWa324mPYl/Um8LwEmYGI5VJOTf8b6PT8aODE+m8+FlHdr2yfRG+TEz67JLU6v+Gky7UbeGJKiBF6+iz7kFhFwVFR/yGiFpxSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d342ba70-967c-40c2-3d3d-08df1d66a878
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:44:46.2450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOrNJhf33S+mz9yR0PqouDay+LoCjOTT2n6+noR4ZB7TgwKJQT8E1QRP7HQulRN5tkftr9+M9u8sFq9w7cuf6kjEeb34yeUnR0PO7RFUfgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526
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

On Mon, Sep 28, 2026 at 02:14:11PM +0100, Bruce Richardson wrote:
> On Mon, Sep 28, 2026 at 04:12:53PM -0400, Sandeep Penigalapati wrote:
> > E610 does not support EEPROM writes and leaves eeprom.ops.write_buffer
> > as NULL. ixgbe_set_eeprom() calls this pointer without checking it,
> > causing a NULL pointer dereference when a set-eeprom request is issued
> > on an E610 port.
> > 
> > Check the op for NULL and return -ENOTSUP instead.
> > 
> > Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
