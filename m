Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A20FDEE2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D96A406FF;
	Thu, 23 Apr 2026 19:03:47 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3B7E640655
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:43 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8ec9f099fc6so450148385a.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963822; x=1777568622; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyMiEqvRjoiFvYcECmyJadtddvmbTJeIAP2V6fX34AM=;
 b=i8RajwSRccRaVDdVEMkACeA/tuXZ9iYoz7OyD8p+nOzVZ+VKLUVd2IvhelvNybxrad
 gWiwULDUve9gLVzWLVY9gvZ5o0nDokOihpXEZuDJXRz+bEEnJR+2lKUgvY2ooFzamu2i
 S1yiqE/ZwVO0VduqGJd4Up6KXr8GPQ7MNk9r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963822; x=1777568622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyMiEqvRjoiFvYcECmyJadtddvmbTJeIAP2V6fX34AM=;
 b=KS0za06L1v0Bt5WrzeWp2CK/cGGLPb/XN67drpz5+1K0gn7xPtgO7asn5yhNCzd9kf
 ZUSt5ttFGF1XVyn/+ITP3Lx1cA0IVjwhLSGVxCajIAIrbMasjo2Hpo7iGRupFnjbfzjY
 ltfiW/K5K5//MrZhSNmqIxbqhaCs2FZTVuJnXyTmoCyvHpvBgiXTifh8Tq7jGyaibvqq
 Y8Lx6s+mo9DNK70yLnpruoEQvWbq197iYiVaZv+RWImR75PT4j4q44JWZ2xU0Fl6SA9P
 9cOQGl6hxZ/6zYbXNab8cgrEP5pm8BTXA2Mi9HPR79fxkt3XFrIG8Zpgosf7yCCI8LC6
 vGRg==
X-Gm-Message-State: AOJu0YwQRRSR+A8YtCTkx5gfeZCZe5yyXqtmas1c5RCY+VA5Ex4e3oAm
 Pi4oVw3Gvr55MzFMt86xcH6FDCjMdIC/Yjen7cePmz6gYfvXZaDrA5BbCz9onNFcZ0U=
X-Gm-Gg: AeBDieuyQUpKzydGq3mw/OOs+dVVaD6ij+gEfMPCOrh47gX00YY+oNKrJYKdeITKxf3
 bhhHOK2U+43AcY5dUUVBj0j9TsFEb/fDn08CQY0+TEbS3X1YhVmej54xWVyLCkmNyFNsthBSINX
 4HVkWjbh6Z2zDx72FiRtAnHcHge3oswWx5WEnFd6nbybxRtOOlZIARWFD4M9vFLxfBcfcppxk1M
 pccqnJ5WqIT1u3RSEeQgbW8dgtx49KqPlznHPDk/J8uZmhnjdYOqkf8pTbYQOtDRm+OjJowkjjl
 aNGajjyHvBr3exeeRy+1ND36MoUySkWSFVRMojpOQJd3poe8SmojBi+QCwOVoyTejsIvmUvnI1e
 gGSN4vSdq4gnorb3uoDTBoUNIfRZh6SW+kFWMx4eIqc40BLUZhKVyWkUZdSwg1H+7fkiNaf2jXm
 AeX4sT9m6HyVw/7CAjMXL1RcUEj3yv3Ze2SUPc6kblQICJDeUFF87pUSNXTuXzzD8PPyjNZKBi0
 aEl4GSdtoc=
X-Received: by 2002:a05:620a:a2cf:20b0:8ea:addd:8951 with SMTP id
 af79cd13be357-8eaaddd8d80mr1965641885a.42.1776963822281; 
 Thu, 23 Apr 2026 10:03:42 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:41 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 8/8] dts: update API rst files for doc build
Date: Thu, 23 Apr 2026 13:03:20 -0400
Message-ID: <20260423170331.33193-9-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423170331.33193-1-dmarx@iol.unh.edu>
References: <20240925192013.17446-1-jspewock@iol.unh.edu>
 <20260423170331.33193-1-dmarx@iol.unh.edu>
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

