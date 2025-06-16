Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F18C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FE6840656;
	Mon, 16 Jun 2025 12:50:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A5BAF40684
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750071007; x=1781607007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zm+92am3nvKeGP5gaB4IAokB0tBjuoxd93vWPbesUW4=;
 b=AyilpNcz9DrH9k7JJSCLWX7okQG+8jou9+HkPR1YV8GEkoePB3wdrWz8
 SwZ/BJv2wMGT4GIdVUQz+dDBjRS7nYXqw/kZIBTGMzVZRnO7cQ7fYC9Ho
 eUdnXMCSZAww8I8hgtLRrrViGqXQ6iDCcj+ZoaFAmzJKgckoGKok5X4rN
 IHvRoO41knqM3N3c5ZSmrJiYu1D7iBFvY2M7jpc0WsszBGCNjYc0Zb1u3
 mjrxiEsV6ONSG2AZYFdMrN2XkIb7O3cH9VESwq9hG3b8QS2NgWr2XjEGL
 naprb3xcIoLm0dly/7lLA/6Q0uHkKPsr22ypZdJwNGBxRS4R94XzG+frJ Q==;
X-CSE-ConnectionGUID: gN+5vwtkT4+dU6cyV/DP1g==
X-CSE-MsgGUID: 28eXV9k+TPSXSBbCgf8ovw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54828171"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="54828171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:50:06 -0700
X-CSE-ConnectionGUID: 72w6PFj4TDiPe+siiGzScQ==
X-CSE-MsgGUID: /d0ucPcYSIOGWqmsdGYrrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148281566"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 03:50:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 3/3] test/argparse: add test for repeated arguments
Date: Mon, 16 Jun 2025 11:49:43 +0100
Message-ID: <20250616104944.3425929-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250616104944.3425929-1-bruce.richardson@intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
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

Add a test case to check that argparse throws an error when an argument
is repeated on the commandline without the SUPPORT_MULTI flag. Also test
that multiple arguments are correctly handled with the flag.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 57b85c4bf0..0a229752fa 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -329,6 +329,38 @@ test_argparse_invalid_option(void)
 	return 0;
 }
 
+static int
+test_argparse_invalid_repeated_option(void)
+{
+	/* test that we allow repeated args only with the MULTI flag */
+	struct rte_argparse *obj;
+	char *argv[3];
+	int ret;
+
+	/* check that we error out with two "-a" flags */
+	obj = test_argparse_init_obj();
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("-a");
+	ret = rte_argparse_parse(obj, 3, argv);
+	TEST_ASSERT(ret == -EINVAL, "Argparse did not error out with two '-a' flags!");
+
+	obj = test_argparse_init_obj();
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	obj->args[0].flags |= RTE_ARGPARSE_FLAG_SUPPORT_MULTI;
+	/* check that we allow two "-a" flags with MULTI flag set */
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("-a");
+	ret = rte_argparse_parse(obj, 3, argv);
+	TEST_ASSERT(ret == 3, "Argparse failed to handle duplicate '-a' flags!");
+
+	return 0;
+}
+
 static int
 test_argparse_opt_autosave_parse_int_of_no_val(void)
 {
@@ -864,6 +896,7 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_invalid_arg_flags),
 		TEST_CASE(test_argparse_invalid_arg_repeat),
 		TEST_CASE(test_argparse_invalid_option),
+		TEST_CASE(test_argparse_invalid_repeated_option),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_no_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_required_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_optional_val),
-- 
2.48.1

