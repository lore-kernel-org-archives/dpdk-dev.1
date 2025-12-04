Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A34D1CDB7
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 01:13:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D1B4029D;
	Thu,  4 Dec 2025 02:13:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 291554027D;
 Thu,  4 Dec 2025 02:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764810804; x=1796346804;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t/CI9wS9dbkvhcjbmVsTT8u8rS2sTBxYuFYpjJxfJIs=;
 b=IhBG+ntMnN110uR+rTVNwgith+YBULcd7xnvkz7GKAOP3ItmUiEMUHI4
 wW9dOgU3H5ZdFqM3W7fSAZeenWbBIArlnxcTsjEPdrAJRO0cuxgws4axx
 wa+UK+hxdgcjOlf7Wa7sPP1o+GYMbS5PzMZeGy/BtgBmpWYcGAmrYogKX
 aB2dzQGsPIbNtOwiD3NPRataIkPjIHNVLFOojkqboqMLZ8j2Zo2teoXXM
 whb+WhGBUBP6eAjc19yEEFY5ea59JqnMBtVE7G57Jj3tDYAIyceArs1Ni
 Z/wT+thaFmYUC95Mq7+rOEVGPwfI8LJcxLKCXjfyAUid+a/tx8+wGKglP Q==;
X-CSE-ConnectionGUID: KJRLrL17Sy2Wz+Bjl3CEMg==
X-CSE-MsgGUID: 3dkbPtULTQ+jTI3DelaAVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77446210"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; d="scan'208";a="77446210"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 17:13:22 -0800
X-CSE-ConnectionGUID: RoLVDUD4S0aHHoHqlIB+5A==
X-CSE-MsgGUID: g+jYQWReTiyKX4P7QhCQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; d="scan'208";a="195085850"
Received: from peter-x299-ud4-pro.png.intel.com ([10.158.122.68])
 by fmviesa008.fm.intel.com with ESMTP; 03 Dec 2025 17:13:21 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 David Zage <david.zage@intel.com>,
 Soumyadeep Hore <soumyadeep.hore@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 1/1] net/e1000: force allocation of context descriptor for
 igc launch time
Date: Thu,  4 Dec 2025 09:30:08 +0800
Message-ID: <20251204013009.857273-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.48.1
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

When the timestamp dynamic flag is set in the mbuf offload flags, force
allocation of a new context descriptor. The launch time feature requires a
dedicated context descriptor to specify the desired launch time for packet.

Testing was performed on two Intel ADL-S platforms with i226 NICs
connected back-to-back. A DPDK sample application is created to send two
bursts of packets with 100,000 nanosecond burst interval. Each burst is
having 5 UDP packets and only the first packet in the burst using launch
time feature. Meanwhile, the tcpdump command below is used on the link
partner to capture the delta of Rx hardware timestamp of the 10 packets:

tcpdump -ttt -ni enp1s0 --time-stamp-precision=nano -j adapter_unsynced

Without this patch, packets of second burst are transmitted immediately as
the driver din't create context descriptor for the launch time, as shown
in tcpdump log below:

  00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982

With this patch, packets of second burst are properly held until the
intended 100,000 nanosecond intervals, demonstrating correct launch time
behavior. As shown in tcpdump log below, the delta of first packet
between first and second bursts is 8387 + 8384 + 8384 + 8384 + 66461 =
100,000 nanosecond.

  00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000066461 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
  00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982

Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
Cc: stable@dpdk.org

Signed-off-by: David Zage <david.zage@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/intel/e1000/igc_txrx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index f2a6c34094..35f36d266a 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -1416,6 +1416,10 @@ what_advctx_update(struct igc_tx_queue *txq, uint64_t flags,
 {
 	uint32_t curr = txq->ctx_curr;
 
+	/* Launch time feature always need a new context descriptor */
+	if (flags & igc_tx_timestamp_dynflag)
+		return IGC_CTX_NUM;
+
 	/* If match with the current context */
 	if (likely(txq->ctx_cache[curr].flags == flags &&
 		txq->ctx_cache[curr].tx_offload.data ==
@@ -1621,7 +1625,8 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_last = (uint16_t)(tx_id + tx_pkt->nb_segs - 1);
 
 		ol_flags = tx_pkt->ol_flags;
-		tx_ol_req = ol_flags & IGC_TX_OFFLOAD_MASK;
+		tx_ol_req = ol_flags & (IGC_TX_OFFLOAD_MASK |
+				igc_tx_timestamp_dynflag);
 
 		/* If a Context Descriptor need be built . */
 		if (tx_ol_req) {
-- 
2.48.1

