Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED370C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C54A9402D9;
	Fri, 25 Sep 2026 14:46:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC8B40294;
 Fri, 25 Sep 2026 14:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790340367; x=1821876367;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l9jkkpVayGwlA1rOIRR0IUkYvjfbjlk/n7O1OWB/NvI=;
 b=SBRLF4Abvaj5Ljz+7TiPajjmpPDu1veaDOJBR+3CWvuH6k7gOVsLCEy/
 mLnDCEDIYaFJ21U7rLWNnhyAD3xfjGQDOm7S9EkErRK5gXcj0hWmtYKXq
 mGI8R/F1tr9E0fKAMcuV1ygJWpGhhlYafBM2vh+sgKJ/nF92G4HsbBD0o
 QovbxbwPPCoyZNo8Takx9rGlYQe4dXoGMuzB1Yd0LnanxGQ+g80WgoYbC
 0di1RRf8WC9iMbWsk2Z+3rewCy0G0dTW264fLSfnVUISr9VcqEeekyAe7
 f4L02tg9TO7z42jbIcLBLwMJdgOOSpuZX2G2esHZ35PvF9VAGa7o2WJ47 w==;
X-CSE-ConnectionGUID: A7g0vY1uS3C7IKhQAmRjwg==
X-CSE-MsgGUID: FMsKMht7RuWfvK4YD1KRTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="94942147"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="94942147"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:46:06 -0700
X-CSE-ConnectionGUID: qw/1uYQDQ7WbVxK2cneFig==
X-CSE-MsgGUID: lsCF5jUdSWei3Y6TgE1Rhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272904485"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 05:46:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:46:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:46:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeJMvTI2gtHYdvvhk+swJt57E9cvdjfGr8DxjzioRTUIO9TAOOGGyauFURIuJ/ksU/W9c+mLn3nFTocFerfuC2iR9mhldTrmxrsS7vLZko8jsT708o1G3CDAp636Z2Bt7LjwtAm4WerqnKfQ3VOPX/xAUiJZHYdxROGi6pqPARpiJMZHjKFXpeVByUd3rvu1mPd8Lvvm5GK8sCgQNSq1aiGXlx7LuNB4JxM3QnF453LNKPHJ9frpY+TYLBQzsGCH39qe4B9xrtuHFxhhZEHbgxD5r2AqIquvsRAMZsLtHe/yvuvHDP9qWhcQ3Jo61lRN3lV82LPIJ/yOubYR7YIOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs3gtkoVwZg6oYUza6ieX1SyH0U8JLlVDLR+GZ3x08A=;
 b=zNlfg/5NUsMfpcj8Qrl+8Lrd0my52yxiOr5rQrGlsUt2M0HmJv5rHJVdZtse7jP6KWhMHKKK32qRKjVVd5GYFVSH1+V7c0MoqZ9ZMRcs8DjJ6GEd5TLZ0k1J6KU06GB1u2q1p1k6BTAhy3aIhv9vev3UX1b5xZ1DCx0lCgf3Sv44YblrzD8AmF857tpzVLxKvTSUdQ/zegqVorYo/Dtl8ktmoXuaZqvVZuIMxwRIWW48F36I9DFYibjiEK6m95zu4XL41ALzpD3EHdCYdxFyWm1mDVDtItr65V4gEvvJSn+hV7YZh6oSdRtE2LOJcaoeyaya+SrntZI0dqG5blQkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Fri, 25 Sep 2026 12:46:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:46:03 +0000
