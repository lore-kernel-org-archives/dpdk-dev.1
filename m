Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB81CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DEE43285;
	Thu,  1 Oct 2026 00:44:54 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7F87142EFE
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:49 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so2866550a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808289;
 x=1791413089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/HI3bau6sHEIgs0yqq7O2abC1kK275cPiP4t3dOLUYE=;
 b=A2EFQ6BU2YM+F1nj8eklUzt2/yKZ8+W40vY17QdGIBYEUGSvETdvUOQ0cQZT9lCHEb
 4NPK8bd2IUZjKNVdkGqQzf7trfKYMxf2CMAPQY9Hh4oK6mXUbMgypEzGGYlNwuyW5zUm
 /FEbCq1499OUigNlPPTfr+csWB1NAtw5YGBuCNwyMOxkDlCIdAzoLv4C2uC7EgIj2MAX
 /qLSYov6gXQNEsH4uhupscGBf54Cw8zYPs5TkcfPJkSZdX+JaSgrCImrzMBImhkMr7Xy
 qSWQy/jkgfKwqR/7FR/+pjYC1VcFwIuXiIIuHD9mZ5oq12g/NwLB+TwKDd/yG0l4olja
 31Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808289; x=1791413089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/HI3bau6sHEIgs0yqq7O2abC1kK275cPiP4t3dOLUYE=;
 b=eWerZuTxOrz3rbAImP/u9sXP+dOsaz6owjPpzhF2IriKaUDFGqvYZF2D0tCUr2xwvY
 mJ0+hzQz37hQfuaRObYJn240TVT+U9bVvyEZ7qmEuX1xy6UI7tA7XiNNciwPS7VbBrol
 PCSMcxR3CjmsxNlbl01cCpBeGmUJUWStB7kZhWlpH9D1/Xmb+1QoDNUjgJqceqGcSL8B
 /XCTsQVqPg73oJLEOdpfTFDwklbqRjqnshaFGmcKR7R5fD1gGgrQDI/PBV9x/0vZnnA3
 c2lCKRcfUupN+qwKp/7FdzZYjRe/QlDDmDqnXBBuWiZmu9JQZrSBSmRDLtctTonyuKgc
 BQTw==
X-Gm-Message-State: AFq9FYL6qoy4/u2yvPBYWvLAVmRli5Xp7IW2mbQlNvK8nxKKask3AsH9
 ORlOZGTdNxBbHld2VgRmG9uZ3vrDpRXtc4fZs4KYJyoLFMhSR/cSNKD+gM0hboVtRlzBbb0LauM
 ZkWzkQQ8=
X-Gm-Gg: AYBFou18TVpdj+AyfjzBJeI6pI1idgsWtxS94WxLqIDiXjVMM61vmcdLMuBa70acr42
 22SGv/UAS58DXTQDg9hXpe0OnBUloLWg5AstiYGvRZoMxfmpLcNRujV0YRPCrdIPrEPQ3cHzakt
 FQHhTplZmWU2STn+yDD4uHoan1oYW+gOujfFU/kKsuIQTCfPjOV2lfTLZAPICRi+3TyJ7jj7WjU
 K5OnIXJXozBJeofkNQ3//j8h0nHeWc/Ke7Q7r44NMXnonJBoIC3EGaCIdbtNtQYVs0by2/dp2DG
 zk5QkOuzTqdJ5LVQA/GugRUmMlsKjJd8GxD65jH/eppvJUbGr2UNBZg7G+8ZgPzq6o4MDT7E9y0
 0L1eAgpo7cZ7GEfyVr0XGe0Ej0B7AViwGZN4UIsJmW/j2PEFZul89wIv4WL2rOnc0YmyCaQyaIe
 PNq5G2HAUNTcmA2OiNewT0iDX12gWzy9hT31XvDrCVbr6RV+BT23hHWPSxAzyiI1YN71KzCEKbT
 DdlG9KRONfUW7t61sXcjpKKuI/A7EUckKelRQ==
X-Received: by 2002:a17:90b:3143:b0:3a0:e320:d1d4 with SMTP id
 98e67ed59e1d1-3a4d1509b3fmr2434639a91.16.1790808288645; 
 Wed, 30 Sep 2026 15:44:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 63/65] event/sw: use kvargs range handlers
Date: Wed, 30 Sep 2026 15:41:21 -0700
Message-ID: <20260930224340.58580-64-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The handlers for sched_quanta, credit_quanta, min_burst and deq_burst
each applied a range and stored the result, and returned -1 without
logging, so a value out of range was rejected with nothing to say what
the range was.

Use rte_kvargs_handle_urange(), which reports it. The per key
SW_LOG_ERR is kept since it names the device, which kvargs cannot.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c | 89 +++++++++----------------------------
 1 file changed, 21 insertions(+), 68 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index fa9fe3e4c2..30c6111868 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -872,58 +872,6 @@ sw_close(struct rte_eventdev *dev)
 	return 0;
 }
 
