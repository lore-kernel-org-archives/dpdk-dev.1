Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB70EC01A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B7B40616;
	Mon, 23 Mar 2026 09:05:31 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 7AEFD40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=j2lzTfOjC3uMQ3yvu6BtHviL8OwvkSxxzMn+b3j08vA=;
 b=WpCn52lAuN76sgzj4s+L7gsr5urY3rIMvfHbgqkTyO4rlDtvkbixrsaK1l+wob
 NDRc3MYo7grV0NZGZmyqh70yxR7uNNcD0cTDi0IjaxtlzerGFyk1YjQEi62vMtj1
 zS+eeNE/71xHXt0DU1vE7eexAzqG1es4P2R8ccnTi3Ipk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHa3Y_9MBp30tVAw--.29038S4;
 Mon, 23 Mar 2026 16:05:24 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v7 0/7] hinic3 change for support new SPx NIC
Date: Mon, 23 Mar 2026 16:04:43 +0800
Message-ID: <20260323080455.2699-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260316134335.1640-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHa3Y_9MBp30tVAw--.29038S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWkGw15uF43ZrW8GrykZrb_yoW5try8pF
 WUJ3y3ZF1DKrW7Jwn7Gw4xAa45J3W8G34UKa45XasYvFykAFyUA34UGFW0yrZxtr4xJF12
 vF45uryvg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMxRDUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgTY4mnA9EQ5ZwAA3P
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

From: Feifei Wang <wangfeifei40@huawei.com>

Change hinic3 driver to support Huawei new SPx series NIC.

v2:
--fix build issues

v3:
--fix community review comments and err reports

v4:
--fix rss type assignment error

v5:
--fix community ubuntu-22.04-clang err

v6:
--fix atomic compilation error

v6:
--fix community review comments

v7:
--fix htn/stn ops function name error
--update doc/guides for hinic3 driver

Feifei Wang (7):
  net/hinic3: add support for new SPx series NIC
  net/hinic3: add enhance cmdq support for new SPx series NIC
  net/hinic3: use different callback func to split new/old cmdq
    operations
  net/hinic3: add fun init ops to support Compact CQE
  net/hinic3: add rx ops to support Compact CQE
  net/hinic3: add tx ops to support Compact CQE
  net/hinic3: use different callback func to support htn fdir

 doc/guides/nics/features/hinic3.ini           |  11 +-
 doc/guides/nics/hinic3.rst                    |   5 +-
 doc/guides/rel_notes/release_26_03.rst        |   8 +
 drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++-
 drivers/net/hinic3/base/hinic3_cmdq.c         | 370 ++++------
 drivers/net/hinic3/base/hinic3_cmdq.h         | 112 ++-
 drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 +++
 drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++
 drivers/net/hinic3/base/hinic3_csr.h          |  18 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
 drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
 drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
 drivers/net/hinic3/base/hinic3_hwif.c         |  10 +-
 drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
 drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      | 182 ++---
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  98 ++-
 drivers/net/hinic3/base/meson.build           |   1 +
 drivers/net/hinic3/hinic3_ethdev.c            | 275 ++++++--
 drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--
 drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
 drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
 drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------
 drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-
 drivers/net/hinic3/hinic3_rx.c                | 267 +++++--
 drivers/net/hinic3/hinic3_rx.h                | 182 ++++-
 drivers/net/hinic3/hinic3_tx.c                | 456 ++++++------
 drivers/net/hinic3/hinic3_tx.h                | 154 +++-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++
 drivers/net/hinic3/htn_adapt/meson.build      |   7 +
 drivers/net/hinic3/meson.build                |   8 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++
 drivers/net/hinic3/stn_adapt/meson.build      |   7 +
 36 files changed, 3379 insertions(+), 1445 deletions(-)
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
 create mode 100644 drivers/net/hinic3/htn_adapt/meson.build
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
 create mode 100644 drivers/net/hinic3/stn_adapt/meson.build

-- 
2.45.1.windows.1

