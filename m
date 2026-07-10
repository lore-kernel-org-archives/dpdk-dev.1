Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA92C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C40E440B9E;
	Fri, 10 Jul 2026 23:09:33 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 3DB1240BA4
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:33 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso7198465e9.2
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717773; x=1784322573; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Agm0alnYNhEQfK5u0yDD0mnoYk2hMXyPzyS6ijtKf3E=;
 b=i+E6lMx8DpFZo2vjs+tMZlVdhTw9n/D94qj/FooaLBjU7prJMicq/dwrsJf2hkNL+p
 utiiBOlBiG0EfRdsJZ5v634L1aUtvnQTSTsHGwuK048dPwrWl5aoeNTKTENW8KcTXUiA
 FfZfWYJr/LfopIPF7Jk0ymmb+WZ1o+4q/m5vD5J4BkD0ks5HJ1sZkg1B2x/WLJkTIMFR
 9ge7xdlrQSKfrEsszybyO4Wd7YD9x/SVDpwNcnWxhhf2IfKVjB2Sn0nwTD/fqEwF3eJw
 RFzOCRR5aXOS9bSBpmyut98svJZp7s+/WTn/VoSkHz2/wG5Gb2lcyAMxyOjlpFDY9fKH
 LNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717773; x=1784322573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Agm0alnYNhEQfK5u0yDD0mnoYk2hMXyPzyS6ijtKf3E=;
 b=WfHyWGyfTtD40kzo7+ysWxxdO71nLEPFjKhxC0I2prEAC574VXXcFBPYAABiQATvgJ
 dwcVtxU172xZPOZ+xW1G4tFdLFJSZ16nri4YlunXQQ45fWSqr66tSe1TAUYBLt+1kvYU
 isZ+GhKH3R0AKZv9srkVRnYMM8UFGs4qPVc5jHQn87+v3k1mFBY4+6Hc5ffAlCbjRtWy
 w/SbJQHGQ9YfEc8c82HVN50AisSQQkr5Ymkb7Ay/mXBEW1sb+wkliZiELi3caEUMNVoo
 KOeuEdnGT0CFsdTxr8PKw+ox4OLQ9EcR/KyD972sMUerN9ejJhP/Uflcq6kZb19C2ILI
 sWcg==
X-Gm-Message-State: AOJu0Yyjjyj6s/iM1lurjnKlgpsXZN1urT0G5aIm0Rpzllq4Ew+8BHFY
 RGYRFfvx269u9GGWETtIj1zCZafCcinhXAtN2dw7kyZ0R4UEFv7/PM80L2ckP3S/
X-Gm-Gg: AfdE7cl0x40vWg1utO7L+MkPbMWKMpuDvVPuJozTqXA0vUXcQlPmHaLo97b7HV8Ur77
 oNrY2oEuAtax85ItrekNfBhoBFk+L522Xra5cP7z95+1y5zNvFCwCchq72OCmBamFhKsDLbdE+K
 5RZINiH1ao83hugERHZGaoMrWSdqNeVSjomf1ZabJOGEqGnbqMGi8mRNAQ53kroBLlR2BXGOZa5
 oQeHJtj9fAfKvyk7lfW9++7QMGnbRfbXUQZfd8L/Tp8fKAqCsFOet0sUcMeTombfBpi/W3LZywL
 gStC1R2ImOjjf9K9yaEXVu7npoPZwioqqxkOKgiLUb/Jtr0GA6hDnYfZS9gtZiX6OAmEkqfUmur
 GsJkkycqKvxODNgoukbAwsTdYZfe+WcLvYNHXk6iTvw2y5ek0PWQbG+83eZsFWyTBIFLRvsJC6G
 KY1r05+p5z4PX2JLGE
X-Received: by 2002:a05:600c:858e:b0:493:be08:c372 with SMTP id
 5b1f17b1804b1-493f88b5d6amr2587905e9.17.1783717772695; 
 Fri, 10 Jul 2026 14:09:32 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73ae14sm161183355e9.11.2026.07.10.14.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:31 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 3/6] bus/fslmc/dpio: make the portal DQRI epoll optional
Date: Fri, 10 Jul 2026 23:09:17 +0200
Message-ID: <20260710210920.2402309-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710210920.2402309-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
 <20260710210920.2402309-1-maxime@leroys.fr>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 44 +++++++++++++++++-------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2a9e519668..05645d667a 100644
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
+		dpio_epoll_fd = epoll_create1(EPOLL_CLOEXEC);
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

