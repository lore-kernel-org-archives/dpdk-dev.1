Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1423CD13D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 22:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98ACD4069D;
	Fri,  1 May 2026 00:06:49 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 1E8A140674
 for <dev@dpdk.org>; Fri,  1 May 2026 00:06:47 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-50d6ab4476eso11901161cf.2
 for <dev@dpdk.org>; Thu, 30 Apr 2026 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777586806; x=1778191606; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmxukdfDOCg8sgBWef3iyOasGZUgCGn3Vg3DPBQ7oc0=;
 b=EaLy4HzB8vdVUtJGlDfTyJ8eUxOszqbPuk6XS6EjIN9S1pgJG+e5GTwWjN2dCcCGPb
 fU2cdwq6aHZz35pzcJZdWubXA+Qc2D0+gLWQDB9GQCw5Y75rf3qWBJsF9UvjiGIkd9xU
 4jKTfqFJF8S4mEH7qvAi9b9kP+Iq2qQOWFH8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777586806; x=1778191606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmxukdfDOCg8sgBWef3iyOasGZUgCGn3Vg3DPBQ7oc0=;
 b=T+mozr7mAgsDVrIL++h8AvqHb7BuW+2vqOQf2z3a6RUrGchWVduAJaxpU0PqnBlr6K
 CI4ZYbQE+TPAtzlBqtn4zkOQoaJawJ4dUfb/SgDb4dfSwguDb8AqZjljLIBjzczYEY+g
 PlOLLOhhtTLvSQNF+VGvqJyppgTiUAtBmkV6xWveZucTbNjg51o05Fgwkx7o+XbLEVuw
 GA4prZg4FpUkqUh4PwMJAXM+5SeTbz1mQy9qE536rnzWfkLKvavnxHT/OOVs1E/gdwgV
 m52erBjyTIR70xmeK3aBhIefQb+VNWUayCIunO0ZadwAz7hlN9BISsyUqqg41T9Dki5z
 zxrg==
X-Gm-Message-State: AOJu0YzBu/ANsZMqx6NaVWTUKKjLchV3lfi13s/71kIGxbD3/E6P0P0J
 tyP82z4wSMETDq41ahWBxd1gh2vHN9Gpj/GU+AiZDRSlXPiKacavj3c7IriWqjuEgtY=
X-Gm-Gg: AeBDieurM1UdUSka5Xbznf0TKrjPdYDkk5kvPpxXdZq9EXP12ahRZYh/oWqrMgVqaQk
 qoHR6sX+NR3PqG+DvBScPneStn83dRFSowxG3/41DpPovxvwUmGP/PMvBULG3wGJJPnyN54rBCy
 7MJ7mJ2i3V6HFHYFXVfRJ0dJtywyTKPe5+GByz0FR2AZVLd6Xv8A5yQC1aT2Ypa6fk1oL4M9MjB
 uB09LG5DBLnk7v9xkbhAsxbvDzo6RNlPyVEJXHaXc/C6cXraiT0xsXL2dKoMj/cuLXUke0ViRWP
 da3vLMdml3mFevjArOk7zrZWtT3mHCKLJ6Gbwa7nov3YSoJJWXV9yF+PcEW/WV8e+XavENvq8OK
 yRKh5YcCM5dnrmcWSgrrO0R+Wamz2aXCjKfrLY+mVlFTbz82PjLXz0x+/W66VHYvEECA3Wv6mrY
 3sROkfn47MtuAqGYtZRkklUkCMak6hnCTSqNRueakwJD8ylKamfjVpQW7/aGQBX9gAjr6jTZIaa
 0vydenjI5Y=
X-Received: by 2002:a05:622a:98e:b0:50e:ca38:e219 with SMTP id
 d75a77b69052e-5102ae1b398mr72864951cf.45.1777586806175; 
 Thu, 30 Apr 2026 15:06:46 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm3146136d6.48.2026.04.30.15.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:06:45 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 4/7] dts: move testbed model from framework to API
Date: Thu, 30 Apr 2026 18:06:35 -0400
Message-ID: <20260430220638.30666-5-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430220638.30666-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260430220638.30666-1-dmarx@iol.unh.edu>
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

