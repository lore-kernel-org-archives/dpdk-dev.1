Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD616C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62D2E40A6C;
	Mon, 14 Sep 2026 07:49:33 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 93A344069F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:32 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so23602165ad.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364972;
 x=1789969772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xrSmQbJGy5XP0DYx5PGIa3bbqOJP0JWEs6KxUpC6Ack=;
 b=xybM1n+KclaE3WX3oe6ZavwAW75U9PTxNAuQIHl1bjPzLduSYaI6U/GX2Ramg/RneW
 nrlB40unKFZnMDAkMfcutunFW0KetTKlQA/lhQVZqYpKmdpnnwXn/enaGdXQWpUHdFGI
 dWl7yFdvKzmWRF177O8R7oBv8btTMkLXjn8oFNDdSLDGwPO6Ch4STKW4i1i62TlrfupU
 KXQNXIeUhWkcWsRBsCE0nMcEHB4jqqGqc8PkcUzGAMhu60detMRRDW4M+vC/8iEcEy/H
 OM+vvUutvpHywzeqlk4A9n7X5wexkTL2Nf84CmS5877v2ntk2hsum/CDGAJ0yiz93+X0
 NabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364972; x=1789969772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xrSmQbJGy5XP0DYx5PGIa3bbqOJP0JWEs6KxUpC6Ack=;
 b=bj2ujGOCfCNkQJ0VTeVF0HMnhBAAdwIqTawpiHYVFfgH8pzfOOh8BNr0JxgGoXukv9
 HhfqgxJhHB5yg0uN7hcgNtnpaL7qnedXyKwP4lJam32rJTlRSXqXqkvrigzX72MCxR4E
 z7BP+SHxF5LlMAN72PLOTSMAt3Nvo1aw/22bIY+6vP5wOf575Bor4CmN1eMhz9/JyDU/
 K36YHHFmeiJpYpaO2qcW/2qlDDPAKkWeYEK+x5A3V8LZHFdRp11mR1uhIQWmNn9ngjGM
 zAcfxcVLlbOTf9/g1/Ep/QhLDulctw12LH8l2XkIX5YR48S5hOMhAzAMyt0QZ+SfyVr6
 HHfA==
X-Gm-Message-State: AFuF++kFuYioIUnKahtJyZxFFg3lVweb3mnG35qFfKGxq5ygGHRLDFDU
 eaX2qVGe5CiDLQrMBSfeOOBIQfYOrw2ZzZEgAC9+vZUXBAepP0uDu23upuFfgbUq5rE6MePXRqN
 yLlOcbUo=
X-Gm-Gg: AYBFou21Uw9AcfKxWywgfO5THTzU6TQ82O3emHUs5bzdAd0q8xFtnnfx6JLn+sJpM5p
 jG19b/Qg8Y66TJJ+zO4vEbV7Z/HcbWszRQOolEW3kyoX2zaLFVR38oJHIve9dlIgyBlCYA8wmoY
 dpuXpHqg5VIfnZqDIRgApNh+tg9m23Ih8J3hCM3Ad2eBmZ9hiDPVXmlcOpUEqYpnH4cKh75qhQm
 r2sUKcTuTuF3H02UFpM22lIKChgdoldI1IqcsrCcWLfW2kmcxDgd2wgYUexuumVBh9GdHBmoSgk
 nr2NxmwAxEywqMu7fWbgv3JUJRGjyPGOVw9uXgiWTR0gOk/qMlc3OI6CqHZueRenc5P4DjuSd2X
 5QqIWsjaCLetzYa0CloQ8p7zQxiTzBDchAQvU9V3h/pinPezIel7NapQv3gIJAE52nSJ4kEBRVi
 lxompXQEGRJsDP6uRbiVTYmWuEKoLv3pV5+30D4XLrWH6HtF2CKde6TWgMIgwGL1rbwbhBXKoyB
 fCoFMPFCaAIW6/U9PdFQYyX9yVVl2oSpNKqnQ==
X-Received: by 2002:a17:90a:e704:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39dec0d27f3mr2828887a91.22.1789364971604; 
 Sun, 13 Sep 2026 22:49:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/62] kvargs: add a socket ID handler
Date: Sun, 13 Sep 2026 22:46:34 -0700
Message-ID: <20260914054912.755403-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

Device arguments naming a NUMA socket are common, and every driver that
takes one open codes the same range check against RTE_MAX_NUMA_NODES.
They do not agree on what the range is: dlb2 accepts RTE_MAX_NUMA_NODES
itself, and turbo_sw and bbdev_null check only the upper bound, so a
negative socket id is taken as valid.

Add a handler for these:

    rte_kvargs_handle_socket_id

It stores through an int and accepts -1, which is SOCKET_ID_ANY, through
RTE_MAX_NUMA_NODES - 1.

The bound is the compile time maximum rather than the sockets present on
the running system, which is what the open coded checks used. Validating
against rte_socket_count() would also make kvargs depend on EAL, which
depends on kvargs in turn.

SOCKET_ID_ANY is spelled as a literal -1 rather than included from
rte_memory.h for the same reason. The value is part of the ABI.

