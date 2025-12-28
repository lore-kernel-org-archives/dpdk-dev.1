Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DBAD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44F6F40A6F;
	Sun, 28 Dec 2025 21:20:00 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4C73F40695
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:58 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso16988855e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953198;
 x=1767557998; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IJoXM1x0YqDjKDOjCrbrrJdy/wqMswEGSiJrZQXkZg=;
 b=YumirnujZ+TlEULJkCzzkXH/F9oGEPbWPKIZIauJRd4WM1ubjRGy9m9MIGhVclGS8E
 rGhv8rvDtO5sljlIKzgmoMnvHCtUIuFHANes99NzBCyL+G8zGePUIh2QILa7Yd2bBQzQ
 /l7XbzAFB1+/QEWPQ9C03lUlw/m5nfQkIG8RgNYh+orUBMcoC5e3Zk3WYJkZ9fYeXMeu
 KE5lyE0wqBt6SDtsBDF/Z9z4Hx0SlIwtJ0w54tM/CG7HPmXfEMUZYpNypImYzM5Srqq5
 /AlwsgQDxfgak2XplYNjlc//0g0dbpkqb+F/LthsS8RJCcuTSFAh9ypwacNs3Tj+Nnob
 2srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953198; x=1767557998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IJoXM1x0YqDjKDOjCrbrrJdy/wqMswEGSiJrZQXkZg=;
 b=G2amHY8DxXvERnAs0DpXb2RQW8QXLpmlHTSFLuDJYSHQRiY2xMYUj2K+2F3UTymdpP
 NzG6XEn4LdOExV9zyvYR2Kb4WdzJU5ZNOg39W8zz9nGgyGK8f8y5t9myFxf+hJkelacx
 EuCU7RT4bgndhPlipqOIolyLYgtHYodRPe1/Ffb7Acugz2osRFuWo+Fm59qoQKEZhrXG
 6geJJtuwmqzLgRYuBT5qXrfT67gRM2NF/185NHHck41s77SzniI046UeJ3a8p3nkDJU6
 wwFa5DMLVpNc1Q/xaO3aaAHFg5XFuJ9gQ06mls3Bd9eyJMzeA4WZaMMvUzMHLL7ABPE1
 8bcQ==
X-Gm-Message-State: AOJu0YzdBVCMOrdSCglaY5ZlpLfU2RRPFpe/k2AKRu2m7o/ulVlQQn+w
 z9zLaVtqBWBwRI3yRaWaFOJVeVvGRQrN83vDbFyppq17J5jcBA7HVtDPemHKa5qIJXh6dS8fmp2
 RTIV8nAs=
X-Gm-Gg: AY/fxX5u32GUMj2zV2cs/a4oJD0RU9Xk0zT8qQKRqsbVXcBNfHmNgOHtHL24ZdziFA7
 dbCjMgARpTBQCm1nq712PPAC4CRnFfZNA0PaFv3WbieWeNaYjh0+ylxFltzzje3KzrrF2UUHBd1
 nsJpWvEHJ60x+WzpzFDvPPgxS8jf0TpXEOETJc+6+5DoiIHW8YjWNLtP9+EtgzhEaIC+drBv4g1
 DnNCJmwhxZd+TFT7rJlHgTNJI01QoQKZvilBfePRSNxhTFvIwtWRWA4UeVny2FchuQXQXVTHavn
 gBctnHtPy06Wlzphvr2kvzROL+QlmaVJ4tr8wXhR0e0+J6QBqV50pmvE9DXsC4CLzrIRmgkA8W/
 M2bH10I4eMTUXsd8Zc3zyQLSGCepTbSZWS+BE3bE/uIbYqlY7uxTm3LsF5fbQu7/3pgLbkcfXU9
 ivU8FdTKzwRO2wHNqbASw5j8xKtLz1C1FdR90SVs4D1T33654feg==
X-Google-Smtp-Source: AGHT+IHeZY3vxJy8O4zNKRWoCQh2ieyvo3/6UppF1oei8bT3tL82NiBfOIyVNv0DP1zHAGo3k4Xzwg==
X-Received: by 2002:a05:600c:6388:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47d19557cd2mr320429335e9.16.1766953197852; 
 Sun, 28 Dec 2025 12:19:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 13/18] eal: check tailq length
Date: Sun, 28 Dec 2025 10:56:16 -0800
Message-ID: <20251228201236.547268-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_tailqs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..c581f43b6f 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -8,6 +8,7 @@
 
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
@@ -30,8 +31,10 @@ rte_eal_tailq_lookup(const char *name)
 	unsigned i;
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 
-	if (name == NULL)
+	if (name == NULL) {
+		rte_errno = EINVAL;
 		return NULL;
+	}
 
 	for (i = 0; i < RTE_MAX_TAILQ; i++) {
 		if (!strncmp(name, mcfg->tailq_head[i].name,
@@ -39,6 +42,7 @@ rte_eal_tailq_lookup(const char *name)
 			return &mcfg->tailq_head[i];
 	}
 
+	rte_errno = ENOENT;
 	return NULL;
 }
 
@@ -67,6 +71,12 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
@@ -115,6 +125,7 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
 	if (rte_eal_tailq_local_register(t) < 0) {
 		EAL_LOG(ERR,
 			"%s tailq is already registered", t->name);
+		rte_errno = EEXIST;
 		goto error;
 	}
 
-- 
2.51.0

