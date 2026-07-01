Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47434C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E8DB40B99;
	Wed,  1 Jul 2026 20:35:49 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 9714440B90
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:35:47 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2c9f0073e20so11047705ad.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782930947; x=1783535747; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WVJ8z5q1ajaX1sgPYx5uQZKajY0wAIz1ch50KNQpjEU=;
 b=JPE0Rc2ddwSGJTRMNGXlR7xFKJ6Gq1KFW7MXgY10HoIoNKKhx9SSdMa/g3XllWKQx7
 3fqk1riFGl25vws3HhVrWgW0RjnZJM/gg9c7pvnYnTslM53xbh1dCjVkcYGQOX3/dIRT
 Khc1/0NKlmg4250fRL1QBDKPTcYYR1OFhENPBldkT4vj9Tg1AttIWa9m+TgJDIy5NK9n
 HastiSCTxTVGA+NDkXIJ86EHvFdvZT9Q2EfcLqVkiElQzhxg6OUIFFbtDAN6VMkVdg73
 j9v63SFdXuVhEVlGcGhQZ9VBa2V7T8YWpa7NW7W6kb3GINZk4Czl4xABGVkuZXroWJ1k
 hdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930947; x=1783535747;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVJ8z5q1ajaX1sgPYx5uQZKajY0wAIz1ch50KNQpjEU=;
 b=CIMSo7xJ5mWfQDch84J2f9RbHZ3Io9uKHvBAmKXT9/MECe0FNhQux0FrIG+C3s55aS
 GktR8yANNZolJaitwvIUirRrgn8mNqqPo8NO22mMcX1TQXM/WWDbORwRNjd5luwsI3OW
 sd6hp6yZpISDtIOEDh0T0Hc7fl5YPFwZ0GU6JJsHAu0B428OUOGEQcQOfn0NIGZOVCXW
 XN9NOl+wa+lm53ShICUWD2YH8TVGhQePrmPyfzmyyh8mqudjHH+JfbHTpsY6x0UPdWjL
 q+mvQAMbxJZFgOc8F4hPyU4+/FzxINBnTnrZav6M6VhBOSvj+13PZPUKKk4dstJkEQ2x
 vEHg==
X-Gm-Message-State: AOJu0YxcUDsn5kEIgU+PG7pVRmFOxA7wlzXQe99mgqcqQQUa75Kzpyw7
 cO2xWv2jjc4d8wrze/Wy6cU2HXXk2G+ZiXEGX5LjvgaZLP8aDni0ZT1ptJdcnMvhC0dj2bDCjlc
 I4ydtReMgku0tBg==
X-Received: from plbjx12.prod.google.com ([2002:a17:903:138c:b0:2c8:1e6f:167f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8d0:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2ca7e6847d9mr33213735ad.12.1782930946542; 
 Wed, 01 Jul 2026 11:35:46 -0700 (PDT)
Date: Wed,  1 Jul 2026 11:35:26 -0700
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260701183528.2443032-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701183528.2443032-9-joshwash@google.com>
Subject: [PATCH 8/9] net/gve: don't reset ring size bounds to default on reset
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
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

On device reset, GVE skips describe_device functionality, as the device
is not expected to change on a reset. However, before skipping the
describe_device functionality, GVE still sets the ring sizes to their
default values. This effectively removes the ability to create queues
with higher-than-default descriptor counts after a reset.

Fix this behavior by only setting the default ring size bounds is
describe_device is being executed.

Fixes: 1bf64edce3c4 ("net/gve: add reset path")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index f73784a109..c990920a4d 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1579,12 +1579,12 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		goto free_adminq;
 	}
 
-	/* Set default descriptor counts */
-	gve_set_default_ring_size_bounds(priv);
-
 	if (skip_describe_device)
 		goto setup_device;
 
+	/* Set default descriptor counts */
+	gve_set_default_ring_size_bounds(priv);
+
 	/* Get the initial information we need from the device */
 	err = gve_adminq_describe_device(priv);
 	if (err) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

