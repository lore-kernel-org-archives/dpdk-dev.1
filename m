Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2203C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:11:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7BB44021E;
	Wed, 16 Jul 2025 12:11:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C25DB4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752660704; x=1784196704;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xpjUFlcTFiLHUpesS0+S092eGxBmrN6Ho76iwlgeQJA=;
 b=W5bJnznIDZH6DXF95PeO1ouzNBhLXqTKdWXoZEpyAaeMVeT0Hfep2AUp
 bvqRm4pQxnI/hPdyQMfIcoH14RkvLF+EkYZYJeqsw13heUlcrMgbGHFnI
 O5j1z9nEAFvxsCpC32mH41qPa3gWua++AyuBXXP5KmWpQr1jaNfpdyHRa
 fYPEaAeGz1YIBrBdhmhyZ5MjpVYTWEHFfskV7EA+pNy0z++/zKziHFA2u
 y+8GYhA7mUwxGCrifwkqCEc2DU0RihaQHr+GwyiIV0Vs+YTGJGNfJQl3f
 gMopWSTWqDXSS3XUCODTFtvysFd2dYDMrEFSg8cAXEgCZMVhHDCEnUS3h w==;
X-CSE-ConnectionGUID: vk1KmP7bSa6MO4fHvyp+ag==
X-CSE-MsgGUID: tSNHwdoiSoiAdnehJmPoUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42530630"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="42530630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:11:43 -0700
X-CSE-ConnectionGUID: x+tRzbxWRby5BGO82+nqhw==
X-CSE-MsgGUID: cgs6wtBRSP6kFoy5UCxziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="161774962"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:11:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:11:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:11:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUJ/KchaBk7di5Utt1cmlx7146McoMaRst6KrDjIpTx2XQPq74uV3Tm8IEBqRTt2FhsHBPBStuqgHqNEfBCxYHbL8OdjucI39IwtIQjtzUymsFwQiWBx1ikJL3uAag6x++nGcuDY0qj+tqupPh9LkcvcjGC7yCL6j2wZSvck03NMouvCMpjBfOOvXKGS+UUjFJDQdUpJQf2rachsG0Tx3vsKRjj8xvxQz+PLxRdaBJ5gBbgCeOdTN/GRUOgXRH0MbH5RSTIFnmoN/YM9vIffwCDuQST7FZFuz7hWqtTjABAW4CltRoyeo1pZEokwktzu1MIBd7whkxkctbZwd+bs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/PlejLNd+naNuiAB0zqHcC1u5mMCkhEIMoLX/eoFv4=;
 b=spUpowdYr2gO0dmXnxzG16ydtIi6UARl9o40dc5OLFVIHWhP0ThRYBK3Ut43e9eNhjvJ50ioUl8N5VUfoR7YNeJt/MZ+dnBtqtDtq7ZowvL9GKkpGQvJIrbHm9ORvGH1fEBdBojWBGEhqml7NxnZkUO1HJs4+HkkejC4c6vVIwwQ4FVqemuHnKyWnxMKsHhwr0NoaFSGCPTsoZfFdjPWeN/wK4oW50s/tfz7QPhxLZ77o3altGAXHAssUrmzf32Nf/GppvTDvC42CZfiKla/09zej6r+t8YYE/dSCKJOlFSz5BfUlG2WazZZJ7MikQJgTBXNEVhQQgDP6x+Dc5FQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 10:11:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 10:11:24 +0000
