Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD2E7E36C
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 10:39:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6917540296;
	Fri,  3 Apr 2026 12:39:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D39DF4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 12:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775212757; x=1806748757;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+a483YBqB1IZCCnUXIjmYdEb+NcZZbwkBe+r5NRWwI0=;
 b=TgPUS/gJao35utYvNUZEEGhUIl1fQgBkjcVBnH9A3UFoeazozKiS4kso
 PJ66cQaqNK/gTIb1sXXgyu/YIFm3IjSlAL5ells+1DJxqwUzUqYdmZMA+
 v7/KxoGr0fFBhXV1oYO/YQyDDyXg01dVQIHlLiIRMC6ILIsGV4gnEHLP0
 1gCEvaUemABQvyny/kAL2NFO924i1s9tOEH0Lbjmd0UTzejcGlMN+h2sV
 JCuU5DibhGN+J5jV0QoH+4fzfLyDlGkfU0BYw4pIgLLWnIZQLEwiraFkl
 B4Zcqq9ZSzNYd/zY6T455TZ7hK7bG954qdyyTbgBcYMXTEi4QkhqNNO8P w==;
X-CSE-ConnectionGUID: wyFRjIGcRZ6Itkt1Kv3OiA==
X-CSE-MsgGUID: tGyC2nQTTZG+5lDBNUROVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76163595"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76163595"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:39:16 -0700
X-CSE-ConnectionGUID: X8eL4vBFR/ak7FKo0Dhm2w==
X-CSE-MsgGUID: ctSTyq/0R0OCmLxb41pDog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="231622392"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:39:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:39:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:39:14 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrmoT1xOdIAn0ZY6nSthIYPSZviEqGxzsFG6Vh50Rq3EAgpyEqwyGqCDThkYrwie3+D7n2m8yUfZSs8wVNXrnDh+zjAf0ON/1irAaub11Vl7YXSv+SDipB/3BxieZzj71OJUPEPr3wfrLrItHisRv5gh7n4eLn0p/s3iTvxKuc2uq6Z8ZKiMoCX/pLS1yj+SYyceG4T4iXL6SJAIFVYjKW6y1qqKW4jW7txrNboDHC/DDg2b8F4QHlQsCPMzoMaIu6/gSWYVvVvCxMv18fcPqsWSTBdSid3Kw6oKTiW3hJIMUP5rsf8q7iv0k7AHDVL83iUdXan82wyAu+d3yHdOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T68oBnrQmsl3FIfAXHaYaWYeOutLpa9HmsMW8mfjVsQ=;
 b=Jkw2tAY4MeB4LJgTNn58oaXPkYh2WRPg3nTfactqUBJ4YK8JKmv2FZyC2wJvVq+lPLGdKueJ65LhqZiyrSzSXB51b7tm5Z4x2x5YZP0+n5CLD5sk1+xZ4eDv5eJKujtPjeD0ZksaNPZlXmHPr1pwWlc+sKrXs6DN3t737gw6aCknbVDQGcZAOtzCu7+eWpAvwWQA6JQdCP0cr5lhsDmdmVKXp+dKTZdHg7hI5ovzA7znbbA6TlqRNBfPvhaDIhxgeGBRNnLpV8K51sEYDvvHnSOCyLbzIiHDR6FJeL16D28Tyb+jerqKJfx8x3wntSbI1KvX4orjbwnAFnnUfOmJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 10:39:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:39:06 +0000