Message-ID: <ad7a38a2-9891-48fb-9281-f196ce4e123a@intel.com>
Date: Fri, 25 Sep 2026 14:45:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iavf: remove redundant assignment in FDIR parser
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jia.guo@intel.com>
References: <20260915095055.431718-1-Evgeny.Sokolov@infotecs.ru>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260915095055.431718-1-Evgeny.Sokolov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:10:110::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5472d2d4-2c03-4de3-ab29-08df1b02f556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: am6TaHvcJXgdqh9hV8rSVxEqg4nqLG52FyXzMnYugM6oihd0K6ljjQWmHHUsCWyQQabvextBhlsa05/ic8ThXHQUCuqm/Rwqhc25rk+KE1ixVPhUw5BkXAEUU0DXU/dzit9X9T//UxVbue0Ne1SxYlUtHw6SbyyVicC2ciWa7UeUcu9o9zJd5NAaQE/ou4NtO3NPl0KxygNdVnYOH1yyG+gvr0CsUUdus5p5cN2UJ0xYZsFRxDXJdX1AE/SYrgsQRYBrAkycJ5UwUFSlbNnsoK4AhSJ4kyPCCnR92MmHVNGTUCVcXqmAn9ZgQhqs9K8bbi7AzSVCzpPrUkF0pXphBTGUBCYaUDST2vsQ7wsLHUTYvvcFYSFhRuj3FfdmQcM7r2EDuQLL0pzb4bPL78LB2+W87Rs4iADzf7+UblScUwTUnF4Kl5HuHouGOrtiGWeyDI2wLSy4ptSMOmcdzxUuI7ttj89h7OfXH9jTD9QDOMitTQjhpCGlE3mEj0epnp9k5mObhVi8naGzPH7bPxi4rrvnTXFcw0+Z00NTg7/2HDr+6LXqFdIrd0bKDVZkIua31pQAg3vtpiuA9/qz5qs/82k4SVYkEdgoejo/4DQ+R7bZpoMdgTzv/03obo1Vy0kT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25FTjRsdndQQ2xRYmoyVTJVcFMzbFB6YlBwZ0g1dU5EUkQ5dVNqVmsrTFlo?=
 =?utf-8?B?anc2NHJQN0hQcnU2bm1WYnVHSHhJQmRrTmZ3Z21sektmY1Nvell1eXdFV2Jy?=
 =?utf-8?B?VFVTUHJzSlB2YTFoa0tOdUhta2QxcXdhcU9OcVlZM2tBeUhBOFFNZFFhbkhW?=
 =?utf-8?B?d1p4cnpDMTUwU09SOHJWMHV0WkJoZ01uMmY3ZGJBR3BEbDhZOTZ4SFJNYnFR?=
 =?utf-8?B?VytiNkV3ZDVwSVh5SSt4dU43ak9KRWdydm03VHBiZ2lWTmMxVWFLaERRbyt6?=
 =?utf-8?B?bEZPaDJvTlV4YjIwVGlXR1cwK3UvNlYrWkxFM2pHKzNuQVFhNG9ESG5UL21G?=
 =?utf-8?B?aHFhbnZTNmtUSFZPeTYxRzJxQ1dxdDNGTlBvaTlzM2tEbHBlUkowbXIzcjZX?=
 =?utf-8?B?U2h0UWVOci9vRmtzM0ZyWmdoTGNSYUYxeThYditrT0pYeU9BK1NZZWVLRnQ2?=
 =?utf-8?B?QTFzc0thdGdzWjZ3cFpKb1lNZjlKY3lIb2htS2l3TjJIQ0pPbE9scWNGWnUx?=
 =?utf-8?B?TjdwL2NoeWtxK3dLSmpZbXlRTDhoS3czS3A4MVQrbzFmSjcycHpZYmR4cWFD?=
 =?utf-8?B?RjZJUWJTc0xjalJQc0ZSb2lqS3A2Rkxua0FCYXhQczBuZnRDenk4enZxYjF5?=
 =?utf-8?B?bjk2RXcyczNwT1d0R21QRnVmeW5qNkdENUdhc2dBNGdhU3JLdWNIV2JzL1Q0?=
 =?utf-8?B?dFdBNll0N0YybzRrSFdXakl6R01KcU83WmRqdjNaVkNxNnA2bHFwVFJFN05E?=
 =?utf-8?B?ZmIrMjBhRmU2WVBrRHZxenBvcGgwaHh6bVhzemc2ZnB1Z1VpYzBCNXdld1Vr?=
 =?utf-8?B?d1pzdXlFUi9CcjA1WklabnFyQjJVU01keFU3Zm5zRHlFV1VjYk91MDZGancw?=
 =?utf-8?B?RmVhcjYrQ1d3UkVvYTBZWGgrLzY3bGxJOURHQ3g5SVU5bWhRb3JJcGRXMkF5?=
 =?utf-8?B?OXM2YjN5b0xhQ0pBQmpJUHNrRmdkNXN3R3ZrK01pRFFTa09WcXRpeUhIdkJu?=
 =?utf-8?B?dnRwalFuYTBSV3l2KzVqcUN6MW8vSjRLMzQwN2hEajJFRU5XVWtSUXI3VVM2?=
 =?utf-8?B?VG9xa28vMStzZWlVRTVydlBXazVWbTJSMGZvcFd6SHR0ZUdxdjFWMGN6Y21T?=
 =?utf-8?B?SzVnQ1RkUy9qK1k4UjQxRXV4WVRjVTVoTGR5ak9XNnQxNkU1S0tTNENneE16?=
 =?utf-8?B?MzZPakpKTXBmbHU5dW9yZ3U4a0hLQi9tNXkwRW5VSUhlVTE1dHdGRWQ5VmN1?=
 =?utf-8?B?b09rS09xZ0Qxa204VkVmOTNlR0lZYXcvZENIUTBIMFBTUStoNjRxNVJ6NXpW?=
 =?utf-8?B?VE9GWUNCNE5zY3hNeTRuNkR3TUdHaVFMTE56Vk5EaS9FQ3Z4eitjQWRicnRq?=
 =?utf-8?B?RWh4Ym12cTNCK0U4U2x4STY4eHM3S1VtSUNxM2djVVkyaER2NGtjOFJBSVRt?=
 =?utf-8?B?dVg1cXlsZm5BdFZlQmg4WXJRWk01ZjF5aGlxdnlKVi9JTHBFWW5ZTXF3eFlY?=
 =?utf-8?B?bEdhM2R1L3ZhSFFIL002OE9oSVJvdnZNMENmR2k5blBaK3h5YmhGN1lnR3pu?=
 =?utf-8?B?L2E2cDBiR1NuWG40cDRnT0dZSGhETmFVRFVpUmVFTnBJRkxkd0wyaFRiMjRP?=
 =?utf-8?B?STV2cno5OE9SV2kxWTljcG85bUlZTGNJUVBLcUVpdUlNV0xHQ2M0dktGNnFB?=
 =?utf-8?B?RC93OGg1ZmFQVThmWmhaU2J2ZHR1NUdEOVJIR2huclFENXI4VVU5OEtWWEU3?=
 =?utf-8?B?YUVTcExDSlEwOWIxQ1U5cUdhb1FlUDJrNXZzRVNXc3dweks5NjBRT002bXJH?=
 =?utf-8?B?RzVGMTkwa2JQYjVyUE1xWkdpTW9McTdFdFRpN2RHZkE0VXhJT0lZajVjSjNl?=
 =?utf-8?B?VHNESWhVQXNqOTVjU1p0NFZDK2F2WXJqckVpSmd1L3R2T3lzcDN1NFFvVzVE?=
 =?utf-8?B?a1FzT1A3L1JsYTJpLzBsTEtWMjF2NGpQa082MG9ETDNDRHFWRVg3WC9UYThF?=
 =?utf-8?B?WlJXU0NYb3p1UjhsYk1hSHdjblFzNnUyelF6WEtDekk2R2pSWE9hSmh1QThU?=
 =?utf-8?B?eXRMUVYxQm9IWHoxcGkzbmY1cm96RW1BdkRIOGl2WDRENFFSQWNBdm13eEtq?=
 =?utf-8?B?YmdxSW4xcUFHTmZxR3hHc2t6b25tNlB5M2NkNnRTZ1NFZnpMTVN3T0VlSW5S?=
 =?utf-8?B?LzlERG5kdVR4SnRJNDVQb2gwN0lLVGRzTklCZ0ptUU1oOXRYWTFXM1Q3OFJw?=
 =?utf-8?B?NWtBZUd3WStNODN0THJCeGxhK0htVHpMam9NUTQ3M2NzUDV0QThOaHRVV0Nq?=
 =?utf-8?B?a2Q0cW1oU21lQ1NaUWRFcFFWallkaUZxRHJMcThyRzBaU1VhWkJxaDhhL21z?=
 =?utf-8?Q?tan4kzHJ2c26JKyM=3D?=
