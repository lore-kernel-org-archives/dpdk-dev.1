Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B9CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B4240B94;
	Tue, 16 Jun 2026 12:27:44 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 31EBF40A8A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:43 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2514989f8f.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605663; x=1782210463; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoNDbb6wnRU/vwLjGNlb90THBQ9jCw1JR6vl6lSAzo8=;
 b=QQoOS3Ez47MhqQmJv29QqPGLgjEGSia9U/gSE69OMRiHSxdiavIH1UhFswTIzsHjSk
 UsVOfVOPglKnu1lQJ2pquY53A7nxfav8lND7/Z5bYvzLDShHcbFPhjuUnwt5erh2kX6f
 Es9AQsU1ZdA27YVlZ4QkUkCcI7PfGOEznQMJ7FFbga6U8NfHWQh0ZiEJMg+uC2T4fVnD
 ksUvp2LGt8ZUqA4oHG3AaYzS2uhheHogVDgVQ4PQ7jjolYv9VD1j4OEFFwehrg/92q0/
 kvz/PVztq0+MB3wdQypIJy8wCxtoTxUVSCIRzKWKYDgTMA+b/LxtbJzsQTBCsRen5+b6
 BgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605663; x=1782210463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoNDbb6wnRU/vwLjGNlb90THBQ9jCw1JR6vl6lSAzo8=;
 b=I7FsboioA1znUe6BNWbel7MZ3VHzlD2Bdx7gMvTKAK3BEL/i4Q5okdhNJUgsnlMm0f
 v+/i6/W3YKWVBIhrMuNjTOSc8DPtBiBlyiOqt2jswgbnOrszxygI90HKefCXnnaFE72L
 nFHRzXLo9No4WTK3XvYMnnnQMjfmLZONZ2p8vzHRbFSRLMZUdOjFG+8JliMDcwPjJiiH
 c5QTDByXIxFbkOGjvCtaKytZ0SWfZ4hmQ6mc6WevTThb+OKHUxcSv5npkhPNUW9iOsZj
 Lte176+1T0HITsvcSpShK5O3p3cN3gGIuq1S8nQ0NKhxYHF+Bm9h2L0J+9J7hCQMiF85
 o5eg==
X-Gm-Message-State: AOJu0Yw4MgE1KWvG66s9y+9HHHX1U4xQ1gxO7TAQwHKvUM7pqmWNFWrL
 SUUvo7/qoRG2BLtFj/0mGaWqdHslc4XjmcAr7hfTC+r2MkomAPzpWwcRFOSSAtWA
X-Gm-Gg: Acq92OEVGWL/lWVc48t5irvkcR+94wSEgVImPVu63o0y0Tc+w2H2zTx0/0vvFhdvpFf
 sHDPxzQO2OuClCcIkDgeaUZ8VJfF3pIMOdIyBKjB3csAmpO0h9TuOj2h4UE9XdZdoRR2VZ5QdEm
 mglw0BZyft/y9fpOlLEH5g9wAgQFAbVRA0r/Juc3hGZ3sSeEmhoDoWkAx5QxfZ2R1tLOljjJEbc
 6XJHTQDi2SnZCWEAjSd3HDYRfdN1XC5HeCNiQfwKEyfA8SLYd1L8/n6Uba3MSDdj9ewXtlp2EmP
 387LRoZVxS/GQcF0fNsWuQaMEGkhKcmxWoHKTeCfm1+mKIXzhPLY17pOU6tZrIcLOPW3llzj2QG
 VntXb7szdxqwnPCgFwPHPmrnCSEMojgJ72R6i7vmLW/wMtDT8+GwETw6Ayr1o3v/ejJ9abO04r3
 +aS4E/yaUq1Z4tCLAejMfSYzMAaRQEwlN9FHs9clRsQnF+0nu3h+zk
