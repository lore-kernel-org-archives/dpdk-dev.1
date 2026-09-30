Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E6CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A3F427C9;
	Thu,  1 Oct 2026 00:43:49 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id AB226406BA
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:46 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e69so2016493a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808226;
 x=1791413026; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W3vb6gz++prOhL7KibRIfZHmwZU/aMj53s9CbTrd3Qk=;
 b=YnM3kHXrEVSCIGCdNRyvTOygd4ie+eqxPRWjnZyaNgXvhuFP42k1EyjO6LUWkSxnLu
 2H8ajQBdkwFY5cWJ4rBDuHBaB5i1H9NxvKAgqoigwrzWps7GVGsd2NPrgvjA/O4s3Pzq
 bgkLLsXrw/J/ysJ7htxdOi1yoCESv3hnl6+u4fd7N3kkcXc9QOYsz9Hk5e17oS6rznRu
 cwH3tI3GiRxpTCYofxwzHgy70ygUaI5nCZBQ/8PgBkihKewtqjadKGrFW5hYBfFe9nr/
 BMCeD3nJEB3lDqkWVXyC/R22a7rEzs+9T57qHKVI1WraXQT8PDPXaHmpptgQ02hnQU8Z
 SjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808226; x=1791413026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W3vb6gz++prOhL7KibRIfZHmwZU/aMj53s9CbTrd3Qk=;
 b=K/d9bBtwIy4iegZxrs1EaRrsC+Km1xMsdSxcM5VuEChlQeeDmoHwQ5wRoQF8/KlQ7y
 KFuP94PHcZSQPfw1zy1b9sdXhNmMbUqt/YPFD+JOFWqHM2hlHP9RTLTfheidt5o6JuUC
 RDLI5h7BAjAx1gGDyCVNyYET1nFyRXA+HstkDR1Inp4hQbkFo27hWKSu7UzPc9I6XnaK
 5JydsCnzUBO3ksiZr0/u4EDGEiSB8VAup+K0wSPcgMYgTmHFtGoZDmV2fdcW9sgkqSth
 GGmGQ3HCMRNdS16SxkSvdk9/TLHKCXiTNTe17a/aEfPtkz7Z3ttJ/0wJHmQNOfSG75a/
 Lkrg==
X-Gm-Message-State: AFq9FYIS0q0+UXeZTv02xxPk7uZ3srTGQzzMBm9JmiICQtgWcvAxqGDW
 5TxHSzkPIzoW5Nv3Rx58wMdZwImcY+2qrNwuaOrra/X4lCIfPqBOC+RuMN6NnGV6R9PLQKpO0Uq
 Lt+PkLdM=
X-Gm-Gg: AYBFou3RrCnWI1fyOMUpJE8XARQCDA0GjzJG5Yr5oPfboBl2moLbI2o7KFCrqW7abwQ
 11TZzB1Gw5P0sqw+Y48OoPa6QCc2ISfsAaL25Vxlh2hZofPGW0j8zd1CByOfao65YQAbOhP7TVm
 MijtZEwxPW8enY9WT3TjS67L5ZTe952fh8h0iKNj0hyqsVudPrlp0WmfL7rg3C7kz1aKC/sFHim
 AHKWZsY5yHAmBaaSbxok1R48d/zA2AUJbE9HzD6USkR4Rlr3zthprqgbqwhqNFuY0LV6yjWlm3c
 MhZq1xwLZ0RxoMA3I090OX9ndFneu80HtvkAzQbv3/nkDZG07P862DYEcQbnHSsohWZtRxukJfw
 QXn2YiXWA0Lr7aPuIAVmKv+BOoBpc1Jn6YJfwdCL/9jfWrNsVNxhPe8C2QYc29YetCtt+ITXg9k
 N5pEBNbR7/eaJZqNdR91mbaVr80wtPDSYZM8jnuj2aKezij3mumkKBJ2WDCnWkyaCLlcgSpl0jF
 kBcCXv6Duu5a9pCgVarX2+r6WlHLcjbnOITPg==
X-Received: by 2002:a17:90b:564e:b0:3a4:9859:9749 with SMTP id
 98e67ed59e1d1-3a4d178aebbmr2060871a91.38.1790808225243; 
 Wed, 30 Sep 2026 15:43:45 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 03/65] kvargs: add a socket ID handler
Date: Wed, 30 Sep 2026 15:40:21 -0700
Message-ID: <20260930224340.58580-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

Add a handler for these: rte_kvargs_handle_socket_id()
It stores through an int and accepts -1,
which is SOCKET_ID_ANY, through RTE_MAX_NUMA_NODES - 1.

SOCKET_ID_ANY is spelled as a literal -1 rather than included from
rte_memory.h for the same reason. The value is part of the ABI.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
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
index 20271cee52..7225e9e787 100644
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

