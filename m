Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7CC61CE8
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Jun 2025 05:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D081A40EAB;
	Sat,  7 Jun 2025 07:29:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 83B044028B
 for <dev@dpdk.org>; Sat,  7 Jun 2025 07:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749274182; x=1780810182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=56I87qJ2bxg+fjCYVXA+IETtdC0dlOyYsL/UKX6A6MY=;
 b=JBpY5F/UF8bA3CW5vlc6xfZNlZ/CkuOKm0z4PdKz+/U/+SfGyMugT3yi
 ILjrx8YHgcUtwDen1Vzid2KxRl+qiFqWwHD7wvOboAyp2iIbpWQVxn5aD
 tgdG1zV30OHmTwS6EJgyLJZ1Qc2Ig0cSQ/so4WMuXIzGpw8vMIcNQVO/k
 dozg2qFhQGftwCp20iGYfEFGiYdmvY5wm6qGKmCGZdVofxlf7ErMXqr0V
 JyB/Wfijn80X7lCFm+5IoYY5KglLY2VXkYEsGAWxecpM/teOWQ40NH3e3
 3I6ssxRjoVvdtR3Wf8O3eUYbIrQGNnXkxI6LNctXJ1NbYtHAYt7KNNDlJ g==;
X-CSE-ConnectionGUID: G5QWx9oWTGaqg14j8CF38g==
X-CSE-MsgGUID: dco1lmheQhaB0vVfzJoHoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="55087288"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="55087288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 22:29:42 -0700
X-CSE-ConnectionGUID: z2acHRqbTr25iJf2Hlnvqw==
X-CSE-MsgGUID: cBuwwVN2SeineQ6RT3oZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; d="scan'208";a="146953497"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2025 22:29:39 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 6/6] doc: announce TxPP support for E830 adapters
Date: Fri,  6 Jun 2025 21:19:47 +0000
Message-ID: <20250606211947.473544-7-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606211947.473544-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-1-soumyadeep.hore@intel.com>
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

E830 adapters currently support Tx Time based queues.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/ice.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..73c5477946 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -415,6 +415,22 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
 
    examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
 
+Tx Packet Pacing
+~~~~~~~~~~~~~~~~
+
+In order to deliver the timestamp with every packet, a special type of Tx Host Queue is
+used, the TS Queue. This feature is currently supported only in E830 adapters.
+
+The tx_offload ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
+For example:
+
+.. code-block:: console
+
+   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=0x200000
+   set fwd txonly
+   set txtimes 30000000,1000000
+   start
+
 Generic Flow Support
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

