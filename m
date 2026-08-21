Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874CBC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B7140A6E;
	Fri, 21 Aug 2026 21:28:53 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 247E440678
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:52 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so1018773b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340531;
 x=1787945331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+epHBW1bC2XIkz4PgfHnxjvw7Mqz5efyojRyBM8ijyA=;
 b=IiydnNt91rw9DnEHt+BfT7oKwY57TPHdZRY99mEj5GI/kaBlbmLow3eCEEayIgVY05
 yhbgrmyqiaESn2fYsvLpdYSaqgRNoi3w+Aqkb04R7KwiK8gM5faRnHp6pmYVNQP2l+Yf
 t5RmzSyluR/mZC7+z3BHpi9UzAc/NJgsfjcS05iC9p9JChyYh0xak51mzqd7K4arXQiy
 Qc+f2AEsRcd2Ifyc8BZ7AGsy2jQ+VOM+4pejZBfEFNu0if1BPhKppoze55xpZ6N4dhLn
 fmUFIebabLxY+G/Ig5E9yQ+Sx3Pg9Bf4ptHllFIGeRBEcRiSl/kK6EHnkAuxBveZWphK
 h4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340531; x=1787945331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+epHBW1bC2XIkz4PgfHnxjvw7Mqz5efyojRyBM8ijyA=;
 b=Qhgc2/Nq36GunmGspIv1rpx9yDyn8IILBkAfrJUHhpEP6z7rdzDqcJMJGeaEnr+eBS
 4CJzQycreeNOTepDCYuqLjv7XtdabM7VRsDIF/mb7yyM6KyX9UD6aivYbi4RohPsNVgJ
 H1GKu5BY2wxHwfe6H77ahTnuJcA94aH5IRfHOdcU70940VeprWeP4Humpi8V94bsNEsf
 oEkTlWwXYdFcfhcHbDpcnJH/6MrhXwKBZUKltkwjovsXWPSHnLsYJXWASxY+zuIc9zrR
 /Tetfb9hqFHnCd1li22odxrLAkr0v8LuX3o2Rjy1n1AsKXaEX+v3qiAGYHU9shY9whVF
 W0Nw==
X-Gm-Message-State: AFuF++mDLnEBkdml3VF8KGHoC0ZK1c054uJUiDVQc52GDPa3BHa63VDo
 29s+SzboRHsi7cV5biARwa2LMal/CCElA28etnI6/Zs6KkH7gfjwM7A8tN/s6KBHizl6+7Ap2lF
 D8LwP
X-Gm-Gg: AR+sD13oUwm6eYFP5hjbuL0NYjWsLyFqrAhb8w4tpMdUVpc8Y/DssnpcxVnrzszDLTA
 Loe1QiNhiRd53vt7BxplHD0FMsdcHtuNQMNKARjWpVqfxCSJzDU2htdCsicwtmBf9StLzAH9vYf
 Jgd+QwG2Erx5hycNNIZaxSn+X2kt2mpWOQqcOw5gNsUiQsuzoATcOH+x2d6i1dLM2Ut1zXik1yh
 RlE+CWShnJUWQB1fTb+olQBjWEcvrmcyUnnEv9bE2xNebK3qVa9hCF5bGMigdl2nkXM8JYytL7e
 NA+Sm65M9EnQ4J233UQdXCi9iTcIUe+7hAZ/tx94pXn4S64JheXG8GT5rt+Zn5veLYrv+iKObfz
 2YqZUm/WnXlEc38YRyLMPUCbj4e2XgiZEOfi5iubat0xBLcsmpQPQPQHazI9EzNqS/0ElTh/P0u
 sR89GCrQ4RfVeuOU2IUM1iFC3t/WkXx9yrjrDUxYhSfVs051xtT6Vil/tQd8mhg7q9BAxta3m1L
 +1EEsifcVmYfspv5hqBm3X744vGUicOosECgA==
X-Received: by 2002:a05:6a21:32a2:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3cd2fecf725mr13301730637.8.1787340531290; 
 Fri, 21 Aug 2026 12:28:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 15/68] security: replace fixed size rte_memcpy
Date: Fri, 21 Aug 2026 12:24:10 -0700
Message-ID: <20260821192646.146382-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Use memcpy for better compiler checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/security/rte_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index 0d89f8af3f..2e60b9ec64 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -406,7 +406,7 @@ crypto_caps_array(struct rte_tel_data *d,
 	while ((dev_caps = &capabilities[i++])->op !=
 	   RTE_CRYPTO_OP_TYPE_UNDEFINED) {
 		memset(&caps_val, 0, CRYPTO_CAPS_SZ * sizeof(caps_val[0]));
-		rte_memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
+		memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
 		for (j = 0; j < CRYPTO_CAPS_SZ; j++)
 			rte_tel_data_add_array_uint(d, caps_val[j]);
 	}
@@ -431,7 +431,7 @@ sec_caps_array(struct rte_tel_data *d,
 	while ((dev_caps = &capabilities[i++])->action !=
 	   RTE_SECURITY_ACTION_TYPE_NONE) {
 		memset(&caps_val, 0, SEC_CAPS_SZ * sizeof(caps_val[0]));
-		rte_memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
+		memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
 		for (j = 0; j < SEC_CAPS_SZ; j++)
 			rte_tel_data_add_array_uint(d, caps_val[j]);
 	}
-- 
2.53.0

