Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D426C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2198A40A7A;
	Wed, 11 Jun 2025 12:52:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
 by mails.dpdk.org (Postfix) with ESMTP id 442B640A75
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy38s4qFiEo+ruJ6KsFN+vHIyII7vU/HM4arpstBbLToCnNKFoHojpjuId+RYfsTLj9C/L+3MktwUc3IvzJdqHpXp6OaZlu27NllJUjUXM35m6HpUrcNbRpP5wQ7RtOuN5a6bS57+4N87KLz9KOJ2PNFf8YFygoGzvDWXejPhHFL4auhCQz/prtTyBCMBo7glepuAnRFRkCkSZdCbA6nQciChA4eiGh6AKQz+xswGYoU5mXHm+cOo7ZqQJRZCTYZW/e2HDZDCiXyBf4aORrZlp3SJy2UwxGOIijxP0OVxJpJZ2FBV6KdQnbYsfffDrIc0ZQy0Kg60QGeUsxahVtC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDVngQcPpRbOgG6y/N/a8B9ZhKDvE4ewP1q6orGq5DI=;
 b=SuYXlZ0lhW594+koODJ4WN9vEx1gAKa+oPVnltp2jDg937Upd5WpKfmaZxbzP+Pb9cdruS6xEbncWq4cM8DCylL9ROaztLqLXai8gu/Vfaw+F+61MC4+xiBgVZeBa9OCs4bATm6OmP/m9rH0AjiSeTZd/04UmF9X1WqKa0ddua4mFfqVDTysdlYXDxoMUm6CRIiyCbEZjA3KrI+gVG+irNLuS62I0r5UuA0UEHlFl+4QHarRm7leV/SvTDMa65bJABePJbg6JbZ8cCMmKZh6OPM8kevMwQ8QoiBn6RcRbs+hCRcLdRT7x3L6xJBFJlohYwN9djZvVmxzIltda9HcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDVngQcPpRbOgG6y/N/a8B9ZhKDvE4ewP1q6orGq5DI=;
 b=mq8cLCc2k+uvoCRndaUsZJOT7KvmmJm+XZW819kv5L3MfQT35ORvZRKVLodJIPNQf4lTtdpOLEuTlRS0C8+MUQDDYdxOQy2QcOCHkMY9FGHIPp9AqmahR3oWTLeN4MJ1AQWHP0/6Uqg0IFHVGBGjbD+8ZDhRscuLuWjAOaTiOZW6RetF3PCMCPtbYJKTkFQzJi3Bn9449SebWCQdoSyf0rvrPqsutAnNcvk0274Saw/aYR3jFXnsn3QjxWyldGQnjYkQHEm2mCS1gzsiXQET7g2C0IOQwPLPPOmKdRldhs5SscGM+oxrsinbgIQ3hUUeRPEKuaIA0mXQQm5A4W3/zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:24 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:24 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v4 07/11] net/dpaa2: support dpmac Tx stats
