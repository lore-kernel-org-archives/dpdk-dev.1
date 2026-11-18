Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0339606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lvdSBkI1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2EEF4029D;
	Wed, 18 Nov 2026 17:08:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 11B2E40298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 17:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795018084; x=1826554084;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XLVgVQPTSfQx3vq2C7dlHHJb5IYOUVnS6jULvgeNzz4=;
 b=lvdSBkI1KQbol20OePwHir/59R8SaiteXyd6+mszWEY4nJLOT5fNG58Z
 WxhL5D5KZCytRMEzeRsdafRSVut+9ixCT0E0njnzl24MpnXPHHCcjTqxQ
 g86JUIXV7QGiBJgox3Oqk20eiG7vG/Ct86yla+02NvjVRRUS+nAYBCoiL
 mHyiajvxCeaeIxQBn4NCPVcVleZnnGJb/5QqYR27rr9n3iutLTvn0a1/4
 WTyfBoOniUibGV1gL7CErQbemXiqczgd8GROr4OGjg9Qks4TZzYKsbLm9
 rbq3aW7hCOIrs1Tk2Jira1xZOHqKYi4fL3LrANUA0QGYxdlzGuf+8sZbG Q==;
X-CSE-ConnectionGUID: 5Phf3XUHRwGz7MrBY4l6Mw==
X-CSE-MsgGUID: Irjy8LAUQpask51fvrGIUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3933988"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3933988"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 08:07:28 -0800
X-CSE-ConnectionGUID: inEyvwXKSBKIJqsmjObetg==
X-CSE-MsgGUID: CD6875qNREGbHE9lPJQAbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10413610"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 08:07:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: soumyadeep.hore@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] net/ice: disable Rx timestamp offload on vector paths
Date: Wed, 18 Nov 2026 16:07:20 +0000
Message-ID: <20261118160720.2763248-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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

Enabling IEEE1588 timesync on a running ice port requires the Rx
timestamp offload to be configured. Previously, having that offload
always made the driver use the scalar Rx path, which is the only path
that sets the PTP mbuf flags. Since Rx timestamp support was added to
the AVX2 and AVX-512 Rx paths, a vector path can now be selected with
the offload enabled. Timesync then gets enabled after port start, and
PTP packets are received without the IEEE1588 PTP and timestamp flags
set.

Remove the timestamp offload from the vector Rx path masks so that
requesting it selects a scalar Rx path again. Flag can be re-added once
PTP support has also been added in the vector paths.

Fixes: 332eb4ec8ff0 ("net/ice: support Rx timestamp offload on vector path")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/ice.ini       | 2 +-
 doc/guides/rel_notes/release_26_11.rst | 2 --
 drivers/net/intel/ice/ice_rxtx.c       | 8 ++++----
 drivers/net/intel/ice/ice_rxtx.h       | 4 ----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index ebc516303b..68c7f48ff0 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -37,7 +37,7 @@ VLAN offload         = Y
 QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Timestamp offload    = Y
+Timestamp offload    = P
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d3ab3662dd..270ff9af4f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -187,8 +187,6 @@ New Features
   * Added support for Tx rate limiting per queue.
   * Made the existing diagnostic dump functions available
     through the public ``rte_pmd_ice.h`` header.
-  * Added support for the Rx hardware timestamp offload
-    (``RTE_ETH_RX_OFFLOAD_TIMESTAMP``) in the AVX2 and AVX512 vector Rx paths.
 
 * **Updated Intel ixgbe driver.**
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 6f19e070ee..4016e5f8d4 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3317,7 +3317,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_pkts_vec_avx2_offload,
 		.info = "Offload Vector AVX2",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.bulk_alloc = true
 		}
@@ -3326,7 +3326,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_scattered_pkts_vec_avx2_offload,
 		.info = "Offload Vector AVX2 Scattered",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.scattered = true,
 			.bulk_alloc = true
@@ -3356,7 +3356,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_pkts_vec_avx512_offload,
 		.info = "Offload Vector AVX512",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
 			.bulk_alloc = true
 		}
@@ -3365,7 +3365,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_scattered_pkts_vec_avx512_offload,
 		.info = "Offload Vector AVX512 Scattered",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
 			.scattered = true,
 			.bulk_alloc = true
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 3332053d3d..abbcee9fe0 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -109,10 +109,6 @@
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
-/* vector offload paths that also support Rx timestamp (AVX2/AVX512 only) */
-#define ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS (	\
-		ICE_RX_VECTOR_OFFLOAD_OFFLOADS |\
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
 
 /* basic scalar path */
 #define ICE_TX_SCALAR_OFFLOADS (		\
-- 
2.55.0

