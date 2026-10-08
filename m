Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A70CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E381740B95;
	Fri,  9 Oct 2026 01:37:43 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id BCAF440B9F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:41 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-88aea027391so3115440b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502661;
 x=1792107461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AK40a5L4NUmpBuvHVBWu5GLt0UdmNfuPeBEr4/k9MEA=;
 b=Qx7LrjJ343zXEuSBHpCk6pero3k5nvNvXpCfRlJsIcikyzImfRGnXYsG/tJxDnoAZT
 h+pjE0wFZ7HvGslQJm7ilRqSDZAevdDMm6S018Swo36TVyBL+ZIrpt1RsxydBdj2EFUp
 J6CFtW1FVdCuKvKdnc4tm5gf8UFc6GSC3nSQ9MCFnMZD9iYd0R+8hOMIuSfUj2chv+Wr
 YJkZhYVHNELD7M2McDzvpyisi7TuxTXSKX1nFqTkUK9lD7Db8DJJp+fCCTU+/T1Abv1n
 EBT1g3/Y9FgVIhpVGpgqXgKbMYcKgIex0EpCOI4N2+nK3KDO2F2zSU/fDq+7h+TNshG0
 dgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502661; x=1792107461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AK40a5L4NUmpBuvHVBWu5GLt0UdmNfuPeBEr4/k9MEA=;
 b=RkFtiUuZKFwvPUwewvkZEhD7bucVTy9euulwwVZfyGC0j6zGWbqZH4vTAcP/bteLwg
 jV1gQo0kT1C8Oa9dwTQQXlsrThe2RGL0f8KTdovn8IIX0J1x35Chu2VACfSh79bNbCkW
 ph4qJcaqWPbOzktBbW6cNAP7+VgluB6pjo83Cf0cLzNyGcUD/ZEsNTg6VC1N0BhVMZFI
 Eo0TP688EUjIpJX5uMRgsYcgeksC3ghVq/aEH9CLigkJAiMJ2EivvNRF9f6+FvMHzFWr
 V3IRJxlVVf6oHy+v5tTmyGQiOAPzPsqzDQV8retfarhEKMYnVYPmG24T93GiLEvbGLH2
 OBZQ==
X-Gm-Message-State: AFq9FYKtHEigW5qDr+qpXOxZS8zIVcUD+MGxBLU8O06eZFIoDjZBqC6y
 WRKsesoHG959UaTH7PY83vIP1YM/mV1WHLyCizAHLXjLeilSxSyDpYOkcV2hpZOnpjsJxXmCGz3
 u4ctRxMI=
X-Gm-Gg: AYBFou39zT7DC0goN+cKpCC5s19XbYqJbRpc/2UpSFmk+bymi054UWzsMi59IlhPM+j
 8+B879WNnGryytAN3KuSndWIVnJzXstFNo2JyEYpPKE3HGBqS3NO2jAvCFlrEVnXG57K1MtAwOZ
 EhCWc6a226V6kcqM/kz4Nb+Qb+8DoMlgvhOSZW8dC4h6t+MhEnsmOnHevVtavrUdv8/wWENNqQL
 XmKGTgcecQUK6GZfKqGjMBo7gXk8tMybcmvrX2BCceiqD1s4umpykWrxr5pN40oROehcnPc+Q1V
 xMVYkQ7mNwigi/ybtbytflTwnsGzvbKPTe7oRkBBKE6dGrUl1vl6rLWzY4Cacd4dkYa6H7UWrE2
 U/Vtwt+tVPsPADalBLEfbUBMkXYly3gM1jKEHScyjIyet2rGInUxp24Pd6oGP9kml7WOkuh2JQk
 agur/4ZPwh80bp8y3G+hA30fLR+iUEFunpavY+WMZ8GQl1gRe1Jxch/k1hoqbQ0rTP6Ro1srjVv
 t4WTOZiCCUBs7GoyXMoTQQ94QYJFK8qjK9caw==
X-Received: by 2002:a05:6a00:44c9:b0:890:44a2:51c0 with SMTP id
 d2e1a72fcca58-897c8996661mr45560b3a.57.1791502660962; 
 Thu, 08 Oct 2026 16:37:40 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 23/29] event/octeontx: replace deprecated SMP barriers
Date: Thu,  8 Oct 2026 16:35:16 -0700
Message-ID: <20261008233649.1260843-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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
index e51b89a31e..df8e710b57 100644
--- a/drivers/event/octeontx/ssovf_evdev_selftest.c
+++ b/drivers/event/octeontx/ssovf_evdev_selftest.c
@@ -65,7 +65,7 @@ seqn_list_update(int val)
 		return -1;
 
 	seqn_list[seqn_list_index++] = val;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 	return 0;
 }
 
@@ -636,7 +636,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
 	param[0].sched_type = sched_type;
 	param[0].port = 0;
 	param[0].dequeue_tmo_ticks = dequeue_tmo_ticks;
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	w_lcore = rte_get_next_lcore(
 			/* start core */ -1,
@@ -649,7 +649,7 @@ launch_workers_and_wait(int (*main_worker)(void *),
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

