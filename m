Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D0FCA16A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 18:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16A65402BE;
	Mon,  9 Mar 2026 19:08:08 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 835D340261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 19:08:06 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-509061dab77so23705351cf.2
 for <dev@dpdk.org>; Mon, 09 Mar 2026 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773079686; x=1773684486; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJPEvsrAKpH31V0n7s/sCZM043Z1BuBvpjhx0SIgRiA=;
 b=UzXvrrLgIzmhEqeCh1dmMe5HZziOatCCVyBDXrP7rqFnQr8edVqkfsC4kQNdwNPkyB
 LItcoBy67RlLmciQ3l7bOtgdfJqJSXTsUArZJegCm5JSb5sD6DOayV8tirkX5FzQ0sGr
 0iAxn7AxfeZwV1GCB0pdsP2FCH9d3/AF9u7fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079686; x=1773684486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qJPEvsrAKpH31V0n7s/sCZM043Z1BuBvpjhx0SIgRiA=;
 b=kOt23PwqkiVWSRpOj1ad5Ltr8VfI2S1ReVkYtemknRofUrdhLAn46Mu+tEqQC3qFxa
 lyTjBUqc4sjHitZAWrAgvjfFVN05LxS8Zi98UCI7NBuUFEG09ZVbxvQUlstiSxTDfOTh
 lj9i99fzRTCuC7dXvwi58CTAc60KXFubo0s2bEV5nNiHwmfcstte11IAW2rwSI6d781b
 lqZK6Ri3/ejkREhP3F5yul7laLozBz8FXEjqax91VWtxiXHb3xo0bzZpLqL4tEfXg5hR
 14lWlK+Vh5CSnOgEiKjXyJyCkNWX3Wf9WIijNqn0HmDEOT+/t+8NZLAUa75o7dH3OqjG
 8ihA==
X-Gm-Message-State: AOJu0Yxy1X/z0zhFbqVbCJ+gLc4Bp8H0fsnlRLtCucGmo/604J2Dnnmx
 FRRwOK0AR8Ut8HejQOYg1ajIlziB6/ZFsVj+lObwB60JlmWEDr6B34Ch4QYbBgPt6Y4=
X-Gm-Gg: ATEYQzyDwoNSSONk2Gr839IBR/2RWzfdwiSTPx18zRbKnFbizqxysLkMo/4vGeKH6aa
 qEiAX2Ot2c4nlGPx5YycsutLCg6vMU+pYWmDfkye6fdhwGLwjaUcd0m5opd0y+VqsB3bDesL3DI
 rQ812hLgdjS6wOcwUwnu6XqXm8hNQRR4NOgl36tnvM4bBsU/ljHjY6COF/+JasudTuvE52iOP64
 PWOjzrnq7mTBSJVebsNp9tG1ktqUvuWQkr3rqR+3JpGnODKu+kPTsOhj1EKPxgJg1X/+MfHO2ZR
 ++ufUn2Y/LLl1C5+ZxZKei4BiAcYwLuJ81L82tkUDtYJLDyaVov6d2ZpoaD+fmQpndZc1JsCWcx
 29fgxJXvG98eUwto9p7JDcBWAXnaKZG721z9+xntDiEqGbxtYaD0y/N+cvgLVZvwhxe5bo8V9X+
 /gDLzcUdjEIQhKDqeJq5K4gcmAHeFoTD/DCx5b2zD50jMTlRn3UWqMJsb9n3swXZ3I
X-Received: by 2002:ac8:59cb:0:b0:4f4:e6b7:df20 with SMTP id
 d75a77b69052e-508f49096bdmr149671141cf.32.1773079685648; 
 Mon, 09 Mar 2026 11:08:05 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f651440dsm69074881cf.5.2026.03.09.11.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:08:05 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5] dts: port speed capabilities test suite to next DTS
Date: Mon,  9 Mar 2026 14:08:02 -0400
Message-ID: <20260309180802.189956-1-abailey@iol.unh.edu>
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
index 0000000000..5eeb4095b7
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
+            for i, param in enumerate(self.test_parameters.items()):
+                link_speed = testpmd.show_port_info(i).link_speed
+                verify(
+                    link_speed == param[1],
+                    f"port {i} speed {link_speed} does not match configured '{param[1]}'",
+                )
-- 
2.50.1

