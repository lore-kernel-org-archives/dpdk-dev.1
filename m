Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDEC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 13:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB8742D83;
	Wed, 18 Jun 2025 15:32:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EBE48427E0
 for <dev@dpdk.org>; Wed, 18 Jun 2025 15:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750253553; x=1781789553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=M7AJ2mTzDmPNNPb6nT/msr6z7yRA8s7XcLlCjM3uJP4=;
 b=DTwZTroHXq4m6luYhOa0aBq/cGTa0jypzPrGap4Al7V9Jlh1IWjf+/sH
 iPs80yejSs68NwmRELVVGp1Rgw4oV1EGdFZRataxelAQvo+Q6ZETRY5NM
 9PtPl82l4zBZu2y7pm2dZvThjyyyrnrEEh0IACLHhG1VcGuvgs3xqYmGD
 uXXGHhYVsrTYsL1m1HClBbib8ofb2kqHCd/HhBIfKgHpUQH158XFCyEVx
 4RVVuhReW5yt36YQWahsES1v1Nm2JmeF/yvFZ3APkkSzdxYxmEHrmt4tD
 PNYjfqlawLP9awIQmDL1WlhVpfypMyBwXB/uV+351+7KAWC/9tm5YQq9Z Q==;
X-CSE-ConnectionGUID: NVUgxA2uSCaRiFxBwqYznw==
X-CSE-MsgGUID: J/ZafGJCT9i9nUpOVCDyEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52611931"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="52611931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:32:32 -0700
X-CSE-ConnectionGUID: tPrJcYpPRlWCvwTp8pp7yA==
X-CSE-MsgGUID: sGoAbx5ZRHusdDxHGSPmmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="154390430"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:32:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:32:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 06:32:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrCnF2aoNGBGI7KAQ25oASyjjnXSczaLSn0/xG8Zow48oWyRPDYSrvjBgJcvbRzCltqTGBraU5J9CU2aQHae5ckVLDLtsl1rkkZfDmLhljl0+ORveozxr/Z3UVVPjRRZby15vlr4XhJszZI3TbG6O6fisADr1AY+i0VvjyG7xgwxAUMwvn8BNlJbIZJntp0rQ1m0VTxLLJ8cKpG0xBSNP4KtkVW44gE5dQRsbhlJIBVyaAwpoSThKHcSZEq3RQHjVYl9oF/4vAJ4D6QhByZ1uHbYbgw+LnmULtHtN62CNMV1zf0Nv0+o+Q5I4dUdfIuLQXtbmOVbY3wrwsk5K47aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGzyt93KhQL3GDLUCNMtSaz7Y8uF6T+aRUi6qyv2VSU=;
 b=MahdgSmQPGTvSUuxvKLdTenryocQZNDlQrDgkxIMuAKI77FCQpqMKlBrTVEz1aiX4RVC8ypQUK4YroaMR9U+2MYOgvmdXor1y0s3oUcZUk72SeeMgpH4tDadEjd4jPwCPJKKCiOEzHuqf0F/LwN5WNH6XcVFLaICcqSW0MRKgb3W6n8AgrTq54TbRZ9pkHwAK98Q2QEAFisqg+aUkEXyWHXBN80CyuTSKE7HZXGv7DTdbk+aq4Meho4OZzmDUSC2fU6Kc/N2nMsY0GlRACrd9j2iQGZmIzgpXD4MO+YsZ1mCRjSey5gXi7QplqbHADceSJB5JUmytVgVOq0rvISQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 13:32:28 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 13:32:28 +0000
