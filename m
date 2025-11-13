Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C418DCD5BAD
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E57DD40B9A;
	Thu, 13 Nov 2025 10:59:39 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011018.outbound.protection.outlook.com
 [40.107.130.18])
 by mails.dpdk.org (Postfix) with ESMTP id AF04040151;
 Thu, 13 Nov 2025 10:59:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt+eYnoljRSJO4ebRQXqOR5f8EUBFQosCXHicrzLi9JZUyanLu5HndaWk/r2K6ocBeu2RzPk4wrsLT7yRMpQrWYQ/UlYKR+fp9L6QzH5Os79FSOswq5nHYbbiNxGOuSd2V8La5SlP3k5tU3frSwBNQuCQUkplEGUratZYgED07taNI++RKv0cLJI31H4HbUlKryQx9FM9EOjPDZ5sTwlLy5MjsbYBLMqdRgA+BbwF9NkinvaQDYj5Bh+c5Og5R8GW8a5x6TSUAbVqWUc85/BikNi95dwHZBtT4kzKdRoyh1PP36AGrGVT/Sqc6oelSwrShdCCDujzfXqMZQi3Dgpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=HzIFPKN568Y+3Q8zj3yMF8XUpxweOFDxs1qOE5vfrvOYAsZXY8fz7kUrGlkR6PMZmgPpLCQhv3XmUymUrxiJ5VBXUWPlINnN2DvlpgAdbpebata06z+1OEAvSNPwLtaDUsBImnElMWXGmygljdD7l95ZEAwX6ju0KFOVhCGDGM7sMJsw0UiYUB9ORDqB32gDzYYkpJvSd7Yib9ZeEnT8fCqDo15/hbgE7zAfjHU9n98JIIPBwUIF9zElrtNHkxIGTgmcu2arn1BJR6dFL/0Hh6FFcGCSg81Moqc9QfFRzPz190fXhLE5kuZRHp18WpcMHawD4LzZT6+am1d9qbjpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTMtlK75uyypBwTAS8PdBJXap+OvW+hs7SG+18qPG/U=;
 b=H6CJdFLdFJ3faQ47v+aYMPpXZBNfIWJ969DYYyQCpLFYPYRRkuGHAwLXsXBokJsN/m67GwKC9vYrm+ZXF/sq8HH/KOoDfBGM/3ooueh2xkOw2kN8DIYLWy1pY21l4ND33sqsQLnB6ikpthNP1dy99+FvGPZn0dNv+zyymGcKK5h+oDQulNvxwfxoz4EbpbGmbuCc7RLQBSMXw5u7k4ukFADBAyGVv4B8dML7nMWGr2upxrky9r1JRNmGBl51smSYAa9PumcZ1/74aHVW4cjWTI4nsQyhqbIKsxpqSrFzhM6XrXZjyMMaaVIpY+DxLMMYwhZpCbAngZNQMYkBlSnQ/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:59:37 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:59:37 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: sachin.saxena@nxp.com,
	stable@dpdk.org
