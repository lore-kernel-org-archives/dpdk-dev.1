Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA45CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 14:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C08340615;
	Fri,  5 Sep 2025 16:45:26 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 128DC40431
 for <dev@dpdk.org>; Fri,  5 Sep 2025 16:45:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.74.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9B67BE00A6;
 Fri,  5 Sep 2025 18:45:22 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9B67BE00A6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1757083523;
 bh=csV1SsRsF9x+XT1+lwp5Vftlz3LzQsgYDtwkvnHJEaE=;
 h=From:To:Cc:Subject:Date:From;
 b=blEdnjcEn+aS6ZGMtlIwmFmXb0UCfnBoWgqgwcgy0/OgTNMFopq/3Uq5ffqpFa5om
 RQtYhbKZbhcu+aI8IJpkW1NJaoc5hMEINFWjo99mUJZ3VZ+yDl8Ijm2WAwRXEAMTR5
 duw8qF5BtC1wXuhLEBVu/yktyBELmdvWQcx4lfvpFdUFOb0wynJOf/JvhDp6kW3FUk
 mN6PwiT8IIWLwepOHs8vLQ/D1+MztE4qBbdnAKDhKb9fqxuSumjwy9t3mrGkBzx/Gy
 LeJPWpI+JsOjep62p21z0GoZV58NnctKZ0wDLAcVl+uzkNtofOx6qbPBK8eDqXZDPN
 TNh/BdtX43asw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 0/4] common/sfc_efx/base: link stability improvements for X4
 NICs
Date: Fri,  5 Sep 2025 18:45:10 +0400
Message-ID: <20250905144514.11698-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.2
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

As announced in [1], this series provides three fixes for link bring-up on
X4 adaptors and an improvement to have link up faster in typical use cases.

[1] https://mails.dpdk.org/archives/dev/2025-August/323545.html

Ivan Malov (4):
  common/sfc_efx/base: fix autoneg detection with netport MCDI
  common/sfc_efx/base: default to auto fcntl with netport MCDI
  common/sfc_efx/base: fix auto FEC selection for netport MCDI
  common/sfc_efx/base: use saved netport FEC choice by default

 drivers/common/sfc_efx/base/efx_impl.h     |  6 +++
 drivers/common/sfc_efx/base/efx_np.c       | 56 +++++++++++++++++-----
 drivers/common/sfc_efx/base/efx_phy.c      |  4 ++
 drivers/common/sfc_efx/base/efx_port.c     |  1 +
 drivers/common/sfc_efx/base/medford4_phy.c |  1 +
 5 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.47.2

