Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62FEC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB08542DDC;
	Tue, 15 Sep 2026 21:22:36 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0225A42E67
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:35 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so111846a91.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500154;
 x=1790104954; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S2r1we++ltBOq+5HzVRZWEcGr1xkR0gBVjm1jULr7WE=;
 b=G0qmgnTwh+DQiiJfviuREUxbFsOMh/f+muk2h5yLd2c1WNwAdBS6PCKcX7bjOWJize
 5cggxHVcgBX83+pOMe+gFWXJnGbIYcoT9jcEsHqHlWW408l0YaJhHL+6jcuJWPDk8yFg
 nGGfcpWyOGdKWImSa0DtWLzlKvzPvrbE3GZ2MaiQqKRxJ8kNJHL7MvQfPG3Rj6WYlVk6
 I8e+4N1BAqMgdzs/8qXwgHf9n3jAWygxTC2Wez4pPWgeDAvftG1QnFYEYZaoh4j2VjhK
 bJ1E3fRoIgOdEbQcggspB4b3l7EGZ7A8mTz0bGSBslkUhCDTdOZy34DUU539VoRpl4Ms
 ud4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500154; x=1790104954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S2r1we++ltBOq+5HzVRZWEcGr1xkR0gBVjm1jULr7WE=;
 b=NnkRh98+Jv60GtSZ7cc6yjyJvvhwZ1nHEkw5agQBzs3urRBnajPxYGnj5RfT34P7S+
 ZdnbsW860Z/TeW4bjArl3lIr0ngkoUtVCIdXSs3Jk8BLD69ch5FQJYtcUaJMYMPDJtBa
 f1zRNkdHm2nX71fBV9f2bvi98FXuQCYWPFdIUmrE0clasrE6lCfPRT8LdtEyH9yLVqie
 Xux/g+/uvAwaBi6j7LqMvygZ42LOMFxuaK9T5aZf25jqEkVmjmAFgR1aN9475spNl7QO
 H5GQFBRTj2XC2ptBAjunef2CcVIQEDy8V/fml/GYl+zj9HlUtGHsND7nOZexdTOfQeEd
 tVSw==
X-Gm-Message-State: AFuF++lDlzUi3EAX7AuAZi4gIYnPXOl7CMztYk4x0I5jyvrmK5hWyB9K
 zUv7O8PSpfo3JRVjsBygEqeGhoHkJj7haz+J5ETqHR4y8acDdjqmierC+5zkT7UonIutgTdAw3i
 qyQT5R5Merg==
X-Gm-Gg: AYBFou1uEPxNnkZn8XkEly5WJineKkJJhBnhfc6i6tTigr8Xc4sU7aWnssN0gB1fpt1
 7DTSSFzYHnjf/ZMrLCUmHAs74zZa560AGP83jHMZ1gMHXKnponqYRRhAEb3kpDvcZNYby1lxPxm
 iYxoJnVXpa3uLHsb8fLD/vAZ0FuHTAFfSpMadqkMfAY3htbRysimYREdV3rZzCG7qPUEWwsRksY
 FKLNLvpOLusPwFsX//3X+DvMhbxbc1XWE85Q/1J7cn2w7k4lRiXkT0mxQpPvJNeeJRrYGxrNniq
 //O0ZavxABPtZNPvG7UGatt59ABuKxxS3rEoXUNd9MEgjdBUsQCadC+ZJ2bzav8nS890OiGXJui
 qzX6i9QYkaECDcjoH4k1e2jhEmNPrig7iSO2njnnrsQC8xufuiHRyUzAAxJxDz92j9v6Uy58B+A
 NzgVM8BEUS0Q5Uto46Z5CFM3zDC1UFyLSKnh4fIFKsFHVp7bm4NbmLy+WSi/ii2OzerDKnioE/O
 jTu0l23oxx+4sgFX4aHhw3NFQDWr6rGV5hy7pQ=
X-Received: by 2002:a17:90b:5865:b0:39e:433:23b5 with SMTP id
 98e67ed59e1d1-39e04332517mr7725067a91.5.1789500154049; 
 Tue, 15 Sep 2026 12:22:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 06/18] eal: add function to get random bytes
Date: Tue, 15 Sep 2026 12:21:04 -0700
Message-ID: <20260915192207.3926217-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

Add a function that fills a buffer from the random generator provided
by the operating system, for callers that need values which must not
be predictable, such as keys, hash seeds and MAC addresses.

