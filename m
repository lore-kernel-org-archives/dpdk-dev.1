Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35457C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:41:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03FFD4067B;
	Tue,  7 Jul 2026 18:40:39 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id A2CE340679
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:38 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso8827142b3a.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442438; x=1784047238; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CNn5U66sHAOay9PhBXcEHoTF8CEV3CRkGbjeHbUwHn4=;
 b=BNstzkcyHs0lylv1Se2nro5AwOZE+F1kABMuWxgBW8XtbSv+PViJIdCV2caUOGJMSY
 MeOHQHfue4ysXYCqENjxKxHu8vLjmhsnRtKEnnII2GmC77UvRENwjCDcwAAGxEwGHENP
 bWmxemSXOWAaezKGL3HXyHqeB/nqovhsjyg2UBITlsGJsPL3Jq9/rLZ6BPFmbLnPQwY4
 NpurkVjMIxXUDSmZVdlRoWf/vFoZLMrq6mBq3EuiXYfzJhmUwmvhHXTMdAazXGV3i3Dp
 A99fRv1LK3zcWDCZ3rq7obOq5AlM3Nw268VCoEFUS+OtbFs+nNENanFu0Du1B3wVKE6t
 zJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442438; x=1784047238;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNn5U66sHAOay9PhBXcEHoTF8CEV3CRkGbjeHbUwHn4=;
 b=modjQ7DmnR665zF1RCPvh/roPTOM/TJ8m5VirLBjBGWYhF773mrssvKxjM/a2qCG1z
 eqF8xYOAKRJbtcNxUvGyE33pnyfbuV6HNR683TI4EE6YoNrobSDA/3dunMjd/vScCykD
 /UGQRDnLjzhv/e79JrOLhJBpjKJjR0iyeTRacyJNK9eiy0GKpzgIodvHRMtcH+8M5GFk
 aSfihjbSvEEdSCspIAda3/jsjsvdP70XQFDECv1AK8i6xl9msAgiDlooR2iKyFa1jyZy
 87JJMIWQbQf8aAzRKAPzKRcRs3aN48Xn2u0uMBc/3MXeB4IhlAhyazB3lki9/o3j6UoE
 DYRg==
X-Gm-Message-State: AOJu0YxjluTKcyLALCNgyY3U3VECT5WIsR44i6SRDeAvqCpXWjX8V6hg
 Co/HYXS1XnoM8RCT4kSdG1khDCTPa/AVVte14nO5k+Fihu2QRWukx0P8W8kX/hmWWttVHcx8Tmy
 ObbqoBxhz90R9+Q==
X-Received: from pfnn24.prod.google.com ([2002:a05:6a00:2b98:b0:847:7d90:188e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10c6:b0:848:2f77:e2e0 with SMTP id
 d2e1a72fcca58-8482f77f32amr3140982b3a.73.1783442437562; 
 Tue, 07 Jul 2026 09:40:37 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:18 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-9-joshwash@google.com>
Subject: [PATCH v3 8/9] net/gve: don't reset ring size bounds to default on
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
2.55.0.rc2.803.g1fd1e6609c-goog

