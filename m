Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39FCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 09:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D9840264;
	Fri,  7 Nov 2025 10:26:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E5C034021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 10:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762507585; x=1794043585;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EuD+wEutoExYBCHRZe8+4cgr0PqukCZgannNeoWetgM=;
 b=EfbLfx2610p7n+1k+NlMGfX/qY1yayehYxGLtPur0n1BYOQ6xVXD36T2
 gx6LukW+stkifOXAPXZ2FmUTGqG4ooXVQDCuBn3rKJyCBipvaCdHmx7DM
 XnjeZfPZVbAc3sJM4WtN+tN0yCKQGslI/49Oc5mh1G5RKtD3OUpzHxGLM
 b94buO44X47hl9sRt7guSJy2e6ThoJH1xb5CVs5RJ4v70ZopKhHQtfqoe
 9AAmts4LuiPHE9Dly5M5YjevthJpAHPX1kQKN9w8er3dgbFL6w8AqvMO+
 6fsnHpzZljhxnnO2w2yvnUNny1EUgj+/u2PbGfl0z5QN4Ap3w2rBj7R4R g==;
X-CSE-ConnectionGUID: OEbiLdfCQ9St7fHLUlQ5ww==
X-CSE-MsgGUID: +x8+qUY4Tv2RYq8rTgihEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64561836"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64561836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 01:26:24 -0800
X-CSE-ConnectionGUID: XZg0UIXlQzu8J7fBSVcOsQ==
X-CSE-MsgGUID: J+IX+mROSsy2zg8AAtW0dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; d="scan'208";a="188715623"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 01:26:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:26:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 01:26:23 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.16)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXZE58kDaEnXUULq2lA6TTzgqdKbGQLqz/Q+yU+VENiuYvofahxaigB84zgML4kFswKNXFJQtLdba8lhtqCLpHS/ubtmMc78TTUwvYgdVwoAUZeGJFm3RWs2yGBYOxcVcW1YVHBC/DlKfcHXkuA6lB2xTipKCTZY5VHOlLgOs84UgrkYSCRlag70ih+Q3CS6yNbnnehNhUf3n7XXpd2gQ1iFsygGUSPO7ADiLfCAaguakjvUIgFfKZ97BIDFaFokeAPu/WlNhqpxj8uMR8EY2MgZAORcAxVbA6sneEih/fpl6yLwKpKU4WPpXXJpBSFTdNKytadtnLNzPKATfc8QSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKjqDJp9QEnsNAFsol0Th2P+1iXW4gDsh0tyFfFwPPA=;
 b=Cm/bLQFTj2yVftvVvnfY/QtePoM8NPmK0ViYG76Jac06TTNjgMGluVyb3sSqwQj5IymBDesf4/ClHMTJ9+2BdkYypWYU7jnltzZrqXtr18oVXRorDi2BgfoCxpm2HeqAJRPJb5ithtmmYdeFYmPf9YEO7e3lSzj+3/AqOkgN6jkfSEV3TiiN4COSZII7iZdU20gsR7oWRPdgvz1LmSbIyzbdePGDbB8t1MCgsHtBtffTvwPk0PUw6ZTg8wZ2sng4ewpd4nTRBGyYnnKQdsZBHlAyI/HOz8mArP9uLJECFq8J3FcPji0ZWURXWc0sUqt+f5muNKhhC72e7/QFFeYqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:26:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:26:14 +0000
