Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E9CAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 13:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3ACC40615;
	Mon,  8 Sep 2025 15:53:31 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 4897B40156
 for <dev@dpdk.org>; Mon,  8 Sep 2025 15:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=tca9iyAtycXbRnX4GPurNfCI+q6NFUMQCySEFjz+26s=;
 b=kJRyOarVDCAIYcVNCpk6uc9UgbhzR958PtR4v7uhpVsM4sE/8sLDapj30Hm34v
 XTQgE4flosSSmKrsfn8DhEKVUaVlC+l1LfDQkBDD7qZeKX7AgZIBsiQaElvmyOwi
 ZV1DfckQk7XhPRM3wFGHcCE352E1QaxXLxP07XNiqlEN8=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDXbbu9375oixA8Aw--.20503S4;
 Mon, 08 Sep 2025 21:53:22 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V8 00/17] add-hinic3-PMD-driver
Date: Mon,  8 Sep 2025 21:52:08 +0800
Message-ID: <20250908135236.11873-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDXbbu9375oixA8Aw--.20503S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryUGrWfAr43WrW5JFWxCrg_yoWxGFyDpF
 4UC3y3Ar1DKrW7tw1kJw1xAas8J3WxG345Kw13Za4Fvr97ZFy5A34UGFW8Ar9xtw17JF12
 vFs09rWDK3Z8tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZXoxUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHh7CCmi+u0NjPgAAs7
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

v8:
-resolve CI compile error
-modify mbox section

v7:
-remove unused-functions

v6:
-modify based on community comments
-remove mml files

v5:
-fix build err

v4: 
-solve patch application conflict issue 

v3:
-fix checkpatchs errors issue

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
 doc/guides/rel_notes/release_25_11.rst     |    3 +
 drivers/net/hinic3/base/hinic3_cmd.h       |  156 +
 drivers/net/hinic3/base/hinic3_cmdq.c      |  972 +++++
 drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
 drivers/net/hinic3/base/hinic3_compat.h    |  144 +
 drivers/net/hinic3/base/hinic3_csr.h       |  108 +
 drivers/net/hinic3/base/hinic3_eqs.c       |  710 ++++
 drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
 drivers/net/hinic3/base/hinic3_hw_cfg.c    |  194 +
 drivers/net/hinic3/base/hinic3_hw_cfg.h    |  117 +
 drivers/net/hinic3/base/hinic3_hw_comm.c   |  449 +++
 drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
 drivers/net/hinic3/base/hinic3_hwdev.c     |  558 +++
 drivers/net/hinic3/base/hinic3_hwdev.h     |  183 +
 drivers/net/hinic3/base/hinic3_hwif.c      |  741 ++++
 drivers/net/hinic3/base/hinic3_hwif.h      |  144 +
 drivers/net/hinic3/base/hinic3_mbox.c      | 1225 +++++++
 drivers/net/hinic3/base/hinic3_mbox.h      |  181 +
 drivers/net/hinic3/base/hinic3_mgmt.c      |  355 ++
 drivers/net/hinic3/base/hinic3_mgmt.h      |  112 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1795 ++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1530 ++++++++
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
 drivers/net/hinic3/hinic3_rx.c             | 1067 ++++++
 drivers/net/hinic3/hinic3_rx.h             |  353 ++
 drivers/net/hinic3/hinic3_tx.c             | 1024 ++++++
 drivers/net/hinic3/hinic3_tx.h             |  313 ++
 drivers/net/hinic3/meson.build             |   31 +
 drivers/net/meson.build                    |    1 +
 46 files changed, 22417 insertions(+), 1 deletion(-)
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

