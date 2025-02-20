Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D0C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D27E402DA;
	Thu, 20 Feb 2025 17:42:04 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id A5FAA40292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:02 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22113560c57so22935415ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069722;
 x=1740674522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox+czeXgjbDT/mWMJGQMQyMceRRbm8M1t97ch3xDIVQ=;
 b=nsmxyhv/z3avsgqiYmxLtdDZYvVcIa+r3gALvYSyn9t22VpEXxSKwgRkAUUpjNBr5Y
 rK2SW2TJNRhmLAZdqQyuc5Kxq/GoKtm03Mysl2sNkNLG80WIrMTrJ11YDLVCx/BgmH7h
 PzbfYqkpvf3OBOomDDiwgiEG3YAMdJaXW3fhiE6v/kMJXNzSPJYLpYJIHUJqepmHnaEl
 a1RdQPRWs5pqPdON5/g1seUn1bO7poItRZRkpE+bs+gKNczSfn2eSQn9ac0tTHwLvDNY
 GihkffAQZjTDLrEuPrBnRo1n+AQgSxuc4uc0A9YyVW+ryweG0gEnod1zoGueFUEboPYP
 RMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069722; x=1740674522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ox+czeXgjbDT/mWMJGQMQyMceRRbm8M1t97ch3xDIVQ=;
 b=dZ3K3sem/ppD6rYBz3iY+cDUJ/HvgNycNIFctBUD4fxKCv8SoIdUDLR+yWpC85PxsT
 NeujpxqLHfArpSuy3//12J0jCJezZYZjRlDVMRWC2FzMc5m5TJ7JdujfpTLrxfjwwujr
 BcWVXr9jyAyIYWog8uuOitDjKh0v9cDItx+pq9V5yTU+5ieMx+DFTgskyEaZzUKFIbXZ
 NRTgaEnHHDJoAkfdwn5MIFcJMUfhDYTTV2LDjH+j0teon63sBTVDULzdfN1a0wzUjydv
 /DRz8pc57sTX5IAHwS2eguGJEpemubmnS+04lx0hUpokmMKUg6cFzh2e/oisEAWSuZF2
 UcJA==
X-Gm-Message-State: AOJu0Yx662IU+RP3E+mKG+KvK1XxChsF62qrxsJMgoKtKqv/TXWhHbP3
 hmRdq56YhZ9RCXqw1rv6CzzL65iWY5qa1cHjv2Urldxv9UqtgTcgivqsgGTenitvb3KSnpsXKZs
 e
X-Gm-Gg: ASbGncvioaI/g/C18/wM+TGyY/3c5RSSHs0xkMgHLVAuJdWkwBRlhjPSikOkrEL3/Qd
 9Xp700EmqTUO9t1oXRETgq6kor7ey/3udCVvTv81tj46ICNYeY7ILkkUW8ZiUVOcWx+IYcaV4xP
 3uax041M1pjG9BXvlbFOYpETUKp8xoHYGdmnQbrCTsIwL/1hnXgdW+JnyEPp5OF5YED9STIizX4
 OA4zatOMa5Vq68q/J6mnELe/XpcX9bY7j7LjQUTe3uCE0AdXs7etkMtxCA2IVybkbqngIjxcQSp
 oQnZrXs+2f9A+puOawCOoOsZxSL30+ojZ4G/wUfeqxH/R4M8o1qoHTfiPLeeog4msz6e
X-Google-Smtp-Source: AGHT+IGVXzB/OD8snOd0JKsSAM6KTw6mbmAOuTe9bu2+Al/XTQPEDAjvzjm2ziSKcCJwSRP7hff+Yg==
X-Received: by 2002:a17:902:e5d0:b0:220:f795:5f14 with SMTP id
 d9443c01a7336-221040566cdmr339986115ad.27.1740069721873; 
 Thu, 20 Feb 2025 08:42:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v9 01/15] eal: introduce new secure memory zero
Date: Thu, 20 Feb 2025 08:27:07 -0800
Message-ID: <20250220164151.9606-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When memset() is used before a release function such as free,
the compiler if allowed to optimize the memset away under
the as-if rules. This is normally ok, but in certain cases such
as passwords or security keys it is problematic.

Introduce a DPDK wrapper which uses the bzero_explicit function
or SecureZeroMemory on Windows.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/common/eal_common_string_fns.c | 14 ++++++++++++++
 lib/eal/include/rte_string_fns.h       | 18 ++++++++++++++++++
 lib/eal/version.map                    |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 9ca2045b18..31804101cc 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -10,6 +10,10 @@
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
+#ifdef RTE_EXEC_ENV_WINDOWS
+#include <rte_windows.h>
+#endif
+
 /* split string into tokens */
 int
 rte_strsplit(char *string, int stringlen,
@@ -98,3 +102,13 @@ rte_str_to_size(const char *str)
 	}
 	return size;
 }
+
+void
+rte_memzero_explicit(void *dst, size_t sz)
+{
+#ifdef RTE_EXEC_ENV_WINDOWS
+	SecureZeroMemory(dst, sz);
+#else
+	explicit_bzero(dst, sz);
+#endif
+}
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 702bd81251..79ca9abd67 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -149,6 +149,24 @@ rte_str_skip_leading_spaces(const char *src)
 	return p;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Fill memory with zero's (e.g. sensitive keys).
+ * Normally using memset() is fine, but in cases where clearing out local data
+ * before going out of scope is required, use rte_memzero_explicit() instead
+ * to prevent the compiler from optimizing away the zeroing operation.
+ *
+ * @param dst
+ *   target buffer
+ * @param sz
+ *   number of bytes to fill
+ */
+__rte_experimental
+void
+rte_memzero_explicit(void *dst, size_t sz);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/version.map b/lib/eal/version.map
index a20c713eb1..82a3e91c97 100644
--- a/lib/eal/version.map
+++ b/lib/eal/version.map
@@ -398,6 +398,9 @@ EXPERIMENTAL {
 	# added in 24.11
 	rte_bitset_to_str;
 	rte_lcore_var_alloc;
+
+	# added in 25.03
+	rte_memzero_explicit;
 };
 
 INTERNAL {
-- 
2.47.2