Date: Wed, 16 Jul 2025 11:11:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dean Marx <dmarx@iol.unh.edu>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbb4ebd-37ee-4f9a-c8cb-08ddc4511e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tyt5Tkh0eXd2TTFoVmNXRmZFZ3hoRVBRQkh6T1AwUWtLWHZrSnVuaWlLV2pz?=
 =?utf-8?B?ZWhwRThHWmtZaDduKzF2VUQ1ZE5nVjBidzJINlpFTjdXVlJpcWxTSXRlSnM0?=
 =?utf-8?B?VUloWUhmK2pDMWM0Rks2QjRhdE5iSmRnMElEbWkvRkY5Nkl2Z3FuNHF0UmtE?=
 =?utf-8?B?bEFlTTJUN1huOHRnNE5CcXBIdzROMDhya05NRUdzNEtJQWNzUms0L3paNk9h?=
 =?utf-8?B?SXE4d2xDQTV3Zlpvd0FQa2NGR0pCVFZHcENYbUdxK25hc3N3RjQ3L3VNNFlk?=
 =?utf-8?B?Vkc2d2pFVjdhOTlONG1ZOFBrMVYxMDV3OEsvNHFsamZVcnpyWVJWWUZXR1hO?=
 =?utf-8?B?WGVIdWxqYzRWd0UzZ29HaDVZYVNIb0hhdDIxRHdMeDc2VEtNVWppMEh5TDRk?=
 =?utf-8?B?ckhVSEZVQkRFa3pqSFFYZ1RlQkhvUDgxTE5Ta2hWSFMvNng3dExvWlhXbVQw?=
 =?utf-8?B?MWVqS2JMT1NJV3RleXBPZ0c3MkZDZGt3SjNtZm9UMGxxd1lMQUYxcW8yV3Iy?=
 =?utf-8?B?OHNmS000L1hDQnBzWTNra1RsSFVuWHVCNlh6QnR2aVlURHBVZjZDTzlKOWtC?=
 =?utf-8?B?VkVocnV6SnoxTEwyL2d2cnRBcFRpUGkrUDFVQU1BTllSQlpDYVhKQlV2WHJB?=
 =?utf-8?B?Q3Y0Rkh5SVJKWXpGSGFQWVJCRFdyR1JiekxuQWRWeTc5Zy9yMzRjWGs1aG1G?=
 =?utf-8?B?alNwQnU1SHNuTms1OWxlSlhsN1kvNnZuS3orOUorZkpjTzIyc2EzZ2U2WTBU?=
 =?utf-8?B?dEZza0R1RHNTbWRLMXZVV2MrWXI3bWRTaDUwUXg5Vlo0Z3RjUDUxbjJybzhu?=
 =?utf-8?B?NndvV0NsSHE3RnR3TzdDSDNNQThvRFM5SU8xdUpTeVBBeHNUYkFRS29KZTc5?=
 =?utf-8?B?WlJMelpDcmpxZHdDZGhvOEsxYnFRWUNTWTJxeHh5TndmOXQvdXpCMUd1QzlH?=
 =?utf-8?B?Tm05S29TZDUvemUzNDh3UjByL0Z2NWdVbkt0MDJncWszc0Z2K3JpVlJqNmtZ?=
 =?utf-8?B?UElRSU82Mk14ZUJWWDc2T1J4eDdIaXQwUmNqYkdIVng3TERaSi9jL2pmOGI0?=
 =?utf-8?B?ck41Z2tsNHNyN1VtdC9VbFdLU2NKRnR6dFBJaHk4R1BXWFJtTFFMQXVwQ0p0?=
 =?utf-8?B?bk5ScDBpbk5hd29yZVVCQjZYU1NROG9nZUlDS0RPQzJLcEpZQVNIVmlzSU9w?=
 =?utf-8?B?aHlRUW5ncFpnS0VDWFgxQ2VHUERubE5RVC9ZdjlQdFZLb2t6TTQvdUVkYjNF?=
 =?utf-8?B?N3ZQVG9kc0k0ejlkcUpYOGk3N1F6NXBsNFFhQXAvaGJURGJiTnlrVm9hT0Z3?=
 =?utf-8?B?TXJyYkViTkVFaHB0bGkrcEhIa0JUbkkybkUxWmdITnN5V25kNldta2M5b1hp?=
 =?utf-8?B?WUtqaVJYeC90N0p2L2FGZ090SFVjSHpDN1JGcUFDWG5pOWJOQ0lPZWRLOWFY?=
 =?utf-8?B?T1ZNRlN0d2JyL3kxOVRVM1JwY0F4RGRMVFRtbkxOVDB5L3B1YlovV1daa0Mx?=
 =?utf-8?B?VS81VDRkMWRrQytzTHlEVldrbmtLSHcveURzdkFIU1dHUkVmQW02bWFlYlg4?=
 =?utf-8?B?TTVEVm1hWUZCRHA4ajFkS0dFRGhCUmNONmdyVGpnUW9JTFVUeWwwaDd5cW4r?=
 =?utf-8?B?Y1E2eERsRjBzYTA2NFFuN1Q0MGhWRVpSZG1ZeHRVaks5SGNVM1VLK0FTVXVu?=
 =?utf-8?B?SWdEN084eC9BcjMxdVYvalVUekpSNzFEbTJ1U0Jubitxb2NIRDJJVFI1akp3?=
 =?utf-8?B?TldVK3RUYXV4Wisrb1lJanp4SmlrUU43bzAxeXA2MUI2RkJvN3ZqdTB1ZHRm?=
 =?utf-8?B?dzJVZTc2dHhTTXg1RzVBMWp0TFNyL3I0QXJBVVRRYk8yS2RweHZOeWhoSlRP?=
 =?utf-8?B?czJKTTRUYXdWbm5EaUpSanh6U3BaV1ViSnlIaHFGZjRkUGhGMjJoWGJHa2Vr?=
 =?utf-8?Q?pkPSHc4zYro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NLcmpRYUN2aW53QTVHKzgwQkgyVnRGRzJzWXFRSjdweksxRUJ0SVNQRkRQ?=
 =?utf-8?B?bDQyQ3NDY3RnaktYeXVkZVZyTEZFQ040c0ltTCtlV21XaENyRTk2eDFIVjAz?=
 =?utf-8?B?U1hWQWhMSExPelFjc1BDZkV6WFREekkvdloreTltRlJ3Unk4QTc0M0wwOGxD?=
 =?utf-8?B?cnVGRlVxZGlYZ25jWVJLcTNlWDhMWkVIRlVXYWtBVVBJR2ZGbHR3VW84ZUtG?=
 =?utf-8?B?aVVFQldqM280YitqeU9SaFVvSHRJbWFQN1RRSDBnRG1PS0xhRTAxU3lqaWMr?=
 =?utf-8?B?bjJjWDE5RTdCUlZXb2htYWxvakJXbFFkMGhzeVJ4enRYaXZiMW5vcHNGM2dU?=
 =?utf-8?B?WVByQzNRM2lyWlN2WDBCMW5ubUxXb0svdnp3V1o2UFp6YVN0QVNxbVIvbUpI?=
 =?utf-8?B?dXBHNVByUDNaQ2E4RVdiSkFiTm0yanN4Y0ZnMVhPKzc4Qk1SNU5YVmovaGVW?=
 =?utf-8?B?UTc4VGxTd3pYOGorY3NwYVVoOWR1dTVQRUNraUNWTTdVTmZTTER5dGxoZUFE?=
 =?utf-8?B?V09ZQ3UvcHJRelVGdG9CYXMyVFk2UVZlbVp5R3gwYytNWlZ4TUoxR1ZJOWkz?=
 =?utf-8?B?RVJKQ3diVHl2RXVMcVY4aUhJUTVmVGpFVHQzYjd0MVZDOTA0REY3Q2xzQXJL?=
 =?utf-8?B?ZmNVbldtUmd2akoxS09BV0phVHRVenhFSFEzVkI3UWN2dW9Lc21SdjlwUkUv?=
 =?utf-8?B?M1VNbUdVOS9mSWVHZGZQU1QvTXJuODNSdktRYk1KWVg5SFQyUVN6MksvM3M3?=
 =?utf-8?B?dng1dkNKNDk0ZjQwcDBpUnRFOUkvdmtYVGExUkcxeHExYTRiYmMweWFkRndk?=
 =?utf-8?B?OSs4Y3o2RUFoeG5mRHM1S1dWTkNnN3lJcTVCWkluQkJWL0Q2MXNYWlB3RjY2?=
 =?utf-8?B?YzRHQ2t1Wkp1ZkNKMFUweWRGbU9nc1BsK3gvU2h1LzlKYWIvZlpucythVGhS?=
 =?utf-8?B?K1lnWitUYWt6eUkzZXg2dHdNcE51aXE5N1MrR09SbTNINTNUam1jaEZFd1Fs?=
 =?utf-8?B?SGc1RXB2YzBxdnlnZ0hVUXQ1VEpzQ0pLbzdtclJtWWV5d3BJUnJnZTBZQnpx?=
 =?utf-8?B?Z1BWU2g4R3NPZWRIZER6VWRIVERVdnVNcWdUbEpTZENEZFA4SjRZc3dJWGQx?=
 =?utf-8?B?bzZDeUtxVlROeWxPZWdxNmNDaWNjSmlndGhxTUhCaWIzY2ZzSll0MXdrQUt3?=
 =?utf-8?B?VlZNUmVtaytxMjRuNE5jendSSFByNTJMUVZhSmZPZTFsM1JuNkErTE55MGFX?=
 =?utf-8?B?cFpiNU1UQlNBeVhwK0lsQXZ1NFFWWktUMkZXWTMxUVZPM2lWRmFvYWM3RHI3?=
 =?utf-8?B?Mk5YVEVtUFJvdHkwekJ0Q2lOejdXelltVjBZakt3bW01b3NRNkNKVTYwMDNQ?=
 =?utf-8?B?YXZpZW1RaUtoeW1NSGZ4RE85SllVeHNwRG02U2swNEtjS3BwWkpyK3dROUdu?=
 =?utf-8?B?M3lVRGR4RkNJRU1GVmF1aUVkTlVnNmlVOU9aUitoZ1hJWU9TWVlrd2ZXanhi?=
 =?utf-8?B?aERHN244aFpGL29Wd25FSHJOeU9QaktMMjhMWCtlVEJkWTF6L1J6WHIrRVRn?=
 =?utf-8?B?Y2dZdldzQUxrd1pOdko1RXJ5d01YczJzODUzUXpsbENHS1VlN1VGeWpGb2lG?=
 =?utf-8?B?eStzbHpENmNScDNLMFppRlpKckRhOFF4RVlRN2tpK0RWWWtZalpkTGoxUTNI?=
 =?utf-8?B?ZUxiK2pNekhTWWp4dkZyRUdNTnJ6NUNER0NGUUFwZlkwTlByS0g5QTRBOTd1?=
 =?utf-8?B?b0FxakRqNkxGa0h1R1ZlOXJ0VXNmTHVucThtMXhNVXE4ajhFVCtLOW8vU1pa?=
 =?utf-8?B?L3p0WWZXUUwzK1ZLTnpGd2JsQkFOL0dNc3BHdmdPRks1UXY0TGRVdDFNYkxV?=
 =?utf-8?B?YStkNnYvcllGUUdFUWdxRklZSTBOQ0hYWGY0Q1BJZzJqa1RGbEt6SXpsaG10?=
 =?utf-8?B?Y1dDalNkbFdXWTF4SU53Y1ZDcjNPaHJrS0J4UEQvaHdhQTg2NnloTkNFTWZ5?=
 =?utf-8?B?VXUzUnhpdmFUcjhWaDQ1K0x3a2JYZUZ4U2Rod252MXJobkNzMmdDR1RvNEUz?=
 =?utf-8?B?SDJSRHBFMkF5WnJLa2U4cXlYbktSVkZqTHFNZlI4enBwZWpZRjArZHh3LzRo?=
 =?utf-8?B?WmQ2Z3daWnkxUVpPeVh6aWFQRWhFMCtqa2dlVTJvZE1ucCtQSG8vUlNKUnly?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbb4ebd-37ee-4f9a-c8cb-08ddc4511e62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:11:24.0279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fHxwDn8U7/qOUMVcDV4wDYBEkQ+X68pKYLKXif/SMoV39/ItjSIeJdr77SelEAHMga9k2SSTUpRrel/aH2phQUGYsnYWmL8tkVsyGagjzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
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

