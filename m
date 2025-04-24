Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FDC369D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 01:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6644042C;
	Thu, 24 Apr 2025 03:48:50 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id DA5CB402DD
 for <dev@dpdk.org>; Thu, 24 Apr 2025 03:48:48 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4774d68c670so8062621cf.0
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745459328; x=1746064128; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94ygF2I+Qrcmwer1JaDzFO4zFZh5JNLF+OCxHk2t91c=;
 b=C1O4aqTROyCLqfGVUlQEvYzwlGJ4yKOrK2PDJsAlCStL+GTq3uMg8ynZLC/LGQTuwp
 SA3uNWNa9XTfKWHieWSE4Zz1Lg/2prRO7NwVmY5qbYsWjzQooQ+fcaG5dMGN8FMm/TrU
 plcCN5La8qejBFiA9jJq5Vt8zPd+iNWfJ1hXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745459328; x=1746064128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94ygF2I+Qrcmwer1JaDzFO4zFZh5JNLF+OCxHk2t91c=;
 b=QkKj1MRFGZt5Dej7QP97RlBFNSkMkXq+nIt813+61US5qV+ARI8XBVXocZStnS2YRG
 2LbE/Fqj2+qtvwbdCZP4t8+UUpL5cNHXgustkZ0DdMEe4pe/bzL1BETgGZxYlSRw7K5k
 7s+O+mqCfr4c021e+tW1WBXSFgKXomKzwRf5KoaVxFZ2FOyE/w4lPWtUGtlHwbQplZEU
 QM+v23pQAEZKqZrneVdlsRZ46RJ0YKBmoRHtqhltr4JBRmLb/GG935ABCY9ppj9FzuIw
 bCjwSPUZb0AVxFdqmLCqvrImHxFStR4Iip1TTpuAWGFnCBei9N/wnoOaETpHNcHwHEyl
 MgAg==
X-Gm-Message-State: AOJu0YzBzpHcBXlNCj6tjm/JOgbxUCVctHpgBj16XuNMcBWryfcaW/Fn
 SlrKgppthbQTXEQ9ZiidSzbK4bV75OQtSpS7ufHc2HKo7cJWj07PMCm9gMYW4r0=
X-Gm-Gg: ASbGnct2JU0RcAuUExpQ1NeyxbawKYcr1OZsSnqNJzayJc7trwK9tYJEvBSb4FkCn7f
 EIjW48iUOzvNMToT8Y1eZeRdaTvZkcdAk9QwRmF2E8xoqVFjw+ZAFlRNVwFRhjRBrfJedOAUIP3
 k1Zr85QVWT6sZT2prZVvTqwHN9r2c6YT7Mq4cQ4hJ9FONVG15oFz6//vd5n6oXZb7aBMJlh+foC
 sSgWVPMooPMJKQx+j2e+ctlS8xCuIf/fqqG8QL1dIjhihMWfht0oBlVTRDbRLaRS6X+9Etv04Nm
 bJ5jPTUFfC09xX/rB/uUfdzz3TarvGRRVxsa/+FQCdT6bQNzAzZLynO+JQVbrsJrLYpXouRKvLG
 4MtJ8Ug==
X-Google-Smtp-Source: AGHT+IFJMPtIIYVQ/D/4LIODuz66x770MhBTihMKgz+rM4FcMPxdXvkYxaEMk2nWO3mlAwp6DJucFw==
X-Received: by 2002:ac8:5a04:0:b0:477:6f1f:e1d6 with SMTP id
 d75a77b69052e-47eb28a0ffamr11239621cf.3.1745459328176; 
 Wed, 23 Apr 2025 18:48:48 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea1ba2868sm4317411cf.74.2025.04.23.18.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:48:47 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 thomas.wilks@arm.com, dmarx@iol.unh.edu,
 Jeremy Spewock <jspewock@iol.unh.edu>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 2/2] dts: add port control testing suite
Date: Wed, 23 Apr 2025 21:44:12 -0400
Message-ID: <20250424014412.3849896-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424014412.3849896-1-probb@iol.unh.edu>
References: <20240814182005.12251-1-jspewock@iol.unh.edu>
 <20250424014412.3849896-1-probb@iol.unh.edu>
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

From: Jeremy Spewock <jspewock@iol.unh.edu>

