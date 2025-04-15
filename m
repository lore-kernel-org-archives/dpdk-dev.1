Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C5EC369B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 02:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7FAE40647;
	Tue, 15 Apr 2025 04:55:22 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
 by mails.dpdk.org (Postfix) with ESMTP id 320B64060B;
 Tue, 15 Apr 2025 04:55:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLhu5CBkjGg2JWCitgWs8gb0ZU4COX9DwtazWxVMT26/hfQmn/WPNA+43VXFqai0c6+txRT9RtR0YFV2Nqm0Ewpj/SC4gGeNTO7cDIwAi8xvydJmC5UvIm0vvExHyQSY4qMma5oCS8TPD0870JKdUt02qzKSNsKeLbwGpbo/uR+kcpD69gvNs13iuj16VTNQA5jfC1/Q44Ym/HGXB9tMxnYGXidtGUOpry0abBDIVXadwmhPojWITFyDCM+qu4lWrVYaHeetqleRjitpxKf4qmtcrD5tV48P3HNC9WaNZsmw3bc3AZPRpQqdWJJest+J7YbdZsuEAMtEfT3CV6Hvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqGISBVFfaKl7/MPnnk7zKDEAwecGGouFFwN0RVsi74=;
 b=YHgcP3VM6RXCzcGu7/0ZI2a9b9VguknFX7YlylzGim1cEiEN5uoXHRqfvbuF9lWAyoMw2Ducy2+HI7RuiIrd3pMkTqWDvcMMnotovVSBHg8/Kesx1l1+Va/cnjPZwz9rNdoeF8wp5lc1kKlhqFS8SlKKarxHnZqOBsZJ7p/BC3UNE+33jS/HqMjYeWCQX6uuAJ4LQjMJ5zSiGL7vswqMQXxRiyF9zpYKS11FW2N3xkFCAnew2ne3Q8KvUInoMhvJWHSLDAEPIb5SiC/n3AfB4DZtqoDPhvIMOvtbnh7qyrfSgdEuFR0xzx2LmM++jnvUZLSpHdMzbDe0fapqWUOIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqGISBVFfaKl7/MPnnk7zKDEAwecGGouFFwN0RVsi74=;
 b=j3mDqoZbwx94rkyUSpoiqC20PdU/OmIH92kDlnG963rSyEuCVFMQ/orEeeS3OSiDwvJ6XTaxGnbukTDaFLtfI4nZeO2qbm8+venYcVl7fv6niqKE2LumwnBWe4Z5ouYwcv82hnqUvNJyyz+zItp3IAiRDFZALGeguZswTSefJqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA6PR13MB7010.namprd13.prod.outlook.com (2603:10b6:806:40a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 02:55:19 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%7]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 02:55:19 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 stable@dpdk.org, Long Wu <long.wu@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH 2/3] net/nfp: standard the data endian of NFD3 Tx descritor
