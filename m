Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB5AC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35F314026C;
	Thu,  8 May 2025 13:31:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 882D44026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746703895; x=1778239895;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wPm5/4GWhhg4CheX4O0kAVmBzkaSC39e9OQfp+AC2OA=;
 b=mMACCJ7Syc63QejkvKC7kpaoMJ57DCD1GnkWIMrHIOG93rDVgSHvJ+BF
 /hM6W9WueL85VHKLDO2IMckZbS9fLPBUuv1mNAa+gMbOBw7jAiKAi5TjC
 gT6/00709g2AX2J85MIXFyxbqVdeI+XSYSg33l4u4lry7bfyHsD5L5FK7
 ti7wVBTXkTusZIE47BwVCEhs8MsePDHTHWcL9CGBti6nWPxGD2kdQ59tc
 7Dy8PBhinYc/0WskgQA8Z45pR0M2Sq+OX3SAi9hSqmqHvwcmfCqUGNmsR
 DyM5aHlZarUlvCPrj0omv3ffofnxikGSnU1AUOpUBI3+jx/hjjV9yDDh0 Q==;
X-CSE-ConnectionGUID: kEQpgJvlSJyz0V2VuaQ3LA==
X-CSE-MsgGUID: OLP88bDZRlCYh3cxONAmUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48629334"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48629334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:31:34 -0700
X-CSE-ConnectionGUID: 0lbhyfpVSMq4rBdWwsuvTg==
X-CSE-MsgGUID: kUrLR80JTBC95/a2oQ9w6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="135972010"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:31:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:31:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:31:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecVE+p97ydxQiTrnPz7Xc/DuJP3NXZMRSZa/ZwHZQSzgsTgrhGM5rCow1DaftytUJgc0+8RZ/SwnLM9oE/oJzfndLyPshNod7rEIUAyHX5FO4D9WxkbOoDIVkfkduZw6YlTiuXsXiKEzI3dsWJmJSXstK405CUF9UPwJO0ixlcEbtuBIwIlDw8TYKU8qwV0RSHkvpPPNuqwOMk3bpwJ7bIa6mwQcc82mbRDpz2J4ryZhzuW1EhWcCz4t4XuB6eKS8nm83XlYD4d5zrR7V2rnHvxX+OHvt2hd+Z45fm+H5Ece6VOIw50y/85DC1IX0NrTMheDCgkVTgQdRl3ofZvZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0iVURt4nnWDJw2OLkL3Uu9FJKJGp+k7k7ODJvLRV8Y=;
 b=p8uomF6oVi9QqiWvGGuHnzR4pD0WrTRm42wzpTxjdSeE/iRv9ZKVum8wpL1AYDyIrAW7Ybi4m8jeTLxeic1Swz9Cw0uLDT8he/NEUPNhWn8iP/cyocemzrTMf4qle32ExqePz3x+dN73Xw2ohcIW13Db0nsoarmQRXNnzSdAM2cOx6DrES04e+qUC3cWpImLBH9D3Vgs3twg89uAWD89u519WTRxWamSCWzD3bY99Omtt13wzkt/UdHSYmCOIMlPSIEkK+/ekotVaWfd4QO0U9xl623w39xF709qpjEuOPOpUjvPcrIXyGGisJNzjaJh7ZyNWo1fJr0sEpIyXc6Mpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 11:31:14 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:31:14 +0000