Multiple test suites import modules from testbed model
in the framework. Move this directory to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
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
 doc/api/dts/framework.testbed_model.rst       | 28 -------------------
 ...mework.testbed_model.traffic_generator.rst | 16 -----------
 doc/api/dts/index.rst                         |  2 +-
 dts/api/artifact.py                           |  2 +-
 dts/api/capabilities.py                       |  8 +++---
 dts/api/context.py                            | 10 +++----
 dts/api/cryptodev/__init__.py                 |  2 +-
 dts/api/packet.py                             | 12 ++++----
 dts/api/test.py                               |  2 +-
 .../testbed_model/__init__.py                 |  0
 .../testbed_model/capability.py               | 10 +++----
 dts/{framework => api}/testbed_model/cpu.py   |  2 +-
 .../testbed_model/linux_session.py            |  2 +-
 dts/{framework => api}/testbed_model/node.py  |  0
 .../testbed_model/os_session.py               |  6 ++--
 dts/{framework => api}/testbed_model/port.py  |  0
 .../testbed_model/posix_session.py            |  0
 .../testbed_model/topology.py                 |  4 +--
 .../traffic_generator/__init__.py             |  2 +-
 .../capturing_traffic_generator.py            |  2 +-
 .../performance_traffic_generator.py          |  0
 .../testbed_model/traffic_generator/scapy.py  | 12 ++++----
 .../traffic_generator/traffic_generator.py    |  6 ++--
 .../testbed_model/traffic_generator/trex.py   | 14 +++++-----
 .../testbed_model/virtual_device.py           |  0
 dts/api/testpmd/__init__.py                   |  2 +-
 dts/framework/params/eal.py                   |  6 ++--
 dts/framework/params/types.py                 |  6 ++--
 dts/framework/remote_session/blocking_app.py  |  2 +-
 dts/framework/remote_session/dpdk.py          | 10 +++----
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 .../remote_session/interactive_shell.py       |  4 +--
 dts/framework/runner.py                       |  2 +-
 dts/framework/test_result.py                  |  2 +-
 dts/framework/test_run.py                     | 18 ++++++------
 dts/framework/test_suite.py                   |  4 +--
 dts/tests/TestSuite_blocklist.py              |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py   |  4 +--
 dts/tests/TestSuite_l2fwd.py                  |  4 +--
 dts/tests/TestSuite_packet_capture.py         |  8 +++---
 dts/tests/TestSuite_smoke_tests.py            |  2 +-
 dts/tests/TestSuite_softnic.py                |  2 +-
 dts/tests/TestSuite_virtio_fwd.py             |  6 ++--
 57 files changed, 148 insertions(+), 148 deletions(-)
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
 delete mode 100644 doc/api/dts/framework.testbed_model.rst
 delete mode 100644 doc/api/dts/framework.testbed_model.traffic_generator.rst
 rename dts/{framework => api}/testbed_model/__init__.py (100%)
 rename dts/{framework => api}/testbed_model/capability.py (99%)
 rename dts/{framework => api}/testbed_model/cpu.py (99%)
 rename dts/{framework => api}/testbed_model/linux_session.py (99%)
 rename dts/{framework => api}/testbed_model/node.py (100%)
 rename dts/{framework => api}/testbed_model/os_session.py (99%)
 rename dts/{framework => api}/testbed_model/port.py (100%)
 rename dts/{framework => api}/testbed_model/posix_session.py (100%)
 rename dts/{framework => api}/testbed_model/topology.py (99%)
 rename dts/{framework => api}/testbed_model/traffic_generator/__init__.py (97%)
 rename dts/{framework => api}/testbed_model/traffic_generator/capturing_traffic_generator.py (99%)
 rename dts/{framework => api}/testbed_model/traffic_generator/performance_traffic_generator.py (100%)
 rename dts/{framework => api}/testbed_model/traffic_generator/scapy.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/traffic_generator.py (94%)
 rename dts/{framework => api}/testbed_model/traffic_generator/trex.py (97%)
 rename dts/{framework => api}/testbed_model/virtual_device.py (100%)

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
index 98269d6e80..f47e4af3f2 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -16,7 +16,7 @@ Packages
 
    tests
    api
-   framework.testbed_model
+   api.testbed_model
    framework.remote_session
    framework.params
    framework.config
diff --git a/dts/api/artifact.py b/dts/api/artifact.py
index f3dd07de56..74a8ac667f 100644
--- a/dts/api/artifact.py
+++ b/dts/api/artifact.py
@@ -48,9 +48,9 @@
 from typing_extensions import Buffer
 
 from api.exception import InternalError
