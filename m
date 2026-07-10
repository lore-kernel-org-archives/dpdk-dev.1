Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DFFC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9679940A81;
	Fri, 10 Jul 2026 23:09:28 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id A109F409FA
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:27 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so9483405e9.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717767; x=1784322567; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MEagi7+wogy9HEYtxyzJO0rS5hcJOJtn/XXlYtDHwOg=;
 b=geYZ3aTXsrwEKzGTgR9KYJ4IRHiQl7Qlu0+NPYGXDPMcL8KqB2DrEF51UDr8cLQFN5
 lH2fRAsLPwidW/QXhaex1gJCpNZGHMoDrQ9Zd2sRXeWfyDxXUXGLOpBk9NIE/8eslJBV
 o7g7dx0+tnc8VOTfvwzLuYRYJbGZx2cazW8jSQ3nAXmQq2ieJbCxU70HILyiODWjdeNF
 xOS+BvFfOWcCnG4+4qsnPPLBeJwZjxejjYc4H/1s2rjhahg/HUCIsGpuV1wXYqUhlixJ
 jbvaXcVzc0BHZD8ctoTNJV/cklHDazWn7XRocSkaTedtH6uBcwkOfmsynfVeoszQlFgh
 QGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717767; x=1784322567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MEagi7+wogy9HEYtxyzJO0rS5hcJOJtn/XXlYtDHwOg=;
 b=hyJVBo0l3Gzt5DGwrMobcMAguWgQUzoTXrQfJx8upaa/1RhrNew82uBTyXJcZ/dUT9
 ahiZl2dM/ak3Wz56OkeednGIbCdo+WNSl2Dx6obDtIkWVgB4n7K0CZ20o5MVIrp8ojrj
 aMgWY8ge3CLy+2tIzaeEDFOoNeK8/JS01wkZbx+pOFLyqjz93UwoDs/zeBCkuYxFbkIP
 tdjictcqzH0ulHtbr14zZgCMjq/Xt8iVpGQSgRei6GoZIrLkC1GyHyCSJ8TkOwK7GiK6
 7T/fivtazgS9ABQtswNAcuBv/T4HtgljX0UltsjwTHS1jcFSpsujD13K/BG3ub5c8Zmk
 vq1Q==
X-Gm-Message-State: AOJu0YyG9srNgmcA+DWW0m+N0Htf/HHHJ3xfudtWoN2uuWjYRuvMNLBS
 i0ZJjJBDDtnR0ziFjDgW4Udu2U2RaNk5/RZUPIA1cBJ7/lVuC25wd8GEhAtiLPjz
X-Gm-Gg: AfdE7cm7akAP9eBEVFd3I4y09OFFNoupkbl06sc5baffydkWGyEvcM9d8/1Q2uUr+53
 tRc1CVHFslXNGNSKj7MHyfXZ0IjYDs2elWXJZ3+ILIxASyAHBwhlcIbSmI6CBiJjz9YdDcf0uLG
 W0dgghtJHUt3m6tjUtKqYacrrrGXcADx49l8klQ/h5sRZWkd/+XFAr0g7wk5Q0Li1w1wYrT+pR9
 ctkeH8Yw3Bu4RUsRvCN8O1FVA5e2OzAvdjBcgFc/9CmmfuSpfqjeTraVO4IjyfCUC4DfUFj6DUU
 ylyD/9c64mGYBKQInRC+WMJaDKsVWHttSbWx/DFC507/LOKrm6PCycbV0AuNk4YyuQt1e4L4Uk3
 /QSWu0pPxmcrVn99A+K6ifY6dlhaghDBTAL4gfR4vS5n7ICpWmX73s9NGuJvm60duUOVPWCYNrX
 RzDpE1ig==
X-Received: by 2002:a05:600c:4ece:b0:493:f0f5:f2d2 with SMTP id
 5b1f17b1804b1-493f87dc3f3mr3369915e9.1.1783717767211; 
 Fri, 10 Jul 2026 14:09:27 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4cbc620sm63535025e9.13.2026.07.10.14.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:26 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 1/6] net/dpaa2: fix Rx queue count for primary process
Date: Fri, 10 Jul 2026 23:09:15 +0200
Message-ID: <20260710210920.2402309-2-maxime@leroys.fr>
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

The rx_queue_count callback was only assigned on the secondary process
path of dpaa2_dev_init(), leaving eth_dev->rx_queue_count NULL for the
primary process. The fast-path rte_eth_rx_queue_count() performs an
unguarded indirect call in non-debug builds, so invoking it on a
primary-process dpaa2 port dereferences a NULL function pointer and
crashes.

Assign the callback on the primary-process path as well, so both the
primary and secondary paths set it.

Fixes: cbfc6111b557 ("ethdev: move inline device operations")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a68404ee5e..61122b323f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3276,6 +3276,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	eth_dev->dev_ops = &dpaa2_ethdev_ops;
+	eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
 		eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-- 
2.43.0