Date: Fri, 7 Nov 2025 09:26:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: fix statistics read error
Message-ID: <aQ27Ml66XlQB7_6i@bricha3-mobl1.ger.corp.intel.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107074338.957352-1-zhichaox.zeng@intel.com>
X-ClientProxiedBy: DUZP191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: a277bc03-d23b-4dc9-5143-08de1ddfb261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0FH/keYcOdLQYJp93GSgVi4+FhmFl1ATDT2yoCp0DPCfOrKZ8nOq6x8cVH2i?=
 =?us-ascii?Q?WJMDnxmu7hdzFw01OA0LF7K5hCsP/jASM3hQLD233yKk2tz47Jn9NlODNty+?=
 =?us-ascii?Q?ubtYVpsxmyJKAiN/3RXiELLJsgbqTY93yCWtcIbXetLvKBIqxV2465NFdB31?=
 =?us-ascii?Q?5XBsHesTf0lVaLXeMOvOpmDnQn/YVO1pLUHPo/sWTHyKoaDFbNdbFi4iqewj?=
 =?us-ascii?Q?JbD+/IxzCwfHnsT+mt8dIdVPJi0uh/ep88SIS4X3P7l7NC/HWMIRQlG0Lse2?=
 =?us-ascii?Q?Lb+GmQ7mxGD4K92HA9MLg/zzgWDJnLh/J/LsBg1WkII+ac4lCywlQIN5yjwO?=
 =?us-ascii?Q?J8hzsulCrbGwi1EfjGh04/gQoBcwo77OjuHeUuHnnbXPFxuK99klB51IuaY/?=
 =?us-ascii?Q?3RvR1MM1+LEESydUmyE7dnFP1eaVQbND4Mpsz2UjlOsOdj8T2sCF86V8AlMP?=
 =?us-ascii?Q?RqEnBHZTtVxcOMYJMY2C9vFVoYh6lhrwnaokVXyxVm/qtqiUzVVfV9wKUOup?=
 =?us-ascii?Q?osSJ+pPVQHti6kmbqskLNY4k30Oghc81IlHC9J6kxy95GqsTxR22wu8gM/H9?=
 =?us-ascii?Q?OKYjry17KLBEf4k99fwHWfdEwl+YrV4Kiv9ImQgXquP+KVN0v4f1vbjy/um+?=
 =?us-ascii?Q?Ihj3BBLeulaXr8dmdWN2RWdHFkNRVe6666ax0PpDwT2u0pKWsqncEnE3HznS?=
 =?us-ascii?Q?bGnhQoTSsJukvGBNBcP9gMb7fUJbTEB16JLZGb2J+eiLw2gCiJbgUQI10W3f?=
 =?us-ascii?Q?92/jNc7WCAK8dty1I9Ra8h1KodN0NdtEl4JMnPuqJ9rDJPFDA9v09+w2Qrn3?=
 =?us-ascii?Q?rpwM3sBB8Mn60PLXk5WHEIEC0YLqq6OpO/I9xt7IkYDDg5tmb6XUP4elPJjn?=
 =?us-ascii?Q?akdFAmd+lcy4g05hRvdPH1FJqPt7NK85AGcFyrNwNrV65MS1D2UnsnDXFLPw?=
 =?us-ascii?Q?yZ9z4IVBnYRnnwD2KF8ELzkPmJ3Sae4bgbkZCf37TM3IH6p3lEkhL0sYkeux?=
 =?us-ascii?Q?zQssAKLC9UABatYzu5/RmOECwQENdx56QyVE9ykcl5JtxAN0QL9Qh37NliZE?=
 =?us-ascii?Q?abZlzrjn610xr81WDDYDb6TLTuOWhN/uVpGr8DdIC5oYClznYtjuMOQxvndz?=
 =?us-ascii?Q?1lvx1TlwsM2K3gPlzpmZA3+yA2it9q9wnEUKt3neUHRQFahF+BisBJXnYoLd?=
 =?us-ascii?Q?bylA3Y435RrhCLN7BQywCXl7dJ0HrMl9pJbQuL/r+rOpZdDTxqH1jBLH5JnY?=
 =?us-ascii?Q?T9UHQ4VIcoyBc8m12xWErttmo+gp+wyQojUlS32g2jIZYM8juFcZtAzePKiv?=
 =?us-ascii?Q?+WoCmg7MdX2lUDekELmGtYNfaZJTDClDfChemLOUZE/46fWTa9AVCdaiuoCW?=
 =?us-ascii?Q?DvOHUCyKnKx5/rPHrz5QMuhOndLTqrdoMcK7z0+f8iv+zKNt1eGlz0DFQDyz?=
 =?us-ascii?Q?ZB+hgLorN/0UBswOa6+UkrFFuh9ksvI+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xU7fiFZcCTsg6ecaPKBeQRV4+sjQK5us5Y533oB/84yrQiQBARtC5OcgIcDT?=
 =?us-ascii?Q?hfSVwR6UQDsG8QiGo8nmiSJQ5E0nPbQjzTTdKkd6QZf/a2VObZv8IXiOAncZ?=
 =?us-ascii?Q?sTupmow/3t39pNGrGZCjT0jS1h06FQfRXBVfGKIidxbdUgI99/j7zbNoza+l?=
 =?us-ascii?Q?RWZUgJe6ixzMwrFHloCSUWqGN4Te8dwnKfW5KKvJlL4LACfOTJQbxBn3F9n5?=
 =?us-ascii?Q?kvd1GUWP3Cqc1dfXjeQTgmS+RS6IEeqBF22EfAYUd2ZwLRCCc1KZnLPIl4U7?=
 =?us-ascii?Q?M2/eLfi1cf8G41k2WZUYCsmpgQjc1aZmQTGV1irHhK059mZaOWp62qIEgurR?=
 =?us-ascii?Q?hWgMUmbocbFbtLE2Sp3xCCZCsgZNkgp0r4mMMMm724rBxCttq0/ZobXYsAnd?=
 =?us-ascii?Q?zCXH/n19E3ebrA+fJg4wmr8AhFUmWRyk1qFOt37jgTqBHWL4viXb34d9QGK/?=
 =?us-ascii?Q?+0LhYmUL050ZaKZVzo3QkK622RCXsUdCLjOyXGN0jQKub7i9qJOJARQRcN3O?=
 =?us-ascii?Q?tiaVfu+nF2PoMJq3pcA2ukaKcZiA88hNSdyoekTZ5uowxUHFXA9tQklPkYQS?=
 =?us-ascii?Q?7k+fBqKUiWJAwHPgNRbwpSaAskvZh5grIliJ1YzQSywDj484IuCSOx7EJ61z?=
 =?us-ascii?Q?cOkx4j6oeRse12AM5wiRKRTvBPq/76xdreREzW+Aprw8R9eF5EKRF/Tz5zAG?=
 =?us-ascii?Q?79yvoaXZk2bqoiY2Cps3Vb2cDdTTQkGjr6RJ3s9QWF5ANrTBiyClOUIW+ok3?=
 =?us-ascii?Q?fYBXGdE1TNJRRdfMZVMIJdrwDZ9OX7UMyP++BJDnAIuRa9UKYm7TxYPagslF?=
 =?us-ascii?Q?9RXY3DjzbQuPF7NM8Hxz/LqnJPPbDhLbC7zuP+wotDtUzndyuSwlyLXKTfIv?=
 =?us-ascii?Q?OoiAug0OLw2mDSZY9B6Pfeq3iSYciaD3icrcP+EyNlCB2SHLdo0laqeEvhtZ?=
 =?us-ascii?Q?Wjs/xT2+GwdViAEg5h5qrBVRIxaEWXsy0pW5bIT2jZLRran4hb2Vsp2bu7aa?=
 =?us-ascii?Q?+lkUYwbQkSfs7jipiPGMvkeECsshhAby7a7uREYPJlpkFLisWy9erBEteCOb?=
 =?us-ascii?Q?/pbiy9o07moMfh0LvhTInhoI1IKGHi9G4pnsJAZbAq45SdntYhOofZzBOksR?=
 =?us-ascii?Q?SfmXgza+TU5b/HOhlHDh/9IN1lWf1ZpRI7ckRF1iPGomGY+5FQmi+d8sg9R8?=
 =?us-ascii?Q?nGpV9ZU5SSTNt4UTXlRxZQe1r+qkd6NCqZwoz09goprBsOqyy5jboDxpQDki?=
 =?us-ascii?Q?K63g6JPzpzvPo/sss88i6PhwrpA7tL6G7HR6GEKxItjYpWXIrw9sfdS3RzRv?=
 =?us-ascii?Q?3Xhe3HhQQiZxSt3s5c1+k3xPn8G1/Rxsg0vzj5l2QhjxYFJGDFRZp5DYfar5?=
 =?us-ascii?Q?jVun/Za6ItHSJVopqihcBsIZUy8qFVqtVklcPStkpWxbvIoRMFi90khjJxX9?=
 =?us-ascii?Q?6n1D9WXhbFhe+ZH2hfHS6R0QpIX2d+ChbsSyrfnNp7u4fx0lEeEXC9jbIKkD?=
 =?us-ascii?Q?KH0T30NkrdUg6sGmj6DLg3qXvck2F7M3VPCM3GaxpUS8607WNrZIhVU0KflS?=
 =?us-ascii?Q?4tD5jFc8j7/JaMZLYegcPmy8nqWy9YMihO9vNAnNO/Q2A90hSQ4iAs/XZEOh?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a277bc03-d23b-4dc9-5143-08de1ddfb261
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:26:14.3303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP/wkUbV7ulZ934C2YNaZzb4u3BFrE3U/r4mParAezZgd5ghf2yl3H7EjGJqIu/jJRKyX48pyFuotbhlrYI7zx3O6HHF5YqG+zEB7t/9XLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
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

