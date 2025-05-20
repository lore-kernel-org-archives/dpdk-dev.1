Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694AAC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22D53402CA;
	Tue, 20 May 2025 07:52:03 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
 by mails.dpdk.org (Postfix) with ESMTP id D12B2402AE;
 Tue, 20 May 2025 07:52:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvqGVNgO50acqA1ivRtAu84CJkdDYv4y0VZAKqkQeIiAHn7wruau8S+f2REelX0dzHEouOKCfxE4Io+Kow/pLHiTCA4TJJQKX/d4nXBzaEt2CSSdDQ3r9UK0L8vc6vStM1/Riy6OZfXZvEBeRXkZNiq0djeKr5QtAzDV3Ifs4Mqr0roa7AvpgFSPAbzVB5oX16KRfj+MZtTkNAd25yDZRMLkz/l9+k/NTSUmoSpk63BvR9XyPBVECXW/P1gbYegkXOBF5AfzPYOXq2cx3I8Pf+xvjmp2Jq6rF7NpaKJEHlf2Ua8gXNyZiXwrBaGRkEq37WjfFPPkOxPcveWCF9I9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kR3pMHC3suYWxTjLAjHiC53mU9gPVQTfkler+QvkbY=;
 b=hsbDZSl2Tv5c9G3u4FgwlY3aBKjC3P5RNNV8Hc5oFvK7r88PERGd7ArCq3dZst4sveDzCYR2JBnD8K77VG4lV/Y0WYLzNEBHOXzkJuSyDrtjpntSGvmh9frLqgTc0n+rjpm6VYx5HW5nL2CHlBPKdiAfAtPEj30pavlkCWzvIJRqh1NKi2YCRePBxe0RdahIYtN5AVb/QIhmD7FTciOVkcLLFsc02fR3CB/Heu1GGUNNfOP//i8uZx2gY8VDvT3z2NFtLYx+B2Htesi2rfY1jsM/9/HoyZ9uFOXs5nXjy4d0edn8kvZwGsQKew+M1RNsMpBX89PyzS7To2UuwWtheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kR3pMHC3suYWxTjLAjHiC53mU9gPVQTfkler+QvkbY=;
 b=P2AZ+5YwNuewi6rT1el8cuCnCJY9IbH5iRmqpBTK9XT+u5aU7+2rpyQDSBoC+gmByesC0M23O9/kkXxba8fs3Z98FA9+ypiYLMDTD45+02n85YgiGUxsguOgJjkdYJw5dYhZeIScjB2U83XjRo2blYSNjYM3rPf8ktabuqDTXuk6Pi1ZTvn5JeGNqrIGLtHkKoAKZlTykbaBWO5DNbDLrALhN27UXq8Zp6VSOBIJfevI91bZvtHqXTyUxE71MY3QVNXIZluyemk5s6V6geqvEOlU22HWrEGdNKpt3MjoCF/bjgduwSUdoboKI1roNN0f5vZwsY52G/bw1cFLZQ3hZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:00 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:00 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Franck Lenormand <franck.lenormand@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH 1/9] common/dpaax: fix invalid key command error
