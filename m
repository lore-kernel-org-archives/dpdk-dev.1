Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF194C43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB7C7402BE;
	Tue, 30 Jun 2026 13:16:23 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id B337540278
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:16:20 +0200 (CEST)
X-QQ-mid: zesmtpsz7t1782818176tef6b565a
X-QQ-Originating-IP: BJs2ABMCOeETh+hXie1Meq0hBvFj508YPe+/2fbYm24=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.190.76])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Jun 2026 19:16:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10326304201680299975
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 0/4] Wangxun fixes and new features
Date: Tue, 30 Jun 2026 19:16:00 +0800
Message-Id: <20260630111608.22196-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mp1EL4S+EMGramXmzcrOecjkw3xqLm6MO013gYtHk0KHRFm54aj8HIVe
 Dxx6TPaEsJrOroyx/1aj58CJ2zm8g92Z8BIWKPV22dOaweOEN2UXE3/r9pQ2El2wjOlqrdk
 Xhyn6axnCPDN+zCOGqgy80393LfaaHG0g2eoKE1KfCfjMpAiP1pJ2O9ABhT2hUZvp9NVYFS
 xoDeZAA6ApCGLlN++neahwNf5Zv4Ga/hNOXAHNBzcR6wnhKqhK5ayAUiioDcc/rDv+M89jJ
 lJl/lhaaUbiapn5xl+bIIp0vBHc42zX06fadvmhske6qtb98Mqb6DkAd99lW6F0F+vwScnw
 7D4AHA56qAI+4Hjc+1F6jcPmx8DhCoUfcAMKiVOoLHXdh54kGDtcou0/VgUaqa/FQ74i0qi
 eD1zwREpTgal3JmG/nV1PZiI0BUAaOSQRlsH1qxVWzStr6ld1wIa/SMgdyE1tf7EtfRyDOD
 EVhNaVoveOIa1AxfDdt7brQTL56RjwN8oE3eue6dvZnBtWxqTQUudnI2zaMlXbZ9t57EiPb
 T6NGnCVVtnUegEdPryDXZjSR03Z/VoVTz6+ciTspQM9IYTosNeJApy/cHuanIBL7ksSZO7s
 4WauS4XNcOsAJ+h3ZNMGjp8/Bs73d0dB3uMKQWgwMuWseapAItH55mbnnabpSH2lTg9Hc9e
 esdnO4tUOL5yhS6cA2QHsvqSUK3hSOFanFxYnaXOGuhBFha5Am5MJbPeYp7mVgw7DDWiAKl
 DR6/qm1yPN2tHCUGc1clStVbypHvdnT2+rPFMIsYNbLPX5pfmojYgDmxmk/I6T6+GxMXz3/
 GegISxhJLupReBhnbhy+MWvc+Zky/izISXxLfWUUiSmSwb1irLB74a4bD0JocF+TuqtXwQE
 DL/Otl7gXn87RXYUShInV/vIlhnWjmqrMgulM5PGkqgxpBQOB5yX1RwsMZTcK7Ff4WuYWrQ
 MgvlJgic6E4rVe90gGU6wX0CltTtJWP8q5DgcvC62re3hQlr+lCvGhIUgjxgZ4CZyf25Ijf
 XM4hOtDMicfibWAO8Er61yskXFeVA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

This patchset introduces three new features and critical fixes for our
recent release cycle.

Patches 1-2 add support for UDP Segmentation Offload (USO) to improve
large-packet transmission performance for UDP workloads.

Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
better fault tolerance and fast recovery in virtualized environments.

Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
was previously omitted in the initial integration.
---
v4:
- Patches 1-4: add release notes
- Patch 3: consume the mailbox message before checking the CTS flag;
           separate CTS validation from link status processing by
	   returning early after handling a CTS-less control message;
	   make pf_running atomic.
---
v3:
- Patches 1-2: change from new feature to bug fix.
- Patch 3: fix link status update in txgbevf_get_pf_link_status();
           extend speed mask from 0xFFF0 to 0x1FFFFE for 40G speed;
           reduce msgbuf array to a single u32 variable;
           correct commit message.
- Patch 4: add a cleanup note in commit message for dropping the
           redundant mac type check in txgbevf_check_mac_link_vf();
	   remove a redundant blank line in txgbe_reset_hw_vf().
---
v2:
- Rebased on top of commit 72fdcb7bd19d to resolve conflict in
  drivers/net/txgbe/base/txgbe_type.h.
- No code changes compared to v1.
---

Zaiyu Wang (4):
  net/ngbe: implement USO support
  net/txgbe: implement USO support
  net/txgbe: add support for VF sensing PF down
  net/txgbe: add VF support for Amber-Lite 40G NIC

 doc/guides/rel_notes/release_26_07.rst | 21 ++++++
 drivers/net/ngbe/ngbe_rxtx.c           | 13 ++--
 drivers/net/txgbe/base/txgbe_devids.h  |  2 +
 drivers/net/txgbe/base/txgbe_hw.c      |  7 ++
 drivers/net/txgbe/base/txgbe_regs.h    |  7 +-
 drivers/net/txgbe/base/txgbe_type.h    |  2 +
 drivers/net/txgbe/base/txgbe_vf.c      |  6 +-
 drivers/net/txgbe/txgbe_ethdev.c       |  5 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c    | 88 ++++++++++++++++++++++----
 drivers/net/txgbe/txgbe_rxtx.c         | 13 ++--
 10 files changed, 136 insertions(+), 28 deletions(-)

-- 
2.21.0.windows.1

