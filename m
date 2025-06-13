Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F56C61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7794B42E8D;
	Fri, 13 Jun 2025 04:12:01 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC4642E71
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnq4YwfyTaqWPAx4wf3YHO9idMrKr/Ae4UXOQbrcEMsbSO6QMaj+bU8PvBOAMMZqYL8x00BzhilVYMgZhIa/ICluZEq/kDPPNhms3kYFa7I+i7tdZwrJj1bu2NqCGswp0uUBSKb7SpZ7OENj2gAlwQGJG4dCL7+5BHRPeE1m/DLwwet/busOe/CKC+QGlpfE3rzWpYf+6N+WjPrB9yXwKNlxLnGQQS+BmBahyZeBSidlu2rQlF9J3m+tNyUD3/o80lQZbACfm/pr61f0bIp89sU80LXj6fKaz6a4WPG6LXycSsXlk7JSjlvjxe16pzddsywjih3+mvQIacRg5NQW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obN58QSNP33q9mGIxtrmAUvnjDd4fK0Za5nzNxsvdH4=;
 b=JJMGb34holWg3TTns+y4vy+jylSMAazULy3vXlZabpTbTokKoiUNFIf5Um/Li8ld/NCiEJURknrgs6pZGsgVXJHr1RvfEquujOJnwRpvpRhauNmiWDYTT8M08I0HiXRSfiAFs11+XzEgaIAaELWZm71O/pa+YymqIeOlYlSAFwFTWfbDZJnpN7Cel1Bkr7QPkHi5DGRtME9xSxkZdAqimThG+geusN3bbiw1NZmom76k6qAz/6VSmfVKGiof6PllXF72nSRzUx3lWxoldUUxZftUf+9qsGSKO8BaTZv+3VPINq8FiCg2VXVYcqvPt4+LtnX2Cp+Wqy7KaB8tdNtvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obN58QSNP33q9mGIxtrmAUvnjDd4fK0Za5nzNxsvdH4=;
 b=b1UMC4qrqw1+RB4N6oPbWUcmE9OqwRKwo2NGCyPFTmRYc4D8fke0RqBMIrhQjH0U1Rb+tDjtyEiLdLmL3Q5VzUw6Z1mJeZkAweEFeflrNC9Z/cKKbviALeNTDzoaqeiVgn+a5wbpXKmPg7afKn0I51QVHYMXw5OvzrnUMpM+ELUxH17djMTjziGllOxFZkpoGvJ+7xKuD+t3aw+aGCRWUozYoXWTT49upQRNFvGumKbhWJxksFX93o/aCYyLarntX5j98v1MV+I2GhcMIJhJ+8XCSer2RHU+TqpXw/DvlH/aPjAvIETxK1t9l9Tl6I6Vi6b+L1gftqao73aZ3JVB2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:58 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:58 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v5 07/11] net/dpaa2: support dpmac Tx stats
