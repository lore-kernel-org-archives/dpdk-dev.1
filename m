Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E5D49208
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25AC840268;
	Fri, 12 Dec 2025 12:53:03 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 24562400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:53:01 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2981f9ce15cso13013605ad.1
 for <dev@dpdk.org>; Fri, 12 Dec 2025 03:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765540380; x=1766145180; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4SmnHO5SlS7jfWRSQTAeEBRFZgrIZYcvzrx3UgtqvZY=;
 b=iRX9/LIdKTsmFpIJqs6jDXsplkc7IXilDHvzPN/RjLp9qFAW/nu17/Op+Z5Z6N2Icx
 P1iXO7YJTOQLO6WB2VfxNNLCxVE4KqYHZYq/lPqV0eDu56cyLvI/zemKI0slkJzqUKOT
 WPMoRZw+0tkUppW84N882K8hSkmuKKW7nhq+Dpeu7PyV8/rxhqoLmhyZU7igxq+zRYYF
 yE4i88El6vnmiEFgCx6GkkOMEXTiG9M3Eh3NupVfkgDxLXvqXnrr5RdiXUywuXDteVJ7
 AFYrwQZhKAFfathm7M38bOhtGVRkwBwfx9dijN+IPyvic8ri9RBlMPvA9pZAZnFzDQLG
 iUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765540380; x=1766145180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SmnHO5SlS7jfWRSQTAeEBRFZgrIZYcvzrx3UgtqvZY=;
 b=bFrb2EkGf6bvMCIpmaFCfAv8r4f0Fj9IkAy93FCF2NU+3D2aH9HAmRATQph30sb/64
 cBxr/cMeyK4bJ0BmCL1B7/DCRq7BI0yMJ7Gfyuh/JGOx0QIl53DaqQ649tLUzZCOEY1n
 ovkZwCFGcLXymPLLKqGNRMJLZCEXi3F7oniGLq7PIUraWRIJsvE8kPQE1gxmofGPS6vQ
 dG8ryMz02TO1yAmtYfNoqGB0/e3Pgb13Oa0lEABSlSQQ7SwCFAOd3dc7hsGPCy2KPwwD
 hXvfqfduTSOz8jpfoG5pDwdQBSbQaPvrk9w2MYZtjcjrqRDopx+zs0Fs1p+OxFXis/Vg
 KFqQ==
X-Gm-Message-State: AOJu0Yym76lWbqAB8paSb1ZJEj7Ae+1T3GLemDZqjn7rVZCEub5F8sz5
 KL7fipE2/iEgGjn6Dp+wDvBBCw1WKz+oqNIQjbU/z/hrwboCSf1b12ek
X-Gm-Gg: AY/fxX6hVq6hOPkDgi2fu4IL/ziGSt/Y1oOjHO8ItpypPe9SCGjg68bv/PMLHlcsw5c
 nYPGb5fXi3HQHsHvVrprb70q609ATy6H6qx3rllBJyKSghNbOKY177IuRzy5VEBNRVi4sJe4Hjl
 sboOI4XpezZbUrR8SEvBzLL2DtM5af9S39EIdOqZy72nK+ObEDMGUV9uXHtpa49A1e2asbqm8k0
 lMIAW61oWFS9w2dFRNeb4/kK3GZssucrPnxmBL23bgyWfgg3ch6o1d+DLnwabINPFUA7vAUkyy7
 VEH7Qew9p1O6K87GlC+FBAqjSSRmaKs9N0NGm2IRa1EdffHUqrVpGd2aAgj89Jc1QQQdRxWohxi
 kxdV1MY8QzqiHR/p8D44euYwaGqrddHi5ZfoDyesGwvqGvkai8dXBctnYQ/PreOn2kEBtctz2C6
 FOndGN5SIzEDIH5DuXXFkjgYPgIX7UEIN19eaXc6Rj8trpG5LBW+4=
X-Google-Smtp-Source: AGHT+IGIvWRPuIp3iF6xKx8K4rAkHZESqgalwsi1Ouna6W2rfZFhWBtixhbTawkSV9uXM9PdZGaLQw==
X-Received: by 2002:a17:903:2289:b0:298:485d:556e with SMTP id
 d9443c01a7336-29f26ced389mr12858185ad.11.1765540380061; 
 Fri, 12 Dec 2025 03:53:00 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1cb0:3cc4:c896:45a:a564:6816])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34abe32e08esm629305a91.14.2025.12.12.03.52.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Dec 2025 03:52:59 -0800 (PST)
From: Madhuker Mythri <madhukar.mythri@gmail.com>
To: longli@microsoft.com
Cc: dev@dpdk.org, stephen@networkplumber.org, madhuker.mythri@oracle.com,
 Madhuker Mythri <madhukar.mythri@gmail.com>
Subject: [PATCH] net/netvsc: Fix on race condition of multiple commands
Date: Fri, 12 Dec 2025 17:22:38 +0530
Message-ID: <20251212115238.59710-1-madhukar.mythri@gmail.com>
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

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
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

