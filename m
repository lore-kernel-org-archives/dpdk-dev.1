Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5306CE7E0D2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2855C40A8A;
	Mon,  9 Feb 2026 19:41:08 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id C706F40A72
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:41:05 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so45787215e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662465;
 x=1771267265; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjOtpjciW1EGIs+fqZwfcEPAZG1T1DZugT/eiryfh/I=;
 b=swjAULjaiqkYaI43SAQGV1ey8rH6JccNqyf48pV2tLuzjhCQeyohT/IIdTrmakE+Tt
 4F1aeUIIJkP6AkSFkO25wC+3fuZNkFo239maIoTQ7ky22UZzyHQX2MGtM2+ml+zQjquV
 QF9irj7ebESRKhIB21SL/609x1OepvEO3tulAudSJmXbxgp3h2YrIZAw2tB/74xOj6BV
 /EW65NDiqOcHsMjnBC1AIk3yFqiMPUPTlWU8d53mSfPYTiH3YaH+35wxL62KnKpqsFVZ
 abqL5dutM+ALXyTtL8HSg8TeJ1moIFjrnUHLIX/lacc9wTFK+1vDpwm9tXRwGI3dwO62
 sMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662465; x=1771267265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YjOtpjciW1EGIs+fqZwfcEPAZG1T1DZugT/eiryfh/I=;
 b=iwNhpXcw5UgvIwhqyt3fXpOLrzkqz/0ryQa/Bsp+XINLUgvCVALfJwUyoMt1B07h1B
 f7/ROCMdcPZ7NzV2taHCPtr7lYaaPjCH6u2gZQLQtqS6+IfHMRo+ETqH7lflJZ5vX4x6
 cGyUL2j1ueu2ndUTpKVeyngRqCWHObz8AN8cQvRpYyUBvriNcbMSFzvp51OWrzDtIFM8
 LFEH6lrGxadcC77MojYjzP8GyLRIabMIOXccXNzFAErd8hmapmDgSRShNvbvBXpR2e85
 X9AaLm4m3WCGQqti2osGXXXnE6GLLIRUBzM7Oa91FdgpUr9IC+GJnTNE2/GnFoX1QQ9C
 MgnA==
X-Gm-Message-State: AOJu0Ywjf9g7YIvygmmPSKXdli1dHO6spY0WH7t+EBtyy0dKBz8wA+d2
 AgYcwcxPMBO1o0n4NR2MskeKSRadFm9R6YS6JKCqhOcRXrQhb1t1Ia8BfORKRnxHVH1UEcPIPdI
 4TP2N
X-Gm-Gg: AZuq6aJTFkd5mkHY21xAOm3pavqTRoZKH2aIw9OGPUb/XSTDau0wxvnoefPFejL6pvc
 px/ra/15dIKLCkr9z1wMKrMv+PZ/8lqfDdm8KT/nCSsWiH0UKTO8oSawRI/Cu01bbmw6iDbrwUT
 yi1C1BJOW7bYQ8jKL7DeMiI+jy1K1YKp5X5DiA9cdJuBSP49Ulsr9y13FjCj4m7VrAdLegvD0cw
 7NDdhKtruo7Z+vA2MLKj7KNgkxVAmCzHfnJywOrZsxhp/JLHk6G6dlFr+bg63D++4QK+UQdDxqs
 Y+1761Sjs2uuZvi4v4a8nLxbjiuH6xv+Xf81l0WETUZ3u/fMn2gzvtZZpPVYHzOs9lsraIMp403
 k97vVoca2ufFQ+5ueB3mKbhAUsgpfSsmTRTRNGiRZhSQyaYEL1IukiT5FfbgV+HeyNUD01QdZ+H
 cClpuE/A06KODZSQ2vfy9SOfB/3rmdZihj6wyX+B5ZvvnoAdmOWw==
