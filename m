Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B0606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LGvEiCnZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B7040A79;
	Wed,  4 Nov 2026 16:15:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E84840A79
 for <dev@dpdk.org>; Wed,  4 Nov 2026 16:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793805338; x=1825341338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AFESn3OWUFV6W94xhGIXikpPP0iX8x10p1auK4yN3UI=;
 b=LGvEiCnZYvppJ5M61O9OdKrh2p8KM+oMOBi/ZjFvOuNscxhxRi+CnKIf
 lA9eSgRRuMH2BFCd8AGOc0bbjMAYDAXMJJDazmjVKKn1+Yf7DPwdMhdDr
 unthJnINjbL2eGT7yYBJXv5mIjw0/x7W6mQKFzGGsma6QEvJhfFA2X5t6
 jI2MY9SdjDC+sLL3aGRpb8GZWq0u+vKSN4WOqfic+Jfz5WIkOUkUYqRRI
 k4V5I3vLEInT6duF2Gdn3haQKtXY406Aj89TUcrXLCERZwNJa8DUQZ7v0
 mJFvaWivhOAzV5Xu5KtfAzkbm6ZateYwJQw+X0WdDl52i41gldoCMKnBb Q==;
X-CSE-ConnectionGUID: /ezGnp7NSOysUEyItnt4UQ==
X-CSE-MsgGUID: HpfiDJWSSRqXDQw+LnYsBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2437327"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2437327"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:15:34 -0800
X-CSE-ConnectionGUID: NYc5ddw5SlKEFZTuutSYZw==
X-CSE-MsgGUID: 0fMkKFNKSzKwTtKcok0Ujw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7093767"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2026 07:15:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] usertools/dpdk-devbind: align BSD output format with Linux
Date: Wed,  4 Nov 2026 15:15:22 +0000
Message-ID: <20261104151524.3990486-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151524.3990486-1-bruce.richardson@intel.com>
References: <20261104151524.3990486-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change the PCI address output format used by dpdk-devbind.py to match
that used on linux, where we have the bus values in hex rather than in
decimal, "pci0" is replaced with "0000", and the final separator is a
"." rather than a ":". As well as having consistent output across
platforms, this also aligns the output format with the BDF format
accepted by EAL -a/-b flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/tools/devbind.rst | 4 ++++
 usertools/dpdk-devbind.py    | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/guides/tools/devbind.rst b/doc/guides/tools/devbind.rst
index 90b289de1e..f36e8c4de7 100644
--- a/doc/guides/tools/devbind.rst
+++ b/doc/guides/tools/devbind.rst
@@ -8,6 +8,10 @@ The ``dpdk-devbind`` tool is a Data Plane Development Kit (DPDK) utility
 that helps binding and unbinding devices from specific drivers.
 As well as checking their status in that regard.
 
+PCI addresses use the hexadecimal ``dddd:bb:dd.f`` format on both Linux and FreeBSD.
+For example, FreeBSD's ``pci0:152:0:1`` is displayed as ``0000:98:00.1``,
+and this address can be used directly in EAL device arguments.
+
 
 Running the Application
 -----------------------
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 00d7188618..c62b3ad6d8 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -286,8 +286,9 @@ def init_devices_cache_bsd():
             # Parse slot/address from first part
             name_addr, fields = line.split(maxsplit=1)
             devname, addr = name_addr.split('@')
-            # Remove trailing colon from address
-            addr = addr.rstrip(':')
+            # Convert the decimal pciconf address to hexadecimal DPDK format.
+            domain, bus, slot, function = map(int, addr[3:].rstrip(':').split(':'))
+            addr = f"{domain:04x}:{bus:02x}:{slot:02x}.{function:x}"
 
             current_dev = {}
             current_dev["Slot"] = addr
-- 
2.55.0

