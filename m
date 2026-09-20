Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862BC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E95DF410D4;
	Sun, 20 Sep 2026 20:14:26 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 97B8A40E96
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:18 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so976149a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928058;
 x=1790532858; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5l9Fd9jBBt5xfz703d0fmcp15z52HJq6eJ38pIeJSGs=;
 b=mSi35LRn2bLtKEhnGSpdfWsEyBTNfQ0176jdrrJOrPcIJlm94TrpcAGyGVT8PZkWln
 Quf0J2a63KjX1+PTZKH2Qvl0wlp79m78uXv6isrV5DTPOGiQdll/K2cK74AgwdlA4xFu
 +N1kLJy8R2BthB/qscn8HbGyhg7tIFwhLf+mYDDe9AgZeqrr3yp1DT5wqGWXCrldCZf3
 cqkrKPH9RS7cOsQEu+9o63TJkjlNZQO3pkZTolRpCJWhXSuA4JpfFzwUXl3bP81THwOt
 xYGveHQPXXlYZ3rKcEG5dttidzsgTZlJPjhX0kBHBn2pm7nNCzbw+PTVdalMtE+rHGnu
 mxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928058; x=1790532858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5l9Fd9jBBt5xfz703d0fmcp15z52HJq6eJ38pIeJSGs=;
 b=ofBjzO7P1FiFsmoqXrmefxrqC98N9zqaT9Ed7HfMiSAbwdWahkL+p/HMld94cqe/3c
 uyLEEvq71vnPo1OXWFDZyDxq41rgv3zayohXLj68RfmLD/edSxVGa/bcJ7LkvxtuBpMo
 9dk7zwM9m3eBnPOg7r/Igj0IG/UeHv0llOh2T5PJ5BOJJsHd6A5r7AfXor+aj9f3c3T+
 3XM6U5yH7rc1RWPguG7kBafq3vdwQMHYdh+7HJk6UANd/BN3lGpZOdAEeYIlLe2vha/w
 ZSfbnSykMTcNQbI4jB4gCps2U7SWWYZ83TAWdRME72nEanRGnB/fIgpUhGWhEpraOUD/
 MAwA==
X-Gm-Message-State: AFuF++lzC1wD+uyM0+Qbmm/MHhBXRZ7iWim+be7jh/CS0gpVQFUyHZAr
 ZU0SWr1oDbwsP2Ay8vy+NOSWGWrACwS+cu3wW/1JbXK9V0Ub/3u8juVLVHnu2c9DuNQHhu0Eu/0
 FHvIn
X-Gm-Gg: AYBFou2q3sPUXfgrzLTvrpPbU6aLjRVsOM62uBwpLcZDeBFULOmPSZZ52WbqMcQXEPu
 x3wPhlCYCVFTollJwv+x2hwM9Au1IGDgxvId0CH7lH/rGxvgHV23urMNmGZymEb9k9cr+FrBdpb
 dpJh1k4nEnzFbWlwCByZGPM8yw5uP3ukz8/p8wrEtS7dfuHUesxmRAysbVA4uLv5WPjR0ohy9gu
 VirlPmBB2sOtv6pR2KVzCTiiJymneO/FzfhwwFJjWRA5PKgDPCqCocGZzUnY9Z3espBiSalGv8G
 mF6ez+hpZMn8d1noI0WDTgjmoulcQ1YqLPKPy306ieLLDyIa4WfV7/4V/QXoWmYuQnOn2CUoNhE
 2qEMF6G1OJCMsDqIsYcBF0bjnSFwxlFgHij8GyBUC44CuN36zYmMWMGWRWLr4eX2kAn/Vo+QEku
 ENH7RQnchOLlmfgSS+QQq+HniWMK9yd4Ishetue4sQocbM0XMZlCtascQccsj7l0YwmEfjx1Rzt
 NdYfEwFL8x94HMT8f/h5hO5JnZnB1GI+BIIow==
X-Received: by 2002:a17:90b:2246:b0:39e:6a7f:618b with SMTP id
 98e67ed59e1d1-39e6e4f5d73mr4955393a91.28.1789928057684; 
 Sun, 20 Sep 2026 11:14:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 23/33] event/octeontx: replace deprecated SMP barriers
Date: Sun, 20 Sep 2026 11:10:15 -0700
Message-ID: <20260920181347.747210-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The worker barriers order event payload writes in normal memory
before the add work or tag switch store to the SSO device, so they
are IO ordering: use rte_io_wmb(). The selftest barriers publish
worker parameters before launching lcores; convert them to release
fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/octeontx/ssovf_evdev_selftest.c | 6 +++---
 drivers/event/octeontx/ssovf_worker.c         | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/event/octeontx/ssovf_evdev_selftest.c b/drivers/event/octeontx/ssovf_evdev_selftest.c
index b54ae126d2..614f9bbaef 100644
--- a/drivers/event/octeontx/ssovf_evdev_selftest.c
+++ b/drivers/event/octeontx/ssovf_evdev_selftest.c
@@ -65,7 +65,7 @@ seqn_list_update(int val)
 		return -1;
 
 	seqn_list[seqn_list_index++] = val;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 	return 0;
 }
 
@@ -637,7 +637,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	param[0].sched_type = sched_type;
 	param[0].port = 0;
 	param[0].dequeue_tmo_ticks = dequeue_tmo_ticks;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	w_lcore = rte_get_next_lcore(
 			/* start core */ -1,
@@ -650,7 +650,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 		param[port].sched_type = sched_type;
 		param[port].port = port;
 		param[port].dequeue_tmo_ticks = dequeue_tmo_ticks;
-		rte_smp_wmb();
+		rte_atomic_thread_fence(rte_memory_order_release);
 		w_lcore = rte_get_next_lcore(w_lcore, 1, 0);
 		rte_eal_remote_launch(worker, &param[port], w_lcore);
 	}
diff --git a/drivers/event/octeontx/ssovf_worker.c b/drivers/event/octeontx/ssovf_worker.c
index 89b5dc056c..f3c6a0da5c 100644
--- a/drivers/event/octeontx/ssovf_worker.c
+++ b/drivers/event/octeontx/ssovf_worker.c
@@ -59,10 +59,10 @@ ssows_fwd_group(struct ssows *ws, const struct rte_event *ev, const uint8_t grp)
 		newtag |= grp << 20;
 		newtag |= tag;
 		ssows_swtag_norm(ws, newtag, SSO_SYNC_ATOMIC);
-		rte_smp_wmb();
+		rte_io_wmb();
 		ssows_swtag_wait(ws);
 	} else {
-		rte_smp_wmb();
+		rte_io_wmb();
 	}
 	ssows_add_work(ws, event_ptr, tag, new_tt, grp);
 }
@@ -158,7 +158,7 @@ ssows_enq_burst(void *port, const struct rte_event ev[], uint16_t nb_events)
 
 	switch (ev->op) {
 	case RTE_EVENT_OP_NEW:
-		rte_smp_wmb();
+		rte_io_wmb();
 		ssows_new_event(ws, ev);
 		break;
 	case RTE_EVENT_OP_FORWARD:
@@ -179,7 +179,7 @@ ssows_enq_new_burst(void *port, const struct rte_event ev[], uint16_t nb_events)
 	uint16_t i;
 	struct ssows *ws = port;
 
-	rte_smp_wmb();
+	rte_io_wmb();
 	for (i = 0; i < nb_events; i++)
 		ssows_new_event(ws,  &ev[i]);
 
-- 
2.53.0