X-Received: by 2002:a05:6000:2386:b0:436:3563:49a6 with SMTP id
 ffacd0b85a97d-43635634ac8mr11593136f8f.43.1770662465244; 
 Mon, 09 Feb 2026 10:41:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:41:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 09/10] net/rtap: add Rx interrupt support
Date: Mon,  9 Feb 2026 10:39:08 -0800
Message-ID: <20260209184045.132774-10-stephen@networkplumber.org>
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

Add support for the DPDK Rx interrupt mechanism, enabling
power-aware applications (e.g. l3fwd-power) to sleep until
packets arrive rather than busy-polling.

Each Rx queue creates an eventfd during queue setup and registers
it with its io_uring instance via io_uring_register_eventfd().
When the kernel posts a CQE (completing a read, i.e. a packet
arrived), it signals the eventfd. These per-queue eventfds are
wired into a VDEV interrupt handle during dev_start when the
application has set intr_conf.rxq.

The enable op drains the eventfd counter to re-arm notification;
disable is a no-op since the application simply stops polling.
The eventfd is always created unconditionally so it is available
if the application enables Rx interrupts later.

The Rx interrupt handle is kept separate from the existing LSC
netlink interrupt handle to avoid coupling the two mechanisms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   1 +
 drivers/net/rtap/rtap.h           |   6 ++
 drivers/net/rtap/rtap_ethdev.c    |  16 ++++
 drivers/net/rtap/rtap_intr.c      | 120 ++++++++++++++++++++++++++++++
 drivers/net/rtap/rtap_rxtx.c      |  31 +++++++-
 5 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index fe0c88a8fc..48fe3f1b33 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -6,6 +6,7 @@
 [Features]
 Link status          = Y
 Link status event    = Y
+Rx interrupt         = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index f73b5e317d..f37cac87ad 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -42,6 +42,7 @@ extern int rtap_logtype;
 struct rtap_rx_queue {
 	struct rte_mempool *mb_pool;	/* rx buffer pool */
 	struct io_uring io_ring;	/* queue of posted read's */
+	int intr_fd;			/* eventfd for Rx interrupt */
 	uint16_t port_id;
 	uint16_t queue_id;
 
@@ -64,6 +65,7 @@ struct rtap_tx_queue {
 struct rtap_pmd {
 	int keep_fd;			/* keep alive file descriptor */
 	struct rte_intr_handle *intr_handle; /* LSC interrupt handle */
+	struct rte_intr_handle *rx_intr_handle; /* Rx queue interrupt handle */
 	char ifname[IFNAMSIZ];		/* name assigned by kernel */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 
@@ -90,5 +92,9 @@ void rtap_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id);
 
 /* rtap_intr.c */
 int rtap_lsc_set(struct rte_eth_dev *dev, int set);
+int rtap_rx_intr_vec_install(struct rte_eth_dev *dev);
+void rtap_rx_intr_vec_uninstall(struct rte_eth_dev *dev);
+int rtap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+int rtap_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 9b8ad1f452..8a9fb5be85 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -293,8 +293,18 @@ rtap_dev_start(struct rte_eth_dev *dev)
 	if (ret != 0)
 		return ret;
 
+	/* Install Rx interrupt vector if requested by application */
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		ret = rtap_rx_intr_vec_install(dev);
+		if (ret != 0) {
+			rtap_lsc_set(dev, 0);
+			return ret;
+		}
+	}
+
 	ret = rtap_set_link_up(dev);
 	if (ret != 0) {
+		rtap_rx_intr_vec_uninstall(dev);
 		rtap_lsc_set(dev, 0);
 		return ret;
 	}
@@ -315,6 +325,7 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_rx_intr_vec_uninstall(dev);
 	rtap_lsc_set(dev, 0);
 	rtap_set_link_down(dev);
 
@@ -527,6 +538,9 @@ rtap_dev_close(struct rte_eth_dev *dev)
 			pmd->keep_fd = -1;
 		}
 
