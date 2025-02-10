Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD08C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59E19410DD;
	Mon, 10 Feb 2025 11:40:14 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
 by mails.dpdk.org (Postfix) with ESMTP id C84D240268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:40:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJJhde9mSWxozleIZN4d4/AkAb9efBVJy3wJyPa0qqdSYC8mBBtCL/cbSLk1wzn0abdoojoQERg/uxfcPNst06otHNk4OYbpycG8SRSlQx7eQGyNFE284DVMHcuJI84otYEtGRjYn3uQPGUBWz8BnVuVq+s7MX+OHAKmlMivySAZejfb36gQx6r/Ib4HFQSfL+vidvkyycYsQNDeykVSmJX5ebS0PV/+JpXJT8leUOG6rrQ4dvUkPgDDVH+uHsU+tUKs9QLqYONfXjgw1Ikjv1QQbixu8IdDK86gDjqyZYqfv12Nfm6H+xKHL5T2HjzZF/vrmsE1Dfb3Q3fTtMLHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KIP8lIPEHJTsIbZlkmwzyujggRQ3TzUnJENsoD6+Us=;
 b=P14YyHqB1jt8tVl7XpQoOkKqJCa282rCXKIOlOTu6PyCKLGJM+60TsYO+nFlEmiDhT61KNz0xit7NJcqukNvKId2Nlw+CRw30uh93IPoF+ZRBeovb65EhjIEOki75tviKw92adRyIXCOnwaqEEYCZgxcgPPM2R8yknEhPHRJ4rt5p9f1u1iV3wlBUHMzHAPzsEeugvO7A9+8SA5AMlD18rGbYTBBvRYP36m9/EM4XaSpxssrHiJ6UZFVgS08INQdRqKnrPQAG9G6X1A6PccvNLdfhh1uS6OBDoT+LpTBBJYi+UEfu+dQ510Ibp29oKdsoZD1/SV8CQYpE+IkvLWaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KIP8lIPEHJTsIbZlkmwzyujggRQ3TzUnJENsoD6+Us=;
 b=itLSsH9giyt1kfTrrAQPb1jwoXJaN480n4O3K452Zwqwu2T7Vaek0c0UI3WvdFEWtHuTgs6QK8+m5KWo8lf8ebw9lgR7Oh++aSPiIf4sJ7MMUJq4Iq/uBqt10pWIEos2b3vB9iliNCCrdIes6PEgx78uaYvrhMPgNMbOqLemgAFuLukHWfpaVd0aFxg4eXVAIToIiGQGnaBuaEwB8x3kFvIDKXyii/umgW6eaJ/S9qe4srHlKgIBczI5b6D6YIkeLFm8UK4kfAeQsasiatNwgAdiRHi3vqb2B/OmWR7dbbmTwStLxuBHlj4Fo3oh16gV0uNhS3xC8RPvadly6TQwrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 10:40:11 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:40:11 +0000
