Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B8C282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B01402ED;
	Mon,  3 Mar 2025 15:57:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 005A3402DF
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:21 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FD7106F;
 Mon,  3 Mar 2025 06:57:35 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A23543F66E;
 Mon,  3 Mar 2025 06:57:20 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 3/7] dts: fix smoke tests docstring
Date: Mon,  3 Mar 2025 16:57:05 +0200
Message-ID: <20250303145709.126126-4-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Sphinx autodoc complains of is_blocking being duplicated. This is the
case as the parent already holds a docstring for this attribute. Remove
the duplication.

Fixes: 6ef07151aac4 ("dts: update docstrings")

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/tests/TestSuite_smoke_tests.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index a8ea07595f..0474b82bd2 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -30,8 +30,6 @@ class TestSmokeTests(TestSuite):
     The infrastructure also needs to be tested, as that is also used by all other test suites.
 
     Attributes:
-        is_blocking: This test suite will block the execution of all other test suites
-            in the test run after it.
         nics_in_node: The NICs present on the SUT node.
     """
 
-- 
2.43.0

