Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D4D29DFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 09:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D060402E0;
	Tue, 13 Jan 2026 10:53:13 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id E073A4028C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 10:53:10 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso4603793b3a.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768297990; x=1768902790; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYbwOYc4rWUkXlgx/uyCyZ+qgEIB0JABhPGH8qvtJt0=;
 b=CFCpsF7824QMbaS3LwQYvn7Ll8ICij8qucP7lkXOqgi+ArVAdJLIMaroRLR0EdhtIj
 y2NqQ6uE2Vi31yoju9bYQ0XYnFoDXM9j7OfuPOFQmdyxU3ih0xKEnqwh9kQuRd5SqrVf
 qxNFmBFGrbAz7Zvg5TN/TnkR4s1VQLRbW97R5X/QLEGBbyNEgbh/Th9Gkt+ZwJpQZpww
 4XwFA7hICzwvHINjkZRWWbUDnppCrFj1nMj2kL2Y3/37pf74ZWtTotIm8GDN16jifUQ1
 Eon5erTDckthKCJX/JYiGwmCvjyKvyTF9D0tCt0oe+VwVRh/FrpXkzh3QQCmDZ/j82un
 3MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768297990; x=1768902790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYbwOYc4rWUkXlgx/uyCyZ+qgEIB0JABhPGH8qvtJt0=;
 b=LA+cbUnDhp/zFvJZNrFNfbv47OApX/ECm3lSLVoqtWHYosXlepvYlAK++IgufkhYhy
 3wyOvxPiAl8bd4R4jJGxunZwJE+TCqnUyfTyR/xxBMtg1Wt0nLU89HLsd7Uh4BVnzpp2
 EemyxQC5y5QffLHhRZa54BR5OMF1JBeSzG1ceJzvQJQaxk9NOPveJ0np/tXnMjFVTrcZ
 WoNZKVL/0qmPOfc9CopZJkHwQ6DNBXlf9lO9NRy9xo+ihA6qkIybM8FCgxmpCf+0+xVq
 cPVd9HX3HjW/f5KS6aumiysK2knP1dpJaUodvBiDv7TjKPPi690CBFeXiUdqvUF6evAk
 aThg==
X-Gm-Message-State: AOJu0YwwSKqCZ92kODYw3mQpst+hTlNIy0qN58m8DUINU8XZpGDy4lU6
 uZ9dTWvz06Ih/hPrRlLhKRrLZqDvMXcE5kh+RshM0DjEzx9U3eDS6JqMcJ4yKw==
X-Gm-Gg: AY/fxX6BLEbsVrn3qX7mhrfBoSjp1j+sfw7ZjmHXgIbTPFu2xxG0KWNeEWC6pJmo/lc
 QysEcelyGmHmIXrGq+LGt0Mbn6RYEDu01XoJBOqu7MiNtuIJXSuaChb/aI7N01pjFV9coYwurQi
 R+JNoWygfVEyS7ZTlnPxeG5prcCoSLlG3clZ3c2c3jdF8h2DKDHXC77JV0Iyns45RBCzts0Ly4b
 q7rBFRLztcjtCSxbp0T3Zp0zhD3hYKI0TOcUoCUBj2eP7OzAQHzvYWDkNKFBZsxV7Y138895VKw
 gPppqG5SRxjiZwgWoQxPzMGMdy1IxdkT0O2AIh02APiJSlOwnLRlSsSJE0AtQJPrVVsKp76bEGq
 +2OjmgOgtd9kFYKosWcBKj26AznPx640EbdnmwPXhXDwAtp4c+AEwF/dGUfivMe2qC3+FaVGhqe
 zlxltoj3ULHnsmK9a/mK5NvNqxHa75XmF34AnzUjRlPRtBu/YdVrQfxA==
X-Google-Smtp-Source: AGHT+IGm0W1jbq8SBmzCWvh8Wte8GZ8LczBrc/kz+AHtfL+zddrUr14Js9IjUyVt3kI/26PP+LRHzw==
X-Received: by 2002:a05:6a00:35c4:b0:81f:4063:f1ef with SMTP id
 d2e1a72fcca58-81f4063f455mr8958454b3a.54.1768297989805; 
 Tue, 13 Jan 2026 01:53:09 -0800 (PST)
Received: from localhost.localdomain ([206.126.100.157])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e042e75b1sm8045352b3a.21.2026.01.13.01.53.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jan 2026 01:53:09 -0800 (PST)
From: madhukar.mythri@gmail.com
To: longli@microsoft.com
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Madhuker Mythri <madhukar.mythri@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 2/2] net/netvsc: fix race condition in RNDIS command
 execution
Date: Tue, 13 Jan 2026 15:22:58 +0530
Message-ID: <20260113095258.54258-1-madhukar.mythri@gmail.com>
X-Mailer: git-send-email 2.50.1
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

From: Madhuker Mythri <madhukar.mythri@gmail.com>

When multiple threads issue RNDIS command requests (such as device
info queries and link status checks) simultaneously, command failures
can occur due to concurrent access to shared resources in the RNDIS
execution path.

Add a spinlock to serialize RNDIS command execution and prevent
data corruption.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
---
 drivers/net/netvsc/hn_ethdev.c | 1 +
 drivers/net/netvsc/hn_rndis.c  | 2 ++
 drivers/net/netvsc/hn_var.h    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..b525e287fa 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1310,6 +1310,7 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	rte_spinlock_init(&hv->hotadd_lock);
+	rte_spinlock_init(&hv->cmd_lock);
 	LIST_INIT(&hv->hotadd_list);
 
 	vmbus = container_of(device, struct rte_vmbus_device, device);
diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 7c54eebcef..8a0716df89 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -500,8 +500,10 @@ hn_rndis_query(struct hn_data *hv, uint32_t oid,
 	/* Input data immediately follows RNDIS query. */
 	memcpy(req + 1, idata, idlen);
 
+	rte_spinlock_lock(&hv->cmd_lock);
 	error = hn_rndis_execute(hv, rid, req, reqlen,
 				 comp, comp_len, RNDIS_QUERY_CMPLT);
+	rte_spinlock_unlock(&hv->cmd_lock);
 
 	if (error)
 		goto done;
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 17c1d5d07b..66ed186c0a 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -179,6 +179,7 @@ struct hn_data {
 	struct vmbus_channel *channels[HN_MAX_CHANNELS];
 
 	rte_spinlock_t	hotadd_lock;
+	rte_spinlock_t	cmd_lock;
 	LIST_HEAD(hotadd_list, hv_hotadd_context) hotadd_list;
 };
 
-- 
2.50.1 (Apple Git-155)

