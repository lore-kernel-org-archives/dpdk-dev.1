Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EACA5FBB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 07:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A20D41148;
	Wed, 30 Sep 2026 09:08:15 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0A65640DD6
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:08:14 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D892B1A01B8;
 Wed, 30 Sep 2026 09:08:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B521A00D0;
 Wed, 30 Sep 2026 09:08:13 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BFF9B18000BE;
 Wed, 30 Sep 2026 15:08:12 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 0/6] DPAA2 SEC related changes
Date: Wed, 30 Sep 2026 12:38:03 +0530
Message-Id: <20260930070809.1929564-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260810112951.2879825-1-g.singh@nxp.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
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

V2-changes:
 - Support AES-GMAC as AUTH algorithm instead of as AEAD.

This series include bug fixes, enhancement and AES-GMAC support

Gagandeep Singh (6):
  crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
  crypto/dpaa2_sec: fix FLE pool leak on sec FD build failure
  crypto/dpaa2_sec: increase ivsize range for AES-CTR
  crypto/dpaa2_sec: add missing ECN capability
  crypto/dpaa2_sec: add support for env variables
  crypto/dpaa2_sec: support AES-GMAC

 doc/guides/cryptodevs/dpaa2_sec.rst          | 13 +++-
 doc/guides/cryptodevs/features/dpaa2_sec.ini |  3 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 78 ++++++++++++++++++--
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    | 40 ++++++++--
 4 files changed, 122 insertions(+), 12 deletions(-)

-- 
2.25.1

