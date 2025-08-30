Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547DCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E188402EE;
	Sat, 30 Aug 2025 14:44:36 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 7B0CC402DC
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=1H8NPyMYVf8gqPHzSHTHMKIysFBqe0AZVff8prDFP9s=;
 b=bd2oHxzKWsg52PJkONrjlmmUFatQx4FM+bIr8fxWPh2ByHNTLdm7zS5dpfC2ZC
 g+RfjdhLcZ57KrAYvOLOsREugsY421HKFtLlxNl7HCxbV6YTkAfBNfRqhgDK6fWP
 d4SDg+CZZaqKox4Sme9f+k6W7ooITsoNv71Wzf/iGoStk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHz+YN8rJogy_MAg--.2603S4;
 Sat, 30 Aug 2025 20:44:32 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V6 00/17] add-hinic3-PMD-driver
Date: Sat, 30 Aug 2025 20:43:04 +0800
Message-ID: <20250830124332.5351-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHz+YN8rJogy_MAg--.2603S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1xXF45XFWUJw1ruF45KFg_yoW7Zw18pF
 4UC3y3Ar1DKrW7tw1kJw1xAas8J3WxG345Kw13Z3WFvr97ZFy5A34UGFW8Ar9xtr17JF12
 vFs09rWDK3Z8tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U67K3UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJhi5Cmiyr99nYQAAsh
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

Feifei Wang (2):
  net/hinic3: add dev ops
  net/hinic3: add Rx/Tx functions

Xin Wang (6):
  net/hinic3: add basic header files
  net/hinic3: add support for cmdq mechanism
  net/hinic3: add NIC event module
  net/hinic3: add context and work queue support
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
 doc/guides/nics/features/hinic3.ini        |   60 +
 doc/guides/nics/hinic3.rst                 |   47 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/rel_notes/release_25_07.rst     |    4 +
 drivers/net/hinic3/base/hinic3_cmd.h       |  156 +
 drivers/net/hinic3/base/hinic3_cmdq.c      |  971 +++++
 drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
 drivers/net/hinic3/base/hinic3_compat.h    |  144 +
 drivers/net/hinic3/base/hinic3_csr.h       |  108 +
 drivers/net/hinic3/base/hinic3_eqs.c       |  710 ++++
 drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  193 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  117 +
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  448 +++
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
 drivers/net/hinic3/base/hinic3_hwdev.c     |  557 +++
 drivers/net/hinic3/base/hinic3_hwdev.h     |  180 +
 drivers/net/hinic3/base/hinic3_hwif.c      |  765 ++++
 drivers/net/hinic3/base/hinic3_hwif.h      |  144 +
 drivers/net/hinic3/base/hinic3_mbox.c      | 1253 +++++++
 drivers/net/hinic3/base/hinic3_mbox.h      |  184 +
 drivers/net/hinic3/base/hinic3_mgmt.c      |  373 ++
 drivers/net/hinic3/base/hinic3_mgmt.h      |  116 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1784 +++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1529 ++++++++
 drivers/net/hinic3/base/hinic3_nic_event.c |  407 +++
 drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
 drivers/net/hinic3/base/hinic3_wq.c        |  140 +
 drivers/net/hinic3/base/hinic3_wq.h        |  109 +
 drivers/net/hinic3/base/meson.build        |   50 +
 drivers/net/hinic3/hinic3_ethdev.c         | 3782 ++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h         |  164 +
 drivers/net/hinic3/hinic3_fdir.c           | 1379 +++++++
 drivers/net/hinic3/hinic3_fdir.h           |  398 ++
 drivers/net/hinic3/hinic3_flow.c           | 1501 ++++++++
 drivers/net/hinic3/hinic3_flow.h           |  196 +
 drivers/net/hinic3/hinic3_nic_io.c         |  806 +++++
 drivers/net/hinic3/hinic3_nic_io.h         |  171 +
 drivers/net/hinic3/hinic3_rx.c             | 1094 ++++++
 drivers/net/hinic3/hinic3_rx.h             |  353 ++
 drivers/net/hinic3/hinic3_tx.c             | 1024 ++++++
 drivers/net/hinic3/hinic3_tx.h             |  313 ++
 drivers/net/hinic3/meson.build             |   31 +
 drivers/net/meson.build                    |    1 +
 46 files changed, 22503 insertions(+), 1 deletion(-)
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

