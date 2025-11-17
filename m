Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DFCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A73240262;
	Mon, 17 Nov 2025 12:55:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1A37F4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763380502; x=1794916502;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cKYvKqcGEtRWWWfQt9LwI8xuG2oGMU6a7K0CMlOhJoM=;
 b=nd9ZihatC8cHf2yC5VtVfTVLnEBVYOAl//WFdUZB9nGnaL8+/km6UdV/
 35ytc6zUEW/G2xerXYp/CYk682vFDOt6Np+8QwQ8oYviFyGYdOdql6cY0
 GQC9iha34BhQsv49C1xe/FXZzb/XeW70qNZOtSv4/VJSC3OSsfFaNlM/Q
 nTE55evktN9L3eQ3itI1RMQJ5icltJje19nMHDSWVn/2dGvTXqaXYFRUN
 Rqc7ImZZpq3KholMuBL3a6xL6+CfJw+a86vJAh419CwZFq2h2xHsrsjfp
 apZQMhh46sIqqFMclOL2XYf0aY/YEetxLQAnyl+GuO43PzpnAXiYhOL0Y g==;
X-CSE-ConnectionGUID: MJLKIzj3Qc+6u2EcxWiyzg==
X-CSE-MsgGUID: Ue06+DN+R5mXapwpmc+rFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="64581297"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="64581297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:55:00 -0800
X-CSE-ConnectionGUID: AEZei6bzTFe5pO2xAfrFfA==
X-CSE-MsgGUID: Y68LBRkoQwK9Nc0QTHK+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="227768290"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:55:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:55:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 03:55:00 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:54:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZh2MOAYEeKk3DJDQDRXJdLICNNRgqOKEWeQlts8IlahHoMyIDiSKeNbI0VSZIZE6vJicgzpxVWME8FWW2setdk3nmTm29Sail0/aPjsIhDvah/XOxylOcNMj7PwNXguHeHkbrNPWCVjmZ08wQcSQxb52Sd9AFmWnPeQM4PGjz1JLj3d/12LUuaXrI0+Cc1WWWWBZ1Cg+TCPLTqEK0EPu1Ud0hUBSYAeDfIxp3L9PQqhCQnZr/5Lvh25YP6dwZrpvxzeTniJJYk8KHvAvJ8zIAbygqZlkZfdXe8XXkbOKWA+GtF9ckrsCLBEHSt03+K4qJ/4bt26rE2B9XoqaxFfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Czu/C3fxNiQR2I6lz+63XkUNYplMujfeCpIx5kD9ts=;
 b=d3heFkpsGM32YW0AQ83JRuRQnzDBrEnlxTTs0LaqRMU/4hxcYg8AycmjAdf71TJRSZV938NBlRv9Cg8c5GNvneymoWrDJWcn5KvNNLrLqPof+HTs++g1wtb2TtjASphqGpFTSA07lPAvCcqDFtvhxnsRZe2g0YK8SrNNw/kBy6zZPEaS7HFkUA59sPuiMOdnFkfVtge1pfbAHuuUzXkRpM3oyBl1Lhb5YiOZcLqTcYQqiUGJYs8yXt26mVrBGs7puMiSVEVZOWQ9nWEK0Daeg3wSbE01SOxaM7HIUamfTPcSTrEgg/IH4gRxBWx39n3ju86m8WMyFpWn/a1Uo7SxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:54:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:54:55 +0000
Date: Mon, 17 Nov 2025 11:54:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@bricha3-mobl1.ger.corp.intel.com>,
 <shaiq.wani@intel.com>
Subject: Re: [PATCH v1] net/intel: changes to avoid comma operator misuse
 warnings
