Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E15106ACCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35F45402AC;
	Thu, 12 Mar 2026 17:48:42 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2BC9E40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:48:40 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso11429731cf.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773334119; x=1773938919; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWjo/2hV/ekqvK2Vygl8a8b4cz3bD0iXfpKj1t33EDs=;
 b=AfWKliI+0QZfjtAJxyhz0vMnL2XLsFW71kOvj6oNISGyrZE42JzghKkb7hrOCPeacW
 UaKGBrf2NXvtVZTHCjZXioK7C3wffPvSeFgCEv+eM84cT8aErB/9WiyZ/l5hyogKtHU2
 tu3pLSK3dc6VNbapmiRb5SfU/nnyDCOFFePgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773334119; x=1773938919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xWjo/2hV/ekqvK2Vygl8a8b4cz3bD0iXfpKj1t33EDs=;
 b=dpfFFYaLKewTEZYH4oRqLneQ9eSNpzqaZieb07O3VNtIV/9gUHESSeXdPLzqS7JN/A
 jyOEclCaMBEzWbr6uU2bHCwF3bLpVhSZ9DJrqmCt8cIXkk3I9EiALrOB2uF61RpO7I0z
 hMKCcWd8Qb2OC8Bd1BE11XWiaGFE6mkQa7igcL4/61oLetPdKC7QrSdI9xnqhBtwYTPU
 gStdWCdxtbsVDzeMER2ZnWYq6Gy64gFReMFruWlGVZjNiB/+hMvUuglEBj/qQziFbiCg
 EiZhenYPeyUf5bjmPbaoU0NkBnlxnEZ/6+fFTFGirTMPvi+96uSxCAVyKWE2ey6fYt+c
 gO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqOQKN6Tvw4Xkv8igNVW3tyUJnJoC8N1jvfCcwxEThWBNIudX6/i4HTF5qhEuEz+cyuGE=@dpdk.org
X-Gm-Message-State: AOJu0Yz+SCXj17To/CaQfzb1IK8/Oz4EW1MSBzJnzTfTuQN2nKxTUNZq
 3TrqZFxPvYYEGTXXVz0FcPRsOSZ23C3tx3cANxnE0GsZer1rEi/btXI/KixeoOeAIrw=
X-Gm-Gg: ATEYQzx+dzEi6//1faNKuTBkns8BSwoSoqB6N3q+aF6hf+nVACvZhb9dsyHk/HWWhrI
 EAIRr7lGxsxY3LU6b+cTMYykvMKmUcMPC+CAAChAU6UY2qGHJhT9ZDy5S2bX0/oQJPVKnmFrjT5
 7lilVA6/FFW93obVVH23UIri2tQKJG2w3oLYJuImI7hoZi+JvkMNjYBCXsfp4zZFmu1YaHc5eNx
 3PUp/joxpK2UG56fpk3UXzRyt1nhJ9esA7wcfX5zcyloVQ5isBSRpNFjuAKRm8IDlDIEyfk5P7W
 dPCwkI60B+aTYxnekNBXFqhvsROziewc8GbUJdAsV/hHSCfX1fIFnCm5jbHw4g2mqA1NHHkV4D2
 6WOyPPp1rm3BMOcjesX85b+YD+pEqHhwBYVlJPZBvGPgv6UXljmtphfym/rztw6ZGPWHSUpGuE/
 BSjl0HZCPgd2UXLT0M/jhieHNpkMj48IvnjAai1ybMMnmhyhwueEoU8FXo4oJT+UJj
X-Received: by 2002:ac8:5795:0:b0:509:2786:fa6c with SMTP id
 d75a77b69052e-50957e37990mr1136041cf.59.1773334119190; 
 Thu, 12 Mar 2026 09:48:39 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939ec5017sm34926831cf.8.2026.03.12.09.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:48:38 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v7] dts: port speed capabilities test suite to next DTS
Date: Thu, 12 Mar 2026 12:48:30 -0400
Message-ID: <20260312164830.218785-1-abailey@iol.unh.edu>
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
index 0000000000..9cbd6f1ef7
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
+            for k, v in self.test_parameters.items():
+                link_speed = testpmd.show_port_info(k).link_speed
+                verify(
+                    link_speed == v,
+                    f"port {k} speed {link_speed} does not match configured '{v}'",
+                )
-- 
2.50.1

