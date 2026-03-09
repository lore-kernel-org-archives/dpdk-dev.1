Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14004FCA187
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 20:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B57D402BE;
	Mon,  9 Mar 2026 21:29:33 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 11E0440261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 21:29:32 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8cd80f56b27so194586385a.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773088171; x=1773692971; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4hMGOmzhtMkcmdkTdo6xeEqdUKzab0/z4hTOSgIRiY=;
 b=XzKXwui9ByqZLk1fIzYPVcXAzJMUVfaSH5U1wtK1q5/hhlqphV0/Uc7ccNHvsWom1v
 8Rg9KX+4voWft8nLmg4XeUAXya2jd0wgAeizK8umB/OVyvVoY0VZwVsN6FG1FJu84kM9
 BowVDdZT+LBl8ZEmSCP9OmFvTGzaXe7uIEDkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088171; x=1773692971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4hMGOmzhtMkcmdkTdo6xeEqdUKzab0/z4hTOSgIRiY=;
 b=WobyQ6/i2tnDp+8mW8MF7qgpnhzIPkyuAGKVlAjlwT2rL4haqfKhNlc30o5UcPhpby
 9vFpNYc+NJFLxQICpttJJJFo87aBbDxtR3pWVinR6nrZGDmXwo80pshKOTIDHzIsbwH/
 HVME5y9wgg1zkAhga9YhSgIdG0vG5Kq9YREpapNPLTw4vivEoQ3Xz/otgbaedXUaNt8r
 vUyD9mMAeKZit9vKYTsEfGGfBOFiJ6Zn0FA7XWVQKrJLXwXmcYXUjG3mJTLSPoUD23+z
 ixXiOXww5hNSAy8kgjmowdVKsa86+FPsAEKQG/mZqubNTiI87hvztHUWTpbaQXMAkKpJ
 Gm5A==
X-Gm-Message-State: AOJu0YxzsBMhOWxb3UGbHkhaXUJs54n4W+IVxCR7rqlmgLrSy3UJOwQ3
 Kdh6bk8MMwjmIY3qr6ryCQwxBpgnibV2ePFyrS9FPmZrViKeX30MeHfXBOOc58J0nZQ=
X-Gm-Gg: ATEYQzw4TrREWTgSCaiBCsVbHgI57vubYjz0OEPvynlH5jUyHpm3xJ76M4gq0g2Njh2
 5i/1sXPelX5B8nQFthQH/4I8WbJgTrYaC+vrMN8tJI3rMleDeUsf2fX1VXLzUhdB0I8O7B9MY9y
 eJKYLSA2z7Pl/igXfh7bJgxPqC2lML3kWprNto6dJ20mO1+6B8bwdv91JqHLU7wIegI3MM5q+FJ
 zfxA+Ng0vYdxbzwZl9pWalIJ5t2K38dQLTIQ74iVFRelx6fqkvICvW+6DBD1/Du8/UXimkSJQrx
 tMeAZd3G7N+ES1gcBxGc4zIQB+CsUCaajaCaqD3wEHjHGM/IVu+nI0JAfIMMj2ObvMrizL7jtgg
 b9AjWOXBotLP0OYgKfezlJFmYT40rnp94Ag/4MtwfXM44s7vz6B9eEUUt8MHqLpY3yFjCdP1jiz
 AeDHb2mMV7Wy6aeq70HtL7GENsc6VP02OooVcU/PNCnpYCmgvMVXgKVnm9E73YE0qE
X-Received: by 2002:a05:620a:4588:b0:8c9:ea1c:f21e with SMTP id
 af79cd13be357-8cd6d40b0a0mr1527029885a.10.1773088171272; 
 Mon, 09 Mar 2026 13:29:31 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd7e15ce57sm457408085a.3.2026.03.09.13.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:29:30 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org,
	dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6] dts: port speed capabilities test suite to next DTS
Date: Mon,  9 Mar 2026 16:29:28 -0400
Message-ID: <20260309202928.200755-1-abailey@iol.unh.edu>
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
 dts/configurations/tests_config.example.yaml  |  6 +-
 dts/tests/TestSuite_speed_capabilities.py     | 67 +++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)
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
index 209d7dd393..a41e65f2b4 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -29,4 +29,8 @@ hello_world:
 #      - buff_size: 64
 #        Gbps: 2.0 # Set gigabits per second according to your devices throughput for this given buffer size
 #      - buff_size: 512
-#        Gbps: 20.0
\ No newline at end of file
+#        Gbps: 20.0
+# port_speed_capabilities:
+#   test_parameters:
+#     0 : 100 Gbps # Assign an expected link speed to a port ID in Gbps
+#     1 : 100 Gbps
\ No newline at end of file
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuite_speed_capabilities.py
new file mode 100644
index 0000000000..7b63a3ead1
--- /dev/null
+++ b/dts/tests/TestSuite_speed_capabilities.py
@@ -0,0 +1,67 @@
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
+    test_parameters: dict[
+        int,
+        Literal[
+            "1 Gbps",
+            "10 Gbps",
+            "25 Gbps",
+            "40 Gbps",
+            "100 Gbps",
+            "200 Gbps",
+            "400 Gbps",
+            "800 Gbps",
+            "1600 Gbps",
+        ],
+    ] = {
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
+            for k, v in self.test_parameters:
+                link_speed = testpmd.show_port_info(k).link_speed
+                verify(
+                    link_speed == v,
+                    f"port {k} speed {link_speed} does not match configured '{v}'",
+                )
-- 
2.50.1

