Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E92FD8FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACB1402E7;
	Thu, 26 Feb 2026 17:08:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 43D01402E6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772122097; x=1803658097;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LKiWM0vM2FbB77IF9dBrb6zV+KA4LAFqjYdTqUmnPqY=;
 b=SsleGya8R49vVisdOBBucqLsMJqL1ToRal5z6r4K9rPZQS3pHvr8eDyN
 6a8n0BjUvOBNsNjolBf8hPE3ahFAhtLBc1R/5OW0RaKdBvnj7j/mSkFAg
 N+3NqUGwTaATbrsc4wpi7rvIHMMI4NaNe5Wbntq6MSUDXuM6qeGqirexK
 Z1GErjfJU/Tnn3lyi7oW0twvFDPGA+owZgjCwOmNu8WKs6tQUQx3KdO15
 k3ALiOz8I8O32uU1BLYrqptdAf9ruFb4IS3wyvyspZD32pd6GVLNvL+uN
 2cKlluaJ8eVnMusFYUQhazgipdtNfWUCDSkrz7YEAgXYlWpuo7kYKBUeU g==;
X-CSE-ConnectionGUID: ztJKI8N1TkCsG1hHtZfhwg==
X-CSE-MsgGUID: HBCVyQfvSquU7x4s8VKdVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90596294"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="90596294"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:08:15 -0800
X-CSE-ConnectionGUID: 7mWFml/OSSKd8Yr80ovrxA==
X-CSE-MsgGUID: 9XQqybsPSeOWetGewcMwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="244158974"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:08:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:08:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 08:08:14 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 08:08:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeCTF+87B8OeS7EN2otlxsQivxuPT1z0TDy7LP14EthW0oXwN7WO2zCS7m9JqmwxgaKdZcDe1Nkmh2Su6roDXsoGAHHkgA+PpgFGWpq3i/vsp9iK6zx0cWRbOyk5Nhse6HAnv8e3U0l67ei8wmsSl6+JWeWQVv+gbHQeFbZfRAPv9A4Y3Q7bKEcYpKim0v4rUm/TtKXSphaiTr8I8Po4vkxOTwuXtI7M1A4YjN26KDE1QBjsQNMqQXY2NKi+yiMPPWS0Lg0FSIm+kwvzyrFx/XPjbV8utuPljoOIMIxCfHoZMOjpJCmzi7V0YVjm2hEaPJCz4ezjBhukJD8zpWtE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvcTn20OkNJ55eM7NUBy2gbCA4oI5SPFQAXzEpvhijI=;
 b=JuWqKELOJvCxPH+k/qEnyBKJ1CIA+9HOB88Tr8j7Gl0B8QBxVJbmI6NewrZlajQSvP0+sWjnN+NjwM3tTyDpcGC94ozVBZn0HzX7V58lrVLnJS12IV3dMbjUQyTOXBidsDGwF3JRuZ512hsv16wIE8P6fDtIVyvOW0mUGcJ/JT/dyNhNqkr0jMXO8PuDy++V+1VFkTNt5YjZevsvmB6qGNcUUFNs/wF1JcGg0L7SLJJREjmlYZDxiqR9n0Oer71pTKFDP93EuZHoocGmPliM+VYM+H5TguDQinf/5Qj4mM0G+PUWjUS8mRz7x0wtOt+WFMvT8SYhsIKMTDlfy+V9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ5PPFA0B9CD929.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 16:08:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:08:06 +0000