Message-ID: <aRsNC26UxgWgozZb@bricha3-mobl1.ger.corp.intel.com>
References: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DB9PR02CA0002.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a317260-f39b-4724-a893-08de25d02021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0gLUdgCfvX3rgTAq2JYEm6MdXv3YZhb84Ypk9s2lMgNfc/bl0EWeHmeIcKT/?=
 =?us-ascii?Q?YpHoy7tl57AxKqBHvezFawWjc0rpGix9HZL8e4OfkgHW14HtqUaqvJmUqHAp?=
 =?us-ascii?Q?4cI3dISe21MhH9CaMtnnGE2udurokBj8FnpORxBCSEZtrGKPcLfdyaxzYEe6?=
 =?us-ascii?Q?ljwHn0mm7y7yTyYTOwMMvR9pnWVNypU0hqPLr7Sc0YmzO8mzCKzXMArXN84V?=
 =?us-ascii?Q?YMZ/IL7s9OtdkxXIC+oWnld5kI6hI68u1CJyyLxoOO5FHJMuH+sEpHajgdCt?=
 =?us-ascii?Q?j5HV71tRsAU/QtJHmHlrTb2CFpUGX92OnGqPgyBxEqdUlBpYiQQC3FhVK9XW?=
 =?us-ascii?Q?2o1Saf0pZLYsdIArxLLLCMbrb+z79xSPAhc5KuO+TY0lU4TrwdKtBWUtJ08b?=
 =?us-ascii?Q?r2Po0DAU4C36G3vQ+fjmoBKvz+WFx5WLB8x5EQTvAvnEGxysRUhliH4rhPxi?=
 =?us-ascii?Q?NZhTcIKxoCdxM2JjrBpg/hgN1ttj8zU0lWe8CdJSXpzbDVlXQhHwCHciDN+a?=
 =?us-ascii?Q?bA3tZvPfuFmYChqmdDTz0gxmLp3G0UKBI2hSKPMvcvVQkf/QHmuR5j7vzw+1?=
 =?us-ascii?Q?OoJ8217tgH6WNyHR7Yf4VmB/2xIQz2zyZLijku3QNtIRQLGQqlM3j2Wf/sbR?=
 =?us-ascii?Q?OMmpScpaNN7odzm6YHBfu4KwHf0QGRdp0GOtioi5FL+iLjzG59W8itkJpLRq?=
 =?us-ascii?Q?C1A7TiFdsT37MAxbnwrSDBEiUViAL+LsNNBxJixNM2i6VoCizsk5vKDfAjRB?=
 =?us-ascii?Q?X0SdkLifXkgP8SANb42xIqfTs2C7tQ/2RrGekXHhC9l9om5JqHTYODKR3X8F?=
 =?us-ascii?Q?GLVuOd4lyJouGRgW1LaaCr5VmpXx9aY26oIGhqpmMDd1eb5gEBKHdQP2ZQAO?=
 =?us-ascii?Q?Fg67yufYx/o1qlLhvlwngSxPajS1pNqUhrA5IjeFc/xoHrlgoi105FQAnQCQ?=
 =?us-ascii?Q?ZDG8w+habeQXmZ9yCryx9FcRZRHIwcYQ4QCQUKXwsgn/DCI9i8uOG/cB1lAf?=
 =?us-ascii?Q?HKHcR4eEcPFfX5cfE6bHGIc/jGWkneb4OnVN/yxzCH6q57MJK/hmdn3smHbP?=
 =?us-ascii?Q?17dxLPdauA+fZeeeO8VOIvPs9Xas3Mr10MAPftSi3J6SX66f02D6CzHwmJ9K?=
 =?us-ascii?Q?xeI+fRjG0fJxm3bCKb3VW0azBPh+xXfre/TBQw74LYGFKYTszUO7uGKISPIY?=
 =?us-ascii?Q?1mK298T4utsFB8Qg0VIzXaKBoKDAXdOBw/zSe+1xSLH/jbjj6Fi34MMmMemT?=
 =?us-ascii?Q?+JtsjQXt9nJnQB87Z/jPWYyd7YnK/4YXDwOFDz/jmPJCHuD0LRqTGoLJypBz?=
 =?us-ascii?Q?028QCYo549Sc7YBVSMgxq9fTf8uUEUn92Jj45UuO/MLGFdTfjggrk1ai8IYq?=
 =?us-ascii?Q?xiqlstMW5ZA8Lr/3IR7/j9ON/70zOI8/2tRBQiqDIQ1ZKXEgPOoQHQTZVF0x?=
 =?us-ascii?Q?Qy4RSzk1kF6EtM72A27NB5qy4uXz2Zt1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JqXuiF/u5jE+iY3D94h8tDDBRYGX1QCYHLsb1zNUEFhF/tK0XZwp5CYKq53u?=
 =?us-ascii?Q?gP8AoBBSZn6w3N3nzU8Wc20YnPz1FcZK7i87qRlTIsilLF5LvOw9QGsoix+Q?=
 =?us-ascii?Q?IcVLq8hR9Mt3A/dvihJwAM20vve2KsnCzPg8Y9WdnECj0UfZEphe5t4xhndu?=
 =?us-ascii?Q?Wx+RZYdFdJenwmadHW+y4lzHV7OQ8yMBsipVxHwMo7uIR9Fqtrtt5PE7E0TA?=
 =?us-ascii?Q?nhQ6C8Myz+xH02m2ONzZDWweshgXIux32zlfQ44X8HE47cTcnLZUJKlDMjxI?=
 =?us-ascii?Q?SwluviLn3h4V4BUBY7MPcg8Hg130sFMwYKYYKwHtijDxs+o7rSfzL//Sg5dA?=
 =?us-ascii?Q?xZLDEyc7WxFgP8sFxBdghtbY7pLOz0rZ039aP7zg2cxvu81+7iegBLMvCmKA?=
 =?us-ascii?Q?GoLw5NHohXon2uadDPB7F4c8/PQrcRq3aQm4LrWqXATea9aKzQm83NiKN6dE?=
 =?us-ascii?Q?gBr93W1zMpJa3pfF9azW49BCQa0K/BV75JeDITg5DwBFjIYjDpmQ06pEMo1c?=
 =?us-ascii?Q?DV7x6Kx2ut1ioiffXCccHirJGNbjYqD8sDEIaHgRr2gtXwMl7NW0ZJyMFVqk?=
 =?us-ascii?Q?tf16MbdC5nlTZVAf92sH/ZzpkUZqN3tQjn8lfLylJnvrjt1WZSBZxYevIHq2?=
 =?us-ascii?Q?PSpFEyB28E2/VO/9NDvpNLpYlSwVQem6U3zbSVV4RcyquDcf9GQHcGNPB4bw?=
 =?us-ascii?Q?7SUyjz6KzH2V9CdQbCbt7JdcIWZA6fFcYvMIqQ9tcrbbx0SZV+owuPtD7d6G?=
 =?us-ascii?Q?oWPVhs1bpi7nfvY+S6aheX/kesRW7LzkZGFyBhVooB63FhOWye5Tyzy21Ip8?=
 =?us-ascii?Q?WwqjQ4XQ//X2z98JZXOhlmFnacm1IUq3VUdyQYKWNY0pOfPT473Q9a8yJgrk?=
 =?us-ascii?Q?ngGHcqSogLztRGt4obonTUvXEFeZhjRrswfcmTTOv2UsqH7e9115nN46+xov?=
 =?us-ascii?Q?zJTEqeDmvqdAmXYrafRb2lBpAewI6QRh2xQMF/fsrSlW1S39VLLOfHZXhMGr?=
 =?us-ascii?Q?VPCJQc/M/6UQRAnSpHo+IYaI33xBaOTWQnx1FoxBNLJmpNmYjfb8UNIRNlD8?=
 =?us-ascii?Q?Jc3Qj2aOOTc0Y41hWw0XlvDhWZzwRgo+m/1At/bv2puT86fCAH/DK6xNuE/s?=
 =?us-ascii?Q?0eHs5LXEd/WaqoX+FKibWNTDnwthI4yO2v7uOL6p68CoLKnH2WQv9TETF7Tx?=
 =?us-ascii?Q?bTqpFO/yjKU+bI6Qnc6IIGV355DCt2iCLU5Bnn+DAYLHf1BCP2qSWRVN8JB0?=
 =?us-ascii?Q?fPByVJJ8D4HtqrWfy1V85yaFeaWA+nShK3bvvBTZXU0ycyKDuoWhs0oZva0z?=
 =?us-ascii?Q?Qx68kCZNPx7XuI+H7wlDqpQzjQaC17wqwM9q6PBLGBUH1m7HUaWqaiA4qvzp?=
 =?us-ascii?Q?joTWBAI9+91pCdH0bif+PNpdQgME/d69icygDWseRT96zPpWv7002EpsSTgt?=
 =?us-ascii?Q?B8qCcbp5DS63+eEZn5pc0kjZc23qC0hOLzXByya73HkTLiCLBcgrlimXDZD5?=
 =?us-ascii?Q?eyuh38T2nzGG7DtPEd4gjAMs3mWYtD/0s9gpzRhxBFLSCrWDsrkPX2l3ezuz?=
 =?us-ascii?Q?IPaJ7zcDH8nssEC8qCEiVqcB0IsrVVEi3bVS5M/aUFoZoTVuo3oSYwaOWl8i?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a317260-f39b-4724-a893-08de25d02021
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:54:55.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr2qKDTHnfhaqsgtpmMDW+QqWXQRqx7tU8EuthCC2FQShNbM/ecAKzuXQLOG6iFXbKle1rJTRbCY4RBW0Yfk+ZhE4XTaZT49p2gkDckq+u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
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

