Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B225C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 19:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E67240261;
	Tue,  4 Feb 2025 20:48:13 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3E8C14025F
 for <dev@dpdk.org>; Tue,  4 Feb 2025 20:48:11 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-216426b0865so105185385ad.0
 for <dev@dpdk.org>; Tue, 04 Feb 2025 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738698490;
 x=1739303290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ofE4HH9FrU+S7TNc61M5xDtztLUU8khWuvN7/KjUTg=;
 b=hwwbJ0V1liZyvUuBfqhR2Z5AmVnTCblqoBNzgHOl5NF7EeXwXBCe4nrWwaL6PVLysr
 H4GhhwsbZJ1jSwxCVuBkGop4EiJ9vCBtPBkWGziBAYLMmcr29KZXGsXoUEtR/XK4pf3Y
 9Cq+hfjmmrWSnnLSCl4777a74LwJHVmFrZQBBZ5eHmGAJBLvFshCS4IQrXMDJc1xyrtY
 NUHe/lE+sfP41d/xXygX3m8cJ7UsQ3UyXMF69LoWdz7c6nyFl9Gy8hX+1Tvrhe1z7+Gu
 TcQ09qUv/ExO455lyc9f0h3siRiGwC1Fe2tV5kBk+m/nDUZ8P+6k0LbWLmyOEzhCmPoT
 Z00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698490; x=1739303290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ofE4HH9FrU+S7TNc61M5xDtztLUU8khWuvN7/KjUTg=;
 b=lBE1tFbxIGoP8p1bjCU3ynfzwwVzAUYK73m7XhiDGCgWKYcC6JNm0xr9j3054IlwNv
 dEYrATerAovWkUasCpYqBjblk3S/gmLwecdpj/Y9tYlnQYVKLYwhthFul9rVJXE2wP99
 PskaipSJhreSsVIWPyVA8fmFfF4zAC0j46rz6X0B+KA/nx9qcHiRN/lVfSKOgIjlgzIp
 KnCiNc4EIyhw1yEgVPPKLbtEnrwQPWHDbm0jH2/r5LbdkCPYKqU4EyM1XfyU6FZ2cOIO
 jz1VtFpR8m/RwcddMTYpYyDJxSvU8hKhtyGZPECC7yT5wchP5gj49AmdFlfJotcDgskI
 j/Pw==
X-Gm-Message-State: AOJu0Yzr4/xqqRZrB/L1fRROyyRX2ij4vhv/1qAvuaayxRAy0hBPbppr
 AnVk/zWB9D48HOTfLbfzR4AQkFNJqWrHFP8DNcVmN8qwCa8fVn8gX3q1EYfxmglU2L9frwRjItU
 W
X-Gm-Gg: ASbGncuYtPeZu1OwRQ+065PLbqTpOJFPcUY9/zUM0N/6G0gPCQDX/odELsT1zKu3X8U
 r4V+QmbFjqXSUFLmSwy/Di7w+xwxwfVbi41K6wzyuRNxolQVXZnD8yI8mJMcSb2GUTu81cayIYp
 vwLGh6yfzcPLr4QBqApXc674Sd5d1e9ota2zl8y0+NyuYxlS3Ilw0ulwaJPUwQuFEKEJJ9vcdSd
 QF2bs6pQTPtv/Dae7O/CkbbRa7aSNint/OM6eAIcKjTxjUuqboomNcFHYzas24j+KvioANrvy8m
 /04aVAVuvFZOZ0pYTR99ufdn3mcU2csFKnaPRBfTXCePq7lPf08Ci1sZM+4cmYTYhuXz
X-Google-Smtp-Source: AGHT+IF6JOVl4nHChiAWp3cgPoOsc5Wak+MOTRpINvIqn8TQmIUNGKPyjhxte5YUtQVWP7MCnqrJDA==
X-Received: by 2002:a17:903:2282:b0:215:e685:fa25 with SMTP id
 d9443c01a7336-21f17dfa161mr1295865ad.20.1738698489757; 
 Tue, 04 Feb 2025 11:48:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f116fsm1557960a91.0.2025.02.04.11.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:48:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] eal: force compilation of RTE_ASSERT expression
Date: Tue,  4 Feb 2025 11:46:09 -0800
Message-ID: <20250204194759.723484-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204165516.168106-1-stephen@networkplumber.org>
References: <20250204165516.168106-1-stephen@networkplumber.org>
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
still be checked for compiler warnings. Use sizeof()
and ternary operator in same manner as the assert() macro to
cause the expression to be evaluated but not generate code.

This was motivated by detection of problems in a driver submission
that was not detected until compiled with non default flags.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - reduce checkpatch complaints and reword comment

 lib/eal/include/rte_debug.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_debug.h b/lib/eal/include/rte_debug.h
index 74593cd4d4..204e6db017 100644
--- a/lib/eal/include/rte_debug.h
+++ b/lib/eal/include/rte_debug.h
@@ -46,8 +46,16 @@ void rte_dump_stack(void);
 #ifdef RTE_ENABLE_ASSERT
 #define RTE_ASSERT(exp)	RTE_VERIFY(exp)
 #else
-#define RTE_ASSERT(exp) do {} while (0)
+/*
+ * If RTE_ENABLE_ASSERT is not set, the exp is not checked but not evaluated because
+ * of the use of sizeof(). The ternary operator is to allow function pointers
+ * and bit fields, and to suppress the evaluation of any variable length arrays.
+ */
+#define RTE_ASSERT(exp)	do {		\
+	(void)sizeof((exp) ? 1 : 0);	\
+} while (0)
 #endif
+
 #define	RTE_VERIFY(exp)	do {                                                  \
 	if (unlikely(!(exp)))                                                           \
 		rte_panic("line %d\tassert \"%s\" failed\n", __LINE__, #exp); \
-- 
2.47.2

