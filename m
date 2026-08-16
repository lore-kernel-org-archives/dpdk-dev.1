Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C98C5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 06:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93EDC4021F;
	Sun, 16 Aug 2026 08:20:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 29A5E40144
 for <dev@dpdk.org>; Sun, 16 Aug 2026 08:20:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.77.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DA7EFE0883;
 Sun, 16 Aug 2026 10:20:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DA7EFE0883
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786861249;
 bh=0V2MM5L70YwYx9YPcyxCtfJgqUrDD08jta/46DyiLmI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UmEb3fI5tlU7rsJilI8hpgIs5O9QwsNRaFr7UmN7OwBVvCSMCZl16DSoS7yao6mPl
 3pWz4A4MxxB13GsEkvtKCAsTQzAYM8qYdLRwsuMuftSXVlBXJBaUntUN3/FS/sfHjk
 s7FCbEo5JyTs8aWCdZTCqVcymIScwRRJoRJe/scgfGTMDLFft/OGDUxEgxlr6oi1KQ
 2RsHhylr6RXio1Zl+6QWggwApGOwKcLZJJKXAIVE0CfbTUirJyF7CPeHCLKKKCNJSE
 6JqqkMUIIt8r59RLE+32TsE01kXGXl2fVIWqMb+1gzojrtRR9sbk38E+iQmWOBrCJO
 eKm5euDdxEFRg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 0/6] common/sfc_efx/base: add Medford4 VF support
Date: Sun, 16 Aug 2026 10:20:34 +0400
Message-ID: <20260816062040.15562-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

This series enables DPDK to use the sfc driver
on a Medford4 VF alongside the PF.

The first patch wires EVB switch operations into the Medford4
libefx implementation, allowing the PF to manage VFs.

Starting with MCFW 1.4.0.8, VFs may use the netport MCDI for basic port
configuration, though several operations remain restricted. The
remaining four patches address each restriction: dummy fixed
port properties, suppressed event subscription, denied FCS
and flow control, and ENOTSUP for periodic MAC stats DMA.

This series depends on the VADAPTER statistics series.


v4:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343468.html
  -- patch 2/6: fixed VF PERM mask derivation; all speeds
     from the tech table are now used unconditionally,
     rather than the advertised abilities, which are empty
     when the PF operates in fixed-speed mode; output
     params of efx_np_get_fixed_port_props are now
     zeroed on the VF early-return path
  -- patch 3/6: noted the no-op for VFs in the call
     site comment of efx_np_set_event_mask
  -- patch 6/6: added SR-IOV VF limitations subsection
     to the Limitations section of sfc_efx.rst


v3:

- addressed https://mails.dpdk.org/archives/dev/2026-August/343075.html
  -- patch 6/6: dropped erroneous VADAPTER mention from
     the commit message; added SR-IOV VF to sfc_efx.rst


v2:

- note for the future AI reviews: apply this on top of
  the 'common/sfc_efx/base: add VADAPTER statistics for Medford4' series

- addressed https://mails.dpdk.org/archives/dev/2026-August/343075.html
  -- fixed reporting of the factual link speed when running on VFs
  -- remaining notes do not seem to point at factual defects


Ivan Malov (6):
  common/sfc_efx/base: let Medford4 PF manage VFs
  common/sfc_efx/base: indicate dummy netport properties on VF
  common/sfc_efx/base: skip netport event subscriptions on VFs
  common/sfc_efx/base: deny tuning FCS and flow control to VFs
  common/sfc_efx/base: deny periodic MAC stats delivery to VFs
  doc: announce VF support of AMD Solarflare X45xx family NICs

 doc/guides/nics/sfc_efx.rst            |  23 ++++++
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/common/sfc_efx/base/efx_evb.c  |   6 ++
 drivers/common/sfc_efx/base/efx_np.c   | 107 ++++++++++++++++++++++---
 4 files changed, 127 insertions(+), 13 deletions(-)

-- 
2.47.3

