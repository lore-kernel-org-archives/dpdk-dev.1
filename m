Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAC7C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E32A40647;
	Fri, 18 Apr 2025 21:33:11 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BDCE340647;
 Fri, 18 Apr 2025 21:33:09 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id F180F20BCAD3; Fri, 18 Apr 2025 12:33:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F180F20BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1745004788;
 bh=ClWkMExrDuoD40juKyh3hALaWQvvCftNnUDh07zExHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kRUOX40DkpmqSFOjSDEfmSkPD98KjmR5rK0vdcQOA7pQR81x7W5FP4daorgR9Q92o
 qw45q+1gI8t1KQZCA1g20JRj0Cpx67nEA+aeOJOeb45bEHmzLlxDrruhVZAihFLzNS
 dwRLkgzvC40dwwiL1SVWzSU5hazOBdYS4G6xZy3k=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH 1/4] bus/vmbus: Align ring buffer data region to system page
 boundary
Date: Fri, 18 Apr 2025 12:32:47 -0700
Message-Id: <1745004770-9795-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
References: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

The ring buffer data region always starts at the system page boundary
after ring buffer head. The current code assumes the system page size is
4k. This is not always correct.

Fix this by using system page size for addressing ring buffer data.

Fixes: 831dba47bd ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/rte_vmbus_reg.h | 9 +++------
 drivers/bus/vmbus/vmbus_bufring.c | 9 ++++++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h b/drivers/bus/vmbus/rte_vmbus_reg.h
index 54a26d12bd..fb7e3043ec 100644
--- a/drivers/bus/vmbus/rte_vmbus_reg.h
+++ b/drivers/bus/vmbus/rte_vmbus_reg.h
@@ -100,14 +100,11 @@ struct __rte_packed_begin vmbus_bufring {
 		uint32_t value;
 	} feature_bits;
 
-	/* Pad it to rte_mem_page_size() so that data starts on page boundary */
-	uint8_t	reserved2[4028];
-
 	/*
-	 * Ring data starts here + RingDataStartOffset
-	 * !!! DO NOT place any fields below this !!!
+	 * This is the end of ring buffer head. The ring buffer data is system
+	 * page aligned and starts at rte_mem_page_size() from the beginning
+	 * of this structure
 	 */
-	uint8_t data[];
 } __rte_packed_end;
 
 /*
diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index c78619dc44..fcb97287dc 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -36,7 +36,10 @@ void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
 {
 	br->vbr = buf;
 	br->windex = br->vbr->windex;
-	br->dsize = blen - sizeof(struct vmbus_bufring);
+
+	/* The ring buffer data starts at the 2nd page of the ring buffer */
+	RTE_VERIFY(blen > rte_mem_page_size());
+	br->dsize = blen - rte_mem_page_size();
 }
 
 /*
@@ -72,7 +75,7 @@ static inline uint32_t
 vmbus_txbr_copyto(const struct vmbus_br *tbr, uint32_t windex,
 		  const void *src0, uint32_t cplen)
 {
-	uint8_t *br_data = tbr->vbr->data;
+	uint8_t *br_data = (uint8_t *)tbr->vbr + rte_mem_page_size();
 	uint32_t br_dsize = tbr->dsize;
 	const uint8_t *src = src0;
 
@@ -170,7 +173,7 @@ static inline uint32_t
 vmbus_rxbr_copyfrom(const struct vmbus_br *rbr, uint32_t rindex,
 		    void *dst0, size_t cplen)
 {
-	const uint8_t *br_data = rbr->vbr->data;
+	const uint8_t *br_data = (uint8_t *)rbr->vbr + rte_mem_page_size();
 	uint32_t br_dsize = rbr->dsize;
 	uint8_t *dst = dst0;
 
-- 
2.34.1

