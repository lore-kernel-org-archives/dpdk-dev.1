Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050AC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F76940299;
	Tue, 25 Feb 2025 16:34:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D46B840299
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:34:10 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8201BCB;
 Tue, 25 Feb 2025 07:34:26 -0800 (PST)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF6F73F5A1;
 Tue, 25 Feb 2025 07:34:08 -0800 (PST)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v2 0/6] Added RSS functions and tests. 
Date: Tue, 25 Feb 2025 15:33:39 +0000
Message-ID: <20250225153345.331216-1-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829125020.34341-1-alex.chapman@arm.com>
References: <20240829125020.34341-1-alex.chapman@arm.com>
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

v2:
- Added RSS capabilities check.
- Added testsuite that tests RSS hashes.
- Added testsuite that tests updating the RSS hash key.
- Added testsuite that verifies the RETA size.


Alex Chapman (5):
  dts: add RSS functions to testpmd
  dts: add utils for PMD RSS testsuites
  dts: add PMD RSS hash testsuite
  dts: add PMD RSS RETA testsuite
  dts: add PMD RSS key update testsuite

Thomas Wilks (1):
  dts: add NIC capabilities for hash algorithms

 dts/framework/remote_session/testpmd_shell.py | 283 +++++++++++++++++-
 dts/tests/TestSuite_pmd_rss_hash.py           | 121 ++++++++
 dts/tests/TestSuite_pmd_rss_key_update.py     | 168 +++++++++++
 dts/tests/TestSuite_pmd_rss_reta.py           | 101 +++++++
 dts/tests/pmd_rss_utils.py                    | 195 ++++++++++++
 5 files changed, 854 insertions(+), 14 deletions(-)
 create mode 100644 dts/tests/TestSuite_pmd_rss_hash.py
 create mode 100644 dts/tests/TestSuite_pmd_rss_key_update.py
 create mode 100644 dts/tests/TestSuite_pmd_rss_reta.py
 create mode 100644 dts/tests/pmd_rss_utils.py

-- 
2.43.0

