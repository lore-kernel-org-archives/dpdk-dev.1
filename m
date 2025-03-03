Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEFFC282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4381140280;
	Mon,  3 Mar 2025 15:57:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id CDB73400D7
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:18 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28BBE106F;
 Mon,  3 Mar 2025 06:57:32 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 584063F66E;
 Mon,  3 Mar 2025 06:57:17 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH v4 0/7] dts: add per-test-suite configuration
Date: Mon,  3 Mar 2025 16:57:02 +0200
Message-ID: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108134532.130681-1-luca.vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Hi there,

sending in v4 for the per-test-suite configuration patchset.

v4:
- rebased
- Changed implementation:
  - test suites configurations are now provided
    through a dedicated optional configuration file.
  - running multiple test runs hinders flexibility in loading
    configuration, therefore DTS now accepts only one test run.
  - the tests folder is no longer a package as this is no longer
    imported directly. The implementation now relies on the test
    suite globbing imports, then the configuration class is referenced
    through the annotation for TestSuite.config.
  - as a consequence of the above, a code generator is no longer needed.
- improved the way configuration errors are displayed.
- adding the test suites to the docs resulted in several warnings,
  minimally required fixes are added.

Best,
Luca

Luca Vizzarro (7):
  dts: add tests package to API docs
  dts: amend test suites docstring
  dts: fix smoke tests docstring
  dts: update autodoc sorting order
  dts: run only one test run per execution
  dts: add per-test-suite configuration
  dts: improve configuration errors

 doc/api/dts/index.rst                         |   1 +
 doc/api/dts/tests.TestSuite_blocklist.rst     |   8 ++
 .../dts/tests.TestSuite_checksum_offload.rst  |   8 ++
 doc/api/dts/tests.TestSuite_dual_vlan.rst     |   8 ++
 .../dts/tests.TestSuite_dynamic_config.rst    |   8 ++
 .../tests.TestSuite_dynamic_queue_conf.rst    |   8 ++
 doc/api/dts/tests.TestSuite_hello_world.rst   |   8 ++
 doc/api/dts/tests.TestSuite_l2fwd.rst         |   8 ++
 doc/api/dts/tests.TestSuite_mac_filter.rst    |   8 ++
 doc/api/dts/tests.TestSuite_mtu.rst           |   8 ++
 .../tests.TestSuite_pmd_buffer_scatter.rst    |   8 ++
 ...tSuite_port_restart_config_persistency.rst |   8 ++
 .../dts/tests.TestSuite_promisc_support.rst   |   8 ++
 .../dts/tests.TestSuite_queue_start_stop.rst  |   8 ++
 doc/api/dts/tests.TestSuite_smoke_tests.rst   |   8 ++
 doc/api/dts/tests.TestSuite_softnic.rst       |   8 ++
 doc/api/dts/tests.TestSuite_uni_pkt.rst       |   8 ++
 doc/api/dts/tests.TestSuite_vlan.rst          |   8 ++
 doc/api/dts/tests.rst                         |  11 ++
 doc/guides/conf.py                            |   1 +
 doc/guides/tools/dts.rst                      |  25 ++--
 dts/.gitignore                                |   2 +-
 dts/framework/config/__init__.py              | 112 ++++++++++-------
 dts/framework/config/test_run.py              |  53 ++++++--
 dts/framework/runner.py                       |  33 +++--
 dts/framework/settings.py                     |  33 +++--
 dts/framework/test_run.py                     |  23 ++--
 dts/framework/test_suite.py                   |  25 ++--
 dts/test_run.example.yaml                     |  43 +++++++
 dts/test_runs.example.yaml                    |  43 -------
 dts/tests/TestSuite_dynamic_config.py         |  10 +-
 dts/tests/TestSuite_hello_world.py            |  14 ++-
 dts/tests/TestSuite_mac_filter.py             |  42 +++----
 dts/tests/TestSuite_mtu.py                    | 114 +++++++++---------
 dts/tests/TestSuite_smoke_tests.py            |   2 -
 dts/tests_config.example.yaml                 |   2 +
 36 files changed, 495 insertions(+), 230 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_blocklist.rst
 create mode 100644 doc/api/dts/tests.TestSuite_checksum_offload.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dual_vlan.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dynamic_config.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst
 create mode 100644 doc/api/dts/tests.TestSuite_hello_world.rst
 create mode 100644 doc/api/dts/tests.TestSuite_l2fwd.rst
 create mode 100644 doc/api/dts/tests.TestSuite_mac_filter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_mtu.rst
 create mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_port_restart_config_persistency.rst
 create mode 100644 doc/api/dts/tests.TestSuite_promisc_support.rst
 create mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
 create mode 100644 doc/api/dts/tests.TestSuite_smoke_tests.rst
 create mode 100644 doc/api/dts/tests.TestSuite_softnic.rst
 create mode 100644 doc/api/dts/tests.TestSuite_uni_pkt.rst
 create mode 100644 doc/api/dts/tests.TestSuite_vlan.rst
 create mode 100644 doc/api/dts/tests.rst
 create mode 100644 dts/test_run.example.yaml
 delete mode 100644 dts/test_runs.example.yaml
 create mode 100644 dts/tests_config.example.yaml

-- 
2.43.0

