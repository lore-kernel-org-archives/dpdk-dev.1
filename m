Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305A1CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52B7942F9F;
	Thu,  1 Oct 2026 00:44:34 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id BA80D42EB3
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:31 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c6bfce73so897350a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808271;
 x=1791413071; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=jOTEeOTys1wNxQl/uhiW2zyklL3aYq3ydWlT7jD7QuYHxjJpzswpS/pqtQdXuGT+hT
 4X1+0tk3s0nAPGA7WNxQb63mTrLIBmrHa997pVKa10oxigEEHTmviOD55ssh3Dokzpx6
 Dp+TEJrAMNkdop1ftTycqFMLwQlUBq7wTMHUPwM876waIDPwywzhyBp/Wiji28AIsdBo
 KWE6+4dbJPvqmExnsGt9AWQ3bNcSbNqZjj7GB/wdwaw/m7mRIWjPW4LOiPyOTFEkVXS6
 BhLDlb6TX+kvRKfHPEuCPPiVx/B1WU5TU6eZiLDtxAAuB9uqllAqgJwFxpQASR7kuS9Y
 XjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808271; x=1791413071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=l17TDo/gsHz52wxAE8X6VogRIcLovTdWmaT07YxD0ylEjVJ7oMh6L215xZPsYmqgo+
 XngsoXoFyXms99NEycU2jIib3sjT/owV8uZB292GXBf/2RZt3HdzC035zC9S484P4ARd
 vWGhjkQu1E0EnqWu1uxghl/2R8/oOxdltVZqzcA/gnKxFdFZ333kHVIN59sHjjDIywj0
 l4ZLkUMvye67v0xYkX+aftXE8HzCb/FI+XBfk6X16LEDRNmha7aiU8ZsR29+ba73MHsc
 17cvDJl93DqJTlI6oIYoc74iQrDLUanG8hb0PrsJ5QgNmdJbX/FFgr6Z6LARBgzzBoLJ
 uWnw==
X-Gm-Message-State: AFq9FYIwlgK5aXHPC6+07VdGpeu/lprh7zx8w3YfHYlXf6gmIU2sE6kJ
 k8Y5XtXyuBBjDv0xvhLRHQiS1xuKOS3N6rJLzX1tLH7t5UQ9T1lCbOUm4E7GGa3htiepJIBCUVt
 OvJApcpo=
X-Gm-Gg: AYBFou3d/ZgM8MBO77ISwLKs6/P5e1JNst8rTy9Ly448zOF4dd0C9kaePbH9tZokM4i
 AqdMQKDyvKwTRozT9pmkcN1leJYn+hmK66+9GhESGzincxEuRkYSFlf1u9ZVfF8G8c4mhUk8SDl
 6pqZXqisd0YppPU87DvkZsvBDu9Bku3NE/NKqN7sKjKetNfJI4ZFzqyb+aE6xO8/leXBQIvIYmx
 qETYoODm/qNffi4Nd9/mRfQ0jqB9XMNXuA0Hum3ZOxKTAd7iXkWU6JNiPI4WxGec8m4w27SKZaB
 Qe6zPE5k2vK63XCqh3g4DZVUnBq3SyHpmrhCPWwBwk5gwirkrscnVbM587LEHbnJW6cjns8Dmhq
 uPrHGxBVi9NttPFOM7baxwc0XmOu+usL+LkjCHfgYZizjlcMb0VD2pN2KiaoqszLO6WZuRIa/Ku
 syZWSalzRQJVYDMJC9vyg3eogxwPcZXWSM9errvdUlxgDXZqy08AZk8CTAOw/oZ7G6eeUl7FCzQ
 KfPSGVCtqC1Xh/9yMw/aOjwbrnxv15/kh8DyjcdM5A2JZAE
X-Received: by 2002:a17:90b:584d:b0:398:b1eb:136c with SMTP id
 98e67ed59e1d1-3a4f776e08cmr441874a91.9.1790808270814; 
 Wed, 30 Sep 2026 15:44:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 44/65] event/sw: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:02 -0700
Message-ID: <20260930224340.58580-45-stephen@networkplumber.org>
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

All six handlers use atoi(), which cannot report an error, so a
malformed value is silently taken as zero. Since zero is within the
accepted range for every one of these arguments, a typo such as
"sched_quanta=abc" was accepted and quietly applied as zero.

The lower bound is now part of the conversion, so the separate negative
checks are no longer needed.

