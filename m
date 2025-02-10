Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED07C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:39:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD6C7410DD;
	Mon, 10 Feb 2025 11:39:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
 by mails.dpdk.org (Postfix) with ESMTP id 4401840EE2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:39:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWivwuyRYKWv9453uz85qGcDg6o6l38SxCtiecUTnazjZljf4RzqJtqUC9y4Zgu1SxbFVJhp6Z39bVjVW2RVDCd//i3X2JqAmzeSCuuPFh8nPiJIZS5QGKdHzyNEqcLyQRzTlF2UiIZZP0IZx6n7QnHg/KmWmLFk+EVDntblMHhNVKsl0YZOPuUgEDX+GEUrk7CI96qY/n5iIX0IsA2q/hCZmONi5kA93zOsu0WF2kybKzKCCQZhuiTM+PEuxE3i2buu1+nolHPhvkmovFeJf2IaxEEPCdVyzTaz6Wct0mV1lNrVFp4YtV/bBuZRcYnYFHcA1MbrDeTPc0oP686fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2/rP3TPMjJaYMqN+TwZ2PEerftqw9TdA7PINktM3S8=;
 b=Fb93ROw9FMBZ0nlZnjZJThJqrzwfc+ia8YdW9wzXeDWEXQfVyxwcL3xxVE21iTbFgjriYCqFlYY/Zvjh/9dgTuJuoeeFjHaY4ghmAIlQlQUIKXBjh/3TLWLpHH0W8N2Nfb43WZx0qXNbJcN4bhX9eugjoo6HReVL4sVD15xqbU58VVMq3HCgNeiauZ4Z4cNBqyy/QCF3lcgwSE1H2pzMeUXfBFCCb5tEmc8dxJHCzy4OOuyQIWCnGuuQmGk4iM3jbD6keL4lQ/YAZlq1aIWbjSmhs5SdfYk2hKFfXr21JZarQCeTV9+L49Dr/bxAQmmMJ0SxOc7SZwkHRHPHLV3zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2/rP3TPMjJaYMqN+TwZ2PEerftqw9TdA7PINktM3S8=;
 b=MK8VCeDyiaU8j63vq73Qk/uoUIx4PgWXtIB6POAivbZstE9wAaRgrCfT/B9q8dbC5/aBfN+kzNyahuMoE9TX9U/FssW9b2l7/7cZC5rmyiCPgQlFigZ037SmYKxg1XmDX8LmYC4Hanq3b/OK6xZWqRxY1jJHUySiXt+pMjjnxeaP2DvH5COuFGdsV3OQ5vkZ2pA3rxefVYdjyWub7GeyBAYN0VscefVRaRQvl5TW4DVN+mWmtQKlhTntmMdmamw80p4dxlgr2qC6bXdZRYPFnMDYoKkLKbaEjdCeh9/Y9kM8Biiz6vphHuPXi8CT9jBK96cLgnMmAtECwSgMG4umsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 10:39:22 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:39:21 +0000
