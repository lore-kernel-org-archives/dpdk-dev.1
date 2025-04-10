Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9373BC369A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 07:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F124066A;
	Thu, 10 Apr 2025 09:54:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
 by mails.dpdk.org (Postfix) with ESMTP id 54C0A402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 09:54:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osTFMOQE3WNhLJtfLtRyDfKpa0daU/W8G2gE17GIYsSKf9WyNI1RQB+LGq9HidJGmZCC8Ouf6s2ffYJmoK8TtBcJsB0kJ88TjHadyIw2Wg8LjV0xEbO02k62DKN2FbO5aJFu+1wsXCT5tp25siy5gFhAmthep+eqE/k2H0vCxcaSk8nR03rVo369li6Jgqg8Vh0zjIvQ/Onb0D6vD7Y+Kalef+8pFQglrkoZJwCZ4p5DC0UrBQoC5jONQWhdCHFBrqdkjLCdxlPdhjm3iD/VK/C1zPCoSs9g5Od8W3xEyL/wpGRckCRpXT9Vu44Pp5NJdOXf4hAULE54dC2uEKPzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55q1qBaVgNkDCoLMC60v3mJ4+KrmqDsgdlUUZznDBvY=;
 b=BJXct1h04o/m8LoTF3nGgjGgurtU7m/zYbo3RVEE95Sx7kdcv5gdtaBydf4QzbvMWfGvetf3KEN8g7x4kfQZCCIU+d8S0Vgjk+GIViirqs49i/lc3Vtq3SSJTUhb5+oHaifb0tduaVSCI49VUeTpJVCRPg6uGxnd3O7rw9lAwF+Eb48kWLHjLpGuPUNLGljjqfEEe453+COUndlcncls2Nvo6dOSDWThwrROD4IPMiJMBEQnZ6llJHhGnooLmVe4KLXhsb+/FHloQfwf1mehPakUBUJdBjfDUzV2HM2HBh46fprbaGL8xBnZTsZHbPRcLfRbhspnVLf3TYq3QdgqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55q1qBaVgNkDCoLMC60v3mJ4+KrmqDsgdlUUZznDBvY=;
 b=E098KYBjQ5qUTf00DDyNOeb6LrY1gAJ7Vn37+T8aRF5PfqXUuErKIwW5jgxy2gkuonw/Z3FUMT/1Ya7LXNRzHUWOCpSBF/pt2Upkaz8cPexa7hiOJaMi05YohDG7gvo/j49GnV4akZn3yWFRUZD1QuXgT7940TojFRhyM9e6v34umd6xqw6YW9WbIYDVde5ULhh9qAFXBai8q/fGAAtRcxetqoZQpv5LHGYgdCJ+7Od7cRLBdRfXGv7oaysCc6XttEuuacWGq01+S54A5xiukncNTy/zJMmBjcALCEw8vNTqCRuHkW6ud6JYmWg+mmOq+c0HbtumAYfXLdcT2Vdx8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by PAXPR07MB8339.eurprd07.prod.outlook.com (2603:10a6:102:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 07:54:06 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%3]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 07:54:06 +0000
