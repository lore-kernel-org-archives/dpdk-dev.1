Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29534CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:29:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07A42402D0;
	Sat, 10 Oct 2026 20:29:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8E73F40274
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791656976; x=1823192976;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sCza4MBOLBrxH0vZmNx28GYTAtmKEixe6/QzyI6a69k=;
 b=ZP5vxOt8FFTnEC7XfmanDLsARw5gZs1G1imEQU1MTVxn8VsrBVuj6pw8
 Enm3bMJxO9WI/6LfKs/NzwMVIla5FtTXjgfO/l7oyle4oCpHELItsY6dY
 0UV28Y6O1T2ok37lWpsz/8RRd6IPCN7+9QyezzKtF4OFUD/HC9rNuaz58
 LKM07lg/EXize5qitPZb50UqGlQNs8vh6Mp6UIViwoXjBO9enEHj8tdqx
 k9yTH7VpHyEVU+dSG0CAvV0YlBe2Mk9OIAspYKFHV15s3GlaFlzqdPbHY
 DDD7+YMuUT7FscMsY/MPRZ1PSIoH1puYbz9sQWPdHByQPMLVGgxJ7ol5G w==;
X-CSE-ConnectionGUID: ZPvzbsWvQqakaezqzPELyQ==
X-CSE-MsgGUID: TQkwcwK6SDSL+Am1cGrHwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="307686"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="307686"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:29:35 -0700
X-CSE-ConnectionGUID: Lc68PcdpRmyFIn7TRu1YQg==
X-CSE-MsgGUID: kFGMQp5TR/mSNqgXdHwwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="544155"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:29:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:29:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:29:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:29:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am7U68JWd10PRN1+QUaq1P2meG9pGv/gOYmtirEJQiW+p7DGN6gKNYJkpG7Oj/ynW+OMOXhZNpegq+w6X25NHnTiOYuT7eaqQ0NE5azHfvhYspQZXYElvFvG9h/WEIJp0Z/+uurSNwjEjRNmJZ845mY771+mcd5aH6Pi3xlitq3HbDkj8sCHOJ/LeOyLAvc0Bc8zB8Lnvci+FsVCqZSzR8D/OPqOI5oNm3S6p4s272gRFfIfUDoVD8VIpHZSvsM6EywyngedlWT1k4dM1UPLTD71NgDQ+VlNJWT7AKR+H1GDAHURvYQD1OW2Kg7KlidVA9riyU7OC0gY1Tqj/9tqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwacTwzQiuZDbttYB2uHgJnRJljZ7xbhyKg1LKQ+gNs=;
 b=oKOT47eiyNQ/aiVpTTDm06/KvIY4BrVRK2NsRm7+3U4EpfyY5OpPQypYKMG0tW0HWWrNml/mDFduTZsgQwDJH08EYn6waYE6f5USs3yUuPTQUwLKFVhqVCUCq5UVrzxtPzIkImxtGNQamUp3GcCG1ljiZDg7Cs6D451FO2Ji9HbgjaDRqX0PTmXNSLXeDPcO+ZnV/y+TZ98Ew16PaFy2P6OQ2gm+qLv/IZX4v/GiqWnn/+T6Yhy9UnxMngnInoakzjdbfqM2n8AYc3O5j0/AAjIgvZqx8boFjgKeJ1+pOcwJ7xBvwMQvsZsERqAN+PygxVLFlaefwyS2XprLpWeO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ5PPF524F3F9FA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::829) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 18:29:27 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:29:27 +0000
