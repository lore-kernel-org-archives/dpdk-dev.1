Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF17EA8109
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 000C6400D7;
	Tue, 10 Feb 2026 14:05:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A7029400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770728703; x=1802264703;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=M+KaPc+ScKqUiXGP3nAD9P9q5rdNCvVHBuHRb/WkAI4=;
 b=PBPLKVrYzz7Zpk4/Spl+eJoPUvw59l47vyyB9rsSUpLx4FVcelUOQv3r
 kVOeTdi3XvS3lzda+N9QDMSWmzIVpmo7S0AxMpU80ymRV7dYxxFyUOMj2
 H5Eh6bkuZTrcbgoUDI5hhRzQIacyzyPZfAuG0S+59EHjgkOpj3XjmjrzS
 ej3qPp9D/5RQmRhfBh5ek3ywRGc5k1LJOoc2h4oBKk8TS49IsW/ion2kJ
 4CaZRFzRILoQ+QJPzFqK2dJFALcYJr3LKOzLwksJCVLVLIonjDACszlPO
 IIj+k94AyBjiFJ0EE3afE+tVzlesXP+vqHK3PFcrQ2f/AxZOxxvCuY0m2 w==;
X-CSE-ConnectionGUID: CrgrHs5SShih1V9hTPsLAQ==
X-CSE-MsgGUID: IsDReE+2RU+u2mopy0LFag==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="94496656"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="94496656"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:05:02 -0800
X-CSE-ConnectionGUID: jSC7KcmrTvGi8nbNnLAP0g==
X-CSE-MsgGUID: I8eLnM5WTpawCMOiDr+oaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211018368"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:05:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:05:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:05:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhltd5zsghdhMQV9J3o0veBrrt8mBfUhzHxHXyWK/MSaE3dPIocyeJQ+b4C0wnTuLJl7bJ97RQs45uKzrugPo/yu3N5g1TI9OifeZbzHz5Jx3pA2qeBc9uFWuEetsHu9hmpwpoMMpajCbJ7No3rgBdcGKy8xXXnbQyRwXRfwed7YQ45jcfCPDBe7vT4GrlpHwxcvGPuXz0h+gc4aKiR/xsF+zswj1XfPJA5Jl1En8CwkcuJ+I9FCf006AfEp3QbmDSXbMs9bn0BVOilL8D6I+sCFxjgWEMHyxTCflL2c2zjHY1BOD4unX++rZxXSjfDpHAStFFGfCG1VkMGcV5wvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgROdlAE2iVOG0SQS57H7h5+GrJmY9mCrJ8+Sq7VYQM=;
 b=bEvk5D9Tig5TmUFB0+1GrrImE/6id3YWqGwRzaiuAAhI24LesCVZ1yPTNzdVjwOuCCBSt0NIXUDsmOyTsZ8uK+Bm2i0Kz3aTr/eArDLM/8pJQCq13JowqFXmM7Zx6uzxkhw10cn5I1ykU7rRwnzrhnJ1996j7Jz8UbOOB/RhK5za0g1b6/+aI+H5u7FELx7WxPt3bSIA7q4TAwH8dHH9lKwYhj8uJpw9QvvE7XOO9hqUW73+IrjE3k+N1ZpyDE5QE0Z2Q970aOGdZ30i34aCw51psU/GqMSeaBRLB0xtkf8h99BtrGPH1Ao2/+RQ20v4TSeBUPv+/ZDjhPQ954lBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 13:04:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:04:59 +0000
