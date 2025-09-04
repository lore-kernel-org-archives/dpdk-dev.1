Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F697CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A19A40697;
	Thu,  4 Sep 2025 13:47:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 27F8640280
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:10 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332491756;
 Thu,  4 Sep 2025 04:47:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1761D3F6A8;
 Thu,  4 Sep 2025 04:47:08 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
	Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 0/7] dts: add file manager
Date: Thu,  4 Sep 2025 12:45:00 +0100
Message-ID: <20250904114653.199080-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725151503.87374-1-luca.vizzarro@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
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

sending v2 for the file manager:

v2:
- resolved log splitting by explicitly set the custom log files in the
  test run states
- updated CaptureTrafficGenerator to use Artifacts to store the received
  packets

Best,
Luca

Luca Vizzarro (7):
  dts: merge RemoteSession class
  dts: add node retriever by identifier
  dts: add current test suite and cases to context
  dts: add artifact module
  dts: make log files into artifacts
  dts: use artifacts in packet capture and softnic
  dts: save received packets with artifacts

 doc/api/dts/framework.remote_session.rst      |   1 -
 .../framework.remote_session.ssh_session.rst  |   8 -
 .../dts/framework.testbed_model.artifact.rst  |   8 +
 doc/api/dts/framework.testbed_model.rst       |   1 +
 dts/framework/context.py                      |   7 +-
 dts/framework/logger.py                       | 126 ++--
 dts/framework/remote_session/__init__.py      |   3 +-
 .../remote_session/remote_session.py          | 110 ++-
 dts/framework/remote_session/ssh_session.py   | 116 ----
 dts/framework/runner.py                       |   5 +-
 dts/framework/test_run.py                     |  36 +-
 dts/framework/testbed_model/artifact.py       | 628 ++++++++++++++++++
 dts/framework/testbed_model/node.py           |  38 ++
 dts/framework/testbed_model/topology.py       |   8 +-
 .../capturing_traffic_generator.py            |   9 +-
 dts/tests/TestSuite_packet_capture.py         |  73 +-
 dts/tests/TestSuite_softnic.py                |  95 ++-
 17 files changed, 927 insertions(+), 345 deletions(-)
 delete mode 100644 doc/api/dts/framework.remote_session.ssh_session.rst
 create mode 100644 doc/api/dts/framework.testbed_model.artifact.rst
 delete mode 100644 dts/framework/remote_session/ssh_session.py
 create mode 100644 dts/framework/testbed_model/artifact.py

-- 
2.43.0