+		rte_intr_instance_free(pmd->rx_intr_handle);
+		pmd->rx_intr_handle = NULL;
+
 		rte_intr_instance_free(pmd->intr_handle);
 		pmd->intr_handle = NULL;
 	}
@@ -597,6 +611,8 @@ static const struct eth_dev_ops rtap_ops = {
 	.rx_queue_release	= rtap_rx_queue_release,
 	.tx_queue_setup		= rtap_tx_queue_setup,
 	.tx_queue_release	= rtap_tx_queue_release,
+	.rx_queue_intr_enable	= rtap_rx_queue_intr_enable,
+	.rx_queue_intr_disable	= rtap_rx_queue_intr_disable,
 };
 
 static int
diff --git a/drivers/net/rtap/rtap_intr.c b/drivers/net/rtap/rtap_intr.c
index 8a27b811e1..231666efae 100644
--- a/drivers/net/rtap/rtap_intr.c
+++ b/drivers/net/rtap/rtap_intr.c
@@ -145,3 +145,123 @@ rtap_lsc_set(struct rte_eth_dev *dev, int set)
 
 	return 0;
 }
+
+/*
+ * Install per-queue Rx interrupt vector.
+ *
+ * Each Rx queue has an eventfd registered with its io_uring instance.
+ * When a CQE is posted (packet received), the kernel signals the eventfd.
+ * This function wires those eventfds into an rte_intr_handle so that
+ * DPDK's interrupt framework (rte_epoll_wait) can poll them.
+ *
+ * Only called when dev_conf.intr_conf.rxq is set.
+ */
+int
+rtap_rx_intr_vec_install(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	uint16_t nb_rx = dev->data->nb_rx_queues;
+
+	if (pmd->rx_intr_handle != NULL) {
+		PMD_LOG(DEBUG, "Rx interrupt vector already installed");
+		return 0;
+	}
+
+	pmd->rx_intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (pmd->rx_intr_handle == NULL) {
+		PMD_LOG(ERR, "Failed to allocate Rx intr handle");
+		return -ENOMEM;
+	}
+
+	if (rte_intr_type_set(pmd->rx_intr_handle, RTE_INTR_HANDLE_VDEV) < 0)
+		goto error;
+
+	if (rte_intr_nb_efd_set(pmd->rx_intr_handle, nb_rx) < 0)
+		goto error;
+
+	if (rte_intr_max_intr_set(pmd->rx_intr_handle, nb_rx + 1) < 0)
+		goto error;
+
+	for (uint16_t i = 0; i < nb_rx; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq == NULL || rxq->intr_fd < 0) {
+			PMD_LOG(ERR, "Rx queue %u not ready for interrupts", i);
+			goto error;
+		}
+
+		if (rte_intr_efds_index_set(pmd->rx_intr_handle, i,
+					    rxq->intr_fd) < 0) {
+			PMD_LOG(ERR, "Failed to set efd for queue %u", i);
+			goto error;
+		}
+	}
+
+	dev->intr_handle = pmd->rx_intr_handle;
+	PMD_LOG(DEBUG, "Rx interrupt vector installed for %u queues", nb_rx);
+	return 0;
+
+error:
+	rte_intr_instance_free(pmd->rx_intr_handle);
+	pmd->rx_intr_handle = NULL;
+	return -1;
+}
+
+/*
+ * Remove per-queue Rx interrupt vector.
+ * Restores dev->intr_handle to the LSC handle.
+ */
+void
+rtap_rx_intr_vec_uninstall(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	if (pmd->rx_intr_handle == NULL)
+		return;
+
+	/* Restore LSC handle as device interrupt handle */
+	dev->intr_handle = pmd->intr_handle;
+
+	rte_intr_instance_free(pmd->rx_intr_handle);
+	pmd->rx_intr_handle = NULL;
+
+	PMD_LOG(DEBUG, "Rx interrupt vector uninstalled");
+}
+
+/*
+ * Enable Rx interrupt for a queue.
+ *
+ * Drain any pending eventfd notification so the next CQE
+ * triggers a fresh wakeup in rte_epoll_wait().
+ */
+int
+rtap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rtap_rx_queue *rxq = dev->data->rx_queues[queue_id];
+	uint64_t val;
+
+	if (rxq == NULL || rxq->intr_fd < 0)
+		return -EINVAL;
+
+	/* Drain the eventfd counter to re-arm notification */
+	if (read(rxq->intr_fd, &val, sizeof(val)) < 0 && errno != EAGAIN) {
+		PMD_LOG(ERR, "eventfd drain failed queue %u: %s",
+			queue_id, strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+}
+
+/*
+ * Disable Rx interrupt for a queue.
+ *
+ * Nothing to do - the eventfd stays registered with io_uring
+ * but the application simply stops polling it.
+ */
+int
+rtap_rx_queue_intr_disable(struct rte_eth_dev *dev __rte_unused,
+			   uint16_t queue_id __rte_unused)
+{
+	return 0;
+}
diff --git a/drivers/net/rtap/rtap_rxtx.c b/drivers/net/rtap/rtap_rxtx.c
index c972ab4ca0..87d181eded 100644
--- a/drivers/net/rtap/rtap_rxtx.c
+++ b/drivers/net/rtap/rtap_rxtx.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/eventfd.h>
 #include <liburing.h>
 #include <sys/uio.h>
 #include <linux/virtio_net.h>
@@ -369,6 +370,7 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 	rxq->mb_pool = mb_pool;
 	rxq->port_id = dev->data->port_id;
 	rxq->queue_id = queue_id;
+	rxq->intr_fd = -1;
 	dev->data->rx_queues[queue_id] = rxq;
 
 	if (io_uring_queue_init(nb_rx_desc, &rxq->io_ring, 0) != 0) {
@@ -376,10 +378,26 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 		goto error_rxq_free;
 	}
 
+	/*
+	 * Create an eventfd for Rx interrupt notification.
+	 * io_uring will signal this fd whenever a CQE is posted,
+	 * enabling power-aware applications to sleep until packets arrive.
+	 */
+	rxq->intr_fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (rxq->intr_fd < 0) {
+		PMD_LOG(ERR, "eventfd failed: %s", strerror(errno));
+		goto error_iouring_exit;
+	}
+
+	if (io_uring_register_eventfd(&rxq->io_ring, rxq->intr_fd) < 0) {
+		PMD_LOG(ERR, "io_uring_register_eventfd failed: %s", strerror(errno));
+		goto error_eventfd_close;
+	}
+
 	mbufs = calloc(nb_rx_desc, sizeof(struct rte_mbuf *));
 	if (mbufs == NULL) {
 		PMD_LOG(ERR, "Rx mbuf pointer alloc failed");
-		goto error_iouring_exit;
+		goto error_eventfd_close;
 	}
 
 	/* open shared tap fd maybe already setup */
@@ -429,6 +447,11 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 	}
 	rtap_queue_close(dev, queue_id);
 	free(mbufs);
+error_eventfd_close:
+	if (rxq->intr_fd >= 0) {
+		close(rxq->intr_fd);
+		rxq->intr_fd = -1;
+	}
 error_iouring_exit:
 	io_uring_queue_exit(&rxq->io_ring);
 error_rxq_free:
@@ -503,6 +526,12 @@ rtap_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (rxq == NULL)
 		return;
 
+	if (rxq->intr_fd >= 0) {
+		io_uring_unregister_eventfd(&rxq->io_ring);
+		close(rxq->intr_fd);
+		rxq->intr_fd = -1;
+	}
+
 	rtap_cancel_all(&rxq->io_ring);
 	io_uring_queue_exit(&rxq->io_ring);
 
-- 
2.51.0

