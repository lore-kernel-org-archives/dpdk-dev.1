Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC79D6D22C
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 15:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C544340275;
	Thu, 18 Dec 2025 16:07:29 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 5A3414026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 16:07:28 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-88a346c284fso8394916d6.3
 for <dev@dpdk.org>; Thu, 18 Dec 2025 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766070447; x=1766675247; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KGew/kE0AciKJiiiPEqmELw3hoZAz5oNB0oiYzu2Nc=;
 b=V1g0rFCG59K4c4n/qnfWLRFR2/ImJV42KfH9J9mE96VIbCWEitI3UniRfLHdF/0w3P
 Qtj06UYdi0ON8xGcy4rIa+4N1aWySCXqCh8FTt+dUTwA+RjRThevUAMWVZEfx1Kdoke/
 jHyw0dcBl3juf6DYQO7ICDXR8InF2xbfQHaf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766070447; x=1766675247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/KGew/kE0AciKJiiiPEqmELw3hoZAz5oNB0oiYzu2Nc=;
 b=Ohq2nIYJcg5ed9x7R2rggYvrPGDQkAsYG2wMJuNm7sPATwQ4KpGmNZrvTJQAu1Novq
 nGbRr4ggWo81IzxmNMDfuKd1IFLTx14lSYiMO/cAfjGvgD/xYoNG6V45m6usPdqgQP1R
 rZNxXgASiql6i70f+CekD/7FrJmF8z1ASrOm78v69tHNYnDQdRuqtCqKlYGDphzY0ofq
 l5kxI/gVbdE74yLIbYbuHEkQsc32yUS2gduh0Kt3g2HUbVDi0Jc/p9FrYxbgZ+SQ2Nrd
 I+2ZR+FbJyb99df1PA7jRvHCp3DmlcPl2GR7GEorvjwUTKZpxYLy5hflHf3B8e6aNx5F
 9hIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ZmuoqOS84zQfMXjOK6GH34F4+pn0fRHGthT2UJomEgB2km9Xv6M1B0wnbhynovQKZlg=@dpdk.org
X-Gm-Message-State: AOJu0YwqELLkWIvMsTQn3wAz0BWjjLb8g7qd7L+QNQyfSEID+izXoyrc
 T8gz0PTO+sc7TR+g1kTWcvdUFSsYiHG0Y15jmpyaDxLCyxdmuuVXKgo/can4gDgBhLE=
X-Gm-Gg: AY/fxX6Yoz1IUtKw03GbBwg3lTpGx+8cCx3MEhC8swAWvzQBA8R06o4ZcA60XRFhPkV
 UOyg+qOGgOOYzpn5J25wj/BMW+a1LknKO/dGx1E95HxX+renAirtxz0BtOcmruXqvk33ApEe+ov
 kIPbVSOArdeTtJ3DnZA5Eg1gpPzHAz5ijL/HFTF6BoAiVIDLr2436vJC2MUsc7HtAFL8dXx+b0J
 v9UFGxQDDSik546CIgidiMDpd9yinaxtbm2Pdfu7/3X0QFHJUVZBipP8afGQdiBNbV31/EI8XO4
 uP62w8IR9NhJk5HO8MA8CAtFN/cKRI7Yx/8zkfUUUVUxnGLVHuAnY6WXa8vQLrmFyoLP29WNtK9
 dRIsexQ4jM/Xrfsng5jjV+etRB+qDuPgg9aVOxq1kHn0WADJgYxshi7nKuoAvGUwSpdq9AM1NNZ
 xfFCQR8MRDu7RgA3COw1LvxgU=
X-Google-Smtp-Source: AGHT+IHxhCCsL7U24KJ+USbw0CL33YKlA0TLL8xacWnOTObT0BGP/mFm9qAGDcvkjM6vvexeC5+fpQ==
X-Received: by 2002:a05:6214:4015:b0:880:5001:17d3 with SMTP id
 6a1803df08f44-8887e101533mr337351296d6.40.1766070447466; 
 Thu, 18 Dec 2025 07:07:27 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88c6089aecesm20801096d6.32.2025.12.18.07.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:07:26 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: update testsuite named to be clear and consistent
Date: Thu, 18 Dec 2025 10:07:18 -0500
Message-ID: <20251218150718.738116-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251217182540.715464-1-abailey@iol.unh.edu>
References: <20251217182540.715464-1-abailey@iol.unh.edu>
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

Some test suites were prefixed with PMD which is not meaningful.
Other test suites used different naming schemes and this patch updates
this. For example, some abbreviated words that others had not. These
word are no longer abbreviated.

