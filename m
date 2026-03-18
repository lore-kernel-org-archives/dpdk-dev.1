Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E44103E170
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D7140657;
	Wed, 18 Mar 2026 13:32:39 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id F24434026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 13:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+xsOYsytPDIFq4xnN+qSEZbxDCqOpsTCdbIL7OYAOc0=;
 b=YXl72GySQcztHdj/2OdFQ2WiJge6DbQLqCkg99uwQX4axmjORTYrGXg52PP7gG
 TtCWR+ow0yAbHzwkXnXo4FiTlqCHzrKOo12whs7D8eZHr9m+PM8QyTA60ekID0bH
 ULFOEfAgUwU93bHDYcJ5rv9FQW7n7CAAJ+i+VspQpLXgY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgDXr95am7pplRv4Ag--.47359S4;
 Wed, 18 Mar 2026 20:32:30 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: chenyi221 <chenyi221@huawei.com>
Subject: [v5 0/7] hinic3 change for support new SPx NIC
Date: Wed, 18 Mar 2026 20:31:55 +0800
Message-ID: <20260318123208.2199-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-2-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: Ac8vCgDXr95am7pplRv4Ag--.47359S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryrury8Ww4rGw4kGr1kGrg_yoW5CFW3pF
 WUJ3y3Zr1DKrW7Jwn7Gw4xAa45X3WxG34UKas8ZasYvrykAFy5A34UGFW0yrZxtr4xJF12
 vF45Cryvg3W5tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJkuxUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB4HEWm6m15fbAAA3Z
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

From: chenyi221 <chenyi221@huawei.com>=0D

Change hinic3 driver to support Huawei new SPx series NIC.=0D
=0D
v2:=0D
--fix build issues=0D
=0D
v3:=0D
--fix community review comments and err reports=0D
=0D
v4:=0D
--fix rss type assignment error=0D
=0D
v5=0D
--fix community ubuntu-22.04-clang err=0D
=0D
Feifei Wang (7):=0D
  net/hinic3: add support for new SPx series NIC=0D
  net/hinic3: add enhance cmdq support for new SPx series NIC=0D
  net/hinic3: use different callback func to split new/old cmdq=0D
    operations=0D
  net/hinic3: add fun init ops to support Compact CQE=0D
  net/hinic3: add rx ops to support Compact CQE=0D
  net/hinic3: add tx ops to support Compact CQE=0D
  net/hinic3: use different callback func to support htn fdir=0D
=0D
 drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++-=0D
 drivers/net/hinic3/base/hinic3_cmdq.c         | 370 ++++------=0D
 drivers/net/hinic3/base/hinic3_cmdq.h         | 112 ++-=0D
 drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 +++=0D
 drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++=0D
 drivers/net/hinic3/base/hinic3_csr.h          |  18 +-=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-=0D
 drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-=0D
 drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-=0D
 drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +=0D
 drivers/net/hinic3/base/hinic3_hwif.c         |  10 +-=0D
 drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-=0D
 drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      | 182 ++---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  98 ++-=0D
 drivers/net/hinic3/base/meson.build           |   1 +=0D
 drivers/net/hinic3/hinic3_ethdev.c            | 279 ++++++--=0D
 drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--=0D
 drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----=0D
 drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--=0D
 drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------=0D
 drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-=0D
 drivers/net/hinic3/hinic3_rx.c                | 266 +++++--=0D
 drivers/net/hinic3/hinic3_rx.h                | 182 ++++-=0D
 drivers/net/hinic3/hinic3_tx.c                | 458 ++++++------=0D
 drivers/net/hinic3/hinic3_tx.h                | 154 +++-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++=0D
 drivers/net/hinic3/htn_adapt/meson.build      |   7 +=0D
 drivers/net/hinic3/meson.build                |   8 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++=0D
 drivers/net/hinic3/stn_adapt/meson.build      |   7 +=0D
 33 files changed, 3362 insertions(+), 1443 deletions(-)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/meson.build=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/meson.build=0D
=0D
--=0D
2.45.1.windows.1=0D
=0D

