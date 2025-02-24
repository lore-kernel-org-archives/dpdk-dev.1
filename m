Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89544C021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C823410DD;
	Mon, 24 Feb 2025 14:30:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 26E4A40EDC
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:09 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378961477;
 Mon, 24 Feb 2025 05:30:25 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEB373F5A1;
 Mon, 24 Feb 2025 05:30:07 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 2/6] dts: use topology in smoke tests
Date: Mon, 24 Feb 2025 13:28:19 +0000
Message-ID: <20250224132823.196509-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224132823.196509-1-luca.vizzarro@arm.com>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
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

The smoke tests where wrongly using all the node's ports for the smoke
tests. Ensure only the ports specified in the current topology are used.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_smoke_tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index a8ea07595f..cc24dd01f4 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -48,7 +48,7 @@ def set_up_suite(self) -> None:
         """
         self.sut_node = self._ctx.sut_node  # FIXME: accessing the context should be forbidden
         self.dpdk_build_dir_path = self._ctx.dpdk.build.remote_dpdk_build_dir
-        self.nics_in_node = self.sut_node.config.ports
+        self.nics_in_node = [p.config for p in self.topology.sut_ports]
 
     @func_test
     def test_unit_tests(self) -> None:
-- 
2.43.0

