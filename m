Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB3BCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B75D54332A;
	Thu, 11 Jun 2026 17:50:20 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 741C243322
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:19 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so28093f8f.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193019; x=1781797819; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoNDbb6wnRU/vwLjGNlb90THBQ9jCw1JR6vl6lSAzo8=;
 b=dJDPUVfzsILEBV6ixrSTHm2QJQ9vc2i8V+82owwVXtWXXZEyWGOO6+ov1wiCbDI6RL
 Ts01+kMGZRfwsdv/djTlQP1zaaIgiVWsY6ijrd8GBUMjXdyTleUnZVHXCE5CiT/AleXi
 glinam10qRuq2t53sJHK2N67tpyqE6XoGzLXmMLhEgpxoKCSYBx36M1DdgL/BiUQG5hK
 /jyQSDYHaLVkYNlKSmGVLeKjKCviAToq94JcDnndwGAwDhde9xG8rbEndPDshZmNdebB
 zciG82NMmdnTABv4vunjUCUPguwgXa/ZWNQ9V5cccS1aLx9Vm1ZQde3ogBaIfd9NbesT
 vUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193019; x=1781797819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoNDbb6wnRU/vwLjGNlb90THBQ9jCw1JR6vl6lSAzo8=;
 b=QMRvTI0dp7h/Tquf7t2ZMItFew55UWalukUnzDsAQJs9V5fjZwVXerHPcXH8Vt5d4f
 HLfN4HZc91YwGswKltG+fYoDCSsSSLYJ4Z2/9JST7Vp5LAFdfpFZpdA2e8SI41VNp/Db
 emw6q+Bb7mQN0T5ctocjRNSEDsTNIJfHQ4hc7SbYJr1EjNM1/Q6phUnoQRYNRqWhz5dp
 fku2h2nALMij+PFo+VijV//yCl7EpHda5wkgyCAgKJXeyUhHToxG00C+P9yVZtf+pQqy
 0fhxp+3oXxo1VkOasIAkXZz1rcrpYO+T2Ek22XLrTVuEo5t2WnQwKxfK7Z+NErbWalIK
 B4Rg==
X-Gm-Message-State: AOJu0YwLM7+xnaWFRc3ayCCNERbyFhGsBDWZ+TEk39152wX6s6HKVeM7
 FD9sm4OqF2+DRg8sn8orqNnv6vazZbSiAqQ+g+Tr02hxKIG07EqLTXjUMPH5jg==
X-Gm-Gg: Acq92OHLDTu7Gw3rZbSgdYnNe+e90dSAbH6zXH7CETYcdF8N8o1qo3pq3yYfjZpQJLT
 lCBwyt/K3FluPQ2CU5DfU7ey1XS41aVTE62EFMUI09SaSOUqzuCqUgaipffNYkqC/6mmd86UGbg
 f4hTYFumoEXBnnT6jmu/txw3zNZVF3+c53JHJEV5FEuiYOwlRKc9UwOqLXBRLvoe/3DaJkbGmHo
 v6oGwbvTcP1w7cp6fuYgYq2q0zYb6lTmPq/9jZvY0YcEhFURvB0FGJSQQVOHROfj6FAiGvXpfbX
 hTQr2v1v2U+c+n0uf0vs9MUn894T79qzscLItkZTDBWDz9BLAX0FN53hEenrBh5l5//xFthJ8gK
 InC9VNGUQJLSF2hN2wJb8qagoHJ0TCCbo8frSSKCbYQaa0ogiyzHtWRKVJGsMr0UekZv0DgxuS7
 ASYnfUpHA0WoYGWOFplRi/8Y6pWy8cIFK5L6/1k3k7cvCC+qNAy2JmChw3UYiiaL3gY9bSoTrxT
 A==
X-Received: by 2002:a05:6000:1868:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-46067dfb1ccmr4693217f8f.3.1781193018940; 
 Thu, 11 Jun 2026 08:50:18 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm90104531f8f.24.2026.06.11.08.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:18 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 4/9] bus/fslmc/dpio: make the portal DQRI epoll optional
Date: Thu, 11 Jun 2026 17:49:19 +0200
Message-ID: <20260611154926.392670-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

