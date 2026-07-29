Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B65C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142D740E15;
	Wed, 29 Jul 2026 19:57:50 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5A21E40A7F
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:42 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so713007a12.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347861;
 x=1785952661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5l9Fd9jBBt5xfz703d0fmcp15z52HJq6eJ38pIeJSGs=;
 b=uzduu9lM/msYXkP5Nd+Ds17CBW9Ur6gujiv9IySEbmU3ZEJryHXy64zH+vq+AW1hXH
 S5slYYwpEfIvmcaZeyMGe59aweAxRDoUGdt80SxBBR3kTjaBgoiDuOlRvjler9vysGXt
 Z+C4kwf0Bip0Dnznoyg+sQuuHAGLo81dlKM2rX82Wdjf8ypNMMq2zrU2tP0xLAALUoSn
 ryQXvc3Ewv47HPC1HRkbQ3PdrBHjcXlGXmNT+0OdWB/RzMXWlll8phQom6+jd99HItdb
 TozslBpo2FiuE0d3Z7YIGRNB1VelO88toceFLg34HR4jvSzbXvSgvUAkAyGaLGhEvEYF
 X0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347861; x=1785952661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5l9Fd9jBBt5xfz703d0fmcp15z52HJq6eJ38pIeJSGs=;
 b=rCjgHUYUjDvofHCUhIXml+4ks33A2oViwMEXPfFn/HBNsoSLkSXwzbyE4HfUfGufEP
 nw1kqbsayA/Lgr4D5P/ftN8Hy70bhzKv5PCsPXR1krBl6TH4y3Q0MoTK3ROXxeQQEmLy
 p7laSZySSMjiZlzJPIZAjxgE2PB4kCo11UEErAkYhDl5/StWW7ijI1JFvP8EgGe2y7wz
 O3rjjLszGAuKRxFmvpt4m8viadbjBJA397HppS8YnqKo2ETfpX845JguM1a2nJsHYVG0
 bb7CehsSBvjcNj5CFHaj1yVR7fZmqJtZcQtofWIKS28n+usRtdRUViLj5msruXasjNPu
 +VBw==
X-Gm-Message-State: AOJu0Yy8Ea3lkmPbQS/0q3HtaBIMQYch0hb/E/VPVZwp8xXJnXL6jtRy
 CUPPDqLuxKvToFCUe3CLD1KRZmDPkU57lbfQluq1fW4S0BAsBoZdhPQav0qv8siZHQ94SZ6pFbs
 oaX2U
X-Gm-Gg: AR+sD11QwmTO/LoVyChzF6gJ+0rbmKB3k7UpP+usJD5QuiDP9hItJ62cY+S/+mMIz/H
 v0LtcuAZJUNg1kqCwc6xBTFLYNFX1ihfG9zk31IZnj+PKjPZxNYAo21/KhnS/QPerVRQftdSTw8
 PzaYzbRFDv5oWKtCN1kUwnEAWTfonESzSBts00evIMf08TCprKYK6nnpNbLG6wuY5fadCUiX3vr
 x+JY45Y8xBwupTwgJrNcFFd7zbLbUfKpYNrRA/kVcUBcaZCac7w0ipTQloKMhdMaFj9QDcS4wnJ
 Fhq4RULeRnpo/R8xuquhmvyV5jLMgpXugSVpVXOpeSjSrs57QWXqNfe0DFdZcJO383kkE94Gpts
 +smkdFRmkIgUX4U6itX8ZvHT9xn8nkPkAiClD+nW02U2Ghpr66AwfvyQCHjOlPpvhD/FPzd2W5A
 /X0COV5beUc2L/Vc4LwtNHOe6n3A6RTJiFs+eRy0LibJCxOvVeUK9qI0fuPD78p+/PYwcztnKib
 fw/LDPm89kRwl1m3HbjeH3np3Q=
X-Received: by 2002:a05:6a21:7009:b0:3bf:6c07:b2f7 with SMTP id
 adf61e73a8af0-3c8ba61b20dmr9207960637.58.1785347861463; 
 Wed, 29 Jul 2026 10:57:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [RFC 22/32] event/octeontx: replace deprecated SMP barriers
Date: Wed, 29 Jul 2026 10:54:15 -0700
Message-ID: <20260729175715.165120-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

