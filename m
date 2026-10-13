Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC02CCC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7AA940272;
	Wed, 14 Oct 2026 00:02:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 83E3640269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791928925; x=1823464925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jk1UTSsVR/Xg1RfNQTcLz3Mkl/batfnMnTOMwfHF9xE=;
 b=ivR0vC1EFsolxDRsPzYUSGRSRHD2hemP/vXtiv342bxWQndjk7M3F0FF
 6nNL3VFzf+TTtxWiJw6AvZ17pPtRT/6j2jiNswyvgdnKxlhYTCUwQGqQA
 jVKPpDhpeMa1ltzWNHAkGYcLRYaJdDvnZkWN4nPuCNNaWv/V4j2S54+mk
 kKc3Dz9Czt0EVTUfSoXpqJBdpph/NRCn5PDRuIBR2UOejxxQY9BC9kTjF
 Z2fMpWxB8BiLjQFutrp6T1+js6N+5rVD5JD5xBFx2A5nSGe3ZjfLutMIP
 RBM08FNrvyVd9TSuV8ne0+5mOmDFHL5odfFTlui+Viva9jKNSUZbFerOj g==;
X-CSE-ConnectionGUID: ZyT7X2NmT+2q+qvo+kmY5g==
X-CSE-MsgGUID: cwptdqiYSc+V0nK/JUXxBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="544740"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="544740"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 15:02:03 -0700
X-CSE-ConnectionGUID: Dy+R3JXhSTG9kEJE0gAT7A==
X-CSE-MsgGUID: 51FJG58yRRK7kBS1RRmTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1343859"
Received: from gnrd03.iind.intel.com ([10.190.213.135])
 by fmviesa003.fm.intel.com with ESMTP; 13 Oct 2026 15:02:01 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com
Subject: [PATCH v2] examples/ptpclient: compensate for clock frequency drift
Date: Wed, 14 Oct 2026 03:31:45 +0530
Message-ID: <20261013220145.880388-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013214649.878454-1-soumyadeep.hore@intel.com>
References: <20261013214649.878454-1-soumyadeep.hore@intel.com>
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

The ptpclient example corrected only the instantaneous phase offset by
calling rte_eth_timesync_adjust_time() once per DELAY_RESP. It never
compensated for oscillator frequency drift, so the transmitter/receiver
offset settled at a non-zero steady-state value (proportional to the
drift rate times the sync interval) instead of converging towards zero.

Replace the one-shot phase step with a PI clock servo, using the same
model as linuxptp. The servo output is a frequency correction that is
applied through the best mechanism the PMD provides:

- When the driver supports hardware frequency adjustment, the correction
  is applied with rte_eth_timesync_adjust_freq() (for example the E810
  INCVAL register).
- Otherwise the same correction is realized in software as an
  incremental phase step over the elapsed interval using
  rte_eth_timesync_adjust_time(), which every timesync-capable PMD
  provides.

Hardware support is probed once at runtime, so any PMD that implements
the adjust_freq operation in the future uses the hardware path without
further changes. The servo state is kept per port and the selected path
is logged once per port.

Bugzilla ID: 1474

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
v2:
 - Use transmitter/receiver instead of master/slave terminology

 examples/ptpclient/ptpclient.c | 114 ++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 59ce892742..99a4606fbd 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -34,6 +34,12 @@ static volatile bool force_quit;
 #define NSEC_PER_SEC        1000000000L
 #define KERNEL_TIME_ADJUST_LIMIT  20000
 
+/* PI clock servo parameters (same model as linuxptp). */
+#define PTP_SERVO_KP              0.7
+#define PTP_SERVO_KI              0.3
+/* Step the clock directly when the offset exceeds this threshold. */
+#define PTP_STEP_THRESHOLD_NS     100000
+
 struct rte_mempool *mbuf_pool;
 uint32_t ptp_enabled_port_mask;
 uint8_t ptp_enabled_port_nb;
