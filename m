Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CCC79FA1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 11:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6B9D40374;
	Tue,  8 Sep 2026 13:19:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4DEC8402F0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 13:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788866359; x=1820402359;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2MCBqvCVRdKTFRfR2CHV05QCzowzoWkP+WL8vNSCva8=;
 b=GAJsqiUoyGF2W7NmsbIdVQOkn+XtQ6CbC2ljJysC7zfBf9CzBGe9JFb7
 OpkcOvAK2eT/jFIspYmejsOgYSJCo/LZf1gcaWBmdCenutrO0IJIQ9sf1
 BbYlqQOBsZDutPPrzjPbG44TZLjBmeqmQsMKT23l+YyXrxie6e4FOwAUg
 YghBfjHgSP4JhrF3dm31N/TBPMtYw1Eu+kT8DXMNJqUUKvafptjEb03s6
 5Ecr6gLdWgToRd2/wEk5zMw622Vy58vW2XulGjRxWgbwswTZvTN/wRdtZ
 jZLuHyhdlIHzm0I5y0FsKGR+k4LlDBsRoHXlR4EAX1vYAv9n4lVkTXpaz w==;
X-CSE-ConnectionGUID: 3XnZiNQRQOiYzg4VGaETWQ==
X-CSE-MsgGUID: wCDjfReoSKWITZmrXUKvpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88415071"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88415071"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 04:19:18 -0700
X-CSE-ConnectionGUID: ArJJGzzDRqi9qpGEgNfHnA==
X-CSE-MsgGUID: OqYyMau7RrunPdasPXO55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="267718471"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 04:19:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 04:19:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 04:19:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 04:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRTMMPQTGHmgoDkEq2j9SkrV4HnGDJyb5Z9VknLew0HzkGOUehE3QyqA7UbDrIy/WxmT2nURaibBhdNlkftnd3IYDrye65kOvcnJlq7Pklath6vG/xoCnzNbXI1d0OYVpI/CpqLLsTkbtxX7Dwj7ItJFJJ4grG5f/zkHI1+H0EyHsxw98IPju1RU+iy60kOA3jQSGncooGCIHg9pnmztFmf8R+GIuHNrHZniaBke4p7N2yaTY53wrj8BI10eky7O43sprzEbjgvVIv8jGyW+iZh3dIqOD0jipnZ+rYTWbFj6erZrruXKMJX5ORIvaui3sFnNzzr/s73QpyqrbcBgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJrZjSo5V0bndDi7kwBzjYLUVbB9Ypg/BZkImFqDndw=;
 b=oX+A3u9kNwYOngNcyLeaSutT3zmy0znN/G2mQ7Q2apRuA3svHnQhc4dMwRqG2ft25rcTXBlpOPFRC1oM1Tl+C8ufiWYmzzL6zcrcZ7+J02pKFU3mPUQxiGaIHAHjLmTPA44/sjoEu8bme2VFjxP2xurPkGvR3J8l3v/Grx3mjJroC/c/zFpysPKLNIthoEFoKOkhhFXmBGEoA4ifU2SMkkte55hz5sMwQXlOsGtuxhnW8UrVrEFCni0hj8lTCyXY8/4OB+m5TfbQJ8nRTfHHthZflCL00cF4l+yCr7uOhpI1bTSPE2Ic90YcF9/c2sMz1CF5j/iIov1j+pfXLJ7Alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SJ5PPFC15A51B16.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::851)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:19:15 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 11:19:15 +0000
