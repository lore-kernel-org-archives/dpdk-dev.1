Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2054CC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FF9E40652;
	Tue,  6 May 2025 15:31:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 49D2B4042E
 for <dev@dpdk.org>; Tue,  6 May 2025 15:31:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD51113E;
 Tue,  6 May 2025 06:31:01 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.25.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B28E73F5A1;
 Tue,  6 May 2025 06:31:10 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Wilks <thomas.wilks@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Dean Marx <dmarx@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 1/3] dts: import lldp package in scapy
Date: Tue,  6 May 2025 14:29:31 +0100
Message-ID: <20250506132933.1580584-2-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506132933.1580584-1-luca.vizzarro@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250506132933.1580584-1-luca.vizzarro@arm.com>
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

From: Thomas Wilks <thomas.wilks@arm.com>

Add import for lldp scapy package to enable lldp packet
creation and handling.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/traffic_generator/scapy.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index aed0b76108..76f8496bf8 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -328,6 +328,7 @@ def setup(self, ports: Iterable[Port], rx_port: Port):
         self._shell = PythonShell(self._tg_node, "scapy", privileged=True)
         self._shell.start_application()
         self._shell.send_command("from scapy.all import *")
+        self._shell.send_command("from scapy.contrib.lldp import *")
 
     def close(self):
         """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
-- 
2.43.0