Appropriately rename/update the framework rst files
which have been moved to the API in this series.
Resolve circular dependency issues in api/params/types
and api/testpmd.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 ...{framework.context.rst => api.context.rst} |  2 +-
 ...mework.exception.rst => api.exception.rst} |  2 +-
 ...work.params.eal.rst => api.params.eal.rst} |  2 +-
 .../{framework.params.rst => api.params.rst}  |  6 ++--
 ....params.types.rst => api.params.types.rst} |  2 +-
 ...work.test_suite.rst => api.test_suite.rst} |  2 +-
 ...y.rst => api.testbed_model.capability.rst} |  2 +-
 ...odel.cpu.rst => api.testbed_model.cpu.rst} |  2 +-
 ...st => api.testbed_model.linux_session.rst} |  2 +-
 ...el.node.rst => api.testbed_model.node.rst} |  2 +-
 ...n.rst => api.testbed_model.os_session.rst} |  2 +-
 ...el.port.rst => api.testbed_model.port.rst} |  2 +-
 ...st => api.testbed_model.posix_session.rst} |  2 +-
 doc/api/dts/api.testbed_model.rst             | 28 +++++++++++++++++++
 ...ogy.rst => api.testbed_model.topology.rst} |  2 +-
 ...generator.capturing_traffic_generator.rst} |  2 +-
 .../api.testbed_model.traffic_generator.rst   | 16 +++++++++++
 ...testbed_model.traffic_generator.scapy.rst} |  2 +-
 ...l.traffic_generator.traffic_generator.rst} |  2 +-
 ...t => api.testbed_model.virtual_device.rst} |  2 +-
 .../{framework.utils.rst => api.utils.rst}    |  2 +-
 doc/api/dts/framework.linux_session.rst       |  8 ++++++
 doc/api/dts/framework.testbed_model.rst       | 28 -------------------
 ...mework.testbed_model.traffic_generator.rst | 16 -----------
 doc/api/dts/index.rst                         | 15 +++++-----
 dts/api/params/types.py                       |  8 ++++--
 dts/api/testpmd/__init__.py                   |  7 ++++-
 27 files changed, 93 insertions(+), 75 deletions(-)
 rename doc/api/dts/{framework.context.rst => api.context.rst} (80%)
 rename doc/api/dts/{framework.exception.rst => api.exception.rst} (77%)
 rename doc/api/dts/{framework.params.eal.rst => api.params.eal.rst} (79%)
 rename doc/api/dts/{framework.params.rst => api.params.rst} (71%)
 rename doc/api/dts/{framework.params.types.rst => api.params.types.rst} (80%)
 rename doc/api/dts/{framework.test_suite.rst => api.test_suite.rst} (81%)
 rename doc/api/dts/{framework.testbed_model.capability.rst => api.testbed_model.capability.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.cpu.rst => api.testbed_model.cpu.rst} (78%)
 rename doc/api/dts/{framework.testbed_model.linux_session.rst => api.testbed_model.linux_session.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.node.rst => api.testbed_model.node.rst} (71%)
 rename doc/api/dts/{framework.testbed_model.os_session.rst => api.testbed_model.os_session.rst} (76%)
 rename doc/api/dts/{framework.testbed_model.port.rst => api.testbed_model.port.rst} (77%)
 rename doc/api/dts/{framework.testbed_model.posix_session.rst => api.testbed_model.posix_session.rst} (74%)
 create mode 100644 doc/api/dts/api.testbed_model.rst
 rename doc/api/dts/{framework.testbed_model.topology.rst => api.testbed_model.topology.rst} (73%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.capturing_traffic_generator.rst => api.testbed_model.traffic_generator.capturing_traffic_generator.rst} (68%)
 create mode 100644 doc/api/dts/api.testbed_model.traffic_generator.rst
 rename doc/api/dts/{framework.testbed_model.traffic_generator.scapy.rst => api.testbed_model.traffic_generator.scapy.rst} (70%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.traffic_generator.rst => api.testbed_model.traffic_generator.traffic_generator.rst} (65%)
 rename doc/api/dts/{framework.testbed_model.virtual_device.rst => api.testbed_model.virtual_device.rst} (72%)
 rename doc/api/dts/{framework.utils.rst => api.utils.rst} (80%)
 create mode 100644 doc/api/dts/framework.linux_session.rst
 delete mode 100644 doc/api/dts/framework.testbed_model.rst
 delete mode 100644 doc/api/dts/framework.testbed_model.traffic_generator.rst

