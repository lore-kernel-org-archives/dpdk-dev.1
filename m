Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387910AB82F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC0342DA6;
	Fri, 27 Mar 2026 01:19:41 +0100 (CET)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 49E0E42D99
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:19:40 +0100 (CET)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2adef9d486bso29254975ad.2
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570779; x=1775175579; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RDzJfqQ+E3zMfftv+s9GtKdAsZQj38jM96xJ1ryeZt0=;
 b=Bdj8nHkb7CndwCg04glmmL1LTPMJOGqdRnlQsSsUKwdNGjZ2p0D1OpWoOzzNhoz/uU
 QtqrqdqYpgjYcrlKkfJtVtKCsESZzAuNGMiu/mJKAUIhLJSRXm2dkfBLi62RV3C7FxKJ
 6drXH872i57hdfA9pYBWPLvNtLbdfwMliiaQFsMrpJPagz53H4kn8+xOGdQfN5dPrlKY
 h7OCFh6uzpvh5HM6pM4WERTw25STy+80/hxyrgj2rf7Q39KwJBuVRDvfM/xWQTvXNRra
 tiveRElHWCy/r3qkPCrvht9n0XsXptlI1mGGF3mjfYDy+uDOzp/n3sroOxYB6Kk15kdS
 Midw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570779; x=1775175579;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDzJfqQ+E3zMfftv+s9GtKdAsZQj38jM96xJ1ryeZt0=;
 b=bKPiWNVzOh+vQOL/v/kyHnbsJO/whUIlKkXgFepKXvcIeyfqAVEHDPRT4F0N2/6asL
 E2ORNUxJxbklpNA05RwbyD2UoGLd4+V189MOe2gPjAxtli/73t55+XuxMAHyD+r9KQgA
 RQ2T24ptguvfY0wKpo56Ti3CMB9BNY6+Mru+Y2a+o+lfxUpTOvwTNKRirBnI0wqdsdcz
 cwSABmlTnxrGi6yqI1IUTazXa9gth6gMc/8NgLamLh2Ev3HNMGlZKOFBlp1NPFvjKMJr
 viwVVNtkiAdKCXuuC+Ey/W1iEqSSUZowsxB88xwOEJh0j3Vf8cufhflBz99S9+Qp7dMx
 zk1w==
X-Gm-Message-State: AOJu0Yz6BqdtRqxO1/vib7rlxbxAhYeijG5iIKaroAPerOrmaCVfyKtL
 nrNQl9lWiEYmL4glXQpgi9bkyRNNajUfDbf5tZUOmuCgwzujqVfdSIYke3QnPonsPW3Vkwmhhn6
 EieYc6Z7g+I+fWIQ6lIW58kw+ww==
X-Received: from plad20.prod.google.com ([2002:a17:902:e154:b0:2b0:5bea:23ae])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf0b:b0:2b0:5e63:fc45 with SMTP id
 d9443c01a7336-2b0cda03c19mr5705475ad.0.1774570779219; 
 Thu, 26 Mar 2026 17:19:39 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:18:26 +0000
In-Reply-To: <20260327001827.3385001-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260327001827.3385001-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327001827.3385001-4-jtranoleary@google.com>
Subject: [PATCH 3/4] net/gve: add checks for flow rule struct padding
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

Enforce struct size matches at compile time to ensure we do not have
unexpected padding added. Other admin queue structs already have this
check, so add it to flow rule structs as well.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_flow_rule.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_flow_rule.h b/drivers/net/gve/gve_flow_rule.h
index d597a6c..bdf2955 100644
--- a/drivers/net/gve/gve_flow_rule.h
+++ b/drivers/net/gve/gve_flow_rule.h
@@ -41,6 +41,7 @@ struct gve_flow_spec {
 		u8 tclass;
 	};
 };
+GVE_CHECK_STRUCT_LEN(40, gve_flow_spec);
 
 /* Flow rule parameters using mixed endianness.
  * - flow_type and action are guest endian.
@@ -55,6 +56,7 @@ struct gve_flow_rule_params {
 	struct gve_flow_spec key;
 	struct gve_flow_spec mask;
 };
+GVE_CHECK_STRUCT_LEN(84, gve_flow_rule_params);
 
 struct gve_priv;
 
-- 
2.53.0.1118.gaef5881109-goog