Date: Tue, 15 Apr 2025 10:54:52 +0800
Message-ID: <20250415025453.1348238-3-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250415025453.1348238-1-chaoyong.he@corigine.com>
References: <20250415025453.1348238-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SA6PR13MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: c01893d6-c6b0-4325-696f-08dd7bc8f4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ijOUn34FtQzFgx/WU6AeWoqrIjLciPv4rJXJIYI1MkP+O+MtDw/cso218HDU?=
 =?us-ascii?Q?Y7U4VLAjujv7EtILVz20m9BSJV8q8imj2xuPezUdeeorqv/50x913v3Se5Hb?=
 =?us-ascii?Q?uvZVe5HIKLLV46BRNjELpBFAhjhgMP7mnv9MA3Oamj8nqbgkIW+/Y/reoQhk?=
 =?us-ascii?Q?7HjzqqEP2oD8FjRyDs0VkTVFO4sfSAq1Rp1nr07zLpErTGK/eph+4QEDC8Oe?=
 =?us-ascii?Q?47o4ad+qPw2fJIg01rwCq1XW7r+AZ9XyKedmJPgFN7mhDulhnNF7rKe87P30?=
 =?us-ascii?Q?a3LSt8QZYXzZ1HHEE1MACzUiPpnSp+imOQAu6k5Y7hRSpxaOHu8liSgSKqtu?=
 =?us-ascii?Q?VCn8zpHfyrqRnBUFeSWX0tUmNyW/pRXg+kr0rC25O0JgoUm0im/f/i3hFxbH?=
 =?us-ascii?Q?zC0vTPOf2rAy4BlVe1mEytHLtUG3AUcHMj76WYFDiZ9SZOPX8N0OVoqvKJxT?=
 =?us-ascii?Q?pUAFsRZhxb6Vbpk3dxyk5lgJtJ8wqxElT4zTUAzvvpz89fqroN3qnZcwMgXD?=
 =?us-ascii?Q?z+sYwwsN1zxZM66slFDEkfI5m5b/7+IDwhjNo8ZFT/ukrprZoxwyrA4F4Ja6?=
 =?us-ascii?Q?Mjeub3EjV7sfCtKTUSQyDQ0yEPDRZPeZFgN/tVc5wuiCPssKUXne5QEGwgZv?=
 =?us-ascii?Q?Q0PujK5wL9iIucrYjNGkNg39VHYHSZ1cnpTRZa4esVU5LTPNYvk0OF6bNZsN?=
 =?us-ascii?Q?faY9CToNLYu9VIBLuIzjgJhiGoWEaXLs9P2djoOl1JJkrTGFXXI5od728CGo?=
 =?us-ascii?Q?hGJxlDHDjZCPm519Nj8AXCKXZomelk/+WtBvugYL2usoOK0OLPfW6712if+q?=
 =?us-ascii?Q?5T76xqQ7wmWUq8Ba4LXZ56Faakjohvj5vie6OuLn3AKO+IoXngAnd1+CHEMm?=
 =?us-ascii?Q?xEwpkTgh7FfDD62Yzn3zheLBJUBOth4sVGIxDmBZB76xjBP5S4D5Yal+l/PN?=
 =?us-ascii?Q?GCCs6OfRZ84UUw7JpvNGiuWgtaZnp/HVrVgqxWWQejeF2Xashyr7Ag3Vk5N0?=
 =?us-ascii?Q?ca9BE/O073yPPHC5CTBpWxJelR/gUmGv+xYefqv1eWo94ZjWcpmZnlQmQWtV?=
 =?us-ascii?Q?+xr2n+9GD8xDBdxmm6bTMBVwKYw1HAmYPWq0lbuNXngBM/WBYt7Z9tbPJzA7?=
 =?us-ascii?Q?AGGTj3Oyhlz8oXo3oUFWVVdA3Anj2aneOImgcn466tlTqakkjqg8pZDogTW2?=
 =?us-ascii?Q?tOVT/Gfmr3wxNxNTNdYAfWeBCmwDFwOt3qaU8M2DcmFF1aFZ+4ONpHL7vfjK?=
 =?us-ascii?Q?i6n669GvI4y8i+Jy+XbeS2w5p5Y089EdBOKv+6eRPxe/fhlHq++OpUeXvPPI?=
 =?us-ascii?Q?heOtASPP2idx2moaTVThwzou9xfqAYwpaNOX5P0OdqgJZ0AI5cbA4KfeEmdG?=
 =?us-ascii?Q?fMvDUu6VCoNou2pV3n28ejEateIOj19Zo4p22czSEzYVd4CK6/l7gqcx2x/l?=
 =?us-ascii?Q?DkxNPbbMmm1/WFojZbbO75tpu7k9/1HHDvz5ESswcmoy1Dyz5b4lPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKjooISSsq0NjTMs3JLovDrTZpymv8vO/ILGW9uYedH2p7VXBKfxv1pp44lK?=
 =?us-ascii?Q?IEoOxHUoxQ9s3Yk9mutN0Uh3DA8JLgmmyJ2L/X9Zb2uh/Hx8WePXPYtBcer6?=
 =?us-ascii?Q?pi9s4kkPGAyu9VGETts3KIuTGtSA/+2nVuwbHN3gMnwq+yEk6sx30AlC2MSH?=
 =?us-ascii?Q?w55S8Pyw0XW3Z5NI78RhZockE9z4HczKrTftfPZz/qGSsfZtLT6/PpolxQ4k?=
 =?us-ascii?Q?QqumKZ2fHsp/S8M7BM663YuAXKfW8FDXZjV3eF38aLWVgEx1pgO6T6gWqTkE?=
 =?us-ascii?Q?gsWAvlK8lPsPcREJUAGnmrKeDXd3TvFOpxFi7AGEqwHSN29QQ7wokFk/j272?=
 =?us-ascii?Q?eCAIliaT0q/TUvQ2JxDq2sjE5KDf3LOzCuWJR1RhKgfEKGjFXdW6qmwHXfZW?=
 =?us-ascii?Q?Qyf0EfEgSXNKtpz3UisleTmJmmXJWKlOOVq+Tn8yJ2uc4ZJ/qImus41582e3?=
 =?us-ascii?Q?mrgG+TZ1xOooFfg0Uv+8IOlFZNEXvpU5g7S0rPq79N0A+QAzlefS5PW+NjPr?=
 =?us-ascii?Q?vv1GI00LXGVgF4b5oNNIGuccBAXzVGAlaFP9A7a+hRGNNa4TWHQTkkxG+WEs?=
 =?us-ascii?Q?zwu5A+EiAQn57PHO9MKSWAHZCMDHL35tmO5gJtrCLu1NrkA6C/ANiuXvuXY9?=
 =?us-ascii?Q?l+AgHEdRqUGgqzNuoNjIOQjdkU3K6dQRHAco+O0dAAHMd9Fe2v+mhrPCuNza?=
 =?us-ascii?Q?c+0Mmldx5u0cKGZqHu+VoHfwjs0v55n5/Ix4+xhai+JS/9DC386TrY6Yswtn?=
 =?us-ascii?Q?g8pwG2lhM3q4FLwwisLeoRsjxnxpL1jhc43YFNRUVYEmf8n3K7/9wt0gWi5l?=
 =?us-ascii?Q?54pvPv2LdcrFWXcYrZ+yLMaSD+8c0IV03q5THNpUu5jWia5+71zzcaNb54XQ?=
 =?us-ascii?Q?UDO79SPQIN/H6wULCH8V8SRF7KooMPL6laMejyvLUGxVnum3dNmXbCBUti3Q?=
 =?us-ascii?Q?9AgZd2I0OuoggDmtA5EG3vggJ5A2ZU+7sIy7vEACOPF/JfwJ6HEZm4sN6cRi?=
 =?us-ascii?Q?aYRQoqy9y4yxhdoRtz63TdzsK+2RRYIQh6Qo+PXov9S63zu0kKf8/s8BOFpG?=
 =?us-ascii?Q?6fegtU9djoFPfxTAcDsodoSo2KLNGUG8UEnWbupJGH1mNeGaVGRWnvOLjsYf?=
 =?us-ascii?Q?/hPzmP6CzjSPdITMjAatJYrNMuqP2aYeB0JPv6ovVrFcIvzpFM0rwJbuWM9Z?=
 =?us-ascii?Q?MEuWNQLeg8Agcs8ZwHF14pZ3/BSiFNHSR6tcXVeXOkBmVbAG/qwzyzUTIE1q?=
 =?us-ascii?Q?Dbp4LMyv8g+2DhR+MR7VhtPjnIQ+N1khSklikAy05/WyVHU9A2VO7UjthiXw?=
 =?us-ascii?Q?/IsvCwaLZ1yjEIVEtjv/7lnmsQOpoBhj3eZZN7hPLffmeMf44FuRpn5UAsuG?=
 =?us-ascii?Q?XToCdrebtcM2C+y8UC0toxKOiefQqLJ3fNq9xPzepeCuqQ9pBePfZsGsgZtj?=
 =?us-ascii?Q?MXXW4+iOXbhiUhbwZbRvyax4QqGR3B47Yb9t0wGl25PCw2mYSIphTsLcSQZh?=
 =?us-ascii?Q?Uscu9VAAzcqFj+04XSchkkilgnyHHZED7d2V8i13EJo3aBFTJL3Uc5HyySrn?=
 =?us-ascii?Q?x0nb1PJvJQbzyxNYPjr+AqrEi1BHcrZWrzY90Ul9j5WS5uQA1pl41BpeTqhC?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01893d6-c6b0-4325-696f-08dd7bc8f4e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 02:55:19.0864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkoTCX9fchboSf9nkLa9GUFMXnlTnOiBHVdWi0hf3Tk23lRC9EniTIkZ9dCkibvRS2/OFeQX7yw3nyGrq60LFBj7GSivNKRNAS3vwW48MhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7010
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

