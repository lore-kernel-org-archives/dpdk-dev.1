Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840ABD4417C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDC5140A76;
	Fri, 12 Dec 2025 12:09:52 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 97C1240664
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:09:51 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so966812b3a.0
 for <dev@dpdk.org>; Fri, 12 Dec 2025 03:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765537791; x=1766142591; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RX52T8GDwymXc768rPYfji8ZI+0jshAhRB4qlQb7Wp4=;
 b=atJes3i3TTtXDR2+L4QPDrBQQXfOusr/LiIwGmrc734avxWnfKDCRJBMpyfY4oZJO2
 V/5WSImrrXn2QSw9+EXUPC+HZ4grlaUCGv7/TMmzoATZS6kcRE+RaCV2bfUvIixvH1vn
 9eEvUOJ3QDJfrdSdMO+EmqajQd7P42AZlOFwHcNaEEDkXDQJy/0vDtSAEXF0TUJ0rU+2
 9L8aiKAxETYJsAZZnxy6D+6Mjii+2EbA2WVysV2mPsBaySSN72XwrlXtehXgf2cMxoQo
 Q5dv6DfK17ceVuqZCcdNpYnTT6sf7kh9AssLx6PlJnDME0r9YDeiDkrMy8xgpNeu/eC9
 XgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765537791; x=1766142591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RX52T8GDwymXc768rPYfji8ZI+0jshAhRB4qlQb7Wp4=;
 b=BGbWhJuomTUSKbP9yjJDqOTfF9LNXTQKAV+yXvP32v8faRSXoCcbcFJ9rUmSira/Yo
 jfkPUZBEb5ueFY3Q5k9kL+vAha6ioxc/sKm//kvYgSjLdRYZ17Vqe+EFkxuIHTTPT91L
 8th7IdMSaAqE9QP386W2brbMPcveaBnJ4QqnWSVMDCaUuEzE3KU8bQzQB+XoNhdNxR1v
 62SG5U2v7ggH+EvCDxTwjXJtRZJl/cJ+WQxh+qx119k4kpWCw+9hTuK4zJmQdfT2Pgmn
 ZxmFnmA2ryIRfSKm3p3AiIfZBWS4OFUdWVq+jwr3AfLe686S8C5M4Uf0cH/GtCuR3k7k
 Vl/w==
X-Gm-Message-State: AOJu0YyndXUo4NMpFtMFwpVT95oAWcGlIhUgPcQRpAjCAjeatxWTpBS6
 pyZz+nyxHtF9XE7hwS+9ctm6O4xuN6a7iS/jxAHJqXrNvsQvklIOHIuN
X-Gm-Gg: AY/fxX5EYbtZwM43o5X7ViUPX4/vYqxowlPELhh5LoOfEnWIJfX0d9RiisJ2+7CZqaR
 ue3c1u9nKbsLAH5JK9cms4O9eXUobrA9K1rf272oeE2nlb+M/tO5M702taoVyAjjn0ReB0P/cOM
 BSE7DMbS+oeRWAFteLb3YANR+4MW+rZSGmHZ12OFWdTDtIBmnizMz/xQ6jMTH8/qIgPn0DQHfTK
 mVZQ6i09uMD20SUQNgDx0jj/MqjvELs1hHmJEtgh2UySlM4TAM8HLzTZEIdUcHLM5VBN+noswG4
 KEUGfSib6N0R9B5K1HoaI4VokzP5kw8bcoD4N2kdNeFhbDUcQFikn/wH7O4pczNMunJ9/MDGp8v
 EqMqKFXhsxZYqv8AGS11OuGfikxFhyKqdxhh03U/ORYblxqMdRkkPy2ocxa2U9FBdKvALXtJQ2r
 Ttpct0vWDNVY4y5Shmppu0nMivm3XlJlf1uZ7GJlB6mnw77bjPv8gn2seX
X-Google-Smtp-Source: AGHT+IHjmuQ01pR+qwVix91R7NuziJu7LhVwiNDQlQspBXq9pFYRQ6WwTJbfxvgSYi0ZTja8m+sk8w==
X-Received: by 2002:a05:6a00:1d91:b0:7e8:43f5:bd35 with SMTP id
 d2e1a72fcca58-7f6692aacb8mr1902806b3a.33.1765537790519; 
 Fri, 12 Dec 2025 03:09:50 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1cb0:3cc4:c896:45a:a564:6816])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f5ab7d87e8sm3280334b3a.25.2025.12.12.03.09.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Dec 2025 03:09:50 -0800 (PST)
From: Madhuker Mythri <madhukar.mythri@gmail.com>
To: longli@microsoft.com
Cc: dev@dpdk.org, stephen@networkplumber.org, madhuker.mythri@oracle.com,
 Madhuker Mythri <madhukar.mythri@gmail.com>
Subject: [PATCH] net/netvsc: Fix on race condition of multiple commands
Date: Fri, 12 Dec 2025 16:39:44 +0530
Message-ID: <20251212110944.59350-1-madhukar.mythri@gmail.com>
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

When multiple processes issue command requests(like: device info get
and link-status) at same-time, then we could see the command request
failures, due to race-condition of common function execution.

So, to avoid such race-condition introduced a new spin-lock to protect
the code of critical section.

Fixes: 4e9c73e ("net/netvsc: add Hyper-V network device")
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

