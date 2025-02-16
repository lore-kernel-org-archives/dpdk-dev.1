Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30ADC02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 008BF40DDD;
	Sun, 16 Feb 2025 18:01:23 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id E8F6040150
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:21 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-22101839807so32799675ad.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725281;
 x=1740330081; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox+czeXgjbDT/mWMJGQMQyMceRRbm8M1t97ch3xDIVQ=;
 b=W0YCId737fAPqqJLRBZpKqUYCB7o4r3KlbWudzLTFTZUcNo7w6s5cwSywBhVe7MD1s
 NE9ZUW+MiYhJed0kjQ+g4Guwskujr8u/XEMJ0bNBwp0VdgAm0nm6/zRnwzK7gQOly2EV
 fouLE8ME/9epDPp/S5tu0kCFvSpxyaTNiLV198LrrM+6LqU9kRzde+5dTCgkCAebzFa8
 HA0jfk3Z947GClFI1xYhJYbEqnZafkNGqzPEGGTB8mo2JjA84TGil6ZGCwIuKWaR9hg7
 fh+0wEC9epJ83NKSC000wrnFz2xgWdKnn1qVh32IcIWh6J5sdW3PyRWbr+j+uWBm2MO3
 NhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725281; x=1740330081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ox+czeXgjbDT/mWMJGQMQyMceRRbm8M1t97ch3xDIVQ=;
 b=nEN4WSps7/Bbkl6rZusVqqXa4F3E9/FwKJe5JRzlj0C7SVB5ECdZ/6nS4rew5/CjfL
 YFviQ2DVux60LSaCa6h060/H6JsgNDCsLhQQDoAMgzoVBDwR+ee08/TvrcKp68VVrfi0
 hLMs4nFDfbnUXf2WJ65Ffb6nWNq/lKimAnG/CStEfjRmK0axr/r5/zywpi29Pc9yVhJF
 w/mVyvvoEacpjpwVdX9Sro07En3VoWyTiRd9Fe+WR37Pfw+IyjK+6AWJ9TgEAhiqLk8V
 /RMUl0B0p339mlEBSxBnXcB9w12qTaTkfRM0GCJ3tRtUe5Ez7eaEoZ/cczB8fJdPuOSX
 wtlw==
X-Gm-Message-State: AOJu0YzaSiamzd2K0j/qdpN+m/ceHEGbpOIFzpSc3t3y7/kFosszBcpD
 y9yecL/5tUcTvLBJ/nQ6LValrfBEzAyBazoVZzDg/ZL54DSbVKB1HUyXKbmNFETcQ33SqX8KR0P
 j
X-Gm-Gg: ASbGncsShSmTJuZEFH9YK6MFwvM+zQ2WckgFnaMRZ+8UfbP8z9TTJK1t408UVylSEIp
 lh/S7HzHfzZVKAeXaDYd72ZM7QYPzrsAVrNiRkUNyiHZmVF/bm2VvLUAzXYxiRMO6uiiLYAl5r3
 3tSfWsBNnCV7DYp+dz1L9TXrshG5HjONjkzN0naPhCzavqFkgOtihoEMxva7Tyg3Y0kHXoq4pUD
 abLeMt96/kvaY+uz5o3jyfcPAJ+VKZilEhZvGKpuUOKeZmv7A2MtL7qgYwidERetipDd7bcBQXx
 eEl9cgKOV3cRAsN/SXDCtybwe/UcV3SDyeFg4OPNL3IkweQ1GKcRHL6VaMsx5N1OiDvC
X-Google-Smtp-Source: AGHT+IGuyyvK2Gk22Mix4APN1Mk5/I9fQxqJv4lBivD7N/e7GS5oCU205qKnQCzua4WStIVOZUJJNw==
X-Received: by 2002:a17:903:174c:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-221040e7162mr107614265ad.53.1739725281025; 
 Sun, 16 Feb 2025 09:01:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v8 01/17] eal: introduce new secure memory zero
Date: Sun, 16 Feb 2025 08:53:00 -0800
Message-ID: <20250216170110.7230-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