Date: Fri, 3 Apr 2026 11:39:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 2/8] net/iavf: add a variable for hena
Message-ID: <ac-Yxe94EjalEVMY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <d154dbf59c477c626feb0154330da9441cc20f22.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d154dbf59c477c626feb0154330da9441cc20f22.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 256a2187-c7b2-4642-690e-08de916d3b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0j99myV0S2QKzOdvrYrThwmFpJzR+XrRdbzivdrlWDJYoX739P3DUR9mXwN+ZlPyKisVf7qtrLjZp67RCIAqLvHpf/Rp/Wi2Xykm5KJPdo3q1ElS8EdLF1F3XzSGsbfYTK0n5XbuSzM0oU25HRbQ/okwI1pEjvr0sDREXi2TemlNLASMAzuXvLmZpAK0qTlCvySiM0AM/H33OrHFoII2eEoudBD706zqOBC+NWeMryU7+Xt4n2rqW7Gf/VSmPcipmhYZjJ0yUkkynRQILVfCDK6jmovjMWzGkZ6yTuOIaxWResWfJ0lHoR4GYcZeAUH6ir/VN3V26rkVrmNybDX6UQZnjgPwgGDbzDhcIFW5x/MDnMqjR1yN7DxKTHRAzSQpBOU8A6jE+1Zelcc6LemRv3NpmdrSS091c4w8C4IVP8hCXY+rKSvGfpZkRMP449oCHBbMdsxPA19bAn9MUrA9j/fZwkVBIEQnE/5CMxFjHYvVxF71saItoqXjF2pBaAtw+xXdYqEqDd/wQQUAGUQUzB1SIQkoPw4q9wAb+QFVgt0+V0h1X3HHPMVPsp4/9WQUNBRZdnX3xqjqM1hlnyZUAwLfzOcaYdFQBjHtuFbn8ksufrEwx/S4nT0w/RF5aakdBUkdYNMBnwJozqzFUtt8NIaWDEmKXZqB8lImkJ4F1bx32DNPod3iEGFf838tZZXP0UABEqOvLlzRq9PN9CZyL9cyfCuR4Pz7UrzTaA1o7tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lq4ShC6DTMxPgZHG78U4HosYzCB6KtBfhOa/zZENwsHgEAK+dWPzH102l2a8?=
 =?us-ascii?Q?dyijgUUiiY3FNDOrfJZgQulChQCZnaUAb43eAPg/AxoF+vzxLfKMbfnTvI5e?=
 =?us-ascii?Q?XcwdjvH3nYaXvE2ci58bzY2P0oe2Xf2L+/LQUcISBhun2LiWXVVtpGjb1e6x?=
 =?us-ascii?Q?M+4C/qduvlDvhP6hZgtNv4B9aiBaVNHdb7SwCrtjvQx8bGxO6RnX1VuJ5WSu?=
 =?us-ascii?Q?NoCaPsMN1mZAB5uf6e9f+a+JLG7PpqpPQzPjg5ZDRwoXc4PUx8oXrz71Y7Iu?=
 =?us-ascii?Q?BXsdc0smXBZ/kMnRVqpA4DIbJsMqGjoR4e0EYRIHqlUaRfaZi85RmXKckvRB?=
 =?us-ascii?Q?FXZbQLvF2Yvtw1aT/+OUEbupt5FLS30cFF2BINnWsh2PZGqpUFBecwCUvp9q?=
 =?us-ascii?Q?a2pb+YsVg1zi0JV7hFWy98XV9GhGi0/Tpi5RCu72dcc/MlDOyu3kVexDf8EY?=
 =?us-ascii?Q?mzBTjpCG2YRnEle3873jCvd17TO+NcxEXZEWuSNwuHmzFIkfZaQq6yJkK/BM?=
 =?us-ascii?Q?cVpAwHC4m/rIr7RyPetAq1GO7IJgcX/7a9xbbnvw2Wwc3UyFxTkMVQK9ECGJ?=
 =?us-ascii?Q?q0FHN6J7jGLV0JIrnbcy1+ug/W1+bBc2rkMwEA5TqTfGCnKKOI+Lcihhf96Y?=
 =?us-ascii?Q?t0GOjh0trcVBzzw10K4MAx5sba5mQr97bAyxD8Ast44lZzFLOwH80CAC2vaD?=
 =?us-ascii?Q?+JsMNOBeIXWXkgPVUoXjrop3+OgOaLrn1F8I4VAEdHEB7H8UXaJrtbzM5vBk?=
 =?us-ascii?Q?YX2/Cg6RhOBeziY1eeKsSD+XRw7AmTJ8XB3K/zRflQW+XiRKxCZa/Zxgh5v3?=
 =?us-ascii?Q?pyReRuUgEJLG54wWzr9qalIRyuYgsc2hO9ODutP0GFXuRComXzb7QO2JQI8Y?=
 =?us-ascii?Q?/Yx0uJuv9uMhMXwbSvIpbdjChD6rvfyrLnOXdFedW98dI9pfa6G93XkzVM9z?=
 =?us-ascii?Q?JJDPp5yeDafMVls0LlocMH7UqOnJh6Fkav0OYLXBgbZDayRZ8QW3zQjNNi5b?=
 =?us-ascii?Q?5xPc8R9yr/PlPm3ZleyJtdKZRVlNXvdUaiOUptbAuBe+SLH4iJvtdXkAtOCH?=
 =?us-ascii?Q?7cd9peDOXyDaRv8YFd33Xl/0a/P6b7h2yglw2EfDg98QVz1CDuze9QTKN7RR?=
 =?us-ascii?Q?STjdYIYPrGjD5IHkq29fYG2jEZO1TDyxEAPiSUQdmzFMrePVqE5tXWECiap6?=
 =?us-ascii?Q?Pw50Mt2d1Hjcrs14QMpVcsZ0rrsDAPepBGv2eZRtQVKnrGYB/Xmu6CoqM7Gu?=
 =?us-ascii?Q?/pVX/EkVdeWdHtPzPMcY6UymPJkxQURh5Y8F2XK6T6gD7mfFiFWWeJVd/CH8?=
 =?us-ascii?Q?1jOhxBqOm5vZNuEWUEJOAeIhIKTMf6gHTAHKMOxhzfwenuYwkwh31L4uv16u?=
 =?us-ascii?Q?Dyf76/1sXOCgiCPg+/jJC2QTyworGb6WT+1o8zjfCasupJLq/FSh+Vq37vvq?=
 =?us-ascii?Q?oAHhfdNBBGl+8RGtaDJaqU5TXc6ufxlXjWQ/8U6z6VwQ4gZ6B+5KWawzXgox?=
 =?us-ascii?Q?SX4RYe1G5qgCcO23j1O46+5vNDuCPlZiRlWotD/CzI28KJvxDpr0QrV0rVKI?=
 =?us-ascii?Q?HdJqgRdX3b9hajmQBkjWoEFoQaO6Hi2DNAVaaxpxw9nPK0HXZV3xneTKXmTh?=
 =?us-ascii?Q?DbmP7r6g4NQR7hBXS+og82IXXyepZSiJhIpeiu5R/04EExUICK7A4qw0N6yT?=
 =?us-ascii?Q?EobcafsEIqJ0HS/UwcUy17OHYp6eUm5fL8tkEO3ZaHaa4raa2mURMRgg6wLr?=
 =?us-ascii?Q?QZr9zILdlwjLse/6k6K+J5wAF5njOzw=3D?=