Message-ID: <ac1fe53f-bf6d-4bef-b0e3-931bf9f344d0@intel.com>
Date: Tue, 8 Sep 2026 12:19:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] examples/ipsecgw: do not print from signal handler
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260906232716.496546-10-stephen@networkplumber.org>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260906232716.496546-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::22) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SJ5PPFC15A51B16:EE_
X-MS-Office365-Filtering-Correlation-Id: 303ead79-424b-4aa7-f50f-08df0d9b03c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BMoBg0XoX5xvuYtF08ck6URcUsLdlYj1+DjuiD1hyiQXtLGd1+5zpsHoX3pL6toYHoxf4yNan6+djBhvtkT/l0WBMmSM8KhD6xFhxPqH4CI+Y7VAtYD2NYixldrikDUQswmz6J9UMeqHD/tRB7h9zhnhPeyTYquM7oQgHhso/pnv5YaEj6DEhCNjsVpDPKVWtEKVEGSpx3CJCW/2Nbkcjl+rspu0xy4EflfV32ae2r0SX115L7Blueg7f3vSWbJRxsGUKzjrLOn3GYbK5TJEX/RL7AdfF9zQ4ylDICpImqa5tYLAaJE3SCm+TQnvvtvm+wP6vk8gvKPaHIFicBoABd+rYXg+iAvGStrhXrJHbN+AK+tbp1luUuO6sSs8y03rBK53a28/SmoM9+intIZT31te0/I/sEl+en0dnOa36IcT4dPC45qWUJpBFHEcw6ooIfj3hbz6h3m8oCYarUTg5lY/vrgox26GjL9f62L2RGcFJYKtbmYesHzuU7F+3V61VCS3X6dORkuNHYHNg8k5HDf/HCeh3Rnz7bQ/jdcCFNGxVRBOjEbJKnDjQaXHdyFxFpmpdweX5i5AvAg2MZF38M4pTevw5fpYSPIXvSzvE0ANsndqJhXbm1vYuwW53Dy0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDljWUQyekpvY0VLTnd4Slh4cDA4N09EdVIzOXdTQWFZQkFESW54d2FKb1lU?=
 =?utf-8?B?SFNHUDZ1MFRxakRsTExqOHZDaDFWL3F6aENnUkxDdEJxdHJTMG45YlNSSWFH?=
 =?utf-8?B?eFk3SC9pU00rNnBHaVQwNFIyWW1CdGdrS3lCSlZXcnFQc050dlpzaVhobjdp?=
 =?utf-8?B?VnUveXpLSCtjU0tnYUdML0JkNTdyNkRNanc5V0I2R3p5dXQ1Y3FkVW5kYlJU?=
 =?utf-8?B?S1hHdlZZaFFwV2gwSE4veUxaMktmUXB0YURUZ3RpSTkxa2t6cGx0M2d6VU82?=
 =?utf-8?B?Q04zL0l3Tnpmb0QyT3F3dG9EUFNKakxxRmhnd2h6eGQwUTVVWlNZNndPNjVh?=
 =?utf-8?B?VEoyZE9ic1VZYjhPSUFQYnZrdUc0b1dmalRzb2huNVFQS0tyazFCREJkeXhF?=
 =?utf-8?B?bUJCelpCZkJzS0ViTDRYVXZvdlhUOUJnbm00UHJYSXAxVzBLVklRcU5tV0Fr?=
 =?utf-8?B?eDlIV2VpYlpaUStZeXlXckhoUHJrUGo1WGl1TTUwR3FjclZTN3JCQ2czd2RM?=
 =?utf-8?B?emp6ekJsRUU4MjhycFdkM0FoVW5OSXhCbE5qYndMMVFzYkhuRXF6c3BKNXJP?=
 =?utf-8?B?ZWxHSS8vb1kwRXBKakxnZytqQTJtUThrdytPcXBveHdFSDZuZlZCckhCaVo4?=
 =?utf-8?B?TERIM2t0M08yZjhJenVjUE9PUjVJc0tYaFFCWjZCRjFUbXJMVVYraHI0RTZB?=
 =?utf-8?B?YnRTVTZVMCt6NlFHdXdmKzFKbDhvaEc0ZDF0YkpWa25tYmkwRm1pNUlIQ0d0?=
 =?utf-8?B?S3FBeEFQSnMwdUpSYTZ3M2dyMXNaZ1A2cmpLZ3JUaXgxRTkxaENOVE5HeXl3?=
 =?utf-8?B?QlF1WTNXaEpBVTNCVUxFOE1STk5helhCT2xkMnlIR2JrTHZkNUtzbG8rZkxj?=
 =?utf-8?B?L1JSSkRESTNJVDBUUzhxTmtISHZkUGFtalhkbGdleTJ6N21tRGtMcUszRGxn?=
 =?utf-8?B?aVdsRFBYYTdOajhjbXNudmdUbHgzQU1jbHhuVys2djNCeDhrblA3cFRMT010?=
 =?utf-8?B?STQ1Q3Y1WG54S0dXZlh2dHdJREpMNStVS2Evb2I2eFBmU1JUZFUvaU9ZeHl6?=
 =?utf-8?B?WXZlZVlkQjVHR1FuTDhFU3YzRXdlZE9OOXdlY2p4bWpaNjJ2T1hIT3F1aEJC?=
 =?utf-8?B?K090eUdLcFRGclpNVzlTZUlVbXlsZEdYR25IVW5RZFFVaTlTcitXa0tka040?=
 =?utf-8?B?TDVZdUpOYTZZUk83RjljTHQyalpoYkcvaXRHVUpJTzhiZENyaWxrSkM3YzRm?=
 =?utf-8?B?b1Z3K0FQTFdIUUEzcVpmT3YrbFptVW5hOHZaSzQyTjZNTVEzalV6RVkraXhZ?=
 =?utf-8?B?TjlXYzNsOWRiSnBWOHFvek10WWJUcUVjU3NZTlhrUFVsbi9qdC8rajJzdXZr?=
 =?utf-8?B?TkZhUHhEc1lTaDFXM2xhOUx4VWRaWkR5Q0FkL3I0ZlJFUGROSXBTWnhMZEJW?=
 =?utf-8?B?MkowTkE5OHFVY05qZmt6djBYRW1FZXAvczNkOElnYWxpcnBBbFg2Unk5WEFq?=
 =?utf-8?B?SG1CWXUwb01TOUxyZ0hBY3piVDY5aUhWc2tSV0s1SitDVW9qNEhPQ3UxR0F4?=
 =?utf-8?B?SHJ1TG9YM2ZKUk9vaitkM3M5cEpiZ1dVV2NWdlo3ZXZUaHRvdnFjZ1A0Ly9q?=
 =?utf-8?B?MkllNGRRdTFzNWkyWUtJMlF5ajBxTHVaQ29aYTdEaTJoSEo3bEx4czVRWEto?=
 =?utf-8?B?akd1T0V6VGtFTkp2ajZSNTZ1UUFjY2NaQitkMWRXdUVyZXVQZW1FWkRuSmpR?=
 =?utf-8?B?TmUxd3RZMXd1MzJ2V0dRWkJuY2hMWW40T2ltL3FNcW56VkdhZTVWOVh2aGZq?=
 =?utf-8?B?SW5YazN1NWIzOForamtFQlZKazlpZE1ZdEhIMzY5ZXFBWXdURW03SHY3eTJG?=
 =?utf-8?B?R0tzNHVwcFAwNm9DTTI0emJock04TFNFZmlqS1BCelZicHhybExmRzNCQ1BC?=
 =?utf-8?B?ZlJ5a3VEL2ROc1U0L2F2TWhUcDhKOE9YaW12amt4eENKbk43L29uZXpjZnNj?=
 =?utf-8?B?aFhlYjFJK1J6NXRsbEQ0QjZYUUVKN1kxeHh2eGxLNU40RHQwYmtPNVlBYlY0?=
 =?utf-8?B?WXc0cTRYc2dxZFRPNmRZOVJzU0JqcDJXMmZma3NYVUlhd2puVHIyUm9kUTBX?=
 =?utf-8?B?dUgxNWJYemR0akwzTWNiSWFwYjRzVFh0RkQxRm1qNkFOVTN5cWtEUzY1citi?=
 =?utf-8?B?T3VpZU9zY3BXcmkwdlEzQTg0M21TZDlEdDBDcG1LdzN6YmNPQWZKQStXenNC?=
 =?utf-8?B?Vi91UXdMVG4yQTV2U1A5K0xiODg4Q3M5OUdiNmVWQ2grWFpxOHpiODdoWW5Y?=
 =?utf-8?B?V3hWcXM4UzhERjdzVTRRZDhQNnJ4WTV6Z0Z6d0dMMmYvb1hleXNuZz09?=
