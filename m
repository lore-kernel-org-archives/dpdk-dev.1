Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AD606A68E
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yoKrYAtI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA0640611;
	Tue, 24 Nov 2026 19:05:58 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 16E5D40658
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:05:57 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so47859345e9.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543557; x=1796148357; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HyGYQ4hWsSV2boZJ3r77XDD3ah/5iG+OIaLbdDA+cwI=;
 b=yoKrYAtIZ9dk2Gc287UvUcF7NvxXo5sjNOBJa+Grf6AfnFpu4gkeFFn4oX39KJ9iu4
 8oMVVXVBA3gqflvk6OT3izeGKZKMLrr6VR74iorcusYU8ejfNQvjiIjN1GUiGNJDEHky
 2pr+5Gsxy3KDSA/eq93GZUFvN5on/GxYq5LLW+3IXoPBKSLlpc/SeHcUisNDqmOj0MdI
 tbxnPF5WWJMIIesqMUaJJNHN6k6MzE0hDuOHkntpOzXMiM38lUk3+65DEHEaFdkC+mU7
 jsq/Xu+hFX3DERyuSAtxhjogfpUPxvlJSOxQ8Ui6YUish5Ic5MLtWoqkH8OkYBafhnNs
 yYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543557; x=1796148357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HyGYQ4hWsSV2boZJ3r77XDD3ah/5iG+OIaLbdDA+cwI=;
 b=JNwu63KUCOFsKtLiB7Ip8FX5J3NHDh7ceXKZAIJQf87aB5UinffYZbHBftLj2bWv5Y
 aPrpBIpOLeZO3fC2tNOyXxyMqgbsxctCjLvKui+5ydXTAYTPfm0pAAYVALBt5BmpGfpe
 PPprfuNznLQH7d5sSp2fKa/B5B2T6G29/sr9df46KHs5+/Z8TS+7er467chXjxr/NcT/
 U5jYgGKKqPxHxM9wU47zlU1BhSYCaUp2y8JBq8ZFd8db2XDeEU1tFrJJBVL4Fog6QZ32
 KXMPcHQBzHClfwrddG6L9ounopORfNnxSD0odIt5MPD+J2Ox5sKCyiBDeTcgdyrpANGW
 4n3w==
X-Gm-Message-State: APuU4Z+yOEZy+Jl52MPR6T3r/D4xpDpmKxBl5tfHlBP+X/0V9Sfd2UUL
 bjgwYD6coo3dk3BMHq22e7zrxJZnRFtA+053xqkARpbMq+tdUuyTNRcy93Zhhw==
X-Gm-Gg: AZFdTZeuT9W9c8gpqU5DEZJW6SDEDYnNvg+gOGZq2oQA2fRpgxvsKtGTDIw3jE8sVQA
 LDWJfSE6be7lPeHGmZl1dBTE4WjZi2ZNrLP+oxZ66ibOcevvBAQVrFwU+Xf3c8LWCt5H+6NTveD
 FefRJuDJ2VGRcc5gjIx39mcmPONNYyeEwlRgGHm2xYPfjeJnv/mt2n47FUw8EAzHSWTJvQ8cPiX
 50WCZJ2fapYJxceNotnt2hIZ9AQbZShywY4ncZVt5QWvNFpclNAg3qLsOlQe2aP5YFovyNpF9MR
 35/f36FsAoXcG7ipAwVOQlJLZlsEgCvoYfnLHA5o+MXSW8S5k+rEwAmey0LOAvvXAO5auUnxPb4
 XGEu2rTI3a2ouJK8yrLAaBHlHsPd40VUuKSB5/zz8bSKQCSLr+lOdQrDxC1cGHLK5WOH5nW4EEX
 IGHeboVAYzHUy/aqwEGfr4e8ekUiI2A5REFrSMPRcEorsdjHc7H4AyO1IvSRdJQ7N7x9CahxuNK
 Ek5yFdWnjwDlWWkRHgFT87EQXKOs9AnpYOgE+B2b8AzfBZMRSF/NKiW0de78bqmWlKk2uLVftkD
 hrTpJlaKWfUOwT5uL8Fv2c7SN5Fs2Vngq8qvK8rzunbNukcUpYS7L/0pP74NuhDOPEc8MneeNkc
 PwSL+vw==
X-Received: by 2002:a05:600c:64c7:b0:4bb:68c4:2044 with SMTP id
 5b1f17b1804b1-4bb887fe725mr296993825e9.11.1795543556438; 
 Tue, 24 Nov 2026 10:05:56 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906817ccsm245943015e9.5.2026.11.24.10.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:05:55 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 3/5] fib: add group of FIBs with bulk lookup across them
