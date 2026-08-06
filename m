Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D0C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 06:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D1ED402D3;
	Thu,  6 Aug 2026 08:11:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
 by mails.dpdk.org (Postfix) with ESMTP id A37FF4027E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 08:11:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ5p1Mn+6i2TBnKuVadeFwS7AU1xuGYUtX2s11FfJ5GP5U1b+Q1X0YfGAbGpVE6ArhxCwXQhcyq/0Wv+pxp16EwjB1wMgyxaf7MmO4LcLrDgb9CIGbtaLbnABibQeOqr+i2HnurY3A5XEKDGwCHCJ8i+nj69Hkjd0j27eONbvv5+XMoJgfymhhLvu5yo9Ii07nFw9JeB3sva7inHgtIfJPRYzPvU7Qv8AkmGC83/ocA976iaQqLmFKtFBTy6BIbSnSqSIDUEa+IPIE1tvXkGYmpTTcszy6vHcOjd2WllqSCzuSCc9/0wDhEHr2MPazgPd9MgaR2ozNNaC1jaq4pStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjoj14UnLiKA7BMXcRdzRrXAh+UpoPVvc1TPKba4+5k=;
 b=Oj8kBUR2icHuV1N6jbKRuS9TFjEpdXhmNi/5XgThqIUyjYeYD99pwh5ybHanm0vAfYGx2DcJZYJRKQbhg3m+8Dq4mQqo0iYhP2us2O76VphuaNgtYNs/ED5Jr6joL7k6JCCFEiaw3KFL3ISAYp/AWrYEj+Bq9CNgEYlaQiIEHKUEe0e+9ULR8Jn7k0UcfYiJ/pmXuQ3hqpiz57Gc7sf+EbKaEwtreKZ5cQ6FbEmo+6PdP2TyBCtl+QKl7qPdylWd/Rh22dLqZWY7jvD9ublbUDDFTd3z3jia4Gj5e97X5z3de0Qcz0iinHanDzi5t6pEEUPjaKzMJ48EjORgbU85rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjoj14UnLiKA7BMXcRdzRrXAh+UpoPVvc1TPKba4+5k=;
 b=maWS8ivdgJDai8q+LQMLpnKmJlXDLvJ5OmvnPpUqdlxegshD9mPw9gQ8B/6tkg8JKwL0cya+LV2mo2vKef5RyU2+lTq7cLOQU0soYpHzyfshLQJ+FpzqQ9E4bfqRT9RPWeGUZTdDP76psDRY8tFlDkyYK7aHCK3BLE8SxYmqiSGzK5uDQC8UerZ5wDoPhwY/HyHaM+DW+A2CSIhQiflRNTCje/8SFnGjfoJVf5PH0VpeOBKwTWapRIvgzbIkh2bca9XJofI5WkeFofUMwVaOXLrjGfbtyknsdAN8dI7Y3P5HiW5OEKvBRWLVAtAGMArZIUEknm0HaRZELyI0m/i2kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM7PR04MB7110.eurprd04.prod.outlook.com
 (2603:10a6:20b:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 06:11:35 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 06:11:35 +0000
Message-ID: <46de3c86-d0b0-4262-8301-07bd179456ca@oss.nxp.com>
Date: Thu, 6 Aug 2026 11:41:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 19/32] crypto/caam_jr: use IO barrier before job ring
 doorbell
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-20-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260729175715.165120-20-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc498db-5487-427a-a168-08def38191c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cBRX1cn6wksDR1BD+nSNKJ60M7OYkCecrcCEQKMCQQB/YzSQDU4C+ct4oR+S5nI2MYHHK5uLLbuC2pJc4nc+j/juEI/fVlhRy/CssWNfYRzTcfwof1JPSIpk7NMmIAPbSZoFYmgUcSmm97s90hJ1MBMCYqaNMk7W8lHR4mc+I7LGhTHRZzfnmyOX/bbX3TzfniboBQ4O+/iBsO8wnuhKx1jz2kgeR9jvH6fpXynzl95lPfEZN040YltFrP90/QqLHkQ3oVnpSEERXZcjIwCUiBCWX8KN3CzX+lQApZajYoN3RZR0LxUNEJoANsMP7Xdk0FYqpil+kboxvsvzAeNUuyRhsH++B0DbKQeYbkaMYBVmbAk+cEadOfBcxlxZ4YCCCoOlKOddmIioi7kiVpZhnDGHxoG7lFv2Dwg4gzPHYGgOIrZgvDbnwh6m8FnpOiTc054PH1WgMQyES+JmMceqdAQn4bpF/3QeMr87FI7r5SY+FCbogOqPKGUWZRzS5mHv8i4K6/F0LJfdyEtSzPVbtwF/IXrs2C42sCgrzF9RoDpjc3Rr9EBlp6X68ipmk0Tr+J4IIECj9TgRm6jDF0Wi44cal3+JTwoB0X8TNUw6SopXPqTJwVX8Z8Hadou+d6EgI3a4c5SEaoMkwtWEdMbZkLFLnhyKvGyfcZEcIfodOt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNMUThHWEMwUkRLcDVIdWYwTGh6Wm5kZ1VBL2l3aEt5NUgxTEZYN29TcVJ2?=
 =?utf-8?B?bzdFM2U3dDBVTi96Y3lHdHhQclhlY2lhdjc3QWdONVduMkliUmVRdE9NRkxQ?=
 =?utf-8?B?eVFWbHMrcTJDMkxyejZ5T1NvMDh0RGtSMUh4REFYV1BnSDJZbWZSQjFZbVZG?=
 =?utf-8?B?YkRDRGYzMjAycWd4cG5iM2N3RmxYTDhlMURtS21NT2doRHU3MXFKU2I1bWZ6?=
 =?utf-8?B?czhQTDdBVVRNajJjbm45Q2hRU29YazV1T3dSMEd5dEJHYS9GOXpTeGVPZVJS?=
 =?utf-8?B?Y1hsY3FqM3huSCtVZEtISWhZV0JYM0lneldVWWd4R2tpaFRGZXZNak9KRk5h?=
 =?utf-8?B?emxVdDViMnZIb2pPMm9VOTR6VExtNGZjUVJlU1hNQU4zN2VYU2F4ZFdtUkZk?=
 =?utf-8?B?a1pVc3NKZzZvbzdsdDU5c2JZc3VLZThkaVVuazZBZEJaWEkvQjRXcXV0NS8r?=
 =?utf-8?B?RnFyZ3IvQWFoZS9wYVl0cUFUUHQ1QjRhdDZoYSsxSUpHcDRnSzQreHFLUW5p?=
 =?utf-8?B?Tk1sZGdCTzN5dk5IOTluMm95U1lDWWVJU0h3anVOU1lVN2NvekwyTWZLL0VG?=
 =?utf-8?B?U2RuSVVjNE9tcFgzOFNyQlpEZCtua2pTVE5rcFpabHZ6K2FpbU1nLzVxaEdO?=
 =?utf-8?B?SUhNQkloWWVtbFdNQ3FjbzVTTzBIV3R4dlpoNGtpZTZuaWJoM1NmVUpuWksx?=
 =?utf-8?B?VVRFVmh1a2toaEllZVlNM09na1JOOW1DTy8wcXBkb1dDS3pyRFVoNm12Tmwy?=
 =?utf-8?B?d3IwWm5mVnMxak9md1lLRXZnMkxUTVpXLzhBTzlmWjFKeUZIak8wSVVRd1Vw?=
 =?utf-8?B?QTJ3TE9XSDMrS24zdktUYzZ6SlpRalZOR1JudDh2UHNWMlhEczljUjhPV3da?=
 =?utf-8?B?VmcySStXQWd6V3lPWUo5MUVZdWVUSEJvQ0wwWHRscE9FcjhDOVd4STRLUzFz?=
 =?utf-8?B?VW53Ukw1OFc5RW1DdUVxUVQwVVNVM0dWTnNUcFVOd0ttY21sdXNtMzdtL21x?=
 =?utf-8?B?dDhVbUpPWU1TdlpsK1RhUHl5eFZZYWZpaFQvMHVVVmM3eWdnZzE1dkl4TFlD?=
 =?utf-8?B?Zi9Kb1Zxc2lJVzMwV2lqZWdiemVCeDFpRDlVbVFvRjZoMVEybUN2elpuRzJm?=
 =?utf-8?B?MUFuRU5XU2VDUHU2OHlNUmVlbFd3eUMrY3hmVXdmQW50c1RSZVZMbnNsSGFM?=
 =?utf-8?B?UHdzSkNrZm8yKzkyNlBYZk9jNGZYR25aYm1wVkRFYm9zODNCb1R3VDNDQStV?=
 =?utf-8?B?R01tdlJXWDUySkZrRkxwY0dvYkszMHdML3IwaTRwZ1RiQXpwcW9VWUFpaWhh?=
 =?utf-8?B?Z0lCaVpUSnVmVEI0RllLanVlYVYrdTBIbm1yTmRyV2hEUm9pZEhSSW45VWJV?=
 =?utf-8?B?OGNEVTdSZ09FSk05SEpaMWNWa2RlUW1Xc1dDWDNVTlNiQWJGU1hjdThZQ25M?=
 =?utf-8?B?U0Q1eXRzTWlhWjV2bG9ENnRNMEhzOVI4djAzM3FqTmJ6K0FuZmt2cHFXM3pz?=
 =?utf-8?B?aDhyVWVaYW1rdU5leGw4dFNmdW5oK0tHaCtob01MWnZ2a21UMGUwNE5ZUysy?=
 =?utf-8?B?N0wydzdSMkpacGJHbyswUTlMZ0pUdDZyZU1nNTRmbHFPQnh1ajVQZW9MS1Rq?=
 =?utf-8?B?Q1NCdlZPbUlhcm40SUN3TXJIWUJTUk9YNFphSDhmQW5GT0JWUll6d3pVeUEw?=
 =?utf-8?B?NTg2U2thcGxSdTRpUFFxS3A4Ry9MT0tEWFh5QlJwSXlnNU42Z0xoTWg4QnR1?=
 =?utf-8?B?ek5wQ1pVeGhPOFd1VlY3aDYycFZidmhrODA1M3BadFZqa2UvaHlPTVNjU0E1?=
 =?utf-8?B?UnNlVXhDSXZ3VVJJZW1GbitNY1ZrQ215cFJ4UHJnS0VXSTFMVXRJbkJXcWU4?=
 =?utf-8?B?enpjZ1RNS3BPY2VKLzI5S3hpVWQvYVdGNUNrMFRjZ05CL0EyU2dYZEZwaFpx?=
 =?utf-8?B?b1BxajBhYnZVL1hpZGNZU1VOR3E5SnBLMEJpWDBYUjB0S3p6Mm8zV29tU0Nu?=
 =?utf-8?B?c0J4TmQzMHhnRzJCbWtEd2M0TTMvSXJtSi9JSDZzVHFUbEVkUDh5bW45WlRy?=
 =?utf-8?B?OWpuQUJ6RVJ6QU9OM0phais1RHlQNFFNYi9HazdzN0JSL2FsWFFxWEZGWmd6?=
 =?utf-8?B?SktsZDRaL0NMNnRmd1gvbjhpMUZSOHBKditSTTZtUWxyQlV2bXd3VEo1Z2M3?=
 =?utf-8?B?OUVPWXMwTCt6V3EyR3h2ejNkcnBMZWNJMWthdjVjUmRqNk5VMktRN05IK2FE?=
 =?utf-8?B?S2wzWGlONmJ3cHRZdXQ3UE16a0I4THV0UHB1akh4a24veEZoVkxJTmN2a09l?=
 =?utf-8?B?bG1Yc0JTNk54NHM3TWF6aUFldXA2U2dJVVVneTNXQldoMFZ1WTVhMUZidmNv?=
 =?utf-8?Q?yR5sR5rWV0AV77vg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc498db-5487-427a-a168-08def38191c6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:11:35.8037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQjU/2TTDpQZg3VtS26UZ4uCmspAqc0DVNjYskdarRO9a7urP6uZbmyMkeqlSZLcJVESbL2rjGnGed0Tvrq87A==
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


On 29-07-2026 23:24, Stephen Hemminger wrote:
> The barrier orders the input ring descriptor write in DMA memory
> against the MMIO doorbell write. That is device ordering, not SMP
> ordering: rte_io_wmb() is the correct barrier, and on arm64 the
> inner shareable dmb the SMP barrier generated was not sufficient
> to order against the device in the first place.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>   drivers/crypto/caam_jr/caam_jr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
> index 1f97e72337..7a345c436e 100644
> --- a/drivers/crypto/caam_jr/caam_jr.c
> +++ b/drivers/crypto/caam_jr/caam_jr.c
> @@ -1451,7 +1451,8 @@ caam_jr_enqueue_op(struct rte_crypto_op *op, struct caam_jr_qp *qp)
>   	/* Set ptr in input ring to current descriptor	*/
>   	sec_write_addr(&ring->input_ring[ring->pidx],
>   			(phys_addr_t)caam_jr_vtop_ctx(ctx, ctx->jobdes.desc));
> -	rte_smp_wmb();
> +	/* Descriptor must be visible to the device before the doorbell */
> +	rte_io_wmb();
>   
>   	/* Notify HW that a new job is enqueued */
>   	hw_enqueue_desc_on_job_ring(ring);
