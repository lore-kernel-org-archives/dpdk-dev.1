Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB530C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 06:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF4F402CA;
	Tue, 20 May 2025 08:20:32 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
 by mails.dpdk.org (Postfix) with ESMTP id 1721F402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 08:20:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrXr7uRGUigq1EC6gHsgxZTVwVoXQcGbtFTwV5DwlpHNYLfKe2Am6jsn/ix6OTRvwjlLbqSu+G7wBga2MSQMXdrY5vi1DBvauLGON1m0L5HsUfiCPl52Hl9dSeQpj/TJJFjOWv9d+CO0DGfB6nx5uP4HjPR1zuw/y2xIXxbug1Wp9zasNq7m/E5dGZy7grX/Wlqrm6FkSX+Zu6jqbzgZcrysUFQB6XV74K1e7HxpLCNDUvepXXCawZdrvj6p1U5Z1godVHmytXlfVL+UQObAMaKDR8v2QHdJS+hzJPkHrGBfr2PdzSf0hxGYOBhQ53Di0BB1Fo3x/Um4ctACym+9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut9K0PlNuMw8gQhUS8+baKrRTL9MzfQo46MKg/4WBRY=;
 b=SU+JmKt0Vrxg7cixvFNLbuqp0p9/zSerktp6uUyWz1K5DnUE6lgl+XXA0hblgpsfFTTXF5y1fnwP9k7uu0ehkF83/NFx3DZh9rfqyFdgG6gttG8OSiHEu/zmg8J1g0cpBMwHj4fnGtRB8zWiX8a7hAx1jw64E/ngRRnUHY9hrGIePjs8hGP7bGzRJBPDie22v1l1KfJ7XvjhZkyn5UCffo/aHSFs+elU6O5PP57kIDMIaHcQkwVKUm9RfPBRu+PI1q2tDB6CaKG+mGRQY89JHLSc4bidExCo04xIltDkn7YENVfqKIN+auVVHg5QrrVZwdlND6FO6KiGvgZgZSej/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut9K0PlNuMw8gQhUS8+baKrRTL9MzfQo46MKg/4WBRY=;
 b=IQWfPKvYbUqu6mQmBNaux38Z625JWXBZtKkc+JmjfoAHm1ZSm51jx1eHFoWMeCKnOlpYodvOqRLxXxm1PeA7lnOcrkdomBG3oKWR1G+crFHGyoQMpuYZ5xAUoBhv57RvVEO+SXU6DYyHd/6tzTlcxSPwtXoYlKLQehVHaxw6apBE7IO9hslw/7bkHeYD2RzkqSrMuA6pgqsfzlFECSLTi/5gEI+4O2Q+MxdUhQQweOayvPDjhKGsvz9uk0eiqh8iJbIZe6CSZzYTdwDbFnDQe8h+ub0Z34s0MjaiE+wtZSWxXmXPIAsg818+cLRElr3dhzGSQP7zWepwBq4gWbpFpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 06:20:29 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 06:20:29 +0000
