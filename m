Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DFCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DEF540B8C;
	Mon,  5 Oct 2026 18:46:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A5D86409FA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218809; x=1822754809;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WZKgcGIGf/IFY5v/t7M3JJl6OTPaXZKhR5A1mMH/aU0=;
 b=dGmIhD91Bqlknn8+Uj+8qw1RWamrHEGu2doNZu+XPR3EPO3yIvJA1j9D
 gcVPvOZrcK/7n2eZ4duLEGR+cZ6d+QKRd4mm1vXiRweVZU+h6DoglXE+r
 R7TN+au1ouG55iKWy5B9+dkKQ4K+Fbp914HUgeoxhDUleJuhfZgqU1Xur
 Ax09VPjCvGkhO3pCHRQjFqc/i/OKhFusvKVAHP67xaulnIJrhlJm55sFl
 oXkNc6tysW4r0hsHx7g+6dWSvDkx3kHbmscAeAsB68nLH3TRsW8lr8EcY
 7nC6fNGeDbrzFPkn6zzW4gXcb6oukOyJyG96VDm+/5NVKJ8qFbJkv1IYQ g==;
X-CSE-ConnectionGUID: x72bN0p0SvmxUqit6AE8Ng==
X-CSE-MsgGUID: 9YvwQcH+TNamvIou2XfSGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="45141"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="45141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:46:48 -0700
X-CSE-ConnectionGUID: 5nQ2q4UBRqaHIMjaBuDq2g==
X-CSE-MsgGUID: v+BsJfmzSkeSlvieeAJIbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="280129715"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:46:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:46:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 09:46:47 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 09:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxfCptK170udGl6SxrQ7k5rZ8Unffs5ssPc/qpB316LE9fU/60PDZn6xsuetZts1U2R6mHdIfkthRg7fUxXVvgjTgxlehEmzNyIQ21j6HGTItSE6JHCZ4QAFPy1yC35uIxFJxKsDlkUtEx/Gyc8ZCq9ezANT4rXozuGiLdSf/gj67g6smNWLDmPy+orj39XFVXBkPDy3KSigMjEUcHQzgribkpTOcudDU5Hm3eDYoysVj4hOqeio0Hyy689bdD2alJryyBgNnk63rhYpgVF6CmP681+MV+afDWKbUVerpr0ef8+1Wm/N4JrQt9BakCLQIcy0PJ2WpMfRU6qEptJQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpRqfwZXmBbtw/AqepLk4a3XfoPQuOAwAR+zzfcyrJ8=;
 b=yY2qrAtxQascGxYqc5PDlXySkicsKhc1PODOQfVKeQVx4RNvX0s2kc3tUhmy5/qCsI6ukab0d8knCWAGLKAh3cWkDZkAMaiIcsBWlBNjsfysfhN7mBrlPf9gryGw+s1yyBsKKRpFBbVQVa9pu0tfrqg00t8huDOpU2qtfalKj9T/6x1e7tFOTw++Yy7OrNtlbz6OdVN0emTRQhQc6OceUWCYhyfxU5ARGpDKa1AMjiRWIZwTVTAZzVkVXCXMw4B/1Se8j9bP+bWBVCQGJcBdUojOeebXu1YY4OznzThzz8NHzVRNrZaodYmZnqP1WdQOy+AjM/kIKce2KmCApapcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPFEF62BB3A3.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 16:46:34 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 16:46:34 +0000
