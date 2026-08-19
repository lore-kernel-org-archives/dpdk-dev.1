Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF517C5DF86
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F38406BA;
	Wed, 19 Aug 2026 14:33:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 64DBC40685
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142784; x=1818678784;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MLfSOm/H5+uTCeyCkG0KCB57iqViGq941SeWuUluWLE=;
 b=bN2DfJrZYl0+DW+mAjQapP8fXOqf2zPKo18wcB8ermTEbGva2jdzMJl1
 iJQlY50YUo8sRrOxYf4ulNTgNk8Xvp51EBtA2EoM5j2Yl/fiNFxI+rm/w
 R1PqiOtzBgwnSWAlWHeKz4GM9OolOVI2dw5yTa+j/WwCnYnROCmUdHImr
 3gfcvK+5htvEcO3qRcSWetRLZW0e7zVwS1FniWq8MJgZNr5GppxJz5Jg3
 C7n5pRglzah7QPT7qGMTwmbSqdBR3ULmuQtZBmddvowYqALf7+PO7Y5Gm
 4aOa3sM2OrFbeOcQRIssCPZmTst07vjRrYhz6kQnCricPOdhSiKi90WD2 Q==;
X-CSE-ConnectionGUID: Ow119P6NQZuLjAkinjgoOA==
X-CSE-MsgGUID: TPgZELB9TCqu5kAmY1iFZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775547"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775547"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:33:04 -0700
X-CSE-ConnectionGUID: eYCOfjnbTNKBy+cKqqCWRA==
X-CSE-MsgGUID: /slc/TcvTUaxxNE/7e2PpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382574"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:33:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 7/7] net/ixgbe: refactor IPsec code
Date: Wed, 19 Aug 2026 13:32:39 +0100
Message-ID: <fb2a3663a95d664cdff1778791b44e914d44f1b8.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, the IPsec code mixes SW bookkeeping with HW writes quite a lot,
which results in difficulty extending the code, lots of duplication, and
potential for bugs. Refactor the code to be more readable by separating
out the HW writing parts into helper functions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 297 ++++++++++++--------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h |   1 +
 2 files changed, 139 insertions(+), 159 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 4fe4dc9ba0..3c35326016 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -36,6 +36,85 @@
 	(a).ipv6[2] == (b).ipv6[2] && \
 	(a).ipv6[3] == (b).ipv6[3])
 
+static inline void
+ixgbe_crypto_write_rx_ip(struct ixgbe_hw *hw, uint32_t idx,
+		const struct ipaddr *ip, bool enable)
+{
+	uint32_t reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_IP | (idx << 3);
+	uint32_t addr[4] = {0};
+
+	if (enable)
+		reg_val |= IPSRXIDX_RX_EN;
+
+	if (ip->type == IPv4)
+		/* only write last 4 bytes */
+		addr[3] = ip->ipv4;
+	else
+		memcpy(addr, ip->ipv6, sizeof(addr));
+
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(0), addr[0]);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), addr[1]);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), addr[2]);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3), addr[3]);
+	IXGBE_WAIT_RWRITE;
+}
+
+static inline void
+ixgbe_crypto_write_rx_spi(struct ixgbe_hw *hw, uint32_t idx,
+		uint32_t spi, uint32_t ip_idx, bool enable)
+{
+	uint32_t reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_SPI | (idx << 3);
+
+	if (enable)
+		reg_val |= IPSRXIDX_RX_EN;
+
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, rte_cpu_to_be_32(spi));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
+	IXGBE_WAIT_RWRITE;
+}
+
+static inline void
+ixgbe_crypto_write_rx_key(struct ixgbe_hw *hw, uint32_t idx,
+		const uint8_t *key, uint32_t salt, uint32_t mode, bool enable)
+{
+	uint32_t reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_KEY | (idx << 3);
+
+	if (enable)
+		reg_val |= IPSRXIDX_RX_EN;
+
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(0),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[12]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(1),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[8]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(2),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[4]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(3),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[0]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, rte_cpu_to_be_32(salt));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, mode);
+	IXGBE_WAIT_RWRITE;
+}
+
+static inline void
+ixgbe_crypto_write_tx_key(struct ixgbe_hw *hw, uint32_t idx,
+		const uint8_t *key, uint32_t salt, bool enable)
+{
+	uint32_t reg_val = IPSRXIDX_WRITE | (idx << 3);
+
+	if (enable)
+		reg_val |= IPSRXIDX_TX_EN;
+
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[12]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(1),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[8]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(2),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[4]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(3),
+		rte_cpu_to_be_32(*(const uint32_t *)&key[0]));
+	IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, rte_cpu_to_be_32(salt));
+	IXGBE_WAIT_TWRITE;
+}
 
 static void
 ixgbe_crypto_clear_ipsec_tables(struct rte_eth_dev *dev)
