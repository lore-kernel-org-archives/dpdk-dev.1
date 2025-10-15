Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47ECCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71F0C40E40;
	Wed, 15 Oct 2025 14:13:14 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id EC74B40A6C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530393; x=1792066393;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=AX9U0v/P1t8MDzR0RtZMDbtYF4VsyJIyWE45VQVzljc=;
 b=qvtUKoZ26A9EFY66vmWm7KZaKqRrokRnvj5pRQ9mmde8NQYhDgqTP+xm
 wa/w9Y5Sthao9gFA04zd7zDye6HokXzKtX419RIk1qWQjn4ZBFfX5BXlu
 L8RwJ8bwPMfXv38jJVqC4YykSn8JfDaiMQ09LrPXoBhyU33EAnskQ2iDw
 k02nKsuNDYV0RZID9KJLADWna4BIphNv3lv0B16tHa47701zwf4egIY4q
 p+/UBpT04fAkuANP/BKklm15aHKiBvmZW+UqBqldKgM4e/H5d97Yph3ra
 KmNOE+WM/dCaGwjxrWL4itqsJMQK28AfrS9NMv61kwD2Awg+6zGPDdPP5 Q==;
X-CSE-ConnectionGUID: aa4vWiBnTwKBioOOMCZX4g==
X-CSE-MsgGUID: kTAs66ZoQa2RXLqfCSx+yA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4930329"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:13:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:24080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.42:2525]
 with esmtp (Farcaster)
 id 26f25af4-2bf2-43ec-840f-28a09951a010; Wed, 15 Oct 2025 12:13:11 +0000 (UTC)
X-Farcaster-Flow-ID: 26f25af4-2bf2-43ec-840f-28a09951a010
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:13:11 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:13:10 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 18/20] net/ena/base: optimize branch prediction
Date: Wed, 15 Oct 2025 15:12:58 +0300
Message-ID: <20251015121258.3073-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
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