Message-ID: <a149bcb6-44c0-479c-bb2b-907c8186557a@intel.com>
Date: Thu, 8 May 2025 13:31:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] bus/pci/bsd: Map resources at EAL baseaddr
To: Jake Freeland <jfree@FreeBSD.org>, Chenbo Xia <chenbox@nvidia.com>, "Nipun
 Gupta" <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
 <20250506174046.1136711-3-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506174046.1136711-3-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a6d2e1-6609-4c83-64d7-08dd8e23d74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzRvdTJhMUtRVlBvcTBYRDh1NUtTQnV6c0Jwd00xZHIxMHY5cTUrT2w2WFJi?=
 =?utf-8?B?a3ltN3MrcnZOL3l0MDVJY2ZpRk9oTVRZQ01WWVBoa3NVNFBWT3lISm91VDIx?=
 =?utf-8?B?STYwaHJsNVV6TTJFeHJBZWhSZ2RtRTl6RWZsZ3Z0QUNxa2trdUJrcDcwQnFF?=
 =?utf-8?B?THBvZWhDdjQ4UysxenpzeFhvbDduY0I5dzRlNmtQVmtsMFRSZXIwMlR1Y09X?=
 =?utf-8?B?cnJLSDBacGZiK054MklpSmhBZ0kyYjFLNitDY1c4Rmp5MElaVGNDV2NaOXF0?=
 =?utf-8?B?b2tNMVJYN2ZaR1dmNHM4aGlrRnJEWG5OckdEWDVQNnBTN0dVaWtDTTQ2aFlV?=
 =?utf-8?B?cm1RYjgvM1Fna1BvYXVlUWFNZkZYNVBjcGVnOWIwZjRvQTEzK2cxVlFWWHpB?=
 =?utf-8?B?VlFOOWRwTGwyZG5vOTZVV1I5MVd2RXlDVVhjNVZWZmEwNjUyS0pWbG16bGFX?=
 =?utf-8?B?WGR2NVZBMXRFNTdZQ0QrRGRyVFR4T2VJR2hPRkI2M2NmMU1jQngyZXE3Tmoy?=
 =?utf-8?B?U2w4cnRIU2R6NllsWnJVYzdwMGszeTZkWE1BbEJnY0VGWlVIZEgxek90UHZO?=
 =?utf-8?B?aU9SM0E0R3VGRVVrL2JleVFsVVVlT2hyWTlBNlEreWZUQkk5Zm4vTEt6VkJO?=
 =?utf-8?B?cUhRWXJMS0RxUC9PSE9BeGlOOHl5TTMyMkxJZDVJMVJyY29ZeTI4VWJncE0x?=
 =?utf-8?B?RWRQNzdNVWZjWHZ3b3NLaGtRMjZpY25nQUJBd3RFbmpmdjUyaUY4R203UmVW?=
 =?utf-8?B?cDlNRE96MGE3d3hHUmhxRDZFTXYydE4rdWU4U3ZZUUlKdEtPOGhtbG1PRmRZ?=
 =?utf-8?B?RWV4S1JJL0pjZXhxTTFwWTNnODdJWklIZFUwNExGQnBZUzhxYjdnT0Z5dzN6?=
 =?utf-8?B?MXI1OXkxd0Fwd2dnQnpPdFV1UGJodkEvNHg0Wmkwb3dxeXArOXFaTW5UeUt3?=
 =?utf-8?B?RGx4WHBtS0MxNFpzUVZQUTZpZTM0cy9STjNUZzFPSzBaODkyeW1rd2xncGdT?=
 =?utf-8?B?S1RMcG5zUUJlMmFCT1VISmFkekMxWHZRb0ZhS0lneHhxTkdDOUxIckxHaDAz?=
 =?utf-8?B?T1lRZGxIYThxN0M0ZFpKVmlPd0EvZWRzMjZRN3hGUXdyZUxmRDdhYzdvZm5u?=
 =?utf-8?B?OE5IT0hRcjg1ZDRoV0hvWlJYNDlpWG1XSXdPUTFBUVlMRUlDME0yZnp1N1dv?=
 =?utf-8?B?V2M5T05nbGgybVpvTzUxSXJFZldkVFR6cFVHdHRQRXZnR3lERnF6eTlsdFNk?=
 =?utf-8?B?K1FGcXNaUFZKTnNRYXlMaHJ0bVBVSm5udFFIeXBLYk9mVFdsOW5raE0yaDFL?=
 =?utf-8?B?RWdjbnFFOStPSnVXWTlYV0lzRWx5VmxRVTJCYjd1Q1hKcUxhenkwZjNFNnU1?=
 =?utf-8?B?MjNoV0dXMVhpcWE1K1IyVlhka282djVnVCtMUHhMbUtwR2ZPTGtPemtLKy9z?=
 =?utf-8?B?S1NNVkwvUS9YbVc5dHVLM1ZPa3MzYUZ2MWFqZ0w0TUxraW0vQ0luNEk2S1FX?=
 =?utf-8?B?bUZoQnRXS0NQWmFvUTR6V3FVczZNaHFpOUJlNkVxdVpVdDQ1T05ObHlWdzM5?=
 =?utf-8?B?VlhQbktHRUlyaU15K1JyRzBOOGloSDFtUWI2OU15aTMvZ0t1T1hXbC9Nd0U2?=
 =?utf-8?B?elFLZnJOSXFMWExGNVZodnJ2WDBzODY0TUx2bW1EeEVoczJjU2JqMG91L0RJ?=
 =?utf-8?B?bXUwaWZUQzFjSVVtbHdBRnFtY3I3UHZDdlM1MnlwMjFNY3JrTVdGbi9EcjZF?=
 =?utf-8?B?WWdnMGs0YU5QeEg3eXJFekdjaStOSDJ3eWxMdjJkUlZhTElXU3ZsYUV3OW9O?=
 =?utf-8?B?Ti9ua3ZNK2dQQ1dFWFZuVm5kRVNaODkrVWZaNThaQXM0L2NLRFV3VldlbkhJ?=
 =?utf-8?B?NkR0NThkVjVCcCswUGlYNVVzWUlkU1FFbkM0WHJ3VzNmVXpVT2xMVE9SOENn?=
 =?utf-8?Q?ebtbU/2icAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1vc2x6Z3VOSXFNbVZpcHZIRWROeUtHcTRYcG94azFDU2Jlb1RkRGMwdDg2?=
 =?utf-8?B?bjBtWHI5c2VuWWRhNjg3ZEMwdytzS0VMOHZzR01xYjd5M3RaMmRUTUs0RlNr?=
 =?utf-8?B?TmJEOFlpSTdGNS9TTVY3VkU2Q1EwM1BJci8rK1J1dGRHWCt1SFhLd2RYTk1W?=
 =?utf-8?B?dTdCcEw3emJ0cG5lRzVUN3U4bEcyTm1ORmd2RExpZUs2Y25KYnJDeWtvMXVU?=
 =?utf-8?B?TG00N0ZLcHBJdzdEWG44M2s1NW5Fc3krRWRiVjdYVkRJQno1TmhuVjBUQWpw?=
 =?utf-8?B?Mnlmczl4SVpQRnNVa1VmUTBTcjMrU2FHMXZlV1FoOWRHMWhwMDdwZDBpMXFD?=
 =?utf-8?B?aHRzNFJTZGxjYmdpNWxwQU9SMFdSeGJwSkJ3V2thVEJxUFJkckxkY3RlUmR5?=
 =?utf-8?B?WmZoemg3bFBmakVpWVpYT2RGakIyRk5ORmFhWW9SeC84MXRiajV4c0tGSklh?=
 =?utf-8?B?akFPSWpXVVZQaWRtbzM0Y0dCbnlLOWNsdmRMbk9pTUpKdnhlYTZIc0hzcVd5?=
 =?utf-8?B?ekt1OTQ2UFBGTmhSTXhpT1N5YXFpeTFTZnFyTEpRK1hsNzJlVVFEZXV3Ullh?=
 =?utf-8?B?SWFYK3hqeFdsZHRoOFpzdVFWTjk3VXhJa2ozM3JkVCtoc3NNNE9HUU5XQ3FQ?=
 =?utf-8?B?U21UdFJBcWM2NnNaUWhvOXRqNFJ3cXo3QklrM2E0ZkwvYXNTYktCUy85dnlG?=
 =?utf-8?B?cWhUejRud0VkbXEyQXZqdDdZMUNGN2FuOVJUOCtNR1IxVzcyNkdHNElGRzEx?=
 =?utf-8?B?djQ2bFpXcVpRNm9sSy9aRitLVVBSVTg4SlZYWjJlS3BWWVFVZy92WTRCU2hT?=
 =?utf-8?B?Tko3TXQzZWdWVEtQZ2hkbWlocGZ6RkxPNm5MNk16STFRRE1xbDl5NDk2dFF3?=
 =?utf-8?B?MDBKTVRzTnJFOTB6RDdUUStyMldpdkxtYUNXK3NYWktPRlNaMDVxckJDVmtF?=
 =?utf-8?B?VzE2elB5MlB4dGdMYWtkSHRTU28yOVd5dWhZbkpjZjhaNW9uWDFkaENyZ2da?=
 =?utf-8?B?K0lGOENHTzJzN2VXU0dHYzhtajJDcXRTOG9kWTZjUDFJblE0TC9NMmttNFFL?=
 =?utf-8?B?OGY0K1NIVVhxTDlVeGdicCsyaytqTGhwNENYTk9sZ1VlR3ZVdWdUcFQ3OVlT?=
 =?utf-8?B?WW1CTG5xdUJ6YmhiR2luNnhWM1VvenRqT0xsbWtQbXE1S0RPbkQ0dWpPUjNP?=
 =?utf-8?B?dmtBSE5URkd1WVU4aXNEb3hZNEVhbmVEKzR2T3hod3FBSkZCaDZXcTRxK0NO?=
 =?utf-8?B?QUN1R1ZsaTU2RnRiSkZ1K00wZGx0dTZDbExCTHJWSXdXdjBUTStha1dqV28x?=
 =?utf-8?B?aFBTdkR5UHdTOFRzQkxaMmJXMmJRbW1kaTNYZUlubWh4ODgzSWlYMXd1SEJT?=
 =?utf-8?B?RVByNk1mVU9GRkNPUnRxM2crTWpqeElCc3Z4cXIxM05lNUE4RXprbDJPbFFv?=
 =?utf-8?B?QjdxNUlFdVhWM3N1aUxyaDdZSUt3YU9IYU10bG4zK2NoemdaK3FFbWNCTHVp?=
 =?utf-8?B?L2p0UGdYa21vZlZUN0ZEQW1NdytrelFDbjBmSUVCRTRaNXVURmlBMHNIQ0JG?=
 =?utf-8?B?Y1hUN1VhM0YzMkpSSk5BUzBxaUlObVJVclAvM3JlTmhyeGR2dlgveGxOQ3hv?=
 =?utf-8?B?OTI4TlpLR2xMSnZhUkdOUWJrd3hMUXgyWFpxOGt2T0ZTU2lmUnVmSmkxWkF0?=
 =?utf-8?B?ZGRTVkFRYXY3WWdKaGJqTGZMTWFOOVpzTzl6eTBINkdIN0NySHJ2eEZCY0Rt?=
 =?utf-8?B?YkgyTEZyeEtZRFNsQTcyNHMwV3MxL0lTN1F1eXlLTnN3WUpJd2VxcS9wTVpR?=
 =?utf-8?B?OG5SYkJ2VjdUTW9PS0FITDZmVndnTGhySzdzK3k1YzdSVHE0N29mNWpLY2h3?=
 =?utf-8?B?UHFxeFNsUW1lR1JYR0l6YzZqZzM2ZXBqS2twVGszVlBLWlJvN0tQaWcranVn?=
 =?utf-8?B?WnI1bXJyRU9Mek90bEF4RmNEaklSTDEzR251cTh6MFprWXJmM1d0bCtDNE5N?=
 =?utf-8?B?bHhYVG0zY0xBcnRYMStVOC9ERUdJMkY2elpGeW5mRS9CSnQvak92RDBZM0FS?=
 =?utf-8?B?RlZsa3cvdllRaTRrTUdmamV5OEFYYlNEcFh1SVl0WTA3WWlPZkxpd0l4QkEr?=
 =?utf-8?B?WXMya3ZXSUpaMFdlYllWNUN1ZmhKbFE3Tis1N1EvZFJMT0YwTHlxc3IwYkZW?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a6d2e1-6609-4c83-64d7-08dd8e23d74f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:31:14.5828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+8+RLiz/SHaIR5Gn9FZSNUP9qiCo4HttZ6GuxuvkdoMjs9Llks8jr0XqLo/5XCIjWaCsqjJhOyBKbOqtcymW8dxUgmOc7AwyVgUbCXzF7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
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

On 5/6/2025 7:40 PM, Jake Freeland wrote:
> Provide the EAL base address as a hint to mmap(2), so device resources
> are not mapped where malloc(3) et al. make allocations.
> 
> This makes mapping conflicts less likely for secondary processes that
> make memory allocations before initializing EAL.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---

I remember attempting to fix this issue by reserving some amount of 
address space for PCI devices in a similar way memory subsystem reserves 
its address space. This doesn't quite do that but is as good a fix as it 
can get without major rework IMO.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
