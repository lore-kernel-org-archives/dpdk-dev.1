Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD8C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8B54027E;
	Thu,  6 Aug 2026 19:50:42 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id DBCCF40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:50:40 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-934956bee57so229013485a.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786038640; x=1786643440; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=omf1LnzDSONXitNVhBvoNyC4TQOAxx0K65CcjW+Kvgg=;
 b=eCtqURb2xhObH+yP5Ni2A1xXe8HSwCtPKQ6xLf55Ty5c/ZhSh6kqVgOxfgoGSVxLTG
 lLGn3s7K2K8r4sEN4sGujjStAf8TwPKrvw5MUJsxmU1ukPrquNgC6bzrQ/XSmjElfUBT
 BJ6u/FBDb0kerE6TpQ25UQp+FDlcwfoN+3I8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038640; x=1786643440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=omf1LnzDSONXitNVhBvoNyC4TQOAxx0K65CcjW+Kvgg=;
 b=qUz9X2UmwKv02ezdokc5voElYTfbHrx73fpq5dUiWkc5cvYK7J7TTHImNKL9Xk05Gf
 GA06U2s7OJXBZ36UXdjyjk5/sS6Y8Ct0jlrKQiMFOICiIPNv/Ie+4xFl4Mxllk+re6D7
 BZD5C84Pr53IPqiiLfrta0QVmQNenEFZjy2ePHNzJNJxGMkWEYw9AmAbG6tfICdD5oHn
 jp23bCxopy9yR9MPuRF9N2l/GRFwBrWhcaOGyMdQ/bs6opWjoa1AkkR+XGAbWfMJDMLs
 1ojLAYulPXl3bDmczp1zw8LotNRkTgfKWqcyUj+YdGmWZhQo8RWOJmcdnDefSAHqD7XX
 78Hg==
X-Gm-Message-State: AOJu0Yx5nvKK16XhMWcOKxCoyRVSOzyp2fzHMLu9/k15J1coU31z4mJP
 Xn02xKxqBygAtiTxWj1sf+mBmBlxcoyoZFM60V6rHKFvMFMFx8ZOJM0JWJvVGzzJlJ94MjisBYr
 LU+xo8L/fPmaUGWbsCYedZPOgbFWyK16BJwszfnuZpaSBSZ8tRkhfywG3lYuZQf412M6FknTDIc
 /2jxE2z32RxsPUS7ENSYX5XsJhMBg=
X-Gm-Gg: AR+sD13+eD+NKRVihxvatouxBt7ujXGTN6xE3cP70JoKwTJQSumyyPbbNbPzRnOhHr2
 bVIumLKL6WJO6DdUvmMXrWjTQLuP7BYZkZ4E1qSWEES4QixgGfwF74G1JOK9LBvRUNRXcZWQfwc
 va2ns4JNypJTPSPsaUetwU95hXTXjJ7qerbJ5Zboxk6QBvS5/AcRmD8FxMQPil8NeEG0NWQXiwN
 7nmbLM+apgBNjhEzK/F4TigQR+eZepShqq2oxOfLVokG9NmZlMLz/JhhU7ZyvSpJTGCA2mzulX1
 LDAl1XK0pyJAl/QjUyI3Lwm9+h24VdW628ce228fmdezywVpELwvw3pm0rMUsS2TyAMiOzYhYgd
 6ZcDI7RvCknuunt5teGkFV+45656HXk6CTZ7z/pcahJXLpYv1RwMbWyOP61nTfSO1ISHeogApx6
 20GkjovSn1wvMLYcP1i8+zkvWlwOVs9GHLqTEmhr1uHUUTRiod9UqvVPFyYZhiHbMWqCQLHwuXm
 HUUJeRKO7z60NqxQcj6HXZtn0ObZiWK+5UXiek/
X-Received: by 2002:a05:620a:618b:b0:936:315b:a5f4 with SMTP id
 af79cd13be357-9364901e95cmr1809426385a.5.1786038639775; 
 Thu, 06 Aug 2026 10:50:39 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93657688090sm317311285a.27.2026.08.06.10.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:50:39 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 0/7] dts: remove imports from framework in test suites
Date: Thu,  6 Aug 2026 13:50:17 -0400
Message-ID: <20260806175024.13655-1-abailey@iol.unh.edu>
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
 * Included missing linux_session py file
 * Included missing linux_session rst file

