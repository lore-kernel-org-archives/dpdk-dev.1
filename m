Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E377C87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 04:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D41C402DC;
	Sat,  2 Aug 2025 06:30:22 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8DF234028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 06:30:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A4A8CE0036;
 Sat,  2 Aug 2025 08:30:18 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A4A8CE0036
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754109019;
 bh=3+5+FJTvgfLwpuT+0rB8AhltUNGU8pZJwsjBUgb9R+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pwkt7c/mFX4ZIFtOiqipSMxFzRAiWnEkZ5toV7AcFNnozjSY6cSIBtgOtFv69ESKV
 fsdLFKiE3uPlrXSxf2tzTwX5Sajo2jylhwaFyIV94TP//xeyPGqd+U3ilznkRLUYRw
 BNRTdZi9nrOjNiDXDYFD4YK9veMKo3F0J24aNLM35Z3it5R4A3Zqvfv9vOQMyRRhtD
 JKMN4kNdCg464V9WdoszqXOfXW3q1ElAhVrVigXe5jIXC0h7H+meOI3FLT7BF9lf8e
 1aAT2RhxhZ8hD5vkI++fezv5e1hevL5j4vCRLYrNKqOU8ya92Sx5BFJsFFcYT92mTT
 ULhgM9qo65iEw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 0/2] common/sfc_efx/base: fix compiler warnings in X4
 netport API
Date: Sat,  2 Aug 2025 08:30:08 +0400
Message-Id: <20250802043010.39134-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
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

v2:
- re-group the changes the way Andrew suggested
- include Cc to 'stable', to have this in 25.07

Ivan Malov (2):
  common/sfc_efx/base: resolve warnings about unused variables
  common/sfc_efx/base: clean up type-related compiler warnings

 drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
 drivers/common/sfc_efx/base/medford4_phy.c | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.39.5

