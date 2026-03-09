Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30955FCA16D
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 17:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C2A7402BE;
	Mon,  9 Mar 2026 18:57:23 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 22A9D40261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 18:57:22 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so1205802185a.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773079041; x=1773683841; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3H+BHbtYRMAoxONqOSgtufMHfnVvKQxlWXqlzt4ccM=;
 b=OhfHyBJ++gVdi6ctucRQ7Ubg8MTGkeFCt+gT2PusR7uUWi8ULl91kBYHNbK1Z5kC12
 ZqbCtHls+GVQP33zUNGE1tZ3rKXqVMLmcIJQQ3SHM+pil88+Uxo9VU/q+FUUdUZ4L/xd
 ci9ZASgkHzoaUA/IbK5Tth7HgNsfS8ZcuYTus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079041; x=1773683841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3H+BHbtYRMAoxONqOSgtufMHfnVvKQxlWXqlzt4ccM=;
 b=QyAuqgr4YuF+B+gIkOHsF6BE5QIFaMXmYfhJu7YJxqOPiwGGaQzRunQNIBt1UaxytN
 qajV9L4mStkYjp+VL1QYHvPTLVw9fygTywX0XJdKSpFHBGgTfMOAnO+1G/0Kl2RgWv3o
 BmEDNbHrT9U96D8V25W+0t2AYN0NgmbH+9VQNl0t0DlQel/JZtU0L7JOCkxqKoo1gJwB
 yV87+zgSA5GFwQ1dnYM3zO39JCgZLat8N/OuExpfmXsH3kbd2etIOUn1zs5AinAkdSzw
 I36x+kH+xTBWUOUaCK+BwfHFnTSwjk4abTiL34KVQF6sDHyNwBdfc9PklvXwtf2D/3DH
 CcsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU44ua1GYsCDgVys2ZSJJsECUhcN5LPFWzCXlnG8DdwX89OpSKoRws1B7SXibSTLaDpuAg=@dpdk.org
X-Gm-Message-State: AOJu0YzloOlRyozBdRy1nabu5Fk5kekiixphM4YTby+NU+4CF9JeJsjs
 v0hWB6nXC5MUDeOK+lLB9D9H/WdsBTJ2VUDvtp8xO/hY4Vjya8AybSsgDk/l/WHuRfU=
X-Gm-Gg: ATEYQzwZPvrtQJs6qSQ76ahz5LwtVTMxEpWW8/2RqC8UOpa6qGxFR4Ov8z1sgMuEUs4
 avBIquWjmnZh2Bfj8GurKkw6SQa4YYaVfIK8wn1kBxkG91KapqoGw9fdYa2+vPxPHlNo5NID9Q2
 5IZZdjlJdMW9gf4nsdFYvRiWOM1KScPdFZqtp7Csuvg9U9Sbruxu1TjBysZjWOdPLYHJz6DNrTO
 z07y7Mdz/9KzVi9w4Vr6IDgeehYCBkI/ER5ATC4Fa56jD1wKi+KdDlj5321W4iY72tjiF7GqhIZ
 GUuAyxTnhVIhut02I9YQOyWHUzUf0geq6K4qbxC7n7x3bf24MQhtrXS4Sfnqu/dY3mEgXmxRc9p
 QD+b/QYv6ph0o32jZrfGW9XxpatMIACFrSyqHiDEfJq4XmQq40zkMrwlhrauewf4eU8NumcWyYv
 cuYpiUltHZbfYcvzyoN7jf8uDwuVNKlwEPSBUWhIAk0sh9xVtZZsbQ9tqYlM73b0xX2drkqD6Y8
 cM=
X-Received: by 2002:a05:620a:444e:b0:8cd:8fb7:7aed with SMTP id
 af79cd13be357-8cd8fb77ed8mr288174585a.49.1773079041298; 
 Mon, 09 Mar 2026 10:57:21 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f57291esm795230985a.50.2026.03.09.10.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:57:20 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4] dts: port speed capabilities test suite to next DTS
Date: Mon,  9 Mar 2026 13:57:18 -0400
Message-ID: <20260309175718.188998-1-abailey@iol.unh.edu>
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
index 209d7dd393..82f0c312c4 100644
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

