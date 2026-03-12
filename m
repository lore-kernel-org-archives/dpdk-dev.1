Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D0FED2F9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 09:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4046040ED6;
	Thu, 12 Mar 2026 10:27:40 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
 by mails.dpdk.org (Postfix) with ESMTP id 6BFD4402E0;
 Thu, 12 Mar 2026 10:27:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf8F8vytMo8FYEbtNVdhAdliXqNj3q4ZTUY0TDy4xgn0UtuCrBDxubGTSHzJNZPj26WNIsmoKOPSsavkvWLTeqwB0kwMCkWsWnRftl+/VeaSCN234nC36J7m0DCyKvrYlPlc+hMEo5U7tBNa8nCF7bH1M1SIDS+u2+wi2inwZKGCP4dGzAVIuDjsszLpYhdm6QNQtjlKXcPuXWyu/uL6aafM6cNT4eTGyIY0V9pp6bWxS4GCz8jNl0CnnxS2UpdcImlxvWJ/Q+S1cysa3b/uCfoyfSjtu+5PjOH5whUZ2iJCuU0T/aKAR35jwZzOc60PWj5zTj/e/CUD4zT3qZkBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POBM6M7EPMuRyjcr3Mw+EvgsHev098nmUFrzfD5e9VE=;
 b=raVMgf5ru4sQ7TY4KEWKTNfmjIzcT8oh8fuX5qU7iJ2DORBc9hVd+1dzP+D7vICr4XkrZ3S1iyCYY9vjRse2IFjBUzGWJpGoiUH8fsEfCCEI83z5uWPErrhjSNoWHMz9NzpdpcQGZg5PqB/4yby1ejFLt2D4XyYpou+TvLYF4KIZWrU6j8GiQrZlqu+bDmfAVqHux6Or1vYpQbPoBCDFa0HusKcQwDszOpV9NPwg3jbGOkfyNw5KOnuVyZViaAAZSxkcKL7P8wyeoMnsxdylmsYZdy9iLvUfMVhd1CqUuXnT79aJ53qMc5ZmiewZon67fdlAiWlQrKGKCJ5Tjc2UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POBM6M7EPMuRyjcr3Mw+EvgsHev098nmUFrzfD5e9VE=;
 b=WfNvcgjIPkpfDHxzexggENyQ++DOYNf6f/EfrA+tpAZDyVglr2iw9KLmQlirXS/n3m+Hko9H6DEH/n9SZ0pQ5OP+BO3MKI4MDmXzBW0UXHsqfDbj8SZ44p0A7xhcvRTSrRE6f0izr3pz6GC5dPHfkjqn42oQMs5cpf73ITsZKZq/a/81OOVeRPfuVooIQ0LsEKtSzBlvCeUnqru/Qkvhc6Z3V+X9ieGohIrrU4+OBrySM72E7EtpyEAc6QMu8ROAqgJvI5bwqqf/m5JHLSmgf65B+5QrkeMej3fQ1FNYQ3It8tJ3Uk3g5HIactXxuawcOj/QWLVaHnx+nDnyVmXV/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM0PR04MB7091.eurprd04.prod.outlook.com
 (2603:10a6:208:197::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 09:27:31 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:27:33 +0000
Message-ID: <addc71bf-e63b-4d40-8bab-02c5b55eec0e@oss.nxp.com>
Date: Thu, 12 Mar 2026 14:57:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] net/dpaa2: warn on Rx descriptor limit in high
 perf mode
