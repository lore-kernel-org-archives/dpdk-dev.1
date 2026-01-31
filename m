Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA35D79769
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FB5A402DD;
	Sat, 31 Jan 2026 11:06:47 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 45985402C4
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=H0N+T7DdqZNHp5sMUtAs7YZQN74w8GDd9MAFqH+uKXA=;
 b=islfjaOBLXkHfjEJl3ACjDG5YfCDPmvYiOAySzlV+es7/qJESEsot/Mcqxq+76
 +EOG5LRckSwO3ySG6nBQArZOoPaucEP3J5bjscUKfGhDcMUNvb62dstz8ClwAMQR
 NkEeSoN0HPivuYzQWe6/AwG8JFcaycQ0msT874CKrcSMU=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S4;
 Sat, 31 Jan 2026 18:06:40 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 0/7] hinic3 change for support new SPx NIC
Date: Sat, 31 Jan 2026 18:05:56 +0800
Message-ID: <20260131100608.12429-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWDXFW5CFW5AryfXr1fZwb_yoW5AryfpF
 WUG3y3Zr1DKrW7J3Z7J3yxAas8X3WxG34UKas0vasYvr95ZFyUA34UGFW0yrZxtr4xJF12
 vF45Cr9Fg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK9a9UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxD6BWl91DBbKQAA3e
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

Feifei Wang (7):
  net/hinic3: add support for new SPx series NIC
  net/hinic3: add enhance cmdq support for new SPx series NIC
  net/hinic3: use different callback func to split new/old cmdq
    operations
  net/hinic3: add fun init ops to support Compact CQE
  net/hinic3: add rx ops to support Compact CQE
  net/hinic3: add tx ops to support Compact CQE
  net/hinic3: use different callback func to support htn fdir

 drivers/net/hinic3/base/hinic3_cmd.h          | 145 +++--
 drivers/net/hinic3/base/hinic3_cmdq.c         | 400 +++++-------
 drivers/net/hinic3/base/hinic3_cmdq.h         |  65 +-
 drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 110 ++++
 drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 169 +++++
 drivers/net/hinic3/base/hinic3_csr.h          |  16 +-
 drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
 drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
 drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
 drivers/net/hinic3/base/hinic3_hwif.c         |   4 +-
 drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
 drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      | 167 +++--
 drivers/net/hinic3/base/hinic3_nic_cfg.h      | 104 ++--
 drivers/net/hinic3/base/meson.build           |   1 +
 drivers/net/hinic3/hinic3_ethdev.c            | 240 +++++--
 drivers/net/hinic3/hinic3_ethdev.h            | 132 ++--
 drivers/net/hinic3/hinic3_fdir.c              | 589 ++++++++++++------
 drivers/net/hinic3/hinic3_fdir.h              | 373 +++++++++--
 drivers/net/hinic3/hinic3_nic_io.c            | 507 +++++++--------
 drivers/net/hinic3/hinic3_nic_io.h            | 147 +++++
 drivers/net/hinic3/hinic3_rx.c                | 235 +++++--
 drivers/net/hinic3/hinic3_rx.h                | 147 +++++
 drivers/net/hinic3/hinic3_tx.c                | 463 +++++++-------
 drivers/net/hinic3/hinic3_tx.h                | 144 ++++-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 163 +++++
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  55 ++
 drivers/net/hinic3/htn_adapt/meson.build      |   7 +
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 147 +++++
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  38 ++
 drivers/net/hinic3/stn_adapt/meson.build      |   7 +
 32 files changed, 3268 insertions(+), 1391 deletions(-)
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

