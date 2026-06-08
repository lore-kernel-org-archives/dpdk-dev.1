Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D1ACD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7F9A40696;
	Mon,  8 Jun 2026 18:14:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DEC4440695
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935258; x=1812471258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bjpAr1+i3/7V1meBvmI5E3f1EEKDSUWpyY+qQaaEqfo=;
 b=QEb4JrSEKe0BcIOYtaiB71YbRxsd2eeyQ6+9Yg+Ja7bUcUtWHzTocw5Q
 ZcyeFBkTetXtboSyH795QJPCls+Edw/PIsebthfe1FNa9GI/savxpMBdA
 m1uToXWgL7WCK3aOckiqkX/qkB6mLVM75mxJ16XLIIcj0tTrXQHAdiH+g
 /9HJWzJkac6L5MIr9eojC1TIpwNXzDnIYTLDqfB0SGFLLyifSbk3lOP4f
 zALOCbYel1l9JMhKt72BqepsT+cQ3n12vZCkLZFvE5hvz4Z5Y4l10aO02
 roLzcrIcAB/SD5yIgtNGSi+W42iygJiGQ3VMQwXlIMDaZz7+ebdhZgVVL A==;
X-CSE-ConnectionGUID: TuHVSstzSqiwjUMb+6Fm4w==
X-CSE-MsgGUID: +Yi4vkLbRZucgBQ1A8eYBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809564"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809564"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:18 -0700
X-CSE-ConnectionGUID: ptNYfW/bTMijw4ldM0opwA==
X-CSE-MsgGUID: fbPRYnpzRN+/KhdlqKPF5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457448"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:16 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 4/7] net/ice: timestamp all received packets when PTP is
 enabled
Date: Mon,  8 Jun 2026 12:40:56 -0400
Message-ID: <20260608164059.65420-5-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

When PTP is enabled on the ICE PMD, hardware RX timestamps are only
applied to packets classified as IEEE 1588 (Ethertype 0x88F7). This
prevents applications from obtaining hardware timestamps on regular
UDP/IP traffic.

Remove the TIMESYNC packet type filter so that all received packets
get hardware timestamps when PTP is enabled. This is required for
time-sensitive networking applications that need per-packet arrival
timing on media traffic, such as ST 2110-21 receiver compliance
monitoring.

The change affects all three RX paths: scan, scattered, and single
packet receive functions.


Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..8d709125f7 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2023,8 +2023,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 				pkt_flags |= rxq->ts_flag;
 			}
 
-			if (ad->ptp_ena && ((mb->packet_type &
-			    RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)) {
+			if (ad->ptp_ena) {
 				rxq->time_high =
 				   rte_le_to_cpu_32(rxdp[j].wb.flex_ts.ts_high);
 				mb->timesync = rxq->queue_id;
@@ -2390,8 +2389,7 @@ ice_recv_scattered_pkts(void *rx_queue,
 			pkt_flags |= rxq->ts_flag;
 		}
 
-		if (ad->ptp_ena && ((first_seg->packet_type & RTE_PTYPE_L2_MASK)
-		    == RTE_PTYPE_L2_ETHER_TIMESYNC)) {
+		if (ad->ptp_ena) {
 			rxq->time_high =
 			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
 			first_seg->timesync = rxq->queue_id;
@@ -2881,8 +2879,7 @@ ice_recv_pkts(void *rx_queue,
 			pkt_flags |= rxq->ts_flag;
 		}
 
-		if (ad->ptp_ena && ((rxm->packet_type & RTE_PTYPE_L2_MASK) ==
-		    RTE_PTYPE_L2_ETHER_TIMESYNC)) {
+		if (ad->ptp_ena) {
 			rxq->time_high =
 			   rte_le_to_cpu_32(rxd.wb.flex_ts.ts_high);
 			rxm->timesync = rxq->queue_id;
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