+from api.testbed_model.node import Node, NodeIdentifier, get_node
 from framework.logger import DTSLogger, get_dts_logger
 from framework.settings import SETTINGS
-from framework.testbed_model.node import Node, NodeIdentifier, get_node
 
 TextMode: TypeAlias = (
     Literal["r", "r+", "w", "w+", "a", "a+", "x", "x+"]
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 09bc538523..04fc20738b 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -23,7 +23,7 @@
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires_link_topology
+        from api.testbed_model.capability import LinkTopology, requires_link_topology
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -34,7 +34,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires_nic_capability
+        from api.testbed_model.capability import NicCapability, requires_nic_capability
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -235,7 +235,7 @@ def requires_link_topology(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import TopologyCapability
+    from api.testbed_model.capability import TopologyCapability
 
     def add_required_topology(
         test_case_or_suite: type["TestProtocol"],
@@ -258,7 +258,7 @@ def requires_nic_capability(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import DecoratedNicCapability
+    from api.testbed_model.capability import DecoratedNicCapability
 
     def add_required_capability(
         test_case_or_suite: type["TestProtocol"],
diff --git a/dts/api/context.py b/dts/api/context.py
index 7e61c85998..13a2ad6c39 100644
--- a/dts/api/context.py
+++ b/dts/api/context.py
@@ -9,17 +9,17 @@
 from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
 
 from api.exception import InternalError
+from api.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
+from api.testbed_model.node import Node
+from api.testbed_model.topology import Topology
 from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
-from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
-from framework.testbed_model.node import Node
-from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.testbed_model.capability import TestProtocol
+    from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
     from framework.test_suite import TestCase, TestSuite
-    from framework.testbed_model.capability import TestProtocol
-    from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
 
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 67dcb02130..1ba8e0d977 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -14,6 +14,7 @@
 
 from typing_extensions import Unpack
 
+from api.context import get_ctx
 from api.cryptodev.config import CryptoPmdParams, TestType
 from api.cryptodev.types import (
     CryptodevResults,
@@ -23,7 +24,6 @@
     VerifyResults,
 )
 from api.exception import RemoteCommandExecutionError, SkippedTestException
-from api.context import get_ctx
 from framework.remote_session.dpdk_shell import compute_eal_params
 
 if TYPE_CHECKING:
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 59f26da833..bf90961c26 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -27,16 +27,16 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Padding, raw
 
+from api.context import get_ctx
 from api.exception import InternalError
 from api.test import fail, log_debug
-from api.utils import get_packet_summaries
-from api.context import get_ctx
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
     PerformanceTrafficStats,
 )
+from api.utils import get_packet_summaries
 
 
 def send_packet_and_capture(
@@ -83,7 +83,7 @@ def send_packets_and_capture(
         A list of received packets.
     """
     from api.context import get_ctx
-    from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    from api.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
 
@@ -340,7 +340,7 @@ def assess_performance_by_packet(
     Returns:
         Performance statistics of the generated test.
     """
-    from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    from api.testbed_model.traffic_generator.performance_traffic_generator import (
         PerformanceTrafficGenerator,
     )
 
diff --git a/dts/api/test.py b/dts/api/test.py
index a1f2326075..03846639ad 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -10,8 +10,8 @@
 from datetime import datetime
 
 from api.artifact import Artifact
-from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from api.context import get_ctx
+from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
 
 
diff --git a/dts/framework/testbed_model/__init__.py b/dts/api/testbed_model/__init__.py
similarity index 100%
rename from dts/framework/testbed_model/__init__.py
rename to dts/api/testbed_model/__init__.py
diff --git a/dts/framework/testbed_model/capability.py b/dts/api/testbed_model/capability.py
similarity index 99%
rename from dts/framework/testbed_model/capability.py
rename to dts/api/testbed_model/capability.py
index 001b65994c..4e4e976be5 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/api/testbed_model/capability.py
@@ -26,7 +26,7 @@
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires
+        from api.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -37,7 +37,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires
+        from api.testbed_model.capability import NicCapability, requires
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -65,10 +65,10 @@ def test_scatter_mbuf_2048(self):
 
 from api.capabilities import LinkTopology, NicCapability
 from api.exception import ConfigurationError, InternalError, SkippedTestException
+from api.testbed_model.node import Node
+from api.testbed_model.port import DriverKind
+from api.testbed_model.topology import Topology
 from framework.logger import get_dts_logger
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import DriverKind
-from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
     from api.testpmd import TestPmd
diff --git a/dts/framework/testbed_model/cpu.py b/dts/api/testbed_model/cpu.py
similarity index 99%
rename from dts/framework/testbed_model/cpu.py
rename to dts/api/testbed_model/cpu.py
index 52ef196f84..ee754f5844 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/api/testbed_model/cpu.py
@@ -29,7 +29,7 @@
 
 @unique
 class Architecture(StrEnum):
-    r"""The supported architectures of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The supported architectures of :class:`~api.testbed_model.node.Node`\s."""
 
     #:
     i686 = auto()
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/api/testbed_model/linux_session.py
similarity index 99%
rename from dts/framework/testbed_model/linux_session.py
rename to dts/api/testbed_model/linux_session.py
index 69b0923744..7307b2abe2 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/api/testbed_model/linux_session.py
@@ -23,8 +23,8 @@
     InternalError,
     RemoteCommandExecutionError,
 )
+from api.testbed_model.port import PortInfo
 from api.utils import expand_range
-from framework.testbed_model.port import PortInfo
 
 from .cpu import LogicalCore
 from .port import Port
diff --git a/dts/framework/testbed_model/node.py b/dts/api/testbed_model/node.py
similarity index 100%
rename from dts/framework/testbed_model/node.py
rename to dts/api/testbed_model/node.py
diff --git a/dts/framework/testbed_model/os_session.py b/dts/api/testbed_model/os_session.py
similarity index 99%
rename from dts/framework/testbed_model/os_session.py
rename to dts/api/testbed_model/os_session.py
index 7bb339fab2..b1e0538ac9 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/api/testbed_model/os_session.py
@@ -73,11 +73,11 @@ class OSSessionInfo:
 
     Attributes:
         os_name: The name of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
         os_version: The version of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
         kernel_version: The kernel version of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
     """
 
     os_name: str
diff --git a/dts/framework/testbed_model/port.py b/dts/api/testbed_model/port.py
similarity index 100%
rename from dts/framework/testbed_model/port.py
rename to dts/api/testbed_model/port.py
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/api/testbed_model/posix_session.py
similarity index 100%
rename from dts/framework/testbed_model/posix_session.py
rename to dts/api/testbed_model/posix_session.py
diff --git a/dts/framework/testbed_model/topology.py b/dts/api/testbed_model/topology.py
similarity index 99%
rename from dts/framework/testbed_model/topology.py
rename to dts/api/testbed_model/topology.py
index 5b6ff2add5..11593d64d5 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/api/testbed_model/topology.py
@@ -19,8 +19,8 @@
 
 from api.capabilities import LinkTopology
 from api.exception import ConfigurationError, InternalError
-from framework.testbed_model.linux_session import LinuxSession
-from framework.testbed_model.node import Node, NodeIdentifier
+from api.testbed_model.linux_session import LinuxSession
+from api.testbed_model.node import Node, NodeIdentifier
 
 from .port import DriverKind, Port, PortConfig
 
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/api/testbed_model/traffic_generator/__init__.py
similarity index 97%
rename from dts/framework/testbed_model/traffic_generator/__init__.py
rename to dts/api/testbed_model/traffic_generator/__init__.py
index 324b5e88f3..11fa25448a 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/api/testbed_model/traffic_generator/__init__.py
@@ -15,12 +15,12 @@
 """
 
 from api.exception import ConfigurationError
+from api.testbed_model.node import Node
 from framework.config.test_run import (
     ScapyTrafficGeneratorConfig,
     TrafficGeneratorConfig,
     TrexTrafficGeneratorConfig,
 )
-from framework.testbed_model.node import Node
 
 from .scapy import ScapyTrafficGenerator
 from .traffic_generator import TrafficGenerator
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
similarity index 99%
rename from dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
index 2804d64990..db274e5e82 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -17,8 +17,8 @@
 from scapy.packet import Packet
 
 from api.artifact import Artifact
+from api.testbed_model.port import Port
 from api.utils import get_packet_summaries
-from framework.testbed_model.port import Port
 
 from .traffic_generator import TrafficGenerator
 
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
similarity index 100%
rename from dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/api/testbed_model/traffic_generator/scapy.py
similarity index 98%
rename from dts/framework/testbed_model/traffic_generator/scapy.py
rename to dts/api/testbed_model/traffic_generator/scapy.py
index e983443548..215c57f93d 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/api/testbed_model/traffic_generator/scapy.py
@@ -26,15 +26,15 @@
 from scapy.packet import Packet
 
 from api.exception import InteractiveSSHSessionDeadError, InternalError
+from api.testbed_model.node import Node
+from api.testbed_model.port import Port
+from api.testbed_model.topology import Topology
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
 from framework.config.node import OS
 from framework.config.test_run import ScapyTrafficGeneratorConfig
 from framework.remote_session.python_shell import PythonShell
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
-from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
 
 from .capturing_traffic_generator import CapturingTrafficGenerator
 
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/api/testbed_model/traffic_generator/traffic_generator.py
similarity index 94%
rename from dts/framework/testbed_model/traffic_generator/traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/traffic_generator.py
index fedce77fdf..5fd68e5144 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/traffic_generator.py
@@ -13,11 +13,11 @@
 
 from scapy.packet import Packet
 
+from api.testbed_model.node import Node
+from api.testbed_model.port import Port
+from api.testbed_model.topology import Topology
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
-from framework.testbed_model.topology import Topology
 
 
 class TrafficGenerator(ABC):
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/api/testbed_model/traffic_generator/trex.py
similarity index 97%
rename from dts/framework/testbed_model/traffic_generator/trex.py
rename to dts/api/testbed_model/traffic_generator/trex.py
index 2064703fcc..d97ed934c9 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/api/testbed_model/traffic_generator/trex.py
@@ -11,19 +11,19 @@
 
 from scapy.packet import Packet
 
+from api.testbed_model.node import Node, create_session
+from api.testbed_model.os_session import OSSession
+from api.testbed_model.topology import Topology
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
 from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
 from framework.parser import TextParser
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.python_shell import PythonShell
-from framework.testbed_model.node import Node, create_session
-from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
-    PerformanceTrafficGenerator,
-    PerformanceTrafficStats,
-)
 
 
 @dataclass(slots=True)
diff --git a/dts/framework/testbed_model/virtual_device.py b/dts/api/testbed_model/virtual_device.py
similarity index 100%
rename from dts/framework/testbed_model/virtual_device.py
rename to dts/api/testbed_model/virtual_device.py
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a528663c21..9f47a15433 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -32,6 +32,7 @@
 from typing_extensions import Unpack
 
 from api.capabilities import LinkTopology, NicCapability
+from api.context import get_ctx
 from api.exception import InteractiveCommandExecutionError, InternalError
 from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
 from api.testpmd.types import (
@@ -55,7 +56,6 @@
     TxOffloadConfiguration,
     VLANOffloadFlag,
 )
-from api.context import get_ctx
 from framework.params.types import TestPmdParamsDict
 from framework.remote_session.dpdk_shell import DPDKShell
 from framework.remote_session.interactive_shell import only_active
diff --git a/dts/framework/params/eal.py b/dts/framework/params/eal.py
index e84a20f02f..86bfd3fcc6 100644
--- a/dts/framework/params/eal.py
+++ b/dts/framework/params/eal.py
@@ -6,12 +6,12 @@
 from dataclasses import dataclass, field
 from typing import TYPE_CHECKING, Literal
 
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.params import Params, Switch
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.virtual_device import VirtualDevice
 
 if TYPE_CHECKING:
-    from framework.testbed_model.port import Port
+    from api.testbed_model.port import Port
 
 
 def _port_to_pci(port: "Port") -> str:
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py
index 3c7650474c..f2fa69f8b8 100644
--- a/dts/framework/params/types.py
+++ b/dts/framework/params/types.py
@@ -32,6 +32,9 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TestType,
     TLSVersion,
 )
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.port import Port
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd.config import (
     AnonMempoolAllocationMode,
     EthPeer,
@@ -54,9 +57,6 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TxUDPPortPair,
 )
 from framework.params import Switch, YesNoSwitch
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.port import Port
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index 07db6dfeb0..84db3974b1 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -31,11 +31,11 @@
 from typing_extensions import Self
 
 from api.context import get_ctx
+from api.testbed_model.node import Node
 from framework.params import Params
 from framework.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
-from framework.testbed_model.node import Node
 
 P = TypeVar("P", bound=Params)
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 9f7cd60dfe..713a564d25 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,7 +13,12 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
+from api.testbed_model.node import Node
+from api.testbed_model.os_session import OSSession
+from api.testbed_model.virtual_device import VirtualDevice
 from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
@@ -26,14 +31,9 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
-from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
-from framework.testbed_model.node import Node
-from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 @dataclass(slots=True, frozen=True)
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index a8f169787c..b807f9bdae 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -11,12 +11,12 @@
 from pathlib import PurePath
 
 from api.context import get_ctx
+from api.testbed_model.cpu import LogicalCoreList
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
     only_active,
 )
-from framework.testbed_model.cpu import LogicalCoreList
 
 
 def compute_eal_params(
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index d138727c85..ec539bad95 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,16 +29,16 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
+from api.context import get_ctx
 from api.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
-from api.context import get_ctx
+from api.testbed_model.node import Node
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
-from framework.testbed_model.node import Node
 
 P = ParamSpec("P")
 T = TypeVar("T", bound="InteractiveShell")
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index a0d8039a04..29be7b80fe 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -13,9 +13,9 @@
 import textwrap
 
 from api.exception import ConfigurationError
+from api.testbed_model.node import Node
 from framework.config.common import ValidationContext
 from framework.test_run import TestRun
-from framework.testbed_model.node import Node
 
 from .config import Configuration, load_config
 from .logger import DTSLogger, get_dts_logger
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 3cecb928ca..5f945163ce 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -36,9 +36,9 @@
 from typing_extensions import OrderedDict
 
 from api.exception import DTSError, ErrorSeverity, InternalError
+from api.testbed_model.os_session import OSSessionInfo
 from framework.remote_session.dpdk import DPDKBuildInfo
 from framework.settings import SETTINGS
-from framework.testbed_model.os_session import OSSessionInfo
 
 
 class Result(IntEnum):
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 605a916ebb..790fbf997d 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,22 +106,22 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
+from api.testbed_model.capability import (
+    Capability,
+    get_supported_capabilities,
+    test_if_supported,
+)
+from api.testbed_model.node import Node
+from api.testbed_model.topology import PortLink, Topology
+from api.testbed_model.traffic_generator import create_traffic_generator
 from framework.config.test_run import TestRunConfiguration
-from api.context import Context, init_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
 from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
-from framework.testbed_model.capability import (
-    Capability,
-    get_supported_capabilities,
-    test_if_supported,
-)
-from framework.testbed_model.node import Node
-from framework.testbed_model.topology import PortLink, Topology
-from framework.testbed_model.traffic_generator import create_traffic_generator
 
 TestScenario = tuple[type[TestSuite], BaseConfig, deque[type[TestCase]]]
 
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 6066f7a77a..786cfc7bff 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -30,10 +30,10 @@
 from typing_extensions import Self
 
 from api.exception import ConfigurationError, InternalError
+from api.testbed_model.capability import TestProtocol
+from api.testbed_model.topology import Topology
 from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
-from framework.testbed_model.capability import TestProtocol
-from framework.testbed_model.topology import Topology
 
 from .logger import DTSLogger, get_dts_logger
 
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index c57231de22..97e03b8fb7 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -11,9 +11,9 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.testbed_model.port import Port
 from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.port import Port
 
 
 class TestBlocklist(TestSuite):
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 39784cbcac..fc4b3cb308 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -13,6 +13,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.context import get_ctx
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
     AeadAlgName,
@@ -31,9 +32,8 @@
 )
 from api.exception import SkippedTestException
 from api.test import verify
-from api.context import get_ctx
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index c018efb1f7..5650366c36 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -13,17 +13,17 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.context import filter_cores
 from api.packet import (
     get_expected_packets,
     match_all_packets,
     send_packets_and_capture,
 )
+from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from api.context import filter_cores
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.cpu import LogicalCoreCount
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 4bd15e2401..042b7019aa 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,15 +36,15 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
 
 
 @dataclass(kw_only=True)
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index fce83604a6..656e2e4bb7 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,12 +19,12 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.utils import REGEX_FOR_PCI_ADDRESS
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.linux_session import LinuxSession
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index c57a12c932..91a6d4eb9f 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -18,11 +18,11 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
 from api.utils import generate_random_packets
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
index bdecdb76fd..c649aac197 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -12,12 +12,12 @@
 from api.capabilities import LinkTopology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
+from api.testbed_model.capability import requires
+from api.testbed_model.linux_session import LinuxSession
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires
-from framework.testbed_model.linux_session import LinuxSession
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class TestVirtioFwd(TestSuite):
-- 
2.52.0

