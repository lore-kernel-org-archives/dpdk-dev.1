Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036AC7115B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 18:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCC874029E;
	Fri, 20 Jun 2025 20:33:38 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5CAE240267
 for <dev@dpdk.org>; Fri, 20 Jun 2025 20:33:37 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso2913534b3a.0
 for <dev@dpdk.org>; Fri, 20 Jun 2025 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750444416; x=1751049216; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r6rNAh2b7J/L5SKa/Wmw+oTQraCg/rs+RtykrQNuq9E=;
 b=jiDy0GWBhbXxSUtT9rfcE+Bwe8lkfVULBZMCcBKzz1yFeUHRuKeNsl0/ElC7hAChBN
 6kz/kd9wRKRrJIQM5op11aVVFg1tn3kBoYxHX02j37vWzpP6j+AYqTUBzpsTgcoaJWMZ
 AeH+NT6YmfRtRTl6JFLH/P8JyPa3OTFt8L+4j4uy6VROW90e8KnrLXKZARLMjLlRwq/w
 P6U5BsT/HSbLHK9IYN2foNAT74YjtOKg7zg+6lwnrrAJ+jY7HET+IUeyw9xrYRF6Mp9O
 v06IyOyH+iDRLa6fxXI0gb69OwX0btV1rYuELNUkEUFiAqw5NnSjkf52HhBnRbGvMARt
 m/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750444416; x=1751049216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6rNAh2b7J/L5SKa/Wmw+oTQraCg/rs+RtykrQNuq9E=;
 b=RgALJbRW4yDJsq2A7OKotSsyaWQA8FPgBytlttkQe9ry+9khrnkxanT6v3ueEu7G4z
 dkXuW1wG9nnB+fTDUthVouVV45UQmpwE0n5mrQYfdhz+cwi8l80fQmVPxJ+V+Yq8iPtx
 EuMEcLfRmw655ULYyDEcFAFraYCNnuCWmSMVfRVD7jDA0vbEPugzNex1YgMmu86un1QQ
 vfF9e2iNIngCWDPWVovc74iNKKIpfwhIp1ryOp4ddex5iYRgYSkPHyb8v1+GbA5qMtbl
 wdl9BauLap16cFH5boqZznvHvd9BG/Di+1sgzIfHJRTbiEigUV6iUKboa4HJY8MdRSb0
 QSwg==
X-Gm-Message-State: AOJu0YwZXWg+Wfj3GvO4RHGhxUaEVlT9CkG7lhtpYENlCuieQetO2xsC
 1MwRHyaKb6ppxGDNahIYc4PkFx9EL9k1lq/2baKVjBJkwiJlCtYq1LeSskuFlA==
X-Gm-Gg: ASbGnctvQLsglxiVSTmXpYkCv0jFsjLhsTOxy7HMfrsmyOQZTtezbkWj/t9+YoPjb5o
 C3cewNIF0sxzhBNAwH02mkIk5LkZAQegwKaSJ7+wN3Vv1IGHNNbLvXPEV3Txah6aJ1dj1OE0Xjx
 Fj+1czfrSFF3g56U/94padR7hgVnSoit4ESefKJkuilt2dzZJyyi692eSSzlYBjCDTo8o0kdM7K
 rRVTXQmPT5afm6vEk+7qOd9duptjNjsZq/xlqgl691R1mQqFWwwzHG3z4j7JkQhEq/0vjlDCFEt
 AqK3SWAdl5I926KJlQ2OWFIUq/DslOABLMH7ekAVbM1oOVYts437lC4KEkH+N6mIPXloVN7oA8F
 WsxikAjFKQ6nvwXN+5YRIwWQK77osYLIphec=
X-Google-Smtp-Source: AGHT+IFJ9L6QM4XJObVu+YGvBslZQYk/BIU+y9RaoRp3UXlUqZ00+wcRZD4LkQqtar+Q2XfYASf9iA==
X-Received: by 2002:a05:6a00:10c6:b0:740:b5f9:287b with SMTP id
 d2e1a72fcca58-7490d4f532bmr5042098b3a.1.1750444415954; 
 Fri, 20 Jun 2025 11:33:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2162:53:7162:efab:e386:259])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64a90csm2520543b3a.119.2025.06.20.11.33.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 11:33:35 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com
Subject: [PATCH] net/iavf: fix VLAN offload strip flag
Date: Sat, 21 Jun 2025 00:03:28 +0530
Message-Id: <20250620183328.68408-1-amiyaranjan.mohakud@gmail.com>
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

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/iavf/iavf_ethdev.c | 48 ++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/iavf/iavf_ethdev.c b/drivers/net/iavf/iavf_ethdev.c
index 656a4c6176..62e75f3626 100644
--- a/drivers/net/iavf/iavf_ethdev.c
+++ b/drivers/net/iavf/iavf_ethdev.c
@@ -1344,13 +1344,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index)
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
@@ -1360,7 +1385,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 		err = iavf_add_del_vlan_v2(adapter, vlan_id, on);
 		if (err)
 			return -EIO;
-		return 0;
+
+		return iavf_disable_vlan_strip_ex(dev, on);
 	}
 
 	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
@@ -1370,23 +1396,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
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