Message-ID: <3c0a10d2-83ec-963e-66b5-34f7c0bd9404@oss.nxp.com>
Date: Tue, 20 May 2025 11:50:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 6/9] crypto/dpaa2_sec: add null algo capability
Content-Language: en-US
To: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250520055133.506071-6-g.singh@nxp.com>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250520055133.506071-6-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA4PR04MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8945ef19-7d4d-43fd-90f4-08dd97666ac5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1VkVHV5aVErODhWUER4Mi9VVDlIdUcvdE9IV1FPdU9DOWNRNVUralVBWnUw?=
 =?utf-8?B?Sm9yb2M4WEh6MUZaT2FYZkFqdkhGS1ljZS9kTHFNN2t4a0FCVi9aRE5yUTBW?=
 =?utf-8?B?L0toaVAzWjNTYnB3QTUxaVdJSy9IeVJOZS9lK1ovVjRSQ29FY3FmcnhWUWpu?=
 =?utf-8?B?TXdjNDhhcmJObkJyT0k4ZkFmdlkwSkJ3Y0dnNWNqblJieHlyR3NESHpBNGM0?=
 =?utf-8?B?d2lxVG9vTmVibmZlRGJ3VjdmU0pIVi93allxeGo4cFZ5N1Y1YVFkZjVZbWE2?=
 =?utf-8?B?cVRLaDUyWGJVd3VEM01sQVVpeGkwWHE4YWRja2M3eEJmSTJNVlFaYklxalZm?=
 =?utf-8?B?YW9LRE1NazV2akVkVUNiRnQ2TDU5MUlsUjlGOGE3azF0Rm50bVJOR2hZeTVT?=
 =?utf-8?B?KzIySEhvYUxtSVNSTDN2QW1Bb3BXeE0zS2dhZ3ExTlg1Q3AxT0ZjM3NRRVJL?=
 =?utf-8?B?enhBSUV5a3paWEZDUVh5aENwZUU4amNqcWVQQ0d2SW5QdzNHVXNmOTBtZWJV?=
 =?utf-8?B?WWFleDRSdmx3ODNtUjVoU3VIb0Y1RmhCdEZqYTVEVlBXdGtRV1kxemd6L3dR?=
 =?utf-8?B?WStRUGZTRVFhZ1lMRU1xblorZy9UQUFJOENwb2Z6TjFxUi94Q2VBY21FQS9Q?=
 =?utf-8?B?SFlWcVRDU1FTRlkvWkh3b29tYXorL0xWaEdIN3Z1OUFNVVEzUEJ4NS8xN0xG?=
 =?utf-8?B?MENCLzBXVUdnUDdxWVBablE4SGhnZndqYXh2SkR0Nytub2I4Y0IyZERWVzgz?=
 =?utf-8?B?RXVwaHNRempiMEdPSmRuTVI5RVJnbWRaY2dwR2ZHL2o0Umw3VnRwdTVxbnp2?=
 =?utf-8?B?a3hEamJ1a1JMdmMvM3R3bEVVWEJIb3VwY1B0eXFMQm1QUU9BcXk0SUFpVzZs?=
 =?utf-8?B?RTZFbVNoMGpjUFRUc0ZNenQ4UXpZbGY0bVcrSnhiL3ZxZFVSQVRYRXR0Z3lx?=
 =?utf-8?B?dVFWYmVzQjFVeUMxazZ4eCt1ejlsY0pjQ0lkcVdzWkp3dzEwMFlOVGM0cTNT?=
 =?utf-8?B?aWtlLzc5aTlDbHRidmxCTmFxWXRNTFBmampYWG9qeFVSZnhlMmhrdkZkODlm?=
 =?utf-8?B?eGpUWm55bmV1eUwvM1d3ai9PVzRjUWt6TjJuMTlLeWd2QTBuRkNvRllwcVpV?=
 =?utf-8?B?blU3bW1TT3o4ME5vYWNSZjJ0eVdOc3JZTHlUdkpHcGxtd3FGTTdTQkdkVHN6?=
 =?utf-8?B?ZktXdlpQSWY0VzMyTlRSU1FCd3ZZOW5LY2NkRXc2M0E3aVpqRTFDYi90amp0?=
 =?utf-8?B?aDM5S1BGSGF6cEUwSm5HeEdTa0Rvd1lBUENDdG9DY25IUUQyeU5ZMHRTSzlK?=
 =?utf-8?B?b2hqcXE4ZVBKRWRKWXhmVzFpejYyS1NHOGV0dzZja1o0VmNaNGJVQXdYWDJP?=
 =?utf-8?B?ZGQxV0hZUmVHWEhWNTZrajQyZ3MyUjBOemhNTTgvUStCYmRUck9yZUQ1N3Ji?=
 =?utf-8?B?WXF0dCt2QjFpOUNBelpZTXErZWdaV1JpQzJxMyttaHdvckN1ZGVRVlIxWTBh?=
 =?utf-8?B?TVRRUGU5Q21SWCtZdFZqem0vbkNaT2hOU1ZKMWRXeUowdFJybm9JSG8zckJN?=
 =?utf-8?B?aVZpbnJ1Wm9iaGNycGhEMVJ5bzE1QmF1eGI2ZDh1c09WeThGRVlIdFRGZS83?=
 =?utf-8?B?NGo0RHc4MlIwSkFza1ZYcWxVNXZhVG44YTJmR0xzMjJjMFhRL1dhVDFNZkRU?=
 =?utf-8?B?Rm5DR1NVM0FoM1NwTXlrTmo3T3EvQU5DZ1FzUFp6VUR3TUlBQ1dJM0J0cnFV?=
 =?utf-8?B?VFhLQ2ZvaG1ncWZ3QVdLS1MwdWRrUjE5VlZncXpvUUJWMHVwWDgvc2xqVGtP?=
 =?utf-8?B?WjU0dDhTK3dQNXE5RjNJdm8ySVdGcmN4Zys3YzZtWCswUmhjb2JLVGRURlFu?=
 =?utf-8?B?eFdVbzNEVUZ0U1dEb1Q1cTJXOXpUQlB6UHJJaHhzeDJqMnR6elJyK2NsRlJ3?=
 =?utf-8?Q?m/ry+i3tJEA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxyVnhiK3FPQ3gxQnBoTEIxeU1aV0xtUVZnL0xFbllIam1JMDJCVUdVdUc1?=
 =?utf-8?B?WHNKRzdXNEVXTTJpV1ZYNUliUHlmcTBQRmlvRkp6TmpFd211OHpPeTJ3MVJG?=
 =?utf-8?B?bjNmS2NPZE1kaDV5QytoY3I3MmFsOGp2N2FFU0cwQ2xKb24xaEVXdW5wVXdt?=
 =?utf-8?B?T3A4RVhFSml3VDNNanNpaHk0TnJzcUZ1LzdxUjA1d0l2dlpLQkw5ZW94RGpw?=
 =?utf-8?B?WllkUmdqVWRyR2xDNGNlK3BqVnpwc2kwMWd1dWtad0Ftc0hNWmFqN0d5Mks5?=
 =?utf-8?B?OVQ0ZlV3T0pYUHp2OVBEVFNkcEgzN1NNQUt2UUtYZ0E0Tk1wWkp2TXFBQjQr?=
 =?utf-8?B?Tjc0TEczSThGNFZHaTBjV2Njc0ZKVGdwRytXZ1pQQllLL24wb3ZnZ255NFlr?=
 =?utf-8?B?MTQ3RHg4cFBYNzdQUGZEU3BQVC9vY1NvM01KclhZWG5QQzhvZUxXVGJCaExH?=
 =?utf-8?B?ZTY4RWxGMmszK1Jia09nYlpDdEVRSXI1dHdRUkwrMnFsK0Z5aTBiOFd1V3A3?=
 =?utf-8?B?cUlwQ1BjZ2xUQ0pmWlBnQmcvZnlMZmkzRzBQL1p4ZlNJZVlpczRMM3BWNGxJ?=
 =?utf-8?B?cUMwVXVZY0hycCswREpLT01VSFoyRDIxMXpLdThVM2lHVnArUkRmZDVUT3V1?=
 =?utf-8?B?ZVpvZElKN0h2T21hN0N4b2RCVnY5TmRnVHRiVzJmejI4cURCYjY1dzZPRVI0?=
 =?utf-8?B?OHlKUzNLT0hNMXZkQzFZekFrS2tNK2FZdDJlTko5Q3JXTlo2MmxMbzRvWUw4?=
 =?utf-8?B?MEZtUDNnNTRUYk15R0NTTjUwakgzVzQzS2VwOEJraGh3R0wwcHA5VXByN3o3?=
 =?utf-8?B?RlgzMHp1Y09aV2JQVXFFcFlSWmlVOCtsQkw1Y2t3WG16UFJFdytOaUdIRlhy?=
 =?utf-8?B?WnN1STNseG9YdldxYmx5czBsNzVWdkVlU09JS1N1NmZVTlpqdURaNmdKY1do?=
 =?utf-8?B?WDI5MnFIQUVQNG1yY2VJWittL1UyMzlTNmxVSHh0QVNxVmNyRXpYUUs3eldm?=
 =?utf-8?B?RG5CY3ErSnZxQncxQmhxdG5DdmtQMFdyOW8zTnpUQnRLcDNCemNmQmFtSjFo?=
 =?utf-8?B?bHRwUVEzYzJFUlNYSGU2Tys5VTc0bXd3eHoxeVFoRVl1VjRiQjFWOStkYmtR?=
 =?utf-8?B?ZXBMMzN4ZFlpbG0zZTFHdW1DTHBXdzVDaDdwMUZYZ2RwNDVER0RYUzBsdWZG?=
 =?utf-8?B?blJMUkpVdHdGMmN6bGpxMXQ2ZndFZytjdlpwUTN0YVNRVnNwSExXaUtGNll3?=
 =?utf-8?B?QXpkWExmM09vZjc0VyszMmVDSFBiaFk2L2loMUlqUFFFZG9wU2wxVkxIeG1h?=
 =?utf-8?B?K2hKcCtQbU9HMzMrSTV4QitqdzdTZHM0dG53THFUS2RvdEEyek9MbEViWEhZ?=
 =?utf-8?B?N3N4Z2JMNXVOWnVmVXFqRG53cGc5Y1krUDh0Q0RPeURvdjJTd2JwVjFhYnpZ?=
 =?utf-8?B?RTFvMjhhSkVGOE5aZlk0aDQzcWFYanVHYUVkZEFGaE5LbzJiWGNJSVprVGRi?=
 =?utf-8?B?SHJPOGk4WlVBek5ZSGlQWHI4RHlNMzBtYVRlc3lWY1R2blgyejJTdTVYczNv?=
 =?utf-8?B?cy9ieWVDSm1zNFJxYUV1TEZQWUJycmZrTnN6NVBlMHBoYW9wSW9jR0VWOThC?=
 =?utf-8?B?bUhTbUU4aG9tZzVqeHlEQjFiRUFxMkRUeXRvc0FWZ2Y3MFJaWitDS0UrSkU0?=
 =?utf-8?B?bHZHaXY2QjFBUVd3TG12OUtnWlJ3WklLcjh5SGNHWnUzZG4xNHpEWjYvd21J?=
 =?utf-8?B?SHprYXh1ZC9nS3FtK0h6RndXUjNiK1dQaHR0VGRldGUvUTdSVWtkMUlsSGdN?=
 =?utf-8?B?UnY0VnEyc3psc2JzZnI4ek1NUTM2MjNOVm11TFBmbm40c21vRDE3M0ZkV1ox?=
 =?utf-8?B?ZnFINFpNOXBTNCtqUW5OSHFNVkkzRGs0cjd4K2puY3hDSER2Njdya2Y1MEN0?=
 =?utf-8?B?aGVsUmlBakpqZGRsL3lSU05SUWQxN0Fuc3FBUitJY0NyNThsS2NGMGIzWjMv?=
 =?utf-8?B?NmhGWTdWRUNkWE92dURFY3EzZXFUQzVMYm5hWUxSWm50djhKN1IvT2xRN09m?=
 =?utf-8?B?UkoreHg3YTBIUmZmdUgxazNiZ3AxK2ViNzZxM2gvTkI3dk83aWZFYzJ5OG1h?=
 =?utf-8?B?bTZVZTUweGZjakFNNktwREQzSnpVaUxZZ01NdXN5RDVlYWh3aldzVDZwWVlI?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8945ef19-7d4d-43fd-90f4-08dd97666ac5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 06:20:29.1635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQgdrM4ZedjCt6IzxnaUegQvBTOZTMMNUuupBHrGolHpvYXCVCVjz2V7HVFW4jaXpTp42YQE/oA2Na9BiKHjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
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


