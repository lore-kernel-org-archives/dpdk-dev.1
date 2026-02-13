Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69205EF48E6
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E545402B2;
	Fri, 13 Feb 2026 09:41:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id ADAD3402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770972064; x=1802508064;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KWRbZ5V3dNKuRg4dOuqfN0tJnc3d0MVKC5RGiDLRQL0=;
 b=f625uKyJPe/SlJl3ZGf+CZo/lTQqdLOr9tVHNQH3ECE9Qqth4MsBTU5W
 4HFS6m9godCXqFOJ79Id0iui78/spT7x8xi/DG9msM3BPLsor41niQjhK
 ZikiTSEY7OzVHl5qG9k8Wa1eUnXxqMNEm2LFvTM6wXZ5nFHMUqyA1vV7O
 Oiyoi8O7PVLd6HdPFOUCD3QfFidkYM47E3lWgCyXcw3LmtHgXO+6F/G/3
 iIty20On9ZNBL3TUDieaOcIFimkyDM+FqLfgAYfX1bIBFy/5iyyO4+zvF
 sTtX3hA+9137gecP1GlbgUIvdi2qypZ5jXdgzCbkhknN1P4RHrvcqCdRe A==;
X-CSE-ConnectionGUID: CL+GMf5US8CUOMLN8W4G1A==
X-CSE-MsgGUID: w3MM9jjyQM6wgkJ5649OtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83253988"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83253988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:41:02 -0800
X-CSE-ConnectionGUID: Mbz+g+H5TpaIsYYmv3nIsA==
X-CSE-MsgGUID: OyUwEU7BTMewfY13mWda8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="212963214"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:41:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:41:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 00:41:02 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:41:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYspYdnjxkH3ZUduVFfjnSK5HjvmPOo7h5ez6YJfNaMEYcB7vkLEuPSULifTLasbY2XFis+/yfw4Nkfb72mRPc49LRpC/NNNqtSiK36IFHsz5+VGHz9LRTXvxpTsjdolNOYvjWK4xWRpE0qE2NVftL5renyQNLBXQXpwsFaHfXP17mwZzQgQHq/FmI8tfS5ZM+5CuolvIJqAB2I7fMmfjRZxJ1fNeYaMlo3HL/Dr8ksGQrz4tK2AgwEXloaW3Ms2xuURjBymYQAQ5JAYcsmpa6l7vUj3Ho+TskSLrpuucz50r7oRTzGvsFeoqRWzKAn5jcVop+17uK41okjBuc1G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smN2m8sznB6/9TRtMTRvW1wgmJ1PsZQ2F/3cg2EKrh0=;
 b=SuvgmBDt+jq7aixSPl8VlSjVXO0NniN5+CBgAVK0RcpUUM1l/0HqqRMEYeET6ivjgEixRe+awa9IQnQl3BJd5tzgSFY3WoLDKg7XieCaVJvEKeZmRUn7lpmv7r2PYaAueweBE+bSub2gRBqrMdeAh+F5qtNNxFE30Y5z7Ibm2Z9AQVHrTQMuetfH6viE/NKbwPCeZJFB/OUjZoOqIHbFCF4TsZyC7dSTVGyAmRoQ8I5uqx/3hkNsik+jacLrfNVgi/lrIJW6Bd+tv0uoyk/XDVpWX/5lXTKTI7FvXLSIWGAb53jZorfRj6YRsIlhiMot5tIGZDbDy3uLDJxzMd80vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Fri, 13 Feb 2026 08:40:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:40:59 +0000