Date: Mon, 5 Oct 2026 17:46:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] mailmap: update contributor name
Message-ID: <asPUZfoSm27qG4-y@bricha3-mobl1.ger.corp.intel.com>
References: <20260927035949.36887-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260927035949.36887-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DUZPR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPFEF62BB3A3:EE_
X-MS-Office365-Filtering-Correlation-Id: 712f0420-4c20-4ad9-b5da-08df2300371a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UdM0E2aDggq8VPHy0R1G7uZpF77gxzjs5HPfR7ChOsiXJXCrjGwcf6yF6HP1ExaYcgTGdhEwsEj2FRlTv8Mp5I3nrOhI2KB1NrWQ5+KTd3xWF/RUP4tAZwuldZ2O2sJ2PnReirLaArgtjoJeuFrozcSOwZQZCQivjesKPTTzLSaz5k7y/Iu1zwNzf3A4+Jcet/KAkzK3gRgPUEC3qwThANXWc6bj3kpSQKhOd6glKetXDoNp5pYiPm+jbJlAYddLwmE1t06TXRgSJE4kTSaUFU0Rj27fDmgOfFmWLFoN/o43r9pgAHN3Inr/9jd174vDmC1dLd7AY34eoHXmo2D0OBukRErTPKMylMfIpz/mnAI5uWaXkBoFF+PLzg7QdKscbV2vZACwljWOdT0IJNcgdfzSamstBv7vjpTF7uRaoa/HIsW+Dn9tQVuZ9wIElVc+lxrNLMD6XuxUhM/QS/vZGY2BOfJTy9+9NbDpMYRqphZ4soS7E7Y49RzlA9VooVxBNCGQu469dcKGOCvptWCcm6rm2MvYPOr9KFy72znm1ygSzxiqtgjdvNjUoZ2IO40Y95m/AaXbnARVkREUqoZDSpjU8OCBl/gNxhSOmBYLXab2xI/NUpD0r0M8puv9eDZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUEh3nEnZIFbPNPHfeeXMyGwqaiLGnzCBbQiOtTk+a/jEJuSXaRi4AU9Jc/l?=
 =?us-ascii?Q?dAEj17gh0gdpi3ZLj4hOY7v5uHMuS7PEhWfPjvxw7CS81fF3BXh51h31GqIP?=
 =?us-ascii?Q?WSVoXpj7y5+IHqUtjBgn1OQrN1nnNqLGBI7BNtozo+kivXtM8QcmD2LOYyDH?=
 =?us-ascii?Q?i2l7zG0nDJt4Dk2Q8uvzBHe58aRD06YUjvv/QU6ukERIgEp2Ado4zwvjnRlB?=
 =?us-ascii?Q?UuZNHpzMVay/WtOy2EyxdMgHbwQQ/R+jkaRvSds1Xl6gBEoUNaTwaSgzG/DN?=
 =?us-ascii?Q?v4NgnrIaep7dZZ7KV+BLCSKTZDjj6NBXaPRhd+HZ4qk7Lr355K2gkkP1XDfw?=
 =?us-ascii?Q?EGTZf/Rc9CJGm+N8nw3PKm2ZBsXvMZmx2g24eAOk4Uf2vnuvORXlSJTP3Ysb?=
 =?us-ascii?Q?hEd+h7EcRR/FnX4sykBlohTNfr6pwDBt+aTGc31ogSbs9lD7ikITl3dOB/p1?=
 =?us-ascii?Q?Mmyjq2R1s2jvNWXQF5wBkLX0E9GFSz9lCiT1/GFOz0fFZgz2gidaLO+he1VV?=
 =?us-ascii?Q?GW8+eY/2iBt/F1QKNrmRCJ25mmozpQVEqeGW0o32Hv3u80vI4dUtzyOL+sNT?=
 =?us-ascii?Q?x6V68F4+EtmrJz/eZB/bS7b3R8y+b3+s4gPIon1MWF6p6wHuI9/rHwwovaqr?=
 =?us-ascii?Q?nMgIYMGkE0VHdFsXSqq+165EHOK2IFKLd3hm5npCHPcK0TvyuS52A5dOJsR/?=
 =?us-ascii?Q?fDzAbS4wZmL4dXLlmQnE0PvHVBoGhk4q8qLW+e6iD6BkEv5HHCzHTN3ImRig?=
 =?us-ascii?Q?njvGsMNqaILNHw2P7jW3//ddGM1X3Nk6XsEJQL9ainsVB8xdZcU6oK99Dio5?=
 =?us-ascii?Q?fmZdb+ro/m5VM256EGLbI1jG8O/E7VmL2HW8WZ14Y3vkMxH1saWU6Uztj/Vp?=
 =?us-ascii?Q?LwqRRH8NbynurCNuMZkTGDkwU7okkUs3Y/IUvKP8Qvxyr6gOoZvFkzWSnHL3?=
 =?us-ascii?Q?EdXvs5Wde3HgcDKjqW4buMjW/p1amTeuvD56YTyapPVp65Dkj5R95ztrGzW1?=
 =?us-ascii?Q?b2XrRTce/s7+J7TebCuAHLSd5aT5lN4LPRRbNi4FacxWw1Oj4QtsUh/TL7wU?=
 =?us-ascii?Q?8KXu0kSmZxQbQFBRcxNLxHNNTOw//jFrlmqg+hsY5jIA0xqFXRlQ7eSIpht7?=
 =?us-ascii?Q?8KGRnsa78DIyKvuvKT78HNG0zNZrqlKAqmuDbDETQBFf2GGYPPCY1RGFRtgZ?=
 =?us-ascii?Q?Ub7ogkpHLM4Yf5QPjiWFbUyUHTrWvU11TFwrRYs7uSFUxWznOg+KrDSJ3qPE?=
 =?us-ascii?Q?nj9upYSeuisbqMHjMPmGilJT9ROlghkCDnXeHYjU+kSI6qafIkgTM4mZYSCK?=
 =?us-ascii?Q?72j3W46Gr7DeH0wN8SY0bGEiwjPoUHxC0rlC2ItgIVPuP9QTHU6q1CbU2auj?=
 =?us-ascii?Q?+ipsMSODMWMCLW7yCQj6uwJoHSOI+WaWZ/4jqH/GMD7E4FUDRpkwz8QsSVgT?=
 =?us-ascii?Q?DzSNVgjNlFc2C9tSICMTDFMT//qN0ugv7dgaNHYo+/TxmKdVd4yj2Q4Ly2Wf?=
 =?us-ascii?Q?BFAOmvoqIsX/qT3dZP3hA05h927WvnMTw6EySbGFsLWhN583NHCZhvvNJ47x?=
 =?us-ascii?Q?YrU2W9RQFR97QPoAd+jtNSYAFKkE4RQZ4m/E6xIjQj9u5mK13p/67GUfPlBt?=
 =?us-ascii?Q?izJ2YvIRCjJR69GyTVscEBPGJMxs093jiltibAhVv4/RlQ4/FtaYCRsSkzkU?=
 =?us-ascii?Q?9lJcMaerlJqbl4iZq+/Fe7Sz8QQfQ+ksh1zV/Y6k9PL8sL+WWCywXlmCrjlM?=
 =?us-ascii?Q?+DmsasaiEitiTVm3/J5Bj2x3/JWWkwE=3D?=
