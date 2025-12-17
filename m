Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305DD66B83
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 18:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 058D34029A;
	Wed, 17 Dec 2025 19:25:47 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 83F614025A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 19:25:45 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b2d6df99c5so90869885a.1
 for <dev@dpdk.org>; Wed, 17 Dec 2025 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765995945; x=1766600745; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ivPO6XdAbz9OXldhfYN+985mK3aw4S2mLwKtS8NRsos=;
 b=f5PSY8z8OqU2F6xIqLCcTlz+X1dkbZkQVuPgSjj6sFXqE+MJW6nqTNdV0H63GlgnDv
 bWDhgxAI3fY4tgGWbHUKAK0cfBfg0GvP/Z9ImgcBTK1EapLejPNjB9Nd6zT5WEP7qJbe
 8qSclEICycJJZxgmfz0WvXkyAVQv1/0Fy2Zrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765995945; x=1766600745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivPO6XdAbz9OXldhfYN+985mK3aw4S2mLwKtS8NRsos=;
 b=oasGoTPjJSy2p4wsUW8+xVD8GSkkoHeI/HizFMdwSgrwjEnVY9Azz2zwK3xE/9xlhZ
 Ovz6by8Tfkmx5FXm9XgFgEYvvguOpHGUNji01kh4/JMiPxwu90ZsaUQfTGOYBlrF7J/1
 XR+PsHrhtb4FWXGSeF6VM6M0AnEdJ1q5z5jgUGk5tZyp2DhGSkxtiQJVhI+MDVpBL4IG
 t/0ioThR+9+Ef/7+VVf1GPg7RZUZOgX15f7a84qVWoWcST7wmddaWn89pZhqPx0p7ddQ
 l7u9JRi4Pv7k1VzPUi4+GpSdwwIHbSAgjgcJRcf7gLqiITnojd1x8PxbtOUt/AkhoTxL
 z1iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh5tuz0bKYeLjTGIbaEfy4hLSy4xiTGtr8qp/oeaj1ykBIYtqqlQMD0jgWoPEuR1woqDA=@dpdk.org
X-Gm-Message-State: AOJu0YywFsJwFazkgFp2N3t9a5voyN9nx9m6JQqX4rcbJBgovwI8HoDx
 7JOD3YAIq8panigZfISPjMlZVyu46/lz3NqyhUonXpC0mlTt71kC4fU2h38WHd6nIwI=
X-Gm-Gg: AY/fxX7mE3trJ7HIFNUItld7MVL2kq8N+zlM1CSxJZtxzDvXaKa0lZZYqO8kt0r5sys
 icWRO/lBl5IKXLdPPPqg67xpGm256HD0GI76DAjKq+mqQfxiIv2ObdN/P0fgIiwEPRDIHxB93Y4
 FxsmRcKjwcs2N+4cV7UD2SzBJxt6f8fCKXFiGgiNqVQ6BixAOUNPpg4E7oQTCYbJ6RPTvLlLSKz
 DiZ2zRPMpDwZiz3Cl01b/NsPT2kjrhQC7Go2g5sue/EBcJXTnPo6THsgCqtxMSjTd7hPRO60kFB
 dQzQBO4atY1Qi8asNQf7BRG5MCnvlU7b31sUWBYI2njxnwJj0rDf8lDmYnFHCvK4JNV9icpazyX
 nGlBnkQApmU9/WwaNIGeAdnds/p3LAfktqYjSFY43j1u0/j+u99X+WizBfcZERUY2jMTyujqQ/t
 g4awHbRUOZt+p0nw0++Iq4AOs=
X-Google-Smtp-Source: AGHT+IGx7OCRIS2+US1dwMskn5vEMCRxWpbWryOxvJwl3WnRK0lSJDEjDc+VI9GoJWLNxvS7/lndLw==
X-Received: by 2002:ac8:5e53:0:b0:4f1:b362:eed7 with SMTP id
 d75a77b69052e-4f35f4849eamr6116971cf.42.1765995944678; 
 Wed, 17 Dec 2025 10:25:44 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f35fb68effsm414001cf.0.2025.12.17.10.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:25:44 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: update testuite names to be consistent
Date: Wed, 17 Dec 2025 13:25:40 -0500
Message-ID: <20251217182540.715464-1-abailey@iol.unh.edu>
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
 ..._pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} | 2 +-
 .../{TestSuite_rte_flow.py => TestSuite_flow_offload.py}  | 2 +-
 dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} | 2 +-
 ...uite_queue_start_stop.py => TestSuite_queue_toggle.py} | 4 ++--
 dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py}      | 4 ++--
 .../{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} | 2 +-
 ...estSuite_virtio_fwd.py => TestSuite_virtio_forward.py} | 2 +-
 18 files changed, 51 insertions(+), 51 deletions(-)
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
 rename dts/tests/{TestSuite_pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} (99%)
 rename dts/tests/{TestSuite_rte_flow.py => TestSuite_flow_offload.py} (99%)
 rename dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} (98%)
 rename dts/tests/{TestSuite_queue_start_stop.py => TestSuite_queue_toggle.py} (98%)
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
similarity index 99%
rename from dts/tests/TestSuite_pmd_buffer_scatter.py
rename to dts/tests/TestSuite_buffer_scatter.py
index 96da67ee7d..539082f2e4 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -35,7 +35,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
-class TestPmdBufferScatter(TestSuite):
+class TestBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
     Configure the Rx queues to have mbuf data buffers
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_flow_offload.py
similarity index 99%
rename from dts/tests/TestSuite_rte_flow.py
rename to dts/tests/TestSuite_flow_offload.py
index 207cbce2d3..fe62648b5f 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -32,7 +32,7 @@
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
+class TestFlowOffload(TestSuite):
     """RTE Flow test suite.
 
     This suite consists of 12 test cases:
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
similarity index 98%
rename from dts/tests/TestSuite_queue_start_stop.py
rename to dts/tests/TestSuite_queue_toggle.py
index e9048d4245..4dd36c6192 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 University of New Hampshire
 
-"""Rx/Tx queue start and stop functionality suite.
+"""Rx/Tx queue Toggle functionality suite.
 
 This suite tests the ability of the poll mode driver to start and
 stop either the Rx or Tx queue (depending on the port) during runtime,
@@ -32,7 +32,7 @@
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
-class TestQueueStartStop(TestSuite):
+class TestQueueToggle(TestSuite):
     """DPDK Queue start/stop test suite.
 
     Ensures Rx/Tx queue on a port can be disabled and enabled.
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_rss.py
similarity index 99%
rename from dts/tests/TestSuite_pmd_rss.py
rename to dts/tests/TestSuite_rss.py
index f6adf262c3..2747c8a36c 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -55,8 +55,8 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
-class TestPmdRss(TestSuite):
-    """PMD RSS test suite."""
+class TestRss(TestSuite):
+    """RSS test suite."""
 
     config: Config
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_unified_packet.py
similarity index 99%
rename from dts/tests/TestSuite_uni_pkt.py
rename to dts/tests/TestSuite_unified_packet.py
index 222276ce67..fcc7f7fbbb 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -31,7 +31,7 @@
 from framework.test_suite import TestSuite, func_test
 
 
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

