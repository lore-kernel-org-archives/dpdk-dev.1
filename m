Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B89C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 18:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 936B040EE7;
	Wed,  2 Jul 2025 20:23:01 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id D0D7D40E8A;
 Wed,  2 Jul 2025 20:22:59 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-749248d06faso7340940b3a.2; 
 Wed, 02 Jul 2025 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751480579; x=1752085379; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IygRE7B3XzL5FGRMQd9fk2AbwQSAery88pow47GbAbo=;
 b=f/vl/jDK/JGrbCorpOsFMyVre9aEkzXZbM4G8zZHJOcJfoIYwHmS2g3VviBRmtmgeb
 PVjmTlge5S1jcFBZkcJv1YOyYDcbwFzA+O4QLbk1ntyJBP84mEKevknimdoFeg87T0rV
 THJAQ2+h9z2vg1Lu9glq23quns+VleWCrdgLwKTmm4X9je4tnFHVct2eph/e1dYOBW+O
 jTVm7RhCvJFbCM90Ee4wYjQvn66laWR0Tw2KP6zqtt0wWEKBZBzIqVTN6mtk/VOUJg+q
 t0gaRQJqoC67H20dd7RMGXlOBBPrdeHKycidqXpbaL3SW5GltsOiT9jSZF29bEXv8Hm0
 gA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751480579; x=1752085379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IygRE7B3XzL5FGRMQd9fk2AbwQSAery88pow47GbAbo=;
 b=Dt0OwAGHGwP/w/OT2J/cpOyJKw1uk1bu/CG8bR06u5JJtoETfWUNsM4mbzpXadrCwJ
 UzWzNiB4XnE1P4aDA1jbp1bCDpoUl5RsIWpB7opTpV90mwmVHvlu4jYEKRicfMmQoR6M
 14lVQw/GFIjvjjcY9HrRgZQzsBA6JqDH4AXqDB4Rag/H5bPU9AKXnj/tDKA9MG/8UWPV
 tARSqG3fS8kJPFD17bmAXp0po+y+PBiBcLtbTdj/9YFZ5+ypSLyPQ03INfYgWonv6hIb
 C+U/9vM5IwFfuNqNysHu1OyIhm5Ws6XC7vgna1oOLLrEdoupUh1PUeD+xFWhRC7+mQ5L
 BN2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb5hE35oNuaIQ90hkZJ6eubBn/kyxTY8g3mCOLmzz3eagUAKzyCCbLk/gKuF1/2R3fonYhPAA=@dpdk.org
X-Gm-Message-State: AOJu0YxJJn2qPXDSq9cywf6ZKH6fLUXA5P9UQUPFEM+jiUe4SXg0Et/E
 6O0PKA/u85AaYZ1/jrNB7FLWtG0KyDvMYAlchCrGMPLDEGR3UKLWLM3nYcUnla21
X-Gm-Gg: ASbGncvqsOPJ+3ymWDC1UeVLslHkzEBNie9INdCMyG3EXMjc+kNDPnhF3q2chfTFz+N
 JrKW7fX9nr9GQc2nUah4ZNZOBaJ2Zb3GPuq/pEKLOTwqHyjR5SrFZBGwkSTF365crao5n96y88B
 Dc4NS5U3vdjsloFgqgmEW7Pfb8J40zjR4I2SmL3ziTL8PxBiL8WmphEHDjwbERY11AHUzo1AHW4
 IZNRrQB2PP/cciPjBsl+FYQBhU0pvvqqdwjT17BJtmUV5PVfjxkp+9rK4glx2WbdG/oecni0MZw
 2XzMIT7lBK+L7AfMhtY4ZDfOkF9tmXrxty2dva9+licRlrvGSDqNu9xGU0UYK19h1WgEzcFFRE3
 Jd2a0zPyRuJmia97YsnvfEWMAnHOPIE+pJw==
X-Google-Smtp-Source: AGHT+IG/2RNM/Y/I9YH2+buWKUlSO2KIq9Q1sViOQxDZL9Wkx7LO9ajCPdCinsEOknpdNsV8iw72CA==
X-Received: by 2002:a05:6a00:a1f:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-74b51048d7fmr5184444b3a.14.1751480578414; 
 Wed, 02 Jul 2025 11:22:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2162:53:bd13:dda6:5d:6065])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540be24sm14433428b3a.20.2025.07.02.11.22.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:22:57 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v3] net/iavf: fix VLAN offload strip flag
Date: Wed,  2 Jul 2025 23:52:51 +0530
Message-Id: <20250702182251.96427-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250702181506.95192-1-amiyaranjan.mohakud@gmail.com>
References: <20250702181506.95192-1-amiyaranjan.mohakud@gmail.com>
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