X-Exchange-RoutingPolicyChecked: ZTXiVjIPL9DrnUPFzKIIZiJtYadzIc3RSgHKBLlzpyok+m1tR7ryAFPOzTvgasdABMw8vwcLwpyGU1ag7vLEj3GFeJpzXa3SWtHxsFDlkr6A+lesgYq5GzNUwVETTNgqGdhNXUz1rYvFkvwS4syVYeW/fpfD7ySOsQkeeT4VQ4nayr9UphIAvqsEVg3wTRsjezisHOCPZ0iNsunZXqyOnAclCgPlKRjMSWW1R1egIVeUusa0GOpoNuQQkYtrNZD6x5URB9yTQf6RJHAHJmBEVqEI/baG2rFDm7z5Dmeo5ltt7RcopceMm3wtVJiAv64uUXIKLIYR9RXe9XT6ttRj2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 303ead79-424b-4aa7-f50f-08df0d9b03c1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:19:14.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUGeyjHrhBmFNGJ99k9MvKO9ECGi/x65ZaUNjRh9OhatmbN1hZWKJFUy9I/3evfE11vqB6raynS0FYFwHCjI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC15A51B16
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


On 07-Sep-26 12:24 AM, Stephen Hemminger wrote:
> The SIGINT handler calls printf which is not async-signal safe.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   examples/ipsec-secgw/ipsec-secgw.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
> index eba7560c9b..4816bcdd82 100644
> --- a/examples/ipsec-secgw/ipsec-secgw.c
> +++ b/examples/ipsec-secgw/ipsec-secgw.c
> @@ -2448,11 +2448,8 @@ create_default_ipsec_flow(uint16_t port_id, uint64_t rx_offloads)
>   static void
>   signal_handler(int signum)
>   {
> -	if (signum == SIGINT || signum == SIGTERM) {
> -		printf("\n\nSignal %d received, preparing to exit...\n",
> -				signum);
> +	if (signum == SIGINT || signum == SIGTERM)
>   		force_quit = true;
> -	}
>   }
>   
>   static void

I think the same applies to interrupt callbacks (e.g.rte_eth_dev_cb_fn 
), many example apps are using printf in those too.

 From what I see write() is required to be async signal safe and can be 
used instead, in signal handlers and event callbacks, but we will lose 
the va args / format specifiers.

https://man7.org/linux/man-pages/man7/signal-safety.7.html



