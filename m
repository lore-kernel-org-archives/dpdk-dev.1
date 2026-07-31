Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8752C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE9BA40A77;
	Fri, 31 Jul 2026 07:00:04 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 2A6F640151
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:03 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso527604a91.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474002;
 x=1786078802; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXfyXLy6OUjoEhM8oMb1wm6XoMDgVHDHJy8P9wKoggo=;
 b=IdmGgS0wZbNupowHcBWn7Z+Lc4HoQAent+bK/W7juNAXuFkeGHaiJsclHX+52PNywz
 ra9Y3aEejf6IlkAdgiM+miLchrlyv/jFmYPbRG57kNEIZToBYF+u5gIBdhoNmM28+SIw
 JKS13uWPyyVlAZh4nRXRfjtmffJYEKxq2Gz21Amv6cPQUVr+KF+UL9SipMBrCD8hQnWf
 mg5XD4kZTn1lGeXv57f1qigkbNP1criMfrmDZB8KawC9Oqtxaj883wOjWpfqKkWKOnt7
 9QzcQsQzB4mgeA/7ZJ2SLc8i7gAxt11BuzJxq7zNIHVcW809okL9Tqc8g/QuZU2bgfob
 +XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474002; x=1786078802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXfyXLy6OUjoEhM8oMb1wm6XoMDgVHDHJy8P9wKoggo=;
 b=kE1U4i7YajebCf6WZn7PqiB+dlyHF484Ma+hi8lMZZQ0jbtE/0wpLlu7VvMtZ//88i
 cc6pvemqhOoy0bvq5sZevjHDbZUJ4qz4xCVtQpZyxt20bWWiwFuz5m9FLMgkSe41OCUz
 Ga1lPbmdQ/ruoQznBJQj3n7R/aK4fI+DiNSqp2EnGqVtDaJa8bsSfUJJLPZJfrMVF5FL
 d41hC7NT6Ez5MRJG4tVE+tbLWoxWv+epa0uQo8R2KtN/AJHwBL+0Wj/OzOzwTWzKDVhZ
 8coFZi45pPqJqF8XeUhuF8ugAH9JqG9DRUNiKcPVasFwFUAKwUs8V8fuuWuzK6noOpSm
 ugFw==
X-Gm-Message-State: AOJu0YxIyyTKIwckJ1uYstOgPjFXzLQyFM/ZQtggbM5lx91tGYLbwyQ3
 12pSAjdWNQB6i6UAMrkiZ6d8fEcLs/MiaBYdCNXuSTwKirLMk2F7Y1BP9+P/KB2a3itK+8GXFnG
 Uzvze
X-Gm-Gg: AR+sD11IFnLHWNVJAVL5C7xkp1V/nYsF74RWUINmXMfQcP5g47z0ysKjtXE3sQ74xRp
 HjPirCC7gNadxnJ1RcZlh+/6jS0PeSAv+EcV+Cp2MGaEj0G90CsiZzs5ais2FFcHL9winZikJQa
 YzcCY6x9fAvdPKsZyEUVS555qRr1fBaYAMLLPk9rB8tY0mmVmJRZVgpansZa0HfGzfDl3a+5bRZ
 KEedCkweuXAQU39GBzuHTcg4IcWqNSYqGocxu+9qf5C5+qhmSx91UwYN/i8M89Ej9pJUv3HC75N
 UlH2NSsShdGgi/d//XbA2aZQLh+ZbRJDo2tEEj6xU3he5PUSpCR3cwxcXxfN94vmqFdkoDE9u4R
 SAuoHzG+gBqeeSaX9HO/ICgY1+au0eoxN0BVDA0g/Nnfx/ok40w7iocRcCpAnIa74G8URCEWR3q
 4zpzhVO220ji4oab/n+SdYl3Z0bbotWryg3DM68HUXXfOUr4M/nehKnyja7NJHo1xmU/2F+CKLn
 e910dTzaO1NMxfaatAgjowNXm8=
X-Received: by 2002:a17:90b:5843:b0:38e:baf:6087 with SMTP id
 98e67ed59e1d1-38fb147fc57mr581525a91.35.1785474002179; 
 Thu, 30 Jul 2026 22:00:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v6 10/24] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Thu, 30 Jul 2026 21:57:48 -0700
Message-ID: <20260731045948.769926-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

This is simple inuse flag which can be done with stdatomic
exchange logic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/qman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d289df2d33..ff56f7b1ab 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -11,6 +11,7 @@
 #include <rte_eventdev.h>
 #include <rte_byteorder.h>
 #include <rte_dpaa_logs.h>
+#include <rte_stdatomic.h>
 #include <eal_export.h>
 #include <dpaa_bits.h>
 
@@ -683,7 +684,7 @@ qman_init_portal(struct qman_portal *portal,
 
 #define MAX_GLOBAL_PORTALS 8
 static struct qman_portal global_portals[MAX_GLOBAL_PORTALS];
-static rte_atomic16_t global_portals_used[MAX_GLOBAL_PORTALS];
+static RTE_ATOMIC(bool) global_portals_used[MAX_GLOBAL_PORTALS];
 
 struct qman_portal *
 qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
@@ -691,7 +692,8 @@ qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
 	unsigned int i;
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
-		if (rte_atomic16_test_and_set(&global_portals_used[i])) {
+		if (!rte_atomic_exchange_explicit(&global_portals_used[i], true,
+						  rte_memory_order_acquire)) {
 			global_portals[i].config = q_pcfg;
 			return &global_portals[i];
 		}
@@ -708,7 +710,8 @@ qman_free_global_portal(struct qman_portal *portal)
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
 		if (&global_portals[i] == portal) {
-			rte_atomic16_clear(&global_portals_used[i]);
+			rte_atomic_store_explicit(&global_portals_used[i], false,
+						  rte_memory_order_release);
 			return 0;
 		}
 	}
-- 
2.53.0

