Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B23F0182E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 11:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C920840DD2;
	Fri,  6 Mar 2026 12:52:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9740F40278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 12:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772797948; x=1804333948;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+tJOEEpB0vzaQu9nWK4RUz5BC+llIrtUwlIi1haCzX4=;
 b=ZJEGWN4TNSidY2TC0NGng+meEArQ5u+H/qly3F3ffKD9i2e77FBC96r8
 jgBu2f3k0bnGDlcVXA5pug4zVq1semO9sLOcDnrhQv2+z/OyNeUp2wpja
 D4w8o982Zg0REmyz1cxPEm7VgpydBgL+pBIrmKN73lxyvR9Irps6s96uA
 3Qf21iTxqydfu9FBwPYNjwumCxPLB4CTxqyc5SPJWJGPsc/QgKDoIiwOR
 UL0KuYwEtVdEPBEzP9LSyv6XF+APVz6c15Yz0I5/a02K6MzvSZfY79GTC
 gEBzIf/gyxWQTpMOMfpQdXYQCuJA+NXTIFtZIjdxyn6t2veu5qoW0VuUY Q==;
X-CSE-ConnectionGUID: rQNXwhxrRQac+UtsJOvcvA==
X-CSE-MsgGUID: Q6I3pLkwQ/iGEd7r/Cb76w==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="99374633"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="99374633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 03:52:24 -0800
X-CSE-ConnectionGUID: LEXLku9gT4q+XD9FI2OV7Q==
X-CSE-MsgGUID: ++VSmXbiR9y9gejDNANY4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="218982443"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa008.jf.intel.com with ESMTP; 06 Mar 2026 03:52:23 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 3/3] doc: announce change to LLDP packet detection in iavf
 PMD
Date: Fri,  6 Mar 2026 11:52:14 +0000
Message-ID: <20260306115214.467033-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306115214.467033-1-ciara.loftus@intel.com>
References: <20260209152049.1640121-1-ciara.loftus@intel.com>
 <20260306115214.467033-1-ciara.loftus@intel.com>
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

The iavf PMD transmit paths currently use two methods to
identify if an mbuf holds an LLDP packet: a dynamic mbuf
field and the mbuf ptype. A future release will remove the
dynamic mbuf field approach at which point the ptype will be
the only approach used.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index ac667e91a6..e450f9e56d 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -139,3 +139,7 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* net/iavf: The method of detecting an LLDP packet on the transmit path
+  in the iavf PMD will be changed. Instead of using either a dynamic mbuf
+  field or the mbuf ptype, only the mbuf ptype will be used.
-- 
2.43.0

