Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A475C83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 18:15:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A8964064C;
	Wed,  2 Jul 2025 20:15:17 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 71F5D4028E;
 Wed,  2 Jul 2025 20:15:16 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-236470b2dceso41469545ad.0; 
 Wed, 02 Jul 2025 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751480115; x=1752084915; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IygRE7B3XzL5FGRMQd9fk2AbwQSAery88pow47GbAbo=;
 b=KA3QSVkPgQaQDXb0LBjOwEWAP0fbREuGy/uZbcFEDNM/DrkgXk/ob/jg3ipMwiVG6o
 RM7/OMJpT7USz1itVnLV0OiboYuYhc/YUMJ+zJAdT4XTWwZ5Hm+FOLYQYK7K6rvIUXFZ
 HHdRasxL4UPRFVEMnqjwobPCWAVOsS40YJbb2kxl3jrSJ7B9C+O9NMxyacWATSIB70N2
 3NTxWNcV0JzRMPoVEp5HGaGstz55i4SInA/qhgtOyYIOcuiU5Mlfk5uRnBZaPMk+BGd/
 RwTSyJ3V5wrJ2N9NAxpw5pMGEV7F9ePyCAg8ij/t1QAXniQA/rfPWV8yncG8JcQ33gJx
 WQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751480115; x=1752084915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IygRE7B3XzL5FGRMQd9fk2AbwQSAery88pow47GbAbo=;
 b=bzhKNlTCzHK2rsZycyPQFbM48jR2hOTo7VEk0r+AmnWDN/aarddIeXbCpqw+eNyGPh
 WeQJkKwtAXKjQqYU4R5qdGgDi3l7dg1xhH1oyM+3lv6aeFk1DIVwoW9RC3y8Og6RfT6Z
 1hOaGbmnZP2itGd+RS7pCwzZvn8WBu/BMF+JkMjJLtL1Xz2np1tXHxghJi40YQGxjrIT
 JawjBSsjXqaydBIXG4eh5iFdfyohA7lVyOkpBoQYV85X0C0QLLlx0DoMpbWwMtOWyhyu
 yjc4pSgcjEuEgOLE/0pIZRjcamxLww4XveW/AKEkZ9FnLAZLdnbqmBehED33iiDkvIwK
 m8mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvbl/Cqhqz/KQJSGeDFAzIVcF/qjnkmCJAcZ+Oa7XPpskQmvgkIFrJLW13P4oUNHgYtBLMq0Y=@dpdk.org
X-Gm-Message-State: AOJu0YzANLY33E+6XSDIzrdumf5vzDSZ/tsRTbKXt4JxplMIOkdX9a3t
 JWmxqcozbyr6O6xNI7RzsJYvsReISIJBENbCJ4iAtg2iNQWheAnsyFwHUDIOsk37
X-Gm-Gg: ASbGnctuiLoH7jI0uTgbTD1LCVDPxe5E84TCHtEoBJL/se2pxWV16Bm0jkTi/36EU7O
 mN/fQ7AuXVI0i6yuIyETD2obrZLZgYi+BdtqnKDezbtyR+Rkc1IKFUCETjEw7+R+BemWgoWFQZR
 GApWHM+2bN3MKbrLORQw6JnowNDcZj1IFKuBoNo/EbWYCoLzfT/vGrgNUgetoJB76Dp4OoFQr+G
 +jxdRlBSoERTBeny5UzaToBiIzVzkxzLt44Q00f4298N4qTMvuNrVBefuvSTpFP/+08Blnc2yPp
 eM/TylpsGd+AAuvp3xBky/53b8MspD0gMH7R2VvAEU9u91JCGHZbCKgVAN0jP3cBQjxgSn07pEP
 UmiWd2Xy0vQU2RcSY1klOgccjeDzyTii/cw==
X-Google-Smtp-Source: AGHT+IHjWn1fvpazJIzCmzjTjGrphCZF6F4TDl0cm93J+07k/eWUHqXKRcqK7bn4SrInM84AsvzvYA==
X-Received: by 2002:a17:903:238e:b0:235:225d:3098 with SMTP id
 d9443c01a7336-23c6e5de40bmr51579455ad.46.1751480114786; 
 Wed, 02 Jul 2025 11:15:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2162:53:bd13:dda6:5d:6065])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c951asm142443755ad.249.2025.07.02.11.15.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:15:14 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix VLAN offload strip flag
Date: Wed,  2 Jul 2025 23:45:06 +0530
Message-Id: <20250702181506.95192-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
References: <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
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

v3:
- Fixed the vlan(v2) scenario by calling appropriate api
- Addresses Bugzilla ID: 1735
v2:
- Fixed indentation in commit message

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 52 ++++++++++++++++++----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b3dacbef84..845d773594 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1379,14 +1379,43 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index)
 }
 
 static int
-iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
+iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 {
+	/* For i40e kernel drivers which supports both vlan(v1 & v2) VIRTCHNL OP,
+	 * it will set strip on when setting filter on but dpdk side will not
+	 * change strip flag. To be consistent with dpdk side, explicitly disable
+	 * strip again.
+	 *
+	 */
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	int err;
 
+	if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
+	    adapter->hw.mac.type == IAVF_MAC_VF ||
+	    adapter->hw.mac.type == IAVF_MAC_X722_VF) {
+		if (on && !(dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
+			if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2)
+				err = iavf_config_vlan_strip_v2(adapter, false);
+			else
+				err = iavf_disable_vlan_strip(adapter);
+			if (err)
+				return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int
+iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	int err;
+
 	if (adapter->closed)
 		return -EIO;
 
@@ -1394,7 +1423,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 		err = iavf_add_del_vlan_v2(adapter, vlan_id, on);
 		if (err)
 			return -EIO;
-		return 0;
+
+		return iavf_disable_vlan_strip_ex(dev, on);
 	}
 
 	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
@@ -1404,23 +1434,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
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