refill_once is a boolean, so drop set_refill_once() and use
rte_kvargs_handle_bool(). The registered parameter string said
"=<int>", which was never true, and now says "=<0|1>". A bare
"refill_once" enables it, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c | 56 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index 3ad82e94ac..fa9fe3e4c2 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -872,23 +872,16 @@ sw_close(struct rte_eventdev *dev)
 	return 0;
 }
 
-static int
-assign_numa_node(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *socket_id = opaque;
-	*socket_id = atoi(value);
-	if (*socket_id >= RTE_MAX_NUMA_NODES)
-		return -1;
-	return 0;
-}
-
 static int
 set_sched_quanta(const char *key __rte_unused, const char *value, void *opaque)
 {
 	int *quanta = opaque;
-	*quanta = atoi(value);
-	if (*quanta < 0 || *quanta >= 4096)
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, 4095, &val) < 0)
 		return -1;
+
+	*quanta = val;
 	return 0;
 }
 
@@ -896,9 +889,12 @@ static int
 set_credit_quanta(const char *key __rte_unused, const char *value, void *opaque)
 {
 	int *credit = opaque;
-	*credit = atoi(value);
-	if (*credit < 0 || *credit >= 128)
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, 127, &val) < 0)
 		return -1;
+
+	*credit = val;
 	return 0;
 }
 
@@ -906,9 +902,12 @@ static int
 set_deq_burst_sz(const char *key __rte_unused, const char *value, void *opaque)
 {
 	int *deq_burst_sz = opaque;
-	*deq_burst_sz = atoi(value);
-	if (*deq_burst_sz < 0 || *deq_burst_sz > SCHED_DEQUEUE_MAX_BURST_SIZE)
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, SCHED_DEQUEUE_MAX_BURST_SIZE, &val) < 0)
 		return -1;
+
+	*deq_burst_sz = val;
 	return 0;
 }
 
@@ -916,19 +915,12 @@ static int
 set_min_burst_sz(const char *key __rte_unused, const char *value, void *opaque)
 {
 	int *min_burst_sz = opaque;
-	*min_burst_sz = atoi(value);
-	if (*min_burst_sz < 0 || *min_burst_sz > SCHED_DEQUEUE_MAX_BURST_SIZE)
-		return -1;
-	return 0;
-}
+	uint64_t val;
 
-static int
-set_refill_once(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *refill_once_per_call = opaque;
-	*refill_once_per_call = atoi(value);
-	if (*refill_once_per_call < 0 || *refill_once_per_call > 1)
+	if (rte_kvargs_to_uint(value, 0, SCHED_DEQUEUE_MAX_BURST_SIZE, &val) < 0)
 		return -1;
+
+	*min_burst_sz = val;
 	return 0;
 }
 
@@ -991,7 +983,7 @@ sw_probe(struct rte_vdev_device *vdev)
 	int credit_quanta = SW_DEFAULT_CREDIT_QUANTA;
 	int min_burst_size = 1;
 	int deq_burst_size = SCHED_DEQUEUE_DEFAULT_BURST_SIZE;
-	int refill_once = 0;
+	bool refill_once = false;
 
 	name = rte_vdev_device_name(vdev);
 	params = rte_vdev_device_args(vdev);
@@ -1004,7 +996,7 @@ sw_probe(struct rte_vdev_device *vdev)
 				name);
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
-					assign_numa_node, &socket_id);
+					rte_kvargs_handle_socket_id, &socket_id);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing numa node parameter",
@@ -1053,8 +1045,8 @@ sw_probe(struct rte_vdev_device *vdev)
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist, REFIL_ONCE_ARG,
-					set_refill_once, &refill_once);
+			ret = rte_kvargs_process_opt(kvlist, REFIL_ONCE_ARG,
+					rte_kvargs_handle_bool, &refill_once);
 			if (ret != 0) {
 				SW_LOG_ERR(
 					"%s: Error parsing refill once per call switch",
@@ -1146,5 +1138,5 @@ RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SW_PMD, evdev_sw_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(event_sw, NUMA_NODE_ARG "=<int> "
 		SCHED_QUANTA_ARG "=<int>" CREDIT_QUANTA_ARG "=<int>"
 		MIN_BURST_SIZE_ARG "=<int>" DEQ_BURST_SIZE_ARG "=<int>"
-		REFIL_ONCE_ARG "=<int>");
+		REFIL_ONCE_ARG "=<0|1>");
 RTE_LOG_REGISTER_DEFAULT(eventdev_sw_log_level, NOTICE);
-- 
2.53.0

