Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65EC77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9D3D402E6;
	Mon, 23 Jun 2025 20:11:51 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BE7A940151;
 Mon, 23 Jun 2025 20:11:50 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-236192f8770so32186045ad.0; 
 Mon, 23 Jun 2025 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750702309; x=1751307109; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9wHh8SWhhg7G3TTsziPr8cXRKv006//WVvXbWyqBDM=;
 b=AYAO+zFutIWdHCIB7e983ByIAjcr1c5fe1VYHYPnZHAghq9+F+a3tSJ6kJ1m2LjyG9
 QuF7tNZ/cHdb7SfcA2cuSNs8tDhdIfTH4KLCa6KItwpN+dBrzlktgHtM2vCzlZmVAaVP
 QZhWWDTk1s+z7J+fSRmKiVkcr1BZLL6UOqhFiUcCpfhK0h9z7nyQ12Ni09hYAT38TyVW
 31CaU5o7Zvic6y2If3Wk49LGMloLbQ0GGD7xtZLD4w0OR7Oi3kWZFCbjDOh1wW6jQfhV
 h9GKf9tXjRtLovoJk7UtmEGVyCR7N7T/fjsOlNMzTTKvfgaF3jzkd/8oTpWxMFWFh5fH
 ZXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750702309; x=1751307109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9wHh8SWhhg7G3TTsziPr8cXRKv006//WVvXbWyqBDM=;
 b=b8zsN16+kznqe2x7jilr3S05Fmzv8u2O1K1ooMO9uzoukhjuP7VxircK9rJ4brD3VS
 3FHtEa0FV1iAsZDHWUhKW9Q2aNaIVUkAgKzMY7U09VHlZxfBdbSxdR8kM2ynElXBz0KJ
 5AJlG470j/24vf71kOSk6Z/4Ksi+fRx2U+OLu3IkQIaaRqD2cGvxfR9d6MBMJ708v+as
 7olFaz0sUup3+2fxJOaA4+UTNOgUlIn/OKo3ZfdfbPYN4a4/P+VMftuovKlJbtQ0+DCD
 eu+iRv6uXZEw5ZkzigWc5qKJ6Mbozo8t/SlvXr3ZzAwjvZ+SZw7fHbUQeMBjeh/yUnAf
 Jd9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJS54fEF1VO0b5DfmdxEIVZ6uGnhagwUDJGnxQRZiOMkUiqV+1n//DJ4KiExHztmbpz4Y+YuA=@dpdk.org
X-Gm-Message-State: AOJu0YyykZjjmPovaH7U39KTncm56HdZkbY2EzpeccLR5L1uxoB9xTmB
 QEK45ZCZIAQCRwqXGV1p/8BuKPbLjp+Nm7n5RNBAmrm6IFsDWb60nKt31dy7XA==
X-Gm-Gg: ASbGncuUHC964M77JjQo+9OWKWnU5/w0IRnorF1meWDMRf1AvOiVreJNEiPA08egjx0
 vmkwePJ1V9GqKlUbQsuXJNgn3JicmnM4HKq8IX0s/96sd8M9tc0s4h3evSPHXm4Za9WhdLy54Fs
 pEhZlgCbdgvhERlatc/XtUTMMECPKPzdtH5FR9NY0JY1RF/DQT/ECYwdmID6C4EtR1KiWUzab/+
 GC557zNQjSZbNF7DRyEVGyDC64di6v1rr2bFWdcFqh8Elr2RdVFNUsa5sGDwYj+naxniuQbUXsx
 6SFe7Q6KdrZ/ut27ramNvip8uW2FI4qVikuke/cMOAVlyXrH3tdzrj0WTyUuIye85Q4LarI6OpC
 3Vz0noI6ggNV1YeHN0rXQreMi0RJFwuMpQCmB68o=
X-Google-Smtp-Source: AGHT+IE0x4dE1AOdw+DdHLiVVmh4A7c9HRi3MJXviBeIOxWf7okbVuBipEFPjoZrAjwYCB6+RcjuRQ==
X-Received: by 2002:a17:903:244d:b0:234:11e2:f41 with SMTP id
 d9443c01a7336-238024491aemr7161445ad.6.1750702309432; 
 Mon, 23 Jun 2025 11:11:49 -0700 (PDT)
Received: from localhost.localdomain ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237eec29a77sm48544105ad.165.2025.06.23.11.11.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 11:11:48 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v2] net/iavf: fix VLAN offload strip flag
Date: Mon, 23 Jun 2025 23:41:36 +0530
Message-Id: <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
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

v2:
- Fixed indentation in commit message

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

