Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC2C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78288406BA;
	Mon,  9 Jun 2025 04:55:38 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
 by mails.dpdk.org (Postfix) with ESMTP id 9B25B4066E
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3xupeyarx/HfMiFWzUd30+gd2UW0es8K/CE/2AdZoNdsT1CSO1vDZbYhx/jH1APNgYVQ4TfKTWLUY0B+Y9ENd5eStFsOhKOhQ2qtmyaVuOzZtt6HiU++40gavbQ83wEERo3SGrDc542bak6Bx0XyqpTqa8c9mc822v6v89jFkus7O7d5HNYVXsyVwSCsAge0A5ugW2cuzo+Z52hKF/cH+2clybJxRhmCCRGeFU+o6b611k/P+weB7QOjJM+rsQFWzfq/ZeUVIj1IsqunFu9/TwHommJEF9FibSftT49N2gS6j780CsYFbpV2RuHPBt0eVSWEqILnGELEliCypQwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDVngQcPpRbOgG6y/N/a8B9ZhKDvE4ewP1q6orGq5DI=;
 b=aRmodVZ2s6gIVS+IJBeP7mD2x/dNW+6M+paDnjkb8ZPsVfowFnmK9qIPbWejTT+A3Ms6mQfJu4CsBFLFWyOumwxGM3z1ZwCRGFCYBVgau6+cC+WmVSjZUVHZrPgNuQxf6d4j8U/HF0dsIBP9YJh2k5hYUHYXl+EBNORlIFObJb9FcfGoQ1B1h3WKhJ+akyl1qeC7bwwlP/PXMDOgRiXGbGdbT4+UobLb7ZLWKms6HAOizdm1qgMRtBftapdT86gNrIWl7/VnEV8Dj5wGtsrrKpOAfJNh4GKMOm1feRSt13e9M51nJnzWt4wZX8s8YxjKrqENTn8SbQC+Ic9YhDdeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDVngQcPpRbOgG6y/N/a8B9ZhKDvE4ewP1q6orGq5DI=;
 b=DpAzMf+LKrLLgvH4vU7bAAEEXyAjMZWPhp8EQU2v86zzWOsT6Uw+fdVo2S9xh8WbDoAAxvivAhjeTj8fGalIzI6wO9L2zsWfXsyAm9gMBWAe1FBNK21HQ/1T5TcuCFzKFW+BObyvhUTcJNkp2CAg62YBwojOxfrw9wS8eW9aUBnUm0STvipJB7h8I5PtzISD4vEeRbX0cQY2u27dSd7BlgGrQtmw1DLMv1bHMz59d/+enFeoOJ8HTCqP2uVItpxm++5Yn29lMaDjIN5mQlRLN3CqWPXWV3Pf8xZBsNUaFKLlFl3d95GJ/a05B2u6/zD3EDi0XiPqADUVPWe8TS20jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:23 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:23 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 07/11] net/dpaa2: support dpmac Tx stats
