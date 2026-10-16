Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91836CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C06B540A75;
	Mon, 19 Oct 2026 13:47:07 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id A31B54026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:12 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-35f036b17easo327797eec.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172772; x=1792777572; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=giQaTLIsNXdqC2w5e6QAM1P6q3Es26N5A5pvDowGBls=;
 b=eG4n/B5xjGMYtG3T7wavMy303LkY/U+5Wu2vXtiqIQTDhA6OTimasosHXSYzKWRQ1x
 PX5Mw04yIFzw2cC+twMlYuuHugfugcF4oZTQ3h6C5IZqMrpP8kd2/l1fvhSofKojjOIk
 7eFOutI/2lrdfSNojphn1GSsNRWSy17RKH1n1nu3H4FyFGHZEaJwcD3Sg37rQC/Gq1dp
 1NZkkV3t/1Sj1FPm2xIyUXqkwRv0vMtoK6LwNYzade8iqQFPOpzzaDxfxUqVq0ZbHOkS
 Vjdx2UemHHlBXMaUyS6AK99lOb4Sryp+qSLN2xYo+og5SlcjeiCGyn50ps+860qWQz1J
 kDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172772; x=1792777572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=giQaTLIsNXdqC2w5e6QAM1P6q3Es26N5A5pvDowGBls=;
 b=mwQ23DExAPMuOM88VhA0gC6y8pxGastVAu0s8Kz5aNNc+YpxHzhxx0MJjWvbpoMwDY
 vMFrmiQ867namdxLovxbcbYeRG2Fpg/1ojqzEFwRk2VJbGUJWBtKJNlw6Ane4Cha0jQK
 FK9vF1N/bkLV/P+MNvwZtrtVwkygzm5mjDGe7eS/3Rz2cSyk25OEdePPZv3UQUl626Ow
 K+dETE90yNWQ5gzOjpcZ/YUYH3foHNe71ngWE0PxhRiX7jiSX8ano7zs5Pdoq3VcVoeD
 T+s4vscsaxzJbNqGwvxSbCjHCSl0zF4SXDzAB3+DenXcjBgvByf2IyW5zb3osIkCkOAM
 29Eg==
X-Gm-Message-State: AFq9FYIvPKWSQ0zt+45ZHwYCTM6t6IvcfWUWRbfl1XCMkxm5/6qVVY3U
 pKKhPEZOHpkSMVOYtjB4oV6v2bp0PGLDEUFjGNNeo1yJKEYW745t8Z/VoW3DQA==
X-Gm-Gg: AYBFou1/9wxV6d5bsrYgdgc42DqnCSWkfa0ch5Jsh3iHlLPxhppRXyYRrlQV0eztB1Y
 WvnkFrtl0+AdJeywwyvyNb1dA7EgINSug1uBvMqAoKaYHirpFZSSTAYC9h7GQ4l0P/2JhHOxwI+
 A6G2qjVNYUdCuy2VwSgNpl8RAdKas+XgRLQ06xfsHZ7/LSJb4/tXYYKeM8paQOp3t90SfAUDbs9
 6DIzm9chBdE6w4zZGP09tEd7CaULVHleSAV6/XRVb3BNW7BVyZeDNARt6iNzPBYzaBQqeQmnwzr
 BhvfkyTNZzCS5jnijwH/ES7aPUjhqGc6mDg7HSVGF/UBd5LjmABByrG8wXS7Myi/K8v8rkFXudQ
 QGUmx5iWbOlnPu0waKjqWV3YBnd/z1LLsIXER5S7hO6pDDnrhkPH8DP+Vh+ka6pYbh7LAhFTNAb
 JxoMe6kN2y4FZQIxwY9LxLzIzvakfGHHdy21BdSq44SeGNFljBDLhNOvSJ+/rbDEvx+v+Y+3DP
X-Received: by 2002:a05:7022:eb42:20b0:16d:1e24:5cc3 with SMTP id
 a92af1059eb24-18512c382bamr740379c88.19.1792172771550; 
 Fri, 16 Oct 2026 10:46:11 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:11 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ankit Garg <nktgrg@google.com>
Subject: [PATCH v4 06/10] net/gve: fix Tx stall on invalid packets
Date: Fri, 16 Oct 2026 17:45:41 +0000
Message-ID: <119eade6994b1a5f8d6be5ba2db713896ff40178.1792170902.git.tathagat.dpdk@gmail.com>
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

When a packet fails rte_mbuf_check() or exceeds the descriptor limit,
the Tx burst stops at that packet without consuming it. The
application retries the same packet, it fails again, and the queue
never moves.

Free such packets and continue with the burst. Validate before the
ring space check, so that an oversized packet is dropped instead of
stopping the burst there. Count rte_mbuf_check() failures in a new
invalid_mbufs counter.

Fixes: f4a70b449bfa ("net/gve: add DQO Tx descriptor limit")
Fixes: f33ce4445ee6 ("net/gve: validate Tx packet before sending")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_ethdev.h |  1 +
 drivers/net/gve/gve_tx_dqo.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 4d17ba727d..66cb31dadb 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -114,6 +114,7 @@ struct gve_tx_stats {
 	uint64_t bytes;
 	uint64_t errors;
 	uint64_t too_many_descs;
+	uint64_t invalid_mbufs;
 };
 
 struct gve_rx_stats {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 637632ce4d..281700b463 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -258,6 +258,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t compl_tag;
 	uint16_t req_descs;
 	const char *reason;
+	uint16_t nb_sent = 0;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
 	uint64_t ol_flags;
@@ -280,7 +281,9 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		if (rte_mbuf_check(tx_pkt, true, &reason)) {
 			PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reason);
-			break;
+			txq->stats.invalid_mbufs++;
+			rte_pktmbuf_free(tx_pkt);
+			continue;
 		}
 
 		ol_flags = tx_pkt->ol_flags;
@@ -289,6 +292,14 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+
+		/* Drop packet if it doesn't adhere to hardware limits. */
+		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
+			txq->stats.too_many_descs++;
+			rte_pktmbuf_free(tx_pkt);
+			continue;
+		}
+
 		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
 		/* Clean if there aren't enough descriptors to send the packet
@@ -303,12 +314,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				break;
 		}
 
-		/* Drop packet if it doesn't adhere to hardware limits. */
-		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
-			txq->stats.too_many_descs++;
-			break;
-		}
-
 		if (!gve_free_compl_tags_pop(txq, &compl_tag))
 			break;
 
@@ -347,6 +352,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		txq->nb_free -= nb_descs;
 		txq->nb_used += nb_descs;
+		nb_sent++;
 	}
 
 	/* update the tail pointer if any packets were processed */
@@ -354,9 +360,9 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		rte_write32(tx_id, txq->qtx_tail);
 		txq->tx_tail = tx_id;
 
-		txq->stats.packets += nb_tx;
+		txq->stats.packets += nb_sent;
 		txq->stats.bytes += bytes;
-		txq->stats.errors += nb_pkts - nb_tx;
+		txq->stats.errors += nb_pkts - nb_sent;
 	}
 
 	return nb_tx;
-- 
2.43.0

