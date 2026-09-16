Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E2C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0881042DBD;
	Wed, 16 Sep 2026 15:58:45 +0200 (CEST)
Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com
 [74.125.231.167])
 by mails.dpdk.org (Postfix) with ESMTP id E947440264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:58:43 +0200 (CEST)
Received: by mail-oo2-f39.google.com with SMTP id
 006d021491bc7-6c24d19ebcfso502730eaf.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789567123; x=1790171923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HuIYUmplmDPZqoscO4nHdLSZ69WrYC0GBWVdUYrZESY=;
 b=XU7JX1xwbKaBbVa5Uhd2mLNHBPG6irVv2+bIMUJ+Ys2o8sB6mtgPCMO8sEfrEzHWqu
 l7d977ASpFMUwlNknaEIjyitHH9mewjXoKcLfrqgM8mp7Ro+dKl5jNhFl5IBrxoAA5R8
 AuPwlZB9Ogv5l8STa7OXFyqBl1rR1Wpp4SK+hH9u/sqN5VC6/V2pm0czib729Odw62Wg
 QX164Nw+vrfdaRCbhZuvxFGlcOk479qHBnlV8nOGfvWSVYQ+HGm31RBhiowMUyR2H87S
 bkwPcCGsaIIJO26AZfi9+x78nzABWTYlFFjyLwoMXa7ottP0e+wdKQzGJ8WJwbnZ0XNF
 6zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789567123; x=1790171923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HuIYUmplmDPZqoscO4nHdLSZ69WrYC0GBWVdUYrZESY=;
 b=Q53ASOSFXEK0o11T7eMxu+KgULP5P6KDCpNoLhnwLhKNzgZ5TQrj/c4Yr39zb155nu
 jH5k/L35EBZta3qwUjoCHPpw2Znkdq0AKlX/X69ISSzvzsMG04jG8//AC0MbSZVDhqD4
 f8CQgqCl63NqJ2yqHSWJDLHEtXuVr9cv0BXqLNvJpnEwxIcB9OLiOy0iY9tww06Vo330
 Hr3eUKK3kcSfVmMIu6xXoB7+exa2zozu2PhgMZw4z3Wr7tCJmIm0myutmwg7ez7hebyp
 Oar1sPXJ+eyDedRIxrnMWusIHlhW6gJ9reyXMth4Sf8hec4LCDbHHgKcRcmLRGDQt4b6
 QqtQ==
X-Gm-Message-State: AFuF++lOGBPZrsyFm3ZwsAe71fhtw48B9KWY+JzPQdfuwKJfV6RPWpdK
 zVPrhR96JG99NbYQuv/zSwbYTmsm3rA/EaSeWypfSM+3lU/jL9pi+YmM
X-Gm-Gg: AYBFou2Y8Pvh3swptuRLuc33moyU4RlGSw8jXRykvk6PyHxZ05DOgVLr+X7Ln7JXoMc
 fnqriHrS17mq3pf55sHAlB3BSA7KvoLVVIpex8Yxx4ty7u6g9zHo5NAqkGb5al6L4AvleoEnAtA
 Fh1aqz8A8GsQ8yWMTh11lVlFdjA6B7zSCLRX+PtDz+KePvzwwQLVQZ/q/lTfRr3J6Q5cLagvkZH
 813RoqDI4WzpfUgiPHoM+2XisVJKNi1Jd3/tgdzDV+dYLNHSuOvzLX2W1jr3Ht0jmHWGRcZfcj0
 6EKAVNIf/KJdTxkCN6de5ByXc888xi+cRRczv9553UqZNop2qPlKHqm80MzVMDk4zZQfH+44aCQ
 oAn+B95LwzTBiUbpJQ5azjytesNTQdpPn0hroE/Di5Mp7x8VFWRzUPXbAisiUHr3Ymory6s3waa
 +9MCNBmCmwdYUb1WAPTV3QXnwND7U8x9BZxbIhiQ0lBFRnoJHdfRHQ8oDxWAqjX38yAnGaVdZYi
 2bzqQE=
X-Received: by 2002:a05:6820:c3d2:10b0:6b9:7d9e:5708 with SMTP id
 006d021491bc7-6c7d15cebe7mr4244832eaf.3.1789567122920; 
 Wed, 16 Sep 2026 06:58:42 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80b06687551sm2352865a34.6.2026.09.16.06.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:58:42 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
