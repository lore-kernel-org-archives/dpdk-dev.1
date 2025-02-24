Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BEBC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1382C40E7C;
	Mon, 24 Feb 2025 14:48:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id F3BA9402A4
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740404919; x=1771940919;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rPU9jAQd6KJRCKfH1nHI2aeuaanY/ARkH+E7FPlFReI=;
 b=BYUP7qfS4F8k300nzq69GN7Ut38BG94q5MUnEkJ5i6Mh68F4BQ08sk5J
 kqtWVC1CnSjJsHv96oO90w7QC6epZR3ppaPOLrbPOyJjcXP6fxlc3UYA4
 HuaQgnKn0PmRarsQcx4hhk//FogbbTyiraQ916MCytSonemqboIG1RdJS
 w/bSAOLXFazmXwSyu5dWScvDf1jJ6TrnGXLiz4NQdOPEmkXxIs27mlW2f
 Sy5Y08rVWLEYkPtY8JrSL7FCEOl5j61Uxqg1QegRnqRTe4yfptN6qBn8S
 SzmPhuHwjMA2oKI+N9ZcJBjBrgJl+oOVqWCrs3elkw3AGsF0bb4z65I+E Q==;
X-CSE-ConnectionGUID: Eapb9oYBQvqE0UqSukNLaw==
X-CSE-MsgGUID: h6AgdsC2RhmBuuHeZG/Aww==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44811782"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44811782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 05:44:16 -0800
X-CSE-ConnectionGUID: LacBlEcOTQGa4ZEGt1mSLg==
X-CSE-MsgGUID: N8kNoG+CTYW1//mCPApLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116087499"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 05:44:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 05:44:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 05:44:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 05:44:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD+rRQocgF2M9u0r65+pHLmADda8eAeadGRZDhkbJ4cTPlbh71RKHE7oPSUpGABgKbDpMym5uOee5tE2GucrW7n6PnBCb/JgbkbkxtDvBeoL9o9zYkyLn9SY9T+NA7HNu/UY0OI0TOjQ9c2SMpkprH5lpn/JEKSS0tSsW1a9DgWTAlGVzVGOkMzQq9OqOL+zpjYLj2R1NhdotMPnLJGjYZH2MOhw9rEIatnU+Z3miDFbwmGAXjg4X1hlOsGaAEG1tX6hnIPIagEtZJO/UQVmyJ0Grfym8kkgwFckKleS7KS5NF5s3GRrkZp6ElIWa9WTEaWCjsJ50umlfaH5ZSqE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/lkAzmgnUHtpA+JheK/kPRdpcaU9u80kObR7z4XRbk=;
 b=mCm4D6asPTEhJ44WLEJoOcRRoWchXyqzuqf4+q79+aTJuU02MUgG5vC+T3rAJ9F1LUIqmGTqR0zv5MtcS0hsCtcWZJxBJDDzw5YyZl5kQ8moSEyvMeGh/+n50GlFDTA8veORR6Gxu2GIATp0yJD3hNdtFwHRiRw+VgOqAhJCdPV6X60eQUasLYp+qlJT/JGWs45sQ7oZRUJ026KefcUK38JWwRNTUgojI6kn5wlGbvA1dhJLZxDNlaw81BP55OMLf+4koVy6+ZNPMqf/HuIky+vlMDpRf5LCaES+VrtrQexbhuk1rAmnAsCtWM2SQHft9zonhLICBkSQdG7vzI7vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 13:43:31 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:43:31 +0000
