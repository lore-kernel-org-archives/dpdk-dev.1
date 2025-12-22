Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9FE66886
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 00:45:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 642AB40265;
	Mon, 22 Dec 2025 01:44:59 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 4682C40264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 01:44:56 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so20800965e9.3
 for <dev@dpdk.org>; Sun, 21 Dec 2025 16:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766364296;
 x=1766969096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fwhRDLM/oJzcnbWlhzj6forE51yyvRCYlaBBojXCsRA=;
 b=bigtkhsG73cp2zf70e/eCKJHjHRhqNEAAsEEv87knpXFmnXDDGRbcaBzpsgg3wthyo
 TXu9NKZEB5jdOKeO9kc0SGfa8HckJrsg64dIvhwIYTl/WJyzYsitxrQs1JGx7XOdFxnJ
 0/vy8wRJYPXuhqVmhkQNE7BcWD07TmPy2UbbSOgBTfowDPe16l1ST2D2avG3FRfDyZ1y
 yHuF0Tu2+nuZzxk6cDiiGQxNx9AassgcCE3l0KXuU+u9+F6GHJXLQ05np3g0UUq56dnu
 +5/xf66HFifopCQ4muWXxqx1FmUg4YwKDMThoYfCk7hIEHqJ6kR/vs2JVOtakRoDTwvy
 eLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766364296; x=1766969096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwhRDLM/oJzcnbWlhzj6forE51yyvRCYlaBBojXCsRA=;
 b=Afuq1hV6QqtoLRo4ymoEsC3uriRuZOPrjIvJTnZed26e+eSblysuZnyIlAvKx/WCjE
 17hrmPMmobn7KPcT5GqxBbARnFe8DrPyrdF+OohrOXCnJVAgyn21yPhQqOGg4nRKsawx
 nqOOg8yvD9Q8yDyrkXvtZmiKqWolWFrnjcDy5gjWB+S1Rq1NR1nXhej5R3YimTJklLfj
 jNLqi8lXE+v54uoh5h5qLV7PnQWoWLNQq7A7Pke4LoJHh7pPL3UNIZ/VmMo2RQahUlwA
 3nadKXfSzTWnY4EjxU7ScXWOtrAQKj4LFo0QKpMXM+NLgbKcdWOimM/oLhBiRzu48Hm0
 cGNg==
X-Gm-Message-State: AOJu0YxBLT/xc+s0/NTNo3yHbsG6EdJ6bk9ua87XJbQGg18fw1qVfYPQ
 aMK6WVafobNFpSOdK3oAtNW2tufGcvddsqNdxvRH0ms57Hw1/MWi2pqZiENCpCOQpVw3LI8jbWI
 xa52kF/o=
X-Gm-Gg: AY/fxX7YX3TtyvPYlA1+emWrAmxs9XmMIFjaUkvQ8llBFYUeVkDm4JvSSPZW/Wb2B6l
 mpOojSDBUVs+ilfyzLuL950P7QJ3kDmDmWPvlqLPMnjB+L0lcnGl91I1t6pjm00eZJuXmbxe94f
 dO4rZBMcERBPY94iC4/SY5S/Nt0dmxoyrZjK/3+fnh0Oe3NBUQUeUA+9edls/2Y+mZIsBhqFNAM
 mLqe5uG+3jxS2ZojAPuuh+a5PmetqmrUZKd9hbN78yZXTitG8IeMyYY8uT837dP2h/J7kbunV+Y
 mDdcG8zOw1wteVE9i++56ktvvBe/ch1NOCieuzWqaenVAircstcSyrWHVxGYLuSKLC66v3ZX2G/
 XRRwc43/5DvL8tgM0QTOZ9J9078lR2gfKea4nExrKJ/ldjfijmf/0cv8rJ4143Mi1LCpjBEghs2
 uzd75woBeUJYaSIwWP3KAsIcqQZ6zSW/JTh+TEFypsQodux7PV8A==
X-Google-Smtp-Source: AGHT+IE8xtlB9wQd8GjiQVXdpj2qqk3RDeLdw0V/B+TVH0QBlesLbuqRKedy3TAxzOR/g5f86CCPHw==
X-Received: by 2002:a05:600c:4f15:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-47d19538dfbmr108297355e9.1.1766364295690; 
 Sun, 21 Dec 2025 16:44:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be396c909sm83787985e9.0.2025.12.21.16.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 16:44:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC] net/virtio: avoid global variable name conflicts
Date: Sun, 21 Dec 2025 16:44:46 -0800
Message-ID: <20251222004446.62076-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

