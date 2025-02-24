Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD988C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6219740EF1;
	Mon, 24 Feb 2025 14:30:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 42C4740E44
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:08 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F701CE0;
 Mon, 24 Feb 2025 05:30:24 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0AC53F5A1;
 Mon, 24 Feb 2025 05:30:06 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 1/6] dts: ensure runtime working directory
Date: Mon, 24 Feb 2025 13:28:18 +0000
Message-ID: <20250224132823.196509-2-luca.vizzarro@arm.com>
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

After loading the user's settings and supplied configuration files, make
the dts folder the working directory for the runner.

This allows DTS to easily access the local DPDK tree.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/main.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dts/main.py b/dts/main.py
index fa878cc16e..5de65c8a50 100755
--- a/dts/main.py
+++ b/dts/main.py
@@ -3,9 +3,12 @@
 # Copyright(c) 2010-2014 Intel Corporation
 # Copyright(c) 2022 PANTHEON.tech s.r.o.
 # Copyright(c) 2022 University of New Hampshire
+# Copyright(c) 2025 Arm Limited
 
 """The DTS executable."""
 
+import os
+
 from framework import settings
 
 
@@ -23,6 +26,9 @@ def main() -> None:
     from framework.runner import DTSRunner
 
     dts = DTSRunner()
+
+    # After loading up, make the dts folder the current working directory.
+    os.chdir(os.path.dirname(os.path.abspath(__file__)))
     dts.run()
 
 
-- 
2.43.0

