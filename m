Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925ACD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF744067A;
	Tue,  9 Jun 2026 16:05:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 23F6C402B8;
 Tue,  9 Jun 2026 16:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781013916; x=1812549916;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CrU9jXVcGXHVQTg8lujMXD5Qc6XQndKN+SXnsgRZ2ok=;
 b=aVHCqgAaoLVsDMV3YaNnI43djcaBhhG6If6dqtx26fzheWY2tEwA2GXX
 TmrED8a7eiOAV78TRXTxPEneCsGmexy9auut5x1DGeMvkpHlthAHBaFay
 z01bf4WHAOADrgn+8FGDFwdTAukDq8KVdYZJAApw3qcXdr01knIrULQDh
 oiYpcIf8Wb2f3G6Rea4sPKw57uFJlsk8e7SbYAgTWnAvS3iGc0tQZaCUO
 7rN5lOI1/ogsXtzn3iAifzb68EUHkzx+8y4hg5jqfXikJbhMsH1NstCY7
 Xjxt/JK2Ko816jUDFOKZR9IIr0k9C6ZuX8VUxyfDFp08DhuQBgMxgEtG/ Q==;
X-CSE-ConnectionGUID: cNu/CMKSTdWiobBzBYPXew==
X-CSE-MsgGUID: o55WhemST1ig72h8YvGpBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85397887"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="85397887"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:05:15 -0700
X-CSE-ConnectionGUID: 5xElHclOQdi05W3GPVlgiA==
X-CSE-MsgGUID: hm4G5cr7S6CYACmJ4sjbuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250797518"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 07:05:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:05:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 07:05:14 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 07:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8uLXOtXN4h6XeMxd1lNPXh4lBRkdTHFrQ+20Sak+N2cTIEXFZWAC2F0sa/Ztka+83H+Ma7KHGJe7/+kfU5T90/h67+eop3OQq2sYPYgZl1/eyiIR3yIJI7AwyAkfpXG7rUZ4gBWrMphOEkPrWQYfrNFwzEhUqWr8g7++LetEDBBH6I+D6HLyUj+5g0YI15cMWXuNijmUrYNQ+XdKuCx1rHuYJ3P/UAGIE/L+StBneSD2xIpuv8DtUM4pOH9l4WN+uirZ2rTm/Qxq+aK5otrLUXLJYSl+EXaQ5PrU3dONQjcBZAYjMC3Nw7HmKFrgNC9banTK623IfK2A3DfaKuy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mib7lmt/N1VB1N5EZOpOCM0q7FHcYmqskShQWBjpdDs=;
 b=i1A4UIMbhyuucjmEAwU9fV5qXusjPJUPewOk2dN2I7ihXmMQ4ODdbvmL5wmPx52OkJgaNHvviddUYdFuPCXGbMxJ47bu65/zz0YpRStTho+WKcHYlqeRji+Rdc1fXCrVOwcCE+wlBMGu80bwfXGta061BSJ+8g5XwoK0ecOf3WysIccU5ukjtyk0MkOZBym8aZTSxOc7l/OZiOdfDF72vnwwRU1XqGuXc1leLCEM8GzgcdcNCpBQKTaWu79gAgXjLlyHEXuxr2QnFA9bUSpV9p2D9V8iA5wEz8IqzBp8gymGh13h8S6VWzMRBCspmde7Mg/zX5lJ8eS6DUK/HDekfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9135.namprd11.prod.outlook.com (2603:10b6:208:579::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 14:05:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:05:10 +0000
Date: Tue, 9 Jun 2026 15:05:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: fix misleading AQ failure logging
Message-ID: <aigdkYk5JMBIZfPS@bricha3-mobl1.ger.corp.intel.com>
References: <20260608171559.355521-1-anurag.mandal@intel.com>
 <20260609120050.360907-1-anurag.mandal@intel.com>
 <IA4PR11MB92781E302F372E466C89501C8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92781E302F372E466C89501C8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e51bb7-652e-4186-97f0-08dec6301e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: mlvcxc28NlwQmJeP3UbbVBzaDbqcNCiGaRVk1XxFXM1QcX4ohT/iYyfEcZ1awIeheo6W4bLBkiFIZHBjC6YExRFCRSFnK5a7cDU/HqhXYNrvxFxtPqS2gLXQb3MX74uL2nDBwe08x82u07kbisiKGdDFB3QSs/qa8dQGLIuqpbHF1/gvaXuzUro0dFmsF5qGSw8wvcs5KiTBI6iwZPwY91AJc9bBlxBa3m2fyGWkiCbQjqkRPKb21NcJRRsrN7mn6XOFuuizfsEeRXmIQ3TAjIbRWuBSk7DuQWAZMWK0eyOGIJpja9E0QojeUFigdwuLOYM5EPayWIv3MxOHHNvNI9VIfUdAFJ/KHUs0Kf4qZFfLPoVG/B9P2rDB9bF6YPYFwK2a38UnSWSQ3nfwDDINEN+/96H9eGw/l0alHfY+rwviyOWRglE9xPELZvq8vEe0DkuTMbBhk1QSKCeVQ+phyZ8lZLdAQMZEjoBgFmCNh3YNUMxzxf5DJpdVC87J54CjsEEtDF/W4cygnQgW6p1J3BIoOobhieZCP3sHbtJ9W0PbpmM8o0LQ0Gk9GdYHdmwUzkVpJ+1JKHFVO8z240NxCBe8+I9VoEMJ5M8WGfBzFI2qCKApHuOD5S9yulUqxq12YESZgWJYlaFHKxW2z3xzyW2imuIEazC4oa6TDKRtafInQF6x9za9uKqwd8ocjTZz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBHFjeGoCKSWEd15AkN9J/KCoacBcgz8011CF2yKSP17/46QGUIuDeSCZDk4?=
 =?us-ascii?Q?RliKIuj704QWHrlQi++AqHKAwudSJiQ0kn4nNm7cpZUHULU4pESiMK5hU9HN?=
 =?us-ascii?Q?yZHCJNeD/paf7J+ur4CstXwwnxqQChJ+gt8HI7TURWyJfREjLKE7kf98+wW8?=
 =?us-ascii?Q?YWc/7tGf+aF1HtTAY7wC2XYR6bFGwBrCQeI3O/r8EE+0L8mo4DK0ds2DYtXp?=
 =?us-ascii?Q?UegLHnTVuvjT9ARk8aAqC334X5AWx+ChI5pi2NIONaP0BYwXRZazB8Nc7O4s?=
 =?us-ascii?Q?V+OAadCNMHh2C9xJUgEk6dWvoivjlAJ2gfPda0HGgPzqZdrfYGYAryfBith2?=
 =?us-ascii?Q?AEGTZVuj9MkLTx3RpHmQavHiDQ8BAnfoJ7Uj21A4kc5lt8JFoNTTHxZIMP/I?=
 =?us-ascii?Q?ajly2jJgaIoHfDZRyRPQY6mQql0KrvcgjyKINfEbi1Bzy47jIFnLvXMIbIwO?=
 =?us-ascii?Q?lv/PcXDOeVpL3sjATiaqgSwOq+Jxrx7hXdrnDYNlURbf2QWDG7IUXDTnEqSI?=
 =?us-ascii?Q?Fdr9/V9EeAVLxoQUUJ/S0C10bwLr4Z+ZqTWV0NhbPchaQS7fvYlPAz7bedwW?=
 =?us-ascii?Q?mOy5oyezVn0fXKW4CI1fkzK/UNdAJSINZ2Pf3HaKDhT0mGl31nz2F6GiinBc?=
 =?us-ascii?Q?+sNJAOAckKVTFFRzQjanlVx3gzDiRZnlZvD9r0l58zbX5ovDGEN72tZ/mSCn?=
 =?us-ascii?Q?yZUfrVmI/G7anCKi9zIJWGH7eAukTlXPOFWiPzIRN6z/kfp1ex3vybwNKZNs?=
 =?us-ascii?Q?n5B1XT6aOfsOtpto+vua4XfuRpPDHEydIqTPoD76gdVrgkh3b/n9qGHdy7t0?=
 =?us-ascii?Q?XNLuzErxsfgx/1yKN74uP9x4qxRXYxC4WfgkPVzUnMe141LU7YhTI4MyDlaz?=
 =?us-ascii?Q?QpZE9X4+eZhjhUXw4IEcJo/q2GVDWsT9u6xgPVeXYDe3d8EhhjEBR3DYfU+H?=
 =?us-ascii?Q?QRqOO7iLZcKkmlzes/SDNTy7AyBMgpUo/aoPQwO6QmWqWnAlCCmVubVQsewP?=
 =?us-ascii?Q?5U2DSquP6vg+7vjZTsK+cWvA1pK/WGj70YFTetaOOaPYACn14kCbonFvfIEY?=
 =?us-ascii?Q?PnjZ+C/oijFGWUrmO0UEWkW1uv6sHGTTACRZL62SzkCfEpmRXh1blT0Hsegl?=
 =?us-ascii?Q?qPUUmJU+iA3WnZ9HHjAhhiN/guRCpDpCPUby0e/m5z0C8fC/j78etT9vY81n?=
 =?us-ascii?Q?99pmOFLMgIVvmdUhFGv9+G8iF6dYea7DuqU78KiTzsEkfXitNoZtlc+xqwzo?=
 =?us-ascii?Q?Xl3TBKrxfTXJdt8dipbdRqSUlUCA0gFtFo15+hyUExCY2GAXU0mp+mgjFVUz?=
 =?us-ascii?Q?TaTl7RMx21nbl8Xtc69vJS7RplM8j6aH/pz6PyGFVyefC6FK1rrx63+W6iyp?=
 =?us-ascii?Q?LcJZ39sdbrfEbNbcvLIBAnfd7I3xt/E+jGNm7dRGY6LQ7P/U4O68oEjNzK4O?=
 =?us-ascii?Q?ykxawIyVZBTE5eamAl4DaQFEakq7SYuZsWcFvx3bwID1zMuSkyFhinJYy5W9?=
 =?us-ascii?Q?pMFaMrzsEUksCacJA6yPosLoKE8j48MDpJkUpAx5Q41sSoHz9vwZZHBwNGZy?=
 =?us-ascii?Q?EpLTDDNM/ohCcbsw7UYaeVYXFY4/o1DHpcm0T3meFBssfxoqy55AL7LrbWl1?=
 =?us-ascii?Q?eJPBVSi1EHDoW7PQ32XSRZgn4KiRbto+akRlqY+HuRRabDkDucnoGcyWEfUO?=
 =?us-ascii?Q?BFR5igY6TXKWOD4LoLy/IQjTrQWMKH4xvKCZukTCFiqke/dFyZ0exLAL3F3V?=
 =?us-ascii?Q?+bM935Ps7Gasm8K4mRbOaKGSbfrcWX4=3D?=
X-Exchange-RoutingPolicyChecked: LFwT5N6S7dcq+Z5cMUALp5zKU/vjKg2BbGr1zxE05SfB1+b3yFQP92BBR0AYGHuzUWsu11J2aRZ1YxQNxzoaHJeiPfEzbqtAG8p4U3mGWrqmvMw3PY5WizdehXRpDl4UjNsfVfnj55OpzII3eBVwxHB4necuocz1mPH8DOQ7yKaM+qS/3FmhDD9ErXWITzD6OWu3lw0yIrZ74nJsjOSt7XHE+N/IrelHb/zUmcCyGvWJDs+Vy+nsovFA/CekLLMVDb2xjnPfGHaL+Gk/KTDx0Q1Pj8RQ6sWJ9+AQ25vdJxlMTunMVnzK48ZqPp0VAOU/KLj276pNfkqPUUFsLEw1yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e51bb7-652e-4186-97f0-08dec6301e73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:05:10.7395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qT/Zhgl8/HbRodG+E4R95/1ZJJlaGlWub2z7ZgCmPOTa5xh8lqFt+0iDgkK7yt/Itm65cBxsSb8ShaJJ/kVz66os6Wa5imMixVQRq1vMoHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
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

On Tue, Jun 09, 2026 at 01:30:47PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v2] net/iavf: fix misleading AQ failure logging
> > 
> > iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
> > until iavf_clean_arq_element() reports that no descriptors are
> > pending. When the queue becomes empty, the base driver returns
> > IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
> > terminator for the drain loop, and is not an error.
> > 
> > The current loop treats every non-IAVF_SUCCESS return as a failure
> > and logs it as follows:
> > 
> > "Failed to read msg from AdminQ, ret: -57"
> > 
> > This message floods the logs on every interrupt cycle and misleads
> > the triage during VF reset by chasing a real virtchnl problem
> > seeing these spurious -57 AQ failure lines in logs and assumes
> > the admin queue is broken, when in fact it has just been drained.
> > 
> > This patch fixes the aforesaid issue by treating
> > IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
> > loop exit empty-queue condition and avoid logging it as an misleading
> > AQ failure.
> > 
> > Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")

Actually, I think the proper offending commit is earlier:
Fixes: 22b123a36d07 ("net/avf: initialize PMD")

> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> 
> Thanks Anurag.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
