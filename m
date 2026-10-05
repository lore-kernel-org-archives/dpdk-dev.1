Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C49940E2E;
	Mon,  5 Oct 2026 21:40:16 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 997A340E2B
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:14 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so30827795ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229214; x=1791834014; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S+E7WyE5HSma2y8PiwW+u8yIPkqVHWuiGE3MP+uxs+E=;
 b=DiAjN6yiz+yLfhS7g/KbSGyc67gjOFyyG+NGsOn6f9pOKV25u1U5JJPm15Dp6oDOKE
 RkrpUJt4k4KF21YbCjSRDHFaTyDIB/9ECyVdf34OHA6txdmU//Db9H5bBKPfNSW2ueYy
 cKtDkCmKnbui6y7lF95lcAYIazMcol/55qhNnlEQh0SgbAS7p9nCoX1ugRw4dcalfJAM
 kJq0iQFsjPAODy5p0JWMO13RDgCqqFmhTfDjmKmYe500IVKpQ3tP77iobAWp6CxIBxFG
 OuAeoZLCUtxjR0wEEgxvAIyvaGPy5+29yMNoCDsHrCwV+J48CL74HJeH1ZozLkFJATrJ
 /ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229214; x=1791834014;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+E7WyE5HSma2y8PiwW+u8yIPkqVHWuiGE3MP+uxs+E=;
 b=sfb+St7W/qQeei7y6jtbIJGuRtn5QRautJfy9rxMfdxQ3BXGTbfJaUUg55umm/ceWu
 IegdB5brM3bo5yto0Lw5+AeX5nyM2rG+Ed+6WLYC8RHHR8fb5Gg4bpDiY8rZdycEB92D
 nVv3WlzMcB4Wl7VzKSAQYJMrDMGJWsUAG3b9avTmAIqIl01bnMMMORNi+1xZZkkW0nlE
 5xgmEfemIjvPEyB+SeDsigo63TYA1XxQY9mJ3HUEuIsnUWOpPl3Kv0ft5u9A39vq7A4w
 3eOe9BdC2jKRjvkQG/2xzOiioBBk7bjMz2H5XQ8OIMDq/A+s/KMM6YbRBdUnQVylBvaX
 YU4w==
X-Gm-Message-State: AFq9FYI+CayZuaB/fj37PcXnOIBcVXNF1b29iEjfRCbBWLQyJvUw7Bvr
 5x4nnG+OaztJ+XQHDiHCrJV/+p2BzFccJVw8RwKDI8sQxMG8r7Y5lBZxcdEI0rOoPnQGzryC7EO
 N9a4IsBxd+xtMVw==
X-Received: from plpr11.prod.google.com ([2002:a17:903:3e2b:b0:2e5:6b23:1f55])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:324d:b0:2dd:ad74:ac84 with SMTP id
 d9443c01a7336-2e49b69b451mr117077115ad.31.1791229213537; 
 Mon, 05 Oct 2026 12:40:13 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:38 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-8-joshwash@google.com>
Subject: [PATCH v2 7/8] net/gve: fix RSS config memory leak on close
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, stable@dpdk.org
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

From: Jasper Tran O'Leary <jtranoleary@google.com>

Free rss_config resources during device close to avoid leaking
redirection table and hash key memory.

Fixes: 7ba84453bacf ("net/gve: free device resources on close")
Cc: stable@dpdk.org

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 22f7d30a6a..aa8beed3c4 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -724,6 +724,7 @@ gve_teardown_device_resources(struct gve_priv *priv)
 	gve_free_ptype_lut_dqo(priv);
 	gve_free_counter_array(priv);
 	gve_free_irq_db(priv);
+	gve_free_rss_config(&priv->rss_config);
 	gve_clear_device_resources_ok(priv);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

