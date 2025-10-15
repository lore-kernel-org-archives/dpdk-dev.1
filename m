Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B5CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57762406B4;
	Wed, 15 Oct 2025 09:17:06 +0200 (CEST)
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.155.198.111])
 by mails.dpdk.org (Postfix) with ESMTP id 6A3AD406A2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512624; x=1792048624;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=AX9U0v/P1t8MDzR0RtZMDbtYF4VsyJIyWE45VQVzljc=;
 b=nt5n4UUse6kimpMIWK12honheZIPKpXCrj+4OIH89AIrQnO2vENVP8QY
 VCBn59NtYUSSRjvCDzws/l8ov2VSvqRiwTaRxfd9wIemNVDM+VV8LQRXV
 2uzhjzucFy2Ve7vTDgFtqtq8y5vkesS1ti83mPKPNb+Ebg4wSOwBSNuwe
 O71QFRrSXhq65d8AOiQpcnSZORcRBl74xYWMR8sI5mWIV9MuWqNGVZsp6
 KEuyKEYcoNnbApD3/kfXsUXsPqEwqs5NEoAWjVeQM+fpY8rVw1q3Lkgzr
 LtP+q8wykiM4seCp5EzCZdjlNoqbQcQ3COGfeDt+aTrA7wpN+LKTkgDSe A==;
X-CSE-ConnectionGUID: RzhafVs7SEyHTIJTy2ovig==
X-CSE-MsgGUID: GO5UjXK9QGeYKW1KnyiVYw==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4801538"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:16:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:30842]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525]
 with esmtp (Farcaster)
 id 92120293-20c7-4363-a863-acc3fbaace48; Wed, 15 Oct 2025 07:16:59 +0000 (UTC)
X-Farcaster-Flow-ID: 92120293-20c7-4363-a863-acc3fbaace48
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:59 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:16:57 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 19/21] net/ena/base: optimize branch prediction
Date: Wed, 15 Oct 2025 10:16:47 +0300
Message-ID: <20251015071647.1188-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
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

Add likely/unlikely compiler hints to optimize conditional logic

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 4 ++--
 drivers/net/ena/base/ena_eth_com.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 653df389c4..8a019b3451 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -241,7 +241,7 @@ static void *get_tx_sq_desc(struct ena_com_io_sq *io_sq)
 {
 	void *tx_desc;
 
-	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV)
+	if (likely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV))
 		return get_sq_desc_llq(io_sq);
 
 	tx_desc = get_sq_desc_regular_queue(io_sq);
@@ -291,7 +291,7 @@ static int ena_com_sq_update_reqular_queue_tail(struct ena_com_io_sq *io_sq)
 
 static int ena_com_sq_update_tail(struct ena_com_io_sq *io_sq)
 {
-	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV)
+	if (likely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV))
 		return ena_com_sq_update_llq_tail(io_sq);
 
 	return ena_com_sq_update_reqular_queue_tail(io_sq);
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index f25e26840d..1fc92ffb55 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -110,7 +110,7 @@ static inline bool ena_com_sq_have_enough_space(struct ena_com_io_sq *io_sq,
 {
 	int temp;
 
-	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST)
+	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST))
 		return ena_com_free_q_entries(io_sq) >= required_buffers;
 
 	/* This calculation doesn't need to be 100% accurate. So to reduce
-- 
2.17.1

