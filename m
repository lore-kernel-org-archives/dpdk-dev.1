Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0559ECA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 07:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC4EA402D7;
	Tue,  9 Sep 2025 09:32:58 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id C621740281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 09:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=VB1wPBdM+k2+Y9plCy0j0FmQaQBz0RXvbCKjC7lywFo=;
 b=PTKSNE3Sah1eJZymznOnqgXa0tshBpFtXtQimCUIiChy7i6axt8td+wUCcJMnr
 YfdmJAgdgyIR/9JWizqCkl19DveIcmQzLnvOp3oS0gDPWk7XDYuGRpmYK/elNlvH
 pZgq4LpVdnyEc52qkeQmWbin6+L9FBTrIipIjTZotJs4o=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAXb4cZ2L9oEBzOAQ--.47637S4;
 Tue, 09 Sep 2025 15:32:53 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V9 00/17] add-hinic3-PMD-driver
Date: Tue,  9 Sep 2025 15:31:28 +0800
Message-ID: <20250909073157.14968-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgAXb4cZ2L9oEBzOAQ--.47637S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryUGrWfArWUJFWUtr4fXwb_yoW7Cw18pF
 4UC3y3Ar1DKrW7tw1kJw1xAa45J3WxGry5Kw13Z3WrZr97ZFy5A34UGFW8Ar9Iqw17J3W2
 vFs0kr4q93WYqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USFAXUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiARHDCmi-zSEuiQAAsF
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

v9:
-resolve type conflict issue

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

 .mailmap                                   |    4 +-
 MAINTAINERS                                |    6 +
 doc/guides/nics/features/hinic3.ini        |   60 +
 doc/guides/nics/hinic3.rst                 |   47 +
 doc/guides/nics/index.rst                  |    1 +
 doc/guides/rel_notes/release_25_11.rst     |    4 +
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
 46 files changed, 22418 insertions(+), 1 deletion(-)
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