Subject: [PATCH v3 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
Date: Thu, 13 Nov 2025 15:29:14 +0530
Message-Id: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
References: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: f1759064-d036-451b-cff2-08de229b5a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHdhZkw1eGJuTnNOdFBqdkVoTzBPWjA4WUNXUHJxWW5zVkNzYnhNZTdDZFk0?=
 =?utf-8?B?L3Irak9HblB6QVpLWmw2WmVTZjJEN0cwR1loRDlxL3NWdzlGNUVyRFJNZlJ0?=
 =?utf-8?B?Y24rSlozYjlCNmNSblRJT3NXN2ZlT01OSEtJOXZSMVhuR3hXRk9iU1BDR0dD?=
 =?utf-8?B?OWdEd0FyOHh3dXVET0NvNTBIalZkUjQwOFlqOFFROUFwTVo3aWpSM3JpbDFV?=
 =?utf-8?B?SCtnSmtOejA2cTNNY3lsMkxNWmhJWWE5MnNGdnhCaWRWL3Q4VU1kZnNwMTAz?=
 =?utf-8?B?c0RxZnZLRDk4VlpIYjFWeDRyUXBJRWpvK2lEMTNOSVJOVnB0UVlrWGFETDRQ?=
 =?utf-8?B?TGg3bW1EY2RrWmRNTXg2U0J6QllKZkhnNlFHalZtYzhONXVTT1V4TCtmMWQv?=
 =?utf-8?B?TXMvNEtqby9zWjlKNWJ0TUw4RHp6anlzR0JrZUt6dzExOE1SNFNMVkw2NDlo?=
 =?utf-8?B?VHBPLzNFZml4c1BteitMZXNMbFJTS3BCN1JKRXd3aWE3WkNNRUVyVFNjdlpV?=
 =?utf-8?B?Mmx5QmlMUjBKMkhMSjFiRm91SFQ0cG9MQlhpc3N2WXJEdUc1Vlh0ajhEUm94?=
 =?utf-8?B?RW9YL2g1QnVrajFIWjVGa2kzNmYxUjljWWdWM1FXVUo1djlxNWY1NnJKUHFV?=
 =?utf-8?B?a1hCRGxRK1VtSitjSkE4eS9QV1ZlTmJoTHdFUGZ1eFM4bjArckxFeUFhaVU1?=
 =?utf-8?B?YlM0M1R5cG5LUy9yZjVtOG1qbjlvbVBMUGM1ZjFuS3hzakU0WkZkbGwrS3dL?=
 =?utf-8?B?SENIeFRXWDdwVGlac3F4MlMwcHBEMWdxN0VOVTY0YlBab01xdVJIVVJvUkZ3?=
 =?utf-8?B?aHJiUU5tOHNEc0taNHBXdjVmUzhoNGtheC8rVy9MeDdhbzhGVm9tTUxxVUgr?=
 =?utf-8?B?cENielR5M01SeWhJQjliOVdQYTJIUlNVZ3JEejU3YTF3QllVWVhEWFc0bVUr?=
 =?utf-8?B?eGhKK25rSUpmeEVoTmlkRkI5dUl2d1Y0TFRWTENjR21iS1FhcE9ueXVib3hs?=
 =?utf-8?B?NmJ4VTc1QmJGaUFJRmgwbGs4R2dINkNFbE45b3BjeUFSL0xXZ1lYK1RzbEor?=
 =?utf-8?B?R0hiY2VSVTUyOWU0cm50TVVkVHBJaUcvYmlNaUNTeFpDaUpjdU5rSG53cUNR?=
 =?utf-8?B?NHcyRjVncVJENHNQWEpjeG5HUG01L1lGeWhsRUdiblRMVjVkREM4V2xNYm5O?=
 =?utf-8?B?Z0M3N3RNaTdlUWd4V0pPWlN2U0VVTEFUQUltcGN0T1RhMy9jRGJaTjI2YlVp?=
 =?utf-8?B?SDZOd2lxWjBhMFRhR2ovVzUzakZZQ0FPQkYzenZLVm1pVkNnM2Z2NVAvTkdS?=
 =?utf-8?B?ZjJINGRQVkdlN2pNTUwyVUQ5VHpwSlc1TGFsTzRxSDdacjVLMDlCMjNrelBI?=
 =?utf-8?B?OHdDZDRVNHJ0S0tuTkpJeHgwUlA4YUhOUWF3WDdqVXEybEhTdnNuV2REZUtX?=
 =?utf-8?B?ZHdNZEY3eEJrWWZtUC9JdlBTN2p6Qkg1V1NMdWlTQ0U3MHFKZmdYTUtsaTIv?=
 =?utf-8?B?N0h5c2NjUVR5QUZmbHRqaWd0MEk4U0ZqN1lnK09iRWI3M2ZWQzU2elA0ZjVI?=
 =?utf-8?B?L2JkSGd3bWtnWDBpa0ZJbzZTYXRnMEtRMHlySjZvMG5jdnN4SjR5ZjRuSEU4?=
 =?utf-8?B?UDVxbEZFeTRuSXhRQVpaem5qQXV1L3hUSkZNS0JuK3ZpMzBCekJmZno0VGtV?=
 =?utf-8?B?bnVDdTRyTGtjbTFhWk0yeEljbnVtWWs3Y215V2FaS2lPdDhzWG9vell6OFpB?=
 =?utf-8?B?MUlIVm8rQUFRMllrZmN2MFRrZTBCRVB1aFN3cHdmZm0xdXVGbmI4eURQQmdE?=
 =?utf-8?B?Mi9GczlrckFiTlhOcmNmTmdBazdlOXgveDh5MGErWEozYnZFcncxaHd4YXNz?=
 =?utf-8?B?UXl6bXc5TFdLMzdGdHVpc3dJVUtOaTQxOGdGZWFIMDFlVktMd2JkWXZsNTZs?=
 =?utf-8?B?R1RKVTQ5TmNDRmM3UkhkdzJVdVN0TUZVRDJtVWFvbWMwOVZPTTE4NmJYVWJi?=
 =?utf-8?B?L1I5Y1huUnptZDJiMGhHNE1Gb1kxUTBUYXMzM1ZOaWZmN1RyNHRQQjJMQ0dI?=
 =?utf-8?Q?r7KXk+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpuV0xBZVdabTJtU1cxb1huZGc5dWpXdm55bUVRcFgvVWVpbG5iWDRqbW8x?=
 =?utf-8?B?cjZLMWRkTE51OFR0TWZNOEQ4cWpkTFBTUFJSMWVSNWZURVRxVDY5dEJGY0c2?=
 =?utf-8?B?VHFmOTI0VEFEeUE3M3ZQaEFaZklDVW96dG96aE1WcHU5ODRFcGNhZEEySm85?=
 =?utf-8?B?ZGNuWGUzdlVoN3dtOHZuWnp0d1kzakF5Zkx1NkVPbmR6aVd6eUFoQXVQSEtB?=
 =?utf-8?B?c3E1YUJULzVvaS9mbmpHRjR4QlVQUmU0dHRmU3MvMyt4WDF0ZVdmd0tySVpl?=
 =?utf-8?B?VllISmNvVC93YmVTeTkzT0pNS2dTVUphK2oxWVRYeUlZaDVCdkdLTlhQV3Rm?=
 =?utf-8?B?MTQvL21Xd2JwRHRHT1NwNHAyLzVkcVRjRWdiMUZaWENUd2dFVkdIc0NHT3N2?=
 =?utf-8?B?ZTNYaG1KRkZFa1ZUcmVLcUtwMStjMHVVckltOTZiVFFrWFNISmprQnUrVTkz?=
 =?utf-8?B?dktOMU1wQ0hlc1hnb3JVSEVnOExPU1BzcmtqQTBwWUlSUytZWHhjUHVPL09L?=
 =?utf-8?B?UTFuUVVGVW9Ca0huVFovYis2R0Zja0ZaWWRSZVpxdm1xU0ZZa1NHRDZnWnhh?=
 =?utf-8?B?STRTVUxJQ3BZMGV5SGdOamNJOHBvWmtwUVhlY050eDZZSnNZUGRCNWxwUHQz?=
 =?utf-8?B?SUhLUjJKMzRuMmY5bE9hZW5uOC9sQ0llTFdQVGFZU3dmNWNjeHdXZTl1Zlpm?=
 =?utf-8?B?ekJyUDdEYUZMaUVsdHMydGRVcDhnbklaUHQyV1pzbERBVzVJT1dvT3BmMkNQ?=
 =?utf-8?B?ZjkybUpoaUpORG9HYkdCaFlmM3EyZU5kVWkvUld2Z2J1VHZqM3ZpOVdoRm5O?=
 =?utf-8?B?a09iNFRPWWlnK2dtZzhGZ0NDZ1BmdXRra0twT3BUeGJHRXduNTdJb1orSyt0?=
 =?utf-8?B?djhmM25YQWFncXpmMjg3TFM2cTZ4dGFlV1hUNE56c0k2K2pxd2pERnprSk9u?=
 =?utf-8?B?SFF6UWhpTkpWTExMVDRZaTgwQThaNEdLb2Q3RXpaSS83ZDluWW5TZ0R5SWpM?=
 =?utf-8?B?Vzdpb2xQVGpvY1QzNzlXNWxIbFhwdkVIcUZCSkh2NDBvNmxpOVhGRE9kOVZm?=
 =?utf-8?B?REZxbGxjbEFDRlkyK1YxLzVRNG9pSis5VlpLRk5JZXFmbFBHU0NObGszMVdD?=
 =?utf-8?B?WFhQNEtGNkRSMXhJNFhYNm83TmlhU09Pa3JoclRiVVFmQlk3ai9NV3RiRWRB?=
 =?utf-8?B?YlNIRnlQeTBhcFUxdVBIaG1lTUNqaytaWWxHTmVCeGhxU1ZlNmpjNm94eDhl?=
 =?utf-8?B?bzJKN0VsWE5tOVdrNzIrcnJYQUtsc1J1ZGZoaUo3S1o2OVZNQ2oxMUJjdzZo?=
 =?utf-8?B?UjNsV09HNFlndjdQZlVra3Y3MnhQbXlLN1o5bEl6WlphdzY3Z1dJbjBHREdj?=
 =?utf-8?B?VjhxUGlGMVJlcm5BY3VVNjUrTk14eFhES0loc3MwNFRNM1B2Q05kS21LT0xJ?=
 =?utf-8?B?MkhPYUJzT3VhNHpVWjdhTkdqalF5WkFGaDh1OTg5R1lSdTlNS04ybG5EN29D?=
 =?utf-8?B?alJLWUFZdmZhdXMrVCt4WS9PQ3lTMHlUS3FVbFF0RkJYN2dEZmp1eGVaRjJv?=
 =?utf-8?B?Qnl4aHRjaDRWUmNRWUNxNTZpSUUrM3U5YzRLUzdaa0lpL2xCbERFT1NpTDE4?=
 =?utf-8?B?R1JLbm9hWkpHdXMwbDhob3FlUkJucm9KUklrN0FDYUdvWDFBZVRyWDdaLzV6?=
 =?utf-8?B?dkRXQVpCdnhNdUlIUHRraXBOQ2xObjhqZDdJcTdQaE9aSHBFMkx3emhDYjls?=
 =?utf-8?B?WDh1ZW5pT2pkZytMZjVKK01BbUpvc1d2azZCdzFsWmcwTGVmTGVROHZZTE9P?=
 =?utf-8?B?OUMvR0lseUFJbVdkSmZCM3hwcHBXOVJwVmpWVXRwUE1VSDNiQWFRTnZtZUsr?=
 =?utf-8?B?SDByeThIR3pKMytDV01LTzk5d293dXp6NWZqK1Y4Qk55TkNNczdIbWUxdzZu?=
 =?utf-8?B?a21jTzJxbkZLQ1BnYktMeks2aTlwRUxRQnRUcTVacHU4dDJ2NGJsaHhsVVJq?=
 =?utf-8?B?RFRpUUp0UUVGSnZXYjNFV1pNbUtnWVNHckxjR2ZZeFo4bDAzNWdnblFLNE5F?=
 =?utf-8?B?S0xXK1ZTYXB2ME9FUlpQc1FyQXZVYnl3eW54dEs5c2prY2x1YWRqVi9FSFVG?=
 =?utf-8?B?d0pyRUhRNStzR2k3ZjViSGplMWlqY1lsa3BZd0JBS05BQ21HTFVaeXFVZ0Nn?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1759064-d036-451b-cff2-08de229b5a69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:59:36.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzhAS3lKeVXRdNmph3f5C62XyQXnXyNRENQr0gEVJhPPNkvXz7O9zw26E7XeLGTifHV6DY3fQOUpL6QgrF8Ljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
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

When rte_eth_dev_close() is called, it performs the following actions:

Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
Then calls rte_eth_dev_release_port(), which releases all device data
and sets dev->data to NULL.

Later, when rte_dev_remove() is called, the FSLMC bus invokes
dev->remove() — that is, rte_dpaa2_remove().
However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->data
was already set to NULL by the previous call, this second invocation
causes a crash.

Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7da32ce856..fc63cf4f09 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3347,14 +3347,19 @@ static int
 rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
+
+	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
+	if (eth_dev) {
+		dpaa2_dev_close(eth_dev);
+		ret = rte_eth_dev_release_port(eth_dev);
+	}
 
-	eth_dev = dpaa2_dev->eth_dev;
-	dpaa2_dev_close(eth_dev);
 	dpaa2_valid_dev--;
-	if (!dpaa2_valid_dev)
+	if (!dpaa2_valid_dev) {
 		rte_mempool_free(dpaa2_tx_sg_pool);
-	ret = rte_eth_dev_release_port(eth_dev);
+		dpaa2_tx_sg_pool = NULL;
+	}
 
 	return ret;
 }
-- 
2.25.1