@@ -97,6 +103,18 @@ struct ptpv2_time_receiver_ordinary {
 
 static struct ptpv2_time_receiver_ordinary ptp_data;
 
+/* Per-port clock servo state. */
+struct ptp_clock_servo {
+	int freq_adj_supported;     /* -1 unknown, 0 software, 1 hardware */
+	int count;                  /* number of samples processed */
+	int64_t last_offset;        /* previous offset (ns) */
+	uint64_t last_local;        /* NIC clock at previous sample (ns) */
+	double drift_ppb;           /* integral term / standing frequency (ppb) */
+};
+
+static struct ptp_clock_servo ptp_servo[RTE_MAX_ETHPORTS];
+
+
 static inline uint64_t timespec64_to_ns(const struct timespec *ts)
 {
 	return ((uint64_t) ts->tv_sec * NSEC_PER_SEC) + ts->tv_nsec;
@@ -229,7 +247,7 @@ print_clock_info(struct ptpv2_time_receiver_ordinary *ptp)
 	int64_t nsec;
 	struct timespec net_time, sys_time;
 
-	printf("time transmitter clock id: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
+	printf("\ntime transmitter clock id: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
 		ptp->transmitter_clock_id[0],
 		ptp->transmitter_clock_id[1],
 		ptp->transmitter_clock_id[2],
@@ -308,6 +326,93 @@ delta_eval(struct ptpv2_time_receiver_ordinary *ptp)
 	return delta;
 }
 
+/*
+ * Convert a frequency correction in ppb to the scaled ppm (16-bit fractional)
+ * unit expected by rte_eth_timesync_adjust_freq().
+ */
+static int64_t
+ppb_to_scaled_ppm(double ppb)
+{
+	return (int64_t)(ppb * 65536.0 / 1000.0);
+}
+
+/*
+ * PI clock servo. Drives the transmitter/receiver offset to zero by compensating
+ * for clock frequency drift, not just the instantaneous phase offset.
+ *
+ * The servo output is a frequency correction (ppb). When the PMD supports
+ * hardware frequency adjustment it is applied via rte_eth_timesync_adjust_freq()
+ * (e.g. the E810 INCVAL register). Otherwise the same correction is realized in
+ * software as an incremental phase step over the elapsed interval using
+ * rte_eth_timesync_adjust_time(), which every timesync-capable PMD provides.
+ */
+static void
+clock_servo(struct ptpv2_time_receiver_ordinary *ptp, int64_t offset)
+{
+	struct ptp_clock_servo *servo = &ptp_servo[ptp->portid];
+	struct timespec now;
+	uint64_t local;
+	double ppb, ki_term;
+
+	/* Probe hardware frequency adjustment support once. */
+	if (servo->freq_adj_supported < 0) {
+		servo->freq_adj_supported =
+			(rte_eth_timesync_adjust_freq(ptp->portid, 0) == 0) ? 1 : 0;
+		printf("Port %u clock frequency adjustment: %s\n", ptp->portid,
+		       servo->freq_adj_supported ? "hardware" : "software");
+	}
+
+	if (rte_eth_timesync_read_time(ptp->portid, &now) != 0)
+		return;
+	local = timespec64_to_ns(&now);
+
+	/* Large offset: step the clock directly and (re)start the servo. */
+	if (offset >= PTP_STEP_THRESHOLD_NS || offset <= -PTP_STEP_THRESHOLD_NS) {
+		rte_eth_timesync_adjust_time(ptp->portid, offset);
+		servo->last_offset = 0;
+		servo->last_local = local;
+		if (servo->count == 0)
+			servo->count = 1;
+		return;
+	}
+
+	switch (servo->count) {
+	case 0:
+		/* First sample: establish the baseline only. */
+		servo->last_offset = offset;
+		servo->last_local = local;
+		servo->count = 1;
+		return;
+	case 1:
+		/* Second sample: seed the drift estimate from the slope. */
+		if (local > servo->last_local)
+			servo->drift_ppb = 1e9 *
+				(double)(offset - servo->last_offset) /
+				(double)(local - servo->last_local);
+		servo->count = 2;
+		break;
+	default:
+		ki_term = PTP_SERVO_KI * (double)offset;
+		servo->drift_ppb += ki_term;
+		break;
+	}
+
+	ppb = PTP_SERVO_KP * (double)offset + servo->drift_ppb;
+
+	if (servo->freq_adj_supported == 1) {
+		rte_eth_timesync_adjust_freq(ptp->portid, ppb_to_scaled_ppm(ppb));
+	} else if (local > servo->last_local) {
+		/* Realize the frequency correction as a phase step. */
+		double dt = (double)(local - servo->last_local);
+
+		rte_eth_timesync_adjust_time(ptp->portid,
+					     (int64_t)(ppb * dt / 1e9));
+	}
+
+	servo->last_offset = offset;
+	servo->last_local = local;
+}
+
 /*
  * Parse the PTP SYNC message.
  */
@@ -507,8 +612,7 @@ parse_drsp(struct ptpv2_time_receiver_ordinary *ptp)
 			/* Evaluate the delta for adjustment. */
 			ptp->delta = delta_eval(ptp);
 
-			rte_eth_timesync_adjust_time(ptp->portid,
-							ptp->delta);
+			clock_servo(ptp, ptp->delta);
 
 			ptp->current_ptp_port = ptp->portid;
 
@@ -576,6 +680,10 @@ lcore_main(void)
 	printf("\nCore %u Waiting for SYNC packets. [Ctrl+C to quit]\n",
 			rte_lcore_id());
 
+	/* Hardware frequency support is probed on the first adjustment. */
+	for (portid = 0; portid < RTE_MAX_ETHPORTS; portid++)
+		ptp_servo[portid].freq_adj_supported = -1;
+
 	/* Run until the application is quit or killed. */
 
 	while (!force_quit) {
-- 
2.43.0