Date: Wed, 18 Jun 2025 14:32:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 2/2] doc: update recommended matching list for idpf PMD
Message-ID: <aFK_5wfbp-ukV5Ij@bricha3-mobl1.ger.corp.intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250612122543.146876-1-shaiq.wani@intel.com>
 <20250612122543.146876-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612122543.146876-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::6) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e6c84e-7b72-4098-5b29-08ddae6c91e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/y9hL38CSeTpVMViATykJWwkP8CXswd4efw4/sd/cTWCDwcUePrXh43lAGmu?=
 =?us-ascii?Q?ouo04Zn9AjdzTyJc9HMLJrenB6MS5wRX5132daQro9PUhEmb46OLjNesgzUT?=
 =?us-ascii?Q?aZiaED3H9srMruls5wUdY7hGAlM9O1ex2x22izR/lFBGu3Gty1MrbBUtKKJZ?=
 =?us-ascii?Q?79KB4hukK2HsRvG6bI7jyFfBLmhCA8YYcZjlvR2DfKWgLtLlwzaYbDLK2Uiu?=
 =?us-ascii?Q?lkHBHewWill6arwVDo7vKEEqrwdjvBGiQ6YSc/cw5vc+R0nyqSD8IgyIFYm2?=
 =?us-ascii?Q?sUZhBRHa93SUN7V+cf9pv9sPC4Vlm+jBNO5Ym3Qrqr/S6afCjQ/rmDgds2mp?=
 =?us-ascii?Q?27LLNf/0PRz4w04DfKzae7px/A9KjQrsDMFQXwmkJHDYlqCnNmsv/e8jVTg0?=
 =?us-ascii?Q?/QQT3P+R+0lH9jRtk2JWNF4N2zLUv1ys/UOBRNQ++ig4FE/etoxrzoH+fjxy?=
 =?us-ascii?Q?8L50bl5Vwp1sTx3A8jyuRxTqaHrwt5OicEg/Xhh58C72EH5uplrG9gB7HifB?=
 =?us-ascii?Q?+ILvz3dTu/oMAO4XowP7D/hXnY8JiU4x3AElvg7K37RSKmx0Hcl6XkcLtp/h?=
 =?us-ascii?Q?WiQSao4QgEV7kjQpjcS8qXYttlSG5rvCyuHIPcorJSsNv1UFmF2vfM5VF6NZ?=
 =?us-ascii?Q?hplIJFhTD3oePUq85BX7PYe0vwFpOjZ9lTsOVCn2CS7UyncaSaoiCPZbHuHZ?=
 =?us-ascii?Q?OIT75WEuh72WkBj16vy+tUsffsc7jHrhlU/CXkk1Jllt/7b61oF5PuY1tFWP?=
 =?us-ascii?Q?9So0hLbU35rLA58sliyGPBmFiz3UdAcWFwpel69+ks9olaiyAVbraDghghuh?=
 =?us-ascii?Q?SefQ7RyHcs+vrV+R4t1nHyvtLKAYIfEevf0838C6E733AFHzk4eo3AutihjS?=
 =?us-ascii?Q?YtG+eAN1UhUMOv79Y4LSR3ZXhV95++LJhpnqvqAZ0xgfLB0zRYdIVM1OiraR?=
 =?us-ascii?Q?EGHwOx7Rn26AmBwJZ9LDZtGJRxIN7V3uhFcivLQw2L3bsYR7YUnD9J+1Zmw4?=
 =?us-ascii?Q?7nfGR+3nZ1aYqkn61wWLQHHZ157ObLeTwU+ywstX9ZjboQHjJ9QBzMUgbzDo?=
 =?us-ascii?Q?3JXTYOIwjO+56dn1E3zKGKKzSc00MYqQUgOnC4B+AZrkoV/pE6zVgHlqI7bR?=
 =?us-ascii?Q?JQe67QnfWd5rfdqQUWH+E1lmUZlpr0FaspMJsQ/jrfME6gul8rrePtK46k5l?=
 =?us-ascii?Q?nRe8RZOSqt3MZuRRCAjVqZ6+XqVlMMU4RQ+Q5kVf+CZXIIYS/irwZrZt/Jjh?=
 =?us-ascii?Q?Eiun4vJgOAuXrJDBvQjS/Ro/69jr3KUiisJC3Wv2Gfkot6BxA9a3Phjx+Egl?=
 =?us-ascii?Q?jclGcKZe6OWKTSxwGH1N57WVTqH9nJGPLYCu8RlX7diRz0qZD5m1787r0xNU?=
 =?us-ascii?Q?lEu5Xvz/9Rt1BaHye6atK5Xf3e6TjTxxPgZsSeSMsz39iePhNtaTHbVuP7LQ?=
 =?us-ascii?Q?/+d+gallR1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pVPGiMI0Q5WZoHUGa3cSiyFZiu4VFO6gPpsYYV3ArH1EkhUWxJCBL2RKCOfo?=
 =?us-ascii?Q?U2H3uvwTXlDcDWwZqe+UdcIBUddNeP/RHJ9kLpsZmhMqY68N7UDxPiNTBg0F?=
 =?us-ascii?Q?ub5SZwkqq7c5ZIZKnOrYOX6cOEGEnH0jXsU/7oBtuRU47S2zauiftqTcJxI9?=
 =?us-ascii?Q?W5aUJYyXwBasSX7fBxxxP69I+48w2FyNLvYVG7zjEy4PMAkquUM0wOc98L0l?=
 =?us-ascii?Q?ZlINd/VN0zaNn7c6jwLB+/I1frViJJH7MFwhuaz1kJx6d+1gt+71fciptHeo?=
 =?us-ascii?Q?vfZem5nu4SIZugQCouYsgsyF46UbL8Vt4K+uSg6iUnaEkT9dSblHlLhQ2BT6?=
 =?us-ascii?Q?zmNLP0q7ZA041LM6WOu442ABTJwGnrhDFBx3DTORBhwrOYCHDpoSMbQbzdiq?=
 =?us-ascii?Q?QFJKtfuldf9VukONOlh7GiEUNHJlyRYYUXhm8+0xAMDclZfJ3IFGfp2tnN/S?=
 =?us-ascii?Q?rQLJxz/GU+KR0/xsMJFS4mvVS1avWrvMP1zMGcFXdrZ0vknL3ekxj8tgkQ4j?=
 =?us-ascii?Q?waOJRFLIpzqeW28lDGBgrllKPHbYgCpg4zKfCfejoEtPkT+AiXAowloOV0mo?=
 =?us-ascii?Q?N92Q/WsGreVjCis1vmzktCKWkWQkPMEUFFNrtUWN8r+1O3LHqnLUCap282F6?=
 =?us-ascii?Q?LmYWW4fytXLK6k4YSaLXczpyWTy9SwHALkMulqABnnbKmacCEu3lAdZiQAgD?=
 =?us-ascii?Q?gXzGJmpgq9HdX+QdNd1nwZOC3rdJeDbXnzzoPanYCZfoPMT7FCMZpNn2GyxJ?=
 =?us-ascii?Q?NxKXTkNYIfIGqG8aWj9J3Pg2CaaYUTOAjLyF+9J68l0SBkR9BZe2Fwg3TeoT?=
 =?us-ascii?Q?oy+E8neJf5qovV/obklmBrdHoZ/2Xsdl/9I5kLGTASX9XQ0O4U4iibDiikYl?=
 =?us-ascii?Q?G0J/bGSaiYMoDnMi2KPZufSaKEWY5NGY9ISwyosKew3+XCn/gTQaTNfrIjbf?=
 =?us-ascii?Q?gTYmlsXAue1oJK3rVON7KXOqOf4eG2CtWTCxnNFmIy61jKkjz2tHHZU0PCOK?=
 =?us-ascii?Q?k4pQ3vW5o4GX2Goql89qxZ7nEQgJ0/jf8YWI7KXipC5BFSe9tzfAk+l7LC+5?=
 =?us-ascii?Q?ZZCAaaaCbiMlsyvblT5b6UlE1dxWkwGgsxA6wQv0VphliICUW7EsPtyALTdf?=
 =?us-ascii?Q?cZ3qW5Oj7PYScPzvCUUFEeS4o+cHz1VKVY9wv0bB98Rq/1OGWL4a20JtCu3u?=
 =?us-ascii?Q?C7aBurdMLso3wdQBwn/9V6JD9kfHLkMnjqJr4HSLVAvKAAVEeKDgShjW/bSS?=
 =?us-ascii?Q?SCUoHoB7aRJcCGbiEGDWoD4rTQaM8Fz1VY9xgYtfpYial6zKKvKjVmncuz4f?=
 =?us-ascii?Q?eK7AgZQgHHvqc9HD85HnlVg77/xjgJqitL9U9ShnwtljaQzJKhDVrYoXltro?=
 =?us-ascii?Q?7OmJK91LoDyd2BHYeCeTK4CEfu9Qm0u+ND+DvU5eODUyu1+wOnmVFvuyJY8p?=
 =?us-ascii?Q?4U/Cu4S3uz5GuGH7cQevc1XM7zGmPdvSLVl8hIuvBBmEkhPQfrFFvSZu6AoO?=
 =?us-ascii?Q?bLJzt+ejdEbgmL73AZ5/zJkGFszwy4A7VrNd5vVO7As2ryJsCUeObkSTaFsb?=
 =?us-ascii?Q?Q1uu/HNX6iCTXZFzYzW/X0ppMhpXyHxVxzEtXF/lztI/XmDhtojU+7IIzeGs?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e6c84e-7b72-4098-5b29-08ddae6c91e3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 13:32:28.6087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDjc1f5jc42B+kIdQiprGRtLWcq8Cck8KN77wlaLBKIlwhhG5yzSbbnYZdtQxbFnwc7Evy3t1RufIUv6PZtqP+0OkEmW1Cw4KZhHiIKSDdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
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

On Thu, Jun 12, 2025 at 05:55:43PM +0530, Shaiq Wani wrote:
> Updated the recommended MEV-ts release versions corresponding to DPDK
> releases in the idpf driver documentation.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com> ---
> doc/guides/nics/idpf.rst | 2 ++ 1 file changed, 2 insertions(+)
> 
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst index
> b55de3abd3..3d694a4e3e 100644 --- a/doc/guides/nics/idpf.rst +++
> b/doc/guides/nics/idpf.rst @@ -33,6 +33,8 @@ Here is the suggested
> matching list which has been tested and verified.
> +------------+---------------+------------------+ |    23.11   |
> 0.0.720    |       1.0        |
> +------------+---------------+------------------+ +   |    25.07   |
> 0.0.754    |       2.0        | +
> +------------+---------------+------------------+
>  
>  
There is a big time gap in this series. Is it worth doing up a new version
of the patch, with an intermediate value added? For example, what is the
recommended version to match 24.11 LTS?

/Bruce
