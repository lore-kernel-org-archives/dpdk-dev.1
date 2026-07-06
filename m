Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA5BC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 16:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F221340A6B;
	Mon,  6 Jul 2026 18:24:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E587F4064A
 for <dev@dpdk.org>; Mon,  6 Jul 2026 18:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783355048; x=1814891048;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uFZbEYp523x8bYb4ZSRfMuFZlnjPGWBEldsmF3m5ezQ=;
 b=i7k9eKM5sBoM5ChjENAPM4fm46yY6XR1kVTd4IHCqKh9qyBvtLZ30uxM
 Vsu+ajgg0IAM37GBCI6P6Y+ZrZbfeRUVICVPEWiCn3Fuvd73k0J8cmAua
 uD2CW1eEvTJ/jc9E0e9UMhoOEhXiwXxCQyxjPG87kqpBit8y0TeswOKhM
 pP2nbbg5G0Aq6A8J0ZMXtTJAD6VwBM8h+bD70Q9lttsysS11fQHIch4R0
 SysnusfhRkjW57emk0gRoVWA8LxqzAndW7M6gU67EzQn0mYGv7QQJ16b2
 n2QW4BntPXo+OI/U2X0lxyUtlAtamY36bP60JU4hWVFE0w8Q25uQy6X2O A==;
X-CSE-ConnectionGUID: xUF8IbMqRC2AX4WRGnnnWQ==
X-CSE-MsgGUID: 8kO7Ylk+Qwa8mwRJXiuezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95148826"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="95148826"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 09:24:07 -0700
X-CSE-ConnectionGUID: 67MBbC8IRYy1W13jqIn7JQ==
X-CSE-MsgGUID: WRpGaTFNRcOG0XJWsRBuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="257335629"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 06 Jul 2026 09:24:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 26.11 3/4] test/cfgfile: verify file modification API
Date: Mon,  6 Jul 2026 17:23:46 +0100
Message-ID: <20260706162348.460489-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706162348.460489-1-bruce.richardson@intel.com>
References: <20260706162348.460489-1-bruce.richardson@intel.com>
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

Check that the has_entry API correctly reports the presence of a valid
entry, and then verify that if we use set_entry we can modify the value
- a modification that persists if we use the save API. In the same test,
also check that we can't use add_entry to modify an existing entry, and
that we can't use set_entry to add a missing entry.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cfgfile.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index 5ed116866d..12da87aa5a 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -491,6 +491,60 @@ test_cfgfile_empty_file(void)
 	return 0;
 }
 
+static int
+test_cfgfile_modify_entry(void)
+{
+	struct rte_cfgfile *cfgfile;
+	struct rte_cfgfile *loaded;
+	const char *value;
+	char filename[PATH_MAX];
+	int ret;
+
+	ret = make_tmp_file(filename, "sample1_set", sample1_ini);
+	TEST_ASSERT_SUCCESS(ret, "Failed to setup temp file");
+
+	cfgfile = rte_cfgfile_load(filename, 0);
+	TEST_ASSERT_NOT_NULL(cfgfile, "Failed to load config file");
+
+	ret = rte_cfgfile_has_entry(cfgfile, "section2", "key2");
+	TEST_ASSERT(ret == 1, "section2 key2 entry missing");
+
+	ret = rte_cfgfile_has_entry(cfgfile, "section2", "invalid_key");
+	TEST_ASSERT(ret == 0, "section2 'invalid_key' entry should be missing");
+
+	ret = rte_cfgfile_set_entry(cfgfile, "section2", "key2", "value_of_key2");
+	TEST_ASSERT_SUCCESS(ret, "Failed to set section2 key2");
+
+	/* check we can't set a nonexistent key */
+	ret = rte_cfgfile_set_entry(cfgfile, "section2", "invalid_key", "value_of_key4");
+	TEST_ASSERT(ret < 0, "Error, unexpectedly able to set nonexistent 'invalid_key'");
+
+	/* check we can't add an existing key */
+	ret = rte_cfgfile_add_entry(cfgfile, "section2", "key2", "value_of_key2");
+	TEST_ASSERT(ret < 0, "Error, unexpectedly able to add existing key2");
+
+	ret = rte_cfgfile_save(cfgfile, filename);
+	TEST_ASSERT_SUCCESS(ret, "Failed to save cfgfile");
+
+	ret = rte_cfgfile_close(cfgfile);
+	TEST_ASSERT_SUCCESS(ret, "Failed to close cfgfile");
+
+	loaded = rte_cfgfile_load(filename, 0);
+	TEST_ASSERT_NOT_NULL(loaded, "Failed to reload saved cfgfile");
+
+	value = rte_cfgfile_get_entry(loaded, "section2", "key2");
+	TEST_ASSERT(strcmp("value_of_key2", value) == 0,
+			"Unexpected section2 key2 value: %s", value);
+
+	ret = rte_cfgfile_close(loaded);
+	TEST_ASSERT_SUCCESS(ret, "Failed to close reloaded cfgfile");
+
+	ret = remove(filename);
+	TEST_ASSERT_SUCCESS(ret, "Failed to remove file");
+
+	return 0;
+}
+
 static struct
 unit_test_suite test_cfgfile_suite  = {
 	.suite_name = "Test Cfgfile Unit Test Suite",
@@ -506,6 +560,7 @@ unit_test_suite test_cfgfile_suite  = {
 		TEST_CASE(test_cfgfile_global_properties),
 		TEST_CASE(test_cfgfile_empty_file),
 		TEST_CASE(test_cfgfile_create_add_save_reload),
+		TEST_CASE(test_cfgfile_modify_entry),
 
 		TEST_CASES_END()
 	}
-- 
2.53.0

