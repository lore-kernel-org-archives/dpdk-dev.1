Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679BEA3F3A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 10:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B4A400D7;
	Tue, 10 Feb 2026 11:56:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 14B72400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:56:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770721004; x=1802257004;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Lk6o0Rtm++qiKgbSlbZc4cwVx83QRYZYGKUiI5cBY0c=;
 b=QK6zOrFeGQrtWooKcMeziyOQ/ptjRwxeept3Nyzp3GUtNhau0TOdDIUG
 rKhTwGr6g/3cLSRx2SdvXL9tFoik3cINs+RVBA+sDv1i+Uv+SD/h/eg/j
 CpZjq4As17dOoAPes00QRL7zzlBPAWXXORP22EAvlUWCOkijy8V0an+XO
 aJUzN/f1ccLIY2VXJSm6qqWP5ZnxcJFNCbIgWgGmHK0ZjxSHfzMcaO6xs
 E3HW1EuDqBlpFL3MziNCn3FAUn6EMRO7THcaJGgJLNK2ccr5NZMl8axI5
 DnAN4NQjfrITyHLnaNkRc6rYdfgLix1kwro+yO5nvqaurbN1lWO/XEpqr Q==;
X-CSE-ConnectionGUID: 5jwB+0x2TMCLN+BInDeD4g==
X-CSE-MsgGUID: 4CWedJ/ITcijTlUpCdcysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71832849"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71832849"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 02:56:43 -0800
X-CSE-ConnectionGUID: Nz/IAUAvQkmzsWsSsFk9+Q==
X-CSE-MsgGUID: 22ZSQkQNSwG0tv0VVk5RaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249529937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 02:56:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 02:56:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 02:56:42 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 02:56:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArSNEGid/mNGwRnp8E2t/2GflgX21UnSw7PpaABizXVfE5F1JIhGcwWmp1exIBuZr4VTDp4yNJRLnuNBS52dvQQGMjFDqTu7LI5sfiGeRQKXP/lsIZFPKAk1HvA/5tWCUOzpWNzGv7fPXvS2f53+wH5RVLIPOfDTtK8IfnuXotEJDXGn3VyNQ0YGe7NR0pedUAJXPHGpL5MNftUs5vRAkVw7nLuKFJ1lV+7YVEsmyRl0dwKJexEzIrPPsBp0kOkrsOvYYelI5Txyl3sGxmX/j0QtBoOjGaA6Hz8Hc1irEjX2IH1r3ijjKB6Kq475KnMxOTjBcITECOQCLns9Ip7Qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClzKchiZ5++2KuzQUCIg3lAUtpLFmjOj6MYEeonevY0=;
 b=QYt57WC6epLoG7L+urFr5Q3wQzafJ0P+zpT+L6lk0gqcQ2P8BDRT0ikeRDOqU7HwHAgPlhD2ZQPbliVKvRtvC1QOFQkd+ldT0tgnkOwpYeEbK6cAOZsrclN2JQtH/yDQjuN0wOUHCt4PzNfIWJRgl+XrACcOuQlvO0wsuDMZu4kgnDHd1YjpgLnQxi4U3IohJIUmqwhHZonorPhMLOUepKXG+DEuXY8GzBUfqPezbWQI1ZNzKfRwCxf6tnibnDAtBn3Z+Fd1ot2OLHVtADWz08RG4BD0ysDDyl4y16m4Z2IcrqZQ7VZO62DbYDkOkf7vEfGbm5ZUec21lWqszC2z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 10:56:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 10:56:41 +0000
