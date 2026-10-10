Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB2CA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 00:59:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 610CF402C3;
	Sat, 10 Oct 2026 02:59:49 +0200 (CEST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTP id EB855402C3
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:46 +0200 (CEST)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df8484f12cso5212235ad.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593986; x=1792198786; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=36RG2Se0nPif7iScLJgcWwdLyjgpafvTsbbbJBDLfSo=;
 b=mpGOYR2EN45HZIJ4zal7sbCIKhrRnHkRyocXsk5K+WyFYBz5gI4hn5gkSHWJylEC7R
 79vhnufF1MQDplkhsc9PBq7rQ+cC4roCKbbG1QkKYgRfLlFTBSrxSnZjcswt8rqE6JTy
 mpG4Vh3bgx9SLsocJhIeyEo+so8rzGXeUDrk7W57Ld0dJHGXF0y1khWTMzLeqiZAdGzk
 JoG7M5lSy3N8BLaWIKPQ44feSwrg06QYbMayzdJFpjERw5aLEv/i18mPLouoWcQID0cq
 /vx9nElxSZX38s4VNAXp7uDqa4lFrl3qzZyFG007jR382irFy9cZI08TNlFJyA/8jycB
 3zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593986; x=1792198786;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36RG2Se0nPif7iScLJgcWwdLyjgpafvTsbbbJBDLfSo=;
 b=GnCnVBaMbU+AQRg71cfGzwYO7G5qvaNAbXd9frlQL+oEH4gQDtiEqdvPcLsEGbbFFn
 UCSDntHGeuCDh7nyuuQN8qY1qnye02/ECVDKOXL9uCGMO354m2pOuo1oIWbvhngJ4hFM
 k9qr+lewh+1zm9TZUmv2iIqOwhPVuH/Y+HCRvUNefvQtenJemihUH4Bi5SJJGM0Kpet3
 nwgI2U28OvPlDQ1Ot0KojICEnJX98MpUVUVIv9eFmBt5giTgkx3zWPCji8Zb8r0zwGSR
 zcVqHf2yFjAENvufsEGOOT2VpSbbrwfv00sqfK1LSXqgUO30yJk8vkng4KS3i+BQVf9c
 fOfQ==
X-Gm-Message-State: AFq9FYIYdR8JZnBymWtTfhuIobKqcRqv6lRpllGgYIATNxW/yq5YWk33
 nD//Q1XO4782XikFyvbDFg1ysFYcKbeOeG5exs4QwBHmcbNgUx1PUAC2QS7JG8ecX6FUNkk7bVp
 Dj8wErBsGXXUTOw==
X-Received: from plbjf13.prod.google.com ([2002:a17:903:268d:b0:2e5:9026:72f2])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e811:b0:2dd:ad73:c988 with SMTP id
 d9443c01a7336-2e842bc7f91mr27011735ad.32.1791593985627; 
 Fri, 09 Oct 2026 17:59:45 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:33 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-2-joshwash@google.com>
Subject: [PATCH v3 1/8] net/gve: fix RSS config memory leak on close
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>, Rushil Gupta <rushilg@google.com>,
 Jeroen de Borst <jeroendb@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com, stable@dpdk.org
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
redirection table and hash key memory. Also, memset the entire
gve_rss_config struct to 0 to avoid leaking RSS hash function or hash
types.

Fixes: 63ef54569760 ("net/gve: support RSS configuration update")
Cc: stable@dpdk.org

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - Clear out entire gve_rss_config struct when freeing.
  - Reorder to make this patch first in the series.
  - Update Fixes tag to earliest commit with the issue.
---
 drivers/net/gve/gve_ethdev.c | 1 +
 drivers/net/gve/gve_rss.c    | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index c990920a4d..80623979a8 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -699,6 +699,7 @@ gve_teardown_device_resources(struct gve_priv *priv)
 	gve_free_ptype_lut_dqo(priv);
 	gve_free_counter_array(priv);
 	gve_free_irq_db(priv);
+	gve_free_rss_config(&priv->rss_config);
 	gve_clear_device_resources_ok(priv);
 }
 
diff --git a/drivers/net/gve/gve_rss.c b/drivers/net/gve/gve_rss.c
index 67b910ed22..4084d7955f 100644
--- a/drivers/net/gve/gve_rss.c
+++ b/drivers/net/gve/gve_rss.c
@@ -71,9 +71,8 @@ void
 gve_free_rss_config(struct gve_rss_config *gve_rss_conf)
 {
 	rte_free(gve_rss_conf->indir);
-	gve_rss_conf->indir = NULL;
 	rte_free(gve_rss_conf->key);
-	gve_rss_conf->key = NULL;
+	memset(gve_rss_conf, 0, sizeof(*gve_rss_conf));
 }
 
 int
-- 
2.56.0.170.g584c36229d-goog

