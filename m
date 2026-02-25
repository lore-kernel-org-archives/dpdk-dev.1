Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE915FD377D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 18:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 022344027F;
	Wed, 25 Feb 2026 19:26:22 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 93420400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 19:26:20 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-896f9397ecdso152486d6.3
 for <dev@dpdk.org>; Wed, 25 Feb 2026 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772043979; x=1772648779; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CsECToQHnjoL2Md93vcx46fWiRZ3CM9mZxIM0HAGojw=;
 b=I0eWo7Y6ZVDoBkw8vFXxzcDU/nNEShkWQfp/+bpBxfMyk3/iss5iAPG1NiQ/jS9ULZ
 NER74lqxnpeMCRStn8fj4SCFiDRk9WAz0zaNZ8r5nFahwDg9SqZUg4Qd+RRp8oC9cRAu
 FMv0VB+s377gWr5VM7y7z1Fj6dscr6g/2UDZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772043979; x=1772648779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsECToQHnjoL2Md93vcx46fWiRZ3CM9mZxIM0HAGojw=;
 b=azAvrRGvAKkg+njw5shy9zC11kH9NmXx35QeL2twQZGufdl70JoXnIjipQxl0q+GVK
 Bw+5V/2jQE4FnzzGiyWGba7l8eGm4uz1ziDs1B40pI26NeOYYoemWu/gX81ObpmYl9B9
 F+SgleCAoDoxsAl1so6QMp4Lyzf5srYIAcvLFWpi2qxeVSx/HSDNxFfHH3ee4T6pRw7A
 GUse8+51q10D1TRZxQgb+Mrta7+/VHSDxNjTAkYt7rbMFG7OuBBJTTImRprOYNqz66pL
 CyoZ++Fn/9csqYmx4qT0AJCfYU12N92+UyJ+z5OeizwobJaZjcaxmZqh9iGjJV661j4c
 FXZA==
X-Gm-Message-State: AOJu0YyiraJo3JeCr0+Htf4dsUTNC9SKdNbT5DfykgvQCops+KzYpkkX
 2ypSnlI1z1m2ysCdJohQxh559QsAuZMD2cHcmWC/B4tNqNoBH/9FhH5M1C2Kv/l3W3yoytUl2N5
 HibNqyTBOjQtjBgjLruToLLWbnX0vlTxMKct0PQMvXzPqF+u9v70JqyoR/Kcc9NIXbzozzmrw89
 J3zHQ6pFt4aHOF/2ThIYaKGmHTtJo=
X-Gm-Gg: ATEYQzyhPnbuG+j30EAdOHfpAuguyUWsE+pMbKjV1rdIgzXXVqdp8unbtfDcX6Fur5i
 YhbphEwBi5Jy1ezMxi24RvYEt7bHALTSRdfyD6ElXbay8VL9IxPwti7NYeB19U0qCyT3yVP+H0Z
 kSj5LaTv++A5PYkNffUgNVoDRMraSzEa42m/CzVO1XEBZAFvYyLZ3kJDfPLnSWMb9Y4zyn1taun
 M+2ZbGtd8MXicwIH5T198W5bVQPlSRc/CSsC/ItvbtgUSnhx/TjopQeDlcyawxgYZnik1Un8vhM
 cou4Mm1A4XerTm2bSckgMKFLCP+nT64lNkUy9IVVrKC8I1YHy11T+3vxhe1b/SGQI/6ZkRG0U1Q
 Y68AGhzs5hOCwEnQ507oY+W7euVy1OcBrEF5DxRjZDhwMNq/bVa8x+D8NwDyRl6sFGiSq3LPH+I
 RnsBL2fhSJzF+I/IZs/NphWc0ZwdrUa8oNHuttFX4tOD4BJGGDETVRJRyAXHs3Z4jB
X-Received: by 2002:a05:6214:3003:b0:896:af07:a4f8 with SMTP id
 6a1803df08f44-89979c39988mr239972196d6.11.1772043979442; 
 Wed, 25 Feb 2026 10:26:19 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997c8a771fsm127155576d6.17.2026.02.25.10.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 10:26:18 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: port speed capabilities test suite to next DTS
Date: Wed, 25 Feb 2026 13:26:16 -0500
Message-ID: <20260225182616.71972-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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
 .../tests.TestsSuite_speed_capabilities.rst   |  8 +++
 dts/configurations/tests_config.example.yaml  |  4 ++
 dts/tests/TestSuite_speed_capabilities.py     | 54 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 doc/api/dts/tests.TestsSuite_speed_capabilities.rst
 create mode 100644 dts/tests/TestSuite_speed_capabilities.py

diff --git a/doc/api/dts/tests.TestsSuite_speed_capabilities.rst b/doc/api/dts/tests.TestsSuite_speed_capabilities.rst
new file mode 100644
index 0000000000..de6dc42757
--- /dev/null
+++ b/doc/api/dts/tests.TestsSuite_speed_capabilities.rst
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