Message-ID: <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
Date: Thu, 10 Apr 2025 15:53:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/mlx5: enhance log file path
To: dev@dpdk.org
Cc: bingz@nvidia.com, dsosnowski@nvidia.com, stephen@networkplumber.org,
 julien.meunier@nokia.com
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|PAXPR07MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a2ac0a-9594-4489-ab62-08dd7804de04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXhjZDc5dlBtYndsSXB0ZEdReVZUUmU1YUlrOVc4a01nejIzS053SnJ0T05W?=
 =?utf-8?B?TjFKNy9vblN2Y0ZBejNrYVVBNlNJeXE1V0g4WnBTdkN0OGV4RzU3cE9Wd2x5?=
 =?utf-8?B?ZmtNUmZOc0tzd09iaG1lS01iNEwvV0pDcDQwMFBVZjh2elhCMzNjRE51Y2FZ?=
 =?utf-8?B?M05hZ0FnREhrSmR5ZHBNMUJ6Vmxmbmh2WGk0L1ZvOU84L3ZlQzdGRVhBbURK?=
 =?utf-8?B?UnNxTkhRQjg0L0labzc5WEk3VWp5LzFZMU9UYTRyOFRyTFFWWXNDQVJ2REpx?=
 =?utf-8?B?Tyt5RTFmdnBRZWlBTU9IbHRVNDFzbUpaSXpxRjBsTUZQRmZTelZPTForeVpv?=
 =?utf-8?B?QzZRdEdCckUwOEhFRVF2UXJibUZMSS9lc2l5OFFrdWp5WXJRQnE3L0Q1MnJ3?=
 =?utf-8?B?RXJGNE9LTjI5MzRid3RkREZ0QUs3U2RiU2ZPb1Z0VU9kdzFOUjAyc1BaRzhu?=
 =?utf-8?B?cElydDNrT1pBTTViQlFuYWlPUTYrR2FtU0VwQUVwT1pFeUpBQ2pSQVc4WkM5?=
 =?utf-8?B?YlVOeTByYjZ2S1VXR095di9TNTltRHRsTytCR2toQUhYbzd4d2hjTGphTWZl?=
 =?utf-8?B?b1NIMEpNUW56ZEErUTVUbUh4WkhQWm5pUVVzWWd4SW1yYkwzODhZRlNDRHh3?=
 =?utf-8?B?RnB0clRORFR0d0prTnhaSmIxSW1ueWc4UWRhSVYzTnd1UlMwQUtUZFhVend5?=
 =?utf-8?B?bWc2RERmQ00yRWVMMXlkVDI5MU9oS2kwWmJxcUl2aDdDaUNwUWI5Q1Zmamlo?=
 =?utf-8?B?UkMrUHBGQjBOWG9VbDNReXp0MEc4dHNpRDd0bEx5TVlYeHFCeEdqUUVrTkhi?=
 =?utf-8?B?V0d3RFVVc1Y4VWtCWmM2SzNQVVhnU3Y2NDQveDBGR2NGaUo3TjhpeG1WODZl?=
 =?utf-8?B?dHF6SHNVRWI3QzFlZzF5REJ4ZWhXU0RQcXhUVVZaM0xrbzBKVkkrSXhNZWlC?=
 =?utf-8?B?MzZJTFRlVXNkOXFONnZ4a0RJSWlnMkhveWV0NmdNMXlaWDhrZktxb0FnQ0RR?=
 =?utf-8?B?WEhtWjZlZjAxZkZaVTdSS3BxRGhFdTVTTmJxZkNoM3N5VHJuMmpZT01RNjBa?=
 =?utf-8?B?MGRSYXppc2xCQ3JtdjUxWmRmK1NWQ2xOcGx3VDNOOFZYSTB5KzBSMWlyMS9s?=
 =?utf-8?B?UmV1STVQdzR0MFNFNEV0KzVhTlhzVU1ORUp6Z0IvUVViS2tZOG9uZ09qNmp5?=
 =?utf-8?B?MFpYeVZ6MGdZQmxxRzNlTW0rdVgxMTlZdmUvcTk0SDRUUHFuQkhWU3B1N25s?=
 =?utf-8?B?K0ZBUzRBR2ZsNVJwQktldUk4enhhZjQ5NmJqZW9mYzFxVkdndGNxTGtOS0ZS?=
 =?utf-8?B?dURVeXFRc0l2eTlJcUNoVkJ2UW5NbldEZkFoV0wyRGg1bGk5bXp4Tk1ZdkhQ?=
 =?utf-8?B?TU1EYVczcGdsUDFVSDdmNkJFSjVvbHBRNzVHdmJaellPVkcwNU5DaUpPVnF4?=
 =?utf-8?B?MEl1R1NFcGZGQWVxSm5nVlNmNExyeGNsTWtTZHgyaDJMWEdzKy9FYVpGMURl?=
 =?utf-8?B?SzJLWDlSSkNyYWVBdWpaM3JpRGRzaGVFMjd4eisxdE51LzlaZGxDdkF3T0py?=
 =?utf-8?B?a09HZlE2L2NrWlFHVGZ1ZlUrZXN1SDhKMmd5VVZ3MUUwMVJLWHJYekE0SzMv?=
 =?utf-8?B?RUZMTGgxQm1pWnNqV1pDRWExMWdQYkpnai85Q3d2MHp2MVBZcWhKSHFlSERp?=
 =?utf-8?B?dG93V21yWlNvcHRHQ1dGK3k5RnFMY284R2I3RXNzenJxU09jeDJKMjYyWDVQ?=
 =?utf-8?B?TURRVFhXd0JkVVhZZkNpbFhRQ2x5RjRTZUR2WUNFZTl0K00rUVFOMTJ2RVhP?=
 =?utf-8?B?a2lPVGtqcVdnNjF5bllmV0FmdnFuT05xVVlsMVRhMUZ3MEZ3Y3dWWWRSSmsw?=
 =?utf-8?B?QlVNeXd6NTRLb3R6T2NSaE9Uam5maUlyK1V3OUhWMVJHd0dOZWczZmVka0pP?=
 =?utf-8?Q?XIQlp2YIlqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZ4Q0V5TER1OHVQRDJHY0Y3QXp2dmdXY1FvR1NQNTBrV01uWU5DS0RsNkxz?=
 =?utf-8?B?WUJxbG5pb3YxTmV0L2I1MGcrd0g0QjBVb0VBMUxUcCsrL0dxYTRwaXdpNWxP?=
 =?utf-8?B?N1RoTjhyQk9oTmhIWlphM3c5M095b1Y3azZmL3NrU0JtckJ6YnpHOFhCSHZx?=
 =?utf-8?B?Rm1yRUZPL0l1QjM1WEdkcVdOcFNvUng2YnU5SkxPQlF1bUhXN0FoTTlVVzJn?=
 =?utf-8?B?OS8vOTVrVkg3bTNhTkQrUDg1YTZudnBISDhPNEhJYjM3SXlyaDhQOUFacTcz?=
 =?utf-8?B?L2g2YVh0Y3pZQnZEc2lRTjhQbGZQTFZJbHJRTmJjSVlnS3N3RnpBN0paa0NL?=
 =?utf-8?B?NW9icDRscnNKeW5IWSsvK1A3VzUvellWTGgva3QvUFBMMnBFTVZyWHE4YUdV?=
 =?utf-8?B?ejdUSXB5MXhGRXlCSWdWeTlkR255M1lnSnRkMnJTaDBOd05EWmxEdk5yVFBy?=
 =?utf-8?B?QWdRYkJFdmt1WjBxWVNRb3N1WDU0aU5jRFlIOXNXSjNZYkpJMW1FTHhkTWw0?=
 =?utf-8?B?dmptaExFNGMvRXhmVFVkbEg5aTNWSFhqSGllcW5BMkV2MVdMdGduNFdDM01V?=
 =?utf-8?B?U2ZYdDlSRXZWZEFISGhmWWtpWHROcnlJbWxZc0RrUEV3SVVzUkZBdmJjU0hn?=
 =?utf-8?B?aDZQWjA3cWVyZjVJUTZ4UnI0bEhtZ0M5ZWRadmZvZzFNVU9nbkhHTWRoNk1F?=
 =?utf-8?B?cmVCZjBUZDRzTGo0NTFZemdDTytpWE4zdEpmMkVSU0VXVWp1dkttNS9scWly?=
 =?utf-8?B?Rm1lcndXOU5ubEQzdFNjNUhSWXlqMllhSCsyL0NIK3pMWlcrdDFHMFpWWThW?=
 =?utf-8?B?VFlNblgwTlhBT0xhNFRJSDNUZlNCS2tJb1d4Q3B6dGNITnhYemFUM0Q1Z3Rn?=
 =?utf-8?B?d0ltcEVLYXdGSWExdXNLYUp4NFZtK2l0T1ZrNnc1WmhIWUVuS0tTUWhFYVR0?=
 =?utf-8?B?Z1Y2Vmcydmx5ekVmdXFCOC9RWjRNK0JpdGMyandsMEVBWDlkajc2WjBPZjVD?=
 =?utf-8?B?TFEzRDVyTDRwV0xySjBnTHg5SlU1YUMvWGJGMjJkby9KSTIzT3BWd1U3MVBI?=
 =?utf-8?B?dWQ5UTBJZmUyU0JMdlVQaUJzN3NsQVJyTUplcE1BUkFtUE9FYUx0TytaQ0ds?=
 =?utf-8?B?UFpmRnJORzB2Q0YxemIrYVV4N3I1QjJpSzNoVUppNGRhYndLK2xoRDhDd1JZ?=
 =?utf-8?B?NVpzTVM4T0hsanVVNlBtUXdFS0Y4MEEvT2E5OC9PaWFwNi96NlBzcGIvTWdO?=
 =?utf-8?B?d1pEd1NvZkUwRk1PTDl0Q2o0NXg5aXFXY3ZQMFpZd0hXekUwcEYwVGtWeENv?=
 =?utf-8?B?N205N1hlMkh3ZklPUTJZeWZpQ0dYRzJ0UVR2RC94R3NiVUR3Ym1DQWE5T0Y2?=
 =?utf-8?B?bHBzVHNzbjhKbVlnRFUvb2pmNVlTMmJsTzB2R3g2WTVKTDZGcDVETGZuUnk2?=
 =?utf-8?B?Zms2STI0Ykpwb3RvREs5dVJNNnlaV2FZdEt3U3ZYME9lL3RGZWJHa0I2dWs4?=
 =?utf-8?B?alVvS1AwQjljVVM0RGh5NGJOeittdS8wZVJVVWIrTmpEWlpRdzJKWE50TjZz?=
 =?utf-8?B?d3haVmZWK2RLV3FabE9qQ1U0Y3pKeG93QVpDNDh6eXMvUmVrY3Bka05qeGNh?=
 =?utf-8?B?TXZrUzNoNTNxbkRoaEhUZW1WUTJqZmpmSnRjK0t6bTcydHowdjUrWkFvWm9K?=
 =?utf-8?B?SnY4Y3YrVGpDc1MyaWF0SlNtbHYwWVA2dGtnbjVQZzMzdGdjZEk2eEZpdGNH?=
 =?utf-8?B?TGY3NEpOTVlGdTJiSHFMd3Ewbk16aDIzOC9UR013azZ2WVFuWDhRQ0lHVFBu?=
 =?utf-8?B?ODY5QnF1VDRwaXBLUE1FMGQzd2lzV1Z5Q0ZEWEtFdUpGODdyLzg2YkhxUWFI?=
 =?utf-8?B?YXNsYkNCRlpiZHdMWmxzNmtqOWVad3FZb1FlVER2cmpvMVRFSEJ6UzdXNkdm?=
 =?utf-8?B?R2NibnBnVTlFUGNOcXRMTEVUM3V3TVNZeW1XSjhwQUt2TnJ5U2lsNXJDR2Za?=
 =?utf-8?B?enhFTWNvREZLSjh4OFAzU3FpUmNPcVJ1SUlyczE2Zyt0V1VuOWlmTjdLTklO?=
 =?utf-8?B?ZkYyQ21Wcnd5LzRjblhoZmJxRkJhU0gzd2Z2MlcxUUlDOFUzOGFTVFlpNENj?=
 =?utf-8?B?czJDSzNiejNhNU9YYzRJT0dTd09TTXh3NkQrbE1KMlFHUmFYa0tJUUYrSUVz?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a2ac0a-9594-4489-ab62-08dd7804de04
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:54:05.8549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu/JCCQVRwLaJJ9qIDirNs/kw7Iz7qL2SC7sDdDe/hcuiU+nvFdwYSx3NGv14dSHeEPA0nReD7qnHQsgY9Kupb99LR45eUu0EGm0WURxjPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8339
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


