Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8654CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 19:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A0340649;
	Tue, 26 Aug 2025 21:43:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DE78D4029E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 21:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756237398; x=1787773398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vkOAiU6TAg+xfyR8CTLmP8mURclKvb7TRP4es7+mGGg=;
 b=DOpz81oZ5B1benyztRHqBi4j+huJn/CeIDZz5SGt+0m0R9hsCnPyfLYl
 ZPXnF7R4buIs97jR7CO/RbL4xmFQauozgB3XJZg96iTUHEY+YiM6FHiOJ
 TU3tghPjzb9/KsmemAtqu7w5h7DiqNTpz7n6O8zIv1STnmwDWsEliG7Iq
 1Q066mXeuGvz0ykQLxuPjBkujSMqhAil96oTGzmdqsF8rOzzn2hfNh8IM
 Ogs6MnQabyh3ZKgDp/DTzimXOYG6pC9GInwWtEVO+SdatRj0f2eYLwmBh
 89OKzJFmu7RV9k4hFekhHxYaWsD7VUzB/PGfx7gIUTR80+T9ZRdHfu6J2 w==;
X-CSE-ConnectionGUID: 1n9R+IJ+SWacPefBLDABvw==
X-CSE-MsgGUID: /TFXwG+GRkqCaJxBGE2ZDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62300035"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62300035"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 12:43:15 -0700
X-CSE-ConnectionGUID: LYDeZsBGRFuhQHex+c2Pxw==
X-CSE-MsgGUID: eeeqrXTkR36ajf8cSP8vvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169592174"
Received: from unknown (HELO spr-npg-bds1-eec2..) ([10.233.181.123])
 by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 12:43:15 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 1/2] doc: clarify CB vs TB level device support
Date: Tue, 26 Aug 2025 12:43:23 -0700
Message-Id: <20250826194324.95284-2-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826194324.95284-1-nicolas.chautru@intel.com>
References: <20250826194324.95284-1-nicolas.chautru@intel.com>
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

Clarify the support for different bbdev devices with regards
to code block vs transport block level processing which was
not explicit enough.

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 doc/guides/bbdevs/acc100.rst        | 1 +
 doc/guides/bbdevs/fpga_5gnr_fec.rst | 1 +
 doc/guides/bbdevs/fpga_lte_fec.rst  | 1 +
 doc/guides/bbdevs/vrb1.rst          | 1 +
 doc/guides/bbdevs/vrb2.rst          | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/doc/guides/bbdevs/acc100.rst b/doc/guides/bbdevs/acc100.rst
index 6843e38c55..1621cc782f 100644
--- a/doc/guides/bbdevs/acc100.rst
+++ b/doc/guides/bbdevs/acc100.rst
@@ -17,6 +17,7 @@ ACC100 5G/4G FEC PMDs support the following features:
 - LDPC Decode in the UL (5GNR)
 - Turbo Encode in the DL (4G)
 - Turbo Decode in the UL (4G)
+- Support for code block level processing
 - 16 VFs per PF (physical device)
 - Maximum of 128 queues per VF
 - PCIe Gen-3 x16 Interface
diff --git a/doc/guides/bbdevs/fpga_5gnr_fec.rst b/doc/guides/bbdevs/fpga_5gnr_fec.rst
index 58d19ffbd2..b181527c45 100644
--- a/doc/guides/bbdevs/fpga_5gnr_fec.rst
+++ b/doc/guides/bbdevs/fpga_5gnr_fec.rst
@@ -16,6 +16,7 @@ FPGA 5GNR FEC PMD supports the following BBDEV capabilities:
 
 - LDPC Encode in the DL
 - LDPC Decode in the UL
+- Support for code block level processing
 - 8 VFs per PF (physical device)
 - Maximum of 32 UL queues per VF
 - Maximum of 32 DL queues per VF
diff --git a/doc/guides/bbdevs/fpga_lte_fec.rst b/doc/guides/bbdevs/fpga_lte_fec.rst
index 7e3748222c..990eeb087b 100644
--- a/doc/guides/bbdevs/fpga_lte_fec.rst
+++ b/doc/guides/bbdevs/fpga_lte_fec.rst
@@ -15,6 +15,7 @@ FPGA LTE FEC PMD supports the following features:
 
 - Turbo Encode in the DL with total throughput of 4.5 Gbits/s
 - Turbo Decode in the UL with total throughput of 1.5 Gbits/s assuming 8 decoder iterations
+- Support for code block level processing
 - 8 VFs per PF (physical device)
 - Maximum of 32 UL queues per VF
 - Maximum of 32 DL queues per VF
diff --git a/doc/guides/bbdevs/vrb1.rst b/doc/guides/bbdevs/vrb1.rst
index 255c4ea040..134dc246e7 100644
--- a/doc/guides/bbdevs/vrb1.rst
+++ b/doc/guides/bbdevs/vrb1.rst
@@ -30,6 +30,7 @@ These hardware blocks provide the following features exposed by the PMD:
 - LDPC Decode in the Uplink (5GNR)
 - Turbo Encode in the Downlink (4G)
 - Turbo Decode in the Uplink (4G)
+- Support for code block level processing
 - FFT processing
 - Single Root I/O Virtualization (SR-IOV) with 16 Virtual Functions (VFs) per Physical Function (PF)
 - Maximum of 256 queues per VF
diff --git a/doc/guides/bbdevs/vrb2.rst b/doc/guides/bbdevs/vrb2.rst
index 45c83e875f..ad67cc36a4 100644
--- a/doc/guides/bbdevs/vrb2.rst
+++ b/doc/guides/bbdevs/vrb2.rst
@@ -29,6 +29,8 @@ These hardware blocks provide the following features exposed by the PMD:
 - LDPC Decode in the Uplink (5GNR)
 - Turbo Encode in the Downlink (4G)
 - Turbo Decode in the Uplink (4G)
+- Support for code block level processing
+- Support for TB level processing for the LDPC Encode processing including CB concatenation.
 - FFT processing
 - MLD-TS processing
 - Single Root I/O Virtualization (SR-IOV) with 16 Virtual Functions (VFs) per Physical Function (PF)
-- 
2.34.1

