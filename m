Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE004CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D40F04025F;
	Fri, 26 Jun 2026 11:09:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 92B7E400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782464944; x=1814000944;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KjhNV/+pDW+xFhY30bwq5EwV2zb+Dcmud2Di/ohMMm0=;
 b=cHuz+WTaYeW/7gkJsNQd1Wt6mCkYnHNIRp20uWSREWPJhuhiot74WkJx
 Te5xS/nodAOqC9e4j2ZX98g1u1gMTpO2cI3Gj8zFikeNLk2vh1EI+Bsf/
 6B3hFv/RXBQyO7gmvlejm5dyeb5iVJOud6hEIGP8tNClJ8LRJekz1yn9g
 6/VP5Nxg2JJyeIipEFaOAN/p6EgvlkeToeShIKg6aaWKdsv6CGsJOSM+R
 mCGeHIi/ECh/UZ6l1xtQsNrB2+7dM5q0aXT0IguOv7GqdcOkLgBaPsZq9
 i8J50IWJsV01HUFM0sreGG6OZfX8/aYywuVuYSXDrfdvIcEjVCNj0rnXV A==;
X-CSE-ConnectionGUID: o88Ljn1AQhyFELZlVArxLg==
X-CSE-MsgGUID: hUMku/m3R16X7itaLocCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83393204"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="83393204"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:09:03 -0700
X-CSE-ConnectionGUID: qH14Yo3qQx2obBnQkKYa1g==
X-CSE-MsgGUID: QNIE1IxTRSuFy6GGEJ7Kgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="251942647"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 02:09:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:09:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 02:09:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 02:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMI2JJu4XXyf9BWkRZe3ou22rMqAllRMWArV9taB5OFD2vkcp3NiLR10YsSFy0DXtsxt1oTE2upt8jm1Uvy+RZeD8FNNwtyahkPBdTR5mFpgF9WUiI0uN26gkvH2/AWOoKXAM0fEzHOo2BClgkBS2/CIf+SrQ2qtfKoGI8PY6tXpVa46FsIXxZShRbbNVbJj99cR2rsO3048d+3VT2qjqX+yfqlUQHl1li87NoEk61d/RchFtvt2BunfnMCVTgvHP4dBsC80cWqqxGtf5zeagqQoJp9jQshPTXSFqomnYPCLz4SvwP4zqc/3Jpw4KJB6d2EzSBCcfAuNWhEND68F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUROPxg8qlbfq5yzGxO3MsKUTH6eR7SoK3PbIbyNSE0=;
 b=QZZnykQYJEC8ir/ptKo643P41IRPRALHZ2VmwEM9VtC/CkBJla811w0nYWFxxgI2zRGwfuSRCC2MiQAXsUJ3qr1P0dhuwwBVVg5ZefYvJ7J6QqcYsy/NhHk2u51shtkq4RzqH8UyW/VwQM3GbG/oXJoVc1tlW5oKUUlkeHo25OwkAJATZJeZhMA/3qEsF7JvPTVUhWCJAdWearAY5L8Vqa8whAD0ZJGtN+CXM9c2//57NaAYLqFTGkwGgzy7XhOFA2FsLLYS0oF5dsZum34ur277TkKmRE6sMdYxBe8KzqclABz7GvmisCSrpw2brbdBzD70rAb1pREhJXyfHeS2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:08:54 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:08:54 +0000
