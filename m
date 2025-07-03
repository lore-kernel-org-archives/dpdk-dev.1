Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA4C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93B7A402E2;
	Thu,  3 Jul 2025 10:42:44 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 20B7940285;
 Thu,  3 Jul 2025 10:42:43 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso5720933b3a.3; 
 Thu, 03 Jul 2025 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532162; x=1752136962; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IqyH2tGzrRK/IQLR4o6pDqfx0sSTBi8tsH33HsiA/jg=;
 b=bes0e9x9vBcUAt/cjJG5rkuCDCYTCtATdcb4rc9ghd+QnIBY5No1iSSQgpn9/gr5G+
 j+lKWhQyszaFzwCO92Ewg8TGB3fU/wBUzf46qzy+BQV9vQShGHUO1Z+PNVshkUbUQxyy
 IJvXR5lBmt8uGB0/njjU7vDfGU97IIK8ttsgOy7n+jIPGl3vKUVaZb8t090NYkbsKzeo
 yJjHuQqjAUtjMdqovfZ+jVvb6KzZj46lBsp//8fBZNBIbCDEiaGhAjF2G/+dimtIAohQ
 FPFUbOvo9DkOaXTGC/i9y2fPmOA2gEu9MV8Dh609ZPxx5OX7GFzejpd4UQhC8noSpJS4
 e4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532162; x=1752136962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IqyH2tGzrRK/IQLR4o6pDqfx0sSTBi8tsH33HsiA/jg=;
 b=c2uMe37qUiu79N5dUZ+bfJ3it2lKaE7CbNRQaIM9xrVrNooohg7JFhYkuEYU2vN5jK
 o7wJgTTJAM5atIo4qqRPZFqHTMU4il8uq9WgK1mDd781yjSt9tpBUsYFVDkZ5xlp16Cu
 wW2K1AhUYd/AO2gtllGVDTC1/D/ZuIMGV6jkO7AbUAjCCwrlwCQqehL2xWA+iaq0M4Al
 f0tGCYFiQ7cWPissBUqZC0iI4zS/OzNivYkw5vl8G+8NcqatDFowHU/WmJQ1loHI3Emx
 q4HhEPvGs23TGHohnpQbNCZxgtiApeNU9mX1Za6pYZPPw5DQSwbjZoI44o1QROcVgkaC
 A0Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOzglu206G4zWG2sgWI38KtiGFI8zdnVhJyHJx98I6Ai58MhttV0hx6oNsK8gkWYxq+fDrMb4=@dpdk.org
X-Gm-Message-State: AOJu0Yws6qHPQzNaogmEGx8yTAtC3eTe47T9Ci5cXeR5FP0wpCNDcah7
 hfIZljsyFE0uQu2FfTyp6am61lTuLsF7vPGf8kfeCccOfm+gYgoGyh4wY1LVv4uM
X-Gm-Gg: ASbGncueLZkEv+0uZb7loc+yJt/c8stOPUcK2aZTURIo4fmVyQIF3F27JQcN2yX/Xkw
 QcZ9v/CNSAQEyv0z7Yq0+HSIRwLb/CAGPe+ONGlOkEp4wKW+rxjWgZSgJIhiYlK90qZHX3SHGFv
 TqX96RQkFbomTDvOJXAQAYurTrWlbw5iiumnGgJYrS/mB0wdScfvuD5mYCQVNzr3GTeHh2uX+PR
 sDH4Oxxqp87FN+0y5rm2UMOs6bXqTpFoZZsRJDZdTAFpyuV9ccZRJqKNvmIUeaCDrIEsQyflcZq
 BYWpWv9pX8f0q9Ow4YNTas1ANsU73Az57yDI7eu/NPDS1d3UlaK+E1FTf6Gkn3dv9/XbbifyftR
 s5MGhmczCRKRFWav3WW1J
X-Google-Smtp-Source: AGHT+IElvWKXCwhdZQCm5cDclNi4wOsXmZzjKGx/LXgR3T1l3+iRNxOfrbka8I9ginkuFDqBxDxSWQ==
X-Received: by 2002:a05:6a00:2d91:b0:742:aecc:c47c with SMTP id
 d2e1a72fcca58-74b50e8daeemr7839951b3a.7.1751532161756; 
 Thu, 03 Jul 2025 01:42:41 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.207])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c7546sm16284346b3a.111.2025.07.03.01.42.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 01:42:41 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v1] net/iavf: fix VLAN strip disabling for v2 capability
Date: Thu,  3 Jul 2025 14:12:34 +0530
Message-Id: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
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

Ensure the correct virtchnl op is called for disabling vlan stripping by checking
if the device supports either v1 or v2 vlan capability and choosing the op
accordingly.

Bugzilla ID:1735
Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling filter")
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c33fdd9069..335a8126c4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 	 */
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	int err;
 
@@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 	    adapter->hw.mac.type == IAVF_MAC_VF ||
 	    adapter->hw.mac.type == IAVF_MAC_X722_VF) {
 		if (on && !(dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
-			err = iavf_disable_vlan_strip(adapter);
+			if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2)
+				err = iavf_config_vlan_strip_v2(adapter, false);
+			else
+				err = iavf_disable_vlan_strip(adapter);
 			if (err)
 				return -EIO;
 		}
-- 
2.39.5 (Apple Git-154)