X-Exchange-RoutingPolicyChecked: b0emtU3wmRlyre/nRLZKB7k6bBax3n9mWVPIZz4cy0Dadu3YSkkRoVwE95fI5i1JzHiY4FIhIKamD7sWaIG/DvSdbxJBjeXMmCcrsKjqANlq7Fw1+FxA14X8I0VxqDFVvZVx87DWlaVm8KupgKwgp/15BRtLAXb66a9wHzwCNO/I7tUjQ2DV0mPUxpIryJe8U1QOmZOBj8nMz8pnpzQqEJufd9ViMj68WekulUT0xtUGtNkOwABHOx8dl9JAdglLCvZFmOW+IxBT75uwUlpzruA+lo4Z1Vc/abgxFXczvKMZQ4/vNMFvgXFgfujBA//d3XAJQr7BEX0FiCEQPuEpAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 712f0420-4c20-4ad9-b5da-08df2300371a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 16:46:34.4154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh4VlONE9f9/ZUmll8AR6LoHEKM0OVDFe8MLfiCHy8Sy856AD2gDeVORit91HPxynxxXyg/5K+2o+jKcqHaK40qu3lj4+NKWesZRy3jysiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEF62BB3A3
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

On Sun, Sep 27, 2026 at 11:59:49AM +0800, Zhang Tengfei wrote:
> Use "Zhang Tengfei" as the primary name. Both addresses belong to me
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 57f7a9f87a..ee4f80e625 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1680,7 +1680,6 @@ Tarun Singh <tarun.k.singh@intel.com>
>  Tasnim Bashar <tbashar@nvidia.com> <tbashar@mellanox.com>
>  Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
>  Tejasree Kondoj <ktejasree@marvell.com> <kondoj.tejasree@caviumnetworks.com>
> -Tengfei Zhang <zhtfdev@gmail.com> <zypscode@outlook.com>
>  Tero Aho <tero.aho@coriant.com>
>  Tetsuya Mukawa <mtetsuyah@gmail.com> <mukawa@igel.co.jp>
>  Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
> @@ -1981,6 +1980,7 @@ Zaiyu Wang <zaiyuwang@trustnetic.com>
>  Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
>  Zengmo Gao <gaozengmo@jd.com>
>  Zerun Fu <zerun.fu@corigine.com>
> +Zhang Tengfei <zhtfdev@gmail.com> <zypscode@outlook.com>
>  Zhangfei Gao <zhangfei.gao@linaro.org>
>  Zhangkun <zhangk.zhangkun@huawei.com>
>  Zhanibek Bakin <zhanibek.bakin@gmail.com>
> -- 
> 2.53.0
> 
When applying patch [1] to next-net-intel, check-git-log requires this
update to avoid warnings. Therefore I've squashed this change to that
commit onto next-net-intel.

Thanks,
/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20260927045943.58541-1-zhtfdev@gmail.com/
