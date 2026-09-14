Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49EC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAB1140272;
	Mon, 14 Sep 2026 13:18:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0D5FF40144;
 Mon, 14 Sep 2026 13:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789384701; x=1820920701;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RaxGTNylBISgtHfrGSOYlNhfEfoX+alU55ssUHv5qh8=;
 b=ZwP092cD+m4bvjg8w7ZF+FqVlL2V0YCVYjHZT/X4xsOrZQsWDLlkmN40
 bi68JGETnTnzTdEULnNXu3AzrnY1isatNWpz2l74fKRpL7zx4bM/76tVM
 8U7h/fRP6I0AMu1c+tDgF6671TpYS0IVPLfvFRI4ODqUna6Ix1UxDH9ys
 9MEG9sWYCDWAHQDaCZZ1mAoB5e+QIq3KS1j+pnTcYSqWgV8R9CgHaH0Fk
 zDE8bIucuC1If96sQeyhEqXPZXJJuag4iVTTr+lBmhxCbgv3ct4o243Pj
 M5ceDuogdnwXjU+PR/Gu3WUs+i/SHdR6/T5tSQ8dzAj5rAQz6QtL4r1Z6 g==;
X-CSE-ConnectionGUID: P3lZeO47SnmZxroRIekPxA==
X-CSE-MsgGUID: hKAMHPBZR+mA/ssGgdRstA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="101085275"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="101085275"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:18:20 -0700
X-CSE-ConnectionGUID: UrHZYVHWQBaFeTWUrjhi4A==
X-CSE-MsgGUID: BnOilfDiRuaGkUYr17fRrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="270810031"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 04:18:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:18:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 04:18:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 04:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NllTt3h8hvTF7lza1XBoeP34tyIC/HFcLY2r8AoXjBmdVdVSVhoNqRmwof4+JYy8GMx5we/MVizIzcX2NsxUHBKDGc2Yzy/wqA6PvoItYLRevRpS9S8m85NEhtwthWoJqkjpKWKpiEka1i4uQS2yxRyMyE/3Z1nP3Q+/VHHTsKrrAjjovo5Cv+Xlw22oZ7GxeJ7qQFDZx95i//cjAqAGQE3OmxKSRsCZfqDjqVL8O0GmzE4D5d6W9BmBN8kUFqbMrrKaacL7dn/plDxCMWADqoqH5YhUKCG8XP3qLssBYX9EsGzLxQDE02m6dvum37bGCymc26gbmKMHy4WxCL/obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDZR2iXXUqeCQJNDZnsUqphOrPk7KxEQuEHVUAXr1CY=;
 b=ezYaX3IypKv6yqMcgKjO4qANBtU3jac/anKN7FvpG5iQUMWbplN8w76RaoHxSDEsgAZjPJ6w5V/hwKNBbO0L7Ynuf/CBu51XCatvvCCtd94zFL5An4Un256PPOUyUxo0LSWbSBWxOdrYEVpy33fY8R7uYnUazC0cuOuE0d/60GuL0Ru+ZBMvUORE9smw/LJOd5o6mGF6Biy/WAJaduNOjrSXTVRoTgIP1wsByENAyYzgg0aJch8uBT67JV40rnQqmSmwWeZatleyRqYESUnkYDIoE1SChWjqVkIaqHy3gB+pn4VDhtwzQCYCXqrFZI6ERAbRG3IUWse0Hu2mvBjmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV0PR11MB9864.namprd11.prod.outlook.com (2603:10b6:408:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:18:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:18:16 +0000
Date: Mon, 14 Sep 2026 12:18:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Artem Novikov <naa@amicon.ru>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <rrv@amicon.ru>,
 <lvc-project@linuxtesting.org>, <ting.xu@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: remove unreachable DCF scheduler branch
Message-ID: <aqfX8267lXdvGhXd@bricha3-mobl1.ger.corp.intel.com>
References: <20260914100350.53842-1-naa@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914100350.53842-1-naa@amicon.ru>
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV0PR11MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 51480856-d177-4a3b-3d32-08df1251dfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: Wz81Zi6TGGqANo9HWPgvrymEOELPQIuFnnI4ZVqCEnzLnY7aQY5CuyTH2oZp0CMtbwK+ijxITtTRLAD3Y4jtC80SFCgm6TYUTy2D9jMqHw3VFa/Ueq346kSnVXmpQTPDY6w4lwjuuYvhfShlK9PT7NLFqMQgI3EaeH2Aqs/qkbiiGTImOxauyZnJJETlDGcVJJP0pDhFTxPxCmAT+q3/AbAnClV/znDo2S+wwrBtTxJzAmeMS3BsfKe9cbP0LRz7+YgCWZHvlye9Es7v80swJlHYkiljC48LnflnPSo0IZblGHismEY9PPGoHz7sTs1tNb94QcEZutatS2kzYF50FBNUDs5YyW9l+yj4ggYFsk3B2DJXm70FiDDPNQ2L6OzU5HS/kuZ7vHPPSG2BPIZLYe/JxKt6+ItHuxGE9Bi0GlDcIiCVkLf0uMBdhTRr6t3jYNqPTZv5aydIgvCcR30O4bat97GSV4l7xgJQfuZkDtj8lMRmjzhyeaZFEM3RHz7uc4m+KDM5hyZIfiizn0lk720ae+Bw2d4Gw8IHe/BzhRUIqVS1+f99IGznVrPTCADhTUQmloPbO2xRaGlOds/PBQpgCm0c9GMyjknIfaBTloUqf1iGjyJdHl7Z8MMB9mAPFC6ynp9PppWTcQGkTR8lF/CAQwv5CFLRpEUCmUpWNbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwOr+ZeynWT6Xug7ZmpLLUQDwWAXDzoXteW0dzjD+FUx1ssI9j0tOrswIVuB?=
 =?us-ascii?Q?deGFcFROVBqYChSBuzc8kYp5DebXUuqlOLj6x99Xcuvgwjy0ejgtSHqIByhI?=
 =?us-ascii?Q?6onMMPcZRjlriOK+rvdXh+Y0y0iFesZmpVBnal4XFHh5SjmSHu5FX8XnzJtS?=
 =?us-ascii?Q?2eVU0V+0M96fiV+3VBmzNnVrJRhT0UO0YwS4jUgcO2Q3SSVGf534pn9l7P4M?=
 =?us-ascii?Q?LS8U81aqd1ExGUSjgADHP4Et8djzCDrnDZTbHtSjXrbj50T+3BOd5v1SuaKg?=
 =?us-ascii?Q?RCr0EuL5u3W4jR4lzbV53M9dKKiogPHZluXcHRKRJ3x7WeLpOWi4kIcKGVBq?=
 =?us-ascii?Q?9GsGyQmXFkZcZHv7sMNRajtiDwApiHHyg4bO/gKnA2hId0uBAyfXGo1vEGTS?=
 =?us-ascii?Q?5Y6OZZfR2vVBnuGfheDp/whgwjRSGmCit0ilqrigIWL1hkagWba1v6cfpxr+?=
 =?us-ascii?Q?9NOi+TJWoFAhR94y/WcBKZTUspxjfj0qUXyrzFjTfGOcXcLo69bVYvhEH24M?=
 =?us-ascii?Q?/GSGxrDj2BxQgasXBqLqsjsrz5mWrhKMhIg3l6k4lLRUqDwild0NSp19tUIx?=
 =?us-ascii?Q?l4CcrqiAsgXG8fuS55ewkJ49RlKgKuJ2zoBrNtQb9A6A43Z5wVF3c/kptILk?=
 =?us-ascii?Q?oANfbpOGHwHwLwL5F3LHfRaG0A6YM4K47aKOp/ig01O5va6yoKi4hCtNPnWh?=
 =?us-ascii?Q?PHpRhr/Wai6BTq+R8UOpq7TfRsT4tunDPUmylS7rO632MJfkhJcCmE8DC1zy?=
 =?us-ascii?Q?NQA9RL9LqZWtmjaRGxvg09RzSub08X+pbUw+k7xNZsEo3oaxXaxprv7fqVRg?=
 =?us-ascii?Q?SIp0SE0N/1zC8UexNhPEVThZNzywK3zy+derdU0Z2eX/OjVenB4BuzhEZYE1?=
 =?us-ascii?Q?aOLMW2lJCAxi0978sYVcPUpv+8WV4/QqROOC8EmQIKCCYCVO2TGhh0JSYNM0?=
 =?us-ascii?Q?5VXZZQuyZ3UWZCAoVIEUXyHsgqD2BYiam/FZachbbHbrmYGyzSfiCQUrOqvv?=
 =?us-ascii?Q?Y+dQBFY3785vS7mQtX3qFanHDdqYjpnz5t/8rtG1jvZpKGP/NEsP3cqidT81?=
 =?us-ascii?Q?y8F3/hhoRmg4OAEZM/RBTRRk+qROIJuAXq6t2PY4M7v1Exd5b8tx5GJ/IcPg?=
 =?us-ascii?Q?FWnKFefYliuf4oB9BaAEavwhfu12ZElW3MknF7gPfUn+VejrCQGD2LnwanHd?=
 =?us-ascii?Q?xfFece96A8rg4+xbL6bJ4V1nqkwZs/hpNq3xe3SqKaLVJ4dlGm1y5QAhaZb1?=
 =?us-ascii?Q?xLjSFdSPBT7fE5QZ8fFkUknhE/aBrlckKv+MsSNmA8cuEIzK1yRx6kKDCUtQ?=
 =?us-ascii?Q?7o92IAjT+QO5VNigekeWMnhYSmLTAVIWLJTvoKAjMcrWauQ0/8z1cw+kBoRM?=
 =?us-ascii?Q?SnPVENYRBvl3R0Hoht8ShC1FYrIjJe1cmC/T0tkg5EUnZ02p0vJ0Wz+UQR35?=
 =?us-ascii?Q?OSGUrudiBuV/1PWkd6JKeC5YlA9i1fxYHmxZ/zMMvbC6kzVXP22O3THNyXuo?=
 =?us-ascii?Q?Qu+JZnUUrXy3nBJdW1zqT7tel93pjcOApMeSBPVGXjI+yKeiaeIplTgwySNV?=
 =?us-ascii?Q?/y1QHrZPnQXQz0N8XOsW5HLnQZKHvACqTpPsB8f1iBuYqL6HBpC1IN+Dg3Wx?=
 =?us-ascii?Q?SXi6LYV4SjVw+ZGWgJj9yBv0Gb0zBdIqxhd5wKoALL/EEGI8rPkTmx7QiIVs?=
 =?us-ascii?Q?70rxnpyMCnwodhiJMHQKtOAPm/wGduPFSxHb/ZLZsRzj7Y8Ikw38PVkTFYmc?=
 =?us-ascii?Q?22DuGooq81+q/6L+YmBY6fVXjKPKvwk=3D?=
X-Exchange-RoutingPolicyChecked: dSjCbHLzrvu460SDhYqFpqglT3vHSopsP1ePzcyPZr7rJ0G9haYE4Xt1hjnFurQdgkVGx8V7rDldVFzRaMRtWj8ND+ZCX90UoGgALVW4Mp+PcemU2LDf0D0QvuEGQPaWQKc9TcpwVKAm2/tje45qgz5LlBeXuaQqRUmaL+gv/5laabFESSgmGzQmZKKt0Ebbi9u9p+gk3sPCdwb+TC1l4ki5JfvR47fuvrkj0v8hnrJVY3Ku41uSKrm5bINS4/ndM0K9Idy971krrbSjXnOTZkWlNic24fusXWPH5Y3Pi6ll3DeHuv3JQhE8LYQs9tmymGYArHb5/jiLgUZWVLhyPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51480856-d177-4a3b-3d32-08df1251dfb3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:18:16.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0kxLQdfD3xH9WP9S3ydqRcTmy5u1F602l8ru0Af51uIxTxf8b639s+QWo/r4OhXFPJ48E00tnC44ricqSkd2MqLKzAteTSs/ojuCrgnabY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9864
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

On Mon, Sep 14, 2026 at 01:03:50PM +0300, Artem Novikov wrote:
> Non-leaf node validation rejects any non-NULL WFQ weight mode before
> checking the SP priority count. Therefore the later else-if branch
> cannot be reached, because wfq_weight_mode is guaranteed to be NULL at
> that point.
> 
> Remove the dead branch to avoid keeping an impossible validation path in
> the DCF scheduler parameter checks.
> 
> Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
> Cc: stable@dpdk.org
> Cc: ting.xu@intel.com
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/ice/ice_dcf_sched.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> index 795b6e683d..5895407331 100644
> --- a/drivers/net/intel/ice/ice_dcf_sched.c
> +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> @@ -188,12 +188,6 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
>  				RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SP_PRIORITIES;
>  			error->message = "SP priority not supported";
>  			return -EINVAL;
> -		} else if (params->nonleaf.wfq_weight_mode &&
> -			   !(*params->nonleaf.wfq_weight_mode)) {
> -			error->type =
> -				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
> -			error->message = "WFP should be byte mode";
> -			return -EINVAL;
>  		}
>  
>  		return 0;
> -- 
> 2.43.0
> 
