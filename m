Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C4C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 15:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9E8B402A8;
	Fri, 25 Jul 2025 17:15:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 745AB400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 17:15:10 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA032176C;
 Fri, 25 Jul 2025 08:15:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.3.207])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0666E3F66E;
 Fri, 25 Jul 2025 08:15:08 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
	Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 0/6] dts: add file management
Date: Fri, 25 Jul 2025 16:11:35 +0100
Message-ID: <20250725151503.87374-1-luca.vizzarro@arm.com>
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

Hello everyone,

I am sending in a new major feature for DTS. This would introduce a
unified and abstracted way to handle files in DTS. Everything is handled
directly through the Artifact class, which provides several file-related
methods, including a standard file object interface for file RW
operations.

Kind regards,
Luca

Luca Vizzarro (6):
  dts: merge RemoteSession class
  dts: add node retriever by identifier
  dts: add current test suite and cases to context
  dts: add artifact module
  dts: make log files into artifacts
  dts: use artifacts in packet capture and softnic

 doc/api/dts/framework.remote_session.rst      |   1 -
 .../framework.remote_session.ssh_session.rst  |   8 -
 .../dts/framework.testbed_model.artifact.rst  |   8 +
 doc/api/dts/framework.testbed_model.rst       |   1 +
 dts/framework/context.py                      |   7 +-
 dts/framework/logger.py                       | 113 ++--
 dts/framework/remote_session/__init__.py      |   3 +-
 .../remote_session/remote_session.py          | 110 ++-
 dts/framework/remote_session/ssh_session.py   | 116 ----
 dts/framework/runner.py                       |   5 +-
 dts/framework/test_run.py                     |  20 +-
 dts/framework/testbed_model/artifact.py       | 628 ++++++++++++++++++
 dts/framework/testbed_model/node.py           |  38 ++
 dts/framework/testbed_model/topology.py       |   8 +-
 dts/tests/TestSuite_packet_capture.py         |  73 +-
 dts/tests/TestSuite_softnic.py                |  95 ++-
 16 files changed, 908 insertions(+), 326 deletions(-)
 delete mode 100644 doc/api/dts/framework.remote_session.ssh_session.rst
 create mode 100644 doc/api/dts/framework.testbed_model.artifact.rst
 delete mode 100644 dts/framework/remote_session/ssh_session.py
 create mode 100644 dts/framework/testbed_model/artifact.py

-- 
2.43.0

