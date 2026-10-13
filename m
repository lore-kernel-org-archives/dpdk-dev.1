Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585E6CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 741954064E;
	Tue, 13 Oct 2026 16:49:50 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 703254042E
 for <dev@dpdk.org>; Tue, 13 Oct 2026 12:44:03 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-35943f55c06so2322680eec.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791888242; x=1792493042; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YjQSJvlpoHGBNf5Q8sMB5XTRDjtTb0B/KRwBGFyEHkM=;
 b=RYJaztzEcyJO63J4Gx2/RfypBr5i9MgAXSQcHwMR6ge3E9QjDYCOk/xexOFepwJX8g
 14h69AepISC6bNOZ1QuoolgJC6kCadooOgt1WIxceHxWxakTcyOKGgxRN0urjsf2JMie
 QmaCZKtoJ+W5BhQ9tU4GuzsmKxTsraVKXIiunGJ2zWdfXYzxGDsHjt1XBTO8ifepTfiZ
 +I2y8uH9CwTdZhSfjg7DcC+7OR+zXJIi2AcRyTuA9hH0SUDMa8F4nnhYTHaWdB0MTls9
 Fl1EoTzGS6SAhKO5iOgKmP1Uk6mUUg0AF9BJOlCG/ycsE1KnFRGu8YKdWbiVyBIZjwuE
 V8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888242; x=1792493042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YjQSJvlpoHGBNf5Q8sMB5XTRDjtTb0B/KRwBGFyEHkM=;
 b=AWr07a3Gzz4MtMxNTajyWvoH7fvxZoEV8mPUGjz2ANOHXYV7Rja6B9uJsaQswvILIx
 pGuMMSxoTPzrDHgfi6TBvi81z5SJPLsq4cpbIch9ZCL2JaK6cT8mhr/5CJQaHGTQlVXz
 +gAMiIXHRVTDhNZub/Q3uUSwuV4OW3q3mJ8KJyBN7XdERWEQQJ0MLYLLYPJmy2kjifbn
 aizWBlN7PBT1BCTZgghw3ybkaSngbgylCs+0uvzCWtMbygjiGMQFedFe2PDboG05NhT/
 7/3aWralREtSxAGON8pgDuMLG2kMhw/KMsYb6HvCJ7xXo5M3WX8uUfs7hBMPINhszO0i
 w7qw==
X-Gm-Message-State: AFq9FYKxLiKj4642Z7j9x9+Ktqn7gzgG90lFNc1klIA+pFU2pO/RT60j
 8r851gzS0i2K/HAE0evUe76PzXbo20LTus89MwXXhlt8X8XrEhrJ0nERK7M7QA==
X-Gm-Gg: AYBFou0RKIseELeGO6i7slvscNp9g71sRRBqgit+2PZ41F0teLGnnM9LplqCcR7T9MG
 Da08sDDQ/M8vt4jN81OPVfjJ+wDAvVkXX+3ROtRu++TChK5emWrFMdrJ+eCAUHfJquacyf0e7ff
 BO4KK9750nnsE9K1M4aq+4hBe767k/kHjjseo+BgwGZo1FD/F+a9nmeN9o2l+o2PLlw2ldUflr/
 1OGpDUE0OFjKbkvioZsam4awsbgU5PlNHbAMqiw12HdCfaU1qyQUuddG2d4tBnUp4RtyTfh2FN+
 FpDDv8D7TFCfjm8nyjifuAqzvJbEHug3255VSKaEmcLiUWRI6Ip0ny3D/6MkBLdw1HjhGrbCROY
 lAFC+oI3ua4bt6pSk/8o3xnSxxde+XqHt8cA1mJIKxCg8tV1/qcTAG8LOJoezUy952ro4Blxjl3
 0iWxK6YTOopSdH82E8ypCVAIIl3Kies42fTZQF2952Qtueta+GGAygmDyZPLTbxr36UOl1HQr+
X-Received: by 2002:a05:7300:ea85:b0:359:fb64:11d7 with SMTP id
 5a478bee46e88-359fb64144dmr9115739eec.11.1791888242363; 
 Tue, 13 Oct 2026 03:44:02 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm16695675eec.24.2026.10.13.03.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:44:01 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v2 3/4] net/gve: add cacheline overlap margin to DQO Tx ring
Date: Tue, 13 Oct 2026 10:43:47 +0000
Message-ID: <20261013104348.714550-4-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104348.714550-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
 <20261013104348.714550-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:49:47 +0200
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

The GVNIC DQO hardware DMA engine prefetches descriptors in cacheline
units (64 bytes = 4 descriptors of 16 bytes each). When producer tail
and consumer head indices share a cacheline, CPU and device DMA memory
collisions can occur.

Align with the Linux driver (gve_has_tx_slots_available()) by requiring
GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) headroom when
checking descriptor availability before enqueueing packets.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 0839179d7f..eee1f10df1 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -260,6 +260,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint64_t bytes = 0;
 	const char *reason;
 	uint16_t compl_tag;
+	uint16_t req_descs;
 	uint64_t ol_flags;
 	uint16_t nb_descs;
 	uint16_t tx_id;
@@ -291,14 +292,17 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
-		/* Clean if there aren't enough descriptors to send the packet. */
-		if (unlikely(!gve_can_tx(txq, nb_descs, 1))) {
+		/* Clean if there aren't enough descriptors to send the packet
+		 * while maintaining the cacheline overlap margin.
+		 */
+		if (unlikely(!gve_can_tx(txq, req_descs, 1))) {
 			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
-						  nb_descs);
+						  (int)req_descs);
 
 			gve_tx_clean_descs_dqo(txq, nb_to_clean);
-			if (!gve_can_tx(txq, nb_descs, 1))
+			if (!gve_can_tx(txq, req_descs, 1))
 				break;
 		}
 
-- 
2.43.0

