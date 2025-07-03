Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91119C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 10:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67F3040267;
	Thu,  3 Jul 2025 12:18:08 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mails.dpdk.org (Postfix) with ESMTP id C2D1040264;
 Thu,  3 Jul 2025 12:18:07 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso4516533a91.0; 
 Thu, 03 Jul 2025 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751537886; x=1752142686; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gO1eBxMjsAaYd/HNPNmuJaqypcG471ccO22XIvEsABk=;
 b=IoiFs4ygT0rPMYSo6aowe5Y27c1uo6yzdt9D1GF+flKMlIBd3FHwbJCEcwLLkZndpp
 Rq2UIoa9c939XNTWFTef4fCOsTwXh/fc0uYwovexMohXEVxuZeY0Ku6r+KUeACjmqcDs
 wleUhVp0k4AK9IrSrEVv9B2QMPcnEL+rQGDNDYYuAoJ1a/mPFbm+mgZtvqPmMPf3GAmA
 D05RYL6kRGnic3+sqlLm+5/Gu928fupbkpOIc4O5BfZOiPAjjHMV7TOogPDWqeafShjQ
 c6mF7kAX1fnFP1pPfGZ4mb79Dq1KwpxgXuPWuacOtSthbNJLHRCn72kk4HBfWzm9eZ/U
 5b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537886; x=1752142686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gO1eBxMjsAaYd/HNPNmuJaqypcG471ccO22XIvEsABk=;
 b=DQA0utUDF6swFzekvVn0+03UoK5H2RX8iKCCAAqhlGVp15I3B1vUQqnkTCJt/slt3L
 K2LqoUnH3QkM/h579ZeRTbJYH8aPH1j3C39W+3MMKbsQwwPUpsjYykT4jjKDC+cPDmLN
 sJiuL3IiZef/KjNCj+tZ8/f3ob0LtUXT2a+hLqTnut/N+rd/1sjQ/+PyEI6D9D7V7jMp
 CNO+uDRw5/+fRQ5T/0jsyNUjx3OOy27mu3K71NH4rWDrGpQTV1FbYOx45ghGkRlptmCi
 UCfyWdax+q7FpLEMENZgu6+Bzm15K6Gf0Z65wovj+x4GDCesa4w/UyqIar2W2kZYNuaM
 S3Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwY2dUW0PRr82zJeCxUNM9oJZ/THd+E54wF7zRIiW0W0K+jF/WF1YGJfIEA90nSf9wK9ULw90=@dpdk.org
X-Gm-Message-State: AOJu0YwP15pUWiWjwIAOSZRtpzc9/NFSmGTaaBDozBZ+CqliSUPWXvmh
 RJeKr0y+EueNgLh/JJhy4SNhQpsoVLpOfzy+v/zKZpn1yL+Dj9jCxmHAaXoCCCXM
X-Gm-Gg: ASbGncvuI8drLYoy5TKwR6rXlR/5LscTi6PoKv8tJe1WIrdFKhYuDwE2S6c5G6AUi/2
 qWqXVudauHZgtfnlhhX9LH33zQYWUFceETXQYt+RN80ByGTGIZxddTMJ6PuNuSXv27YCdch4pcH
 tFjThbUbQbCV8eDxaXQqLw+g/dkZieg7Ft4rRsyq4CTTPOBGpThPA2RclUEsXr0CRjeLDXSHAPD
 nmueJCeeKoSelqcQsmOAVcD6e1LmUvm39oSVK96l/TZGDRqvI/HpOWrSospe0KT14tY3/mPZkEp
 iRJeEQFqgFSt6DMYYIoBb2fokyJZ7uPvxvOO1bDIG6dYuz+ZzZJ1eEqMEGM21qKwh8e+X+58Z+B
 iYt12BaqHQ60wA+y8RXVA
X-Google-Smtp-Source: AGHT+IETqCaLwcHBCweGz5JJ6bNwJF5UY9taGp/bS4qe7dGzm+Oxc5TIB64gQJvn8USE4aCKg+darw==
X-Received: by 2002:a17:90b:514e:b0:313:1e60:584e with SMTP id
 98e67ed59e1d1-31a9d5da7aamr4206427a91.9.1751537886390; 
 Thu, 03 Jul 2025 03:18:06 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a80823837sm2607500a91.1.2025.07.03.03.18.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:18:05 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v2] net/iavf: fix VLAN strip disabling for v2 capability
Date: Thu,  3 Jul 2025 15:47:58 +0530
Message-Id: <20250703101758.9973-1-amiyaranjan.mohakud@gmail.com>
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

Ensure the correct virtchnl op is called for disabling vlan stripping by
checking if the device supports either v1 or v2 vlan capability and
choosing the op accordingly.

Bugzilla ID:1735
Cc: stable@dpdk.org
Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling filter")

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

