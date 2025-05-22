Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9137C54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 07:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 507F8402B9;
	Thu, 22 May 2025 09:43:00 +0200 (CEST)
Received: from HK3PR03CU002.outbound.protection.outlook.com
 (mail-eastasiaazon11021131.outbound.protection.outlook.com [52.101.129.131])
 by mails.dpdk.org (Postfix) with ESMTP id E6D2A40144;
 Thu, 22 May 2025 09:42:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVd9e+INMdtucby9/GE8lqQAtQpkY8tbc4fNWYun+wARKC65dLq5UUuGOVTBxe3qHDOp9AwTio3IsWGx5NGEiGer7B3mXDCw7BLq7lvmcu2pTRyVC9VZCn9goG46leMbWJKudBGhsfsEp9LaByryQW6Qg9pPS1IZT3K/ev4QG01P3awfp5ZXV/6Q6D/soKpHjK+TPaaxa6o0KkypPcfxo8ZyyW6HfIEFLBQ3wkop/4isYrXNaSFTkHUQOebbVVxj4dY7wYfWA7zExQWgVtY9vdXD+mo9PAVoh3ceWvbi7PugokSbRI80fh7p8o10JFMn8BZWNKEwolxWHm5H1uaofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxfQqOnpP93qrkLnY4Vqh7quSdlddcp/H5+FBDd/zGg=;
 b=ZkxNzcpQvcbBJvvtc2BZTicHL/4IVrNb5ww/0bH4PbTZeqb0U4DACdpFnQK9RJwLbV8znNdhcAG367YgdkMH3XgHhDRZEb27uX9BVhr4Buldq+QHomWoQD6YsqQhCKw9QvFf2t4NooEzb6L4kagOVdr95HF9n1o4bI4af6yPMMDunEdyILF//2sw+SxdJlNn6O2WT7y0Fk2chLfiVFZS2IvS83K3ojiFMVuQnTtRC1SZn5vlOLB0sxhFE2sIFSF6l1xYoUFPJvv88etTs39PpPhKT6DKRn26k3pIyGybkc02Rv04QBQdS39sgFfOwwHtqK1/KUN9dpbEhRJmcoPpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxfQqOnpP93qrkLnY4Vqh7quSdlddcp/H5+FBDd/zGg=;
 b=VP/bIE7Z1Stwmw3pCQ3mj64l2AdD7hUWmHuSBrj6cLyP3mV5Ubj3ssb1grdxdAHn+s28LPawCqVumW2S6cYAcwrks2dneUcw/ceVZ9wLWgQ/fXfFGF70EhsTND4FIq1bzNakoykU2ZeJIiFbTWYeF1JKh9ctIIsvYuZFK37wlSx2ulv8onACbuldVdH6Ulf5y0qwv/A8a3xFgAdm8NrReS9eWLBtLy+eOWXkbW0bxHvPycA5awX7J2s7C+Kat9P4lUSdf3MKaGhqs24o4NW5TL0xUg0nUOzE5TbDLeYi4Gk5cwEKepaPIKPdLhx4TwiqdLh7rbapAtK6cecFvfv3Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KL1PR06MB6819.apcprd06.prod.outlook.com
 (2603:1096:820:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 07:42:54 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 07:42:54 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3] ethdev: fix the bug where the flag variables are assigned