Message-ID: <308963ee-0fa6-432e-89c2-40b806436f13@intel.com>
Date: Sat, 10 Oct 2026 19:29:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/25] net/ixgbe: add support for common flow parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <35f49edcd0f2ebfd2261b447de963033a4c06e45.1791543154.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <35f49edcd0f2ebfd2261b447de963033a4c06e45.1791543154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0062.eurprd06.prod.outlook.com
 (2603:10a6:10:120::36) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ5PPF524F3F9FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 69104c6f-2683-4a77-9c2e-08df26fc6a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v72zH1FXadVYJ4QNSqolugJ7iSgIuwGye/qHeDbWlabrr43w7FepBWqX5eBFyhtpJUs8MIAEEkOJL7cfRal9xNpB7HZoSpf304eX4UJUWLsaTzoIRNNoqZHQjdSdwznS5hBfjIpLuqYaBjyPxWMr9uusyOhs4WCUUZ47lG+qCDvdUQtfUB7IM+RN8GEdmi9DtuKXrPeLE8d+DBQrwcPjimPHTWRizPf3vzBjc7VAHSTfgosw6L+F+1lupdcaoGtAICKZcbFViNwy61KtzUJkdUfUoN+kBxJJkaWjAB9PZy8jkvtuOxKWq84ffs1d3mTZ+PnGoubhHweea0MSHqB9VKHh0ba/WnFbMfqf3HIC4kG+8giifpvn40B6D3rrZFzEGt+S+UGfgFc9WveDUJGEukOSTHlZXOBTMFpIjIKmMBFyPnneby7jlnCf/+YAOVZw5mShLqpFtRA5u3CiovoTmqlcUteFh+sWjOK6qm6JmIDBRPXTVo4Wbza3A2D+mWz+YR3uNF+pJB0ggnn14mhH7DMj3Mvts0MnhfSxJGUZq2k1c4v0HV9fy7V+VYb7qB4On/SQqXwaWqQcTz4h32FmNrgb+7XyoBVHvyv1LR0VjpfJWfekwvU+oToiXgwWemsdhmoU/opqPCti5AnpAVDrSnz1duzreC3449fncCDCDZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFkTTZHbUV5TG5CbVRFQ0Z5YjNRK3ZsZXB1cVVnbTIxNkRBSUN4Z3NYVGxt?=
 =?utf-8?B?TnFxaXcxK3NvTWNuVkd5L1hpZG1LcG1UVHhXTFdNOFhCcE02a09RcFBTSWoy?=
 =?utf-8?B?eVcxejZtSVJiVE5haTJQdmtPcU12a2NqaG0ybTdmeWxyS3ZwcjhFS0tlRXFP?=
 =?utf-8?B?WjYxb0VhNGJxdXJNYi8zTVNXT29JTm5yenovOVFoOHFiSjhPYXBlWDI0aHVJ?=
 =?utf-8?B?V2N2MEQxVVlSSHVoSFpDRFllYUxLdTNFRXNic3F0eDA3ZnNGbnRkMldOdUpp?=
 =?utf-8?B?WXloK0Y2aEVXZWVIaEdWTS9XcFlnY3Z3bjNQdnpZS2UxeHFVMU55Y1N5dVRV?=
 =?utf-8?B?MGFiMHg3d0FtRC83Q0FYV2pqWXY0VDMvaWhYbGt5MVZtU0lGK3U5UEVvRURM?=
 =?utf-8?B?NW9tZTZJQ2tFaEt6WGFyMHVETEVXbXVmYkdDRWYwU240aVlZTmRPdkM3UTZL?=
 =?utf-8?B?SFhoOTZ3QTRjUFpCL1l6ekNOVldDUEtJK0hkYUpGNGYzYnQ0RS8vaEpPanJP?=
 =?utf-8?B?aEZrK3l3V3pRM1ZhVmpWM0d4K0FkWEIrTzhEYVIrRGphOWhMOXBsK2NxSElR?=
 =?utf-8?B?UkNDcVhKd2hOOVFMaTZ5MzN5MDBUNXJsQjFWUWpUMmJCR0U5b1NhVlRkYzVh?=
 =?utf-8?B?eFMwNm81K1hpT3ZYQTMzUFpLYXlLbnNELzFkSlQzUTYwNmVlZUw3S3JVckFk?=
 =?utf-8?B?d2ZpQzJsVzNtYldFcG9WWjlFV3E3NzB5N3RhNy8vUzhuV1F3cW12WDhOZG03?=
 =?utf-8?B?Tnk1a1FtY3FZamZWbk1RSDlSVVYwWDFpdlB2dkQ3emo3a25OZVduK3h6SDgx?=
 =?utf-8?B?YlpnV2Y0WUlla0NIZWhHM0pQd0RaZlp3WGIxWUdYNWwyUmFDRmluQVVIQUpN?=
 =?utf-8?B?ck5EODhQbXIrVTFUTjZ6T3huY0pKdGZRWVVXcExrUVVPQXFNUTFhN1laWE03?=
 =?utf-8?B?Y0JrR09YTVNnak9sY2h4YVltTm9zR051Q1I3MVRhQzVlTW9rOS9GSnFOQnBC?=
 =?utf-8?B?VkNzQVUrM0JnZzJya1BqU0lrc1pnZnJZbjBEZ1k0NGhDT0NITUlzRysxQ2N1?=
 =?utf-8?B?YTlweCs3MUFQSWRrY1lMcDFxUFVFSVBZNUUzRkJWb0V5S01PMWd5emJ5cUVG?=
 =?utf-8?B?RjZOMjRIUllMazJtcElFaTVOclkwLzZpankrZTBzVjlPVGVKYUVyVnJZSkh1?=
 =?utf-8?B?WGNERWc1NzNXZ3poa2htZEpBSk9TZDlaSmVTandVb2d4aEFvTFhUQTZaZXdm?=
 =?utf-8?B?SUJwT0Y0NFBka2RPcEZWN2xVSmJVdVFzaUJCaENPRHpLM1lPWXRSUEJUMHJv?=
 =?utf-8?B?ZW9KNFcrN3AvZ3RLeWtpdU0zNlJIaTc5TUZWdnpsdVYxYTE1aUNpWlRaYzdB?=
 =?utf-8?B?RElTelNaWjM1Qjh0K0JyWGRoVTY1eDg2RXdUazdFajRrdCtzOHc2QnorT0dU?=
 =?utf-8?B?M3diS3F6VU13MVhBQ0FxUHUxVWt0c0NIbVVpTWJqV1NCY01FOTkwa2huamJu?=
 =?utf-8?B?eGpSL1VtUVRpUndlbng1bzlMbkNmTXBMWFVLMEIzTEZIRGpHTWdKUXVCSDU2?=
 =?utf-8?B?Vk95MGRLdnRiSjZYNTFtRFM1b0FEWWVRR0Q3YUk3WjFBUHVYeHRBMTdKNjNU?=
 =?utf-8?B?a3gzK3lGUG5sQTV3ZHdBZFVUZ2ZwRHJ4Y2N2RTlmL0NCMnQxaVhPcUdlU0lv?=
 =?utf-8?B?bFFyQ1lZVG5ydFkrcTNyUjdjMGU2RlAzaFJxbDlEY2FiT3ZXS3lubVBTMlJx?=
 =?utf-8?B?SVlmZFltWFBqK242UUJMWkwwbWN6Zjl0ay8zbFgzN29rU2JTRjN5WGhBZ29m?=
 =?utf-8?B?NEdPSFMwNVd5dE45QzNtVXFuNThrZzc0c2Z2d21EYy9SckFvUTZjTVBJRWw3?=
 =?utf-8?B?d2N3WkMxVGJCNlJSTlVQdVJPb08raHg2ekZvYzN5NGhiaEpMVXA0TU15UlJP?=
 =?utf-8?B?OU8yd0h1UmhaeHowSGhoV2lUa1BqSEhLek9ZRVJDZE1QRGo1NzNsRWpHZHFl?=
 =?utf-8?B?dmhzS21wWmtTc2ZyMDBmdUI4OG1hUmVrY2dFd0VKMVlPWjN3aDAyVmNqaTIx?=
 =?utf-8?B?NGszMGxBVHRYdFBpRHA0UFF1ZW9SM0QzL1V2NHJKbGd0VVJFSkg4cHgraVVt?=
 =?utf-8?B?eGZlaUZJR0IwQTZ6NnhuNzZJWTlVYXpkamROUGFuUWp5K21xazhQTzc3ODNL?=
 =?utf-8?B?Q2ZudXVqNndoYVVKMml6NDRjTVIzTWJhNEJ6WHFpOXRmZDI4aHpEVTl3VlhJ?=
 =?utf-8?B?OGRhWGFsOC9TR1lSNzB0anptN044aG1kMHFHZzRDVjhNcXErUHN6a3llNVc2?=
 =?utf-8?B?SzU1Y0FCc21nVnhZSVdHdGhIM3ZHRTBvUHRySlBRNkQ1eUIzaGZZd25tQWxv?=
 =?utf-8?Q?/3KrgQl2N5jWYW6g=3D?=
