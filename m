Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431AC79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F166415D7;
	Wed,  9 Sep 2026 17:05:00 +0200 (CEST)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76]) by mails.dpdk.org (Postfix) with ESMTP id 9C242411F3
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:04:59 +0200 (CEST)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so189487f8f.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966299; x=1789571099; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s8RvsLv5Fg8k5Zjlgl9iKzQ6bAVRFvn0HqiDMRxSYog=;
 b=YoVR12WSCZSqAj7EldJ88lKzhJOc7Uk+AHPoWJVgU+LRY0u3D/exeA4p6/4+7sXepS
 mMHxDGA0R9YRYPWvZ1wY6kYgtRZTjh85i+AAsENCpBiAgRiW/wVLCaYVM3w1uuskc75k
 gBIybJlRaLx4zdpRgt1fVgB0JoFvnq4y93sLmP4sL3ztYHtKhEvGuR8VRIjOKy2CNB8X
 9vNAwUljo6MM4R597BbReq06RSwK0wpzm7CIZoCFnZuFbb+7SGsuMdJASEosAGi1nK+R
 LtCFx021cJsmZewx0McIZ25W/G2sZzrbPWqwlRGRoPGnU2KsHhP6X9S2Zlzdy1/QRh+w
 hU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966299; x=1789571099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s8RvsLv5Fg8k5Zjlgl9iKzQ6bAVRFvn0HqiDMRxSYog=;
 b=pHlbgJZZ/HyomMgcml5GezY5+yt33Rr9rP36w6Lz3TMJW2Hz7c9O7XP9DTAOrtOzZO
 ZA7PR9v9hV/vcFLeH4xezEMUs3W2soFMV3Fg5DfEKGg/zXjOY/C/SjwFk2dDSBSADC05
 ey6tH+xoFUqpLLDRdt6p9A2+7NxM/9Q9ajpedm3BGza85dzLHnU1tn6gOsEsOACcRiQo
 uuuQuR335rxuLTlU1cRd/eX3KyxliXaRwN/RYDdgj4xXTNBqSUUnhhlXCiGOrmLatz9o
 XvLwewv4VUTMzW1Rzad7E4HtWOoK1S5YtWYfWy07IxFzqlAcR5q1O9+bx+AHAQghrcVn
 iL3A==
X-Gm-Message-State: AFuF++mmaILTWZt528gyUwigyd69O/0qUQrjiIsAYMS8pBIbQZHjqTNK
 +shFehb9aWs96FjeY/6YvqBjiGGqfbZ3Q6oPshJqSvDptgQDl03S8dWFNV+icg==
X-Gm-Gg: AYBFou1CFeSgpSSrkToO39PEBaDnTYvJUH8gvR+W0WwRKGzhe0y6m7wpPDKrf3HoQci
 9b2vPT45PFd+mgKde7v5Obdd4VNt+qbcqTrJn7AiknuadEw0iAB/MMwPEAWxVbE8lrtl2y4TVf0
 j+i7XHpoHPNeibz/uQhjzPXUH2ldN7KqutNm6mgecNbCpcfsRpYjOi08dsNEWqfIIYO1pkhrLD7
 3OHiBtTBsdhpn6znHwLwyubllC2H+xcvvLKOJfyKRGecBFR3lgkYp7eTJKXdwQaRkVasGrI6D/i
 7Hafga6IBZjSfO66jcMcla8xiToX020L7xjMgJFjAp4qiU/fRe4Yxu67pFBDrEpVWcf4l3sAvsK
 Ib2yDayqCcpv/r474O68gE/R4vuW9ww8fchJhvdSRWafJ32G0Sku2TcJ+Aj48KhTp8ZtY7trAyl
 y0Bmd+QuhGAP31/qDXUKorUqi0yWhmOgCI8dzthg/ttwU10Io4Uj+AOgmIsY8qtYQ10am//R7aR
 k5Zi+vz8Z49tzgzhKkT4znwbk7O9NxGdnmSehgQzQ56v8OM4R0yRK/v7hSR
X-Received: by 2002:a05:6000:2303:b0:485:8a47:5b92 with SMTP id
 ffacd0b85a97d-485c2408352mr2399972f8f.47.1788966299108; 
 Wed, 09 Sep 2026 08:04:59 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588390e30sm42914438f8f.7.2026.09.09.08.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:04:58 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 3/6] examples/l3fwd-power: enable Rx interrupt before epoll
 add
