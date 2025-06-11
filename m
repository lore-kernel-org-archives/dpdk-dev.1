Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C8BC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EFF540A73;
	Wed, 11 Jun 2025 12:52:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
 by mails.dpdk.org (Postfix) with ESMTP id D7C1A406B4
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnMVVguTNLBzqdXTN43MAuWjopQ1k4eNGHKAT59K5T7g+WM/6vLyqozvERHfwV0IAlngS4c054VXH4ii1Hm0rDsrNjuTURPydnPntsI4Y7AR8pCSpJWL8CKM0498p3MJjXGQxXcvcyVoZWb7qjgkLXB+MJJGAqZ0FCWeFUGyWf/MHiMJydS+HdG6fusO6+6+Dk1FsBoKbOis1K/pN19NYDEI8YNgKe+Lqe6+QVYn6LjrsL4lsEYmWwVZWXDWc8a+7PxcK1foctn0VIazklg5h5IhqaMHPgpJBdruN0VGr0xZFsnlozq0KnbXnUJtO/mzFiFnogv61AaSiXSnESYleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOMbUqGrgsT3siBQthP6qCm5TmvxfSrr/+ddPsIZacE=;
 b=aAq0ObhYjrRUGNdZpEFJXycHEDO3Uj1jn+KfGzEHTMYXd0MgPz35KdxooxlnLBpPRx4CqIN0mV19/kcY9Pr2RkRS/RN+E9k4idW9h+5i6gCJ8AlJJDAire63Kp9mbZ2ZlFyblKo9Az2hvT6E93TzLYbSRkI5oA+XC11jZT6rjNQ5sd3V1s4OY25DJ5ft1KlT+Hb1Qim048hmXHCw3rxpuSYqyfk4w43mu0Gnk1SXkaiAmQDWjCC0da0X9Q4OZB32bulTeMdntAn5CQm3xX4jg0A6qh5wLnyMgLU3dwmPRJsvUWYWTXH06YsSBPw/TW73CXtCfBKaT1Gz9kBbSl9pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOMbUqGrgsT3siBQthP6qCm5TmvxfSrr/+ddPsIZacE=;
 b=j5GKb01LfajYzHG/ixqNV1M6DRD4gbP8NHbdAOZV+l/8R5v9Zt4KkTzwlblexUNFV4kyBotWsuP+0sIEWj39cCZAH+duIbl9gOCMITsY8/b6mPpksnmtXj0gm7mNMFl/YnOyFNBnRKWa1728Yd2vec4SgMu04rTAvBS4tlgmEUYDfCP7su/2ss5vdzO6pyaY73oauH0u3BBKV8vLi+sruGP7vH8PhDAnbhFSK+sJ+d7DSxhKxHe/gOSDdZeSosh+WZ/aQVYHAqJsYp8lK+d/zoIAGkeEbmif4+eGIfsRhEP9LI0L56oSNebYO0Rvvudja7Bv6iCO8bi0mvxZ6Npw9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:22 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:22 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v4 06/11] net/dpaa2: support dpmac counters in stats
