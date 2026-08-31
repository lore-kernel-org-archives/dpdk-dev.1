Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D4DC61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18CBC4025A;
	Mon, 31 Aug 2026 10:18:09 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 7214F400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 10:18:08 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so36862585e9.2
 for <dev@dpdk.org>; Mon, 31 Aug 2026 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788164288; x=1788769088; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NyM7Km8ceEx9HJMUarEYGhyM9EZ/CYc3EbUKzo8+qgU=;
 b=CbYHDbcOGKtxf9CQiLDxK1z2jjZXp45p+1UM3Kxw9s3YQyN8lYVyoDrkgQ5IjntKTw
 E2TdnDiwKXAtRfV/YAdMlOCyF+zE3A775cvCdcohKrwx2mrQYb52TlyRpvAi4KGYlnPk
 WS1svCZ/QTrMebRoqbkTOoz97mth81VC/WawHW7C8yQYtpsiqeHys9w0fV20/gP9Z1dz
 +MFHLf02nFX5f/1kRPrQZVuEU0ZqkW3QLv4VBhunmagJ9br9xjjPmI7WyuLaMHSaPTO2
 b9ZAj2HoXBD6hPdGHF4CkAi6/5M7OGSfL9YOWUkguVbJO+Z8S5OacNrYTTGmkyGRlVz7
 sYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164288; x=1788769088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NyM7Km8ceEx9HJMUarEYGhyM9EZ/CYc3EbUKzo8+qgU=;
 b=buvSysip2+syEOWUxoqn6RpF75Rk9W0t6TiUy4MlBztzw7jz9wlTSVVC3G9VCnmIL5
 dXwaCjw4lNq/43WCrRsDajNqSqr7RWELmVH7wpGNbtn7jp0PXdGHnXO2KdrKV0GmSlel
 49H+XqT9DCkgGshwXfYxJcRk11AnaBIpQ4nj1T6N1cqfIYFkT2lEoC+7QHtobA2VerQJ
 RJGRlTBA2GRq2QbKIc0CZKspw42iyJ4/5INwQa5Qfg2OhNljZpMX4L7a7LvmGfeL+u77
 LXfHW6SzKdvIlt38XPUf+LhUY8DWH9hfqKBmbhtwhjRlBPuwFalnGt5DL6UBmVijHgmE
 kRQA==
X-Gm-Message-State: AFuF++k6jzq4nbamzvSgdDRH7JnreO+J0vcSAmAhCB5rPbR1T+UjosFY
 2FU66G0v7IYevziNwDVKSbIEoiwE9tKJgo2By4DO7iyeFeoil1Vl/jVr
X-Gm-Gg: AR+sD13thB3dEldif/yVPfQkIpUDGDwnPpZjMdrwuERr57mRdW2gvVL6PYWY1dL3PFL
 mP4AWEek8AypJQG4UfSEXZkNZOWVNAjF6xE5jzJKEhIXJJeyP+lJse/5PG8L4WKBoMPUBMJ9XI0
 R8XiCGQlB4P6g+eBjRiGbsx8lZleL5MTZ/jjxu9IcHz0hJBUy+HSch5pWA4v0SbUD4uXQD2wNPj
 11s7z1k8UiqAxvqyCIxwsw272CWQFuElByyn3Cdw1lb/W/2VtRy1apziuZTfWdIq4JkAixHqUUz
 6yTIGfzF4tkqSXRI+CuWkJCLJkV1eEqlc9pfJX/p/+IUrznO7iLGyYRuol8sZgtmzr0Hdqo+E9Z
 irV0xVhvH46MBiX/04tsWcdu3JoxmdsZKmBhn9PN40bH9m54klVWFmsugybLevvhQX2g3UMQtl9
 Lb2bi+f2LaBvzJL9Vl68CwHmIx47wSaOGWIWDKf+IRqy9tE2ZbpaAKoCGz864AK1MmNoc=
X-Received: by 2002:a05:600c:1c1b:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49cd94fabb2mr30856505e9.16.1788164287883; 
 Mon, 31 Aug 2026 01:18:07 -0700 (PDT)
Received: from DMUbuntu ([95.214.11.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b963c3c0asm483750735e9.10.2026.08.31.01.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:07 -0700 (PDT)
From: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
To: erinj@marvell.com,
	kirankumark@marvell.com
Cc: dev@dpdk.org,
	Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
Subject: [PATCH] graph: copy nb_xstats during node clone
Date: Mon, 31 Aug 2026 11:18:00 +0300
Message-ID: <20260831081800.44771-1-matveichev.dmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
---
 lib/graph/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/graph/node.c b/lib/graph/node.c
index 1fce3e6632..bb39c616de 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)
 			goto free;
 		}
 
+		reg->xstats->nb_xstats = node->xstats->nb_xstats;
 		for (i = 0; i < node->xstats->nb_xstats; i++)
 			if (rte_strscpy(reg->xstats->xstat_desc[i], node->xstats->xstat_desc[i],
 					RTE_NODE_XSTAT_DESC_SIZE) < 0)
-- 
2.53.0