Message-ID: <8ef07213-7871-44bb-9320-454f74f8cb1f@intel.com>
Date: Thu, 26 Feb 2026 17:08:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel: fix wrap-around check in simple Tx scalar path
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20260226153636.3925387-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260226153636.3925387-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ5PPFA0B9CD929:EE_
X-MS-Office365-Filtering-Correlation-Id: afd2b798-2884-4cd4-3196-08de75513a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: vVbfde+OjQtElpMKKnjh3+/XYJl3QyzBB4Iv/18zq92VDLVwp5ZZSmWKjXpqm6ZBGJYypsXN2eU6a8/zI97Q6+asobIkh0SGeJ0JpYieQOIUQln6l9U5YlKwLrjWlkbYRErFoUlgpmEOY52t4iYpoQyKsKtynTjolO4IOpjS9B7DeuhSZTJ52kqg6ALHxS6QlVuRtdtdO4OXR4OoBGZ5aGEm46OPJ87Kx/kv0/bPaDlTaNbLqExqHch3hVu5yVF9cl2M6tzb8AOcinL9uVXyrBn0izORb3fLOQUkq9ZtxhAyBnBACrhx8oMLdqv+LpaAi5PawCwTBZzXNBaU4IVaDUSbDmztrzuspBAgB5H2wi6A1g6WWNSB07lI3iT2xaWsDNasgFSaZmDliX7T8IL7Zz5y4hoktHgJnLsvxWrTefdYrrKA1JOdWfJ68W18y979VgUix8SFBLgjGdQHS0grXUdiC5KC9YoFECD9cqITlrWX2BJeJhN4FUaWQyw/3Rxuc+ezxYV1VrJIS/UTp4XvxoM9Jw9QIf180OCrFwWZvgu0yxHyG0L7J8tTxuUwZVD3fYnRWmqEcEC4WKNHPg/d/c+xZe08BdXmcHedEQnh4a4urHRSr0qy+kTPJRUWUzlEmeaN1VraXiAjak4mVQbEewq1Shylk0s0Thrwx81Nph37p3h1TCT/+XynbN9nUVx8lW2xhfl0mgGYNQ1KefqCPiUe8iqq2NCBy3hRZvh8XWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0Q4eVJpTjlpMHF1RjhGK1dvanNlblFvRkZpUEJTWTdKeVpldlBZcnE5MkZv?=
 =?utf-8?B?eGoyeXZwQWQ2TldzRlNDV1p3TXpQdG1uSGdvbjVOY3FNUldPMnVPTWhCZGdh?=
 =?utf-8?B?eUFROFh5WkNLOTVmTHloWnE3SHFDTFBvU2hFT1JyYmRrUmIyME8vRnlDQTdr?=
 =?utf-8?B?SDA1aGw3MFVPSmVMdHcvWVFpRXZteklyelBJdnVScXFGSkJnQzYvNnpwaHFO?=
 =?utf-8?B?QzdUbXNmRzdDWUpEMEswMk1aY2ppejA3cEtpSUdobCt2dCtTMXVabUtITXpE?=
 =?utf-8?B?RFNaRGZjU29CMEpBc0swbDFCc1Z4ZWpWdjQxbzNaUEliVGljSDRTUFMzMyt3?=
 =?utf-8?B?YWpZRmR2a1E2a290MHpMdm1wZlZRc3hObHVsVVpsN2VNb1UvVEpneTNYaGdt?=
 =?utf-8?B?Vmg1R0VGL1ZwOWNVWEp0ay91bXVSNGdodGVpeUIvVHgyMFpXWkZRUVowYThL?=
 =?utf-8?B?YkV1K0V2WEdObkVRcVAvWTVrRWFaVGVYUTVqNnh2MHpTUk1KU1I2UUxJakdM?=
 =?utf-8?B?LzBrUG9EYjlxNEE3L0NnZ1hxOTFvbGMxaUFlejFzMEJ5VXVOVjZheWZxWmhk?=
 =?utf-8?B?bEZvejEzRjdFSXU0VS9oSFc3bXI1Qkt4MVl4dHJJREpBTVU4MDFXY0p2QmdR?=
 =?utf-8?B?eVBkaDZ3VTlVTXlSQmJQQURaelkvN2ZETlQ3UUZYeXpJV3VNL2E1aW44WEpt?=
 =?utf-8?B?V20vN3FKTTZCY0NFd1lxWjdUSUdxSVJpKzZvWnJENFI4U00rS3BkV01DYmpa?=
 =?utf-8?B?TDRCTWY5bC9uS0ZSd211ZVE3OWZYb0xEZlczbmNjQVVZajZzUm5JZ1JodFpI?=
 =?utf-8?B?bVp6TzB0VGdCM1hkSDdQK1BGeDNIS0U3ZjROWjQ2R3E1eG5rVG5tTFBqZCt5?=
 =?utf-8?B?VGdycTBPUXpMZnIyYUdKQTFiRHlxN1IvcEVLQzBkY3dNWEpZZmRpeVRpbXhW?=
 =?utf-8?B?ZDBxdXJ6M2tIV2N1TVZtYU5tRGhSM1JRRGxzLytmN0UwZ3NRQ2pML2xqYTFu?=
 =?utf-8?B?a3cxODA5K2RhTXhXZy9CSmhjd1ZEekJIMnlaSDBvSHNHRHZUTEdqMndGVzJL?=
 =?utf-8?B?MGhPckhVUE56L010NmpGL2lmWjkxbURwL0pxV0Q5Z29YVTVqYkpkRXhyUlhZ?=
 =?utf-8?B?VHNQK0IxclRuTVBLV1lqTHFENVZ5dXNlOG9Fb3VhUkNtT1dobTdqWDBoelJB?=
 =?utf-8?B?YzI2QnZ2OUEreElWU2xqYmloWUN0UFJBUUw3WGRnUjJFaHRxN2l6NGlPTkIv?=
 =?utf-8?B?dk9sSGRmK1pQdWh4RlRhUGlicHFZK2Vjam5GVk5HNEJMMC9Ia1BOdmczZW5X?=
 =?utf-8?B?dEdRcHdRNkV2dmZnS1J4eHlJNW1memNaNTd1NEtva0ZyVHljc3NNTUh3c3Q1?=
 =?utf-8?B?aExZYUpJVTcvb3dwKzZsYTJycVNlS1VPMXo2c0JqaFYzaUU1NkRsRmsrOHln?=
 =?utf-8?B?akk4ZmdicFJqRTFQb1FDbUYyVnlMZWU2Wk1CQkduZmg1enlYTHFTVlpUVERr?=
 =?utf-8?B?a3dlYVYxdUxjYVlmbTBqUFNVL1ZkOFltbVhlbExGdVJIdXB6aXovQzM3K1BG?=
 =?utf-8?B?bmdMK3ZYdkNRdEUrZlQzQ1YxR0s0S3FjOS9Gcm1MN1V3V29vYjdKRFJtNzNE?=
 =?utf-8?B?SnNyV0lwc3VPRXZpK04vQ0FDWmljOUpuVkNGazZBNmI0c3dub1JFWTJFbklm?=
 =?utf-8?B?M1E5TE14Q1RvSUdlcS81RzUrVnVUbE85VytnWlFDeTRXSVVwbjVkQXNnazdr?=
 =?utf-8?B?MkFKZUQ2eTRsU0ZodXRtaDR6VmQ4OXlOY245bzgxMm9uWDc1MUU1MHpxMitZ?=
 =?utf-8?B?ZzB4d0U0N0NtcktTZEpZbm44WGtQOEg2NDgrbVc1Z0o1Skcrb05RaG1YT08w?=
 =?utf-8?B?MEZHbkl6bjg1Qm1JS1pPYnJjSkJ4cW1ZTkR3YjU2OEwyWHJDMGdjSGFyWWIz?=
 =?utf-8?B?Zjkyc052eDNmc2NPaFBMWmt0TzgvaFVNRVIrSFBJTHdFRmYrWS9LMm1jOTh2?=
 =?utf-8?B?eUtYSWRjMktqVGdOSGRxcGdJakdobkpneVBwY0MxQ1Z1YW01UVZHT0VDSElw?=
 =?utf-8?B?c1FNUmxWS3VBbVBsNjMxYk8xeXhrZVlYMXBwYUtQNFBJdDdyeStLVXRueHFk?=
 =?utf-8?B?eHdDZEROWEFvcnd4bFFZUVY3ZURiUlRIamJtVHhMdW4yQ0Q0d2E3QVRtTlVJ?=
 =?utf-8?B?ajFuTnU3OFdGK3RtTnNvWkUzNGY0aHZ5anlSM2d5citlTFVDZ2JidllBc3dN?=
 =?utf-8?B?UUlIZmRhd1U3OTJBdzFHQU5BTEQxaEdycU04OEhBWVEvMkhCTFpMWVp4REtR?=
 =?utf-8?B?TnR6OFJPY0k4dVlhR0Vwak1HVTZZVm1BZzZFWmo3RnhIYzFCSk5TbG9CNmJH?=
 =?utf-8?Q?4s43pkCPymIY6Mok=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afd2b798-2884-4cd4-3196-08de75513a21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:08:06.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86ucKeqBMis4+FeFd5k6s2KiIOwSUgOi7hIUvmA+HbCNwtPyBwsw/w0vwYUcMYRvKyxCOdFOM+OFu9BCSoM/ToBp9IZR2M+gOXj7CEWxjXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA0B9CD929
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

On 2/26/2026 4:36 PM, Bruce Richardson wrote:
> There was an error condition when the burst of packets being transmitted
> ended exactly on the last descriptor of the ring. In that instance
> alone, we ended up writing an invalid tx_tail value to the hardware, of
> ring_size rather than of zero. Add an explicit check for this case to
> the simple Tx path code.
> 
> Fixes: 9bacf6a81b92 ("net/intel: align scalar simple Tx path with vector logic")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
