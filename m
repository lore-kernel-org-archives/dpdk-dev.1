Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E5C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 17:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C8F040298;
	Fri, 28 Mar 2025 18:18:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9542A4028B
 for <dev@dpdk.org>; Fri, 28 Mar 2025 18:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743182278; x=1774718278;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MloZB1XlR3FqdHE+ApN+wenuNytnNx2010ZVnq16xxQ=;
 b=S1tdce/9wpjNIupEQBM6ol+ZIIBhg8FPqApS4MrAOKHL/ZOZPdr3UctC
 VV+DpPwhF/PC+BXZMNz80+HErl5QUd3rQKYPn4bX8/KJieI3/dJiP1f7v
 eZdc2SiPZU+H0JVLQRp2/N2iyJh5LkHCrHmCDAohdVZcJfEWtu9Woo09S
 7g0MHFsx+3EfJW09ASmIak2PxuFL/DGNo24eON3uPFK0dZlsVbtysn9+8
 0l1871mwOUlqNi91l016+QrOaEMo34I36junZxX8WNzjHajgL/exlnsdw
 EVR/0kV7bqGtIjOd4xabIZmKfPFJyFIv5H7STtptleKJiAR5zKeA5LUNy g==;
X-CSE-ConnectionGUID: MpD8an/cRFGPu6OeMAkojQ==
X-CSE-MsgGUID: LaIw7+s4ScyIZaCtcnlPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="48209611"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="48209611"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:17:57 -0700
X-CSE-ConnectionGUID: DvDxwabUTPCIQGfJnX3bbg==
X-CSE-MsgGUID: Fli+6FahRoer3kRjUlhleQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130609966"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:17:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 10:17:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 10:17:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFWfPssNU7O7yyDvBpDEE36UY6hlR9mEh/s8tLI/V7LPNx7uaIrzn5GnixssJuvCF8MyZKjtyu25HHC2muT2KGv3EOIxJQFGGZ3OhIalbJ+VxrpYsvil+yILKOsUIcRoklNPVyu6HlKmMH+A5psedm7IxJMFtupi5gsJm2mXbuhA73Gn3OK8iHIJEcAAWmDfH6EreWgm+VOAEYw5cpRLMGIPwrQRAjJZRNK92opGHIMar+1UEPL5BuJ806hWjQDUd940DcqO1Q4OG15zuny032iJCX7DujYbnFk0NyDBgauqGoE9ACLvkBheRaIS7jtg5GvFAf458TPgyyRLSZ0hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBUOS+gYF0qvxn7yGgHm0F9SbG7E8ZjknjUG4CDZrvM=;
 b=MQL9GZZ4LVhfMlAMBD0VzM2p8eClZiPrpniNGEdQm+e5cNjYM1XXBXl65J44z9aLhQP1pxDP20zRdCZn7mXZj8cmomkud6FbAABpxhcSENb7R3SC/wJWw7A25+qRAoENMoBh3M+en9uOy3S2vgFLPe7WWuILtdSLa9OcBKyvm0t0x9VYC1nShCcw1yvSf6c+BO31kk9Wi/1+Jjqo52UlSsvMcsgU6rrofXe/CJElIGx3++aO/hShka/72VG09c2eWz43nHAcIaKSR+X0yjdp6XZ+p3nQRPuiLdilCdE2cvvfaWvm7BNAEWPSy5cgKFtZtxlP3lqtxTGZq20sytnEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:17:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:17:33 +0000
