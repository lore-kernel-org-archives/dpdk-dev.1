Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B608CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0F214065D;
	Wed, 10 Sep 2025 21:43:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1B15540653
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:43:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C70516F2;
 Wed, 10 Sep 2025 12:43:02 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.66.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E78B3F694;
 Wed, 10 Sep 2025 12:43:10 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v1 0/1] update testsuite docs
Date: Wed, 10 Sep 2025 20:42:58 +0100
Message-Id: <20250910194259.1027220-1-paul.szczepanek@arm.com>
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

This is a minor but important update to the testsuite docs to make
them more consistent and hence easier to read and to give a good
example of how to write new tests. Given that it touches many files
I recommend we merge it before it gets into conflicts (but after the
series it depends on of course).

Thomas Wilks (1):
  dts: update testsuite docs

 dts/tests/TestSuite_blocklist.py              |  23 +-
 dts/tests/TestSuite_checksum_offload.py       | 126 +++++------
 dts/tests/TestSuite_dual_vlan.py              |  85 +++-----
 dts/tests/TestSuite_dynamic_config.py         |  67 +++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  74 +++++--
 dts/tests/TestSuite_hello_world.py            |   5 +-
 dts/tests/TestSuite_l2fwd.py                  |  10 +-
 dts/tests/TestSuite_mac_filter.py             |  48 +++--
 dts/tests/TestSuite_mtu.py                    |  98 ++++-----
 dts/tests/TestSuite_packet_capture.py         |  10 +-
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  30 ++-
 dts/tests/TestSuite_port_control.py           |  30 +--
 ...stSuite_port_restart_config_persistency.py |  26 +--
 dts/tests/TestSuite_port_stats.py             |  16 +-
 dts/tests/TestSuite_promisc_support.py        |  16 +-
 dts/tests/TestSuite_queue_start_stop.py       |  62 +++---
 dts/tests/TestSuite_rte_flow.py               | 200 +++++++++---------
 dts/tests/TestSuite_smoke_tests.py            |  29 ++-
 dts/tests/TestSuite_softnic.py                |  11 +-
 dts/tests/TestSuite_uni_pkt.py                |  96 ++++-----
 dts/tests/TestSuite_vlan.py                   |  58 +++--
 21 files changed, 619 insertions(+), 501 deletions(-)

--
2.39.5