On Thu, Nov 06, 2025 at 01:53:54PM +0530, Venkatesh Vemula wrote:
> fixed comma operator misuse warnings with clang compiler
> for intel PMDs when -Wcomma enabled.
> 
> Bugzilla ID: 1809("net/intel: possible misuse of comma operator")
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c             | 8 ++++----
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c      | 4 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c    | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      | 4 ++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c    | 6 +++---
>  drivers/net/intel/ice/ice_ethdev.c               | 8 ++++----
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c        | 4 ++--
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c      | 2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   | 4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 8 ++++----
>  10 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b8ce79061b..799e65ac8d 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -5099,15 +5099,15 @@ i40e_res_pool_destroy(struct i40e_res_pool_info *pool)
>  		return;
>  
>  	for (entry = LIST_FIRST(&pool->alloc_list);
> -			entry && (next_entry = LIST_NEXT(entry, next), 1);
> -			entry = next_entry) {
> +		 entry; entry = next_entry) {

The indentation and wrapping seems off here (and similar changes below).
Suggest you see if the whole "for" statement can exist on a single line,
now that it's shorter. If not, keep indentation from original code and
don't adjust it.

Thanks,
/Bruce

> +		next_entry = LIST_NEXT(entry, next);
>  		LIST_REMOVE(entry, next);
>  		rte_free(entry);
>  	}
>  
<snip>