X-Exchange-RoutingPolicyChecked: A3ABWGKf9C1WhvyVTrC8xbW0a6o3Q4pWV5NRCnbzWyii8RbJp5i9GU8DoigYTO9R15wXlodYJtx6+hwiWb5WdC5l383cwRbGLFtexz5Zml7F/sTEhrz87IBCzT2BJKcGfh/AUqOxN6PyVvw0gGD1MYPBkwWIbPaWq6Ddl1BG0knataE0/HIrrT10REs7wodtfCi0+uv0K/bzks1swcQcK2zRG/DHmPgn3hhzufLDXzCJHgONrAAr10juzyHltWzh1ZFM7Nwq6bXNP+eT/+aP6YrP6x6L4lgkIdGVleGpv9eYqVTWux0C0aZHIm8UL/gmCFKejMBl9AKpkdL1VhyNYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69104c6f-2683-4a77-9c2e-08df26fc6a8e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:29:27.2884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngBeb0jY6Ww5HENUYJGJXMtfCwGmKx3OhPBbiTX1Ic0XwqmoPBdZ04k3snH2tTv5C6pq9uo27pC/THg9E6TgSHjuixI7NKdG/goaisNgOaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF524F3F9FA
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

On 10/9/2026 11:58 AM, Anatoly Burakov wrote:
> Implement support for common flow parsing infrastructure in preparation for
> migration of flow engines. The following features are enabled:
>
> - Conf init on dev_init
> - Conf uninit on dev_close
> - Flow replay on dev_start
>
> Currently, ixgbe explicitly clears KEEP_FLOW capability flag, meaning that
> it advertises that all flows are flushed on dev stop. However, in
> practice ixgbe actually restores all flows on dev start, so while we will
> not (yet) advertise the KEEP_FLOW capability flag, we will also not flush
> the flows on dev stop with the new engines, and instead replay them.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>
-- 
Regards,
Vladimir

