Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D71C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4234942798;
	Wed, 12 Aug 2026 19:10:42 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3B4B440E0C
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:10:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8624CE0872;
 Wed, 12 Aug 2026 21:10:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8624CE0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554641;
 bh=FEU/2+mgvbkRFM1uGFaLXIo/zEh1MiLbo21fsBlwRRY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4dkW3q3f1HHMCg66srPe/HUwIcJmaPaMZcWbMoCH7uEZGiAjeK3rwuLh3q/n8n3Xc
 d1BbRrn3B1SKaKmcUIvNh36ArCBPu0j1/Yzy04o4Q+VIA7PCLKQj0b56YOxSeFIaBH
 AOcpHqZXpM6Y+Zfj4JwASGVZ4ZPcHbJX21lvtwcT2CqgDYGYzJDdlZNdbWZ/N9nQ+D
 fP1aQAVvNYcIQCvTbxdHXbMm05TWjCZFwwrDllGBPKoloS50YpedfJyRIhFGZ5l9je
 64YwLmybqjDUMq64Ezmg6RnvAwjzjHFAjwUWsqwmJgraG90LQ5jZ/HQfbkchFnCCFo
 OeFD+Nev+KcFw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 0/3] common/sfc_efx/base: add VADAPTER statistics for
 Medford4
Date: Wed, 12 Aug 2026 21:10:36 +0400
Message-ID: <20260812171039.8538-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174949.8993-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
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

