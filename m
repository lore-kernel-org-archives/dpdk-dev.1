Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B12E91290
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 08:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB3324026D;
	Thu,  5 Feb 2026 09:44:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7628240264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 09:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770281066; x=1801817066;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u97Ydlr+ucRcDULdzGNWNDfjqWlhybi8BNkAqKthMok=;
 b=D9qkepo6SBC7QemOIJStwf8BHOmjhFNsjKYqgbkAX2oBvJapiL3RtT8m
 mG9XmOCxQNHt7TF27KmClw5y1t4cwsH2DH/5De+SCWF7tuHXNOzK7GD/h
 wf0T/U8T6XJ/vimCKpZAs4ACSy0p2DDZ6sTZwSJrXUAq8RaWrrC/w0+m+
 yNsXtBIfgTXAWcZ4h6R1Z2UGdBKM5oGFT9B4wC1SZ8jwrr0jlJ/7YSJYe
 RanKEFWd5Qfv93cvR50Pe2F6zMhRM/XHCLAtS27+FTLbP5Lcpk6dj22g1
 CoHN/AFkz3zbj7iC037jcbx8nrIOiw98C8rSaNcW2j63fCvnT9z56F6Uh A==;
X-CSE-ConnectionGUID: +R9r4tkzQpOy5t3htr1yUg==
X-CSE-MsgGUID: 7HxuxEYjRtywVMEFTlGatQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75327410"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="75327410"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 00:44:25 -0800
X-CSE-ConnectionGUID: s75Lc1E9RnOiXy/GVoW70g==
X-CSE-MsgGUID: IC993mgbTmKTzdWhCQxe4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="241090347"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 00:44:24 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:44:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:44:24 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:44:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyR0vHcz9Krf+8vjAOFU6LVHZHCTME4SsRS1BMvYi1aKYnKmA7IZjUdNURuC8FqYlrGBZ5tfjuvv+1pxnVf/JR1sd8gV3dPKBIELvfJDDBV3qDXAGXsUMSZpeWc8JXLPpA4al8Q3a4901R/Old5SG3H5LjpVrUiBWH/kAoOExPdN+1kV6D0CMMxsPhXoMhodRn3k0I0DlQJIez6uYyUz7Rq/HtD8DLLUhl7m5lNNYnhCpFMG64g5KH9pKrxfjGLKDc9mVLNIjF8SfUwwRMItvkMDfXCc2RNGJHXeBQxC8lwhUBnLIXsFNoJeZrAaR440/HfntcIiAx/4J8ZVDFVURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FAPgNGdR5pxqj7L/huzZAbyXvM87TEv1l6OzsDii4Q=;
 b=Wr1H0R71KXSwpXVyGy/kKHNxwJK84OY9EZZ6YGjFSIqYc6CG4TQ6Lll2xDwqflvWuV6z5HXJOVCb4nRkq9xoGK41sTretGWGewMJrQ5dCI5OlXx/ABZeKSEynS6ZZcKsUpNFYfFFXiaRMuN4Lj2xxNInLXexeeub40TDUD5rzGfI9L9KBl6+fITc/wL6nq1uEkmvp17rYvhNYtRPZka4MRxzTgBPnQpEtqqXStShSKCcJ1kkIt9hwvTDjHvwQ3t3QHnmdrKLmsx7RjMgkC8kkoFn7eoDKnsk8ConECP0bFAm2Slg5KW10WMo5kxkEhLp395SrnkLFH8u9Klx0oXLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 08:44:16 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:44:16 +0000
