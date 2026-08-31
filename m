Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A1C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637454025A;
	Mon, 31 Aug 2026 10:02:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 36285400D5;
 Mon, 31 Aug 2026 10:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788163374; x=1819699374;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HTyv61qAUTkGOoacOxbto1vo+QpPP1Z5IqjaXEK+2CY=;
 b=Pp3cOv2Nx5FwT5PB/1sWdaefkDEkjpt2xy/7zamXMVOdRTzQPHtsmrLG
 cfMSzXFH3+nofSqYNvyT+/8s0CT+fszu2bvhOteU4Hula9Aae+GO99EGJ
 HXTF2F5Mpbc6cu5dGrl7lHuG/6bxBjOaBDIqtPL9Nw9oKPe2Mpy7zOB56
 EhcDh0JDrbdvy7gVSL0JdPpydlWt0wkC6NoWBbVPWoDrirgxPASxCIO6i
 w3T3l5PdDoP4dM/SsjMzDSpYo2pHd78LgSBA4vJzsEYZzkD/zj8KCXGff
 Tb1Df8vgovWdy8GZEvyRGDgdOtwcv1+2Zs3Al3Hh4zESG5zygTkGVHgT7 Q==;
X-CSE-ConnectionGUID: /VVYUwnBSXiwtk9EJJwKng==
X-CSE-MsgGUID: Yibw1BfeQPqszML1N+b1iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="111337536"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="111337536"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:02:53 -0700
X-CSE-ConnectionGUID: 2nwj9E2MR2q7VjxJSrBpPA==
X-CSE-MsgGUID: Ri6LLVcPREuWyUNsOIy/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="293539282"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:02:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 01:02:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 01:02:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 01:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDTWA9G/3WvdxS1YLoPR1/xZolIaQvGCtSg/hpt1eQakavrIFVUVt4SB+yck0UWnH9kr3xR7Tl73IOtGAVRxr2uno0JIzGsNn8ooV+fMJP43RopXf8xTg6l4uCYD5oWnKbSFSY4czSoGnPyguUdHJ+2V2Z2Bm+Y7WzuRENgh/2c0F3OAPaxMbop57gnG4dh4qtibNMqAks2eJ7TWZHfoYRKEVLEV5XnUJojov9L2bImdW4yOFsxUY0lk+3ciPKNdXWWNpeb7tSTjPgZvCm8dBmTNonUZvPGAhk2RuLRFY/G9sBrt1QtKRQrUfKHR2DrFpZBxLMktIBhfgOFpgcVt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJeZxxYdH0XBP2da+eRwRPeF8pKs+LMDxcQkkKh0AF4=;
 b=RCiry1IOYlSZ2xulW4/YuGU3j5sqqdzw5PkB5j30qjXvu/gealNsFvI6Ckh9HNIy+8gl0M7ZXukJEePBn7uVrtj8LludlKU67vP+4Rfm2zJhRpSis4NZplgtV36yX2IsFxUFeqXDwYFJdyW6CV+c09bktNa/VUDTvlTy3ybzdHe3xkdpFATFwo9+Yr91DnQGa3HXTgxwtSjPsU1hQ1yvynTPJTrdKc+/qDEmO4IsN9XE7Gq0TQ8r4MsMAdjBPybZNWtb9lVReiOx8eQNkYlnh3pCZ4NOT6FQO9VbVhbvmotXNJXc6tBJeFwVA0KuTZjFttjJpNNOmYBGyIqYg4K/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:02:50 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:02:49 +0000
