Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010A8C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FEEB427C8;
	Tue, 11 Aug 2026 19:50:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6C6D5427A1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:50:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B514AE054D;
 Tue, 11 Aug 2026 21:50:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B514AE054D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470627;
 bh=QQTeXr79eEev/lQKpYt+yZjbCERDuTNMh0l+5GyxSy8=;
 h=From:To:Cc:Subject:Date:From;
 b=lSjb32gz1JWk3AgwSLr7cdDspLSLdNERlBJUG0X4T1tZ+7KvWbNg8dKwejD3Xp8hQ
 eBZywTDzZ7LuTJWcLmI0eABMrjMi5UBRY/OpySARy6DU8OERptZHtNcZWeD38tdLtu
 7TlN8uBy6DvQM/IQhpCorHC1a7id6uUKEItfH6IFjDxVqyWhSFu9ZjNg5OXVcz6W+H
 R8jMPep7Sd+tOYkq7XiggxoVVD7VFfU/ywFJgeA56UpASXdmhzlKiM0deB0tpuQq6L
 iJkd+iA1+XVWoIw87HN6t5CzRQRczTyRcLYDViKh9rtm2sLREeO2wSNe7v8TfdkpSG
 RsKdhc7vnKCgQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 0/6] common/sfc_efx/base: add Medford4 VF support
Date: Tue, 11 Aug 2026 21:50:19 +0400
Message-ID: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

Ivan Malov (6):
  common/sfc_efx/base: let Medford4 PF manage VFs
  common/sfc_efx/base: indicate dummy netport properties on VF
  common/sfc_efx/base: skip netport event subscriptions on VFs
  common/sfc_efx/base: deny tuning FCS and flow control to VFs
  common/sfc_efx/base: deny periodic MAC stats delivery to VFs
  doc: announce VF support of AMD Solarflare X45xx family NICs

 doc/guides/rel_notes/release_26_11.rst |  4 ++
 drivers/common/sfc_efx/base/efx_evb.c  |  6 ++
 drivers/common/sfc_efx/base/efx_np.c   | 91 ++++++++++++++++++++++----
 3 files changed, 89 insertions(+), 12 deletions(-)

-- 
2.47.3

