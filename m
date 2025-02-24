Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E16C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:26:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5C0E4275C;
	Mon, 24 Feb 2025 16:26:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3808841144
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740410786; x=1771946786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nO3NqdODU9hREssX6S5ItYaXIIxzDQGFaen4EwAbGf0=;
 b=i9F8plMUg1V+15rW9osH/o44nlKkl4HI+sq9tTlYmOfekDY52vOFpi0/
 4x2noN/V6cqLzzI4TqDYpTfZlzvqNCRA99nTMVN6yzFQj/H5X91d+9KhR
 e57OpadDrQPFejEQD9/wDsOaB2iuSrqN98NF6dZ9RIE4MDlVxrKxVL5LJ
 +yajT0USIe9+WJ1amO+jA5EgAIXeJDrLMFR1zNxwvAYG0jTb5zoxw4+Ny
 uJKAG/YPvx0EvhYQwyyKQmwpyOy7VTf+EcbODSZHjmQr6qyF2EE2WsMBT
 8cvsWok+jSbnNliHIzzvq6UCGR3zfuoWmOKhzSfmLhrotKr/ZOx2ay376 Q==;
X-CSE-ConnectionGUID: rhJGGw1AQUKUfqpbyGfNOg==
X-CSE-MsgGUID: +JXBi3zGQXWMRJOBYh+ZzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44823611"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44823611"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:26:24 -0800
X-CSE-ConnectionGUID: wap7WOcXQkG7LfGOoNN2gw==
X-CSE-MsgGUID: DmgLVwjIQE+Xj04g3Fb4Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116107652"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2025 07:26:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] doc/nics: document how to create large VFs for iavf
Date: Mon, 24 Feb 2025 15:26:07 +0000
Message-ID: <20250224152611.1012935-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152611.1012935-1-bruce.richardson@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
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

Document the additional step necessary to create large VFs for iavf when
using ice kernel driver v1.13.7 or later.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/intel_vf.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 708cb85417..eb939df41a 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -138,6 +138,11 @@ Intel\ |reg| E800 Series Ethernet devices:
   for example: ``-a 18:00.0,quanta_size=2048``.
   The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
 
+* When using the Intel out-of-tree "ice" PF/kernel driver v1.13.7 or later,
+  to create VFs with >16 queues (aka. "large VFs"),
+  it is necessary to change the rss_lut_vf_addr setting in sysfs from the default of 64 to 512.
+  This can be done using the following command for the first VF on an interface:
+  ``echo 512 > /sys/class/net/<PF interface>/device/virtfn0/rss_lut_vf_attr``
 
 The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0

