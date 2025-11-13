Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC17CD98E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 21:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BCD40E44;
	Thu, 13 Nov 2025 22:34:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 056CC4064A
 for <dev@dpdk.org>; Thu, 13 Nov 2025 22:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763069659; x=1794605659;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=a/Ipv4tf+Nmc6f0A5CgEE2RZFqeCmF8dEp156ZWSpi8=;
 b=BetdTSjMsa74DCqsP6YHF7tbSgY3WW1UK58m59Cqmf3J/oqFOawPTNY0
 o2OpYpSijMrQJGOe3QSIgGZxxlJOtsa5gQvSE1YsRJ/MugH2Dz8oIOZYL
 nmxeN7AwejlGi1zQH7OjX3CefIXFgPyUUKoFcQtvBRn3VSvxnJ6Vu0Km1
 kWER8Nv/QzVnwLGVrPaZFzjJ52Qkig07+wQ0QfZ7Sx5G4oUYWjH17y/qy
 C7gSqvg6g3IQ97Idgk7AFbH14neinNS24YZyXv1eTdXuuI0V2j6L64OLq
 DGgIMFmQYVSQhhvGhU/YW2QjrUX5z6QmnFB7kOovZOh4yeFrDM5EA5aLf Q==;
X-CSE-ConnectionGUID: +nRiojfIQj2GRhh7eCaOgg==
X-CSE-MsgGUID: OcNHs59FTsqVwMVyIu2Hxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69027492"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="69027492"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
X-CSE-ConnectionGUID: sqz4Uc6IRQSMcVyHkaXvfQ==
X-CSE-MsgGUID: 9WTi2jbTSQCQW6c4tksurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="194051462"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90])
 ([10.166.28.90])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 13 Nov 2025 13:33:45 -0800
Subject: [PATCH 2/2] net/iavf: check Rx timestamp validity bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-2-3d9a0168087b@intel.com>
References: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
In-Reply-To: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
To: dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=4642;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=a/Ipv4tf+Nmc6f0A5CgEE2RZFqeCmF8dEp156ZWSpi8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkwxvxtnTz/q+Kaf8qJezEbD3ueWo9UF/k/rXnjXXGI9Y
 LNueaJsRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNpDWH4n8+wtufVwztTbrkk
 dj+f9TI/P8ZH305fyfzy76j+k8uCXjIyPD35aFZd87xHbxuK7kY4vom6pzb3/dL3a/75v7m39bd
 vOhcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

When reporting an Rx timestamp from the receive descriptor, the iavf
driver does not check the validity bit in the time_stamp_low field. In
the event that hardware does not capture a receive timestamp for any
reason, this valid bit is unset, and the timestamp value in the
descriptor is zeroed out.

The iavf driver ignores this and passes the zero value into the
iavf_tstamp_convert_32b_64b function regardless, and proceeds to treat
the result as a valid timestamp.

Instead of reporting a zero timestamp which users can clearly interpret
as invalid, the raw 0 value from the descriptor is "extended" to the
64-bit timestamp. This results in values which are not immediately
obvious as invalid to users:

  timestamp 1760629088881475583
  timestamp 1760629088881475583
  timestamp 1760629088881475583

First, if the value is printed in base 10 it is not immediately obvious
that the lower 32 bits are zero. Second, multiple packets in sequence
will receive the same "timestamp".

This occurs because of the timestamp extension logic. The receive
descriptor timestamps are 40 bits, with 32 bits of nanosecond precision,
7 bits of subnanosecond precision, and 1 validity bit. The
sub-nanosecond precision bits are discarded. To obtain a 64-bit
timestamp, the upper 32 bits are calculated from the lower 32-bits and a
snapshot of the PHC timer that is captured recently (within ~2 seconds
of the packet timestamp). This enables reporting proper full 64-bit
timestamps without needing to store all 64 bits in the receive
descriptor.

However, when timestamps are not working properly, the raw 'zero' value
is extended regardless of whether hardware indicated it was a valid
timestamp. As a result, users can see what appear at a glance as valid
timestamps. However, they will not match the packet reception time, and
will only update when the upper bits would roll over. This occurs every
2^32 seconds, or approximately once every 4 seconds.

Instead of reporting bogus extended timestamp values which could confuse
user applications, check the validity bit and only report a timestamp of
the valid bit is set. This matches the implementation used in the Linux
PF driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h | 3 +++
 drivers/net/intel/iavf/iavf_rxtx.c | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 5c9339b99f9a..8efb3bd04ee5 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -504,6 +504,9 @@ enum iavf_tx_ctx_desc_tunnel_l4_tunnel_type {
 /* for iavf_32b_rx_flex_desc.pkt_len member */
 #define IAVF_RX_FLX_DESC_PKT_LEN_M	(0x3FFF) /* 14-bits */
 
+/* Valid indicator bit for the time_stamp_low field */
+#define IAVF_RX_FLX_DESC_TS_VALID	(0x1UL)
+
 int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index ea49059f83a1..d8662fd81533 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1582,7 +1582,8 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, rxm, &rxd);
 		pkt_flags = iavf_flex_rxd_error_to_pkt_flags(rx_stat_err0);
 
-		if (iavf_timestamp_dynflag > 0) {
+		if (iavf_timestamp_dynflag > 0 &&
+		    rxd.wb.time_stamp_low & IAVF_RX_FLX_DESC_TS_VALID) {
 			ts_ns = iavf_tstamp_convert_32b_64b(rxq->phc_time,
 				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
 
@@ -1751,7 +1752,8 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxd_to_pkt_fields_ops[rxq->rxdid](rxq, first_seg, &rxd);
 		pkt_flags = iavf_flex_rxd_error_to_pkt_flags(rx_stat_err0);
 
-		if (iavf_timestamp_dynflag > 0) {
+		if (iavf_timestamp_dynflag > 0 &&
+		    rxd.wb.time_stamp_low & IAVF_RX_FLX_DESC_TS_VALID) {
 			ts_ns = iavf_tstamp_convert_32b_64b(rxq->phc_time,
 				rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high));
 
@@ -2036,7 +2038,8 @@ iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
 			stat_err0 = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 			pkt_flags = iavf_flex_rxd_error_to_pkt_flags(stat_err0);
 
-			if (iavf_timestamp_dynflag > 0) {
+			if (iavf_timestamp_dynflag > 0 &&
+			    rxdp[j].wb.time_stamp_low & IAVF_RX_FLX_DESC_TS_VALID) {
 				ts_ns = iavf_tstamp_convert_32b_64b(rxq->phc_time,
 					rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high));
 

-- 
2.51.0.rc1.197.g6d975e95c9d7