Message-ID: <0862456e-6f40-4134-ba33-6ce4e461c8b8@intel.com>
Date: Tue, 10 Feb 2026 14:04:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/35] net/intel: create common checksum Tx offload
 function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-11-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-11-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:408:e6::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f981dd2-cdbe-4187-1a3a-08de68a4fea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFR3TDdVU29UZVo2NmUrRTFTRWVrWFRpMW5XK2ZCbEV2bHd4emZXTkZzSk44?=
 =?utf-8?B?UmNWUVN2MTZVcnJXdk51K2ZLSkp5SlhocFJTQTU3NjNzMm1sNHRSUXp5TlFi?=
 =?utf-8?B?V1EzMTh6ZVNwNlU3aE5OSVVDUGhrV2orMlRDcTIvUVZpRGp4UFNzWXZxaysy?=
 =?utf-8?B?b05JdGtpaENNcjFBamdSMStMa21SSUxvbDkrZnBBN2JSbzljZG5FZkVVZGc2?=
 =?utf-8?B?RytGNFl2bGN5aWxCaHVjOHJkTjRRVzQ4bGEwU0MvL0JYd0QzOGJTSHhXOGZl?=
 =?utf-8?B?eER0M0syQitacEJOM0YrVXR1YzZLODBUaUF5L2JLelRxYVR5QW1UWkIzQ29x?=
 =?utf-8?B?YlFGS05RM1VZRDNEdUdTVW85T1dndFhHSjhVT0w5cjV3Qkt0cm81Y2FRdG81?=
 =?utf-8?B?NHNNTDRsNkZ3V1pYeXJQSlN3VUFCTkU5NTdpaFlBOHZHTk1uSUs1QTN3NGFC?=
 =?utf-8?B?ZmdvOWhVYmdhbzBRQnAweFhZa2d5Wk5OcE1KYjQ4YWpMcjdWN1lVb0psK0E4?=
 =?utf-8?B?YzBiM0dWSkNOWEZHb3dlZ0dwc2RPd1J4VGZtbHhRbWdMQ0t4MkFlWVZvdDd2?=
 =?utf-8?B?S0Q1cFUzWjFSS2VLc2RCMjhjY1ZHdldEczIvNG1ONUpiNm5rZFB0akNnaklR?=
 =?utf-8?B?Znhtc2l1aHNYRTB1eTB3WW5uajIrS0JFR3N3WnZoVGxUaFBjSC9CeXNhZjlV?=
 =?utf-8?B?cDlzTTlMVFk4MGFxTlVJVmU2TmJnZ0loWTdqMi9SRGVXOUpMMDM3enRFMFN3?=
 =?utf-8?B?TFd4eWZmMFlaOVFNeC9tLzJlUXVFOVc2anlFNmVJeUF4dkRjZUNDc3NDeVVx?=
 =?utf-8?B?OEdxKzJnV3gwNGoyeFcrZHZXV0hWSjIyK2YzdnN6SnlQR2NTQlNnNVBpT3gv?=
 =?utf-8?B?MjlncG43MzAwbWJwc0NkUkoyNlJwbHlUSlFHeDVVUU52dXA5YytWRkhmd1NZ?=
 =?utf-8?B?Y0xmUmVNWEU3Y0tFMkhMU2pmSFJtT3VlNjNxaVNhdnhGZDRPRkpMa2dOTlBh?=
 =?utf-8?B?TE0zMlBKWSsvZ3FCYTVNOVlJbFdzQ0pkblgveHFIVkVTeUhCbmFFWWZkKzNC?=
 =?utf-8?B?S0tVRlRvU1dyTkV6QXJDMTRLS25pWE1vN1YwL0YxT25adWlVanhuU09YZjJm?=
 =?utf-8?B?MmRtOUtSL1ZyKzFYTnMwVU1GZUMwanB0RVU0TGUrcnkwZTYzdjIvaXNQWmxM?=
 =?utf-8?B?ZmhBamcvaW4za0MvdW10ZmhRTHpPYXFTenY4OGF0VDlrRmFxZzJqc2dDcVpE?=
 =?utf-8?B?azh6Tk41L0x3dG9xckNLT1hsZ2M3ZXpteENTd2ZSK0hIeHpIVUFmM2EwRFQr?=
 =?utf-8?B?dm1rN3JZZGpHcmllRUlSazdsa1JHU2hZdkVySytyaEN4UG9tb0FpSFp4TzUv?=
 =?utf-8?B?K3B0eFhlQW9YaUtQZTFjSFZvNGRVYytaVVRkaERLaEF5V3ZUVDhMM0M1Nk9W?=
 =?utf-8?B?bmNEbEJQNWhhL2M0MzE1SDlFcHBPT0RoeUNiSjZveWt3MHB6NnEvMW9KMkN4?=
 =?utf-8?B?YnlIQlpnRFFZZnVINlBDU2tZaGxzemNDNENTZlprNnZiMmtoOXVXa0sxajdk?=
 =?utf-8?B?WXkvZlhlOEpZbk1KRGdrVHFXSzRkWGljaEZod3FnOGkyaTQwU3gvVS83d240?=
 =?utf-8?B?b2U2NWNVS3VpVWQ3bEN0czlXZzdMMENtdUZ2dzZabFZaU2Q1WEpzcldtQkZ1?=
 =?utf-8?B?NDBFQytlTmltM1h3VzBCRE9YVWVLMWZPR25sQ2pVSWs2U2NtbHJIRmhJWVp0?=
 =?utf-8?B?b1FHcXlvYXhDQ2lNbUVzQVVSRjVRRFdhQWVVWThEZ1JIY1ZIdmdWOWhYT3B0?=
 =?utf-8?B?aDU3ellZRENkR0pNVjc2TWdEOE5tWkp3dEh3SnZNRy90NmxvanhpK21OZFJJ?=
 =?utf-8?B?dTNPRGJZajF4Mzl4N1B1TkppVS9ZQTRMVUllNWxrZ3psbVczZTBpNkpINmpR?=
 =?utf-8?B?NVBYUThRRTRJY0s0QXVNbjNuSXJwQzhyM1ptUThyQmZhRFhZV2FLZGE1U1Zq?=
 =?utf-8?B?UUI5N3E1d0ZXbkVNS2hJVW1iYlVpKzJIbldZazFzUDRndUtmeTd5VHYvSWJy?=
 =?utf-8?B?dlZiY0laRCtCSFJvUDgwb0VBY3dkK09rUFJZME5kYUVHR0V6QndkUDNZUFRQ?=
 =?utf-8?Q?yYgg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVCSkZHQ0l0WCtLUjk1TzVuTEEweTlrY1B1MGk3QjlCNW5xMTVBOHd0RjFv?=
 =?utf-8?B?YjFqK2pTOFJjVjlMc3Q0a1lBWlp0TDdUTEVJbnFHVmpzQ3lYUTEyYlJ1R1FQ?=
 =?utf-8?B?UWZGUmcwRWlodUJoTkFtQ0tleEYrSUFMbE9JVjY3ME00Z0NWblE4Mm1FdkY4?=
 =?utf-8?B?ZjZjZmd1Z0JvcEIyWjI0NEdIQ0thSkdYdjBGbmZ3N3B5dUVtRWsyNGpEblc1?=
 =?utf-8?B?TDByUS9mdFIwN1FNVkpRM3NnN1RNV280UlFvYlBQMXdiOGJnbzY1NElRRzRp?=
 =?utf-8?B?dXBnallwbW5rMFY0ZVFKQmYrdzJlOXBDTHZxVzJiVUpTUkdydmpaeXh5Z25T?=
 =?utf-8?B?eC9SK1B0WnREdmVKRTJtUTFmRTJLWDB0bVNPVThTMTQ5QVlYZjVobUpaZldy?=
 =?utf-8?B?MkQwZ3JBQ0lmenBKN1N5TVg1WEgrdmpudEpUbFI4MDY3OS9QNzB3TUxxOWRs?=
 =?utf-8?B?eE5TU3c5YVEvYmRqUmlGelR3bWVUK0lXaVI3UnBXcjdHV25xOURZQnE3aU1J?=
 =?utf-8?B?WVR1K0srSWtDRUhYSEdQTHJvZ2tHQ1hWWEdwa2s1UHZ0S1loMzVPWkpLQ2d4?=
 =?utf-8?B?WmxHay9kUzZ1V3AyTjlRRmFnWVF1TldJNW1BUVE4aGt4UXV3MVdxazh5eUJK?=
 =?utf-8?B?dkJ6OGVIVkNLUmdpRms1UC9reXMvWUxlSEJPZE5IRkxwQmJDTDMrRkthSTVv?=
 =?utf-8?B?VWJxbDhVdlhPZmZYbXUxdWtSOU1vSkNMZXVwd2VDTEo4T3NWSjl3S2xWZkY3?=
 =?utf-8?B?cU12c1ErbnVJSEQrcm9GZnY0REhOV3MzbWFtamFKM1BBVUNLMHBXUEYrQ21l?=
 =?utf-8?B?M0d4UFNlNUpidWRyZEFrNEJuelVPaWZsZzZORzJreHJQYnFvWUgyL2x2YmUw?=
 =?utf-8?B?aXJiY1RVVW9LTHFQd3N5NHR0Z2J3bGRPNEowWFFXT2lUYnRmTGxwOU9rME13?=
 =?utf-8?B?eWhncVV2bHdtNEtFc0o0L0VMSk1IQWhXQlA3d3Q2akNyWnNKTU5BR2x5Qzc2?=
 =?utf-8?B?VVpwM2RDUEdwTHFvaE90MzNtWHRyVWhBcHpkVEpkN0I4SDkySnZUY1cwSTZ4?=
 =?utf-8?B?OUhsVHBaZDVVc3AvSG1UYUdpbWpJUWRxWTNoOEVCK0w5YmM5QjFYRnUvZ2dT?=
 =?utf-8?B?NWNjbGhybW9Gem5ENkxIUUZ3c0JoVEJvWFRHZWpRc2Z4ZWM3OXp2MnlsMElV?=
 =?utf-8?B?OG5rR0dqd08zcEI5clQ2QmJzMURENkYxYlpPcCttTTJobUdsbVQ3OVFaaWZt?=
 =?utf-8?B?bnRtcytaUlk0NlN4T1FoZkhGZTNhekFSbEQvTmZGVmhCWmQrRmtGekJXemZT?=
 =?utf-8?B?blAzazNzdFN4RTBlNHVTVGNqYkxTeGhMYnVZb1RkSE12OHloenFENnZRZlVo?=
 =?utf-8?B?eEtEYmo3Y3RROE41NWRYMGVQTmV0R3dBRzErNkpUSE9paHp4Mk1xbC9uMGlX?=
 =?utf-8?B?bnNBRHRyYmdveWlIQmNKNytjUHhoT0psTGgxYnB6K1JFUlpuMmZvRWJ1dFZ4?=
 =?utf-8?B?NlNqUU9JRVBVTFpTWU9FKzlsbk1Bc013b2pqVGI2Um9qTFlqdDJjNUMvTjZT?=
 =?utf-8?B?Vld5Y3ZTYkM4NUwvZzB3eG9kSjFzRms2dG5hV25aNUx5WVJtMm5ubC9nNURL?=
 =?utf-8?B?TVFkWXBnWFNOWVpST3hBSlZoZWVwckZuY0paelBpanIzRytjSCtkQ1VtTzlw?=
 =?utf-8?B?NkwvbHB1am8rQTBVTHlvZ3ZmMSt6WHVlUXgxL2kwOEoxdG1VekpvS2VUQWxV?=
 =?utf-8?B?NGtPUDhrRWxib1ZnUUMxWFdwclpSVFQxbHNPSlhvc0RKdXJtSUpVN3BVb1Zz?=
 =?utf-8?B?eWg0aDJleEFldlA1Tm5PaEJVYWNWL28rdjMxVW45MFZpQ2ZPVjJSMnBmZWFC?=
 =?utf-8?B?Ynh5dm0yUUxURTdDeERwK0VnMTNjSXR1d1A5aGs4K055MUdmY3Y5azZKZzZy?=
 =?utf-8?B?ZWZPWFN1djNkWEZxZHQzc1pNYTU5WVJ5aFNHOEM3WVBEa0dTYWZMU1A2WEw5?=
 =?utf-8?B?bm5vZUVFTk11dngzb0lqQ2NYK1o1UjFKelA1VWQyQjl3Sk5WWDBWSTE3RFN2?=
 =?utf-8?B?MG1zdzBsWEwrVk4vejFjUGx1K29zVDhIRUlJaUQ2dEprSit4MXdMSFVWUjA2?=
 =?utf-8?B?M0V1ZFhpK0NZWkpvNGl5d2FWSVFjSlVwUVZ2djB1bEZIWlRneDRFbElYbkNK?=
 =?utf-8?B?UGhBdnpaWUhYenBKRnlVSHd1VVVpZUtETVRsek93U0Q0RTRNVUp0bzNaczRu?=
 =?utf-8?B?TjhRN1p0WHBZbTdUdHlpdkZEQXJhMC8wZGMvUnZ5ZjRNR1ZFSStmdjZPZjdt?=
 =?utf-8?B?UkgvakFCRGdhV09JZC8xZDlPeElWeHlxS21ZWE1ZY2s5V25KTEo2QkJWWDRj?=
 =?utf-8?Q?6VCZXzMIX7AUCVlM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f981dd2-cdbe-4187-1a3a-08de68a4fea0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:04:59.0172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn7sKjZJynjoU/uIyFk9VMMl5a67yPzt+hLJyY49xhwtkxn1XqkLTU3w/lu848nNiqxdnghutO8ZOde+Z1bPDPQmVaMAufXAH8xZdsGGj6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
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
> Since i40e and ice have the same checksum offload logic, merge their
> functions into one. Future rework should enable this to be used by more
> drivers also.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++++
>   drivers/net/intel/i40e/i40e_rxtx.c   | 52 +-----------------------
>   drivers/net/intel/i40e/i40e_rxtx.h   |  1 +
>   drivers/net/intel/ice/ice_rxtx.c     | 60 +---------------------------
>   drivers/net/intel/ice/ice_rxtx.h     |  1 +
>   5 files changed, 62 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
> index 573f5136a9..cf0dcb4b2c 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -59,6 +59,64 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>   	return 0;
>   }
>   
> +/* Common checksum enable function for Intel drivers (ice, i40e, etc.) */
> +static inline void
> +ci_txd_enable_checksum(uint64_t ol_flags,
> +		       uint32_t *td_cmd,
> +		       uint32_t *td_offset,
> +		       union ci_tx_offload tx_offload)
> +{
> +	/* Enable L3 checksum offloads */
> +	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> +		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
> +		*td_offset |= (tx_offload.l3_len >> 2) <<
> +			CI_TX_DESC_LEN_IPLEN_S;
> +	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
> +		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
> +		*td_offset |= (tx_offload.l3_len >> 2) <<
> +			CI_TX_DESC_LEN_IPLEN_S;
> +	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
> +		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
> +		*td_offset |= (tx_offload.l3_len >> 2) <<
> +			CI_TX_DESC_LEN_IPLEN_S;
> +	}
> +
> +	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
> +		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
> +		*td_offset |= (tx_offload.l4_len >> 2) <<
> +			      CI_TX_DESC_LEN_L4_LEN_S;
> +		return;
> +	}
> +
> +	if (ol_flags & RTE_MBUF_F_TX_UDP_SEG) {
> +		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
> +		*td_offset |= (tx_offload.l4_len >> 2) <<
> +			      CI_TX_DESC_LEN_L4_LEN_S;
> +		return;
> +	}
> +
> +	/* Enable L4 checksum offloads */
> +	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
> +	case RTE_MBUF_F_TX_TCP_CKSUM:
> +		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
> +		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
> +			      CI_TX_DESC_LEN_L4_LEN_S;
> +		break;
> +	case RTE_MBUF_F_TX_SCTP_CKSUM:
> +		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
> +		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
> +			      CI_TX_DESC_LEN_L4_LEN_S;
> +		break;
> +	case RTE_MBUF_F_TX_UDP_CKSUM:
> +		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
> +		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
> +			      CI_TX_DESC_LEN_L4_LEN_S;
> +		break;
> +	default:
> +		break;
> +	}

Nitpick: some of the indentation here is inconststent. Perhaps enabling 
whitespace view in your editor would help, if you haven't done so?

(the inconsistency was already present in the ice function but that 
doesn't mean we have to copy it!)

Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