Date: Thu, 22 May 2025 15:42:42 +0800
Message-Id: <20250522074242.30376-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|KL1PR06MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ac6845-a65e-45ca-1166-08dd99044300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3drUmVSK3hOOCsxaU11QWswWWErV1M3SkpocnlFanRSMlNmQmN5Zm84Y3pH?=
 =?utf-8?B?L0FveTNSN0hwSEh5WFFSaDMyWVNKK0R3SFBlSzFSZTVjRVRIcllQWWxQQ1dV?=
 =?utf-8?B?em9HZFE2VkFFT3VHbzU5NnI0T0l2S083Z09WVlErZWxsaXJZZEd6alVoSThx?=
 =?utf-8?B?bE9lTlpvY1RDNVJZTnRBcHpEYnNNZTZyaDBvSFNDelVickF0ZDhSYmJOSnd1?=
 =?utf-8?B?Zi9vYWhlMlpsZ3hObEI3Q2RWbFdML2hrYTZhTmlrTlJ5TFlGWThrclNSMjA5?=
 =?utf-8?B?eXp5SXgvZ2JBeXdGTmVvWGZock5Jczg2YVAyUWNKOEVpbE00c2NKZkhzOGVK?=
 =?utf-8?B?cVJSUXYwUzQwUCtkODJkbzZtZlZoeGV6bmU2bDI1L3l5cmQzcDF1TEdwUGpU?=
 =?utf-8?B?SnJXMjR0QktIdzV2Mkl3RENpbGl4YVExUUs3RW83bE1ZWU5nVjhHU0xzc3p1?=
 =?utf-8?B?TlJpTk9xQ0lQd25HNVZQSTRtNldHYzhlcHBUcExmdUV0d0xySWZSWXY5U2E1?=
 =?utf-8?B?TmgraDlyaVIraVZTOVFVWXNFbko1aEpiNTR6bnpmaENiZXNHWnQ1SC9pTHZo?=
 =?utf-8?B?aDlpVTZTWGp2dGFqUXZzcUN1bHl5dWpTZHFpRUdJM2l3bkpiZWRPM0dvNzF1?=
 =?utf-8?B?Tmd4OXFWUEpLRzRsdzhSckxvSHZnakcwR09QZWxDTDIxSXIwRThKNWdveUpB?=
 =?utf-8?B?TlI5OFB2dFdzaC9VRjJPbFI5WXVvNWNhMURhalVVY2ZoWitMYzdFbXdpUGpr?=
 =?utf-8?B?ZUNmMkVMcThsS1F2K0FURmRFZEw2OHBGUmZxNGh2cVhnbDh1a2QvZVp5c2cw?=
 =?utf-8?B?Tmk5TWJqUzE0NW1OV3JsMFpQcUdOMG03V3h1TTZuMFFndE95NmpWNkJoQ2dK?=
 =?utf-8?B?REdkNjEvNGNUaUQ0U1phZVRORkpMdUduUHpZUHRKOVA3Yisvb2FFNkIyWG1G?=
 =?utf-8?B?Zzd0aFdVWkQ5ZS9YeDdMdlFvL2ZBVXBPa0wzSldTRXlqSVlXU3RBQXVnOUJq?=
 =?utf-8?B?SzRIaUpNbytxbjI2L0xtQzYwWXJSU1g0YjNkWWRkSDRqOFhFcDVhWklmelI0?=
 =?utf-8?B?NGRFYTlaQy9BNjZ0MWRpRkdKaWpvL0dybkQ1NWxISVIrYnlrSkFLdFpMMWJN?=
 =?utf-8?B?c1dGYThEVGw5NTRpSmIxOU4vSmtDdy8yQkdzb0ZrNFkyMFNLQ293MTNyRXMw?=
 =?utf-8?B?UDBQbGwyR25CVWVKNFl3VEtJSURVVWF6L0JodFlSd3FMbkFwNUZ6cFM1S2Yv?=
 =?utf-8?B?bnNwT1FBSjdWa1BkaGxuSWhjeFZFZWlKeXhLQWJLWHpBMDRPNlVOVFlvS3ov?=
 =?utf-8?B?eXVYUGMwR3FkTm9ZcE5kekhJVnd4QlNnd1V1RnNONWdFVnc0S1Y2R3RzZEFz?=
 =?utf-8?B?VFpOd3F6a3ltak1Tck41OEVFMzRvQjRhMVp2YjNRL1hLNkhUV2R0NzRKNjd3?=
 =?utf-8?B?S0s2SUtNTENHTE9YY1JOcG5ETnIraEg3K0tkV2dRVGEyeWxyZVdNWDRXSGxU?=
 =?utf-8?B?S1B2K2ZPOW9mYTNBRU13OFpiMWtBbG90RG1BdmRBbzk3MklPRnJDOThhM082?=
 =?utf-8?B?RlpHVjE1UGZaMHZrbjQ4azdSU2Rac01BKzE3eDV2Qng5SkJOQjc4R2RCLzBh?=
 =?utf-8?B?UGRwcDl1SUYvVDZMRzBYNEtjN1NzUDdQdzVrRTh2SDhRdE04UUJpcHdDL0k0?=
 =?utf-8?B?Ykh5MGhtZzBZc2x6Z2pjREdSeS9iYkhJK3pXVjhGdDJJM0w2VXBJVzJhVmhY?=
 =?utf-8?B?L2YwRmh6bk5kSTIvT3NLRGE4MlBjRUtONTZibysybEVnNWVTcUp2RmVpNFJP?=
 =?utf-8?B?VUVSWHBva1haTlZvTGVRK1ZBcStrMUM0RGNMeGtMMWVKV3lTNXJaaXNmQjdG?=
 =?utf-8?B?Q1N3QklXTEg1U2RiMGo3ZzAwU050UlBka29zVTZMUU9adGxvb1BwQ1IweEd3?=
 =?utf-8?B?NUtBOS9HRkF5dHRVRkp6ckgwSjVNanhwTnRRUEEvUTJENDFVY2ZobmtvQkxQ?=
 =?utf-8?B?VHNFanRidnFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURtYzBadkxESTlTMXVPYlZGSXlYcHZ2OTlXUnpnT21uSHdTcVp0VkViMkYr?=
 =?utf-8?B?V3QwenVkTlRSTGR2Si84ZWRxb2ltK1dHUEZHNG40aXpHZzQyV0JmbnFSSjU1?=
 =?utf-8?B?N0RUS2ZFbHA2Tks5NDEwaXdHTmc2MkdaWVU4akVqRlJDMEZhQXhodCsvbDZU?=
 =?utf-8?B?bHlSWGQvWmpiclBRZjlCNUNCbWtwN2tIcW8reWpadVZObVhEaGV5ZWlER2FF?=
 =?utf-8?B?Y21FRlAwQk52ODB1N01sa2JVdS9QYllXQmE2b0hXM0o5b0Yycmpvb0JBcnR5?=
 =?utf-8?B?MjVsbEdzNWYrL2dJUGdhdENweURMU2hSdno1b0Q3MHdlOHBDSFdnK0p3eHBy?=
 =?utf-8?B?MGpxa3U4bXpLN3lOR1lXQ2JlUkVLWXNWaGFhVHl6Sm9hbnBuZUFwbkJYRGxD?=
 =?utf-8?B?dUpPRGsyNndCV3BPZVdMSkN3SUVWNjNGVWJ3c1lLWnhISldpakZZNkRDalZD?=
 =?utf-8?B?MDZCdWNXUXp2aFZTUWxHNkxXR1J4WU9mRFJyZ1p2UGovQVFVVHA3ZGtlZEQy?=
 =?utf-8?B?SDhQUGsrSGNCa2paa2FpbzQwNzJ1Z0w5aVlZeDNxMHZpdmpQUTBxQ01kaWxr?=
 =?utf-8?B?c2NnWVlHSzV4L2pWbTZENzVmdGpVY1BzSmdWWUdrcWw3UkxyZ1NCanUxc1Fr?=
 =?utf-8?B?MTlJOTRuWUxBZFlyL3VyaHJIWVZ4TDZjOFBaNXVjd0VEL3BTUVdxUEVHaW9q?=
 =?utf-8?B?ZnBUcW14TTF5dGd6aUErSXQvajdWeEU3V1BxZkJraTFUZXhaSkhiVC80cHgv?=
 =?utf-8?B?RlhUb0Y4WUllZ3lzOGdoSHBUVkJ2WDhwUHA4bnBRKytiWGU5Tm5IMElRSm1y?=
 =?utf-8?B?Q1Y2eVpsWEZwdkxpNG1rWDYzMVV1eTZ6RFYrMkxYbVlBMU5MQmJaVmdJSDZ5?=
 =?utf-8?B?MzBxa2lLMzNzYVlHY3cxNHJiMnEyNUtscGMwZUlkSzFXckdBcVM3VlFQdE96?=
 =?utf-8?B?TUhZb0dJQU44RmNMamVMSW8yUmtoa2d5RkF2K3pHdWxiZWk4TWdDTDV3SEF5?=
 =?utf-8?B?YUk1Zlp6NEo4eU5iWS9wMlF3d2lKL1ZtWi9qUlhnK0F5b2YyWTR2QTZLRk1h?=
 =?utf-8?B?SEZ6aTN4eWhtU1VVcjN4eHpjdmhLN0psRnZWNStrYmVuMFIxbEJUUGtUQ2do?=
 =?utf-8?B?ZWd6Q2Y2RzNkaHRkbTBXRU9xVUVMc1lZQ1VMU1c0QzJVV3NxV0QyWWs3Q0tl?=
 =?utf-8?B?N2x5N2R0cnkvYlRKQm94WGxDclROckE0T2UvRXZ0ZFFRaUNvanZSMHlSdVU4?=
 =?utf-8?B?ZzhLem9sTXlLZUNhOFQxSHBrRFliWnBnOVRpaGVKN0djM3ZnQ2FCZk43Zllv?=
 =?utf-8?B?L1krTlFTenFKYXdySnJ5bnZUR1lSZUVMV3RFUlNuekxJLzNRTW54cFJET1Ja?=
 =?utf-8?B?UDcrMHp5QWtzcXdxY25TWnBWN3lyMzFGZkVMMnVjKzF5QlZFZm96MGdzSmJZ?=
 =?utf-8?B?QWdsdTBYemhFb1FTSHcybGxEK2h6YUhQVlRLNUhia2d5MWFiSERxOC9DMzJY?=
 =?utf-8?B?UkcwSCtvK00yayttT1ZJaWpTSnM4RUpDOXhqbWFtdDJDVGpKdUVzaXB0V1E4?=
 =?utf-8?B?dzlsLzNmUUFvcHgwZ1NyMkJ2MTJLTDhWWm9kQndMaHl3a3VXeE8ybHg2V0VL?=
 =?utf-8?B?NFljY29oaFRnYmhUZWdBT0hCUVdpUytPeUVwK3ZabFE0L3FIQytsc3lFTlh1?=
 =?utf-8?B?S2kzNVFLMHkweWs5MHJPZVRGS3hOSTJIUHNuS2lNOGF0SFBmdWszbmI2a0tz?=
 =?utf-8?B?YThRUnV1ZEhpVWw0eTBFeEd2OGFCMklaeUcwdnR6QURkREVkNUNEN0FZbWJj?=
 =?utf-8?B?MTFjMkh1YXg0UTA4TGd0elpXVTk2cFE3WGY2eCt4ZzA1cnlQbzVHdFArVU1Z?=
 =?utf-8?B?VXJxbGJVdi9qNzVEVFIyZjRJbjZySGE4YTZJb010UjluM3hmdGpydFZsUjR1?=
 =?utf-8?B?aU9aWnZIOFlEM0h1ZXViRXExRnRudlNrRWloSUl6MFhkQTc3RERlbnMyY1cr?=
 =?utf-8?B?UlNHR1JnVWpqRVF6YmxkYkRLWDlPbytFRE9CblZkTXQ0aG56Zk1uUGdkWUc4?=
 =?utf-8?B?eW9YL292QVU4RFMvNUNCWkMyYXpPK1BwUmZuUnFOeVVNaVQ1L1VPckVQbU1x?=
 =?utf-8?B?SG0za04veWh4cDJ4aHRwRWsrRHhtVERob010UFNYbjRzZDdsMm5oMERQYXVP?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac6845-a65e-45ca-1166-08dd99044300
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:42:54.2225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lViJvyJGqvvPswOtsZ5JZBb119SACP9tizA7gE2HBgkiK/Emu3Kb8AgJ9IoF+C688uGaj7XjRFvAbAFadEOYqGWRkeYat1AJvxyRDwllI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6819
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

Set the values of the promiscuous and all_multicast variables
according to the return value.

Fixes: af75078fece3 ("first public release")
Fixes: de5ccf0775ae ("ethdev: do nothing if all-multicast mode is
applied again")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..c27d3e5041 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3044,10 +3044,9 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	if (dev->dev_ops->promiscuous_disable == NULL)
 		return -ENOTSUP;
 
-	dev->data->promiscuous = 0;
 	diag = dev->dev_ops->promiscuous_disable(dev);
-	if (diag != 0)
-		dev->data->promiscuous = 1;
+	if (!diag)
+		dev->data->promiscuous = 0;
 
 	diag = eth_err(port_id, diag);
 
@@ -3112,10 +3111,10 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 
 	if (dev->dev_ops->allmulticast_disable == NULL)
 		return -ENOTSUP;
-	dev->data->all_multicast = 0;
+
 	diag = dev->dev_ops->allmulticast_disable(dev);
-	if (diag != 0)
-		dev->data->all_multicast = 1;
+	if (!diag)
+		dev->data->all_multicast = 0;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

