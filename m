Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B8C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E113D4066C;
	Fri, 27 Jun 2025 17:12:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4CB92400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:12:53 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5396528C7;
 Fri, 27 Jun 2025 08:12:35 -0700 (PDT)
Received: from e132991.arm.com (unknown [10.57.84.101])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83B663F66E;
 Fri, 27 Jun 2025 08:12:51 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH 1/2] dts: change test suite name property
Date: Fri, 27 Jun 2025 16:12:40 +0100
Message-ID: <20250627151241.335114-2-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627151241.335114-1-thomas.wilks@arm.com>
References: <20250627151241.335114-1-thomas.wilks@arm.com>
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

The test suite name property was previously returning the class name
instead of the way that test suite are actually named, e.g.
TestHelloWorld instead of hello_world.

This change rectifies this inconsistency.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/test_suite.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 145b79496f..d4e06a567a 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -110,8 +110,11 @@ def __init__(self, config: BaseConfig):
 
     @property
     def name(self) -> str:
-        """The name of the test suite class."""
-        return type(self).__name__
+        """The name of the test suite."""
+        module_prefix = (
+            f"{TestSuiteSpec.TEST_SUITES_PACKAGE_NAME}.{TestSuiteSpec.TEST_SUITE_MODULE_PREFIX}"
+        )
+        return type(self).__module__[len(module_prefix) :]
 
     @property
     def topology(self) -> Topology:
-- 
2.43.0

