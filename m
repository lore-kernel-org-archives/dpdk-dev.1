Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A4C44501
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:07:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 924B74068A;
	Thu,  9 Jul 2026 06:07:45 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id DC24C4067C
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:43 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so29360865ad.1
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570063; x=1784174863; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=41y4wIsIpuC6IDIkiS38QYAbnUut/LgYJuRiCuOjKN4=;
 b=jZzjSVmOciC4Z5dKZZsVQPkrkdx43k2lAL15DsMIXKlSY20JfDVvVYWk2iEGvkHDSm
 B3X1IYTorG1CKuCQ8Cl8ilSDVHU74Jykrpw0LrD0pgI4tITmetywqNL6m1r8B9Fi4QrJ
 xaeQZluE6sWV2MKwxhsB0M8Qpi8AQz+R5jg6WOwlz5Jt5feXGolEuwHQAWA9KYC3xW05
 tU+Xla5TkPuvrddLUkChUGTrlmol+NwxbSl7bbQCC9kivyLzGjWIx7+LHtF3cO3klQUD
 b8FXde8HuhqLVtzTeX6DGs6QYbJ1dLuBIhj9NtI6OwQvb0LmDeb6K9bzNnxamSJeTyuC
 i+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570063; x=1784174863;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=41y4wIsIpuC6IDIkiS38QYAbnUut/LgYJuRiCuOjKN4=;
 b=HKALnEO66OHyrudgGVBQacxCSXPkuypMN1wk2LP7L3a1yJeQ238i3Mp2DY/DurHiiO
 8lLX8UqqiuR5d2uG7m8OMB6JWdYzTO2o4CcH/2if5DsOfsTpn2egOEcYz1YXCFMH8stO
 sAeVM5Z2epbfJHFvlS1R7HkXv7lWzuXTYAvNM4sfVDVBfww+oqQGGicXO4TfDmQdvimn
 9NW19sDpLC3YgsvfAYsQ+PcRsfmj9kd0kvYLJw+u/vGfg7Aa5CKELMRhAedkYogMTk9u
 biytRjZ7miSHWOMOMxsrLobSNkojDqIbd55E1YZ4mjRaaVp7x+9/ac6q5K84bs4ABANf
 BQHA==
X-Gm-Message-State: AOJu0Yz7W76toT403bfTyXf/NAFZ/jSXudQEVVsPMrd9Wpi7flJEa/H0
 V+OfV+wDoe5qll/tCR6dkCxn98caL4+wwCg4luxiy5IURpwfplGW6aoikZuOpckli4NOTkO7NMM
 Ho+IkUpFJ/j/kGg==
X-Received: from plbbd12.prod.google.com ([2002:a17:902:830c:b0:2cc:8271:578d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db04:b0:2c9:97a7:3278 with SMTP id
 d9443c01a7336-2ccea483c06mr55654395ad.41.1783570062765; 
 Wed, 08 Jul 2026 21:07:42 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:29 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-2-joshwash@google.com>
Subject: [PATCH v4 1/9] net/gve: clear out shared memory region for stats
 report
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org, Mark Blasko <blasko@google.com>
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

The stats report memzone is allocated from hugepage memory which could
possibly have had sensitive data from a previous DPDK invocation.

Clear out the buffer before sharing the memory region with the virtual
device to protect guest memory.

Fixes: 458b53dec01e ("net/gve: enable imissed stats for GQ format")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Mark Blasko <blasko@google.com>
---
 drivers/net/gve/gve_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 0b02dcb3ad..f73784a109 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -306,6 +306,8 @@ gve_alloc_stats_report(struct gve_priv *priv,
 	if (!priv->stats_report_mem)
 		return -ENOMEM;
 
+	memset(priv->stats_report_mem->addr, 0, priv->stats_report_mem->len);
+
 	/* offset by skipping stats written by gve. */
 	priv->stats_start_idx = (GVE_TX_STATS_REPORT_NUM * nb_tx_queues) +
 		(GVE_RX_STATS_REPORT_NUM * nb_rx_queues);
-- 
2.55.0.795.g602f6c329a-goog