Message-ID: <e63850f1-cc15-4678-bf91-1f9bdf44b69a@intel.com>
Date: Mon, 24 Feb 2025 14:43:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix incorrect mbuf cleanup function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Praveen Shetty <praveen.shetty@intel.com>
References: <20250221160402.855510-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250221160402.855510-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 85148756-05d8-4b5e-2c91-08dd54d92e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFA2ZnQ2Rk5selk0eTdKOHJyYnFscXRRYzVmdDBKT2RXV01rekVoVXhZZ0JH?=
 =?utf-8?B?aUxjQlFJVmxWN0ZIRWtxdjZyS2FaYW1HN0NTUk5NUkFRdzhDdllpWjNLVS9R?=
 =?utf-8?B?djRHYmpadFg2S1FGUCtiakJjV3J2L0xmSjhZVENrVmlYRkpyUkFlL3RacnE5?=
 =?utf-8?B?ZzZrcDZSNVhVVWdDTnkzUlFac2ZtZlc5dUU3dUw3U1NFU3dzVm44ZWtvMkFp?=
 =?utf-8?B?UHFaSXpYdDByaVc2R2I2QXVCc0xURGdLaVpWaXo2d3gyRzIxU2lERkNxOGhV?=
 =?utf-8?B?MlZtN2xwQkVUYXl6Y2dneGkzczdjWEgzOUErUFY1cHQwa1lkdDNqc2NEaWoz?=
 =?utf-8?B?OC9lek1jeEhhLytoYlFZdTZ4Z2RQdXY3RU5wZ2I1N0VUQ2VjNzd5KzE4V3ZM?=
 =?utf-8?B?TVV4M1dpTjJoaXBVbFZjNllwSTlrdzQyQXU1bHBSKzhUUVg1cGp4TTZwc3Rm?=
 =?utf-8?B?MG5xVUFwMXpuMk9pMDNuUGV2ZFA1ckN3UFdiMGVQSDFLZXFaWmhUQmtYQ1Ji?=
 =?utf-8?B?R1JSY0JGVGZsMHVNV3JNQUExakNXYitObktJTDBXamI3WTJldENDVC9VdjZF?=
 =?utf-8?B?TDJsU1ltMjBzR1N1MHM4RGlNc2VUMjRPTVE0dkp2TkQwTDJQajNtLzVPakRK?=
 =?utf-8?B?S054eVJvazJucGZzMEJZOXBwc0xvcjh1T2gxQ0lveG1GUWJhcW84Y0JHTmdM?=
 =?utf-8?B?SnhIeExPcmEvNUhxS3BvelBvSk1OOEdMMmJ2dDE2Y1dVZjhnWlFGdXFlbmda?=
 =?utf-8?B?cUY3MUhObVpLUDNYSE52VnR1TVcyL3UzWmQzRFdSeXlKZnJvTmNHRzJqdmhX?=
 =?utf-8?B?dU1CbFA5WWNXc2l0bFVqQmhEdUlGcDBEdkRoYkN5Q1lMSTR1c2JnVU9ZaFpw?=
 =?utf-8?B?MEVITHpJVVF2cFlOa2lVN3pIMTIyN3NYdUYzZlpjNmU4MDIydmpKcjJTeStP?=
 =?utf-8?B?VjhRNVJ1OWxNbWJEYk5sT2Y2aW45QkdHQUNrMDQ4dTlXcU1vTTJEenc0THVL?=
 =?utf-8?B?dGhrcVNtd01hVlZDQllkQmsvUFR0V3Rqc0UrVlBYZmc2WXVseEZ4cW1NaEll?=
 =?utf-8?B?Snczb21pdXB4THJia0lvTmUyVngzZE9tWnQ2SVFCOGI2TmM3RjQrcGdWckRD?=
 =?utf-8?B?c0VQVzY2Nm15dmtxaEJoRTZKWEZ5M0MrM3RpK25Xc3RDVVdoeHZWOXBDbmNl?=
 =?utf-8?B?OTN4R1ZGYy8wUmN4MDRDSU44cGpmeERLMFlLck5zUkF6ZzlNOUhiaHFsQkJO?=
 =?utf-8?B?UFk2ZFBFTWE5L3ZtdG1rRjdvNnIyeDNJV0RUblpTTk1JM2VCMFgvMzExQWhi?=
 =?utf-8?B?cXNySU9ZbWlLdkFNOHVIb21Ybk5oNGRoWFBJOElyUVNraXc0SjJFeTZzSVEw?=
 =?utf-8?B?SnRDL3lmeFVDTm1ZNzF3RGVNSFBiR0tPUmhBSmEwcFB6M0dyaTdUcEdMN2l6?=
 =?utf-8?B?UTVicS9mQnJBTWhyWVpqS2R0aGpTdzJWZndnQkd4RHZ4R2ZOTFRUZGlqYmF3?=
 =?utf-8?B?LzlMKytmeFNGZVBGT09VRDdtVWhtV3pRUGdDZGsyTVdCYmx6TnpjN1VhL0JU?=
 =?utf-8?B?aHJwM0hyL3NKeFpQWmhTQXRwZWNEektTSW1EUUhwU3lEa05hcFMyQjFTcGlJ?=
 =?utf-8?B?SmhaQUxaSDZKMkk2Q0ZpOE5aQXB0MzdaYlk5SW1ldVVPZDcrOEd4Z0hUOWVT?=
 =?utf-8?B?cTRYTCtJV3ZwUmxVc2JEUEFrUEJkQTdsbzVLNHllbld6Z2ZzMS9xdjBFMXlL?=
 =?utf-8?B?UFN0MEw3VjNIUGNGTHg0ejE1Ylh6T3VvKzczZHBJc2NhWVpoQ1dwVStWUWJN?=
 =?utf-8?B?TGpFa1R5QzRFRTduWTdTa0FJaDVuMUZ5RjY1alpZdzlFOVhNMVpFR09VSjlZ?=
 =?utf-8?Q?ufYreX9SiX/Ml?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRwbVA5ZW1mQ1AxMDVuMXFVTDVOM2NSdm9pck9Pa1VaZjBnajQvUUZ4RnFo?=
 =?utf-8?B?OU5EZjY5T0VOeDRRTStsOUNiZmsrcFF0akZaNHVGVk40QUpXelhHa3VscTY1?=
 =?utf-8?B?ODcrNDA4L3gxN0dFMkpuVENIenV5QW5xQnpuSW5OWmNXZTlmTHcxQXhpYlQw?=
 =?utf-8?B?UnpBckFpdklRYjFxM3h0UVhIc2pVM0xuK2VzY21OV3J3Um1YeVh3cktqSGJ6?=
 =?utf-8?B?TGlJSVFaYVhEazYxYzcxbC9HVDFCdG5UbENjZXdteTR2Rk1ibklZRWRqZGRq?=
 =?utf-8?B?d1dXWlVCamlSUStqYUtvdElTRjd1aXBHdHBWMSt2cVMrRHFFd0loZGUxTk1w?=
 =?utf-8?B?SjV0VFQrZ3lRalJKSEkrWVlwV2pUQzBSSytubk9lNjY4aFNyQjRnQzZ5UEpq?=
 =?utf-8?B?aFRZRzA4WlAxOTZWNGJoQU9rcE55QzBJR2pjQ1BVTzlTVzAxVU5jZVYxL05o?=
 =?utf-8?B?eGRlNUhGV3dOaGtrbkYrTW9FQU1SRHpNdnEwRTRMT2hCaGUwVGJmcDZTM20r?=
 =?utf-8?B?MFA2dFdjaHhUdW1zRWN6dUt3L1p1RVZIVkNuY0dtMlUzZWRJbXRiQkxxLzRq?=
 =?utf-8?B?VmY1dTY1MDBRKzdQV3lJaGJOWU5OdktrY2R5MWxYWStSQmcvOWFqSTQ2d1ow?=
 =?utf-8?B?cUxmY2ZKbFBET3NaMmpGL0hPb1dtUFJyeHRtaU5ZYUpqWUxucmRsaTVKMnVY?=
 =?utf-8?B?SjQwN2NuTUl2aFNxUVkrTUZ4elJYU2M4cGtPVXN1bTZpVkNESzRFcG5id1Bj?=
 =?utf-8?B?L0JGT0JxdFJpdGNKSGEyeUJCRmNkbVJQZlAwUE9WVEJLeHZHREkvaHRrYUNE?=
 =?utf-8?B?UWxEWCtwVmRLSUUxZFdKT2YvUGxVTTlGcFNZdzQrazZ6TmJ0Z3o4a3c2MjB1?=
 =?utf-8?B?VUtOY3M0WkI0MHBEVUVIbWthYkJnU0NybU0xTUlvQThjeDYzc0dsa0p5L3Rk?=
 =?utf-8?B?WGxHVVJ3d1hGWHFaMklSNnRiN1ozMTdERlN6dHc1ZU1OdEp0ZnZ3MFAvY1BD?=
 =?utf-8?B?M2E5YkxPQ1g4ZzJxb250c1N2ZkFiSXlUaWJUYm1HSCtSVlcxQWdETEhjRWVT?=
 =?utf-8?B?aXByN0NVSWhOQVF0Mm8zeHhtWG9xNFF1U0o3LzZmZFIrY3p6emJXbnJzb0xY?=
 =?utf-8?B?YjVhdXRtWHNFOUFiRDhZQkRvK2JzWmNqMWJaMFBSOTdqOUQ1YUV6ZEF3THNn?=
 =?utf-8?B?TFhIVVN3RHh2ejZhY0p0T0dRNzFVVHZhNVR6N0phbU90VGtpTi9GeG8wcHlX?=
 =?utf-8?B?emZJck94ZmE0MmNmdnJyUzRwZm5waVhoTm1TVFRNMFJSNjl5Q2xkUitCbmFJ?=
 =?utf-8?B?SmxPdEJZa0JUbklrZjFyaEFCWjhMTTFEdlR5bE45M1QwZmdEOC9meDJXQU5F?=
 =?utf-8?B?cnNTV3NtcEZpRnNmcUZCaUE5aFR2ZUt0UWVaR1JQaFQxRElBSEZBRWtwZ2FQ?=
 =?utf-8?B?VEFJWGZQa2hPNm8rdExpaFlHWXQxZnVQblAwSW1aM2I3Y0laTkZsU2hkN0sr?=
 =?utf-8?B?U3dtY2VsQ2xvcE5wU1QxY2JpdzJUOGtrc1hsUkV6QXBvS1lxRFlHZ2Vzb2h6?=
 =?utf-8?B?YTBKT2U5MVRlT05qQzd0YjIxcTNrWC9yc2c3M1k4T29BRGpPZExldk56S1dO?=
 =?utf-8?B?QmNxcTd6UVRHSHRvVWR1cTNVaUdmWnRaNkNYNm5lZm12cld3RVhwNnpYbzdK?=
 =?utf-8?B?YXJLSDBpVS9URWM4L2JPdnJ6Rm5vUmVVQTFsU0pRSXkxZEZVbDk3Rk1UMXpC?=
 =?utf-8?B?WHl6K3FtdStDcXNsYUpxZE1iZUc0M2Nwai9ZY0ltZThiSGVzbHFCTnJNT3Yx?=
 =?utf-8?B?OGgxem84bjI4UXd2WEFZMXRSSXVaeWxoY2grNDMrMjQxMElXSEkyb1lKWGJn?=
 =?utf-8?B?WHdWM2h4ZVFCRWQ4alZHTE9weHk1S3Y3c0hkSGtDTTJ3VmxBc1c2WklTNVhx?=
 =?utf-8?B?WnVRcDZsMGVlb3lqd2E0SFRsbC9vUlQwL01TanNxQzdDRWpjTlp0ZnlPT1lW?=
 =?utf-8?B?NXd2SnlrbmZ2MFZPeDFUaVRUdTlWZE5wZjFXbm9zeEpDbmR2SzBMV0NzRVdu?=
 =?utf-8?B?Z2J1dkVoQmJ3WHBsQk15Uk9ENWprWkY5WnZWckpaWDR1anF1akpLcE84T0V1?=
 =?utf-8?B?M2lYNGdvOWFQOXJCNkF6c2wvSzlYZEgxNkwxYmQxcGxWajVybkRDRXNHdEJT?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85148756-05d8-4b5e-2c91-08dd54d92e9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 13:43:12.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbcqSzWUd0l/oooiaxHgc9fvUhBlxBpkHHFOulQyKiW5QC1cW+r3qvE73M9mIb2Dlg9VN+N3SX893+uajRicSWabj1mP42C23bI/QisOwQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
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

On 21/02/2025 17:04, Bruce Richardson wrote:
> The mbuf cleanup function is not being called correctly on close of the
> driver, due to the vector_tx flag not being set correctly on each Tx
> queue. Normally, this causes no visible problems, because the default is
> to have the vector flag unset, which means that, if vector Tx path is
> chosen, we only free every second mbuf in the descriptor vector ring - a
> subtle memory leak.
> 
> The reverse case - where we initially configure a port to use a vector
> driver, and then later reconfigure it for scalar - causes a segfault on
> close, as the vector cleanup is used on a scalar SW ring, and that
> vector path treats the extra metadata in the SW ring as mbufs to be
> freed.
> 
> This is due to an inconsistency across drivers on port start: in e.g.
> the i40e driver, the Rx and Tx functions are chosen before the
> individual queues are started, while in ice driver the order is
> reversed.  Because the Tx function selection is done after the queues
> are initialized, the initialized queues use an old value of the overall
> flag indicating if a vector Tx path is being used.
> 
> Fix the issue by moving the Rx and Tx path selection before queue start.
> 
> Fixes: 552979dfb1c9 ("net/intel: create common Tx queue mbuf cleanup")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