Andrew Bailey (7):
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
 .../{framework.params.rst => api.params.rst}  |  6 +-
 ....params.types.rst => api.params.types.rst} |  2 +-
 ...work.test_suite.rst => api.test_suite.rst} |  2 +-
 ...y.rst => api.testbed_model.capability.rst} |  2 +-
 ...odel.cpu.rst => api.testbed_model.cpu.rst} |  2 +-
 ...st => api.testbed_model.linux_session.rst} |  2 +-
 ...el.node.rst => api.testbed_model.node.rst} |  2 +-
 ...n.rst => api.testbed_model.os_session.rst} |  2 +-
 ...el.port.rst => api.testbed_model.port.rst} |  2 +-
 ...st => api.testbed_model.posix_session.rst} |  2 +-
 doc/api/dts/api.testbed_model.rst             | 28 ++++++
 ...ogy.rst => api.testbed_model.topology.rst} |  2 +-
 ...generator.capturing_traffic_generator.rst} |  2 +-
 .../api.testbed_model.traffic_generator.rst   | 16 ++++
 ...testbed_model.traffic_generator.scapy.rst} |  2 +-
 ...l.traffic_generator.traffic_generator.rst} |  2 +-
 ...t => api.testbed_model.virtual_device.rst} |  2 +-
 .../{framework.utils.rst => api.utils.rst}    |  2 +-
 doc/api/dts/framework.linux_session.rst       |  9 ++
 doc/api/dts/framework.testbed_model.rst       | 28 ------
 ...mework.testbed_model.traffic_generator.rst | 16 ----
 doc/api/dts/index.rst                         | 13 +--
 dts/api/artifact.py                           |  6 +-
 dts/api/capabilities.py                       | 14 +--
 dts/{framework => api}/context.py             | 14 +--
 dts/api/cryptodev/__init__.py                 |  6 +-
 dts/api/cryptodev/config.py                   |  6 +-
 dts/{framework => api}/exception.py           |  0
 dts/api/packet.py                             | 18 ++--
 dts/{framework => api}/params/__init__.py     |  0
 dts/{framework => api}/params/eal.py          |  8 +-
 dts/{framework => api}/params/types.py        | 16 ++--
 dts/api/test.py                               |  4 +-
 dts/{framework => api}/test_suite.py          | 15 ++--
 .../testbed_model/__init__.py                 |  0
 .../testbed_model/capability.py               | 18 ++--
 dts/{framework => api}/testbed_model/cpu.py   |  4 +-
 dts/api/testbed_model/linux_session.py        | 45 ++++++++++
 dts/{framework => api}/testbed_model/node.py  |  6 +-
 .../testbed_model/os_session.py               |  8 +-
 dts/{framework => api}/testbed_model/port.py  |  2 +-
 .../testbed_model/posix_session.py            |  6 +-
 .../testbed_model/topology.py                 | 20 ++---
 .../traffic_generator/__init__.py             |  4 +-
 .../capturing_traffic_generator.py            |  4 +-
 .../performance_traffic_generator.py          |  0
 .../testbed_model/traffic_generator/scapy.py  | 14 +--
 .../traffic_generator/traffic_generator.py    |  8 +-
 .../testbed_model/traffic_generator/trex.py   | 18 ++--
 .../testbed_model/virtual_device.py           |  0
 dts/api/testpmd/__init__.py                   | 11 ++-
 dts/api/testpmd/config.py                     |  6 +-
 dts/api/testpmd/types.py                      |  2 +-
 dts/{framework => api}/utils.py               |  2 +-
 dts/framework/config/__init__.py              |  6 +-
 dts/framework/config/node.py                  |  2 +-
 dts/framework/config/test_run.py              | 12 +--
 .../{testbed_model => }/linux_session.py      | 12 ++-
 dts/framework/parser.py                       |  2 +-
 dts/framework/remote_session/blocking_app.py  |  8 +-
 dts/framework/remote_session/dpdk.py          | 16 ++--
 dts/framework/remote_session/dpdk_shell.py    |  6 +-
 .../interactive_remote_session.py             |  2 +-
 .../remote_session/interactive_shell.py       |  8 +-
 .../remote_session/remote_session.py          |  4 +-
 dts/framework/runner.py                       |  4 +-
 dts/framework/test_result.py                  |  5 +-
 dts/framework/test_run.py                     | 24 ++---
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
 dts/tests/TestSuite_packet_capture.py         | 12 +--
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
 dts/tests/TestSuite_virtio_forward.py         |  8 +-
 dts/tests/TestSuite_vlan.py                   |  2 +-
 101 files changed, 382 insertions(+), 371 deletions(-)
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
 rename dts/{framework => api}/params/types.py (93%)
 rename dts/{framework => api}/test_suite.py (98%)
 rename dts/{framework => api}/testbed_model/__init__.py (100%)
 rename dts/{framework => api}/testbed_model/capability.py (98%)
 rename dts/{framework => api}/testbed_model/cpu.py (99%)
 create mode 100644 dts/api/testbed_model/linux_session.py
 rename dts/{framework => api}/testbed_model/node.py (98%)
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
 rename dts/framework/{testbed_model => }/linux_session.py (98%)

--
2.55.0