@@ -43,41 +122,19 @@ ixgbe_crypto_clear_ipsec_tables(struct rte_eth_dev *dev)
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_ipsec *priv = IXGBE_DEV_PRIVATE_TO_IPSEC(
 				dev->data->dev_private);
+	const struct ipaddr ip = {0};
+	const uint8_t key[16] = {0};
 	int i = 0;
 
 	/* clear Rx IP table*/
-	for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
-		uint16_t index = i << 3;
-		uint32_t reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_IP | index;
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(0), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3), 0);
-		IXGBE_WAIT_RWRITE;
-	}
+	for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++)
+		ixgbe_crypto_write_rx_ip(hw, i, &ip, false);
 
 	/* clear Rx SPI and Rx/Tx SA tables*/
 	for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-		uint32_t index = i << 3;
-		uint32_t reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_SPI | index;
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, 0);
-		IXGBE_WAIT_RWRITE;
-		reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_KEY | index;
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(0), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(1), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(2), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(3), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, 0);
-		IXGBE_WAIT_RWRITE;
-		reg_val = IPSRXIDX_WRITE | index;
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(1), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(2), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(3), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, 0);
-		IXGBE_WAIT_TWRITE;
+		ixgbe_crypto_write_rx_spi(hw, i, 0, 0, false);
+		ixgbe_crypto_write_rx_key(hw, i, key, 0, 0, false);
+		ixgbe_crypto_write_tx_key(hw, i, key, 0, false);
 	}
 
 	memset(priv->rx_ip_tbl, 0, sizeof(priv->rx_ip_tbl));
@@ -90,14 +147,14 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 {
 	struct rte_eth_dev_data *dev_data = ic_session->dev_data;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
-	struct ixgbe_ipsec *priv = IXGBE_DEV_PRIVATE_TO_IPSEC(
-			dev_data->dev_private);
-	uint32_t reg_val;
-	int sa_index = -1;
+	struct ixgbe_ipsec *priv = IXGBE_DEV_PRIVATE_TO_IPSEC(dev_data->dev_private);
+	int i, sa_index = -1;
 	uint8_t key[16] = {0};
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		int i, ip_index = -1;
+		struct ixgbe_crypto_rx_ip_table *rxip;
+		struct ixgbe_crypto_rx_sa_table *rxsa;
+		int ip_index = -1, free_index = -1;
 
 		/* Find a match in the IP table*/
 		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
@@ -106,22 +163,19 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 				ip_index = i;
 				break;
 			}
+			if (free_index == -1 && priv->rx_ip_tbl[i].ref_count == 0)
+				free_index = i;
 		}
 		/* If no match, find a free entry in the IP table*/
-		if (ip_index < 0) {
-			for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
-				if (priv->rx_ip_tbl[i].ref_count == 0) {
-					ip_index = i;
-					break;
-				}
-			}
-		}
+		if (ip_index < 0)
+			ip_index = free_index;
 
 		/* Fail if no match and no free entries*/
 		if (ip_index < 0) {
 			PMD_DRV_LOG(ERR, "No free entry left in the Rx IP table");
 			return -ENOSPC;
 		}
+		rxip = &priv->rx_ip_tbl[ip_index];
 
 		/* Find a free entry in the SA table*/
 		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
@@ -135,84 +189,35 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 			PMD_DRV_LOG(ERR, "No free entry left in the Rx SA table");
 			return -ENOSPC;
 		}
+		rxsa = &priv->rx_sa_tbl[sa_index];
 
-		priv->rx_ip_tbl[ip_index].ip.ipv6[0] =
-				ic_session->dst_ip.ipv6[0];
-		priv->rx_ip_tbl[ip_index].ip.ipv6[1] =
-				ic_session->dst_ip.ipv6[1];
-		priv->rx_ip_tbl[ip_index].ip.ipv6[2] =
-				ic_session->dst_ip.ipv6[2];
-		priv->rx_ip_tbl[ip_index].ip.ipv6[3] =
-				ic_session->dst_ip.ipv6[3];
-		priv->rx_ip_tbl[ip_index].ref_count++;
+		rxip->ref_count++;
+		memcpy(&rxip->ip, &ic_session->dst_ip, sizeof(rxip->ip));
 