If PMD is statically linked, all global variables are visible and
can clash with application or other drivers and therefore should
have a consistent prefix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_pci.c                   |  8 ++++----
 drivers/net/virtio/virtio_pci.h                   |  4 ++--
 drivers/net/virtio/virtio_pci_ethdev.c            |  4 ++--
 drivers/net/virtio/virtio_user/vhost_kernel.c     | 14 +++++++-------
 drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 10 +++++-----
 drivers/net/virtio/virtio_user/vhost_kernel_tap.h | 10 +++++-----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio/virtio_pci.c b/drivers/net/virtio/virtio_pci.c
index 90bbb53502..44e4400af7 100644
--- a/drivers/net/virtio/virtio_pci.c
+++ b/drivers/net/virtio/virtio_pci.c
@@ -269,7 +269,7 @@ legacy_dev_close(struct virtio_hw *hw)
 	return 0;
 }
 
-const struct virtio_ops legacy_ops = {
+const struct virtio_ops virtio_legacy_ops = {
 	.read_dev_cfg	= legacy_read_dev_config,
 	.write_dev_cfg	= legacy_write_dev_config,
 	.get_status	= legacy_get_status,
@@ -524,7 +524,7 @@ modern_dev_close(struct virtio_hw *hw)
 	return 0;
 }
 
-const struct virtio_ops modern_ops = {
+const struct virtio_ops virtio_modern_ops = {
 	.read_dev_cfg	= modern_read_dev_config,
 	.write_dev_cfg	= modern_write_dev_config,
 	.get_status	= modern_get_status,
@@ -669,7 +669,7 @@ vtpci_init(struct rte_pci_device *pci_dev, struct virtio_pci_dev *dev)
 	 */
 	if (virtio_read_caps(pci_dev, hw) == 0) {
 		PMD_INIT_LOG(INFO, "modern virtio pci detected.");
-		VIRTIO_OPS(hw) = &modern_ops;
+		VIRTIO_OPS(hw) = &virtio_modern_ops;
 		dev->modern = true;
 		goto msix_detect;
 	}
@@ -688,7 +688,7 @@ vtpci_init(struct rte_pci_device *pci_dev, struct virtio_pci_dev *dev)
 		return -1;
 	}
 
-	VIRTIO_OPS(hw) = &legacy_ops;
+	VIRTIO_OPS(hw) = &virtio_legacy_ops;
 	dev->modern = false;
 
 msix_detect:
diff --git a/drivers/net/virtio/virtio_pci.h b/drivers/net/virtio/virtio_pci.h
index 6d4a8712c2..93a5347608 100644
--- a/drivers/net/virtio/virtio_pci.h
+++ b/drivers/net/virtio/virtio_pci.h
@@ -139,7 +139,7 @@ int vtpci_init(struct rte_pci_device *pci_dev, struct virtio_pci_dev *dev);
 void vtpci_legacy_ioport_unmap(struct virtio_hw *hw);
 int vtpci_legacy_ioport_map(struct virtio_hw *hw);
 
-extern const struct virtio_ops legacy_ops;
-extern const struct virtio_ops modern_ops;
+extern const struct virtio_ops virtio_legacy_ops;
+extern const struct virtio_ops virtio_modern_ops;
 
 #endif /* _VIRTIO_PCI_H_ */
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index daf513d04d..fcda002297 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -87,9 +87,9 @@ eth_virtio_pci_init(struct rte_eth_dev *eth_dev)
 	} else {
 		VTPCI_DEV(hw) = pci_dev;
 		if (dev->modern)
-			VIRTIO_OPS(hw) = &modern_ops;
+			VIRTIO_OPS(hw) = &virtio_modern_ops;
 		else
-			VIRTIO_OPS(hw) = &legacy_ops;
+			VIRTIO_OPS(hw) = &virtio_legacy_ops;
 
 		ret = virtio_remap_pci(RTE_ETH_DEV_TO_PCI(eth_dev), dev);
 		if (ret < 0) {
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/net/virtio/virtio_user/vhost_kernel.c
index e42bb35935..7914b517cd 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
@@ -131,7 +131,7 @@ vhost_kernel_get_features(struct virtio_user_dev *dev, uint64_t *features)
 		return -1;
 	}
 
-	ret = tap_get_flags(data->tapfds[0], &tap_flags);
+	ret = vhost_tap_get_flags(data->tapfds[0], &tap_flags);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Failed to get TAP features");
 		return -1;
@@ -389,7 +389,7 @@ vhost_kernel_setup(struct virtio_user_dev *dev)
 	uint32_t q, i;
 	int vhostfd;
 
-	if (tap_support_features(&tap_features) < 0)
+	if (vhost_tap_support_features(&tap_features) < 0)
 		return -1;
 
 	if ((tap_features & IFF_VNET_HDR) == 0) {
@@ -435,14 +435,14 @@ vhost_kernel_setup(struct virtio_user_dev *dev)
 	}
 
 	ifname = dev->ifname != NULL ? dev->ifname : "tap%d";
-	data->tapfds[0] = tap_open(ifname, r_flags, (tap_features & IFF_MULTI_QUEUE) != 0);
+	data->tapfds[0] = vhost_tap_open(ifname, r_flags, (tap_features & IFF_MULTI_QUEUE) != 0);
 	if (data->tapfds[0] < 0)
 		goto err_tapfds;
-	if (dev->ifname == NULL && tap_get_name(data->tapfds[0], &dev->ifname) < 0) {
+	if (dev->ifname == NULL && vhost_tap_get_name(data->tapfds[0], &dev->ifname) < 0) {
 		PMD_DRV_LOG(ERR, "fail to get tap name (%d)", data->tapfds[0]);
 		goto err_tapfds;
 	}
-	if (tap_get_flags(data->tapfds[0], &tap_flags) < 0) {
+	if (vhost_tap_get_flags(data->tapfds[0], &tap_flags) < 0) {
 		PMD_DRV_LOG(ERR, "fail to get tap flags for tap %s", dev->ifname);
 		goto err_tapfds;
 	}
@@ -452,7 +452,7 @@ vhost_kernel_setup(struct virtio_user_dev *dev)
 	}
 
 	for (i = 1; i < dev->max_queue_pairs; i++) {
-		data->tapfds[i] = tap_open(dev->ifname, r_flags, true);
+		data->tapfds[i] = vhost_tap_open(dev->ifname, r_flags, true);
 		if (data->tapfds[i] < 0)
 			goto err_tapfds;
 	}
@@ -558,7 +558,7 @@ vhost_kernel_enable_queue_pair(struct virtio_user_dev *dev,
 
 	/* Set mac on tap only once when starting */
 	if (!dev->started && pair_idx == 0 &&
-			tap_set_mac(data->tapfds[pair_idx], dev->mac_addr) < 0)
+	    vhost_tap_set_mac(data->tapfds[pair_idx], dev->mac_addr) < 0)
 		return -1;
 
 	if (vhost_kernel_tap_setup(tapfd, hdr_size, dev->features) < 0) {
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
index 611e2e25ec..2431d00c33 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
@@ -20,7 +20,7 @@
 
 
 int
-tap_support_features(unsigned int *tap_features)
+vhost_tap_support_features(unsigned int *tap_features)
 {
 	int tapfd;
 
@@ -42,7 +42,7 @@ tap_support_features(unsigned int *tap_features)
 }
 
 int
-tap_open(const char *ifname, unsigned int r_flags, bool multi_queue)
+vhost_tap_open(const char *ifname, unsigned int r_flags, bool multi_queue)
 {
 	struct ifreq ifr;
 	int tapfd;
@@ -81,7 +81,7 @@ tap_open(const char *ifname, unsigned int r_flags, bool multi_queue)
 }
 
 int
-tap_get_name(int tapfd, char **name)
+vhost_tap_get_name(int tapfd, char **name)
 {
 	struct ifreq ifr;
 	int ret;
@@ -98,7 +98,7 @@ tap_get_name(int tapfd, char **name)
 }
 
 int
-tap_get_flags(int tapfd, unsigned int *tap_flags)
+vhost_tap_get_flags(int tapfd, unsigned int *tap_flags)
 {
 	struct ifreq ifr;
 
@@ -112,7 +112,7 @@ tap_get_flags(int tapfd, unsigned int *tap_flags)
 }
 
 int
-tap_set_mac(int tapfd, uint8_t *mac)
+vhost_tap_set_mac(int tapfd, uint8_t *mac)
 {
 	struct ifreq ifr;
 
diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
index 636a0481be..1e026d7488 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.h
@@ -36,10 +36,10 @@
 
 int vhost_kernel_tap_setup(int tapfd, int hdr_size, uint64_t features);
 
-int tap_support_features(unsigned int *tap_features);
-int tap_open(const char *ifname, unsigned int r_flags, bool multi_queue);
-int tap_get_name(int tapfd, char **ifname);
-int tap_get_flags(int tapfd, unsigned int *tap_flags);
-int tap_set_mac(int tapfd, uint8_t *mac);
+int vhost_tap_support_features(unsigned int *tap_features);
+int vhost_tap_open(const char *ifname, unsigned int r_flags, bool multi_queue);
+int vhost_tap_get_name(int tapfd, char **ifname);
+int vhost_tap_get_flags(int tapfd, unsigned int *tap_flags);
+int vhost_tap_set_mac(int tapfd, uint8_t *mac);
 
 #endif
-- 
2.51.0