X-Exchange-RoutingPolicyChecked: GyEKJ3405LL08sTGQ90qO82X2a39ob1Au8bUSxi1H9Devwg0mi+fRYStuHtxs0imyv0bgJUrp2AXiJNJISAUuQXVhZDwZfvznd873Hayjni6eXK7QhT/Jm60oVyC9xJPAOaH/pb51LYDjFkcn2kN4Rk+hSIJCPH1xmUoq98VeNKG1FLiEEu5YUU5KBoYu7wGqhxbFjUtE/wBuQw28ZAyZ6U8BdD4Imubwjb0xTUFiLhD4/n5OhKR/dJ4dBSic9MT1UYMizQrPhzcBs9i0A4IFHCwe3XIlmXNiCrCagWEjA4l5E4hog5+M+ikAJdD4CxXZ6Ixh4fR3ktUcci7bXBbMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5472d2d4-2c03-4de3-ab29-08df1b02f556
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:46:03.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWdgz0v9GlZ7NvDDw7ThDTS/+sSEsmrqi/c/OV/Z4wgVqPZXfVUp9mno0daIECoSljleg3umB4IbtlCZ3S3DjyX9VdCwmmiUl+vHiULerQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
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

On 9/15/2026 11:50 AM, Evgeny Sokolov wrote:
> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> 
> The assignment to next_type in the <case> branch is redundant since
> the value is never used afterwards.
> 
> Remove the leftover assignment, which appears to have been copied from
> another parser branch, to avoid confusing readers.
> 
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---

This patch looks related to the other one [1] that you have submitted, 
and my comments for that patch apply here as well.

Also, please do not put advertisements in commit message, thank you.

[1] 
https://patches.dpdk.org/project/dpdk/patch/20260915104617.467149-1-Evgeny.Sokolov@infotecs.ru/

-- 
Thanks,
Anatoly