Message-ID: <06e1c612-6610-475f-8211-84fd98723ba7@intel.com>
Date: Tue, 10 Feb 2026 11:56:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/12] net/i40e: use stack allocations for tunnel set
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <fe7f0fcdb712cb1932a3bd360a705af6d5395039.1770646012.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <fe7f0fcdb712cb1932a3bd360a705af6d5395039.1770646012.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0186.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d685bc4-5d07-415f-0141-08de68931232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NmelZ1dEt1cTJPbnE4ZXdTakdDdEk0b01mSm1LWDdxS1d1eFNwN09XcFFi?=
 =?utf-8?B?V3liWDV2QU9DekkvQm9EMnpRUWFVdFJUdVFsZDRwWGdCNTRJNHhYMEJHNXlz?=
 =?utf-8?B?WVV0bG1IMFVVQ0Y3Z2k3TFBNYnRWN2wvNnVOR3N4dGRvdFRNam5jZHdxYjlh?=
 =?utf-8?B?TGZMVE5jUlNSVitYNVV2bU9Ma294cGhFN0JDQ2liWXNyU21nVkFBbHdnd2tC?=
 =?utf-8?B?dmwzVjJyRXBmY1BnWXRhVkRwMWRGUmlVNy9xT0kyUzVDN2pZL2lxT3U0SVFK?=
 =?utf-8?B?Ni9tdGZ0YWFnaHlWTU1zVHpTMTcrWTlHOXJzNUZYa0J2Qml4N0NvRWloV2VT?=
 =?utf-8?B?UHkvZG1yTWdsZXZDcHF0RHRHZG9wUHFDRjRiazBGWWFQMzFyaGNwcGl5N2hp?=
 =?utf-8?B?Y1h0dm80NnJuczFpcUFsZzJDQmVEMmtkQ0luaW56Y211Snc2Qk41cHNyN1RC?=
 =?utf-8?B?UDNBMjBGNEFtUGI1QjJ0MXdRSU1kUWtieUVJV3NTb0dUbEFOS2loVWF2c3Jq?=
 =?utf-8?B?bWY5dUNMaE10WjJ4ZWxkU2o1eTkxSVBHVGNVdjBUM3R2Wk1yMnAwT25pTmRW?=
 =?utf-8?B?K05aZVI4MzNNRTVkVWg1MlVMcHJWa05zSUhBL3FTRHZZQjYxNnV4WlE0VjRu?=
 =?utf-8?B?aTgzaFhmWlJOV1VkeDRhTzZjNElSL0R0L0xDM0xILzhlL1Rwakhaa1greWhP?=
 =?utf-8?B?SjBjNXFrZzE1aTA0MlNMR2kxVStRRDVwN3hRekZqdEYySkwrMGFGYWtkTzZK?=
 =?utf-8?B?UFEyaW9yWkFvSzNRbURuL3RXN1FMUjgxbWNqQmtNTGZmdWdDYmIyd0l6SG12?=
 =?utf-8?B?NHFsTENBUkR2Vnc5ajArKzVUSXptVEJuWWFZRVYzTXI0TVBYMG1Nd1ltZTQ4?=
 =?utf-8?B?Uzc1R3Qra3o0RFZCY1NuZjJUNkEzWEl4djVwUlhMQVZ5UFluZjlhYlppWlJL?=
 =?utf-8?B?aVd3d0tRWHRqTDVpeFBFdVJvb1ViR2RXc05mUDVya0t1MXd4THh0a3g4WmFO?=
 =?utf-8?B?WUtTR2RqbUdZREFER3VpbEc0eVdNdnRORzg2L3Z2UXE0eVlwVExJZDRZRzRr?=
 =?utf-8?B?LzkwdENNQnNoWTlxTmpOcjNwZngzNU5CVEtwQUNXQ052QTVESlpnOExwNlpP?=
 =?utf-8?B?TzNLbzVpWjVVbGs4c1VWOGIvZFcvNHp0S3J3dURJUkxxMFVyN0hHN2N4N3h2?=
 =?utf-8?B?NzFKQTdVNDc1RHpET09ST2FLQ0FGeHVJclRlZVpOMGo3Vlp0VmZ2M0h5bzhk?=
 =?utf-8?B?MG5oMERNUk52WUh3TzRmVHVGVTRvRlJTU1hNS2U5Si9HVzQ4NmtpdFpaOGVk?=
 =?utf-8?B?Ymg2QnBSQUxkVEZvckR2L0FvN2VvcFJGMW1kRVA0cXdxb2M5NExFZDg5L25r?=
 =?utf-8?B?VE85VzFRblBhcGtMSGlab0tUMUdXMWVDek0yZUc5WWJwdzB6MUJHR0RYdGRK?=
 =?utf-8?B?ckQ0RjJRVVdPNnZJUU5hUGlvWnp5OTdJTk9mQnZCQW5oNU5KdDJzZlJoRU4x?=
 =?utf-8?B?OFVxTUpPTFQ3cVB1dytBeDNZRDVlekpaZDN6TlVTc0JVaWVCcjVjZnBHNFZB?=
 =?utf-8?B?MmNROE16amdyL0FlMlhQb1dsRTNhRHhPeWE3c3JXM2VSRHdvaTk2RTB3cnBZ?=
 =?utf-8?B?ekFWL3czQTN6cFQyNWdKNVRHVTZTWUc2SWkzdW5UYk5QR1JyMlNaNFJRZGpt?=
 =?utf-8?B?UG5XT1hsc3B5OWpvaFJMejZYcE9mN2ZYZDVGLzlrcjZHSCtzZ2ZXeUx0QzBh?=
 =?utf-8?B?bFcrajA3VHhwMXprUHpIVTcrcE1XUjF6T29rSlgyL1lpUW95ZlkralowemZR?=
 =?utf-8?B?Tm1Edm50RldMenRsbDlzdFZDYlRHV1NwVXh5czZSRTV3SitONExxY3MwbWdP?=
 =?utf-8?B?VWNsVFlobWloc01PcERZVEcyK3RtdWdtYzU2cS9DV3EydjdlSzA0VEs2RWtp?=
 =?utf-8?B?YjdVQzRiZEZUQkdYYVNOTVNsNVRONkcrN1U5VTdwSzVSR0hLZm8rQS9tUnJr?=
 =?utf-8?B?MmF3K093czExSGlpQm5CNkNDNzcycjJFUzVKS29aelBYaSttMFNSVk9IajUv?=
 =?utf-8?B?NklKZEo4Q2h1djNuUG9IRUFTVnQ0MXh0OGFTdFAzTFBSNis1ZGpPMWJ6MUdl?=
 =?utf-8?Q?1QSs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkYrejFIYXQ1NytROVl3MEpTQ2FGV3V6UEw2cEk0dEhUcFFsaGJnL2VIZDdx?=
 =?utf-8?B?c0E3NjVTZHdvS0IrajFwc3dudGN1VURyY2JuTkpzRWN4SVJKa05pTXBXcmx4?=
 =?utf-8?B?M1k5UUZTaWxmRHhSTlNtYTNNcU81RW53NTRkeDhZOUJScitVelZjYUNXWlY5?=
 =?utf-8?B?dGVEaXkwODlTUkpUalZnWThnK0VGeFFBOExFTGFOTEc3UlVPSFZ2MURhYzQ3?=
 =?utf-8?B?SFVQTmMycTA4TkhwNVk3bnBqbjZndVlTWlYxZ0ZjdHY3Nk11ZEVOTE85bE1N?=
 =?utf-8?B?eVNFM1c4cGwwNy9USlhnWEhGbUFSQWVhUGlEVjg3Zmk1LzNXUUxyZ09tQi9O?=
 =?utf-8?B?RENqaEhVc1dScUpSeHl6NHQ0WFFRdStaYklQMGEwOW9QQ2w4ZVpseXhYODlk?=
 =?utf-8?B?dU1hSDJoMERBcG9rd2poVU9mM0pIRE1CR1dwZnVscXJZRmg5UE41UmkvN2Vv?=
 =?utf-8?B?MHI2d0I1Y0RGaE1ONUxmemRQRFBFNzMvVWp2VEtEVVZMNmFMVnBvVTNDSkty?=
 =?utf-8?B?ME8xTXI2ZGxhWkZRa2k2bnZnRWNPejQvVndjTDAyWWJFa3IxU3NCOVZMVWhx?=
 =?utf-8?B?OEtYVFl5RS9ORTFzc29yVG5FUmR4SUtkNi9aaXZNVUl2VlY4Zi9uekdQVXpl?=
 =?utf-8?B?bVRzQ0ZnZjdHYUtUTFRnYkh5Q3RuVVB2V2JIRFZYMG11dWtLMmV4SjFsZ2JO?=
 =?utf-8?B?OFhRejlySmdUanpjQ091aDhNdDU1TW1ORWt5anJxenV5bEpEMlNnMmwvTGNJ?=
 =?utf-8?B?U1piK0JqVHFxbXk5SmIrUjBVdVRnUGt3Q1BQTFBueW1nSG1FaEFiSGR0M1BZ?=
 =?utf-8?B?SWozVFVwTEozMldYTzJFcUUyTUNCbGVXejRmeHozWXBxMlJDRmVVVE1hU2Fj?=
 =?utf-8?B?aDB3VllMRHdmelAxK1IzTGJUOHJvK1p2RjVONk5PUkNrVExLaW9NQ05wQXdG?=
 =?utf-8?B?TmF4NTNlTWFkSXhyMjk3WTduQWxETDFBRnNMR2w3bk9tcUYyWnU2ZkRRdG1k?=
 =?utf-8?B?a01uNnExNTJMT01INEltVkR2Y05waDJvSU9oVEJ1TzdOZUN0OE5ubFhLSzdY?=
 =?utf-8?B?TUkxcExGZzIvemlGb0MrbWttSldyY2lnWncxaFJnMlF3eUhFRElmNkU4UVBm?=
 =?utf-8?B?UVBiRDZ5cUpVQVlmV1RZcmpuWndVSGVKSjZIdlNJU3BmRzFIRStsL2t0V1VD?=
 =?utf-8?B?UmEvTlBOaHNDMStjczVTVnR0NDl6aUV2d0MwbXlFUGFHNjlwNnBrMEZtQSsz?=
 =?utf-8?B?NkdBOS9Ua0ZoMTRpY3FrS1BFM1hJYUpFZDNvVVFldmVOc2JiVDR2ZGdZWTJs?=
 =?utf-8?B?S2E4Tjd6T2szM0VHNlVVRWNkeDZLUnZkZ0VMOXF4ZFR2N29jNm4rRFBXbTZj?=
 =?utf-8?B?L3VRekNuL3ZrUzZJcHdGK1JUOHphN1hVVkRqU0xhK05FTGM0SG00SzR3LzUw?=
 =?utf-8?B?UmRzL0JiTHl4NWI1K3hUOWZ2YkpUTUJWZllXVlhET0JwU0JTRVNRYlc4Tkhz?=
 =?utf-8?B?alFrcDZZbFBNMVNIYXduc1N4YTUwb2ZxSUhUTGdsSDQzRkVGNFBWTjdrN0xa?=
 =?utf-8?B?L28reGdPZVY1YUpFckpQanRIZm5IbHQxVVpYaFBSaVlTTHFIVGZyek1XTGVs?=
 =?utf-8?B?NmlMUXVRV1Q2QkdMcGg4YmdQbHVURU0rQUR4UG1MZTBCVkRhT01wb3hjak5y?=
 =?utf-8?B?dm9nanRRempmR1ZYbS9tbHd2VUtlZkhwYXNuazczRFMzODBBckJQcktPNEZ2?=
 =?utf-8?B?a0swMTFhazVnNkRtY2VlRmhhWmN3SjRNSzI3Nmx2eEx5VTd3amcyYnFoZ3Vn?=
 =?utf-8?B?NUpBRVhNdU9VdGhlVFRyd1ZHVWdPMVBMZzR2K0d0R2R4QlVVbWpnNFB5KzR2?=
 =?utf-8?B?Rkc2T0dwNUFyc3VtSjF2RU1hRjJZeVZ5SzZQanVKbjNsRHZrQ1llQUxBUUZa?=
 =?utf-8?B?TFVaU0tLalBCbkFCYkQ2c0tCeVhlOG5UZTlvN25VUm44b0NibDJua0ZGSU5E?=
 =?utf-8?B?cUVTMzF4Ly9QYWlMbHZ2cld4Y093eW9lTWlqV2EzMExwSkFrOG8wbUpnWUVa?=
 =?utf-8?B?K2F2YmtGN0NqQWROSEhOallJSHFDRkZmRSswNm11S0p4QjBXTmFkcnBSK2l0?=
 =?utf-8?B?ajB4MmtvbVBSMlBPYXRaa0RkcFZSN1BFZTdmQkI5dDJ1OVkvWkJWWGFNRTlQ?=
 =?utf-8?B?Q25RV1grL2o3L1JIcVJhUWRIZko0eE9wUnY0MCtTdGVNQkJXVS9tY25IZEdt?=
 =?utf-8?B?a1pycXp0MHNCVExPRWlVNW5lbWxjOW1yZWFpRWFPZVZ0SUx0S2tXcVh5c3Vo?=
 =?utf-8?B?TFBiQ1daYUVRT1BOcFJ5T0VyajJpOGJLODdoZzltRldQZWZ6bFN0UEo5TlV1?=
 =?utf-8?Q?FZ/0l7q080Hm7GQw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d685bc4-5d07-415f-0141-08de68931232
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:56:41.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJEQRbcMhMypCK+AlKsX09nqDavP7XIZLdLXSvRwwonippiJNId+826VyJzQ+JAHrOX+bAKPP7SjT1z8ytLWqbjnOdS0qvtrJDgNmyf5uxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
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

On 2/9/2026 3:13 PM, Anatoly Burakov wrote:
> Currently, the tunnel "set" function is using rte_zmalloc to allocate a
> temporary variable. It is actually not needed in this context and can be
> avoided entirely and replaced with stack allocation.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

I've actually found quite a few more of these so I'll send them out as a 
separate patchset.

-- 
Thanks,
Anatoly
