Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B1DCD13D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 21:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 113F840274;
	Thu, 30 Apr 2026 23:09:21 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id C05D7400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 23:09:19 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8ef0ba61d46so150107185a.2
 for <dev@dpdk.org>; Thu, 30 Apr 2026 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777583359; x=1778188159; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXaJ+GMFLwzc9vf/p4v4MD79+r8uXQkhic1BuoEfgYA=;
 b=cH2LMGBN6+pUn0qPpmVzIrAwUQLI1ip29LAPIJyl/VfudXoCfaoF130QZmWaX4yOiA
 3aC0RTJDFt+0J2Y3bx705iVUW7znQbUvHKjUIAjSPBlSeuhTYKBTKX41f1LXKmdS991q
 CO0kYu7yJo6xLd/vdkR8zvGrUUfX63nP+S0oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583359; x=1778188159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXaJ+GMFLwzc9vf/p4v4MD79+r8uXQkhic1BuoEfgYA=;
 b=PLlCH1mZHYVn8OKkUmSbZHmbv0lofQUGGT9+bVPSgxdp62Mvkqd6wcYMYQO1kDif96
 Z+qs65vD5GhMi8QyA6OgkukJkH2G2Ti0Tz3lCXcXsn+gmX5PtaBzepdFTTjSxwiDa+hB
 EweNS9Ca3Cxc5DCcMvFGr51eYRLKQZBxi+cINYlnN0hVMJvoEy/cVVTkkPfbA6A8uNF6
 CNVrm1swUyKEtyPZgFegFflcpW06oG1wEBBspjHgYATEwRQvyatZhkslArEGkt30PyrQ
 KnhP3eiNgtlcD4qqlL92zyIV6h6T1AkpFUPez8P1JnGVI3GCrzV5WweQdWFfDdjesuuE
 Pdvw==
X-Gm-Message-State: AOJu0YyA3JPgSd2gQ3LFQSUTUK2m8f5gUylAFEoT20ZiitL+0hW/M2kC
 LSQrak9d0BaTvsIHgHTCoN39R4r7ehlnViQX5pjlYFZl+cbvY1jtiR0+V56WFHoKW8/42xJzLR1
 wpcmS
X-Gm-Gg: AeBDies/YMUayvFHP72vCt95s18QG0MMU/NnBFPcxCDuta3KXfdK8IMkuag47qszegz
 beRmxBQavKGjl+8AMqIkSZ++KaOJin+yUDT1YHlsOlG+OPZXt7olLl/cKax+R0i8Lyfg6GJ+mZx
 0al65LsKsiFMz5oBSHeSh3riWuBqzeVMHwfWSeMyLDoxfgF9sJnK1ZpzdLyV68N5ur+G++t43TI
 Mvm5GmXdqhaTOGJBdgdXu8iT0tHvu0orWRYVPf07TJPTnKiuXZWf6lfCmy7rV9Rhu4QgSnPo/hx
 /+m0FYA9WAmtui3tC6OqBKvCp4+7DfDN3fwLuwY5K8C7fBPlt59hmjqVj902ZKrS79q3DzVHpvy
 qvZe7CphnxfT6G4sLS3UI5q4wpHYJCi2XAphBsm5tRzG+1kRThC6fT2tS7+yB+3cbBYWjlyoVpM
 IXUxp9o2t7Vw46lGt9f1vV4XtaSxF2izJlsFxwSsZz4og2jB5t4xJ3BnWuUXI3VlGVifzr0LGT
X-Received: by 2002:a05:620a:454d:b0:8cd:7952:d449 with SMTP id
 af79cd13be357-8fa88f2eff1mr743046985a.29.1777583358942; 
 Thu, 30 Apr 2026 14:09:18 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbf3f2141fsm15434385a.41.2026.04.30.14.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 14:09:18 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 0/7] dts: move test suite imports from framework to API
Date: Thu, 30 Apr 2026 17:09:10 -0400
Message-ID: <20260430210917.25186-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424170139.20592-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
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

