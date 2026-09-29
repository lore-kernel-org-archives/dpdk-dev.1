Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34290CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A42642D6A;
	Tue, 29 Sep 2026 18:38:16 +0200 (CEST)
Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com
 [74.125.228.30]) by mails.dpdk.org (Postfix) with ESMTP id 3876C4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:11 +0200 (CEST)
Received: by mail-pz2-f30.google.com with SMTP id
 d2e1a72fcca58-880fcd3790bso1520150b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699890;
 x=1791304690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQnC5bzkHu22EygKBNus6qIepUfDmIkzcpfPmtOa2Kg=;
 b=bPNnk0F5GLiNXmLm7vq5j6NrhIc9WB1jcjV1FJd5tD95e2dkTFih8+gSITpdX8qBrB
 wzRrYaCDzUufZxdZs6FYJkU15JAICxbuwAANeMot1YIiHXNmax7xLzuh62SDm9FgfnqR
 kaq2KilFSkueg1MCSbdz3gQrND9OQfofLaYuGFJZMeS97HBKsB11QQOnKr9+R/mNElcV
 h3cXUyVkp5epLO4Pe5H8LsGQtQQt0m2/B8qtH0ISlh45JQe7EgVEhu8x28ljBNpEmDOz
 8MT9BrOKzmA1ZSHf+rfi4f7zsWbG5fAhv4m9yq6bX6z8b9v1/MFVRnswei8Hw1MGR3vt
 trQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699890; x=1791304690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PQnC5bzkHu22EygKBNus6qIepUfDmIkzcpfPmtOa2Kg=;
 b=X5LWnoPYRnccpPcM6CyNk0nX8bDkJcHE0zQ1kab4n+/aluUCFQ0FB6/H7F5wj/F4Z3
 r5W1xbVHMGhclBl913Cd0gmjMPqfeGgN0lYnI3MvnPcSjh8aFwqFCIIZwU3oLce8r2F4
 M3ZTY+Cnj0+zs1wNPnmTw8x2psuJ+qOU6RKSwco5hEgCytConMM3WSm8aywFj23NuOIS
 o6NMjvKaqz7BNq4sgMUVTqlwrAI7eZd3LHCuI6lzCM7HFrOpwlQr9unFy5H+jgTXUZHV
 ppIKEJb8V1BDq/UrfmYetn10ZendmRj0S5RTOyUDOm+5nWh7Ir02ON/xmLcL5QAGSDie
 sY9g==
X-Gm-Message-State: AFuF++muRKd56iXNKrH7Lu3jkWOGR6slLBbqhL6mtzlPf4/5BZDnCnDI
 uYjlxvSE90siSUPU0IumRlXEw3qHACqKAke93bmXQkxYbCpBmXyoDgirRfe6dDoVTEFhloMB0FJ
 HBUeqlFA=
X-Gm-Gg: AYBFou254BnkGIhQcIruAq1U9ixR5k5Goasf0oo5QSsWHz9AgWwpoM1DX3qqdm1xg4c
 9a1jnT6O3mXZI4ljBgXz6ltf8iCsunnwO4oQy1H0WbdB/EJ6Ygr5+PnrJZsZzMovYE9TG53nLdG
 a7Gb+jg9ePSbFV7k2yMTu1mrMFoupt1+V+tYeERo6n8qBO+BO6BZ0R2qdFTVV/uOGu7HnC94MM1
 5Sltl9pKlct5Dx9JDxoCbCYtVyjeYPQgefrE2ni+SVpf/L4SDrGmzOu7TXNrY3foqa4GBgKo3Iz
 47oGXMCCiD/75SVZANcBlVrpxo3p5AC3UqkF0SSAgaMt/x0DVEhgX+plrly2bRbkcrqvCRiJAkz
 s/wTyS2tbpMYGUDvwCfMvMZ5hcxw0RHmmqSnpFL3gGGfiAnqkq66bOofIKN30haFpKiQ8Pke0fH
 ekclSktVprfH48soV4qAnqnnfHZn3HO/I77Ou7nV5G3h0IVRj9jVkd8jxXAMm+rSu1I8ZC9bKb7
 zzmjmCZt04YhlUJ2WSEU+5eB2rOAOq+W7yq8quD6vgRTyUC
X-Received: by 2002:a05:6a00:1911:b0:874:705d:f656 with SMTP id
 d2e1a72fcca58-87e9b3b680cmr13826975b3a.36.1790699890276; 
 Tue, 29 Sep 2026 09:38:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 02/61] kvargs: add a socket ID handler
Date: Tue, 29 Sep 2026 09:36:05 -0700
Message-ID: <20260929163800.1108305-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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
index 5cfe3d4265..8a75a53ab7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -151,6 +151,8 @@ New Features
   * ``rte_kvargs_handle_i8``, ``rte_kvargs_handle_i16``,
     ``rte_kvargs_handle_i32``, ``rte_kvargs_handle_i64``,
     ``rte_kvargs_handle_int`` and ``rte_kvargs_handle_long``
+  * ``rte_kvargs_handle_socket_id``, which accepts ``SOCKET_ID_ANY``
+    through ``RTE_MAX_NUMA_NODES`` - 1
   * ``rte_kvargs_handle_bool``, accepting ``1``, ``y``, ``yes``, ``on``,
     ``true`` and their negative counterparts. A bare ``key`` means true;
     an empty ``key=`` is rejected.
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 3b961a19a8..6e5e3fcd7c 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -750,3 +750,21 @@ rte_kvargs_handle_bool(const char *key, const char *value, void *opaque)
 
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

