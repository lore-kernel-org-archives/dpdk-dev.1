Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DCC7115B
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Jun 2025 01:56:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67E3C4060F;
	Sat, 21 Jun 2025 03:56:35 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2AA8340267;
 Sat, 21 Jun 2025 03:56:34 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-234fcadde3eso33213925ad.0; 
 Fri, 20 Jun 2025 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750470992; x=1751075792; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JrWfow8YKTUjojGtO7vMTTzwjw6ucnTqyYnk0qj01Kg=;
 b=NmqS5WIiprhoSs8pW3gc8O+BINPiTMERkiMOHbgFuyXHIaSDqQIrYMVRWRXIm8erdw
 fnzUoR9x8imGdIo9qzdrwAD/gYayEhtyRoopimqGrPhXcz9w/gGE1OZgDUEX037vma/c
 vJlWxsZgrv0drusWO90aggnE2tg0MsIlrjkK67/mRALqn5z5M7PJWMZXhkmnW9lHgXaI
 jAK2JKAkKCmf5RsfQlCYkalUElQN+2cwLtoEI1p6lnrSDAaFdkZUOLW91EovCW1JoL8U
 8KFRsnHK/J2ofFhEvCaAMUGhhtO559I9+H0uLZrupQKM/1tZzndkllQK28Z1oFRvNLme
 R46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750470992; x=1751075792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrWfow8YKTUjojGtO7vMTTzwjw6ucnTqyYnk0qj01Kg=;
 b=Fu1G4Bqei/YZgnKZPyoQ+l5e/K+tpuyVSBc/rZvvVuswzbJWr2gigx3SRi3lXSewVX
 jvemzn0ePD5eyoPn9zngkEXcmCBH73XYN51FSEq3ciZOIIWI4tC+Xbe160UYmKoZBPZN
 1f33Mf+0dX4M1t2XGjEuN1/tLwekxI21lzTJeHVorbaWGDEUj/pZlOv9aUO8l0eZVnRD
 JNvDBnX06rWVktZAhkNJOdlL3j4siJDyQMU29kFI55jBxEB3SXXc8PRvqjnDLV03NC45
 O7UFVZF5vx2OJ98nIW4SQQcEOtlKb49HelPZ6uL/ppNxp0nJ+0wMWAil6qAmp8acmcuc
 bZ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7+KcD14AJtqsN8LYSAbsuqhQWDDnnoNXXCsZNe/yOm6oMdF0oY9rjjbvpAYRv+qyLgDxsdYU=@dpdk.org
X-Gm-Message-State: AOJu0Yz0FntCdY2uzDDgdhiKtToIIo9uTi78dzzfv/9UfWkIioe8sS/G
 /C94qDMTaL5d1+hgM22JR8zxyKzVniV30mgotq9hSRymhXaJli/E9DsikfjRQQ==
X-Gm-Gg: ASbGncskNM3EPJErMbx/WRfR85VltjQmHPIG4o41EyIPA9R/FFOrqtWfJi9Ly8d0/Mp
 QQla9ieP0qcj65fpahjzF1r1NLrsO6WBK+7YItBZq5xDINL56W0LwsZwAtdzSpxKlYoSQ0AVXbB
 Oi/cKFBtXDUL/wWVCXEI16be2fUCwt8PnYysfW2cNaVPlaPdOp+/Bp0Owebc7yd3cOhEn+a/BUx
 pwuqpg+dKqyAzWQHj2FCh6VavylGaBbgrk6iJyr2sl81yOnhnnWomjq1SzwcKII/rBkZcSWov9x
 HJOuVploj6F6KFgJ2kEy1mKAJit0EtdUaFBWwDpK62zv28sBfxdE3Orodn87u65Hh2Sa3VPDMeX
 4oO1UMbLYKApppvSQRIvfmS4VGA==
X-Google-Smtp-Source: AGHT+IFVskpDDnr0+KXwAVBUHn6XvlKu1lNpA3XQr7zZRottAWynHawBsyzLFb6g4S7rphtMXhUfkA==
X-Received: by 2002:a17:902:fc8f:b0:236:6f7b:bf61 with SMTP id
 d9443c01a7336-237d991690fmr81011435ad.26.1750470992365; 
 Fri, 20 Jun 2025 18:56:32 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.175])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860b8c9sm28284445ad.131.2025.06.20.18.56.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 18:56:31 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix VLAN offload strip flag
Date: Sat, 21 Jun 2025 07:26:24 +0530
Message-Id: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

 For i40e kernel drivers which support either vlan(v1) or vlan(v2)
 VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
 side will not change strip flag. To be consistent with dpdk side,
 explicitly disable strip again.

Bugzilla ID:1725
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b3dacbef84..f93e7bf9ae 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index)
 	vf->mac_num--;
 }
 
+static int
+iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
+{
+	/* For i40e kernel drivers which supports both vlan(v1 & v2) VIRTCHNL OP,
+	 * it will set strip on when setting filter on but dpdk side will not
+	 * change strip flag. To be consistent with dpdk side, explicitly disable
+	 * strip again.
+	 *
+	 */
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	int err;
+
+	if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
+	    adapter->hw.mac.type == IAVF_MAC_VF ||
+	    adapter->hw.mac.type == IAVF_MAC_X722_VF) {
+		if (on && !(dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
+			err = iavf_disable_vlan_strip(adapter);
+			if (err)
+				return -EIO;
+		}
+	}
+	return 0;
+}
+
 static int
 iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	int err;
 
 	if (adapter->closed)
@@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 		err = iavf_add_del_vlan_v2(adapter, vlan_id, on);
 		if (err)
 			return -EIO;
-		return 0;
+
+		return iavf_disable_vlan_strip_ex(dev, on);
 	}
 
 	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
@@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 	if (err)
 		return -EIO;
 
-	/* For i40e kernel driver which only supports vlan(v1) VIRTCHNL OP,
-	 * it will set strip on when setting filter on but dpdk side will not
-	 * change strip flag. To be consistent with dpdk side, disable strip
-	 * again.
-	 *
-	 * For i40e kernel driver which supports vlan v2, dpdk will invoke vlan v2
-	 * related function, so it won't go through here.
-	 */
-	if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
-	    adapter->hw.mac.type == IAVF_MAC_X722_VF) {
-		if (on && !(dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
-			err = iavf_disable_vlan_strip(adapter);
-			if (err)
-				return -EIO;
-		}
-	}
-	return 0;
+	return iavf_disable_vlan_strip_ex(dev, on);
 }
 
 static void
-- 
2.39.5 (Apple Git-154)

