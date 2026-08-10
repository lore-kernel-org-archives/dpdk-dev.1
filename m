Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DCC5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3F2740E18;
	Mon, 10 Aug 2026 13:29:55 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BFD6640DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 13:29:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C4BD1A0022;
 Mon, 10 Aug 2026 13:29:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5460E1A001B;
 Mon, 10 Aug 2026 13:29:53 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7786718000B5;
 Mon, 10 Aug 2026 19:29:52 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 0/6] DPAA2 SEC related changes
Date: Mon, 10 Aug 2026 16:59:45 +0530
Message-Id: <20260810112951.2879825-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

This series include bug fixes, enhancement and AES-GMAC support

Gagandeep Singh (6):
  crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
  crypto/dpaa2_sec: fix FLE pool leak on sec FD build failure
  crypto/dpaa2_sec: support AES-GMAC
  crypto/dpaa2_sec: increase ivsize range for AES-CTR
  crypto/dpaa2_sec: add missing ECN capability
  crypto/dpaa2_sec: add support for env variables

 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 50 ++++++++++++++++++---
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   | 45 ++++++++++++++++---
 lib/cryptodev/rte_crypto_sym.h              |  2 +
 3 files changed, 86 insertions(+), 11 deletions(-)

-- 
2.25.1