Date: Tue, 24 Nov 2026 19:04:13 +0100
Message-ID: <20261124180415.1099828-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180415.1099828-1-maxime@leroys.fr>
References: <20261124180415.1099828-1-maxime@leroys.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A burst may carry packets of several VRFs, each one having its own
FIB. The application has to call rte_fib_lookup_bulk() per packet, or
to regroup the burst per FIB before the lookup.

Add a group object holding what such FIBs have in common: type, flags
and next hop size. A FIB joins a group through the new group field of
its configuration, which is rejected if it does not match the group.
rte_fib_group_lookup_bulk() then takes one dataplane pointer per
address, as returned by rte_fib_get_dp().

In DIR24_8 the tbl24 is embedded in the dataplane struct, so it sits
at a fixed offset from that pointer, and the tbl8 pointer is read
from the same struct. The FIBs keep their own RIB and tables and are
created on demand: no FIB identifier, no table shared or sized in
advance.

DIR24_8 gets a scalar and an AVX512 implementation, the latter
gathering 8 entries at a time from absolute addresses, selectable
with rte_fib_group_select_lookup().

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib.c               | 216 ++++++++++++++++++++++++++++++
 doc/guides/prog_guide/fib_lib.rst |   6 +
 lib/fib/dir24_8.c                 |  70 ++++++++++
 lib/fib/dir24_8.h                 |  63 +++++++++
 lib/fib/dir24_8_avx512.c          |  82 ++++++++++++
 lib/fib/dir24_8_avx512.h          |  32 +++++
 lib/fib/rte_fib.c                 | 125 +++++++++++++++++
 lib/fib/rte_fib.h                 |  88 ++++++++++++
 8 files changed, 682 insertions(+)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index 62c0ce1e70..12c9b8ee2e 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 
+#include <rte_byteorder.h>
 #include <rte_ip.h>
 #include <rte_log.h>
 #include <rte_fib.h>