Message-ID: <5cfc8292-2cb4-a785-f3f3-33508ade04b7@oss.nxp.com>
Date: Mon, 10 Feb 2025 16:09:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/32] event/dpaa2: replace memcpy with structure
 assignment
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-8-stephen@networkplumber.org>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250208203142.242284-8-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: e68725ff-78fb-4970-31fa-08dd49bf2dc5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWptTEloa0UzQUZ1Z1diZ1poRU9nVzdOOGdHaUZYTzUzaE5rSGlWRjRJLy9D?=
 =?utf-8?B?Vmg2Wk0zczhvRDlEaWp1blUrUGMwTFNwVHd3NmtuelBEQ3ZGRWFvRFc5Q21m?=
 =?utf-8?B?eU9mSFZ4c1pjZ1pQOGpsS1lRNkVWRnBkeUx5VDl0Vmdybm1zcHZiSGFpSVoy?=
 =?utf-8?B?LzFDT1NXaXFrTCt0K0JLSnBjQTRHMkRpckV6c2xWOEcxaFVjdWdncStwMkVC?=
 =?utf-8?B?Ui9STEFkWkIrMUxCWGFNUDRrMTBGbjFJL2swaFpDcW5PcklyRVF1SFJOeS9v?=
 =?utf-8?B?QjZ3NThSTXp4NVZaQmNRVXdWU0RNNXBnbFRPOTUrZVRZOFdpdERqdWJpajAw?=
 =?utf-8?B?WDBMTjM4aVZQWEMzb2JKWDRWYkh6Vmtib0RpVERuN252TjAzS2hMSmNOdnFZ?=
 =?utf-8?B?c1I5azJJcTZiR2p1Ulc1bTN4dThFM01RcmlxUW14YitZQU1TNDloRFdaMnBG?=
 =?utf-8?B?aW1MdkRNOWNWN2pyK2ZMUGQ1UFk4UVphRnA0TGNlaFUrck56cnd2Ykd5ODhC?=
 =?utf-8?B?ZVo1Z2NjNmlHRWhJZnR4NXZFOTk4bGdtYVZCVWZLRTM5dWtZdjg0QlQzU1NR?=
 =?utf-8?B?b0ZsY1MvZFlSd0E0M0VzeUxGTnlZODdvTGhlSDNPMUdyUW93NDhyeHl3VmJP?=
 =?utf-8?B?QjBQdE9nb1JEZ1R1NklIQlZrMklNdjAvNmowaU13eDd6Sm9hTjBKR082TDJD?=
 =?utf-8?B?blcyd3phVldqYXlRUzB4Q3F2RTJQUEhxdTQ5cWxad0NBQ1VyNDdwL0hETDhx?=
 =?utf-8?B?SStVUlR0NG9GRTkvK0R2NjEvaGxNbHg5ZHgrYlQwY1NTK3RoaVV3TjUxTzBX?=
 =?utf-8?B?U2U3NUVwYjVhR0trOXRmRDBmb1pKaDdoSmpEVmJ6YW5wZ1RWZUZCTmpMaEJB?=
 =?utf-8?B?bHhPV3RUdHdCbG1sd0dxREQ5N2ZuTEU3N3puK2YzUXh4MCtYSlhqU2QzaDVw?=
 =?utf-8?B?MEs2dFBURmtwSTlqL25vVk51ODZjYy9UY00vVVlLSG5PclZmLzAxSXJ4azR0?=
 =?utf-8?B?ODUvRGh6aU5wQnZ0TWFqRlMwbFlsYTUxRVZBWHhUZzdNbVNtaHpCd0M4T1FY?=
 =?utf-8?B?ZHlIME1WcWZLS3Z5dUlEYkFWaW9Lc2M3TnZEc1hnN1FqNVdZb0p2enJwWUVT?=
 =?utf-8?B?VDY3ZHh3M2dhNS8vMXYvaEUrUlo3YlNHTTJESU9TeUJPLzA0bk92Tk1aZ29D?=
 =?utf-8?B?M3hiQVlNNk1iQlZwTUVDc0hLUG1jTDRMSWRONTVFTHdJTnVidEtnU0JaTEV4?=
 =?utf-8?B?VjlJckZwUFB5cGsyZkVva1dNWDBuSDFHUGlnRG1GZWdDblEvK3NYM2dheElk?=
 =?utf-8?B?OStiZTFreDhXME8vVndMZDJ5SVF3NXdYSkRtNElVSjN4ZzNXUFh5L0VhS2gy?=
 =?utf-8?B?ekcyWUYrTUlHeVM2K3lRTmROeE9JaVZuYXNzdmo3L3VoWXZYM0hBUmJXTDM3?=
 =?utf-8?B?ei9LUnE4dlZPcDBDUUkzV1dybm1UWldkd2ZDcUxzY2cvOHpXZTRzRnFsaUk1?=
 =?utf-8?B?cDF1SXpQR1IydjF5NzVLMHZQRWNGcjNxSEF2alpCRk45YU5MVy9lcE9sQW5K?=
 =?utf-8?B?L1pHaDBxRU5walFkMHNmN3IrQ3BFNlU1aEkyMmVieXQ5Y2h4eldjZ0tBalJq?=
 =?utf-8?B?V3oreFNjYk15WDNFN3F5ZUJCNSsyd1V3SmZ2ZDJScFRDRlhLcHNITit4OVVy?=
 =?utf-8?B?L1lPWUtBblczVFFPaElKdWZ4SWFaWjVxbm85dXF5RmNaV3ZMTzFVb3AvVzlH?=
 =?utf-8?B?cVVzc0tHcHE3RE5idCtBQXpWaTY3Mm5TSnBDU3liK05oLzFYaXhHQWptVGpW?=
 =?utf-8?B?cTgwZ2JhQ0VkVWRKUEdRQ1dkYXBWZDNsSEFXZUVyWVNxNXZ3RGRpS3IyZ1o0?=
 =?utf-8?Q?+SvI+fgyreea4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5Fek9YYiswR2thcGVKRkJUT0MvZnZlbHFyRHVBZVNMRWVXRXVKT1lSYktP?=
 =?utf-8?B?bUs5MVZVS2VGVzhUWHVORWpzWlpjTURGeU84Q0xqZWFRWmMrY2hxRTZVMmJo?=
 =?utf-8?B?VWRMK1Iyb2FOK004aDIvdmZsNDl3bTdrcmNPcFh4RzhOYldyYmFzS0VGdXpk?=
 =?utf-8?B?SUJGbExKU2I4WldNbG44TnE2OUY5eVRoNEdwOW9jRXFQMWhmUVVxRVBybUNB?=
 =?utf-8?B?cW1yMDR4M0tlUm5aYXRlWU1PZVBwVHN3MFdDZmhCVlhLSFc2SmxQemZ2bXRQ?=
 =?utf-8?B?d2VybHkrc2txVkVkM2VLbUU5UTdPa0ZnNG52MXYzZVkrd1lYM1QrZXl0Nmcw?=
 =?utf-8?B?dVp1RjJEL25QREFtcTJTM1BFc1VnOHkzenZkSFNBNmttQVdtSkhIemNROWZk?=
 =?utf-8?B?amF0eVYxYllTNitPZ1U1dDJrSkM5WjBBOGJRRDJKdmNWMzgxa2I0QVgzNEN4?=
 =?utf-8?B?NThiUWM5L0tXcGZVcUxOQ3hlc004cDBRNFNHc2tkWFNZZFFFaW9kV1JVK2J1?=
 =?utf-8?B?dzJWZ0ZGN1RRNU1Va1JRa0c4UTZZc2JpS2hxamczTlJoUUlwcDQrejl4aG9r?=
 =?utf-8?B?MTBHMHlMK1FyRXNzbUxSd1dtQlFPWHFPWEtValdWMitrc2NKUitzMmxhVHBq?=
 =?utf-8?B?TU5OQUsxL1ZEejkzN1FXWk5aSjJzcDRTK2V6ajVCNitQRnBnS1FQUkpwMmtp?=
 =?utf-8?B?SFQ0MGxhWkpoOTZOSTd0d2dYeW1TQXJzeGFKeDQ4SFJPYzJCTVVKNHRVdTl5?=
 =?utf-8?B?R1VjcVNyZ3JMM1VnbFNKMDdZeWZDYlFIU0cvY21ONGtia3FUcXBuZ3QxSnpO?=
 =?utf-8?B?SXcxS29rd1pxOU1xUFNKTlU3QkJ2cEQyazM5ZHR0V2E4Qno4T0dZMXVaNG9h?=
 =?utf-8?B?TmJvQ1Y5ZXlvRmkvSEdzZUFTbi9tWDdyNmFUaTBZQmplUXo4Y0l5NGx6cS9z?=
 =?utf-8?B?a2ovTFlXR1cwVDNGWDc2QWVDOVVTL2xnaWQzcUxwMjFzVUNpdlQvUWdJeXVu?=
 =?utf-8?B?dUxSemNRZi9GQ2lNNitrajhkeWZQNmU0Z2xkNGY4d1o1VVROVkFUamJ5YzBy?=
 =?utf-8?B?b3F0QjJ5VU55dkphSStsalNnM20ydlllU2tqZDFLMEl6SzFjTncwVENVbklI?=
 =?utf-8?B?RWlIRUpOeXJneEZBZ0lrOUFrV2xwaWFtR2VjeXRlNGY3aHNtT213K3MweUxW?=
 =?utf-8?B?S2JQSXZXQmdFVzlQM0ZVUVJnUXlWbE9WQTZ6Q3pIbDBFaTZXTEtEZDJlQUNz?=
 =?utf-8?B?Y1dUMmNyYXVSTWZ6NTV0Q0NvREJ6a3k5REZ2dFQxTW9GWERiNkl3ZE5yOENr?=
 =?utf-8?B?akJhazM0eUpMUGdhaDF1WXhCYjdaVjQ5aFdmci9qSkZQL3lkc3E5eTZPUnhi?=
 =?utf-8?B?ZWY4ZHZCMHIwd2grbWs0K2ZtN3g5dWxFSFVsQ2MySVZXNjB1OEE4ZzRxdU1U?=
 =?utf-8?B?UXVlUVZmZ2ZwaTRRb3VxTmR1SDFBK2ZCY3d1QmJ1aVFGZFg3dm9UTmdlYlZm?=
 =?utf-8?B?d2pCTEY1dUpiUnQ3R1IxZjE3S2JwRjdNVVVRYytoUWNWUm5FdkNESHhZNlRF?=
 =?utf-8?B?ZlNyRW5UdFhaaDRkczhQNkR0a2pEQkw0SVBHTzZoSGowNjhrS0JkYm5RbHV6?=
 =?utf-8?B?SU50SkxvWXVBL3FJRFBUZlBkUlUxazFKZnd6LzV2TnZxUWF0Q2VZWmE5Z3FT?=
 =?utf-8?B?Sm1sYVh5aXZWOW9YbllzeWZnSWkyd2ZSVythUVVZcUpWV3FSTkdPNDFEK2FQ?=
 =?utf-8?B?cVRBMUdYMHArQXIvZGhwV1U2TEJ1L0M5ZEZRRkw0UlQ0VXd2andrNW9haS9i?=
 =?utf-8?B?bVgxVitTazB1VTRqaTNyUFRwTGhTMzJDeklTNlI1VEZiK1pSZERXQXZpVlgz?=
 =?utf-8?B?ZWpqdVVEb21XMWtRUHA2VTN3Q3ZrS2Z0bmsycUZLQnBJb3RQbk5YNGUrSFlo?=
 =?utf-8?B?TXBPWUpwOW1KWU1lT1lOUW44STJHMG1Xc2psczl2V3JZL3lVRDErb3BSNlhk?=
 =?utf-8?B?bXgvc25pSy9EWUwvTXJCL3BmeTNrSThyMEI0M1FLZkUrT3EwdTBWNG9QWUlM?=
 =?utf-8?B?NUk2WjlzaXlxU1B1anhuaXpzc1hTeUdZRjU1MHFucmp6NFd2a1AwTVFqYXF1?=
 =?utf-8?B?cVk4Y3hCTE1VaGpVRmd3WUx6M2ZRZldpMnkrSFRCUm9tdnQxNGhBTndONDRk?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68725ff-78fb-4970-31fa-08dd49bf2dc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:39:21.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUZGCkyIM5bZuvNWjuFq67aZqw5LZldSUfPWFtXJFy18B6KLP8FSGis5ITpVxS46s2daNFF+WsdGG6QsqXK98w==
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

