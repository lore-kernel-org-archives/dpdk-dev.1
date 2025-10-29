Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C667CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 10:01:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEF8E40616;
	Wed, 29 Oct 2025 11:01:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 764E040288;
 Wed, 29 Oct 2025 11:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761732095; x=1793268095;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y9R4wWIHvZXahhVWSVLKa9hxMPXkAymjh2HygsQLu3k=;
 b=T3us2RqCpOqXFOBcT5ozUPBP0jI69gEa9Pw890WBR0peyNsDtMuSeUXG
 dNO4D6SmuZr5lHvIqq8BCEpqx4pBf0ZkQ0aSV5xfopCy/lkYwkhBOFVqG
 kRQfTay+bqV09wY4VO6RHVtq4QsUTjvCCzvjBIe6nZWoBaCfcxG0OOCEO
 +O3N2oqOBymkX669yDIIsDL0hCQAZReZzPgKRQiAZAwc5/zNIl9p6UlLg
 /I6kVJOLJvtYqej+6iQcWTP5Y7TtF2lcuZbhqOtwD3ta21FaOAGXkl6KT
 tIXIx+vn8F/og9x+FX9w+QL/fdx8/hnNqCwcNnxt2VQ7Hqt4p2d1qgs5o Q==;
X-CSE-ConnectionGUID: VtuXWntiSSWDv/fEDYqzoQ==
X-CSE-MsgGUID: Xrt0vFHYQ1yu8pSBVk74Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="75193378"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="75193378"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 03:01:29 -0700
X-CSE-ConnectionGUID: au8ShGkWSbSfLqxPTd3Ssw==
X-CSE-MsgGUID: HJGt60mgSGiGNxlsZ753QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="190792427"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 03:01:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 03:01:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 03:01:27 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 03:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8CabgH6PFBABMwj/mqHj92FLRcXaRRuN6DVlTW6t7XVM50u4eIarNU82wJz/fBCapwgU/cC7+f8J7490+KFJBW5O4RUDhJIDaf2Nj8k2fs5+3xZ2GssxsILKrqAutWeHrwENyHX3x2cQUwpbxeinXa6UxSsge/TAbWdBStncAddet+rQc4hx0zp9bXX77K/ugO4BC4JwKD8KO+kKFlVVdF0HTKlw31Fu2sqr4p8OB6+n6XC3OL06CobeVK30DJS7EyfsYsT+kOYPT7qObiEejDLYRuEIUGvuqvhxlHkBiodRG+GcNHX45lPtJIxjbSWJjNbajfE8sRgKHft+ARs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAMdFvEYmrJtGsGwHT97675x2OZmSBjMmTSGyAhaNBc=;
 b=Qbp8O9zDaZrgWcwra4qg36qtaduELOX+7RnX9lQWzSQJklN7IaQYt1yCagIs213CEqtOUshaDCaQFZvOTDOoS9Gi5geOSYMVsdBwW7u0baUhStMGrGY2xxAv8xd2iannyVcRJoFzaQFAXS2bB4joINNPr3pOtnz5wcQEl7Wq9eBI/mBKZEbmI9jedyDHoony3fTdJ9gQSJuWF8uDJuEomu8aoLOWSnoVobSTGx4Sse+7xdXtnD71xfzZ3yXe1tpNFucqfS0ZdXGewa6gFgAQvy5Zj9F8yumfPcoEBC2Hr6vVCIgRWFjYYlg4t3RMnXjPB3XNKr5BhFiPo919L/dqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 10:01:26 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:01:25 +0000