No handler is added for lcore ids. There is no caller for one: the
drivers that take a core argument either parse a list, as crypto/scheduler
does with its coremask, or dispatch many keys through one shared handler,
as mlx5 does with service_core. One can be added when a user appears.

Nor is one added for queue ids or queue counts. Those look similar but
are not: some drivers count from one and others from zero, and the useful
bound is nearly always a hardware limit well below
RTE_MAX_QUEUES_PER_PORT, which rte_kvargs_to_uint() already covers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_kvargs.c                 | 31 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 lib/kvargs/rte_kvargs.c                | 18 +++++++++++++++
 lib/kvargs/rte_kvargs.h                | 27 ++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index b74dfd6acb..f05c7918e9 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -515,6 +515,36 @@ test_handle_bool(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_handle_socket_id(void)
+{
+	char buf[32];
+
+	/* SOCKET_ID_ANY is a valid socket id, anything below it is not. */
+	CHECK_GOOD(rte_kvargs_handle_socket_id, int, "-1", -1);
+	CHECK_GOOD(rte_kvargs_handle_socket_id, int, "0", 0);
+	CHECK_BAD(rte_kvargs_handle_socket_id, int, "-2");
+	CHECK_BAD(rte_kvargs_handle_socket_id, int, "");
+	CHECK_BAD(rte_kvargs_handle_socket_id, int, "1x");
+
+	/* The last valid value, and the first one past it. */
+	{
+		int socket = 0x5a;
+
+		snprintf(buf, sizeof(buf), "%d", RTE_MAX_NUMA_NODES - 1);
+		TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_socket_id, buf,
+					       &socket), "socket id %s rejected", buf);
+		TEST_ASSERT_EQUAL(socket, RTE_MAX_NUMA_NODES - 1, "wrong socket id");
+
+		snprintf(buf, sizeof(buf), "%d", RTE_MAX_NUMA_NODES);
+		TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_socket_id, buf,
+					    &socket), "socket id %s accepted", buf);
+		TEST_ASSERT_EQUAL(socket, RTE_MAX_NUMA_NODES - 1, "target clobbered");
+	}
+
+	return TEST_SUCCESS;
+}
+
 static int
 test_kvargs_to_range(void)
 {
@@ -574,6 +604,7 @@ static struct unit_test_suite kvargs_test_suite  = {
 		TEST_CASE(test_handle_unsigned),
 		TEST_CASE(test_handle_signed),
 		TEST_CASE(test_handle_bool),
+		TEST_CASE(test_handle_socket_id),
 		TEST_CASE(test_kvargs_to_range),
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c175fe089b..dbf7923b66 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,8 @@ New Features
   * ``rte_kvargs_handle_i8``, ``rte_kvargs_handle_i16``,
     ``rte_kvargs_handle_i32``, ``rte_kvargs_handle_i64``,
     ``rte_kvargs_handle_int`` and ``rte_kvargs_handle_long``
+  * ``rte_kvargs_handle_socket_id``, which accepts ``SOCKET_ID_ANY``
+    through ``RTE_MAX_NUMA_NODES`` - 1
   * ``rte_kvargs_handle_bool``, accepting ``1``, ``y``, ``yes``, ``on``,
     ``true`` and their negative counterparts. A bare ``key`` means true;
     an empty ``key=`` is rejected.
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index c3bd199f3e..3f45ea519b 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -749,3 +749,21 @@ rte_kvargs_handle_bool(const char *key, const char *value, void *opaque)
 
 	return -EINVAL;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_socket_id, 26.11)
+int
+rte_kvargs_handle_socket_id(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	/* SOCKET_ID_ANY, which is -1, is a valid socket id. It is spelled
+	 * out here rather than included from EAL, which kvargs sits below.
+	 */
+	ret = kvargs_store_int(key, value, opaque, -1,
+			       RTE_MAX_NUMA_NODES - 1, &val);
+	if (ret == 0)
+		*(int *)opaque = (int)val;
+
+	return ret;
+}
diff --git a/lib/kvargs/rte_kvargs.h b/lib/kvargs/rte_kvargs.h
index 118cf3c79b..acc15607bc 100644
--- a/lib/kvargs/rte_kvargs.h
+++ b/lib/kvargs/rte_kvargs.h
@@ -359,6 +359,33 @@ int rte_kvargs_handle_size(const char *key, const char *value, void *opaque);
 __rte_experimental
 int rte_kvargs_handle_bool(const char *key, const char *value, void *opaque);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a key/value pair to a NUMA socket id.
+ *
+ * Accepts -1, which is SOCKET_ID_ANY, through RTE_MAX_NUMA_NODES - 1.
+ * The bound is the compile time maximum rather than the set of sockets
+ * present on the running system, matching what drivers checked before
+ * this helper existed.
+ *
+ * @param key
+ *   The key, used for error reporting only. May be NULL.
+ * @param value
+ *   The value to convert.
+ * @param opaque
+ *   Pointer to an ``int`` to store the result into. On error it is left
+ *   unmodified.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is malformed, or if @p opaque is NULL.
+ *   - -ERANGE if the value is not a valid socket id.
+ */
+__rte_experimental
+int rte_kvargs_handle_socket_id(const char *key, const char *value, void *opaque);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.53.0

