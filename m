Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFA1C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35B8402C4;
	Tue, 18 Feb 2025 12:58:50 +0100 (CET)
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com
 [209.85.167.98]) by mails.dpdk.org (Postfix) with ESMTP id F1DBA402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:58:48 +0100 (CET)
Received: by mail-lf1-f98.google.com with SMTP id
 2adb3069b0e04-546267ed92fso1662676e87.2
 for <dev@dpdk.org>; Tue, 18 Feb 2025 03:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739879928; x=1740484728; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ABdOYLshl5xRr0uKiCZsozUcmdJIGxs0RrkDJV31mI=;
 b=eNdhiNNJIZQ5hfuJYJyFkWtX7jGg5hvKYHdMz3cAAWuHCbRBTXmaGmKJIkhxdK3xBS
 tXGF0vWoZXPsOBsAxA/m8EyPtC/MvQBJjJkPBmC5ehVuW5y692rq+WS92RYmD6ZkMV6u
 32W+CkdKW57jlQf7bxm3wwyDviHGYLPGldtJVpRVnI9yRi30UPM7P/P4ZCQwParIMjIq
 MJbXhiuIK+K5VliKKxXvH7HK6v1Zx8RxSmFJniODMKus9wyxBgr57YcPiVsEwJTb0vN+
 X1gZKHAYKBJHfLxAI8XM2Q5lA3f37n5xldMF5HpJU3Xn8c7buzLMZlCT82u0zhjxpx4/
 UFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739879928; x=1740484728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ABdOYLshl5xRr0uKiCZsozUcmdJIGxs0RrkDJV31mI=;
 b=p95fNU9KNB88XjNkYeenH/zXe3Dt7RLAvIB2UQJVuS/IrYAH8gwEgDDfx1TtyL1Z56
 jK2XDtDXUzp1Be58JQs+UjZ2zj6HzIZFB2K1pGmgpbieD7bj0s2VkstEvKH10XIT+bbI
 R5zNfJQKtA8YFjlRlsQciezFDUsiylAp2E9q0++COZvS8/Tm+v7mAR3BYxHWFdE/0dQ1
 yUnFgR8aGcPMTMi8nXZTz7HPBithtnLNXpKTTvWCiuG/p7jQGgNYCLsGEWJyzZuOnK0D
 WaL2FJ7rkD/6DXZPGcavo1JGr6XL0VTVQ3WHQvRCP7XpkAg8rogTckNpmUtg/5Vqq6C2
 uQVA==
X-Gm-Message-State: AOJu0YxF4qu1v3moFoiU1LIiQkHmtgNUj638cU5rrva7n8efyIYshS5W
 JAe7DtUSzDvWhA4byLwJJBo3vqnNl1f2rp8kDw9hMtQEbLV7Y7NCyNwEhy6E1OoyatTo//+QXII
 yTM9ZRPUCoEEeZMwfAhI+a6ghq82E/wY3ttZ8V28=
X-Gm-Gg: ASbGncsU6Sh1PMyFBPyYRuj/WILPaf8PslutHotyMcL+daFFBQ5+Pz/DoYICpl30g56
 BsK2mol0sDb1Dm4jHGD+78GKmwyN6wi3COngZDXAbnUKPsBDO59byjM49KJ2JzAV/P+V672KMsz
 BXDWEPWMgOmFzOSgIC950NKavM/CJhu09IVKxDviis66C8fL1wE9Vc0oTn/9YfqD0Q0PDEKRLWu
 Swx/p77vDjGXAoCBQddL4OiLaVwfIn5WudfgbiImkbalIWoMi0yYH+cf/aKZPBnNcGmD8ufrvKq
 iWCocKNOLiFnqJW+JsoanCxm8s+4tZGOZ43KW2TKJYv57yuumXLILAwt55mh
X-Google-Smtp-Source: AGHT+IEdXvvIQJE0EE/xmDrIIgotJtd8rkE+3rpjqBkolhrPlI3K/6qLMhjVDLkMSsW2wHo5uhUvg/y9gi+A
X-Received: by 2002:a05:6512:b12:b0:545:6fa:bf60 with SMTP id
 2adb3069b0e04-5452fe2eaebmr4791892e87.19.1739879928061; 
 Tue, 18 Feb 2025 03:58:48 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-54622d840a0sm152473e87.10.2025.02.18.03.58.47; 
 Tue, 18 Feb 2025 03:58:48 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id 7A366121C8;
 Tue, 18 Feb 2025 12:58:47 +0100 (CET)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>, stable@dpdk.org
Subject: [PATCH] ethdev: fix get_reg_info
Date: Tue, 18 Feb 2025 12:58:28 +0100
Message-Id: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
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

'width' and 'offset' are input parameters when dumping the register
info of an Ethernet device. They should be copied in the new request
before calling the device callback function.

Fixes: 083db2ed9e9 ('ethdev: add report of register names and filter')
Cc: stable@dpdk.org

Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
 lib/ethdev/rte_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 6413c54e3b39..073a3bcf5c0b 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6511,6 +6511,8 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 	}
 
 	reg_info.length = info->length;
+	reg_info.width = info->width;
+	reg_info.offset = info->offset;
 	reg_info.data = info->data;
 
 	ret = rte_eth_dev_get_reg_info_ext(port_id, &reg_info);
-- 
2.39.2

