Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF92CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D490840E0B;
	Mon,  5 Oct 2026 21:40:11 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id C04B040E22
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:10 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so23138185ad.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229210; x=1791834010; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PDVTkEUBXUIEvJH3suF1jxMAyHZoXOuwbqSfStUcT3M=;
 b=sSG1B/SYpUuX187y7lq+qMYIy16Oy4bPDCHybqES7h8oABAURttAJ6pUv9amp6w5Bm
 dgQ54tNF+C++wZj+P7luqOe6VGEmhdk9d9d1Wx/BlrMn4hP6w3nXqLBW0ujxIpZoOvd0
 sq4E3qXkJK4XBE4ySHJw5qi9Fd8klCsbv+wFhZK/7q6wSMpEHARDxPdfwXSIFzjNlIZR
 nX7DHzchXdZkcobPON1AH5FLv5v+Fs3PNLj8sHo3sE335R8DFFdCCDbNwLP0NVy647m6
 tBeuLFbEJRuD9whncjz0Kxe0X9cJl6WciM0r78ypCF3qGmUTKo836yIsHqoEquo5ncGq
 LiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229210; x=1791834010;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDVTkEUBXUIEvJH3suF1jxMAyHZoXOuwbqSfStUcT3M=;
 b=s5whNCtQ/at7xaclyD3P6cIN4YZ8IAqy83d5X36PktBL316Nx+ELOKibDn8sBOiN0C
 yQZRkrAgKbgGJWizFLLRmpz0AAvLdpZPUkq9BoebhcVpgZq89t8/vPULLATUDJo/nQy4
 ylepQRU3+yO44Vb5jgmZKMYIrm+DuNUq8KEcgOwsJPDvUL2fDlQ+pioNsFg8xG68MmDO
 NmcGRxodrvB5c6VJWtneu7to4c8m9PdSTIZwUXown6J6Yyjun28/x/xJD67oeAOrZlku
 1Ckgc5XrUoxj3oFrOjHIWyqM+pRmHrGphJX6dPr2rfBu3vryyzBqMUzTaFAdjQyTBRIC
 TBDQ==
X-Gm-Message-State: AFq9FYJAnnY4iS5RU2KlmHvirZV/n4XoLLs/q+9NWMDuKUPLO4yetVq1
 OfnH/Gyi9hOOyDhs0+WvctuiunlBhFJmDIt3NJhGQkM6XhVZk6fdBTaCC8YR6MVVNEl/ixX7IuI
 dXmcGk2PTYlpyBw==
X-Received: from plxq13.prod.google.com ([2002:a17:902:dacd:b0:2e4:b726:a820])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54a:b0:2e2:e5b2:6451 with SMTP id
 d9443c01a7336-2e510605fe5mr78925345ad.36.1791229209549; 
 Mon, 05 Oct 2026 12:40:09 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:36 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-6-joshwash@google.com>
Subject: [PATCH v2 5/8] net/gve: update RSS config just after successful
 programming
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Moving this into the control op allows for better flexibility when
introducing the mailbox op, which will include support for a query
operation.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 5 +++++
 drivers/net/gve/gve_ethdev.c      | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 4dd095880d..db3e43c6b0 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -3,9 +3,12 @@
  * Copyright (C) 2015-2022 Google, Inc.
  */
 
+#include <rte_common.h>
+
 #include "../gve_ethdev.h"
 #include "gve_adminq.h"
 #include "gve_register.h"
+#include "gve_rss.h"
 
 #define GVE_MAX_ADMINQ_RELEASE_CHECK	500
 #define GVE_ADMINQ_SLEEP_LEN		20
@@ -1275,6 +1278,8 @@ int gve_adminq_configure_rss(struct gve_priv *priv,
 	};
 
 	err = gve_adminq_execute_cmd(priv, &cmd);
+	if (err == 0)
+		gve_update_priv_rss_config(priv, rss_config);
 
 out:
 	if (indir)
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 3ba99fd74c..49604f9362 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -243,8 +243,6 @@ gve_dev_configure(struct rte_eth_dev *dev)
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not reconfigure RSS redirection table.");
-		else
-			gve_update_priv_rss_config(priv, &update_reta_config);
 
 		gve_free_rss_config(&update_reta_config);
 		return err;
@@ -1161,8 +1159,6 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 			gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));
 
 	err = priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
-	if (!err)
-		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
 err:
 	gve_free_rss_config(&gve_rss_conf);
@@ -1239,8 +1235,6 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 	err = priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (err)
 		PMD_DRV_LOG(ERR, "Problem configuring RSS with device.");
-	else
-		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
 	gve_free_rss_config(&gve_rss_conf);
 	return err;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

