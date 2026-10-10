Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806CFCA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02A3A40664;
	Sat, 10 Oct 2026 03:00:03 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 529BE40697
 for <dev@dpdk.org>; Sat, 10 Oct 2026 03:00:01 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e651510a5dso2277785ad.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791594000; x=1792198800; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1S+QMJoDcxl4oPEq2sdERUZAV+EIYMFC4u2NLJUsqJA=;
 b=dcha0pJJ1GRG7CqO28GMLebpjRow48CORyJETJV1CO9MWabfDf+LuqZrYizPXkMvpF
 ijb3f/iHFWE4hjwclawwLLXKVEmyrtrPh+eXxxdP0J1dAPjTaYjxi8Itj4ZjLu3ZgL+K
 XeUrkUZYvBspxxpUPdtOWIfNQKSJ9oKl96AljRm33uvaVgmQQPh6YEVN7UaUY9/XZimm
 nJwaDIm3TVGGbemzMsKo0mhZgvWhcZwWv4irP8vULHtQpFJCMa9S0aQzir1HmwUjDYuK
 xmR9ODG+25CkO7MggRip3htxSUXA0TK3BQaNUNJ/pByrr83GZDFJ6lYzwmIy5pLWGSWH
 vy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791594000; x=1792198800;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1S+QMJoDcxl4oPEq2sdERUZAV+EIYMFC4u2NLJUsqJA=;
 b=m6T7MOFgaJKqKJ3AW6LKA8n9bVu5ASLstisEONxOM36PK/VrMkmYLZn4sJ4ktEJKrz
 nka0ef+kCweG3sS8wspKaaKeMV0jY2whJCJBSD3Z24HDdhhkUQomD3lL+/JtmeMbtcRa
 kwMJfqbr9i8pmuUG3bTzEE3HmaqqeGwg33jp1TEnJIBgU4J9xM6687syiSU4uAMQH5DR
 9kWHjKBlRM/4/hnTotDiWnBYp7xdQPB0NUI6jAIFrCquKjyQBZGTABCbKcv2cZCd8qwB
 elFrDvGIVY9IkklpuvvhRIXajPTq3nbgQyL937M2QJ52UCIMr6vcxqq5eA1jDiojtK7c
 4LEg==
X-Gm-Message-State: AFq9FYKnj5VWp/VC+FaczhY1W9br7a30HPvHkSk6WjrJQY7cVn4PV6S0
 g5/xaN2AnlmdVUyx9/Iet7WUPHiXPM39UaMhDkhlWIg+LWqJ1mzFXXROCMInFr5QjqXaS5ikq3T
 5J6n0M9i7o7sUGQ==
X-Received: from plrb9.prod.google.com ([2002:a17:902:a9c9:b0:2df:a429:6698])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54f:b0:2dd:c053:d73e with SMTP id
 d9443c01a7336-2e842cd9904mr31464195ad.37.1791594000220; 
 Fri, 09 Oct 2026 18:00:00 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:38 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-7-joshwash@google.com>
Subject: [PATCH v3 6/8] net/gve: update RSS config just after successful
 programming
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com
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
index 1ee49856af..d117b28dd0 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -251,8 +251,6 @@ gve_dev_configure(struct rte_eth_dev *dev)
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not reconfigure RSS redirection table.");
-		else
-			gve_update_priv_rss_config(priv, &update_reta_config);
 
 		gve_free_rss_config(&update_reta_config);
 		return err;
@@ -1187,8 +1185,6 @@ gve_rss_hash_update(struct rte_eth_dev *dev,
 			gve_rss_conf.indir_size * sizeof(*priv->rss_config.indir));
 
 	err = process_priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
-	if (!err)
-		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
 err:
 	gve_free_rss_config(&gve_rss_conf);
@@ -1266,8 +1262,6 @@ gve_rss_reta_update(struct rte_eth_dev *dev,
 	err = process_priv->ctrl_ops->configure_rss(priv, &gve_rss_conf);
 	if (err)
 		PMD_DRV_LOG(ERR, "Problem configuring RSS with device.");
-	else
-		gve_update_priv_rss_config(priv, &gve_rss_conf);
 
 	gve_free_rss_config(&gve_rss_conf);
 	return err;
-- 
2.56.0.170.g584c36229d-goog