Date: Fri, 26 Jun 2026 10:08:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/4] net/ice: fix potential NULL dereference
Message-ID: <aj5BoQp_vcSGyIx8@bricha3-mobl1.ger.corp.intel.com>
References: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
 <aj48r5GCYmLvhZ5X@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj48r5GCYmLvhZ5X@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ0PR11MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: c46213e3-a101-472a-534e-08ded3628bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1tIBJGkfrnRnXV5g3iL3vShlUyRpd1pzS5an0CMBrgpxYOfIjlZTw8ZRNQIeqPU9g/dOWsr5MEL4fYDLB9zicgxuvRw9ZRd6G6RKaPpCP2rRV1tHKddrJRFU2QHtN3HmsVk7PKQCDO68EANKcv6JXW3l+5RMYH9gaGyIyVpBKf3pDqy0UQIBv+FfhOc9WZ6gghjPA80kAqrxFiE7shnCda6szEWcb6c8nztC5vdCt9yg5A7KjTLldI9VVRhfzgoE+OsDDADyoCNBU1ufk4q0diHhC8GUCU7ksCH9mNP0ybJ7dRWyK9410k+5bWKNyXt1XA0LKc4fC9+HbEBKdlNejTpZiuzXVnL5awx/vjEuUZXAxOKNxm+RGAyMFU0pQtaocUo1VlpT8KnxvddjnVxUqjdKC43InBsKD1k9n3otG83xAPu59VZq3JJXbFhZmyzrIJnvtj11S+vyUkigFku7C2UleO0ata6XIq6TZ3EZEPrPPub/C+HcFfrzRKVCVlobUHkNuYbhRAZaIw4Z2kfPtwKCRslXtxLlCB1hC32qRberLh+q5VI1tssSuhHV4nDFlLV8jvyqSTrjQ1UJc08s5mQtQaeHr5TCayaJsF2i+vgabl/f+1Ejl399lSgibRdJMhvChA4RI9F2KSNcHKnaeI7QmSqAkuvv6zUqT4hTc0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FfHuU9K0USYebh3cp7Mm5y3+yiQbIVCYC+W0oCE0ddO6VaXxlYIFLzZCgiCv?=
 =?us-ascii?Q?uk7/OwSGYuIe1NoCzfUnr+H4Z+KOd1k+SA1gT2wwPgcuLniTvUJoXVdOuNRY?=
 =?us-ascii?Q?59ETpVT4PGXeFYYQ7uF0a+q8eJplBq27pDaGUxd+wPVjXiwSGP6xBEjAjhGX?=
 =?us-ascii?Q?ogNIQDG8zTimyDIklBk4RxUt4c84aVpnUKEq3ovY/ttlemvmjCvd5BVX/3Hy?=
 =?us-ascii?Q?yz3ahouU3xyysAcgQjTf71GKUUSF3jYY4P1dmo2WnmeB1yvBIUO1SEUf3tf8?=
 =?us-ascii?Q?r8/yu/jiqylgjCilLenb9p/OsxBYQUI7KkqXpjDLvapO7rcuUDfS3rHweMyx?=
 =?us-ascii?Q?xcgIrZY9vIrzRMqenSXDTjVxhmG3tWfMNnctEW1hScnAqm9aIjzSiQ/VZ+re?=
 =?us-ascii?Q?jcE8fs4sPAiw/zMmiCLVj3vAkR27/gsmvwGuPV9De9G5ZNXr85IdGLBXOy1j?=
 =?us-ascii?Q?4+HSPk3EMZQs/ZKjG1wCSUnWkTryhiIg1sImzLYA+WwcBzbcfPxHVvTpxJ/G?=
 =?us-ascii?Q?m5kJR6K9xh1tx943pv3/C+uim37e0rvoEuc5m5PYhiQ9B+Y33sZyHHvj8sLn?=
 =?us-ascii?Q?GR0vT9yqQl6VSYXXIJnPsT+KWPqYgX0wJWYg2fdwcyH+lHGZluacToBZXpM3?=
 =?us-ascii?Q?Z5Vcff8K7QCwsDKZjdaBqijgEVxSscC4+BHvRzlDfW45R0TO0zfDFISHKBvv?=
 =?us-ascii?Q?qj7C1sLtkMUWesE9dTald5HLmmIwrn8LVt7mZIh3Lyb9ixXfjpB1X++cxy1n?=
 =?us-ascii?Q?eJrURGjIRW0DaNC3yARF1vm/HiN35lnWwiwF+EOIDGMrw351BlFjZ1PCbdbj?=
 =?us-ascii?Q?OewYgqEYPC2z5L74oNWMxhQixKjoVGrxZfyn5fuHN7cGu47mw4ZK3hjNnBjD?=
 =?us-ascii?Q?Tey1caPjWuWa9ONkG9b8A4K86XuuTD06sx6WEh6E4NFd6uMYUvMj5X/cdekH?=
 =?us-ascii?Q?4jxNdWeP8aWsAORh1ay9EA335kAGYmSoMDeDjFWEH+SzzJa00oM0bxmb6zcB?=
 =?us-ascii?Q?llxa73rq5USwonZ4N4UZ61YFo/It7VQlvzELFXxO5Klv616lAd5LSC389XI6?=
 =?us-ascii?Q?v3Q2XrFj80iwRO4a5HeRg5Ub4pMgDtWgR3JeCWlgSxMfLVG4IdYlLcL0kW0q?=
 =?us-ascii?Q?hsiCHpopH/H+fTLrJDB0dcE5w6+8vbrZdTiejKhb3f62u7bbhXmWD+At8OiH?=
 =?us-ascii?Q?CE0UwzpWEEOAnEuh+grUdoT/ASo3jHNOqIyiK4ratO2DsWsd00bXiUvA7+zY?=
 =?us-ascii?Q?SovS6bX0wjN+DP7/MgCtZmXhdJP3M8l46Q3cSJuQjP1KCgLW3mMiiQdAwYbc?=
 =?us-ascii?Q?rZhvrcbgPrmp1rVGg/lz4KfwQl8R/oOrrwDOxi6AznSnfwONjnijt3h6W8Jc?=
 =?us-ascii?Q?Qu3DIcSkJJ4hPfd/ringM0OZXwYt6iXSZTrMZE9st0Ymz4zXGDWvb05vIsB9?=
 =?us-ascii?Q?tYCZ3QPYZfGTgHvuWX8Msvs9tqgF9J760PiSmRlBEo371JXqPJIJHle6OpMi?=
 =?us-ascii?Q?m0ksUYkbEsuBTgER+y7oAFwC09cGO5RrJbWiNe4sL8G4Z5XsCJnXEpTrQgIo?=
 =?us-ascii?Q?oVphQwzUoQScB8YyAzX2HcASTm2Itqc0TaTZHqxKxW3CyQFnavqKnEKSVGTX?=
 =?us-ascii?Q?+a4tqEoIqdRJocvlO3Zv3ZKtQEqmAP8UguW58lT27iMoYmRKb31mel6eNvGb?=
 =?us-ascii?Q?eVtFi6akGS5a1X7NAH9PkjXPGHzut9034fBqANm94G6dPjOfr4D+ZLZQw4Jr?=
 =?us-ascii?Q?+Z2/02gQ4P1kqT9qv/TWKzw6zN19ZnM=3D?=
