Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A8C98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55584402DB;
	Wed, 23 Sep 2026 20:42:14 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 194134027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 20:42:12 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so674531a12.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790188931;
 x=1790793731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fRt0uogU+RB38Prc7YHdqdHryrzFTDIOh5SCzv7bl5Y=;
 b=TujtPQRcu/8wQLPWNouHCRLXvyD4aoPfCzHcNKQxjtLd6TEdHBoZJ3gdgziLW2CWNY
 FZl69WjJKgpU9yzf6fIklnYrPezriO++4DkRkSpQnqq+VBcFobIcZuIoXhrYPEwTH76N
 5fNwHvXe/tgdLMsKzkay94G3idUbJvK6J1zQOKihInwfLoJz7uGC7cL4/kotPjQmQ4sK
 E8U+JAEdCZPlnc2tK5pHU2rhxpaaniga8bFfQcA13U2kBs1PPmDYTh6Pa3DKitlrgo2G
 97PojnIY43jQbTlaRPsi+ykZC+Sja+L2dmzUpyc7Rbf4tDLg+uleey2z6r5cpPdPb61h
 2xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790188931; x=1790793731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fRt0uogU+RB38Prc7YHdqdHryrzFTDIOh5SCzv7bl5Y=;
 b=HNpAEMSpO7tZm+j6oUp01wSB5NfokgbNnOSczC3i/qDIMKX30DZMRHIvzAzC+BCZBk
 MYX43ETXcIP52wzjRfqO9nVl2uOfISqinbqqQKSko2VQvPdWStUJMyN5H+UxFFQX5JJz
 IzUNRB/RyjCNexOU1M9hh/HkUbmOsVNYfwKXP1Tojt0e7hvTv/S5wrhVGb8TiQXZf1WD
 n97UO2IYxhuPSvdKxbKTrGyCEhIOhQXW6lvFQKolabWC2xPmO4bkjtwAujWUnX7jZqeu
 db10fXiNM3LSIHjTKSB63d6Eyn4Q++3BKOdtBtuj3s/XHhVU+1xTGn/J1hBGia+NIvNs
 eLKA==
X-Gm-Message-State: AFuF++k507NIpWvLEhqi9sL1lqAHHhUsyCuuq85UiAB36IZF6vcN8gI4
 McsplUFnblQjgPlw0ON5Ob2JF6bLPuT4fjKMdNF4seO+yWBtjm+Cicb/ZRyoxcpIqYMPpT0K1kb
 RRdDo7wY=
X-Gm-Gg: AYBFou09WRsKLCcXINqQOTh0z/x/RempnBKetQozjDjutISUaUiCCXgbrkVWLOec5gt
 5dCx9BLjITB0eSJ0GQ4kO8yucLBjSbQafIrPfbTuo/aC9WiEP7Nz5Qx3w6C3d5geio1UFEFSOxk
 HcoHe/dlgNh48xpY55JpIH/nS/J0DFWx88xf3tGENi/KD0t7R3Jo95wDuE9gP3/o7HrezCvnNze
 Xh0DGB7L3Z/LcbYh1qpxo5BPK9MjCzArzp8W7tCWFjmgYvSFhcAAY0Vc5/4cH3rYMN4ieat+RxL
 vpu5xYo3TXyZmbd7KzHjWzroHjPGSzhEwKTyz3H+nldScSgYzsNKtufQ3NQkv8y0kfMBhb2p0LN
 XjkGmy1iwXb05GKFtgJ6vtkPYaaAFjn64bFson5yD4Gh2aGnwd/2TUlPXINb4qcrjNCAF6JfTTA
 +7WS9qKqXslobIQgoTmQFiszLtJB63yygvY6Q4ClgGFFKK3HGWpDcdhJ1d2IbDlB2RYEg45nxzX
 u7QYsJNtiuXHr0AW85JFL4g9XKVQjRLJicbhVeKANqmdBDh5hu0EJ796MU=
X-Received: by 2002:a17:90a:d450:b0:3a0:516d:9f7e with SMTP id
 98e67ed59e1d1-3a098e7fd3fmr22032a91.45.1790188930559; 
 Wed, 23 Sep 2026 11:42:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09738f2b6sm389120a91.13.2026.09.23.11.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:42:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>, Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC] devtools: rewrite doc vs code check in Python
Date: Wed, 23 Sep 2026 11:42:07 -0700
Message-ID: <20260923184207.626576-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The existing check-doc-vs-code.sh only compares rte_flow items and
actions, and only for drivers whose directory matches the ini name,
so none of the drivers under net/intel are checked.

Replace it and parse-flow-support.sh with a Python script covering
the whole NIC feature matrix:
 - ini syntax: unknown rows, invalid values, duplicates, row order
 - rte_flow items and actions, keeping the bnxt and dpaa2 exceptions
 - feature rows against eth_dev_ops, fast-path ops, offload and
   capability flags, including full (Y) vs partial (P) support
 - ops that only return -ENOTSUP
 - OS and architecture rows against meson.build and its dependencies
 - incomplete operation sets, e.g. start without stop,
   or Rx timestamp without read_clock
 - rows requiring another row in the same ini

Drivers sharing a directory (PF/VF, e1000/igb/igc) are matched
by their own eth_dev_ops instance or source files.

Given a git reference, only drivers changed since the reference
are checked, and findings already present at the reference are
not reported, so existing documentation gaps do not fail CI.

Documented but not implemented is an error. Implemented but not
documented, and incomplete operation sets, are warnings.
Option -v adds notes such as platforms meson allows but the ini
does not list. Option -g prints ini rows derived from driver code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .github/workflows/build.yml            |    2 +-
 MAINTAINERS                            |    3 +-
 devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
 devtools/check-doc-vs-code.sh          |   84 --
 devtools/parse-flow-support.sh         |   92 --
 doc/guides/contributing/new_driver.rst |    4 +-
 doc/guides/contributing/patches.rst    |   27 +
 doc/guides/nics/features.rst           |    5 +
 8 files changed, 1169 insertions(+), 180 deletions(-)
 create mode 100755 devtools/check-doc-vs-code.py
 delete mode 100755 devtools/check-doc-vs-code.sh
 delete mode 100755 devtools/parse-flow-support.sh

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 1ea5f92e51..ed89043ffd 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -29,7 +29,7 @@ jobs:
         git remote add upstream ${{ env.REF_GIT_REPO }}
         git fetch upstream ${{ env.REF_GIT_BRANCH }}
         failed=
-        devtools/check-doc-vs-code.sh upstream/${{ env.REF_GIT_BRANCH }} || failed=true
+        devtools/check-doc-vs-code.py upstream/${{ env.REF_GIT_BRANCH }} || failed=true
         devtools/check-meson.py || failed=true
         devtools/check-spdx-tag.sh || failed=true
         [ -z "$failed" ]
diff --git a/MAINTAINERS b/MAINTAINERS
index 186cc82b39..bc118ad540 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -88,7 +88,7 @@ F: MAINTAINERS
 F: devtools/build-dict.sh
 F: devtools/check-abi.sh
 F: devtools/check-abi-version.sh
-F: devtools/check-doc-vs-code.sh
+F: devtools/check-doc-vs-code.py
 F: devtools/check-dup-includes.sh
 F: devtools/check-maintainers.sh
 F: devtools/check-forbidden-tokens.awk
@@ -100,7 +100,6 @@ F: devtools/get-maintainer.sh
 F: devtools/git-log-fixes.sh
 F: devtools/load-devel-config
 F: devtools/mailmap-ctl.py
-F: devtools/parse-flow-support.sh
 F: devtools/process-iwyu.py
 F: devtools/update-patches.py
 F: devtools/libabigail.abignore