Message-ID: <f3a411f3-adae-4203-8ed6-26441ac379f3@intel.com>
Date: Wed, 29 Oct 2025 10:01:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [dpdk-dev] [PATCH v1 2/3] net/iavf: fix issues with clang 21.1.4
To: <jerinj@marvell.com>, Yiding Zhou <yidingx.zhou@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <stable@dpdk.org>
References: <20251028172324.3149379-1-jerinj@marvell.com>
 <20251028172324.3149379-2-jerinj@marvell.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251028172324.3149379-2-jerinj@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c6309c-75c9-4198-71bb-08de16d21f29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHlSVXcySjJlY2I2ZXlWSklLNkE0UlZtOWVHUGxEM2tvaitPT3lzNkFHcEk4?=
 =?utf-8?B?b1hza292YmRVaTNsb3BlOEU5d1NuMkJJQUZhOUgyYTZDa0N0YzZVSWdFSU4r?=
 =?utf-8?B?VDd4WS9mVFF5VEFwSWF3S2ZoR1RKMEMxUmN5SWs3YWFzQTBWVVJLa0xuTHI0?=
 =?utf-8?B?WXJ1ZkJNMDZrcWU1QTdGdXQxaEJONXVZOTFib2Z1QWcxRmIwYkdIdXk3anBZ?=
 =?utf-8?B?Mnk1eVdZSjBBWC9BelAwd3I3K1I4alBCblJybnI1cE8rK2c5RmRiSzZEeFh0?=
 =?utf-8?B?amlRRHB4alRoV2F6WUM5RHJCa2lvVXNsUzRTeDBUS09pcFZTUnJBbmFaL0Nj?=
 =?utf-8?B?dTN4M1A2dEdkMGdiV3pPUHIyT0Q1U014cEtmN3piK0haS2s4ZlF5dEdoblh2?=
 =?utf-8?B?OG5nVlZRenhxaER3bU1pY09JcTYzazBGTWlTT0I0dzM2eVpoYktReUx3cFJZ?=
 =?utf-8?B?MmhCellaeHVNZGJJVTFqOE92dHBXOU5nNXBNT05SSzJaaHlhdUMxbmVFMVFj?=
 =?utf-8?B?VzRZcVRkQm8wSDhlUDk3a056VWsyUEorM0Z6RG50Y2o3RmNFeWJuOEFCVXhz?=
 =?utf-8?B?Wmx2bGozWDZJTGR0azlRa3hRODBBWDdDbUl6bWFyVDMxd3UwQ0EzemVGWlJR?=
 =?utf-8?B?bjFTRmtaczQ0SUpLWDM4dUZNSkxjSW9qN2dtNUU4aXpPS21pYkc3ajRYbkZP?=
 =?utf-8?B?dnowZ0c1WE5RVXJwaURxOVJBZm1INS9pQUc3ZVg4TWRsei96UzgzdjVlZ05C?=
 =?utf-8?B?TXVjcWV3dVF1Z2ZRdllJUENXVVdQZjFQRlNYUmZUTG9MTllLTjZpM3l1a0tl?=
 =?utf-8?B?aytnN1JJa3cva0wyMVBITk5qL1JteC9kQ21lNG1LUEFFcWIzMkUyRzFvNW1v?=
 =?utf-8?B?dlptOExPOVdvQ1JDQ3V5VlBnb0E0cEpFRkFLQU1HelZSZXAwZzBzNFBPMXlP?=
 =?utf-8?B?Vm4zbDUyQXMzS2k1OTNWam4rVmRPbVdJV1JCMmhDYWRJd0pKYU9uWjFpZ0dq?=
 =?utf-8?B?Z0phY3lmc3JtMEtJQmZHNkFMa1pPbEVCamYzTnpjSmJSMm1xWXovZlhwOTN3?=
 =?utf-8?B?TDZXUzRMNWtMa3k4SXdlVUJOK0FnU1RWbUhlWTFEckliSTZvWVhLcFBjc3k2?=
 =?utf-8?B?RUpOcU1HQS9TdUF4RGFPb2xUU3Y5ZkxLRTl4TnE5N1JHTkdKTXRaUDhvUDN0?=
 =?utf-8?B?T1JhcU5objVseXQ0cnlxVG53R2EwZ1E2SkQzLzluRldLYUNUcGpQZDNpMDJH?=
 =?utf-8?B?NTlyR3VRMHk1SU83Q1BKUWhyRFlSaEtTSmxWSktncCtMVENITC9iWUFCNG95?=
 =?utf-8?B?OGN0WjJaVk9oajUvbTZ2MW1SL1VTUG9yb1RaNS8ydFduanB2emxHdnpMblJW?=
 =?utf-8?B?ZGExekhSVmMzQkszVUMzNzUrQlZVdjBmUUxiRUg5d1Z4WUxBL0w3NU45Ylpv?=
 =?utf-8?B?T1ZqUkRJZkFxNTM4cSs1ZXVXYytlQ2NtQmtod3U0UVh2dVpRQ0orcFpMVkJ3?=
 =?utf-8?B?bVVXMGREK2toTW9tdVFFcDdyWlpZTFkxaWdVVWdVZFNycDdIVmEyWnVKMDJL?=
 =?utf-8?B?ZlFxbUx6ZkFxMnhhZGthYlNickp2SXpYT0UweHpVdjVhZ3ZvYlJLa0lYVWpk?=
 =?utf-8?B?aDFXSXVGZ0p6NlptdlNnNlVXeXdBZzdtU3JnRmh1SnNVSitxMklYZHdoVnZC?=
 =?utf-8?B?MWpqZlIyK25KOXhKWTRFYXhRQjhaNVRzd2dXS0Q1alFBZ0IrNVhlRXhsZWk4?=
 =?utf-8?B?cnBiTkZQd21BQ05Xd1hKQUxIY0pMMzdIaEJxRlp0akl1RWN4M2dtM1BFMVhu?=
 =?utf-8?B?bHlUZi9TMXVJSFRxeWtaZ05uWkJ6dWRRaGRrZzNub0wvblRPTEoyelZNdGg2?=
 =?utf-8?B?WFJJR0tMcjBEaDdtcS93elhyVkNnRnJxSTJRTU9WYUhrdmNrUURSTEhxS0lX?=
 =?utf-8?Q?p7txv1PrgQiTBGacWHIfqrlSotvBX7f3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Y1RUNQVkYvRTVuNXBnTGFQTGJnMmZPVUdlNnVFcHQ1bTlUZjdiYWdQU05G?=
 =?utf-8?B?eHlMQ1FsT0VTQWhoV3NVcUpUaXYxNWsxRUZ5c3JnTjBLbjVnZVBzWHp5Nmor?=
 =?utf-8?B?ZEhaazVUNDVoM2lUUnllZ0tMY09HenNHWklGeHdRK1hpRExqYmdrYzAzaGlz?=
 =?utf-8?B?MXJGNlJENWE0ZDM2VGVndnJwVUVGRkFoSHdpcUh4dDNUVk1XSzd6cUI1UWpK?=
 =?utf-8?B?SmE5RmhqMEJTUFFNN0dDeW0yWnZleUN4VUFSbEU4b2M0bjlKTmJtamxqd0Rj?=
 =?utf-8?B?djhydWFkSXNLTHNOTHo0elRVSTk2Vkt0TFYzbkVFczVmQkhuUTZjVW5Yc2FM?=
 =?utf-8?B?WmtJcHJ5WG0wWFNsSk9hekE0RUZSdXpQaU1mSGlYYitEMjlCTkk3Y3k1ZEgv?=
 =?utf-8?B?SDdXSGNzL0plYk8yMS9oNlNabTZPY2h6SDJnU2x2SXYvTDhIaHFjdTBYKy91?=
 =?utf-8?B?ZTZUb0lYV09DaWQ0UHZXWjJxN1BpUUVId1JQM2w3MWYxdnF1SzBIUDdZOE1U?=
 =?utf-8?B?Q3BHc1pVZExuZEdWM0pWSE45RzNacWhWeHpZWnJORkhkdDN6d0pwcm5UVnhi?=
 =?utf-8?B?RjR3bzU3TE5WRllHdng1dEhGbk5kRVp5aWt3OXByd0JLZk5ORHNwYkZzbDhJ?=
 =?utf-8?B?OEhFclY1cnA2QXM3dGpBS0xzN0tUUi80VkN6ekFRZjJ5Vm1JVVA5elZMdXp2?=
 =?utf-8?B?V3hES0ozdjE5UmlHVzBiOUloaUw0Yy94R0JSTWhMYlM3V2EvZ1k0Q3JYSkJy?=
 =?utf-8?B?cTJNdy9rY3FKMllHRnNEcWdSZzdQdjYrVjE2b2kzbGhDUkMwckQyUnFYNHpv?=
 =?utf-8?B?RStaMEtGQUdabmNWVWZFZ05VVjdVRkVVMEc4OEFnNnlJcHVmN0RvQ05LL1ZF?=
 =?utf-8?B?UDRva1RIQ2dJV05RUXRrZExlRlBPUDFweUZVU1FPWEtxUUI4WmhJRmhxMU1o?=
 =?utf-8?B?L01wZFhlQ2drcTFnUnpaMU5KSEc1OTNKRnRNbWxnK3cxeVRNQ1RId2llelpR?=
 =?utf-8?B?TXVybkRLT0dBVU9SRjNJdjhiR3J3amowekRCZ0RvaThIZUpSUFFCOU5kdjFU?=
 =?utf-8?B?ZzBocFBxN3l1QXpHaHBabVFvT0hUWWkyN0JVZjY2aG9EZUFxSWRsdmNSSko0?=
 =?utf-8?B?NU5GMzkvNFZJMERCcDFhYThaR1BRNUVnQUVkS1B6S0ZuSTJhSlRrSDdycUl4?=
 =?utf-8?B?aVFyUThqa0Y4V3E3OVRLeHRUWDY0bWJOOXJXOGVUdkRIbUlONDI0dDhlemRT?=
 =?utf-8?B?MEJFd3VrSG11TERzVytkZzJQbml1SmRiZmhQdHgrRVg3NlJhWGc2NnZpWWxV?=
 =?utf-8?B?RjVqS1YyWEpLVCtuOWc5SXRsbWFmaEZLMDcyV1JEbG1FVlVROUtxS1A5NGdF?=
 =?utf-8?B?Q0xOSUFxZU05bGwxcUV2cGVyQUNaTzBzOWtRdzlHeVhZalB0UVpWc3ZnVlgw?=
 =?utf-8?B?SklDNEZ4amtVYVZLTStOZi9OMW9rZDF0d2VxODJpZzhTTWF6MXZaNjFCRVd5?=
 =?utf-8?B?UXRpQ1JPenpYVy9RbXBxWGsvemo2N3ZXNW1mOWJUOVBVcjdha29Tc3VZVC9p?=
 =?utf-8?B?MnhBMytya25leTROc1lINEhKWmsyMkZsdnNrRVY5bjVXblNCWnhZWE5YREpH?=
 =?utf-8?B?RlNnZFdzdUJ5bTA0SklyK3JJYTJBRUs3KzNibnlBU1doOTZ2ZGl2dnAyem5O?=
 =?utf-8?B?cHJvVGs4L2pRVlo4MXcySjFKcWdiUWdTNHd3b3g5UDZoM0FNdmhmbFZydHc5?=
 =?utf-8?B?QlA4YVFiaEkwbkh6VkRaa2xzK0I2czFkeFcxNXdPL2lsSE5STnBKUkZBZjhI?=
 =?utf-8?B?Qk1DRHI0bG9URENPVEFHN0NwcWpPWk1kOURlRkJuWDZwSFQ2d09GdXRuVXQ5?=
 =?utf-8?B?a0ZQWmVWRGZGMXNkakc2cnRpN1RTd3pTWjFiVWg2RThXN0VQS3V3azhxcCsr?=
 =?utf-8?B?Q01PUXE1WEtzSXptTW1CaFFIb3Vaa0ZyN1NXdy8rYWtnMjlBSDhMRktyZFBQ?=
 =?utf-8?B?ZVg0aU9sNG1DZ0krQ2VGUGpZUFN0eGJ1cXZqdW13Rk11TjJZeFZ2bjY4UGtk?=
 =?utf-8?B?VDZXa3h2d2ZDV2M5Y2U3R2FZcFpreU9jOEZCZzFsTFEyMDRGN2xFaC9MSHk3?=
 =?utf-8?B?Qmt2QklkVTY4VnloMXFzbDZ3VnMvMklPcEI4M3lyTlRxeTE2SFB1OUVLSTd4?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c6309c-75c9-4198-71bb-08de16d21f29
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:01:25.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFaKVM3rjCtDkaVeGwq76oS2mkJkngoMT8/0qDultQXQkeQQubkI+845MQnHq7HQkoa0Zj4K21NknT9ZPV0WDA4c3OKPjk5e5EBpdw/RSJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
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

On 10/28/2025 5:23 PM, jerinj@marvell.com wrote:
> From: Jerin Jacob <jerinj@marvell.com>
>
> Fix the following error seen with clang 21.1.4
>
> drivers/net/intel/iavf/iavf_vchnl.c:123:38: error: variable
> 'notify_byte' is uninitialized when passed as a const pointer
> argument here [-Werror,-Wuninitialized-const-pointer]
>
> Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
> Cc: stable@dpdk.org
>
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---
>   drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index 460035d772..9ad39300c6 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -102,7 +102,7 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
>   		void *param, size_t param_alloc_size)
>   {
>   	struct iavf_event_handler *handler = &event_handler;
> -	char notify_byte;
> +	char notify_byte = 0;
>   	struct iavf_event_element *elem = rte_malloc(NULL, sizeof(*elem) + param_alloc_size, 0);
>   	if (!elem)
>   		return;

-- 
Regards,
Vladimir

