Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33756C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:52:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1205B40E2A;
	Mon,  5 May 2025 14:51:20 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0E358400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 10:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=uycyTxGIMY5qw9d5NP5KCl292bEJ4youk3+xi9KRG1Y=;
 b=oDGic61qEg6cNYQhYdV99uVYVAMkxgdvzNGAM3zYDFwinyVOoGZ7kYttyGSp5o
 D5ACeF9wD7kmDZ9rYPK4Kl8GbNs6xSk9xDVbujzSonFsnzxYz8NeA6Dp+ihDXzAZ
 qg/3QEDI3TW+oiTlXnWWqlNBPsvOhqeHpMRiroTVVRbdQ=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAXqpe1CAJoAsjFAg--.56413S4;
 Fri, 18 Apr 2025 16:09:28 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [RFC 00/18] add hinic3 PMD driver
Date: Fri, 18 Apr 2025 16:08:32 +0800
Message-ID: <20250418080908.9447-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXqpe1CAJoAsjFAg--.56413S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1rAr13JFWUtrWDCrWUCFg_yoWxKF4UpF
 4UC3y3Ar4DKrW7tw1kGw4xAa45X3WxG343K3W5Z3ZYvr97ZFy5A34UGFW8Ar9xtr17JF12
 vFs09rWqg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwb1bUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAhIzCmgB4ZentAAAsl
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:05 +0200
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

*** BLURB HERE ***
The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.

Feifei Wang (3):
  net/hinic3: add intro doc for hinic3
  net/hinic3: add dev ops
  net/hinic3: add Rx/Tx functions

Xin Wang (7):
  net/hinic3: add basic header files
  net/hinic3: add support for cmdq mechanism
  net/hinic3: add NIC event module
  net/hinic3: add context and work queue support
  net/hinic3: add device initailization
  net/hinic3: add MML and EEPROM access feature
  net/hinic3: add RSS promiscuous ops

Yi Chen (8):
  net/hinic3: add hardware interfaces of BAR operation
  net/hinic3: add eq mechanism function code
  net/hinic3: add mgmt module function code
  net/hinic3: add module about hardware operation
  net/hinic3: add a NIC business configuration module
  net/hinic3: add a mailbox communication module
  net/hinic3: add FDIR flow control module
  drivers/net: add hinic3 PMD build and doc files

 .mailmap                                   |    4 +-
 MAINTAINERS                                |    6 +
 doc/guides/nics/features/hinic3.ini        |    9 +
 doc/guides/nics/hinic3.rst                 |   52 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/rel_notes/release_25_07.rst     |   32 +-
 drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
 drivers/net/hinic3/base/hinic3_cmdq.c      |  975 +++++
 drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
 drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
 drivers/net/hinic3/base/hinic3_csr.h       |  108 +
 drivers/net/hinic3/base/hinic3_eqs.c       |  719 ++++
 drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
 drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
 drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
 drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
 drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
 drivers/net/hinic3/base/hinic3_mbox.c      | 1392 +++++++
 drivers/net/hinic3/base/hinic3_mbox.h      |  199 +
 drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++
 drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++
 drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++
 drivers/net/hinic3/base/hinic3_nic_event.h |   39 +
 drivers/net/hinic3/base/hinic3_wq.c        |  148 +
 drivers/net/hinic3/base/hinic3_wq.h        |  109 +
 drivers/net/hinic3/base/meson.build        |   50 +
 drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h         |  167 +
 drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++
 drivers/net/hinic3/hinic3_fdir.h           |  398 ++
 drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++
 drivers/net/hinic3/hinic3_flow.h           |   80 +
 drivers/net/hinic3/hinic3_nic_io.c         |  827 +++++
 drivers/net/hinic3/hinic3_nic_io.h         |  169 +
 drivers/net/hinic3/hinic3_rx.c             | 1096 ++++++
 drivers/net/hinic3/hinic3_rx.h             |  356 ++
 drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
 drivers/net/hinic3/hinic3_tx.h             |  315 ++
 drivers/net/hinic3/meson.build             |   44 +
 drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
 drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
 drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
 drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
 drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
 drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
 drivers/net/hinic3/mml/hinic3_mml_lib.h    |  275 ++
 drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
 drivers/net/hinic3/mml/hinic3_mml_queue.c  |  749 ++++
 drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
 drivers/net/hinic3/mml/meson.build         |   62 +
 drivers/net/meson.build                    |    1 +
 57 files changed, 25926 insertions(+), 31 deletions(-)
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
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h
 create mode 100644 drivers/net/hinic3/mml/meson.build

-- 
2.47.0.windows.2

