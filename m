Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C4606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hfJCVjsv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D418410D4;
	Tue, 10 Nov 2026 22:02:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 6C48B40EE5
 for <dev@dpdk.org>; Tue, 10 Nov 2026 22:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794344524; x=1825880524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lHAM1LcC58jRNhtZYNnAQ6aRZGH8IrowG53x6sNuLrM=;
 b=hfJCVjsviurXGjhOQLxEpLt5++aqDa6afgEo24FxCXKVQKRFsT7ehXW9
 /ppA8KhrcpS3Ro2eFfN+5bCn/gUWKaMQoefOqgGLJCiRH1B+4J0u+YMa5
 nZ0pBMLraRaHP8qxcmy8cHA6KCg1NrST7I9QzZDn6POVbvIdZkrbwlZEX
 tgZ2hy+NqGIk7JOVdHnNNxszZXBSRNgQ6q3F0xUDfY3DJevSyL5b0AEL7
 lKW2E8URRIG8FlrCPvOtt70T6QMqBPKEkwdt5xHHq6387Skg+UAGrDS7r
 EqCpWusEFWVdIxCZKtQ86w+2EH/xJgEr4ZsJy7VSPUk+l0FHC05w+HeJo g==;
X-CSE-ConnectionGUID: gprBhvduSWCMc+nT2AqnSg==
X-CSE-MsgGUID: 6siEkaNwRGimALRHFTNd2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3141137"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3141137"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 13:01:50 -0800
X-CSE-ConnectionGUID: qfyOatfGRuuVcxuErCuXXQ==
X-CSE-MsgGUID: nHVGhdnqQFuIUdyHADBEKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8405996"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 13:01:50 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/3] usertools/dpdk-devbind: align BSD output format with
 Linux
Date: Tue, 10 Nov 2026 21:01:40 +0000
Message-ID: <20261110210142.1734222-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110210142.1734222-1-bruce.richardson@intel.com>
References: <20261104151524.3990486-1-bruce.richardson@intel.com>
 <20261110210142.1734222-1-bruce.richardson@intel.com>
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
index e70bdc23b4..1625fae9e9 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -287,8 +287,9 @@ def init_devices_cache_bsd():
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