Date: Thu, 5 Feb 2026 08:44:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/2] standardize SPDX tag
Message-ID: <aYRYW9PMGfu3NI_j@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260204204945.3893117-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260204204945.3893117-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: b449cf3c-53a8-4842-7096-08de6492bed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RPZ7NCgn6yfg/LfugGtcWzAJsf/Y/0bCR7hg/XcndJr+6yZAzSlLO83yIhyc?=
 =?us-ascii?Q?eU9sPq4Dc+qWP9QiMcLnsqrvV9w+efWDH6sBM1/ulDrfK5ty8fJC6KyPKN68?=
 =?us-ascii?Q?s91fWiE5qT8XIxpdhRE5dZZNVmFzg1u0O3qwF2iBNLTnrEO/r7jdxAC1Pejy?=
 =?us-ascii?Q?rDRPT26Go+Mf9p6x97eWIdUTKTWIMfpytk4qK5ygnmrUdCoj6NidK+8UzTo/?=
 =?us-ascii?Q?efhJiRbWj2ba59Z6y+98Trh0S13DNGtJk9/169mr6dnx+C2o5JgcZSHOISTf?=
 =?us-ascii?Q?RPeLgtMIjKEtQTZo2frowYWrsUeMDt4CighqKctqtYSBTWHvVOa5bMCQpMhv?=
 =?us-ascii?Q?+4BzHJ1rNb0LZJ6E0KOjM6Jj18GtgE/ESrLLNrP0h31J0CmKPsXweJuYBvmz?=
 =?us-ascii?Q?OoQ07A7ZcKo4I6jouwILTKp0fcY69whY5aZLW3bKjjlfUgsSJJ6ENBZ89JHa?=
 =?us-ascii?Q?aHRhrx7DFysMn9FR31/vl8Spvmdv4NOVRCerMJRiecn/6D4xoMKF3Mf75y+t?=
 =?us-ascii?Q?ni9K+mIkmc5aypwoL4lM8yasd5FIZ9Nh978Di+KsO/TxroJuCZikFEu731To?=
 =?us-ascii?Q?vNZzjG3ZGb7DVJDd3fAN9yRYQQOKq7SbZKahUGacCR+N9A6wZXDdqcVfKd+m?=
 =?us-ascii?Q?xeOsqgpJ69BwPKsCXtbceQ5WtaxNtmDQ+E7EDE3iccj1j3YfmfGW6wBlJE/Y?=
 =?us-ascii?Q?6bypqocMyjKrZPYwWN2AZp5c9AnvK2Sntns5Fbuy1HkI68q4/6+ULT7iODaN?=
 =?us-ascii?Q?MDgsEsn/60222gFKcRvO0C5xkZWF+tUaTLpZdzckNssKUdJ94ZFLUTgioABI?=
 =?us-ascii?Q?DYvtHeNfRNrTnpP7ib14KkikLlGArTIq0bWv7bgyg4OJJQH89KOt0brNWu3r?=
 =?us-ascii?Q?2oOpBniVmRx2ipBkAvaQ4Z3fthJmW1V9yh4dL+xjg869fUzqbUBeA+bkAG7D?=
 =?us-ascii?Q?ThwqaAmJ29jf+B48X0xSokBNUOuNSxF52r0l3pj2itKprCSrMOuN6y3fk4QX?=
 =?us-ascii?Q?pbi7T8c/EKV9dIngcpZ3DzMd7a8BHkewCWMUrGgE4J2e5/b752Sy0vnCnqUn?=
 =?us-ascii?Q?uCmiZc9URHWArw4t0O4k3TBBMXGJECqBW023I3UyLVRcLYBUl0flKmgMbd60?=
 =?us-ascii?Q?sfC7GkR2t8ZLr7dTx+VCGk1c7+OEO70d01PUtnBsvb1aMpq+KGkFVRpzLoG3?=
 =?us-ascii?Q?L+dYHXUILbukTB8A3h794iir+cqIewnXAFhcbROjHnpjazojSHNgvKxArm8m?=
 =?us-ascii?Q?Oycf6yQE7WWIj4NrhCEgWUgoBYNhXSMW/VZpAcSt5FYd3MMpQs4osCt12flB?=
 =?us-ascii?Q?UcoXNKwW0o7WuiAOjmbAG5WPudZPcuKPXqahqlGSFKflfv5zHeRzs8sst64G?=
 =?us-ascii?Q?o8rHrB1RbKpVQ6K3Kbg37c8nfVaP26qeKW63j0zr6xfrQ4hZbRNYzdZI6ZiM?=
 =?us-ascii?Q?kiweU+Qu//JwXI2yr5pZCQL2n0DK3k037lPnn4uEsfQc0vZt+Gxq+sWogoCi?=
 =?us-ascii?Q?I4+cZy5RAZGRTjrfxbAfuTMvqaBw3iE8IzFszeT2O11InyvunReCOGotDwp+?=
 =?us-ascii?Q?W40VBSibOvjwHjTo2Mc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbN732h6JoNC7AC3Wg+9v3qMIwp/Yjo8NIgeU3Ilciod/W8gyLeFBA4bNEUF?=
 =?us-ascii?Q?AVM8W/lElmxMB9sP+3OHY5FovVaQfdE6bxERtfEp2JTPqDUFAb8yq2Bjr/Le?=
 =?us-ascii?Q?tkvGNiYo2FISXgifoIVbZch2+m8zFHs3GxujNnFeYLCil/3QHUHYuXH1RS9a?=
 =?us-ascii?Q?23O/p44Toutd7MZ3jqAcHHTDmfDjBW413WYn4XeNLQZDjztLiFPkXZBOAMPN?=
 =?us-ascii?Q?awhXlFfc+T57n6+SF62nCEnszobQW+aJdM1IjiQcMWXBGMYsKrtCOwB27wO1?=
 =?us-ascii?Q?LMQvHAVu2mdN4WUGxMlwD6EP1h3/OMOokPFjGHj88Quk6oxXacipy1ySOjY5?=
 =?us-ascii?Q?Igs54hnQR0G9neio9t5XT67swe0JQnTCIyNP8NoodrQ29gfGkCvFLS1YGQVY?=
 =?us-ascii?Q?itk5KRauQ0kGl4lN/7CToBmPPtfPy9jObAYOfODNTXGb/kKs1NPmez9t+ENw?=
 =?us-ascii?Q?Gc8q577a7vBToVOJMfP3LE5+sEdQJvnCBIO8iom/RpHY3x1h7d2NMm4KYS/X?=
 =?us-ascii?Q?GCbVYnFLnbTRoQ86pkHTgwzuDyS1kX2IV0QU3Gv23neOLReyr01iI4aQXOBj?=
 =?us-ascii?Q?xE2umqJ1CjFqu9jm+L1G+UrVOWF2gSI5SEnKl/VCWc98BsbgxcidUyFZVs8R?=
 =?us-ascii?Q?LHwEe+mSUCC5CS+qFypPZAneKP7mdX/MAWfWAtQ9fa5OvTGuoXQALvtt1ies?=
 =?us-ascii?Q?QFjNyZOL2zGYVXQ8lhFkql/r9yV3asc2+6OjnWX0JrhhoYWx093ZHk9uXVoW?=
 =?us-ascii?Q?GFCmZswlR23Jp3p8dudytHvOOFqBv7YFyGwMJfTD5A/eVTSLvChS+W4YTeTX?=
 =?us-ascii?Q?Wi2vyEXtzG2hMJ++5f4PqQoNWlG6ijbsksuezcSsAZ3BkV3PsFp5Sz+46XUj?=
 =?us-ascii?Q?hbF6qdLuFR8trYzKjfadJHi9ELpM4z2EcCu8ihrCYGoHGzsqU7XXtt0Vsfx4?=
 =?us-ascii?Q?oxmOcAJUxkdlhUepShLDMNgyrIjmIrzoRO7TJPi8GnvAti9uN4v1wokFBtQt?=
 =?us-ascii?Q?JRiR5HJY9BrVavGxRaLZCYyhBLEggPu2AGHOveN+Z3fh7UW04hc5SBDu8waW?=
 =?us-ascii?Q?bWjQrA2AHS2VwM2hjH/1q2HEYHMpQtzw9TrkeTf1ptdvz5W8+W/eFQ3qBtuy?=
 =?us-ascii?Q?YGDmlwi2CYMh4Kc4EG0+5wCSy6U1k0vdn69LGacZS5oyzCel03xYdPuhCz5P?=
 =?us-ascii?Q?ez0J2QpDoysMtAF4zvz2G5b9dnOE/fKpsTsTEmmSa+LG7M52jKnJVLdMAPqB?=
 =?us-ascii?Q?C4D7F9HTctGPRcAYHSkea/vpE6vWPYrwuSM75u8HMv/bKY5HxWjIDL6O7c3E?=
 =?us-ascii?Q?LTLq1BKiMEje3/ISHzKF0kOPnQihj3YhsAxmT1G0EzQIlh7yeXwirOsqvysm?=
 =?us-ascii?Q?m5V+Dnw2WmavtqmQ/ZCtkafi2luWicaFulfoKsfIMq313MPhbxZCWHLCwzn/?=
 =?us-ascii?Q?S5nFpTZ3z6IxJwJdAVq3HD/J5YzBfGDYD0pyM6WBjQNrXcTzMfUOTAHhb+F4?=
 =?us-ascii?Q?Q/M32Wwj5MmXRDT7j6QZGZ4SyOeLy17i3LXLEmfIdPk+EbkSHbCmi+JKkp3U?=
 =?us-ascii?Q?RsLEODJsB6szk/qJoVHzhdcuoLuvf/riiXatGEEfLq6GkySZhewvMXRUfLE8?=
 =?us-ascii?Q?x6ggcSobEm7TyZikZqn22KjlvrAm/WoNteablRke+8cdthOYCetkXL/kkhEm?=
 =?us-ascii?Q?3KBwNh2wkAJ1EkYvHMmBOTR4fPJEf4a1kGN+xXmop/mulGqtCF9bB20HbhFG?=
 =?us-ascii?Q?Bjg9fqlzV7ljW1MvrKSwcLCvmryMk9s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b449cf3c-53a8-4842-7096-08de6492bed6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:44:16.4005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMJQzfEMZQwRF9AOF7PsmEiO/49czZqaBCBnL9jeBO1ZawkKk3HS7DlFXQapJVxHx1Cf44UrdlJKWZt7D2n5qWozI+xohoZWvekhmpOMLL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
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

On Wed, Feb 04, 2026 at 09:46:04PM +0100, Thomas Monjalon wrote:
> SPDX lines are fixed to be more standard,
> and the checker is improved to detect some of the fixed issues.
> For readability, the script changes are in a separate patch,
> but for the sake of atomicity, the patches should be squashed.
> 
> v2: update the script and README, and remove useless parentheses
> v3: keep Linux uAPI imported file untouched
> 
> Thomas Monjalon (2):
>   license: standardize SPDX tag
>   devtools: check SPDX syntax
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
