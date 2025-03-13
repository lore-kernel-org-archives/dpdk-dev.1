Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC4C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6014114B;
	Thu, 13 Mar 2025 18:48:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BB69F41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:48:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741888117; x=1773424117;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=Zaa9CMhoGmSXGQ+EFaOwbGc6CzRJ0Q8Li2uX6exTF7A=;
 b=CI8psCQOsiXJXJqs7gI3Ul1+9k2HjHHgk8kzvCR788nwc2RqXTP3MGlK
 tmrpuf2fRXQe3cEBXZBKBaC3RhCqBdxIL9KAZob9wr9NSThwS7Hpeenwx
 s8EkTej7loNwCfbFIeqptFjSeLc3lc07BQckEMncp6N/Z7FBpbiyaBp+0
 CPuWYvzmfiyOK3tqDbQbWhAW9lHEYN1SA0YMsh6sbSmShkMWMs1pLMCIx
 lhcEESFp6MNjMp/JojnETp+9pKGUWN0ajHwXvBQ3Q0exlTzBuocgU46xO
 MpNXLPKSwLlIJzM1LDc2c15RQSvu69UIPykNiSoZnuVtGpnLdky/MhsiN g==;
X-CSE-ConnectionGUID: 2udaDo3rRuClBZdWoYiHFw==
X-CSE-MsgGUID: A1e6Y1ZrSoCVDLbY5ciNFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60424149"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208,217";a="60424149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:48:36 -0700
X-CSE-ConnectionGUID: MZPQWnCQRk24v/lRzUWP6A==
X-CSE-MsgGUID: 4xkcMbzRRiWsRgjDy2bsgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
 d="scan'208,217";a="120750734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 10:48:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 10:48:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 10:48:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJyoupJJgyZaeHbKNfYGDSplbOXEIBlvoX6bsUngVXdVnaZ5eO8Nwajcazvtdxslb73+jl8lvq4e0GAcpfxixF0JEUMR2Z9ptY4oaFSuhCeTLPinPZov4pjbaI6qfKFLT4SpJp7daLsiRgCOgw/I789aljwAed1e1Kcusi5OG6kZMyl6wHc3oZAwfY0SHiW5LqeWdVyKBmBRxSTiNlpbr5YWr6eVMS9J6sPIpzRAFs8S588gLbsgtFXxQflwcEydrIUaGPObX+XcetSTyBXdfBHF7FSWJYFr8WXEONhzwsNm+/4egIJI7qaMuzx6+qgYBdLWRCvu1H/4FsW8v/dlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkyr6TZ0Hy6pd/zyl6K3gyHsL6J29wMh7WklkxyQ2co=;
 b=ljYvbaYbId6rd1cM2SCjpwughCDt/0hbsYaG7tT62+jUcaS4mF9O5LIxSjbhcQPvoluiAac0ZspN8XZ7z31fjKQ0TcklNsNu8AtZrTuLOVsWmlC9icfJcAvivoDDUpeVAFnsESrTtoT/gIthGutVum2H3qnl6rPfQkm1uXhScADBMMZzp9IHegv2Y91+6QeS7s5A1424uGlJmxuFebmiKsXGMVCKOoFLuLJcTnwSakaFidRikxlBRU7yPLo93TaZRQDAaf0hihViHQEq6UAWCRjXiROq2Qvxe9pgfy8Z4kkrMTfU1vEVMsFQIjgBUxi+3seRBitvHSusFVjxbTLG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 17:48:33 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:48:32 +0000
Content-Type: multipart/alternative;
 boundary="------------qYtDD3jzhcqDIWi0jZFFkEdn"
