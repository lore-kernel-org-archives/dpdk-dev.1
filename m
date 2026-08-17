Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEFEC5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C354065A;
	Mon, 17 Aug 2026 16:59:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0E317402BA
 for <dev@dpdk.org>; Mon, 17 Aug 2026 16:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786978747; x=1818514747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3TKE/DgICmZY1JIWgugnqbH7yct1+u2TEOVA3DDJpUk=;
 b=LMxPhnHU9e8kMCW7VuR2zQnOCEMtrZJFyN9Xpx3/S3LUahtKhumY0snh
 8hoKB8AEREMF1/ESl7apDWxYWxw8FsnxMWnoeGRgRkKMvhy5p3UEHVbET
 8XMfEuIkjAVKdwpHpnZMeyTNM6o6lWHoFTXfLQjvDkaXF7Ggxjnjy6Tuy
 ahICfGLSd5wSP9X0moyuxqMZkiebAKE514X7cQ2TFLEzE1x/PH15cQSGm
 vHxWN+hm+fdjdEugpt+B3cdhinNDdUrayGIoFIYh0zCYM7AETxPqoouK1
 yrEQpDQBghbzwiwoxWVnFoUiWQJ26tGTH21m+6e2jsfG/IR0Kgdsytq+D Q==;
X-CSE-ConnectionGUID: hO80qlBiR1uE6p5tshw3zQ==
X-CSE-MsgGUID: NAh7UwanTlaxvx/39HjwWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87311445"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="87311445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:59:06 -0700
X-CSE-ConnectionGUID: zoLODx9QS4yLyRqZIQxMhA==
X-CSE-MsgGUID: aaIVIQ9hTnGIBdc2iNKgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="264972587"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 17 Aug 2026 07:59:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/4] test/cfgfile: validate config creation APIs
Date: Mon, 17 Aug 2026 15:57:22 +0100
Message-ID: <20260817145855.1421504-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817145855.1421504-1-bruce.richardson@intel.com>
References: <20260706162348.460489-1-bruce.richardson@intel.com>
 <20260817145855.1421504-1-bruce.richardson@intel.com>
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

Add a test case creating a new configfile and then saving that to disk.
Verify the result by reading the file back in and checking entries are
as expected.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cfgfile.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index 2f1c8ec423..5ed116866d 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -197,6 +197,74 @@ test_cfgfile_sample2(void)
 	return 0;
 }
 
+static int
+test_cfgfile_create_add_save_reload(void)
+{
+	struct rte_cfgfile *cfgfile;
+	struct rte_cfgfile *loaded;
+	const char *value;
+	char filename[PATH_MAX];
+	int ret;
+
+	cfgfile = rte_cfgfile_create(0);
+	TEST_ASSERT_NOT_NULL(cfgfile, "Failed to create cfgfile");
+
+	ret = rte_cfgfile_add_section(cfgfile, "section1");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section1");
+	ret = rte_cfgfile_add_entry(cfgfile, "section1", "key1", "value1");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section1 key1");
+	ret = rte_cfgfile_add_entry(cfgfile, "section1", "key2", "value2");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section1 key2");
+
+	ret = rte_cfgfile_add_section(cfgfile, "section2");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section2");
+	ret = rte_cfgfile_add_entry(cfgfile, "section2", "key3", "value3");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section2 key3");
+	ret = rte_cfgfile_add_entry(cfgfile, "section2", "key4", "value4");
+	TEST_ASSERT_SUCCESS(ret, "Failed to add section2 key4");
+
+	ret = make_tmp_file(filename, "create_save", "");
+	TEST_ASSERT_SUCCESS(ret, "Failed to make temporary output file");
+
+	ret = rte_cfgfile_save(cfgfile, filename);
+	TEST_ASSERT_SUCCESS(ret, "Failed to save cfgfile");
+
+	ret = rte_cfgfile_close(cfgfile);
+	TEST_ASSERT_SUCCESS(ret, "Failed to close created cfgfile");
+
+	loaded = rte_cfgfile_load(filename, 0);
+	TEST_ASSERT_NOT_NULL(loaded, "Failed to load saved cfgfile");
+
+	ret = rte_cfgfile_num_sections(loaded, NULL, 0);
+	TEST_ASSERT(ret == 2, "Unexpected number of sections: %d", ret);
+
+	ret = rte_cfgfile_section_num_entries(loaded, "section1");
+	TEST_ASSERT(ret == 2, "Unexpected section1 entries: %d", ret);
+	ret = rte_cfgfile_section_num_entries(loaded, "section2");
+	TEST_ASSERT(ret == 2, "Unexpected section2 entries: %d", ret);
+
+	value = rte_cfgfile_get_entry(loaded, "section1", "key1");
+	TEST_ASSERT(strcmp("value1", value) == 0,
+			"section1 key1 unexpected value: %s", value);
+	value = rte_cfgfile_get_entry(loaded, "section1", "key2");
+	TEST_ASSERT(strcmp("value2", value) == 0,
+			"section1 key2 unexpected value: %s", value);
+	value = rte_cfgfile_get_entry(loaded, "section2", "key3");
+	TEST_ASSERT(strcmp("value3", value) == 0,
+			"section2 key3 unexpected value: %s", value);
+	value = rte_cfgfile_get_entry(loaded, "section2", "key4");
+	TEST_ASSERT(strcmp("value4", value) == 0,
+			"section2 key4 unexpected value: %s", value);
+
+	ret = rte_cfgfile_close(loaded);
+	TEST_ASSERT_SUCCESS(ret, "Failed to close loaded cfgfile");
+
+	ret = remove(filename);
+	TEST_ASSERT_SUCCESS(ret, "Failed to remove file");
+
+	return 0;
+}
+
 static int
 test_cfgfile_realloc_sections(void)
 {
@@ -437,6 +505,7 @@ unit_test_suite test_cfgfile_suite  = {
 		TEST_CASE(test_cfgfile_missing_section),
 		TEST_CASE(test_cfgfile_global_properties),
 		TEST_CASE(test_cfgfile_empty_file),
+		TEST_CASE(test_cfgfile_create_add_save_reload),
 
 		TEST_CASES_END()
 	}
-- 
2.53.0

