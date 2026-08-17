Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18424C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:59:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1385A402EB;
	Mon, 17 Aug 2026 16:59:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D8C934021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 16:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786978746; x=1818514746;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/iM3mHgaa5XUpWIplZ4Tzfrsnm6pT132cB9YSjvowk=;
 b=dMMMBek1LzCeKgIninUeUpIj7AWQmFijYGZcVthlIL99smlmailrviMl
 0KJH4tCRmBWdPC6ut67Fd/rn43+N+8y9JBQuaLZXRDt7PQQuFg82PXZFE
 DtyqeLKHQkpevbhniCMkcm74HR/1z71IPtSwTGGOyiaqXNW6RoUPURY8E
 3RVzcPI1ZXcJHHMKdCvmB0jF3qpswwJqgCREVSXB6ZYA47hOrOc/4Puts
 GugZocPH8W87exHc09KpzGdZrI5MtdptPwQOoWgSdhmX8PdzoKMzKEu2y
 ypYQTd1Z+VLPbKac5r0GTndjIhVzBXZA3DkwgNnoPY/EfAaP4PahplG4g g==;
X-CSE-ConnectionGUID: ZTCcxxjlS0qHE2tCugcMWQ==
X-CSE-MsgGUID: 3EDvOjFdS+KDIseQTTtzUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87311444"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="87311444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:59:05 -0700
X-CSE-ConnectionGUID: gIUBWoZcSfu20ogjMCqrnQ==
X-CSE-MsgGUID: fxy3kRvpRkuSpuk7wPkLJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="264972584"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 17 Aug 2026 07:59:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/4] test/cfgfile: improve coverage for listing APIs
Date: Mon, 17 Aug 2026 15:57:21 +0100
Message-ID: <20260817145855.1421504-2-bruce.richardson@intel.com>
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

Improve cfgfile unit-test coverage for listing/index APIs, by adding
assertions for section and entry listing behavior, including:

* expected count validation
* listing sections and entries and checking expected results
* index-based listing checks
* sentinel verification to ensure only expected slots are written

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cfgfile.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index 1e56473064..2f1c8ec423 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -93,7 +93,14 @@ static int
 test_cfgfile_sample1(void)
 {
 	struct rte_cfgfile *cfgfile;
+	struct rte_cfgfile_entry entries[4];
 	char filename[PATH_MAX];
+	char sec0[CFG_NAME_LEN] = {0};
+	char sec1[CFG_NAME_LEN] = {0};
+	char sec2[CFG_NAME_LEN] = "sentinel_section_2";
+	char sec3[CFG_NAME_LEN] = "sentinel_section_3";
+	char index_sec[CFG_NAME_LEN] = {0};
+	char *sections[] = { sec0, sec1, sec2, sec3 };
 	int ret;
 
 	ret = make_tmp_file(filename, "sample1", sample1_ini);
@@ -105,6 +112,52 @@ test_cfgfile_sample1(void)
 	ret = _test_cfgfile_sample(cfgfile);
 	TEST_ASSERT_SUCCESS(ret, "Failed to validate sample file: %d", ret);
 
+	ret = rte_cfgfile_num_sections(cfgfile, NULL, 0);
+	TEST_ASSERT(ret == 2, "Unexpected number of sections: %d", ret);
+
+	ret = rte_cfgfile_sections(cfgfile, sections, 4);
+	TEST_ASSERT(ret == 2, "Unexpected listed sections: %d", ret);
+	TEST_ASSERT(strcmp(sec0, "section1") == 0,
+			"Unexpected section at index 0: %s", sec0);
+	TEST_ASSERT(strcmp(sec1, "section2") == 0,
+			"Unexpected section at index 1: %s", sec1);
+	TEST_ASSERT(strcmp(sec2, "sentinel_section_2") == 0,
+			"Unexpected write past listed sections at index 2: %s", sec2);
+	TEST_ASSERT(strcmp(sec3, "sentinel_section_3") == 0,
+			"Unexpected write past listed sections at index 3: %s", sec3);
+
+	ret = rte_cfgfile_section_num_entries_by_index(cfgfile, index_sec, 0);
+	TEST_ASSERT(ret == 1, "Unexpected entry count at index 0: %d", ret);
+	TEST_ASSERT(strcmp(index_sec, "section1") == 0,
+			"Unexpected section name at index 0: %s", index_sec);
+
+	ret = rte_cfgfile_section_num_entries(cfgfile, "section2");
+	TEST_ASSERT(ret == 2, "Unexpected section2 entry count: %d", ret);
+
+	memset(entries, 0x5a, sizeof(entries));
+	ret = rte_cfgfile_section_entries(cfgfile, "section2", entries, 4);
+	TEST_ASSERT(ret == 2, "Unexpected section2 entry count: %d", ret);
+	TEST_ASSERT(strcmp(entries[0].name, "key2") == 0,
+			"Unexpected section2 first key: %s", entries[0].name);
+	TEST_ASSERT(strcmp(entries[0].value, "value2") == 0,
+			"Unexpected section2 first value: %s", entries[0].value);
+	TEST_ASSERT(strcmp(entries[1].name, "key3") == 0,
+			"Unexpected section2 second key: %s", entries[1].name);
+	TEST_ASSERT(strcmp(entries[1].value, "value3") == 0,
+			"Unexpected section2 second value: %s", entries[1].value);
+	TEST_ASSERT((unsigned char)entries[2].name[0] == 0x5a,
+			"Unexpected write past listed entries at index 2");
+	TEST_ASSERT((unsigned char)entries[3].name[0] == 0x5a,
+			"Unexpected write past listed entries at index 3");
+
+	memset(entries, 0x5a, sizeof(entries));
+	memset(index_sec, 0, sizeof(index_sec));
+	ret = rte_cfgfile_section_entries_by_index(cfgfile, 1, index_sec, entries, 4);
+	TEST_ASSERT(ret == 2,
+			"Unexpected entry count for section at index 1: %d", ret);
+	TEST_ASSERT(strcmp(index_sec, "section2") == 0,
+			"Unexpected section name at index 1: %s", index_sec);
+
 	ret = rte_cfgfile_close(cfgfile);
 	TEST_ASSERT_SUCCESS(ret, "Failed to close cfgfile");
 
-- 
2.53.0