Date: Wed, 11 Jun 2025 16:21:45 +0530
Message-Id: <20250611105149.655144-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3c2a7b-dd7b-4c56-627c-08dda8d60c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NoN6eK1zvy35brUjTMWzz4VmgUkvlwmUZhFpr/GKnjLm9zx0cy6/tcsQRzB2?=
 =?us-ascii?Q?G/MdKmZDKn7b4KHaV2z8WvvebuEkHLXQXlNYWZS+BMxeklJe6C43bUi3bJjt?=
 =?us-ascii?Q?wmapxwvyBWdDHF2X2zRxCykCoXGMkadqWn1Wmzd/3HsVH6jbrwHd3hTMJ81f?=
 =?us-ascii?Q?SsT6uOowc2lTQwHWBEpbjdrVFcoCEik0yTPfiBIOFaoTGk9AVyoUJS7aVazA?=
 =?us-ascii?Q?N+1I1kn0uJkbSWXT46pWr2VkMhBLttCzYJxiMPnkLjJk1tNZUYlwZgiOVLNe?=
 =?us-ascii?Q?ysRT+RqRMHaNr+upBR6OOA4ja7zw2IVFUtUEZsHdZ91ZrJy6q4Je0M5tBQ3V?=
 =?us-ascii?Q?9bCrMPnMO9R3mIdCTttr1yWwlaOBBgWyL7icCZVUHYqos5HkW/W1nJREBAvT?=
 =?us-ascii?Q?HwcXhvlqbVHYPsM6FOxiHAzZqI3U51hgV7b6GumiT08ms85gn5mbgxqkd+Jx?=
 =?us-ascii?Q?EeGWiaMaSaXhoEnWv4rrfUloVbpMQLmsr+UrTSbX0fDXpu5/oP9lTIf01gVr?=
 =?us-ascii?Q?yR6CiqK8Pxe53pOx58pugBm9ll8PVtsUM8yf2BXdsOfwYhNpQLEgzkYddJ4N?=
 =?us-ascii?Q?ff2Ar/DFm4KXnLPh1SsqG2lV8kSUloJIlsuL0dQvsYlAvuSjdw52sKMauh3W?=
 =?us-ascii?Q?Aezzy2OCmGCdOUfbIPS4Pd1l+3lkpHfSxke8AkO2mTkI/b8KiTdEAkSscN/u?=
 =?us-ascii?Q?sZLa8TzN6oS3J0+fZCC/ZN6qZ6pvsjHsT9SUj2VuZLv121AycsPPwMem/0xy?=
 =?us-ascii?Q?48XtEvszyHsUTxMpz3+NmBhmDXkrRTlqjGpXUzFcL23nH9CJgqPaxdowk4Zi?=
 =?us-ascii?Q?r9JczBZ/z7j1YbvdYrA39EQrpu0acuTt8yFJuj7sST9nLHu2CrpmTtdFcBcv?=
 =?us-ascii?Q?G7Q+4fNUt7Xuw60mivHFDyKisTRANDoo8ES3/yLfLTdgePtTH8SqdQgtgBRk?=
 =?us-ascii?Q?FE8R6Hzezzc/0yKqRiSZgiccEKyctZH9EzlaDtEmhFNG3HXac+YucX3C+83R?=
 =?us-ascii?Q?UUpdmpT2rYpXwRjQPNORcqDBO2UKXPwcZ1QeTL+ui8Hf62IjaTide/dgSu07?=
 =?us-ascii?Q?8BnbVJG5M9EIEZNi+zRN1Gon6kJgTnpBT2lAWUk3Tqay/ScKpQVQ9gHPE9KX?=
 =?us-ascii?Q?r3J7yAbWzBN3jBTKbXrNv763WPyBignvi+hB1wAmnNhdLWRgcMrK6x3/jFNO?=
 =?us-ascii?Q?N0JtHNEP02SPj3vT3usHP/bPXlxUGzzaa4suJzbWOKX2jZ1OA/xj7ggNIYxd?=
 =?us-ascii?Q?NiQ5Va+2cHcFpfYEbaCTbjbLhnWklnl6+TtIho8Y6oqAXOIOQrBWBDW62p4Y?=
 =?us-ascii?Q?vs9j6G/2kPo88OWBhqm13G92QwnvS+FgRmVSG8Sv3eQGp1fCuJ9mwFS/OPUU?=
 =?us-ascii?Q?Bmhw+XD1wKB4D3kFCFX86HkGx7NL0iih39LqFOSUBmdavKaeqF6LvsxZDm2L?=
 =?us-ascii?Q?gdZWpBAW3LX0N7IFSZN38dCsZbaauisO6kjySPqbpf44SSd6aPexrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NqKha406lyVu6G4dGRYQndKv385pzTDOc0G8v743O4rVwlqq8dsyEwK3byW/?=
 =?us-ascii?Q?T3/I1y9nwEQJKKZVvgN1MM8V1oEt1B1rJ0ctG+9mIEMNYUtwxuj7A4dwz2Mr?=
 =?us-ascii?Q?seuK2tQAVt0uc3rl8jXQu0xc6OHJVk0Tz5QFMhk5WopWSA3lWkSQduE9nx8H?=
 =?us-ascii?Q?ffilJWijGPD6k2tqqqBmgSPki8GEx38oUocMLXY32xHC2r+VxXEuvyFr5y0l?=
 =?us-ascii?Q?5OkwQTLLaHQE0SKbhk/xeG2R+6wqgWt5ZEIYfcgIs8rsQirKg0Kf2v6aPcNj?=
 =?us-ascii?Q?ZyYrv6pQZAuiIy4zRUJJ6GeLdJGDor59F6cczcu2I6JNIr8i3uOLLS/R2YtI?=
 =?us-ascii?Q?CY7xjyzk0Aa3vnP23OrDQ9WL9WHu+LIaSacZ1A3sIMdG/aq0uQ6fePWrI+SO?=
 =?us-ascii?Q?+QttqUtAez3abWj8FVvXg1YHRnojNutVyxTR0k0LVuUUamD0DKLeJRGVsj+q?=
 =?us-ascii?Q?byekapWlSZ+35ceMNFZJa+CxNlBPb6paSfEjUpcLMqtMuf66REx+8WwwgxT9?=
 =?us-ascii?Q?Fr0EFNQ3vvXyDPpPWau7MP2vRMU09CGbkpYIkla0ZYSS7P3hM0YBIr5dqn2t?=
 =?us-ascii?Q?FsVEpp3xRGUP8f97Q7ur17oqbd9j3x6q5huJ8CrmtCcMZKGEo3XAapYovcsG?=
 =?us-ascii?Q?T34wsGuL7onRQMekhRTKShpGURiAusZBvOknKGbLZ3XMMsOrKsZJgomQtl+w?=
 =?us-ascii?Q?l/sbR2tNaP59+LIkedN6ylSeUtof2uYXRaRrcjbAFcG199URUaWmvxEAd8Su?=
 =?us-ascii?Q?h6RcKC71xfsKIFRN4rUIgFk3cVWKeC0qjOFcUCMNzkqCjawyojHqHLZVr+WI?=
 =?us-ascii?Q?NpEDu1WAzRIMNriBpZ7Vehfnh6GJZjDqcYaam9LDw0A0Ch+mJQ3eBplecpqA?=
 =?us-ascii?Q?3fKplsyMKh4N+SWOpBgih0AKkUYcFCQo0ZWJrAkZbWTg2F08axlEd7gOLltS?=
 =?us-ascii?Q?u5Y/Q47hIrR769lH/fiI44kZO7gHjVD8BCqQWFaH3kOZ/YvLnQi6q6R1dbUR?=
 =?us-ascii?Q?9onmk4Jj77t+n+RbdDwsf1ipDurIbH27zCIfOQf99WOW2nkEFvu7vAEQM8Rz?=
 =?us-ascii?Q?sJJzkAkOKZglvYIeR24YuogZVgggbJMdgRXS2fvw5dqaZ3BKdFHjIHiDp6n7?=
 =?us-ascii?Q?qkHszvefZPVGnCvvr7NKQ+SfRP8OSmHRkmXTAWUvv4vIkWpjWcAAjg//qcVO?=
 =?us-ascii?Q?FUWh6LJE1PdIWBy2xFMN80UAwrRA62CADc1/LjKqUm+vWUfpnmY9RLld9wiC?=
 =?us-ascii?Q?I0DdpWPEOF0xPeqgEdtNmiLufZNL24WDVEmzWNczpvb2RQd+PicmDd9x+84/?=
 =?us-ascii?Q?RsNcRfAmemNJn01C5hn0DYAHrIVMlZYN1gwEnYxCncK9RqohJvdgQTcUL/+D?=
 =?us-ascii?Q?d/CRWCnlk/79YshcW35e8n5ehinCTSLDSeeImMjzxt9/MmyTEHI3PpDJEP5O?=
 =?us-ascii?Q?/CGBUK+6Bf2VerxuZ99jHzko+7rY8yOv2xlAV3yQH/3EoTpaFhmSvdkOpgMD?=
 =?us-ascii?Q?ffyMAZoAeCafud2r5W2C4tOErbVN+s39Vhu8jvjhwP7g3VQrS56yLjOuZvup?=
 =?us-ascii?Q?0ZnvzApZyfW4g9f3I+8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3c2a7b-dd7b-4c56-627c-08dda8d60c5e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:24.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPSfi22QBW89DMzQ77TS2Vgbk5quGVkODS6tw2nMQmVOCzXqWFySI3HrWUoD9JU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

