Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E400DF0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 11:52:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1E2140B9D;
	Fri,  6 Mar 2026 12:52:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 03DA140278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 12:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772797947; x=1804333947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=98o0gKZwG94ol30B6YHYBcRhHEmZ8//grwMX8+EYUAY=;
 b=P+LmruBC19csW2voVcEAADrJ/0m+wLoSerRiPeNmZ02D49D+A8sbKHW2
 RiZXY4HwQ6M+fkLqXpTW2nPwu11yv8vX0WFcjobfJG3v5hAIpPhgVwTWC
 m6PSFWRxd9vywTT+iVhIzQImOvpQSlTlRxHr5oC22WnkBbo13KyUM1jIG
 xlKJicG3v2u/cEx6n5HdD5OU5wig7yfecWiSuGIMtibZn+Rf2Y7oG2JMo
 u51SfIcLwU/KfqjKeoiJ+QH3Y8dLd2OCrZoP6KJQpT83wXo4nJbj1BDwb
 n4/kWVfFn9AHqi6bMRtEp3rLJK5ZYCX1H2TZj0PgTAyR0m2IDM9KN2f8F w==;
X-CSE-ConnectionGUID: of9m+2KkR6uaGxNDUEl3yw==
X-CSE-MsgGUID: Qoqqihw8QUW6+lwEhoySuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="99374631"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="99374631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 03:52:22 -0800
X-CSE-ConnectionGUID: jPsjpoF6QByfpRKmNmeemg==
X-CSE-MsgGUID: acpr2/pJTemyriwgX6CdLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="218982437"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa008.jf.intel.com with ESMTP; 06 Mar 2026 03:52:21 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/3] net/iavf: support LLDP Tx based on mbuf ptype or
 dynfield
Date: Fri,  6 Mar 2026 11:52:12 +0000
Message-ID: <20260306115214.467033-2-ciara.loftus@intel.com>
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

Prior to this commit the only way to flag to the iavf PMD that an mbuf
contained an LLDP packet intended for transmission was to register and
set a dynamic mbuf field. This commit introduces an alternative
approach: rather than setting the dynamic mbuf field, the user may
instead set the packet type of the mbuf to RTE_PTYPE_L2_ETHER_LLDP. If
the LLDP feature is enabled (ie. if the dynamic mbuf field is
registered), on Tx the driver will check both the dynamic mbuf field and
the packet type, and if either indicates that the packet is an LLDP
packet, it will be transmitted.

Using the packet type to identify an LLDP packet instead of the dynamic
mbuf field is preferred because the use of dynamic mbuf fields should be
reserved for features that are not easily implemented using the existing
mbuf infrastructure. Also, it may remove some overhead in the
application if the Rx driver sets the packet type to LLDP as that would
remove the burden from the application to explicitly set any fields
before Tx. It is intended that the dynamic mbuf field approach will be
removed in a future release, at which point only the packet type
approach will be supported. A deprecation notice announcing this
intention will be submitted separately.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Support both dynfield and ptype methods to preserve ABI
---
 doc/guides/nics/intel_vf.rst           | 6 ++++++
 doc/guides/rel_notes/release_26_03.rst | 1 +
 drivers/net/intel/iavf/iavf_rxtx.h     | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index bc600e4b58..ad25389521 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -681,6 +681,12 @@ Usage::
 
     testpmd> set tx lldp on
 
+An alternative method for transmitting LLDP packets is to register the dynamic field as
+above and, rather than setting the dynfield value, set the ``packet_type`` of the mbuf to
+``RTE_PTYPE_L2_ETHER_LLDP``. The driver will check both the dynamic field and the packet
+type, and if either indicates that the packet is an LLDP packet, the driver will transmit
+it.
+
 
 Limitations or Knowing issues
 -----------------------------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 884d2535df..5ad531aef5 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -80,6 +80,7 @@ New Features
 * **Updated Intel iavf driver.**
 
   * Added support for pre and post VF reset callbacks.
+  * Added support for transmitting LLDP packets based on mbuf packet type.
 
 * **Updated Intel ice driver.**
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 80b06518b0..1db1267eec 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -158,9 +158,8 @@
 #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
 #define IAVF_CHECK_TX_LLDP(m) \
 	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
-	(*RTE_MBUF_DYNFIELD((m), \
-			rte_pmd_iavf_tx_lldp_dynfield_offset, \
-			uint8_t *)))
+	((*RTE_MBUF_DYNFIELD((m), rte_pmd_iavf_tx_lldp_dynfield_offset, uint8_t *)) || \
+	((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP))
 
 extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
-- 
2.43.0

