Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73415C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BECA40E72;
	Wed,  2 Sep 2026 20:13:52 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8EBB140E50
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:50 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c0c45c580so13853481cf.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372830; x=1788977630; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTJZDtlhRU33e65Rrcb883sA9D04PoQo0OFz5yhOzAc=;
 b=Ww2JcuBxX+Sm5q8TUBJXfLRce7cvP1I1wTgQv0bM7cioKqSQdQkIy4ZJiLE7zPK9zr
 B4OXWQIyanfQtJz2GuBWbG11VWU1DPBCxOJQrQXn6jF7tvH1wAD24xAYBmugaA3mGDzh
 Icc3JAc8mXTXcqWTF9YNl7JdU7Ju0is3AmE4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372830; x=1788977630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hTJZDtlhRU33e65Rrcb883sA9D04PoQo0OFz5yhOzAc=;
 b=REcz+uo95ZNUAEWTqP3SUeTxm4IIQmFL81yGhXbmQHRM80ozSviFM3JJJL4IfJjvJX
 bM7iCIpD/7/yYOsuB4lirxJeDCfvvGSMN74dX9QD+QWQNHmvAa0a4Bo8JH2QoD0P6Qs0
 Hl5fkQNqxXlL23lU72cUvt806wNVqfkfHe0wVZQpsG91UP4Q869ymFxOL02KnWi55i+u
 0QftMu7ut94X4dubjVTwHAwe+9qOZSWXcCMvI8s7aksr/VY7W4od/RKLHRT/8xYroT1e
 4ip7Sf8Nkx5Zxh38fSa1l/ZHnvXwP5zCixfezPZrjALP1HWZVfRq4+9dBIoCTdlr2kzs
 tQoA==
X-Gm-Message-State: AFuF++kmqIDmwOpXYibFxcgf/0wNZmmdtG1gtT6zBtuyc6hsqNdnrmb/
 Avp0EyoMLjSeKnKf6Z6ZGcTsk/S13KNMVjyKWS/Ql8JxSdww5LXouEBFVRspXa/sb4otOfMAIRj
 P2bK4Q3Ef77Y7yX7QTXgpKlYX0QDgS9BGLQ3cb7IHDjIDC1mtvdahsKJFVjmS1ZP2CHcYci4gVw
 jyKdtometH9+eUoccPd/VlpqencYQ=
X-Gm-Gg: AYBFou3HL5xb/m8fZUUSEElRXuKSI6HqycvK3XhnijwoBwULGjceiFS0rRKk36d3tzX
 hXDXROGdShfbNkiwfatPSNGhL1VRqnI7Ktcx+LEJBaJeh3T2Nn+iJ2MpfRG1AtpkJbUsvRZMmZc
 bJVizA4awIaTau8PBs6Uf311XD+WNpwzUHcpSHyl8JZ5qoWY1smgA6PE/QCSimqENtESW9KGwiA
 Ccl8usWnqhX8QCIKpmf+H6a3OOYch4r/ErZmTwxfNvEbQ8ZnY7dggA6z4V84jWMOPxIgWdjsREI
 vhlJ0UbjSbVipcCaxy3ek6QtOQhKzXUYfjXNmCJlpIhabs15+mHrPraK2+OjLXC+FTTaqdQdTJ7
 /IZt126OECs2P28NC34+Vx2PI0g5cLpw5wApy9TWPSCmm7u+TMoA37kgZQbHjsASEwAFJfGUV3r
 9ba0ZD2ifKRtFQYAEjT7FvR7diT9DhkCCnh01Cv8KsHzpuyYnfv0Mf/H9yazfloflQWu5O3ZiDD
 egmkA+oGI6a
X-Received: by 2002:ac8:58ce:0:b0:51c:ba4:d837 with SMTP id
 d75a77b69052e-53036bf7703mr79160851cf.18.1788372829555; 
 Wed, 02 Sep 2026 11:13:49 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:48 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 0/8] dts: remove imports from framework in test suites
Date: Wed,  2 Sep 2026 14:13:24 -0400
Message-ID: <20260902181333.461556-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806135346.568766-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
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

This series takes action to make modules accessible from api that were
only in framework before. This greatly cleans up the majority of test
suites, ridding them of almost all framework imports.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

---

v5:
 * Resolved merge conflicts and rebased to main.
 * Removed additional framework imports from test suites.
v6:
 * Moved linux changes to port over before testbed model.
 * Separated traffic generator porting into a new commit.
 * Removed context variable from being exposed in API.

