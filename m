Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59767CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB086406A2;
	Wed, 15 Oct 2025 09:17:23 +0200 (CEST)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.83.148.184]) by mails.dpdk.org (Postfix) with ESMTP id 926DF402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512641; x=1792048641;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=2h1LkIGpL0A8iB963xxlxKk/pAq2HPznSROlQ72eCBg=;
 b=f9qOqa6TIkAHKN9fv19G1vxyH8Z2sfZa0qZ3KU8TiArjWWIKh8VzSpPF
 XfKoz3U8Biecuk28IYVXCJ3ogRjxguIYVrU7dbGjQreXgXQ4N9vi72mps
 WWg4gk73pEHD6gg2Rk3+VjnuNO0IXddYancQHScV4wqSUaSO2oVupy7D3
 sh5asXrEtEs+y8DYHXDASyy+xulSOktETzCXR2eXXbgBThHtCd2CopxW1
 rNJoUf4Pto8paGpTvbQp0kg3bxiuUjiHKpTsdpYHOvciq+ilcsxUmTlhW
 O24vfJsVq44CiDjlZPLKjBVkEQj7ebXd9KFVyD03ZSJnqTaNDH3GU9rzF A==;
X-CSE-ConnectionGUID: nVyiySwpQPuxX6g3q/25DA==
X-CSE-MsgGUID: tpg8AFCLT3idn7EhAlWEpQ==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4717241"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:17:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:15992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525]
 with esmtp (Farcaster)
 id 798704a1-bd4a-4a30-ac6a-b6683e9d82ff; Wed, 15 Oct 2025 07:17:20 +0000 (UTC)
X-Farcaster-Flow-ID: 798704a1-bd4a-4a30-ac6a-b6683e9d82ff
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:17:20 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:17:18 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 20/21] net/ena/base: change return type and improve logging
Date: Wed, 15 Oct 2025 10:17:08 +0300
Message-ID: <20251015071708.1237-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

The return value was unused and carried no semantic meaning,
so the function signature has been updated to return void.
Additionally, debug log messages have been refined to
improve clarity.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index 1fc92ffb55..f773699467 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -171,26 +171,24 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 	return num_entries_needed > io_sq->entries_in_tx_burst_left;
 }
 
-static inline int ena_com_write_rx_sq_doorbell(struct ena_com_io_sq *io_sq)
+static inline void ena_com_write_rx_sq_doorbell(struct ena_com_io_sq *io_sq)
 {
 	u16 tail = io_sq->tail;
 
 	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
-		    "Write submission queue doorbell for queue: %d tail: %d\n",
+		    "Write submission queue doorbell for rx queue: %d tail: %d\n",
 		    io_sq->qid, tail);
 
 	ENA_REG_WRITE32(io_sq->bus, tail, io_sq->db_addr);
-
-	return 0;
 }
 
-static inline int ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
+static inline void ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
 {
 	u16 max_entries_in_tx_burst = io_sq->llq_info.max_entries_in_tx_burst;
 	u16 tail = io_sq->tail;
 
 	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
-		    "Write submission queue doorbell for queue: %d tail: %d\n",
+		    "Write submission queue doorbell for tx queue: %d tail: %d\n",
 		    io_sq->qid, tail);
 
 	ENA_REG_WRITE32(io_sq->bus, tail, io_sq->db_addr);
@@ -201,8 +199,6 @@ static inline int ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
 			    io_sq->qid, max_entries_in_tx_burst);
 		io_sq->entries_in_tx_burst_left = max_entries_in_tx_burst;
 	}
-
-	return 0;
 }
 
 static inline void ena_com_update_numa_node(struct ena_com_io_cq *io_cq,
-- 
2.17.1

