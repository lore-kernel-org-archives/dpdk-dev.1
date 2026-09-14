Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36937C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59ED940EE2;
	Mon, 14 Sep 2026 07:51:55 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 948AA410D5
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:52 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb5so1320998a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365112;
 x=1789969912; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=HrUh/pf5jV0BQm5XBjGHytksiy4oIwRV8/plrzy24mEG4wSw+8IfGq+ckiXtpXusoF
 Q7/uJ2Tm3EQMl/O2RF2/plqakR3yJx1YChwiHizoCUuW331IL0QpeaugxGqJ5zpaWq2G
 m4RqZsgFJhVU0q+qP6FzhL+x7OYfB3TscNZBN4ILFhdCYeAS2QtqZoVS9fi3h4kE14tY
 6/3rXQaq+z4/r8uyPeo8TQ4FupsSi6RE2NU33AKdXC76jWKcytM62bFavE3u71+qPVs/
 AxI1s1YqRDgBNmoM8xWOf0pMgBxvItPqFw98ewSzX1EpXbEf1VXyNkQzLXpLg4LSSi6K
 q+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365112; x=1789969912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=XEI9fuRQp543a8Pk3j9NdVEqVhMuBuNhgUrBIQmht1A+oN+E+2d0PQtcuYO4X+jmhT
 wgsUBe1WmKe2qzrxTQb7/6G+h9lyBdISeKhm2EqWOT49GaZtKxTptOHS3JDRpFZeM08F
 CjG2Qb/DVVI3B/LWlCRkVyu1OSxWdFOEPO3qEv1BVkb7xBgYyOVS3P6WsQ2V6Mo8Ft4H
 UxksI8f5vbByy5wy2VVZtBFxRmBSZbk9t63n5jTpdtC07L3vKI8+Kzkdv2/EYf4Toq+m
 gE3UxuQwSlL5twYttYyQeWL9xk+KfcVqLcFqjw2yOzqyhCQKCMvLd2cjAIjbdjZzDMRp
 hIrw==
X-Gm-Message-State: AFuF++mIjNbAWU9/jyCmKeuisraPbU21l9fGS3VFCsYg4pkQzexzwx6E
 v+8xKzPcvt/fRSxpviBTbe8v+AGI/z2VKEFTa4U0gYeS6+yX2SZz1Njh0jhUvfvN6wwJwbalA/6
 N2WBSvQc=
X-Gm-Gg: AYBFou0fcKA8uspNbPX+y/WLhid9Dd8/bdr74gH4gNdpKohbeiAZvtY1NkLvTsYDu57
 bFKgfrUoippSb9VNr1Ae+5GcE7wWla+mxxITjiKQWJLWB6DUxk4PA6NHSABnwbLa/oGEFXV2y1f
 K+ZsY1DSMc+H+iygROeOWPv31b11Jdcb+o93+/Kq8PzCUSdnH7HvYGrQps7BMKzCGKDy2CyIyN+
 R440yiGXvmwui71tf7gq5Diqodj5e5nqWHpnr4Gv+LA6FmBeaM9Otx9MjonPfTJC3R/zEd/J1hC
 /GiesLZsGXaq1pZuLuNVK/2U8boy6iP76tRFwO3RiSRYQDkMOohL/Nghq7g/sZGfGR4ynFYYYRs
 TlruwzbzpwtfObsBWAF5NjXFft+t/UosXtgxxz6SGrOrevNyFobywtfwP2fGEZolsiJJ9sVTfJB
 il8yp64Jel38ctwWcZM6dV/tk1NrJG9Y4mQEH0VBYrhqFCzFww6cM8t1DByRASxXBTVqpSuByBS
 jetUOrbwibrgEpbGOLq+6HwnbW+9RrDIYdRQxiQV7/3Gxyc
X-Received: by 2002:a17:90b:5102:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-39dec0bf7b0mr2629777a91.18.1789365111734; 
 Sun, 13 Sep 2026 22:51:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 44/62] event/sw: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:15 -0700
Message-ID: <20260914054912.755403-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