Date: Wed, 11 Jun 2025 16:21:44 +0530
Message-Id: <20250611105149.655144-7-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbe54521-9c8e-432f-6d8f-08dda8d60ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7M8//ycCVtvlOn39UNjLn0a8I/CQ34JefI4+VXuDQ6/ykXQL32XVW6lBeKn2?=
 =?us-ascii?Q?SJQAmugCBavO0IncrtxhKYvP4CJ08mLZ9WXZXh65n29I92oRVl9cddVHy33B?=
 =?us-ascii?Q?npt77KXwaDIShqTXH1Tz32AZGyMN9SLZtuA0X1pUecY/gUjHLWp652Ef8HHe?=
 =?us-ascii?Q?gd7zkR5YuWXFKI/Nx2vmpvYoCwFXzWLUfX1yINM3GbfOlKLEhGHBFeGOvcwh?=
 =?us-ascii?Q?zhL678/tqUkFiUUIF5/NgTbCX75Ao6vqtXDby4Eb83KeJ3zwssJuvSRHSWIW?=
 =?us-ascii?Q?2JKoMk15m8KNLQbjkxdXEwQWOSy80ECWYkpjQ0j8GXSqRskGIiLQaTh9s5w6?=
 =?us-ascii?Q?8JNaymNXcrTBYeAmUs8w1AKsucLSY5JCu41s8mgrc7AERbL1VnTHWf/zadVJ?=
 =?us-ascii?Q?Mvd4ocXKvBm0sP39h5rXhay2KcpqQ7CoF0lmiAOQ59sEwCNHYZgUhtaSyboO?=
 =?us-ascii?Q?vB5YIBNVKbddadNC9jaGOKznfVWfmHafaGZuvfO5zPhqBvCqJGBuxhmWNLPc?=
 =?us-ascii?Q?tLrJh5MgmxPMmedWTQFY8GUw56niMhCjkWoO/vb1mrvI6t/jYVx6ZwaXevYo?=
 =?us-ascii?Q?03s2OlDo97e16H6xfnXNGZuUlV3xHjge2aS2aHKxuO3OPS7XqRexyzAKdW3E?=
 =?us-ascii?Q?wXwvw8ttY4BJVtevYsYw20E1BAVig4YnkB7nWjPGyeguNpcq0uFZE4rHz15l?=
 =?us-ascii?Q?VUeHlj0F+Pkgr9J75gSWWUyuMF8+VVRl8BnkVAB6JQuPCqw3bD+OMKYdIl4d?=
 =?us-ascii?Q?BZgODbKQ/yu05dP3uBfn4Cs7Wu8xcpfiLLK0ROV+6ZtYucEFk+gL+JuFNqa0?=
 =?us-ascii?Q?+5MxUYbolLEpIhv3Is3QRQbqLKBnmct29qsD8RUG72QCxtBU9MmqPrMQ2wmp?=
 =?us-ascii?Q?ezJiabrywVcprEkt6iydkj6O3mR7gFdpCqngkdtJZ6VaSahsjdBbxwl565nw?=
 =?us-ascii?Q?+NQNw0AGNeqx8TAZagqp5v6NS1e/ZXW2afPhr38GP4YniIB70GQp7vjkHPn/?=
 =?us-ascii?Q?+dtoUUdIuQ8TyZH82k+XJ0CEcenldS/Yi0Wc6I3ax1+Daf3P4WH+FA5yvaLj?=
 =?us-ascii?Q?jMHmPcLby+v5FE0JjjJkqjtPSR8lEurXXn0cja9CGPEMAetkontm+m4/7RgW?=
 =?us-ascii?Q?iMRtS7dNGZSixxIugRlQJzGllULVbBqLylvnGSydZYXgCfDM5Hayst/rMON6?=
 =?us-ascii?Q?MhSDpKSXJSy0jNUn0nznOC6JtdpO3W2kHzW5vJmF5SEJXEiH257O6XiQqsLx?=
 =?us-ascii?Q?hXrJp+bovXYMkUfTbN65M4QG/AA9R/rSHj2pGWGY1micGsdEy5gi2uGkzhBl?=
 =?us-ascii?Q?ioaJr2sHolhs/t7OT7K4JkO/jNHsIZRUi+S4sd/2mR8oJPuci9nSuDYAn2qX?=
 =?us-ascii?Q?30ryagYQTSGwbuW3mT0kMfYeyr0lFqes0xkV+jIneXiNxjZCNcATZVSLewsY?=
 =?us-ascii?Q?PfAFAtlKePLIdCzL1u0dzWilhr/gJmblDEcBG0bIvF2TZyvxcveUiyDx58Aa?=
 =?us-ascii?Q?eJ0AmarYocdQ+P4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTKXslgDoR76K2OFKJQLzu/vaOc0u+FD4C7eNxcgMypENtFLhRETJxLkUtOE?=
 =?us-ascii?Q?D0Zyjulj47/i56fLktMGPQYLUIZsqmwYdkojzo24lk33sVuo2gtY9j0jkc8w?=
 =?us-ascii?Q?8LcLrdx1I6boQlxK5HylnDCdGO3MftHhuj+LcB/fH0PTSHtxbo5fyhjkK5ea?=
 =?us-ascii?Q?GfWdl9BZazdwvbaLTf9/rxO15xBsC6yQXRZd3ZaLs67DdIjDgt+s6TKaIZ9E?=
 =?us-ascii?Q?zwJGtmfQWI1jHmIc29sj53dSvrVxRuYbm4LXnsLRjSBuVVg2XqHAFxGqfdng?=
 =?us-ascii?Q?TDZYKqItOpEztafKbdfqvqC5YqK84Lx8x3p1SXt8/rE+DzYbSI3/f+1Mupnq?=
 =?us-ascii?Q?4889lt69Qugvhci1lPNs6G6y3RybfLglOW74FYa/WtI1tYFtRqeYuLQY1JAd?=
 =?us-ascii?Q?63luc6woIY6iVV2GoYqekeeJ2cOhpoLQejNQEJfeZM++SHDj8DoSDLu66cx4?=
 =?us-ascii?Q?qeGQ1bIy0fga4Tbp24WrLQut+1nkQ7ISPWUvduGH68ZY1EwCPbDjLfhjLNWb?=
 =?us-ascii?Q?FIVxUroqbf5s70iCs8X5BpPPXB+aJ4Vf9ztWp8jPc1W0nMyspkLubw9H9Ur+?=
 =?us-ascii?Q?/T2YFAvjP7mFm8YP9yXlrtH6JkHJRGKvLFnV5r0liF2MXBopNCpaRCKTbq9V?=
 =?us-ascii?Q?ZkuZBW3OGtK0XDi+d0iol2Gx+7HF06D0omnpqeaQs84UF9N79GHH7U/oXEBZ?=
 =?us-ascii?Q?OWlRkvamGIK6qc/CwWv66fGxhNpSNDBwBXftn41EKsqtXBrqrom4HCRlkUgv?=
 =?us-ascii?Q?6UTAxlQIhIxSLkCgd0dt3yPS5/4g511HNH7FZbZ9KuWV5VEvhK2dQH1mfKYQ?=
 =?us-ascii?Q?epBflnlkqRRoT6c07Pt8lztwztr6gw6c332KkSn0WbuhxzduvyiWa/kvPmvM?=
 =?us-ascii?Q?TyGc5ZkcJSXwUKyjZwSENLnDGO5z4eOiJs53J4/PuddH14m5KNoPWTL7gfLu?=
 =?us-ascii?Q?KfVA6LvDCpenqbGR2kIrgVUw/O/v09BowirYLKe0BAKQ+F7ZyK1l7IMQRowS?=
 =?us-ascii?Q?tNcRbZFTUF7KODIpi0pYJEt/W0odtLp0rjd6qvGTC0OtdVbMYAmkm6u69O2j?=
 =?us-ascii?Q?xNRMSsu1nHC11xIscKw2IgkuvFcHlugcNzboPV5xR5/g4BZgx+P+qf4JTj8H?=
 =?us-ascii?Q?CGPaHObMsmc8EjVlPTJcFoDAi3/dd2Z+uhu2342BstcvS+75hi+zMMXLbZaZ?=
 =?us-ascii?Q?p3NfvDgi+pZv3ec1vF0gR7BLsze9Wo36+q9of3e3MD4kjsRwAaLlgUcmSzgl?=
 =?us-ascii?Q?d0xv8MfviAO8OCHLHw8JxtrGJR9XxcmHnoCMCxUbtisxq9MRI7GkhW/pqlIJ?=
 =?us-ascii?Q?4fmmPBVFUi0QMBpbhsXmJQV4IlLHeBTGXnBUmVtiDn4o+19+gExe4HiGqAJs?=
 =?us-ascii?Q?Bgp+2OGK9hqLZRWjx67lIiAVKacg7fgCw+SSxPnGFHKEIvKl63NsHffFUz6E?=
 =?us-ascii?Q?dZMdkrBRAsQFwPEwMsBjl0R6/T29klnDq4x/IcIQFmsD2K7/eKuwXqVmwE/E?=
 =?us-ascii?Q?fHehRDlPgCmt6Od6VsXTOck8R2l+jw2Enj9t1su0bazSbr8V0ulcFwI8D6K2?=
 =?us-ascii?Q?lUBHzAxHvoZIhqUrzdo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe54521-9c8e-432f-6d8f-08dda8d60ab9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:21.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0zCEQT9DSTFrBOePjK+kzAwyTaMUb926jb82W09DD4JW2B/cjAFfPHdEjyUStgX
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