Andrew Bailey (8):
  dts: move exception module from framework to API
  dts: move utils from framework to API
  dts: move context from framework to API
  dts: separate Linux session into interface and logic
  dts: port base traffic generators to API
  dts: move testbed model from framework to API
  dts: move test suite module from framework to API
  dts: move params directory from framework to API

 ...{framework.context.rst => api.context.rst} |  2 +-
 ...mework.exception.rst => api.exception.rst} |  2 +-
 ...work.params.eal.rst => api.params.eal.rst} |  2 +-
 .../{framework.params.rst => api.params.rst}  |  6 +-
 ....params.types.rst => api.params.types.rst} |  2 +-
 ...work.test_suite.rst => api.test_suite.rst} |  2 +-
 ...y.rst => api.testbed_model.capability.rst} |  2 +-
 ...el.port.rst => api.testbed_model.port.rst} |  2 +-
 doc/api/dts/api.testbed_model.rst             | 14 +++
 ...generator.capturing_traffic_generator.rst} |  2 +-
 ...> api.testbed_model.traffic_generator.rst} |  6 +-
 ...l.traffic_generator.traffic_generator.rst} |  2 +-
 ...t => api.testbed_model.virtual_device.rst} |  2 +-
 .../{framework.utils.rst => api.utils.rst}    |  2 +-
 doc/api/dts/framework.testbed_model.rst       | 15 ++--
 doc/api/dts/index.rst                         | 11 +--
 dts/api/artifact.py                           |  4 +-
 dts/api/capabilities.py                       | 10 +--
 dts/api/context.py                            | 30 +++++++
 dts/api/cryptodev/__init__.py                 |  6 +-
 dts/api/cryptodev/config.py                   |  6 +-
 dts/{framework => api}/exception.py           |  0
 dts/api/packet.py                             | 20 ++---
 dts/{framework => api}/params/__init__.py     |  0
 dts/{framework => api}/params/eal.py          |  8 +-
 dts/{framework => api}/params/types.py        | 16 ++--
 dts/api/test.py                               |  4 +-
 dts/{framework => api}/test_suite.py          | 13 ++-
 .../testbed_model/capability.py               | 10 +--
 dts/api/testbed_model/cpu.py                  | 36 ++++++++
 dts/api/testbed_model/linux_session.py        | 42 +++++++++
 dts/{framework => api}/testbed_model/port.py  |  4 +-
 .../capturing_traffic_generator.py            |  7 +-
 .../performance_traffic_generator.py          |  2 +-
 .../traffic_generator/traffic_generator.py    |  4 +-
 .../testbed_model/virtual_device.py           |  0
 dts/api/testpmd/__init__.py                   | 11 ++-
 dts/api/testpmd/config.py                     |  6 +-
 dts/api/testpmd/types.py                      |  2 +-
 dts/{framework => api}/utils.py               |  2 +-
 dts/framework/config/__init__.py              |  6 +-
 dts/framework/config/node.py                  |  2 +-
 dts/framework/config/test_run.py              | 12 +--
 dts/framework/context.py                      |  8 +-
 dts/framework/parser.py                       |  2 +-
 dts/framework/remote_session/blocking_app.py  |  6 +-
 dts/framework/remote_session/dpdk.py          | 10 +--
 dts/framework/remote_session/dpdk_shell.py    |  6 +-
 .../interactive_remote_session.py             |  2 +-
 .../remote_session/interactive_shell.py       |  6 +-
 .../remote_session/remote_session.py          |  4 +-
 dts/framework/runner.py                       |  2 +-
 dts/framework/test_result.py                  |  3 +-
 dts/framework/test_run.py                     | 18 ++--
 dts/framework/testbed_model/cpu.py            |  2 +-
 dts/framework/testbed_model/linux_session.py  | 10 +--
 dts/framework/testbed_model/node.py           |  6 +-
 dts/framework/testbed_model/os_session.py     |  4 +-
 dts/framework/testbed_model/posix_session.py  |  6 +-
 dts/framework/testbed_model/topology.py       | 19 ++--
 .../traffic_generator/__init__.py             |  4 +-
 .../testbed_model/traffic_generator/scapy.py  | 13 ++-
 .../testbed_model/traffic_generator/trex.py   | 12 +--
 dts/tests/TestSuite_blocklist.py              |  4 +-
 dts/tests/TestSuite_buffer_scatter.py         |  2 +-
 dts/tests/TestSuite_checksum_offload.py       |  2 +-
 dts/tests/TestSuite_cryptodev_latency.py      |  6 +-
 dts/tests/TestSuite_cryptodev_throughput.py   | 89 +++++--------------
 dts/tests/TestSuite_dual_vlan.py              |  2 +-
 dts/tests/TestSuite_dynamic_config.py         |  2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |  4 +-
 dts/tests/TestSuite_flow_offload.py           | 12 +--
 dts/tests/TestSuite_hello_world.py            |  2 +-
 dts/tests/TestSuite_l2fwd.py                  |  8 +-
 dts/tests/TestSuite_mac_filter.py             |  4 +-
 dts/tests/TestSuite_mtu.py                    |  2 +-
 dts/tests/TestSuite_packet_capture.py         | 10 +--
 dts/tests/TestSuite_port_control.py           |  2 +-
 ...stSuite_port_restart_config_persistency.py |  2 +-
 dts/tests/TestSuite_port_stats.py             |  2 +-
 dts/tests/TestSuite_promisc_support.py        |  2 +-
 dts/tests/TestSuite_qinq.py                   |  2 +-
 dts/tests/TestSuite_queue_toggle.py           |  2 +-
 dts/tests/TestSuite_rss.py                    |  6 +-
 dts/tests/TestSuite_rx_split.py               |  4 +-
 dts/tests/TestSuite_rx_tx_offload.py          |  2 +-
 .../TestSuite_single_core_forward_perf.py     |  4 +-
 dts/tests/TestSuite_smoke_tests.py            |  6 +-
 dts/tests/TestSuite_softnic.py                |  6 +-
 dts/tests/TestSuite_speed_capabilities.py     |  2 +-
 dts/tests/TestSuite_unified_packet.py         |  2 +-
 dts/tests/TestSuite_virtio_forward.py         | 16 ++--
 dts/tests/TestSuite_vlan.py                   |  2 +-
 93 files changed, 382 insertions(+), 309 deletions(-)
 rename doc/api/dts/{framework.context.rst => api.context.rst} (80%)
 rename doc/api/dts/{framework.exception.rst => api.exception.rst} (77%)
 rename doc/api/dts/{framework.params.eal.rst => api.params.eal.rst} (79%)
 rename doc/api/dts/{framework.params.rst => api.params.rst} (71%)
 rename doc/api/dts/{framework.params.types.rst => api.params.types.rst} (80%)
 rename doc/api/dts/{framework.test_suite.rst => api.test_suite.rst} (81%)
 rename doc/api/dts/{framework.testbed_model.capability.rst => api.testbed_model.capability.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.port.rst => api.testbed_model.port.rst} (77%)
 create mode 100644 doc/api/dts/api.testbed_model.rst
 rename doc/api/dts/{framework.testbed_model.traffic_generator.capturing_traffic_generator.rst => api.testbed_model.traffic_generator.capturing_traffic_generator.rst} (68%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.rst => api.testbed_model.traffic_generator.rst} (54%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.traffic_generator.rst => api.testbed_model.traffic_generator.traffic_generator.rst} (65%)
 rename doc/api/dts/{framework.testbed_model.virtual_device.rst => api.testbed_model.virtual_device.rst} (72%)
 rename doc/api/dts/{framework.utils.rst => api.utils.rst} (80%)
 create mode 100644 dts/api/context.py
 rename dts/{framework => api}/exception.py (100%)
 rename dts/{framework => api}/params/__init__.py (100%)
 rename dts/{framework => api}/params/eal.py (89%)
 rename dts/{framework => api}/params/types.py (93%)
 rename dts/{framework => api}/test_suite.py (98%)
 rename dts/{framework => api}/testbed_model/capability.py (98%)
 create mode 100644 dts/api/testbed_model/cpu.py
 create mode 100644 dts/api/testbed_model/linux_session.py
 rename dts/{framework => api}/testbed_model/port.py (97%)
 rename dts/{framework => api}/testbed_model/traffic_generator/capturing_traffic_generator.py (97%)
 rename dts/{framework => api}/testbed_model/traffic_generator/performance_traffic_generator.py (95%)
 rename dts/{framework => api}/testbed_model/traffic_generator/traffic_generator.py (95%)
 rename dts/{framework => api}/testbed_model/virtual_device.py (100%)
 rename dts/{framework => api}/utils.py (99%)

--
2.55.0