To: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, stable@dpdk.org
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-4-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260306133035.179709-4-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::8) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 912ee146-0ee0-4831-8aad-08de8019972b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: WaFIRk5SsOXadxbLGbJPp/DhOYvgMfxZ9XJZikacc67FqOz1noXf+nLwGy5rJ5ZsW0K7AnlTbEwOX8VmzAc2fIGh1RyGYKRJjw7hx+tSu9BS7ub4dsU9e8aILXieVhgtbegtzMJ3bmeqJYiKSUEgOm8atm6Fip5oFv2ByBSQzMtIOzXG0WM9Z87LA5YZouZKAmhiw5vuh0KXAZ3gEv+nXTxjuqgJiZl8r5mF3XN7cB1TObgHKZBo7v0hFmnnpNqTn3/B+WBuLwMYKXSIvlNw8dQg7S47N95F/Daj1qIvAvJhXl2EvZv/807rK637BfThscSOZFVtUAKDrnFqko91+1PmzQ1b9TWOUwNC/p6zdIQfl9QUk4YSYlg0fibdbQlBL3G9wcb4kG8hSwrBESqronwmso955d0bzeV98BVwhPJ9icWob94oPtW6kPTgxal6QEOPCCzfMXRS1rWCH5tB62JbNVj/NRLaGmpb+O5hIoSxZUusosoyVWqUYSAFZTwcjR9rU3MBVqeFbCpjaHSsCrsdXpSoh3SS+xQLV4YQM35rG8OBlbYDUM1JubRfgVRQMoBmWTr0xzKt4w5YhPJ+ug1DH9VvKhCMUa9lxtXSQxq/13hqgOvRd1SKR6TuE5q/m2OgIj/Un67fc2dTgXIxdx8uzv/2tAQlBzE5TQj5LhZGB7Qp/vw1AEOXSvTYEWgvPo5i5RAEesu/1Y6xojMBZUKaHBxmqTQIkfZpl8KiYV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWp5M2t3TFpPNGZCNFhkYTFuWnFoOFpLaGh4SDY4WXVFcFIzVjJ1YmI5UFVr?=
 =?utf-8?B?T3FaSDRlU0JheERPbHhCZFp6emVqV0pFeXd5ZEZLeWlxQjAxcTZ2OGt6blN2?=
 =?utf-8?B?dnB4Qkk3TTcwMERyNjJ1UTdiM285VHUyK3JSNlFGZ2JZdHQrUXlVTXhWeWls?=
 =?utf-8?B?QjUyUkpEWTVDK1B0VllNNnhTa0VWSjFqR3JaNFVDZjBNRnFONGxGQkkxODlC?=
 =?utf-8?B?Wjl3WDNiRE9BUWhFdGs5akpjcHdadFNJV3N0VG5rOG9UeDNiMFFtaUZtcVoz?=
 =?utf-8?B?UUhKWTFIRU4zWktEWTJQbStTcUtqcjdaZS9Dem9kc0Q1dmlLVXhCQS9zMzZh?=
 =?utf-8?B?aFFtS205T09GWHlWdWVxZmp2UUpOT1Fkc1RZdVRkVzQzSXZHM3hmcDBveFJz?=
 =?utf-8?B?MjBaVnBjY2oxRTVnWkFGcEpCU1E2dDNERmJPVnBRbnRsemFGUFRYKzVqQVV1?=
 =?utf-8?B?VmZ5Qlc5d3NoWHMzVGR1WjRvTEpnTzNpV1NPa21lcDA5a2NPWWpqS3dYeXNQ?=
 =?utf-8?B?VGl3YSt3L295RldJcy84N2NNdXBrVU0rVzJZdUxvZ3ZPYnFERUlybk5iTGdz?=
 =?utf-8?B?KzFRR1l0cktDTWlkY2s5TUR3MXZJNUlwODVnWHRkSExlYmlvZ2x6Q3FmRDBN?=
 =?utf-8?B?K3Z1WXNjSC9EMUlHL3plRncvTmFUL2RyNlBtZncxT1VMc1BYUmVIRjRBYTZF?=
 =?utf-8?B?QU5LbjVUTVdDWHRLSmhtMlpqZ0UxaFBXRWxOZHZ2VGhicnlnQzZzMmhnM2JC?=
 =?utf-8?B?Q2ZnOFVTMUg2UmxvNEtrOWg4cXBrN29IajhiVllTdVBTTDladlcvM0JEUGo2?=
 =?utf-8?B?RXZTTjViUk9Ma0NZOXBFdk9yeDE0TkVmSHE3N0RoNTRoYU8rSlB6cDg0a0RT?=
 =?utf-8?B?anRNS2k0bTlTb29BaGFkSWVBZjRTc2FuVHJRdElrTEZwbkJkN2lFVnB1NEYx?=
 =?utf-8?B?R3hyTThmNEFwS3NsT3JScXVoSFZ3alVDSnJqSnJJQmUrTXcxa1JuMVQrdDR5?=
 =?utf-8?B?RFB2d2kydEpkYXdETnBqR1BCL2VPdStKdlBQT3JSVzd3ZXRwNzhqV0dBbWVh?=
 =?utf-8?B?citzRkkwWHV2elROODFXNERYems5RzVGV1B2QndTM0hmQnR1Q3FzdktIYkRY?=
 =?utf-8?B?eWY1ZUJmUEN2Qno1MzJlajNiQzJGekV5cllIalk4RGtkeUN6Zml6TjhWTGt5?=
 =?utf-8?B?dWs0eFhtU1N5a2o4bDNlRG5iWnEvVFh1QXVYRVRvanBMM3RDeW5xTkkwcm9R?=
 =?utf-8?B?bzBIS2xPaWw0OWZnblp5eitBaTdMckNGZFBEWTF3cjkxRmFtS0Z3NG5BaWRE?=
 =?utf-8?B?UzhYcStPaU1VYjZnZDB3MmRsUHhaaGdoUmdGTHFqbVJLdmdsb0lKaWNxNHVl?=
 =?utf-8?B?a1I1UEhJdWJoS3JFV0V6cWVmcFplV1Z5Yk9DZ0ZmbUhqZHBDUUorQ0ZSdkxG?=
 =?utf-8?B?QVhYOGNSVXVpWGllcHJFdlZpQXB6aTZTWHREeS8vb0tRU2UvczU5L0Y4Vnh0?=
 =?utf-8?B?a2laTUFWb0tYZ2tHbS9WSnIzSGgzODdTMjR4a3ZFc3hoR3E0WTBKVnRMekw0?=
 =?utf-8?B?UWlzQ3Y1NjVFazdEK0lqbzV1cCtPbjF1T1Q4Y2VVaXFUWWh6UDZDNHE2Z1Fo?=
 =?utf-8?B?aUhCUGdHc3lmSTcvNXQxZXJCMUFzQjltdGtmeVh1NVVJOWdSZHRsSkJtMERS?=
 =?utf-8?B?d3R3bFZrQkk1aEV6LzI2VkJnZk9JcGVnTWE4V1l1MGRHV1hzcGF3dlcyK3Ir?=
 =?utf-8?B?UE1sSTRRL2Vyd2N5Ujgrb1h1Uy9WRjZGT0M3emp3cXBCREk0NEFDRitlVk5Z?=
 =?utf-8?B?b1JXZ2NTYjJxZ05YMWtNei9ycEZqZmRzWFh6dGhWWWxkZGxuTlpTZXY4NDJG?=
 =?utf-8?B?ZjdKSHVTcVV5ZkYrcGNSVG1QS3BZVTdVbFZHVzZhZ2F2TGcyN3lSTTRmZk50?=
 =?utf-8?B?V0VHRXRHVFRSeUNnWENrSWVtb3l5a2JyL2VDd3dYbCtsdDRSZzdqWThMYWZo?=
 =?utf-8?B?WUNtc3JNWlZGaE5BVkRvQXBGeEJrUnBDdXljbWljeHIzQVFJVW1EbVltd2Y5?=
 =?utf-8?B?bmVybkVKZy9pWXcxaENCR3FibEhOem5OdjRiZUJ5eksvM3BpaXY3MG42c2p3?=
 =?utf-8?B?bGJhSWhQakxCYjVYY2VUSWszWXRQaUVyZ0o4aUplVzRDUzNwTzlyUldibGJI?=
 =?utf-8?B?UmpoWHBlazZKd1I5cENtWHNKL3FoZUk1dnRYQXIxc285eWJBNTN2L1MvUjYr?=
 =?utf-8?B?T3Zvd241N09jUGpLc1ZWTEZMM3BtU0RQanZ5eHhPU0dCaFcxd1d3dHkwZTRp?=
 =?utf-8?B?aWEvdkZZdHhleE9kdUozalE2OXpJYmxkUlRnVTFpenZlSkNza2FrREhLWHNy?=
 =?utf-8?Q?Eln1Uxhw6VT6kzqg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912ee146-0ee0-4831-8aad-08de8019972b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:27:33.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WV7w0xfItqx8DhnqmlV2Z3yMbRkGHK4FOk/4LDNuAzR/zDVSyY8YizZjI+rQnoXQs+ABufW0NM+ks4XvzsX/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091
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


