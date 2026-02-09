Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F3CE7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1121640A70;
	Mon,  9 Feb 2026 19:41:04 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 733FF40A71
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:41:02 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so2034041f8f.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662462;
 x=1771267262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZMytvZcE70QNRUJl5jpFD3l3zBBaaRJRaAoYAcir/I=;
 b=GKxE62mg3BQsNouq084KwcXZOJdIQOMHN88dAVwuvF7Wlzm+r1QEjbCwpO/g9StfFI
 a9L67+hZq14aGYGKu1+d17lgFwPZILQguO7tLsKCtpv8uiZCUUlJojkc46zoW/Bkm5T5
 6locoSDrcD4cjG10rRbRIH61ycNxWeyFe0Ul7oxVYpDoCp0d6OBmDWEq1peByZ9wW2V3
 OD7wx9dUXcOWw6cndjOrfRvN1F0CZd59VriDYQSgFvUzsUNmHNlVyZIDg0ZshTXOJ5sk
 L9aCu8K+2eDGp+ZVxN2dRfKMvk9alk3OxVAaEufu2JcYzrH2OCYrvwWwFWuSErddbQWU
 DFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662462; x=1771267262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XZMytvZcE70QNRUJl5jpFD3l3zBBaaRJRaAoYAcir/I=;
 b=GsFRvzpy7qipFWBujxX5Ab2Rmk8sQJj7pvD04ECavLq6wTDHfaiklZwQQfVrtMDoZO
 4fbtfG8XYUDFn1EcXDlwGE6PvyM6pFdk2OLOGG5jg1Q3O6Ptvj0joyaJ/PFTyuB1SMW7
 Mu9DWsyikyfJ3pllb4TJM67YQ6MIMKkyJ9PlrIXmI+tyTOUfKzA+lLILpruk8yHl/A/H
 mpH6ByyH4mN1G9HRor4PsiHT7EOnesNZ/qJr8i4uHwioqfUn1Wph9zAM7u1hRz/4U0ae
 wBt7YkySGxV2+/+iMkfYCLveGrstDfS0ikHolLFTawg3v/NAyx9498Mq/WtFA9/5Wztz
 Ntpg==
X-Gm-Message-State: AOJu0Yxo7q9pvqHax6cB7D1j54m/PNTp+cYj7wDbOVablsvK4TZ5PPj1
 RDnxPgZMZcP2kWySnYP2QHdX5cCzkjQwDTtuminD8L81rGAoJTiLafwDxmDglImVIa9zDMW1g/t
 SJG3W
X-Gm-Gg: AZuq6aKvO2tDm1+HH42GOMtdmLExvY+lbpkt8cW3hIJ6ijthPoioZ/LyNnQm28SqIg7
 xmzcBb7O2pTxCxrk7GX5xTdUqczBUMSjvvz2D20HF87pk7dZytJXaXVbj89JloK3a0gVBFTXe7k
 7zy7tZCV479ISbHBaSPszEkDSedy5c0KsxCISes16PQGNAGRMwt0SbEsMJJF20ZY9WEfvyAsqRI
 d8TvZCqGMWtVV0xBcDMVGMnJ57NKz3TxQp8xmUt0BuQpGB9eynTaqsSTGvD9JN5tVZZdbpxs6Kn
 p6bLjQevNsuN9JqWEB50vx2htIKk+YYrrSB8HkFHrmUIH+WxP8XAZnr17DmjzL9NMmPxJ/uETRW
 qza+UiiEOjsAJ7Ioptm8WPVXItzH353HWXKPuSs6PLKgzkxRUdC2Zqs3TJjLI8eRvIs7HEZOSPj
 2rKP7+jtvfF9vpawXCqRqbefaiw1DeQ69xxLjxjkrrxCsGUNFf5g==
X-Received: by 2002:a05:6000:40e1:b0:435:a8e7:62de with SMTP id
 ffacd0b85a97d-4362938f7e2mr17826203f8f.58.1770662461955; 
 Mon, 09 Feb 2026 10:41:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:41:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 07/10] net/rtap: add link state change interrupt
Date: Mon,  9 Feb 2026 10:39:06 -0800
Message-ID: <20260209184045.132774-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209184045.132774-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260209184045.132774-1-stephen@networkplumber.org>
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

When LSC is enabled in the device configuration, the driver:
  - Creates a NETLINK_ROUTE socket filtering for RTM_NEWLINK and
    RTM_DELLINK messages
  - Registers the socket fd with the EAL interrupt handler
  - On interrupt, drains all pending netlink messages and updates
    the link status for matching interface index changes

The interrupt is enabled during dev_start and disabled during
dev_stop, with proper cleanup of the netlink socket and EAL
callback registration.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   1 +
 drivers/net/rtap/meson.build      |   1 +
 drivers/net/rtap/rtap.h           |   5 +
 drivers/net/rtap/rtap_ethdev.c    |  36 +++++++-
 drivers/net/rtap/rtap_intr.c      | 147 ++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/rtap/rtap_intr.c

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index b8eaa805fe..36a14e9696 100644
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
index 8e2b15f382..86d400323c 100644
--- a/drivers/net/rtap/meson.build
+++ b/drivers/net/rtap/meson.build
@@ -19,6 +19,7 @@ endif
 
 sources = files(
         'rtap_ethdev.c',
+        'rtap_intr.c',
         'rtap_rxtx.c',
 )
 
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 99f413f001..f73b5e317d 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -13,6 +13,7 @@
 
 #include <ethdev_driver.h>
 #include <rte_ether.h>