Add support of dpmac counters in xstats.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c    | 118 ++++++++++++++++++++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h    |  12 +++
 drivers/net/dpaa2/mc/dpni.c         |  29 ++++++-
 drivers/net/dpaa2/mc/fsl_dpni.h     |   3 +
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  11 ++-
 5 files changed, 163 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d17785a6ee..bbf4df69d4 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -106,6 +106,34 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"egress_confirmed_frames", 2, 4},
 	{"cgr_reject_frames", 4, 0},
 	{"cgr_reject_bytes", 4, 1},
+	{"mac_rx_64 bytes", 0, 0},
+	{"mac_rx_65-127 bytes", 0, 0},
+	{"mac_rx_128-255 bytes", 0, 0},
+	{"mac_rx_256-511 bytes", 0, 0},
+	{"mac_rx_512-1023 bytes", 0, 0},
+	{"mac_rx_1024-1518 bytes", 0, 0},
+	{"mac_rx_1519-max bytes", 0, 0},
+	{"mac_rx_frags", 0, 0},
+	{"mac_rx_jabber", 0, 0},
+	{"mac_rx_frame discards", 0, 0},
+	{"mac_rx_align errors", 0, 0},
+	{"mac_tx_undersized", 0, 0},
+	{"mac_rx_oversized", 0, 0},
+	{"mac_rx_pause", 0, 0},
+	{"mac_tx_b-pause", 0, 0},
+	{"mac_rx_bytes", 0, 0},
+	{"mac_rx_m-cast", 0, 0},
+	{"mac_rx_b-cast", 0, 0},
+	{"mac_rx_all frames", 0, 0},
+	{"mac_rx_u-cast", 0, 0},
+	{"mac_rx_frame errors", 0, 0},
+	{"mac_tx_bytes", 0, 0},
+	{"mac_tx_m-cast", 0, 0},
+	{"mac_tx_b-cast", 0, 0},
+	{"mac_tx_u-cast", 0, 0},
+	{"mac_tx_frame errors", 0, 0},
+	{"mac_rx_frames ok", 0, 0},
+	{"mac_tx_frames ok", 0, 0},
 };
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
@@ -1713,16 +1741,67 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	return retcode;
 };
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint32_t *cnt_idx;
+	int i;
+
+	priv->cnt_idx_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_INDEX_DMA_SIZE,
+					   RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_idx_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac index");
+		goto out;
+	}
+
+	priv->cnt_values_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_VALUE_DMA_SIZE,
+					      RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_values_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac values");
+		goto err_alloc_values;
+	}
+
+	cnt_idx = priv->cnt_idx_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
+		*cnt_idx++ = rte_cpu_to_le_32((uint32_t)i);
+
+	priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
+	if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
+			__func__, priv->cnt_idx_dma_mem);
+		goto err_dma_map;
+	}
+
+	priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
+	if (priv->cnt_values_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
+			__func__, priv->cnt_values_dma_mem);
+		goto err_dma_map;
+	}
+
+	return;
+
+err_dma_map:
+	rte_free(priv->cnt_values_dma_mem);
+err_alloc_values:
+	rte_free(priv->cnt_idx_dma_mem);
+out:
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
+}
+
 static int
 dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	struct rte_eth_xstat *xstats, unsigned int n)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	int32_t retcode;