The data endian of NFD3 Tx descriptor should be little, and the related
logic also should modify.

Fixes: 3745dd9dd86f ("net/nfp: adjust coding style for NFD3")
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/flower/nfp_flower_ctrl.c |  4 ++--
 drivers/net/nfp/nfd3/nfp_nfd3.h          | 14 +++++++-------
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c       |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_ctrl.c b/drivers/net/nfp/flower/nfp_flower_ctrl.c
index 23d1b770d8..6ac2caf367 100644
--- a/drivers/net/nfp/flower/nfp_flower_ctrl.c
+++ b/drivers/net/nfp/flower/nfp_flower_ctrl.c
@@ -194,10 +194,10 @@ nfp_flower_ctrl_vnic_nfd3_xmit(struct nfp_app_fw_flower *app_fw_flower,
 	*lmbuf = mbuf;
 	dma_addr = rte_mbuf_data_iova(mbuf);
 
-	txds->data_len = mbuf->pkt_len;
+	txds->data_len = rte_cpu_to_le_16(mbuf->pkt_len);
 	txds->dma_len = txds->data_len;
 	txds->dma_addr_hi = (dma_addr >> 32) & 0xff;
-	txds->dma_addr_lo = (dma_addr & 0xffffffff);
+	txds->dma_addr_lo = rte_cpu_to_le_32(dma_addr & 0xffffffff);
 	txds->offset_eop = FLOWER_PKT_DATA_OFFSET | NFD3_DESC_TX_EOP;
 
 	txq->wr_p++;
diff --git a/drivers/net/nfp/nfd3/nfp_nfd3.h b/drivers/net/nfp/nfd3/nfp_nfd3.h
index 96ea23b3df..dc24f4fa1d 100644
--- a/drivers/net/nfp/nfd3/nfp_nfd3.h
+++ b/drivers/net/nfp/nfd3/nfp_nfd3.h
@@ -17,13 +17,13 @@
 struct nfp_net_nfd3_tx_desc {
 	union {
 		struct __rte_packed_begin {
-			uint8_t dma_addr_hi; /**< High bits of host buf address */
-			uint16_t dma_len;    /**< Length to DMA for this desc */
+			uint8_t dma_addr_hi;   /**< High bits of host buf address */
+			rte_le16_t dma_len;    /**< Length to DMA for this desc */
 			/** Offset in buf where pkt starts + highest bit is eop flag */
 			uint8_t offset_eop;
-			uint32_t dma_addr_lo; /**< Low 32bit of host buf addr */
+			rte_le32_t dma_addr_lo; /**< Low 32bit of host buf addr */
 
-			uint16_t mss;         /**< MSS to be used for LSO */
+			rte_le16_t mss;         /**< MSS to be used for LSO */
 			uint8_t lso_hdrlen;   /**< LSO, where the data starts */
 			uint8_t flags;        /**< TX Flags, see @NFD3_DESC_TX_* */
 
@@ -32,11 +32,11 @@ struct nfp_net_nfd3_tx_desc {
 					uint8_t l3_offset; /**< L3 header offset */
 					uint8_t l4_offset; /**< L4 header offset */
 				};
-				uint16_t vlan; /**< VLAN tag to add if indicated */
+				rte_le16_t vlan; /**< VLAN tag to add if indicated */
 			};
-			uint16_t data_len;     /**< Length of frame + meta data */
+			rte_le16_t data_len;     /**< Length of frame + meta data */
 		} __rte_packed_end;
-		uint32_t vals[4];
+		rte_le32_t vals[4];
 	};
 };
 