diff --git a/devtools/check-doc-vs-code.py b/devtools/check-doc-vs-code.py
new file mode 100755
index 0000000000..4cafb739f1
--- /dev/null
+++ b/devtools/check-doc-vs-code.py
@@ -0,0 +1,1132 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+"""
+Check that the NIC feature matrix (doc/guides/nics/features/*.ini)
+agrees with the driver code in drivers/net.
+
+Checks:
+  - ini syntax: unknown rows, invalid values, duplicates, row order
+  - rte_flow items and actions referenced in code vs documented
+  - feature rows vs eth_dev_ops, fast-path ops, offload and capability flags
+  - full (Y) vs partial (P) support
+  - OS and architecture rows vs meson.build (including dependencies)
+  - incomplete operation sets (start without stop, timestamp without clock)
+  - inconsistent rows within one ini (QinQ without VLAN, ...)
+
+Severity:
+  error    row documented without matching code, platform excluded by
+           meson, rte_flow mismatch, invalid ini content
+  warning  code without a documented row, Y where code is partial,
+           incomplete operation set, row order
+  info     (-v) P where code looks complete, platform meson allows
+           but the ini does not list
+
+With a git reference, only drivers changed since that reference are
+checked, and findings already present at the reference are not
+reported. Exit status is 1 if any error is reported.
+
+The mapping of rows to code is the RULES table in this script.
+"""
+
+import argparse
+import os
+import re
+import subprocess
+import sys
+import tempfile
+from collections import namedtuple
+from fnmatch import fnmatch
+
+ROOT = os.path.realpath(os.path.join(os.path.dirname(__file__), '..'))
+NET = 'drivers/net'
+FEATURES = 'doc/guides/nics/features'
+
+ERROR, WARNING, INFO = 0, 1, 2
+LEVEL_NAME = ('error', 'warning', 'info')
+
+# ---------------------------------------------------------------------------
+# Mapping of ini files to driver code.
+#
+# dir:    driver directory relative to drivers/net
+# ops:    regex selecting eth_dev_ops instances that belong to this ini
+# files:  globs of source files belonging to this ini (default all)
+# shared: code is not specific to this ini
+#   'ops' - only the selected eth_dev_ops are specific, so undocumented
+#           features are reported only when backed by an op
+#   'all' - nothing is specific, undocumented features are not reported
+# ---------------------------------------------------------------------------
+Driver = namedtuple('Driver', 'dir ops files shared')
+Driver.__new__.__defaults__ = (None, None, None)
+
+DRIVERS = {
+    'afpacket': Driver('af_packet'),
+    'cnxk': Driver('cnxk', ops=r'cnxk_eth_dev_ops'),
+    'cnxk_vec': Driver('cnxk', ops=r'cnxk_eth_dev_ops', shared='all'),
+    'cnxk_vf': Driver('cnxk', ops=r'cnxk_eth_dev_ops', shared='all'),
+    'cxgbe': Driver('cxgbe', ops=r'cxgbe_eth_dev_ops'),
+    'cxgbevf': Driver('cxgbe', ops=r'cxgbevf_', shared='ops'),
+    'e1000': Driver('intel/e1000', ops=r'eth_em_ops',
+                    files='e1000_*|em_*|base/*'),
+    'enetc': Driver('enetc', ops=r'enetc_ops$',
+                    files='enetc_*|enetc.h|base/*'),
+    'enetc4': Driver('enetc', ops=r'enetc4_ops$',
+                     files='enetc4_ethdev.c|enetc_rxtx.c|enetc.h|base/*'),
+    'enetc4_vf': Driver('enetc', ops=r'enetc4_vf_ops',
+                        files='enetc4_*|enetc_rxtx.c|enetc.h|base/*',
+                        shared='ops'),
+    'failsafe': Driver('failsafe', shared='ops'),
+    'fm10k_vf': Driver('intel/fm10k', shared='all'),
+    'hns3': Driver('hns3', ops=r'hns3_eth_dev_ops'),
+    'hns3_vf': Driver('hns3', ops=r'hns3vf_', shared='ops'),
+    'ice': Driver('intel/ice', ops=r'ice_eth_dev_ops',
+                  files='[!i]*|ice_[!d]*|ice_diagnose.c'),
+    'ice_dcf': Driver('intel/ice', ops=r'ice_dcf_',
+                      files='ice_dcf*|ice_rxtx*|base/*', shared='ops'),
+    'igb': Driver('intel/e1000', ops=r'eth_igb_ops',
+                  files='e1000_*|igb_*|base/*'),
+    'igb_vf': Driver('intel/e1000', ops=r'igbvf_',
+                     files='e1000_*|igb_*|base/*', shared='ops'),
+    'igc': Driver('intel/e1000', ops=r'eth_igc_ops',
+                  files='igc_*|e1000_*|base/*'),
+    'ixgbe': Driver('intel/ixgbe', ops=r'ixgbe_eth_dev_ops'),
+    'ixgbe_vf': Driver('intel/ixgbe', ops=r'ixgbevf_', shared='ops'),
+    'ngbe': Driver('ngbe', ops=r'ngbe_eth_dev_ops'),
+    'ngbe_vf': Driver('ngbe', ops=r'ngbevf_', shared='ops'),
+    'qede': Driver('qede', ops=r'qede_eth_dev_ops'),
+    'qede_vf': Driver('qede', ops=r'qede_eth_vf_', shared='ops'),
+    'txgbe': Driver('txgbe', ops=r'txgbe_eth_dev_ops'),
+    'txgbe_vf': Driver('txgbe', ops=r'txgbevf_', shared='ops'),
+}
+
+# driver directories that have no ini on purpose
+NO_INI = {'intel/common', 'vdev_netvsc'}
+
+# ---------------------------------------------------------------------------
+# Evidence of a feature in code.
+#   op:  eth_dev_ops member set to non-NULL in a selected ops instance
+#   fp:  rte_eth_dev fast-path member assigned
+#   tok: regex found in code (comments and strings removed)
+# A group is satisfied when any of its alternatives is.
+# ---------------------------------------------------------------------------
+Ev = namedtuple('Ev', 'kind names')
+
+
+def op(*names):
+    return Ev('op', names)
+
+
+def fp(*names):
+    return Ev('fp', names)
+
+
+def tok(*names):
+    return Ev('tok', names)
+
+
+def rx(name):
+    return tok(r'\bRTE_ETH_RX_OFFLOAD_' + name + r'\b')
+
+
+def tx(name):
+    return tok(r'\bRTE_ETH_TX_OFFLOAD_' + name + r'\b')
+
+
+def capa(name):
+    return tok(r'\bRTE_ETH_DEV_CAPA_' + name + r'\b')
+
+
+# req: groups needed for full support; some but not all = partial
+# code2doc: report when code has it and doc does not
+# strict: documented without code is an error, else a warning
+#         (used where the features.rst definition is known to be unclear)
+Rule = namedtuple('Rule', 'req code2doc strict')
+Rule.__new__.__defaults__ = (True, True)
+
+RULES = {
+    'Speed capabilities': Rule([tok(r'\bspeed_capa\b')]),
+    'Link speed configuration': Rule([tok(r'\blink_speeds\b')],
+                                     code2doc=False),
+    'Link status': Rule([op('link_update')]),
+    'Link status event': Rule([tok(r'\bRTE_ETH_DEV_INTR_LSC\b',
+                                   r'\bRTE_PCI_DRV_INTR_LSC\b')]),
+    'Removal event': Rule([tok(r'\bRTE_ETH_DEV_INTR_RMV\b',
+                               r'\bRTE_PCI_DRV_INTR_RMV\b',
+                               r'\bRTE_ETH_EVENT_INTR_RMV\b')]),
+    'Queue status event': Rule([tok(r'\bRTE_ETH_EVENT_QUEUE_STATE\b')]),
+    'Rx interrupt': Rule([op('rx_queue_intr_enable'),
+                          op('rx_queue_intr_disable')]),
+    'Lock-free Tx queue': Rule([tx('MT_LOCKFREE')]),
+    'Fast mbuf free': Rule([tx('MBUF_FAST_FREE')]),
+    'Free Tx mbuf on demand': Rule([op('tx_done_cleanup')]),
+    'Queue start/stop': Rule([op('rx_queue_start'), op('rx_queue_stop'),
+                              op('tx_queue_start'), op('tx_queue_stop')]),
+    'Runtime Rx queue setup': Rule([capa('RUNTIME_RX_QUEUE_SETUP')]),
+    'Runtime Tx queue setup': Rule([capa('RUNTIME_TX_QUEUE_SETUP')]),
+    'Runtime queue setup': Rule([capa('RUNTIME_RX_QUEUE_SETUP'),
+                                 capa('RUNTIME_TX_QUEUE_SETUP')]),
+    'Shared Rx queue': Rule([capa('RXQ_SHARE')]),
+    'Burst mode info': Rule([op('rx_burst_mode_get'),
+                             op('tx_burst_mode_get')]),
+    'Power mgmt address monitor': Rule([op('get_monitor_addr')]),
+    'MTU update': Rule([op('mtu_set')]),
+    'Buffer split on Rx': Rule([rx('BUFFER_SPLIT')]),
+    'Selective Rx': Rule([tok(r'\bselective_rx\b')]),
+    'Scattered Rx': Rule([rx('SCATTER')]),
+    'LRO': Rule([rx('TCP_LRO')]),
+    'TSO': Rule([tx('TCP_TSO')]),
+    'Promiscuous mode': Rule([op('promiscuous_enable'),
+                              op('promiscuous_disable')]),
+    'Allmulticast mode': Rule([op('allmulticast_enable'),
+                               op('allmulticast_disable')]),
+    'Unicast MAC filter': Rule([op('mac_addr_add'), op('mac_addr_remove')]),
+    'Multicast MAC filter': Rule([op('set_mc_addr_list')]),
+    'RSS hash': Rule([tok(r'\bRTE_ETH_RX_OFFLOAD_RSS_HASH\b',
+                          r'\bflow_type_rss_offloads\s*\|?=\s*(?!0\s*;)')]),
+    'RSS key update': Rule([op('rss_hash_update'), op('rss_hash_conf_get')]),
+    'RSS reta update': Rule([op('reta_update'), op('reta_query')]),
+    'Inner RSS': Rule([tok(r'\bRTE_ETH_RSS_LEVEL_\w+',
+                           r'\brss\w*(->|\.)level\b')], code2doc=False),
+    'VMDq': Rule([tok(r'\bRTE_ETH_MQ_RX_VMDQ_ONLY\b', r'\bvmdq_rx_conf\b')],
+                 code2doc=False),
+    'DCB': Rule([op('get_dcb_info')]),
+    'VLAN filter': Rule([op('vlan_filter_set')]),
+    'Flow control': Rule([op('flow_ctrl_get'), op('flow_ctrl_set')]),
+    'Rate limitation': Rule([op('set_queue_rate_limit')]),
+    'Congestion management': Rule([op('cman_info_get'),
+                                   op('cman_config_set'),
+                                   op('cman_config_get')]),
+    'Traffic manager': Rule([op('tm_ops_get')]),
+    'Inline crypto': Rule(
+        [tok(r'\bRTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO\b')]),
+    'Inline protocol': Rule(
+        [tok(r'\bRTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL\b')]),
+    'CRC offload': Rule([rx('KEEP_CRC')]),
+    'VLAN offload': Rule([tok(r'\bRTE_ETH_RX_OFFLOAD_VLAN_STRIP\b',
+                              r'\bRTE_ETH_RX_OFFLOAD_VLAN\b'),
+                          tx('VLAN_INSERT')]),
+    'QinQ offload': Rule([tok(r'\bRTE_ETH_RX_OFFLOAD_QINQ_STRIP\b',
+                              r'\bRTE_ETH_RX_OFFLOAD_VLAN_EXTEND\b'),
+                          tx('QINQ_INSERT')]),
+    'FEC': Rule([op('fec_get_capability'), op('fec_get'), op('fec_set')]),
+    'IP reassembly': Rule([op('ip_reassembly_capability_get'),
+                           op('ip_reassembly_conf_get'),
+                           op('ip_reassembly_conf_set')]),
+    'L3 checksum offload': Rule([tok(r'\bRTE_ETH_RX_OFFLOAD_IPV4_CKSUM\b',
+                                     r'\bRTE_ETH_RX_OFFLOAD_CHECKSUM\b'),
+                                 tx('IPV4_CKSUM')]),
+    'L4 checksum offload': Rule([tok(r'\bRTE_ETH_RX_OFFLOAD_UDP_CKSUM\b',
+                                     r'\bRTE_ETH_RX_OFFLOAD_CHECKSUM\b'),
+                                 tok(r'\bRTE_ETH_RX_OFFLOAD_TCP_CKSUM\b',
+                                     r'\bRTE_ETH_RX_OFFLOAD_CHECKSUM\b'),
+                                 tx('UDP_CKSUM'), tx('TCP_CKSUM')]),
+    'Timestamp offload': Rule([rx('TIMESTAMP')]),
+    'MACsec offload': Rule([rx('MACSEC_STRIP'), tx('MACSEC_INSERT')]),
+    'Inner L3 checksum': Rule([rx('OUTER_IPV4_CKSUM'),
+                               tx('OUTER_IPV4_CKSUM')], strict=False),
+    'Inner L4 checksum': Rule([rx('OUTER_UDP_CKSUM'), tx('OUTER_UDP_CKSUM')],
+                              strict=False),
+    'Packet type parsing': Rule([op('dev_supported_ptypes_get')]),
+    'Timesync': Rule([op('timesync_enable'), op('timesync_disable'),
+                      op('timesync_read_rx_timestamp'),
+                      op('timesync_read_tx_timestamp'),
+                      op('timesync_adjust_time'), op('timesync_read_time'),
+                      op('timesync_write_time')]),
+    'Rx descriptor status': Rule([fp('rx_descriptor_status')]),
+    'Tx descriptor status': Rule([fp('tx_descriptor_status')]),
+    'Descriptor status': Rule([fp('rx_descriptor_status'),
+                               fp('tx_descriptor_status')]),
+    'Tx queue count': Rule([fp('tx_queue_count')]),
+    'Basic stats': Rule([op('stats_get')]),
+    'Extended stats': Rule([op('xstats_get'), op('xstats_get_names')]),
+    'Stats per queue': Rule([tok(r'\bq_[io](packets|bytes)\b',
+                                 r'\bRTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS\b')],
+                            strict=False),
+    'FW version': Rule([op('fw_version_get')]),
+    'EEPROM dump': Rule([op('get_eeprom_length'), op('get_eeprom')]),
+    'Module EEPROM dump': Rule([op('get_module_info'),
+                                op('get_module_eeprom')]),
+    'Registers dump': Rule([op('get_reg')]),
+    'LED': Rule([op('dev_led_on'), op('dev_led_off')]),
+    'Multiprocess aware': Rule([tok(r'\bRTE_PROC_SECONDARY\b',
+                                    r'\bRTE_PROC_PRIMARY\b',
+                                    r'\brte_eal_process_type\s*\(')],
+                               code2doc=False),
+}
+
+# rows with no code equivalent
+UNCHECKED = {'Usage doc', 'Design doc', 'Perf doc', 'SR-IOV'}
+
+# rows implied by another row in the same ini: (row, needs one of)
+DOC_IMPLIES = [
+    ('Selective Rx', ['Buffer split on Rx']),
+    ('Link status event', ['Link status']),
+    ('RSS key update', ['RSS hash']),
+    ('RSS reta update', ['RSS hash']),
+    ('Inner RSS', ['RSS hash']),
+    ('QinQ offload', ['VLAN offload']),
+    ('Inner L3 checksum', ['L3 checksum offload']),
+    ('Inner L4 checksum', ['L4 checksum offload']),
+    ('Stats per queue', ['Basic stats']),
+]
+
+# ops that only make sense together
+OP_PAIRS = [
+    ('rx_queue_start', 'rx_queue_stop'),
+    ('tx_queue_start', 'tx_queue_stop'),
+    ('dev_set_link_up', 'dev_set_link_down'),
+    ('promiscuous_enable', 'promiscuous_disable'),
+    ('allmulticast_enable', 'allmulticast_disable'),
+    ('rx_queue_intr_enable', 'rx_queue_intr_disable'),
+    ('dev_led_on', 'dev_led_off'),
+    ('timesync_enable', 'timesync_disable'),
+    ('mac_addr_add', 'mac_addr_remove'),
+    ('udp_tunnel_port_add', 'udp_tunnel_port_del'),
+    ('xstats_enable', 'xstats_disable'),
+    ('hairpin_bind', 'hairpin_unbind'),
+    ('xstats_get', 'xstats_get_names'),
+    ('xstats_get_by_id', 'xstats_get_names_by_id'),
+]
+
+# (have, needs, message): one-way dependencies
+CODE_IMPLIES = [(op(a), op(b), None) for a, b in OP_PAIRS] + \
+    [(op(b), op(a), None) for a, b in OP_PAIRS] + \
+    [(op(a), op(b), None) for a, b in [
+        ('timesync_read_rx_timestamp', 'timesync_enable'),
+        ('timesync_read_tx_timestamp', 'timesync_enable'),
+        ('timesync_adjust_time', 'timesync_read_time'),
+        ('timesync_write_time', 'timesync_read_time'),
+        ('stats_get', 'stats_reset'),
+        ('flow_ctrl_set', 'flow_ctrl_get'),
+        ('reta_update', 'reta_query'),
+        ('rss_hash_update', 'rss_hash_conf_get'),
+        ('fec_set', 'fec_get'),
+        ('fec_set', 'fec_get_capability'),
+        ('get_eeprom', 'get_eeprom_length'),
+        ('set_eeprom', 'get_eeprom_length'),
+        ('get_module_eeprom', 'get_module_info'),
+        ('cman_config_set', 'cman_info_get'),
+        ('cman_config_set', 'cman_config_get'),
+        ('cman_config_set', 'cman_config_init'),
+        ('ip_reassembly_conf_set', 'ip_reassembly_capability_get'),
+        ('ip_reassembly_conf_set', 'ip_reassembly_conf_get'),
+        ('priority_flow_ctrl_queue_config',
+         'priority_flow_ctrl_queue_info_get'),
+        ('rx_hairpin_queue_setup', 'hairpin_cap_get'),
+        ('tx_hairpin_queue_setup', 'hairpin_cap_get'),
+        ('rx_queue_avail_thresh_set', 'rx_queue_avail_thresh_query'),
+        ('speed_lanes_set', 'speed_lanes_get_capa'),
+    ]] + [
+    (op('timesync_enable'), op('timesync_read_time'),
+     'Timesync without timesync_read_time, no way to read device clock'),
+    (rx('TIMESTAMP'), op('read_clock'),
+     'Rx timestamp offload without read_clock, no way to read NIC clock'),
+    (rx('TIMESTAMP'), tok(r'\brte_mbuf_dyn_rx_timestamp_register\s*\('),
+     'Rx timestamp offload without rte_mbuf_dyn_rx_timestamp_register()'),
+    (tx('SEND_ON_TIMESTAMP'), op('read_clock'),
+     'Tx send on timestamp without read_clock, no way to read NIC clock'),
+    (tx('SEND_ON_TIMESTAMP'),
+     tok(r'\brte_mbuf_dyn_tx_timestamp_register\s*\('),
+     'Tx send on timestamp without rte_mbuf_dyn_tx_timestamp_register()'),
+    (tok(r'\bRTE_ETH_DEV_INTR_LSC\b', r'\bRTE_PCI_DRV_INTR_LSC\b'),
+     op('link_update'), 'LSC interrupt without link_update'),
+    (rx('VLAN_FILTER'), op('vlan_filter_set'),
+     'VLAN filter offload without vlan_filter_set'),
+    (rx('BUFFER_SPLIT'), tok(r'\brx_n?seg\b'),
+     'buffer split offload without rx_seg handling'),
+]
+
+OS_ROWS = ('FreeBSD', 'Linux', 'Windows')
+ARCH_ROWS = {
+    'x86-64': ('x86', 'x86_64', {'RTE_ARCH_X86', 'RTE_ARCH_X86_64',
+                                 'RTE_ARCH_64'}),
+    'x86-32': ('x86', 'x86', {'RTE_ARCH_X86', 'RTE_ARCH_I686',
+                              'RTE_ARCH_32'}),
+    'ARMv8': ('arm', 'aarch64', {'RTE_ARCH_ARM64', 'RTE_ARCH_64'}),
+    'ARMv7': ('arm', 'arm', {'RTE_ARCH_ARM', 'RTE_ARCH_ARMv7',
+                             'RTE_ARCH_32'}),
+    'Power8': ('ppc', 'ppc64', {'RTE_ARCH_PPC_64', 'RTE_ARCH_64'}),
+    'LoongArch64': ('loongarch', 'loongarch64', {'RTE_ARCH_LOONGARCH',
+                                                 'RTE_ARCH_64'}),
+    'rv64': ('riscv', 'riscv64', {'RTE_ARCH_RISCV', 'RTE_ARCH_64'}),
+}
+
+# rte_flow exceptions carried over from parse-flow-support.sh:
+# driver -> (file, marker on following line, extra excluded tokens)
+FLOW_EXCLUDE = {
+    'bnxt': ('tf_ulp/ulp_rte_handler_tbl.c', 'TYPE_NOT_SUPPORTED',
+             {'RTE_FLOW_ACTION_TYPE_SHARED'}),
+    'dpaa2': ('dpaa2_flow.c', 'Skip this', set()),
+}
+FLOW_IGNORE = {'void', 'indirect', 'end'}
+
+
+# ---------------------------------------------------------------------------
+# ini parsing
+# ---------------------------------------------------------------------------
+class Ini:
+    def __init__(self, path):
+        self.path = path
+        self.sections = {}      # name -> list of (key, value, line)
+        section = None
+        with open(path, encoding='utf-8') as f:
+            for lineno, line in enumerate(f, 1):
+                line = line.strip()
+                if not line or line[0] in ';#':
+                    continue
+                if line.startswith('['):
+                    section = line.strip('[]')
+                    self.sections.setdefault(section, [])
+                    continue
+                if section is None or '=' not in line:
+                    continue
+                key, _, value = line.partition('=')
+                self.sections[section].append((key.strip(), value.strip(),
+                                               lineno))
+
+    def rows(self, section):
+        return {k.lower(): v for k, v, _ in self.sections.get(section, [])}
+
+
+# ---------------------------------------------------------------------------
+# C source scanning
+# ---------------------------------------------------------------------------
+C_STRIP = re.compile(r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\\n])*"'
+                     r"|'(?:\\.|[^'\\\n])*'", re.S)
+IF0 = re.compile(r'^\s*#\s*if\s+0\b.*?^\s*#\s*(endif|else)\b', re.S | re.M)
+
+
+def strip_c(text):
+    def repl(m):
+        s = m.group(0)
+        if s.startswith('/'):
+            return ' ' if s.startswith('//') else '\n' * s.count('\n') or ' '
+        return s[0] * 2
+    return IF0.sub('', C_STRIP.sub(repl, text))
+
+
+def match_brace(text, start):
+    """return index after the brace matching text[start] == '{'"""
+    depth = 0
+    for i in range(start, len(text)):
+        c = text[i]
+        if c == '{':
+            depth += 1
+        elif c == '}':
+            depth -= 1
+            if depth == 0:
+                return i + 1
+    return len(text)
+
+
+OPS_DECL = re.compile(r'struct\s+eth_dev_ops\s+(\w+)\s*(\[\s*\w*\s*\])?'
+                      r'\s*=\s*\{')
+MEMBER = re.compile(r'\.\s*(\w+)\s*=\s*([^,}]+)')
+FP_MEMBERS = ('rx_descriptor_status', 'tx_descriptor_status',
+              'rx_queue_count', 'tx_queue_count', 'tx_pkt_prepare')
+FP_ASSIGN = {m: re.compile(m + r'\s*=\s*(\w+)') for m in FP_MEMBERS}
+NULL_VALUES = {'NULL', '0'}
+STUB_BODY = re.compile(r'^(?:(?:RTE_SET_USED\s*\([^;]*\)|\(\s*void\s*\)\s*\w+'
+                       r'|\w*LOG\w*\s*\([^;]*\))\s*;\s*)*'
+                       r'return\s*-?\s*\(?\s*(ENOTSUP|ENOSYS|EOPNOTSUPP)'
+                       r'\s*\)?\s*;\s*$', re.S)
+
+
+FUNC_DEF = re.compile(r'^(?:[A-Za-z_][\w \t*]*[\s*])?(\w+)\s*\([^;{}]*\)\s*\{',
+                      re.M)
+
+
+class Code:
+    """Facts extracted from the sources of one driver (or a subset)."""
+
+    def __init__(self, path, files=None, ops_filter=None):
+        self.path = path
+        self.texts = {}
+        for root, _, names in os.walk(path):
+            for name in sorted(names):
+                if not name.endswith(('.c', '.h')):
+                    continue
+                full = os.path.join(root, name)
+                rel = os.path.relpath(full, path)
+                if files and not any(fnmatch(rel, g)
+                                     for g in files.split('|')):
+                    continue
+                with open(full, encoding='utf-8', errors='replace') as f:
+                    self.texts[rel] = strip_c(f.read())
+        self.text = '\n'.join(self.texts.values())
+        self.found = {}
+        self.funcs = None
+        self.ops = {}           # member -> function name
+        self.ops_structs = set()
+        self.fp = {}
+        self._parse_ops(ops_filter)
+        self._parse_fp()
+        self.stubs = {m: f for m, f in self.ops.items() if self._is_stub(f)}
+
+    def _parse_ops(self, ops_filter):
+        for m in OPS_DECL.finditer(self.text):
+            name = m.group(1)
+            if ops_filter and not re.search(ops_filter, name):
+                continue
+            self.ops_structs.add(name)
+            body = self.text[m.end() - 1:match_brace(self.text, m.end() - 1)]
+            for member, value in MEMBER.findall(body):
+                value = value.strip()
+                if value not in NULL_VALUES:
+                    self.ops.setdefault(member, value)
+        # runtime assignment to a known ops instance
+        for name in self.ops_structs:
+            if self.text.count(name) < 2:
+                continue
+            pat = re.escape(name) + r'\s*(?:\.|->)\s*(\w+)\s*=\s*([^;=][^;]*);'
+            for m in re.finditer(pat, self.text):
+                value = m.group(2).strip()
+                if self.text[m.start() - 1:m.start()].isidentifier():
+                    continue
+                if value not in NULL_VALUES:
+                    self.ops.setdefault(m.group(1), value)
+
+    def _parse_fp(self):
+        for member, pat in FP_ASSIGN.items():
+            for m in pat.finditer(self.text):
+                before = self.text[:m.start()].rstrip()[-2:]
+                if (before[-1:] == '.' or before == '->') \
+                        and m.group(1) not in NULL_VALUES:
+                    self.fp.setdefault(member, m.group(1))
+                    break
+
+    def _find(self, pattern):
+        """regex search; a leading \\bIDENT is matched as a literal"""
+        m = re.match(r'\\b(\w+)', pattern)
+        if not m:
+            return re.search(pattern, self.text) is not None
+        lit = m.group(1)
+        if lit not in self.text:
+            return False
+        for m in re.finditer(re.escape(lit) + pattern[m.end():], self.text):
+            if not self.text[m.start() - 1:m.start()].isidentifier():
+                return True
+        return False
+
+    def _is_stub(self, func):
+        if self.funcs is None:
+            self.funcs = {}
+            for key, text in self.texts.items():
+                for m in FUNC_DEF.finditer(text):
+                    self.funcs.setdefault(m.group(1), (key, m.end() - 1))
+        if func not in self.funcs:
+            return False
+        key, start = self.funcs[func]
+        text = self.texts[key]
+        body = text[start + 1:match_brace(text, start) - 1].strip()
+        return bool(STUB_BODY.match(body))
+
+    def _search(self, pattern):
+        if pattern not in self.found:
+            self.found[pattern] = self._find(pattern)
+        return self.found[pattern]
+
+    def has(self, ev, precise_only=False):
+        if ev.kind == 'op':
+            return any(n in self.ops and n not in self.stubs
+                       for n in ev.names)
+        if precise_only:
+            return None
+        if ev.kind == 'fp':
+            return any(n in self.fp for n in ev.names)
+        return any(self._search(n) for n in ev.names)
+
+    def tokens(self, prefix):
+        return {m.group(0) for m in re.finditer(prefix + r'\w+', self.text)
+                if not self.text[m.start() - 1:m.start()].isidentifier()}
+
+
+# ---------------------------------------------------------------------------
+# meson.build evaluation for OS/arch support
+# ---------------------------------------------------------------------------
+class Undecidable(Exception):
+    pass
+
+
+class MesonConf:
+    def __init__(self, keys):
+        self.keys = keys
+
+    def _check(self, key):
+        if not key.startswith('RTE_ARCH_') or key == 'RTE_ARCH':
+            raise Undecidable(key)
+
+    def get(self, key, *_):
+        self._check(key)
+        return key in self.keys
+
+    def has(self, key):
+        self._check(key)
+        return key in ('RTE_ARCH_64', 'RTE_ARCH_32') or key in self.keys
+
+
+class MesonHost:
+    def __init__(self, cpu):
+        self.cpu = cpu
+
+    def cpu_family(self):
+        return self.cpu
+
+
+MESON_TOKEN = re.compile(r"\s+|'[^']*'|\d+|[A-Za-z_]\w*|==|!=|[().,]")
+MESON_NAMES = {'is_linux', 'is_freebsd', 'is_windows', 'arch_subdir',
+               'dpdk_conf', 'host_machine', 'cpu_family', 'get', 'has',
+               'startswith', 'and', 'or', 'not', 'true', 'false'}
+
+
+def meson_eval(expr, env):
+    """Evaluate a meson condition for a platform, None if not decidable."""
+    pos = 0
+    out = []
+    while pos < len(expr):
+        m = MESON_TOKEN.match(expr, pos)
+        if not m:
+            return None
+        t = m.group(0)
+        pos = m.end()
+        if re.fullmatch(r'[A-Za-z_]\w*', t):
+            if t not in MESON_NAMES:
+                return None
+            t = {'true': 'True', 'false': 'False'}.get(t, t)
+        out.append(t)
+    try:
+        return bool(eval(''.join(out), {'__builtins__': {}}, env))
+    except (Undecidable, AttributeError, NameError, SyntaxError, TypeError):
+        return None
+
+
+def meson_statements(path):
+    """Parse meson.build into a tree of if/foreach blocks and statements."""
+    with open(path, encoding='utf-8') as f:
+        raw = f.read().splitlines()
+    lines = []
+    buf = ''
+    for line in raw:
+        line = re.sub(r"#(?=(?:[^']*'[^']*')*[^']*$).*", '', line).strip()
+        buf = (buf + ' ' + line).strip()
+        if buf.count('(') + buf.count('[') > buf.count(')') + buf.count(']'):
+            continue
+        if buf:
+            lines.append(buf)
+        buf = ''
+
+    def block(i, end_words):
+        nodes = []
+        while i < len(lines):
+            line = lines[i]
+            word = line.split(None, 1)[0]
+            if word in end_words:
+                return nodes, i
+            if word == 'if':
+                branches = []
+                cond = line[2:].strip()
+                orelse = None
+                while True:
+                    body, i = block(i + 1, ('elif', 'else', 'endif'))
+                    if orelse is not None:
+                        orelse = body
+                    else:
+                        branches.append((cond, body))
+                    word = lines[i].split(None, 1)[0] if i < len(lines) \
+                        else 'endif'
+                    if word == 'elif':
+                        cond = lines[i][4:].strip()
+                    elif word == 'else':
+                        orelse = []
+                    else:
+                        break
+                nodes.append(('if', branches, orelse or []))
+            elif word == 'foreach':
+                _, i = block(i + 1, ('endforeach',))
+            else:
+                nodes.append(('stmt', line))
+            i += 1
+        return nodes, i
+
+    return block(0, ())[0]
+
+
+class Meson:
+    def __init__(self, root):
+        self.root = root
+        self.trees = {}
+        self.cache = {}
+
+    def _tree(self, path):
+        if path not in self.trees:
+            self.trees[path] = meson_statements(path) \
+                if os.path.exists(path) else []
+        return self.trees[path]
+
+    def _dep_path(self, dep):
+        if '_' in dep:
+            cls, name = dep.split('_', 1)
+            base = os.path.join(self.root, 'drivers', cls)
+            for cand in (os.path.join(base, name),
+                         os.path.join(base, 'intel', name)):
+                if os.path.isdir(cand):
+                    return cand
+        cand = os.path.join(self.root, 'lib', dep)
+        return cand if os.path.isdir(cand) else None
+
+    def _run(self, nodes, env, state):
+        for node in nodes:
+            if node[0] == 'if':
+                taken = False
+                unknown = False
+                for cond, body in node[1]:
+                    v = meson_eval(cond, env)
+                    if v is None:
+                        unknown = True
+                    elif v:
+                        taken = True
+                        if not self._run(body, env, state):
+                            return False
+                        break
+                if not taken and not unknown:
+                    if not self._run(node[2], env, state):
+                        return False
+                continue
+            stmt = node[1]
+            m = re.match(r'build\s*=\s*(.*)$', stmt)
+            if m:
+                if meson_eval(m.group(1), env) is False:
+                    state['build'] = False
+                continue
+            m = re.match(r'deps\s*\+?=\s*(.*)$', stmt)
+            if m:
+                state['deps'].update(re.findall(r"'([\w]+)'", m.group(1)))
+                continue
+            if stmt.startswith('subdir_done()'):
+                return False
+        return True
+
+    def buildable(self, path, platform, env, seen=()):
+        key = (path, platform)
+        if key in self.cache:
+            return self.cache[key]
+        state = {'build': True, 'deps': set()}
+        self._run(self._tree(os.path.join(path, 'meson.build')), env, state)
+        result = (state['build'], None if state['build'] else
+                  os.path.relpath(path, self.root))
+        if result[0]:
+            for dep in sorted(state['deps']):
+                dpath = self._dep_path(dep)
+                if not dpath or dpath in seen or dpath == path:
+                    continue
+                ok, why = self.buildable(dpath, platform, env,
+                                         seen + (path,))
+                if not ok:
+                    result = (False, why)
+                    break
+        self.cache[key] = result
+        return result
+
+
+def platform_env(os_name, arch):
+    subdir, cpu, keys = ARCH_ROWS[arch]
+    return {'is_linux': os_name == 'Linux',
+            'is_freebsd': os_name == 'FreeBSD',
+            'is_windows': os_name == 'Windows',
+            'arch_subdir': subdir,
+            'dpdk_conf': MesonConf(keys),
+            'host_machine': MesonHost(cpu)}
+
+
+def platform_support(meson, path):
+    """row -> (buildable, blocking component)"""
+    res = {}
+    for os_name in OS_ROWS:
+        res[os_name] = meson.buildable(path, os_name,
+                                       platform_env(os_name, 'x86-64'))
+    for arch in ARCH_ROWS:
+        res[arch] = meson.buildable(path, 'Linux-' + arch,
+                                    platform_env('Linux', arch))
+    return res
+
+
+# ---------------------------------------------------------------------------
+# checks
+# ---------------------------------------------------------------------------
+class Report(list):
+    def __call__(self, level, name, msg):
+        self.append((name, level, msg))
+
+    def keys(self):
+        # line numbers move when unrelated rows change
+        return {(n, lvl, re.sub(r'^line \d+: ', '', m)) for n, lvl, m in self}
+
+
+def support(code, rule, precise_only):
+    """return 'Y', 'P', '' or None (not decidable)"""
+    hits = [code.has(ev, precise_only) for ev in rule.req]
+    if None in hits:
+        return None
+    if all(hits):
+        return 'Y'
+    return 'P' if any(hits) else ''
+
+
+def ev_str(ev):
+    """readable form of the evidence patterns"""
+    def clean(pat):
+        pat = re.sub(r'\(\?!.*?\)|\\s\*|\\b|\\\|\?=|\\s\*\\\(', '', pat)
+        pat = re.sub(r'\\w[+*]', '*', pat)
+        pat = pat.replace('(->|\\.)', '.')
+        pat = re.sub(r'.\?', '', pat).replace('\\', '')
+        return pat.rstrip('=( ')
+    return '|'.join(clean(n) for n in ev.names)
+
+
+def misplaced(order):
+    """indexes not in a longest increasing subsequence of order"""
+    best = [1] * len(order)
+    prev = [-1] * len(order)
+    for i, v in enumerate(order):
+        for j in range(i):
+            if order[j] < v and best[j] + 1 > best[i]:
+                best[i], prev[i] = best[j] + 1, j
+    keep = set()
+    i = max(range(len(order)), key=best.__getitem__, default=-1)
+    while i >= 0:
+        keep.add(i)
+        i = prev[i]
+    return [i for i in range(len(order)) if i not in keep]
+
+
+def check_ini_syntax(name, ini, default, report):
+    for section, entries in ini.sections.items():
+        valid = [k.lower() for k, _, _ in default.sections.get(section, [])]
+        if section not in default.sections:
+            report(ERROR, name, 'unknown section [%s]' % section)
+            continue
+        seen = set()
+        known = []
+        for key, value, lineno in entries:
+            k = key.lower()
+            if k not in valid:
+                report(ERROR, name, 'line %d: unknown row "%s" in [%s]'
+                       % (lineno, key, section))
+                continue
+            if k in seen:
+                report(ERROR, name, 'line %d: duplicate row "%s"'
+                       % (lineno, key))
+            seen.add(k)
+            allowed = ('Y', 'P', 'I') if section == 'rte_flow actions' \
+                else ('Y', 'P')
+            if value and value not in allowed:
+                report(ERROR, name, 'line %d: invalid value "%s" for "%s"'
+                       % (lineno, value, key))
+            known.append((valid.index(k), lineno, key))
+        bad = misplaced([idx for idx, _, _ in known])
+        if bad:
+            rows = ', '.join('"%s"' % known[i][2] for i in bad)
+            report(WARNING, name, 'line %d: %s not in default.ini order'
+                   % (known[bad[0]][1], rows))
+
+
+def check_flow(name, drv, code, ini, report):
+    if drv.shared:
+        return
+    excluded = set()
+    exc = FLOW_EXCLUDE.get(os.path.basename(drv.dir))
+    if exc:
+        # the marker may be a comment, so scan the raw file
+        fname, marker, extra = exc
+        excluded |= extra
+        with open(os.path.join(code.path, fname), encoding='utf-8') as f:
+            raw = f.read().splitlines()
+        for cur, nxt in zip(raw, raw[1:]):
+            if marker in nxt:
+                excluded |= set(re.findall(
+                    r'\bRTE_FLOW_(?:ITEM|ACTION)_TYPE_\w+', cur))
+
+    has_flow_ops = 'flow_ops_get' in code.ops
+    for kind in ('item', 'action'):
+        prefix = 'RTE_FLOW_%s_TYPE_' % kind.upper()
+        in_code = {t[len(prefix):].lower() for t in code.tokens(prefix)
+                   if t not in excluded}
+        in_code -= FLOW_IGNORE
+        in_doc = {k for k, v in ini.rows('rte_flow %ss' % kind).items()}
+        for t in sorted(in_code - in_doc):
+            report(ERROR, name, 'rte_flow %s %s not documented' % (kind, t))
+        for t in sorted(in_doc - in_code):
+            report(ERROR, name, 'rte_flow %s %s documented, not in code'
+                   % (kind, t))
+        if in_doc and not has_flow_ops and code.ops:
+            report(ERROR, name, 'rte_flow %ss documented without flow_ops_get'
+                   % kind)
+
+
+def check_features(name, drv, code, ini, default, report):
+    rows = ini.rows('Features')
+    for row, _, _ in default.sections.get('Features', []):
+        rule = RULES.get(row)
+        if rule is None:
+            continue
+        doc = rows.get(row.lower(), '')[:1]
+        have = support(code, rule, False)
+        if drv.shared == 'all':
+            exact = None
+        elif drv.shared == 'ops':
+            exact = support(code, rule, True)
+        else:
+            exact = have
+
+        if doc and have == '':
+            stub = [n for ev in rule.req if ev.kind == 'op'
+                    for n in ev.names if n in code.stubs]
+            why = '%s only returns an error' % ', '.join(stub) if stub \
+                else 'no ' + ' or '.join(ev_str(ev) for ev in rule.req)
+            report(ERROR if rule.strict else WARNING, name,
+                   '"%s" documented, %s' % (row, why))
+            continue
+        if not doc:
+            if have and rule.code2doc and exact:
+                report(WARNING, name, '"%s" implemented, not documented%s'
+                       % (row, '' if have == 'Y' else ' (partial)'))
+            continue
+        if doc == 'Y' and have == 'P':
+            missing = [ev_str(ev) for ev in rule.req
+                       if not code.has(ev)]
+            report(WARNING, name, '"%s" documented Y, partial in code '
+                   '(missing %s)' % (row, ', '.join(missing)))
+        elif doc == 'P' and have == 'Y' and not drv.shared:
+            report(INFO, name, '"%s" documented P, all of %s present'
+                   % (row, ', '.join(ev_str(ev) for ev in rule.req)))
+
+    present = {k for k, v in rows.items() if v}
+    valid = {k.lower() for k, _, _ in default.sections.get('Features', [])}
+    for row, needs in DOC_IMPLIES:
+        needs = [n for n in needs if n.lower() in valid]
+        if row.lower() in present and needs and \
+                not present.intersection(n.lower() for n in needs):
+            report(WARNING, name, '"%s" documented without "%s"'
+                   % (row, '" or "'.join(needs)))
+
+
+def check_code(name, drv, code, report):
+    for member, func in sorted(code.stubs.items()):
+        report(WARNING, name, '%s = %s only returns an error, leave it NULL'
+               % (member, func))
+    for have, need, msg in CODE_IMPLIES:
+        if drv.shared and (have.kind, need.kind) != ('op', 'op'):
+            continue
+        if need.kind == 'op' and any(n in code.stubs for n in need.names):
+            continue
+        if code.has(have) and not code.has(need):
+            report(WARNING, name, msg or '%s without %s'
+                   % (ev_str(have), ev_str(need)))
+
+
+def check_platform(name, drv, ini, meson, report):
+    rows = ini.rows('Features')
+    sup = platform_support(meson, os.path.join(meson.root, NET, drv.dir))
+    for row, (ok, why) in sup.items():
+        doc = rows.get(row.lower(), '')
+        if doc and not ok:
+            report(ERROR, name, '"%s" documented, build disabled by %s'
+                   % (row, why))
+        elif not doc and ok and not drv.shared:
+            report(INFO, name, '"%s" not documented, meson allows build'
+                   % row)
+    if not any(rows.get(r.lower()) for r in OS_ROWS):
+        report(WARNING, name, 'no OS documented')
+    if not any(rows.get(r.lower()) for r in ARCH_ROWS):
+        report(WARNING, name, 'no architecture documented')
+
+
+def driver_for(root, ini_name):
+    drv = DRIVERS.get(ini_name)
+    if drv:
+        return drv
+    for cand in (ini_name, 'intel/' + ini_name):
+        if os.path.isdir(os.path.join(root, NET, cand)):
+            return Driver(cand)
+    return None
+
+
+def all_inis(root):
+    return sorted(f[:-4] for f in os.listdir(os.path.join(root, FEATURES))
+                  if f.endswith('.ini') and f != 'default.ini')
+
+
+def all_dirs(root):
+    dirs = []
+    net = os.path.join(root, NET)
+    for d in sorted(os.listdir(net)):
+        if d == 'intel':
+            dirs += ['intel/' + s for s in sorted(os.listdir(
+                     os.path.join(net, d)))
+                     if os.path.isdir(os.path.join(net, d, s))]
+        elif os.path.isdir(os.path.join(net, d)):
+            dirs.append(d)
+    return dirs
+
+
+def git(*args):
+    try:
+        return subprocess.run(['git', '-C', ROOT] + list(args), check=True,
+                              stdout=subprocess.PIPE,
+                              stderr=subprocess.PIPE).stdout
+    except subprocess.CalledProcessError as e:
+        sys.exit(e.stderr.decode().strip())
+
+
+def changed_inis(ref):
+    """ini names affected by changes since ref, None for all"""
+    files = git('diff', '--name-only', ref + '...HEAD').decode().split()
+    myself = os.path.relpath(os.path.realpath(__file__), ROOT)
+    if any(f in (FEATURES + '/default.ini', myself) for f in files):
+        return None
+    inis = set()
+    dir_to_inis = {}
+    for n in all_inis(ROOT):
+        drv = driver_for(ROOT, n)
+        if drv:
+            dir_to_inis.setdefault(drv.dir, set()).add(n)
+    for f in files:
+        m = re.match(re.escape(FEATURES) + r'/(\w+)\.ini$', f)
+        if m:
+            inis.add(m.group(1))
+            continue
+        for d, names in dir_to_inis.items():
+            if f.startswith('%s/%s/' % (NET, d)):
+                inis |= names
+    return sorted(inis)
+
+
+def extract_ref(ref, inis, dest):
+    """write the files needed to check inis at ref into dest"""
+    dirs = {driver_for(ROOT, n).dir for n in inis if driver_for(ROOT, n)}
+    paths = [FEATURES, ':(glob)drivers/**/meson.build',
+             ':(glob)lib/*/meson.build']
+    paths += [NET + '/' + d for d in sorted(dirs)
+              if git('ls-tree', '-d', ref, NET + '/' + d).strip()]
+    tar = git('archive', '--format=tar', ref, '--', *paths)
+    subprocess.run(['tar', '-x', '-C', dest], input=tar, check=True)
+
+
+def check(root, inis, report, full=False):
+    features = os.path.join(root, FEATURES)
+    default = Ini(os.path.join(features, 'default.ini'))
+    meson = Meson(root)
+    for row, _, _ in default.sections.get('Features', []):
+        if row not in RULES and row not in UNCHECKED and \
+                row not in OS_ROWS and row not in ARCH_ROWS:
+            report(INFO, 'default.ini', 'no rule for "%s"' % row)
+    if full:
+        mapped = {driver_for(root, n).dir for n in inis
+                  if driver_for(root, n)}
+        for d in all_dirs(root):
+            if d not in mapped and d not in NO_INI:
+                report(WARNING, d, 'no features ini')
+    for name in inis:
+        path = os.path.join(features, name + '.ini')
+        if not os.path.exists(path):
+            continue
+        drv = driver_for(root, name)
+        ini = Ini(path)
+        check_ini_syntax(name, ini, default, report)
+        if drv is None:
+            report(ERROR, name, 'no driver directory')
+            continue
+        code = Code(os.path.join(root, NET, drv.dir), drv.files, drv.ops)
+        check_flow(name, drv, code, ini, report)
+        check_features(name, drv, code, ini, default, report)
+        if drv.shared != 'all':
+            check_code(name, drv, code, report)
+        check_platform(name, drv, ini, meson, report)
+
+
+def generate(name):
+    """print a suggested ini from the code"""
+    drv = driver_for(ROOT, name)
+    if not drv:
+        sys.exit('%s: no driver directory' % name)
+    default = Ini(os.path.join(ROOT, FEATURES, 'default.ini'))
+    path = os.path.join(ROOT, NET, drv.dir)
+    code = Code(path, drv.files, drv.ops)
+    sup = platform_support(Meson(ROOT), path)
+    print(';\n; Supported features of the \'%s\' network poll mode driver.'
+          '\n;\n; Refer to default.ini for the full list of available PMD '
+          'features.\n;\n[Features]' % name)
+    for row, _, _ in default.sections['Features']:
+        if row in sup:
+            val = 'Y' if sup[row][0] else ''
+        elif row in RULES:
+            val = support(code, RULES[row], False)
+        else:
+            continue
+        if val:
+            print('%-20s = %s' % (row, val))
+    for kind in ('item', 'action'):
+        prefix = 'RTE_FLOW_%s_TYPE_' % kind.upper()
+        toks = sorted({t[len(prefix):].lower() for t in code.tokens(prefix)}
+                      - FLOW_IGNORE)
+        if toks:
+            print('\n[rte_flow %ss]' % kind)
+            for t in toks:
+                print('%-20s = Y' % t)
+
+
+def main():
+    ap = argparse.ArgumentParser(
+        description=__doc__,
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        epilog='''examples:
+  %(prog)s                  check all drivers
+  %(prog)s origin/main      check what this branch introduces
+  %(prog)s -q -d ice        errors for one ini
+  %(prog)s -g ice           ini rows supported by the code''')
+    ap.add_argument('ref', nargs='?',
+                    help='check drivers changed since this git ref, '
+                    'report only what is new')
+    ap.add_argument('-d', '--driver', action='append', default=[],
+                    help='check only this ini name (repeatable)')
+    ap.add_argument('-g', '--generate', metavar='DRIVER',
+                    help='print ini content derived from code')
+    ap.add_argument('-q', '--quiet', action='store_true',
+                    help='report errors only')
+    ap.add_argument('-v', '--verbose', action='store_true',
+                    help='report informational notes too')
+    args = ap.parse_args()
+
+    if args.generate:
+        generate(args.generate)
+        return 0
+
+    report = Report()
+    if args.ref:
+        inis = args.driver or changed_inis(args.ref)
+        if inis is None:
+            inis = all_inis(ROOT)
+        check(ROOT, inis, report)
+        if report:
+            old = Report()
+            with tempfile.TemporaryDirectory() as tmp:
+                extract_ref(args.ref, inis, tmp)
+                check(tmp, inis, old)
+            known = old.keys()
+            report = [r for r in report
+                      if (r[0], r[1], re.sub(r'^line \d+: ', '', r[2]))
+                      not in known]
+    else:
+        inis = args.driver or all_inis(ROOT)
+        check(ROOT, inis, report, full=not args.driver)
+
+    level = ERROR if args.quiet else INFO if args.verbose else WARNING
+    for name, lvl, msg in report:
+        if lvl <= level:
+            print('%s: %s: %s' % (name, LEVEL_NAME[lvl], msg))
+    return 1 if any(lvl == ERROR for _, lvl, _ in report) else 0
+
+
+if __name__ == '__main__':
+    sys.exit(main())
diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
deleted file mode 100755
index c58c239c87..0000000000
--- a/devtools/check-doc-vs-code.sh
+++ /dev/null
@@ -1,84 +0,0 @@
-#! /bin/sh -e
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2021 Mellanox Technologies, Ltd
-
-# Check whether doc & code are in sync.
-# Optional argument: check only what changed since a commit.
-trusted_commit=$1 # example: origin/main
-
-selfdir=$(dirname $(readlink -f $0))
-rootdir=$(readlink -f $selfdir/..)
-
-# speed up by ignoring Unicode details
-export LC_COLLATE=C
-
-result=0
-error() # <message>
-{
-	echo "$*"
-	result=$(($result + 1))
-}
-
-changed_files()
-{
-	[ -n "$files" ] ||
-		files=$(git diff-tree --name-only -r $trusted_commit..)
-	echo "$files"
-}
-
-has_code_change() # <pattern>
-{
-	test -n "$(git log --format='%h' -S"$1" $trusted_commit..)"
-}
-
-has_file_change() # <pattern>
-{
-	changed_files | grep -q "$1"
-}
-
-changed_net_drivers()
-{
-	net_paths='drivers/net/|doc/guides/nics/features/'
-	[ -n "$drivers" ] ||
-		drivers=$(changed_files |
-			sed -rn "s,^($net_paths)([^./]*).*,\2,p" |
-			sort -u)
-	echo "$drivers"
-}
-
-all_net_drivers()
-{
-	find $rootdir/drivers/net -mindepth 1 -maxdepth 1 -type d |
-	sed 's,.*/,,' |
-	sort
-}
-
-check_rte_flow() # <driver>
-{
-	code=$rootdir/drivers/net/$1
-	doc=$rootdir/doc/guides/nics/features/$1.ini
-	[ -d $code ] || return 0
-	[ -f $doc ] || return 0
-	report=$($selfdir/parse-flow-support.sh $code $doc)
-	if [ -n "$report" ]; then
-		error "rte_flow doc out of sync for $1"
-		echo "$report" | sed 's,^,\t,'
-	fi
-}
-
-if [ -z "$trusted_commit" ]; then
-	# check all
-	for driver in $(all_net_drivers); do
-		check_rte_flow $driver
-	done
-	exit $result
-fi
-
-# find what changed and check
-if has_code_change 'RTE_FLOW_.*_TYPE_' ||
-		has_file_change 'doc/guides/nics/features'; then
-	for driver in $(changed_net_drivers); do
-		check_rte_flow $driver
-	done
-fi
-exit $result
diff --git a/devtools/parse-flow-support.sh b/devtools/parse-flow-support.sh
deleted file mode 100755
index 44b4cecafd..0000000000
--- a/devtools/parse-flow-support.sh
+++ /dev/null
@@ -1,92 +0,0 @@
-#! /bin/sh -e
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2021 Mellanox Technologies, Ltd
-
-# Parse rte_flow support of a driver directory,
-# and optionally show difference with a doc file in .ini format.
-
-dir=$1 # drivers/net/foo
-ref=$2 # doc/guides/nics/features/foo.ini
-
-if [ -z "$dir" ]; then
-	echo "directory argument is required" >&2
-	exit 1
-fi
-
-# test git-grep for -o (--only-matching) option
-if ! git grep -qo git -- $0 >/dev/null 2>&1; then
-	echo "git version >= 2.19 is required" >&2
-	exit 1
-fi
-
-# sorting order
-export LC_COLLATE=C
-
-# exclude exceptions
-exclude() # <pattern>
-{
-	case $(basename $dir) in
-		bnxt)
-			filter=$(sed -n "/$1/{N;/TYPE_NOT_SUPPORTED/P;}" \
-				$dir/tf_ulp/ulp_rte_handler_tbl.c |
-				grep -wo "$1[[:alnum:]_]*" | sort -u |
-				tr '\n' '|' | sed 's,.$,\n,')
-			exceptions='RTE_FLOW_ACTION_TYPE_SHARED'
-			grep -vE "$filter" | grep -vE $exceptions;;
-		dpaa2)
-			filter=$(sed -n "/$1/{N;/Skip this/P;}" \
-				$dir/dpaa2_flow.c |
-				grep -wo "$1[[:alnum:]_]*" | sort -u |
-				tr '\n' '|' | sed 's,.$,\n,')
-			[ "$1" = 'RTE_FLOW_ITEM_TYPE_' -a -z "$filter" ] && cat ||
-			grep -vE "$filter";;
-		*) cat
-	esac
-}
-
-# include exceptions
-include() # <pattern>
-{
-	case $(basename $dir) in
-	esac
-}
-
-# generate INI section
-list() # <title> <pattern>
-{
-	echo "[$1]"
-	git grep -who "$2[[:alnum:]_]*" $dir |
-	(exclude $2; include $2) | sort -u |
-	awk 'sub(/'$2'/, "") {printf "%-20s = Y\n", tolower($0)}'
-}
-
-rte_flow_support() # <category>
-{
-	title="rte_flow $1s"
-	pattern=$(echo "RTE_FLOW_$1_TYPE_" | awk '{print toupper($0)}')
-	list "$title" "$pattern" | grep -vwE 'void|indirect|end'
-}
-
-if [ -z "$ref" ]; then # generate full tables
-	rte_flow_support item
-	echo
-	rte_flow_support action
-	exit 0
-fi
-
-# compare with reference input
-rte_flow_compare() # <category>
-{
-	section="rte_flow $1s]"
-	{
-		rte_flow_support $1
-		sed -n "/$section/,/]/p" "$ref" | sed '/^$/d'
-	} |
-	sed '/]/d' | # ignore section title
-	sed 's, *=.*,,' | # ignore value (better in doc than generated one)
-	sort | uniq -u | # show differences
-	sed "s,^,$1 ," # prefix with category name
-}
-
-rte_flow_compare item
-rte_flow_compare action
diff --git a/doc/guides/contributing/new_driver.rst b/doc/guides/contributing/new_driver.rst
index e7f7695752..2c74c933c9 100644
--- a/doc/guides/contributing/new_driver.rst
+++ b/doc/guides/contributing/new_driver.rst
@@ -97,6 +97,8 @@ Split patches following this approach:
 * Organize each patch logically as a new feature.
 * Run test tools per patch (See :ref:`contrib_tool_list`).
 * Update relevant documentation and `<driver>.ini` file with each patch.
