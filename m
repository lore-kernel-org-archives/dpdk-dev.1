Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8AAD44C48
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC3A640608;
	Thu, 15 Jan 2026 15:01:54 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 547B04003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768485713;
 bh=q55sChql3incdGDJPz0ARO8OLXm0WoqNKoA3oJFSvrA=;
 h=From:To:Cc:Subject:Date;
 b=fpjLwEwPuTEd0i2mMn500gWf2VGgTQzsvhdIbnLbzdvfwQmyGZFFY9s9AUV3VA000
 SP2TSUs7Z3CCUrSQbRXTzx+ryXuiZDvFLDQCwJsxb9ZNOOJRkU0vtVl1vxPuyYcOkl
 +1RbMksggSmws4j8gWmGKsP9alP2RF4X8dKlkla4OcCP4kZmDXYIndlAyBPpDs22K8
 CYjur4gsgMQPhGWSJlUJ6oCxzCSJxu9jaUJJ8lM7MGsAr7fqW7N7dx35iI2jdlpA81
 y51J/xjvSFwqLB2rmobyJ4ZMzQNbbBzugmWD72NLdPDFfIFla8FO3syv6OXUglmKi0
 Lo58qbmrgXhBA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 0C1F91180078;
 Thu, 15 Jan 2026 15:01:53 +0100 (CET)
From: spinler@cesnet.cz
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: [PATCH 0/6]
Date: Thu, 15 Jan 2026 15:01:28 +0100
Message-ID: <20260115140134.235877-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
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

Martin Spinler (6):
  net/nfb: use constant values for max Rx/Tx queues count
  net/nfb: fix bad pointer access in queue stats
  net/nfb: update timestamp calculation to meaningful value
  net/nfb: use process private variable for internal data
  net/nfb: release allocated resources correctly
  net/nfb: stop only started queues in fail path

 doc/guides/nics/nfb.rst      |   6 +-
 drivers/net/nfb/nfb.h        |   5 ++
 drivers/net/nfb/nfb_ethdev.c | 163 +++++++++++++++++++++--------------
 drivers/net/nfb/nfb_rx.c     |   2 +-
 drivers/net/nfb/nfb_rx.h     |  13 +--
 drivers/net/nfb/nfb_rxmode.c |  12 +--
 drivers/net/nfb/nfb_stats.c  |  46 +++++-----
 drivers/net/nfb/nfb_tx.c     |   2 +-
 8 files changed, 141 insertions(+), 108 deletions(-)

--
2.52.0

