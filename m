Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE5CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CA1840B9C;
	Fri, 16 Oct 2026 13:31:39 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id CE2E3402EB
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:15 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35ef6b49813so3518258eec.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132035; x=1792736835; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pPhPcYizhj0gvN2eAZ2kpRjqMxU2cinjwfFoAoXSaeY=;
 b=n2P/pFCxaQUSBcyyfg5uImjKdawRjoXcgwUDBeyX4cHtTnE7FYrbPy8ycZcZ0bP7Uj
 ivnsbz1qySlZ0R1z14uzssdBYXSurJqVmgdBkWF5QjV6xnbv+TwauR+05H+G176s39lz
 7UizlpZMxjbQ5Bc5FGo4UkzyRLhnWJqqzNc7OLS1CzlZAAd9+dMP2JlG/rt3wzfjJrrB
 anD4P2JnTL3yAaPCC1LxftXkoqk+guh6JWtVJaNUXhBgN45T52zOQw1ie8hyig3KRXnp
 xsPb3Gm+z1JE2WNOWFggrS8kT5oJXQFccQmk8jjSmH1y2mH5iNB5nkJeU7QZK9oCG78c
 Tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132035; x=1792736835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pPhPcYizhj0gvN2eAZ2kpRjqMxU2cinjwfFoAoXSaeY=;
 b=v8J6fl1gS+vKSlRFLR9xiF2bdnqjX3oX5hHDJolEXZi1hxArUIFqNGLmD160/UZkjv
 HF089vPAnwxTWylDgUuvt1/xwJDPhZfK9jaYAoAGWPE4O0+2UAx2O6qi56vExxX2SEgy
 h63yBw71PrGUYjvwGttjU/AX3/j4n/WytCGGk+4ubiY8C487Z08B4hkhtA+yl7jev4Ej
 xAU1z7c35nbX2r7GMEmvWQTJodDHlNjDaiUXmVdKqfRWc/wz3vgi5yIZLpZhLgdWNhW9
 DLx1eda6xSKLo3qILl53yMrwlaH1lTpL4hyul1yPx7DBnLdxy0tKytF3AmbdSVkPT+Id
 Z6jQ==
X-Gm-Message-State: AFq9FYIPZusDsl2jLr4tfSiFRywM/JiMRsHeimG3NbozS26uTYTcWp19
 Ex/fndeyTGBhqCAlHCU72FOB+ByK161G1UnZ713Asrsmv8XOOFt0uijHTOW/yQ==
X-Gm-Gg: AYBFou1qq3PF6BkVtI0NnG3VYsHrQBRtaMpiCPKq+PiK/9PlWl4mermo1QXI/Oe8r9f
 YjWMWl2KijbRwTlZm9VmqymcMRVdaZCtOT8ZGgQzghFYuQdwlARk1nRX5/8+EB2aAv2ZGrQsMss
 Cquuyem5erMQI+W/ff7fuLzsbSkp7p+8u8GSuTUCph13h2TI/cE47RR4C3IAMCVUbYHS9Ywj/H9
 d5zMM1nWvFOI/zntwvLVKNgveLp2Xn0wWAef2+DuYbxOS7kwo1aEHbz8tHwxcOdmsiQ72B82WJD
 AMaoUQyLS3My50J/BdD35J150M1P9PICroCUsGqRWv/hSw22xmkSecDzipvz7oV2wGQqrMN9F8g
 7SxaV1EfA98Ah4MjgM48zn9KcQ5hp3RrJv7Cs+TTNjoa/1JQHxusqjtkMyPS7vQGMbORF/MIByG
 yPImuaEZuFTqE3cDLBEV/vHnoxSoYlYiWbLDvzNNqPORx+w3qHQgG4yH+fBOWwQP69ZmnI7RA9
X-Received: by 2002:a05:7022:f51c:b0:160:90a3:ca8c with SMTP id
 a92af1059eb24-16a5fe7bebfmr24174674c88.7.1792132034766; 
 Thu, 15 Oct 2026 23:27:14 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:14 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 09/10] net/gve: enforce DQO Tx packet length limits
Date: Fri, 16 Oct 2026 06:26:46 +0000
Message-ID: <342428be26464475e28395d450290804b4a56d56.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

The device requires non-TSO packets to be 17 to 9728 bytes long, as
noted in the Linux driver, but packets of any length are posted. The
device treats an out-of-range packet as coming from a malicious
driver: it drops the packet and disables the datapath, stalling all
queues.

Drop such packets in the driver and count them in a new invalid_pkts
counter.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/base/gve_desc_dqo.h |  2 ++
 drivers/net/gve/gve_ethdev.c        |  1 +
 drivers/net/gve/gve_ethdev.h        |  1 +
 drivers/net/gve/gve_tx_dqo.c        | 17 +++++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index c1534959c2..d50d88765e 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -12,6 +12,8 @@
 
 #define GVE_TX_MAX_HDR_SIZE_DQO 255
 #define GVE_TX_MIN_TSO_MSS_DQO 88
+#define GVE_TX_MIN_PKT_SIZE_DQO 17
+#define GVE_TX_MAX_PKT_SIZE_DQO 9728
 
 /* Basic TX descriptor (DTYPE 0x0C) */
 struct gve_tx_pkt_desc_dqo {
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index cbfb07edf6..167dcbce7b 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -985,6 +985,7 @@ static const struct gve_xstats_name_offset tx_xstats_name_offset[] = {
 	{ "errors",  TX_QUEUE_STATS_OFFSET(errors) },
 	{ "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
 	{ "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
+	{ "invalid_pkts", TX_QUEUE_STATS_OFFSET(invalid_pkts) },
 };
 
 static const struct gve_xstats_name_offset rx_xstats_name_offset[] = {
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 24ef3a4552..2464474426 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -115,6 +115,7 @@ struct gve_tx_stats {
 	uint64_t errors;
 	uint64_t too_many_descs;
 	uint64_t invalid_mbufs;
+	uint64_t invalid_pkts;
 };
 
 struct gve_rx_stats {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index fd36d92fab..c23b222ada 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -126,6 +126,17 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* Validate packet lengths against the device limits. */
+static inline bool
+gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
+{
+	if (!is_tso)
+		return tx_pkt->pkt_len >= GVE_TX_MIN_PKT_SIZE_DQO &&
+		       tx_pkt->pkt_len <= GVE_TX_MAX_PKT_SIZE_DQO;
+
+	return true;
+}
+
 /* Max descriptors a single packet may use. A larger packet can never pass
  * gve_can_tx(): one slot is always reserved, the cacheline overlap margin
  * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors posted
@@ -309,6 +320,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
+		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+			txq->stats.invalid_pkts++;
+			rte_pktmbuf_free(tx_pkt);
+			continue;
+		}
+
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
 
-- 
2.43.0

