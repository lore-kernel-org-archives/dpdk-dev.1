Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B3CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B748C40653;
	Fri, 24 Oct 2025 20:51:05 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1EC40395
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:51:02 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4e88dbe8b77so20023901cf.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761331862; x=1761936662; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ohybgvj+15Dx65Hm914xU5lybI5Rb0XoRR35OhX3e3I=;
 b=TksyXeZdpgGToye+Cjcn4rOMwlqQXl5DARA47Z/8ezIIQzqHGHSMtjj8jDZRaQ90oR
 evyX86sY/W3keBm611m69aNSBUJXL9LqvxYpmYYGDPPQh8hG2cCoIg40wyt6WAu74H+7
 La8gUfIs7Ds2+B96XbvIOvyOReQRi+NsoD1kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761331862; x=1761936662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ohybgvj+15Dx65Hm914xU5lybI5Rb0XoRR35OhX3e3I=;
 b=iJeqkzjE9fKgoLuxpd5iu7gnuWNblsHlhdtHWrJEIUfbTeAcPyLK/uGG9lYk7exQIo
 lxiirzw1HvJKZiR9Ss93zRSe6e6o4DymnsfLinecujOg/m0V45gteSkuMsmn0e0KFlcP
 ekmgx1dfX9qnr1oG2TjUpHMOI9YwGE63SprAfKO9ur3UO3QAceYNHvw7Ip2r2G1GVJ+T
 AIs1vCVqYZOkqVvh2n4WToPYw3b825qrHRfxvVLvpiteOJcf8qnsuAbMXo0iB9zCsKGs
 a8EBZHViSxijLymyOlrTajLl5rsjcRMh9B8G3tNgmyVsaGALDNos7SPny5KcizG4hMha
 uKSQ==
X-Gm-Message-State: AOJu0Ywwyb2iPY1YeueITAzRfTqoN8T4KUz3IWdi7nSICgBX8n02+eJw
 DzdTxjc4wCSPkQxijY2FR0t6Aycs5A1xXwpumkUuPjKCHg2T6hNoPyTAHmUcVoQwMVwrd+XZnBc
 a62bn
X-Gm-Gg: ASbGncsRIcQKa1AsuI/x8Z/FNVC05GMJQeGK1I8xh7Tc3gimPpwjv+36mwy1ASwhLjd
 9eqCNOmB5yulyWUP+zpseeLKQAEChcUgU3IUL8GjeVgt3nJ8pZH3Ot1sCioY0RIg4eI42SqFaY7
 WkxDycbrz1RGMy4PGRYeiZpkSoKIhZkc9sEkXISWD8oVjcgCdrra7nptBrke5zV382iuZrx+lGt
 OXIcHfzbzGcj6w18t5qM4idONF1DZ8aqZ3RgscOgKiP1ImeEC8ZLEWd5q6FaaHxVzpSO+jAjovJ
 ufi2azwjsQf0G2JIHy9YCCUR8feiYwsuJMWuy8DMGTMckacncU+4RD2An2feV1AQJhwWcZBBO8l
 WKx4QSGTVQRzgQiJbEky4PRhM42SlO+g6XqggM/BfOPGK4l57M6yFRgnosIab6Qjk+N90w4y+vE
 06Uow=
X-Google-Smtp-Source: AGHT+IG1qzym6dIJpgC/6U2o9VzSjhC8nn3DJXYU0pERWa0u1EQJ9sfVVX6DxaMvu8UCbIwrHfz6wg==
X-Received: by 2002:ac8:7f46:0:b0:4e8:8651:b703 with SMTP id
 d75a77b69052e-4eb9490efecmr46252921cf.62.1761331861861; 
 Fri, 24 Oct 2025 11:51:01 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80804d81sm39830751cf.19.2025.10.24.11.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:51:01 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 3/3] dts: add virtio forwarding test suite
Date: Fri, 24 Oct 2025 14:50:55 -0400
Message-ID: <20251024185056.607160-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024185056.607160-1-dmarx@iol.unh.edu>
References: <20251024174702.600147-1-dmarx@iol.unh.edu>
 <20251024185056.607160-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add test suite covering virtio-user/vhost-user
server/client forwarding scenarios with
testpmd packet validation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_virtio_fwd.rst |   8 +
 dts/tests/TestSuite_virtio_fwd.py          | 193 +++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst
 create mode 100644 dts/tests/TestSuite_virtio_fwd.py

diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
new file mode 100644
index 0000000000..ef0d86a776
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+virtio_fwd Test Suite
+=====================
+
+.. automodule:: tests.TestSuite_virtio_fwd
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
new file mode 100644
index 0000000000..154443b205
--- /dev/null
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -0,0 +1,193 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Virtio forwarding test suite.
+
+Verify vhost/virtio pvp and fully virtual functionalities.
+"""
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+
+from api.capabilities import LinkTopology
+from api.packet import send_packets_and_capture
+from api.test import log, verify
+from api.testpmd import TestPmd
+from api.testpmd.config import SimpleForwardingModes
+from framework.test_suite import TestSuite, func_test
+from framework.testbed_model.capability import requires
+from framework.testbed_model.linux_session import LinuxSession
+from framework.testbed_model.virtual_device import VirtualDevice
+
+
+class TestVirtioFwd(TestSuite):
+    """Virtio forwarding test suite."""
+
+    virtio_user_vdev = VirtualDevice(
+        "net_virtio_user0,mac=00:01:02:03:04:05,path=/tmp/vhost-net,server=1"
+    )
+    vhost_user_vdev = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")
+
+    @requires(topology_type=LinkTopology.NO_LINK)
+    @func_test
+    def virtio_server(self) -> None:
+        """Test virtio server packet transmission.
+
+        Steps:
+            * Launch a testpmd session with a vhost-user virtual device (client side).
+            * Launch a testpmd session with a virtio-user virtual device (server side).
+            * Set the forwarding mode to mac in both sessions.
+            * Start packet forwarding on vhost session.
+            * Send a burst of packets from the virtio session.
+            * Stop packet forwarding on vhost session and collect packet stats.
+
+        Verify:
+            * Vhost session receives packets from virtio session.
+        """
+        with (
+            TestPmd(
+                prefix="vhost",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.vhost_user_vdev],
+            ) as vhost,
+            TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio,
+        ):
+            vhost.set_forward_mode(SimpleForwardingModes.mac)
+            virtio.set_forward_mode(SimpleForwardingModes.mac)
+
+            vhost.start()
+            virtio.start_tx_first(burst_num=32)
+            vhost.stop()
+
+            vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+            rx_packets = vhost_forwarding_stats[0].rx_packets
+            tx_packets = vhost_forwarding_stats[0].tx_packets
+
+            log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+            verify(
+                rx_packets != 0 and tx_packets != 0,
+                "Vhost session failed to receive packets from virtio session.",
+            )
+
+    @requires(topology_type=LinkTopology.NO_LINK)
+    @func_test
+    def virtio_server_reconnect(self) -> None:
+        """Test virtio server reconnection.
+
+        Steps:
+            * Launch a testpmd session with a vhost-user virtual device (client side).
+            * Launch a testpmd session with a virtio-user virtual device (server side).
+            * Close the virtio session and relaunch it.
+            * Start packet forwarding on vhost session.
+            * Send a burst of packets from the virtio session.
+            * Stop packet forwarding on vhost session and collect packet stats.
+
+        Verify:
+            * Vhost session receives packets from relaunched virtio session.
+        """
+        with TestPmd(
+            prefix="vhost",
+            no_pci=True,
+            memory_channels=4,
+            vdevs=[self.vhost_user_vdev],
+        ) as vhost:
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio:
+                pass
+            # end session and reconnect
+            with TestPmd(
+                prefix="virtio",
+                no_pci=True,
+                memory_channels=4,
+                vdevs=[self.virtio_user_vdev],
+            ) as virtio:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+
+                vhost.start()
+                virtio.start_tx_first(burst_num=32)
+                vhost.stop()
+
+                vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+                rx_packets = vhost_forwarding_stats[0].rx_packets
+                tx_packets = vhost_forwarding_stats[0].tx_packets
+
+                log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+                verify(
+                    rx_packets != 0 and tx_packets != 0,
+                    "Vhost session failed to receive packets from virtio session.",
+                )
+
+    @requires(topology_type=LinkTopology.TWO_LINKS)
+    @func_test
+    def pvp_loop(self) -> None:
+        """Test vhost/virtio physical-virtual-physical topology.
+
+        Steps:
+            * Launch testpmd session with a physical NIC and virtio-user vdev
+                connected to a vhost-net socket.
+            * Configure the tap interface that is created with IP address and
+                set link state to UP.
+            * Launch second testpmd session with af_packet vdev connected to
+                the tap interface.
+            * Start packet forwarding on both testpmd sessions.
+            * Send 100 packets to the physical interface from external tester.
+            * Capture packets on the same physical interface.
+
+        Verify:
+            * Vhost session receives/forwards 100+ packets.
+            * Physical interface receives all 100 sent packets.
+        """
+        self.sut_node = self._ctx.sut_node
+        if not isinstance(self.sut_node.main_session, LinuxSession):
+            verify(False, "Must be running on a Linux environment.")
+        with TestPmd(
+            prefix="virtio",
+            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
+        ) as virtio:
+            self.sut_node.main_session.set_interface_link_up(name="tap0")
+            with TestPmd(
+                prefix="vhost", no_pci=True, vdevs=[VirtualDevice("net_af_packet0,iface=tap0")]
+            ) as vhost:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.start()
+                virtio.start()
+
+                packet = Ether() / IP()
+                packets = [packet] * 100
+                captured_packets = send_packets_and_capture(packets)
+
+                vhost.stop()
+                virtio.stop()
+
+                vhost_forwarding_stats, vhost_raw_output = vhost.show_port_stats_all()
+
+                rx_packets = vhost_forwarding_stats[0].rx_packets
+                tx_packets = vhost_forwarding_stats[0].tx_packets
+
+                log(f"Vhost forwarding statistics:\n{vhost_raw_output}")
+
+                verify(
+                    rx_packets >= 100 and tx_packets >= 100,
+                    f"PVP loop forwarding verification failed: vhost interface RX={rx_packets},"
+                    f" TX={tx_packets} (expected ≥100 each).",
+                )
+
+                verify(
+                    len(captured_packets) >= 100, "Sent packets not received on physical interface."
+                )
-- 
2.51.0

