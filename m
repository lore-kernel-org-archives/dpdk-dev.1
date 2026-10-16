Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E5CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5166406B7;
	Mon, 19 Oct 2026 13:47:05 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 9FD4C4026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:03 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3514b90bb89so339656eec.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172763; x=1792777563; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74SQuOZThpaFKjidRpXMqSUQrhrPaMirZcXKkHItv/M=;
 b=Ua5iKHZ5OVlYM/RSDtyZ1TMnqEcb84MoPezcG+beYK06rOdSbY/OMylIw1RcxkIo2g
 3F6Ljr8HduHoi4mm3UnB2UEibdOrp6PfvZ35tAy1YCwehGfvgyhn16FNXyxQPTFlIWkF
 lbLsdKWbx8tKszstli3ZXFAk2rdKP5aIQn4aj459V4JFhF2Cda5v9LiI1SxXWVBCRVMp
 mEfAbppHPGFoQgpZxhaDuyfjGqGFLPSCpaFm9GPA6FuvU7HQOJm4q6iilj17PHTi30nB
 mOgeyVSwGIcUgJd1WeG2uqyZGX8ZA+TmQYBv0WuqRS2L5vMIUmCv6TcYI+No8Hkv1UbA
 nc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172763; x=1792777563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=74SQuOZThpaFKjidRpXMqSUQrhrPaMirZcXKkHItv/M=;
 b=FZeYo+b73ptjRPq3ADzVK2LVbE/ZjuxcRUjQUVQ6f5D8YmRV/QNjYml61OvJCyyV55
 C5VqgoU4n5+rwkKUAhvLJU7OtU+Z/qfVHvb1gNUSguDMPEcj8C+y8puGXhYcU5ojB6kY
 YtCaygzcRvivaW+iJV+M07dlakK8rw1uSTa1QWTwx588EfGUUGZT8I9zE0kYzqliOtyI
 QQ6NpdHXnP5g8yN+YU+2ASNeAUgwYSrNxdXrOt5LAYGLDBECGGP47D18WBRl+Mc8gGBw
 YSLOjtRz9I/dXer1Mpuwd5jyiuLZAP700hehDurn+1ZyRe/bASt/oVeP857jiMUWUL/J
 2Xyg==
X-Gm-Message-State: AFq9FYJZrPDHUAL7R3mEBOyXlqVJEjs/nXiAbuMEwBzs5itBX6sPLEI1
 avZXo4z4ldFOj+uCFp/AQ2NDmJIAYs+9wXyY65IbANCfAOCzv9aSt1oygSrPYA==
X-Gm-Gg: AYBFou105/80LE43OcWwchuAByciOZ6j6E2BCIAriRWPJeud1zyNyURH3hmWlvfyZDH
 ghQoNDXFY0tHMsRvI5PWPK0lSKrafAge7dJQ1FtsQXDcoDmm3KOY0wAS+sS0pJXnGaJthEzABLB
 Hkp5Y046jFylXYjYoeDV8yDFuiGcpds9MjC86IhaHjlmhCsEue+0De44gnZ0nUdaLOnFjXmCucB
 U9J2UiboLpzLWqz13QpAcf0TVAiNvVG7LwmjXAUjE7VTWcGngFjujbAmlAYPxj7gq1zBlHuwGZG
 zc9CE1ALM8KQyUr4n4czs+z+xj/BoSdJC4rIWmvwg4SdU0sQvt44wKxHKCqauouCFgXhIZjOisA
 Kg+52eYnC7aTIPv7EwbNqqLS3Pq36Q+GmX6ITqdOKdj+NwP1rinqx5F4C+OHKIMYQzyshpmcA/I
 p+S45M39rP0MYlAjfGo+oZYFGxRUZo3QeOMrVODKA8c3wdAqqDeMA9ZeJbADfW6LjwevVGY6Kd
X-Received: by 2002:a05:7022:f51b:b0:14a:a6dc:9ca6 with SMTP id
 a92af1059eb24-1850d087d4fmr692672c88.3.1792172762604; 
 Fri, 16 Oct 2026 10:46:02 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:02 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Junfeng Guo <junfengg@nvidia.com>, Rushil Gupta <rushilg@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>
Subject: [PATCH v4 03/10] net/gve: fix DQO Tx report event interval
Date: Fri, 16 Oct 2026 17:45:38 +0000
Message-ID: <7160dadebea6fb1085ae7e00915dc827a9f6f2e3.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

A descriptor completion is requested once every 32 packets, and Tx
descriptors are only reclaimed on these completions. With
multi-segment or TSO packets the ring can fill before 32 packets are
posted, so no completion is ever requested and the Tx queue stalls
for good.

Request a completion once GVE_TX_MIN_RE_INTERVAL descriptors have
been posted since the last one, as the Linux driver does.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.h |  2 +-
 drivers/net/gve/gve_tx_dqo.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 19eac9ec0b..4d17ba727d 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -193,7 +193,7 @@ struct gve_tx_queue {
 	uint16_t sw_size;
 	uint8_t cur_gen_bit;
 	uint32_t last_desc_cleaned;
-	uint16_t re_cnt;
+	uint16_t last_re_idx;
 
 	/* Only valid for DQO_RDA queue format */
 	struct gve_tx_queue *complq;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 4b84135d02..6cca968122 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -251,6 +251,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	volatile union gve_tx_desc_dqo *txr;
 	volatile union gve_tx_desc_dqo *txd;
 	uint16_t mask = txq->nb_tx_desc - 1;
+	uint16_t last_re_interval;
+	uint16_t last_desc_idx;
 	struct gve_tx_pkt *pkts;
 	struct rte_mbuf *tx_pkt;
 	uint16_t compl_tag;
@@ -328,20 +330,23 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
 
+		/* Request a descriptor completion once at least
+		 * GVE_TX_MIN_RE_INTERVAL descriptors have been posted
+		 * since the last request.
+		 */
+		last_desc_idx = (tx_id - 1) & mask;
+		last_re_interval = (last_desc_idx - txq->last_re_idx) & mask;
+		if (unlikely(last_re_interval >= GVE_TX_MIN_RE_INTERVAL)) {
+			txd->pkt.report_event = true;
+			txq->last_re_idx = last_desc_idx;
+		}
+
 		txq->nb_free -= nb_descs;
 		txq->nb_used += nb_descs;
 	}
 
 	/* update the tail pointer if any packets were processed */
 	if (nb_tx > 0) {
-		/* Request a descriptor completion on the last descriptor */
-		txq->re_cnt += nb_tx;
-		if (txq->re_cnt >= GVE_TX_MIN_RE_INTERVAL) {
-			txd = &txr[(tx_id - 1) & mask];
-			txd->pkt.report_event = true;
-			txq->re_cnt = 0;
-		}
-
 		rte_write32(tx_id, txq->qtx_tail);
 		txq->tx_tail = tx_id;
 
@@ -442,6 +447,7 @@ gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 	txq->nb_used = 0;
 
 	txq->last_desc_cleaned = 0;
+	txq->last_re_idx = 0;
 	txq->nb_free = txq->nb_tx_desc - 1;
 
 	txq->complq_tail = 0;
-- 
2.43.0

