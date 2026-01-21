Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7390C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B47427C5;
	Wed, 21 Jan 2026 18:01:59 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 11CCE40261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769014917;
 bh=QvrKbdKb4sZpv41rAZGfnAwon6x/3szNhnzUCxBIjNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jJUKgIjL+MIobzDMb5p1V4AFaKtJjsUzGTheekhbL1eS9RUNwT6Y7gM6b6zsCkhxN
 0hI/m2J5fK6QaeAm4DxmMnPJQVjZe8kvDjMDn9db0xabVPtXBd3/2eJm3ej8w9bGqi
 okP3/XoOIEQ2cevT0HNxVYmsp5I14JkIK3FaGpqluMjG15ZfpiayRtkMx1r+N6jF0h
 iIDcAVDJkOiMFFh7smllGVbP/qsOgmtNUj2QpguOP97XhugWw2193VUqhZk1vk2V6/
 xVnU3xXaGJm05guXqU253tXi1FD0pbFbL22JWChdtxWoHgvTc/8R/PDug899c7OHym
 +AvG2UhMC+FGw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B32CB1180072;
 Wed, 21 Jan 2026 18:01:57 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 0/6] net/nfb: code cleanup
Date: Wed, 21 Jan 2026 18:01:14 +0100
Message-ID: <20260121170120.268553-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115140134.235877-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

This patchset mainly cleans up the code and prepare it for another
quite large rework. Also it resolves some unpleasant behavior.

---
v4:
* Added comment for process private/shared data.
* Added Fixes+Cc tag for patch 4,5,6
* Moved shared data assignments to RTE_PROC_PRIMARY block

v3:
* Changed type of queue count variable to uint16_t.
* Fixed wrong queue count variable usage in log.
* Fixed another coding style issues.

v2:
* Fixed coding style issues.


Martin Spinler (6):
  net/nfb: use constant values for max Rx/Tx queues count
  net/nfb: fix bad pointer access in queue stats
  net/nfb: update timestamp calculation to meaningful value
  net/nfb: use process private variable for internal data
  net/nfb: release allocated resources correctly
  net/nfb: stop only started queues in fail path

 doc/guides/nics/nfb.rst      |   6 +-
 drivers/net/nfb/nfb.h        |  14 ++-
 drivers/net/nfb/nfb_ethdev.c | 166 +++++++++++++++++++++--------------
 drivers/net/nfb/nfb_rx.c     |   2 +-
 drivers/net/nfb/nfb_rx.h     |  13 +--
 drivers/net/nfb/nfb_rxmode.c |  12 +--
 drivers/net/nfb/nfb_stats.c  |  46 +++++-----
 drivers/net/nfb/nfb_tx.c     |   2 +-
 8 files changed, 152 insertions(+), 109 deletions(-)

--
2.52.0

