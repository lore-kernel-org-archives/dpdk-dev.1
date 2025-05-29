Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11736C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 08:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD17A402C5;
	Thu, 29 May 2025 10:16:02 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 54C1A40150
 for <dev@dpdk.org>; Thu, 29 May 2025 10:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Q3Xo639mVaSSgPbpjKT/DbGCCu8dk9AEyWc75nUA1lQ=;
 b=Cy8xtiRaWCcbOe4FkfTo/c0rbpxJfqx+Tcq6okwITn1bVsfCWrLRnZWE0qGZzq
 sHHebbV4YsnntmR1GR3Ofyt3Q5fFGNDHs32/b3NbGOqg3RuPf3gerxO4PuS7PQGr
 gCzDQEMosE/ldIJQM6OOQ0Ll+dtBPEM1QfZxOq9HEweyU=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgBnrqG7FzhofozTAQ--.8522S4;
 Thu, 29 May 2025 16:15:56 +0800 (CST)
From: Feifei <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/18] add hinic3 pmd driver
Date: Thu, 29 May 2025 16:14:59 +0800
Message-ID: <20250529081529.2839-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-19-wff_light@vip.163.com>
References: <20250418090621.9638-19-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgBnrqG7FzhofozTAQ--.8522S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1rAr13JFWUtrWDCrWUCFg_yoWxKFyrpF
 4UC3y3Ar4DKrW7tw1kGw4xAa45X3WxG343K3W5Z3ZYvr97ZFy5A34UGFW8Ar9xtr17JF12
 vFs0krWqg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv4iUUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQZcCmg4DmEpgwACsG
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

Feifei (1):
  This patch adds some basic files to describe the hinic3 driver.

Feifei Wang (2):
  net/hinic3: add dev ops
  net/hinic3: add Rx/Tx functions

Xin Wang (7):
  net/hinic3: add basic header files
  net/hinic3: add support for cmdq mechanism
  net/hinic3: add NIC event module
  net/hinic3: add context and work queue support
  net/hinic3: add device initialization
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
 doc/guides/nics/hinic3.rst                 |   51 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/rel_notes/release_25_07.rst     |    3 +
 drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++
 drivers/net/hinic3/base/hinic3_cmdq.c      |  976 +++++
 drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
 drivers/net/hinic3/base/hinic3_compat.h    |  266 ++
 drivers/net/hinic3/base/hinic3_csr.h       |  108 +
 drivers/net/hinic3/base/hinic3_eqs.c       |  720 ++++
 drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++
 drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++
 drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +
 drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++
 drivers/net/hinic3/base/hinic3_hwif.h      |  142 +
 drivers/net/hinic3/base/hinic3_mbox.c      | 1399 +++++++
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
 drivers/net/hinic3/hinic3_nic_io.c         |  828 +++++
 drivers/net/hinic3/hinic3_nic_io.h         |  169 +
 drivers/net/hinic3/hinic3_rx.c             | 1098 ++++++
 drivers/net/hinic3/hinic3_rx.h             |  356 ++
 drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++
 drivers/net/hinic3/hinic3_tx.h             |  315 ++
 drivers/net/hinic3/meson.build             |   33 +
 drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +
 drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +
 drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++
 drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +
 drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++
 drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +
 drivers/net/hinic3/mml/hinic3_mml_lib.h    |  275 ++
 drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +
 drivers/net/hinic3/mml/hinic3_mml_queue.c  |  744 ++++
 drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++
 drivers/net/hinic3/mml/meson.build         |   45 +
 drivers/net/meson.build                    |    1 +
 57 files changed, 25905 insertions(+), 1 deletion(-)
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