diff --git a/drivers/net/nfp/nfd3/nfp_nfd3_dp.c b/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
index 3ffcbb2576..6466a5a4fb 100644
--- a/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
+++ b/drivers/net/nfp/nfd3/nfp_nfd3_dp.c
@@ -139,7 +139,7 @@ nfp_net_nfd3_tx_vlan(struct nfp_net_txq *txq,
 
 	if ((mb->ol_flags & RTE_MBUF_F_TX_VLAN) != 0) {
 		txd->flags |= NFD3_DESC_TX_VLAN;
-		txd->vlan = mb->vlan_tci;
+		txd->vlan = rte_cpu_to_le_16(mb->vlan_tci);
 	}
 }
 
@@ -300,7 +300,7 @@ nfp_net_nfd3_xmit_pkts_common(void *tx_queue,
 		 * Checksum and VLAN flags just in the first descriptor for a
 		 * multisegment packet, but TSO info needs to be in all of them.
 		 */
-		txd.data_len = pkt->pkt_len;
+		txd.data_len = rte_cpu_to_le_16((uint16_t)pkt->pkt_len);
 		nfp_net_nfd3_tx_tso(txq, &txd, pkt);
 		nfp_net_nfd3_tx_cksum(txq, &txd, pkt);
 		nfp_net_nfd3_tx_vlan(txq, &txd, pkt);
@@ -330,10 +330,10 @@ nfp_net_nfd3_xmit_pkts_common(void *tx_queue,
 			dma_addr = rte_mbuf_data_iova(pkt);
 
 			/* Filling descriptors fields */
-			txds->dma_len = dma_size;
+			txds->dma_len = rte_cpu_to_le_16(dma_size);
 			txds->data_len = txd.data_len;
 			txds->dma_addr_hi = (dma_addr >> 32) & 0xff;
-			txds->dma_addr_lo = (dma_addr & 0xffffffff);
+			txds->dma_addr_lo = rte_cpu_to_le_32(dma_addr & 0xffffffff);
 			free_descs--;
 
 			txq->wr_p++;
-- 
2.43.5

