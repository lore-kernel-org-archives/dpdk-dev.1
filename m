Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A65C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88F344067B;
	Mon, 17 Aug 2026 16:59:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 215DF402BA
 for <dev@dpdk.org>; Mon, 17 Aug 2026 16:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786978748; x=1818514748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uFZbEYp523x8bYb4ZSRfMuFZlnjPGWBEldsmF3m5ezQ=;
 b=OLW+800ZN0gy1HRHTE7v3oe19I5r791fy+I2kFGyRBuFefqCpc7V15TE
 kkWUY892X6Wza/gIGKCkpBeykTpy+RBhkaOlsS1w+xzfmsdYx44Bk8imD
 6GGx+q7qoxyg5Z54oFozLYyFg/wfFQnM+C518nBVx+a7Rftt8w6Ktqv3r
 dfzSTnK9gbcbnQpGL79R6juPX2kYNYej//MwBQ8e5mOn/75zga43D2t+b
 qAcKHJez53N87Bcf401vmNJpj1YOmdcaMY1E/dEpiUZnJftIWyW6Gau9N
 SHZhMQZU4VJbgZp0RcYmpRTBbSrbdwm11j6TA6eMJJdurHgaCZ4n4ZTCV Q==;
X-CSE-ConnectionGUID: 6ybtu/xsQB+qHwy+MTpVPA==
X-CSE-MsgGUID: rWUV/4r6TPKY7Ownz8Elqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87311446"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="87311446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:59:07 -0700
X-CSE-ConnectionGUID: 3NJBQY20Q9CeXpVGpyGrrQ==
X-CSE-MsgGUID: 4sYrpJWoTci4Mk5Ge99m6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="264972590"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 17 Aug 2026 07:59:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/4] test/cfgfile: verify file modification API
Date: Mon, 17 Aug 2026 15:57:23 +0100
Message-ID: <20260817145855.1421504-4-bruce.richardson@intel.com>
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