On 20-05-2025 11:21, Gagandeep Singh wrote:
> This patch adds NULL algo capabilities.
Do you also need to update documentation for the same?
>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>   drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h | 41 +++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
> index 1c0bc3d6de..e9b601c035 100644
> --- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
> +++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
> @@ -227,6 +227,27 @@ typedef struct dpaa2_sec_session_entry {
>   
>   static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
>   	/* Symmetric capabilities */
> +	{	/* NULL (AUTH) */
> +		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
> +		{.sym = {
> +			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
> +			{.auth = {
> +				.algo = RTE_CRYPTO_AUTH_NULL,
> +				.block_size = 1,
> +				.key_size = {
> +					.min = 0,
> +					.max = 0,
> +					.increment = 0
> +				},
> +				.digest_size = {
> +					.min = 0,
> +					.max = 0,
> +					.increment = 0
> +				},
> +				.iv_size = { 0 }
> +			}, },
> +		}, },
> +	},
>   	{	/* MD5 */
>   		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
>   		{.sym = {
> @@ -553,6 +574,26 @@ static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
>   			}, }
>   		}, }
>   	},
> +	{	/* NULL (CIPHER) */
> +		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
> +		{.sym = {
> +			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
> +			{.cipher = {
> +				.algo = RTE_CRYPTO_CIPHER_NULL,
> +				.block_size = 1,
> +				.key_size = {
> +					.min = 0,
> +					.max = 0,
> +					.increment = 0
> +				},
> +				.iv_size = {
> +					.min = 0,
> +					.max = 0,
> +					.increment = 0
> +				}
> +			}, },
> +		}, }
> +	},
>   	{	/* AES CBC */
>   		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
>   		{.sym = {
