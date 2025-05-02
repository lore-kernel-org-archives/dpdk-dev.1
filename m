Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD3C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 12:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42E1D402A0;
	Fri,  2 May 2025 14:37:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4F5254029E
 for <dev@dpdk.org>; Fri,  2 May 2025 14:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746189447; x=1777725447;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pGnAJaCSmgor1H3fLMuED3q3GaqtTq2iS5+CiOy8zQY=;
 b=X+s5Gj0rzAP9UaOS5m1IgZ4HWvvZQF/GJ5RniUvzEdCjZbK7UNcMFpgo
 8EQjm6scgQeUjbvxKCyWPuGbVB4b3OKJggaTigKKJacA4/erl58iPbtB2
 7txAkr4RCirqH5OS6FWjAkEwzuzZF+qprr01zF4/ZiPvRGg711c2vKJfy
 O36eR3zhL7va1T07xkTl5HqzxmANZAWw9mZDAeA9LqCfRZ4KB7cMm1KJL
 4MKcbDAKk91s0z8VtCXC9vqEwBIxtVj2kqrccvk7kRz+kMaq05gxO5E80
 JrClQN1pQYklj9Fwvs3kFbMseGhLSDC11rCS20pdg9bWicKYhxHCwQKSl g==;
X-CSE-ConnectionGUID: Ncrn0NOfTiCVOsTOlfV63Q==
X-CSE-MsgGUID: eHqqlTefR+yd3r65g6tjIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="35487321"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="35487321"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 05:37:26 -0700
X-CSE-ConnectionGUID: Lel1oUOnRrKpZqEgar4sMA==
X-CSE-MsgGUID: IoPQRhlMQq+t1CYsoDSH4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135144094"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 05:37:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 05:37:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 05:37:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 05:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIobThn7vT75TYpk+Lrq2t72IqHYrOt8+T0TFqF6pnOEOYHWFQ0nQsqRkM5zIv5T/tK1NxTCPoDfGP4kY05oOvH7DIIOzyhV2X0ZH5Feg5xZfRPx7c6jk/K1Ejw5Ipvii2c3Kwg5UUtfTscmpLSfBpkYvGoSCU7cmAAtzpy2auUTLRp3E8qhNCM7ZgXW8BFbhUoO89aQt4B7fWHRMWEUBvhf9sigLV9V4tKNHji9suFZUTj0IpV2OpepaFzlHEJlI27zJTY6X+oTE6L0wZxSiAMhrgh+UhbPISTsapUPLj7MFcaA0KT6G8R9cpe0in+nKQhDBvB4nv+rW3ILi/6t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugicjayReC8FvnJElCQJtQs9gYbg/2Fcp1HUTrppY6c=;
 b=eyMymoHgHEfv3pP+MUQyphIBxQ7F/UNsOoyXgb+klEWkTZvIlFor6D1KqnRjdtTXADIUsU/Mom9p8icaaWskdHorcKRLGa2V0uv2rIZqlfsRLnRqRUqZdRQSz76MKvBipSOm1S3dGtnJ0F58/TTRqT+PryPCvgf89j+DxIs6kKmeehfiUrVVkQa7gqYP3j/bmU4d+bF1PxafXcDRmjgvxmamtjEzDHnByEjUcI3fzRzRUo4oRnLsohqbuzIN/F2zn1YZ7yNAUMLYW3wy8opYzK+Sxb0bvkAVx6L1b07fYu6gNKr9/LpV+D8+ZJuuIULcvgrE5HkZGIybZnP/u1TMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 12:37:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:37:22 +0000
