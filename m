Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00F606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=SKhEcHvM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AAB4402D6;
	Tue, 17 Nov 2026 08:58:23 +0100 (CET)
Received: from pmg.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTPS id D7843400EF;
 Mon, 16 Nov 2026 09:59:36 +0100 (CET)
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
 by pmg.amicon.ru (Proxmox) with ESMTP id 9BEAA1016DB;
 Mon, 16 Nov 2026 11:59:33 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
 by pmg.amicon.ru (Proxmox) with ESMTPS id 6A5E51012A5;
 Mon, 16 Nov 2026 11:59:33 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1794819573; h=from:subject:to:date:message-id;
 bh=BI4rfcajWl5FhLhOFw9UYEXpVnT6JB14PaHsoeJwtq4=;
 b=SKhEcHvMZt1IwEy6sZYP0sKN3jPud2blCgnC72f0TB5P+m8St9k+dZu5avH8p5tnNIBajAXJPPX
 RIP922jI+aDhFiougzw/nfKDX4qMaqabiELWB8OLzrdkzBU2ZeNlwlbxZF79bd11JSNigThkl3o5T
 tl0V5Z+Rm2LG2/6KAVaBRX6qRnRcEchPQc3YULj1c/X+0MFhdd2a+BbgEnglv1E9mLAPecXqXfRC/
 G2abvRmgXFTwaHQGzVJGZ5CyzYeib9S44ZrP0gpB+40ow41H5JZAwpdQY1E7S2XKjpYd7hWoARy33
 TdmHU6d78tATVtd9SSE4OTuQXDInIPXufzXg==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 16 Nov
 2026 11:59:32 +0300
From: Artem Novikov <naa@amicon.ru>
To: <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <bruce.richardson@intel.com>, "Artem
 Novikov" <naa@amicon.ru>
Subject: [PATCH v2] argparse: fix null dereference in corelist parsing
Date: Mon, 16 Nov 2026 11:58:52 +0300
Message-ID: <20261116085852.16580-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112153039.291045-1-naa@amicon.ru>
References: <20261112153039.291045-1-naa@amicon.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parsing a corelist without a value dereferences val_set even when no
default is configured. This also occurs with
rte_argparse_parse_type(NULL, RTE_ARGPARSE_VALUE_TYPE_CORELIST, &cpus).

Return -EINVAL when the default is missing. Reject a NULL input string
or output pointer in rte_argparse_parse_type() before parsing the value.
Add regression tests for both parsing APIs and copying a configured
default.

Fixes: d78103fb9488 ("argparse: support core lists")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
v2:
* Reject NULL str or val in rte_argparse_parse_type(), as requested.
* Add a regression test for a NULL output pointer.

 app/test/test_argparse.c    | 27 +++++++++++++++++++++++++--
 lib/argparse/rte_argparse.c |  8 ++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index fdc6dd1..1b0db25 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -501,9 +501,10 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 }
 
 static int
-test_argparse_opt_parse_corelist_of_required_val(void)
+test_argparse_opt_parse_corelist(void)
 {
 	struct rte_argparse *obj;
+	rte_cpuset_t default_cpuset;
 	rte_cpuset_t val_cpuset;
 	char *argv[3];
 	int ret;
@@ -531,6 +532,21 @@ test_argparse_opt_parse_corelist_of_required_val(void)
 	TEST_ASSERT(CPU_ISSET(5, &val_cpuset), "Core 5 should be set in corelist!");
 	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in corelist!");
 
+	CPU_ZERO(&default_cpuset);
+	CPU_SET(2, &default_cpuset);
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].val_set = &default_cpuset;
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Default corelist should be accepted, got %d", ret);
+	TEST_ASSERT(memcmp(&val_cpuset, &default_cpuset, sizeof(val_cpuset)) == 0,
+			"Default corelist was not copied");
+
+	obj->args[0].val_set = NULL;
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == -EINVAL, "Missing default should return -EINVAL, got %d", ret);
+	TEST_ASSERT(memcmp(&val_cpuset, &default_cpuset, sizeof(val_cpuset)) == 0,
+			"Rejected corelist changed the saved value");
+
 	return 0;
 }
 
@@ -966,6 +982,13 @@ test_argparse_parse_type_corelist(void)
 			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
 	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (out of range) should have failed!");
 
+	ret = rte_argparse_parse_type(NULL, RTE_ARGPARSE_VALUE_TYPE_CORELIST,
+			&val_cpuset);
+	TEST_ASSERT(ret == -EINVAL, "NULL corelist should return -EINVAL, got %d", ret);
+
+	ret = rte_argparse_parse_type("0", RTE_ARGPARSE_VALUE_TYPE_CORELIST, NULL);
+	TEST_ASSERT(ret == -EINVAL, "NULL saver should return -EINVAL, got %d", ret);
+
 	return 0;
 }
 
@@ -1588,7 +1611,7 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_no_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_required_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_optional_val),
-		TEST_CASE(test_argparse_opt_parse_corelist_of_required_val),
+		TEST_CASE(test_argparse_opt_parse_corelist),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_no_val),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_required_val),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_optional_val),
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 88c3e77..188134a 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -576,6 +576,8 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 	int min = -1;
 
 	if (value == NULL) {
+		if (arg->val_set == NULL)
+			return -EINVAL;
 		*cpuset = *(rte_cpuset_t *)arg->val_set;
 		return 0;
 	}
@@ -971,6 +973,12 @@ rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type,
 		.val_set = NULL,
 		.value_type = val_type,
 	};
+
+	if (str == NULL || val == NULL) {
+		ARGPARSE_LOG(ERR, "argument and value must both be non-NULL!");
+		return -EINVAL;
+	}
+
 	if (val_type == RTE_ARGPARSE_VALUE_TYPE_NONE) {
 		ARGPARSE_LOG(ERR, "argument %s doesn't have value-type!", str);
 		return -EINVAL;
-- 
2.56.0