Date: Fri, 28 Mar 2025 17:17:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 3/4] net/intel: use common Tx entry structure
Message-ID: <Z-bZqJ8Ka7Xc8o62@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <20250327160437.2296127-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-4-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0358.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8b153b-bfe7-4f55-5996-08dd6e1c6d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BAeRXAi5IaUWNUU8DCjY0gUCEKb59SL1Ya7e+DNDOne2eTf6GS1wPHbhSMWH?=
 =?us-ascii?Q?mwk33SRwr9OSfhClWT/n7yALdGyVulc4kGwVATSYhMVdcPk2skDZ1UWyGDDJ?=
 =?us-ascii?Q?ke5THZMOW4NNdheMVq2WBTdb/j62Ni8vFDinOB8FH2ECtMn4V2ZzXOSW68xA?=
 =?us-ascii?Q?KPIu0ztZDSOuIbz0qSAMqJ5+RwujwhHa/I/j4hjVkdNu6Pt/T0cuIkZtS2FP?=
 =?us-ascii?Q?T74EmviKXqvNyNPa553MhZXWVQwucDDR1WqE+gIgwWPDSeIgIUyvQCEt7vqV?=
 =?us-ascii?Q?5nEerRSFsi5ed6KPesnif6E/Fl+fIsmfOmIKUnL5YnvqqYVZJw/ekhzdHSjg?=
 =?us-ascii?Q?Uimr5Md5HRiCousHBd6l7UWMnI1uoXQyo82sNzCx3tpgZwSKtalna/TTvE+b?=
 =?us-ascii?Q?po4Ea/FN6NUKVTKBH6xDoBAYpAcACFFpBJc+nzdIk7agx/Z/upwW7cF9x+Df?=
 =?us-ascii?Q?5cgMCpQ8/iHN7Oma+2idEhN+JVMXxxggsGzvq+ui+tvHg8SvbsdDX0TZxbD1?=
 =?us-ascii?Q?aBGJQqBUpvonZW73SkXhVvecSRMxlDWo3ZThPY56spx1ajNYM4f7KXx9OQto?=
 =?us-ascii?Q?Zd+1N0tM18BQWbnvaBKg7X+x1v5ji7JGnPr9B4NqbA05IT9oSt/cV/FNLIhE?=
 =?us-ascii?Q?mJHeT/gsMbRu4w3fyf1ej6Ri+1LCLifBt9npiljgZUh1S0IiaMX3hQZj/+9v?=
 =?us-ascii?Q?90pkqC6nskXp3qlR5feGpCHcdR1yxT1OwYp9mTAKmOgDiplkZOTW7QuUmJSg?=
 =?us-ascii?Q?PmkOg3B139LWQ5FdlwKTd8fkcI1f3wN6crFS0L0um69lvf9A7sQnENXJVPV7?=
 =?us-ascii?Q?RenzwrhOXtU9eZkISAQox0Pqp1l2PXh10/dyXH/yzIeDq4M9L3swzJnyg4Br?=
 =?us-ascii?Q?LEl9B4sF1odX5/Ig4RfeZSrhVRXRQy3YG270jgKPyiA0URZ5lf5jfuRxlI/o?=
 =?us-ascii?Q?SM349WejnC+QDtCd/k0nN14ten8j4GON+nRX1yNLp/Cg4JNfocDuZQ2/Rwrr?=
 =?us-ascii?Q?CNjG61WoQnKVFBekBUqs/YqW9RvXwwms2U+73lKWTLm0E41DrBJNSsZ8z8NJ?=
 =?us-ascii?Q?3DliQXhXNo6ddPFEva7weW5NcWBK4qrJmjvxJBzU2N5wzAi5g3XBfYDR6Zdd?=
 =?us-ascii?Q?/PiE5ajlJYuIT0K0iDEhog/CZyfCfb1CkIr3EUfmMvl7AJC0nmU6LcY3tpGQ?=
 =?us-ascii?Q?n9oeSnqINxk38jCiXHyIPKvUxfLQPJCuLtvwKgRFVq2ofED+bkiGj2IsIGT0?=
 =?us-ascii?Q?k4tZ8S28yBi7JPAmHl3ooSTmzy6DjZiEajrnTxdwCu790z4iX0G5hyIO4Q94?=
 =?us-ascii?Q?9Mnd9QWygjejF0sjcb+JQ2fGemLN7HLlUpo6lbMoremnXxdqKAMh9tbwYFEP?=
 =?us-ascii?Q?8ic+7dkWqWAoe75G/y1q+F83URwV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmA5Y37LgghJp12FVTORRZfuCNMWwwJDVkWH5Jy5kop/c+2iNPXRZDKITY+E?=
 =?us-ascii?Q?YdNF1V/GdowfGaVC7AspIZqIr+sYI3oODwGNhooZryFpOlc42wNN3L87rnWP?=
 =?us-ascii?Q?npa+oFw0ltPHCmA91/an7eK50hiRnQDdsFNKVVK4sQ1pI4qsxpjBJRQZgps9?=
 =?us-ascii?Q?FBNMdNv5hiVjH73XA3WNI4YqtskbmblKZTUkFXlGX0TEWJUruMnWLwnyCvzj?=
 =?us-ascii?Q?ntM2ykszgzYymKUdNG04c9vK0+bTfTUg7rBBxWcqu1exHrLpKxlsDSnHSu7Z?=
 =?us-ascii?Q?ftP+7iFkxHLVIpNexaIWquVoFBQFuSxiPSJSTTtFR8CS3t0aUtQx5MbbT8Fb?=
 =?us-ascii?Q?I68ERkMqkTBAwV+xo9UybyNsg7HhcrNPiRGyljX1apNApo53O4IpG0RR8xtd?=
 =?us-ascii?Q?DQvHd8wBTXCtjCCRHrDydt+lTCBoWED+4LYzrV2a04RDa9/ovXA+k9qeyfTV?=
 =?us-ascii?Q?34GCXC5FvfpSIS+JdGl87SYRsFHazTgSke6dtzpqqf6gIozuX0TIk8zsAiS8?=
 =?us-ascii?Q?GzCikHIEfFpjUGffL40r9cjhqhUFOlyXfGTda66H1x0tVbqFTgo11UlryfEo?=
 =?us-ascii?Q?o/dVB7ZuHg5iJZGf6t9qZ9hjijFP3atXi8VsHeBEejc+f2Sz7YNl1cTVGHaH?=
 =?us-ascii?Q?+vrN7t/IS+iQyNUxn8K8hKHxQaNUidYSs/UF8msScgewhhY33rUdz5nu7Mhj?=
 =?us-ascii?Q?4rw4HwACgf6BkddpmDapDU2jQMyjdnSE86M+8Cm2WesxEJkg/axqkWZHiw5q?=
 =?us-ascii?Q?bEzjqEqs2qI5n8V2/UJ7afMzrXlCOWcqsqmZwvRJYOEQsMQdl3czlgIsaJN7?=
 =?us-ascii?Q?3AAQRzIIe9HBvesFloIARNh9/LI1LgAS1dKqD82OyxG+k6rt6pMvBkxmqZP7?=
 =?us-ascii?Q?M/Hihdf190D9r9S+WFIiDB5U8vZSjwwqHRf0uJnY7gPHv/Cj1xYbQJsf+JuG?=
 =?us-ascii?Q?kripfOC3fhmW6myu/6Oc9OIBQ7MA6hl/8Fe5sZNxdpThug3WD51JiQHegFXL?=
 =?us-ascii?Q?gC0ttn6PCmCyqW4fuVPLtDXk4MFdYgVnWeKRgXiggXwdVI3PtmjnTSx4Tyfr?=
 =?us-ascii?Q?s7LGIXhwlBR9oTIKQej096WHzfvR3Yqzar9gZkNM0g8Zd2Apr5+xTOjwCoW9?=
 =?us-ascii?Q?db1pAJ3YOCklqVlap1JMM7exZmzJZ/EuB2bWC0cGSYNMdKHM93uSGKmcJSTI?=
 =?us-ascii?Q?bOdVM9ZObloGp9X2Ok4a/rcvuQPY9h3BGuTSOu7Jrna7wmA5DUI5fs0oMOvR?=
 =?us-ascii?Q?qaygCG40G0t560gR0oCGTdAWcF6Yyp4BqcTWmvPfak9Zo+wxjaDgy48lykVQ?=
 =?us-ascii?Q?HNVxZtTsv+lKECBHQXNeTcT9Rt1bAWkPq62TkJUAHsAwdaTviH+awAfUT1xq?=
 =?us-ascii?Q?//KJEa7eYM6QGdjLdG+UElqyMnlHKEi3Hfgecgg2pNKX/+1eR/UxB4TX1KQX?=
 =?us-ascii?Q?K4KURSeTsNwGX7IyQSChhyGQUq0VuasboqR1H/rV+ddRlB+4LvrKF02jAlwE?=
 =?us-ascii?Q?hFXGWdgl2Zml7fjVfCT0HIRzcupYOtE5WmgtDzwkzhOSNh0v3cy6cjLd8Da3?=
 =?us-ascii?Q?mNOgMaxfvJkzofPoSe0eMCA4TVRNnMDVos0pbEYbAmYvcjHjoQctQR+1KAuj?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8b153b-bfe7-4f55-5996-08dd6e1c6d5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:17:33.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM6zyWxVJKrtmKYw8zUiWAU6dNLzuNZgFRdZQLxf76VyOLNDZQR1bnTZJ++Kt0pEontcfowtrxOMFcYCpaleJlyTLta6JfQMaPz/ytNPHLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
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

