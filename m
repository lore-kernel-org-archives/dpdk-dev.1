Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA1C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:43:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 410A240698;
	Tue, 30 Jun 2026 16:43:46 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 5A2C6406A2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:42 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-473ba028d46so2184604f8f.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830622; x=1783435422; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdbsarOu2QCMGMnyZjNk5ccu2jIdwuiuZqDEnvhGRVQ=;
 b=ePTo+7tT2oI9QxQGNouZ4tg8DbCwzlo3ySiBna67pgcDtubWhPCwAUjmLIR3xRJZaK
 41PVJT8ImKUKBBZj5jJuVFr+as/zeP+5KrJaFHeBZEGW49tLrSJc5fC6oOjPwh5ANUoO
 dcc8hRRw44eEiCLusrUTF3XjoxWOTFkFSXDOVVbETVwC/1WQEoa+ibbXk/+CrvMYd/iw
 JkDpkCF7UboLmIYt6no8QwQAWRUdjrYzMpUj9LxC1aaADiKwmn4ufjsdhv1GX4yzvevB
 3J6y4ZsSdQc2mK5oZ47Qb874c0xUtsXWSt1qH71SkvAn9A5DzD8ub5mM/EU2Q9mUbsZG
 KBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830622; x=1783435422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdbsarOu2QCMGMnyZjNk5ccu2jIdwuiuZqDEnvhGRVQ=;
 b=GWvV1pPNYA81G6m0tKmGM7tLeO2/AwvWHY2bre3MuCObp/gCNdmovpWE7dI4rwjcju
 WKNTKfxCktuDsMIrZm5ra9BIW4wyDkxcpFMzfJ1lvD3mtFYPtN52YOStP8b8hK6rCdLN
 GWKiz4ECop3o4Nver57u0jqL6GhAs2JSrPDx3NO9qbZpKAQXbeWfRjmFRzqUuERKLviU
 NvcCKZHmPEXVSS54EZzzIIXu6iOg+2ImZIwXC54ESJtFtzmxd2BMvR7Dzpeusd7rHii7
 reVkJSun3oX5om7aAHxS7ORL3epvrFhB3P/ytbr4qTeQTqxgmsdsdXQvCkQzhTinwxsX
 ut7A==
X-Gm-Message-State: AOJu0YzZRJJ6Sqybh+unmOuKGK8Fx5d2Dqf3eH8LWoBTztoZMTE6nu4b
 RODzCKIHPlIeDdkjSBKLibE3AJcX0U8pAWx0wNSUoXHYsVaMzbnLV/+64m38DUn0
X-Gm-Gg: AfdE7ck3515hwqfATD7hhKYv+uFsOMQ56ZGU/93B2Jep96dSpgvqdgy10+TSXfogeNE
 IXs8MbMlJQKu/OuiZjjI1pCod+cSR4cYvQCdSO8bqYAfjPixaDeRNYeKJiZA/IQkD1siILCw/2Y
 JowfQ5/i695rUZRiQOh0vxnDSzOkWklQgzooaBu+qc4Aqe8LFwlF5stU93E3zEShbe+UPDXxBG5
 PfGp0cefrCTc4hTaVwIwKFDpq2sVyUVg72N3+6U4vUc+6dVkCdq+IT7P/rVp7RHJus4m2D5nfPn
 8e1MpZIikORDGhOyVcvobc4YDN+grT0Eta0tU7sfrA+T57DpDKRGSlxymQ+EdZPVash1xOv5zYQ
 5ttQ8piiervHNecs/8dL8++CaLwT/sJUE1rTQOImHVfKY3g4I3xsDQdx9zQDfhQOl3MxwoZEkdZ
 Dfpu1KIWn2fcSY43Kt8v3C2wlNfyV9lnjrepMICPPRk/TMik3DDqSh/8M=
X-Received: by 2002:adf:e785:0:b0:475:a05c:c642 with SMTP id
 ffacd0b85a97d-476587c91d6mr1054267f8f.19.1782830621864; 
 Tue, 30 Jun 2026 07:43:41 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf98sm6256399f8f.22.2026.06.30.07.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:41 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 3/6] bus/fslmc/dpio: make the portal DQRI epoll optional
Date: Tue, 30 Jun 2026 16:43:26 +0200
Message-ID: <20260630144329.457643-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
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
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 40 +++++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2a9e519668..f0b843e3a3 100644
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
@@ -231,16 +230,30 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev)
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
+	/* private epoll for the event PMD; the net rx-intr path uses the app's */
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
@@ -253,7 +266,10 @@ static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 	if (ret)
 		DPAA2_BUS_ERR("DPIO interrupt disable failed");
 
-	close(dpio_dev->epoll_fd);
+	if (dpio_dev->epoll_fd >= 0) {
+		close(dpio_dev->epoll_fd);
+		dpio_dev->epoll_fd = -1;
+	}
 }
 #endif
 
@@ -277,7 +293,7 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	}
 
 #ifdef RTE_EVENT_DPAA2
-	if (dpaa2_dpio_intr_init(dpio_dev)) {
+	if (dpaa2_dpio_intr_init(dpio_dev, true)) {
 		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
 		return -1;
 	}
-- 
2.43.0

