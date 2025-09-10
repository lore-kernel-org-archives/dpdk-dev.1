Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC577CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1124F4065D;
	Wed, 10 Sep 2025 21:31:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D0BCC40653
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:31:53 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C0A328E;
 Wed, 10 Sep 2025 12:31:44 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.66.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E79853F694;
 Wed, 10 Sep 2025 12:31:52 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v5 0/2] dts: add RSS functions and test suite
Date: Wed, 10 Sep 2025 20:31:47 +0100
Message-Id: <20250910193149.1023435-1-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730125859.159185-1-thomas.wilks@arm.com>
References: <20250730125859.159185-1-thomas.wilks@arm.com>
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

This patch series adds the required functionality for the RSS functions
and test suite.

v5:
- added preset RETA configurations as per review
- rebased onto latest upstream

Alex Chapman (1):
  dts: add RSS functions to testpmd

Thomas Wilks (1):
  dts: add PMD RSS testsuite

 dts/api/testpmd/__init__.py    |  91 +++++++-
 dts/api/testpmd/types.py       |  12 +-
 dts/tests/TestSuite_pmd_rss.py | 396 +++++++++++++++++++++++++++++++++
 3 files changed, 494 insertions(+), 5 deletions(-)
 create mode 100644 dts/tests/TestSuite_pmd_rss.py

--
2.39.5

