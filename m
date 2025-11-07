Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253AD4064C;
	Fri,  7 Nov 2025 22:50:31 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBAA4060B
 for <dev@dpdk.org>; Fri,  7 Nov 2025 22:50:30 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8b22efd44d8so136572185a.3
 for <dev@dpdk.org>; Fri, 07 Nov 2025 13:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762552229; x=1763157029; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIGCO7fSPsLm10IyT0ahtcmBwIBIASN9e5nAK0R0qjw=;
 b=YYca3DDHzv9XjDuKgMIaNUeKkdQ84EyAGIymFv7sZleezUY1y779SaBM5y8yeVUIxH
 Z7hsl7jExiXQ387sFNM/Az3J9KizHi3tC3V674eq5Xw6sVN9HY8K4i8I8N3yuz4UBWlM
 OAuMGDzkyQhFxGeQ/GY1luTDYUrOkFeY02MPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552229; x=1763157029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIGCO7fSPsLm10IyT0ahtcmBwIBIASN9e5nAK0R0qjw=;
 b=I5lWXkTDVqhuMM61zCO2NzIjzRocTwHg5kLxhiit867J10PHEYyTnGp951fE1eLtX+
 hrp2XaGUqpwgZPckm0nMc7aXWG7XxtJVPFmdihpHhY1b3PfCQR62XyyEVsxcHKKT5oCu
 1SdbgT9Rt4TksFE8cctoDylqMmPRZnD/m3qTI/TZoeM/WjIaT+kVT1LsNFagba2J/QFb
 lEB9HvNdej4gd2bQx/FxwKYFl4gNJyPY4NMjy5uEs7evE7kmMpjnY0r6tMQO37anWcn/
 QDwA5ZGqJp7eTDiBwhIYKI+oP45WgI9T9A8dAb1+9vXr25eratCdFkoLfw8FUDYVZywF
 eMDg==
X-Gm-Message-State: AOJu0YzCOW6pT5qX/cU9dnKcNKfWvYfigSCpqtyX5l84KExAAzyCL9yk
 B259WSjoHzsvgn6gaL20E5m3ZGhWWgZ/NF5lZy2VHPX85MY6JH1FMsuHEK4+xH0oy4k=
X-Gm-Gg: ASbGncumX9Fx+1z5B05uIcsrterfBgCBR0Z/79sa1JVRc1B3oUrQiBnYEuiBAVAWd0X
 niwMKXGmhRQ7YjjippH7PTGPmj/X9CvTSAIqhjFoNoyjuO6k0kHymUMj7RDgAz5IfNL48kj/a32
 wgvjgtT4coAxC+r35n9gEjukea6X2SME/ofkATZuY9STZrF5xg4N7VjSbZv3CjaeNTdaxKQ9hiz
 +qG1buXr1v5JegGslBGsbltmfXpojr3sUCA9YEVnb64hEYKCd1NDUGVFnexOo7SqzaFvwvd3xuO
 4y5qAT0dvuyX4lMCDxMCbQsbeaq+kgziWNu+eoHVvJyPR1cM9hMWJqCpwfyBvG9lhJ1UeVxDvVO
 4berUYOzZzPCt+0QjRBBU8D3tZyP08IHJyJwiEU38Ka4rjj8VSJH/UxuHExAetkyG3+lRaejGmc
 tdoJc=
X-Google-Smtp-Source: AGHT+IGuSj5eaRTOtp8H39cgIOEwOjlKBTxoOkDL14EIB3eSUX6NYmIajRuVAroexAbeEJgLgq+kOA==
X-Received: by 2002:a05:620a:4416:b0:84f:110c:b6e8 with SMTP id
 af79cd13be357-8b257f52229mr115473185a.68.1762552229266; 
 Fri, 07 Nov 2025 13:50:29 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580c7f9sm496607085a.44.2025.11.07.13.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:50:28 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 4/4] dts: add virtio forwarding test suite
Date: Fri,  7 Nov 2025 16:50:18 -0500
Message-ID: <20251107215020.255182-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107215020.255182-1-dmarx@iol.unh.edu>
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_virtio_fwd.py          | 197 +++++++++++++++++++++
 2 files changed, 205 insertions(+)
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
index 0000000000..bdecdb76fd
--- /dev/null
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -0,0 +1,197 @@
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
+from api.testpmd.config import PortTopology, SimpleForwardingModes
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
+    @requires(topology_type=LinkTopology.ONE_LINK)
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
+
+        Verify:
+            * Vhost session receives/forwards 100+ packets.
+        """
+        self.sut_node = self._ctx.sut_node
+        if not isinstance(self.sut_node.main_session, LinuxSession):
+            verify(False, "Must be running on a Linux environment.")
+        # delete tap0 interface if it exists
+        self.sut_node.main_session.delete_interface(name="tap0")
+        with TestPmd(
+            prefix="virtio",
+            vdevs=[VirtualDevice("virtio_user0,path=/dev/vhost-net,queues=1,queue_size=1024")],
+            port_topology=PortTopology.chained,
+        ) as virtio:
+            self.sut_node.main_session.set_interface_link_up(name="tap0")
+            with TestPmd(
+                prefix="vhost",
+                no_pci=True,
+                vdevs=[VirtualDevice("net_af_packet0,iface=tap0")],
+                port_topology=PortTopology.loop,
+            ) as vhost:
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+
+                portlist_order = [0, 2, 1] if len(virtio.ports) == 3 else [0, 1]
+                virtio.set_portlist(order=portlist_order)
+
+                vhost.start()
+                virtio.start()
+
+                packet = Ether() / IP()
+                packets = [packet] * 100
+                send_packets_and_capture(packets)
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
-- 
2.51.0

