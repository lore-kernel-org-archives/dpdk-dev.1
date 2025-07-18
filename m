Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18874C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5725040A73;
	Fri, 18 Jul 2025 17:04:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F12C44021F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:04:45 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ABE816A3;
 Fri, 18 Jul 2025 08:04:38 -0700 (PDT)
Received: from e132991.arm.com (unknown [10.57.84.73])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9F5E3F6A8;
 Fri, 18 Jul 2025 08:04:43 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [RFC PATCH v3 0/2] dts: add RSS functions and test suite
Date: Fri, 18 Jul 2025 16:03:59 +0100
Message-ID: <20250718150404.200096-1-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225153345.331216-1-thomas.wilks@arm.com>
References: <20250225153345.331216-1-thomas.wilks@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is v3 of the RSS test suites which has been rebased onto the latest patches. 
I’m also requesting comments and some help with an issue where the packet RSS queue and 
the predicted RSS queue differ when running on ConnectX-6 NICs while being the same on E810-C NICs.
I’m currently in the process of refactoring the test suites and addressing 
the review comments from v2. Below is a summary of the changes made so far that are included in this version:

Changes in v3:
- Merged the RSS test suites into a single file for better maintainability.
- Moved the supporting functions into the same test suite file and removed the previous separate function file.
- Combined the reta_key_reta_queues test cases into a single test case.
- Added new test cases to support flow rule creation on ConnectX-6 NICs.
- Removed requirements for specific hashing algorithms which has been replaced the flow_validate function.

Regards,
Thomas Wilks

Alex Chapman (1):
  dts: add RSS functions to testpmd

Thomas Wilks (1):
  dts: add PMD RSS testsuite

 dts/framework/remote_session/testpmd_shell.py | 132 +++-
 dts/tests/TestSuite_pmd_rss.py                | 610 ++++++++++++++++++
 2 files changed, 729 insertions(+), 13 deletions(-)
 create mode 100644 dts/tests/TestSuite_pmd_rss.py

-- 
2.43.0

