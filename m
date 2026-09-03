Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE444C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C64B427DE;
	Thu,  3 Sep 2026 16:38:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 88089427DE;
 Thu,  3 Sep 2026 16:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788446314; x=1819982314;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sD1rkKTTrnKXsrGNRxKPLf7+fp0kXBBn2AdmCkOLq9w=;
 b=ll9f0WtabPJriSNSVQcLHv0+dWchrVHnTe7InHKy+f/8iYGtLHPbyz8w
 Iq4RBfQklx4JRXmDXy+HwdtwHdHvY4UblCCE2IpKUip17FxCL+llIHxuL
 NcZ9zTJEe6foHP1J4au9NHySMKjMQTdXDPVh4dHuIpoPKaLckzHhEP1cF
 OChhpyXcYIpQnfngEXeb5MLbkyzeB6/lhr5vJX0ZjrYKTUCqlPmyqT723
 PleMA/fY5XfLMn3FeHJnQUSEARQAGq1+VvcZGi+Pp5WTUkDtXJxd8LnPB
 zNy36L1/s6izmHICMJz9wIdVmUAVY3oJW8FOBK8jTCWP1u63BPue6yX6K w==;
X-CSE-ConnectionGUID: hJMZ7S2qRwmw2uhVs2mWVQ==
X-CSE-MsgGUID: /PnUrwEPQ0qBWUllY54XcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87869757"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87869757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:38:34 -0700
X-CSE-ConnectionGUID: G1SMwwKkRlif/ptjI8Xllw==
X-CSE-MsgGUID: unFREj8ITM+1sjvG/VYcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273894910"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 07:38:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>
Subject: [PATCH v2 1/7] net/iavf: disable broken QinQ strip on Rx
Date: Thu,  3 Sep 2026 15:37:23 +0100
Message-ID: <20260903143827.327131-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143827.327131-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
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

When 2 VLANs are stripped from a packet, the iavf driver vector path
fails to handle them properly as it 'or's the two values together on the
assumption that only one is valid. Explicitly list the VLAN related
features supported by the vector path, rather than using the
"OFFLOAD_VLAN" group, thereby disabling advertising of QinQ stripping so
that a scalar path is used.

Fixes: 1e728b01120c ("net/iavf: rework Tx path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 6f53d5805a..3ff49b94b4 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -105,7 +105,9 @@
 		IAVF_RX_VECTOR_OFFLOADS |		\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_RX_OFFLOAD_VLAN |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 /* vector offload paths that use the flex rx desc */
 #define IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS (		\
-- 
2.53.0

