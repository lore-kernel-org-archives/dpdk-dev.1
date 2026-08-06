Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC121C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09577402D3;
	Thu,  6 Aug 2026 08:13:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
 by mails.dpdk.org (Postfix) with ESMTP id E75914027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:13:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws7z04wwZqFSPCmsjy61Lj+9C9SpukGNnmzeFxbGZ36ymac6FTUh9Lt9HUrJoK/Xkk0EKEiBiYyAM5YFazWTgTdK0UDd32Iln/bwTZQu1JkNxhDzQyyJzU4IKa45Lr0GSdiBXLSaulKRsGpJE0QuKtsBIg1tBzPWRnhVsyFJBnzj8jhFlzST/70alCM3UhTl+ciXsqWvDYhsMmdz/LqGaGttbjLGGFp9yPYh0AQX2jvXoSpVgwir2ud72oeJ14xMRVlZvCcSRo5fnjCvgQowYyp2QpYZI0JCN0HdSMb9JsH3VtqifznEfeSJzuzyKpWj9WHOL3IRupGCvg2a29Rb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsgi5YhJyffI72wqgU5O60pIoNCUii/DooA3JXz2vC4=;
 b=LMip9FJsB4rrvcCZXQjhjwrXK1iJTAIaFFkvK8QBhRa3qJRyKnr8ux2w7Ott5tvInMRW3BTt9aAtbhbo0U15ahPdPMNGamYJJXOvVia/Y3jXZBC89MJrunxKCZHoiUeztCU748ND9KwJO1EoVSm57ke/TwmB57tTMYnWgTPWFYzzvgZVhul6bGgAwRTvKy/9qAxcxILPuOhqjUGVznL8JLSR9YXRN7ODEZWmvtYgj4J6WAcij5tne0q2Ne+qO/ooBMQbcnf7ZNSZdHHJCF1nHbvIV1BG6cpHOL/fE/9OrHBfO3M3T7nTKVbC+NsU051zBwECiAnqzS5n8vd5jt/oKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsgi5YhJyffI72wqgU5O60pIoNCUii/DooA3JXz2vC4=;
 b=s3eNoefmPKw4OOcrWsWauyF/xp3hQQZg8x24FwehoVLho21pfJQmHOU8map5NVn8yMWXM9FjLi3PNz1L1LYIZi7x0UycDNC/PYGFbDXpbjQxQ0nbEwb+M+/MIbLolk/jqrct1x9lg/ui7IG0fNGm6/VY+mVI3tsrXbrbsDkanroPij6eb6BnpX7ZUn84YIgoStGG+s8LvW5cCn2v9Lz+mvf9y9r76ciD6bzxZjNfd6L+qDTgzhWH7Nh9p+f5mCgN05RECw03R5Bp3lyGlIEFVuw1P8A8cCGCqmheBerhv5SxXoROYJGU8UI9tAQr8xxL2uhzh/CpFr8Qx3lIlouw4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM7PR04MB7110.eurprd04.prod.outlook.com
 (2603:10a6:20b:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:13:27 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:13:27 +0000
Message-ID: <ddd556ba-498f-4d30-96b5-3b0296cd8501@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:43:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] drivers/net: remove unused include in dpaa and
 dpaa2
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-2-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260806051004.166778-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 GV1PR04MB10750.eurprd04.prod.outlook.com (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: d736876b-35cb-4444-0ecc-08def381d492
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VjH4xHowN/4zvC4UdK/2LhgD3lf4qjLdEYeOjSzzMJ1ROpMSMdGg6qUoiY9xcsa3HG4beIHFbQsvtdJ8Gy2+ftqXaWbXpRwY8K5u9QOVr0yt8blEjzDCoVfzKp0BEqBKg6WPVMhxCIusXC4S5EcpooUgIOoX91ywRQ1yoA4MrR2xfyQgptontf7LVG+psWjEf4e4WOslBElpbUKNvB4qAxTLo0eLRxFmeoSqscsPUuPw2cckfWawzudPIXuvgeyIiOfEecwOi7wviDwTjy7d//EysXBeENByjXruihKbc0QU1lWu6nDVQIKl9lTnd+73cWdBUCY5pptbIJVl4EAVzizsLi9XZdxzIT+t+bjNCwvHwXHzDWHBj4y9SfTHcmF0ZmHMyW6hdQMZNS2HNdxIklLOrp9A5kOR4TRcY4QEuTjLMJUgx/dyaifNjpBgJw7n8u08+NWTjiKOOnZipUJvYFu6SW81Zfx1xzoOiBdrExgKkfBSzqKxhePy5OZUf/5WhVF0C5AgFw9y5MxfpBC3kZzCeCeyqF+mL6pN6dpSm+R5Y4RltvL4Qo0W8b0atWqAIpQcKseVaEnHUfDe+1CLWStc5ecP6Zmjk4BKNd9KrfPyR5QP/acrgxk2oMzUu8w3yeT5uc7T1MQLmKG/7iWdOHV/cKBrC+PxmEXQbzlk6+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU12T0J1N0wxWEdYemg2WENEYUdjbzVKc1M1KzlvZ3I4SnZ5Z25RNTBQK0t4?=
 =?utf-8?B?ZkNocEN0MVIxbzkwQ3BEendmNHhWRUlKUUhKbHVuMEZXRnZ5dldob2lKcFVQ?=
 =?utf-8?B?UlhqUWRaMVdYMnpFQVFrSkE5UXQ0SnRxVEl1bXVNQktCTERIMm82dWRwWFdO?=
 =?utf-8?B?Y2tUSFBwRm1jOG5GVCswZkJHNENDM3pXZ3J1Q0E4Ukticnp2Y3VudUlrWlAv?=
 =?utf-8?B?TDJ4K0JmeHp2anlHY3c5Rm10UTJkVmZUejV4Wm51cStqMEZNNlRtTmdxUTA3?=
 =?utf-8?B?a2lkM1N4NjdoTHV3S3Jkdkh4c0ZOcFprNE1tdVo0V1ovUm9IYzdyZDUwR1lT?=
 =?utf-8?B?Uk9ubnJ5OVljTmc2K0huZUxLQXVBVHRmZ1o4MTY3OWhNbUtOYTl6OHpPWnFS?=
 =?utf-8?B?K21DNUt4MGtDWFhMZDY2QXBKTU5yeXY4c3JtUjR2R2U3Mng5bDJheDhDUCsw?=
 =?utf-8?B?OTRuY29iSDh5aGRSWnJiWUpQY2lmTCtzWDRhWUFIaFhDZlVIaEhmVUVYSWJG?=
 =?utf-8?B?WG01M284b2FwQlUrS2JxN0hreU5WRnFpd1pTelFZRE5qYlo0SDVLVXpJL0VU?=
 =?utf-8?B?Wm1JTlFFU042K1dEUkU0WWI3SDkyQXBrV2FwV3FXSFgvSzIxSS9SazdWSFgv?=
 =?utf-8?B?dHY3SE9oYVUweWIydzc1cGVRRHB3STBPZUc0NnJ0OFV3MEJ0MGJwTEo4SFlK?=
 =?utf-8?B?Tm1xZXkrNCsyY3g2YjFsOFovMjdQMGpvZ3ZBRjFORzc0TXJUOHcxYWRmamNV?=
 =?utf-8?B?YS8rS25wWTZ3MHd2MjJ5alIvdjd4N0JVSzhrTWJYb3dOYzdqWUxKWVVWY1Bp?=
 =?utf-8?B?dEYwNFdqdDlBR0J3L0hPT2J3dTZnYlZTcFpDTGpraFgyTDl5Mmt4WGsyaFJJ?=
 =?utf-8?B?ZlhLdUZLbmF3SUpnWG50NGoxVUo0bFVwRDhadzA3OVBjbWl4ODkzUmR5cm5v?=
 =?utf-8?B?UFEyOVJZdElpd0hmTmZhUFZ5UWFHQVlBMTJQR3JReUh3MFVRUk9ZS0RYMmx5?=
 =?utf-8?B?VElmNUZab2pxNFJvUXlvUitBaGl2VHRnaS9oS3h0NC8zRjJqQVBZUVdFRFM1?=
 =?utf-8?B?L2NGODk5ZFF2UGlkWVhqV21SLzkxLzd5U21WUEx6Kys1eWxvUldaVFFFcG5R?=
 =?utf-8?B?cHVudnIrQlQxTFlFRVZsTFBWVzJ6MDVoWlBuVGFSK1hsZDJKRGZvUGtDUUVQ?=
 =?utf-8?B?bm1zL2YrblNRam5oWDEwMGJBVUJlM2o5V3BwcEs2K2NJR2xsclFTQUc1YkQz?=
 =?utf-8?B?OGxxTndwMFlvYmxyMG9GbEhUZkRKWGZqUHRIN0VTcFFWU1MvTDViM1lrUFJm?=
 =?utf-8?B?Z0wxc20xdEZoOW41cHUvUklrbDViMjY3eStCOGdQa1hwWHVaME1ZNFVPNXFv?=
 =?utf-8?B?UTdlQ21sM2JQTnZhbFlPMjVLMGhEUmVNSXNBMDRORlYrQzYyQmM1bHVJdldZ?=
 =?utf-8?B?UkM2L3dUV0szV2dwekpNckR3anhmaHp5MW1XZVFic21SODIydWk2ZEVKWElB?=
 =?utf-8?B?NnZWRTRDN0tkRTY2QldncllBR1ZPUHFpMXRyUnlqTytGVDhCMWVmMGRoYzFu?=
 =?utf-8?B?dWZYNHNQa2N3UmhTd2IxOEJUZjNINWw1VDBTWjdMSnZBSGVWdFpvNVhMK1p5?=
 =?utf-8?B?cG5wbjZPWVVtSVJoTkdXOWVZUU5vcDdkTWhuMWFUdzk1MXR3NTR3OW9MMWNF?=
 =?utf-8?B?cElaaUlUeEltdlU3cjBtV0c4OVhwekx5R0dNQ2U1eXpDYzU3R2pIWnROZjNL?=
 =?utf-8?B?clorQzlYZVBNS284Sk11bk1ob0ZUcTZEMFhoUk55dlB1T25ZY2ZiemJtaWJq?=
 =?utf-8?B?SzVDNEd5bytIRFNFUzVnaExVOE1VWnp5Y3gwVExwU2ZTVXNwcU5wcDlxZUZ3?=
 =?utf-8?B?U3ZYZHdhdTc0aXJOV0Q4NVdDS3JmcDdaNFFuWk1rbExSYTFWN201azN5ekRr?=
 =?utf-8?B?eDZBK0JvK1IrRkF6am5BbnBLNjlCU0w5VHFyV1ZaSDYwanhOQ0pQZ1hFWVZm?=
 =?utf-8?B?TEhNTmhLVFMybmtDQjBPd001V3BIZnRCY0FibkhzRTVILzgwclk4Y3RFT2oy?=
 =?utf-8?B?a0lyUVl2enhhYnZBeG1kM255aHFHMURuYXJNb2R3ZmlVUHU1OC9INW5uYnJ5?=
 =?utf-8?B?OVVmQi95elVKY2RkOU9iUEY2dmlBTW41dDU4NjBZd1ZiQlZHUEoxVG5pMjJY?=
 =?utf-8?B?TTlSSTVZekVkL3J4SHlyVDdzWWhYdU1yQkcwcGZRVmJNT2NhcUovS05XK05U?=
 =?utf-8?B?Y1ozRGUvK0hDVHNZanJOckJ1Q05CTTJWSStBbEFKQXh6UXVOU3VMY01IUjMr?=
 =?utf-8?B?TmdhOXlEc3NzZVhSTVUxKzhZOTlCYlNFWmZ2RjNaVm9Id0JXa1A1UmppNndv?=
 =?utf-8?Q?wjsYGT/vYO51xATY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d736876b-35cb-4444-0ecc-08def381d492
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:13:27.8672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 366h8m93fUE/9GRWu9yWWjpcBDuF9lqxU7CGgokmLQUZ/L0BwKs4slnysZDT1g75JRiofI7Fe5aAj94/5rogwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
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


On 06-08-2026 10:38, Stephen Hemminger wrote:
> rte_eth_ctrl.h is deprecated and its contents are not used here.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>


> ---
>   drivers/net/dpaa/dpaa_ptp.c   | 1 -
>   drivers/net/dpaa2/dpaa2_ptp.c | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
> index e9b332c571..f91d3f9ce3 100644
> --- a/drivers/net/dpaa/dpaa_ptp.c
> +++ b/drivers/net/dpaa/dpaa_ptp.c
> @@ -9,7 +9,6 @@
>   
>   #include <rte_ethdev.h>
>   #include <rte_log.h>
> -#include <rte_eth_ctrl.h>
>   #include <rte_malloc.h>
>   #include <rte_time.h>
>   
> diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
> index 751e558c73..77d5d82b44 100644
> --- a/drivers/net/dpaa2/dpaa2_ptp.c
> +++ b/drivers/net/dpaa2/dpaa2_ptp.c
> @@ -12,7 +12,6 @@
>   
>   #include <ethdev_driver.h>
>   #include <rte_log.h>
> -#include <rte_eth_ctrl.h>
>   #include <rte_malloc.h>
>   #include <rte_time.h>
>   
