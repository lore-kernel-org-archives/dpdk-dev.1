Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E57CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 15:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 017F240649;
	Wed, 10 Sep 2025 17:21:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id CF9BD402C2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 17:21:09 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA90B16F2;
 Wed, 10 Sep 2025 08:21:00 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.66.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 923A03F694;
 Wed, 10 Sep 2025 08:21:08 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v1 0/2]  Split DTS framework and public API
Date: Wed, 10 Sep 2025 16:21:01 +0100
Message-Id: <20250910152103.976383-1-paul.szczepanek@arm.com>
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

Split up framework and public API. All calls in the tests
should go through the public API. This will allow us to change the
framework internals without breaking the tests and also to provide a
stable and smaller API for test writers.

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
 doc/api/dts/api.testpmd.config.rst            |    8 +
 doc/api/dts/api.testpmd.rst                   |   15 +
 doc/api/dts/api.testpmd.types.rst             |    8 +
 doc/api/dts/framework.params.rst              |    1 -
 doc/api/dts/framework.params.testpmd.rst      |    8 -
 doc/api/dts/framework.remote_session.rst      |    1 -
 ...framework.remote_session.testpmd_shell.rst |    8 -
 doc/api/dts/index.rst                         |    1 +
 doc/guides/tools/dts.rst                      |    4 +-
 dts/api/__init__.py                           |   14 +
 dts/api/capabilities.py                       |  180 ++
 dts/api/testpmd/__init__.py                   | 1294 ++++++++
 .../testpmd.py => api/testpmd/config.py}      |    9 +-
 dts/api/testpmd/types.py                      | 1406 ++++++++
 dts/framework/config/__init__.py              |    3 +-
 dts/framework/params/eal.py                   |   12 +-
 dts/framework/params/types.py                 |    4 +-
 dts/framework/remote_session/__init__.py      |   43 -
 dts/framework/remote_session/testpmd_shell.py | 2844 -----------------
 dts/framework/testbed_model/capability.py     |  174 +-
 dts/framework/testbed_model/linux_session.py  |    2 +-
 dts/framework/testbed_model/os_session.py     |   13 +-
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
 ...stSuite_port_restart_config_persistency.py |   16 +-
 dts/tests/TestSuite_port_stats.py             |   21 +-
 dts/tests/TestSuite_promisc_support.py        |   11 +-
 dts/tests/TestSuite_queue_start_stop.py       |   24 +-
 dts/tests/TestSuite_rte_flow.py               |   36 +-
 dts/tests/TestSuite_smoke_tests.py            |   11 +-
 dts/tests/TestSuite_softnic.py                |   18 +-
 dts/tests/TestSuite_uni_pkt.py                |   35 +-
 dts/tests/TestSuite_vlan.py                   |   26 +-
 46 files changed, 3371 insertions(+), 3172 deletions(-)
 create mode 100644 doc/api/dts/api.capabilities.rst
 create mode 100644 doc/api/dts/api.rst
 create mode 100644 doc/api/dts/api.testpmd.config.rst
 create mode 100644 doc/api/dts/api.testpmd.rst
 create mode 100644 doc/api/dts/api.testpmd.types.rst
 delete mode 100644 doc/api/dts/framework.params.testpmd.rst
 delete mode 100644 doc/api/dts/framework.remote_session.testpmd_shell.rst
 create mode 100644 dts/api/__init__.py
 create mode 100644 dts/api/capabilities.py
 create mode 100644 dts/api/testpmd/__init__.py
 rename dts/{framework/params/testpmd.py => api/testpmd/config.py} (98%)
 create mode 100644 dts/api/testpmd/types.py
 delete mode 100644 dts/framework/remote_session/testpmd_shell.py

--
2.39.5