@@ -23,6 +24,8 @@ static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_wraparound(void);
+static int32_t test_group_invalid(void);
+static int32_t test_group_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 
@@ -472,6 +475,217 @@ test_wraparound(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Check that rte_fib_group_create fails gracefully for incorrect user input
+ * arguments, and that a group only accepts the FIBs matching it
+ */
+int32_t
+test_group_invalid(void)
+{
+	struct rte_fib_group_conf grp_conf = { 0 };
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib_group *grp;
+	struct rte_fib *fib;
+	int ret;
+
+	grp = rte_fib_group_create(NULL);
+	RTE_TEST_ASSERT(grp == NULL,
+		"Call succeeded with invalid parameters\n");
+
+	grp_conf.type = RTE_FIB_DIR24_8 + 1;
+	grp = rte_fib_group_create(&grp_conf);
+	RTE_TEST_ASSERT(grp == NULL,
+		"Call succeeded with invalid parameters\n");
+	grp_conf.type = RTE_FIB_DIR24_8;
+
+	grp_conf.flags = RTE_FIB_ALLOWED_FLAGS + 1;
+	grp = rte_fib_group_create(&grp_conf);
+	RTE_TEST_ASSERT(grp == NULL,
+		"Call succeeded with invalid parameters\n");
+	grp_conf.flags = 0;
+
+	grp_conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B + 1;
+	grp = rte_fib_group_create(&grp_conf);
+	RTE_TEST_ASSERT(grp == NULL,
+		"Call succeeded with invalid parameters\n");
+	grp_conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+
+	rte_fib_group_free(NULL);
+
+	ret = rte_fib_group_select_lookup(NULL, RTE_FIB_LOOKUP_DEFAULT);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Call succeeded with invalid parameters\n");
+
+	grp = rte_fib_group_create(&grp_conf);
+	RTE_TEST_ASSERT(grp != NULL, "Failed to create group\n");
+
+	config.max_routes = MAX_ROUTES;
+	config.default_nh = 100;
+	config.group = grp;
+
+	config.type = RTE_FIB_DUMMY;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib == NULL,
+		"Call succeeded with a type not matching the group\n");
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib == NULL,
+		"Call succeeded with a nexthop size not matching the group\n");
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+
+	config.flags = RTE_FIB_F_LOOKUP_NETWORK_ORDER;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib == NULL,
+		"Call succeeded with flags not matching the group\n");
+	config.flags = 0;
+
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	rte_fib_free(fib);
+	rte_fib_group_free(grp);
+
+	return TEST_SUCCESS;
+}
+
+#define GROUP_NB_FIBS	2
+#define GROUP_NB_IPS	77
+
+static int
+group_lookup_and_check(struct rte_fib_group *grp, struct rte_fib **fibs,
+		       void **dps, uint32_t *ips)
+{
+	uint64_t nh_exp[GROUP_NB_IPS], nh[GROUP_NB_IPS];
+	uint32_t i;
+	int ret;
+
+	for (i = 0; i < GROUP_NB_IPS; i++) {
+		ret = rte_fib_lookup_bulk(fibs[i % GROUP_NB_FIBS], &ips[i],
+					  &nh_exp[i], 1);
+		RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
+	}
+
+	ret = rte_fib_group_lookup_bulk(grp, dps, ips, nh, GROUP_NB_IPS);
+	RTE_TEST_ASSERT(ret == 0, "Failed to lookup in the group\n");
+
+	for (i = 0; i < GROUP_NB_IPS; i++)
+		RTE_TEST_ASSERT(nh[i] == nh_exp[i],
+			"Failed to get proper nexthop\n");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Create FIBs of one group holding different routes, then check that one
+ * lookup over the group returns what a lookup in each of the FIBs does.
+ */
+static int
+check_group(struct rte_fib_conf *config)
+{
+	static const uint32_t probes[] = {
+		RTE_IPV4(10, 0, 0, 1), RTE_IPV4(10, 1, 0, 1),
+		RTE_IPV4(10, 2, 0, 1), RTE_IPV4(10, 1, 2, 1),
+		RTE_IPV4(10, 2, 2, 1), RTE_IPV4(10, 1, 2, 129),
+		RTE_IPV4(10, 2, 2, 200), RTE_IPV4(192, 0, 2, 1),
+		RTE_IPV4(192, 0, 2, 2), RTE_IPV4(255, 255, 255, 255),
+		RTE_IPV4(11, 0, 0, 1),
+	};
+	static const enum rte_fib_lookup_type types[] = {
+		RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO,
+		RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512,
+	};
+	struct rte_fib_group_conf grp_conf = { 0 };
+	struct rte_fib *fibs[GROUP_NB_FIBS];
+	char name[RTE_FIB_NAMESIZE];
+	uint32_t ips[GROUP_NB_IPS];
+	struct rte_fib_group *grp;
+	void *dps[GROUP_NB_IPS];
+	uint32_t i, f;
+	int ret;
+
+	grp_conf.type = config->type;
+	grp_conf.flags = config->flags;
+	grp_conf.dir24_8.nh_sz = config->dir24_8.nh_sz;
+	grp = rte_fib_group_create(&grp_conf);
+	RTE_TEST_ASSERT(grp != NULL, "Failed to create group\n");
+	config->group = grp;
+
+	for (f = 0; f < GROUP_NB_FIBS; f++) {
+		snprintf(name, sizeof(name), "%s_%u", __func__, f);
+		fibs[f] = rte_fib_create(name, SOCKET_ID_ANY, config);
+		RTE_TEST_ASSERT(fibs[f] != NULL, "Failed to create FIB\n");
+
+		ret = rte_fib_add(fibs[f], RTE_IPV4(10, 0, 0, 0), 8, 10 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(10, f + 1, 0, 0), 16, 20 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(10, f + 1, 2, 0), 24, 30 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(10, f + 1, 2, 128), 25, 40 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(192, 0, 2, f + 1), 32, 50 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(255, 255, 255, 0), 24, 60 + f);
+		ret |= rte_fib_add(fibs[f], RTE_IPV4(255, 255, 255, 255), 32, 70 + f);
+		RTE_TEST_ASSERT(ret == 0, "Failed to add a route\n");
+	}
+
+	for (i = 0; i < GROUP_NB_IPS; i++) {
+		ips[i] = probes[i % RTE_DIM(probes)];
+		if (config->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER)
+			ips[i] = rte_cpu_to_be_32(ips[i]);
+		dps[i] = rte_fib_get_dp(fibs[i % GROUP_NB_FIBS]);
+	}
+
+	ret = group_lookup_and_check(grp, fibs, dps, ips);
+	RTE_TEST_ASSERT(ret == TEST_SUCCESS, "Lookup and check fails\n");
+
+	for (i = 0; i < RTE_DIM(types); i++) {
+		if (rte_fib_group_select_lookup(grp, types[i]) != 0)
+			continue;
+		ret = group_lookup_and_check(grp, fibs, dps, ips);
+		RTE_TEST_ASSERT(ret == TEST_SUCCESS, "Lookup and check fails\n");
+	}
+
+	rte_fib_group_free(grp);
+	for (f = 0; f < GROUP_NB_FIBS; f++)
+		rte_fib_free(fibs[f]);
+	config->group = NULL;
+
+	return TEST_SUCCESS;
+}
+
+int32_t
+test_group_lookup(void)
+{
+	struct rte_fib_conf config = { 0 };
+	unsigned int flags, nh_sz;
+	int ret;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = 100;
+	config.type = RTE_FIB_DUMMY;
+
+	ret = check_group(&config);
+	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
+		"Check_group fails for DUMMY type\n");
+
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.num_tbl8 = 127;
+
+	for (flags = 0; flags <= RTE_FIB_F_LOOKUP_NETWORK_ORDER; flags++) {
+		config.flags = flags;
+		for (nh_sz = RTE_FIB_DIR24_8_1B; nh_sz <= RTE_FIB_DIR24_8_8B; nh_sz++) {
+			config.dir24_8.nh_sz = nh_sz;
+			ret = check_group(&config);
+			RTE_TEST_ASSERT(ret == TEST_SUCCESS,
+				"Check_group fails for DIR24_8 nh_sz %u flags %u\n",
+				nh_sz, flags);
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
 /*
  * rte_fib_rcu_qsbr_add positive and negative tests.
  *  - Add RCU QSBR variable to FIB
@@ -692,6 +906,8 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
 	TEST_CASE(test_wraparound),
+	TEST_CASE(test_group_invalid),
+	TEST_CASE(test_group_lookup),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 41ab5764b6..d6a01bf4a6 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -45,6 +45,12 @@ The main methods within the ``rte_fib`` API are:
 * ``rte_fib_lookup_bulk()``: Provides a bulk Longest Prefix Match (LPM) lookup function
   for a set of IP addresses, it will return a set of corresponding next hop IDs.
 
+* ``rte_fib_group_lookup_bulk()``: Same as ``rte_fib_lookup_bulk()``,
+  with every IP address looked up in its own FIB, given by its ``rte_fib_get_dp()`` pointer.
+  These FIBs must belong to the same group, created with ``rte_fib_group_create()``
+  and passed in the ``group`` field of their configuration.
+  A group only accepts FIBs of its own type, flags and next hop size.
+
 
 Implementation details
 ----------------------
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 68029c6165..c8797bd447 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -147,6 +147,76 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 	return NULL;
 }
 
+static inline fib_lookup_multi_fn_t
+get_scalar_multi_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
+{
+	switch (nh_sz) {
+	case RTE_FIB_DIR24_8_1B:
+		return be_addr ? dir24_8_lookup_bulk_multi_1b_be : dir24_8_lookup_bulk_multi_1b;
+	case RTE_FIB_DIR24_8_2B:
+		return be_addr ? dir24_8_lookup_bulk_multi_2b_be : dir24_8_lookup_bulk_multi_2b;
+	case RTE_FIB_DIR24_8_4B:
+		return be_addr ? dir24_8_lookup_bulk_multi_4b_be : dir24_8_lookup_bulk_multi_4b;
+	case RTE_FIB_DIR24_8_8B:
+		return be_addr ? dir24_8_lookup_bulk_multi_8b_be : dir24_8_lookup_bulk_multi_8b;
+	default:
+		return NULL;
+	}
+}
+
+static inline fib_lookup_multi_fn_t
+get_vector_multi_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
+{
+#ifdef CC_AVX512_SUPPORT
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) <= 0 ||
+			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_512)
+		return NULL;
+
+	switch (nh_sz) {
+	case RTE_FIB_DIR24_8_1B:
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_multi_1b_be :
+			rte_dir24_8_vec_lookup_bulk_multi_1b;
+	case RTE_FIB_DIR24_8_2B:
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_multi_2b_be :
+			rte_dir24_8_vec_lookup_bulk_multi_2b;
+	case RTE_FIB_DIR24_8_4B:
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_multi_4b_be :
+			rte_dir24_8_vec_lookup_bulk_multi_4b;
+	case RTE_FIB_DIR24_8_8B:
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_multi_8b_be :
+			rte_dir24_8_vec_lookup_bulk_multi_8b;
+	default:
+		return NULL;
+	}
+#else
+	RTE_SET_USED(nh_sz);
+	RTE_SET_USED(be_addr);
+#endif
+	return NULL;
+}
+
+fib_lookup_multi_fn_t
+dir24_8_get_lookup_multi_fn(enum rte_fib_dir24_8_nh_sz nh_sz, enum rte_fib_lookup_type type,
+			    bool be_addr)
+{
+	fib_lookup_multi_fn_t ret_fn;
+
+	switch (type) {
+	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO:
+	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_INLINE:
+	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_UNI:
+		return get_scalar_multi_fn(nh_sz, be_addr);
+	case RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512:
+		return get_vector_multi_fn(nh_sz, be_addr);
+	case RTE_FIB_LOOKUP_DEFAULT:
+		ret_fn = get_vector_multi_fn(nh_sz, be_addr);
+		return ret_fn != NULL ? ret_fn : get_scalar_multi_fn(nh_sz, be_addr);
+	default:
+		return NULL;
+	}
+}
+
 static void
 write_to_fib(void *ptr, uint64_t val, enum rte_fib_dir24_8_nh_sz size, int n)
 {
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..de54b70994 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -19,6 +19,9 @@
  * DIR24_8 algorithm
  */
 
+typedef void (*fib_lookup_multi_fn_t)(void * const *dps, const uint32_t *ips,
+				      uint64_t *next_hops, const unsigned int n);
+
 #define DIR24_8_TBL24_NUM_ENT		(1 << 24)
 #define DIR24_8_TBL8_GRP_NUM_ENT	256U
 #define DIR24_8_EXT_ENT			1
@@ -286,6 +289,62 @@ DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_2)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_3)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_uni)
 
