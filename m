Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAFF10AB82F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A62342DA1;
	Fri, 27 Mar 2026 01:19:48 +0100 (CET)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id CD6EB42D55
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:19:46 +0100 (CET)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c6e24ee93a6so1785679a12.0
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570786; x=1775175586; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YU0qYyZxP+A1Rl6n4x1skuvc0xccx1iNnuj9m3uJYMc=;
 b=Vm7wIKQdpVmwxVDSyqE0pnyCcXVOBrBzke9SU4J5w4I3HpzBCH9W5PLhTkcyy4Hh82
 tGJJLFuaF/9hWzAwmDHqg+dSH0GR4C2LIkkm97wnl1jVYrPUqLITkEjeQqz7x0SmOA+Q
 PvL2i/u+jwh3YmR/On5rb04uxi/fM2JKZYzFy9DkNW8wTSnzQIpco+SY/UcT5jkW33AC
 4dOVyWyH6Og2CL97frFlVv8TpZdKBviQxTUWxcfSHSjlyrXmj/DnLIbz6+L+vGya/J8S
 vvhmq/uehTEII2ReQoUEp2T4YkeTz+hw+xtX8CH6PpM6r4MuwCNl14KRPobVI0ESFAJT
 C22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570786; x=1775175586;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YU0qYyZxP+A1Rl6n4x1skuvc0xccx1iNnuj9m3uJYMc=;
 b=kh1Nxk67i4uk/vBr/7mrOBfgyWAKzE0pJoiPQbwG9F2ep5jyjRxPKsaxEdq5t9CRk0
 j1yqTKGsuRg3TGTR7QTbxcotvwynFYSnZBNplxQ5+z3gCy1+1/An8ekaPKOlSpcxI2Cy
 Ckf0V6+6J8imYLwzd0KCb+P+sgMhaZ0b0ksKLtnsLAJ7txLip+6SecOo9e8OiIS01CMr
 z5mV8mhJ2ShwAhWEokLUjwSjlVGBEz4csCjtIszz5yxmHZ372JH65vRxmV+BJ/tRSX+x
 CD1dy2bB9ZOHaCcf8pplUgHNyrbgQ+OVVliPuk2t6hNZv9mVxeJwoxfLdAnNxQhDoX9p
 pWvg==
X-Gm-Message-State: AOJu0Yzebe00MY9T6u+Pgmkgt7HGx/fBYwyc9PEgivIqvfh844lLCjM0
 BBRG5QkJRbbdsdgQZqthjsId8QwKKF/HrfVFzFoQp5MEbBfvfSJ24X3/xYhVzV/ErmcrIZ1KhEx
 xwIU/bBwXL+bklU2uGI7kpzZSLQ==
X-Received: from pgbem14.prod.google.com
 ([2002:a05:6a02:468e:b0:c73:9a1a:387d])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9389:b0:394:4d99:ff56 with SMTP id
 adf61e73a8af0-39c8a70a62amr288739637.11.1774570785722; 
 Thu, 26 Mar 2026 17:19:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:18:27 +0000
In-Reply-To: <20260327001827.3385001-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260327001827.3385001-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327001827.3385001-5-jtranoleary@google.com>
Subject: [PATCH 4/4] net/gve: add minor fixes to flow rule code
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
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

Replace an unneeded goto statement with an early return. Add a comment
about the lifetime of the flow rule lock.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 6ce3ef3..fce90ad 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -521,8 +521,7 @@ gve_setup_flow_subsystem(struct gve_priv *priv)
 			priv->flow_rule_bmp_size, 0);
 	if (!priv->avail_flow_rule_bmp_mem) {
 		PMD_DRV_LOG(ERR, "Failed to alloc bitmap for flow rules.");
-		err = -ENOMEM;
-		goto free_flow_rule_bmp;
+		return -ENOMEM;
 	}
 
 	err = gve_flow_init_bmp(priv);
@@ -619,6 +618,11 @@ gve_dev_reset(struct rte_eth_dev *dev)
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
 
+	/*
+	 * Note that gve_teardown_flow_subsystem does not destroy the
+	 * flow_rule_lock. The lock is preserved across device resets and only
+	 * destroyed on dev_close.
+	 */
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(priv);
-- 
2.53.0.1118.gaef5881109-goog

