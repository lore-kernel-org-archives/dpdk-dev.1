Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E91C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5076427B5;
	Tue, 11 Aug 2026 19:49:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EBB94427A7
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:49:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 38869E05C7;
 Tue, 11 Aug 2026 21:49:50 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 38869E05C7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470590;
 bh=7SfKCA2zSm1N0gQ0/FTcE/KHhDL8D5b8GzX+5IAhjp0=;
 h=From:To:Cc:Subject:Date:From;
 b=Vpd5G6p9X2f6Sx1q6pbjLRjEW3pJ1cQpa27hnWVMG+yebJOtbej7FT3pAcLAefFAp
 ruffDpxJKIvF+6nN2X/9stU+uRkQWtfkYHUR2dZcGQUuIs0//RXMikagLkouS2vPcJ
 8HimCKW1569RWkyQCnVEKYpVJLrO6y6nkTqdKHv7l9Whz2T6aXX1kvUOC4t8hYYD+p
 eCDfgqoK/pArPGveX5QlVU8CLo68gnohRW3FOexzntE+AjSyeTYciIW8YSXRu8dydy
 5/P17udxupFSjOL0WfwtVqFIYsVYQvDTDqlYjm8++5EW+3Ev7IJUt5GRoKQGBHIvmX
 vXx664fz9ze3Q==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/3] common/sfc_efx/base: add VADAPTER statistics for Medford4
Date: Tue, 11 Aug 2026 21:49:46 +0400
Message-ID: <20260811174949.8993-1-ivan.malov@arknetworks.am>
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

This series adds support for per-VF (VADAPTER) MAC
statistics on Medford4 in the libefx base layer.

The first patch selectively updates the MCDI headers, adding
new definitions needed by the subsequent patches.

The second patch introduces netport VADAPTER statistics IDs,
which identify the per-VF counter set returned by the NIC.

The third patch switches the netport statistics call to use
GET_NETPORT_STATISTICS_V2, passing the EVB port handle so
that the correct per-VF counters are retrieved.

Andy Moreton (2):
  common/sfc_efx/base: add support for VADAPTER statistics IDs
  common/sfc_efx/base: switch netport stats to use EVB port ID

Ivan Malov (1):
  common/sfc_efx/base: update MCDI headers

 drivers/common/sfc_efx/base/efx_impl.h      |   3 +-
 drivers/common/sfc_efx/base/efx_mcdi.c      |   2 +-
 drivers/common/sfc_efx/base/efx_np.c        |  60 +++-
 drivers/common/sfc_efx/base/efx_regs_mcdi.h | 313 +++++++++++++++++++-
 drivers/common/sfc_efx/base/medford4_mac.c  |  12 +-
 5 files changed, 373 insertions(+), 17 deletions(-)

-- 
2.47.3

