Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EDEC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AEB6409FA;
	Tue, 11 Feb 2025 18:37:35 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 877D840662
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:33 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f9bac7699aso8657980a91.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295452;
 x=1739900252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vL0zrSN80vuagRVyMJeDhkCFPR6FmAGCCZ+phmJGzw=;
 b=uCgYv/W22xbAqxeb6g66QhJ+XtF87SOk78NDQX8sTu3mOCI7d3vf07YsZY8fBli9S6
 OrPKMl8MOpHmLFy9lvCIx4dZ+gGva4ZGdjHXbtUZU0xFU87KVRNSFpswSHoI0uKMmzcD
 WJFUE7UqRpV2xCKUmLRTjQH9i2tYDS2ywR5JeZaVtzHeKbMFvvQsRBBvng5iQw0ocqbi
 Zv9oytuGnoWE/XXGfPWOoJq6hedytezcLSMcN1Jtk4OEqT/JP+ykD31027yOvYxV6b/X
 x+DrSCnwsmo9ER8XLc9NWCraw/Hfz126J6LdHcFvZTKfhC6blwnsu33vTfOG9/oNXrbw
 vQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295452; x=1739900252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vL0zrSN80vuagRVyMJeDhkCFPR6FmAGCCZ+phmJGzw=;
 b=wko6gX0cuLAbubNcxTTWd8iAIRfZqyy99uGAU6WYVvkQLOxH6H2uLGudqP9MVs1Lkf
 gAp9DqwcNjdjA4qjr92lxQ1ntlq4sB5XasKIpkKZQWi0Kc97GfFfivf3Pv4eogfEE01E
 LYK5rYnDN+C22F7R+/O9C9O/LquEEzQisGqvotlZwvtSuARCnHkXK/xKnZF2l5I96GYf
 hnOt2adSocOOxIdV2fXVLTbFq7VM4/A9do7NOyaq9gchXvzo+NzUEe9NlEkkik6EQ1ZX
 UJNEqcKQ/MbGZtEC7Dqr0JiAP22/1KjANdnKJW2KGhmpoRE/a3Dp9zPwsXiJ/bFlZF1X
 DmtQ==
X-Gm-Message-State: AOJu0YwWSEAD9ajsEPk8cB4vxFQyOMtl1CsupNu7fhnpiF+DAJmrmLym
 S+9PjPP3GVhimwC8KxQ+lNq3SAEu4GHpOJZ3EPdWYiDfe4zUm+C/Pjh3cvUAGzj6nLsymKh+8K0
 i
X-Gm-Gg: ASbGncvbei2BscPNLz7mjm5uFIF1ixLwu6moSit9afzhMNIE6YYUoS+qcTEQCiu7HgW
 R2spMh6O/Hg6fJQvnXhfde0OR1zSMjrd1vm2eDObcjS9BZf73TpiSTEEL9V8N5KwzOOlDpCghPB
 p0IzYvFDS7QTL8JuD4o8MDIoYuRrNic9xHc3aZNpa1A7VyernxTgvN4JypYIqEIyaiwWkEJ8X8x
 lF9W2W1NUciDsf5PsTPWSWHBuAjmICeI+b9LJ6ag8EjBdh+oKI7zg3ErWcWhUaTXXSDwzYoQaT+
 FPCYlBTHLWyZtbJEd9aLNR7Wyb8YkF/K8h5wcaeDbRLGSjOKrZG9LpjSeXkdfgCkc+6E
X-Google-Smtp-Source: AGHT+IHKPiTYo+ZVykNtl33HmABkM5T31ju4Jjwqly+OY5leAZQSGyl1uK1UKDtvQf2R3EWHYALTsA==
X-Received: by 2002:a17:90b:1f81:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2fa9ee19228mr6367951a91.28.1739295452583; 
 Tue, 11 Feb 2025 09:37:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v5 01/11] eal: introduce new secure memory fill
Date: Tue, 11 Feb 2025 09:35:21 -0800
Message-ID: <20250211173720.1188517-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

When memset() is used before a release function such as free,
the compiler if allowed to optimize the memset away under
the as-if rules. This is normally ok, but in certain cases such
as passwords or security keys it is problematic.

Introduce a DPDK wrapper which is equivalent to the C++ memset_s
function.  Naming chosen to be similar to kernel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_string_fns.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 702bd81251..4874703957 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_compat.h>
 
@@ -149,6 +150,32 @@ rte_str_skip_leading_spaces(const char *src)
 	return p;
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Fill memory with constant byte but can not be optimized away.
+ * Use as a replacement for memset() for sensitive information.
+ *
+ * @param dst
+ *   target buffer
+ * @param ch
+ *   byte to fill
+ * @param sz
+ *   number of bytes to fill
+ *
+ * @return
+ *  like memset() returns a pointer th the memory area dst.
+ */
+__rte_experimental
+static inline void *
+rte_memset_sensitive(void *dst, int ch, size_t sz)
+{
+	void *ret = memset(dst, ch, sz);
+	rte_compiler_barrier();
+	return ret;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

