Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671AC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E37B40DFD;
	Sun, 20 Sep 2026 20:14:05 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 7365440B9D
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:58 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so2018035a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928037;
 x=1790532837; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57kOT+NnrqKVV2LyYNJ6tGP7yK3ktsF+3PsT54MkKt4=;
 b=FITXi6I1UUSjIXFgVoAGl2CBjd0B3y67AlnhhJubpnaD7qJOLrYA0EHtt2Oa3il9kX
 2TAM5Tn8qmE0Zj0oCa/ComPOgd3qzsbt853+CXgL9LzQS8o2TZMDtRfMZk2A3m9DAlyA
 giFXc9C9VR/oL6yM99wenrca0sUaBdL5RIC6eEfm83BAeQmMpo9fBpgOVKtvcQf3JWTL
 hHZ93wTujo+dp6r1IvpNmtOmSw9D8EJvCAHWYWk1ZXYNoRk05j+UgGNIesmFn6CwzRUh
 0gFtSIhluX+rmMPQhYFyIgs4Zp7F5aCXMiZnn8EbyZHG+wFd9v5ivN0N6YYzt4jc8xYT
 572A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928037; x=1790532837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=57kOT+NnrqKVV2LyYNJ6tGP7yK3ktsF+3PsT54MkKt4=;
 b=VWHmkgaFPiO+sKYNdLNtZiT2stotqn6aORiM3KjEDTlkywyNt4PMIUcErqNeDnGdj8
 cdfLl2yIpOmCAdievWAVXaUH5Nvc4ZSFt/Wi6CF9ddtGkNBpcw3ot4PNDX9zkra4PbuM
 lSARusM6ghvxTjmWrJpZrXlfezcj8KL3Rj9tA69b1tWW0tBljyh6PC7d5YwHX84GhGQl
 CyTlk3X+AM0xt3D+bWrPVSeAp8cHP9sBE2mt7gih1fmmocwjI74xEmJiYldq3cbiUBYe
 p4qzpfijw7nXBcExAYreo2QR4ndAKcqe03jLjMRfnO8UGZ3n6DCFcTQAEHv+zDUJEUwb
 FtAQ==
X-Gm-Message-State: AFuF++kKJsZ5yYqW0H3wKAeC9wmwIDZeFPuFpgenaTi1A3LVkQyRnJTE
 NU/xs05xzHfS/IpVPW4J7pIb68yHXQrTu6kh1mKeXyW1Ow4R9gVERwUSr2bUjlYtuAHV9No3ZA/
 igU8Q
X-Gm-Gg: AYBFou3TgRHkKrCUfiUMJhlksWwy8CUUXQZoUIt3Enby4SkcNXrk/CHtG3JET/M+z0A
 AUJobemjHCbBuBPpCzxzBMhNlhyrKTxswHvvavaXzWTQOkeUsnkUwJLnGR3usFZqpLFgp+Kmy51
 1CQQaRfUw1pFmr8juY5Wf95L5Gbvcknnp+ZoqXuM+qIeKNANy2bxeIjvGmMJ8/LZiJ5OxLAG5jY
 oOoQyK0oI0/s6SRABqxaQ/DVJQT8VjZL010KVpn4GTi8dmd3+9eWtmyk4lfM/0VhIMfqFP2elt+
 1vQzcAQXl1Rw4sqDTFAEpQakYlBXQFWRjSRnL0xtkirxcaKDuoliY15QskttJdI65/hzR2TlqQ1
 e6zNAgJzn+zR/GxMNA16o6AwO1GtvN2SHGAd1E2ge0aJyrVbTf1IJGM6sX+cQ//STPRWQLeZfET
 2PDEi7wA0nCJjqH2kdmVD0RtXuNb0tRaywRxEcIqDCWbDdR6YGUNVk/ixMIfqZDr+vilFGUTg3S
 i9XRndLTE0ar8GsVpiZhozB+LjzqwA3IpJbsQ==
X-Received: by 2002:a17:90b:384c:b0:39e:4c80:44bb with SMTP id
 98e67ed59e1d1-39e54df6c9dmr13610115a91.30.1789928037608; 
 Sun, 20 Sep 2026 11:13:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 05/33] bus/vmbus: replace SMP barriers with C11 memory
 fences
Date: Sun, 20 Sep 2026 11:09:57 -0700
Message-ID: <20260920181347.747210-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The write barrier before publishing the transmit index becomes a
release fence. Nominally stronger on arm64, but it is immediately
followed by a full barrier cmpset; converting that to a release
compare-exchange is left for the rte_atomic32 removal series.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/vmbus_bufring.c | 6 +++---
 drivers/bus/vmbus/vmbus_channel.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index f622869974..31478d3bfa 100644
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
@@ -158,7 +158,7 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 	RTE_ASSERT(windex == next_windex);
 
 	/* Ensure that data is available before updating host index */
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	/* Checkin for our reservation. wait for our turn to update host */
 	while (!rte_atomic32_cmpset(&vbr->windex, old_windex, next_windex))
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 2648d8e3fd..10293f59be 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -211,7 +211,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 	return br->vbr->rindex == br->vbr->windex;
 }
 
@@ -229,13 +229,13 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
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