On Thu, Mar 27, 2025 at 09:34:36PM +0530, Shaiq Wani wrote:
> Used the common Tx entry structure and common Tx mbuf ring replenish fn
> in place of idpf-specific structure and function.
> The vector driver code paths (AVX2, AVX512) use the smaller SW
> ring structure.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Minor nit: I would suggest making this patch 2, rather than patch 3, which
would avoid the need for the typecasts in the patch to convert to the
common queue structure.


>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 26 ++++++++---------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     | 10 -------
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 23 +++++----------
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 28 ++++++-------------
>  drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
>  5 files changed, 30 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 48fc3ef7ae..4318b3fb3c 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -210,7 +210,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
>  void
>  idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
>  {
> -	struct idpf_tx_entry *txe;
> +	struct ci_tx_entry *txe;
>  	uint32_t i, size;
>  	uint16_t prev;
>  
> @@ -223,7 +223,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
>  	for (i = 0; i < size; i++)
>  		((volatile char *)txq->desc_ring)[i] = 0;
>  
> -	txe = (struct idpf_tx_entry *)txq->sw_ring;
> +	txe = (struct ci_tx_entry *)txq->sw_ring;

No typecast is actually necessary here, since txq->sw_ring already of type
(struct ci_tx_entry). As I suggest above, if you switch the patch order,
you remove the need to have the (struct idpf_tx_entry *) cast at all - it
was just introduced in the previous patch in this set.

>  	prev = (uint16_t)(txq->sw_nb_desc - 1);
>  	for (i = 0; i < txq->sw_nb_desc; i++) {
>  		txe[i].mbuf = NULL;

<snip>