+	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	union dpni_statistics value[5] = {};
-	unsigned int i = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	uint8_t page_id, stats_id;
+	uint64_t *cnt_values;
+	int32_t retcode;
 
 	if (n < num)
 		return num;
@@ -1748,8 +1827,8 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	if (retcode)
 		goto err;
 
-	for (i = 0; i < priv->max_cgs; i++) {
-		if (!priv->cgid_in_use[i]) {
+	for (j = 0; j < priv->max_cgs; j++) {
+		if (!priv->cgid_in_use[j]) {
 			/* Get Counters from page_4*/
 			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
 						      priv->token,
@@ -1759,13 +1838,38 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 			break;
 		}
 	}
-
-	for (i = 0; i < num; i++) {
+	while (i < (num - DPAA2_MAC_NUM_STATS)) {
 		xstats[i].id = i;
 		page_id = dpaa2_xstats_strings[i].page_id;
 		stats_id = dpaa2_xstats_strings[i].stats_id;
 		xstats[i].value = value[page_id].raw.counter[stats_id];
+		i++;
+	}
+
+	dpaa2_dev_mac_setup_stats(dev);
+	retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
+					  priv->cnt_idx_iova, priv->cnt_values_iova,
+					  DPAA2_MAC_NUM_STATS);
+	if (retcode) {
+		DPAA2_PMD_WARN("MAC (mac_*) counters are not supported!!");
+		rte_free(priv->cnt_values_dma_mem);
+		rte_free(priv->cnt_idx_dma_mem);
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			xstats[i].id = i;
+			xstats[i].value = 0;
+			i++;
+		}
 	}
+	if (!retcode) {
+		cnt_values = priv->cnt_values_dma_mem;
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			/* mac counters value */
+			xstats[i].id = i;
+			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
+			i++;
+		}
+	}
+
 	return i;
 err:
 	DPAA2_PMD_ERR("Error in obtaining extended stats (%d)", retcode);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 4e3e0338aa..ba67fd8b0b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -18,6 +18,7 @@
 
 #include <mc/fsl_dpni.h>
 #include <mc/fsl_mc_sys.h>
