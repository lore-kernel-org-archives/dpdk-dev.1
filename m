Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA8CD6E74
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 14:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5031940A4B;
	Thu, 13 Nov 2025 15:50:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1782540151;
 Thu, 13 Nov 2025 15:50:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763045428; x=1794581428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GS0byIU0VsekSfN3wMTOryRl9qT/RGx0Bb0tEaHj0mM=;
 b=Rs5Tmwra/Cg3bGdZo3EbjDKBAZwm40JI3v9oBSJNZNENXiRqVRYqnfYj
 OBnO4ua+aAUSVhuC0ZDbhGUMZk5ReIurZx/RxnEeIN3XPKLMt5DnF99A4
 3BO8xQdLivp/qFp+L+wINWeNH949DtWyYSPoxaOk4sKjKaFs4XsueL+Ut
 pjzzjwPCx2d/6QcdZc/CRcbjo3Ap0fMAAYlXa1AU9d2/nNA4HiqSAxJ22
 RnGmUnR90PqSij3zCrgdxJ59uJzuGdxoIb/WOibjRxfxViFHxQnxyLVje
 iEzqUsH9KX6GzURrSa/JXRCe1o0vEgNOxSdpP8/HxQMCUgL9ZOFti2He1 Q==;
X-CSE-ConnectionGUID: 1V/ISvqaQkS5OoL5jUB/8A==
X-CSE-MsgGUID: UEDqs/UzTm6bPc/OZYs9KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65033514"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="65033514"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 06:50:26 -0800
X-CSE-ConnectionGUID: CRlNO+btTDiX2eA1GPE5JA==
X-CSE-MsgGUID: H2xD/TvlQWe34zE9bkALLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="193958329"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 13 Nov 2025 06:50:27 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/idpf: fix missing offload from conversion function
Date: Thu, 13 Nov 2025 14:50:21 +0000
Message-Id: <20251113145021.3793930-1-ciara.loftus@intel.com>
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

The TCP_TSO tx offload was missing from the conversion function. This
was effectively taking the request for that offload out of consideration
when selecting the tx function. As a result a vector path which does not
support TSO could be chosen when that offload was requested, when
instead the scalar path should be chosen which does support that
offload. Fix this by adding the TSO offload to the conversion function.

Fixes: c008a5e740bd ("common/idpf: add queue setup/release")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 1c725065df..4796d8b862 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -42,6 +42,8 @@ idpf_tx_offload_convert(uint64_t offload)
 		ol |= IDPF_TX_OFFLOAD_TCP_CKSUM;
 	if ((offload & RTE_ETH_TX_OFFLOAD_SCTP_CKSUM) != 0)
 		ol |= IDPF_TX_OFFLOAD_SCTP_CKSUM;
+	if ((offload & RTE_ETH_TX_OFFLOAD_TCP_TSO) != 0)
+		ol |= IDPF_TX_OFFLOAD_TCP_TSO;
 	if ((offload & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) != 0)
 		ol |= IDPF_TX_OFFLOAD_MULTI_SEGS;
 	if ((offload & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) != 0)
-- 
2.34.1