Message-ID: <7c89bf80-66ed-457d-96ed-0cbb73dba751@intel.com>
Date: Fri, 13 Feb 2026 09:40:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
To: Radu Nicolau <radu.nicolau@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>
References: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
 <987bda2e-d92e-44f2-ae04-2a9dd6143b49@intel.com>
 <aY4LGKrTeEkzACIT@bricha3-mobl1.ger.corp.intel.com>
 <3f295bb8-017c-4b8b-b8b6-18787d3a31df@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <3f295bb8-017c-4b8b-b8b6-18787d3a31df@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR06CA0015.eurprd06.prod.outlook.com (2603:10a6:8:1::28)
 To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BY1PR11MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b71afb4-3630-454c-4cbc-08de6adb9cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHoyWTREajNMMlBCOGpiOUkxdjczTEtLeWMwTDFXdStDS256OHoyWWNERFpu?=
 =?utf-8?B?SDd2SUVsakZWT1MxWmhUaFl2RFFoaVljRW52NlFhUnQ3eE84ZGxVV2MxSHZY?=
 =?utf-8?B?R0g0OXRmUXlmRVg1bHdSTjJodXV1KzBxOXhQZEsyRDlLeDdoT3JjelFHTmFa?=
 =?utf-8?B?dVpCbDhKdnZNYVZjU09kWWoxRFlmZVNRekFIRkZEdk5lRU1UVHlUQnN0bGZN?=
 =?utf-8?B?cHpxc1RJTUNhSWxSMW9uRGxuc0U3ZWtTWHNubFkxZzA4WnhINXJWWGJXMlhT?=
 =?utf-8?B?MFRSY0k1ZktPdTF0d04vbFRkVXBjZStiaTdnVjRlTm9RYTU0OEpiTGxxUUF2?=
 =?utf-8?B?MjM1QkxzNE14bVViY3ZCbFRUREw2WGFYckUwaHRkeHVhWFg5V0MzeXJoajAz?=
 =?utf-8?B?eUNDblpkSmhvWkRBYmsvVnpublg3S3Rlb2hVYlQ2VFlpalBmNFlLRVBtb0Va?=
 =?utf-8?B?N0NPR1ErMUI3MjAxSlpRbGNQYVJ2bkdQNFZ2RFoxRlhMeFZxMnl5YkF0Mms5?=
 =?utf-8?B?elNMM3FseXBtVUF3T0QzajFOQnZ4NUZLZFRFVlRTMzhKUDRzRUpvT0dXalhX?=
 =?utf-8?B?MGlpaFNHdmNkUVRqN3c3eWI0Q0JteW9GSkJWcktWMFVldFJoY2FKSmRrK2I0?=
 =?utf-8?B?dnZPckJqMjVucWZ1Q2I0TDNOeTdUWHVGNzFXUVlVd3hGeHh6aGE2dGVDUUs0?=
 =?utf-8?B?VGkrYXVNdHRWUk1ud0ZzaE1lZzMzVWl1RGhmWXViOCtoYkxNV2hJMzNEdWtt?=
 =?utf-8?B?UzVIdUs5ZkhrSW5RL3JIWmxTc2FVMDJyd2xPdFNpTnFWWU1iYTZzaVhlRkZl?=
 =?utf-8?B?bHkrVDBIY2ZyVkQzbG0ybjZEQkMrL2pPT2hBazhGcml0Y3pCdFVYL0JlSEIz?=
 =?utf-8?B?VGRZaE9takFoQTN5ckpoSVhVOGFxdEdxTXhjNGcxMnIwTFlETE9iQmFidXh4?=
 =?utf-8?B?UmEzTENZM3ppcGZkS0J3QWFscEhwZ2diYTVXak1kY1l2WnF2bms1ZElmb1Bk?=
 =?utf-8?B?akllUW0rNjJqZjJIMVlUWVpSZFBoUjNvTEZWZkplQWlUQWdMUWtCWGZhd2RC?=
 =?utf-8?B?TXhtT1hDbDF2R3lWNlUrSGptRThXbkdlT1ViQVZpYTc2ZStYb3NvbVV2U1Z3?=
 =?utf-8?B?d1pMdUdPMHNKR0Z2Um5uaWxLSE5aVWNuVklmbUV4VmJ5d0FGcEIxQ2gxWnJZ?=
 =?utf-8?B?UXAzVStQbTF4V0Evc0pJWksvb0k1YjJUYkhCYldxTUg4c2QwZHZIbmJOdjRM?=
 =?utf-8?B?THFCQzNwMlhYRVRzSjJSM1kyaWtnc0l3dUViWTFaTGEybnZCN0JlSGtibkpj?=
 =?utf-8?B?NnVUeU54anZqMmZXbXpYK280K0d6U3pObmpqN0RrcHVPQ3hEQkd3cGFwWW9G?=
 =?utf-8?B?YzBMbW9NdXc0V29oeXZKdXk5a1k2RTE5TGhIbndLYWNZUm1TVjR1MFl6Qnkw?=
 =?utf-8?B?aWJhNC8wd0xMWHNJbERhSDEzRnJxTXV4TXo0OUY3bXVaNGlRODR5RG9aYks1?=
 =?utf-8?B?S05YNUVzeHlIY1RLaXBUbjhTNkF3U1E0bFk2bGp1aE9RdVc1OVhwdG9LYWlu?=
 =?utf-8?B?eUVNN0swNVlJRnp2bHZZVEdkdUc4Zi9BV2lHMlZmYnlrN1hNdmEwK05XTzNQ?=
 =?utf-8?B?RDQwbUxKbStLNEI2ejdodGQzalFFYUpYZElHRmZOTFBwVkxNT1o1ZnU2Y3o5?=
 =?utf-8?B?ZXpiTUFXditUQ2dJMUJLOE40UVhYa0tBVXpnSVhPR1NHcVJuVFVNZXpRekNz?=
 =?utf-8?B?a1pFWXlOTUcxK3Bwa0hScFR0L2Roclc1ZFlCQzUxcElHNmx1MU9ycUtOSFI5?=
 =?utf-8?B?eVRGRi9LT0ZyTUdOeXhLbGNiU0RiQUI5d2pSVDNDRHZYZjZjQkkzL0E2aVFS?=
 =?utf-8?B?cUgwYjNzNzFnN3g0eDNDMzF0TzAvK3U4enhJUVV0aUJxZkVxME5OcVhYTVcy?=
 =?utf-8?B?Qys3Y0M5OUFMdjdKZnNua1FQUUwzUi8wS2R0TnA5TGdKOFY4WlJpN1BaYUJL?=
 =?utf-8?B?MkY0b3o1TlJ0aXk2a0kzRkFFeGxXM0hXT0tudTNQdmdKTDArVTc5V1JDd1d2?=
 =?utf-8?B?WVlLUStiUHM3QWhsVWJENWxIYVdSM3pTWDJuWXMzQmdlMzVhcHZEelVEV3dD?=
 =?utf-8?Q?ukrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFhbkt5TDJmL0pIVitJcmc1SlVFSDh3VkdvUjhqUjgwanBlM001SzdQeC9J?=
 =?utf-8?B?K0tSRU5sM3djSHVPNEw2SEUyWGNMODVlcEtZd1o0TDZBRHhVZGhLVVl4RG4y?=
 =?utf-8?B?dWdRYkJxemFNQzZhcmpHcktTejc4VEJ0Zy9SOE5LcllOZlF5SlYvVDJ1dGcy?=
 =?utf-8?B?QXdJaEJJcktuNTdyT1lPY0t6Y1g1eFZvUURFeWQ5c2ltU0RhYUJROUlQc2cr?=
 =?utf-8?B?VW5XVitkLytzSmthWmNRNzQ4ZThBd0ZEZ1pteVE2YzU1S0MwdG9LUnlRdUk2?=
 =?utf-8?B?K2F1c0NhL2U0VkZiR2dQbE9sbnhGZjhqSWRIcy9abGVPV3hWZ05PbGxLczJY?=
 =?utf-8?B?ampnSUJqWFRIbnBOOGJ5YUpNYkFoTUhyWDVaOFdvQkJsK3Azd1pMRlRyeUM1?=
 =?utf-8?B?UW9xaEIwUlZxZ1FDU24zWGJmd0ZyZ2orZkd2ZHJETXg0ZWx3QzFsRWIzV1dW?=
 =?utf-8?B?bThHTjQ5YnFvY3N0L3dYM25YY2hzbysycU1lMzFDaDdyUVRDeGozcnFmUFBp?=
 =?utf-8?B?Q1h2UTVFSTVXaHBtcU9UdUdlODIvanpDWVNST1A3Q3RZMnVCdDdjMkJNN2Na?=
 =?utf-8?B?KzJiMUVZUS80ODAwUU1OT0VMc3IvbVJDSERXKzA4VHk3Kzk4M0JENkpOUWVn?=
 =?utf-8?B?bWxaWjArT0xxd3hTT1hVbDhvdEIrUUx3UVE1SkVPeUh1T0g4aW00N2djYll0?=
 =?utf-8?B?R0tvRnhGeTVYTHpsY2pXR0hNZFdPaytmR0k1czlVWGtLbWRvMFdrbXZMM0tU?=
 =?utf-8?B?d0VWZUZTMlM3R3pxZUdQKzJBYktFL3RvUTh5cGdVamVXWGREaFAvaXdVS2cw?=
 =?utf-8?B?R2hGTHJIK2VhUlBTbUtxTTFBSkt1a3NRQ3J4c2txcDJmT0pKNVg0NVJ1THpN?=
 =?utf-8?B?Q2FJeU1aQkY0RlRqMy82cERBNDYzSGJDQlBFeWVuZ0ZjcXVobnJEL2hHV0xx?=
 =?utf-8?B?UFNGd3ZaeWZoTW8vemlVQVdrVU9UdlZxU3U4S0ZiRE1GNzdCRzFrOGNHRmlw?=
 =?utf-8?B?dkFwMG5sWUVheWFpVlFSbFBuc0FFL2dYYnM5YkhDdkdDeGhLWFNEeDIya21X?=
 =?utf-8?B?bnpGK0l0WDNiR0o4NFZud3luTGFnbVJkejI1Y1dRbjhReXlXdHVsZnVWZXEz?=
 =?utf-8?B?dUw4azFOMGlmOTlld1JaNWtFZ0srYVdCWkt6akhKTmwrV2RzUmtPZkY3RDdK?=
 =?utf-8?B?ZnhCcEJ3Ni9LcHFOckIyaWxMVk5xd0pUUS92TVhPeElDSVNkaW92a2lKRzE5?=
 =?utf-8?B?S3NxNCt0czI4anBDc05ueWNXMVp3SmFMNTgyZURZUU11dG8xUWJCUjJPbU5V?=
 =?utf-8?B?eUpGTzBCTWFRdC91NkFPaW15QTZtYjhHdVBoTWtNbktuMnpsWlRWcWtaU2hW?=
 =?utf-8?B?SHphdlJPd3BZditWMnlUeXNxaWtXWlppa3ZtVlFmRlN5UTlVT243bGpLMXBR?=
 =?utf-8?B?S04wckJrNFBFdXZzRzBnSXArY1BNa3JkQ0h0VkRvcklTWnlYZEo4VDNTYXlt?=
 =?utf-8?B?QUlzcGRRUEhReXAxVVNFK295andNL3JoWW1GWWZQRHJocmRCQmRqMUcycHA5?=
 =?utf-8?B?REFKOGVzaDNYK0VnY2VMME80eHpvVlo3eFM4MU9UeGozbm1RSHp5dnVDc29w?=
 =?utf-8?B?VUJLeFNMVExNREpPbkQ0YmhyeUhrMFdTZytzSTB1a2w4cGc5QkZLMllxV3Rl?=
 =?utf-8?B?UU9QTVdEWlN2eFBVVkRnanE3UjlVMTFSWnhrQ0hUWWtqSm50T1IvaENRb3Ru?=
 =?utf-8?B?eld2OVRMRmxwQm9QSGJDd2c2d2xuQW9jUlN0S0JRSmlRWUJiNHBQb0luTzF6?=
 =?utf-8?B?T1gwTXJ6cmVJc09iczZiaGZOT2tEYm51RnowM1V5aTdYd0lZUlJ4RXluOUF5?=
 =?utf-8?B?cEgwL3FWL1pqa1FLUHpRWmxBdXQrclEyTTVwUFpGS2ppRTRXeUpidFhrU0RH?=
 =?utf-8?B?K1QvN1NxdVdRajI0dXUwL3J0a29TWHM1UWpnT1dVVGE5NkM3UGxoa1RzZlpZ?=
 =?utf-8?B?QTdmWUNMdTBxcFNOeHB5QldlVWtWY2M0LzJZVDlNZVE4V0J2NUhaZ3FhSDhH?=
 =?utf-8?B?bVl1dkk5RXI5S0d2cCtMR2lPOGpOYkpxSGFYdTdaT1pZaXJob3RQTUlrcWE4?=
 =?utf-8?B?ZTRydU9kK0tjSUtHdlFoR0NCVTdkaVRHY1Q1VTBtZmlOQUhPaDhwZXl5NzM2?=
 =?utf-8?B?dStDTm5lbmo2RlZWbkkwRTFHZmtnaFdQM3dEQ01JZFRiZ1FJNVJ2K2V2TXQz?=
 =?utf-8?B?bmpzdUdhK1FYRzUzM0RlUnhsZ3JRZHAyRXZLRHFhMVhERWFTckwzenZuRTZw?=
 =?utf-8?B?SjF3ekQvS2w5QXdVazZRTHJrdmxjZUdCbFEzTk90N0toWVBOMExvVVU0U205?=
 =?utf-8?Q?+uHRej49NtmL+s5s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b71afb4-3630-454c-4cbc-08de6adb9cc1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:40:59.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oH1p8HuY+eUQXpUTV3tBmUN+Az33gwe939DX+dBPldk9Xp6tNL5+wiDebs81j/BZxQOcL85j+SYkJw82UFjTzwcpudja/7e0eIBlO2F+ipE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
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

