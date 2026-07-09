Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC42BC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0421440B98;
	Thu,  9 Jul 2026 06:08:00 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 78AB540A89
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:57 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-84842381150so690631b3a.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570077; x=1784174877; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=544ErnmFizHTKe25o84roi8tCu2qyn4KkT2qXxOD2L0=;
 b=kjwR0dnMsAGeWEQbUIDaHCAUsNMVtsIeaGeZK0R9aFgTSXotrBH9shM5OYEMCv6qXG
 1+on0HRS9cLvIc4z1JHH3U46QN8Hi2Uh0ixH2akuD8zW3KONkc7nDMdy6N3Haj4QN3WD
 UiaD6SRxEgLmQ+rkeQSvj5zNzjmZHTyvrzFDChO5FzagDxbl8JRpXnrop8LoSN8IL4y8
 PrhTyvXLfonY+PWKdk2pAZ7hif1k3oPOFIDE++w2g8/489jjIhSZaT88i1LoW/BPuvRD
 Khmf/q7+SXyneJWL1TMZFoHCa/YvNkcc0e8URlzj5erQPYDRFVUyM0ZMtN63+KhFYqZn
 ZQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570077; x=1784174877;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=544ErnmFizHTKe25o84roi8tCu2qyn4KkT2qXxOD2L0=;
 b=e+WDKQRF9aDcNCsmwGxuIdeaFvsai9ukP308PSVMmtf6T7hv2CXtWOcYXa00qd9txo
 NcW3dTc5qULSztB+qx3Lm+A2/pqTXtVJO5QASJQEJQYCyL931Zt1kcDgQML/LtLaBJgd
 3WUBhirQzrajjiX8SCEGdTjPmdVn2nnlygYDIwTfUdf8omAvNkRRaMKbxQvduIjRnQ15
 fsUQGWSdHKQDisFurzq72ebzGGB//bjy30FHiW4WIMte7cwwRJI5lr30yECxAYQAMOmy
 vFrnLkyBoS1rYWRyTJkW0gAqdUorC7sXuxN13CatyIh3Sv1NNkQ+cVwZ0Yy2AenFpwAQ
 6F2g==
X-Gm-Message-State: AOJu0Yz3CoCjy4rPNsnMbayoieUMV3GIwkC8roU59h2ev9067Z4/ZScW
 NXyKDdfYoIuA2lScvgzIEtseTdO/WPAiZujxKG/AqrFagQeezyzcagpKLJ4i1s627cFHAmEeO9L
 Z8jRe+gqEf3z5bw==
X-Received: from pfwp39.prod.google.com ([2002:a05:6a00:26e7:b0:848:2cfd:8fa1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a256:b0:848:2f6e:e52e with SMTP id
 d2e1a72fcca58-84843027855mr5196952b3a.66.1783570076306; 
 Wed, 08 Jul 2026 21:07:56 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:36 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-9-joshwash@google.com>
Subject: [PATCH v4 8/9] net/gve: don't reset ring size bounds to default on
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
2.55.0.795.g602f6c329a-goog

