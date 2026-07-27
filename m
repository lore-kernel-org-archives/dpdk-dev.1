Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCFC531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0629640647;
	Mon, 27 Jul 2026 15:54:27 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 27498400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:54:25 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8f29ec73064so20563396d6.1
 for <dev@dpdk.org>; Mon, 27 Jul 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160464; x=1785765264; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+xodLBeN2dxTcpWYqluLbqrMG1OM+08tn7Kth+0Pb0=;
 b=dZHwcQ8UkPW+A38MIO+B+bhSSQTmrgiObbtpDjAkxlgJG0PVkevXz52cEx+9SXZSna
 HQdMB7g2GAqOOHqcylZRBgLoMKUiIE1o3XWt+A+mcpUpCV/GUpd+plkZea90Z/+Vjlp3
 R+5G5AyU3ormhr6GSOTjoQUp8CgkqE+7/EtOm0GbV80tp9h63dpxWWZim251eOQRevrs
 rEKLmjwTB2rBS9Lbb9uWqRg6Bahfm/shoitN47wg6pB0Nf2WHA5d4fgzo/8oMt5kq5yO
 7rYzHr7OJWxl8YlQ4+qm1VBlebtv+m2eH3+17WA5wrDQKUK9BoMCXxa1mUtApYuBA3o7
 pGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160464; x=1785765264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S+xodLBeN2dxTcpWYqluLbqrMG1OM+08tn7Kth+0Pb0=;
 b=Ju6MSd7H2yHGPInFQrKLNsRIfXHHD7kk7SN4p54iHEzdJ8ogRj+nUSr+O0SQCgEv53
 qH3uwWh/ZkWKb9wi6fRv1yl6aZqERZDe/rD0OOG4n//e26SJ1SqPfEF8MvZWvZbOX92N
 gLYRkK4rmQE6nYBDGpu14TFbXIyjurKId7YJV+qKkp5etzVTJhtVNw239CUuOzqs/9qy
 gpGdrcdcBrN9smM81F0ssXQqunY+TmUfqoY31hz6bX/nh9RKZTC+qXKaL3v8Rc51601V
 YkLRoA91CnnmAJEVbNgYQMq4XjmCPokFYH5JIHTvWQoblVzZfnKYATEkvNo6AxnrjeKf
 C+GA==
X-Gm-Message-State: AOJu0YwtmcLlv06imG0A+5OVCIfpvwkU4namlkVcE/9LWmDNTBaZsemp
 nwJ5T5SY6wnqkAcpSlLkmpmxQxFvIBhdNzSdIUmJNIq3yJCEx+IW7gBx
X-Gm-Gg: AR+sD12ZKMl6R69120XtGg+Q7gbwn92R6zVRn4q22oax6i+zWLW57t/N6LDc7K7Pg2P
 5wVEIQO4q+L4yqayhnVIDNEUpZop1XiGAXk/q4U5H/27GZRKFD6S0+c3WjNBryUD0iuX9Tp+oIv
 fzxaNiTxtvtFy6RnmA+lIcbsbm6a2BtVa9dlAaiTdv7KsmgXvHwnwIkhJUNoSIQ9rQ3vCu5avno
 Z7uCnEnDPnVq2090JDyJyneOWiomq/I7LnwTlyP56WxiibMeNW9pwNlNc7NdCAZ2YgIzt5kTSd8
 bFEPQbxE4vfEiHHDGaYQOjiVUrWYuYZAJvM4CsEJSawJ9BnUgniWMXkpn5E8r1MhyoBASVeUDyF
 TRSFyB/oBjfHrTMqkGgPJEBWbPTFYyj9S5ypsgYWOF33o1c84r7XRv/cqETI8PdYiIsBDUg8Wu5
 Ji+sUCZQAJhyqy2jPndZwVt3Mzo9DxQ5I=
X-Received: by 2002:a05:620a:2945:b0:930:a631:68bf with SMTP id
 af79cd13be357-932df5f0f46mr872759185a.22.1785160464128; 
 Mon, 27 Jul 2026 06:54:24 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de675d99sm615665885a.45.2026.07.27.06.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:54:23 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, ferruh.yigit@amd.com, Maxime Leroy <maxime@leroys.fr>,
 stable@dpdk.org
