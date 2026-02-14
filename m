Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EEEF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2EDA40672;
	Sun, 15 Feb 2026 00:47:48 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id B911840662
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:45 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso14284095e9.0
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112865;
 x=1771717665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEVCRbVa9HcZUo3qMyqlECxfsNtFJmANKLRB6axyVuk=;
 b=VSwhV6Btf/VfalzGSED36wFURn5VjDQYNLMP7OUYaUbhWMRNShhRnkoA7KBt/Rrdiy
 hVIMi7EfziUuyXN6RSz81uoHv7T4hG8lbWLZkvECiTf1FM9ZPZxm5ZFUHxjuq8ngK6sN
 sT91Ed6aPH2lSPghVC2zN6lNO3dDOOnej7JEwl4vJZ3rlwpFGo/ZLBSHyFkaj/UAivw1
 w6yuHjOYJbQKIntEPwyB7jnKw3tDOmsasC2gKS7a+NWFvw3ojff0YzU5u2nMsjjUJrAV
 JB5NPQ7kRh+lgP1bRgFOfPGARGAbZVfoueD+eI5pRVazZbm0Vh79MkH2joLmt9pFFHAe
 olDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112865; x=1771717665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEVCRbVa9HcZUo3qMyqlECxfsNtFJmANKLRB6axyVuk=;
 b=SmEEr2PS6cCaAv/sVAIzctLMC3/1tKZprcV/uMUNiTceN8XIzt0WluG6MZRLt/xGy6
 5GnzmDdL7XPj4FDRGRN5sYVLJVYwb3ddoULPJA5e73c1+aETdTmtlfyKjxSMIs/igtWU
 Hywl5atZYzNYkU7V6uwCXhxE49kLAhu5ZjM6mA/6B9pR8WczQB6xDmDtwHAIidFO3sp0
 ZhesDNx0e4mBNbtLYMiGlknKepdDxZa/5UoemjjO27xTc9WlMwDWopMFcOOpQad3IxaK
 HQfPyhwfmlWVr/mMtOF7rvVPc+pRoGf/vkytsXc++yHYy8a4PKJzVsouMNrwvrt8liaa
 Db9w==
X-Gm-Message-State: AOJu0Yyy2p23VPEHkV/xf0+OdPaNs/ild1BEv8epZvIs4PEXHYPM9+pL
 CViWSX5ZrxK3Yb1S8/bDxnTacDJcjmiKOt2BBKzgmlQ+jprnga/ecuz8lpog7D0HsbHG5UVUbUu
 lQ+Bh
X-Gm-Gg: AZuq6aK8kPOjZt0Vn9MLHQaxojsfkR58grxmH0bGIXhY1uXqFCuLK1I+e+vwTwXc9Bb
 YrpWAzlNqVx16uhFubE2H1l6rL105r2XJRgH7saMo1ARdUskJ0FzLL3Uv61nw7fHQskLbeHYsCX
 e8GLsPfOyQKjZDwgD1OaJa5u76r20Txz2yq89/XCkLIx4Dip65el9EblYu1sZmY2vZG1wKJoXMv
 inK3Uso8MlS9KnSU7sLPBzyOEWTvh1pi2FruoHCoGkKgWI1j7mC6LttB/6Ih9g+qBaJNrWwj7PE
 m2j3NfMp/zt38+PHGGR+RdY5Kort+YZQe1PrcT+ZT1TrgP55HJbSrLWwA0QagSBIo01mNhen0Gw
 iOrqeMtrnF24Rdc+zn8VWp60SlanYBwucvmKxXbgy38wKfilAfxLVlROz+O/LJ2QJ+OEXZBYQA5
 DPzbshCMws3J3C97sTgsrAd0/0pDPM/STYkgjehSO30ck7+/1X5pjVSwrxJUigkgon
X-Received: by 2002:a05:600c:1d89:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-48373a085c8mr113755895e9.5.1771112865320; 
 Sat, 14 Feb 2026 15:47:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 08/11] net/rtap: add link state change interrupt
Date: Sat, 14 Feb 2026 15:44:17 -0800
Message-ID: <20260214234726.188947-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
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

Add link state change (LSC) notification support using a netlink
socket subscribed to RTMGRP_LINK events.

When enabled, the driver registers a netlink socket with the EAL
interrupt handler. On receiving RTM_NEWLINK/RTM_DELLINK messages
matching the interface ifindex, the driver updates link status and
triggers RTE_ETH_EVENT_INTR_LSC callbacks.

LSC is enabled in dev_start and disabled in dev_stop.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |  1 +
 drivers/net/rtap/meson.build      |  1 +
 drivers/net/rtap/rtap.h           |  4 ++
 drivers/net/rtap/rtap_ethdev.c    | 26 ++++++++-
 drivers/net/rtap/rtap_intr.c      | 87 +++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/rtap/rtap_intr.c

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index cfbd29ef08..fe0c88a8fc 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/drivers/net/rtap/meson.build b/drivers/net/rtap/meson.build
index ed0bcc1313..58943e035a 100644
--- a/drivers/net/rtap/meson.build
+++ b/drivers/net/rtap/meson.build
@@ -19,6 +19,7 @@ endif
 
 sources = files(
         'rtap_ethdev.c',
+        'rtap_intr.c',
         'rtap_netlink.c',
         'rtap_rxtx.c',
 )
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index aeda7f3f25..2cc55c9667 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -61,6 +61,7 @@ struct rtap_pmd {
 	int keep_fd;			/* keep alive file descriptor */
 	int if_index;			/* interface index */
 	int nlsk_fd;			/* netlink control socket */
+	struct rte_intr_handle *intr_handle; /* LSC interrupt handle */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 
 	uint64_t rx_drop_base;		/* value of rx_dropped when reset */
@@ -98,4 +99,7 @@ int rtap_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 			const struct rte_eth_txconf *tx_conf);
 void rtap_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id);
 