-		priv->rx_sa_tbl[sa_index].spi =
-			rte_cpu_to_be_32(ic_session->spi);
-		priv->rx_sa_tbl[sa_index].ip_index = ip_index;
-		priv->rx_sa_tbl[sa_index].mode = IPSRXMOD_VALID;
-		if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION)
-			priv->rx_sa_tbl[sa_index].mode |=
-					(IPSRXMOD_PROTO | IPSRXMOD_DECRYPT);
-		if (ic_session->dst_ip.type == IPv6) {
-			priv->rx_sa_tbl[sa_index].mode |= IPSRXMOD_IPV6;
-			priv->rx_ip_tbl[ip_index].ip.type = IPv6;
-		} else if (ic_session->dst_ip.type == IPv4)
-			priv->rx_ip_tbl[ip_index].ip.type = IPv4;
+		rxsa->spi = ic_session->spi;
+		rxsa->ip_index = ip_index;
+		rxsa->mode = IPSRXMOD_VALID | IPSRXMOD_PROTO | IPSRXMOD_DECRYPT;
+		if (ic_session->dst_ip.type == IPv6)
+			rxsa->mode |= IPSRXMOD_IPV6;
 
-		priv->rx_sa_tbl[sa_index].used = 1;
+		rxsa->used = 1;
 
 		/* write IP table entry*/
-		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE |
-				IPSRXIDX_TABLE_IP | (ip_index << 3);
-		if (priv->rx_ip_tbl[ip_index].ip.type == IPv4) {
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(0), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3),
-					priv->rx_ip_tbl[ip_index].ip.ipv4);
-		} else {
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(0),
-					priv->rx_ip_tbl[ip_index].ip.ipv6[0]);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1),
-					priv->rx_ip_tbl[ip_index].ip.ipv6[1]);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2),
-					priv->rx_ip_tbl[ip_index].ip.ipv6[2]);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3),
-					priv->rx_ip_tbl[ip_index].ip.ipv6[3]);
-		}
-		IXGBE_WAIT_RWRITE;
+		ixgbe_crypto_write_rx_ip(hw, ip_index, &rxip->ip, true);
 
 		/* write SPI table entry*/
-		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE |
-				IPSRXIDX_TABLE_SPI | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI,
-				priv->rx_sa_tbl[sa_index].spi);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX,
-				priv->rx_sa_tbl[sa_index].ip_index);
-		IXGBE_WAIT_RWRITE;
+		ixgbe_crypto_write_rx_spi(hw, sa_index, rxsa->spi, ip_index, true);
 
+		/* write Key table entry*/
 		memcpy(key, ic_session->key, ic_session->key_len);
 
-		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE |
-				IPSRXIDX_TABLE_KEY | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(0),
-			rte_cpu_to_be_32(*(uint32_t *)&key[12]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(1),
-			rte_cpu_to_be_32(*(uint32_t *)&key[8]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(2),
-			rte_cpu_to_be_32(*(uint32_t *)&key[4]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(3),
-			rte_cpu_to_be_32(*(uint32_t *)&key[0]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT,
-				rte_cpu_to_be_32(ic_session->salt));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD,
-				priv->rx_sa_tbl[sa_index].mode);
-		IXGBE_WAIT_RWRITE;
+		ixgbe_crypto_write_rx_key(hw, sa_index, key,
+				ic_session->salt, rxsa->mode, true);
 
 		rte_memzero_explicit(key, sizeof(key));
 
 	} else { /* sess->dir == RTE_CRYPTO_OUTBOUND */
-		int i;
+		struct ixgbe_crypto_tx_sa_table *txsa;
 
 		/* Find a free entry in the SA table*/
 		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
@@ -226,27 +231,16 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 			PMD_DRV_LOG(ERR, "No free entry left in the Tx SA table");
 			return -ENOSPC;
 		}
+		txsa = &priv->tx_sa_tbl[sa_index];
 
-		priv->tx_sa_tbl[sa_index].spi =
-			rte_cpu_to_be_32(ic_session->spi);
-		priv->tx_sa_tbl[sa_index].used = 1;
+		txsa->spi = ic_session->spi;
+		txsa->used = 1;
 		ic_session->sa_index = sa_index;
 
 		memcpy(key, ic_session->key, ic_session->key_len);
 
 		/* write Key table entry*/
-		reg_val = IPSRXIDX_RX_EN | IPSRXIDX_WRITE | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0),
-			rte_cpu_to_be_32(*(uint32_t *)&key[12]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(1),
-			rte_cpu_to_be_32(*(uint32_t *)&key[8]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(2),
-			rte_cpu_to_be_32(*(uint32_t *)&key[4]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(3),
-			rte_cpu_to_be_32(*(uint32_t *)&key[0]));
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT,
-				rte_cpu_to_be_32(ic_session->salt));
-		IXGBE_WAIT_TWRITE;
+		ixgbe_crypto_write_tx_key(hw, sa_index, key, ic_session->salt, true);
 
 		rte_memzero_explicit(key, sizeof(key));
 	}
