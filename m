Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA7C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8300A40613;
	Mon, 10 Mar 2025 22:01:45 +0100 (CET)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2BB61400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:01:44 +0100 (CET)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-3f3f149c334so2545113b6e.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741640503; x=1742245303; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtnHeevLAKuGO9zEqAN0ZgsyMlJQu0lko6aIyWA6Yjg=;
 b=Q32mUKmGVfTWQpbp7VLZSPEXuNO+bLb19xjNTqDk6f51NOjbE4utIIb++370hlcVMH
 iC3ddjuFe48PziDVN3CnIs6ToVZvfbZe3iIMnruYuAoA+Zy12SV9DBw2TDU9nMF5INVc
 pFf6ZO+VvGMwRWfRwrrjv6MQy1pFLf91Eu6VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741640503; x=1742245303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtnHeevLAKuGO9zEqAN0ZgsyMlJQu0lko6aIyWA6Yjg=;
 b=Vym1It8JD5d/ynZWGxxiHy+qh7q3VQvqIp+gauISDgf+E1sL+GJgucl83BvmGj6z1N
 i4jqrrlafAs19WN0EVZQxNKS6fBOj1w3gJLSAFeAUdsAeesNzvAg/20xCj7W93iWWmS0
 CCh2u6uaRPhf/cGiS8TDdmW3jjUf/4gftPbwl91Pnesue5ZLPUuDPEyLL8/NsPNA5zNA
 1l3FMjuxYI7WEzDBteljJUjwfHZqYfJw7xvoRo503oqok5WfsxzVYrJSBU+OoEA9nMzw
 H94Va7RpvRDLiyaot6JEutA3SdforncUT4pXuZ6W2DZhrxzb/rzot+1UyYIZ9r8zxIZ/
 ZLOg==
X-Gm-Message-State: AOJu0Yze1OwkM6cRMMNQbj3oXQ/s+glp5beu34Pdy5iX62YIqnlfkKqf
 3BwJo2l4SkPy81cBegQmOI2/FK89pisJ+M6EiFK+BV+2n2iZtnQ2vTcktIJcECEpYmhxL0quOYb
 w4VnEyXDS+JvtiTDxxkhUWyq+Yg79BxRENWDa08mJj/DsAIlxZy5n7xPOy9P82tC7I1bPx+AR+f
 ASYmrUp/OumuFWwbiM1PppqmGQOT7M
X-Gm-Gg: ASbGncvbpKO7NJv2ahXnT5/Y9w5Drr/WhC4smZw6HGuszrg+0/E9ilHU4fMmKO9e+rP
 Yy77TM4tPDADIyx2eXYG4Hjpr8XskxyK/VpbyYC6y+kzw7oaMtMOytyKLKDt7GI7xd6Y04jadq6
 iRTdBlftoQQlaUE3Ha2mCkcJ7hK3vEpX/kznaQzV8nRqVOmCh4FiwwLN1IQ4cTV6Cc4aMl0kDQ6
 x3opRM5BjekwD77GrVFeGEAUafVAPel4u6q52xZKQ9URUm1IQryddDsY9p25v9lxcrDXL1obaCd
 bErjwQPdYDRarxejKTL9nuPU2VoSnX3uoQgFqSJPXobeCdYTYaHQr75OoyPnUGvAAcXTtltfwXy
 8zbLvPFdiHcpR8yP6gR0mLhFZbBuSJhjyiJptWA==
X-Google-Smtp-Source: AGHT+IHLN/+DBRYfQzi4Q2yFHT3/z1lJuiV1jeViwgml/n+3anfRsDz+eyN7Im/7XurRaLcyed/ENw==
X-Received: by 2002:a05:6808:4447:b0:3f3:f90b:f1b9 with SMTP id
 5614622812f47-3f697850059mr7799170b6e.0.1741640503186; 
 Mon, 10 Mar 2025 14:01:43 -0700 (PDT)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f7dcdc4050sm1034092b6e.40.2025.03.10.14.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:01:42 -0700 (PDT)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH 2/2] net/bnxt: fix epoch bit calculation
Date: Mon, 10 Mar 2025 14:01:32 -0700
Message-Id: <20250310210132.48829-3-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
References: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
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

The epoch bit is a binary value which needs to be toggled with
every pass of the ring in the hardware.
The code was doing this prematurely in vector path.
Improve the ring wrap identification and fix epoch bit calculation
in the vector path.

