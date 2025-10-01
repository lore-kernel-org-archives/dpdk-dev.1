Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2DCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 11:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C69A40C35;
	Wed,  1 Oct 2025 13:13:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6FA3940B95
 for <dev@dpdk.org>; Wed,  1 Oct 2025 13:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759317184; x=1790853184;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=VzFJEwatNfCTiX2NovMf+aHxCNQdZP5L6EOIFFoW/6s=;
 b=YpVbzuphde/JXy2pBcKbANlw0Ox6qvvtaJjynfyDkL+TU5WId6gFA1Wn
 qE5KejKd1itA0LvQZ8dOgVaJoeGkoWDgF0rVxI7s0fwGB9nygL1S3LL8x
 Vk9czjeuQw24lUsfKMMo2zJLU57zT9wfo9VJKdDG7vxxKnPEXkyL/8BD0
 dDkIaLh6+qe1AHQd7CMrkqs1We8/TyX0C7Mz242BAFRjvj5dkTs11TMhA
 vRPRa1T0iM4Ac6w48E8B9domSK9XwqDdPXXJ2Pd6HtY3izgYE0DfEMcL9
 BtUCMj/rIhJTGrDgVOrFgkosyj8tt6/jcVH6NsWWZb2zFdpCMHeF4jpR7 w==;
X-CSE-ConnectionGUID: x13vl6L7RAqUN2u6rnF8/g==
X-CSE-MsgGUID: wobFML7vQD2hOfDZO98NwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61635159"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208,217";a="61635159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:13:03 -0700
X-CSE-ConnectionGUID: fmMiQvD0TDCpnuGwgn9Hew==
X-CSE-MsgGUID: 6ZrxlXX+S9Cvst5jeY4c5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
 d="scan'208,217";a="182788562"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:13:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:13:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 04:13:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF9wBNtdcLFw0f8D5tlaYQiQWvZ2owtutU8ZHyvNHeOLbMs8McYr1M/p2KCV1gC9thm6t47PMpGV3R1k/R/lnL+9wQB+HkiWptg6eXJlgNJW9IV5T43JEDNVxlNHEDfuGKzqRXUxQuAG7TGblUAfE6Gknsw5yAlpjZgSvIgAH6Bas93UkGKO4ERlenGQAv9vRKCsbd3K5lElYfvdJSjd6vQBkYt+tCq8Rf8GQ9M7pznC969eNaD19dC2O0uXFtIv1AfceNTZOQynr+1FaW2KJXifEcFcO7ZsIQwVS0D0ccnnRE/cyZlOfAWR3lruumNYVz9lB6V3CL3r41+a835P6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujkbJe1JuS4CxWvFEvUVlxcGxwH6hA72w7qGTQFLNeU=;
 b=a4+W2AoIzbSKLQl2Y4S50nnjsx1pr4x9SRVWPrlXDb5sFsJegwtZ69+d8u498YSflTMJlRVuJAJs4fE0jGjErfilTIcxsWVsdJ7pVwQMvUUn2NJ7bonts/PJR9LS7nqoOYiBdRqw9vnqRO0zRnunyl1jWzZGVItLUSFGyT8VDK+gfGaiZx3Qpj8LpYvqdbtRAYlqzv9EaqX7mBTTxvaGrOFSnn+VvjDWZnSdiUGSnuEmfoyYOqzhbm7B7uSN6uLAOWLD3KWXt3tDb+lEtSBUb0rNORpuHtINdikMPuF7qKRSJGyW24w0PPWhnruaod1I4CFSQZOBgMIMO6xrU8PYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 by SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 11:12:58 +0000
Received: from IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b]) by IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 11:12:58 +0000
Content-Type: multipart/alternative;
 boundary="------------5mQw0Fu4uWh6t5hASk0x12p6"