diff --git a/doc/api/dts/framework.context.rst b/doc/api/dts/api.context.rst
similarity index 80%
rename from doc/api/dts/framework.context.rst
rename to doc/api/dts/api.context.rst
index 925c160360..65b4ab9a47 100644
--- a/doc/api/dts/framework.context.rst
+++ b/doc/api/dts/api.context.rst
@@ -3,6 +3,6 @@
 context - DTS execution context
 ===============================
 
-.. automodule:: framework.context
+.. automodule:: api.context
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.exception.rst b/doc/api/dts/api.exception.rst
similarity index 77%
rename from doc/api/dts/framework.exception.rst
rename to doc/api/dts/api.exception.rst
index efb47dc5ae..8e6bff5ee7 100644
--- a/doc/api/dts/framework.exception.rst
+++ b/doc/api/dts/api.exception.rst
@@ -3,6 +3,6 @@
 exception - Exceptions
 ======================
 
-.. automodule:: framework.exception
+.. automodule:: api.exception
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.params.eal.rst b/doc/api/dts/api.params.eal.rst
similarity index 79%
rename from doc/api/dts/framework.params.eal.rst
rename to doc/api/dts/api.params.eal.rst
index 6999b00233..4531cb1fe1 100644
--- a/doc/api/dts/framework.params.eal.rst
+++ b/doc/api/dts/api.params.eal.rst
@@ -3,6 +3,6 @@
 eal - EAL Parameters Modelling
 ==============================
 
-.. automodule:: framework.params.eal
+.. automodule:: api.params.eal
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.params.rst b/doc/api/dts/api.params.rst
similarity index 71%
rename from doc/api/dts/framework.params.rst
rename to doc/api/dts/api.params.rst
index d8c6af9667..3ea7f9215e 100644
--- a/doc/api/dts/framework.params.rst
+++ b/doc/api/dts/api.params.rst
@@ -3,7 +3,7 @@
 params - Command Line Parameters Modelling
 ==========================================
 
-.. automodule:: framework.params
+.. automodule:: api.params
    :members:
    :show-inheritance:
 
@@ -11,5 +11,5 @@ params - Command Line Parameters Modelling
    :hidden:
    :maxdepth: 1
 
-   framework.params.eal
-   framework.params.types
+   api.params.eal
+   api.params.types
diff --git a/doc/api/dts/framework.params.types.rst b/doc/api/dts/api.params.types.rst
similarity index 80%
rename from doc/api/dts/framework.params.types.rst
rename to doc/api/dts/api.params.types.rst
index 6d609038be..4754b3a665 100644
--- a/doc/api/dts/framework.params.types.rst
+++ b/doc/api/dts/api.params.types.rst
@@ -3,6 +3,6 @@
 params.types - Parameters Modelling Types
 =========================================
 
-.. automodule:: framework.params.types
+.. automodule:: api.params.types
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.test_suite.rst b/doc/api/dts/api.test_suite.rst
similarity index 81%
rename from doc/api/dts/framework.test_suite.rst
rename to doc/api/dts/api.test_suite.rst
index 9517f51a4a..4acb7b103a 100644
--- a/doc/api/dts/framework.test_suite.rst
+++ b/doc/api/dts/api.test_suite.rst
@@ -3,6 +3,6 @@
 test\_suite - Common Test Suite Features
 ========================================
 
-.. automodule:: framework.test_suite
+.. automodule:: api.test_suite
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.capability.rst b/doc/api/dts/api.testbed_model.capability.rst
similarity index 74%
rename from doc/api/dts/framework.testbed_model.capability.rst
rename to doc/api/dts/api.testbed_model.capability.rst
index fab91cad83..88e396dddb 100644
--- a/doc/api/dts/framework.testbed_model.capability.rst
+++ b/doc/api/dts/api.testbed_model.capability.rst
@@ -3,6 +3,6 @@
 capability - Testbed Capabilities
 =================================
 
