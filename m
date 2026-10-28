Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA59606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J1uoFK5H
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C70340264;
	Wed, 28 Oct 2026 14:23:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 183C4400D7;
 Wed, 28 Oct 2026 14:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793193812; x=1824729812;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gWu88INGDZ1V+Fs54FTinxLl2OTpS+/be3oRL4wt9Lw=;
 b=J1uoFK5H26DWkflfpEvBQs47mM6PNyqKm5tkiLugLH1UWGO8teslSew4
 F2d3sHdRF8LAbL0zh2fhY672iTJ9EjZYyQv5UOIGlmeailos8M6LHXruH
 F2Nsk9oWnkINBUpmuEKlcTNMcrjUm1nUV3cO+i/wmo0BJ5WE/Y5gUOrD/
 Ca0zb3uWf1v4JGLhTgaXLzr/xJXTOYS5hmGINMUESaR/vnkaazrDgehDd
 GOuKZuug08HxBBFgbGEZYnPCkJ5hh0d+Z0Tf2g3r1ybmPDS3MPmTiL86q
 RIb4f5pU/clhrfSmBP8thPpzebwxpmpfaZBingpShBmAFFYk+lhm3vjbe g==;
X-CSE-ConnectionGUID: 9LKQoWkrTzi5kGXQbWYl9A==
X-CSE-MsgGUID: VuBWMHW/Sb65KF8Zr+RkXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1798288"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1798288"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 06:23:29 -0700
X-CSE-ConnectionGUID: bvV5po1wSpuy0eLLw0kLkw==
X-CSE-MsgGUID: oCqwcGQ8QsyttQC7a1HQWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6661587"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa013.fm.intel.com with ESMTP; 28 Oct 2026 06:23:27 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 soumyadeep.hore@intel.com, grzegorz.nitka@intel.com,
 marek.kasiewicz@intel.com, stable@dpdk.org,
 Michal Michalik <michal.michalik@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH] net/ice/base: fix E830 PHY timer command
Date: Wed, 28 Oct 2026 13:23:57 +0000
Message-ID: <20261028132357.2112458-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

ice_ptp_tmr_cmd() prepares the source timer, then the PHY ports, and
then starts the command with a write to GLTSYN_CMD_SYNC. For E830,
ice_ptp_port_cmd_e830() writes the command to E830_ETH_GLTSYN_CMD with
a sideband queue message. E810 and E830 have no sideband queue, so the
message goes to firmware on the admin queue as a neighbor device
request. The firmware rejects it with ICE_ERR_AQ_ERROR (-100).

E830 has an internal PHY, and its port timers follow the source timer.
On E830, ice_ptp_init_time() and ice_ptp_write_incval() write only the
source timer, and ice_ptp_adj_clock() prepares no PHY adjustment.
Also, E830_ETH_GLTSYN_CMD (0x00088814) is the address of
GLTSYN_CMD_SYNC, and the only command that gets to this function,
ADJ_TIME (0x04), leaves the SYNC field of that register at 0.

Do not prepare a port command on E830, and remove the unused
function and register define.

Before commit f9767f70cb73 ("net/ice/base: fix adjust timer
programming for E830"), ice_ptp_adj_clock() returned early on E830,
and nothing called ice_ptp_port_cmd_e830(). Since that commit,
each rte_eth_timesync_adjust_time() with a delta in the 32-bit range
fails with "PTP adj clock failed, err -100", and the PHC does not
change. A PTP client then cannot discipline the clock.

Fixes: 881169950d80 ("net/ice/base: implement initial PTP support for E830")
Fixes: f9767f70cb73 ("net/ice/base: fix adjust timer programming for E830")
Cc: stable@dpdk.org

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
Tested on an E830-CC PF (firmware 1.3833.0) with a program that calls
rte_eth_timesync_adjust_time() after rte_eth_timesync_enable(). "step" is
the change of PHC minus CLOCK_REALTIME across the call; with a delta of 0
it is about -245 ns, the cost of the reads.

  delta (ns)   without the patch     with the patch
  0            -1, "err -100"        0, step -238 to -249 ns
  +1000        -                     0, step +691 to +890 ns (3 runs)
  -1000        -                     0, step -1128 to -1250 ns (3 runs)
  +1000000     -1, step -1279 ns     0, step +999762 ns
  -1000000     -1, step -171 ns      0, step -1000247 ns

 drivers/net/intel/ice/base/ice_ptp_hw.c | 22 ++--------------------
 drivers/net/intel/ice/base/ice_ptp_hw.h |  2 --
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ptp_hw.c b/drivers/net/intel/ice/base/ice_ptp_hw.c
index 5688f969ce..84b2486c49 100644
--- a/drivers/net/intel/ice/base/ice_ptp_hw.c
+++ b/drivers/net/intel/ice/base/ice_ptp_hw.c
@@ -5612,25 +5612,6 @@ ice_ptp_write_direct_phc_time_e830(struct ice_hw *hw, u64 time)
 	return 0;
 }
 
-/**
- * ice_ptp_port_cmd_e830 - Prepare all external PHYs for a timer command
- * @hw: pointer to HW struct
- * @cmd: Command to be sent to the port
- * @lock_sbq: true if the sideband queue lock must be acquired
- *
- * Prepare the external PHYs connected to this device for a timer sync
- * command.
- */
-static int
-ice_ptp_port_cmd_e830(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd,
-		      bool lock_sbq)
-{
-	u32 val = ice_ptp_tmr_cmd_to_port_reg(hw, cmd);
-
-	return ice_write_phy_reg_e810_lp(hw, E830_ETH_GLTSYN_CMD, val,
-					   lock_sbq);
-}
-
 /**
  * ice_read_phy_tstamp_e830 - Read a PHY timestamp out of the external PHY
  * @hw: pointer to the HW struct
@@ -5881,7 +5862,8 @@ static int ice_ptp_port_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd,
 	/* PHY models which can program all ports simultaneously */
 	switch (hw->phy_model) {
 	case ICE_PHY_E830:
-		return ice_ptp_port_cmd_e830(hw, cmd, lock_sbq);
+		/* The internal PHY follows the source timer command */
+		return 0;
 	case ICE_PHY_E810:
 		return ice_ptp_port_cmd_e810(hw, cmd, lock_sbq);
 	default:
diff --git a/drivers/net/intel/ice/base/ice_ptp_hw.h b/drivers/net/intel/ice/base/ice_ptp_hw.h
index 534e05a8dd..31cbcc39d0 100644
--- a/drivers/net/intel/ice/base/ice_ptp_hw.h
+++ b/drivers/net/intel/ice/base/ice_ptp_hw.h
@@ -617,8 +617,6 @@ ice_get_base_incval(struct ice_hw *hw, enum ice_src_tmr_mode src_tmr_mode)
 
 /* E810 timer command register */
 #define E810_ETH_GLTSYN_CMD		0x03000344
-/* E830 timer command register */
-#define E830_ETH_GLTSYN_CMD		0x00088814
 
 /* Source timer incval macros */
 #define INCVAL_HIGH_M			0xFF

base-commit: cc048a01ec4c7ae5f63a6607260ac05cc1588968
prerequisite-patch-id: 7f8d7046d07c815969a50ef60697c6c779bcbaa8
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

