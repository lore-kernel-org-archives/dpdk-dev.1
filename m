Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF89D116E1
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 00:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49EB640B9E;
	Thu, 27 Nov 2025 01:38:27 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id EFFCF4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 01:38:25 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ee13dc0c52so3185181cf.2
 for <dev@dpdk.org>; Wed, 26 Nov 2025 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764203905;
 x=1764808705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvP8UaAPHRxpDoUGoDswK1x09E/DfgyQHLfEZeCdrN0=;
 b=TWF6cnl32xnSurAdYtLpoiQ+gOW67UOiTZ+PJNUEhzysFNsAgYYOlfjS4QNOYuj9Sg
 gWYnQC40Sbl5E0gxUN6IRfFksWgSPvqB762ugfBGeNPEMafrZHz0H7q27JttXiNy+qyF
 gfFLMmsBEj2X5jDVspRqVZpom5KtYyBQJNktKSX3u++cfYn3542TsgFS69yMssHCGzvw
 /Y4hDEaVTfviGNYGkoerGgOPyyI/zc1qKFW/f59L8cUM1JW1hAkzcqxpit7gOM6SvqXB
 7SNjOEnvJDpy2pC0GXsBVAVz9+Rws0Vyelyb5idkb0nvxI1a1ilIPCdMJz7Sl4c21nYj
 zhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764203905; x=1764808705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvP8UaAPHRxpDoUGoDswK1x09E/DfgyQHLfEZeCdrN0=;
 b=Q4DzMkfo8LFFpzZjV0G1ctU0q9A0E9MCuq9v8PwaNF6Q7n9xwl3Cko7PhV0iRZaQYf
 67HsgreDcpw40zjLRzUU51dw/4s2M7/XUcJG+VyYcoxgYv9k07SfWaDh74NmGliog3PW
 tLI7udgbmf3tzEAd3V01G/TaR7VEh4L3TX8+YAIt7UynTYkk/iFJ4YVbHuySFoVLoYwZ
 P3B05fcyZF/XSombXa1OfR1k+3RXhed5UNlTpv0lVy661VvWKdRRvgJNzwoZv+ea13o2
 qnWO1gJF+/JFPpDuf9m+OiQAC9EtkT8eE4tbW1IY/v+xw73GxbyZyWXj+EOgJwJXsTWn
 x3jA==
X-Gm-Message-State: AOJu0YzGh7M9HePuaTEWhZlHQCHNMM1uBK3vv5pqpSJsMIbTq7WrOoO6
 5i2QgzWPCyGNf1N1SJyOcNloJlUpz365pd/k8IrPVEDQxEM4g6bTq3lBDGZCwbasRC4=
X-Gm-Gg: ASbGncvO01QqGQv4FAKf2p/5j5rBKaaCMcA+MACAhbcYjZLASX5f2OHjBNs9ypWxj6b
 5eA5G15MopTd8u9AOshU7oPY3cjfpbdOB8Ynq9vZ0X1w59VCFyAMve+dNHJtzoVoWR9ooUysyhd
 b7mNy0z9EC6knosOOBV0hab8GMkbtop7XbvOpHPqCCzVo5C3tzQJmLbc89vmybfbM+KUTxH6VBg
 SwHqF8WIprqwg604wEIivDAMD6NSNlNfRhYHI3MM+vUQKUuuuxorEqLvptEhFgwD4oDoEKRIfSk
 ZNwfV6RnfObEljmcP5AAwznwsatJnP/DSTm/v5Y83ZrpBORMSaju5Sr/Ib4s8hhwmO9ZAKRggpS
 F5gnBLbIMlYwQxiI6sbDNsnoldUN9n2RlbCWpJJ1x1lYk3s6el8FSmv9Enb12DIPwRGykEb4lIQ
 LZbnIQETV7J+l6OVvweVr+QETGx33hOuRCD12vpmBLBETW1GyGgA==
X-Google-Smtp-Source: AGHT+IH9e/oX77R5RnqwwVItKNV7+44xMvPkUTtrDNcMMBMrPilNJGfPX2fGvwhYYGiSeaA4V6Zi3A==
X-Received: by 2002:a05:622a:11c9:b0:4ee:13ed:3da1 with SMTP id
 d75a77b69052e-4ee58a9c757mr302036871cf.21.1764203905050; 
 Wed, 26 Nov 2025 16:38:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd2f9a3b5sm578631cf.1.2025.11.26.16.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 16:38:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net/nbl: add VLAN offload set interface
Date: Wed, 26 Nov 2025 16:37:14 -0800
Message-ID: <20251127003821.76733-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
References: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
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

From: Dimon Zhao <dimon.zhao@nebula-matrix.com>

Implement the vlan_offload_set device operation to allow
enabling or disabling VLAN offloads through the API.

rte_eth_dev_set_vlan_offload() calls the driver to update the hardware
configuration. Because this driver performs VLAN stripping entirely in
software, only a dummy implementation is needed to avoid returning an
error.

Validation of unsupported or invalid flags is already handled in ethdev.

Fixes: 9d7757dce874 ("net/nbl: simulate VLAN offload")

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - reworded the commit message and added a comment
     (want ok from original submitter)

 drivers/net/nbl/nbl_dev/nbl_dev.c | 9 +++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h | 1 +
 drivers/net/nbl/nbl_ethdev.c      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 58eb1c6231..e926c06456 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -758,6 +758,15 @@ int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask)
+{
+	/*
+	 * No hardware or state change needed since
+	 * receive does VLAN in software based on rxmode.offload
+	 */
+	return 0;
+}
+
 static int nbl_dev_setup_chan_queue(struct nbl_adapter *adapter)
 {
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index c8a5a4670b..21d87a372d 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -95,5 +95,6 @@ int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
 int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu);
 int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev);
 int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev);
+int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask);
 
 #endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index a3b963e9cc..d269ea8058 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -45,6 +45,7 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.mtu_set = nbl_mtu_set,
 	.promiscuous_enable = nbl_promiscuous_enable,
 	.promiscuous_disable = nbl_promiscuous_disable,
+	.vlan_offload_set = nbl_vlan_offload_set,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
-- 
2.51.0