Date: Mon, 31 Aug 2026 09:02:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yonghao Li <cruselee1@live.cn>
CC: <thomas@monjalon.net>, <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] eal/x86: fix LZCNT CPU feature bit
Message-ID: <apU1JV-ays2oJDgZ@bricha3-mobl1.ger.corp.intel.com>
References: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: DU6P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ0PR11MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: c8231733-9afd-4b3d-b6ab-08df07364038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9g5DKaRvgKeNTom5mXxVQfsL/ElLK+eOqtponUp4kHDF6pOMN6kr506MGUWZqC53vf52KTcp1N86hey0YXD+5xX0ADM2SBCY1PSAdd2pUv7rX0Rk0e7JxN3PV4dZr3a5KjwVoRfhnhGaRjLvcgl/dK1lPjpiauibTGcNzvXSs5XxPbAYoPDsFxp7drao/imb2CZfLM13Hy8PC+dWepRddeIclqqNfIy32IaX0VTpPey85lnFXd5aUqiNl/h4OsOib2nUyHqPF3Im7KJ+Khmp9XVXjMr+tWSyOXqFu5PMT/VG0JCtfvX4Pzp3+YONkz5vKqCj3DJsdBX9I1hr3e71Cj3wnvOQtIyypbEkTTv7ToIesOz4TCvDIKAYuPQ+D0OESmZlSuvsLASAjrsT20GDRqaWLzWlvmstLZaRfuZq4rys3gRj+deHUBBL+sIBpxb0xgk/9B4X0p+bWK+8gClF30Fg9hESAt4DrR+SPA+KSKu3qLaalmEyrbSXxJfIGtorR9GgVMwQzzTEGDVfF1Uwr2y4IFpbsSmXTK77a5HaEpl05tIREbj7y1/TTriQNi+RHaLaVckHuPavFH0qWkSz4PMbi4P5jeldglhYqUslXoAgBHPUUdGImazNRuWe8xOyCy6MkhdA8OeMCgk2ccU+GkUl3RdRfbTEfO1Wae7in1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fsf7P11CTBKnffOhUz0D629QIEnfP7wQGexAfKi69mIVbYBOPNVjYDRZ5BSl?=
 =?us-ascii?Q?Pzn+FcFHi/PUmp3ItMuSprdOvQylj+EtCoIc3DRS1MlfQTNxsRBY2Kj4B2ff?=
 =?us-ascii?Q?zeDdNVBWvwyFSzDDj7h8DQKJteXHCkjh6LEMcx0Lwby+SDTZ0qbF5jlRUG9L?=
 =?us-ascii?Q?7UIZ5U0CiAAqm+pNAlnZk4U0gbz9yrEWC7laStMZrzPW50+RVNOtyWrb1xrV?=
 =?us-ascii?Q?YOpT10bms6IrUdOE9cXhnQtA+N9m3DbGD7Y4WjWjyYIggR6P2FbCw+QefvvN?=
 =?us-ascii?Q?fJkhU5JoIsn3wi4j4yDgqRA3HjZs5kF2/EoTrujRDvd4qOjV3eTVtoanFSgh?=
 =?us-ascii?Q?Z9OUnfQZR79kLBrctLSpd+mW1eXN2FvGU8j1rFSK0YgMAe6Ka1TkgUJuFG+f?=
 =?us-ascii?Q?HloEWpyZtfq9QcFNRMCIGWmuEKIwNsiex4eYHo86hihC3Z8DN2hoAKraE1Xl?=
 =?us-ascii?Q?E7urmJDi0Sgm8cES9EEZL7Tb7VXaQqE/Cd+kGdUwV7TLACG9/8D1lmwefDjA?=
 =?us-ascii?Q?ldPh2ZB+5qeJLhpTjZ4CJ8EJfeJ5k+uIiXpcmTi1jIgEDZ+GWDa73orZ3oYz?=
 =?us-ascii?Q?uG8PO4bZKSSFCpLC5xSXMjdSSr5m/nFpYWSoDuj5SMvBhuo1iKSs29vmmeSy?=
 =?us-ascii?Q?/wriC0OAjJKrYiGPx5qGiOptNKF7N3UJ6/GRwHm1IqHj64VKCNi5k/B6Vev3?=
 =?us-ascii?Q?YMYQq/d4sDNyi+BOKWg7OT4aMcbtGzK/axnZWj/URmWQAifPkXszPdiqWbsH?=
 =?us-ascii?Q?+jqlE4X+8Dqy9om4d8dh3ZdU/Q7+zrpO0Lm6TOAMSlfwwRtXisBovMEivTHH?=
 =?us-ascii?Q?qq/huHCkJhBUMYe1jtxKxjmvU9kljBcOT66SO2YgcgJNUzHsyAoSET1VIgTX?=
 =?us-ascii?Q?oKGKxKV/0lbI8Fwmp1KpiYiasS2bcsproLc0LvqDf/HMY/yRut9pagJjrJiB?=
 =?us-ascii?Q?BDknN2L5Ot+iI275BF1OPWBtOyG9B3eFsoPkPYarzbZDIOIeZtAv/VWAAwAx?=
 =?us-ascii?Q?58s3xjqoVYEfo2zMDWPZ2vc65be+TRNp4tuEl3yWSbuHCnHFyQCDKX1TZWA6?=
 =?us-ascii?Q?fpR2xixGrIsfwgYIttXZOfbbk9DCtZ067GEEwcWzhrByt74laW5UYMsgE/JM?=
 =?us-ascii?Q?cNns8yGJI1O4Oj2BpJgCgd66sFAQIPQDrfZXC17jfp/eLFWK3B9z1ZHI3Yq0?=
 =?us-ascii?Q?PrB0QKnOK8NN+iSIoYrnO5X9X0lh2mnDsXoOtQsZvxZbwBNXiWFVDDDgacnb?=
 =?us-ascii?Q?qboWEahQt2viCwqz0P2dfqiyldhGzWeg8KqveC3bS43gD8OEu0wI30LtX1dH?=
 =?us-ascii?Q?qX24UJZoJ07nm8LZjxDW976PRC1yXiZ+UPbBNhQXxKLDKAiBane4A6c1l7cw?=
 =?us-ascii?Q?Y3jJMBh1S2NjHivbuet0I6MNsxGj+d9Sg2eOrO4KJhUbtF8V/srPyOsv7fBy?=
 =?us-ascii?Q?HTPasrZt/ZZcmSxalSrHT8UizlomhV5ce9Rh6GWZ3BWbPrghBHPPPgA/OBEs?=
 =?us-ascii?Q?v/lDfBUhOYgihe4pb8/VX+Jv3P0gYVbYa3nxkuRK1LmR48w1v0MiwcALniyW?=
 =?us-ascii?Q?U9QG0iCJnpsVgnariySPiB0YIjQQ/B8lyBYpn5bqgIy9fJ813jexEttGW/OD?=
 =?us-ascii?Q?dxIZfxiJPtObDYBGPMnnJrFg6NpudgOHazpTkDn+8h73DqoUzj8C9TcFweRl?=
 =?us-ascii?Q?GykhQ8TZNqwxp5I7dDhKBrZUmwUwUq6b7LPCkRLzXShX86h/mXFOFZ4AEjbk?=
 =?us-ascii?Q?DBRglcye6i+YdeLgOpXoBz691f2qVp0=3D?=
