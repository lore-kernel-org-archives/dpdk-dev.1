Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F0CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 10:38:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E23AD402EB;
	Tue, 23 Sep 2025 12:38:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A40B34021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 12:38:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1CD6497;
 Tue, 23 Sep 2025 03:37:56 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.70.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 892353F694;
 Tue, 23 Sep 2025 03:38:04 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v1 0/2] Move TestSuite methods to API modules
Date: Tue, 23 Sep 2025 11:37:56 +0100
Message-Id: <20250923103758.3192015-1-paul.szczepanek@arm.com>
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

Split up TestSuite internals from methods that can be used in tests.
Packet and test related methods have been moved to new API modules:
dts/api/packet.py,
dts/api/test.py.
All tests have been adjusted to use the new API calls.

Paul Szczepanek (2):
  dts: add packet handling and test utilities to API
  dts: adjust all tests to use the new API calls

 doc/api/dts/api.packet.rst                    |   8 +
 doc/api/dts/api.rst                           |   4 +-
 doc/api/dts/api.test.rst                      |   8 +
 doc/guides/tools/dts.rst                      |   2 +-
 dts/api/packet.py                             | 311 ++++++++++++++++++
 dts/api/test.py                               | 126 +++++++
 dts/framework/test_suite.py                   | 305 +----------------
 dts/tests/TestSuite_blocklist.py              |   5 +-
 dts/tests/TestSuite_checksum_offload.py       |  14 +-
 dts/tests/TestSuite_dual_vlan.py              |  26 +-
 dts/tests/TestSuite_dynamic_config.py         |   8 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |  13 +-
 dts/tests/TestSuite_hello_world.py            |   3 +-
 dts/tests/TestSuite_l2fwd.py                  |  11 +-
 dts/tests/TestSuite_mac_filter.py             |  16 +-
 dts/tests/TestSuite_mtu.py                    |  10 +-
 dts/tests/TestSuite_packet_capture.py         |  22 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  10 +-
 dts/tests/TestSuite_port_control.py           |  14 +-
 ...stSuite_port_restart_config_persistency.py |   3 +-
 dts/tests/TestSuite_port_stats.py             |  12 +-
 dts/tests/TestSuite_promisc_support.py        |  20 +-
 dts/tests/TestSuite_queue_start_stop.py       |   6 +-
 dts/tests/TestSuite_rte_flow.py               |  70 ++--
 dts/tests/TestSuite_smoke_tests.py            |   7 +-
 dts/tests/TestSuite_softnic.py                |  11 +-
 dts/tests/TestSuite_uni_pkt.py                |   6 +-
 dts/tests/TestSuite_vlan.py                   |  20 +-
 28 files changed, 638 insertions(+), 433 deletions(-)
 create mode 100644 doc/api/dts/api.packet.rst
 create mode 100644 doc/api/dts/api.test.rst
 create mode 100644 dts/api/packet.py
 create mode 100644 dts/api/test.py

--
2.39.5