Subject: [PATCH v3 2/4] net/tap: support Rx queue interrupt enable/disable
Date: Mon, 27 Jul 2026 15:54:08 +0200
Message-ID: <20260727135411.2590931-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727135411.2590931-1-maxime@leroys.fr>
References: <20260727135411.2590931-1-maxime@leroys.fr>
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

The driver registers each queue file descriptor for Rx interrupts but
never provided the rx_queue_intr_enable/disable ops, so
rte_eth_dev_rx_intr_enable() returned -ENOTSUP. Applications that arm
queues before sleeping (l3fwd-power and similar) treat that as "no
interrupt support" and fall back to polling, even though the epoll wait
on the queue fd works. The advertised Rx interrupt feature is therefore
unusable through the generic API.

The queue fd is kept readable by the kernel whenever data is available
and is drained by the Rx burst itself, so there is no interrupt source to
arm or mask. Record whether the port was configured for Rx interrupts and
implement both ops to succeed in that mode and return -ENOTSUP otherwise,
so the generic Rx interrupt API works and applications can block on the
queue fd.

Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.c |  5 ++++
 drivers/net/tap/rte_eth_tap.h |  4 ++++
 drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index eec18a7c97..770d75f0c7 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -935,6 +935,7 @@ static int
 tap_dev_configure(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
+	bool intr_mode = dev->data->dev_conf.intr_conf.rxq;
 
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
 		TAP_LOG(ERR,
@@ -945,6 +946,8 @@ tap_dev_configure(struct rte_eth_dev *dev)
 		return -1;
 	}
 
+	pmd->intr_mode = intr_mode;
+
 	TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
 		dev->device->name, pmd->name, dev->data->nb_tx_queues);
 
@@ -2098,6 +2101,8 @@ static const struct eth_dev_ops ops = {
 	.tx_queue_stop          = tap_tx_queue_stop,
 	.rx_queue_release       = tap_rx_queue_release,
 	.tx_queue_release       = tap_tx_queue_release,
+	.rx_queue_intr_enable   = tap_rx_queue_intr_enable,
+	.rx_queue_intr_disable  = tap_rx_queue_intr_disable,
 	.flow_ctrl_get          = tap_flow_ctrl_get,
 	.flow_ctrl_set          = tap_flow_ctrl_set,
 	.link_update            = tap_link_update,
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index f53a5ad077..df9a8f8a7a 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -11,6 +11,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <net/if.h>
+#include <stdbool.h>
 
 #include <linux/if_tun.h>
 
@@ -93,6 +94,7 @@ struct pmd_internals {
 
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
+	bool intr_mode;                   /* Rx queue interrupt mode */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
 };
@@ -104,5 +106,7 @@ struct pmd_process_private {
 /* tap_intr.c */
 
 int tap_rx_intr_vec_set(struct rte_eth_dev *dev, int set);
+int tap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+int tap_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 
 #endif /* _RTE_ETH_TAP_H_ */
diff --git a/drivers/net/tap/tap_intr.c b/drivers/net/tap/tap_intr.c
index 1908f71f97..7db22b69f5 100644
--- a/drivers/net/tap/tap_intr.c
+++ b/drivers/net/tap/tap_intr.c
@@ -112,3 +112,47 @@ tap_rx_intr_vec_set(struct rte_eth_dev *dev, int set)
 		return tap_rx_intr_vec_install(dev);
 	return 0;
 }
+
+/**
+ * Arm a queue for Rx interrupts.
+ *
+ * @param dev
+ *   Pointer to the tap rte_eth_dev device structure.
+ * @param queue_id
+ *   Rx queue index.
+ *
+ * @return
+ *   0 on success, -ENOTSUP if the port was not configured for Rx interrupts.
+ */
+int
+tap_rx_queue_intr_enable(struct rte_eth_dev *dev,
+			 uint16_t queue_id __rte_unused)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (!pmd->intr_mode)
+		return -ENOTSUP;
+	return 0;
+}
+
+/**
+ * Disarm a queue from Rx interrupts.
+ *
+ * @param dev
+ *   Pointer to the tap rte_eth_dev device structure.
+ * @param queue_id
+ *   Rx queue index.
+ *
+ * @return
+ *   0 on success, -ENOTSUP if the port was not configured for Rx interrupts.
+ */
+int
+tap_rx_queue_intr_disable(struct rte_eth_dev *dev,
+			  uint16_t queue_id __rte_unused)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (!pmd->intr_mode)
+		return -ENOTSUP;
+	return 0;
+}
-- 
2.43.0