X-Exchange-RoutingPolicyChecked: K3CmRvfZGkEhy2vtdkmYx+T2KkH05INGGIJoryUSWMSxfkMiqS0y4tgK9B10y1FWyr+C9kl8c2/j0PJFO4WoMrxlGpvUdq1j4XRx1lUnYWnGR0/kHJL05dOBPaKHUzfEDTuyeKKw3XYdOAq8GS3vjZgdxcza/5sYcDU67ORUaTTFHUoYCwneu2HSVPHYoK9xHbKajutOYhgSbcNd4APfdd1L00pHQPEkbjcQ5Mad0WMQXaQ30Oh9DH95joesdSZ0E4neRl7ke+UEUSxyQVP7F6XevzgiMxP9qT5/QQceYwIst10/oBlPzmnwZOyb4xgpBpWb0AKCU6VXC8AtlxTVTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c46213e3-a101-472a-534e-08ded3628bf7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:08:54.3398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcyR0W5g9qKBeDEJCsYK5x360PGpXIWmEv3z5+2gWPYFn5hwgw2DPxAxMgVVcgF9yzV+S5mmiqX9cRHGM8eszevCGmVwa0OOzmD4XV3YfLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
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

On Fri, Jun 26, 2026 at 09:47:43AM +0100, Bruce Richardson wrote:
> On Thu, Jun 25, 2026 at 04:48:10PM +0100, Anatoly Burakov wrote:
> > Static analysis reports that a rule might have a valid engine but invalid
> > rule pointer while having a valid rule size. This should not happen in
> > normal operation, but it's a good defensive check, so fix the potential
> > issue by checking for the problematic condition before dumping flow memory.
> > 
> > Coverity issue: 503774
> > 
> > Fixes: 215a768c180a ("net/ice: support flow dump")
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