Date: Tue, 20 May 2025 11:21:25 +0530
Message-Id: <20250520055133.506071-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fcf1be-e6ff-42de-f5b5-08dd97627021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDRPRlQ2Vzdpbk1BS0g2aExlckdkbkNpTHhKZ3FqWVZVc3NWd1A3enVSSmdw?=
 =?utf-8?B?TTMvQkNZNzJmRXZ1ZmRQdW1HSkhNaVhxOS9DMW5DRjBPVm9Zbzd1YUtsYzZu?=
 =?utf-8?B?b1M0Y29Pd2gwVTRJU2t6eWRFTnZuVWNLem9tRFhOWStUWVEwTEJhc1VZUzUz?=
 =?utf-8?B?cWtmSU1xK3RCMEE4aVlZSXRMMUFPb2YwUlF6eGZJenRuSDVvRGd0ODJTRDlG?=
 =?utf-8?B?Yys5ZExWVkg5ZjIwN0tLR3BBNzdWQ2U5R3BmSnpVeVhiQTluV1ZSNzdPcXVo?=
 =?utf-8?B?dWRxUDlvT1UycmpwNnNhSVFEUUpGQk4xTUtVU1ZqZmt4UHdyeHBqd0NlZ1Rt?=
 =?utf-8?B?SU40NFpNbHJYaTVxbzJ4RU50YndVM3B2bHk2dzhpbmMwVktVclBGZDE4ZDJV?=
 =?utf-8?B?NzZJK2tjRVUzcHVZbW1rRlZnUUYwVEdmcU1EQXpLK2IwMytMWDh5YjlkOHlx?=
 =?utf-8?B?aDZrNWI0RDk3WThsSlBWL205UjZiUklxSy8yYVNqWk9pajZSczNxSGNwK3R3?=
 =?utf-8?B?S2xUWDBtazFTZ0Y0YXVnSXNtemlBQlN4MURLYVRnYUVyZGFhRTVMREJkeUlx?=
 =?utf-8?B?VTE1TzZBQ0J4eDI2OUhnZ3FUdXhuc3hMeFh1REp5YUgzRktxSjdNK1VVMU5j?=
 =?utf-8?B?bVV0Y2h2NE02aXZPbWNoY3JMNE9hZ1FVNENpRGY2RzlnVnd1SkZuUERLL0ll?=
 =?utf-8?B?dWUwVmVUWmQ1QTdSRFhwdzdNRHdsVExWOTdqZDVNNkNKWEordnpubWhpUVNS?=
 =?utf-8?B?b0lEdVdVK0xOVldkaHNQV0t2aFNYVEdVOGZCa3AvMFlqZFI5K1NVcUFzeE9n?=
 =?utf-8?B?aHVBakgxZEhPcFhsVXBjaGJoU3RRdEhVQW1Bd3NIVCt3REhobHdncjdvUFJL?=
 =?utf-8?B?bjFleXRLUFJ4ZzF1N3VWaTYzS2hxa044RUEyUkZMdVdRYlVnRmU1M0I3OXRZ?=
 =?utf-8?B?dW80RkxwY1o1VUpmT1hvTGNWb2RSWEM2QytsSUc3U1dnR1kzT1BKVmtMSGtG?=
 =?utf-8?B?d29xbzZLZXU5NHZxcnU2RmJoNkwxZHF3Y3QydVo4d3lZTzFERVFuWU1NWGN3?=
 =?utf-8?B?YTFCUnVBbFNnYWhxemdPeER0UERrSVZxaHlhT3VDRXZHekkxOU90UUJ2OFZP?=
 =?utf-8?B?Z1hxanlyYjdiY2lzMWFiNzZIRENhYXNoalpUWEV6TDZ3akpONFNpdzk0Wk1B?=
 =?utf-8?B?ZnprcWFEbUhRZkNpQ0NtQm13OEx1NERiQU5iN3dEWFc1ckFLRzNjUGxBYWNa?=
 =?utf-8?B?cWNZTlhzSEpaa002dFJ4SXJDZ3p0YjZqMkd4R2t1dngzRDlnb2tEVlVENTFW?=
 =?utf-8?B?N3hWTkIyd0J4alh2VUhJRVMraEFybUtic0V1bGZkdk5XNDNBZWFqcDJlamNl?=
 =?utf-8?B?RjZIdmpOVDViMTg2MGJsMVB1eWs1QytxVHhEaThGcmpNY0hnYzlYVDRGZTFG?=
 =?utf-8?B?M1VTc29sOXpSMTRBbVNaRitCRW5HdnpRT280R0FKMGtaclJ1dlBOYkgwR3Z2?=
 =?utf-8?B?aXdrOXUvM3ZWczc2bENaQlNzRE9DSFg4VWtpMlUrMjJaTTZVelc2WFJZSWcy?=
 =?utf-8?B?S3QyWHVVYjRZa09oTVZDMDNZYTRhMDM3cDU5UFZWM1ljdVVVQ085UWJYa2ps?=
 =?utf-8?B?Ymt1NHlyNmFmNHNnSCtCQklGWTBtZmkrdGVhZUd4NXlPZnYyZE94aU5KOWts?=
 =?utf-8?B?ODZLdEdqTENZSHpWcGNOVXFJa010RE1tRDlTU3FYT0t4ejJZeHlPeHNQN1Ji?=
 =?utf-8?B?WEtmT0VOeGhNK1k1OXEwS21mZjJZbHdCR0NFaEhOcTJBU1hNKy9tbUNJaFl5?=
 =?utf-8?B?aW9rWlljYkdLRWZoT3hrd2FCeCsrWVRDU3RNdjd2cU52K1dwVmZhSjVqcCtR?=
 =?utf-8?B?VzNYQWNhRmtpS0M0MnRjNUx1RUUwcVhNcTZSZE9mdlVPUTkvR3FKVzZNUmlo?=
 =?utf-8?B?UGNnYloza3N3VjRHUmI4OEw4WWpvdnlqL3FMd3JUZnhjVGpJVUR4VVY5T2VQ?=
 =?utf-8?B?ejRiQ1JXTzBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpCeG1YNnlTTHBVdmRFcWg1bk8yL0xjdmJHeGZ0SFhSa1l0RXVQbUZ0TnEy?=
 =?utf-8?B?L1FWY0hGQ3NEMFByVlNFNVp1bGVDelYzZGVCbHVNSzFMbjRIZ3RmNHJlbHpB?=
 =?utf-8?B?bWk0RDNURUtrUllCOGdqcnIrQmlRZm5BZGIxQlorYVdVTTJuM1FHaUZKZVF1?=
 =?utf-8?B?UHF2TUQwdGc5S3RBT3JFRVFJaXA1VXh0MGdMbDR3WkNhUjRYMVpLSUgxS2dr?=
 =?utf-8?B?UTlYVm5JOWNMRi9oY2hRNVpOZmFnOWNVcVozY3RFN1FTSUthTzhibmpvZ0VJ?=
 =?utf-8?B?bFl3RC8wdnB0ajBlMTNaL3VaWEZLTVhGUzdiM3hsMGNDYUw0dnl2ZFdDME5m?=
 =?utf-8?B?QmJZd1lQdlo3OEZTekd6eTlQWko4eGlyU0Rnc1FEdjZmZ1hiekpZU1pKcDRx?=
 =?utf-8?B?MlNXL1FpdjR3a2p4MTc5WVNRNnN1OEtENjVJQVBQU2VNZmFXWTdIdkg0Um8v?=
 =?utf-8?B?VjRURFlQTC9pbEN0Mk83L3dnNGJockhQQkczUXB3b3dyeWNXVnl4aDFCT3A3?=
 =?utf-8?B?OUtmc2tibmZaV1RXUVA4TTZ1bm05aHU4UEhLZDYxMzdvWGlZT09nVzZUaUxV?=
 =?utf-8?B?R04rVXorUW5HaDlQOVZCYXFyd2ZkM2VYRDErNE9hQVJOYXgwNGRES051ZjhV?=
 =?utf-8?B?V3NWK3BxdmJrUE5wWGZtcmM2Mm1QWWY5OWd0eFUwdm53OE5LVFBEQTMzbi9U?=
 =?utf-8?B?cjRkVWg4aUd5T3VaTkxYdHZEaFpyL2s4WEEzcWY2S1F5b3d4VkhzdEFad2VI?=
 =?utf-8?B?U1EvZHFHYndDNEtEQnJGWXJVR1d2NjYwdEVDQmx2NDFRTGIzMHVEWFIyVHNS?=
 =?utf-8?B?SnhTMnoycGEvNlhuVkxqcFM1WnVzNlZuTEVHT1lNQnlxVHRyU2pIZ1lPNlUy?=
 =?utf-8?B?SlNhTTFCbHU3S0RjQnorZmhDMkZNSDlrKzhLMmJQbzhPaGxNdWZiUXRXTjkw?=
 =?utf-8?B?bTFXQnlsY2dDVjdTNTNMWWZ4NFVLKzl1RGFCYXMwQnlKcjFReEh0WmVhY3p4?=
 =?utf-8?B?VEtCNzdDQ1E5NFl3M1FXblVDQmlUR0dRSzhNRGFaZS9qMEtXdEZpZnVRRStC?=
 =?utf-8?B?d1dBdkdIU0RsczJBODRQbGU4QXpWaElxaWFQNXVEakd5Z1lWRjZYUHJ4YlZi?=
 =?utf-8?B?ckhBNmdFc01TTkcweUZEejNuY1FKblhoVElqcEppcWtUem4rVVIxUmp5YUJn?=
 =?utf-8?B?K1hiMkg3NmVuWXgvWENZdy9uZzFaY00wbUVqNjJhNHBldEtvY0s0TDlHWWFT?=
 =?utf-8?B?b3JleExoVFo3YkFnQ3FJcWJGbE1UWU5RNEZYMFlxblU1dlRoRGtLYmdrWnk1?=
 =?utf-8?B?b0pKb2NEVVpnTCtEUnNjY1ZpM3MzMjZuNGt6RlZpcWZUTkdBTi9ERlQvNzVU?=
 =?utf-8?B?UC9iSjRTNXBWQkxDTEVGVFVJeHNEb1RQZHVKU0EzMHljK3U0cUM3N3FycDlP?=
 =?utf-8?B?V1R3UlFjTTM2YkorcTNKajA1a3NIK2Z6MGI0NGRteWJ6SjcyZFBxQXNlUUpn?=
 =?utf-8?B?dFJZYlJOWEh5TGxmanh1dU5tUGwzOExWeVBKUE1ydjR5VlZnT3dNWFExVGR4?=
 =?utf-8?B?RnNIUGtxMzRGbGpDcksyZnhvNjJSWG9Jd0V1TllWRUo5Z0VqZnFxZ0pHZUpO?=
 =?utf-8?B?aWUzVjcrYjRDajBKaWx1eloxd1NVc0tYeEc1R3FCZUpZNVdxQUFKeFRUaXJN?=
 =?utf-8?B?S0N5UEdVWSsrU1BtRWRrajhYMkVGZVQxOVdWdStzTHlXTEtSVzZXeENsNkU0?=
 =?utf-8?B?cjdidU5oUVNqU1pzTW9XUk04bXZWN2E2a1BhOS9STmZMcDBhYUdYNm9saVpy?=
 =?utf-8?B?dUtCRE9zem0rTHpScmY3VWMyc2dXOHVhUy90czlCSncrcmNRbVpHNkdCSkwz?=
 =?utf-8?B?MndpYkQxRytmQ2xocTF4NXB6MkRTNTZTSjZ1MkQ4amRmWDRyOEhaUFR0eFc2?=
 =?utf-8?B?NGdsSUdBeXFSWUVJY0NxSWUwMkcrS2x2Qk5XSFdHT2o3SDRqMUFncHRwZTdD?=
 =?utf-8?B?WGpzTExuNHJCK1g0Snd3L1ZxaGppYTMvWFhxWC9oSmM1ZmpqVEFrZ0ZJc1ZZ?=
 =?utf-8?B?Zjg4MjVaRVltUDU5WFRXaDNnMW9HelpLV2pscVFNNy96eXhidndpN053aDda?=
 =?utf-8?Q?SJyo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fcf1be-e6ff-42de-f5b5-08dd97627021
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:00.2548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKar5m1x5CtUOZR6XBihSSYVj5iHHLoi1aqerfWsNGp/gvDxTI70qNL/F/V829hb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617
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

