Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C3CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5A7C40B94;
	Fri, 16 Oct 2026 13:31:38 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 64556402E8
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:13 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-16ad92569b5so5862529c88.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132032; x=1792736832; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wojDm4eOBLkJCoYLHaroKugC1GPfmuH04nqhaonOYzs=;
 b=DUX4d1ih4/hkzyMMUnv5mEn133JV26nqTghDicz2EL/S9/1lmYCsPLcZoKXl49R7LR
 pqSWWSZIHdJY+ij5kUgAWAzT9n2SFrZ4AhSLfcZaDvOmHyA/HYdc60bAmCyOsLRAxTES
 b+Q8ekU3AACj+iD6GGuoE1egTp17Sal3+JrmChM1uUJ5IAE6NeU5znpMPpDxj29Fofe/
 L2vs5ABD2KWviXN+yKLF+twvpfSLs/mXjTY8rHhmtL2Si8aVt9AaUh0OPYjuTfpNR3QD
 yN3sdAJpJkcT4NZQZs4pu7AW92JxjePZAZurPjR9jMQP8wUiYOM3cTtChmAHoNVj7ogs
 XKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132032; x=1792736832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wojDm4eOBLkJCoYLHaroKugC1GPfmuH04nqhaonOYzs=;
 b=jC/ulbLXByDpKT5Y9RuuXErwpOjLVfyG6jJ6b4nUzIWUYkvrk06wbt4b2YXeGO2AY8
 QeFAh6I5G0UxiMzzyj2rymK0K3dtvW0ionblp93IHKFb7dqKF81NgStrh44QbpCF0BRN
 bmSdNiXNd+aiB80jDZr+yuzQaPoO+EXawrw5SGF0AeKOJ6WnfwqrgPEPINOJnlINwxpm
 sHqrSA2+blNWygb36RY4iEbQLwilMSQcv0BdP6JuF7V4SqvT78CgPz6FIkECLBhPHHWz
 czBMNpDJ1Ejdf12zTL6su+dJHgM93fLdNEG5z2X0p22XCKbd3z39cgZqHXdT9UkVSMaP
 PtbQ==
X-Gm-Message-State: AFq9FYIYVdTs3E9nnSO6eltGKekXdM4qw2DvSndfo54e+fa37mfdnCfr
 rYb8sjYhxfmHi3i65DqAGNFZZ7lDbC45cE56a+dA4IEDLuu+BGPcUfNHLaLiaA==
X-Gm-Gg: AYBFou07QUmuJ+tEmwyfTBhj0uKya0UZSjkCC/jLbCT66E0phtDG6826eC8WeIzlQic
 ojyLn/BV0w62QtYlYVGQxBpw6qe2rBov6AZHb4bPi/nRrQJp27eevS/pczoHnCO0qh7vTGlts0D
 eRZReiVNNABJUOjgH+6WkDOEETeeAZaSPbFks88waBGq90CfpC5Hd8KYJ+PKldXXGJGRH2g9TMR
 1YMbanqMeXnnLvxG+HITq9RSzQQVqizjV9x0zGUnK3w3bjo43vJUPOaOruBP7LIIfem6b47bmVd
 jhZ8cTFOdgbLClVeCBih5+RSv0nIIR7yoPNqkacYvznkKBUc/KUnyFghXdXa8vX4ug5iWcL7PYu
 l6XpVxIValMesl8uD1o4DxrWIdtYCCJ9iLGBb3nQpWkHSqMscFQkZuQGePCJZw23uV56m2w8iPz
 Ru0T+EXDzKKC4MM/bFh4uIWqy6FRsAxNh68KBl0Y2Tc1BcimCXrLFg38bzxZ6yFbphT92B2rXk
X-Received: by 2002:a05:701b:4553:20b0:14d:5a09:5cd0 with SMTP id
 a92af1059eb24-16a5ed3d9aamr26699325c88.42.1792132032326; 
 Thu, 15 Oct 2026 23:27:12 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:11 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 08/10] net/gve: reject Tx packets that cannot fit in the
 ring
Date: Fri, 16 Oct 2026 06:26:45 +0000
Message-ID: <0fa92ec4cb4885d5d2c8b9ffe9472383d7e23c55.1792129992.git.tathagat.dpdk@gmail.com>
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

A TSO packet needing more descriptors than the ring can ever have
free fails the ring space check on every burst and blocks the queue.
One slot is always reserved, the cacheline overlap margin must stay
free, and up to GVE_TX_MIN_RE_INTERVAL - 1 posted descriptors are not
reclaimed until more are posted.

Drop such packets and count them as too_many_descs.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 44d2fa870f..fd36d92fab 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -126,14 +126,30 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* Max descriptors a single packet may use. A larger packet can never pass
+ * gve_can_tx(): one slot is always reserved, the cacheline overlap margin
+ * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors posted
+ * after the last report_event are not reclaimed until more are posted.
+ */
+static inline int
+gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
+{
+	return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP -
+		(GVE_TX_MIN_RE_INTERVAL - 1);
+}
+
 /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond this,
  * the hardware will assume the driver is malicious and stop transmitting
  * packets altogether. Validate that a packet can be sent to avoid sending
  * posting descriptors for an invalid packet.
  */
 static inline bool
-gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
+gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
+		      uint16_t nb_descs, bool is_tso)
 {
+	if (nb_descs > gve_tx_max_pkt_descs(txq))
+		return false;
+
 	if (!is_tso)
 		return nb_descs <= GVE_TX_MAX_DATA_DESCS;
 
@@ -297,7 +313,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		nb_descs += tso;
 
 		/* Drop packet if it doesn't adhere to hardware limits. */
-		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
+		if (!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso)) {
 			txq->stats.too_many_descs++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
-- 
2.43.0