X-Exchange-RoutingPolicyChecked: XAD6AvqgjA+PhH4wxcTuS6vkY1tsr69jnFQoZ1WbB4ALIEV4+yObpoKPzxrqhNq148Ko3P8sDdBpuWanFocXJbD+kXU1GZdG1fXnFQo0JDGMDUiEaMMDVWqlA6NUzbbyM6JupFLu3B7f1Oc079TET4bEmVc8qyz2eFD7Mc6bO7cBTt9KkJvFIF/iuY1MGlrfzBWqy89bcwQBRWBQ1e+Dr+klMzYnGF8lwvFvoHTGXTnHgTrHAcOWvTjdE6kTzgQJSVhDXYnletsiFx49ZzUhg5ERIx8V/cwU/B2MROKQRkTLemizH/VaeC2gTR4SW4td7eJqVHi+f6O/2Oro/k10kQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 256a2187-c7b2-4642-690e-08de916d3b03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:39:06.3058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp2pshRNsQkFgujG12o1tLqUK9VTMCqNwwYsNe2UP24k2V+L3AOq+hr3DoJWroDSd3Gu9ffp49U/0AgJk1yvKoSXhELb/0ZepXwnhShydq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
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

On Fri, Mar 06, 2026 at 10:58:18AM +0000, Anatoly Burakov wrote:
> Currently, we read RSS hena value directly from output buffer using an in
> place pointer cast. Use a variable instead.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Not sure I see that much point in this patch alone, but it's harmless.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/iavf/iavf_vchnl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index a1dc573841..d97bdf0dc1 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1933,6 +1933,7 @@ int
>  iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
>  {
>  	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	struct virtchnl_rss_hena *hena;
>  	struct iavf_cmd_info args;
>  	int err;
>  
> @@ -1949,7 +1950,8 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
>  		return err;
>  	}
>  
> -	*caps = ((struct virtchnl_rss_hena *)args.out_buffer)->hena;
> +	hena = (struct virtchnl_rss_hena *)args.out_buffer;
> +	*caps = hena->hena;
>  	return 0;
>  }
>  
> -- 
> 2.47.3
> 
