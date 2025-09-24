Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1684CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDDEF40661;
	Wed, 24 Sep 2025 09:53:38 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 76A1040657
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=lhX+N5/xShpLyf5J2okwlZaz1gui8kEOk+GuUwDM0QM=;
 b=L7iK6TnpEb49Y3oMd3ECP0XbTXXWiYkoYKNdcnzcPaimdWAOvrKXjl76z4ZQBr
 Vsm2PVz6Jcy7F24UnxWVCqMTcIofzvyhEBUhWhB/t+b6L4Tew9C55P4y5eQBGHtG
 z3SIEJ0yfYJocPxx0wj06gPS/pFA+duG+tJur+qMDfkJ4=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S4;
 Wed, 24 Sep 2025 15:53:33 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com
Subject: [V13 00/18] add-hinic3-PMD-driver
Date: Wed, 24 Sep 2025 15:51:47 +0800
Message-ID: <20250924075216.18750-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15Xw4UCry3JF15KrW8Xrb_yoW3Jw15pF
 4UC3y3Ar1DKrW7tw1kJw1xAas8J3WxG345Kw13ZasYvr97ZFy5A34UGFW8Ar9xtr17J3W2
 vFs09rWqgwn8tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdcTQUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHgzSCmjTYNHV5wAAsy
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

The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.

v13:
-remove unsupported features in hinic3.ini
-fix capitalization issue in hinic3.rst
-fix rss key config not taking effect error
-fix mac address allocation issue when vf_num > 255

V12:
-modify get_bit function
-remove defined but unused macro
-modify time_before macro

v11:
-reorder code to avoid forward declarations
-remove unused casts
-use assignment instead of memcpy
-change some LOG level to DEBUG level
-remove unused function
-remove unused check in mtu_set/dev_config/vlan_filter_set
-defer start/stop
-use strlpy instead of snprintf 
-remove unnecessary line breaks, fit on line

v10:
-add prefix to some functions
-use memcpy instead of rte_memcpy for simple fixed copies
-modify LOG message format
-modify meson.build files
-remove unused check in queue_start/stop/intr
-remove unused function 
-remove function that stubbed out
-modify some api log level
-remove features unsupported
-modify some casts
-change xstats_cal_num return type
-modify stats get function 
 
v9:
-resolve type conflict issue

v8:
-resolve CI compile error
-modify mbox section

v7:
-remove unused functions

v6:
-modify based on community comments
-remove mml files

v5:
-fix build error

v4: 
-solve patch application conflict issue 
 
v3:
-fix checkpatch errors issue

v2:
-modify CI compile errors

v1:
-modify community comments and compile issues
-remove the compilation flags in the meson build
-remove (void) cur_link_machine_state
-remove '*** BLURE HERE ***' in cover letter

Feifei Wang (2):
  net/hinic3: add dev ops
  net/hinic3: add Rx/Tx functions

Xin Wang (7):
  net/hinic3: add basic header files
  net/hinic3: add support for cmdq mechanism
  net/hinic3: add NIC event module
  net/hinic3: add context and work queue support
  net/hinic3: add futions for initialization
  net/hinic3: add device initialization
  net/hinic3: add RSS promiscuous ops

Yi Chen (9):
  doc: add hinic3 driver
  net/hinic3: add hardware interfaces of BAR operation
  net/hinic3: add eq mechanism
  net/hinic3: add mgmt module function code
  net/hinic3: add module about hardware operation
  net/hinic3: add a NIC business configuration module
  net/hinic3: add a mailbox communication module
  net/hinic3: add flow control and FDIR module
  drivers/net: add hinic3 PMD build and doc files

 .mailmap                                   |    4 +-
 MAINTAINERS                                |    6 +
 doc/guides/nics/features/hinic3.ini        |   50 +
 doc/guides/nics/hinic3.rst                 |   47 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/rel_notes/release_25_11.rst     |    4 +
 drivers/net/hinic3/base/hinic3_cmd.h       |  135 +
 drivers/net/hinic3/base/hinic3_cmdq.c      |  960 ++++++
 drivers/net/hinic3/base/hinic3_cmdq.h      |  222 ++
 drivers/net/hinic3/base/hinic3_compat.h    |  133 +
 drivers/net/hinic3/base/hinic3_csr.h       |  104 +
 drivers/net/hinic3/base/hinic3_eqs.c       |  704 ++++
 drivers/net/hinic3/base/hinic3_eqs.h       |   92 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  190 ++
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  110 +
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  442 +++
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
 drivers/net/hinic3/base/hinic3_hwdev.c     |  549 +++
 drivers/net/hinic3/base/hinic3_hwdev.h     |  166 +
 drivers/net/hinic3/base/hinic3_hwif.c      |  739 ++++
 drivers/net/hinic3/base/hinic3_hwif.h      |  145 +
 drivers/net/hinic3/base/hinic3_mbox.c      | 1188 +++++++
 drivers/net/hinic3/base/hinic3_mbox.h      |  181 +
 drivers/net/hinic3/base/hinic3_mgmt.c      |  340 ++
 drivers/net/hinic3/base/hinic3_mgmt.h      |  102 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1785 ++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1517 +++++++++
 drivers/net/hinic3/base/hinic3_nic_event.c |  400 +++
 drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
 drivers/net/hinic3/base/hinic3_wq.c        |  139 +
 drivers/net/hinic3/base/hinic3_wq.h        |  109 +
 drivers/net/hinic3/base/meson.build        |   16 +
 drivers/net/hinic3/hinic3_ethdev.c         | 3566 ++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h         |  164 +
 drivers/net/hinic3/hinic3_fdir.c           | 1364 ++++++++
 drivers/net/hinic3/hinic3_fdir.h           |  398 +++
 drivers/net/hinic3/hinic3_flow.c           | 1476 ++++++++
 drivers/net/hinic3/hinic3_flow.h           |  196 ++
 drivers/net/hinic3/hinic3_nic_io.c         |  802 +++++
 drivers/net/hinic3/hinic3_nic_io.h         |  169 +
 drivers/net/hinic3/hinic3_rx.c             | 1057 ++++++
 drivers/net/hinic3/hinic3_rx.h             |  354 ++
 drivers/net/hinic3/hinic3_tx.c             | 1025 ++++++
 drivers/net/hinic3/hinic3_tx.h             |  314 ++
 drivers/net/hinic3/meson.build             |   30 +
 drivers/net/meson.build                    |    1 +
 46 files changed, 21898 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/nics/features/hinic3.ini
 create mode 100644 doc/guides/nics/hinic3.rst
 create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
 create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
 create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
 create mode 100644 drivers/net/hinic3/base/meson.build
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
 create mode 100644 drivers/net/hinic3/hinic3_fdir.c
 create mode 100644 drivers/net/hinic3/hinic3_fdir.h
 create mode 100644 drivers/net/hinic3/hinic3_flow.c
 create mode 100644 drivers/net/hinic3/hinic3_flow.h
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
 create mode 100644 drivers/net/hinic3/hinic3_rx.c
 create mode 100644 drivers/net/hinic3/hinic3_rx.h
 create mode 100644 drivers/net/hinic3/hinic3_tx.c
 create mode 100644 drivers/net/hinic3/hinic3_tx.h
 create mode 100644 drivers/net/hinic3/meson.build

-- 
2.47.0.windows.2

