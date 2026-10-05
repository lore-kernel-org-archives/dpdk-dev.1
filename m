Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22739CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3BB740E4A;
	Mon,  5 Oct 2026 22:25:51 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id D6B5A40E50
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:49 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2df8c28a0b1so2717835ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231949; x=1791836749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xGOV/FjEpTsF7F8gH/PYsWvbVv8/645pqN9rdONe8y4=;
 b=Wuf3vJfBNX/XWqeLakcn4phnKIf68skd46zijokXkAdfFJLukwHHzRm09aM7UmECxf
 Te0xDkL/hPplzGAn8NPkwLvGivKb5rf6HjKjcqyPSycmnvrIaTpvURPF2Buvexi/gsKM
 /tQ+6fy4IPc0SHKPGvlX6Xh0kD0pOwnifNMjfW9h+pu4WdpyZoOHBbqcM91KB+ppnISe
 fvk9JuT5F5R7ssr5FgOjbqD1QCbRQmkeTPp3fJD7VEsw5N70kBiUtnsjF2eEj0nE9zln
 9b78YvJjv46zALh37egkneQcehdPA2IZMGjE+u9D8Fl/UsQ7lcPaVgFBdZTIpWtyfvho
 edSw==
X-Gm-Message-State: AFq9FYIZTcJXBhtaAB0KM2W3EDoGNZ0v9wv/QFhdjcFnsbqr2JTuJjbC
 kXUxtP1cGiqa/WGf6Qbn7AZ9I5KMTok8pKqu6S5JK9CNiTPGAxs1jdBgVFIpZ9mGP2h2urq2z6y
 vPP8X6SvqpwPZe1kZvNc059mLbF39BUMCiqQkzbKzrIQA1vOu78EzT2xQjhBVikNgeF07r8Vqho
 rpoiA0tlNZ5mvvPpafMQNIxn0WycSxGTZ94eHZSC2Wm3e2iCjhHStjXJ2dgh3oMuMz+Piiuw==
X-Gm-Gg: AYBFou0gOFEKnTxXxpiuilJd/H9o+34yROBLl7MPXhb8+Tv4IkRaosJystVAjRz4rIv
 UA1kjCBaRSAQzuvZcIkOE4ZD79DE+FzVuxHcfbc4jAQFjD7U4IVPKE5BIKaeZPlyaJ6TnjIWucD
 m5OxQXGayxOXtp7mmVT4EtfwXMd6e7aobRY3t0x4G9/KW20MplTSbYEPVNC93yRBxMnwC9tSm4n
 meutbmzwEjcs+5dVUacADOPsHloC086/GWRv4rK4W/lSKtM1xKEp7Jpm7rTncCbwJdDlBQoqLxv
 tpYq87GFVTItBQ3IdX/vQ9GFNvUu3XV0vnjlzF0Hx9YKoiFfil7Gn/S+RqkGdRBUZNol/4DA8gH
 KwZ9lX1oQTr9scmxvDx3BGe5vwJLp50JiU5djLmtAJA0685W0WE+YzosiUOEZ5PuJ2AUNWzVx0A
 Wpr+Yb1Q+Bubv+55p/snksi2VnbVDpyHwE3SY4Lg==
X-Received: by 2002:a17:90b:1808:b0:3a4:b0ba:8e4d with SMTP id
 98e67ed59e1d1-3a6ceab1b67mr6262860a91.13.1791231948742; 
 Mon, 05 Oct 2026 13:25:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a8533a9905sm311739a91.1.2026.10.05.13.25.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91792488228so53059376d6.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231948; x=1791836748; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGOV/FjEpTsF7F8gH/PYsWvbVv8/645pqN9rdONe8y4=;
 b=LTVWeBTGSLJHkRBCKBpkCDpGVLgYdNGQ090WDYZ6JOcuffp+bKBJUaLNGWF/mJfC3H
 +vRBJrTBAWjUveI/QxvP86AwQIgqUWkDr3/EN1w36CbMgEqKWPsJpQkEwQIWeOABdh3u
 oFxjEKUDKkGETuAnlu20Y5fbWua2e70bMDeBQ=
X-Received: by 2002:a05:620a:f11:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93cf16b39d4mr2116063385a.12.1791231947700; 
 Mon, 05 Oct 2026 13:25:47 -0700 (PDT)
X-Received: by 2002:a05:620a:f11:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93cf16b39d4mr2116058485a.12.1791231947029; 
 Mon, 05 Oct 2026 13:25:47 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca1a7a40sm951256085a.7.2026.10.05.13.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:46 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix meter stats race with stats cache thread
Date: Mon,  5 Oct 2026 15:25:44 -0500
Message-Id: <20261005202544.18272-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Jay Ding <jay.ding@broadcom.com>

The background stats cache thread and the show-port-meter-stats
path both issue MPC TABLE_READ commands targeting the same ingress
(RE_CFA) completion ring. The stats cache holds fdb_lock for the
entire batch send+collect window, but the meter stats path called
tfc_act_get() with no lock, creating a race between the two threads.

Fix by acquiring fdb_lock in ulp_fc_tfc_mtr_stat_get before the
MPC call, matching the same serialization pattern used by the stats
cache thread. The flow-stat path (ulp_fc_tfc_flow_stat_get) is
not changed because its callers in ulp_fc_mgr.c already hold the
lock. Also initialize count to zero to fix a pre-existing case
where count.reserved (marked "must be zero" in rte_flow.h) was left
uninitialized; count.reset is already explicitly set on both branches
above and was never the affected field.

Fixes: 3ed6fb5edc8e ("net/bnxt/tf_ulp: add meter stats support for Thor2")
Cc: stable@dpdk.org

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
index 8e61c71f97..d25e4ac27c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
@@ -160,14 +160,27 @@ ulp_fc_tfc_mtr_stat_get(struct bnxt_ulp_context *ctxt,
 			int32_t clear,
 			struct rte_mtr_stats *mtr_count)
 {
-	struct rte_flow_query_count count;
+	struct rte_flow_query_count count = { 0 };
+	int32_t rc;
 
 	if (clear)
 		count.reset = 1;
 	else
 		count.reset = 0;
 
-	return ulp_fc_tfc_stat_get(ctxt, direction, session_type, handle, &count, mtr_count);
+	/*
+	 * Acquire fdb_lock to serialize this non-batch MPC read against the
+	 * background stats cache thread, which holds the same lock for the
+	 * duration of its batch send+collect window. Without this, both paths
+	 * race on the shared RE_CFA/TE_CFA MPC completion ring, leading to
+	 * out-of-order completions and firmware ring-state corruption.
+	 */
+	if (bnxt_ulp_cntxt_acquire_fdb_lock(ctxt))
+		return -EIO;
+
+	rc = ulp_fc_tfc_stat_get(ctxt, direction, session_type, handle, &count, mtr_count);
+	bnxt_ulp_cntxt_release_fdb_lock(ctxt);
+	return rc;
 }
 
 const struct bnxt_ulp_fc_core_ops ulp_fc_tfc_core_ops = {
-- 
2.31.1