Bugzilla ID: 1826

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_buffer_scatter.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_flow_offload.rst              | 8 ++++++++
 ...uite_virtio_fwd.rst => tests.TestSuite_l2_forward.rst} | 4 ++--
 doc/api/dts/tests.TestSuite_l2fwd.rst                     | 8 --------
 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst        | 8 --------
 doc/api/dts/tests.TestSuite_queue_start_stop.rst          | 8 --------
 doc/api/dts/tests.TestSuite_queue_toggle.rst              | 8 ++++++++
 doc/api/dts/tests.TestSuite_rte_flow.rst                  | 8 --------
 doc/api/dts/tests.TestSuite_uni_pkt.rst                   | 8 --------
 doc/api/dts/tests.TestSuite_unified_packet.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_virtio_forward.rst            | 8 ++++++++
 ..._pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} | 4 ++--
 .../{TestSuite_rte_flow.py => TestSuite_flow_offload.py}  | 6 +++---
 dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} | 2 +-
 ...uite_queue_start_stop.py => TestSuite_queue_toggle.py} | 6 +++---
 dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py}      | 2 +-
 .../{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} | 2 +-
 ...estSuite_virtio_fwd.py => TestSuite_virtio_forward.py} | 2 +-
 18 files changed, 54 insertions(+), 54 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_buffer_scatter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_flow_offload.rst
 rename doc/api/dts/{tests.TestSuite_virtio_fwd.rst => tests.TestSuite_l2_forward.rst} (60%)
 delete mode 100644 doc/api/dts/tests.TestSuite_l2fwd.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
 create mode 100644 doc/api/dts/tests.TestSuite_queue_toggle.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_uni_pkt.rst
 create mode 100644 doc/api/dts/tests.TestSuite_unified_packet.rst
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_forward.rst
 rename dts/tests/{TestSuite_pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} (98%)
 rename dts/tests/{TestSuite_rte_flow.py => TestSuite_flow_offload.py} (99%)
 rename dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} (98%)
 rename dts/tests/{TestSuite_queue_start_stop.py => TestSuite_queue_toggle.py} (97%)
 rename dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py} (99%)
 rename dts/tests/{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} (99%)
 rename dts/tests/{TestSuite_virtio_fwd.py => TestSuite_virtio_forward.py} (99%)

diff --git a/doc/api/dts/tests.TestSuite_buffer_scatter.rst b/doc/api/dts/tests.TestSuite_buffer_scatter.rst
new file mode 100644
index 0000000000..ce764ff0d6
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_buffer_scatter.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+buffer_scatter Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_buffer_scatter
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_flow_offload.rst b/doc/api/dts/tests.TestSuite_flow_offload.rst
new file mode 100644
index 0000000000..5fcd3f57c3
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_flow_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+flow_offload Test Suite
+=======================
+
+.. automodule:: tests.TestSuite_flow_offload
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_l2_forward.rst
similarity index 60%
rename from doc/api/dts/tests.TestSuite_virtio_fwd.rst
rename to doc/api/dts/tests.TestSuite_l2_forward.rst
index e40cc4ca2b..3570a1e101 100644
--- a/doc/api/dts/tests.TestSuite_virtio_fwd.rst
+++ b/doc/api/dts/tests.TestSuite_l2_forward.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: BSD-3-Clause
 
-virtio_fwd Test Suite
+l2_forward Test Suite
 =====================
 
