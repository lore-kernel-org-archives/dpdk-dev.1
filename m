Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A29D44C59
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E59B42670;
	Thu, 15 Jan 2026 15:41:11 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id ADF3F410E3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:41:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768488069;
 bh=YJKZMT7x+vHaaXjWf+1I5KNoTrtdVfxr4SpnnhNOliU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lfwiU5HSVlTHyxVY7YoF5fLphG2u6AtGsVDDsLSXzBdBGFKk888dmugPpcUlWoDny
 xNP1W79Lmx7prkkGk4cVJvxGluFSDGS8iUhljnIZrrHpIWdvcrUPBRMRQEe4UrNG6k
 RE+9RHkK9gp9qXV/U8pJW+HkuMY2rGT64TbcUR/i66XyI+22GNadu7NH013oPkcEaS
 QESSmXoUswr3UkxvzVTcuBZWJMsuc38Z4a/NLVCInDBP+m/Mti1g2lh5rMP23i39Yb
 neMwDnO9dyVYLWDuxgsyxT+j2Hs8FKXtwKjcx/oijw5dayQYYb/DcRLBbSgkWuwsGQ
 TRyXW96HCG5dw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 7170B1180078;
 Thu, 15 Jan 2026 15:41:09 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 0/6] net/nfb: code cleanup
Date: Thu, 15 Jan 2026 15:40:34 +0100
Message-ID: <20260115144040.345873-1-spinler@cesnet.cz>
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
v2:
* Fixed coding style issues

Martin Spinler (6):
  net/nfb: use constant values for max Rx/Tx queues count
  net/nfb: fix bad pointer access in queue stats
  net/nfb: update timestamp calculation to meaningful value
  net/nfb: use process private variable for internal data
  net/nfb: release allocated resources correctly
  net/nfb: stop only started queues in fail path

 doc/guides/nics/nfb.rst      |   6 +-
 drivers/net/nfb/nfb.h        |   5 ++
 drivers/net/nfb/nfb_ethdev.c | 165 ++++++++++++++++++++---------------
 drivers/net/nfb/nfb_rx.c     |   2 +-
 drivers/net/nfb/nfb_rx.h     |  13 +--
 drivers/net/nfb/nfb_rxmode.c |  12 +--
 drivers/net/nfb/nfb_stats.c  |  46 +++++-----
 drivers/net/nfb/nfb_tx.c     |   2 +-
 8 files changed, 142 insertions(+), 109 deletions(-)

--
2.52.0

