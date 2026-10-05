Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC05CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8630B40DDD;
	Mon,  5 Oct 2026 18:55:22 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id AA10140E17
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:55:18 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1219052a91.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791219318;
 x=1791824118; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XP5HD1p2O+FrgmKFpdAGaCRDciPD/RuM80bEZQNEZ5I=;
 b=mTIItrTlcPKfmrtw5IohlnBYKr2v7jWpkCEuk3W/feBnnHzk31mYDoGfQhKBlZuQ/T
 S5IlAFBK19YPVRO8kXb5TTl0n1E5sWRXt6uZZI2t8YiVynG8ff1feE81tH3qPQTex9WU
 Jj93Xy0j+56DGef/EwP5Xey8yFGFAlZbcVGTaFr1LBRzRPubIKmYl+XuJ1cJPRAwwbEg
 S5Gh+tQCIKBD0CNyGFPZa43PXDsyzo4L6p29s1u4Joza7t/HzEOO2Q3U/UZQgZLODIr2
 RQrcVmQEnp4DzvocYu6knC1nK+HwcR5qeheQ3YJDaLD7L+tUDDfHbxpzApaaZwC2I7GY
 iZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219318; x=1791824118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XP5HD1p2O+FrgmKFpdAGaCRDciPD/RuM80bEZQNEZ5I=;
 b=yGfSfss2B1qqrpy3jv8yNC5OBzpRouN3AH/HPPtO7EUmEF1rXLUJkIPMo7R6J1GbDR
 ibbLckE3gEOp9Cou+q5iIwBMiW+0IQHwfk6Mng8pp0OrGX5Z6sREyXHGqswAeeFJM3es
 5rgx84clXVQ5hvokR9m+xLzJ05mRuoGedeZj65vPKycSGxFKjsCJH/tNtdhFw/CJBS6l
 PIWc6UrY9rFoSJVqUkSKlZFKLbACMQZgu6k9c51gFvds5vKp4drHWbfwiBYMPIkuDK4+
 rmzOgq/Z4H3kgiJ5t2v7pBA4rnJWgYKvUIpAcyQTV1J5UrSlo2FNrJsOZY0SMfYkoL70
 S/Gg==
X-Gm-Message-State: AFq9FYIRtKK1UzwLB+zUl5CBZQm359/3+/DnChfropWbgKD/P7JwJ2Nf
 8eggv0QAbNsM+Ud1FVuVgnAQsKl1sVLURUINPrg0uYWszWU4eOm++9Jmoq/Wf91JqBMbSbVseJj
 VOaU6LUw=
X-Gm-Gg: AYBFou3DpT3P0RjH4PZiszFinP8apm3WbJR+z2EMVPTa4SrNq04alaiT40psHEa7pFb
 lHEm+4nD3nWtij6rP4L+zmMNojmsjK1J7+IxTjvOIAhC0aURJcg8O2gyfujNSy53Og2HROyYoDi
 lkvq4kBYMxDVbEY4ae41Pf9lzGr67S/m+m/ATD9DvqdizfVudDmjQ4FEp8egekOswvs5LogG05R
 jZ0y5rv5inhEd5hwnHO3+yilUBcB3k3xJq23ikg2rf+NkrTC4ijLLFpq9LwW+Ye4UAuflyyGSKu
 GLfod/EAe/EgLRGgja9DvApO2GrSzkWDQjexgLUOKer/T/VJz3KiV3CPO5mtGu8CBQq/b6LxkQU
 03LpLx/HfgUujR90W+PjYeU6YT7hH2bdBxL5Pa6fVz/ocDV+YdxzvyWLfCkZ/3p94LHWsTpSIju
 OVqC9hvPlbRaMjKjDmpIqx3B4v54PgIukWjYOQSuW7e8czGM5+fW92TyU8Ik3KD+wo/21FLX4NL
 lK7zp1Gn9osj770v5v1rk9Zf2i6reBFgPrf4Q==
X-Received: by 2002:a17:90b:5604:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3a6ce82a386mr8496751a91.46.1791219317779; 
 Mon, 05 Oct 2026 09:55:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533aba95sm289414a91.2.2026.10.05.09.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:55:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4/4] test/devargs: add tests for missing device arguments
Date: Mon,  5 Oct 2026 09:53:50 -0700
Message-ID: <20261005165512.334085-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005165512.334085-1-stephen@networkplumber.org>
References: <20261005165512.334085-1-stephen@networkplumber.org>
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