-.. automodule:: framework.testbed_model.capability
+.. automodule:: api.testbed_model.capability
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.cpu.rst b/doc/api/dts/api.testbed_model.cpu.rst
similarity index 78%
rename from doc/api/dts/framework.testbed_model.cpu.rst
rename to doc/api/dts/api.testbed_model.cpu.rst
index 997f2a9795..dbbb29480a 100644
--- a/doc/api/dts/framework.testbed_model.cpu.rst
+++ b/doc/api/dts/api.testbed_model.cpu.rst
@@ -3,6 +3,6 @@
 cpu - CPU Representation and Utilities
 ======================================
 
-.. automodule:: framework.testbed_model.cpu
+.. automodule:: api.testbed_model.cpu
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.linux_session.rst b/doc/api/dts/api.testbed_model.linux_session.rst
similarity index 74%
rename from doc/api/dts/framework.testbed_model.linux_session.rst
rename to doc/api/dts/api.testbed_model.linux_session.rst
index 7567816199..cfe79d8bca 100644
--- a/doc/api/dts/framework.testbed_model.linux_session.rst
+++ b/doc/api/dts/api.testbed_model.linux_session.rst
@@ -3,6 +3,6 @@
 linux\_session - Linux Remote Session
 =====================================
 
-.. automodule:: framework.testbed_model.linux_session
+.. automodule:: api.testbed_model.linux_session
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.node.rst b/doc/api/dts/api.testbed_model.node.rst
similarity index 71%
rename from doc/api/dts/framework.testbed_model.node.rst
rename to doc/api/dts/api.testbed_model.node.rst
index 23c6c46a00..15f522e5f7 100644
--- a/doc/api/dts/framework.testbed_model.node.rst
+++ b/doc/api/dts/api.testbed_model.node.rst
@@ -3,6 +3,6 @@
 node - Base Node
 ================
 
-.. automodule:: framework.testbed_model.node
+.. automodule:: api.testbed_model.node
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.os_session.rst b/doc/api/dts/api.testbed_model.os_session.rst
similarity index 76%
rename from doc/api/dts/framework.testbed_model.os_session.rst
rename to doc/api/dts/api.testbed_model.os_session.rst
index ecfb352311..e7e3f9894f 100644
--- a/doc/api/dts/framework.testbed_model.os_session.rst
+++ b/doc/api/dts/api.testbed_model.os_session.rst
@@ -3,6 +3,6 @@
 os\_session - OS-aware Remote Session ABC
 =========================================
 
-.. automodule:: framework.testbed_model.os_session
+.. automodule:: api.testbed_model.os_session
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.port.rst b/doc/api/dts/api.testbed_model.port.rst
similarity index 77%
rename from doc/api/dts/framework.testbed_model.port.rst
rename to doc/api/dts/api.testbed_model.port.rst
index fdb7ca8a1d..d64501aef0 100644
--- a/doc/api/dts/framework.testbed_model.port.rst
+++ b/doc/api/dts/api.testbed_model.port.rst
@@ -3,7 +3,7 @@
 port - NIC Port Representation
 ==============================
 
-.. automodule:: framework.testbed_model.port
+.. automodule:: api.testbed_model.port
    :members:
    :show-inheritance:
    :noindex:
diff --git a/doc/api/dts/framework.testbed_model.posix_session.rst b/doc/api/dts/api.testbed_model.posix_session.rst
similarity index 74%
rename from doc/api/dts/framework.testbed_model.posix_session.rst
rename to doc/api/dts/api.testbed_model.posix_session.rst
index e65585fd85..9f0e9ff18d 100644
--- a/doc/api/dts/framework.testbed_model.posix_session.rst
+++ b/doc/api/dts/api.testbed_model.posix_session.rst
@@ -3,6 +3,6 @@
 posix\_session - Posix Remote Session
 =====================================
 
