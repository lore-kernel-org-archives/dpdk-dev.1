Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F001CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92D8042EC7;
	Sat,  3 Oct 2026 04:52:00 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 145E242ECC
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:59 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso1305005ad.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995918; x=1791600718; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ofh/T44HDL8IePOasEwfSDYcmWNJjWHhAJMb9+OMZ3s=;
 b=KjAo14ecTWin7XLOJo+FMn7tTH17vPolgrgNeRgx35wA4xVHaqOArn/SPf2EEK3Qve
 QRZtLKZF0UzTsb1tAZM2A685XU9n2WrDWQK6KcgL53bXnI4xebELWnQyut1THaYtAMzc
 v6YGqae1lrroTEexCLJfqav8xoRmnRxAO1OMEM1NALRINxnVuiBzmSpVNRg/Wlq8C81e
 rj8Eob9X2DX78Cj6Y3/MPha3dTwndmTit8Tw/7pg3zVQcAUibnQo6oanu/iQio3cM/lW
 UySMycwE1pXydYGfzH0Z3a9TG1jKdQptK7Jaehb0+6DloimtASy+lE3B+uKrV+tBHWKF
 4cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995918; x=1791600718;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ofh/T44HDL8IePOasEwfSDYcmWNJjWHhAJMb9+OMZ3s=;
 b=NlpQQ9xouN6VaJ7BVFXcteOfhNmqGhrQAFdB8V3ZYmESm1uUtRAX/3i37deI9zxiHx
 /SFHtZhmirQB4dc8K4PICkr+dSscZjvDkLsmR8LY4teRSU5dhsAj6uvVFnMT3Lu80ls7
 9Av4X+d9baHV0vULoxdNbC6+DvM2nxb5pCn+H5xt0t6fo0BnjqacR926Wk0Y5fjSdBYQ
 TlLq40k32aVsTGFHpwBCTYtRwLGpEHh3/7udqS1cZmSOQEVJrzOuhGoNOTs+yuUkeBMB
 D6SVWioPUHa2yn2DLMbI7bwQnyWN/TT6VSCj5udw64h0Pryu17yr2ngJ9QZU4XTxu2tv
 EqcQ==
X-Gm-Message-State: AFq9FYJc7hfK6noe7rD55UFQv4IEA8X5uc/S7fls04+lxHW22KXjF9e4
 I7X6l5DYXbRWdh6UqNPAtvj07tM2uo+9qQh7JLIHhEo0B6PW4aW14t1bwjCiBFTmwnIACxYPmbv
 0QGdqPop6oi1AzQ==
X-Received: from pltf10.prod.google.com ([2002:a17:902:74ca:b0:2df:8f31:620f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e802:b0:2dd:ad73:c938 with SMTP id
 d9443c01a7336-2e49b60b66amr38430815ad.25.1790995917891; 
 Fri, 02 Oct 2026 19:51:57 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:39 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-8-joshwash@google.com>
Subject: [PATCH 7/8] net/gve: fix RSS config memory leak on close
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
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

From: Jasper Tran O'Leary <jtranoleary@google.com>

Free rss_config resources during device close to avoid leaking
redirection table and hash key memory.

Fixes: 7ba84453bacf ("net/gve: free device resources on close")
Cc: stable@dpdk.org

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index fd77b5928a..5a2f95ae19 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -723,6 +723,7 @@ gve_teardown_device_resources(struct gve_priv *priv)
 	gve_free_ptype_lut_dqo(priv);
 	gve_free_counter_array(priv);
 	gve_free_irq_db(priv);
+	gve_free_rss_config(&priv->rss_config);
 	gve_clear_device_resources_ok(priv);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

