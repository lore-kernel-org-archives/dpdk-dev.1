Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DCC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B38840B8D;
	Tue,  8 Jul 2025 14:36:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9EBA74028C;
 Tue,  8 Jul 2025 14:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751978183; x=1783514183;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ki3uXpAFK+U7gvhpIN+zOUABa8ymV8N9eOn4lB+VbMI=;
 b=E1T/k+Y6LQkQ4vEq5u3rldQ/RJFCWWKTAUsXQu0bI4JjwL90Wok7vyZP
 pIx4oqrpcMblw/FfaeHTPD1AnTIXpX3PtNpuDFFISTYPJRUVsVBe/W2aO
 y9Od9tyPAV12qNurnZtAC1FMOVEwRUPrjb9QHD5EoO5HwD8d+ayeUP8/g
 3iSrRHQtKKZGKEwrV4Lg+5xIrK7dPbvAzSSWQSO07QZt7AhUPuFn27RH2
 ZcwSERYYiDgwDGmBanB81ZdPO6hRU68r0Iu8rf8ABOG4DsVSJODLyOc9T
 w4tcPU4p9F3oMus9QTBXXunKG6NfJfMnY5j5PVASFTRKzUoSZeG+2eR+A Q==;
X-CSE-ConnectionGUID: rNmD2ufwRzCHjHpm8Okohw==
X-CSE-MsgGUID: Vn985P69SayYKOcbT/oz2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65670959"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="65670959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:36:22 -0700
X-CSE-ConnectionGUID: HoTrV7GvT12o58G2ffQBdw==
X-CSE-MsgGUID: /xuaJgIDSOKKRdT5dj1YQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="179164516"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:36:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:36:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:36:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwN+gQIXyFHJLBkeOJeRswknoQ4qh1U8ZNtPCH0fM3GM1vceNni1rP3KwEpo/fGDpHC1AleA1ph8R670iAEIr/DVH2dveg6wKVqTxKrkrTklMpBJp7pFizYXmjwTr+pnnrzdIoxTXN9KmFo4saPrZwGXVMe3hhv1sPfVo1+DEAYvIhOXedD+E8eQJBekiR1hUHA8Y9CW4+tkhrc/tITAaCeunOOEf01ixYBJ8TKteYr+3p2rqNL50XY9cyKJu4SOt6qhZNNHk0CW7xfEp0uVwAldSRW7cPckSu1YxAxSnNCbeVabiFyCNGcS7IrZVWxva9I466c6WdWuXms+Q3sBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6uxCYIiKzE88Tp5LS+JtDG5NvGaowz0a5wlFNi4LuU=;
 b=iw1WpWGcIqcSe9QLhDipp65pS/gtoFpd/1XdOUxr6NuM5P/zL1DEEdl3B6PI0RetZpjgv2xPSlxPaxLvpQp3Z1U+QecBE8/3I1P00Sgx3pZOcLfdllFRBlxoNIFazHUEk6m4XaKJHvSFjFX0q2yv6oJ9bERrvNocBpYMxzBlFhXDxQQueZ7lIvjGboIIko/yXZayZfHM/uENtfKEnf1NHWJvQ2rmyeUzBlyMfRCvGsoCYb/xL1G/MxZsQEMazPIpiYCsHws8kvr4+ZM6TwADrYxma2IKvaXVDD+P0JLXXgrVlKVeDvs2AnrO/qvlpqDm9m8atd5nQbLQY3RsJrkEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Tue, 8 Jul
 2025 12:35:38 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%4]) with mapi id 15.20.8880.026; Tue, 8 Jul 2025
 12:35:37 +0000
