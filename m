Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601EE73165
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 19:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC2C94027D;
	Mon,  2 Feb 2026 20:33:36 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id D9F944026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 20:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770060815;
 bh=pq7wWrfxObCYfzQxNeaSvpRgKt7GiPqn9pVg807rDa4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NMs/tzFSyd51NZJE7fHk8ulaufqYB627YuVmaLKWX5VzMQaqUxw3iXVF46CC2GYH/
 DJMzpcOp9JJWXWfcVEYCFGqYk7Ipoq5VaSaVtDcGd4n2A6ajm8pMZJAgj+aGcnyFYb
 uHjBdGCHu3zUJXZ9yjvAn74ozOOVukMU5SGAonnW/BLlwWjszS4dD205SaqxvjlfAE
 /HwT/nokh+QT1Uk3v17DpAUmqTnqVYCdDjgdrUbxC5Uo9Ayo0AjpVTu2Ih7OlVn5kG
 1sXkTzaL2Ud+Yw9IqUF6SJfpTqNh7BLNxTc2NF0FBRoYwrLRMI//Ynr3SedQ5Z1122
 udRyrjwfvW42g==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 96DE31180072;
 Mon,  2 Feb 2026 20:33:35 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v5 0/6] net/nfb: code cleanup
Date: Mon,  2 Feb 2026 20:33:24 +0100
Message-ID: <20260202193330.3324681-1-spinler@cesnet.cz>
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
v5:
* Rebased to next-net-main

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