This patch ports over the port_control test suite from the legacy
framework and adapts the functionality to fit with the current testing
framework. The test suite provides validation of basic port control
functions such as starting, stopping, and closing ports. It should
be noted that this test suite is not completely 1-to-1 with the one
from Old DTS as it does exclude test cases that use QEMU for testing as
this is not something we are looking to add to the framework in the
near future. It also excludes test cases for resetting ports as this
feature is something that is not supported by all devices and does not
expose a capability regarding if it is through testpmd.

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/config/conf_yaml_schema.json |   0
 dts/tests/TestSuite_port_control.py        | 105 +++++++++++++++++++++
 2 files changed, 105 insertions(+)
 delete mode 100644 dts/framework/config/conf_yaml_schema.json
 create mode 100644 dts/tests/TestSuite_port_control.py

diff --git a/dts/framework/config/conf_yaml_schema.json b/dts/framework/config/conf_yaml_schema.json
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
new file mode 100644
index 0000000000..a6a694dcbe
--- /dev/null
+++ b/dts/tests/TestSuite_port_control.py
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 University of New Hampshire
+"""Port Control Testing Suite.
+
+This test suite serves to show that ports within testpmd support basic configuration functions.
+Things such as starting a port, stopping a port, and closing a port should all be supported by the
+device. Additionally, after each of these configuration steps (outside of closing the port) it
+should still be possible to start the port again and verify that the port is able to forward a
+large amount of packets (100 are sent in the test cases).
+"""
+
+from scapy.layers.l2 import Ether
+from scapy.packet import Packet, Raw
+
+from framework.params.testpmd import SimpleForwardingModes
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.test_suite import TestSuite, func_test
+
+
+class TestPortControl(TestSuite):
+    """DPDK Port Control Testing Suite."""
+
+    def send_packets_and_verify(self) -> None:
+        """Send 100 packets and verify that all packets were forwarded back.
+
+        Packets sent are identical and are all ethernet frames with a payload of 30 "X" characters.
+        This payload is used to differentiate noise on the wire from packets sent by this
+        framework.
+        """
+        payload = ("X" * 30)
+        num_pakts = 100
+        send_p = Ether() / Raw(payload.encode("utf-8"))
+        recv_pakts: list[Packet] = []
+        for _ in range(int(num_pakts / 25)):
+            recv_pakts += self.send_packets_and_capture([send_p] * 25)
+        recv_pakts += self.send_packets_and_capture([send_p] * (num_pakts % 25))
+        recv_pakts = [
+            p
+            for p in recv_pakts
+            if
+            (
+                # Remove padding from the bytes.
+                hasattr(p, "load") and p.load.decode("utf-8").replace("\x00", "") == payload
+            )
+        ]
+        self.verify(
+            len(recv_pakts) == num_pakts,
+            f"Received {len(recv_pakts)} packets when {num_pakts} were expected.",
+        )
+
+    @func_test
+    def test_start_ports(self) -> None:
+        """Start all ports and send a small number of packets.
+
+        Steps:
+            Start all ports
+            Start forwarding in MAC mode
+            Send 100 generic packets to the SUT
+
+        Verify:
+            Check that all the packets sent are sniffed on the TG receive port.
+        """
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+            testpmd.start_all_ports()
+            testpmd.start()
+            self.send_packets_and_verify()
+
+    @func_test
+    def test_stop_ports(self) -> None:
+        """Stop all ports, then start all ports, amd then send a small number of packets.
+
+        Steps:
+            Stop all ports
+            Start all ports
+            Start forwarding in MAC mode
+            Send 100 generic packets to the SUT
+
+        Verify:
+            Check that stopping the testpmd ports brings down their links
+            Check that all the packets sent are sniffed on the TG receive port.
+        """
+        with TestPmdShell(forward_mode=SimpleForwardingModes.mac) as testpmd:
+            testpmd.stop_all_ports()
+            self.verify(
+                all(not p.is_link_up for p in testpmd.show_port_info_all()),
+                "Failed to stop all ports.",
+            )
+            testpmd.start()
+            self.send_packets_and_verify()
+
+    @func_test
+    def test_close_ports(self) -> None:
+        """Close all the ports via testpmd.
+
+        Steps:
+            Close all the testpmd ports
+
+        Verify:
+            Check that testpmd no longer reports having any ports
+        """
+        with TestPmdShell() as testpmd:
+            testpmd.close_all_ports()
+            self.verify(
+                len(testpmd.show_port_info_all()) == 0, "Failed to close all ports in testpmd."
+            )
-- 
2.48.1