Date: Fri, 2 May 2025 13:37:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 1/1] app/testpmd: add sleep command
Message-ID: <aBS8e9GZkyXiCCJS@bricha3-mobl1.ger.corp.intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: e446b9a0-93bd-43bd-5348-08dd897615b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1tcll8vkyv+XQWkl/gd2ZeIYSX7w9vNmgFdErtpn2RUwEu5/SIMv7bLaokt?=
 =?us-ascii?Q?l71WpteVC/gFT9EeQ1omdAcm2GljBKtQFyv2HQ6A3HMaAueNUD//XDZjmxf/?=
 =?us-ascii?Q?Da3+qFxRJ+LnAtOfQnwtSlVBB8aONgNDcDe3pS3l5th2xVvb4RC0k08YILcX?=
 =?us-ascii?Q?5PtAC368hLGcJuJbTV7n3lGxVu+K7b+kX9vq4SCMCzjdBgctLc0LlqrT50eb?=
 =?us-ascii?Q?xLqdBAGz2QwljU+QjrxIx0+3kRTR/IoyH2i/ET9M6qLgSvikyD0xIzc95MNh?=
 =?us-ascii?Q?qavXjdk9PvsHrObcIHY6D3LjA89KOyWKGDL9LodWL6xq22XwMzkwmN3oup1u?=
 =?us-ascii?Q?8D4D/uaa66Lcv8rwNHeuu9vilaeFr8qRyrUJ9uzLiMkIno2GEq5qiJ9EU8rp?=
 =?us-ascii?Q?iXpX3SqWiXw+2uQUIjWx2V21MixrjwVIlMj7YTO26NXM+jgHKTapZSzoOqIK?=
 =?us-ascii?Q?4lNxBq4OTewFltDYRCekHwZaD2BwgVq1qVCFyGiXgsr2V54LDxkWiFie9KJz?=
 =?us-ascii?Q?vvNj6xR40L+CPJ08KxVGyAoCjCt+HV70hMBfqk/YhEUW4A2A8GWxhoUr2hOr?=
 =?us-ascii?Q?XS4qyXbQgu5jpN/87xPrpY1b4LFOL1Az4bKZHlKNUy6pd2f28NsC+maF7of8?=
 =?us-ascii?Q?AwbCeSDSrlscJ/LDPiQq3SF/oipb9FqtxDh+0vIsUoPY0ZQhuaWC7LxJH/G4?=
 =?us-ascii?Q?NCaYBqPHmvzz4315Gi2zJK49yAmfa3qqpQOSgPr3dvxjI8/I0cNqyvU56j8q?=
 =?us-ascii?Q?/q2DnOea2VACVQtKdvDnuwKOLyychsJ01vyrdLOIETysu/mVZ51KseyKjwGi?=
 =?us-ascii?Q?U0oTj+qrIvpJdb4NN7foHXKXjpmSEiguokHwUagsLg81ZO5crR1IgujWzjID?=
 =?us-ascii?Q?VLXxS+6e815/oKXdK0nyZEBJ2tu6TBwH/yUFCGZ5RjaGeOhxhP4VBU0ZCxXR?=
 =?us-ascii?Q?2HLHKGbR3yVJSLy75CxwO6k4K4aIt4Xn/pqm73o8GG/4oXxtkuhn0tyrNgb3?=
 =?us-ascii?Q?7HXineapXOKNb9g0JWeaCOctQF4UzGpj13eQfNJdp4Y08NwfvVAMzePYvq8y?=
 =?us-ascii?Q?ptC2Hrhz/tAIjwYH9rs1AizspApXrta+hYKfnzYEIU4vDioLzUr1FdykqKea?=
 =?us-ascii?Q?4lv2XbTK/9LH+ewbhUpcvIuQqHE6hiFzeh8aWztKdB1GoZfsQvxQv8lIMC31?=
 =?us-ascii?Q?W1KsPQXXr9VaxMT8qKBvQ+9RWHSjI2c9oXTI4ZrSyuXtHt2SJBEHdzBK07Dk?=
 =?us-ascii?Q?OxGgIAc9kuGJmwDaqPWaH8kx9UPQ1oABjEU2R7qALOoRmOM5VRnFqQySsAOS?=
 =?us-ascii?Q?9zEpxA7kAyt6d3vx8ZDXjWPt7tOx5Y7MeXiPpE2ajaibuDo6TCk/7kHS1KKk?=
 =?us-ascii?Q?BIRT8Zi1EpXt/uPz0Ao6xkXm5ffWqKrxyYijfT0wISWCpOKNR99o9gUaUykK?=
 =?us-ascii?Q?Km+myZ+V21M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBZJwz2UnDbPGRDWA/wvsxj0iPKQfZQk8wRFZgSRN8fvHT3ki+ByeXyYSnyc?=
 =?us-ascii?Q?5j3OjQcoySPFnGV0HLgOIEbhBScQXu3VS+K0RXgl/kBnm+jfMo+dPXmNO9NE?=
 =?us-ascii?Q?alSg8AYk3D7aPa3gobmoLWYPJ1EymogPKQLwWvCz1ufvk1HYQDatpQcW8gRj?=
 =?us-ascii?Q?7PGwT3TfaSPsFTkxzNv4uSQ/8jc8KFgq/KgeVqCF32UhH9RltW0OXH3KSHuk?=
 =?us-ascii?Q?FfbTW7efhE/jWZisOIFEAZlAMoALpilM4yWocr4zAgJDkUOgEI2jw09GJ/so?=
 =?us-ascii?Q?MUijO079DZcgbw+PCitFbnJx0M/3VD4CCIhgtj4yQX6rV8PJmu8qapRK836R?=
 =?us-ascii?Q?RpuijSLPqhtEnynmC9NvyXqTWcPlvmRspLk+80uTwtV+enGnSgPwCSagg+ZK?=
 =?us-ascii?Q?Y5fEXQ3fo11nwxgXtBy+naXZxHHoctw07fRzy62Ev4zVn8h6W4N5IsvSvKkH?=
 =?us-ascii?Q?/SD98sVE92U8KKBHfNHQpJ+d9NlTRovxm3in6FN+PLwExh94LmD7OeiV+ASP?=
 =?us-ascii?Q?FoXjY/AMuf7Q/2ej8o+iqvy7RpvALKYrHYQFARD3vqPwDtqKhrk4vtXXMHtj?=
 =?us-ascii?Q?3blGfyjcIb1OubT0IT9asTaW8ewNGjgsRvFgRjgJ+1EbRiIrb3Qsy/S2LQmr?=
 =?us-ascii?Q?FMcI+sJRpsJZ+XqCqHtoOjLVhReqcKd47tECD6Mi1lvVJMp4J64QF1fGf234?=
 =?us-ascii?Q?R+FVDiqMQhp0i6QV+MzYXjgfJU6SBYFFDLDFMO6Pqjypnevth9B0jlTl5xQr?=
 =?us-ascii?Q?4FlLkyysVkTu6PYoAHwte14BJbXHfdrraKX50ZZ1K1+UOYZPGJOPvwQnVzz5?=
 =?us-ascii?Q?X1mv6/SgGwTFscT4jRX3EhB4c1Jc+QcG7PFqiQ41pl3odrt8nDgktnFddx4Q?=
 =?us-ascii?Q?8Gfcjj/ypg0Ht7mttoOVaoJoPOwo4igeV+KzF58uVFGq4atfMZBzhyJQYHKX?=
 =?us-ascii?Q?uaEF7Bq0025pDhfaJEhIxEfdG5t8Jox5sZBEMCg6nS6y+MH7YfoVjA8m3OvG?=
 =?us-ascii?Q?CRgKGeFsp6OiXLiL18+ZdwnwPnPWGJNJZbjMR+MuYg1pyzv/UwFzeXdtwBMv?=
 =?us-ascii?Q?F5CSLFqBdKSwnOcG4PtTvZpREhBKXZZIjs2fnYMP7cLKC0iWOpCZUaFiTn58?=
 =?us-ascii?Q?Df6YbtzUFVNG3eOPa3Ipo3qWGQY006ET/Zjnjke+UXeQbIuNSn7TwlHAobrw?=
 =?us-ascii?Q?pfs5YUXLV7KBsLRe2ePgXDi8coGmXwWXjWNzEvFlHFpQJFJ8xw2qaul00nYI?=
 =?us-ascii?Q?nw02ah9fdtE+GZ/Wo7+g14FQgdDLeFjqSe36tAqD8EzdELJxZcLYCrf0AiIk?=
 =?us-ascii?Q?ntOupASp/hY0Ab4mjfoLqfmACNsofkCDrMslWZ3kBV3za8f09jluobJYNNiu?=
 =?us-ascii?Q?hrENwNSUi8VS+U9f+pOO/55Qfzh2T6qud0rEQkBbdCTzc2GsheFbo28hgn2U?=
 =?us-ascii?Q?q9js5P+XVA+Pi936akJSDYGawWb69qxyWCKuV4GoiNMgnLx/e0uyQA/Qusbz?=
 =?us-ascii?Q?4+9+mYlAIdxc4FQ4M0g5tqL0Qs543tHAQv690sqOGaOyIjBGiG4SQq5f5ns5?=
 =?us-ascii?Q?zv9LhOPpwONNksmUX+l5jmwnK4yg/wgXYPYtq49KftBstIdfi/vf/4r+Ab1e?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e446b9a0-93bd-43bd-5348-08dd897615b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:37:22.3519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR7GYr+Z8sfSsL+thK9dBqeqhnQyyKEgyWHLQXQc5Q3QYnvupC3x7u3jNkIri5xF4dJ5zL57/rxnD8xDR/r8COK/VHUfJzswdzFFj+HHcM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
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

On Fri, May 02, 2025 at 01:27:29PM +0100, Anatoly Burakov wrote:
> Test-pmd already has a way to run a list of commands from file, but there
> is no way to pause execution for a specified amount of time between two
> commands. This may be necessary for simple automation, particularly for
> waiting on some asynchronous operation such as link status update.
> 
> Add a simple sleep command to wait until certain number of milliseconds has
> passed.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index d4bb3ec998..1e429e6d0a 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void *parsed_result,
>  
>  			"quit\n"
>  			"    Quit to prompt.\n\n"
> +
> +			"sleep ms\n"
> +			"    Sleep for ms milliseconds.\n\n"
>  		);
>  	}
>  

A "sleep" command, I would expect to sleep for a certain number of seconds,
for compatibility e.g. with terminal "sleep" command.
To keep this as "ms" granularity, how about making it explicit as a
"sleep_ms" command. Alternatively, how about adding a usleep command? [Not
sure "msleep" works, which is why I suggested sleep_ms instead]

/Bruce
