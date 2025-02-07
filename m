Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A355C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 772B942DDC;
	Fri,  7 Feb 2025 16:08:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E041842DC1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738940930; x=1770476930;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IcnotB9iThFXdM2Ju/LUemrLQPNCh7moHwrovi6vR8Q=;
 b=I9Ouy9T7ztqFwr48g5gnIxbpJP3PA13+ERj6NpJn2cGoun/VxauT4obY
 lNKLr88fR7PaqDo0Q+OWbgdzK+DVjUq7tHcAtYsfKDLdO7x4jewaou9ef
 lYO4T4E3g9p8PeFCSh9JAn2AlvkRlTeZJsjG5UXjvvEsMkLWLP1QS5ygP
 o02bW6ZuMtPkG5/vDAgbJZ9b1CPp2Tt5ro63QCvSdUjin4zmVNQYnmWB3
 G8DybO2IuzubNrdRvTIixIbw/Y7PjAC9ZT0VvV17on90hiAhIUvimcNS1
 RXw5MoAPFY0/RFsok0jZ1bic8BhMwsb73FWGTt4aPBjpEHgw/n4DP7CFW w==;
X-CSE-ConnectionGUID: C2p3BHPsRA6vBUOqgud4Yw==
X-CSE-MsgGUID: xsvZmAiCQOK2hcXaFzlB/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39699094"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39699094"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 07:08:48 -0800
X-CSE-ConnectionGUID: w6Y3czKTSpOXTaw2oDCPyg==
X-CSE-MsgGUID: nb/L9N69ROGH/6//4IPLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116155963"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 07:08:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:08:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:08:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:08:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjkwzClP0VTdaLNE3zLeD8AA/IrCQHAOgEnbaWlvZlI+KVGYGoxRqIFNBzYeSoElAWyjOnFYH0BxIfbcwes4xv3uTmukLnSsMow/3KyNDwLu72NgPk3mjt0ghymc/6xsCeVLgiDn4IpAmN1Q0VdLO9cURqlZlp+XE9LC9XhiVs/0lvOuMxAdVfGZioo9S2NIvr1o/7uG1TMgQh5tNEFkGJHz7yscspisfj507eTav7LVh89xktHW4MdAo+k+1IK6zcoXgTGVusF8Q6V6K6JJvxDs2MKoZQzBSGa7J6naS/XAo9zo7qrCjboB2VuDkSP5Fne+txmNyDlDrp8Nx6W0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpPFaIehdMu3ovd/qHSSS/vOK/am6QMwrPz93K4Fwnw=;
 b=lBxFf3aMCGFJvoU2PGBfl2ShHjKT7YSWiEQ8p+1YQF9O66vSvobkIsUlf+c2olK7pM/PiNBvHkW6g7dfr8FyShQHCzcF7AD6rPafITi4/0aO65yD9mlGq6joAV5RGbL4IR3nX21FkkiA+LWvgZ52fQNi/exITePLTHufSHwkOkOy7X3gTmOGeGSvUySExFiYPw1GEhDY4qYlOO+2EON8RgZ6uqZdUg+wlC0/hHyh9kQTHBoRktyebCwVIUNm4DWvCqDKevJr+q9fP3QW/gBT5M3CX0xKyPj4j1X6hpi4rUw23ri5ts5UpmOWbONo4ZYveVo6491ytH9EEJDhEun1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 15:08:43 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:08:43 +0000