-.. automodule:: tests.TestSuite_virtio_fwd
+.. automodule:: tests.TestSuite_l2_forward
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_l2fwd.rst b/doc/api/dts/tests.TestSuite_l2fwd.rst
deleted file mode 100644
index 5a0ca312e9..0000000000
--- a/doc/api/dts/tests.TestSuite_l2fwd.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-l2fwd Test Suite
-================
-
-.. automodule:: tests.TestSuite_l2fwd
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst b/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
deleted file mode 100644
index cdf30fd879..0000000000
--- a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-pmd_buffer_scatter Test Suite
-=============================
-
-.. automodule:: tests.TestSuite_pmd_buffer_scatter
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_queue_start_stop.rst b/doc/api/dts/tests.TestSuite_queue_start_stop.rst
deleted file mode 100644
index 87121676fb..0000000000
--- a/doc/api/dts/tests.TestSuite_queue_start_stop.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-queue_start_stop Test Suite
-===========================
-
-.. automodule:: tests.TestSuite_queue_start_stop
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_queue_toggle.rst b/doc/api/dts/tests.TestSuite_queue_toggle.rst
new file mode 100644
index 0000000000..1d6345511f
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_queue_toggle.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+queue_toggle Test Suite
+=======================
+
+.. automodule:: tests.TestSuite_queue_toggle
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst b/doc/api/dts/tests.TestSuite_rte_flow.rst
deleted file mode 100644
index eacbfd3a2a..0000000000
--- a/doc/api/dts/tests.TestSuite_rte_flow.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-rte_flow Test Suite
-===================
-
-.. automodule:: tests.TestSuite_rte_flow
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_uni_pkt.rst b/doc/api/dts/tests.TestSuite_uni_pkt.rst
deleted file mode 100644
index 95c5a5a28b..0000000000
--- a/doc/api/dts/tests.TestSuite_uni_pkt.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-uni_pkt Test Suite
-==================
-
-.. automodule:: tests.TestSuite_uni_pkt
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_unified_packet.rst b/doc/api/dts/tests.TestSuite_unified_packet.rst
new file mode 100644
index 0000000000..dddf12b18a
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_unified_packet.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+unified_packet Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_unified_packet
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_virtio_forward.rst b/doc/api/dts/tests.TestSuite_virtio_forward.rst
new file mode 100644
index 0000000000..9178c73be5
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_virtio_forward.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+virtio_forward Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_virtio_forward
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
similarity index 98%
rename from dts/tests/TestSuite_pmd_buffer_scatter.py
rename to dts/tests/TestSuite_buffer_scatter.py
index 96da67ee7d..48c0167de6 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -35,8 +35,8 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
-class TestPmdBufferScatter(TestSuite):
-    """DPDK PMD packet scattering test suite.
+class TestBufferScatter(TestSuite):
+    """DPDK packet scattering test suite.
 
     Configure the Rx queues to have mbuf data buffers
     whose sizes are smaller than the maximum packet size.
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_flow_offload.py
similarity index 99%
rename from dts/tests/TestSuite_rte_flow.py
rename to dts/tests/TestSuite_flow_offload.py
index 207cbce2d3..7339749908 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2025 University of New Hampshire
 
-"""RTE Flow testing suite.
+"""Flow Offload testing suite.
 
 This suite verifies a range of flow rules built using patterns
 and actions from the RTE Flow API. It would be impossible to cover
@@ -32,8 +32,8 @@
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
+class TestFlowOffload(TestSuite):
+    """Flow Offload test suite.
 
     This suite consists of 12 test cases:
     1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2_forward.py
similarity index 98%
rename from dts/tests/TestSuite_l2fwd.py
rename to dts/tests/TestSuite_l2_forward.py
index 596b892730..95f9c62bdc 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2_forward.py
@@ -28,7 +28,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
-class TestL2fwd(TestSuite):
+class TestL2Forward(TestSuite):
     """L2 forwarding test suite."""
 
     #: The total number of packets to generate and send for forwarding.
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_toggle.py
similarity index 97%
rename from dts/tests/TestSuite_queue_start_stop.py
rename to dts/tests/TestSuite_queue_toggle.py
index e9048d4245..50d371e975 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 University of New Hampshire
 
-"""Rx/Tx queue start and stop functionality suite.
+"""Rx/Tx queue toggle functionality suite.
 
 This suite tests the ability of the poll mode driver to start and
 stop either the Rx or Tx queue (depending on the port) during runtime,
@@ -32,8 +32,8 @@
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
-class TestQueueStartStop(TestSuite):
-    """DPDK Queue start/stop test suite.
+class TestQueueToggle(TestSuite):
+    """DPDK Queue toggle test suite.
 
     Ensures Rx/Tx queue on a port can be disabled and enabled.
     Verifies packets are not received when either queue is disabled.
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_rss.py
similarity index 99%
rename from dts/tests/TestSuite_pmd_rss.py
rename to dts/tests/TestSuite_rss.py
index f6adf262c3..f941248d7a 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -55,7 +55,7 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
-class TestPmdRss(TestSuite):
+class TestRss(TestSuite):
     """PMD RSS test suite."""
 
     config: Config
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_unified_packet.py
similarity index 99%
rename from dts/tests/TestSuite_uni_pkt.py
rename to dts/tests/TestSuite_unified_packet.py
index 97d61cd03a..a35e25d25b 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -34,7 +34,7 @@
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
-class TestUniPkt(TestSuite):
+class TestUnifiedPacket(TestSuite):
     """DPDK Unified packet test suite.
 
     This testing suite uses testpmd's verbose output hardware/software
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_forward.py
similarity index 99%
rename from dts/tests/TestSuite_virtio_fwd.py
rename to dts/tests/TestSuite_virtio_forward.py
index bdecdb76fd..6efaa4e156 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -20,7 +20,7 @@
 from framework.testbed_model.virtual_device import VirtualDevice
 
 
-class TestVirtioFwd(TestSuite):
+class TestVirtioForward(TestSuite):
     """Virtio forwarding test suite."""
 
     virtio_user_vdev = VirtualDevice(
-- 
2.50.1

