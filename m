Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43EC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3194014F;
	Fri, 14 Aug 2026 14:54:49 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 56AAC4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:54:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 58327E0AD0;
 Fri, 14 Aug 2026 16:54:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 58327E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712086;
 bh=je1YbTbznobeUpYFqxNGmVj3CzNWPDy9vxZeRjCyb74=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bYfIlRsMrR1GNCC/az8xo0TsB+wLNRafG+gk3VztE5yA6Jv+W1iFy35fClmlvzCmc
 FbvctSCHv8FI7F9NeyyrbsuyI7U3j4+Ten2kHsGbpthJ6QYiXR/yk6Aw3yjVhNgiO8
 d4oNhs+PKXy+OXR3JBhr65Z4z5OvouMlf4D+kiXMnPiKAcN5HIyUgPHxJ6ka7rQawG
 pot1cXQdBeigiOS0/FZpudXCT0VoPF7s4Nh5tlUrxrj2rOYUv59jOeM64oaqOXl56U
 0jxU9DNhNEaidW5VyC0wtptg3Vt5AfGW646Nw9G/LvhJCnGQ3akPpWbaLhnqIkP9nr
 /EZ2tpV7jCTSA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 00/14] common/sfc_efx/base: fix code analysis issues
Date: Fri, 14 Aug 2026 16:54:24 +0400
Message-ID: <20260814125438.13283-1-ivan.malov@arknetworks.am>
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

This series addresses code analysis defects in the
common/sfc_efx/base library.

The first four patches fix excessive stack consumption in
MCDI helper functions, each exceeding 1 KB on-stack, by
switching to heap-allocated payload buffers.

The remaining ten patches correct SAL annotations, add
assertions and bounds checks across netport and filter
helpers to address uninitialised memory, buffer overrun,
and potential dereference issues. The final patch widens
loop variable types to address a CodeQL warning.


v3:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343201.html
  -- patches 01-04: switched to EFX_MCDI_BUF_SIZE
  -- patch 05: replaced the unreachable NULL guard with
     EFSYS_ASSERT; corrected the commit message
  -- patches 09, 13: moved __success to the declaration line
  -- patch 11: added stride and count bounds check before the loop
  -- patch 13: documented the TECH_AUTO default behaviour


v2:

- note for the future AI reviews: apply this on top of
  the 'next-net-main' branch

- addressed https://mails.dpdk.org/archives/dev/2026-August/343072.html
  -- fixed the MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES accessor
  -- fixed the FEC hardware enum selection from the software mask
  -- remaining notes do not seem to point at factual defects



Andy Moreton (14):
  common/sfc_efx/base: reduce stack in RSS context table write
  common/sfc_efx/base: reduce stack in get addr regions MCDI
  common/sfc_efx/base: reduce stack in set addr regions MCDI
  common/sfc_efx/base: reduce stack in netport stat describe
  common/sfc_efx/base: fix filter saved spec handling
  common/sfc_efx/base: fix annotations in client MAC addr get
  common/sfc_efx/base: fix annotations in HW-SW mask converter
  common/sfc_efx/base: fix annotations in get fixed port props
  common/sfc_efx/base: fix annotations in SW-HW enum converter
  common/sfc_efx/base: fix annotation in netport stat describe
  common/sfc_efx/base: fix flex array in netport stat describe
  common/sfc_efx/base: fix filter in SW-HW mask converter
  common/sfc_efx/base: rework SW mask to HW enum converter
  common/sfc_efx/base: cleanup wider type comparisons in loops

 drivers/common/sfc_efx/base/ef10_filter.c |   7 +-
 drivers/common/sfc_efx/base/ef10_mcdi.c   |   2 +-
 drivers/common/sfc_efx/base/ef10_nvram.c  |   4 +-
 drivers/common/sfc_efx/base/ef10_rx.c     |  23 ++-
 drivers/common/sfc_efx/base/efx.h         |   3 +-
 drivers/common/sfc_efx/base/efx_bootcfg.c |   2 +-
 drivers/common/sfc_efx/base/efx_mcdi.c    |  51 +++++--
 drivers/common/sfc_efx/base/efx_np.c      | 167 +++++++++++++---------
 drivers/common/sfc_efx/base/mcdi_mon.c    |   2 +-
 9 files changed, 168 insertions(+), 93 deletions(-)

-- 
2.47.3