+#define LOOKUP_MULTI_FUNC(suffix, type)					\
+static inline void							\
+dir24_8_lookup_bulk_multi_##suffix(void * const *dps, const uint32_t *ips, \
+				   uint64_t *next_hops, const unsigned int n) \
+{									\
+	const struct dir24_8_tbl *dp;					\
+	uint64_t tmp;							\
+	uint32_t i;							\
+									\
+	for (i = 0; i < n; i++) {					\
+		dp = dps[i];						\
+		tmp = ((const type *)dp->tbl24)[ips[i] >> 8];		\
+		if (unlikely(is_entry_extended(tmp)))			\
+			tmp = ((const type *)dp->tbl8)[(uint8_t)ips[i] + \
+				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)];	\
+		next_hops[i] = tmp >> 1;				\
+	}								\
+}
+
+LOOKUP_MULTI_FUNC(1b, uint8_t)
+LOOKUP_MULTI_FUNC(2b, uint16_t)
+LOOKUP_MULTI_FUNC(4b, uint32_t)
+LOOKUP_MULTI_FUNC(8b, uint64_t)
+
+static inline void
+dir24_8_lookup_bulk_multi_be(void * const *dps, const uint32_t *ips, uint64_t *next_hops,
+			     const unsigned int n, fib_lookup_multi_fn_t cb)
+{
+	uint32_t le_ips[BSWAP_MAX_LENGTH];
+	unsigned int i;
+
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	cb(dps, ips, next_hops, n);
+#else
+	for (i = 0; i < n; i += BSWAP_MAX_LENGTH) {
+		int j;
+		for (j = 0; j < BSWAP_MAX_LENGTH && i + j < n; j++)
+			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
+
+		cb(dps + i, le_ips, next_hops + i, j);
+	}
+#endif
+}
+
+#define DECLARE_BE_LOOKUP_MULTI_FN(name) \
+static inline void \
+name##_be(void * const *dps, const uint32_t *ips, uint64_t *next_hops, const unsigned int n) \
+{ \
+	dir24_8_lookup_bulk_multi_be(dps, ips, next_hops, n, name); \
+}
+
+DECLARE_BE_LOOKUP_MULTI_FN(dir24_8_lookup_bulk_multi_1b)
+DECLARE_BE_LOOKUP_MULTI_FN(dir24_8_lookup_bulk_multi_2b)
+DECLARE_BE_LOOKUP_MULTI_FN(dir24_8_lookup_bulk_multi_4b)
+DECLARE_BE_LOOKUP_MULTI_FN(dir24_8_lookup_bulk_multi_8b)
+
 void *
 dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *conf);
 
