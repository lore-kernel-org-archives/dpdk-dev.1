Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36336106ACD6
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79158402AC;
	Thu, 12 Mar 2026 19:53:35 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9164940275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:53:34 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-506362ac5f7so13410271cf.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773341614; x=1773946414; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWjo/2hV/ekqvK2Vygl8a8b4cz3bD0iXfpKj1t33EDs=;
 b=RG48KbLKOMIZCBk6bMMige3tAENr3NLY7o5K++jkpzu1SLoT6pvfWkQs0S9AZ4Aqyu
 izV4Kwo11Zjx9TVo7RSsWOtQC+ezuiaCZjnl2HjocTGMYp9zMJgAE8Xg9knJ8kwir/CS
 Uz+i/wX0AZC45EmWftMYiSwsBj+k1Jvtk8JDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341614; x=1773946414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xWjo/2hV/ekqvK2Vygl8a8b4cz3bD0iXfpKj1t33EDs=;
 b=rfG64UnVAMaQeOyuFZK20DA7SeK5e2n+WOhrVnXhmLhIdm+EKm717I6aC8APfYDsWu
 8CRlv526dUvkQ8NDGTPjkeGFIGhbSgu8oQVpFhj5c1w4Q8TyX80eS9J4EC8AjkTsS3K3
 RLh9qz/GjJAEjiE2zheuxUI+nE7YGWllsjIC2F9+p/USiXi5/KoZRWsQgR0Yx9GOBPUw
 oHYgMMh6vmgggCGwIVZxNFrLFbeV+MpysF32wQ6cB7jduw5IUfsqjv1VgfCmxMjvFwYB
 OLXGff1MUxi4H0LIr4f8mVSRyq2tCUx+7RIWvTTQ6vhyMEKE9lPL9x32Sj+DJ1qtTneu
 /heQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYljq+7hArn1npM7Q+u+gPXSQSz+S9jMO3d7OghKhPtrNJiTKKQJxcwFp8ck1qShKziGM=@dpdk.org
X-Gm-Message-State: AOJu0Yxm4hcWwkwryklHrkZK6wX7PU/WQVLPiC541VitjjAWAOpv3DAS
 JPmnkSlNmE39LmtmmeWoJlsSiKayWrPYEpsohtywrfqIg42yj2tquCbXiJPlqAzTe9Oute6Txwt
 8rbYU
X-Gm-Gg: ATEYQzwiN/3POYIUAMdSvKDXJXPOHsGhSrf7uziIWJXQWriF6PKd/AIzNnFnWPGMVmH
 M4eGr6sWZb50griUcvslhvfaE3mP7At1KJeVsXqTDQU4OYbo/dbJZ+xvM/wABB/T0+DFg8idGtd
 Th2y2mtaDqetvkTxFxaTwXYTd4r7gXGISjEBHW5FNPSQYGVyDZovATyYHghkGBDML+34SjzTsa2
 PaZATqGUlM2h4VynUo/LhIa8sUa5C0Bd4Ap1uN8/1ytu36MyItuGbLfI3T0BpiO2O7IR7500gSz
 8fBiWCH8lOfEbsilCP8Q7Ktr6MT7MWLIY+R3XwBIygRr3kTvge7r84cqJpE7PgfZZoyB9xNHM1a
 ZcG5TUNFkGE2tXcuLsBkXmyc0gQ292BGIE6oZX7oPbot8pvpigB9FvB35rV+xil8XId1AERIo1Z
 znn58Yq1W8b+tOVAOT1AwEiXNrQzrxYQ79XWg/e/1rfuOvHrWPNBMAXcWc7A39mTE4
X-Received: by 2002:ac8:5f8c:0:b0:509:1f95:f3c2 with SMTP id
 d75a77b69052e-50957b890eamr7777891cf.13.1773341613793; 
 Thu, 12 Mar 2026 11:53:33 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939ce2f3dsm39365891cf.0.2026.03.12.11.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:53:33 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v8] dts: port speed capabilities test suite to next DTS
Date: Thu, 12 Mar 2026 14:53:30 -0400
Message-ID: <20260312185330.226227-1-abailey@iol.unh.edu>
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

