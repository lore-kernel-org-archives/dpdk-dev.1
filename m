Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E837FD377D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 18:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 843F3402E7;
	Wed, 25 Feb 2026 19:33:34 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id BB1264027F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 19:33:32 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb3b3e643dso466670385a.2
 for <dev@dpdk.org>; Wed, 25 Feb 2026 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772044412; x=1772649212; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdFiMnm2ThjYWISZpDM3czHx6iuMmYDryasRf4PtdKg=;
 b=ElbQlL+nyCrYD9i2y/GBtUUumO2HDjMTrO1ZN6mGa55vRBOIWrb1HDffjCWLeC1MTA
 Sjg5CWiVCOV3JBn68UPAknWlX2AGly6NZ2w+OcaPK8IQzeZUIRjaDfub7ziWxL6oJAqq
 XgDGOgVz/g1XAaj4OxYTOwYJvqPCuc3A/JPJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772044412; x=1772649212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdFiMnm2ThjYWISZpDM3czHx6iuMmYDryasRf4PtdKg=;
 b=ZEE05qy9QilCyPODhLg08hoTejUNwbQv/H5NgMdxcn3nufoY9FoBXANqkY8ovXkM1t
 Xu6DIHJBQPwZYDlAqVrf8Ce6vwqFr68G7GZgZ0jUrcrCOiAVvrCTrPLIknyunBWs+ZJz
 x2xyLBNzOHCyFSzd8TNmh9EEVJ8O7YeQACtdjEqagLAWHqQFrV3qE+4OC2LjBoRr6b/2
 yYRTinuwsnl15QRHbigv89SXRARRM+H0LvPoQiNuvSfG6OF3YqmY57L240djoUSiKkKH
 3lc9D/kZma2PiH9TRMH3E1AJH889WS071zpp4iDq+TAUgWuewqMfYJEOXrvp9g3bhZqe
 AOMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA1TgzRtdXNgw8OMEpuTfrthxNedsKWMy2EZevooSowZRRUaQXk/YUgRlNJsPQh+L4Ag8=@dpdk.org
X-Gm-Message-State: AOJu0YxgsQAv2No4KyFNGPyhD6+wu24n7lQZnIO5+kZk40nRcGu95XMT
 YjjAqDcmnlLAif8yg/R5SWKH36cJvnkjpQQKplWXqNapSDgDjEVnwqmybHMGKl0bvrg=
X-Gm-Gg: ATEYQzyyusVtPL/obHQ4o0kqM/bv4NywSUNQyNcEsA9A+w7mliLiAJs5L/mA4i3Fy0x
 zCYC7lB1R9cWihJrOjfKxW1ypQHo6LHDd0sl00MN+wKvQ4Mvh+UxSW6gxx5P+cmKg5FXzmKkYc0
 Yat+hXlfZO740EHJqBlKjOU+M5SwoSEJqYo8Hnj8wdNCjqVNYP0cdQ2QAxCuncWmBMLLWHYitwS
 DXk2nY8SP2rmmC5pswWJwSxKmj4YeX4oFFqTNAKfdDZP154006RDc70NIQipatjFgrn8WK1Yd0o
 CAko04aYEmFcQatVTAF++5STHfblMWLqp+Al+bMK/dZSL7NSIWhsAf84rNfxvQKWNA6pq2RSJa/
 wZuMmiI/yVjX7daXGttFiB86qbaaROy3Oi76Ama9EucLtyOsqgCKGuNDsu/r5FjZuBfO07uc8uM
 qjCPnl45RonALlbXDpYCzwOfQxKdVAQIvuBnYKq/j5lvgScom+y+WAT55PGXpMZ1RV
X-Received: by 2002:a05:620a:1726:b0:8cb:2b30:1c7c with SMTP id
 af79cd13be357-8cb8ca769dbmr1738260985a.56.1772044411846; 
 Wed, 25 Feb 2026 10:33:31 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d064007sm1564625285a.19.2026.02.25.10.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 10:33:31 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: port speed capabilities test suite to next DTS
Date: Wed, 25 Feb 2026 13:33:28 -0500
Message-ID: <20260225183328.73357-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225182616.71972-1-abailey@iol.unh.edu>
References: <20260225182616.71972-1-abailey@iol.unh.edu>
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

This commit ports the speed capabilities test suite from old DTS to next
DTS.

Bugzilla ID: 1494

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../tests.TestSuite_speed_capabilities.rst    |  8 +++
 dts/configurations/tests_config.example.yaml  |  4 ++
 dts/tests/TestSuite_speed_capabilities.py     | 54 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_speed_capabilities.rst
 create mode 100644 dts/tests/TestSuite_speed_capabilities.py

diff --git a/doc/api/dts/tests.TestSuite_speed_capabilities.rst b/doc/api/dts/tests.TestSuite_speed_capabilities.rst
new file mode 100644
index 0000000000..de6dc42757
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_speed_capabilities.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+speed_capabilities Test Suite
+=============================
+
+.. automodule:: tests.TestSuite_speed_capabilities
+   :members:
+   :show-inheritance:
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index 64fa630aa0..bdc4c49a1c 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -15,3 +15,7 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# port_speed_capabilities:
+#   test_parameters:
+#     0 : 100 Gbps # set link speed according to your expected speed in Gbps
+#     1 : 100 Gbps
\ No newline at end of file
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuite_speed_capabilities.py
new file mode 100644
index 0000000000..9ab488ab1b
--- /dev/null
+++ b/dts/tests/TestSuite_speed_capabilities.py
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""Speed capability test suite.
+
+This test suite ensures that testpmd recognizes the expected speed from a link in Gbps.
+"""
+
+from typing import Literal
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.test import verify
+from api.testpmd import TestPmd
+from framework.test_suite import BaseConfig, TestSuite, func_test
+
+
+class Config(BaseConfig):
+    """Performance test metrics."""
+
+    test_parameters: dict[int, Literal["1 Gbps", "10 Gbps", "25 Gbps", "40 Gbps", "100 Gbps"]] = {
+        0: "100 Gbps",
+    }
+
+
+@requires_link_topology(LinkTopology.ONE_LINK)
+class TestSpeedCapabilities(TestSuite):
+    """Speed capabilities test suite."""
+
+    config: Config
+
+    def set_up_suite(self):
+        """Set up the test suite."""
+        self.test_parameters = self.config.test_parameters
+
+    @func_test
+    def validate_port_speed(self) -> None:
+        """Validate expected port speed is also the observed port speed.
+
+        Steps:
+            * Show port info for each available port
+
+        Verify:
+            * The resulting link speeds are equal to the configured link speeds
+        """
+        with TestPmd() as testpmd:
+            for i, param in enumerate(self.test_parameters.items()):
+                link_speed = testpmd.show_port_info(i).link_speed
+                verify(
+                    link_speed == param[1],
+                    f"port {i} speed {link_speed} does not match configured '{param[1]}'",
+                )
-- 
2.50.1

