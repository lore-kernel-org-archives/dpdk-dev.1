Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876FCCC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 244414064A;
	Wed, 14 Oct 2026 00:35:03 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 72B864064C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:00 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso2070255ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930899;
 x=1792535699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wV3uRDjDKw+4gpUNqDku6XevfxOokDYpE3PMKcchHQM=;
 b=MPySzbssqf/WI2qGv722+tBNzWBetrFHMh6afIXOwMVKz4eCLWNjWVdz46Hotr5kUu
 is6lLW4Wz320eYB6jiFUA6BOGckXvOlwOCZNlcgM0ZOrxKhLFvIela+aU550bdPPRTFO
 pH3wYKJQoaow+Ow1+ZmiGPxTRp/DCt06D6AXP8nTk28GZ2t1lk0WfXz+GMAwwCN1QErJ
 djos5MUCWOJJ5RtldYP7VuJ2t9Sc0MBoz3WFv5N0gKXl4WLtowDXMQ1Lzh6ym2IsRyeS
 ifoKnvCoT30zPFYLJwNdMf9HmAyoXbz6P1o6W1wIDSVRLuO0Wz9mSHIqDSOM0u3GADju
 GQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930899; x=1792535699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wV3uRDjDKw+4gpUNqDku6XevfxOokDYpE3PMKcchHQM=;
 b=cZABwxgiPNq9c0Ws8w5qRB9+n8Ei0Gne4rKKnkTNz7l3q+IAOh+GVb6e8xYx1t81L6
 XFP793SVyLMt8drY9Lym4v5fJCE/M7oAZqzNPv7996UEkbwdYN8j1LvMwZK7qsYkYhZq
 O5KHiZWrvjplrWhj6OyCNqEf1ePx6cWFB3Y5pmGN3KwFD4oAoLPrDIAsjVG/CTJn6T9l
 87FqmN5Z+gTJU07D2cNiF9djCFaWcAjvT3ENKUdXhP9MQ2uBd18A2q10BK2HxqtTjWNr
 hF5stWJoM/cwIKf0s/aZmO13zZVIa4jsuKXGAb14FiPOoCotfMyus94rt7FVde96Nx26
 5JuA==
X-Gm-Message-State: AFq9FYKX9gBlf68ovf7j/pD04K96L1RT4PskPcTTbahuhe9Nt1bEApDH
 8ph4qMoaoqn29+GiwhtdU1MuT5TiPhww4GgBf0x/C7eWsZa0WhRJHtO5irydjd40kY0jJQVDXeA
 ENQY0Dwk=
X-Gm-Gg: AYBFou2Oq3NG8rMx90NrvoV3F7wpHirXyoo+dQWq2xwlXhgSpYOzpPsKeEhWZQvXdwz
 oq0Djr49Qv/EjTjLQbAVMrMtMOhUKTLGjxlRM3K+O00SarGHB/rZbcWilWjTma33m8zDvTA2hKM
 QHmalyx51Xgikx0Gj1OKxVWbjAg8KD+Fvli9t9oNJNog6Yfpoaj3lBjQexjIrS7b6sT+C6Buggd
 5cflLKz+WWU4PtPXpo6zDKqSf8EX/R3qUE2Rj0eRtbDXH8OwR1uPoaKZivmxyECGsEsab3GrVg1
 kn8hkttp+YGYV4uOQ4sui4cLEGui4mIa2uC4dLRPq6l3rFo+LPnsZ5Nx12tfVzCWiQ1GwMFgI/s
 po0GzkjZtAsRqQNmcImHzGNw/cF54VkFqI9HUUH02xP8XMxbLIQlZcpx4CBpV0PHFeJyi0HgThj
 jU9j5EI/08Q57/Unnlvx/i7FL3RS2ymCLxJ5F4So7OczOQFTik48HkVGDJV1Vl10TDvzW1hhvVp
 hvUVc9Ij7Kc1PUXy2pBTcaYVAFa7BjYGtzJmA==
X-Received: by 2002:a17:902:ef07:b0:2e9:3395:cca8 with SMTP id
 d9443c01a7336-2e93395d1c7mr5735305ad.46.1791930899538; 
 Tue, 13 Oct 2026 15:34:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 05/29] bus/vmbus: replace SMP barriers with C11 memory
 fences
Date: Tue, 13 Oct 2026 15:22:18 -0700
Message-ID: <20261013222410.2257622-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Full barriers order the preceding index store against the following
load of the interrupt mask or pending size and stay seq_cst; read
barriers become acquire fences. Same code generated on x86 and arm64.

The write barrier in rte_vmbus_chan_signal_tx() goes away instead.
Every caller reaches it through vmbus_txbr_write(), which ends in
vmbus_txbr_need_signal() and its full barrier, so the load of the
interrupt mask is already ordered after the write index store.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/bus/vmbus/vmbus_bufring.c |  4 ++--
 drivers/bus/vmbus/vmbus_channel.c | 13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index 86dc446786..95f03929cb 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -58,11 +58,11 @@ void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
 static inline bool
 vmbus_txbr_need_signal(const struct vmbus_bufring *vbr, uint32_t old_windex)
 {
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 	if (vbr->imask)
 		return false;
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/*
 	 * This is the only case we need to signal when the
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 6887fbad46..90ba3d1ef6 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -104,10 +104,9 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channe
 {
 	const struct vmbus_br *tbr = &chan->txbr;
 
-	/* Make sure all updates are done before signaling host */
-	rte_smp_wmb();
-
-	/* If host is ignoring interrupts? */
+	/* vmbus_txbr_write() did a full barrier after the write index
+	 * update, no further ordering needed here.
+	 */
 	if (tbr->vbr->imask)
 		return;
 
@@ -211,7 +210,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 	return br->vbr->rindex == br->vbr->windex;
 }
 
@@ -229,13 +228,13 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 		return;
 
 	/* Make sure reading of pending happens after new read index */
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	pending_sz = rbr->vbr->pending_send;
 	if (!pending_sz)
 		return;
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 	write_sz = vmbus_br_availwrite(rbr, rbr->vbr->windex);
 
 	/* If there was space before then host was not blocked */
-- 
2.53.0

