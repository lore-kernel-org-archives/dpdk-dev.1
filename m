Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489ECC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 02:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A20A40150;
	Fri, 18 Jul 2025 04:38:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B42434014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 04:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752806329; x=1784342329;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=abNHJm/Ado22YA9wSRZ0SVlkEF2qK5PYPp/e2wkOehk=;
 b=IoEfjwQg+tO4trLwaQ+P6NVJugQqBeYgcS9sk4v7UplwSX1Mfr2yYnJG
 1OOd2kzqiZ6ZmDZJmw8WhXjTThyb67tcwkZMJay5bbITGtcssczwc9AJx
 ie/Ytbpbp61A71t04JVr5oEvLE6hXnUFmmO4nqlYWxMPxJRrf0taKHC0L
 4ZMhjc66kJDzg/Jg5zxJD3cwNUzJ+uzhTuxiMjki6uCxYy1x5yDX9uV1d
 uPpb1xW6oSm55SwihliT0WsbTGHTGhiZ/TLceCBv5UQnlKRe97J5uQCCi
 iOzMEu16D/IWVVZ334cUHl8kNx4baoqk1Fu98SEAzbxIDP9Rop3gN0Bz1 g==;
X-CSE-ConnectionGUID: edBpmNvMQr2yCHBKf3f6Xw==
X-CSE-MsgGUID: +jNMXNr2Q6eZ0HGZy3+j7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55060391"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="55060391"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 19:38:48 -0700
X-CSE-ConnectionGUID: 2Ii0kPt8SCyIizAMUS7aYg==
X-CSE-MsgGUID: UxolamHQR/Wiggas8Fc6nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="181660797"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 19:38:46 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	hailinx <hailinx.xu@intel.com>
Subject: [PATCH v2] net/ice: updated latest recommended matching list
Date: Fri, 18 Jul 2025 10:00:08 +0800
Message-Id: <20250718020008.3364498-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Signed-off-by: hailinx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index c6531d5684..7f9da1afda 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -5,8 +5,14 @@ ICE Poll Mode Driver
 ======================
 
 The ice PMD (**librte_net_ice**) provides poll mode driver support for
-10/25/50/100 Gbps Intel® Ethernet 800 Series Network Adapters based on
-the Intel Ethernet Controller E810 and Intel Ethernet Connection E822/E823.
+10/25/50/100/200 Gbps Intel® Ethernet 800 Series Network Adapters based on
+the following controllers,
+
+- Intel Ethernet Controller E810
+- Intel Ethernet Connection E822
+- Intel Ethernet Connection E823
+- Intel Ethernet Connection E825
+- Intel Ethernet Controller E830
 
 Linux Prerequisites
 -------------------
@@ -52,6 +58,8 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
 and Linux distributions that were tested and verified
 are listed in the Tested Platforms section of the Release Notes for each release.
 
+For E810,
+
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP | Firmware  |
    +===========+===============+=================+===========+==============+===========+
@@ -85,6 +93,17 @@ are listed in the Tested Platforms section of the Release Notes for each release
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    4.8    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
+
+For E830,
+
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP | Firmware  |
+   +===========+===============+=================+===========+==============+===========+
+   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    1.0    |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.25.1

