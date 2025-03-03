Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76CC282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6510540611;
	Mon,  3 Mar 2025 15:57:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F1CB2402E4
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:22 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8919E113E;
 Mon,  3 Mar 2025 06:57:36 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9D573F66E;
 Mon,  3 Mar 2025 06:57:21 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 4/7] dts: update autodoc sorting order
Date: Mon,  3 Mar 2025 16:57:06 +0200
Message-ID: <20250303145709.126126-5-Luca.Vizzarro@arm.com>
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

The autodoc member sorting order default is set to alphabetical, which
translates to autodoc sorting every member in modules, classes etc.
This also brings some side effects, like sorting capabilities which
can't be compared and result in errors.

This change prevents autodoc from sorting, and keeping the order as the
developer intended it.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/guides/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index da139df1bd..565f5705d8 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -87,6 +87,7 @@
     autodoc_typehints = 'both'
     autodoc_typehints_format = 'short'
     autodoc_typehints_description_target = 'documented'
+    autodoc_member_order = 'bysource'
 
     # DTS docstring options.
     add_module_names = False
-- 
2.43.0