@@ -260,11 +254,13 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ic_session->dev_data->dev_private);
 	struct ixgbe_ipsec *priv =
 			IXGBE_DEV_PRIVATE_TO_IPSEC(ic_session->dev_data->dev_private);
-	uint32_t reg_val;
-	int sa_index = -1;
+	const uint8_t key[16] = {0};
+	int i, sa_index = -1;
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		int i, ip_index = -1;
+		struct ixgbe_crypto_rx_ip_table *rxip;
+		struct ixgbe_crypto_rx_sa_table *rxsa;
+		int ip_index = -1;
 
 		/* Find a match in the IP table*/
 		for (i = 0; i < IPSEC_MAX_RX_IP_COUNT; i++) {
@@ -279,11 +275,11 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 			PMD_DRV_LOG(ERR, "Entry not found in the Rx IP table");
 			return -ENOENT;
 		}
+		rxip = &priv->rx_ip_tbl[ip_index];
 
 		/* Find a free entry in the SA table*/
 		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->rx_sa_tbl[i].spi ==
-				  rte_cpu_to_be_32(ic_session->spi)) {
+			if (priv->rx_sa_tbl[i].spi == ic_session->spi) {
 				sa_index = i;
 				break;
 			}
@@ -293,40 +289,28 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 			PMD_DRV_LOG(ERR, "Entry not found in the Rx SA table");
 			return -ENOENT;
 		}
+		rxsa = &priv->rx_sa_tbl[sa_index];
 
 		/* Disable and clear Rx SPI and key table entries*/
-		reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_SPI | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, 0);
-		IXGBE_WAIT_RWRITE;
-		reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_KEY | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(0), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(1), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(2), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(3), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, 0);
-		IXGBE_WAIT_RWRITE;
-		priv->rx_sa_tbl[sa_index].used = 0;
+		ixgbe_crypto_write_rx_spi(hw, sa_index, 0, 0, false);
+		ixgbe_crypto_write_rx_key(hw, sa_index, key, 0, 0, false);
+
+		/* Clear the SA table entry*/
+		*rxsa = (struct ixgbe_crypto_rx_sa_table){0};
 
 		/* If last used then clear the IP table entry*/
-		priv->rx_ip_tbl[ip_index].ref_count--;
-		if (priv->rx_ip_tbl[ip_index].ref_count == 0) {
-			reg_val = IPSRXIDX_WRITE | IPSRXIDX_TABLE_IP |
-					(ip_index << 3);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(0), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(1), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(2), 0);
-			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(3), 0);
-			IXGBE_WAIT_RWRITE;
+		rxip->ref_count--;
+		if (rxip->ref_count == 0) {
+			const struct ipaddr ip = {0};
+			ixgbe_crypto_write_rx_ip(hw, ip_index, &ip, false);
+			*rxip = (struct ixgbe_crypto_rx_ip_table){0};
 		}
 	} else { /* session->dir == RTE_CRYPTO_OUTBOUND */
-		int i;
+		struct ixgbe_crypto_tx_sa_table *txsa;
 
 		/* Find a match in the SA table*/
 		for (i = 0; i < IPSEC_MAX_SA_COUNT; i++) {
-			if (priv->tx_sa_tbl[i].spi ==
-				    rte_cpu_to_be_32(ic_session->spi)) {
+			if (priv->tx_sa_tbl[i].spi == ic_session->spi) {
 				sa_index = i;
 				break;
 			}
@@ -336,15 +320,10 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 			PMD_DRV_LOG(ERR, "Entry not found in the Tx SA table");
 			return -ENOENT;
 		}
-		reg_val = IPSRXIDX_WRITE | (sa_index << 3);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(1), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(2), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(3), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, 0);
-		IXGBE_WAIT_TWRITE;
+		txsa = &priv->tx_sa_tbl[sa_index];
 
-		priv->tx_sa_tbl[sa_index].used = 0;
+		ixgbe_crypto_write_tx_key(hw, sa_index, key, 0, false);
+		*txsa = (struct ixgbe_crypto_tx_sa_table){0};
 	}
 
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
index 356817c61b..1099b5f598 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
@@ -12,6 +12,7 @@
 #include <rte_flow.h>
 
 #define IPSRXIDX_RX_EN                                    0x00000001
+#define IPSRXIDX_TX_EN                                    0x00000001
 #define IPSRXIDX_TABLE_IP                                 0x00000002
 #define IPSRXIDX_TABLE_SPI                                0x00000004
 #define IPSRXIDX_TABLE_KEY                                0x00000006
-- 
2.52.0

