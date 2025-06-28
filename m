Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F9C54ED1
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 07:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7FDC402AE;
	Sat, 28 Jun 2025 09:26:17 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id EE20A4025D
 for <dev@dpdk.org>; Sat, 28 Jun 2025 09:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=SqE5nlgUFCV7KZrz1ketLSMukWXYLp/KAdqZi4JG0ac=;
 b=FEFZ1PAxPhBzKM/q8Efy6Mih9o/dyJdLIHbRKFy9nrDN6ZUxTT9P0Ig2QUZB1J
 CgkTwFjRFOL8TX8BFdFiLgVzXCCI/BCTfPuyUrO/ILNL3TAkQARYSlFCwNMnevWM
 CqvdJTnYnmYkh6E7nni4btQxTfuqKKbJ02fXjZvNXn5rY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnrwERmV9o+dKKAw--.5048S4;
 Sat, 28 Jun 2025 15:26:12 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com,
	Yi Chen <chenyi221@huawei.com>
Subject: [V3 00/18] add hinic3 pmd driver
Date: Sat, 28 Jun 2025 15:25:23 +0800
Message-ID: <20250628072552.1311-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDnrwERmV9o+dKKAw--.5048S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1rAr13JFWUtrWDZr17trb_yoWxKFyDpF
 4UC3y3Ar4DKrW7tw1kGw4xAa45X3WxG345K3W5Z3ZYvr97ZFy5A34UGFW8Ar9xtr17JF12
 vFs0krWqg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdcTQUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAx16CmhfYnRVYwAAs5
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

From: Yi Chen <chenyi221@huawei.com>=0D

The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support=0D
for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.=0D
=0D
Feifei Wang (2):=0D
  net/hinic3: add dev ops=0D
  net/hinic3: add Rx/Tx functions=0D
=0D
Xin Wang (7):=0D
  net/hinic3: add basic header files=0D
  net/hinic3: add support for cmdq mechanism=0D
  net/hinic3: add NIC event module=0D
  net/hinic3: add context and work queue support=0D
  net/hinic3: add device initialization=0D
  net/hinic3: add MML and EEPROM access feature=0D
  net/hinic3: add RSS promiscuous ops=0D
=0D
Yi Chen (9):=0D
  add some basic files about hinic3 driver=0D
  net/hinic3: add hardware interfaces of BAR operation=0D
  net/hinic3: add eq mechanism function code=0D
  net/hinic3: add mgmt module function code=0D
  net/hinic3: add module about hardware operation=0D
  net/hinic3: add a NIC business configuration module=0D
  net/hinic3: add a mailbox communication module=0D
  net/hinic3: add FDIR flow control module=0D
  drivers/net: add hinic3 PMD build and doc files=0D
=0D
 .mailmap                                   |    4 +-=0D
 MAINTAINERS                                |    6 +=0D
 doc/guides/nics/features/hinic3.ini        |   62 +=0D
 doc/guides/nics/hinic3.rst                 |   51 +=0D
 doc/guides/nics/index.rst                  |    1 +=0D
 doc/guides/rel_notes/release_25_07.rst     |    4 +=0D
 drivers/net/hinic3/base/hinic3_cmd.h       |  231 ++=0D
 drivers/net/hinic3/base/hinic3_cmdq.c      |  978 +++++=0D
 drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++=0D
 drivers/net/hinic3/base/hinic3_compat.h    |  266 ++=0D
 drivers/net/hinic3/base/hinic3_csr.h       |  108 +=0D
 drivers/net/hinic3/base/hinic3_eqs.c       |  721 ++++=0D
 drivers/net/hinic3/base/hinic3_eqs.h       |   98 +=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  240 ++=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  121 +=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  452 +++=0D
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  366 ++=0D
 drivers/net/hinic3/base/hinic3_hwdev.c     |  573 +++=0D
 drivers/net/hinic3/base/hinic3_hwdev.h     |  177 +=0D
 drivers/net/hinic3/base/hinic3_hwif.c      |  779 ++++=0D
 drivers/net/hinic3/base/hinic3_hwif.h      |  142 +=0D
 drivers/net/hinic3/base/hinic3_mbox.c      | 1399 +++++++=0D
 drivers/net/hinic3/base/hinic3_mbox.h      |  199 +=0D
 drivers/net/hinic3/base/hinic3_mgmt.c      |  392 ++=0D
 drivers/net/hinic3/base/hinic3_mgmt.h      |  121 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1828 +++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1527 ++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_event.c |  433 +++=0D
 drivers/net/hinic3/base/hinic3_nic_event.h |   39 +=0D
 drivers/net/hinic3/base/hinic3_wq.c        |  148 +=0D
 drivers/net/hinic3/base/hinic3_wq.h        |  109 +=0D
 drivers/net/hinic3/base/meson.build        |   50 +=0D
 drivers/net/hinic3/hinic3_ethdev.c         | 3866 ++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_ethdev.h         |  167 +=0D
 drivers/net/hinic3/hinic3_fdir.c           | 1394 +++++++=0D
 drivers/net/hinic3/hinic3_fdir.h           |  398 ++=0D
 drivers/net/hinic3/hinic3_flow.c           | 1700 +++++++++=0D
 drivers/net/hinic3/hinic3_flow.h           |   42 +=0D
 drivers/net/hinic3/hinic3_nic_io.c         |  828 +++++=0D
 drivers/net/hinic3/hinic3_nic_io.h         |  169 +=0D
 drivers/net/hinic3/hinic3_rx.c             | 1099 ++++++=0D
 drivers/net/hinic3/hinic3_rx.h             |  356 ++=0D
 drivers/net/hinic3/hinic3_tx.c             | 1028 ++++++=0D
 drivers/net/hinic3/hinic3_tx.h             |  315 ++=0D
 drivers/net/hinic3/meson.build             |   33 +=0D
 drivers/net/hinic3/mml/hinic3_dbg.c        |  171 +=0D
 drivers/net/hinic3/mml/hinic3_dbg.h        |  160 +=0D
 drivers/net/hinic3/mml/hinic3_mml_cmd.c    |  375 ++=0D
 drivers/net/hinic3/mml/hinic3_mml_cmd.h    |  131 +=0D
 drivers/net/hinic3/mml/hinic3_mml_ioctl.c  |  215 ++=0D
 drivers/net/hinic3/mml/hinic3_mml_lib.c    |  136 +=0D
 drivers/net/hinic3/mml/hinic3_mml_lib.h    |  276 ++=0D
 drivers/net/hinic3/mml/hinic3_mml_main.c   |  167 +=0D
 drivers/net/hinic3/mml/hinic3_mml_queue.c  |  745 ++++=0D
 drivers/net/hinic3/mml/hinic3_mml_queue.h  |  256 ++=0D
 drivers/net/hinic3/mml/meson.build         |   45 +=0D
 drivers/net/meson.build                    |    1 +=0D
 57 files changed, 25927 insertions(+), 1 deletion(-)=0D
 create mode 100644 doc/guides/nics/features/hinic3.ini=0D
 create mode 100644 doc/guides/nics/hinic3.rst=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_compat.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_csr.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.h=0D
 create mode 100644 drivers/net/hinic3/base/meson.build=0D
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_ethdev.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_fdir.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_fdir.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_flow.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_flow.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_rx.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_rx.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_tx.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_tx.h=0D
 create mode 100644 drivers/net/hinic3/meson.build=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h=0D
 create mode 100644 drivers/net/hinic3/mml/meson.build=0D
=0D
-- =0D
2.45.1.windows.1=0D
=0D

