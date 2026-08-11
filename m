Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B037C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 708B640285;
	Tue, 11 Aug 2026 19:48:32 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id A47F24021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:48:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 03DABE0BE5;
 Tue, 11 Aug 2026 21:48:28 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 03DABE0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470509;
 bh=qBwXg2WWmeW4O3T53hLYbIbU7+UmaLe75iXzuQs3z90=;
 h=From:To:Cc:Subject:Date:From;
 b=HyYa0YizVpFSHjTMhRX/u88sUNoTKWs6o4I+t6WDBBwdqJBudSKEqyC9e+SxQl4CO
 Ru0XDgvZOldy+JbkpqxVlt8O6FBh9eAJ28DbkWqD4KzvR+kgTft2pGDwSGMbJtuQUV
 AqKqOt2fhvjiw+xbHo2FSGT3jy01384OiAVzVEw4Oc45E1KlCO/CW7nImbhKPAEHXw
 Jp/oZs16VaPqv8Jnx9/S2MNS9U+sRjaxL4nMVTUTVuw3sayF/na1/SBNad2PH8NgY7
 sBYviYxY/ByA2HyrGumZZDO8EQTX2TJdJCRPyHDUSesbYCCflIzppezE4MxaorF9KW
 6A4K63aMhLOZA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 00/14] common/sfc_efx/base: fix code analysis issues
Date: Tue, 11 Aug 2026 21:48:07 +0400
Message-ID: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

This series addresses code analysis defects in the
common/sfc_efx/base library.

The first four patches fix excessive stack consumption in
MCDI helper functions, each exceeding 1 KB on-stack, by
switching to heap-allocated payload buffers.

The remaining ten patches correct SAL annotations, add NULL
checks across netport and filter helpers, resolving
uninitialised memory, buffer overrun, and potential
dereference issues. The final patch widens loop
variable types to address a CodeQL warning.

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

 drivers/common/sfc_efx/base/ef10_filter.c |  11 +-
 drivers/common/sfc_efx/base/ef10_mcdi.c   |   2 +-
 drivers/common/sfc_efx/base/ef10_nvram.c  |   4 +-
 drivers/common/sfc_efx/base/ef10_rx.c     |  22 +++-
 drivers/common/sfc_efx/base/efx.h         |   3 +-
 drivers/common/sfc_efx/base/efx_bootcfg.c |   2 +-
 drivers/common/sfc_efx/base/efx_mcdi.c    |  50 +++++--
 drivers/common/sfc_efx/base/efx_np.c      | 152 ++++++++++++----------
 drivers/common/sfc_efx/base/mcdi_mon.c    |   2 +-
 9 files changed, 155 insertions(+), 93 deletions(-)

-- 
2.47.3

