Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE1DC44529
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFFAF40663;
	Mon, 20 Jul 2026 10:01:04 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 015CE40689
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:01:02 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso23911965e9.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534462; x=1785139262; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5MtKpoK9HYxHuqvWQlUL3p2Dy7g2v+0PIqpdfdKhO4=;
 b=ZAfAe9ipLud8vYs1OPY2k2XVpyE/khTrsC+kGeOLh3nKFHJHzlHzMxTK6WVNGE1StV
 M5acgDDcDVqC6TzH8jHnOEpFqXuTikPOGgl33zvFEp9KkPfLaIbqtpTYfvc94Q1Knqwd
 zDxA1hO+qjXhVW1p/Y8YKb8hYx2YpzrEQL9zZLtD23YgbVbq0BLIFBo7r26/+JniTPwn
 +xZ7rYfIb9+oSpsvvC1NiVRgxelHhaAhFAbB3qUEQopSXf/pnfKy8O2PFS9FwynDnXEV
 KjHt5hArumeRlPtXElS/3dEOdUXvsO9fWtPEJ3XFuIDlkp8Ov06jY1ECyfwrbMb44eZE
 7z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534462; x=1785139262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t5MtKpoK9HYxHuqvWQlUL3p2Dy7g2v+0PIqpdfdKhO4=;
 b=ifibuz2A1PdWl57OzcMjT39jMMEYpKHkEVUfbcuiQKyZmIargCmK0e38fCJPw0KgJa
 4p0biHF9pXf4FSB6wW6ox/dtZI83LY2ZLEnk/U8aQYAQa1cKO0cI1TOFxM8dsJ45h6yw
 VAz5iHyx5zYcy68cnhTamOSjeVTzAAtzyO9wgueuN1BhRXoIYjPRsBjWqplYJ3DPVS+5
 Mk1ADwiWWS7uUUr3hem0N8f3nssUw112BsTLccGgm+bSAMmkgPyK1NLpgoeo74G+7JoM
 KeveGJckfIroB0APJoMrLxPCMiJQ6UQeduLUFkDoI6D1rkNMXq/XwhigSNkO0Ndd2Eww
 hE1g==
X-Gm-Message-State: AOJu0YxY/qJ8jtJnQApXjo6W0aV4qluqjnLtV3b2YIYofUsqjyIXrnuU
 FF7ppylc6kUf9YyLbs4WUX0XGjPdGLhElcbrI4kmR8alo9u/CPjY0xrCKGHMzw==
X-Gm-Gg: AfdE7ckLeXIIUwNUIiwR8bORcIM23nsd+455ygoNu+mE44ebLXkvFJFqetfQftOFU24
 pqdcWMlNdv2JOn1f5C4tpbw9Q3doqdxTS1sIGY7ZgyP0GzVx/7Ekgk90Gmzp48JayV/1LqJ8m6X
 enWm4kYZXrLxU+wYKjFyYq5XUrV5aBGcf+0blyS9YKaWbRWLTINEoQixZ3q8eAnSyqvw70PoO9Q
 qxRTaRuyUhmWB0naR9W43CUYCpnvjA9G2O1TtrW238X5I/Ow/sCRb1dYghFxoJuJm+Xh2thTBl2
 04ODfzZzrxxDGgjna3FQjjTlF699MtJxXGlEvKQdNCel9PXsVBBJJkkSSrJdizPUEaGU13sp6o5
 GN5cZO4TK0zR4Q7/1d8wQjmY0PB0LWdALIZWn6gUoy68X+/C+izoIuKFF/hxJgoZ4I6pQ4fgGsF
 hf4sK4YJWPQ1wBst0qPG3nbmEf9nFHdbpnlO5K8YKwcvFV/KX2Wq8=
X-Received: by 2002:a05:600c:1906:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-4954affd764mr131409675e9.2.1784534460118; 
 Mon, 20 Jul 2026 01:01:00 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955370d78csm142740425e9.12.2026.07.20.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:00:59 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 3/6] examples/l3fwd-power: enable Rx interrupt before epoll add
Date: Mon, 20 Jul 2026 10:00:32 +0200
Message-ID: <20260720080035.673782-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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
once: keep the epoll entry installed for the lifetime of the loop. NICs
with a fixed per-queue fd are unaffected.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 70f76d202e..4874a55de1 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -945,7 +945,7 @@ static int event_register(struct lcore_conf *qconf)
 }
 
 static int
-rx_interrupt_wait(struct lcore_conf *qconf)
+rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
 {
 	int ret;
 
@@ -953,6 +953,16 @@ rx_interrupt_wait(struct lcore_conf *qconf)
 	if (ret != 0)
 		return ret;
 
+	/* some PMDs expose the interrupt fd only once the queue is armed */
+	if (!*intr_registered) {
+		ret = event_register(qconf);
+		if (ret != 0) {
+			rx_intr_disable_all(qconf);
+			return ret;
+		}
+		*intr_registered = 1;
+	}
+
 	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
 	rx_intr_disable_all(qconf);
 	return 0;
@@ -970,7 +980,8 @@ static int main_intr_loop(__rte_unused void *dummy)
 	struct lcore_rx_queue *rx_queue;
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
-	int intr_en = 0;
+	int intr_registered = 0;
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
 
@@ -1103,7 +1108,7 @@ static int main_intr_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					ret = rx_interrupt_wait(qconf);
+					ret = rx_interrupt_wait(qconf, &intr_registered);
 					if (ret == -EAGAIN)
 						goto start_rx;
 					if (ret != 0) {
@@ -1260,7 +1265,8 @@ main_legacy_loop(__rte_unused void *dummy)
 	enum freq_scale_hint_t lcore_scaleup_hint;
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
-	int intr_en = 0;
+	int intr_registered = 0;
+	int intr_en = 1;
 	int ret;
 
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) / US_PER_S * BURST_TX_DRAIN_US;
@@ -1286,12 +1292,6 @@ main_legacy_loop(__rte_unused void *dummy)
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
 
@@ -1424,7 +1424,7 @@ main_legacy_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					ret = rx_interrupt_wait(qconf);
+					ret = rx_interrupt_wait(qconf, &intr_registered);
 					if (ret == -EAGAIN)
 						goto start_rx;
 					if (ret != 0) {
-- 
2.43.0

