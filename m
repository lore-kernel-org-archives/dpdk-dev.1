Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86228EA8109
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9849C400D7;
	Tue, 10 Feb 2026 13:26:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id C1AC0400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770726391; x=1802262391;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7/HI9R8VQhA652gU3U3zxHoradzpiGm4/aaHxqOJOcE=;
 b=IGqyl6Rqbc6CpMAA5yJAOW8FhN7OR2IewMGTyG8gcXXfVAIMIvNWtxzf
 1StFlUXDnu9IwdOKgQ261Fq5Hk0gfLfdtogYODlGP0lcvxCpSnylQFoPf
 24GIK1tUi7S7MAMI3nHNXDfRTR+C7q7kpYxItY1/zblOEhi1z0OQZTW/r
 m7cTRtOzKJayJ3pEcAjghr/eHG8xYAqJ3Y3GBmb+j0WuWIT9Qf8A+35Qr
 cXRy/EQTciUSRT8TJR10L2VJrb4cHRgwD4dwHHB6QjhvfoixJdATFBD9R
 hSWdUsY1UHdbjappIJg8ApthbrUN/R1fn5gVgeQJSR4/2xnpGoo0s6sqC w==;
X-CSE-ConnectionGUID: zZGQzFSrTKCKHXPy3fFWhg==
X-CSE-MsgGUID: q3q0rFq3Tz6eesOWFGqlpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82582350"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82582350"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:26:29 -0800
X-CSE-ConnectionGUID: 2kYPkSTgRE+s5z3zMGzAtA==
X-CSE-MsgGUID: 5uIojjPISpWiKTxatUpY7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216421623"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:26:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:26:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:26:28 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:26:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THsNSLXmVHvbeVYyVGW8Jvgi/2sqA8X6ss6t39CM6BAsYCrBGUTpAWiFqT8eywxN7vRcJo7cLyXMDx61J1JlbH16+rbMk/ZJJftt6oMUbS4pB9BbgWiJmdQ4Fg31eCN6RIknuQDm2x8a87yGiNUt0+uzKu/m1lAyUqaZ1epiPd4UGsL6mbTqBWPVJIaY2pbNCCsFVwDTpu+RdUzxKA8iQ5ClZ502rjErVZKDM7sTaBedXo8Kown8nSBoO47XlEBYl78/bjhLb7tX/b5npIHXc7HGWxmHY1csRyXrGjgjtwsKaLDyOyr9YYdM2xDrAnl1qLxjfytmwR3k80KdMWbx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOUJGny/5gSSZDjSryI0Ov2kZHKSVS86Tr/4z/XkeNo=;
 b=uNtxloOzZ9Gf0tlarHgbA/JBxt9aDMFgBIAnVKWWDQNsRLhT/TvxJsJMxCSbZE8J3eI01IS/NPcPMjnYnvkBSnSsK0w4oAYCQX7iy+z+0CgcXT/0CeavMf6I0T0OjfsT9yUS+HwHHnLPiozUfcBppBEriF4XnSvLmJHi+NnE3NLmZzCdm2Vil8XEhSgzvwUmFnWzEop/dtbh4/UHj6Y6feUQ4q5aohR/sL9hVERgHISkc55aW7b2NtvvvefVDgwGCfP/sLcbpDttazgw1TlzhdzvWmGdtJA1zQh8006eckDWj5yGcetFjFUySu/UPK985CBCa2Ic6wstCX6DZqlGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 12:26:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:26:25 +0000