Message-ID: <a28bee31-d753-9203-f84d-00c272cf346e@oss.nxp.com>
Date: Mon, 10 Feb 2025 16:10:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 25/32] net/dpaa2: replace memcpy with structure assignment
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-26-stephen@networkplumber.org>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250208203142.242284-26-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab93992-741e-49e5-5208-08dd49bf4ba0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG1ycUIrZk9zOXM1K3BVL3ZrMDB1cklQbzVtSkJQS1B4NlNRVHlGdEhUQi93?=
 =?utf-8?B?VTUyV0hoQ04xS3Q5THpXU3ZFR0tlSHpGeC9WNkFIekczeGNmOUNtTStlOU41?=
 =?utf-8?B?MlFkeDMwTUI2RUFuWGhYU0k0WmFQRm5rVXFNRSs5dWtHTzVQVmJzTC9nTUtm?=
 =?utf-8?B?eTJlc2RkM1BIMHFDbE1Ubk1UcmNvQzZia1RhR1k1QWx3dkRIMFVZMWlsUjkw?=
 =?utf-8?B?NkNCeFRtY0JxaHFLeXA3LzJ2MWNDbjZQejlQS1ZVYWdiR2ZYaEpmbGVjV0Zk?=
 =?utf-8?B?M25BUE9IWVBnSGorVG5ucjJjTmpsT2FFaTZNQm9rWU52amt6WDZBSWNkWTlO?=
 =?utf-8?B?U0dmMzF6N3V6U1pUejhqanY0dU5BQ2xiWDRGNC80cTJEaDUwemFNNU5yK2Nv?=
 =?utf-8?B?ZkVpTGE4dlZUWmt0SXJwTS9yenNWWXEwVHVNQUZwekxtejA4Sm10ZStwcStS?=
 =?utf-8?B?cTBxZ0RsSmRkdmpxOVdtVWo3eEoybWNwc3dmbEpwZUwvZ2RUSlBMMWZ2dzlO?=
 =?utf-8?B?MjU4dEwzUlh5OE44MEJvQkJoeE12TWxsOHhxdkF6ZCtTZmMyMS9qZnZrT1RN?=
 =?utf-8?B?RDRQZ25FdjJFODBpNTgwVWdBczVyWXlNbTBDMzVVelV6QitCUk85QW9sOVZU?=
 =?utf-8?B?WUFQNkdOdmpqdEZ5R1RzWlQ1QUtZblBPWnU4cFpuZURNWFpkZzZYcENFTWhl?=
 =?utf-8?B?TVhPNFFlcWJ0QnJpdERQRkZxenhPRGZ6TnRCclVvbmwycm9STFhIR0p2eGFG?=
 =?utf-8?B?b1NmQUF4WG9ieTlYaWRERXRzWkJpblF5dHNBcXhvckRVMnZvNXpnL3hOVlRE?=
 =?utf-8?B?M2h5Tzd0SFhQYWpDTkZYeHNQbGhYdFZ5dE9MNW5hMHdVWVcyRnhxQkUycnlt?=
 =?utf-8?B?aUlPTlQ5RnlEcXR5MWN4OFlpSG9Zc3RTRjQrUnNMSk9GRkJWSnV1QzBsUkp4?=
 =?utf-8?B?aW12b05weXNXR0hyMnFMMVlSQzZLbndKeDl3NERhZWg5cnVDa3F0bCtwSEZI?=
 =?utf-8?B?Z2R0ekxkM1BoWjRMQmRmcFI1R3YyVDZuL1F2OUhNUVJHRW9hNDVWQ3RxUWtr?=
 =?utf-8?B?aWJxcVY4c1FzdEMrRFA4ZlI3RFNwYW1UeUc0ZUhsbEthMDJKdFhmakc4b2hR?=
 =?utf-8?B?bmErK0VQbkZiV29oZmhPZThma2dCakhMd2VVUVg2WmYzb0lxc29rcWswR1p6?=
 =?utf-8?B?bEo5YVllZi9Dd09WZzR6VVZvTWRHWkFGMStvMUpKMDMybkg5bkdGbUNxcXhH?=
 =?utf-8?B?ZjNKY1hQZ2FTaFJGL0EzcWtVWGltaGU2NXpzZm9ZK3F5YlU1aDhuOHU0RVpp?=
 =?utf-8?B?ampmYmQ2QnpqRGVDVmI2WnFRci91YURRTENtLzV3OUs0VDZYemw5dWtLYnJL?=
 =?utf-8?B?RDBQRjhmcldMdW1wTXY1R2NlVGVkTVhBN1BnUWZEejF6U1ZkYVZzdStyUFVz?=
 =?utf-8?B?WXI0aVBuMHBqTm5oaFA3NVhBbUE1T3BKTlRNTHJKU0hvcmloMXZNZXZUQVBN?=
 =?utf-8?B?czJqU0pkb0wyMzF4RWdBa3RRTVR5Z3ZiQUJVUnoxb3RDWHMwSWhxUGlTK1RZ?=
 =?utf-8?B?MHBnaWFCbjc1QVhESUVFYWl5MS8xNTdRTTFQRWpXcGp1cXRqdlYrbWJwWXFW?=
 =?utf-8?B?VkhKVGp5M2dnRUttYVdEZ3RML0llNGo2R01tYVpWTXIvZFVIM2kvaEhxUGlq?=
 =?utf-8?B?dEt5bkdmcTMvTnh4M0FXaGRKRUdxTkFGMmQza1BkdzYvRVc1NzNreEt0V28r?=
 =?utf-8?B?V3FBbHJrR3JBbmdackhXS3pOOWFUNjY5MzMxNjNzMmsxRXVDUHd6U3Q1UWhr?=
 =?utf-8?B?MVNjY0ZZZUpzaHRlZFpLK09iZ1A2M3ZzTjBsekNaWDdCdHY4UlJzNHZJeFht?=
 =?utf-8?Q?t+ow88CH48kKB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVdSbG9RYnQ2YlNCRzFXS1NWQnVGc01nZzR3UlE0eC9rVVg3MGZEMWNLQnNM?=
 =?utf-8?B?cFlnODRNNVF0ckNUUEs2aEhRWndrNFdnTUxZUkNKRXdBL2VTQUVhc3FNckxJ?=
 =?utf-8?B?emJDQzkwZVdSaHNwNnBvRzVOa1oyVk9vWmZpUVhmZWR6UFM1aDBtang4OTlZ?=
 =?utf-8?B?YU9Ba0wyVDE3SVhDOGsvOUgzSEV1N204ZjJ0bTBva205R2hOVC85YkozeUZS?=
 =?utf-8?B?aGVGQi9UZk9DMGVVbDRvdGlXd2w5NElyQUI1bTU2U0dpYS9jSnBuTE9oT3pW?=
 =?utf-8?B?SkUrM1ovdlZoQnFhK2VDdm55aTUrU0piamw3S3hOdDlyKzkxc2hDVFFxcits?=
 =?utf-8?B?N0l3OFdXUjJ1amY0bDYrNUhwK3E5dDdYNTlYbDV0bzk0SGhyVytKeGdvVXdm?=
 =?utf-8?B?V3hQczJFWjd5SmQ2M0JrZldlL2JxWU9Lb0dYZ0c0RE5CMlMyUFIvWU83L09F?=
 =?utf-8?B?U05tL2Vlc2IxN2orVnFxcDF5ZTMvY25CU2NKa2Q0SWU1UTg3WGRQU3orTEZX?=
 =?utf-8?B?SzVMV0JmRjg5ZHhzU1JPS1FIWW93QWtJQVdCYjRZVHB3TUUzWlpVQ3NpOUht?=
 =?utf-8?B?dHFhNndrR3FOM3p4TkhDSUtZMlRNemFOQVFzMGNYOUNjRjV1Vk9NUjFLVGs4?=
 =?utf-8?B?b3B3T2gwREt5TER4UUV2Vkg1MHlicW0yU3ZvaFR4TG5aeHVSUVJYRWJmdG1s?=
 =?utf-8?B?T3E2TmhDeTA2RnBBendwbFAxeFRQVlJaZ1JlOWRSeUd1NkJuRTJVSEdUUVgx?=
 =?utf-8?B?cjZKVCtxOEFROG5yb1ozY0Q2UktzRXdJRDN5ODRTVkhOQ0s2MHVRT1V6VXB5?=
 =?utf-8?B?cDIyRjdsU2NtakhLRWNpYUtWejZHUGZTTkNaelVIcjBpUzA4RVY4aWV2eGxE?=
 =?utf-8?B?QTFzTVFhRlFCdzZER0dtRWNOMDU2akdXMXVBbGVaYjBKQ1pYYXdNU2N2YjJT?=
 =?utf-8?B?Y0E5UFJXSFl4UlpWUWRvczVhQVQxaGttWEJWYUZENmJheThEYjlmSmgybCtT?=
 =?utf-8?B?Z3V1K1lSQzlvSXI1OW5PaXYwdHdWWEw2Q0RHNEdiaVY4UUxkakZDYTk3M0ts?=
 =?utf-8?B?cDlxdXMraE5qS1lTYzdHM3VlQXpidThNQW93R1ZGZDYzdFlpTHBJMTBlTlYw?=
 =?utf-8?B?Umx3NGlZbGQwRG4rdldjQXptT3BqamhDRE5YMUdkcGFWTjJZa2xKb3Ryd3I5?=
 =?utf-8?B?NERGVFRJMm1INzdIM25OcXlzekdLWXdiYVE1MlFRRzE5ZVFPSFQ2WS9QSjJY?=
 =?utf-8?B?M1dFOXA2ME9Nd2NhdWRUYnRWS3NUSncwc3BuR2F2SEoybGJtRFc0R1Z5eXF0?=
 =?utf-8?B?d1k5b1pTYTYwUFlDV0ZuUFRLNFA5eTZXSEdSVUNvdHpwUmpTemtxS3A2VzU1?=
 =?utf-8?B?c05CZ28xRVdoUDBLUDF1dm5EZHJTSXdRWERad2Y4SEYxQXdzNktzNWlTSGpx?=
 =?utf-8?B?Sm03dzBDNW9yajlDM2ZuNmcxa0FIdmdVSURReUtYOExXN1l1Vnk5Tko4c0c1?=
 =?utf-8?B?c2tjcVBZelZsR0VTNjRMLzNyYUdXWDAvRkJqL1lrK1NSdE5PczBIWmNTOVN0?=
 =?utf-8?B?RG1wMG5wTVB1djlaRmJUQzBBaGgzQTBITWVGaVhtRVk2OXh3M2hoazJTRFZF?=
 =?utf-8?B?TFZud3YzL0pPM1FoVUdET09ZdDdqZ1IwQ29iSlBjTjZTWGxhTUQ0ZVc4VTIr?=
 =?utf-8?B?ZnZoN21hL2E2U0p6ZUpsdUtWVmlzN09RQ2pSOUwxRTZGakJnRmI2c2k4WWgw?=
 =?utf-8?B?RllZb2pXL3kyMXVUV2pJTCtxbEt4cGVRRDR6ZytiMGt4cDdVWlVtRmVRU2Fo?=
 =?utf-8?B?RGNQNUdaUEl0Mi9XT05zNHRKZDd5WGt1NlB5N1NQSVBWeFQ5dmRtb2Fmdlhq?=
 =?utf-8?B?WWo5WUt4L2NMZDZCempXSGZxbHVVT1hLQW1DeVNqN0xhN1JaWUxPeHN0K3dE?=
 =?utf-8?B?SFU5Z25PejR1QnNlTzlDR09KQitqby81UFRJSHhnaVNzZjFEUXp5NXJsai92?=
 =?utf-8?B?cTM2ZTBRaEZ2aTZHaXVabzFXV3Y3S0k0dGJWaWFzUEJpbUdrRVdwb2U3MmQz?=
 =?utf-8?B?TFpnWWh2cU9wZHV4SG1Sa2RyVkJmb1A5eFd3dDl1bDB6RVRjRmtSNFpyME5L?=
 =?utf-8?B?bDdxUGZoeWNmMlF0U205QXBLd3NoQS9HNnl1ZENsenZTNU9QbXVCU1RVSkow?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab93992-741e-49e5-5208-08dd49bf4ba0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:40:11.5601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+ex8CUbkexutHYe+ZNsatJDYXRG6Z+/UQa+r2k+vFZMGEjyEMpiFPaeVoR07ZW6ZVFLlgtrsMPqp/rwef1/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

