Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DDC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8584540A87;
	Fri,  3 Jul 2026 15:13:27 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 4E8F340A76
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:26 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so586284a12.3
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084405; x=1783689205; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WVJ8z5q1ajaX1sgPYx5uQZKajY0wAIz1ch50KNQpjEU=;
 b=BRsedGPSelIB1CN2Xea7QnhJP7h5Da+HFEi0814CpazpEsD5D2yZqAB0ZfrGHsHu4P
 TUw71mlhdZyrJQ6DmM8GdSJC3FbpZaV/t/K3FgOuny/vdlbuNKRYyvrCWafTEq1gxNk1
 GH80jrJ9ibsjMjtzgeWdSaYHeflXXm36dykau/3d8EpJCie7Q75BmjpkJRZvDnxqUVNg
 7gO7TmWgzARVbow0+WpjbppfS0q6do0co2To0fpLvFjteQKkKf1LpFyqBvi15l47FLdz
 7yH/pTYVbXLGPig0sUbhf987LlLUV/kTfKrq5dKG2f1xzDotfB2KaF9oOKaQ1h4RHR5X
 WzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084405; x=1783689205;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WVJ8z5q1ajaX1sgPYx5uQZKajY0wAIz1ch50KNQpjEU=;
 b=PTTpg2JnOuIergsWJ+ibC/ENepq34uoMdLN0ofOEjM1tsXTS+mFGfV9BZiL7jn5fte
 zW6mLnx0F2JVTpskHCEXuEqZhic8z8IlETym8/rEAF5/nOBlnKMiNABhG6PZLIb6n63c
 sF+1nGNXcPOJ/j1ahOQpHEo06Ob9zXxoqul+M+CnxG5S0Sh9jVEUo9su60ywe/vqjbAz
 v4P1af4ZhxzSHgioyMaNHdK3ZxJVlkqbG3Xo5XZkD9E5zArD4Tpdiknz0bGjrSaOhPkX
 0Jop4klSEZQcGp9HYN+v9AyKHx6WQVxm3q+/rxURFgujl/rXnim/nzpxdLsKpL54wVWm
 jkMQ==
X-Gm-Message-State: AOJu0YzlF1Ht14Y6H2WjN543i/YK9lFV7UXgjoEOARUure5cnVnrQzac
 12rAz8ppsQp1zd9y94q3lFLJ2jA+wwmH3Ne8WicshZ9FBI6Br5TQ+P8y8GyEMQCt5sJ2aKoPL5Q
 qvDxtUB9W3/hc1A==
X-Received: from plfz14.prod.google.com ([2002:a17:902:d54e:b0:2bc:ac01:8af8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:94c:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2ca7e71324dmr120495385ad.13.1783084405351; 
 Fri, 03 Jul 2026 06:13:25 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:13:05 -0700
In-Reply-To: <20260703131308.2507403-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-9-joshwash@google.com>
Subject: [PATCH v2 8/9] net/gve: don't reset ring size bounds to default on
 reset
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

