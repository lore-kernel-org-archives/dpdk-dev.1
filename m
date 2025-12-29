Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4BE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC68D402B6;
	Mon, 29 Dec 2025 22:35:36 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 059664025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 22:35:35 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 34710E13A8;
 Tue, 30 Dec 2025 01:35:35 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 34710E13A8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044135;
 bh=0MwqTMpSTWq/kKr57VtB0KlQo2fGYNqMym2PJT3yOw4=;
 h=From:To:Cc:Subject:Date:From;
 b=iflsidHgmZN5Z6WIqCxKZbfvOShK8fH4RosqQFgmKGpv0++xS5z9E1UuE78GQ/DBe
 qlTCWWAtPH0FplM3zzKfrA4t9ZasF2ijX3x9pg4AVXVQHVcL2yCDY8qzkLHv3rPl9z
 /ot3cAQAiyf6HJW/tU/Br5efEEpAVz3/FiDYLScJivLOh1p/B55WWZRUKIsbXmq9TA
 uJiNqGQdSzDtoq7yzfZmhCOSIF/IlCZiHRQtXcigM8SzsuIEQ7prDMI0WzxXnmhZH2
 jGtIyDJwqaHrg+FVbx7ZgDvLzDjBY84pom0OByxplsW1WiYzoqBJ7ncXavlmstJTk8
 3YyHKFaRFBobQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 0/9] net/sfc: SFN7xxx deprecation and Medford fixes
Date: Tue, 30 Dec 2025 01:35:18 +0400
Message-ID: <20251229213527.37907-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The series provides various fixes, primarily for Medford4 support.
It also fixes a legacy flow control bug; due to hardware constraints
in the fix, SFN7xxx NICs are now marked as deprecated.

Andy Moreton (1):
  common/sfc_efx/base: count Rx TRUNC ERR as CRC errors on X4

Ivan Malov (8):
  doc: remove support for AMD Solarflare SFN7xxx family boards
  common/sfc_efx/base: fix flow control setting on legacy MCDI
  common/sfc_efx/base: fix indication of requestable FEC flags
  common/sfc_efx/base: define mask for pause mode capabilities
  net/sfc: avoid speed reset when setting FEC in started state
  net/sfc: rework the capability check that is done on FEC set
  net/sfc: drop AUTO from FEC capabilities and fix the comment
  net/sfc: fix reporting status of autonegotiation to the user

 doc/guides/nics/sfc_efx.rst            |  14 ---
 doc/guides/rel_notes/release_26_03.rst |   4 +
 drivers/common/sfc_efx/base/ef10_ev.c  |  41 +++++--
 drivers/common/sfc_efx/base/ef10_mac.c |  35 ++++--
 drivers/common/sfc_efx/base/ef10_nic.c |  57 +++++-----
 drivers/common/sfc_efx/base/efx.h      |   1 +
 drivers/common/sfc_efx/base/efx_np.c   |   2 +-
 drivers/net/sfc/sfc.h                  |   2 +-
 drivers/net/sfc/sfc_ethdev.c           | 141 +++++++++++++++----------
 drivers/net/sfc/sfc_ev.c               |   7 +-
 drivers/net/sfc/sfc_port.c             |   8 +-
 drivers/net/sfc/sfc_repr.c             |   2 +-
 12 files changed, 193 insertions(+), 121 deletions(-)

-- 
2.47.3

