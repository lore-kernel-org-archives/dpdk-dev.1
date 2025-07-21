Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 10:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA1D4060F;
	Mon, 21 Jul 2025 12:55:32 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8A7FF4021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 12:55:31 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso2591807b3a.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753095330;
 x=1753700130; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MEbvfO53t6/fWgthJIijZ1e48CiIKvJa2/DuiH7fhAM=;
 b=GtDzdsBAnC1k2qSmx4/aFNsxa5N0FTXxYDWYpU7PP6/Xjrb+aCyBbiie4fuURsZrtj
 Z0a4e5vUT3cIr95c4ve7r5t3v7K2GuQMqMaCU1OKHrUn0teLfTCmbCfigroRnuzVIyiS
 NY7q68wpRBbxMGFQ8koyoGByG1GtUAeygV9/QNv3zGUVotgTFSxMzHcqGgnpFEMUkshA
 DFoHNte6kkiYUX7r22xSE1v+ynUhahXjoU8+9X2ZlJtS9Lr7WZc+CNX+0q9NBLM4nbNx
 CgK352TXNqH+qCwVcx2O3OCHRJOLXavkDguRrUkV8oYiztNxfx7GCs4MCHt9NEUfolCr
 am9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753095330; x=1753700130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEbvfO53t6/fWgthJIijZ1e48CiIKvJa2/DuiH7fhAM=;
 b=QLVtiP9UTG2i+/NNFYlmJwzHrp4WZLEFo50QvxaXIxjRORmaWNV4/GPSrRuOt+Kbn/
 NhIZqY+Ui0ydufMCFz4GJalRHTt18LRRS0ur1D0AggvFenKll4LcnEScwqlNsx33p601
 aE/k/HWAM1pDIrJv/fonPpmaX6RDLbkhn1p8R19VLtCWbe1m0hElTpODoE19VvmdkwjS
 cTXvUJKSbztZxMXhx2aYpmzWu3SIcNMlgF/k3JgNatR0yDOFnpKBGhWzqQ0Qc5xVmtkz
 QUY9/zV/9Ou5JE9OcYsRG9OpGaeHtuPwJv74dNV4hEvi2y6ryRH4T66sbFe5vFwN8TEF
 kHOw==
X-Gm-Message-State: AOJu0Yx+lTm2Q08kr8LXt5OwXtrkNE0W8izcnzuR99A1Kn91F0GWmCPA
 VlR2Olcm1S+0dJzFMcmnzKNOlGFEH0W5TCRvg7JQllySBT8o1qJixvSkvKheMyBZqP8ETAhBuzT
 ubwrw1bg=
X-Gm-Gg: ASbGnctKP9jvzMRUuBX4/kN7sAYr0MTR1QxZl9/mlnHvEsg/gjWkWuizWXiNGwJBMa0
 /62XuihebP7BFKLPR/ijTRf9VTXSZDmfD9lGYPJP91RbBDJOrAHzFAX9FaGwEVHu33QIh78SZLb
 sNh8iM9c4stBkwvft9D12Pyd4LLPtw89gbQ/1jLQsIY/k8kJ3AESr1VJnVzuD4j93sX/356UMpa
 SeTUjDegP3dT2qJ4bEtRvmwBo7PTvkH1bn1nA/WbxqwHX1PQouFHOZjgpAxkGXxuZ2nZOv/u1se
 CrBmzf5ODV5b0wnk45Tf+Ti5ATWzMReM5F6aFB3w+lfLyny9/ZmWdQc2v9wuMT5abpjOOyuGULh
 hYqTJgDcDJZ2rBcuMggxCWD53D//sfgcuF++yve36/BOzbwTf
X-Google-Smtp-Source: AGHT+IHog9EVhUDri9q7EX5zvsF4i8Ti/A6ho1TNUHJ8lWmAf6l1pAG1V0AFhxW43LN4NcrLrnKP4w==
X-Received: by 2002:a05:6a00:aa89:b0:75a:c415:7804 with SMTP id
 d2e1a72fcca58-75ac41578c3mr15301197b3a.8.1753095330376; 
 Mon, 21 Jul 2025 03:55:30 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d3302sm5619675b3a.44.2025.07.21.03.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 03:55:30 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/ice: fix segfault in secondary process by validating
 dev_private pointer
Date: Mon, 21 Jul 2025 06:55:22 -0400
Message-ID: <20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

In secondary processes, accessing 'dev->data->dev_private' directly can
cause a segmentation fault if the primary process has exited or the
shared memory is unavailable.

This patch adds a check for dev/data/dev_private and uses
rte_mem_virt2phy to ensure the pointer is still valid.

Fixes: 690175ee51bf ('net/ice: support getting device information')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/intel/ice/ice_ethdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..f0ba3626bb 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4090,6 +4090,15 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		(dev == NULL || dev->data == NULL ||
+		dev->data->dev_private == NULL ||
+		rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			PMD_DRV_LOG(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	struct ice_vsi *vsi = pf->main_vsi;
 	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
 	bool is_safe_mode = pf->adapter->is_safe_mode;
-- 
2.43.0