Message-ID: <7ba1b4f7-8d83-4467-b1bc-6e5bd5ac1687@intel.com>
Date: Tue, 8 Jul 2025 13:35:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/18] hash: fix unaligned access in predictable RSS
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 "John McNamara" <john.mcnamara@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-9-david.marchand@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250708122823.3406288-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS7PR11MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: c3baab06-0a46-4756-7009-08ddbe1bf13d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWVLL3FkZFlUM2llTnVBZTI5RXlLVXBjUXhnNm9pQnFJRHBOME4wcit1bXd3?=
 =?utf-8?B?aTkyVmFTVEZMcDJYd0pLM21EYVJQeVV3aHdDT1JuL2R5aTFydzRPN0wzSk5z?=
 =?utf-8?B?U2tIcGtVQ29hSE5CTk1mb21abDk1T1hNcHVXYlkxbHdKM3AzaGZXK2o4VW5B?=
 =?utf-8?B?NFVtMndGNG90Vm9CVzYzei9YQ2lTVDVkRGFhT0Q1NjRVdkM4VlRnc3plL2xt?=
 =?utf-8?B?b2JQcUhVT3FsZkFrUmFFTWVpOTF3U0hFL1JtYW1udzQ3M2N2YWFGZGNsaUtx?=
 =?utf-8?B?Rm4vTnRTZTU4SzBGYnpRMmRidkkxYXRqRXc2czhPYUpsZ1oyL3J4aDhISFBw?=
 =?utf-8?B?SjNXWDFiQ3g4UW5SQ2JZVHlvYy9Ld0FPN0MvUnVCMVFRVXFBR0Y2RmVKSDFy?=
 =?utf-8?B?V1lMM24zZk5ybGFOUkUrWk9Sb0trTFZZTXlnY3B2RjA2a3FxZ1RXOHQwa2M5?=
 =?utf-8?B?Tk5rWEh1T2I0VnVZZkhFNXlldDFpNW5LZjY3VWhPbTM4S1ZHVXBOcDBjdzdU?=
 =?utf-8?B?aitvWkN4SU12WmJxUlB3RjhpTkxRZTFlSTZFc1g1alRFekxKQitSNmk0SG1n?=
 =?utf-8?B?dHllVEJ0Ry9Oek5DQUVreVBhU0xSSEs3Vk5wOXJLQk1icjkrUWRFSVJzMDRq?=
 =?utf-8?B?eXBYMUEwTnR6RERFOFRCeWRkKyt0ejRDVlZuVEh3RVhOM1NJNHI3ajRCVHVJ?=
 =?utf-8?B?ZUlUdW1YdVMxOEM5MUMya0lPcGNpNzQzNlp5UnZwdWJzTUFhQ1RLcUhTVUF5?=
 =?utf-8?B?NG8zK2g3Q0FsWkxpQnRDYzR4K1pRYWVUeW9rL2xqMTk4TFZOSHl6bElwZFNB?=
 =?utf-8?B?TnJLblFrdGVRRjVORFZkaFhldjhUbkN0TkE1VFZsNGQ4T2JmVnR6MHUycTl5?=
 =?utf-8?B?Q1F6bjVvUmFHbS8zVkh0dkVSdzhMZFdJNGMvK0p6cUpsYTEvanRnVXJ1S200?=
 =?utf-8?B?RUxQL1FUVTBPcDNrd1VkN2RFdEFVbm15eXV0WTFYckJsSUpBQ3p3WkRicWdi?=
 =?utf-8?B?eGVPcmxGWG10dm0rM29TQWtwZDFiMmk2S1Y5MGhvRzRZR0J3Z3ROS2lJYUQ0?=
 =?utf-8?B?c0F3VXRnaGg3WXFiT0E5ZTZ3TVBuM3VXeDM1WmtKS3RoeE1oMmpIMFlPTGVP?=
 =?utf-8?B?WmJDMnZyczFwSFBKK0dzc1VIL3ZzR3pPaXRLRUVub2l0cWxYZU4rVWY2ZDZB?=
 =?utf-8?B?QmF2YWd2VFBOZGtJZEFYME4wcGt6YS9WZHR2OXRWczVLRGxUU1RaUStWdm9z?=
 =?utf-8?B?N3QzZzlhbFg4aTIyVkRsR21sWnM4ZnB4SkZTak42aldpcEg4QVBFVDBsTm1V?=
 =?utf-8?B?N1UvRWpXdW43MlZLVWtJNXcvWFJZSDRzNGlDNmJMZ2NOamhkOG9kRFUya0lr?=
 =?utf-8?B?UEpJb2hjdXNTbEZMbEFJSzdQa1VWOXdJZ1hMUEw4VmE1NUVMUGpZTmtQNnlX?=
 =?utf-8?B?Wkt1b2ZpOG9zeTQ3WkNBR2ZobWprd2JHcjV0aFZBZFhub1dJMlVxb3pUTE1i?=
 =?utf-8?B?VFlpOFlNL05MRXpjVDlkN25kNW42WU9MWC9pM0hHSngxM2dlQWJlUUM0UGFy?=
 =?utf-8?B?RUk2U2x4VjBpYjY2NEJidS9ZZExNcTcwTld3NmdLV0lGbEZYYUdBZk1Ja0xU?=
 =?utf-8?B?QVd3TUsrSW9nQXBnVzRkSE5GZ2txWWE2L05oRkc4cDJVQVlEbUhaRUptNG4w?=
 =?utf-8?B?THh6QTdGdFppckttWjJIUFVIV2tnQXdHbDdrYnNTK0dCcXFTVmVjZVcwRFA5?=
 =?utf-8?B?aEt2Mk16MURWY1pFY1JjMUxCcExJczBiUGp1MzRZRFRxaEErNWRDd01kM2g4?=
 =?utf-8?B?a01IS1NDK0V5UUpaL2FhNElVb2hjMUFneUgzcGQwWlQzb1BUN0JpMlQ1ZnVI?=
 =?utf-8?B?UlN6dVl6dFhHYU92K2JNMVJ5UWs0UWxDaFdNeThGNlc1NHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJxSUNxSVNNSjlPMy9MLzZDbjJqV1RVN2UvQUVuN05EVzUrQndXaWNIRFpH?=
 =?utf-8?B?aFVuTzB5aUVxOWxzYjA1eW1naTdpL0JkVU5QTmM2N2JpK3lubXRCWnBPeXFH?=
 =?utf-8?B?SytxT09aMXV2ajhoSW1pdHVlSXFtVGZJWWg4OUpJb28xWnZPaG9EcEEzY3I1?=
 =?utf-8?B?Y2ZGUU1WN1pwa014MjVpZjlya0tjckcvR0J5RmU1OUJVOHhENkxOSmNDRk5R?=
 =?utf-8?B?dGJMa05QQWhBVTZyUlJZaWNBNVl2enAyYWNNaHozdU1DWjIxUkFoVmExNGFK?=
 =?utf-8?B?UWo4VDVEb3l5dG8yalR5UnhFTXA3dnFnSFdVb0hkNG9GZG1naVE4cWtjaTVr?=
 =?utf-8?B?RHp6VktpZWZRblRPU0Z3S2czQ2I3MTdkSC9LaFBhOTR1ZHZ5eFVsTDZISWVB?=
 =?utf-8?B?eHk2Q2MxMVBzejBRQnZkQzZBZHZueHBVNTZCck9IcGl3eHpUWndtS0dwcGM2?=
 =?utf-8?B?dTZkdVNWNDVBTjFYUVRZdVFvRmN3cHYzUGFyS2FqTjNLUm0vQXV5RVFqS3lR?=
 =?utf-8?B?OVFCS3psZHQwdkJ5M0pSOXVIT0lWcGhRWjVodi9oMnl1d1FjTXh3Misvandp?=
 =?utf-8?B?Y1VacmUzekdtRnlJeExHTFhDbmdVUi9oS1J4S1p3WXdNTjIrZVQvNkJBTytY?=
 =?utf-8?B?MXk4MnllWVN4ZDJhRGVZVWF3dmpydStSNFRpME9kbW5TWE1ldGIyRGNYVmJn?=
 =?utf-8?B?NGVXaGVFbUhaYmhTdmVqaWE4dExkQTRlWGVickJmVlg2U0FhT0lvVEZkRjJk?=
 =?utf-8?B?Uml4U3lQaHVnam5sZnBEbHZ3U0tlcmIwVERzTk10eXJSZ1k1NlZVY0hyU3VF?=
 =?utf-8?B?aGViWmg3RzJ5UWpVTFdKRlYxaEpnWWw2UVlHSWMzSE5tUFZsV2hLY0dhQXB2?=
 =?utf-8?B?U09uOGhVeTJwMVhsVjBwc0tUYjRBWlNwTXFOOEU5SjdYanhoTjFseEVYV2FX?=
 =?utf-8?B?UnBKakxyRTdqMHJSY0tTT0hueGMxTUZQUmtBYUVEWVd5a1FINHB0VDhkaHgw?=
 =?utf-8?B?STRyYXU4T0pPWjBsZWw1ZjA4OEc0VlljbFpvbG1hbGhDV1VabThCVXVJWjhM?=
 =?utf-8?B?VCsrZmYxN3FnTEpjU0ZXeVFXNFhZZzBzUk15Y3hPYUhRdFZNM2lKRXRPWS95?=
 =?utf-8?B?Q0NET2JzN2krY2J0SE9oeURpYWRlbzhMa2huKytxQ29DTnlKa0MzZ0ZIYndK?=
 =?utf-8?B?dlJ2SlBkY08vdEpjRk9JUStyS2dnbDBNUG0rUnA4L0ZTY0lXWjhFSUpRbGVt?=
 =?utf-8?B?RllIbHZJR21naVlDMFpTeUVLOC9FTnpmL2JwMmxkZnkrVTBYRnM5WUlmc2lN?=
 =?utf-8?B?VlBSVzNCdGE3NlJjNVFnMFc2U2dmUlNOcDExSUFvR0M3US9sdVdsaWF4NGdo?=
 =?utf-8?B?YUdYd3RmRUQ2ZmJ2eVNFVmprQkpob3VoVVlBcHZ1RkxsbFUvUWFuY0orUjEz?=
 =?utf-8?B?OU5KbUhNZERNN1IvME4wYjhwN3hxMlRmNCtjZkRTWUw2eUhibWNiamludWZk?=
 =?utf-8?B?T3B0YXF3OFZYRzl1WkkwaExwODd4TGJVaVgyU1BCeGVUU0lPaldvdmc4bnkz?=
 =?utf-8?B?eHliQXZkUnQ3VUJybkdPS293b2Rnc2VMMnB3aXZ0SzhrV25UNzFNZ2c4bHM3?=
 =?utf-8?B?UTFlMXA0SHF4NjdsVTNBU2haRTlsSkxHQkhIM0UyUUhUcW4xWXNodTBYRHFw?=
 =?utf-8?B?S1pNd1NwaDd5WVlyT3VQOVZrRDlrNmZDWVk4aGpYcXMvWEthdXlwQlRka0JG?=
 =?utf-8?B?dmZJRXNEeHRTMENucUpnalphQkx3YXo3enc0ZVFKM3UxRkNlTjZPZHhrdFZU?=
 =?utf-8?B?WkJNVDFNVHllaFRjaG9HaW5odWpLS2JnclhGWitPbDJyY1NacW51YllNR0hP?=
 =?utf-8?B?Z1NFaXlqWmdIQUwxU2htZHN4dVpNdS9TcWo0a3ZreFdiQjROMkNwcGRNbEpS?=
 =?utf-8?B?TGNwS1pWc0xVYTZaNDc2cGE4WDlPTE5tam5RUS84N1FXa1UzTFRrS2VXTkhQ?=
 =?utf-8?B?QlRzVUlSaG5OYjczeU1jSTc4alJ3MjZQNnM2Q0RwaDVPSlRsdHpBVmJFcG5I?=
 =?utf-8?B?bS96MWFIRTdOSGlraUw0a0YrOHQyZGd0blhUN2tYZ0NteUxpekJWMHVlOHlT?=
 =?utf-8?B?bWFiQnNrTS9lVmVMNkp2L3FwMWpqbXdlV1RsMCtkWDUvMnNSMUozczc3ZnFi?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3baab06-0a46-4756-7009-08ddbe1bf13d
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:35:37.8862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4iEM06mBe39+XyleYylbh9Hu/XfjlVrZwvPH29TmjA04kHj+7YwUGBVVTUCGAFq66TrW2WU8DV3vs0/FoiOynC2867htWi7iLMCa71MEg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 7/8/2025 1:28 PM, David Marchand wrote:
> Caught by UBSan:
>
> ../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned address
> 	0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
> 	which requires 4 byte alignment
>
> Fixes: 28ebff11c2dc ("hash: add predictable RSS")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   lib/hash/rte_thash.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
> index 6c662bf14f..6d4dbea6d7 100644
> --- a/lib/hash/rte_thash.c
> +++ b/lib/hash/rte_thash.c
> @@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct thash_lfsr *lfsr,
>   static inline uint32_t
>   get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
>   {
> -	uint32_t *tmp, val;
> +	uint32_t tmp, val;
>   
> -	tmp = (uint32_t *)(&ctx->hash_key[offset >> 3]);
> -	val = rte_be_to_cpu_32(*tmp);
> +	memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
> +	val = rte_be_to_cpu_32(tmp);
>   	val >>= (TOEPLITZ_HASH_LEN - ((offset & (CHAR_BIT - 1)) +
>   		ctx->reta_sz_log));
>   

-- 
Regards,
Vladimir