X-Received: by 2002:a05:6000:18a4:b0:45e:f68d:e791 with SMTP id
 ffacd0b85a97d-46074a38ce1mr20300816f8f.0.1781605662461; 
 Tue, 16 Jun 2026 03:27:42 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm43471947f8f.21.2026.06.16.03.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:42 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 2/6] bus/fslmc/dpio: make the portal DQRI epoll optional
Date: Tue, 16 Jun 2026 12:27:22 +0200
Message-ID: <20260616102727.708948-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
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

dpaa2_dpio_intr_init() builds a private epoll instance the event PMD
sleeps on. The upcoming net rx-queue-interrupt path waits on the
application's own epoll instead, so that instance would be built but
never used.

Add a build_epoll parameter: pass true to build it (event PMD), false
to skip the epoll_create/epoll_ctl. epoll_fd is set to -1 when none is
built and closed in intr_deinit only when valid. The sole caller passes
true: no functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 44 +++++++++++++++++-------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2a9e519668..3a5abb2e6d 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -205,13 +205,12 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 	fclose(file);
 }
 
-static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev)
+static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
 {
 	struct epoll_event epoll_ev;
 	int eventfd, dpio_epoll_fd, ret;
 	int threshold = 0x3, timeout = 0xFF;
 
-	dpio_epoll_fd = epoll_create(1);
 	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, 0);
 	if (ret) {
 		DPAA2_BUS_ERR("Interrupt registration failed");
@@ -231,16 +230,34 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev)
 	qbman_swp_dqrr_thrshld_write(dpio_dev->sw_portal, threshold);
 	qbman_swp_intr_timeout_write(dpio_dev->sw_portal, timeout);
 
-	eventfd = rte_intr_fd_get(dpio_dev->intr_handle);
-	epoll_ev.events = EPOLLIN | EPOLLPRI | EPOLLET;
-	epoll_ev.data.fd = eventfd;
+	dpio_dev->epoll_fd = -1;
 
-	ret = epoll_ctl(dpio_epoll_fd, EPOLL_CTL_ADD, eventfd, &epoll_ev);
-	if (ret < 0) {
-		DPAA2_BUS_ERR("epoll_ctl failed");
-		return -1;
+	/* The event PMD dequeues by sleeping on a private epoll instance owned
+	 * by the portal, so build it here. A caller that waits on another
+	 * epoll (the net rx-queue-interrupt path uses the application's) skips
+	 * this.
+	 */
+	if (build_epoll) {
+		dpio_epoll_fd = epoll_create(1);
+		if (dpio_epoll_fd < 0) {
+			DPAA2_BUS_ERR("epoll_create failed");
+			rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
+			return -1;
+		}
+
+		eventfd = rte_intr_fd_get(dpio_dev->intr_handle);
+		epoll_ev.events = EPOLLIN | EPOLLPRI | EPOLLET;
+		epoll_ev.data.fd = eventfd;
+
+		ret = epoll_ctl(dpio_epoll_fd, EPOLL_CTL_ADD, eventfd, &epoll_ev);
+		if (ret < 0) {
+			DPAA2_BUS_ERR("epoll_ctl failed");
+			rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
+			close(dpio_epoll_fd);
+			return -1;
+		}
+		dpio_dev->epoll_fd = dpio_epoll_fd;
 	}
-	dpio_dev->epoll_fd = dpio_epoll_fd;
 
 	return 0;
 }
@@ -253,7 +270,10 @@ static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 	if (ret)
 		DPAA2_BUS_ERR("DPIO interrupt disable failed");
 
-	close(dpio_dev->epoll_fd);
+	if (dpio_dev->epoll_fd >= 0) {
+		close(dpio_dev->epoll_fd);
+		dpio_dev->epoll_fd = -1;
+	}
 }
 #endif
 
@@ -277,7 +297,7 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	}
 
 #ifdef RTE_EVENT_DPAA2
-	if (dpaa2_dpio_intr_init(dpio_dev)) {
+	if (dpaa2_dpio_intr_init(dpio_dev, true)) {
 		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
 		return -1;
 	}
-- 
2.43.0

