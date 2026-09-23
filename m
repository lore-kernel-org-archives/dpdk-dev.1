Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E72C982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8543B42EE3;
	Wed, 23 Sep 2026 03:08:06 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id D34BC42EDC
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:04 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d959904658so4386105ad.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125684; x=1790730484; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HVHXD8ETiWX5IK9R9g12FoYDLx3DjB7xrU26iS/JCSY=;
 b=XDut1Vpg0r1HTbTV4uI6sJWATkDfvoe64Ky9FL5CAu3ljx9u0cxPbz02zLUwZrbntv
 u789NP8p6PXkA+fOB2fdEpxGPUmoJso6QetesHo4AeaREXkF6kSLvwQ4M4/Y84QAQeXm
 KnjEFZ7+d2evu9XJSg99jeSlQvYk4vC0SRWvrFpZoSINo/N9PG13/uVPW94wjoXcJNTo
 q6aJ2CggqjVL9WCEi/gW1wGyofobK1ETQGHOfUbFkrDWTHfVg0/jZrRU8O7lrgzbVFf0
 bkbsZj7+TGhRFX/rhYrjfALff7z8LpTPlQwq4FeoD4VxywJNRE5RHdCEuCT7tpaLgVtv
 e99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125684; x=1790730484;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVHXD8ETiWX5IK9R9g12FoYDLx3DjB7xrU26iS/JCSY=;
 b=kYQ14MBIEaX1/m5ElvduR/tN6dXjVbvZg5mbmHjdBeeQBJu1qgf9fBgzBqGCUN/rc9
 YuTQ+4l9aGC7cqeAbyNqyKvSNYepOtzNLsofmqWcOvrGT2wm3n/oRFzg1v476XowjCC9
 O6UwuBAztA5bmKpEZJzKoUnWCZoYIRCs0WhuJRnZkUkEZdfAao/lt4yS6FCkQUikzR1s
 wJsMs6FdIv2UnKFDbZkATyZVZrrlmySs9rqS8G2We5Y9Bg74wCxH8CNGyLkoQZqrluG4
 hqv7klk2W62jkFLaLEtpOKfFeVStWN/hWkRy3V4FevOIfuIVGupFthgKH5HU+TEotZIb
 8bJQ==
X-Gm-Message-State: AFuF++k9/l8FrA0D48Iz4kqP92tG0maYeh/RLUun6fQhFP6qLJjDfkZV
 HsWivs9avglVc3kBjgZvvLImOM9LdAu/n64raeFLSBPVRdv2m07FaEeLZge2IXIMnRhGhYtdUc4
 NDSas7rFrpp3r2g==
X-Received: from pldu17.prod.google.com ([2002:a17:903:1091:b0:2df:49dd:2a76])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a67:b0:2dd:c100:7cc8 with SMTP id
 d9443c01a7336-2df69e0af0bmr9949035ad.68.1790125683812; 
 Tue, 22 Sep 2026 18:08:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:34 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-12-joshwash@google.com>
Subject: [PATCH v3 11/16] net/ena: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - Leave call sites in base/ alone and map DIV_ROUND_UP to
    RTE_DIV_ROUND_UP in ena_plat_dpdk.h.
  - Remove extraneous blank line in ena_plat_dpdk.h.
---
 drivers/net/ena/base/ena_plat_dpdk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index c84420de22..ec47c885b1 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -304,7 +304,7 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 			rte_write64_relaxed(*from, to);			       \
 	} while(0)
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP(n, d) RTE_DIV_ROUND_UP(n, d)
 
 #define ENA_FFS(x) ffs(x)
 
-- 
2.55.0.1082.g2b9226bbc0-goog

