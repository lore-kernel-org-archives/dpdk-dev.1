Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E653EF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4320D40663;
	Sun, 15 Feb 2026 00:47:46 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id BF3FE4064E
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:42 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso20938165e9.1
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112862;
 x=1771717662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAKX33glITeQMDz+RxUN/sB5/LJp+z5WBhPsgBCNuHA=;
 b=YnFt4LxNn7ymg0cLb9jNGQ5uYYwe8WipABOFiTsKGeUADgxEa7FXOSmP2yA1VqaOe9
 4X5kU97PIg5CLujqiezwqGajdUwjkRIjEuGDoOFk3Z7OG+6e7NlYu7MG/Uflsw02R4AC
 9Fkr86kTanBFXQZ6pp/utQD2dO4IdzEvWZHs/53ulB0bEpzjOuTRbJ71OCVU3RojMWMP
 FjzdJNH45TZGjCz6djwVFPPWkf4mMfWnuauSuWC1g9Lsl1hcQsIafrsDkr9GNgv8RlZe
 5sOCfynWy/3aZnPbwoZpx/uO/uSxOC47/R9QQps2JgVoBqQBacfoLTm/ebAMIe9VBylg
 TIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112862; x=1771717662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EAKX33glITeQMDz+RxUN/sB5/LJp+z5WBhPsgBCNuHA=;
 b=MssHi4va+TH2g/13xvnWf0DJnfi2hEjIBFLo/S/zBSq3JG8KZykcmYS8lkPpNB1IK3
 t9aaUQRtCBYTqQKGDnTLd3i8rEsspueaVvOEg7wNuVYdLOkETLit7Kfs+mrmnUY+a7RS
 E3UowLsOVoA1P7k3NNSZ3mq0k4V4aQRz1lMDMCdGaZe+dzYgMP1znp97TivUwE7pAJWE
 kWEiKIeU4qKC4VqL+dCVY3BZ5kSpzBg1sE4rsyin1lHMO8ZL+eMwhfM8pu1utcoz3BAO
 xMyG5vemC0rFnDW6GSpEOiA+u8XjEe2lRruzUxfqJkkvgYqjft8zc1Y7mv1P+wsqd90w
 l8PQ==
X-Gm-Message-State: AOJu0Yxdfgt4EqF6jEfoPdjsGo0MoKm0WlgimDlFSged1sy1M1IXswGU
 gP/m51vCDylwFKWKhffcSabArklb3TUyE9lLWScghJbzA++AJBubDSunoL7tcAI3I91AHtpxRtC
 silAo
X-Gm-Gg: AZuq6aJGon3fv/UkJclEVbV8/hAXZApz0MWLhZ3KHEjPgiN2pACGNqSuzW3yHPy6k1P
 hubpTFeUVi0WompbWLF1BNxIzaJLdbP7Y/kfhw7P7G8KGy7+DxrWZxAAjWQ2sCR7qFMU4UM8Fcb
 zfIwleN9JHVwun6JVtJJ6tTJuSecpcxBJEg8GlCWaLceXqyl6nWdYJxxs9oUKXKgZWdZewjDxcq
 LXbI+00LHPxmu1Nj2gjo61B12bJmTbgc27tLG85a7/L5mx/2wjetHOri/Sry007Q30FXXtb7eb7
 K5rWXphPWOiWfFW0Z96QN9ZFxtTU2C+fRyJxwaaHquPsiH9tyIS/GKorpQoR/mdCaOzMZs2nvV4
 XJ593O6u1xt7V7NBHF7YayFB41SwJUrTq91fpcnCGEZvE54oFOtcGIUbkoEe5iQTRPiHTKSPO54
 HLBdRT87IlzQiN/xmYHP9bXG3/ppH6DBA3zOO42ZW5WICh1y4UZrTBDPD+yICVHwKYuHQMbzFsV
 Y4=
X-Received: by 2002:a05:600c:3143:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-48373a2384emr109516205e9.16.1771112861987; 
 Sat, 14 Feb 2026 15:47:41 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 06/11] net/rtap: add checksum and TSO offload support
Date: Sat, 14 Feb 2026 15:44:15 -0800
Message-ID: <20260214234726.188947-7-stephen@networkplumber.org>
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

Add transmit and receive offload support using the virtio-net header
that is exchanged with the kernel TAP device.

Tx offloads:
  - UDP and TCP checksum offload: set VIRTIO_NET_HDR_F_NEEDS_CSUM
    with appropriate csum_start and csum_offset fields
  - TCP segmentation offload (TSO): set gso_type and gso_size

Rx offloads:
  - Enable receive offloads based on configuration

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
index b6c6421e3d..c4125e04b3 100644
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
@@ -250,7 +260,21 @@ rtap_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
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
 		int ret = -errno;
 
 		PMD_LOG(ERR, "ioctl(TUNSETOFFLOAD) failed: %s", strerror(errno));
@@ -271,6 +295,10 @@ rtap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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

