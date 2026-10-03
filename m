Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF0CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41A0D42EAB;
	Sat,  3 Oct 2026 04:51:56 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 3F96442EAB
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:55 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso3333375ad.2
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995914; x=1791600714; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PDVTkEUBXUIEvJH3suF1jxMAyHZoXOuwbqSfStUcT3M=;
 b=cUt851I8BRX4kGKquMhydJd/M2phoIPDhFEb4mg+sit6nIOfbbMt7nw374Y7kkTQ8f
 SvVWwT5T9xQMXk2zAn99KOmDZJV7HPT2WnaJuCxI+xkqFKNCG+Er8894lOeV1iPZOwra
 RjZ/fdbpeY8E+P8OFb9NdMZi8tjRCqO08OZWXgahYYA56Ess0Nxx8yILLsjvEzxR7Wfs
 07JruZBly0zfs5UfYgv4yOPJ7IkdbXT63P45Wkn9DUvRJU96n1RiRnE5lM/JSA9XTqU5
 ZXLJMUa5qjyJQ0ji1d3sMtlFY07fU/wm3Lp0Dpxlo1rjxVn7r14AmWLnutJVtEYrKWwf
 7mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995914; x=1791600714;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDVTkEUBXUIEvJH3suF1jxMAyHZoXOuwbqSfStUcT3M=;
 b=LAUYUssY0oKvbKqq7IZ4ikY6SdAmO5t7ciElrfBpXrXkswWm/j0WSNeBCuq0H9wGKp
 QRche7YZ3pearcDRZ/ouxf9JaCgToF9d1Yzw96OqLGrGGP2jyHF3qMGXvJiGmTGzoHPp
 qAivtcmodRWAp7HDU/3nEgmp+vs0nj41NP2mRUssGvrMvvyapeLx+vy106jVCpphsK/M
 4VYnTVrjQwSFo3T/AU79fvj9mqnCoR6WNliwnVr6QBUzn2IV8j7pNbyfv3yTlho8i6Sp
 S2tBeqtBhgzvxKzw1YAIS4g7utY1Z0lsVncDmVHFek5J0YQp53aFTYSHjUCWGvdqWyrH
 JMyw==
X-Gm-Message-State: AFq9FYLKBam8W8EuC7PAhmVC4Pe6b89Ae6vWDn15bxqa5/OpmL1AW/l1
 PPuecbMEnObbS1FEZAO79D/xb/PI61efEIIRkwdn+HOVg2oBplXAvUu3ohP6wzITB+OPg69b+Qg
 c5Q/eFgFcPtwb/g==
X-Received: from plch4.prod.google.com ([2002:a17:902:f2c4:b0:2df:994e:466])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:120b:b0:2df:9eb0:761a with SMTP id
 d9443c01a7336-2e5105647b4mr10843065ad.25.1790995914062; 
 Fri, 02 Oct 2026 19:51:54 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:37 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-6-joshwash@google.com>
Subject: [PATCH 5/8] net/gve: update RSS config just after successful
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

