Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393BDC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 16:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E811640A73;
	Mon,  6 Jul 2026 18:24:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8CDBC406BA
 for <dev@dpdk.org>; Mon,  6 Jul 2026 18:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783355049; x=1814891049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BdmjwzpGg2o8XgKJCuBtRwjBJe4Wmu7LFePY+Akiioc=;
 b=md9QFnjWhfTHYIxd6T3D6K90bq04K+QVZSJ7n1nLFiR0zErTVBCwedPC
 A305TjhgKAwbg4jABIYw12kHeXu/OeTKNhmZ+J8zPh7akoU+lO4q5t5nH
 FsHcq1+rrGICYwRnt2uOQsM3WTx2+Bk2itoZcwWZwe0zNGkBRL0NaosvE
 NTSTY89rxTfFgFX4i2dy1xl++uWMhd/XRM2je2ECLbXKRsoebA5zyn9ov
 1ETB+ib4HB9tYOlku7T2POLoQaUV/yTHq93ow4VdpvcHFxOZEmudGO98j
 E88W7I2l2ToVzG4PuQNJFYO9EuJDrgj+OzskHEr0/Od8lT8ybfqgThEeK Q==;
X-CSE-ConnectionGUID: EI4P9MmGQi6S0O3IOiThbA==
X-CSE-MsgGUID: xzXBdHoDR4u2Osd6aHsugw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95148831"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="95148831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 09:24:09 -0700
X-CSE-ConnectionGUID: IYF5Lt1jQcirgq63Hot2RA==
X-CSE-MsgGUID: ZmqBW3QRSOCzhfeF93Gbgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="257335635"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 06 Jul 2026 09:24:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 26.11 4/4] test/cfgfile: test for long lines in file
Date: Mon,  6 Jul 2026 17:23:47 +0100
Message-ID: <20260706162348.460489-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706162348.460489-1-bruce.richardson@intel.com>
References: <20260706162348.460489-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

The test_cfgfiles directory already had a line_too_long.ini file in it,
but this a) did not exceed the line length that the library could manage
and b) was not actually used in any test case.

Fix this by expanding the long line so it does trigger an error, and
adding a test case for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cfgfile.c                  | 20 ++++++++++++++++++++
 app/test/test_cfgfiles/line_too_long.ini |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index 12da87aa5a..f056fe2d4d 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -376,6 +376,25 @@ test_cfgfile_invalid_key_value_pair(void)
 	return 0;
 }
=20
+static int
+test_cfgfile_line_too_long(void)
+{
+	struct rte_cfgfile *cfgfile;
+	char filename[PATH_MAX];
+	int ret;
+
+	ret =3D make_tmp_file(filename, "line_too_long", line_too_long_ini);
+	TEST_ASSERT_SUCCESS(ret, "Failed to setup temp file");
+
+	cfgfile =3D rte_cfgfile_load(filename, 0);
+	TEST_ASSERT_NULL(cfgfile, "Expected failure did not occur");
+
+	ret =3D remove(filename);
+	TEST_ASSERT_SUCCESS(ret, "Failed to remove file");
+
+	return 0;
+}
+
 static int
 test_cfgfile_empty_key_value_pair(void)
 {
@@ -555,6 +574,7 @@ unit_test_suite test_cfgfile_suite  =3D {
 		TEST_CASE(test_cfgfile_invalid_section_header),
 		TEST_CASE(test_cfgfile_invalid_comment),
 		TEST_CASE(test_cfgfile_invalid_key_value_pair),
+		TEST_CASE(test_cfgfile_line_too_long),
 		TEST_CASE(test_cfgfile_empty_key_value_pair),
 		TEST_CASE(test_cfgfile_missing_section),
 		TEST_CASE(test_cfgfile_global_properties),
diff --git a/app/test/test_cfgfiles/line_too_long.ini b/app/test/test_cfgfi=
les/line_too_long.ini
index 1dce164838..2683cd2938 100644
--- a/app/test/test_cfgfiles/line_too_long.ini
+++ b/app/test/test_cfgfiles/line_too_long.ini
@@ -1,3 +1,3 @@
 [section1]
 ; this is section 1
-01234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
4567890123456789012345678901234567890123456789012345678901234567890123456789
+01234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
456789012345678901234567890123456789012345678901234567890123456789012345678=
901234567890123456789012345678901234567890123456789012345678901234567890123=
45678901234567890123456789
--=20
2.53.0