Message-ID: <24ce84f1-f131-4c0b-ad2a-f837a0a90e16@intel.com>
Date: Wed, 1 Oct 2025 16:42:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] net/intel: add vCPF PMD support
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <dev@dpdk.org>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
 <20250930182718.2997819-1-praveen.shetty@intel.com>
 <20250930182718.2997819-2-praveen.shetty@intel.com>
Content-Language: en-US
From: "Singh, Aman Deep" <aman.deep.singh@intel.com>
In-Reply-To: <20250930182718.2997819-2-praveen.shetty@intel.com>
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To IA1PR11MB6074.namprd11.prod.outlook.com
 (2603:10b6:208:3d6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6074:EE_|SJ2PR11MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: aef83c2e-480e-4b31-0176-08de00db7a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzlYQVE3YUNuTjdscDRjL2NEZzk3SnJoMUxubm83eC8zSlBiR3BveWsweEE4?=
 =?utf-8?B?QVVORnlPSzdod3gxa0VqVzBzd2VHRURFMytLMTc1L2VtV2tSQzVEZTVNd29R?=
 =?utf-8?B?ZFVFMHZZMnBuTzhtVTFIM1VTYXpTZUNXZmIrRzBSNk5iWFo5K1F0SnRYaFNC?=
 =?utf-8?B?MGVsdHhKTjJuOHM1UFM4eFV2Y1pTcWJ3Q0xpeEpLQS8waFFhSFVsRGl4RVVR?=
 =?utf-8?B?YUd2cFVVSnBTMHM5TnIxN3FvNHZ1Z05jcml0MTkvWG1QZjJHVVZabVBKaVBM?=
 =?utf-8?B?M296QnpHQVhpdEt5d3dSSkV3cUUwcG85eFI1R2MvZDZWWTdPTzl1S3I0U3lR?=
 =?utf-8?B?aURpNjNWY0JJR0JybmMwVVdxL3ErU2RQU2VmckhSYTFRbVZSZHBLNDdtTG1J?=
 =?utf-8?B?N3Vta2hsa2RhWDlvZTF5SzhZaGVWeTUrVytVQkQzWm5CYXhodUl3QnVhbSsy?=
 =?utf-8?B?N1gwaEVlTmZOQzdtR2NzOXBsa1RBUzFFR09kdnVjT1RpU2FzOHU2ZDhZS3Ru?=
 =?utf-8?B?Z20yZG0zKzg0ZFNoeWkrSE5mS2pTaVA0NjFvUkZENk1xeHVGaG9rRWlFTXBm?=
 =?utf-8?B?WlRVY21lMVkrQzczQmVZelVDbVZUSVpORXpBOXdGakh4VnpFL3lWamVUMzZk?=
 =?utf-8?B?ZDRoSUJDQ0pla1RGWDg3WlVKLzF3UVhNWFAreWNjMXFoVXY5enFOWC81NUhy?=
 =?utf-8?B?NmZ6dEsvQ0srNWdjcC9XRndnMTFlY1pyL1pQcFdZNlhWTUQvQzBHSEJVRlJj?=
 =?utf-8?B?MzZ3UWVPWFJ4MHNvdDEzdlQ2cjRXTEdOUWVMaGc4WXRGWFlUTGVPKzBlSytx?=
 =?utf-8?B?ajB2Zm9tTDRpYXFnVzVxNkcxQm9pNDZVRS9QK3hPRFR0UGZyUWk5d21jaVRC?=
 =?utf-8?B?cUVtTlBJM0V1VHBpenR5SkNBaWRJTFNocjJ1aDZ6Skk3bDY2dmM4VDdqeEZC?=
 =?utf-8?B?QWZHdnROcFFPUnZBZTJnaTA5M3puSWNibHNkZmI5anVxWXhDckVhd2t5WVdo?=
 =?utf-8?B?QmZadnRFVlZITHVBajYwRklNTTdXbEcyNS9lTjE5RGxLL1gxbEFBajRVeXMr?=
 =?utf-8?B?dUlTR3NHUmJCbTBqMjNaWk4rY1NoazYwZTRzTlZhbk1WM2loOG9hakhQMmZz?=
 =?utf-8?B?dXRPNStMRDNtUy9FY1dUT3I2VHBkTGtpYnVKdkRRd05NQnh6SjZMNXByNVFh?=
 =?utf-8?B?TjkyUHdEeExCcHhLNjBqM0J1dWo1enpUN3pSYjVUK2J1WDBYeTdTTWFGYXNq?=
 =?utf-8?B?dWJKdzZpeG9KRWc1VkU5MlV1bmp5RUNOSlFUTi9hTW80NWJtNXF4c3VRY0o5?=
 =?utf-8?B?N2NBY3dyVkw5UnMzSzZaZDd0aWdTMFFFZk15YXhIWm1UTGRvYkFqRUpjZ1BH?=
 =?utf-8?B?emNXWXVITExHUVY3bkNJWU9NMkNYdzliZVREbWlYbGQydG9FUWg5VFFFT0lZ?=
 =?utf-8?B?aUVBVEZCc1AvNFc5VDBLU2NXcUxsQTk3TkpOcnpNUXZSUG05MGVOT3M1SVZT?=
 =?utf-8?B?N3NxMVRJc1hFRGlESjJyMUdvZ2IvMEFmVHdWWHBzLzNmVHNrYjJuWDNGVUg5?=
 =?utf-8?B?S0hPUEF4K21kMjJsRjBId0Y5blIvSjdBVVF5am9ZaXZqZ3Z4V1VObHJhOHlX?=
 =?utf-8?B?ZVNWWjJVNE1pRGw0UG8rcFJnQUIxQWx4alErRmd6U1VHTjJuNDlJYnNaK05o?=
 =?utf-8?B?ZUhVZEFlVW1LNjluZzhFbm9ZcjNhSC9JdW9mYkZRUW9ESU8zQmxGVmMrcmJH?=
 =?utf-8?B?Qk91eTFRK3Iwa1hhMndjQktqYkpvK0JOT3ZwUndzbk5wLzhuMDZYOEFHL2dS?=
 =?utf-8?B?Y3ZBWjV1dUtMM0FhWUJmcE4rSzlhUkhFYldZTE1kcnpEaTIyekR4SGxNTVdD?=
 =?utf-8?B?Nld5N2wrbTlIdDlPOHkxSjdlMnlHNncrRGt5Q1RmVFROMjdEUTZSUjFzenhJ?=
 =?utf-8?Q?INAf36r81NaXBD9Koi9mt53l02u/HVM6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6074.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZxOERPWm5Ld2VEL3JiRU95TzNiQnJ0YWpaUWMzUXBhcDdDMnQxdFFTL3Fv?=
 =?utf-8?B?UXl4L2FzbXJ6M0lENnVkUkFzZkZ6aTE2d3M3V3FpTnF2dGpYMS95RVZMUGll?=
 =?utf-8?B?UnJjd3lsOUUvaFBXUCsxUEI1ck44Q05xcEpIUUUrWjZWVDRqU2h4cWZFTitr?=
 =?utf-8?B?K3d5ZXptZS9pVHJxMXJMWG1yRGVlMnN3TzRrWHpzZ2g5b24vWVU4VjJLZFJl?=
 =?utf-8?B?N1RJSGI0OXBPWDFsNFNZcGk4Nkl1K3AxamI5dU9tRDlKblNEaUFvTDlCdE9G?=
 =?utf-8?B?UG1tazAvSE93cFVkRGVoY1lQL0MwUXBuZjBONVJ2K1VUaDhLd2x3SVRPVlU5?=
 =?utf-8?B?WFRjZlZ4NFZtaEp6MWxtNHZPWnVPa01PV2JRU0tvNmdHSUswSWR4SFJlS1FQ?=
 =?utf-8?B?d2x2TmlMQzBqVWI1aEYzNi9XMkJ4Tjd5dnZLYytweThkY3dVdTZvczM5V0g3?=
 =?utf-8?B?bnpzTTJrZzVsZXkrNUNVanYxNXVmdlI1UW9HbGxpZDcvRVRKNEtiWUpKc3lm?=
 =?utf-8?B?UHRFUDdZWmlMRlEvK0JHKzVMa0RSYnRxRWVwMjljbkRHVCtEUnlrV3JNUFFm?=
 =?utf-8?B?OW53MmpEUk4xTUsreG04cDFkMW5xVDZCY0VmU1NTS0NwOVhOZUNmWkNHVUtB?=
 =?utf-8?B?UFo4dVN3VjJDMHNVOHhSRmYrREp1UEtXc2RONHNDNW0xSHdKa1Z3cE1tNEEv?=
 =?utf-8?B?czdzU2FIVHprNEp3eEZBUWZGMXBUODlwc3Y2R09uWGdOSUc5WkJmT3prTnBl?=
 =?utf-8?B?V2haN2tIVzZLN0RjQXNvaE9EZVRucDRwaFFoU2h2RjBKdTIzZHpqVVNpZnZR?=
 =?utf-8?B?dWFoWnNmSUw4ZlI4bTVqNUJaVU1tdDB2QlVIQ0NocVNRQWxubkhiZzc4bzkr?=
 =?utf-8?B?cXJxZzJlS0ZENlVHdE1ORVFrUm04akhUQzYzM0FlQVVUdG5EcWZWckRTVUVu?=
 =?utf-8?B?NXcyTGhtZ08vRHJkVldkNldVK2tmcVZlb2phZzk2TkNRbUhnRzdodlRZbUtr?=
 =?utf-8?B?RGhIb0VBWUFUZHp4WGpOT1MxelVvUFBvVW0xSENxZUJqWjRMZ1JabExwR3Q3?=
 =?utf-8?B?ekdteHYrdFlJWFo5UVVoWk12Q3gxbkNWS3hZOWZVRFdZZldFdXhmY0h2Ykc5?=
 =?utf-8?B?NkswYnFiVys1WFM1YnhvUDZOeDc1dWVBVGU3TEpjV2hmSEFxMU9ZYWZIcCtu?=
 =?utf-8?B?RjJDamF4ZnBaK1J5Sk0xSVFuUnUzVHN1aDBaeURsSDk5a3VONFFra0JaRWtu?=
 =?utf-8?B?UWlJVUFVK3F4QW8xOFRuU3hYREIxbjE1VENLc2RwT3R5bGRRL0g5ZHNiVURj?=
 =?utf-8?B?YlJvY0JmUmFuV0VuL243N1NId3Q1WnAxUWZBdUhqcVJWRktaUGFuTGhrVHBM?=
 =?utf-8?B?cGlHN3FlbjEwbXVCZVcrekpDdmoxZTNiOXJYUW9zb1l1MDBqWjVsSlNkZ2Y1?=
 =?utf-8?B?MUZqVit3YW45RmVtMjJvdlpaU1BuTVdsWVY1VEcxUXgwMnN2Y2g0QUZKR3E3?=
 =?utf-8?B?bi9iZTg3aFNQV1NBNnpENG9SY1RONm9tYWhvcmk2QmljY3Rpd3lKOVAzbjZU?=
 =?utf-8?B?cXNCQy94VHVXSXpaaEhLelh0VE0zQlI1eUhSMXdBZ08yWTd2c1JFVzNGVHFm?=
 =?utf-8?B?YVQ5V2Z4TnhYQkhtMkZLTVZyM0djNjU1UlBVc2VlZW10UnFLR0hxNkNCSEFP?=
 =?utf-8?B?YUsxdzV5d2k2Zi9UQnNickxNdFh0aXJyVDZ1eGJVbWVqR1pjYW10clZEU1Fq?=
 =?utf-8?B?bllmbnEwc3JvVW1BOE5kZGhtWmlIMVhMYS9oTmYwVVh5QzJiZ3c3L0gyTDNP?=
 =?utf-8?B?eEE0c0J5c1hhcVNUNDE2aDAvWWprTEpUSUY4c2R1YmIrZG1ad0VMUWdueitS?=
 =?utf-8?B?TkpXNFkwTEZmVWdOUGtaaVUyRnRaV3B0WTBqYUgzWml1WVpqcURrNENtNm9Q?=
 =?utf-8?B?WXpldjA0MFZsOWxhVTZ1R2pLQnA5akVaZS9RNFRZKy9FNXJBb1M4Y0hyNFBo?=
 =?utf-8?B?UkRSWWlQR1JhNURCNWZ0TjJuODJIdEVDQm8rUXg5d2tta0lpSitaZCtmMlZY?=
 =?utf-8?B?WkYvZGxnVGx5V3hjWkFmSVdpd2hZb0pmYkJRamZaeVNvNTNveXNUelJIRzBz?=
 =?utf-8?B?dlhnMk0veFk5Y0RwRVoxeTAxcHBMMU9jdnM2eGswTDdnZFBQdGtLUE9YbWtU?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aef83c2e-480e-4b31-0176-08de00db7a08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 11:12:57.9931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W3nxfoXVORVJGMZ7MKcyYMxIQBiuqCnqBiPiv9p3NpXy0GY4F3naTk31CEqrMKtPFoLGhqTl/19Ofe7HOyNBzXl0LegttM2UKlq8FS20Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
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

--------------5mQw0Fu4uWh6t5hASk0x12p6
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 30-09-2025 23:57, Shetty, Praveen wrote:
> From: Praveen Shetty<praveen.shetty@intel.com>
>
> This patch adds the registration support for a new vCPF PMD.
> vCPF PMD is responsible for enabling control and data path
> functionality for the CPF VF devices.
>
> Signed-off-by: Praveen Shetty<praveen.shetty@intel.com>
> Tested-by: Atul Patel<atul.patel@intel.com>
> Tested-by: Dhananjay Shukla<dhananjay.shukla@intel.com>

Acked-by: Aman Singh<aman.deep.singh@intel.com>

<snip>

--------------5mQw0Fu4uWh6t5hASk0x12p6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 30-09-2025 23:57, Shetty, Praveen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250930182718.2997819-2-praveen.shetty@intel.com">
      <pre wrap="" class="moz-quote-pre">From: Praveen Shetty <a class="moz-txt-link-rfc2396E" href="mailto:praveen.shetty@intel.com">&lt;praveen.shetty@intel.com&gt;</a>

This patch adds the registration support for a new vCPF PMD.
vCPF PMD is responsible for enabling control and data path
functionality for the CPF VF devices.

Signed-off-by: Praveen Shetty <a class="moz-txt-link-rfc2396E" href="mailto:praveen.shetty@intel.com">&lt;praveen.shetty@intel.com&gt;</a>
Tested-by: Atul Patel  <a class="moz-txt-link-rfc2396E" href="mailto:atul.patel@intel.com">&lt;atul.patel@intel.com&gt;</a>
Tested-by: Dhananjay Shukla <a class="moz-txt-link-rfc2396E" href="mailto:dhananjay.shukla@intel.com">&lt;dhananjay.shukla@intel.com&gt;</a></pre>
    </blockquote>
    <pre>Acked-by: Aman Singh <a class="moz-txt-link-rfc2396E" href="mailto:aman.deep.singh@intel.com">&lt;aman.deep.singh@intel.com&gt;</a>

&lt;snip&gt;</pre>
  </body>
</html>

--------------5mQw0Fu4uWh6t5hASk0x12p6--