Message-ID: <3053dd6b-c0c8-4ec2-b945-ad9be50b3337@intel.com>
Date: Thu, 13 Mar 2025 17:48:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel: remove unused reassembly functions
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Ian Stokes <ian.stokes@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20250307160711.747754-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250307160711.747754-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB7PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:10:52::47) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d53b762-c94d-4869-6791-08dd6257456a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TytWbnU2Q1RRMXl3WlNyY3g0MUI3WUhrYVpML2VFcFM1VmI2NlRseEJsZG1o?=
 =?utf-8?B?M29SN2hvWU1HT0VSMVRFUnI0dWpwdzcrZDVnNUc2SWlWcnlHbTZtTERuUVI4?=
 =?utf-8?B?V01rcEJFcE5xMXZlN1h4Wm1qRnRQMDIyZUczUlN0ai9xUWppNVhoWFU4dzFq?=
 =?utf-8?B?aG9GYUZkYzZVcHdMZUdXdVpFVTFSTUIyYkpsNVpCMFBFZ3d4YWQ2WkpsMlNF?=
 =?utf-8?B?TG5WaGQza0x2NkNjZkNqcjNUamhjSXpoREhMQkZ0SzVWYUZGZnB6L1NLQ1pF?=
 =?utf-8?B?K2ZDRFRpV1psUHR4THpHZ1FkUXcyTWFiaEZSRFlhQ1JYUCtiN1pTOER5LzF4?=
 =?utf-8?B?R0Y2MGpkWXpad3AvMlV0K2R6TDB1M2pmY1FJeDgyNjJOTlJYNVRHWGtIdldX?=
 =?utf-8?B?SnNyUlVBZ3FpTVBEZ3NIQVhWR2t2S1dBRUJ2eW96OGE0aUc0UVNWZHdvc2x0?=
 =?utf-8?B?WmtDRnNqdktRWFNZK0tKQ3pLZmY5OEdleWlQM1g5N2RwYU1Ydld3WU80M3Nh?=
 =?utf-8?B?RzNVczJDYXZZYmx5UytCdGdkQS85aDBUWWhVMlhTSVBxZjhTUFZiY3NHdkZF?=
 =?utf-8?B?c2F2MzlNNi9ObEtYSVpkOWptbTNWMnVsZjRrN1lydG4wVXczOUQvR21HSGpZ?=
 =?utf-8?B?QnAydXdaZUVyeU0yS0F0STNqZVF1UURhbUdNMGxxUXdiSVZCZVlMNTJzdTdE?=
 =?utf-8?B?SjE3UGlIMGRWV2p2R21yQXhWOGtKNlFKTjNaSVo1anh5NW1BaU1ON20vb0Vy?=
 =?utf-8?B?dllPUGZIakw1dzVSNVZ4QjR0NUNkcUxvZXVVWjZVekZURFN6ZDk5RWdHdlRM?=
 =?utf-8?B?dnZ3bTNqQzd0eHBPYjMrMG1xRXBhL0NFWVpDemprQjNpcE5Ibkh2eFI4Qkx2?=
 =?utf-8?B?bVdCUy9TUFhkTE95SjY5Ujh4cHdoeHhSOFU4bnNtM3lBWXlsOFJLbnpiMW5Q?=
 =?utf-8?B?SGt6dG5leHBlSUswckpyUWRjN0haL1dpUmRPZ3BkdmQrS2lGV05ka3ZTa05v?=
 =?utf-8?B?eEtNdW5VVlV4ZlR3cFRJVWQxd0xabTZveEdTZ1IyMWdHNWVYM3lid1VnK2lP?=
 =?utf-8?B?THU5WFdaNWltMjBMcHRqNHlGdXdGQy9nN0ZNMU8yZ0tqM0gwa0xkeHZtREd6?=
 =?utf-8?B?OUJ4Y1pPZzRTSFFqV2o1dkFPNXB6WmE0enJDVHI3QWx2Y2pVWlhOdWg5VTl3?=
 =?utf-8?B?RW14VWQ0VlZTMUNvS1QzdW9ndjhaWTA2N2ljdmF3Qk00UTQzK2dDeWhBelU5?=
 =?utf-8?B?a1lqYTF4YXdqZFMvRHdrR09OeDBjVndlZWFrU2JCZHl5WWFOV2NJaGlZdnlq?=
 =?utf-8?B?L0dxTnRjc3ErTHR2RGYwWHBqYzVZSHNJL3Uxek8rNnpINlc0UG9hNnFzZlZO?=
 =?utf-8?B?QklGUDVmL0V1N3NJakc1cDNDSWFvOFZxM0MxME10bTY5R25mNWJnd1k5NjFM?=
 =?utf-8?B?cUJCYTJJRXdmUStrSWNnN2hKT1Z3U252c2R3UU5VcFdEeXRLcElYcXdRNWdK?=
 =?utf-8?B?b0FIQzNrTFErYmN1MlpPaVNtTmQ5YUlWSGZyd3FqQmo4ZVhvTTBnT3ZYY3hZ?=
 =?utf-8?B?OUN5eXBUWTJacnVKa3dpZGdtelRZMGZtRERIRUQxWlQxVCtSUGtkS3VOQTh6?=
 =?utf-8?B?YzZoYzhyN29yR09hUXNRaWptT3Vuc3ArcGh5czh1d0JsZm1ITXd3c3J5ZzBB?=
 =?utf-8?B?QjRNeTJ0Q3lLZkhQaTBUZ2JvZnhNcGhHRnFHTTkyM1BrblhyQlQxbGNZbGR3?=
 =?utf-8?B?S01xeDVEOW1GVFNwckI4cnJGOHg4Q3pGUkFKL2RET1pFL0ZtM0tMUTJKam9N?=
 =?utf-8?B?SzNjZHk0cENzYk1jODJMdjRrUW1pYm1SRGVHcDRiU3RPNHk2cUxaYXhOdEMy?=
 =?utf-8?Q?n+nSsve420smS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlLdHRvZ0tHTXFOWUs5ajlieVVrc0dzRWV6a2w4SlRWZUpkeWtVd0lLOTAx?=
 =?utf-8?B?Qi9IY3hSTmNOOGcvRXBneWZZbCtQSDlPRVF3ZXVza0lEdVU0OE5JTEF5S3Fa?=
 =?utf-8?B?dmMyWkxrekk3T1pBN2t5TFVBNDZPZkhwMmZKc2RPeDhuRjdGSXRySWs5eFJr?=
 =?utf-8?B?TWF3WERLaU9xMDcvSnZ3S1FKWXVnNE9tTWt2WkRibXQ1L3F0amZjbm1yWUYv?=
 =?utf-8?B?L1drRERKV2VieUd0Q1ZmY3RWc0Z5YlJ2VVQrNDlKK3RQSDNrT082WVhIYk1G?=
 =?utf-8?B?d1pUb0hGNFJWdXYyTGp6NDlOT1BEOUt5ZFVmL0RSRVlNWktuN3dhMnlDWFZI?=
 =?utf-8?B?Zm9OeW1Bb1l5dzR4ZmdQRWpwbEVXb0p2MW9TZTdrQVNjSldmd1BMdkloM0tp?=
 =?utf-8?B?R2VLak1FaUd6SnlaeWVIa21Ja04vOUNodWYvUkZ6Zk5rWkJvQUVqSGt3c1ZD?=
 =?utf-8?B?M1A0bEtxTllqWHY0NTZqaG4rdnFtK3BTbDJJN3EzN05seDN5MWVIRm43ODN1?=
 =?utf-8?B?QUc3TlM0TGtHZml3U3drbzZCWVR3VG9ZK3ZjSDlXajFLQ0s4dFRFV0twalNZ?=
 =?utf-8?B?dmRNdkY1L0lJQzZxQWRra092ZXlQMGoxbjdvaHJpcm9rTHJZR2RmS3lUSUtG?=
 =?utf-8?B?YTJOeUR2UnN0ck9HOW9VQzhWaUZCbVRLQkF6ZkVVMkF5RU1XTzI0OTl0Q1FU?=
 =?utf-8?B?M3JYTGdPcktsYU9WNHlOYSt3Y1dRNXBlRldLd2FlcXdvSWZTZnFIdTRsM21s?=
 =?utf-8?B?aVRHM2xkdWxsRE9nZUxoczZ5Tis2aGIwSkIrUTRkVmN0RDdNaGtvV0x6bmZ5?=
 =?utf-8?B?T0VTYm94cHp4SXZiSWFac3JrZ2p5T2JoeEtCM2NrVFVseEl2Z2VqaHREUUVH?=
 =?utf-8?B?eFNKZk1TVFZ4NzdKbUtLanNBTXVId05DRmRNWnUvTGlDYmFndnBubUhTOEVZ?=
 =?utf-8?B?S1hzeHNYMDVjWENNQTZ3STEvTDJMV05uY21zR3VFby95aHo1ZTRuVUNUemZh?=
 =?utf-8?B?K25pdFBscWJVaXR0T2tzMk1UQ3AvTmVsZGp6a0xGUVJ5L2FWeHpXVFk1RGtn?=
 =?utf-8?B?cE9DSG5mOFFCWW5URVU5eHRpQUpuOVJvbFpDZXAvdDVOME53TDlMamNBUGNX?=
 =?utf-8?B?ZHNyazZETDZaZ1RSYmlOejFBbElKekhQL3lRVWpNZzBiSDhpVEtCMC9VZktU?=
 =?utf-8?B?d0kxY2F5NFpRcEs4QWNLYmJjSDhtVXg0SzJQSE92UStTc0pQUTM4VXBpL3cy?=
 =?utf-8?B?N0RqWVhTcTBqU2FwR29RNUJ5aGRNZmxPYzhmVmV0cXFQdXlYbDBHZFBCaHU3?=
 =?utf-8?B?V2QySkhkNnkyMzYzalk3Nm9UMVpvTUdaVzkxUlhxYVNTTDRZWlNWc2J1YjlI?=
 =?utf-8?B?VCtPdk9pTWlUZC81SE1IWlUzbEVDcExKQk9KM0pDc3FaMlptZjUwQ3NmaEVy?=
 =?utf-8?B?Z09KYVFhOUVkTFZuNTNXazUrRE0vbEVES1hLSHNGMHVFSmF1RjkzMS9rS2pP?=
 =?utf-8?B?cVlQK3NFRHJOUVYxeGF2T1VHNTY5a0FkSmQ5QWpCeGd2NWREaC9ZNDVtM0Rp?=
 =?utf-8?B?SXo4L21PTGRzVWdGeG1UL1l5WXRtT1ZKT1MwL0k3ZkVtVkVmVXRWL1hvenBF?=
 =?utf-8?B?TWlVNWxSU3h3S0drd1ROT29hcFJnUXBJYVZYbXR3RHJuanYyUkVJeTU4K0pu?=
 =?utf-8?B?cmRlWVNnNkRYTy9acThQbGhFTGFicFVWUkc5cmlaa2lzeVg2YStqbkUwdHhQ?=
 =?utf-8?B?a05ObUFnZTNDSFVMUUFWaDBiMDVVbGMxSGQzOEFrRkV0SEdDMjFtV0ZJblRz?=
 =?utf-8?B?aXJvRjhwQS8xc3lTTTFPVnZjMGh6dVZQS3FlWEhreG9PbUxNUHkvSlVmK2Vo?=
 =?utf-8?B?UHRQSklZREVtM2tmeExpNWRHb0h1NGFjVThmQzhNbHg3S2xKUU1zSFVkV0JD?=
 =?utf-8?B?REJzeWNmK3RBY2F1Sm44MjNaWUk2RzZuaFBqYmhnV0VIMWxTRHZNMXp3Ymdq?=
 =?utf-8?B?OWw4MjNvSEdaN2luNWZZZnltWmZqVlZVNHdFOWNhYlRqZVZqeHRmN002WnEw?=
 =?utf-8?B?T2Zmei9TQ2NKWjRvamkrcVVDOUduR2VnYWxLUmpUMFA0WDdCSWZXQkZrQ0sx?=
 =?utf-8?B?aE9iSW1tS3FLaW5jbEFJbFYrd0MvcHZzS1JEY0p2VDNXdUdFdVZoNUZnamJT?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d53b762-c94d-4869-6791-08dd6257456a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:48:32.6171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5W43hyxAF2PeODcXt6gKmKpxPY5YRmbTYfFrTUn/l01ShdAYicGWUHWYkzyD9cheUWHajg783JcTsIbisERjrtrITzP9uMzsQ5I0MC6IVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
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

