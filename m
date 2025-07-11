Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E9C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB82406B6;
	Fri, 11 Jul 2025 16:43:59 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 93A28406B7
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:43:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9FE14E09F9;
 Fri, 11 Jul 2025 18:43:57 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9FE14E09F9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752245038;
 bh=GmVSWldra4QPGRsD/IDGM8lRo/CtUU7+pUSoANl5y10=;
 h=From:To:Cc:Subject:Date:From;
 b=QdYTLJIG80xIWCNzcXm7W8aq0EcyMFBSV2FK/3p+LJaRYdZLwLuP+XbXF61k0MoPp
 mkRHMTcDT/hRnpKiZUv8+SY0cthBALLmluIOVyrt0AFhI0IPDYwtBBtgekuypV2psH
 vUxnAatuDJqHlVMB2ZegDrdPc+8smfkPaQsBsmvIKCcD4LC/QqMxJytsrn3JVH4vKH
 m7s8Tkp+hTXvjGJ6s6sAxb1LJo+dWAvSomGoxc+szGPCQZFTMBM/SbMsVurkBtCqyw
 S0YZV7VtKAHKZN21Wr+hEaMmfQFf+3jJGxfFQTJqFrJ48cg5aq8kLVR090QOeWiXM9
 GvpB0WOEXXK1g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 0/3] common/sfc_efx/base: fix compiler warnings in X4 netport
 API
Date: Fri, 11 Jul 2025 18:43:46 +0400
Message-Id: <20250711144349.9236-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
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

The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
This series is a follow-up to [1] to fix compiler warnings in the base
driver that are seen in Windows driver build, also based on this driver.

[1] https://patches.dpdk.org/project/dpdk/list/?series=35095

Ivan Malov (3):
  common/sfc_efx/base: fix compiler warnings in statistic code
  common/sfc_efx/base: fix compiler warnings in PHY link setup
  common/sfc_efx/base: fix compiler warning in PHY link getter

 drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
 drivers/common/sfc_efx/base/medford4_phy.c | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.39.5