Due to race between KEY loading to CAAM’s internal memory
and initiating crypto operations can SEC errors in PDCP
AES algo combinations.
To mitigate this, adding CALM instruction in SN 12bit case
and using older version of descriptor for SN 18bit case.

Fixes: 6127fff842a7 ("common/dpaax: remove outdated caamflib code")
Cc: franck.lenormand@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/caamflib/desc/pdcp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index 9ada3905c5..f4379ede2c 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause or GPL-2.0+
  * Copyright 2008-2013 Freescale Semiconductor, Inc.
- * Copyright 2019-2023 NXP
+ * Copyright 2019-2025 NXP
  */
 
 #ifndef __DESC_PDCP_H__
@@ -1981,8 +1981,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
 	KEY(p, KEY1, cipherdata->key_enc_flags, cipherdata->key,
 	    cipherdata->keylen, INLINE_KEY(cipherdata));
 
-	if ((sn_size == PDCP_SN_SIZE_15) ||
-			(rta_sec_era >= RTA_SEC_ERA_10)) {
+	if (sn_size == PDCP_SN_SIZE_15) {
 		PROTOCOL(p, dir, OP_PCLID_LTE_PDCP_USER,
 			 (uint16_t)cipherdata->algtype);
 		return 0;
@@ -2747,6 +2746,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 			    (uint64_t)cipherdata->key, cipherdata->keylen,
 			    INLINE_KEY(cipherdata));
 
+			JUMP(p, 1, LOCAL_JUMP, ALL_TRUE, CALM);
 			if (authdata)
 				PROTOCOL(p, OP_TYPE_ENCAP_PROTOCOL,
 					 OP_PCLID_LTE_PDCP_USER_RN,
-- 
2.25.1