-static int
-set_sched_quanta(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *quanta = opaque;
-	uint64_t val;
-
-	if (rte_kvargs_to_uint(value, 0, 4095, &val) < 0)
-		return -1;
-
-	*quanta = val;
-	return 0;
-}
-
-static int
-set_credit_quanta(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *credit = opaque;
-	uint64_t val;
-
-	if (rte_kvargs_to_uint(value, 0, 127, &val) < 0)
-		return -1;
-
-	*credit = val;
-	return 0;
-}
-
-static int
-set_deq_burst_sz(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *deq_burst_sz = opaque;
-	uint64_t val;
-
-	if (rte_kvargs_to_uint(value, 0, SCHED_DEQUEUE_MAX_BURST_SIZE, &val) < 0)
-		return -1;
-
-	*deq_burst_sz = val;
-	return 0;
-}
-
-static int
-set_min_burst_sz(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *min_burst_sz = opaque;
-	uint64_t val;
-
-	if (rte_kvargs_to_uint(value, 0, SCHED_DEQUEUE_MAX_BURST_SIZE, &val) < 0)
-		return -1;
-
-	*min_burst_sz = val;
-	return 0;
-}
-
 static int32_t sw_sched_service_func(void *args)
 {
 	struct rte_eventdev *dev = args;
@@ -979,10 +927,15 @@ sw_probe(struct rte_vdev_device *vdev)
 	struct rte_eventdev *dev;
 	struct sw_evdev *sw;
 	int socket_id = rte_socket_id();
-	int sched_quanta  = SW_DEFAULT_SCHED_QUANTA;
-	int credit_quanta = SW_DEFAULT_CREDIT_QUANTA;
-	int min_burst_size = 1;
-	int deq_burst_size = SCHED_DEQUEUE_DEFAULT_BURST_SIZE;
+	struct rte_kvargs_urange sched_quanta = {
+		.min = 0, .max = 4095, .val = SW_DEFAULT_SCHED_QUANTA };
+	struct rte_kvargs_urange credit_quanta = {
+		.min = 0, .max = 127, .val = SW_DEFAULT_CREDIT_QUANTA };
+	struct rte_kvargs_urange min_burst_size = {
+		.min = 0, .max = SCHED_DEQUEUE_MAX_BURST_SIZE, .val = 1 };
+	struct rte_kvargs_urange deq_burst_size = {
+		.min = 0, .max = SCHED_DEQUEUE_MAX_BURST_SIZE,
+		.val = SCHED_DEQUEUE_DEFAULT_BURST_SIZE };
 	bool refill_once = false;
 
 	name = rte_vdev_device_name(vdev);
@@ -1006,7 +959,7 @@ sw_probe(struct rte_vdev_device *vdev)
 			}
 
 			ret = rte_kvargs_process(kvlist, SCHED_QUANTA_ARG,
-					set_sched_quanta, &sched_quanta);
+					rte_kvargs_handle_urange, &sched_quanta);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing sched quanta parameter",
@@ -1016,7 +969,7 @@ sw_probe(struct rte_vdev_device *vdev)
 			}
 
 			ret = rte_kvargs_process(kvlist, CREDIT_QUANTA_ARG,
-					set_credit_quanta, &credit_quanta);
+					rte_kvargs_handle_urange, &credit_quanta);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing credit quanta parameter",
@@ -1026,7 +979,7 @@ sw_probe(struct rte_vdev_device *vdev)
 			}
 
 			ret = rte_kvargs_process(kvlist, MIN_BURST_SIZE_ARG,
-					set_min_burst_sz, &min_burst_size);
+					rte_kvargs_handle_urange, &min_burst_size);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing minimum burst size parameter",
@@ -1036,7 +989,7 @@ sw_probe(struct rte_vdev_device *vdev)
 			}
 
 			ret = rte_kvargs_process(kvlist, DEQ_BURST_SIZE_ARG,
-					set_deq_burst_sz, &deq_burst_size);
+					rte_kvargs_handle_urange, &deq_burst_size);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing dequeue burst size parameter",
@@ -1061,10 +1014,10 @@ sw_probe(struct rte_vdev_device *vdev)
 
 	SW_LOG_INFO(
 			"Creating eventdev sw device %s, numa_node=%d, "
-			"sched_quanta=%d, credit_quanta=%d "
-			"min_burst=%d, deq_burst=%d, refill_once=%d",
-			name, socket_id, sched_quanta, credit_quanta,
-			min_burst_size, deq_burst_size, refill_once);
+			"sched_quanta=%"PRIu64", credit_quanta=%"PRIu64" "
+			"min_burst=%"PRIu64", deq_burst=%"PRIu64", refill_once=%d",
+			name, socket_id, sched_quanta.val, credit_quanta.val,
+			min_burst_size.val, deq_burst_size.val, refill_once);
 
 	dev = rte_event_pmd_vdev_init(name,
 			sizeof(struct sw_evdev), socket_id, vdev);
@@ -1085,10 +1038,10 @@ sw_probe(struct rte_vdev_device *vdev)
 	sw->data = dev->data;
 
 	/* copy values passed from vdev command line to instance */
-	sw->credit_update_quanta = credit_quanta;
-	sw->sched_quanta = sched_quanta;
-	sw->sched_min_burst_size = min_burst_size;
-	sw->sched_deq_burst_size = deq_burst_size;
+	sw->credit_update_quanta = credit_quanta.val;
+	sw->sched_quanta = sched_quanta.val;
+	sw->sched_min_burst_size = min_burst_size.val;
+	sw->sched_deq_burst_size = deq_burst_size.val;
 	sw->refill_once_per_iter = refill_once;
 
 	/* register service with EAL */
-- 
2.53.0

