Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8376606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aSJcTmqu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF25940E0C;
	Fri, 30 Oct 2026 19:43:17 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTPS id E7DD040DD1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 19:43:14 +0100 (CET)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e8e16d22d8so15899705ad.1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793385793; x=1793990593; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fRtCZYRCe1qZCLFKnXp+LQ9yY6llnNURsUpXh9hm658=;
 b=aSJcTmquh7JVsPB3k4I+ta8nuYMC36bhrsD+8o2bGjb11ZkF2XbywBFuEMwQLub5uS
 GPfvxi/owI6jXHck7bSYXP66s3Ar7D9rcEHHHx7mBItk4Dqsrjlr7GgRsaMKrpIF9OQ5
 9z+1XrraeJAZs6ZoXssFhbW8eI90fCuYiWk7AkdzvvnjKNxKnqmgkrdK/UDBmqIomcEn
 A7FuUVPALOCAUDE5HLLjb7V4bkxrBk07afdFoU0xp6JwDieP4Q4wqUIZ73gdMs9PUhtR
 MkyqEOAJ+GfOjHdfr/JjCNvp4c5QgMGQiwRxdUFoWvUxNwlxiMiSxjVI3wlG/mxC8dvQ
 nJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385793; x=1793990593;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fRtCZYRCe1qZCLFKnXp+LQ9yY6llnNURsUpXh9hm658=;
 b=UhdbYusoghM246/O6wXLaZ0QuAeig7KjSTPP++0O6YLhImBEG0PiWs6uvabVIH8hF2
 6y5ZGLnMusxp6BNzd3Hjol36mFetUtToiDeRiizypU4kUg0gc15D7/WDOFZOaXDrujar
 TE815ikp4+5halSihahRdYP1jW5OtJt0QKElAubZhV52dPM35JtYBZ6zyr+5wZ+nKK/x
 /hTcmw/6V+4uszrlVet2sgBHSgNsp1dCm8dQPF5icmwgvNmpzwgfuX4frnHTSctPQknA
 7yHqTfLwXCIoA0IJuoxe3e/S8kW3Bf71Ff1IsKPAHaiRfYXZJb+lHu1bQ06Z6O5chnr1
 YTgA==
X-Gm-Message-State: AFq9FYIaZLGQU2eaL1U8LCtGYAYC4S4OUBY6aPLD9jTgfhLxEOYUAhHW
 A92dGEdf0jbN+TwGMeWUwXKxDgSB4BblfPs1rnPSzzDUnNnZ05iQCIdeh900PbwqM6kYNP5JuEL
 FxxraRZRctTP8wQ==
X-Received: from pllw6.prod.google.com ([2002:a17:902:7b86:b0:2e4:8c0e:97db])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:2e9:3d65:22f1 with SMTP id
 d9443c01a7336-2eb36493e82mr34930395ad.20.1793385793288; 
 Fri, 30 Oct 2026 11:43:13 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:43:03 -0700
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030184304.508282-5-joshwash@google.com>
Subject: [PATCH v2 4/4] net/gve: validate minimum header length for TSO packets
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>, 
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>,
 Rushil Gupta <rushilg@google.com>, Ankit Garg <nktgrg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In addition to the limits added in commit
03b62d39c1c8 ("net/gve: enforce DQO TSO header and length limits"), TSO
packets also have a minimum header length of 16B. Enforce this limit as
well.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Fixes: be8f0eb81f98 ("net/gve: fix DQO TSO descriptor limit")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_desc_dqo.h | 1 +
 drivers/net/gve/gve_tx_dqo.c        | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index b7d8b27d68..5d51c70aa9 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -14,6 +14,7 @@
 #define GVE_TX_MIN_TSO_MSS_DQO 88
 #define GVE_TX_MIN_PKT_SIZE_DQO 17
 #define GVE_TX_MAX_PKT_SIZE_DQO 9728
+#define GVE_TX_MIN_TSO_HDR_LEN_DQO 16
 #define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
 
 /* Basic TX descriptor (DTYPE 0x0C) */
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index d6ed238849..45f5a79b2e 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -139,8 +139,8 @@ gve_tx_validate_pkt_limits(const struct rte_mbuf *tx_pkt, bool is_tso)
 	 * contained in the first segment; the payload must not be empty.
 	 */
 	headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
-	if (tx_pkt->l4_len == 0 || headlen > GVE_TX_MAX_HDR_SIZE_DQO ||
-	    tx_pkt->pkt_len <= headlen)
+	if (tx_pkt->l4_len == 0 || headlen < GVE_TX_MIN_TSO_HDR_LEN_DQO ||
+	    headlen > GVE_TX_MAX_HDR_SIZE_DQO || tx_pkt->pkt_len <= headlen)
 		return false;
 
 	return tx_pkt->pkt_len - headlen <= GVE_TX_MAX_TSO_LEN_DQO &&
-- 
2.56.0.317.g454f8302e1-goog

