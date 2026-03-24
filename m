Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4593E9A77F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B098E402BE;
	Tue, 24 Mar 2026 13:45:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3DA894025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774356299; x=1805892299;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zkTJSOvfB7B01lvE2ku5/XqyAiZnxMqgucGTKwAMWsc=;
 b=lEwbopBt1dP3d6+RnXpjtSlZ2Q0YAmQKRJ9Mq9XIknm4vm3FyNbGjaJ9
 L8NfWuc066wOGGue1Q/lpVswJqlCGgQI0T66/vvW5piHH7RRKKkpEIv9J
 ZFu122GkFk0YGz6Xeq7HRGzpsbhA3SquZaXiix23YQL4/yUKK12C6DKy+
 DYzWJnmKh4P3uj0vW+yYx6xBbwu+YOtXrRXe0EqgBFMtG3EgROamnmKQe
 MHBWPnl2/ccNmTAuepxmuoy56G9Zbqi5UswpEUTP1HKMrj1C8owQn5+DC
 jfJ+8VZUCkdIWfw0MHzqToQcYd1O17RY7hVjgHZ+ZSJC4gemH6CIHnoVf Q==;
X-CSE-ConnectionGUID: Hdw6KlSxR0WlI+msg69nMQ==
X-CSE-MsgGUID: uHuCWT63R6GDdWeBo+FB/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86067497"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="86067497"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 05:44:58 -0700
X-CSE-ConnectionGUID: 4OtbPO3pQKGKqHU2DG7djQ==
X-CSE-MsgGUID: o+S76vwuSfm1tqYoqhPtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219451016"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by fmviesa006.fm.intel.com with ESMTP; 24 Mar 2026 05:44:56 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, stephen@networkplumber.org,
 aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH v5] doc: improve e1000 driver documentation
Date: Tue, 24 Mar 2026 23:03:37 +0000
Message-ID: <20260324230343.1050223-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add an overview of the e1000 driver for Intel 1G devices.

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---

v5:
* Aligned PMD names with code.
* Fixed wording for clarity.

v4:
* Fixed RST structure, single top-level title.
* Used ASCII "PCIe".
* Adjusted commit message to match content.

v3: Resolved apply patch failure.

v2: Addressed review comments.
---
 doc/guides/nics/e1000em.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index ed4f57e9c6..a101b54020 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -4,7 +4,20 @@
 Driver for VM Emulated Devices
 ==============================
 
-The DPDK EM poll mode driver supports the following emulated devices:
+E1000 Poll Mode Driver
+----------------------
+
+DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
+These include:
+
+*   e1000_em – Intel 8254x family devices, including QEMU ``e1000`` emulation.
+*   e1000_igb – Intel PRO/1000 PCIe family.
+
+.. note::
+
+    The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.
+
+The e1000_em poll mode driver supports the following emulated devices:
 
 *   qemu-kvm emulated Intel® 82540EM Gigabit Ethernet Controller (qemu e1000 device)
 
-- 
2.43.0