-.. automodule:: framework.testbed_model.posix_session
+.. automodule:: api.testbed_model.posix_session
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/api.testbed_model.rst b/doc/api/dts/api.testbed_model.rst
new file mode 100644
index 0000000000..5e2e5189b2
--- /dev/null
+++ b/doc/api/dts/api.testbed_model.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+testbed\_model - Testbed Modelling Package
+==========================================
+
+.. automodule:: api.testbed_model
+   :members:
+   :show-inheritance:
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   api.testbed_model.traffic_generator
+
+.. toctree::
+   :hidden:
+   :maxdepth: 1
+
+   api.testbed_model.os_session
+   api.testbed_model.linux_session
+   api.testbed_model.posix_session
+   api.testbed_model.node
+   api.testbed_model.capability
+   api.testbed_model.cpu
+   api.testbed_model.port
+   api.testbed_model.topology
+   api.testbed_model.virtual_device
diff --git a/doc/api/dts/framework.testbed_model.topology.rst b/doc/api/dts/api.testbed_model.topology.rst
similarity index 73%
rename from doc/api/dts/framework.testbed_model.topology.rst
rename to doc/api/dts/api.testbed_model.topology.rst
index 496f2a895f..bb63fe38dc 100644
--- a/doc/api/dts/framework.testbed_model.topology.rst
+++ b/doc/api/dts/api.testbed_model.topology.rst
@@ -3,6 +3,6 @@
 topology - Testbed Topology
 ===========================
 
-.. automodule:: framework.testbed_model.topology
+.. automodule:: api.testbed_model.topology
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
similarity index 68%
rename from doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
index 29fa834042..cfe03201a7 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
@@ -3,6 +3,6 @@
 capturing\_traffic\_generator - Base Capturing TG ABC
 =====================================================
 
-.. automodule:: framework.testbed_model.traffic_generator.capturing_traffic_generator
+.. automodule:: api.testbed_model.traffic_generator.capturing_traffic_generator
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/api.testbed_model.traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.rst
new file mode 100644
index 0000000000..311bdcf6b9
--- /dev/null
+++ b/doc/api/dts/api.testbed_model.traffic_generator.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+traffic\_generator Subpackage
+=============================
+
+.. automodule:: api.testbed_model.traffic_generator
+   :members:
+   :show-inheritance:
+
+.. toctree::
+   :hidden:
+   :maxdepth: 1
+
+   api.testbed_model.traffic_generator.traffic_generator
+   api.testbed_model.traffic_generator.capturing_traffic_generator
+   api.testbed_model.traffic_generator.scapy
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.scapy.rst b/doc/api/dts/api.testbed_model.traffic_generator.scapy.rst
similarity index 70%
rename from doc/api/dts/framework.testbed_model.traffic_generator.scapy.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.scapy.rst
index df78ac9514..949bb66632 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.scapy.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.scapy.rst
@@ -3,6 +3,6 @@
 scapy - Capturing Traffic Generator
 ===================================
 
-.. automodule:: framework.testbed_model.traffic_generator.scapy
+.. automodule:: api.testbed_model.traffic_generator.scapy
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
similarity index 65%
rename from doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
index bfec728dee..1045e534b5 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
@@ -3,6 +3,6 @@
 traffic\_generator - Base TG ABC
 ================================
 
-.. automodule:: framework.testbed_model.traffic_generator.traffic_generator
+.. automodule:: api.testbed_model.traffic_generator.traffic_generator
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.virtual_device.rst b/doc/api/dts/api.testbed_model.virtual_device.rst
similarity index 72%
rename from doc/api/dts/framework.testbed_model.virtual_device.rst
rename to doc/api/dts/api.testbed_model.virtual_device.rst
index a6b0420e75..97adc895f6 100644
--- a/doc/api/dts/framework.testbed_model.virtual_device.rst
+++ b/doc/api/dts/api.testbed_model.virtual_device.rst
@@ -3,6 +3,6 @@
 virtual\_device - Virtual Devices
 =================================
 
-.. automodule:: framework.testbed_model.virtual_device
+.. automodule:: api.testbed_model.virtual_device
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.utils.rst b/doc/api/dts/api.utils.rst
similarity index 80%
rename from doc/api/dts/framework.utils.rst
rename to doc/api/dts/api.utils.rst
index cc06d4c3c3..0b4baff1b5 100644
--- a/doc/api/dts/framework.utils.rst
+++ b/doc/api/dts/api.utils.rst
@@ -3,6 +3,6 @@
 utils - Various Utilities
 =========================
 