There was no coverage for a device string with no driver arguments,
which is how Bugzilla 2049 went unnoticed: global device syntax with
no driver layer left args NULL and drivers crashed passing it to
rte_kvargs_parse().

Add a devargs case asserting args is non-NULL and empty for global
syntax without a driver layer, and that it parses as kvargs the way a
driver would use it.  Add a kvargs case for rte_kvargs_parse(NULL),
which must give an empty list.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_devargs.c | 60 +++++++++++++++++++++++++++++++++++++++++
 app/test/test_kvargs.c  | 16 +++++++++++
 2 files changed, 76 insertions(+)

diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index de0dd2364d..693bf362d4 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -193,6 +193,65 @@ test_invalid_devargs(void)
 	return fail;
 }
 
+/*
+ * Global device syntax without a driver layer must still leave args set,
+ * as the legacy syntax does.  Drivers pass it straight to
+ * rte_kvargs_parse(), which used to crash on NULL.
+ */
+static int
+test_devargs_no_driver_layer(void)
+{
+	static const char * const list[] = {
+		"bus=vdev,name=net_null0",
+		"bus=vdev,name=net_null0/class=eth",
+		"class=eth",
+	};
+	struct rte_kvargs *kvlist;
+	struct rte_devargs da;
+	uint32_t i;
+	int ret;
+	int fail = TEST_SUCCESS;
+
+	if (rte_bus_find_by_name("vdev") == NULL ||
+	    rte_class_find_by_name("eth") == NULL) {
+		printf("vdev bus or eth class missing, skipping\n");
+		return TEST_SKIPPED;
+	}
+
+	for (i = 0; i < RTE_DIM(list); i++) {
+		memset(&da, 0, sizeof(da));
+		ret = rte_devargs_parse(&da, list[i]);
+		if (ret < 0) {
+			printf("rte_devargs_parse(%s) returned %d (but should not)\n",
+			       list[i], ret);
+			fail = TEST_FAILED;
+			goto cleanup;
+		}
+		if (da.args == NULL) {
+			printf("rte_devargs_parse(%s) left args NULL\n", list[i]);
+			fail = TEST_FAILED;
+			goto cleanup;
+		}
+		if (da.args[0] != '\0') {
+			printf("rte_devargs_parse(%s) args (%s) not empty\n",
+			       list[i], da.args);
+			fail = TEST_FAILED;
+			goto cleanup;
+		}
+		/* What a driver does with it. */
+		kvlist = rte_kvargs_parse(da.args, NULL);
+		if (kvlist == NULL) {
+			printf("rte_kvargs_parse(%s args) failed\n", list[i]);
+			fail = TEST_FAILED;
+			goto cleanup;
+		}
+		rte_kvargs_free(kvlist);
+cleanup:
+		rte_devargs_reset(&da);
+	}
+	return fail;
+}
+
 struct devargs_parse_case {
 	const char *devargs;
 	uint8_t devargs_count;
@@ -300,6 +359,7 @@ static struct unit_test_suite devargs_test_suite = {
 	.unit_test_cases = {
 		TEST_CASE(test_valid_devargs),
 		TEST_CASE(test_invalid_devargs),
+		TEST_CASE(test_devargs_no_driver_layer),
 		TEST_CASE(test_valid_devargs_parsing),
 		TEST_CASE(test_invalid_devargs_parsing),
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index a14b75948a..5dd74bec49 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -328,6 +328,21 @@ static int test_invalid_kvargs(void)
 	return -1;
 }
 
+/* NULL means no arguments, and must give an empty list rather than crash. */
+static int
+test_parse_null_args(void)
+{
+	struct rte_kvargs *kvlist;
+
+	kvlist = rte_kvargs_parse(NULL, NULL);
+	TEST_ASSERT_NOT_NULL(kvlist, "rte_kvargs_parse(NULL) returned NULL");
+	TEST_ASSERT_EQUAL(kvlist->count, 0, "rte_kvargs_parse(NULL) count %u, not 0",
+			  kvlist->count);
+	rte_kvargs_free(kvlist);
+
+	return 0;
+}
+
 static struct unit_test_suite kvargs_test_suite  = {
 	.suite_name = "Kvargs Unit Test Suite",
 	.setup = NULL,
@@ -353,6 +368,7 @@ static struct unit_test_suite kvargs_test_suite  = {
 		TEST_CASE(test_parse_list_value),
 		TEST_CASE(test_parse_empty_elements),
 		TEST_CASE(test_parse_with_only_key),
+		TEST_CASE(test_parse_null_args),
 		TEST_CASE(test_invalid_kvargs),
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
-- 
2.53.0