--------------qYtDD3jzhcqDIWi0jZFFkEdn
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 07/03/2025 16:07, Bruce Richardson wrote:
> When creating a common pkt reassembly function for common driver Rx
> re-use, not all original copies of the function were removed. Fix this
> omission.
>
> Fixes: 82fbc4a4479c ("net/intel: create common packet reassembly")
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 63 ------------------
>   drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 64 ------------------
>   drivers/net/intel/ice/ice_rxtx_vec_common.h   | 65 -------------------
>   3 files changed, 192 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

--------------qYtDD3jzhcqDIWi0jZFFkEdn
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Acked-by: Vladimir Medvedkin <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.medvedkin@intel.com">&lt;vladimir.medvedkin@intel.com&gt;</a></p>
    <div class="moz-cite-prefix">On 07/03/2025 16:07, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250307160711.747754-1-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">When creating a common pkt reassembly function for common driver Rx
re-use, not all original copies of the function were removed. Fix this
omission.

Fixes: 82fbc4a4479c (&quot;net/intel: create common packet reassembly&quot;)

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 63 ------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 64 ------------------
 drivers/net/intel/ice/ice_rxtx_vec_common.h   | 65 -------------------
 3 files changed, 192 deletions(-)

</pre>
    </blockquote>
    <span style="white-space: pre-wrap">&lt;snip&gt;</span>
    <blockquote type="cite" cite="mid:20250307160711.747754-1-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Regards,
Vladimir</pre>
  </body>
</html>

--------------qYtDD3jzhcqDIWi0jZFFkEdn--
