Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07901C9EC9D
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 10:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07CAD402D8;
	Tue, 13 Jan 2026 11:18:32 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4816640276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:18:30 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so70700245ad.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768299509; x=1768904309; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYbwOYc4rWUkXlgx/uyCyZ+qgEIB0JABhPGH8qvtJt0=;
 b=HSOTBZmTW/W5NvS+X9Njn2SJY2F9pGnumlH54Kb8GtICFQ7EuQNOYQckM/s+R7wt/J
 qPmW6TO2P4IkUtWgxbturz/R/xI2L77C/mNM19mwiiGxM7EAA+3QeEn301kyBXe807Iq
 Hl2zQqgpKv+Zfpe9NsHCFzA0HW9ZgcVIDMvJPjfnfirglWRpFK3zr8jB5yKUkBzhKH5P
 WrXON63/HNQ9QNl6JePhDxiZws7IAq12Diam5DadPF7RTa2JW9kqHu0g/iwQprh7Mw6m
 LBliHnPJw0YrhIPKzlRZstc9xNsJO3J++SWCZDg5RWBsn35AyuVYTx3x5xlrWFWJCVZ6
 QxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768299509; x=1768904309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYbwOYc4rWUkXlgx/uyCyZ+qgEIB0JABhPGH8qvtJt0=;
 b=f486/f2btwITBb9yr9ZteHWZIr/dmpeVyH4E1U1kqQwayeEQYMatcZ/iQf3sLDByIK
 yGfy3lgNdCfXQEEXBvkiour0f5kAwh5z8tx6Gw2LXXyInycgxpw/kGI2ofjnQF7vmh/d
 U/t/qM24+OcZr2g+cI/fT/CBCYVRLQXyj+ykSo62O/smi7aRkyl/427uPcapIRjGM/1T
 KdK7YVH6yrA2rUv5W2MY4IoJxpNvZK6gkZfn8rzAiI2PGjV3AYPR5j/4tREo31H6Qufp
 wyses+bN+zkaRhGI4zhBV2d9pAqsUcpedALWua3jwtsaoCMfbCbPlhED0h/bVP/lkFJx
 m9hQ==
X-Gm-Message-State: AOJu0YzOn/u8DPyebs7oz2gvpAGQoopBJAEVbai7o/1sIe+Zqudsx/Of
 1wBHxSlwnyb9Nb14bTW35aOY/e4oc8ijMeSAfVXFIb+ecfQ63lQj0WUx
X-Gm-Gg: AY/fxX5mCiLkNwFF0KA7tFvyeQ6u0q6X5ed9MR3tgaFUWuWqDSBrx1RjhgtAMKaEAql
 Uvd4SDAyA6cbb2WW0qKEWIfEm4Cbw/YQVGYMYopwNXqVoNSiq9HSd3WMELUWXXToQyNy9UBbsa7
 uqR7D9aOjsB+KZjbRNyVtanLeX5z6uBLqK9anZeo+ogkAsnFaOxRy9AoD3UTiphOQr9q1B4maCy
 wSTY9xqfmjSvFF1H3VPx1ARP+i497a5j74t8c5l549UfPqpqj5ynrzlkSwEEosX7MJHe4EjRQx7
 SNDTJ9cgG11/7gd5O0vq/CbzobL1LSOTijkPYC6XRxx9IjadYE1wHyyvM95cYdKVGv30WyytrPy
 TFOuUBnGuSnlCAa8oIyZ6gbsIcnMEnHI7l8m4J8Isg/6jyoZPZenz4CSznKLVMuV+FGmbxO+hyX
 KWOVlszDk4q1vKqUS6JytR0s+6o2NAiOZKt3aKd4E4YFBi4MqKBD2U+A==
X-Google-Smtp-Source: AGHT+IFFVIpz9F6enGY/vw/Cq/i+ZT4OPry1G2IWULDFMTcOfsSVWwM6ypqCyinCWVJag3Benx2NmQ==
X-Received: by 2002:a17:903:2348:b0:295:9e4e:4092 with SMTP id
 d9443c01a7336-2a3ee4b7515mr203660295ad.56.1768299509101; 
 Tue, 13 Jan 2026 02:18:29 -0800 (PST)
Received: from localhost.localdomain ([206.126.100.157])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3f3115682sm163067995ad.55.2026.01.13.02.18.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jan 2026 02:18:28 -0800 (PST)
From: madhukar.mythri@gmail.com
To: longli@microsoft.com
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Madhuker Mythri <madhukar.mythri@gmail.com>, stable@dpdk.org
Subject: [PATCH v2] net/netvsc: fix race condition in RNDIS command execution
Date: Tue, 13 Jan 2026 15:48:20 +0530
Message-ID: <20260113101820.60611-1-madhukar.mythri@gmail.com>
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

