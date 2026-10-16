Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA1CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8C9140A7D;
	Fri, 16 Oct 2026 13:31:36 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 81A37402EE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:08 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so345187c88.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132027; x=1792736827; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U06ix2DxLCp+PQezcwt6PA66l2msHfBYKCNZ3Y+FGkA=;
 b=mT3YkJWb00BnsxIG35oB5Zf52teT0EbLM78ox8n6wSKOGPWTA87JzRi/SNF+x5npt+
 e4TU/dL2h+J5gcohMX0g/z7+Z6h6vw4dxDveCsMuh/TI7UbMFxHcW6kYJi5FOh5G1UTL
 ybbSC6QPebkgwywki2A7sqkrT9Uxd/oc9WbJbI73rSMnkNawlLM7vRFHU5O/CTxhzW28
 JV+ghv0UGOm4OD+SZYa32rxVzZvhlliXMxtG15OH6fl9p0zXF7oDjoyDklhaaO4lyyyx
 Ngqx1LKitSZnbWLeUT8h/XfaqWK54+OWX29x27POzKSXa5fOHB4QusjeQDiB8yIPXqoq
 mwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132027; x=1792736827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U06ix2DxLCp+PQezcwt6PA66l2msHfBYKCNZ3Y+FGkA=;
 b=oJeZ1jRx6arjCttHqbKqu02kjImj6CeGH5q5SWpCXIBoEUb8Bv6W4qyu8NcCcLl40c
 m4iCE+25lAuMBqhK88lBjTcl8b6VZvhTqkwnYEJwwpmDiL/MHHiryQY+kdiWcHXtihFB
 npE+PDU6K5TOBwejzyghbGs7WH4txdhEE1BVuyOri+rlSOOCDoh1daGPl1p0CmMeu33n
 7je2MizV3rzAvUOUZZt9Mmy0pujeHo6hi+VGYlTQayW9MCv+JLTwPBAUIyDVqJO75EtU
 opHx7092IZKnwlSqH6Fb4rjktt52DH4INdvmHpiUHI6ufyiVvO11xpNsoVVNDQQSun6+
 4C0Q==
X-Gm-Message-State: AFq9FYI8MVzFnJOhep+15c4SOSCkr+XGMcGj/TLRimm3zZU0hSOV9N48
 3vAHIepkGReu9VBkp7+v0v4J+StB9edgmfC1W8a3pr+hY14LWBmKyFtwHLoflA==
X-Gm-Gg: AYBFou3/Yx+3/8PHHfBHpyGtSGEsljE4s5F7x1IcbJH8ZmbeOnq8gm46UrObu3cMj66
 aAGfQ7O+qENfZeQiNTpPgO3RA46aDc2CLu+TNR8Gp3y3+S7N0w0GLun0uHVWPojG4tbXfaTZ8Aa
 750yg7GIl7yQR3x2RXhdFz/sIIBbA7gwrsqTOg10YCm44rV0z9E4kQ+iaM8B9t4LCzM0FjgKZx2
 XQy3CbNNbCcRqc87dRcQAk8LvyLutnwpWURVIiSLq6kZpqGkTOK6X2hu1i850tNYLQwjPoP2YS9
 gamR9rJ8l6/Nw+NrANgmdyuKqGeOMAT8fCadTCjpFnOW+cq8P3P5Rg49HLVqPumoj1lYMAuTqyj
 ytqnlsecNErQoLQWBOCH2nS9N7c5k6OvqpPXKVIMV0YXgbW53y27KSY/C2FphSwZXnVIpA0wTwb
 /nPrzIbpqdOvqNGzPzPbT1GOgktWoHcW9DBIEbesya5ycTUW6EhTK07A+PpEECDCmwK2AKDRPy
X-Received: by 2002:a05:7022:e884:b0:17e:6de6:6a1a with SMTP id
 a92af1059eb24-17e6de66ab6mr11586382c88.8.1792132027407; 
 Thu, 15 Oct 2026 23:27:07 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:06 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 06/10] net/gve: fix Tx stall on invalid packets
Date: Fri, 16 Oct 2026 06:26:43 +0000
Message-ID: <771fdd2b2d81d74832aa5499999791e09c1c2c97.1792129992.git.tathagat.dpdk@gmail.com>
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
index 8349b1c92e..24ef3a4552 100644
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
index c5ae2136ad..44d2fa870f 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -261,6 +261,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t compl_tag;
 	uint16_t req_descs;
 	const char *reason;
+	uint16_t nb_sent = 0;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
 	uint64_t ol_flags;
@@ -283,7 +284,9 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		if (rte_mbuf_check(tx_pkt, true, &reason)) {
 			PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reason);
-			break;
+			txq->stats.invalid_mbufs++;
+			rte_pktmbuf_free(tx_pkt);
+			continue;
 		}
 
 		ol_flags = tx_pkt->ol_flags;
@@ -292,6 +295,14 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
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
@@ -306,12 +317,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
 
@@ -350,6 +355,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		txq->nb_free -= nb_descs;
 		txq->nb_used += nb_descs;
+		nb_sent++;
 	}
 
 	/* update the tail pointer if any packets were processed */
@@ -357,9 +363,9 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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

