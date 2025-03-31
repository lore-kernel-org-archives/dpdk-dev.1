Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29660C36010
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 15:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5FC406BC;
	Mon, 31 Mar 2025 17:58:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2A81240696
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:58:15 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17B1E1692;
 Mon, 31 Mar 2025 08:58:18 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.39.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 793133F63F;
 Mon, 31 Mar 2025 08:58:13 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH 2/2] dts: import lldp package in scapy
Date: Mon, 31 Mar 2025 16:58:00 +0100
Message-ID: <20250331155800.449823-3-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331155800.449823-1-thomas.wilks@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
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

Add import for lldp scapy package to enable lldp packet
creation and handling.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/testbed_model/traffic_generator/scapy.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 78a6ded74c..c7e8fc42e9 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -95,6 +95,7 @@ def setup(self, ports: Iterable[Port]):
         self._tg_node.main_session.bring_up_link(ports)
         self._shell.start_application()
         self._shell.send_command("from scapy.all import *")
+        self._shell.send_command("from scapy.contrib.lldp import *")
 
     def close(self):
         """Close traffic generator."""
-- 
2.43.0

