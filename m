Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10DC982C7
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 15:22:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17934427E2;
	Fri, 16 Jan 2026 16:22:57 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1F94E4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 16:22:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768576975;
 bh=xuFV9+k41zTYcEeOWYyDKSOKdXnQ63p3LYWWY/ACE2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gBKUC7En13Ma0aP57LM3DTjpS6VQgtllvCnrjVgiF1L1To6YysGvnGqI1uxs7Y+cS
 a16hmGuKIVAKZQHZnt5ioq+q3A3rxHJFOV3N0J3gAHvHmV5rszlj0JQYt+rHAMj+s8
 BYow8A+W2tXUvw5StsEb2l9EzLtCgFkHfwlpjKU3G8TNcYAOtKdwK0LYFNFGeHnJ2G
 pKtJIZuWRvM2YVrGejta79y99ETnWeZRgn1kcy90oglAQW0H7ZlAHUt6wJqzGQltRT
 3q/KA4AE0WRGu3k50zQlthby+GlS76X5TAoyZ9yJWpN0VhlQ9Sot5K1A76P+rfC5Ih
 Bkrz2GH5Fr6YQ==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E7B821180078;
 Fri, 16 Jan 2026 16:22:55 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v3 0/6] net/nfb: code cleanup
Date: Fri, 16 Jan 2026 16:22:51 +0100
Message-ID: <20260116152251.1467025-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb.h        |   5 ++
 drivers/net/nfb/nfb_ethdev.c | 164 ++++++++++++++++++++---------------
 drivers/net/nfb/nfb_rx.c     |   2 +-
 drivers/net/nfb/nfb_rx.h     |  13 +--
 drivers/net/nfb/nfb_rxmode.c |  12 +--
 drivers/net/nfb/nfb_stats.c  |  46 +++++-----
 drivers/net/nfb/nfb_tx.c     |   2 +-
 8 files changed, 141 insertions(+), 109 deletions(-)

--
2.52.0