Date: Fri, 13 Jun 2025 07:41:21 +0530
Message-Id: <20250613021125.790614-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: afd2268b-94bd-46a7-77af-08ddaa1face0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80t+vmZUZgosBW6UKkafGsYrfWpqphRaQaFyAKJSFhcDt8zjvMCdrB3bfCCu?=
 =?us-ascii?Q?P+tW/lUHLrIspld9+ww176CSDihQNbK16r6clLMyP9lPtb/flVBLAO3M4RAs?=
 =?us-ascii?Q?UIDOsk7YzfZ6CXZvbYuBbjBGQhkJ6pnYEUiVjPMccL674iiDp7+rp6e52Z4C?=
 =?us-ascii?Q?h+5NviIMJM3nudkf0fRiaDXtGxOo8QcHq691PfPyNNS+vmvpHpgfx1RA5lys?=
 =?us-ascii?Q?0eUdkxBkfkrU4wJqCN3WXYK7iPTuCj56HP1ikmPUqhlC8uaeh+9wYNvJmcVy?=
 =?us-ascii?Q?TrB7LremPu7T82AJK/XZTF3ePosokKlrxWRtcmU2rZxr8u1BomoT0jNH9zXs?=
 =?us-ascii?Q?e2YYbC8aXjVjv6LXgw48hlQ6uhwMTFJTLr0/4gHlwiZeykoXBcXmqNCu7kui?=
 =?us-ascii?Q?8xw38si+uPZowBKsloezb+Z0ohSHk90lC+eQSaC8/TxtSUaUhqBxNOiw6jsH?=
 =?us-ascii?Q?hv329dYQY2A0EmdE3kzfRLF+v5zTS2FteCvB9c+LLQyJ7aIGUhmfGWjiVtnx?=
 =?us-ascii?Q?GK9eID/YcY7Vt3AFGclyvwyeLoucoyKA9+3ZDUTq0TSQ5oat1WyvvhCvlk+v?=
 =?us-ascii?Q?niGy6LXeR3FgWze/F9mNRZAQTg2drftenfUZkGKADgGLk7EI7H34cINKMiuq?=
 =?us-ascii?Q?7UVNUQXIPTiSfYKMhzN4ROMJ9jI2lJc/YlIZKfUDwgYYLwoNvC7lgdb9Ae9J?=
 =?us-ascii?Q?CVuWslWQaL5UEvfCZSutxzl4aAAqpbBwjDGowKLCCsIQmssYDzSgpYC7qdMb?=
 =?us-ascii?Q?8seK/N59wIPZn8MChH/mSd+DuirXsuytBpUhWGaZ3NXgkjdjxTveRsF/DQAR?=
 =?us-ascii?Q?C3+mfrZlJVhJkxIZC5EGUwCSjsr4ex9JpTF+LebZ0WDoRMeVgpVsJKlnACGF?=
 =?us-ascii?Q?oYGtJi+RnPDRDIMv7j/RNjXLOesZY5FjeLX8VcsN6ES7CTm+roC6Pa1rxi36?=
 =?us-ascii?Q?D/bgY5Es63SI1nHRgn3Fw8EwW/0UzmM1bIp7N1jIGWxmvJ8BHnTz83B0457K?=
 =?us-ascii?Q?F/rokjZ0aR/TDD0cP79Adk7pY8NNskoDYCUn1Jt7A4nR6aKuDf849OB4dbc3?=
 =?us-ascii?Q?QGWx8D5WMDXpIYwb7JcC0EtCSE4jTiqZ0FnKDYzgLH2NOO1fZeP2iWN+1k8f?=
 =?us-ascii?Q?wUCgd2xLuTjo2s+BW152TRqBFDdGdElZEIPwbIPsESQQE+e+2O/rW85d/MdO?=
 =?us-ascii?Q?1hwJw0fgJPobo5ywrFHF08UXgdCzH7ElnUbuEh9Ytbc/IDLyyDnjVnlPBRVE?=
 =?us-ascii?Q?lCRWOzJpG0c39yGTiG7Mv/ZwHpMM/jxru9jj7iBQKTdq8IOz0nJZP5qIT41l?=
 =?us-ascii?Q?NOOUeUpQLXKrqPDByEfH+mYD1bhQpsLpfJ05zOkZampUYGF9wXQO+8ticPMv?=
 =?us-ascii?Q?cuZaKAklNYVzVUI2JmUx2Yr866OU3n5cBzzPGHOxgSX+EKQGt9MWssVu7hZz?=
 =?us-ascii?Q?g0zckoMQS4Jb3OPnI3B4Qghvzfx8/gTZz2wXsyvLplBKuKeX9NAQVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRzWrXEWlQC+/SQyR+etm5nh1r3U4dCydk1YM4yvWhxdUUrm5mYeDCHppL0g?=
 =?us-ascii?Q?OYGd/AXaSEgu12ivzYAoNV/Am08JyJnZ9rDG2Ng4nQb/qkNYdW5NpYhs1QZV?=
 =?us-ascii?Q?AEZUSPlfeZD82vsPw6t6UmWfIphSRGxzsvBbrx1u+RoPS6VyXr2opv3s2edx?=
 =?us-ascii?Q?isAehYcI7+HFhGM2sSr0axaZTa7QEjHnhy6r74Br4mkl0XGf6e4JLU7gvu/G?=
 =?us-ascii?Q?BXLMG+gKRX3rjK1iegDlQadeKtbsxncMypFut5+MNAQPuftcKC1gebYljZ1K?=
 =?us-ascii?Q?4z0UMt2aahBxp6tQ4teySXPGgmF7SfhEGCIJAS5a1Ekkh0dRHFahuSjvX/fa?=
 =?us-ascii?Q?miWRIUms8CpnfBNJwWTncw7EHlBY4KsF5uP5J0M3xtng9R+DTVZOb35xAqvy?=
 =?us-ascii?Q?ec0DCn5Nd2u7jfg11n8ljzoUNU+ajX/t+R4YEBOdrb3mh5t49DNLoTOYvkFP?=
 =?us-ascii?Q?sc0uqhBWoVP6tpbgZoAimylFD8TW73O1ZR7ox0rbeAYAUA5o1r1saIXflSZY?=
 =?us-ascii?Q?4VO5hE0mPekx6DcSoF/KFJ9/ZlZeAtrWPwj26ghheIVgRx/kXG5x4KNhkmQY?=
 =?us-ascii?Q?ffitA1uHpHV8tqMehCjSoomjUHIwcwyt/hBnrq5B5Pl5ZNNhwdRRnCR6rInb?=
 =?us-ascii?Q?QA4Wa2tNBZnuX28PBwGmdI4Ck+0utL8WRVncSR1zUgzrNfdAb3qJE9WDU1SE?=
 =?us-ascii?Q?vVz1iMJIafZ0Ihaxja7p35/snhzIBv8KqLpFsU9CDrJ9UolpOf+d3JeVIMJx?=
 =?us-ascii?Q?zQfJyDgYIvM+R+DiKf07z2q/q81De9PzlwAyDwGDrDQRphhUT8z0ceSHM7WO?=
 =?us-ascii?Q?g98CzJiHLAXegbF5P5L1jAdOq6pwMeFrd4IVhiC9aA86Ft6OEGiKuGlxFO+R?=
 =?us-ascii?Q?0pI2a8vuDmBG9WRy9fkK8I5ddu3tu0Znqb6K5scSrvOZLJRRVxRUswDy7tZP?=
 =?us-ascii?Q?OpfdQENvuDRmhkLC2IffitdhQDM32B8umoDv+ASx66AnO5rrRyCDEBqbvRlL?=
 =?us-ascii?Q?rNVsMic3Fn82UGeA31PchC8t+0myIhaCmZ6VQTEmzxuECuZoejy8u9AOzBD0?=
 =?us-ascii?Q?BvLLS1DP6C7hCs0Tfg614LV6oDwaWcT27n1qlVlpg3rtfVhr0fb1Osobh2N/?=
 =?us-ascii?Q?eV4QCDE/jFO7aa+mMA66+4ECLtFJMP55IDqokYO9vkZ8lkrUzeuM5k0CmP5/?=
 =?us-ascii?Q?R4aPB3B90s7TXHAmAd3x1Qs2MVKRaIQiOCIXYlTWPUYChkF8mCXRwWEbILMN?=
 =?us-ascii?Q?FriRohAYZPPa1zO+Kr3yt/BP9pPs8mnjJKCl4uca3NhG1zr2kQaViAvlrnBS?=
 =?us-ascii?Q?Kwc3yIUJBQnE+SAJYRiNXniX2fcNPCl7EpytLESxzPx/O2capEmMBnzX43u5?=
 =?us-ascii?Q?SCbb4DJYLMVtiie7MJydKE1yPrOmR1L+3BwPM8/ar5XQB91NmdhLc34T+idD?=
 =?us-ascii?Q?Xosd8lJ8R1C2pVN7MyI/7FjpazcoWu7WH8CvKXVm1A7opQ2SDNdTI3HBjwsa?=
 =?us-ascii?Q?9D0cJS24gW/ykJcUVzKf7zipjgQ5vlJf34vJlQfE+BWjERQ88kq3i2DhMXFH?=
 =?us-ascii?Q?3ktfd+nVRqibrtX4hCM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd2268b-94bd-46a7-77af-08ddaa1face0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:58.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0GqnaOUda9pRJq25cfrQTxEfW+hrSQAg0fZOXBbasA3TAqo3so7BEE4JSWWfjuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Added all mac counters including Tx stats buckets for
packet sizes.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 48 +++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 41eca47cfa..375d646cfc 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -409,6 +409,34 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts transmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all transmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
  */
 enum dpmac_counter {
 	DPMAC_CNT_ING_FRAME_64,
@@ -438,7 +466,25 @@ enum dpmac_counter {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io,
-- 
2.25.1