@@ -295,6 +354,10 @@ dir24_8_free(void *p);
 rte_fib_lookup_fn_t
 dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr);
 
+fib_lookup_multi_fn_t
+dir24_8_get_lookup_multi_fn(enum rte_fib_dir24_8_nh_sz nh_sz, enum rte_fib_lookup_type type,
+			    bool be_addr);
+
 int
 dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op);
diff --git a/lib/fib/dir24_8_avx512.c b/lib/fib/dir24_8_avx512.c
index 89b43583c7..517d3727da 100644
--- a/lib/fib/dir24_8_avx512.c
+++ b/lib/fib/dir24_8_avx512.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
+#include <stddef.h>
+
 #include <rte_vect.h>
 #include <rte_fib.h>
 
@@ -169,3 +171,83 @@ rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
 		dir24_8_vec_lookup_x8_8b(p, ips + i * 8, next_hops + i * 8, true);
 	dir24_8_lookup_bulk_8b_be(p, ips + i * 8, next_hops + i * 8, n - i * 8);
 }
+
+static inline void
+dir24_8_vec_lookup_multi_x8(void * const *dps, const uint32_t *ips,
+			    uint64_t *next_hops, uint8_t nh_sz)
+{
+	const __m512i tbl24_off = _mm512_set1_epi64(offsetof(struct dir24_8_tbl, tbl24));
+	const __m512i tbl8_off = _mm512_set1_epi64(offsetof(struct dir24_8_tbl, tbl8));
+	const __m512i res_msk = _mm512_set1_epi64(lookup_msk(nh_sz));
+	const __m512i lsbyte_msk = _mm512_set1_epi64(0xff);
+	const __m512i zero = _mm512_setzero_si512();
+	const __m512i lsb = _mm512_set1_epi64(1);
+	__m512i dp_vec, res, idxes, bytes, tbl8s;
+	__mmask8 msk_ext;
+	__m256i ip_vec;
+
+	ip_vec = _mm256_loadu_si256((const void *)ips);
+	dp_vec = _mm512_loadu_si512((const void *)dps);
+
+	/* addresses of the tbl24 entries */
+	idxes = _mm512_cvtepu32_epi64(_mm256_srli_epi32(ip_vec, 8));
+	idxes = _mm512_slli_epi64(idxes, nh_sz);
+	idxes = _mm512_add_epi64(idxes, _mm512_add_epi64(dp_vec, tbl24_off));
+
+	if (nh_sz == RTE_FIB_DIR24_8_8B) {
+		res = _mm512_i64gather_epi64(idxes, NULL, 1);
+	} else {
+		res = _mm512_cvtepu32_epi64(_mm512_i64gather_epi32(idxes, NULL, 1));
+		res = _mm512_and_epi64(res, res_msk);
+	}
+
+	/* get extended entries indexes */
+	msk_ext = _mm512_test_epi64_mask(res, lsb);
+
+	if (msk_ext != 0) {
+		tbl8s = _mm512_mask_i64gather_epi64(zero, msk_ext,
+						    _mm512_add_epi64(dp_vec, tbl8_off), NULL, 1);
+		bytes = _mm512_and_epi64(_mm512_cvtepu32_epi64(ip_vec), lsbyte_msk);
+		idxes = _mm512_srli_epi64(res, 1);
+		idxes = _mm512_slli_epi64(idxes, 8);
+		idxes = _mm512_add_epi64(idxes, bytes);
+		idxes = _mm512_add_epi64(tbl8s, _mm512_slli_epi64(idxes, nh_sz));
+
+		if (nh_sz == RTE_FIB_DIR24_8_8B) {
+			idxes = _mm512_mask_i64gather_epi64(zero, msk_ext, idxes, NULL, 1);
+		} else {
+			idxes = _mm512_cvtepu32_epi64(_mm512_mask_i64gather_epi32(
+				_mm256_setzero_si256(), msk_ext, idxes, NULL, 1));
+			idxes = _mm512_and_epi64(idxes, res_msk);
+		}
+
+		res = _mm512_mask_blend_epi64(msk_ext, res, idxes);
+	}
+
+	res = _mm512_srli_epi64(res, 1);
+	_mm512_storeu_si512(next_hops, res);
+}
+
+#define DECLARE_VECTOR_MULTI_FN(suffix, nh_sz) \
+void \
+rte_dir24_8_vec_lookup_bulk_multi_##suffix(void * const *dps, const uint32_t *ips, \
+					   uint64_t *next_hops, const unsigned int n) \
+{ \
+	uint32_t i; \
+	for (i = 0; i < (n / 8); i++) \
+		dir24_8_vec_lookup_multi_x8(dps + i * 8, ips + i * 8, next_hops + i * 8, nh_sz); \
+	dir24_8_lookup_bulk_multi_##suffix(dps + i * 8, ips + i * 8, next_hops + i * 8, \
+					   n - i * 8); \
+} \
+void \
+rte_dir24_8_vec_lookup_bulk_multi_##suffix##_be(void * const *dps, const uint32_t *ips, \
+						uint64_t *next_hops, const unsigned int n) \
+{ \
+	dir24_8_lookup_bulk_multi_be(dps, ips, next_hops, n, \
+				     rte_dir24_8_vec_lookup_bulk_multi_##suffix); \
+}
+
+DECLARE_VECTOR_MULTI_FN(1b, RTE_FIB_DIR24_8_1B)
+DECLARE_VECTOR_MULTI_FN(2b, RTE_FIB_DIR24_8_2B)
+DECLARE_VECTOR_MULTI_FN(4b, RTE_FIB_DIR24_8_4B)
+DECLARE_VECTOR_MULTI_FN(8b, RTE_FIB_DIR24_8_8B)
diff --git a/lib/fib/dir24_8_avx512.h b/lib/fib/dir24_8_avx512.h
index 3e2bbc2490..b27963598b 100644
--- a/lib/fib/dir24_8_avx512.h
+++ b/lib/fib/dir24_8_avx512.h
@@ -37,4 +37,36 @@ void
 rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
+void
+rte_dir24_8_vec_lookup_bulk_multi_1b(void * const *dps, const uint32_t *ips,
+				     uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_2b(void * const *dps, const uint32_t *ips,
+				     uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_4b(void * const *dps, const uint32_t *ips,
+				     uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_8b(void * const *dps, const uint32_t *ips,
+				     uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_1b_be(void * const *dps, const uint32_t *ips,
+					uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_2b_be(void * const *dps, const uint32_t *ips,
+					uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_4b_be(void * const *dps, const uint32_t *ips,
+					uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_multi_8b_be(void * const *dps, const uint32_t *ips,
+					uint64_t *next_hops, const unsigned int n);
+
 #endif /* _DIR248_AVX512_H_ */
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..5201b76518 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -46,6 +46,15 @@ struct rte_fib {
 	rte_fib_lookup_fn_t	lookup;	/**< FIB lookup function */
 	rte_fib_modify_fn_t	modify; /**< modify FIB datastructure */
 	uint64_t		def_nh;
+	struct rte_fib_group	*group;	/**< group the FIB belongs to */
+};
+
+struct rte_fib_group {
+	fib_lookup_multi_fn_t	lookup;	/**< lookup, one FIB per IP */
+	enum rte_fib_type	type;	/**< Type of the FIBs */
+	unsigned int		flags;	/**< Flags of the FIBs */
+	enum rte_fib_dir24_8_nh_sz nh_sz; /**< Size of nexthop entry */
+	uint32_t		refcnt;
 };
 
 static void
@@ -65,6 +74,16 @@ dummy_lookup(void *fib_p, const uint32_t *ips, uint64_t *next_hops,
 	}
 }
 
+static void
+dummy_lookup_multi(void * const *dps, const uint32_t *ips, uint64_t *next_hops,
+		   const unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		dummy_lookup(dps[i], &ips[i], &next_hops[i], 1);
+}
+
 static int
 dummy_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op)
@@ -150,6 +169,97 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	return 0;
 }
 
+static fib_lookup_multi_fn_t
+fib_group_get_lookup_fn(const struct rte_fib_group *grp, enum rte_fib_lookup_type type)
+{
+	switch (grp->type) {
+	case RTE_FIB_DUMMY:
+		return type == RTE_FIB_LOOKUP_DEFAULT ? dummy_lookup_multi : NULL;
+	case RTE_FIB_DIR24_8:
+		return dir24_8_get_lookup_multi_fn(grp->nh_sz, type,
+			!!(grp->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+	default:
+		return NULL;
+	}
+}
+
+static void
+fib_group_unref(struct rte_fib_group *grp)
+{
+	if (--grp->refcnt == 0)
+		rte_free(grp);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_group_create, 27.03)
+struct rte_fib_group *
+rte_fib_group_create(const struct rte_fib_group_conf *conf)
+{
+	struct rte_fib_group *grp;
+
+	if ((conf == NULL) || (conf->type > RTE_FIB_DIR24_8) ||
+			(conf->flags & ~RTE_FIB_ALLOWED_FLAGS) ||
+			((conf->type == RTE_FIB_DIR24_8) &&
+			((conf->dir24_8.nh_sz < RTE_FIB_DIR24_8_1B) ||
+			(conf->dir24_8.nh_sz > RTE_FIB_DIR24_8_8B)))) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	grp = rte_zmalloc("FIB_GROUP", sizeof(*grp), RTE_CACHE_LINE_SIZE);
+	if (grp == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	grp->type = conf->type;
+	grp->flags = conf->flags;
+	if (conf->type == RTE_FIB_DIR24_8)
+		grp->nh_sz = conf->dir24_8.nh_sz;
+	grp->refcnt = 1;
+	grp->lookup = fib_group_get_lookup_fn(grp, RTE_FIB_LOOKUP_DEFAULT);
+
+	return grp;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_group_free, 27.03)
+void
+rte_fib_group_free(struct rte_fib_group *grp)
+{
+	if (grp == NULL)
+		return;
+
+	fib_group_unref(grp);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_group_lookup_bulk, 27.03)
+int
+rte_fib_group_lookup_bulk(struct rte_fib_group *grp, void * const *dps,
+			  const uint32_t *ips, uint64_t *next_hops, int n)
+{
+	FIB_RETURN_IF_TRUE(((grp == NULL) || (dps == NULL) || (ips == NULL) ||
+		(next_hops == NULL) || (grp->lookup == NULL)), -EINVAL);
+
+	grp->lookup(dps, ips, next_hops, n);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_group_select_lookup, 27.03)
+int
+rte_fib_group_select_lookup(struct rte_fib_group *grp, enum rte_fib_lookup_type type)
+{
+	fib_lookup_multi_fn_t fn;
+
+	if (grp == NULL)
+		return -EINVAL;
+
+	fn = fib_group_get_lookup_fn(grp, type);
+	if (fn == NULL)
+		return -EINVAL;
+
+	grp->lookup = fn;
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_fib_create)
 struct rte_fib *
 rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
@@ -170,6 +280,14 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		return NULL;
 	}
 
+	if ((conf->group != NULL) && ((conf->type != conf->group->type) ||
+			(conf->flags != conf->group->flags) ||
+			((conf->type == RTE_FIB_DIR24_8) &&
+			(conf->dir24_8.nh_sz != conf->group->nh_sz)))) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
@@ -229,6 +347,11 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		goto free_fib;
 	}
 
+	if (conf->group != NULL) {
+		fib->group = conf->group;
+		fib->group->refcnt++;
+	}
+
 	te->data = (void *)fib;
 	TAILQ_INSERT_TAIL(fib_list, te, next);
 
@@ -312,6 +435,8 @@ rte_fib_free(struct rte_fib *fib)
 
 	free_dataplane(fib);
 	rte_rib_free(fib->rib);
+	if (fib->group != NULL)
+		fib_group_unref(fib->group);
 	rte_free(fib);
 	rte_free(te);
 }
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535..f2e0715eaa 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -25,6 +25,7 @@ extern "C" {
 #endif
 
 struct rte_fib;
+struct rte_fib_group;
 struct rte_rib;
 
 /* Maximum length of a FIB name. */
@@ -110,6 +111,19 @@ struct rte_fib_conf {
 		} dir24_8;
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
+	/** Group the FIB belongs to (NULL = no group) */
+	struct rte_fib_group *group;
+};
+
+/** FIB group configuration structure */
+struct rte_fib_group_conf {
+	enum rte_fib_type type; /**< Type of the FIBs of the group */
+	unsigned int flags; /**< RTE_FIB_F_* flags of the FIBs of the group */
+	union {
+		struct {
+			enum rte_fib_dir24_8_nh_sz nh_sz;
+		} dir24_8;
+	};
 };
 
 /** FIB RCU QSBR configuration structure. */
@@ -224,6 +238,80 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth);
 int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 		uint64_t *next_hops, int n);
+
+/**
+ * Create a group of FIBs
+ *
+ * A group gathers FIBs of the same type, flags and next hop size, so that
+ * IP addresses belonging to different FIBs can be looked up in one call.
+ * A FIB joins a group on creation, through the group field of rte_fib_conf.
+ *
+ * Creating and freeing a group and its FIBs must be serialized by the caller.
+ *
+ * @param conf
+ *   Group configuration
+ * @return
+ *   Handle to the group on success
+ *   NULL otherwise with rte_errno set to an appropriate values.
+ */
+__rte_experimental
+struct rte_fib_group *
+rte_fib_group_create(const struct rte_fib_group_conf *conf);
+
+/**
+ * Release a group of FIBs
+ *
+ * The group is freed once all its FIBs have been freed.
+ *
+ * @param grp
+ *   Group handle (NULL is allowed)
+ */
+__rte_experimental
+void
+rte_fib_group_free(struct rte_fib_group *grp);
+
+/**
+ * Lookup multiple IP addresses, each in its own FIB of a group
+ *
+ * @param grp
+ *   Group handle
+ * @param dps
+ *   Array of dataplane struct pointers returned by rte_fib_get_dp(),
+ *   one per IP: ips[i] is looked up in the FIB owning dps[i].
+ *   All these FIBs must belong to grp.
+ * @param ips
+ *   Array of IPs to be looked up in the FIBs
+ * @param next_hops
+ *   Next hop of the most specific rule found for IP.
+ *   This is an array of eight byte values.
+ *   If the lookup for the given IP failed, then corresponding element would
+ *   contain default nexthop value configured for its FIB.
+ * @param n
+ *   Number of elements in dps, ips (and next_hops) arrays to lookup.
+ * @return
+ *   -EINVAL for incorrect arguments, otherwise 0
+ */
+__rte_experimental
+int
+rte_fib_group_lookup_bulk(struct rte_fib_group *grp, void * const *dps,
+			  const uint32_t *ips, uint64_t *next_hops, int n);
+
+/**
+ * Set lookup function of a group based on type
+ *
+ * @param grp
+ *   Group handle
+ * @param type
+ *   Lookup function implementation to use
+ *
+ * @return
+ *   0 on success
+ *   -EINVAL on failure
+ */
+__rte_experimental
+int
+rte_fib_group_select_lookup(struct rte_fib_group *grp, enum rte_fib_lookup_type type);
+
 /**
  * Get pointer to the dataplane specific struct
  *
-- 
2.43.0