On 2/12/2026 6:21 PM, Radu Nicolau wrote:
> 
> On 12-Feb-26 5:17 PM, Bruce Richardson wrote:
>> On Thu, Feb 12, 2026 at 03:50:26PM +0100, Burakov, Anatoly wrote:
>>> On 2/12/2026 1:53 PM, Anatoly Burakov wrote:
>>>> The original IPsec "add SA from flow" function expected a void* 
>>>> pointer to
>>>> security session as its first argument. However, the actual code was 
>>>> not
>>>> passing that, instead it passed `rte_flow_action_security` which was a
>>>> *container* for security session pointer.
>>>>
>>>> Fix it by passing correct pointer type, as well as make typing more
>>>> explicit to let compiler catch such bugs in the future.
>>>>
>>>> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
>>>> Cc: radu.nicolau@intel.com
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>> ---
>>> <snip>
>>>
>>>> +        const struct ip_spec *spec)
>>>>    {
>>>> -    /**
>>>> -     * FIXME Updating the session priv data when the session is const.
>>>> -     * Typecasting done here is wrong and the implementation need 
>>>> to be corrected.
>>>> -     */
>>>> -    struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)
>>>> -            ((const struct rte_security_session *)sess)- 
>>>> >driver_priv_data;
>>>> +    struct ixgbe_crypto_session *ic_session =
>>>> +            RTE_CAST_PTR(struct ixgbe_crypto_session *, sess- 
>>>> >driver_priv_data);
>>> Despite being removed, the comment is still true. This is an artifact 
>>> of how
>>> we get the crypto session (it comes from security rte_flow action, 
>>> which is
>>> const).
>>>
>> Why not keep the comment then?
> Probably it's best to explain why we cast away the const, but not 
> include the FIXME or TODO tag anymore.

The removal was accidental, I'll add it back in v6

-- 
Thanks,
Anatoly
