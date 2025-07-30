Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE6C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 12:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F7D3402C3;
	Wed, 30 Jul 2025 14:59:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C4B66402A7
 for <dev@dpdk.org>; Wed, 30 Jul 2025 14:59:17 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38A081E5E;
 Wed, 30 Jul 2025 05:59:09 -0700 (PDT)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 379693F66E;
 Wed, 30 Jul 2025 05:59:16 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Ivan Malov <ivan.malov@arknetworks.am>, Dean Marx <dmarx@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v4 0/2] dts: add RSS functions and test suite
Date: Wed, 30 Jul 2025 13:58:57 +0100
Message-ID: <20250730125859.159185-1-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718150404.200096-1-thomas.wilks@arm.com>
References: <20250718150404.200096-1-thomas.wilks@arm.com>
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

Hi all,

This is v4 of the RSS test suites which addresses the issues with running the hashing algorithm 
test cases on ConnectX nics. The patches have also been rebased onto the latest upstream changes. 

Also thank you for your help and feedback with my previous RFC patch.

Changes in v4:
- Merged the RSS hashing algorithms tests into a single test case.
- Resolved issues with packet RSS queues when being ran on ConnectX nics.
- Updated doc strings to better reflect the test suites functionality.
- Moved RETA configuration into a dedicated function.

Regards,
Thomas Wilks

Alex Chapman (1):
  dts: add RSS functions to testpmd

Thomas Wilks (1):
  dts: add PMD RSS testsuite

 dts/framework/remote_session/testpmd_shell.py | 104 ++++-
 dts/tests/TestSuite_pmd_rss.py                | 383 ++++++++++++++++++
 2 files changed, 480 insertions(+), 7 deletions(-)
 create mode 100644 dts/tests/TestSuite_pmd_rss.py

-- 
2.43.0

