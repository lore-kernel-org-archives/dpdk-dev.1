Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65285C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F07D40DF5;
	Wed, 12 Aug 2026 19:10:20 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C667340B9D
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:10:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 150B3E07BF;
 Wed, 12 Aug 2026 21:10:19 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 150B3E07BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554619;
 bh=b80iuSet089wLEH3lPtIAdycfJNHdUGiFYiUjSi6d7U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XhX1zgc0/a6p5Oh3/fJmTBlR6aXLZ4WBdFH9oe5Dg7bAcHcGCb1JhzxNz8lo9BIy2
 TFUZyq0E7TR0zaSkIF3EZcfFRg6AclQGkv/cofSR5o3TRppB5USK/9lty7P5sHmJYu
 g54/O+CC8HpeXuLJ06a5k7MDsmcNVr1j66Ot1Jbk/W1tvOewusMepkMxHqndm36Uge
 HOe51fTGX4x8qFLWl4A9OCCPn1UJLO6jSw3Ishq8PUMa7CBC3xAguVo7w3RDgAmrmm
 cdK6YpDl6/lzsgr9NqXG8IMu+wpO4RPHW6jloFk9Ll0Yq8dTZGRanA0QRyK3wGSvUp
 sHt6UGA8eOQQQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 0/3] net/sfc: miscellaneous bug fixes
Date: Wed, 12 Aug 2026 21:10:14 +0400
Message-ID: <20260812171017.8521-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174913.8961-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
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

Three independent fixes. The first ensures that Rx queue
type flags are derived from scratch on every queue setup,
preventing flags from a prior configuration persisting
when an offload is disabled.

The second patch removes an erroneous static qualifier
from a flow RSS iterator variable, which incorrectly
shared state between multiple interfaces.

The third patch corrects reading of the advertised
autoneg capability. When the user disables it, the
corresponding bit was re-added upon the next
link-state query.


v2:

- note for the future AI reviews: apply this on top of
  the 'common/sfc_efx/base: fix code analysis issues' series

- addressed https://mails.dpdk.org/archives/dev/2026-August/343072.html
  -- fixed the queue type flags so that it accounts for the extra flags
  -- the rest of the notes do not point at factual defects


Ivan Malov (3):
  net/sfc: set Rx queue type flags from scratch on queue setup
  net/sfc: drop wrong static qualifier from iterator variable
  common/sfc_efx/base: fix reading advertised autoneg ability

 drivers/common/sfc_efx/base/efx_np.c       | 11 +++++------
 drivers/common/sfc_efx/base/medford4_phy.c |  6 +++++-
 drivers/net/sfc/sfc_flow_rss.c             |  2 +-
 drivers/net/sfc/sfc_rx.c                   |  8 ++++----
 drivers/net/sfc/sfc_rx.h                   |  1 +
 5 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.47.3