Date: Fri, 7 Feb 2025 15:08:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v6] eal: define __SIZEOF_LONG__ when using MSVC
Message-ID: <Z6Yh91qsKOsB43Bn@bricha3-mobl1.ger.corp.intel.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0209.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::34) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CH3PR11MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e94b5f-7184-4852-3bd3-08dd47894fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5AMQU7/g2FI3VQNOQVLgW8DLokZvFH3UTx4DK5LB+UgN4ok+3QcjitbX7oWs?=
 =?us-ascii?Q?AYQNUl+euQzUcdx7+4X8uYL7c90VcAyomeGs9GvBkxw1xTUgMprFSVr2IsFN?=
 =?us-ascii?Q?org3GvOhjZJ8IZ/U7rGm9zo762vOFemQs4Fk8ZJitfaWMIQrXCmuQZ0Qt3o9?=
 =?us-ascii?Q?yPLxI6ybryIPHuKz4++mD2TSHwm7GGC0hWEIsdyKWdoJrSlnXG2oqGFCmCQ5?=
 =?us-ascii?Q?aJtJl8Px29eq8OoBY3zBc3tmCmnMEkOG0K+YMscdspB51gbRD8TKbaf42Tkp?=
 =?us-ascii?Q?LMUnkAVeK/JWUY8t3b8fe6QQsnFgKJoBLYDOqD8RG4laHg6qs7r1GRMBEL1V?=
 =?us-ascii?Q?T6x1dKL6KIJ7qVuweD9KInRxUHfeUkZm6YW+y2Mwb4A8l0viqjePU7Wiv7Rx?=
 =?us-ascii?Q?xy0fyawBnZYvenfbCXwnU6CGTKutAE3Ctx+kjhCDQxaukbMOKjJhOHy+qjrO?=
 =?us-ascii?Q?5BeWWoRh7ibWa2PvdmzejBAxMP+HRP7YbaJR4Apggq8rxhkaPbfDZ+EGQI53?=
 =?us-ascii?Q?/dSBqyhkrk0opr8d6pkPo0FLtsg7zpmo7TlNrglEAo7LZOJTf8Gi47mRgc5P?=
 =?us-ascii?Q?WODUa3l3pjScUvtdDQV8FdSDywIHKOkVcbltlykPA/Tv6E4DbmnlfqlDXne9?=
 =?us-ascii?Q?KL7c/GcUwfRcVtrrMSaRc3vOWz1QVoT03L/LkzfVvqWGBwTPUn9FKAyWFvP6?=
 =?us-ascii?Q?kfPNx/xhaZptdXRvGc5Gku9BtmJGaCsUmbJZryyrF/d+dHPp2shNqj+VWxEv?=
 =?us-ascii?Q?csDCc1Sap18J+C/cUjnm+sLCp7XCZgKasjPi/kn97KrZTUXKVwQPbJ1yBuAz?=
 =?us-ascii?Q?qA5GT/H7eN93c7yR42Y+xwltQkHoymO+bNsEMA7hTvxTqry+J0YPxWOSVReh?=
 =?us-ascii?Q?Ss+sv96h3dzvfWMOdidI7TssBuhPSHsfIFS7r+ZZ2eLIQBizZNxOwQgGqRJ5?=
 =?us-ascii?Q?25EowLzaGTpXAexhp+N26Ko9vU/G9z6/8rNDiFlpGKIOC+b3Qa7UtNUu+8Fr?=
 =?us-ascii?Q?ZHsQCAf0AQDE1T6LUPo+dXK71Ee44KaWWXUMByVjJaHPRRpZpduZh4UqWfTv?=
 =?us-ascii?Q?ZyuYrGHGXQGarg9Av5S2h+z8infwog0Q6etaB/1jPyI6mFLeXL1vbuzmVSXy?=
 =?us-ascii?Q?s+6ACi8iUjlUDgDHaSBojH76HATpZ4SWRxNYgJPHm4JdcWx4Lyqi/B1kPvw/?=
 =?us-ascii?Q?uPGkP65s0cJ4YfGPy7olg6fTU1HjCvebFrWvucBEcGEtMA/eyxTVO+w8l+Ra?=
 =?us-ascii?Q?q0iLQw+6fNsAUTb9yXI8SN8U61O1H7UuAB1f2gaA62/ycK01eWw5r/bO5XHx?=
 =?us-ascii?Q?lrrCyvkW01cetoB1x0DBo+JWWnpgxfKrDkrezLPsiQBY7WUTyr75bY+TBSsl?=
 =?us-ascii?Q?kHBmr9u89HEmPgKteOiIejYFXMN1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xjcHsRSUS7t+aJNAODRdRTAgd7GyAYgUsOafxpwufQuW2l+T9kgdcpxDBeq?=
 =?us-ascii?Q?h4VVegIpT7rbTnnmzrDXo9ZehsR0UnICw0QfOgKy0DMWddHoZHwBphmvzNiW?=
 =?us-ascii?Q?E1k4GZ+3MdwGzD2DywRTKO+UkUoTTuaEwB0rH4Kbi92G8Ea6uv41/R1p9n9t?=
 =?us-ascii?Q?64ptIB1i6Fa+QQz9kG7mKWR7ycljRdU6+3NgrQ6tUkMfjbQ8Zv8RmJGOYuec?=
 =?us-ascii?Q?nE+ymufpXLUi8+rNTo+UqRHokRoVEw3IAVWvA+Ag/a17/uIOLx4Xl0iXIEuW?=
 =?us-ascii?Q?nu5Ef08F7dB5msJ7vVEvk466iMV5iBo/yNNubRSmNdbc2N/nXiqlROPv7Y8P?=
 =?us-ascii?Q?hgef2InqpJZj0cEc2uS7wZOVwLnBKOCjWN17VV8Nve5x0cb48zApZsWfaL+i?=
 =?us-ascii?Q?4ci2h8qeQSxDJ5A8qcpAotulVyf1rJ7CxsFx3WA7f1W8+uH3tMia7x77f4Tu?=
 =?us-ascii?Q?1nH7oft255qLQy9dbDmM2xy4DYvxZhGdaDGW9KBvwsBnjr4tV+fyC52bl0sO?=
 =?us-ascii?Q?486d3wRTydWnV4fu6o9HZPraMyD/bW9+zPYwtzH8Ak8ZsFeqV697OUujeZBz?=
 =?us-ascii?Q?zUkSNJ6GgkZmfZ/yz2W1qUDgDoOMixk8s9pHs+knJy1LT1S8TbMBeQw1uJgs?=
 =?us-ascii?Q?KU6U99WHXeOJuTOsJ1e1n+UNrUHopiybECeYcaOx1AQuo6xhilkBKZVmnu0f?=
 =?us-ascii?Q?ve55LRu52Oc/puCMHbrnl0AQ+n/ZYq/Xh3BoElSrJlrnoWwIDl9vCeYe5kx/?=
 =?us-ascii?Q?k4bNzfSMWYrQFQ4JpO61ppoZiR65s73ymSVWysHcKgVRN/nUw43U3WfQAO+g?=
 =?us-ascii?Q?Uo95E9UXITapaMPOMHzCNVT4FtIaRU7B81TT0CVclyTv6zvuTk1ojzhiBKZZ?=
 =?us-ascii?Q?4JYagLs4zRnWr+UuQJHbIpuf5NG394I/XNYdBVwO0dGSby6DYp/JSvaZTAM8?=
 =?us-ascii?Q?AYyARWOYCQSRUty8tfEjdKDqidmS6w568NxBWUufvmEtfj6gQrwx3ISfZXrE?=
 =?us-ascii?Q?eFU4oL57CjhqnvlQL6pVNZBzsk0QsaY2itVFydb09HowlGF4IZlubKu7GdRd?=
 =?us-ascii?Q?mLllPwJg4JHy3wmyLzOFD3zTzru3nAqnP1ZixQqchGBTwhzz8b8jw2dDmW43?=
 =?us-ascii?Q?At8yy1uZdFvfV/Cwd1UhLOwBDcu8zzJk4W39blz52IyA8h9AixAJgLQ9O1xp?=
 =?us-ascii?Q?+nbUPcVPKYMkYY+Yerk2q5wNdZ6JjyjzSoIcBOPErtbJwYeLq3hSuzFGJtnx?=
 =?us-ascii?Q?Prr4lmbw3e1VHGZ9bZy7M/YEy+V1UbHGxuUkBeByuDaROvLg5Akr3CbY6cU9?=
 =?us-ascii?Q?vpgBpc7Hr4OUHoDnoY4+lcVUdg3c72rLGTpEP+H7eb9UsMGXPjywlfpC3aeg?=
 =?us-ascii?Q?PM3IO5hCM2g4xCYI96q111rIMzk6VkJaI8NV+UbWnlbyd/QZgyWOzP6QSmT9?=
 =?us-ascii?Q?5CQsrbdQANR10UcDj5VMR34SiIlo83GnyMJr+f1YnxLhN16adKRAL5RNH2dt?=
 =?us-ascii?Q?aoN9wlFATpcHxR44pxkI50qljmWSk5yanAuFlK1YnQb1BAtHXkBadk2VIoN4?=
 =?us-ascii?Q?6kVUEI5XypDJLkwygCq9L/4rqAGKkuTM5rTfMLX0Lqclt7j8U4xDrr67PzpM?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e94b5f-7184-4852-3bd3-08dd47894fc8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:08:43.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSaQb7MgV6m4WyuT6t8RpUtzpEvSyJOCoOnGU7UnnTBgBDxx7sPQn0kdwhhVlik3aM+q1Fp/A3cArDIXq8e7v/Chs4NMs0/A/F03Ya9QUCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
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

On Fri, Feb 07, 2025 at 07:04:28AM -0800, Andre Muezerie wrote:
> Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> Therefore the errors below are seen with MSVC:
> 
> ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
>     case expression not constant
> 
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
>     '__SIZEOF_LONG__': undeclared identifier
> ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
>     case expression not constant
> 
> The fix is to define __SIZEOF_LONG__ in a common header when
> MSVC is used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/windows/include/rte_os.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