-.. automodule:: framework.utils
+.. automodule:: api.utils
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.linux_session.rst b/doc/api/dts/framework.linux_session.rst
new file mode 100644
index 0000000000..5cb2d04db1
--- /dev/null
+++ b/doc/api/dts/framework.linux_session.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+linux\_session - Linux Remote Session
+=====================================
+
+.. automodule:: framework.linux_session
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.rst b/doc/api/dts/framework.testbed_model.rst
deleted file mode 100644
index f283178f6a..0000000000
--- a/doc/api/dts/framework.testbed_model.rst
+++ /dev/null
@@ -1,28 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-testbed\_model - Testbed Modelling Package
-==========================================
-
-.. automodule:: framework.testbed_model
-   :members:
-   :show-inheritance:
-
-.. toctree::
-   :hidden:
-   :maxdepth: 2
-
-   framework.testbed_model.traffic_generator
-
-.. toctree::
-   :hidden:
-   :maxdepth: 1
-
-   framework.testbed_model.os_session
-   framework.testbed_model.linux_session
-   framework.testbed_model.posix_session
-   framework.testbed_model.node
-   framework.testbed_model.capability
-   framework.testbed_model.cpu
-   framework.testbed_model.port
-   framework.testbed_model.topology
-   framework.testbed_model.virtual_device
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.rst b/doc/api/dts/framework.testbed_model.traffic_generator.rst
deleted file mode 100644
index 24c250ee3a..0000000000
--- a/doc/api/dts/framework.testbed_model.traffic_generator.rst
+++ /dev/null
@@ -1,16 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-traffic\_generator Subpackage
-=============================
-
-.. automodule:: framework.testbed_model.traffic_generator
-   :members:
-   :show-inheritance:
-
-.. toctree::
-   :hidden:
-   :maxdepth: 1
-
-   framework.testbed_model.traffic_generator.traffic_generator
-   framework.testbed_model.traffic_generator.capturing_traffic_generator
-   framework.testbed_model.traffic_generator.scapy
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index c719297c11..bdb8462622 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -16,9 +16,9 @@ Packages
 
    tests
    api
-   framework.testbed_model
+   api.testbed_model
    framework.remote_session
-   framework.params
+   api.params
    framework.config
 
 Modules
@@ -29,14 +29,15 @@ Modules
 
    framework.runner
    framework.test_run
-   framework.test_suite
+   framework.linux_session
+   api.test_suite
    framework.test_result
    framework.settings
-   framework.context
+   api.context
    framework.logger
    framework.parser
-   framework.utils
-   framework.exception
+   api.utils
+   api.exception
 
 
 Indices and tables
@@ -44,4 +45,4 @@ Indices and tables
 
 * :ref:`genindex`
 * :ref:`modindex`
-* :ref:`search`
+* :ref:`search`
\ No newline at end of file
diff --git a/dts/api/params/types.py b/dts/api/params/types.py
index 55a0e546c1..280c87ec92 100644
--- a/dts/api/params/types.py
+++ b/dts/api/params/types.py
@@ -12,8 +12,10 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
             params = TestPmdParams(**kwargs)
 """
 
+from __future__ import annotations
+
 from pathlib import PurePath
-from typing import TypedDict
+from typing import TYPE_CHECKING, TypedDict
 
 from api.cryptodev.config import (
     AeadAlgName,
@@ -32,7 +34,9 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TestType,
     TLSVersion,
 )
-from api.params import Switch, YesNoSwitch
+
+if TYPE_CHECKING:
+    from api.params import Switch, YesNoSwitch
 from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.port import Port
 from api.testbed_model.virtual_device import VirtualDevice
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index e9cd822bac..09974048e7 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -14,6 +14,8 @@
     testpmd.close()
 """
 
+from __future__ import annotations
+
 import functools
 import re
 import time
@@ -21,6 +23,7 @@
 from enum import Flag
 from pathlib import PurePath
 from typing import (
+    TYPE_CHECKING,
     Any,
     Callable,
     ClassVar,
@@ -34,7 +37,9 @@
 from api.capabilities import LinkTopology, NicCapability
 from api.context import get_ctx
 from api.exception import InteractiveCommandExecutionError, InternalError
-from api.params.types import TestPmdParamsDict
+
+if TYPE_CHECKING:
+    from api.params.types import TestPmdParamsDict
 from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
 from api.testpmd.types import (
     ChecksumOffloadOptions,
-- 
2.52.0

