Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D34C5AC67
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 02:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EC32406B8;
	Wed, 12 Aug 2026 04:12:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D2237402EB
 for <dev@dpdk.org>; Wed, 12 Aug 2026 04:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786500731; x=1818036731;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v4d1FjI7LsoRX45ypSEn371UPOZp2a10Wq05Yv6QFSE=;
 b=oKgav8wD3ihSID6u4qCxCWbUrAXHmUpPftuFdiOBnX1fYtQPYCDXByfS
 L+DSBEXxCZIezqMVBAxsJa2cpEX1Q0A2NyPH/tL5zb2tYb/AYN6MDpX7m
 cyoQ/4knr+D7BuPjTotT/hgrO8CPIDD/ZrpMsD8ZNQxOzyA2ApZU6++xX
 PQQpLak1yi5Ej70ZPVjXK/Q8oSFvANZEua6VjBH6buFY8ImBlI11X+Vjm
 5nDj2c/lXSWlkQVF8B0NkMjoZGN+2TL7xeB+BXN/UQFPgW6LkKvSmYN4g
 zKxxaSqX2AcPIWTOlg3LdwUU+6DV8DymaJm9saTvmaKrb7BiUS2eFWEBZ g==;
X-CSE-ConnectionGUID: Tl8EFhRzRKyPitSaibMEhQ==
X-CSE-MsgGUID: tI+SBOaDSIyfiE3T2dR9fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97707870"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="97707870"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 19:12:09 -0700
X-CSE-ConnectionGUID: 7f+ew8s+Tv2Ouqoljyx6HA==
X-CSE-MsgGUID: ReUHPPteQe6B0UFM3X6dbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="293437014"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 19:12:10 -0700
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1] nics: add E2200 to the NIC guide
Date: Wed, 12 Aug 2026 10:09:07 +0800
Message-Id: <20260812020907.148153-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
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

nics/cpfl: add E2200 to cpfi
nics/idpf: add E2200 to idpf

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/cpfl.rst | 1 +
 doc/guides/nics/idpf.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 3e2788ba03..5964a980ee 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -8,6 +8,7 @@ CPFL Poll Mode Driver
 
 The cpfl PMD (**librte_net_cpfl**) provides poll mode driver support for
 Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
+Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2200.
 Please refer to
 https://www.intel.com/content/www/us/en/products/network-io/infrastructure-processing-units/asic/e2000-asic.html
 for more information.
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index f4cd69ba7d..1f06eed645 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -8,7 +8,7 @@ IDPF Poll Mode Driver
 
 The idpf PMD (**librte_net_idpf**) provides poll mode driver support for
 Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
-
+Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2200.
 
 Linux Prerequisites
 -------------------
-- 
2.34.1

