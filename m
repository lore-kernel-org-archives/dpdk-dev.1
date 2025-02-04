Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25DC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61123400EF;
	Tue,  4 Feb 2025 17:55:30 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id DCEEC400D7
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:55:28 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-21680814d42so101360575ad.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738688128;
 x=1739292928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AYbQceKeI3jarB5Hu5dTAcTcjAtI7HYYfaftjtKczsU=;
 b=YeFfn4hfeT1NIMaibTkFdGclgT6gQ8JAcKRqNJZIfgw71itR+O5ZKqGNM6JwaUMYDj
 rCn9my4zV/u/oJyqbMmcULAw/050h49CHrRxMK2l7Rgcu4rpruM/WafkwTEtCzOrKs/L
 6E1eL3+yo4AY+G7zMLXCYtLG2tJ1zCTV5CKmdLrWDe2x93n0kHjDaS8UWIJryV+e87pW
 0RZVtGXHDWab+QYrp7UDN28bV8Que5+050scNoiUTCOR6EvwAYGAv9awp1JwdAlT1p8q
 CDlEAGCkNmGrR6eCgBn/kiD4NuDCeNUb7k2cgQpwLY7+9j6t0l4LE48DmmXV6Dh7vc9E
 H6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738688128; x=1739292928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYbQceKeI3jarB5Hu5dTAcTcjAtI7HYYfaftjtKczsU=;
 b=dWU/AstP3CnVHQ3v2WoHDxCbTnkTG03d/SE1lSwiR8phVOKvZ1W0X7K+z1Y2Sb7yyS
 1CXmHvIzb19Bq6Emb83V+OOvj/Hxz91eFACxUlxQIvwPVNQtmW8kpoCxd1DT/Eh3sdlA
 rzerkhiNGvGEPxPfzf5ZZIVgPpCtKD+soTyjNoyQSKfylOilC6ruTNzw/rzw2I/rxSFo
 pbX9yLX3cXaIopepfCJ707oAK938VVSklfiPZsclWirBzCrb4Hr2FsDN/OzpkVq2J3uH
 Ki3Nq+SRXz51TiDywhcei2pmIXhbSFGXxIBZ1zctiu3pR0I4zwWMIctZ8xPefEvhoWD5
 UiUQ==
X-Gm-Message-State: AOJu0YzJXq+hcJ7M1fxLSeVH9mHLJSLEQIHPtkz+54kVFwJVHkLZBTS0
 RN/yRuiK6InYTYtXd+kcJHd9KLe0P1/BjP4x5k7KIzoSJBEuvtVi4vIfTy2tkwzlXJ4GiRy5Wry
 K
X-Gm-Gg: ASbGncshnU9qkBK+DZIYd5zvKu1trbeMsWAI9Oo+wiODMojKGuzh1wSMSwu/RcoZQuO
 Z21Axf+XfkP9WN7sDTdh73b+31WZdqmNvj3EnCykkUg5l41l27Lh8TWvXDd0YbaSyNDvsH00j9h
 KZTvbBmhVCWA9Dxn1VwpQExvE6sS4ldIIAGhkEtZWGMQGlUS9N/RBXIA/ray41DyGN2LsQG2hbW
 GsgF6udA7haI6HY5/znB03atiTGaSAySaDS3yW7/I+hnFOp+mau0aXLeF9RThKrbAfm+3TlLGEg
 pfCMDdqSZhssxAAFl6DxiKjI1AhoDLmZIhvDrC7BYcpUEBDLpUk74yZ813zVEcZGkTJu
X-Google-Smtp-Source: AGHT+IESBTiTMKTDF2wORRJXMIYLUX22kN+HW6uDUB4Bu4CcUVce+wnHBRN023FkClJgAuAx8BsZ7A==
X-Received: by 2002:a17:902:d48f:b0:216:325f:6f2b with SMTP id
 d9443c01a7336-21dd7d74dbcmr432535925ad.21.1738688127176; 
 Tue, 04 Feb 2025 08:55:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de3300880sm99677475ad.168.2025.02.04.08.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:55:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] eal: force evaluation of RTE_ASSERT expression
Date: Tue,  4 Feb 2025 08:55:16 -0800
Message-ID: <20250204165516.168106-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Even if RTE_ENABLE_ASSERT is not enabled, the expression used should
still be evaluated to check for compiler warnings. Use sizeof
and ternary operator in same manner as the assert() macro to
cause the expression to be evaluated but not generate code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_debug.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_debug.h b/lib/eal/include/rte_debug.h
index 74593cd4d4..357dbb09ec 100644
--- a/lib/eal/include/rte_debug.h
+++ b/lib/eal/include/rte_debug.h
@@ -43,11 +43,17 @@ void rte_dump_stack(void);
 #define rte_panic(...) rte_panic_(__func__, __VA_ARGS__, "dummy")
 #define rte_panic_(func, format, ...) __rte_panic(func, format "%.0s", __VA_ARGS__)
 
+/* RTE_ASSERT is optional checks that only get evaluted if RTE_ENABLE_ASSERT is enabled. */
 #ifdef RTE_ENABLE_ASSERT
 #define RTE_ASSERT(exp)	RTE_VERIFY(exp)
 #else
-#define RTE_ASSERT(exp) do {} while (0)
+#define RTE_ASSERT(exp)					\
+	/* Evaluate expression to trigger warnings */	\
+	do {						\
+		(void)sizeof((exp) ? 1 : 0);		\
+	} while (0)
 #endif
+
 #define	RTE_VERIFY(exp)	do {                                                  \
 	if (unlikely(!(exp)))                                                           \
 		rte_panic("line %d\tassert \"%s\" failed\n", __LINE__, #exp); \
-- 
2.47.2