On 09-02-2025 01:52, Stephen Hemminger wrote:
> Prefer structure assignment over memcpy.
> Found by struct-assign.cocci.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 5 ++---
>   drivers/net/dpaa2/dpaa2_flow.c   | 9 +++------
>   2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index a9bce854c3..452d58ae28 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -2539,8 +2539,7 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
>   					      ret);
>   				goto cleanup;
>   			}
> -			memcpy(&prime_mac, &phy_mac,
> -				sizeof(struct rte_ether_addr));
> +			prime_mac = phy_mac;
>   		}
>   	} else if (rte_is_zero_ether_addr(&prime_mac)) {
>   		/* In case phys and prime, both are zero, create random MAC */
> @@ -2555,7 +2554,7 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
>   	}
>   
>   	/* prime_mac the final MAC address */
> -	memcpy(mac_entry, &prime_mac, sizeof(struct rte_ether_addr));
> +	*mac_entry = prime_mac;
>   	return 0;
>   
>   cleanup:
> diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
> index c94eb51ba5..299c50dcdf 100644
> --- a/drivers/net/dpaa2/dpaa2_flow.c
> +++ b/drivers/net/dpaa2/dpaa2_flow.c
> @@ -1008,8 +1008,7 @@ dpaa2_flow_faf_add_hdr(int faf_byte,
>   	if (pos != dpkg->num_extracts) {
>   		/* Not the last pos, must have IP address extract.*/
>   		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
> -			memcpy(&extracts[i + 1],
> -				&extracts[i], sizeof(struct dpkg_extract));
> +			extracts[i + 1] = extracts[i];
>   		}
>   	}
>   
> @@ -1063,8 +1062,7 @@ dpaa2_flow_pr_add_hdr(uint32_t pr_offset,
>   	if (pos != dpkg->num_extracts) {
>   		/* Not the last pos, must have IP address extract.*/
>   		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
> -			memcpy(&extracts[i + 1],
> -				&extracts[i], sizeof(struct dpkg_extract));
> +			extracts[i + 1] = extracts[i];
>   		}
>   	}
>   
> @@ -1118,8 +1116,7 @@ dpaa2_flow_extract_add_hdr(enum net_prot prot,
>   	if (pos != dpkg->num_extracts) {
>   		/* Not the last pos, must have IP address extract.*/
>   		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
> -			memcpy(&extracts[i + 1],
> -				&extracts[i], sizeof(struct dpkg_extract));
> +			extracts[i + 1] = extracts[i];
>   		}
>   	}
>   
