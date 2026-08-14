Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745AC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6552540687;
	Fri, 14 Aug 2026 14:56:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C6E75402AC
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 193F7E0AD0;
 Fri, 14 Aug 2026 16:56:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 193F7E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712186;
 bh=MoN1nkomH8820ZMyDYkTwJOhGOKdQBaNzfmu4sVlbO8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u1pDQaelrdRsah+DutQMclGaJf5NoHmXVB2rn7nqi6GSa84emfden6VS2zm2PVRdl
 A0sLW8ylAfGUBHcUpnpwMXDgwI88WTb5xOQZu84AJ5JpO0iSG0cZSvFS620w8JqLo4
 FkDf1tgZ87QMzDpRn9XUPQCcRMYZMaps6bhc60cPFMw+nUdaDg7kfnvHhqi5YaTkUq
 1F4WEQ9m+oIXQ5TaFlOR48oip4E36mjopo+bWDodtuLiEEk+pAWUILBWc9GVfs8ypi
 GIOrlHuF4huRStsvRJZ/QWyGZGD2eAx7v/lxDsvRXV27TYyrnct065+fmDdAk84fTE
 y1xxX6Bg4PMDQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 0/6] common/sfc_efx/base: add Medford4 VF support
Date: Fri, 14 Aug 2026 16:56:18 +0400
Message-ID: <20260814125624.13372-1-ivan.malov@arknetworks.am>
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

 doc/guides/nics/sfc_efx.rst            |  2 +
 doc/guides/rel_notes/release_26_11.rst |  4 ++
 drivers/common/sfc_efx/base/efx_evb.c  |  6 ++
 drivers/common/sfc_efx/base/efx_np.c   | 90 ++++++++++++++++++++++----
 4 files changed, 90 insertions(+), 12 deletions(-)

-- 
2.47.3