On 06-03-2026 19:00, Maxime Leroy wrote:
> The Rx descriptor count warning fires unconditionally when the total
> exceeds 11264, but this limit only applies when the DPNI is created
> with the high performance buffer option (0x80000000). When using normal
> buffers, there is no such limit and the warning is
> misleading noise.
>
> Check the DPNI options to only warn when the high performance buffer
> mode is active.
>
> Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>   drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++-------
>   drivers/net/dpaa2/mc/fsl_dpni.h  |  6 ++++++
>   2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index eb8333458e..61dcfafff6 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -74,8 +74,9 @@ int dpaa2_timestamp_dynfield_offset = -1;
>   
>   bool dpaa2_print_parser_result;
>   
> +/* Rx descriptor limit when DPNI uses high performance buffers */
>   #define MAX_NB_RX_DESC		11264
> -int total_nb_rx_desc;
> +static int total_nb_rx_desc;
>   
>   int dpaa2_valid_dev;
>   struct rte_mempool *dpaa2_tx_sg_pool;
> @@ -904,11 +905,13 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
>   	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
>   			dev, rx_queue_id, mb_pool, rx_conf);
>   
> -	total_nb_rx_desc += nb_rx_desc;
> -	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
> -		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
> -			       MAX_NB_RX_DESC);
> -		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
> +	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER) {
> +		total_nb_rx_desc += nb_rx_desc;
> +		if (total_nb_rx_desc > MAX_NB_RX_DESC) {
> +			DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
> +				       MAX_NB_RX_DESC);
> +			DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
> +		}
>   	}
>   