X-Exchange-RoutingPolicyChecked: d/iov+NkfbeVfifWHdGVi8824R7E7GO2FtTCIt+EiU3rOdugsHLEir4aJeg5/TMGLzSr6vlCEzqThDVCDa+nVqjshK5TNcd2G+nfqojgEZ8TXns+wefI+LWR7MEga9Qp9QNuq3o+lJf+9mDWBYq5fqQXCyxZaOfgRFQxBucJMvBv+R485tqe50EM4WxAkwsA+IlO0FBje+GwmF9iGRMm3awPmc+9JZihClCBmt+/7QtHZxw1PigDMKC0f8LiEfP7MpJMwHMBVkdNT/rFx2xrme8BK2+WKVifkPAYGy2D0UJBmyaVdyoWVjMH+dfxtFnxmFxfPyGsumNb6PE3Z2eoZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8231733-9afd-4b3d-b6ab-08df07364038
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:02:49.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M05RRSh6y+Po9s46Jdl1ngGErIuvbMGPAYADupD/hEyoS4HWkeeYqCnmNDkJIc/g+Na836NfNGHYpjYN9ONUft0ZpCEu1/8SXeFvQgL3Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
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

On Fri, Aug 28, 2026 at 09:32:52PM +0100, Yonghao Li wrote:
> LZCNT support is enumerated by CPUID.80000001H:ECX[5]. The current
> definition checks ECX bit 4, which identifies CR8 legacy mode on AMD
> processors and is reserved on Intel processors. As a result,
> RTE_CPUFLAG_LZCNT can be reported incorrectly.
> 
> Check ECX bit 5 instead.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> Signed-off-by: Yonghao Li <cruselee1@live.cn>
> ---
>  .mailmap                   | 1 +
>  lib/eal/x86/rte_cpuflags.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..fad671fbe9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1933,6 +1933,7 @@ Yong Wang <wang.yong19@zte.com.cn> <yongwang@vmware.com>
>  Yong Xu <yong.xu@corigine.com>
>  Yong Zhang <zhang.yong25@zte.com.cn>
>  Yongfeng Wang <mannywang@tencent.com>
> +Yonghao Li <cruselee1@live.cn>
>  Yongji Xie <xieyongji@baidu.com>
>  Yongjie Gu <yongjiex.gu@intel.com>
>  Yongping Zhang <yongping.zhang@broadcom.com>
> diff --git a/lib/eal/x86/rte_cpuflags.c b/lib/eal/x86/rte_cpuflags.c
> index 5d1f352e04..80b71a3ce0 100644
> --- a/lib/eal/x86/rte_cpuflags.c
> +++ b/lib/eal/x86/rte_cpuflags.c
> @@ -137,7 +137,7 @@ struct feature_entry rte_cpu_feature_table[] = {
>  	FEAT_DEF(AVX512VP2INTERSECT, 0x00000007, 0, RTE_REG_EDX,  8)
>  
>  	FEAT_DEF(LAHF_SAHF, 0x80000001, 0, RTE_REG_ECX,  0)
> -	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  4)
> +	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  5)
>  	FEAT_DEF(MONITORX, 0x80000001, 0, RTE_REG_ECX,  29)
>  

Confirmed by checking Table 21-90 in the Intel SDM Vol 1 docs. Thanks for
catching this.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

