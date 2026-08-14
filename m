Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E383C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 011DF40613;
	Fri, 14 Aug 2026 14:55:48 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6810C402B8
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:55:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A62D4E0AD0;
 Fri, 14 Aug 2026 16:55:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A62D4E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712147;
 bh=iSebP/w61T2YfmI/ZZMigXAKy+5qgvBgTESBgjTx48w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=65mztvgU9f81wtiBEil2yDHsC1gPvRZQg3dOsYI8gkhWol82DmZgthzyYpziQqKV9
 6j4IfieX2SDavPtNK1y8aLuM+JOKIYCGDJ4z0CmGGYoDSFskOUG85d8GolxTvgUvow
 nVYtFSJmJ6o0KeO8MswzrDdrm15Aw2H0deFU7/TcPld7RDeMHnpKUgdrch8SII1JwL
 8rL+KzqJzjlswvoPcHyDv5C1OgSfNMOSAKZDD6SaDK0JsHUqnP37e0GwtuQpONP2eV
 kGSQdJsJPiL3xWj7BGMZNIiMUS5aUn2sV5JyundEpVdhS5KvR2dDM3RJHhVcX5AxUD
 hGuAimRVz6fKQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 0/3] net/sfc: miscellaneous bug fixes
Date: Fri, 14 Aug 2026 16:55:42 +0400
Message-ID: <20260814125545.13343-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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


v3:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343202.html
  -- patch 3/3: added Depends-on; inlined ep_adv_cap_mask


v2:

- note for the future AI reviews: apply this on top of
  the 'common/sfc_efx/base: fix code analysis issues' series

- addressed https://mails.dpdk.org/archives/dev/2026-August/343073.html
  -- fixed the queue type flags so that it accounts for the extra flags
  -- the rest of the notes do not point at factual defects



Ivan Malov (3):
  net/sfc: set Rx queue type flags from scratch on queue setup
  net/sfc: drop wrong static qualifier from iterator variable
  common/sfc_efx/base: fix reading advertised autoneg ability

 drivers/common/sfc_efx/base/efx_np.c       | 11 +++++------
 drivers/common/sfc_efx/base/medford4_phy.c |  5 ++++-
 drivers/net/sfc/sfc_flow_rss.c             |  2 +-
 drivers/net/sfc/sfc_rx.c                   |  8 ++++----
 drivers/net/sfc/sfc_rx.h                   |  1 +
 5 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.47.3