Date: Wed,  9 Sep 2026 17:04:46 +0200
Message-ID: <20260909150449.856295-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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

event_register() added each Rx queue interrupt fd to the per-thread epoll
set before the worker loop, while the queues were still disarmed. This
works when the fd is assigned at queue setup and stays fixed, as on MSI-X
NICs.

The dpaa2 PMD delivers Rx interrupts through a per-lcore QBMan portal and
binds the fd when the interrupt is enabled, not at queue setup. Adding a
queue to the epoll set before arming it then watches an fd that is not
bound yet, so the lcore never wakes from rte_epoll_wait().

Register from rx_interrupt_wait(), after the queues are armed, and only
once: keep the epoll entry installed for the lifetime of the loop, with
the state in struct lcore_conf. NICs with a fixed per-queue fd are
unaffected.

The "RX interrupt won't enable" notice moves to the loop error path, where
it is still logged once per lcore since intr_en latches off.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 70f76d202e..43a0509bd5 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -368,6 +368,7 @@ struct __rte_cache_aligned lcore_conf {
 	struct rte_eth_dev_tx_buffer *tx_buffer[RTE_MAX_ETHPORTS];
 	lookup_struct_t * ipv4_lookup_struct;
 	lookup_struct_t * ipv6_lookup_struct;
+	bool intr_registered;
 };
 
 struct __rte_cache_aligned lcore_stats {
@@ -953,6 +954,16 @@ rx_interrupt_wait(struct lcore_conf *qconf)
 	if (ret != 0)
 		return ret;
 
+	/* some PMDs expose the interrupt fd only once the queue is armed */
+	if (!qconf->intr_registered) {
+		ret = event_register(qconf);
+		if (ret != 0) {
+			rx_intr_disable_all(qconf);
+			return ret;
+		}
+		qconf->intr_registered = true;
+	}
+
 	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
 	rx_intr_disable_all(qconf);
 	return 0;
@@ -970,7 +981,7 @@ static int main_intr_loop(__rte_unused void *dummy)
 	struct lcore_rx_queue *rx_queue;
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
-	int intr_en = 0;
+	int intr_en = 1;
 	int ret;
 
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) /
@@ -998,12 +1009,6 @@ static int main_intr_loop(__rte_unused void *dummy)
 				lcore_id, portid, queueid);
 	}
 
-	/* add into event wait list */
-	if (event_register(qconf) == 0)
-		intr_en = 1;
-	else
-		RTE_LOG(INFO, L3FWD_POWER, "RX interrupt won't enable.\n");
-
 	while (!is_done()) {
 		stats[lcore_id].nb_iteration_looped++;
 
@@ -1107,6 +1112,8 @@ static int main_intr_loop(__rte_unused void *dummy)
 					if (ret == -EAGAIN)
 						goto start_rx;
 					if (ret != 0) {
+						RTE_LOG(INFO, L3FWD_POWER,
+							"RX interrupt won't enable.\n");
 						intr_en = 0;
 						continue;
 					}
@@ -1260,7 +1267,7 @@ main_legacy_loop(__rte_unused void *dummy)
 	enum freq_scale_hint_t lcore_scaleup_hint;
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
-	int intr_en = 0;
+	int intr_en = 1;
 	int ret;
 
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) / US_PER_S * BURST_TX_DRAIN_US;
@@ -1286,12 +1293,6 @@ main_legacy_loop(__rte_unused void *dummy)
 			"rxqueueid=%" PRIu16 "\n", lcore_id, portid, queueid);
 	}
 
-	/* add into event wait list */
-	if (event_register(qconf) == 0)
-		intr_en = 1;
-	else
-		RTE_LOG(INFO, L3FWD_POWER, "RX interrupt won't enable.\n");
-
 	while (!is_done()) {
 		stats[lcore_id].nb_iteration_looped++;
 
@@ -1428,6 +1429,8 @@ main_legacy_loop(__rte_unused void *dummy)
 					if (ret == -EAGAIN)
 						goto start_rx;
 					if (ret != 0) {
+						RTE_LOG(INFO, L3FWD_POWER,
+							"RX interrupt won't enable.\n");
 						intr_en = 0;
 						continue;
 					}
-- 
2.43.0

