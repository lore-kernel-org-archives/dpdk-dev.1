Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E817C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE0640A71;
	Fri, 14 Aug 2026 14:56:11 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4D784402DF
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 87F46E0ADB;
 Fri, 14 Aug 2026 16:56:09 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 87F46E0ADB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712170;
 bh=MvvlDNVZX1mcLiQGRTFADXw0D33ix8xvYcU0Czj1ZBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lkCuRp4P42oJXiycvjJRnD8bNBuih9+z8R5g0plygvzlZLA+cwR9sIB8l7WRuKQWA
 lMRdAV9KGv9KWUf0odbzC5CE64cHzCKESajogcQ1WE8WUycSd/WDSiJvqLD1o7cJ4n
 pcYaybA2+jharkOoNFC21iqfmqgPhGzEYKVckiY5BvA9FlC7b159GTkQb9VPRiHFyQ
 CGt+CKwkd3JbanJbjrd5qOYgvEptHjmDATz8sOrqvDPhsEvrhdv5TqVNQfIdaDd28z
 1Bh+qs5qT6jYG1DQ5qwcWdaydry4T+XeQt9kr/u7yWblmgBlKwgigetH1ljzHx7g4+
 r6tFjKGWdyymQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 0/3] common/sfc_efx/base: add VADAPTER statistics for
 Medford4
Date: Fri, 14 Aug 2026 16:56:05 +0400
Message-ID: <20260814125608.13358-1-ivan.malov@arknetworks.am>
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

This series adds support for per-VF (VADAPTER) MAC
statistics on Medford4 in the libefx base layer.

The first patch selectively updates the MCDI headers, adding
new definitions needed by the subsequent patches.

The second patch introduces netport VADAPTER statistics IDs,
which identify the per-VF counter set returned by the NIC.

The third patch switches the netport statistics call to use
GET_NETPORT_STATISTICS_V2, passing the EVB port handle so
that the correct per-VF counters are retrieved.


v3:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343074.html
  -- patch 3/3: documented why V2 is used unconditionally


v2:

- note for the future AI reviews: apply this on top of
  the 'net/sfc: miscellaneous bug fixes' series

- v1 review notes do not seem to point at factual defects



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

