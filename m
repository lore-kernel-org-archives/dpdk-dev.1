Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D3E7E0DA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A58640A6D;
	Mon,  9 Feb 2026 19:41:02 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id C8E964069D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:41:00 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso2236524f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662460;
 x=1771267260; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgRqo/ZkFTXf2hRup5a7MpGT5cyvJEqVvQgIA7DwgH4=;
 b=tDMnuwP+t2rx6QCEjtKA5PKOuvfYZv0+qFIfaA/OrunzjcQcNWAUr6LvF4q2cteGQt
 jvtN7VqwYJ10dYqXzb5RPRao2a0nZQNG91Js9KafF7n12WmWSq/n6aHMEQoNkOBT4j7J
 uQjCMvOy3P3zfElu6mu2GOC+9UdPtIV89lw4RJnGuUgZz/iQ49dZtIpNUfAUS5O7UI1c
 xnbEXXCj/ek2ufNFe5oT7X6uQ2P+4WmOKGYwLAOZVx/pSNPEbVNByEgX2h8Ac0rMkxoL
 j3arkNjYoqEs0UJ3wb6RNNdbx+UVrC73KTicOsSg8fTlGI2Dr1SnSFAC2qnqz9L8230M
 GMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662460; x=1771267260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgRqo/ZkFTXf2hRup5a7MpGT5cyvJEqVvQgIA7DwgH4=;
 b=M55ZrmQgAweoN+rsv2836TmaEpddA72tYvxKILaj30x/fm+X3xoz4MODk+hbzW/gvS
 LwBWETNJeY2KpoN1VHDQ53SYn0vOIwtrug8WVyoOF/I/m9lysXMQgpnlFqwdOLPfPa/A
 c1Xo03Gwcgb33gSmHo7RJNR27bAxOfy3ONBZDGc1IVd91oCKAV5Pc8N8u7zDU19RwrQP
 qRYCUxPhXpAyc0QF13JiKyACxIdcZD1l8yCDLCQVrRcBSUeXYllsc9Pj5yUy2ArJrB76
 eYLtlLdYmZI3ySf+Fi5+FTIhvz0z2pmfZ4P4URHH5qT7lJRE8rOYLsWZGP8wZQxOSk4j
 M5OQ==
X-Gm-Message-State: AOJu0YxTfq2Hn1Foc6iQDitRMGtcPnXKuHnHZpg1rKFBKBe8bg+GDHta
 XYNE96xcdaykg66UeXr3U9sOi83fsp97Duz4uLiwjdsJkzfJ4s7/KJPijk+7OzeXk5A4HNMiJwg
 WcIVk
X-Gm-Gg: AZuq6aL9QlQXN14bx5vtw16qoD8Ax3AGJGGuwlPQc1V9/p80uFdMivhNY757z87pbf+
 JULv0dA+wl52ZHMhKXcQw3rXnTL2UlV+W3gGphgnrzc1s/cP+9qznL7+GVvoBT3j6d1iaBh6JPv
 HEW1DWDOk3HfMgXJqEz5FvN302eKeVC6ZuOEulHlumY/JXflkIzaM4sA26ITMWgveJg5O7WhGTO
 4KcKq4zfho6f9nSvyn0IjXoHVddEf9dDgNbxUAsUkiLJXML97CKUeGdg9E1N6G9dMmqtPxWyvhq
 qoj2npDK2GXHDP2umClvRBv57f2pd8OuIBEtsiQ2e7TJmsWAwH40L/LZov+n4KrtnMZSeL3V5Ni
 6qYz4W+xtO0bXXGw0+RQ4UBpavTwQ8y3nQnUxnnu5rsQqmnFq7TrCb3SqvpEr387ZHSi7xs8vej
 g9l6zLCJdrWXTDnJBarLJBsb5wtdK8FCkFRREoU6klLi5PP5Auug==
X-Received: by 2002:a05:6000:26c4:b0:435:8f1b:bb32 with SMTP id
 ffacd0b85a97d-436293888d9mr18824394f8f.32.1770662460346; 
 Mon, 09 Feb 2026 10:41:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 06/10] net/rtap: add checksum and TSO offload support