+#include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
 
@@ -133,6 +134,11 @@
 #define DPAA2_PKT_TYPE_VLAN_1		0x0160
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
+/* mac counters */
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_GOOD_FRAME + 1)
+#define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
+#define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
+
 /* Global pool used by driver for SG list TX */
 extern struct rte_mempool *dpaa2_tx_sg_pool;
 /* Maximum SG segments */
@@ -417,6 +423,10 @@ struct dpaa2_dev_priv {
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
+	/* for mac counters */
+	uint32_t *cnt_idx_dma_mem;
+	uint64_t *cnt_values_dma_mem;
+	uint64_t cnt_idx_iova, cnt_values_iova;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
@@ -502,4 +512,6 @@ int dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
 	struct dpaa2_queue **txq,
 	struct dpaa2_queue **rxq);
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 558f08dc69..f651f29b02 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -3493,3 +3493,30 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+/**
+ * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt)
+{
+	struct dpni_cmd_get_mac_statistics *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_STATISTICS, cmd_flags, token);
+	cmd_params = (struct dpni_cmd_get_mac_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 3a5fcfa8a5..2f8125314c 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -2014,4 +2014,7 @@ int dpni_set_sp_profile(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t to
 int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 		uint8_t type, uint8_t en);
 
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index 1152182e34..f653f2c0e4 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef _FSL_DPNI_CMD_H
@@ -9,7 +9,7 @@
 
 /* DPNI Version */
 #define DPNI_VER_MAJOR				8
-#define DPNI_VER_MINOR				4
+#define DPNI_VER_MINOR				6
 
 #define DPNI_CMD_BASE_VERSION			1
 #define DPNI_CMD_VERSION_2			2
@@ -131,6 +131,7 @@
 #define DPNI_CMDID_SP_ENABLE		    DPNI_CMD(0x280)
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
+#define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1024,5 +1025,11 @@ struct dpni_cmd_sp_enable {
 	uint8_t en;
 };
 
+struct dpni_cmd_get_mac_statistics {
+	uint64_t iova_cnt;
+	uint64_t iova_values;
+	uint32_t num_cnt;
+};
+
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.25.1