Fixes: 30656a1cace8 ("net/bnxt: refactor epoch setting")
Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
---
 drivers/net/bnxt/bnxt_ring.h            | 19 +++++++++++++++++++
 drivers/net/bnxt/bnxt_rxq.c             |  1 +
 drivers/net/bnxt/bnxt_rxq.h             |  1 +
 drivers/net/bnxt/bnxt_rxr.c             |  4 ++++
 drivers/net/bnxt/bnxt_rxtx_vec_common.h | 11 +++++------
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index a7470a0e73..3e2bd634a8 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -108,6 +108,25 @@ static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
 	}
 }
 
+static inline void bnxt_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
+{
+	uint32_t db_idx = DB_RING_IDX(db, idx);
+	void *doorbell = db->doorbell;
+
+	if (db->db_64) {
+		uint64_t key_idx = db->db_key64 | db_idx;
+
+		key_idx |= epoch << DBR_EPOCH_SFT;
+
+		rte_compiler_barrier();
+		rte_write64_relaxed(key_idx, doorbell);
+	} else {
+		uint32_t key_idx = db->db_key32 | db_idx;
+
+		rte_write32(key_idx, doorbell);
+	}
+}
+
 static inline void bnxt_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
 {
 	uint32_t db_idx = DB_RING_IDX(db, idx);
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index a1c3777f33..91b3555df6 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -425,6 +425,7 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		goto err;
 	}
 	rxq->rx_mbuf_alloc_fail = 0;
+	rxq->epoch = 0;
 
 	/* rxq 0 must not be stopped when used as async CPR */
 	if (!BNXT_NUM_ASYNC_CPR(bp) && queue_idx == 0)
diff --git a/drivers/net/bnxt/bnxt_rxq.h b/drivers/net/bnxt/bnxt_rxq.h
index cd49faf4cf..3385496e70 100644
--- a/drivers/net/bnxt/bnxt_rxq.h
+++ b/drivers/net/bnxt/bnxt_rxq.h
@@ -30,6 +30,7 @@ struct bnxt_rx_queue {
 	uint16_t		rxrearm_nb; /* number of descs to reinit. */
 	uint16_t		rxrearm_start; /* next desc index to reinit. */
 #endif
+	uint32_t		epoch;
 	uint16_t		port_id; /* Device port identifier */
 	uint8_t			crc_len; /* 0 if CRC stripped, 4 otherwise */
 	uint8_t			rx_deferred_start; /* not in global dev start */
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index b53d9a917a..c94abefa01 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1366,6 +1366,10 @@ uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			bnxt_db_write(&rxr->rx_db, rxr->rx_raw_prod);
 			rxq->rxrearm_start++;
 			rxq->rxrearm_nb--;
+			if (rxq->rxrearm_start >= rxq->nb_rx_desc) {
+				rxq->rxrearm_start = 0;
+				rxq->epoch = rxq->epoch == 0 ? 1 : 0;
+			}
 		} else {
 			/* Retry allocation on next call. */
 			break;
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index f608b5152e..e185005293 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -50,6 +50,7 @@ bnxt_rxq_vec_setup_common(struct bnxt_rx_queue *rxq)
 	rxq->mbuf_initializer = *(uint64_t *)p;
 	rxq->rxrearm_nb = 0;
 	rxq->rxrearm_start = 0;
+	rxq->epoch = 1;
 	return 0;
 }
 
@@ -88,13 +89,11 @@ bnxt_rxq_rearm(struct bnxt_rx_queue *rxq, struct bnxt_rx_ring_info *rxr)
 	}
 
 	rxq->rxrearm_start += nb;
-	/*
-	 * We can pass rxq->rxrearm_star - 1 as well, but then the epoch
-	 * bit calculation is messed up.
-	 */
-	bnxt_db_write(&rxr->rx_db, rxr->rx_raw_prod);
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
+	bnxt_db_epoch_write(&rxr->rx_db, rxq->rxrearm_start - 1, rxq->epoch);
+	if (rxq->rxrearm_start >= rxq->nb_rx_desc) {
 		rxq->rxrearm_start = 0;
+		rxq->epoch = rxq->epoch == 0 ? 1 : 0;
+	}
 
 	rxq->rxrearm_nb -= nb;
 }
-- 
2.39.5 (Apple Git-154)