Date: Wed, 16 Sep 2026 21:58:27 +0800
Message-ID: <20260916135827.116145-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Enabling Flow Director reduces RXPBSIZE to reserve SRAM for the
filter table. Clearing the last FDIR rule set the mode back to
none without restoring that buffer, so the next flow create ran
configure again and subtracted the same amount a second time.

Keep the FDIR mode after rules are removed, and subtract RXPBSIZE
only once until the next hardware reset.

Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
Cc: stable@dpdk.org
Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  7 +++++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 21 ++++++++++++++-------
 drivers/net/intel/ixgbe/ixgbe_flow.c   |  1 -
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index cbb7b4831c..ce5b4c51f5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1372,6 +1372,7 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 	}
 	fdir_info->n_flows = 0;
 	fdir_info->mask_added = FALSE;
+	fdir_info->rx_pb_reduced = false;
 
 	/* drop queue is always fixed */
 	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
@@ -2541,6 +2542,8 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 		IXGBE_DEV_PRIVATE_TO_TM_CONF(dev->data->dev_private);
 	struct ixgbe_macsec_setting *macsec_setting =
 		IXGBE_DEV_PRIVATE_TO_MACSEC_SETTING(dev->data->dev_private);
+	struct ixgbe_hw_fdir_info *info =
+		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 
 	/*
 	 * This function calls into the base driver, which in turn will use
@@ -2628,9 +2631,9 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* Configure DCB hw */
 	ixgbe_configure_dcb(dev);
 
+	/* reset_hw restored RXPBSIZE; FDIR must subtract again */
+	info->rx_pb_reduced = false;
 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
-		struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 		err = ixgbe_fdir_configure(adapter, fdir_conf, &info->mask);
 		if (err)
 			goto error;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index ba826b6d8d..495a6ddd22 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -200,6 +200,7 @@ struct ixgbe_hw_fdir_info {
 	struct rte_hash *hash_handle; /* cuckoo hash handler */
 	uint32_t n_flows;
 	bool mask_added; /* If already got mask from consistent filter */
+	bool rx_pb_reduced; /* RXPBSIZE already reduced for FDIR */
 };
 
 struct ixgbe_rte_flow_rss_conf {
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc54287..ca96ea85d7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -560,8 +560,10 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *fdir_mask)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct ixgbe_hw_fdir_info *info =
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
 	int err;
-	uint32_t fdirctrl, pbsize;
+	uint32_t fdirctrl;
 	int i;
 	enum rte_fdir_mode mode = fdir_conf->mode;
 
@@ -591,11 +593,18 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
 	/*
 	 * Before enabling Flow Director, the Rx Packet Buffer size
 	 * must be reduced.  The new value is the current size minus
-	 * flow director memory usage size.
+	 * flow director memory usage size.  Do this only once; a later
+	 * re-configure (e.g. after a failed filter program) must not
+	 * subtract again.
 	 */
-	pbsize = (1 << (PBALLOC_SIZE_SHIFT + (fdirctrl & FDIRCTRL_PBALLOC_MASK)));
-	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
-	    (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));
+	if (!info->rx_pb_reduced) {
+		uint32_t pbsize = (1 << (PBALLOC_SIZE_SHIFT +
+					(fdirctrl & FDIRCTRL_PBALLOC_MASK)));
+
+		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
+		    (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));
+		info->rx_pb_reduced = true;
+	}
 
 	/*
 	 * The defaults in the HW for RX PB 1-7 are not zero and so should be
@@ -1359,7 +1368,6 @@ ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 int
 ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *fdir_filter;
@@ -1384,7 +1392,6 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
 	fdir_info->flex_bytes_offset = 0;
 	fdir_info->mask_added = FALSE;
-	fdir_conf->mode = RTE_FDIR_MODE_NONE;
 
 	if (had_flows)
 		ret = ixgbe_fdir_flush(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..1e79ef8b28 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3164,7 +3164,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 				fdir_info->mask_added = false;
 				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
 				fdir_info->flex_bytes_offset = 0;
-				fdir_conf->mode = RTE_FDIR_MODE_NONE;
 			}
 		}
 		break;
-- 
2.53.0

