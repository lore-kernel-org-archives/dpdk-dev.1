Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAFCC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00D6C427E8;
	Wed, 12 Feb 2025 17:45:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D240942707
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:45:29 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04DB312FC;
 Wed, 12 Feb 2025 08:45:50 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 342F03F5A1;
 Wed, 12 Feb 2025 08:45:28 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v2 0/7] dts: revamp framework
Date: Wed, 12 Feb 2025 16:45:17 +0000
Message-ID: <20250212164524.23615-1-luca.vizzarro@arm.com>
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

sending some more final code, hence dropping the RFC.

v2:
- applied suggested changes to the port topology config
- re-implemented FSM from a generator function to a more traditional
  approach where each state is actually is self-contained in its own
  class.
- dropped the status enums (as a consequence of the above)
- fixed some docstrings

Best,
Luca

Luca Vizzarro (7):
  dts: add port topology configuration
  dts: isolate test specification to config
  dts: revamp Topology model
  dts: improve Port model
  dts: add global runtime context
  dts: revamp runtime internals
  dts: remove node distinction

 doc/api/dts/framework.context.rst             |   8 +
 doc/api/dts/framework.remote_session.dpdk.rst |   8 +
 doc/api/dts/framework.remote_session.rst      |   1 +
 doc/api/dts/framework.test_run.rst            |   8 +
 doc/api/dts/index.rst                         |   2 +
 doc/guides/conf.py                            |   3 +-
 dts/framework/config/__init__.py              | 138 ++--
 dts/framework/config/node.py                  |  96 +--
 dts/framework/config/test_run.py              | 214 +++++-
 dts/framework/context.py                      | 120 ++++
 dts/framework/exception.py                    |  33 +-
 dts/framework/logger.py                       |  26 +-
 .../sut_node.py => remote_session/dpdk.py}    | 462 ++++++-------
 dts/framework/remote_session/dpdk_shell.py    |  59 +-
 .../single_active_interactive_shell.py        |  12 +-
 dts/framework/remote_session/testpmd_shell.py |  27 +-
 dts/framework/runner.py                       | 547 +--------------
 dts/framework/test_result.py                  | 138 +---
 dts/framework/test_run.py                     | 641 ++++++++++++++++++
 dts/framework/test_suite.py                   |  80 ++-
 dts/framework/testbed_model/capability.py     |  70 +-
 dts/framework/testbed_model/linux_session.py  |  47 +-
 dts/framework/testbed_model/node.py           | 100 +--
 dts/framework/testbed_model/os_session.py     |  16 +-
 dts/framework/testbed_model/port.py           |  97 ++-
 dts/framework/testbed_model/tg_node.py        | 105 ---
 dts/framework/testbed_model/topology.py       | 165 ++---
 .../traffic_generator/__init__.py             |   8 +-
 .../testbed_model/traffic_generator/scapy.py  |  12 +-
 .../traffic_generator/traffic_generator.py    |   9 +-
 dts/framework/utils.py                        |   8 +-
 dts/nodes.example.yaml                        |  24 +-
 dts/test_runs.example.yaml                    |   4 +
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
 dts/tests/TestSuite_smoke_tests.py            |   9 +-
 dts/tests/TestSuite_softnic.py                |   6 +-
 dts/tests/TestSuite_uni_pkt.py                |  14 +-
 dts/tests/TestSuite_vlan.py                   |   8 +-
 49 files changed, 1726 insertions(+), 1697 deletions(-)
 create mode 100644 doc/api/dts/framework.context.rst
 create mode 100644 doc/api/dts/framework.remote_session.dpdk.rst
 create mode 100644 doc/api/dts/framework.test_run.rst
 create mode 100644 dts/framework/context.py
 rename dts/framework/{testbed_model/sut_node.py => remote_session/dpdk.py} (59%)
 create mode 100644 dts/framework/test_run.py
 delete mode 100644 dts/framework/testbed_model/tg_node.py

-- 
2.43.0

