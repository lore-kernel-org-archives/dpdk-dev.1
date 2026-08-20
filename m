Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F54C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B8E40A79;
	Thu, 20 Aug 2026 07:25:40 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6AE4740E32
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:34 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cace91f112so17852735ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203533;
 x=1787808333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TeQOZtGV/AQ28W8Td/uJRmXYvnKMYKoEZ8O7Zo5MVXM=;
 b=AcYvdcAGJYj7nFdU+8sFycZHMttG2ioX7OiGwRBnCdOXRoRAtHGTckkro8IdL9SA9s
 iCvG84LIDVtqIqHvw0VUwMTUreXRM3Qhmt7FO/nMT/N0sX4GPeKmW47oLMTvA7VgZGZW
 bSH/kWadrs0oIuApLob2kIpOM6hH5OtlNYyAEaQskyrQK2a6kAvNOkGbhORTqSMe0odp
 rhodLi5Lr+6duQtbGXMrIDa/AzPlYJkyh/1dzreMBkBUT8QJzX1YMjqKs8TSbqxwF+5q
 YRAQ3lDuTjBDi/3mlIeqtDomN08dnhtpVebVEJYPrx6rwuIv4EEb229lpICKIQU4ZSev
 qbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203533; x=1787808333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TeQOZtGV/AQ28W8Td/uJRmXYvnKMYKoEZ8O7Zo5MVXM=;
 b=fGTEntDrRDgePMbXIOKR0dJxnFsfxYGBreY3Qx/V+FG/s3LVMQl0aDFEhOhExPZsRt
 R1VNBo5ZrJjfPyoBa27ZukRs/0I5jDHrpjEP023MmEVoA7TznZIBlumIHcq2gxHoTi21
 uegxXQ4Vq75MHoE3+2RCxrNYUAb1VYYe3GDqHPlC95fnKf4Dr7egFLhSKNSXrE1WbRUZ
 m3aF0CRTWwKynWiya+ywTFYCwOh742k8UKoShjgTFpjzfJHSBCrklvvZvRpEUwEArQCC
 SfnbkIsq/vh0xYfrCu3yj566WRuCdbzUP/dE7Nsw5G+HpHIujKqfWNMqQySZo7veI+gI
 0R8A==
X-Gm-Message-State: AFuF++lC2xeEqnjM/PokafI7/JDEQHkYPKLFSBiv9jiaMjzxemVEf4w2
 G6Lhn0YP5oyqPd2zNkuN/WRI9Rg32uBuEMrkLJodR4N8U73pF6JMnFErTWB6zWtTwnS1F2E6By4
 AKt+I
X-Gm-Gg: AR+sD10rKp5k6BvTbluiOcDfNeXCzO/k2cpJX38THVIQjQnd7RhAEDAIrkMiDx+6y6H
 9xni8Wuw7SEX4tVJlRe/WPVv2ZkUb8LkMD8qMlY6yqWDp8vjeCqMd2c9738VwQXG7IjLwQJ+INz
 Zn3q0SX26DKJsiUWnP1m1r3eP2pBvNfUe3WwBKffPByN3w6pEhdEy2tOOYk6HOL/nGjOLu/wik0
 O6Drc5VXhzhsYB32kik6ElzJEmm2/SYhn0mKns17d5LodUoboVMY2b282Sosqhgj73UMqn5vdow
 Rl1mfCPjfS0Dub8E0lc7FAIxmDJxuScYZXQa0RG/2jy1Ut1XGsZVHNktSKKild3p2HxgUZWT1c4
 43MdlDZVTkivFzlz4Q/14VkOi+J9Yg6e+Ewqm8BaNJGGVUkNMcXvxptYV+nnkl/q715hck/juA4
 Qz4T/VM1R9Bu6rJ0yfFXKcndx1Lmrirmw0zFvLqLLs9fUg+TlhxRm/OJ6WQP2XgMoJXyGpgKLCs
 TseK6ro8KD/T3rwk7eGSqfmMSs6
X-Received: by 2002:a17:902:e802:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d5fd6e09a1mr173469305ad.8.1787203533565; 
 Wed, 19 Aug 2026 22:25:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 42/61] net/vhost: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:32 -0700
Message-ID: <20260820052251.1453273-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vhost/rte_eth_vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..97d60ecf5d 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -13,7 +13,6 @@
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_net.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
-- 
2.53.0