On 09-02-2025 01:51, Stephen Hemminger wrote:
> Prefer structure assignment over memcpy.
> Found by struct-assign.cocci.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/event/dpaa2/dpaa2_eventdev.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
> index 6c8ed3ff6b..95d9154b11 100644
> --- a/drivers/event/dpaa2/dpaa2_eventdev.c
> +++ b/drivers/event/dpaa2/dpaa2_eventdev.c
> @@ -224,7 +224,7 @@ static void dpaa2_eventdev_process_parallel(struct qbman_swp *swp,
>   
>   	RTE_SET_USED(rxq);
>   
> -	rte_memcpy(ev, ev_temp, sizeof(struct rte_event));
> +	*ev = *ev_temp;
>   	rte_free(ev_temp);
>   
>   	qbman_swp_dqrr_consume(swp, dq);
> @@ -243,7 +243,7 @@ static void dpaa2_eventdev_process_atomic(struct qbman_swp *swp,
>   	RTE_SET_USED(swp);
>   	RTE_SET_USED(rxq);
>   
> -	rte_memcpy(ev, ev_temp, sizeof(struct rte_event));
> +	*ev = *ev_temp;
>   	rte_free(ev_temp);
>   	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
>   	DPAA2_PER_LCORE_DQRR_SIZE++;
> @@ -588,8 +588,7 @@ dpaa2_eventdev_port_link(struct rte_eventdev *dev, void *port,
>   
>   	for (i = 0; i < nb_links; i++) {
>   		evq_info = &priv->evq_info[queues[i]];
> -		memcpy(&dpaa2_portal->evq_info[queues[i]], evq_info,
> -			   sizeof(struct dpaa2_eventq));
> +		dpaa2_portal->evq_info[queues[i]] = *evq_info;
>   		dpaa2_portal->evq_info[queues[i]].event_port = port;
>   		dpaa2_portal->num_linked_evq++;
>   	}