+#include <rte_interrupts.h>
 #include <rte_log.h>
 
 
@@ -62,6 +63,7 @@ struct rtap_tx_queue {
 
 struct rtap_pmd {
 	int keep_fd;			/* keep alive file descriptor */
+	struct rte_intr_handle *intr_handle; /* LSC interrupt handle */
 	char ifname[IFNAMSIZ];		/* name assigned by kernel */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 
@@ -86,4 +88,7 @@ int rtap_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 			const struct rte_eth_txconf *tx_conf);
 void rtap_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id);
 
+/* rtap_intr.c */
+int rtap_lsc_set(struct rte_eth_dev *dev, int set);
+
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 277a280772..8c22021655 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -24,6 +24,7 @@
 #include <rte_eal.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
+#include <rte_interrupts.h>
 #include <rte_kvargs.h>
 #include <rte_log.h>
 
@@ -141,11 +142,16 @@ rtap_change_flags(struct rte_eth_dev *dev, uint32_t flags, uint32_t mask)
 	ifr.ifr_flags |= flags;
 
 	ret = ioctl(sock, SIOCSIFFLAGS, &ifr);
-	if (ret < 0)
+	if (ret < 0) {
 		PMD_LOG_ERRNO(ERR, "Unable to set flags for %s", ifr.ifr_name);
+		goto error;
+	}
+	close(sock);
+	return 0;
 error:
+	ret = -errno;
 	close(sock);
-	return (ret < 0) ? -errno : 0;
+	return ret;
 }
 
 static int
@@ -277,11 +283,18 @@ rtap_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
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
@@ -298,6 +311,7 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_lsc_set(dev, 0);
 	rtap_set_link_down(dev);
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -508,6 +522,9 @@ rtap_dev_close(struct rte_eth_dev *dev)
 			close(pmd->keep_fd);
 			pmd->keep_fd = -1;
 		}
+
+		rte_intr_instance_free(pmd->intr_handle);
+		pmd->intr_handle = NULL;
 	}
 
 	free(dev->process_private);
@@ -585,6 +602,17 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 	pmd->keep_fd = -1;
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
@@ -623,6 +651,8 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 error:
 	if (pmd->keep_fd != -1)
 		close(pmd->keep_fd);
+	rte_intr_instance_free(pmd->intr_handle);
+	pmd->intr_handle = NULL;
 	return -1;
 }
 
diff --git a/drivers/net/rtap/rtap_intr.c b/drivers/net/rtap/rtap_intr.c
new file mode 100644
index 0000000000..8a27b811e1
--- /dev/null
+++ b/drivers/net/rtap/rtap_intr.c
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/rtnetlink.h>
+
+#include <rte_interrupts.h>
+
+#include "rtap.h"
+
+/*
+ * Create a netlink socket subscribed to link state change events.
+ * Returns socket fd or -1 on failure.
+ */
+static int
+rtap_netlink_init(unsigned int groups)
+{
+	int fd;
+	struct sockaddr_nl sa = {
+		.nl_family = AF_NETLINK,
+		.nl_groups = groups,
+	};
+
+	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK,
+		    NETLINK_ROUTE);
+	if (fd < 0) {
+		PMD_LOG_ERRNO(ERR, "netlink socket");
+		return -1;
+	}
+
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		PMD_LOG_ERRNO(ERR, "netlink bind");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+/*
+ * Drain all pending netlink messages from socket.
+ * For each RTM_NEWLINK/RTM_DELLINK that matches our interface,
+ * update link status.
+ */
+static void
+rtap_netlink_recv(int fd, struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	unsigned int if_index = if_nametoindex(pmd->ifname);
+	char buf[4096];
+	ssize_t len;
+
+	while ((len = recv(fd, buf, sizeof(buf), 0)) > 0) {
+		for (struct nlmsghdr *nh = (struct nlmsghdr *)buf;
+		     NLMSG_OK(nh, (unsigned int)len);
+		     nh = NLMSG_NEXT(nh, len)) {
+			struct ifinfomsg *ifi;
+
+			if (nh->nlmsg_type != RTM_NEWLINK &&
+			    nh->nlmsg_type != RTM_DELLINK)
+				continue;
+
+			ifi = NLMSG_DATA(nh);
+			if ((unsigned int)ifi->ifi_index != if_index)
+				continue;
+
+			/* Link state changed for our interface */
+			rtap_link_update(dev, 0);
+		}
+	}
+}
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
+		rtap_netlink_recv(fd, dev);
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
+		int fd = rtap_netlink_init(RTMGRP_LINK);
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
+	unsigned int retry = 10;
+	do {
+		ret = rte_intr_callback_unregister(pmd->intr_handle,
+						   rtap_lsc_handler, dev);
+		if (ret >= 0)
+			break;
+		if (ret == -EAGAIN && retry-- > 0)
+			rte_delay_ms(100);
+		else {
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

