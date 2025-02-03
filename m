Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E041EC02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 15:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0255740270;
	Mon,  3 Feb 2025 16:17:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0F4EA40264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 16:17:45 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A339911FB;
 Mon,  3 Feb 2025 07:18:08 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C09183F63F;
 Mon,  3 Feb 2025 07:17:43 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC PATCH 0/7] dts: revamp framework
Date: Mon,  3 Feb 2025 15:16:05 +0000
Message-ID: <20250203151613.2436570-1-luca.vizzarro@arm.com>
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

This series enables the topology configuration and implements it in the
framework. Moreover, it performs quite a few refactors and a change on
how the test suites operate through the use of a Context. Finally, the
runtime internals are now isolated under the new TestRun and are further
reworked into a finite state machine for ease of handling.

Mind that unfortunately these commits may be breaking in intermediate
steps. Due to the amount of work done in one go, it was rather difficult
to have individually working commits.

I am currently requesting for comments on how we can improve this
further. In the meantime, I am going to remove node discrimination (TG
vs SUT) in the nodes configuration and allow the test run to define the
TG and SUT configurations.

I understand this is a lot of changes so please bear with me, I may have
missed some documentation changes, or even added proper documentation in
some instances. Please do point everything out.

Best,
Luca

Luca Vizzarro (7):
  dts: add port topology configuration
  dts: isolate test specification to config
  dts: revamp Topology model
  dts: improve Port model
  dts: add runtime status
  dts: add global runtime context
  dts: revamp runtime internals

 doc/api/dts/framework.context.rst             |   8 +
 doc/api/dts/framework.status.rst              |   8 +
 doc/api/dts/framework.test_run.rst            |   8 +
 doc/api/dts/index.rst                         |   3 +
 doc/guides/conf.py                            |   3 +-
 dts/framework/config/__init__.py              | 138 +++--
 dts/framework/config/node.py                  |  25 +-
 dts/framework/config/test_run.py              | 144 +++++-
 dts/framework/context.py                      | 107 ++++
 dts/framework/exception.py                    |  33 +-
 dts/framework/logger.py                       |  36 +-
 dts/framework/remote_session/dpdk_shell.py    |  53 +-
 .../single_active_interactive_shell.py        |  14 +-
 dts/framework/remote_session/testpmd_shell.py |  27 +-
 dts/framework/runner.py                       | 485 +-----------------
 dts/framework/status.py                       |  64 +++
 dts/framework/test_result.py                  | 136 +----
 dts/framework/test_run.py                     | 443 ++++++++++++++++
 dts/framework/test_suite.py                   |  73 ++-
 dts/framework/testbed_model/capability.py     |  42 +-
 dts/framework/testbed_model/linux_session.py  |  47 +-
 dts/framework/testbed_model/node.py           |  29 +-
 dts/framework/testbed_model/os_session.py     |  16 +-
 dts/framework/testbed_model/port.py           |  97 ++--
 dts/framework/testbed_model/sut_node.py       |  50 +-
 dts/framework/testbed_model/tg_node.py        |  30 +-
 dts/framework/testbed_model/topology.py       | 165 +++---
 dts/framework/utils.py                        |   8 +-
 dts/nodes.example.yaml                        |  24 +-
 dts/test_runs.example.yaml                    |   3 +
 dts/tests/TestSuite_blocklist.py              |   6 +-
 dts/tests/TestSuite_checksum_offload.py       |  14 +-
 dts/tests/TestSuite_dual_vlan.py              |   6 +-
 dts/tests/TestSuite_dynamic_config.py         |   8 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |   1 -
 dts/tests/TestSuite_hello_world.py            |   2 +-
 dts/tests/TestSuite_l2fwd.py                  |   9 +-
 dts/tests/TestSuite_mac_filter.py             |  10 +-
 dts/tests/TestSuite_mtu.py                    |  17 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   9 +-
 ...stSuite_port_restart_config_persistency.py |   8 +-
 dts/tests/TestSuite_promisc_support.py        |   8 +-
 dts/tests/TestSuite_smoke_tests.py            |   3 +-
 dts/tests/TestSuite_softnic.py                |   4 +-
 dts/tests/TestSuite_uni_pkt.py                |  14 +-
 dts/tests/TestSuite_vlan.py                   |   8 +-
 46 files changed, 1287 insertions(+), 1159 deletions(-)
 create mode 100644 doc/api/dts/framework.context.rst
 create mode 100644 doc/api/dts/framework.status.rst
 create mode 100644 doc/api/dts/framework.test_run.rst
 create mode 100644 dts/framework/context.py
 create mode 100644 dts/framework/status.py
 create mode 100644 dts/framework/test_run.py

-- 
2.43.0