On Fri, Nov 07, 2025 at 03:43:38PM +0800, Zhichao Zeng wrote:
> The statistics contain 40 bits. The lower 32 bits are read first, followed
> by the upper 8 bits.
> 
> In some cases, after reading the lower 32 bits, a carry occurs from the
> lower bits, which causes the final statistics to be incorrect.
> 
> This commit fixes this issue.
> 
> Fixes: a37bde56314d ("net/ice: support statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> ---

See comments inline below.

/Bruce

>  drivers/net/intel/ice/ice_ethdev.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..be08be0826 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6036,10 +6036,19 @@ ice_stat_update_40(struct ice_hw *hw,
>  		   uint64_t *stat)
>  {
>  	uint64_t new_data;
> +	uint32_t lo, hi, lo2;
>  
> -	new_data = (uint64_t)ICE_READ_REG(hw, loreg);
> -	new_data |= (uint64_t)(ICE_READ_REG(hw, hireg) & ICE_8_BIT_MASK) <<
> -		    ICE_32_BIT_WIDTH;
> +	lo = ICE_READ_REG(hw, loreg);
> +	hi = ICE_READ_REG(hw, hireg);
> +	lo2 = ICE_READ_REG(hw, loreg);
> +
> +	if (lo2 < lo) {
> +		lo = ICE_READ_REG(hw, loreg);
> +		hi = ICE_READ_REG(hw, hireg);
> +	}
> +

While I can't see multiple wrap-arounds occuring, it is theoretically
possible e.g. if a process gets context switched out. Therefore, I think
using a "while" construction would be better. For example:

	uint32_t lo_old, hi, lo;
	do {
		lo_old = ...
		hi = ...
		lo = ...
	} while (lo_old > lo);

> +	new_data = (uint64_t)lo;
> +	new_data |= (uint64_t)(hi & ICE_8_BIT_MASK) << ICE_32_BIT_WIDTH;
>  

Using "lo" rather than "lo2" here means we are returning data we know is
old. We should be returning the second value read. Suggest using something
like what I suggest above, where we make "lo" the second read rather than
the first.

>  	if (!offset_loaded)
>  		*offset = new_data;
> -- 
> 2.34.1
> 