+  ``devtools/check-doc-vs-code.py -g <driver>`` prints the rows
+  that the driver code supports, as a starting point.
 
 The following order in the patch series is as suggested below.
 
@@ -207,7 +209,7 @@ Run the following test tools per patch in a patch series:
 * `checkpatches.sh`
 * `check-git-log.sh`
 * `check-meson.py`
-* `check-doc-vs-code.sh`
+* `check-doc-vs-code.py`
 * `check-spdx-tag.sh`
 * Build documentation and validate how output looks
 * Optionally run ``review-patch.py`` for AI-assisted review
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index f4996fd195..dace3a5205 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -513,6 +513,33 @@ The script usage is::
 For both scripts, the -n option specifies a number of commits from HEAD,
 and the -r option specifies a ``git log`` range.
 
+.. _contrib_check_doc_vs_code:
+
+When a patch changes a network driver or its features file,
+check that the NIC feature tables (see :doc:`/nics/overview`)
+match the driver code using the ``check-doc-vs-code.py`` script::
+
+   devtools/check-doc-vs-code.py origin/main
+
+With a git reference, only drivers changed since that reference are checked,
+and only findings not already present at the reference are reported.
+Without a reference, all drivers are checked.
+
+Errors are features documented without matching code,
+platforms excluded by the build, and rte_flow mismatches.
+Warnings are features implemented but not documented,
+full support documented where the code is partial,
+and incomplete sets of operations such as a queue start without stop.
+The script exits with an error status only if errors are reported.
+
+The script usage is::
+
+   check-doc-vs-code.py [-h] [-d DRIVER] [-g DRIVER] [-q] [-v] [ref]
+
+The -d option restricts the check to one features file,
+and the -g option prints the features derived from the driver code,
+as a starting point for a new driver.
+
 Additionally, when contributing to the DTS tool, check patches using
 the ``dts-check-format.sh`` script in the ``devtools`` directory of the DPDK repo.
 Running the script requires extra :ref:`Python dependencies <dts_deps>`.
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 43eda7867d..dff6dfa7f4 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -22,6 +22,11 @@ for cases where provided data can't be represented simply by a function.
 
 ``[related]``    : Related API with that feature.
 
+The feature tables in ``doc/guides/nics/features/`` are checked against
+the driver code by ``devtools/check-doc-vs-code.py``,
+based on the structs and flags listed below.
+See :ref:`the contributing guide <contrib_check_doc_vs_code>` for usage.
+
 
 .. _nic_features_speed_capabilities:
 
-- 
2.53.0