how about not changing the calculation, but only the warning.

     total_nb_rx_desc += nb_rx_desc;
     if (total_nb_rx_desc > MAX_NB_RX_DESC_IN_PEB &&
         (priv->options & DPNI_OPT_V1_PFDR_IN_PEB)) {
         DPAA2_PMD_WARN("RX descriptor exceeds limit(%d) to load PFDR in 
PEB",
             MAX_NB_RX_DESC_IN_PEB);
         DPAA2_PMD_WARN("Suggest removing 0x%08x from DPNI creating 
options(0x%08x)",
             DPNI_OPT_V1_PFDR_IN_PEB, priv->options);
         DPAA2_PMD_WARN("Or reduce RX descriptor number(%d) per queue",  
nb_rx_desc);
     }


>   	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
> @@ -1213,7 +1216,8 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>   	memset(&cfg, 0, sizeof(struct dpni_queue));
>   	PMD_INIT_FUNC_TRACE();
>   
> -	total_nb_rx_desc -= dpaa2_q->nb_desc;
> +	if (priv->options & DPNI_OPT_HIGH_PERF_BUFFER)
> +		total_nb_rx_desc -= dpaa2_q->nb_desc;
>   
>   	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
>   		options = DPNI_QUEUE_OPT_CLEAR_CGID;
> diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
> index fcc6d4726e..82d6830acc 100644
> --- a/drivers/net/dpaa2/mc/fsl_dpni.h
> +++ b/drivers/net/dpaa2/mc/fsl_dpni.h
> @@ -121,6 +121,12 @@ struct fsl_mc_io;
>    * The stashing is enabled by default.
>    */
>   #define DPNI_OPT_STASHING_DIS			0x002000
> +/*
> + * High performance buffer mode.
> + * The total number of Rx descriptors is limited to 11264 in this mode.
> + * When not set, the DPNI uses normal buffers and has no such limit.
> + */
> +#define DPNI_OPT_HIGH_PERF_BUFFER		0x80000000
Or use: #define DPNI_OPT_V1_PFDR_IN_PEB
>   /**
>    * Software sequence maximum layout size
>    */
