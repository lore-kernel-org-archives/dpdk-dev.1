Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAC7CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B503740647;
	Wed, 14 Oct 2026 00:35:23 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8F39F40B8D
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:20 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso1559585ad.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930920;
 x=1792535720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AK40a5L4NUmpBuvHVBWu5GLt0UdmNfuPeBEr4/k9MEA=;
 b=pCx4k6yPVS2/WEwF6/EdeO1Kzpob2vkKkytu3xSX/8j7pNrFdKNmITTMQuPSekHn+q
 c7yvFy74/axi0n84JJpAQc96jvtJDBPnjgHFT/eqARmP6uZAtussavQ+542OgkqHeibJ
 13KhcHbBzM6F8EJd8TdWjYZZztz2P5ru7Lxa/uEAJY3GvWifrDXdmx2TwM9BRmrSw02m
 QyM8KUekeUd9J8e20Eddda+rx1AYXRyKLFoPD6QuSvxEcJ++27mBuVM0fHOlidtl95Oe
 wmZyPk1l0MDlAvskE86/pZaFSYGIPUeDOV3elBdly/3aJdKlsTHPDmj+/7fRhiCMsNE3
 fF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930920; x=1792535720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AK40a5L4NUmpBuvHVBWu5GLt0UdmNfuPeBEr4/k9MEA=;
 b=Y+X28sx1OLd4Qy91pFDymiP3nI59nkinWwP2w94Pdtet/WX49q6Mk68S4Tnt/HxL10
 ApC6svUC4mTgXasd4Zu+RYaQlA8eHo+VGLYximNUZP9pmEIYlhu/Q42ZQTQ+8NaCX2Cp
 SA4zSdoF2AtXbZYDg3kQ3YCEW9IH+2YmYbPTjABIsOMFmmYIeArNfuLDB3PP0DKhBI8s
 QGcJgiaErJlBiQr+F7egiSLNiiNO8YbnRYLAHRg4J2rh+vNV5LvdCfHIVTRMVLFgTW3h
 8OazOWOHKYu99vHo4IhUodhQZrhF8c0L65cq0KvShyk8AW5ePB6xK0PUq5cgiQnd3SD+
 rwig==
X-Gm-Message-State: AFq9FYL+5gFEhsB2B0H2SZWVtdL3OVZf3I8kKeVhR4/WOQFdnDgn9bM2
 BlbesnDdzQqX/twyxUTDKJ8OzmzYM8MM28+NFrfcigDNSws4lTPu4EOTKLcp/RjD44ea8EnLeC+
 VAHl2lIg=
X-Gm-Gg: AYBFou3dOzyqn4X4iNz7LkckleQXn+wmhLgEbaWvgFcrpjSAIZmXpoT8YWkTuo297bD
 ruCnEBOWx7ZWJdhxqyA91Y6LfBAn9mnrQPl3Zt6T215KMZF83j7xXEvhsWgmAxYfXufOs08MKB7
 DcSDT/kgIkKoUG8oRjtswlSyAEy39g38Zd8MAoR27I73mNDpsedmJ6xBlXRavuJw41CUTa8MS7f
 mU3Z5H5HF/YbloF0608Qeuy05PqVb7zUzW/fXrgWcBxEkEZfN0eiVvy/KXCqJXD+syfpExNKZkJ
 8c8wplyxCX7yOC7g4ppLeN/5JWdrrSvXv3RR1fq3M3DjwSil37sTHmaFdePw2ylQWU2fRVc6FF+
 SaBbuLuc8IDRwWh1FjZaV07KMiS6D9GcEpxzmzLfLtfo9ntrt80JMH3Le2Etqd9F+LSZSzj0sbo
 0kQAe6vd/eJvgukvl2SPTO1hLxICFSvNFpWc5aswTUdYjORStvDJ4z7AxbiZRIzc4kgnMM8xm44
 Y5CZVc3SZlfeGfUgD8OhSGZipKXmcaW0BP1zw==
X-Received: by 2002:a17:903:38c8:b0:2d8:d4cd:dc8f with SMTP id
 d9443c01a7336-2e842ab8115mr116758295ad.18.1791930919762; 
 Tue, 13 Oct 2026 15:35:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 23/29] event/octeontx: replace deprecated SMP barriers
Date: Tue, 13 Oct 2026 15:22:36 -0700
Message-ID: <20261013222410.2257622-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