Message-ID: <8e683730-a57a-4d12-88a1-7268dc507c4c@intel.com>
Date: Tue, 10 Feb 2026 13:26:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/35] net/intel: consolidate definitions for Tx desc
 fields
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-5-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-5-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0315.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd5b999-8a0a-4e6b-c1a4-08de689f9ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXBFcktUeFVQYTZXazJPK3RITUg1T2h6MG1wRFhGcFNFMGdLaStqTWJSOGhv?=
 =?utf-8?B?anRXdXRjTnlHNFBFY3gvcjFHVG55aWo2b3lhY3dnN2lKZklmQUFKMWdSYUV6?=
 =?utf-8?B?eVNrUkVzb2lyemZHcEFOOEU2ckhoZTB5a3QwZ005Z1hsZ2plT1ByRzJmTFZ3?=
 =?utf-8?B?d3BoUVY5TWxHUkxSTnc5U3dNZlNuamxtazJOUlJMVEJSSVhtdjZNRHhEb0Mx?=
 =?utf-8?B?WWVXczBkWHFTK2Nmd282Y0ljTjFleWR4MnhEZExlVDcrRndkOEZoWENaV25i?=
 =?utf-8?B?K29MUnk0L3dmQ1RZb0xvVHV4MHF0Ny9XUExCUnVUTFp1UDJYQXdUUmtQdXdW?=
 =?utf-8?B?QlgvSTJWcDdLQVhFSUVaeWtHSXgxWHd3ZXBTMjRWdk05MWR2ZjR3cStxNDhr?=
 =?utf-8?B?emZXS3Bac1lQdjluN3R6ZVJId1k3emhOYWRWYTRlQXZ1ZjZMS3UxeGhXOWhv?=
 =?utf-8?B?emwxZnZMRy8vcUVVeVhLLy9CNnVrQ2RHYjRIYm9yZUpkZXlTQXc3VTJ5WUh3?=
 =?utf-8?B?NjJFZHh5djNla1VpajFidkFRalhqWjNJNWVTMWU4K2lsN1B4ejZ3UXRCdlR4?=
 =?utf-8?B?bUNNZVVBbVh2UWV5N0Rja0dwalNIc3ZNbFlxdDJVUU1IM2t0T2JsN2YvOEEr?=
 =?utf-8?B?ZXdjYmdVYVhHWm9sNGR2U0lCczBENmUxOTFDRGZSSTI2Z0liald1SSt2eHFi?=
 =?utf-8?B?S3V4dysva2JZd1dDQ240YXNQSW11WCs4MUJRV3FkeURVQWhVMjdDV2l2V09X?=
 =?utf-8?B?bXNDdkJhODhRdkVJREtpY01XVksyVDAxemJvdXEvbWhZbkd4TE5GTm9sSzQ5?=
 =?utf-8?B?MHJ4djYveDB0R0JkMGdPNzNsRVZFVVRGUFBMcGIrWW84SDZCTi9sOUF2ZXV3?=
 =?utf-8?B?elVCbHZJbk9USEFqRkswUHVMWHZLaURDMXBSL2lTaWg2ck53b0RoWWxRRWhP?=
 =?utf-8?B?WmtBQXZ3U3dPemVVTU0xNk11TGV6dUpsbDNZcDFleHNaUTVjZnhuUWkrcEpR?=
 =?utf-8?B?VXpqNk1QTkdLYXZBTWdkcnVDbTdFRkxhODk4THdtRk1qb3lmWUlmbW95aWdi?=
 =?utf-8?B?UEEwbUw5M0Jlckg0RHlUclVqQ0hmcUdtVGVDdVlHU040aGJrL2RtOUZ6UDBj?=
 =?utf-8?B?YVNNcS9wakQwU0NZOUMraHhtSGFPblZTVGQ3TkNJYnU0ZFludHhuRFF1WTlB?=
 =?utf-8?B?c2FjTVozTGl6UjRVZmRtQ05EODM2bkFhclBNZTA2cElVN2NIUzE0NUtzTFZl?=
 =?utf-8?B?MnVld1JFSEpPeVEza2sxTCtNQ0ljZ0wvOXM5dzhOd1E5SW1WOUlmUy80RlVT?=
 =?utf-8?B?cGJzUGlmUEhrQ1VmRGlhTkZrbVd1VHFUUHROSEx4akdkK1NvT2t0RExkbVlL?=
 =?utf-8?B?L3FYZmVPSU0vWFVkYitxenVxNllUUVcxcWR1dGRPR2p6eWU4bnlZT3BFbml0?=
 =?utf-8?B?RVZjTnFxTEZxNWl6WENWNnc3RExnWktqSjF6K3Roeks4RitlWTBzdmZVZThR?=
 =?utf-8?B?ZUtQdW04bG94NUZDdlYwbDgyU3kxQy9adTRrYXBtRFU1L2JRQVpWVk5SYTlX?=
 =?utf-8?B?amtabUZBcE8rTUZ3eHQ0cGF4bGhtWUNXL2V0M1hqS0s0ay9rUGRPREduUzB3?=
 =?utf-8?B?dWptellYM05WRlRlWGJxaG5LM0g2MFNWb2IzdlZ0dHJYOHdOTWx4YjFndURQ?=
 =?utf-8?B?SEtpS1ZoaWNxWVV5OWVadFAxZ2ZjTmY5YTREK0tvalZiWW9TWFNWeEQxMFR6?=
 =?utf-8?B?TGVDMVZxMmxTczhTTis3R3NmL1BySjBONU1rMHJEazkrR2JFOUcxOTdJam9o?=
 =?utf-8?B?RGFJQ3FrTjJrcXN0Vk85c29PeEQxYWxyMlZYWGViNzBzVHVLTDJzZThGTnIx?=
 =?utf-8?B?M2sxTVVBNmpXSDVoSG5KMjJlRmwrNm9HVDc2SmtxdThpbTJxQ0tyR1A3ZnR1?=
 =?utf-8?B?THo1aEZWUmdDM3JWcXZ6cXlCVDdkbFdhQkZ0NytXVEtYZngvR3IzbkxVdnhI?=
 =?utf-8?B?cWxwcStlZ0YxSndFWVVhQU9ibFNDRUJNSjRUQ01sVEJ2UTN4WkgxWDBtTGJm?=
 =?utf-8?B?dFdBaGZsS1lnYVg1WlkvTyswWjJ1MUxuSWUxcEgvdXlWTnZLeXhlUExybGVH?=
 =?utf-8?Q?pp8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVISWl5S2JrMjVVU2cxSWN4MDRDcTZmWkorMDVjU0RFQzhZVmk2U3d0RVM3?=
 =?utf-8?B?bnU0TjFhaGR6RWNNTEJiMDJONDhmSGJ5eVJsRWxzdEtieElFVHRVeUQ3dUcv?=
 =?utf-8?B?Sk95VG9MVFBlVEIrSFVqU0V5c2xhRzhWaEdCS01SK3ZGdHR4aExFOTB2dmVk?=
 =?utf-8?B?dlFhcTllU2JqNE0wZmFkRU5QTFVzQ2gwNXhpa1pwTWJORm1pdklCUGZRYmx0?=
 =?utf-8?B?SkdIUTNsamIvb1NZMzB1NlVQL0ROR0NTM3hJVStQTU9VNzBDR1JmbTF3b3Rx?=
 =?utf-8?B?cXZ4eEQxK245cTlSZFQxOGNIdUxhMitRTEF4NTZCNTdhdVJZMk01M0ZwNUVC?=
 =?utf-8?B?NVorTXVlQUlWc2RHNkx0TVU4b3V6YXpTcGJ3R202K2pxY0xLTjduajlla3FG?=
 =?utf-8?B?NGMzQWo1a0Z3cVdrVnRxdW1lNUlvR0c4ZE9Sd2FaeWFSYVpqQjd5OWxwR2p2?=
 =?utf-8?B?SFY0M21BS1dvZ0dGbURPOTB5ajhrUmlWSGZWQ2NYM3p0T1RubDc4R3JQclZh?=
 =?utf-8?B?dGtNSVgwYlkyaURyeExEZTlNUmxxTHhjbklpZ2FyRHZNWEFpSEc2TjliYWxN?=
 =?utf-8?B?Q09ucnF5dmhYeERtM3N2M0JyUDltb1QyekVVcVlJaXM1L3k3ZmlpLzhCZlVX?=
 =?utf-8?B?azBSeFVjNEhYai9sVUdRR0FsSktXeVIrWWJvZmtTWitMbHZhYmNYVjRkamN0?=
 =?utf-8?B?aUJKU1RwcCtPc05raXl3L2ZMY1hrWEZnSnhZUVI3WGZsbDFHTGM5YWlGOUds?=
 =?utf-8?B?TDFIYUExT0E1RHpvK0xzVVU0THZWZkZKQXAvSEtwbzFVMWhtZXhBZHBmSitn?=
 =?utf-8?B?Y2xrSlA0ZHRhc28za1ZIWTROOXkzV2g0cHN3Vk9jYThpUy91WC9EQ0tESkJs?=
 =?utf-8?B?ZFRjbXM3ZTBHMzZhTEFZK2xKeEQzNDB4OFlKSXpzSWpnaVZZdlZXQlhlNUZT?=
 =?utf-8?B?STlvMlBUbUlsQjY2cFRYM1ViNUFTcER1a1dTTXNSaXNOZlZoVGZPb09oZDlj?=
 =?utf-8?B?ZHFMeEIrVzVUbHRHSmNqUk85Z0Q3dkZKZW52QW9WdFE3N3lqM2k3elpvOVFk?=
 =?utf-8?B?V0xYK2dvTzkrOTc1YWUrSUFaZnNmU0xKVEVCZU1GTHB2T0libEdrWnRlZjdW?=
 =?utf-8?B?WjdQNFNkbnV4U0pjTTlkWE1RWTd2aHE0UStaR3d0a1R0N2RkL0plVWVJbzBG?=
 =?utf-8?B?U0JDZDNnRkdTVXVZRE1CU1JQeVFMZjZXamFBWDJlYUZUVjQ2ZXpaYU94Mmd2?=
 =?utf-8?B?cTlpZzQxSnA2cWVRcDhQdEt3dDZJcTJ5c0M2eXgxdkZoc2VYWmQ2aTJsRVRI?=
 =?utf-8?B?Y2ZIL2c3VnNYZ0dsY09jTVZtRHZZZXgzckRzSFFqSlk2NzNEQjNvUWV2M1hY?=
 =?utf-8?B?dmR1Q3ZKNEkvOUJNUStGWlVxczI5bC9HbU40Vk1xRmNRU1ExWS9NdXNWa0xQ?=
 =?utf-8?B?V3lNYnBvUEQvSkNZejhxeHVGMm50WXdZTitmUVpKTGFUTDRlWFFzNStLajIz?=
 =?utf-8?B?bnhobFRGQlJKa0w0UFdhaEUvRVQrZlFXZVhYWWZVT2ltdjdmWERxVlpUcEN5?=
 =?utf-8?B?M2RqelB0MTU2cVB5S2IrVFA1ZVNaejFxZVVOSHVnZlk3bU5ERVZiNzdJSjAv?=
 =?utf-8?B?RzlrZ3laMmU4WXIwSm9BQWhmL0t1UGhZYmp1RHlJSjdtTGxHQkIwelhIWW9k?=
 =?utf-8?B?emE2MDFsRXhuTlVPSm1aYktJWVJFczlqTU1xa2NsS0VBem9xVU1ibmxTU3Jo?=
 =?utf-8?B?ci9nSEVZSFMrejBmODlpMEpBbkFvQ0R3ZTc2dmFJNDdqU0pabVVLZzA3TVpI?=
 =?utf-8?B?d1ZxcEhCcmowNGFqc1FFRFlJdWNHRXFxU3U3bTBWeDNCa1VkV3RaRjNIQ1Fq?=
 =?utf-8?B?dWRBRFhpNllUeFkyRXF1SlMvOExvZXlUemVGRytHU095MWxGb2xPdG5MYmNM?=
 =?utf-8?B?bWlxSEF6YVE4d0lMSEtnaDlIZFVydDFFcW9Hd0MyWjVBV1lyaDdHUTJtWENZ?=
 =?utf-8?B?ZU1qWC9HaE1TNk52c3BSdzVwRDRFNVpHVUJBM1Noc3JQQkQ1dXhyaFhpNmJ3?=
 =?utf-8?B?TTFyYUxhQVhLSkw4Z2J5UmZTT3c5UlpJVXJOeUs5aW83NExlcE0wMkhSRWxL?=
 =?utf-8?B?aWltRGVWNUFNdXpCVUtORUoxdlNNYUVTYmRXUGhoclhiM1M2d3dQSmI2VXpu?=
 =?utf-8?B?VlBYZkl6a05ibXU1OEsxbTdmaWgwYk5ybWFnSDhGOE5FSHY4eTZkOXcxSTFa?=
 =?utf-8?B?OVlmMVhCMG84Wk5vZzN6ZXdNeXJCbjNCRSs1SkVDV1hEdW9pMnQwSnV1SW5N?=
 =?utf-8?B?ejlpU2t6NjV6dkJ4dWxzTGZpZjFPa0I4dHh1amJRNGROSjFDTkdUV1lxcFJM?=
 =?utf-8?Q?npGkk3GonmWglfLQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd5b999-8a0a-4e6b-c1a4-08de689f9ba2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:26:25.5550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq1ETXfAotJr2Jz5H/hbGhXSs49Uw9KZ6+wb5jP/JO0Zcu12G9Sn4aChfv/RHYYzONtZU5oZSSsc4xNAlxlgs3LUdHcEQcBLxu5FBytMWZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> The offsets of the various fields within the Tx descriptors are common
> for i40e, iavf, ice and idpf, so put a single set of defines in tx.h and
> use those throughout all drivers. (NOTE: there was a small difference in
> mask of CMD field between drivers depending on whether reserved fields
> or not were included. Those can be ignored as those bits are unused in
> the drivers for which they are reserved). Similarly, the various flag
> fields, such as End-of-packet (EOP) and Report-status (RS) are the same,
> as are offload definitions so consolidate them.

Nitpick: the NOTE should IMO be separated, as otherwise the flow of the 
commit message is a bit confusing, as the latter part kinda parses as 
being part of the NOTE section that accidentally got left out of the 
parens, instead of being a continuation of the pre-NOTE section.

Otherwise, LGTM

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
