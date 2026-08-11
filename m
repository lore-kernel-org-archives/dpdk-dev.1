Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677E3C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66B48415D7;
	Tue, 11 Aug 2026 19:49:17 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id ACD8C4278E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:49:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A4F87E0BE5;
 Tue, 11 Aug 2026 21:49:14 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A4F87E0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470555;
 bh=9BScmQFAKPk+Ekcv08wC0WM7cbLztQcA5okl2dSERqY=;
 h=From:To:Cc:Subject:Date:From;
 b=E9uZKl6GFzu9gbIdqhTVdtm8GjtoaPlIrDsXG6UJ4Cv3oG9X58La3XI3T6n7bJMS3
 gdtG+1862iOJv5HTQYaEfgYe/QX67k36PeW3bvAl6E6QqTAU7PXvd4ICEsDNvbqMaP
 8CvwWZhfsjvfRbnowhFaLLjIJAcB2yAwTuFA7jfuyiGHrEzRKL8KW+5hl0AP1ZX4gz
 1ldl5X1lPzmLSLZ9SUWqyVGG0PGh4hkLEDizhERSGnYlhltrhQiwN/I9p3GyAFhGQr
 ICnbCGVCRCYTf0lanUQExzGptiYhjetK0t/ICQ7UO5kic+8M7CGTAcod91QVHch+OV
 dkOEz6Li3T3Ag==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/3] net/sfc: miscellaneous bug fixes
Date: Tue, 11 Aug 2026 21:49:10 +0400
Message-ID: <20260811174913.8961-1-ivan.malov@arknetworks.am>
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

Ivan Malov (3):
  net/sfc: set Rx queue type flags from scratch on queue setup
  net/sfc: drop wrong static qualifier from iterator variable
  common/sfc_efx/base: fix reading advertised autoneg ability

 drivers/common/sfc_efx/base/efx_np.c       | 11 +++++------
 drivers/common/sfc_efx/base/medford4_phy.c |  6 +++++-
 drivers/net/sfc/sfc_flow_rss.c             |  2 +-
 drivers/net/sfc/sfc_rx.c                   |  2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.47.3