rte_rand() is a fast pseudo-random generator whose internal state can
be recovered from a handful of outputs, so it is not suitable for
those uses.

The implementation uses getrandom(), which is now available on all
supported platforms. Requests are split internally to stay within the
size that is guaranteed to be returned in full, so that callers do not
have to care about the limit. If the system random generator is not
available an error is returned rather than falling back to the
pseudo-random generator, since a guessable value is worse than a
failure for the intended uses.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 lib/eal/common/rte_random.c            | 40 ++++++++++++++++++++++++
 lib/eal/include/rte_random.h           | 43 +++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c1742b3c60..f25e497729 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,11 @@ New Features
   * The initial seed is now always taken from ``getentropy()``.
   * Added ``rte_rand32()`` for callers which only need 32 bits and would
     otherwise have to truncate the result of ``rte_rand()``.
+  * Added ``rte_random_bytes()`` to fill a buffer from the random
+    generator provided by the operating system. It is intended for
+    values which must not be predictable, such as keys, hash seeds and
+    MAC addresses, where the pseudo-random ``rte_rand()`` is not
+    suitable.
 
 
 Removed Items
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 1368b70e27..4b777f69f4 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -10,9 +10,13 @@
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include <sys/random.h>
+#endif
 
 #include <rte_bitops.h>
 #include <rte_branch_prediction.h>
+#include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_lcore.h>
 #include <rte_lcore_var.h>
@@ -228,6 +232,42 @@ rte_drand(void)
 	return (double)rand64 / denom;
 }
 
+/* Requests of at most this size are guaranteed to return in full
+ * once the random source has been initialized. Larger requests are
+ * split so that callers do not have to care about the limit.
+ */
+#define RANDOM_BYTES_CHUNK 256
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_random_bytes, 26.11)
+int
+rte_random_bytes(void *buf, size_t len)
+{
+	uint8_t *ptr = buf;
+
+	while (len > 0) {
+		size_t chunk = RTE_MIN(len, (size_t)RANDOM_BYTES_CHUNK);
+		ssize_t ret;
+
+		ret = getrandom(ptr, chunk, 0);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+
+		/* Should not happen, a bounded request either blocks
+		 * until it can be satisfied in full or fails.
+		 */
+		if (ret == 0)
+			return -EIO;
+
+		ptr += ret;
+		len -= ret;
+	}
+
+	return 0;
+}
+
 static uint64_t
 __rte_random_initial_seed(void)
 {
diff --git a/lib/eal/include/rte_random.h b/lib/eal/include/rte_random.h
index 9d3ecc596e..7c5030ecab 100644
--- a/lib/eal/include/rte_random.h
+++ b/lib/eal/include/rte_random.h
@@ -8,9 +8,14 @@
 /**
  * @file
  *
- * Pseudo-random Generators in RTE
+ * Random number generation.
+ *
+ * A fast pseudo-random generator for general use, and access to the
+ * random source of the operating system for values which must not be
+ * predictable.
  */
 
+#include <stddef.h>
 #include <stdint.h>
 
 #include <rte_compat.h>
@@ -104,6 +109,42 @@ rte_rand_max(uint64_t upper_bound);
  */
 double rte_drand(void);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Fill a buffer with random bytes from the system random generator.
+ *
+ * The bytes are drawn from the same source as the urandom device and
+ * are suitable for cryptographic purposes such as keys, hash seeds and
+ * MAC addresses. Unlike rte_rand() the generator state is not
+ * recoverable from the output.
+ *
+ * If the system random source has not been initialized yet this call
+ * blocks until enough entropy is available. Once initialized it never
+ * blocks.
+ *
+ * It is several orders of magnitude slower than rte_rand() because it
+ * may enter the kernel on every call, and is not meant to be used on
+ * the datapath.
+ *
+ * This function is multi-thread safe.
+ *
+ * @param buf
+ *   Buffer to fill with random bytes.
+ * @param len
+ *   Number of bytes to write. There is no upper limit, larger requests
+ *   are split internally. A length of zero succeeds without doing
+ *   anything.
+ * @return
+ *   0 on success and the buffer is filled completely.
+ *   A negative errno if the system random generator failed, the
+ *   contents of the buffer are then undefined.
+ */
+__rte_experimental
+int
+rte_random_bytes(void *buf, size_t len);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