Date: Mon,  9 Jun 2025 08:24:46 +0530
Message-Id: <20250609025450.3997062-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cc9338-fa9b-4924-40b6-08dda7011463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rKBLSwkMV3iP+payffuO8d3qql94LVBJZWtlXz/Nc5pdwlJDhtMAm1btS1yz?=
 =?us-ascii?Q?t6lJgNlX8w7Yf4ZKvjPFbthCMrsBbK2nLw/KQkLhnPsH+vKDxlPy0NFV6GHj?=
 =?us-ascii?Q?rMYj2GLYmIBbwC2U1u1K2YYNTcwaTlzifhjPIXjBj8UxPI/wBkS6eBzWb6kW?=
 =?us-ascii?Q?RCxa1GfYOx7HeNI9Y5v6dh5a41xi5CIG6MQBQmiGG6AcEgvHOX3FSBq5shrG?=
 =?us-ascii?Q?N5jcTLyANK5v5AiSVQZZRCI7CU+uT5HmENO//avtKEwcUmWCJCLANnp0AghC?=
 =?us-ascii?Q?SE1Q+5sPYmynzAWqQzoDEpILu8oTbdpYm9n9Hw0ZLNYqURktwqfUBscVa5op?=
 =?us-ascii?Q?bahOi8y7ebfBTmxnemTxG9rK3+Xx9+bGCw98DEu2+B9NzkqWfAw3297sjhqv?=
 =?us-ascii?Q?gZsv8zpkFdCBEqDeRi+1z+NpE6SMu9VWM5ocJYGqEQA3najNZi4uWKXjPEUJ?=
 =?us-ascii?Q?P4+n08qOBkR214n2+j/jMoCiFMC3zbTNB2zhLzL07ExDAXXhC8aWHBESA2Bk?=
 =?us-ascii?Q?ublehS5537Go3d0Wr0KiRWeBOGKHa9mNI47rj42t+GPqo/uEm+dka4NLJyNi?=
 =?us-ascii?Q?Zg6scJOpakECbqK6rEqYQK0bhfdl+SHCg27voKihp2HeXFcn0G5Pwuisi6CM?=
 =?us-ascii?Q?e335UKLd9zqd3Jmc/bjZ3rGq3gz0AZ2pWlF97IuI8SsTtlKe2mmODCzp9c9z?=
 =?us-ascii?Q?sPCOAeuKmrdKa4Mb5tGQnL9mvcYxhoyeQUqZNzQ041lwNkBPxrs6+PKd8qFF?=
 =?us-ascii?Q?b+K0mpX4RZgSA10skYBDAByY0WRn4ii/NidPXbgwpFvdC2O8PU4IYm0AZW6g?=
 =?us-ascii?Q?j31V42BuK/ZK4XMIweT6s315QaeOOS9RZ7Cp0NTw+N3oG8NaCgFcWk9APXok?=
 =?us-ascii?Q?sC3nC7yS3bAIEGYYIxRxKz8r/nG09PbWholQVn2K+aY5LsQ1P6VwYX/MdmJY?=
 =?us-ascii?Q?B/ryns+rc37v09DYRqQxzcEDtgCDD88R3cfA8jjijSgN6S5+bG2/JccBrBx/?=
 =?us-ascii?Q?Fr3rymoAx1JZFSGLbXuHj4l6TU5Kk59vgplACnHe99KXxBNFDmpkUw9de2zs?=
 =?us-ascii?Q?K4a0n2Jlom63M6sL9omqCANoQv8/7Tl9n77OkphTADj6RYd1SMhyd1lLuAxD?=
 =?us-ascii?Q?loNP7aCIPxEplSRsLsV3njwYYx8HOEMaeldtsGgyrPWSk5uw+3y+SkVnsJ7S?=
 =?us-ascii?Q?0kfUFL5OnTwcaxhdujVDcKFq7nUkNWarFukH491F3ML4KSV/zVvjGZ2LtwN3?=
 =?us-ascii?Q?XmJ69qT+6CoA2oZWNdwjak9pN286RhyZH/98fHXtZjFPY40vwjLW3dg/ucw1?=
 =?us-ascii?Q?RyY608L/da5Vig3sRpqZxqaXA46oOjz2rb8AYJhNJQha+ANn/Mftq3JvrcOG?=
 =?us-ascii?Q?B/Zkzn3OHp2cPgifbvN8EA9Sh04bSI8YxN6Junt2JjBkgRmh2W28laXS1e/x?=
 =?us-ascii?Q?Qy2khVkEQF7pCaH1dE/XM/fsISVEe3GQH2XoihipQo/uX61gFBaoBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MkV39gLOzTt9W9+m6GADvcTnPXxI7z6XRX5XLbP24MtCuFrPjXT3akgZTZsb?=
 =?us-ascii?Q?E9YBMxp1rSucaJmmsA6NYdyqj6vtN7wKlTADC8Piz6NJyOJMHzQ2b2DLVLWf?=
 =?us-ascii?Q?yf4h+J18siKTbkEXjqQnDaKeGRUutR1eHUreKcx+MMmFJT7gD9X8hUwJ6g19?=
 =?us-ascii?Q?qxlEFG24AcF//5OsFDnfwCQ7pqeYplicUC9qeKzpOdZoFMyAXse1oVRz/G86?=
 =?us-ascii?Q?s4lVagvqsMyQo9V01kHCOzqYX542ESLlE2EOMHbnk6Sdossk8VJBvQbT+kgq?=
 =?us-ascii?Q?SVSCx0u1Bn5OZxj/WzHIgrgkm7q0s9JAG3tt4keQHE3Y4R1kDLX+mu4nPPG+?=
 =?us-ascii?Q?Xb9UuB96GQKkaJNmRzEQ5GEO69SdDK4loy5JfcGCZa2uHZVHtVIQmoHkGmnA?=
 =?us-ascii?Q?wRwve5tUeSyuOjZdylZ+s+EtcjaFaiWhmEURGh5JetQFhr/VHxifaLVcwjhS?=
 =?us-ascii?Q?NnnmxbhSWo4C/BGoH9RR722qkL+ynipFY2EAyQqul1AH5260IZL5lJTl6O8l?=
 =?us-ascii?Q?/sIm1Daa+XXcZwK7/7gIEgstXL/ZH98y4reV0axH5nvgUzp24VQoLZEiqu01?=
 =?us-ascii?Q?A/TEqOarxFiBmv55DGm9l6RmdrHOyAwfqM2kHPHL95vUufoenU9UA82j5QHx?=
 =?us-ascii?Q?MGnllJgqdHM7WEFqoiADhXDn1OdUTpHM0554GXWoQEWf0LcFLjwUviHm0ndS?=
 =?us-ascii?Q?X94YO8Dx/W2ypFbaOUGuoyt2jZUXWPT5BPqwgEhmF4EZ7kEdzQeMn0c5Z0rG?=
 =?us-ascii?Q?nKM4pWwGQgTEpktu6YkHkfVlMVJ1JkZrB3IozmtDMf6BSk7YLK9E3e4mPXIk?=
 =?us-ascii?Q?+yW/VTFUDugnGCm8f7rAvcxpgKYqWI7DCAThD0xsqKmPAa+ipmtAg2Z0FePW?=
 =?us-ascii?Q?XMSv1AhZU+nBKQhCQz3HzWz9vlLGG8TX/iPIFprGyUgo5S5yxOe/SbLsVYnK?=
 =?us-ascii?Q?S4F/OIOLot7E0EdZa+A5IJox4MPn0sb++pCm0SbuWnsonWKumhEjFmXJmWr/?=
 =?us-ascii?Q?kFyvVDFbtyb+MoB7wdEfF7XJKFWM67BwqNuln01ricHL2X7Zzgm1AqNTjov9?=
 =?us-ascii?Q?rVjKlBWvvy3zFIb2sIPiGnxO7C+oz4epwgTmiquuCk4d+9tfnQcQyyR7A9J5?=
 =?us-ascii?Q?tzi5qJ99Uh0IEuPgh/C0XojBnHEaiOtnRmtYH82ztzpi594eQiMxiy0M01Lz?=
 =?us-ascii?Q?Tbgl7YaQ5VAlOBiIz6vQYBINEMo9CESxOfiysbvtUF8l667DvrvRvilVxwXc?=
 =?us-ascii?Q?mHWCroyGa1MhtpXWO6mc4ZuPrNornwMoatAin4G6eAbbIg/85dozON2ffKte?=
 =?us-ascii?Q?mWBMdrMhZRJuFKhAeUEQa+6ry5FPdf5JLXSGAU0RehrM4zNFsNS403MhOk1/?=
 =?us-ascii?Q?lUr+aEwPlx63tSixHNEOeujg/qRnnYJ2T88YpEvugLQ+IxmAHjwXbUmHUfNV?=
 =?us-ascii?Q?EEAgUK3bBmEsoGfSp5HpdOdhEJQj+c5618bps1WUSEkuTysIQvxXaK5lRF3f?=
 =?us-ascii?Q?Z2xUSaw27rLKLW7zpPSqVRHsgYOsfb9p+9kNastWxcxnoqQoOIf17/xR7jJq?=
 =?us-ascii?Q?jKh0IjuGcuWxANx/l+s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cc9338-fa9b-4924-40b6-08dda7011463
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:23.7584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIpspeRV5wV/Je75/1hYD1v6+6Gc2944WdILPXykGI2HXD9o7gVIfD75uZ6mqJKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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
index 41eca47cfa..076da5b5a3 100644
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
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
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

