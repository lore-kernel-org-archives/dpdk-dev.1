Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D805CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1055942F17;
	Tue, 29 Sep 2026 18:39:59 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 5EE3F42EBB
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:47 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098dbba5fso938805b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699926;
 x=1791304726; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=BsHGgY56v/ZkdjuzpPFOg9Mh91i/QrjjfdMijRSbYK+snbKl9whTWzeHJEj6eyz9oc
 ZxPjym5OTRfEu0LzHsFPc5astnPIr94xuje8P0FYHRfiFtXjVWdgFAX+nHI77RvpXcXP
 KyaLQWSdwqGoyC7KjXulLh1HzlaK1I8mAEj3Hg3vkz1xAHZcIvP1CHQsMjvIcLGzP3MP
 VbtZ6f2q3fdriPNUE8QCsN8kRTDATG6CLVtzyd+k2Y8NPSY2IhsGIFzqcGch3gEDtsRT
 vji6iUJSoKxygWc565FJUFSPNBmzfFiqsClAvh363JWq7V6iXCdQTikprfmPRI8PcYGY
 WUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699926; x=1791304726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OttYL0eGBE7W1xRZGhSU3OmXBVsH4U97tW1E93FYGVo=;
 b=M+rGYE5vR8ybC8C0Du7mi8hWxorQHwHDdDlNoxvuFvICrqceF7DMJzEFDAhBCu5q0Y
 3eo6AUFOCEArU3gbNgMsgDhSq+F4428V4EF3M1sC6nKX6/yUjt+KZfCmb31ZH76XgbpW
 8wWHHpLgb2lwhx6Tiz57hHHwWdBGAKgwHhhLaKeWLqiTQ/H2BGPRlCg7C5XSOKe7yED2
 9WmlVoBjBI2vQ9zSpeUScxsdPs+2mAqBFw/0ZKKp3IZx9U0qqhJAI2xTW6XPMictdiwM
 c0ziu9KD5rl1YtWulZFMsbUycUv3VTH/DVN6mhlYtgH/CXcrLlYJRQ4MuoF4KZuPZDsq
 pthQ==
X-Gm-Message-State: AFuF++ntku9X0aVpvmWYWYqWl4l2la5tggyKNQ8ERpQTxCLJxsyznwR0
 vDeW+84fPHPXRVN26It3sm0Fq59yNdMDyYmGjxRHrrchYHCXuEp65RCBFtid2ajPG/L+bvDNZ1E
 PrIoSvQI=
X-Gm-Gg: AYBFou3vPPbCRuPtj2UILrh/G8NES+s9Jykl84Iy3POQUjq/uN0rG27/q0KtbKpv9/g
 rG9dompmksX+rhD8dqTSpp4xDJ4kgk6B942FNxWCX85N5WL1qsoYReKcxVkj0lZp1NYSHIzFxte
 ZmbWTTiIR/Lcvgv7bTtI50QTkbiiKAZG8l4HhyFp0Utt5RwfP9nKgnsffIdxfVOHtVqM+C53fAw
 pLXQ6ssI9SxOuzxVsKTdMD/g6fuDpOUf54/4KXeylbnEwqihGdwMmKE+QSma5mDUERE4Xz/l3fR
 CJexVxvD84wsnUaAcPU2UU2xGbPGGYAQDwM1qVElm8KzgGP7q0wLL1ph3JbJkUrzft4CbrY8xMc
 k+mk1tlOoEdSjDALDHCMBvzlOU5YUu7rDW17A9E+VJyWOwAYlFp6WaE3mWBGI52gA/VxGgh7Ik7
 yv2Bg5/QJOwyuluQG+FOOBYizRAcgDLHWZY9uDi+Eb9SYFv29nKAQnIwNU8SnyWig159sTorc49
 3Vd2ayV2aI3Iry6NveftUosH/T34nuGL1Yojr/4WrKtbLH8
X-Received: by 2002:a05:6a00:1bca:b0:882:2195:5a73 with SMTP id
 d2e1a72fcca58-88560e4f49bmr2023032b3a.29.1790699926522; 
 Tue, 29 Sep 2026 09:38:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 43/61] event/sw: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:46 -0700
Message-ID: <20260929163800.1108305-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