On 2025/3/21 21:27, Yang Ming wrote:
> The directory /var/log may not be writable in a container's
> read-only mode. To address this issue, use the DPDK runtime
> directory as an alternative when /var/log is not writable.
>
> Cc: bingz@nvidia.com
> Cc: dsosnowski@nvidia.com
> Cc: stephen@networkplumber.org
> Cc: julien.meunier@nokia.com
>
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> ---
>   drivers/net/mlx5/mlx5_rxtx.c | 33 ++++++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
> index 9c075f6a56..9e63d38524 100644
> --- a/drivers/net/mlx5/mlx5_rxtx.c
> +++ b/drivers/net/mlx5/mlx5_rxtx.c
> @@ -6,12 +6,14 @@
>   #include <stdint.h>
>   #include <string.h>
>   #include <stdlib.h>
> +#include <unistd.h>
>   
>   #include <rte_mbuf.h>
>   #include <rte_mempool.h>
>   #include <rte_prefetch.h>
>   #include <rte_common.h>
>   #include <rte_branch_prediction.h>
> +#include <rte_eal.h>
>   #include <rte_ether.h>
>   #include <rte_cycles.h>
>   #include <rte_flow.h>
> @@ -411,20 +413,33 @@ mlx5_dump_debug_information(const char *fname, const char *hex_title,
>   {
>   	FILE *fd;
>   
> -	MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
> -	fd = fopen(path, "a+");
> -	if (!fd) {
> -		DRV_LOG(WARNING, "cannot open %s for debug dump", path);
> -		MKSTR(path2, "./%s", fname);
> +	if (access(MLX5_SYSTEM_LOG_DIR, W_OK) == 0) {
> +		MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
> +		fd = fopen(path, "a+");
> +		if (!fd)
> +			DRV_LOG(WARNING, "cannot open %s for debug dump", path);
> +		else
> +			DRV_LOG(INFO, "New debug dump in file %s", path);
> +	} else {
> +		MKSTR(path2, "%s/%s", rte_eal_get_runtime_dir(), fname);
>   		fd = fopen(path2, "a+");
> +		if (!fd)
> +			DRV_LOG(WARNING, "cannot open %s for debug dump", path2);
> +		else
> +			DRV_LOG(INFO, "New debug dump in file %s", path2);
> +	}
> +
> +	if (!fd) {
> +		MKSTR(path3, "./%s", fname);
> +		fd = fopen(path3, "a+");
>   		if (!fd) {
> -			DRV_LOG(ERR, "cannot open %s for debug dump", path2);
> +			DRV_LOG(ERR, "cannot open %s for debug dump", path3);
>   			return;
> +		} else {
> +			DRV_LOG(INFO, "New debug dump in file %s", path3);
>   		}
> -		DRV_LOG(INFO, "New debug dump in file %s", path2);
> -	} else {
> -		DRV_LOG(INFO, "New debug dump in file %s", path);
>   	}
> +
>   	if (hex_title)
>   		rte_hexdump(fd, hex_title, buf, hex_len);
>   	else
Hi Experts,

is there any chance to review and accept this patch?

Brs,

Yang Ming

