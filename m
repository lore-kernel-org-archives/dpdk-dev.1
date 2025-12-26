Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF5E7AD4B
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Dec 2025 01:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A84640267;
	Fri, 26 Dec 2025 02:51:28 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
 by mails.dpdk.org (Postfix) with ESMTP id E426140262
 for <dev@dpdk.org>; Fri, 26 Dec 2025 02:51:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqSD/gQ9RuDWcsECZeXSYddZHviM9079bpUPA+Z6FI/zirtkTh0yrefAcxDhK+B7bTbdtcAB8FLrQHIMLlyyVh3kdtY9by4hSrNX4YuW7QM3BPl1keuksWDtCDe5x0/DeQRXcaDHSNBI4hbXGyM2Qp+J3lJ4mk/bTynqhBR6/E9B1ikw7Poou2eMiw1hURfIZ1XzIQTHijTW97OSlUDY2fpc+brxM47t//tBHUMDoUmtgekXsIM6xEqi1adE5POE29NGy5D7Wiq3WHhaCO76EWrgKssgeGsYghdVumrhGAjlVEXgKnAJjajJXti6u5R0CyKedgWXUjSqH4YQlvp42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hti3HYgSywGXjxouSd1TffDcv66wkyBdS5WCIW4l6ZU=;
 b=g/lgIjVDEn4k6qebZIBspsA3b/+zwAT7iZVZwosofoDKkZl/9Uhbh8oAQnIrnB5d0N4zQrFkKmvBBJX3q8vlJSrFVmmINNu2pH9cM/BFwYkFakkX1mnTOGogpBH1IKaaRz2V/96VuVbxVi68EH+Sfxm0pQ1bpafijYsyT6lYbT7se41GqYiA6FTY4Qxj0/XeL+KyG7IQ/3+hbD77+N+eL6ATZdw46yNMpBoFXjSD3OnY8aREoh2imcYXPcm+fJsL+7ETzejm2v+MAcEhfkdcYZ9vTClRqhVEWaCFJHBvM/5Kdu+M1+bCWDDQTbTuzQFRNdBEoi9Irx5At8wwLZhRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hti3HYgSywGXjxouSd1TffDcv66wkyBdS5WCIW4l6ZU=;
 b=BtTKSbmVfxaSWEZmAZ+6Vwfq5oQyuNeTyqKXgXP+eDQJ3AhMR0V8Fd91y4kP330B7kmDAUETaoEHB7W7H3tBElzXTfQyemgnRUZa6Udy0JJrrfSzyAPx26uXRnydCSitoIgs1n+L7uyhd6CYI0NcxAsL0QbqVUZiG5Psx2zcgyM27MGOfrTXapL7vSxd9ZE+z1OKW9JIeTdvGxBw6uylQVSl/pj76Qu4QAx3IRf5G0j4Y0oMUWFIsKbAzYRKJqG4eaqd5uCT6QZdwFLnuLpQNhjiPXX4dU/+0f3PHOiGO68zVOERJWo+t5pEbHcV2AdHuPiFICJhtAHjlmnm5idNbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by OS8PR06MB7321.apcprd06.prod.outlook.com
 (2603:1096:604:289::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 01:51:21 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 01:51:21 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: wisamm@nvidia.com
Subject: [PATCH] doc: update flow-perf.rst --query-rate option description
Date: Fri, 26 Dec 2025 09:50:57 +0800
Message-Id: <20251226015057.49408-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::11) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|OS8PR06MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e6d47d-5930-44d9-2c76-08de442144dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQ+il8clxECs6HuJPkVbEU36XyoqQHy2TCUMCJk4ns9hHhg4C1phCUe3kOOS?=
 =?us-ascii?Q?NRH+aj4Vafv9SBgan7mb7ET10L6JwtHoIx5MrXLls/kGYcLlpFM51oIMTnpJ?=
 =?us-ascii?Q?LKn4i5r6oDrUx3EDuX0GTvxds7YcnE9t0SP4odJY1icGyc8ctuqtbknrO1GT?=
 =?us-ascii?Q?I2S2VzbVGSz0yc7LMQ6Z4hZVn3j4zno2MzyU0AZZfLSxj7Gx8XnDrmTh8rer?=
 =?us-ascii?Q?43R4+WfZQrvD45r7eIXPQ63+Y+c1r7rcZhVpEhtbHIFc4XMI5m0eF5dmPQjI?=
 =?us-ascii?Q?Uoz5f2/19sI2nRLZ4oTihUOYO/3aSpN1K4SgkY+5VGWV74qCQR6igfrVDlcc?=
 =?us-ascii?Q?NCHHr+o08l61FVKt0F0W4ldgrOgD9PNqKuK+do1VZOOhZ+PYvSqCpItSdg5L?=
 =?us-ascii?Q?LxzdRn22X45HQg2MvoNE4Zjal1p/dyPlztwXjPUPsLRe8IYzglz+iZaYn+f/?=
 =?us-ascii?Q?9IYU7hztlEKSQnpHEU/UnDvTrGCwJUeKll2rLemjv0TtWQ1SD5kSZ6/yobVj?=
 =?us-ascii?Q?VC3rkpjeaAWSppn8EDdpBOGPOWaSdLZCzYC5B9ogs6Qobe0sAJntCIxWvIot?=
 =?us-ascii?Q?mCrQXweGptmoch8by0NG+Gl9SGZeDrzTvYHzgDOODNfrtp5lIHli5ytEf5BY?=
 =?us-ascii?Q?2GHy1q1H/v44zM1JoYuFDeQt3StI1sq8oaB03TlmfY44vU3y/2XFGa+Td9Xq?=
 =?us-ascii?Q?f84HEarizwHdHLLA6orfaDXK1byAkRxrTahJvmu2KK970qNR5AhCmLfeLYM8?=
 =?us-ascii?Q?vT870swgT871lOwFo10PfrNu1OToiFQsebIpymwsE6qUDGM4r9DZ5oZsY+AD?=
 =?us-ascii?Q?/UO/F1tXeU3mIcltph9m76LwkdGlQHQKGAgfo30tlvrmqZTXUaUpF7DnQQ3E?=
 =?us-ascii?Q?YY5lmQZki185Y4IFVQ6zkFUrlUuqmwYx3SIcpARJ6T0DF/P9Q2wjVIk+FNAL?=
 =?us-ascii?Q?oNQRa8UNxEvM6CiWlxPATsO3i1Ge+2nqZDfvMRAuXsuT1jYTNXiGAQjmG1l6?=
 =?us-ascii?Q?K41uUBEsvSQphiyq/ad/TsHolJj5Vfl9AQURL1reriVXKvilbOzRo/x7tc3P?=
 =?us-ascii?Q?JB0MdDGGAxZqCuRrN273wDwEmAGW8PcSfwZTr1OKdBSJDX2VWUPUnozIkYDb?=
 =?us-ascii?Q?TjidqkhWxvDq3jBkm8f2kSRfH0SzDY1QZ30Tg6wkk1GbygyeKnuJ43ye4GFZ?=
 =?us-ascii?Q?eb4xZxFpoih/CrFdAObo3LAe4072cPBTGVYLRw6DVLwcpF5SER3eAWjPMcSi?=
 =?us-ascii?Q?E8WCRkNjssaAjUnSp0UiuMgd0YLIf+XP319600714MtWRrT/A5MununXbajm?=
 =?us-ascii?Q?QeYKb4wdr2mYNgP2aLwH2SDsvMEIj8zmhK0VbvG1YZIXJdMSYKzot/WVf39d?=
 =?us-ascii?Q?CBFe0MGLqwVntFGk8inY1/xv6+lSAu1OjRK8b6E/qCwgzDDmpENQqFrskUk5?=
 =?us-ascii?Q?V3UoM3lwmFDlB+KYhdfeYeroIJ3SNVAoUCg1TJyb1JfUXMB8NDz6OcQvvEFM?=
 =?us-ascii?Q?B9PiUT7QqmuBUbiB5XPzJhw5l8w6y6WMTuDP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ud4PYm2Gb318ezQVe2nnCQMMfyHEVY+XmlurYjQhB3sK7bWRp1AuCjZ/dI2A?=
 =?us-ascii?Q?o3+BYAMxoa4clMj5xIuoYCXAEKgvAUTatoClwe3eXXOABNrBcQK6dMjAXjSp?=
 =?us-ascii?Q?Q1NFBG/qXgdUXVJtG8jpfXkP0sd/mSgnRjRRKUyxJ/6DOSLiR+1KO5rMSOd7?=
 =?us-ascii?Q?NYA4jLYBrUuFAo0W8zi/3omM1PDF4brJ5f4TfIpicjp6cayTvg+dtZUC1Qht?=
 =?us-ascii?Q?81i2BHoatjF8MkQulOhe194W6MEyA5kJFUvDQsyKZLgSi8BL0X3oJP/bD9/U?=
 =?us-ascii?Q?wYt0pzuwpUCXT6QlOaalqNpPxkrbopg2e7duHeITwppQENlAxF3ux0rlVN9D?=
 =?us-ascii?Q?9T5ekj9uYzDm0UOq2HFOSSUUp7msvbMJ5VGCMTjmGMreXBqhrSsTAMpdNl+o?=
 =?us-ascii?Q?PxRCYPJ84I8GKcnbROgILdkUxB2IRDblej7F3iQY2u49LYlAR1hyQ3HbGuGW?=
 =?us-ascii?Q?tSnvyi7ulgs7lOMORAX5OKki4zMOAlbAGZQIfrxMUJ5YeU52EWfR8bD0Fqtk?=
 =?us-ascii?Q?4/maLFeClZUktsPEQtNt8TMy66EzwVx30CvP+U1/ANCmMYLseswh29wfimph?=
 =?us-ascii?Q?w8r09GwzmmPJuPHDqSvZt0Zj7bVHU2hoIhispqSB2wd+5uZoYsVHBhD+6aqK?=
 =?us-ascii?Q?zZPqTWaDyjiY2xfJemGCAEpSP0xVKFu552McFPqO9z8a1RnyJSA4y5y0cz3t?=
 =?us-ascii?Q?VIPTmtkJwX5bJCwKJseGtN/7qw9GkPpXl2fHWOXc75cv4sBa7unxuo7Uxnjs?=
 =?us-ascii?Q?GgD0gsgRlwgAiruJguYE9ztOy6rxdjTkraOcykOSQD6xPCVkOjV6+kk1emV3?=
 =?us-ascii?Q?tt748Rp4Zppu2ZHOxN++noe1jOgMjsOBKYMRefPWY0p5sAaDse9zHXTtXr1W?=
 =?us-ascii?Q?VIYzBUQmV1uwHdwkAkJin07HuLWNPgZcpCfIA2EkXme6T2GiTw0EJYIz1Rz1?=
 =?us-ascii?Q?wIc9i2JCXCUnzzhZtechsvdwSX/0d6etDTmib9rWuMo/9DOIEBC18TOqfxUd?=
 =?us-ascii?Q?4i77IL9KnEQxuiJFxIwqvJiGpX1+Xr9OmXnikned8tZGuubFLAICHUUTYI0g?=
 =?us-ascii?Q?5A+cVdMOiO27rhacwU1pN0o98ylk8+V/+j2zEDadEQFvXOcEmOF7EfO22Zxm?=
 =?us-ascii?Q?zUPgFh7EiLt43Ge0LAvbvb7lSCxG6t6cXYTm4FNFVAuxTLVOP6ZDPF+2cmgB?=
 =?us-ascii?Q?zYXQzBspb4aMzW/FFGmU4iphZiuPuURvHMkhm7Ca/ooEEsZruo0BZTHJPTlp?=
 =?us-ascii?Q?RVmwmcrHbQUYzWN3Oq77OXL9QehgChpGYkDRnuZZ/Ocs33XG1caL3l7d3kvj?=
 =?us-ascii?Q?ndtUtvLwUFmGNJ6XJODEDHAyNio+bonFpszMqGb4MkEKoML6EepjamnGVU1z?=
 =?us-ascii?Q?4iPS3x9UoCMeqCpnfF2EKCkju/OVljZS1+QTQAnyDjA6PWZvrGcSO4Uo6tU0?=
 =?us-ascii?Q?G1QLtLeONE77MRJeeS9NOnn++OgQoUPD2ZYzi3okGhhC9MGIN6h71f713Noq?=
 =?us-ascii?Q?eNWDtg6SuY4K3Tx3ScjKb2XFHxcIRuFSpkbBQccQHQ7Z8l/y3+6NNL4vx+OZ?=
 =?us-ascii?Q?ktWGV9OokoHrwofAEDOBdbNlx5wrsz4SsBythyrElsp1Xy4XPcoTFamAtQde?=
 =?us-ascii?Q?qwxA37OwMbqjLES0b50qMFWDgs4H00QfhrvnFZosvXQCKFthYlljVUxxsuGX?=
 =?us-ascii?Q?aiGsqRqz3DEncn1tepKObdb8BNCGBWIa0gLUEKclzlqVRdqwG0CtlEcsn/dw?=
 =?us-ascii?Q?R/vTkiqGBffoPyYLctUOc3wvzpS62cI=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e6d47d-5930-44d9-2c76-08de442144dd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 01:51:21.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRoWtW2Ac59hGFn9qjmKcCQYUA1fDmqlWPmf1Ag3OgcGbzl9kvz3eKdfAQS9GLemV6r8Goji8RmEfRy6cMtis5Jou2nin39e+YLE+/7nlYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7321
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

Update the --query-rate option description in flow-perf.rst

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 doc/guides/tools/flow-perf.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index 5d7ae86cb0..a289ba482b 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -89,21 +89,6 @@ The command line options are:
 
 *	``--query-rate``
 	Enable query rate calculations.
-	The application measures the rate of flow rule query operations.
-	After inserting the specified number of flow rules, the application
-	queries each rule sequentially and measures the total time taken.
-	The query rate is calculated as the number of query operations divided
-	by the total time.
-
-	Example usage with query rate calculation:
-
-	.. code-block:: console
-
-	    sudo ./dpdk-test-flow_perf -a 08:00.0 -- --ingress --ether --ipv4 --queue --rules-count=100000 --query-rate
-
-	The query rate measurement follows the same window-based approach as
-	insertion and deletion rate measurements, using the window size
-	configured via --rules-batch.
 
 *	``--dump-socket-mem``
 	Dump the memory stats for each socket before the insertion and after.
-- 
2.19.0.rc0.windows.1