Date: Mon,  9 Feb 2026 10:39:05 -0800
Message-ID: <20260209184045.132774-7-stephen@networkplumber.org>
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

Add transmit and receive offload support using the virtio-net header
that is exchanged with the kernel TAP device.

Tx offloads:
  - UDP and TCP checksum offload: set VIRTIO_NET_HDR_F_NEEDS_CSUM
    with appropriate csum_start and csum_offset fields
  - TCP segmentation offload (TSO): set gso_type and gso_size

Rx offloads:
  - Parse virtio-net header flags to determine checksum status
  - Handle NEEDS_CSUM by either marking L4_CKSUM_NONE for known
    protocols or computing the checksum in software for tunnels
  - Handle DATA_VALID flag to mark L4_CKSUM_GOOD
  - Parse GSO headers to populate LRO metadata

Configure kernel-side offloads via TUNSETOFFLOAD in dev_configure
based on the requested rx offload flags.

Report offload capabilities in dev_info.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |  2 ++
 drivers/net/rtap/rtap_ethdev.c    | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index ce0804d795..b8eaa805fe 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -11,6 +11,8 @@ Allmulticast mode    = Y
 Scattered Rx         = P
 Basic stats          = Y
 Stats per queue      = Y
+TSO                  = Y
+L4 checksum offload  = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 591fe91eac..277a280772 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -31,6 +31,16 @@
 
 #define RTAP_DEFAULT_IFNAME	"rtap%d"
 
+#define RTAP_TX_OFFLOAD		(RTE_ETH_TX_OFFLOAD_MULTI_SEGS | \
+				 RTE_ETH_TX_OFFLOAD_UDP_CKSUM | \
+				 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
+				 RTE_ETH_TX_OFFLOAD_TCP_TSO)
+
+#define RTAP_RX_OFFLOAD		(RTE_ETH_RX_OFFLOAD_UDP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_TCP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_TCP_LRO | \
+				 RTE_ETH_RX_OFFLOAD_SCATTER)
+
 #define RTAP_DEFAULT_BURST	64
 #define RTAP_NUM_BUFFERS	1024
 #define RTAP_MAX_QUEUES		128
@@ -317,7 +327,21 @@ rtap_dev_configure(struct rte_eth_dev *dev)
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues)
 		return -EINVAL;
 
-	if (ioctl(pmd->keep_fd, TUNSETOFFLOAD, 0) != 0) {
+	/*
+	 * Set offload flags visible on the kernel network interface.
+	 * This controls whether kernel will use checksum offload etc.
+	 * Note: kernel transmit is DPDK receive.
+	 */
+	const struct rte_eth_rxmode *rx_mode = &dev->data->dev_conf.rxmode;
+	unsigned int offload = 0;
+	if (rx_mode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM) {
+		offload |= TUN_F_CSUM;
+
+		if (rx_mode->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)
+			offload |= TUN_F_TSO4 | TUN_F_TSO6 | TUN_F_TSO_ECN;
+	}
+
+	if (ioctl(pmd->keep_fd, TUNSETOFFLOAD, offload) != 0) {
 		PMD_LOG(ERR, "ioctl(TUNSETOFFLOAD) failed: %s", strerror(errno));
 		return -1;
 	}
@@ -336,6 +360,10 @@ rtap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_rx_bufsize = RTAP_MIN_RX_BUFSIZE;
 	dev_info->max_rx_queues = RTAP_MAX_QUEUES;
 	dev_info->max_tx_queues = RTAP_MAX_QUEUES;
+	dev_info->rx_queue_offload_capa = RTAP_RX_OFFLOAD;
+	dev_info->rx_offload_capa = dev_info->rx_queue_offload_capa;
+	dev_info->tx_queue_offload_capa = RTAP_TX_OFFLOAD;
+	dev_info->tx_offload_capa = dev_info->tx_queue_offload_capa;
 
 	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
 		.burst_size = RTAP_DEFAULT_BURST,
-- 
2.51.0

