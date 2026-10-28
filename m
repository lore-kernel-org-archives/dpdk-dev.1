Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEE606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwulq55b
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3F9402EE;
	Wed, 28 Oct 2026 14:24:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id A8835402E0;
 Wed, 28 Oct 2026 14:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793193838; x=1824729838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UBBtas6qRkM3eaCen7+cKol3mqmK+KPNCm2kXzODHNQ=;
 b=hwulq55bWYT6SjsQb/hCtUDJx8Iyout41yiyBBbo2DQ17LOjgBiwuWkC
 HRGJ3ba8mOEvV7qhmsYpvXCv8Jq2m5Z0DzH2ekX7vFXeNyCRQd5jpDBbV
 Qij1X1vCqgLAOa8LIb1CTf3lyIrMnbjb5a6y6cetlwdgfqkCpVc7upLH0
 PlVBeNu09ws5tB/e+T2fo3IkoHzoiQcLRmiadfnwTrCozv6P6EKX6f6qo
 aqL+lIzVZqEwNDjBD4spoti7yTqdHoDO00pALutBr9eSBmoKmuDrympNm
 PmJ2vJ57BvlQw5OCh7Hw/tCd+iugYvyifoItAX5VfrZW5+RbbmYjRSRxr A==;
X-CSE-ConnectionGUID: ho0wUdskQ4+B/j0+CXx/2g==
X-CSE-MsgGUID: nSFXIJyqQnO7Lbdrks14PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1917434"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1917434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 06:23:57 -0700
X-CSE-ConnectionGUID: 9pYcd6daRV2Kjoh9Q9xjjg==
X-CSE-MsgGUID: D0CoRa8sS3qNnJKXTa+4Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4778806"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2026 06:23:56 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 soumyadeep.hore@intel.com, grzegorz.nitka@intel.com,
 marek.kasiewicz@intel.com, stable@dpdk.org
Subject: [PATCH 1/2] net/ice: fix TxPP launch time encoding
Date: Wed, 28 Oct 2026 13:24:33 +0000
Message-ID: <20261028132435.2113321-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028132435.2113321-1-dawid.wesierski@intel.com>
References: <20261028132435.2113321-1-dawid.wesierski@intel.com>
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

The Tx time descriptor holds the launch time in a 19-bit field, in
units of 128 ns. The hardware compares it with the low 19 bits of the
PHC time in the same units, so the field wraps every 2^19 * 128 ns
(about 67.1 ms).

ice_write_ts_desc() takes the launch time modulo one second before
the shift. One second is 7812500 units of 128 ns, and that is not a
multiple of 2^19. Thus in second k of the PHC, the encoded value is
k * 51820 units (k * 6.63 ms) after the launch time, modulo 67.1 ms.
At each second boundary, the launch time that the hardware sees moves
6.63 ms later. The error goes through the full 67.1 ms range every
10.1 s. In half of that time it is more than half of the range, and
the queued packets look late.

The result is a pacing fault that comes and goes: the queue holds
packets too long, or sends them at line rate. Because the phase
depends on the absolute PHC time, some runs start in the bad half of
the cycle and some do not.

Encode the full launch time, and let FIELD_PREP() keep the low 19
bits.

On E830, with one ST 2110-20 video stream on a 1024-entry Tx ring,
6 of 13 runs lost pacing with the modulo encoding. With this patch,
32 of 32 runs paced correctly, with burst sizes of 1, 4 and 16.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 6f19e070ee..7c299618c5 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3095,7 +3095,8 @@ ice_write_ts_desc(struct ci_tx_queue *txq,
 		  uint16_t ts_id)
 {
 	uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt, txq->tsq->ts_offset, uint64_t *);
-	uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >> ICE_TXTIME_CTX_RESOLUTION_128NS;
+	/* The hardware compares the low 19 bits of PHC time in 128ns units. */
+	uint32_t tstamp = (uint32_t)(txtime >> ICE_TXTIME_CTX_RESOLUTION_128NS);
 	const uint32_t desc_tx_id = (tx_id == 0) ? txq->nb_tx_desc : tx_id;
 	__le32 ts_desc = rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M, desc_tx_id) |
 			FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

