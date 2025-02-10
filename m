Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDAFC021A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A4E540268;
	Mon, 10 Feb 2025 11:38:46 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
 by mails.dpdk.org (Postfix) with ESMTP id 0631D40150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:38:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRsHeLzfLpOgaROPdx3C6prcojk+zm/U6mmD+fZYbypbtMagg8KCXwPyL41QegjJvw5ISFy64Nc4QLSWF3AKSyF7RD3I/bhce9bdI3uiu8yq97UExM0ZhUEEMt4R5Az/0nHT6f25Yj6nuWaABXktd6nCI9H5Ufhrunytwz+/0XnPkGDBiyaTb/eckTmtIY363bOK9vkwCRgLEGBToSS0EPQk0YUHsJAWUyJYKWd9g34JWlmOXXYHi166uYkrukZ7rUCtWRRf9/o33U7aL6c1liyPkYItAUEw11uHjoqn7pdcVo8+Mo5PjyfmK6tWh6S8cZ784I7zdkGTnmKpsnWOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW0UBC4+N773YgZfifMz1NK14e5fQrhTwRNprF0ERFU=;
 b=eqoa6tsI/z+A+eva3bbdFpe2xhmcGsbNzI6s8CtvZHlHGACCAXSV7MAYkglfBbfsWfvPDiA0QLVvQiIPMhZxNSnxsrN7wLTu/kDFGW5kobe0Fp39hRe5o+l3Z294s66Dt6nuyiWQ42juqeUQnSCdM5vtJVVYvsLvUuKH9U+wWTQ2vthS+SSr9DxsndfqN3h9vQOe0rV6h7h2TaYYMDl2f53ELtKWIdn5eUvz5W4UtxEtOsuo8wUSM7DZaQJthYsjhDgB/tgPvB5HO3APLL8UrWE5MSn5va/wOeykUBK8dYcPJA1yLBqyv/7dN5jte/BLAHqH0jTJgS5K1l4P/zVKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW0UBC4+N773YgZfifMz1NK14e5fQrhTwRNprF0ERFU=;
 b=LfYIvOs2SKewNTz0XW23bmOsW41yTMoxU6oOqCc91DGvtmQtkl0Edc49GI7zHMtr37i8/uWp2qKMwxhAVF7JVR45ZB9o3F5BHhy0bH+sleWJAcYOQcHr2U4YX/17cWgQeU8ioNxEp8wDPYU8qn1UiMYE8RCjPlFiDNru7LGEB996l7MlvzM7UlZSP0Ndf1b8gFWeeUMcrH3Ucc6ks1nelLHo5+N2cGEaNf7YsVK6fidfKy3Gw+lP50ScUxt99PguESN/rCAvmuyRsnjnagL+GL59gD+WITZv2M1oJQLq5FMgmMsVj9zoVwH8L8H+os7891HnDZM5nj/tsOxFZzi1Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB9PR04MB8330.eurprd04.prod.outlook.com (2603:10a6:10:241::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 10:38:43 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:38:42 +0000
Message-ID: <9e1a3a29-b84f-3bc0-a416-d13140e20f88@oss.nxp.com>
Date: Mon, 10 Feb 2025 16:08:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 04/32] crypto/dpaa_sec: replace memcpy with assignment
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-5-stephen@networkplumber.org>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250208203142.242284-5-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB9PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: b107e1b2-0646-4c7c-abbb-08dd49bf16a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXpxdEo0OTYvb0xGaEM3cDFDT0Ixd1FXS2VhQjllVkhrOVhXbkpST3FyWTN2?=
 =?utf-8?B?Q0pROWZ4WEpnQWZCZ1BVenRkWTNmOTVPR204alBmSnNaMFd0VHNBd2JIVmMz?=
 =?utf-8?B?R1pNbUUveWlrVm53aHA0V1NsTVhmMWd1UHBLa25pejhaTGxqeTJzZnBrRVF5?=
 =?utf-8?B?ZkVkZ0EzTXdJc3ZJQWtocGRoU29KaWdKeXJXeXdqVmdZM1hOMklNWDJ2Z1I0?=
 =?utf-8?B?RFBKSFFnWUlWMHBQdVhVbkVOdVpCbWhOQUNndGxUZStsRUxYRnV1ZG9DVVdT?=
 =?utf-8?B?SXBQUWRXS2kxY0h4K3RqTEVMYzBrbXp2VGhjNnVWbmJpMUlQcGR2MjB1YUYy?=
 =?utf-8?B?S1BtR210R1ArM25wQWlIZFk0RTVUdzY1cm1NZGE1T0R0dW9DRTlmLzVqbE5U?=
 =?utf-8?B?TmhxUHdrVUR1UnBMaHJIa3Nha3VoL2YwVXA2REFONFBSVlY5NjU4aFEzNGwy?=
 =?utf-8?B?K25CWW9FbXJyV3VOaWkvWUVEK0NLOHJNSUt5YjgzSGRlWUoxK0J2K3B4YkV0?=
 =?utf-8?B?OVQxTGtiTVcrTFZndVVmQ2ZHZUYzVXEwRkFvbVlKNmlZNzZKQ0lpZHNnbXlp?=
 =?utf-8?B?bDY3cUdteVNNczBXcWRFMGEyeERNRTkxdE9FZXMzaWZGVUhWU2huUjBBbFJw?=
 =?utf-8?B?cHpsMG1tYnZSS0JaMldPaHJaQnh3WWRUSWFaVTZPL0gwclIvYjI5djJHd093?=
 =?utf-8?B?NWh1d2JGTlhSY2l6UHBVcThicFlhV251SjNHWktmOVU4YUFFdUpIOFF0eEVz?=
 =?utf-8?B?ZExZKy9tZmpTR29tekZKRVlDMVJQcGpEZWJiQTQ1Q3J6OUJadVZzUEF2RUlz?=
 =?utf-8?B?R2xrOHZxUW9EVC8rQUhrSDUyazFHUDhEaFV2VEZRa3JXbVo3ckkvVkM2VnU0?=
 =?utf-8?B?YzliUUloMzUySDd5RWZ3RXUzazc2VWJrSm55MUJZYVlKQ3UxVXFCcjByZzhz?=
 =?utf-8?B?dXI5R2I0WVVadlNBVzhQN3FESWpCUUNJbU9JaFM2YnR2UFpXcWZDMTd4SUtk?=
 =?utf-8?B?bVhOaUU5UHdrWlpZSldrQlI5VC8yL0lPQ3ZQVmZ2d2JJVWp3NDJaa21mamJ6?=
 =?utf-8?B?SjZac1AvckcxV3dxejIvM3BKcVZWSFp6M085REN0WkRtMlBmRG5vK2FvRGQ4?=
 =?utf-8?B?ZUd4bVA5OHB3SmZGVUZlUFBIOEhuNkwyZnFqNzgwT0Npckl2a1lMVG5OK3Jj?=
 =?utf-8?B?OVhkdFlIRE82Rzg0eVRKSnVzRUlaMnMyV0NIZ0pXeHd4ZmV5bXhacUJHSnZr?=
 =?utf-8?B?QjJGbGljOXVuM1F6a25wcmoyKzVoRytob25xWkhEOVdkcEV3VnR4dmpVVjlQ?=
 =?utf-8?B?VVVBeWIrNjY2aEduOHZ4WDlXc3N5Q3BKK1NFS1RCck9pVW5vSC9KQXA2MlJk?=
 =?utf-8?B?Q053RzdMaVNIdytZM0ZtVkIzYUpZV1ZSYUY4Sk5YcHFvc3F5VUpYNFBBTkdx?=
 =?utf-8?B?WHkxMVlENXFvR0RpZitoN0FLV1FWZDM2b2tKQXZHdTBYVnFWeUp6Z1RDdHdU?=
 =?utf-8?B?VXZpRTl0Qk1Ua3lDZWV0THVqTGNLaWJzckdaUXpvcFRURWYycVBPVHE5Z0lQ?=
 =?utf-8?B?OUFpYmlDSlgvNmV6TGxRcjE4ajF3UlBtellYbmlMOGFtQXVjTXhpWWE2SURF?=
 =?utf-8?B?aDB3VU84OVdRL0lWZSs2cklHQ0xiRnEyQVE0WHZlVy8zdGdEQ0Z3QzdWdVJr?=
 =?utf-8?B?ZjIrRThhY3BZSS9TNU11UVR0bjhITy85T0tWSk5QWmN6Q1BLNlRDZnBySXJq?=
 =?utf-8?B?VExhZFN5YWdZekpPL2FIVlU5Z2Z6TitCSzRDR1YyS0xBM0wyS0lRMDl4UGYw?=
 =?utf-8?B?cjc5cHYvMlFHdjFqTG40VjhCa2d5TDduUjk2YU4vUkU2L1I3SnNwK2QrUDNO?=
 =?utf-8?Q?Z1HLF8qx2TOv0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpGVWo0TFRZNitFbVlNazh6UDBWSWtwTDdBNmE3VFVXQllpekg3VXNoSnJ5?=
 =?utf-8?B?cUhHMTJhYnhiS21WaGNWYUxPRjkza24wbGpnbGR2bjZoNERmaEFsNzZPTDRH?=
 =?utf-8?B?bHI4K2lpTW1NNjB1VThoa0RidytPZTNOK1NKYktOMlhRVlhmSHVWTURTdG56?=
 =?utf-8?B?NzBKZGN5VFlmL1I3NStQMkRiNTU2ZGhPTlN1UHI5aEZMREJJSTVEdmkwK2Ni?=
 =?utf-8?B?L0tsOGxYQVJPMzlEVVdzQTUxQzFORmx2dDdxbnBzbTYvOHlYZlZIMFgrTGU5?=
 =?utf-8?B?WHJpb2tuMFpueXgwQ3loZlFhT1JGNFczUG0rZHR4ZHlBSEcvMVQ3eHVMTUc0?=
 =?utf-8?B?VXZNNFBLSWRRUzVJTzg0YlNQY3p4RE1ITVRvbHBNSGFtTUgxTlFWU1QxUnhh?=
 =?utf-8?B?aE1tOXVpamRGY1BJeW5WVHhISWRhOFFSaTdUV2lGbTFOT2ZhZWxCT0duSDhO?=
 =?utf-8?B?aUYyaUV2ZnVaZTJGUjVpdlJOb2JHTHFhdmdlRWtyQ1luTFRRVmtLaU5XRTV6?=
 =?utf-8?B?bkNKWitFeG9RNzFMMlVCdkFyTERraERGQ1FlQ0I5Tkl1L0VrNlYyVXVqSld1?=
 =?utf-8?B?TEdGQUUxRjh0NmM5aGFMc2JTaXRZTVJIcHE3QVRGTEhuYTFkcVhZVVRkQ25v?=
 =?utf-8?B?SVY5dWNqZEFHa3dqK0cvZVBhSVVheHBxd3JTNU52YWJPbGh3R214RUtEWVdW?=
 =?utf-8?B?QXl2a3lZUlJoWEtBbU9lVHUzYjk1akpGZ09rK3N5NDAzZXh2d2U0UXdHYnh4?=
 =?utf-8?B?ZGFTengvdzlZUWZxTEdjeGhWVm54WUVZcE1RRGJId2FrcVFkUmdZMndMc2U4?=
 =?utf-8?B?Uy83eUlCV291MWdiTlN0TWJGOFpsL0pUK3RmOVlLVDZUd2FpclQ2akorZktM?=
 =?utf-8?B?T09sZW5xNUpVcktzaGphMVJWcC9BeFFWQUFLRG45NHZnUkVUNnZnTzZFOE9R?=
 =?utf-8?B?Um9kWitvYVBlUk8wVWhRU1V4OEZ3Wkg5Rk5ZWVEzb2c0VmtsaUUrTmszSjNa?=
 =?utf-8?B?RUR2dlcrcTZqMTFGSldqbC9weEUzTzYzOVBaMXFQa3hsOGNkUG1SaExNTCtm?=
 =?utf-8?B?NjVCOUZXdnlJMWQ2Zk5qdXVrOWZZUThMRVdGRDlTcDR2SENSbFVJdjZBYlFK?=
 =?utf-8?B?bzYrYXZyTUd4OVBZQWcvL3ZmQnVlOFM4VnNxdGdvQjQzeERRY1YySm5zemFZ?=
 =?utf-8?B?MlgwcHR2OXd4aEhtZmd5a2szOEpvWFBucktiZVFBV0p4OE13RFJhTk1XWmpW?=
 =?utf-8?B?RXRBOWxoUml2R2F4N0kxN3IvWkIrZWI2Nm9wOVg4VmR3VzE4c0pTM1VnRHVn?=
 =?utf-8?B?SVEvdmU5d293NUFUVnBYVEVPTWlseUdxYVMrQVZXSlhVTFMyVmtSNmNUK3Q1?=
 =?utf-8?B?YmNITExiNENoa3g0V1Fybyt3QXUzM1Zld3JmeDRHYlR6a004cVJQSzdqV21k?=
 =?utf-8?B?OGZZdTRYN01MeVVXQUVvNkFkTW9vNVZHSDFxendaaFlCQWRYdTVWSGhHbFhz?=
 =?utf-8?B?ZFB3UjAyM0JQQ2ZWK2NSVi9tY28vb0hoQ0pNSm9mcEhsaUlyeVZBMXJjWWov?=
 =?utf-8?B?dVFaeFBYL0pCY2FwcEc3c2RNVGZTcytoYkFXajhpUU1JUCtpbTFHTHEvU0lj?=
 =?utf-8?B?Q3hzZXdrUGZtWkZKK0pRRGt6a3lVcWY3eWJhMkxiZTUxQ3dKaHc4dUFUY0dX?=
 =?utf-8?B?b1piQVJDbmFUVjd0UUtVekJIMzBxNXJBcFRVdTJiYks5ZEtjbXJLbUUvVktQ?=
 =?utf-8?B?Vll1ZGh4TzNDbDNyY2dFa3lxZEgwSThmb0xtanNCODAzbXdWa1psYVpTWjJ2?=
 =?utf-8?B?QmpxKzN6VWhtaWZVR2wzVmJsc0Y5Zmx0YkdpbHNQZGtzbzZrcGVjcmNBR2Ny?=
 =?utf-8?B?UEpQeWtYcldsZGMrYVM1aVoxU3Rvcmc0OHZTV3J4VE1BRHVBV291Z29UeE5y?=
 =?utf-8?B?RHBTWWxQUG91V2dxOWRiNzU0UE12U25zVWp0QmN5L01Uc3Fld09mYXBhMzg2?=
 =?utf-8?B?TmFkcGo4VlJCdTN5SDRvYi9LdVRSc0FhcWNMSmY0Z0FKUUlubGkwZ3lCR0hw?=
 =?utf-8?B?QVNaRmw2eWVSdWMzR1FGUU5HTHJoNzlKcmNCNzdFQ01BTG90bko5OEtaZlN4?=
 =?utf-8?B?dnVSRmFSNWQySnFQQi9iVnY0VFBNWlJCeWxYME5paThIVDhaSFJmL1VmWGdq?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b107e1b2-0646-4c7c-abbb-08dd49bf16a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:38:42.7803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DahdqhoYlHepSoy1EAgSXQsqlPjIc78tE+Ogh4NZbEZrCvLWTYEYVEGUBsTfjvnhgOmd64Si1Ro2/44VBkaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8330
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


On 09-02-2025 01:51, Stephen Hemminger wrote:
> Prefer structure assignment over memcpy.
> Found by cocci/struct_assign.cocci
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/crypto/dpaa_sec/dpaa_sec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
> index 3fa88ca968..af605d2025 100644
> --- a/drivers/crypto/dpaa_sec/dpaa_sec.c
> +++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
> @@ -680,7 +680,7 @@ dpaa_sec_dump(struct dpaa_sec_op_ctx *ctx, struct dpaa_sec_qp *qp, FILE *f)
>   	}
>   
>   	cdb = &sess->cdb;
> -	rte_memcpy(&c_cdb, cdb, sizeof(struct sec_cdb));
> +	c_cdb = *cdb;
>   #ifdef RTE_LIB_SECURITY
>   	fprintf(f, "\nsession protocol type = %d\n", sess->proto_alg);
>   #endif
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