This series moves various modules from the framework directory
to the API based on which are being imported by test suites.

These include:
  - test_suite
  - testbed_model
  - exception
  - utils
  - context
  - params

This eliminates all test suite framework imports except for
the remote_session imports in packet_capture, as well
as the settings/config imports in smoke_tests. I believe these
imports, and what to do with them, should be a topic of discussion
in future DTS meetings, as I don't believe they should reside in the
API, even if they are being imported in test suites.

In addition to these changes, I've split the linux_session module
into an interface in api/testbed_model/linux_session and an
implementation in framework/linux_session. This way, users
can still import linux session if necessary, without exposing
the backend implementation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>

---
v2:
* Integrated rst updates with corresponding commits for build testing

v3:
* Fixed commit ordering to resolve import inconsistency
* Updated Linux Session interface with test suite methods

v4:
* Added missing SPDX tag to framework.linux_session.rst

Dean Marx (7):
  dts: move exception module from framework to API
  dts: move utils from framework to API
  dts: move context from framework to API
  dts: move testbed model from framework to API
  dts: move test suite module from framework to API
  dts: move params directory from framework to API
  dts: separate Linux session into interface and logic

 ...{framework.context.rst => api.context.rst} |  2 +-
 ...mework.exception.rst => api.exception.rst} |  2 +-
 ...work.params.eal.rst => api.params.eal.rst} |  2 +-
 .../{framework.params.rst => api.params.rst}  |  6 +--
 ....params.types.rst => api.params.types.rst} |  2 +-
 ...work.test_suite.rst => api.test_suite.rst} |  2 +-
 ...y.rst => api.testbed_model.capability.rst} |  2 +-
 ...odel.cpu.rst => api.testbed_model.cpu.rst} |  2 +-
 ...st => api.testbed_model.linux_session.rst} |  2 +-
 ...el.node.rst => api.testbed_model.node.rst} |  2 +-
 ...n.rst => api.testbed_model.os_session.rst} |  2 +-
 ...el.port.rst => api.testbed_model.port.rst} |  2 +-
 ...st => api.testbed_model.posix_session.rst} |  2 +-
 doc/api/dts/api.testbed_model.rst             | 28 +++++++++++++
 ...ogy.rst => api.testbed_model.topology.rst} |  2 +-
 ...generator.capturing_traffic_generator.rst} |  2 +-
 .../api.testbed_model.traffic_generator.rst   | 16 ++++++++
 ...testbed_model.traffic_generator.scapy.rst} |  2 +-
 ...l.traffic_generator.traffic_generator.rst} |  2 +-
 ...t => api.testbed_model.virtual_device.rst} |  2 +-
 .../{framework.utils.rst => api.utils.rst}    |  2 +-
 doc/api/dts/framework.linux_session.rst       |  8 ++++
 doc/api/dts/framework.testbed_model.rst       | 28 -------------
 ...mework.testbed_model.traffic_generator.rst | 16 --------
 doc/api/dts/index.rst                         | 13 +++---
 dts/api/artifact.py                           |  6 +--
 dts/api/capabilities.py                       | 14 +++----
 dts/{framework => api}/context.py             | 14 +++----
 dts/api/cryptodev/__init__.py                 |  6 +--
 dts/api/cryptodev/config.py                   |  6 +--
 dts/{framework => api}/exception.py           |  0
 dts/api/packet.py                             | 18 ++++----
 dts/{framework => api}/params/__init__.py     |  0
 dts/{framework => api}/params/eal.py          |  8 ++--
 dts/{framework => api}/params/types.py        | 14 ++++---
 dts/api/test.py                               |  4 +-
 dts/{framework => api}/test_suite.py          | 15 ++++---
 .../testbed_model/__init__.py                 |  0
 .../testbed_model/capability.py               | 18 ++++----
 dts/{framework => api}/testbed_model/cpu.py   |  4 +-
 dts/api/testbed_model/linux_session.py        | 41 +++++++++++++++++++
 dts/{framework => api}/testbed_model/node.py  | 12 +++---
 .../testbed_model/os_session.py               |  8 ++--
 dts/{framework => api}/testbed_model/port.py  |  2 +-
 .../testbed_model/posix_session.py            |  6 +--
 .../testbed_model/topology.py                 | 20 ++++-----
 .../traffic_generator/__init__.py             |  4 +-
 .../capturing_traffic_generator.py            |  4 +-
 .../performance_traffic_generator.py          |  0
 .../testbed_model/traffic_generator/scapy.py  | 14 +++----
 .../traffic_generator/traffic_generator.py    |  8 ++--
 .../testbed_model/traffic_generator/trex.py   | 16 ++++----
 .../testbed_model/virtual_device.py           |  0
 dts/api/testpmd/__init__.py                   | 11 +++--
 dts/api/testpmd/config.py                     |  6 +--
 dts/api/testpmd/types.py                      |  2 +-
 dts/{framework => api}/utils.py               |  2 +-
 dts/framework/config/__init__.py              |  6 +--
 dts/framework/config/node.py                  |  2 +-
 dts/framework/config/test_run.py              | 12 +++---
 .../{testbed_model => }/linux_session.py      | 15 ++++---
 dts/framework/parser.py                       |  2 +-
 dts/framework/remote_session/blocking_app.py  |  8 ++--
 dts/framework/remote_session/dpdk.py          | 16 ++++----
 dts/framework/remote_session/dpdk_shell.py    |  6 +--
 .../interactive_remote_session.py             |  2 +-
 .../remote_session/interactive_shell.py       |  8 ++--
 .../remote_session/remote_session.py          |  4 +-
 dts/framework/runner.py                       |  4 +-
 dts/framework/test_result.py                  |  5 +--
 dts/framework/test_run.py                     | 24 +++++------
 dts/tests/TestSuite_blocklist.py              |  4 +-
 dts/tests/TestSuite_checksum_offload.py       |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py   |  8 ++--
 dts/tests/TestSuite_dual_vlan.py              |  2 +-
 dts/tests/TestSuite_dynamic_config.py         |  2 +-
 dts/tests/TestSuite_dynamic_queue_conf.py     |  4 +-
 dts/tests/TestSuite_hello_world.py            |  2 +-
 dts/tests/TestSuite_l2fwd.py                  |  8 ++--
 dts/tests/TestSuite_mac_filter.py             |  4 +-
 dts/tests/TestSuite_mtu.py                    |  2 +-
 dts/tests/TestSuite_packet_capture.py         | 12 +++---
 dts/tests/TestSuite_pmd_buffer_scatter.py     |  2 +-
 dts/tests/TestSuite_pmd_rss.py                |  6 +--
 dts/tests/TestSuite_port_control.py           |  2 +-
 ...stSuite_port_restart_config_persistency.py |  2 +-
 dts/tests/TestSuite_port_stats.py             |  2 +-
 dts/tests/TestSuite_promisc_support.py        |  2 +-
 dts/tests/TestSuite_qinq.py                   |  2 +-
 dts/tests/TestSuite_queue_start_stop.py       |  2 +-
 dts/tests/TestSuite_rte_flow.py               | 12 +++---
 dts/tests/TestSuite_rx_tx_offload.py          |  2 +-
 .../TestSuite_single_core_forward_perf.py     |  4 +-
 dts/tests/TestSuite_smoke_tests.py            |  6 +--
 dts/tests/TestSuite_softnic.py                |  6 +--
 dts/tests/TestSuite_uni_pkt.py                |  2 +-
 dts/tests/TestSuite_virtio_fwd.py             |  8 ++--
 dts/tests/TestSuite_vlan.py                   |  2 +-
 98 files changed, 359 insertions(+), 301 deletions(-)
 rename doc/api/dts/{framework.context.rst => api.context.rst} (80%)
 rename doc/api/dts/{framework.exception.rst => api.exception.rst} (77%)
 rename doc/api/dts/{framework.params.eal.rst => api.params.eal.rst} (79%)
 rename doc/api/dts/{framework.params.rst => api.params.rst} (71%)
 rename doc/api/dts/{framework.params.types.rst => api.params.types.rst} (80%)
 rename doc/api/dts/{framework.test_suite.rst => api.test_suite.rst} (81%)
 rename doc/api/dts/{framework.testbed_model.capability.rst => api.testbed_model.capability.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.cpu.rst => api.testbed_model.cpu.rst} (78%)
 rename doc/api/dts/{framework.testbed_model.linux_session.rst => api.testbed_model.linux_session.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.node.rst => api.testbed_model.node.rst} (71%)
 rename doc/api/dts/{framework.testbed_model.os_session.rst => api.testbed_model.os_session.rst} (76%)
 rename doc/api/dts/{framework.testbed_model.port.rst => api.testbed_model.port.rst} (77%)
 rename doc/api/dts/{framework.testbed_model.posix_session.rst => api.testbed_model.posix_session.rst} (74%)
 create mode 100644 doc/api/dts/api.testbed_model.rst
 rename doc/api/dts/{framework.testbed_model.topology.rst => api.testbed_model.topology.rst} (73%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.capturing_traffic_generator.rst => api.testbed_model.traffic_generator.capturing_traffic_generator.rst} (68%)
 create mode 100644 doc/api/dts/api.testbed_model.traffic_generator.rst
 rename doc/api/dts/{framework.testbed_model.traffic_generator.scapy.rst => api.testbed_model.traffic_generator.scapy.rst} (70%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.traffic_generator.rst => api.testbed_model.traffic_generator.traffic_generator.rst} (65%)
 rename doc/api/dts/{framework.testbed_model.virtual_device.rst => api.testbed_model.virtual_device.rst} (72%)
 rename doc/api/dts/{framework.utils.rst => api.utils.rst} (80%)
 create mode 100644 doc/api/dts/framework.linux_session.rst
 delete mode 100644 doc/api/dts/framework.testbed_model.rst
 delete mode 100644 doc/api/dts/framework.testbed_model.traffic_generator.rst
 rename dts/{framework => api}/context.py (90%)
 rename dts/{framework => api}/exception.py (100%)
 rename dts/{framework => api}/params/__init__.py (100%)
 rename dts/{framework => api}/params/eal.py (89%)
 rename dts/{framework => api}/params/types.py (94%)
 rename dts/{framework => api}/test_suite.py (98%)
 rename dts/{framework => api}/testbed_model/__init__.py (100%)
 rename dts/{framework => api}/testbed_model/capability.py (98%)
 rename dts/{framework => api}/testbed_model/cpu.py (99%)
 create mode 100644 dts/api/testbed_model/linux_session.py
 rename dts/{framework => api}/testbed_model/node.py (96%)
 rename dts/{framework => api}/testbed_model/os_session.py (99%)
 rename dts/{framework => api}/testbed_model/port.py (98%)
 rename dts/{framework => api}/testbed_model/posix_session.py (99%)
 rename dts/{framework => api}/testbed_model/topology.py (96%)
 rename dts/{framework => api}/testbed_model/traffic_generator/__init__.py (95%)
 rename dts/{framework => api}/testbed_model/traffic_generator/capturing_traffic_generator.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/performance_traffic_generator.py (100%)
 rename dts/{framework => api}/testbed_model/traffic_generator/scapy.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/traffic_generator.py (91%)
 rename dts/{framework => api}/testbed_model/traffic_generator/trex.py (96%)
 rename dts/{framework => api}/testbed_model/virtual_device.py (100%)
 rename dts/{framework => api}/utils.py (99%)
 rename dts/framework/{testbed_model => }/linux_session.py (97%)

-- 
2.52.0

