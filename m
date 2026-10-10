Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F29CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DA7F4028D;
	Sat, 10 Oct 2026 16:45:17 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 5B3154026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=eG/jcLFQVKC8THHEWvBwhIbyfnVuGxEuD7JQIwSOydI=;
 b=HD6L2dk9C2qRCLyMPJrK86xq90/LQICqM9Y6lMUmE3rSZCslP+kJ4DkPv3v1qm
 3NLrmQqTVlzION5kZ81ZUTWi4Z8VkWJwxZYNe1D0PZB2SNbVdInRDmqPHAg9kK0Q
 lbPTff6GFPhrYeInMEoyUgsAA9qX5EvaAtOUUB5nEHdAU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 00/17] net/hinic3: add PMD features and fixes
Date: Sat, 10 Oct 2026 22:44:51 +0800
Message-ID: <20261010144509.2731-1-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF43Kr4xZFy8Gr1kWr4kZwb_yoW5uw15pF
 WUG3y3Zr1DKrW7Jwn7Kw1xAas8X3Z7Ga47KasrJa4FvFn3ZFy5Z345GFW0yrnxtr47JF12
 vF45Cr92gan0qrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCtCcUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRk-SWrKT3kvjwAA3s
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

This series fixes offload capability advertisement and cmdq/compact CQE=0D
configuration, and adds FEC, CIR drop statistics, VF LAG/link state, COS=0D
mask/map, mbox recording and telemetry, RSS hash configuration, compact CQE=
=0D
Rx/Tx paths, TSO segment expansion, pseudo-header checksum, per-tile cmdq=0D
ops, SP560 NIC support, and device kvargs tunables.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
=0D
Jiacheng Ye (17):=0D
  net/hinic3: fix offload and cmdq/compact CQE config=0D
  net/hinic3: add CIR drop statistics and VF LAG support=0D
  net/hinic3: add FEC mode get/set and capability support=0D
  net/hinic3: add mbox message recording and debug dump=0D
  net/hinic3: add COS mask and COS map support=0D
  net/hinic3: add VF link state and promiscuous support=0D
  net/hinic3: convert cmdq ops to static global variables=0D
  net/hinic3: update RSS hash type configuration=0D
  net/hinic3: refactor flow rule parsing=0D
  net/hinic3: add SP560 NIC type identification and handling=0D
  net/hinic3: add device kvargs parameters support=0D
  net/hinic3: add compact CQE Rx path and ptype table=0D
  net/hinic3: expand TSO from 127 to 255 segments=0D
  net/hinic3: split Tx burst function for compact CQE support=0D
  net/hinic3: add pseudo-header checksum calculation=0D
  net/hinic3: add per-tile prefetch/drop/CEQ cmdq ops=0D
  net/hinic3: add mbox count telemetry support=0D
=0D
 .mailmap                                      |   1 +=0D
 doc/guides/rel_notes/release_26_11.rst        |  13 +=0D
 drivers/net/hinic3/base/hinic3_cmd.h          |   2 +=0D
 drivers/net/hinic3/base/hinic3_csr.h          |   8 +-=0D
 drivers/net/hinic3/base/hinic3_eqs.c          |  59 ++=0D
 drivers/net/hinic3/base/hinic3_eqs.h          |   2 +=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.c       |   2 +=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.h       |   9 +-=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c      |   9 +-=0D
 drivers/net/hinic3/base/hinic3_hwdev.h        |   4 +-=0D
 drivers/net/hinic3/base/hinic3_hwif.c         |   4 +-=0D
 drivers/net/hinic3/base/hinic3_mbox.c         |  53 +=0D
 drivers/net/hinic3/base/hinic3_mbox.h         |  22 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      | 188 +++-=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h      | 116 +-=0D
 drivers/net/hinic3/base/hinic3_nic_event.c    |  79 +-=0D
 drivers/net/hinic3/hinic3_ethdev.c            | 750 +++++++++++--=0D
 drivers/net/hinic3/hinic3_ethdev.h            |  62 +-=0D
 drivers/net/hinic3/hinic3_fdir.c              | 158 ++-=0D
 drivers/net/hinic3/hinic3_fdir.h              |  19 +-=0D
 drivers/net/hinic3/hinic3_flow.c              | 581 +++++++---=0D
 drivers/net/hinic3/hinic3_flow.h              | 196 ----=0D
 drivers/net/hinic3/hinic3_nic_io.c            | 145 +--=0D
 drivers/net/hinic3/hinic3_nic_io.h            | 145 ++-=0D
 drivers/net/hinic3/hinic3_rx.c                | 589 +++++++++--=0D
 drivers/net/hinic3/hinic3_rx.h                | 217 ++--=0D
 drivers/net/hinic3/hinic3_telemetry.c         | 104 ++=0D
 drivers/net/hinic3/hinic3_telemetry.h         |  25 +=0D
 drivers/net/hinic3/hinic3_tx.c                | 997 ++++++++++++++----=0D
 drivers/net/hinic3/hinic3_tx.h                |  81 +-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  71 +-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |   8 +-=0D
 drivers/net/hinic3/meson.build                |   1 +=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |  75 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |   6 +-=0D
 35 files changed, 3625 insertions(+), 1176 deletions(-)=0D
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_telemetry.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_telemetry.h=0D
=0D
-- =0D
2.33.0=0D
=0D