On Mon, Jul 14, 2025 at 04:09:11PM -0400, Dean Marx wrote:
> On Mon, Jul 14, 2025 at 9:30 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> > not very well documented. Even the documentation that does exist appears
> > contradictory.
> >
> > For example, the doxygen docs for the mbuf flag
> > RTE_MBUF_F_RX_QINQ_STRIPPED says:
> >
> >   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> >   is unset, only the outer VLAN is removed from packet data,..."
> >
> > but the docs for RTE_MBUF_F_RX_QINQ says:
> >
> >   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> >   headers have been stripped from mbuf data, ..."
> >
> > Without a good definition of what the correct behaviour is, it's not
> > possible to assess and ensure conformance across drivers. Update the
> > documentation for NIC features, ethdev and mbuf library to all report
> > the same information: that VLAN strip feature is stripping one flag, and
> > QinQ strip feature is removing two.
> 
> I'm working on testing QinQ/VLAN stripping features across PMDs, and
> so far I've found that our Intel devices are capable of QinQ
> stripping, while our Mellanox/Broadcom devices are not. When QinQ
> stripping is enabled on an Intel PMD, the test packet is received with
> its outer VLAN layer stripped, but the inner VLAN layer remains
> intact. Thus, the doxygen example is more accurate for what is
> currently supported. I'm also running some tests on VLAN stripping
> behavior, I'll update this thread with the results once these are
> finished.

I may follow up with you directly on this testing, because from what I've
found so far there are some issues with our current VLAN/QinQ support, which
requires multiple fixes - some of which aren't even merged yet and will
only be in the next release. For example, for correct reporting of a
stripped single VLAN tag, I believe patch [1] is necessary.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20250714161050.289375-1-bruce.richardson@intel.com/
