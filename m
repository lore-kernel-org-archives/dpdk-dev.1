Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3563BC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 14:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19F3B40EF0;
	Wed, 19 Feb 2025 15:36:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0B2AD40E6E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 15:35:59 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C760313D5;
 Wed, 19 Feb 2025 06:36:17 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.26.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFC3E3F59E;
 Wed, 19 Feb 2025 06:35:58 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: grab linter return value
Date: Tue, 18 Feb 2025 23:07:46 +0000
Message-ID: <20250218230746.1281585-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
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

In dts-check-format we were checking if the linter was updating the
tree, but we were not picking up the return value in case an unfixable
error would be raised.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 devtools/dts-check-format.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.sh
index 44501f6d3b..907eed1293 100755
--- a/devtools/dts-check-format.sh
+++ b/devtools/dts-check-format.sh
@@ -84,6 +84,7 @@ if $lint; then
 	heading "Linting in $directory/"
 	if command -v ruff > /dev/null; then
 		ruff check --fix
+		errors=$((errors + $?))
 
 		git update-index --refresh
 		retval=$?
-- 
2.43.0

