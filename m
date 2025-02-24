Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59582C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7549240E7C;
	Mon, 24 Feb 2025 14:30:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9316340E44
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:07 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C5101477;
 Mon, 24 Feb 2025 05:30:23 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CA1C3F5A1;
 Mon, 24 Feb 2025 05:30:05 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH 0/6] dts: add build-less driver binding
Date: Mon, 24 Feb 2025 13:28:17 +0000
Message-ID: <20250224132823.196509-1-luca.vizzarro@arm.com>
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

Hi there,

sending in a solution that could enable DTS to bind drivers for
DPDK-based apps, like traffic generators, that lack the DPDK build to
gather dpdk-devbind.py from.

Best,
Luca

Luca Vizzarro (6):
  dts: ensure runtime working directory
  dts: use topology in smoke tests
  dts: add tmp directory facility
  dts: decouple DPDK runtime from build
  dts: enable build-less DPDK driver binding
  dts: restore TG setup and teardown

 dts/framework/context.py                      |  3 +-
 dts/framework/remote_session/dpdk.py          | 49 +++++++++++++++----
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 dts/framework/test_run.py                     | 12 ++++-
 dts/framework/testbed_model/node.py           | 31 +++++++++++-
 dts/framework/testbed_model/os_session.py     | 12 +++++
 dts/framework/testbed_model/posix_session.py  |  5 ++
 .../traffic_generator/traffic_generator.py    |  2 +-
 dts/main.py                                   |  6 +++
 dts/tests/TestSuite_smoke_tests.py            |  4 +-
 dts/tests/TestSuite_softnic.py                |  2 +-
 11 files changed, 109 insertions(+), 19 deletions(-)

-- 
2.43.0

