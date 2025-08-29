Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E6BCA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 17:43:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 749E7402EB;
	Fri, 29 Aug 2025 19:43:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A8697402C1
 for <dev@dpdk.org>; Fri, 29 Aug 2025 19:43:27 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8576119F0;
 Fri, 29 Aug 2025 10:43:18 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.64.222])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71A0E3F738;
 Fri, 29 Aug 2025 10:43:26 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC 0/2] Split DTS framework and public API
Date: Fri, 29 Aug 2025 18:43:10 +0100
Message-Id: <20250829174312.2855311-1-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
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

The idea is to split off framework and public API. All calls in the tests
should go through the public API. This will allow us to change the
framework internals without breaking the tests and also to provide a
stable API for test writers.

More importantly this will make it easier to non DTS developers to write
tests by being able to more easily find the relevant functionality.

The first patch moves TestPmd related code to the public API. The second
patch updates all tests to use the new API. Further patches will move
more functionality to the public API.

Moving code required fixing some circular dependencies in the framework
and simplifying the capabilities code to allow selection through a
vanilla enum.

The functionality is otherwise unchanged.

Paul Szczepanek (2):
  dts: move testpmd into API
  dts: update tests to use new API

 doc/api/dts/api.capabilities.rst              |    8 +
 doc/api/dts/api.rst                           |   20 +
 ...stpmd_shell.rst => api.testpmd.config.rst} |    4 +-
 doc/api/dts/api.testpmd.rst                   |   15 +
 doc/api/dts/api.testpmd.types.rst             |    8 +
 doc/api/dts/framework.params.rst              |    1 -
 doc/api/dts/framework.params.testpmd.rst      |    8 -
 doc/api/dts/framework.remote_session.rst      |    1 -
 doc/api/dts/index.rst                         |    1 +
 dts/api/__init__.py                           |   14 +
 dts/api/capabilities.py                       |  180 ++
 dts/api/testpmd/__init__.py                   | 1294 ++++++++
 .../testpmd.py => api/testpmd/config.py}      |    9 +-
 dts/api/testpmd/types.py                      | 1406 ++++++++
 dts/framework/config/__init__.py              |    3 +-
 dts/framework/params/eal.py                   |   12 +-
 dts/framework/params/types.py                 |    4 +-
 dts/framework/remote_session/__init__.py      |   44 -
 dts/framework/remote_session/testpmd_shell.py | 2844 -----------------
 dts/framework/testbed_model/capability.py     |  144 +-
 dts/framework/testbed_model/linux_session.py  |    2 +-
 dts/framework/testbed_model/os_session.py     |   14 +-
 dts/framework/testbed_model/topology.py       |   30 +-
 dts/tests/TestSuite_blocklist.py              |   11 +-
 dts/tests/TestSuite_checksum_offload.py       |   44 +-
 dts/tests/TestSuite_dual_vlan.py              |   12 +-
 dts/tests/TestSuite_dynamic_config.py         |   27 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |   29 +-
 dts/tests/TestSuite_hello_world.py            |    4 +-
 dts/tests/TestSuite_l2fwd.py                  |   18 +-
 dts/tests/TestSuite_mac_filter.py             |   17 +-
 dts/tests/TestSuite_mtu.py                    |   19 +-
 dts/tests/TestSuite_packet_capture.py         |   14 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |   19 +-
 dts/tests/TestSuite_port_control.py           |   21 +-
 ...stSuite_port_restart_config_persistency.py |   14 +-
 dts/tests/TestSuite_port_stats.py             |   21 +-
 dts/tests/TestSuite_promisc_support.py        |   11 +-
 dts/tests/TestSuite_queue_start_stop.py       |   24 +-
 dts/tests/TestSuite_rte_flow.py               |   36 +-
 dts/tests/TestSuite_smoke_tests.py            |   11 +-
 dts/tests/TestSuite_softnic.py                |   18 +-
 dts/tests/TestSuite_uni_pkt.py                |   35 +-
 dts/tests/TestSuite_vlan.py                   |   26 +-
 44 files changed, 3333 insertions(+), 3164 deletions(-)
 create mode 100644 doc/api/dts/api.capabilities.rst
 create mode 100644 doc/api/dts/api.rst
 rename doc/api/dts/{framework.remote_session.testpmd_shell.rst =>
  api.testpmd.config.rst} (54%)
 create mode 100644 doc/api/dts/api.testpmd.rst
 create mode 100644 doc/api/dts/api.testpmd.types.rst
 delete mode 100644 doc/api/dts/framework.params.testpmd.rst
 create mode 100644 dts/api/__init__.py
 create mode 100644 dts/api/capabilities.py
 create mode 100644 dts/api/testpmd/__init__.py
 rename dts/{framework/params/testpmd.py => api/testpmd/config.py} (98%)
 create mode 100644 dts/api/testpmd/types.py
 delete mode 100644 dts/framework/remote_session/testpmd_shell.py

--
2.39.5