+/* rtap_intr.c */
+int rtap_lsc_set(struct rte_eth_dev *dev, int set);
+
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 705d98323e..9c23ca2f16 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -214,11 +214,18 @@ rtap_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 static int
 rtap_dev_start(struct rte_eth_dev *dev)
 {
-	int ret = rtap_set_link_up(dev);
+	int ret;
 
+	ret = rtap_lsc_set(dev, 1);
 	if (ret != 0)
 		return ret;
 
+	ret = rtap_set_link_up(dev);
+	if (ret != 0) {
+		rtap_lsc_set(dev, 0);
+		return ret;
+	}
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -235,6 +242,7 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_lsc_set(dev, 0);
 	rtap_set_link_down(dev);
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -435,6 +443,9 @@ rtap_dev_close(struct rte_eth_dev *dev)
 			close(pmd->nlsk_fd);
 			pmd->nlsk_fd = -1;
 		}
+
+		rte_intr_instance_free(pmd->intr_handle);
+		pmd->intr_handle = NULL;
 	}
 
 	free(dev->process_private);
@@ -522,6 +533,17 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 	pmd->nlsk_fd = -1;
 	pmd->rx_drop_base = 0;
 
+	/* Allocate interrupt instance for link state change events */
+	pmd->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
+	if (pmd->intr_handle == NULL) {
+		PMD_LOG(ERR, "Failed to allocate intr handle");
+		goto error;
+	}
+	rte_intr_type_set(pmd->intr_handle, RTE_INTR_HANDLE_EXT);
+	rte_intr_fd_set(pmd->intr_handle, -1);
+	dev->intr_handle = pmd->intr_handle;
+	data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
+
 	dev->dev_ops = &rtap_ops;
 
 	/* Get the initial fd used to keep the tap device around */
@@ -571,6 +593,8 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 		close(pmd->nlsk_fd);
 	if (pmd->keep_fd != -1)
 		close(pmd->keep_fd);
+	rte_intr_instance_free(pmd->intr_handle);
+	pmd->intr_handle = NULL;
 	return -1;
 }
 
diff --git a/drivers/net/rtap/rtap_intr.c b/drivers/net/rtap/rtap_intr.c
new file mode 100644
index 0000000000..6cdfb412c3
--- /dev/null
+++ b/drivers/net/rtap/rtap_intr.c
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <linux/rtnetlink.h>
+
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_errno.h>
+#include <ethdev_driver.h>
+#include <rte_interrupts.h>
+
+#include "rtap.h"
+
+/* Interrupt handler called by EAL when netlink socket is readable */
+static void
+rtap_lsc_handler(void *cb_arg)
+{
+	struct rte_eth_dev *dev = cb_arg;
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	int fd = rte_intr_fd_get(pmd->intr_handle);
+
+	if (fd >= 0)
+		rtap_nl_recv(fd, dev);
+}
+
+/*
+ * Enable or disable link state change interrupt.
+ * When enabled, creates a netlink socket subscribed to RTMGRP_LINK
+ * and registers it with the EAL interrupt handler.
+ */
+int
+rtap_lsc_set(struct rte_eth_dev *dev, int set)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	unsigned int retry = 10;
+	int ret;
+
+	/* If LSC not configured, just disable if active */
+	if (!dev->data->dev_conf.intr_conf.lsc) {
+		if (rte_intr_fd_get(pmd->intr_handle) != -1)
+			goto disable;
+		return 0;
+	}
+
+	if (set) {
+		int fd = rtap_nl_open(RTMGRP_LINK);
+		if (fd < 0)
+			return -1;
+
+		rte_intr_fd_set(pmd->intr_handle, fd);
+		ret = rte_intr_callback_register(pmd->intr_handle,
+						 rtap_lsc_handler, dev);
+		if (ret < 0) {
+			PMD_LOG(ERR, "Failed to register LSC callback: %s",
+				rte_strerror(-ret));
+			close(fd);
+			rte_intr_fd_set(pmd->intr_handle, -1);
+			return ret;
+		}
+		return 0;
+	}
+
+disable:
+	do {
+		ret = rte_intr_callback_unregister(pmd->intr_handle,
+						   rtap_lsc_handler, dev);
+		if (ret >= 0) {
+			break;
+		} else if (ret == -EAGAIN && retry-- > 0) {
+			rte_delay_ms(100);
+		} else {
+			PMD_LOG(ERR, "LSC callback unregister failed: %d", ret);
+			break;
+		}
+	} while (true);
+
+	if (rte_intr_fd_get(pmd->intr_handle) >= 0) {
+		close(rte_intr_fd_get(pmd->intr_handle));
+		rte_intr_fd_set(pmd->intr_handle, -1);
+	}
+
+	return 0;
+}
-- 
2.51.0

