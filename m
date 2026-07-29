Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E9C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0101740A4B;
	Wed, 29 Jul 2026 19:57:29 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7C8BF4060A
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:24 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso803795a12.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347844;
 x=1785952644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o4vXEMYH5m/F1PYIlEpytbgB7qarIrmjnShAfpMvt5Q=;
 b=N9/ytPEY74+EzigXbzFfAJ3W3uNN/5DzmisF7AHS7NBBE/qoRKzhazqHQmNlHRlFdm
 V0SpZpC2JSvAreot7cqwsK5/fv4PCv3o4innpWwCgpn/1ZD5TVs9j7dCnviVkOpfPp0k
 5dT9HvWK6tfXB1/MWGF83ps4BoOh6Ma3YY5OJtPxLFghtQCCcuIty3fnyC6frIqCdREP
 r1eI+rhsatduNJ4nYXxgLZNPeafvr5JjVVLu9h2Y4uXP8fhJKvnvu6Aox6a1YiUDSkq2
 5wC4q35nxB+bIdstHbkyLBhJD5WiydUSGZmnrMCrkqQimpaUMs1DlCdMzgja0er0llQZ
 db5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347844; x=1785952644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o4vXEMYH5m/F1PYIlEpytbgB7qarIrmjnShAfpMvt5Q=;
 b=MDQZBHkTFggazG56DTyys6VbLWVpa+3dXSJCbOnhmjgTXifz1oKorpypvhekxHH4yM
 dH1RIVR6PlZVbi4KbjIjESVTBLj7hIweBJzfE9tLVmUJZiXRfF1qjgpFWRC1qM/Webnh
 HY1ml1dFEsi2/zOFZ8zFLJjd8avAvFBLQ3ZLRkVrQyFEMtHke0lMUs8b0+mS3AREREMl
 QWEVRZwV70Zr78N2EutkCK5OI71PXNOhLnQUj0LZal8YgO7y3+gNtYKvcbGpRfp2hMYr
 nP+JQLs8SizyCX7jNFhB58OHGqNCaKW5927Gmb8XlyansdE/QP2xe82rHt2NcI1b7UDO
 xiZQ==
X-Gm-Message-State: AOJu0YwgkfVWvadmZ90jaCVcqLvpHTmtkSU2ig9IJdD42yvLjEFyCIgA
 PDkik5dSRbnRX/AZryF8X/JkkB7Ck5U154ZYS+0atATm/exAc+Hv9g8ADfbfNKDIQqnQxYR+XAU
 FAQ3H
X-Gm-Gg: AR+sD12QT+2uVfR85X6fx0sXUj66IZLkUnroawRDgdp1PLxveiSPd6RUGFk1P9qcHrd
 VqsFcLhHXjBwnX1KZu6iEt9D+WT0LuDwY/VIiScCGWMOxaBxQbO0G0PNk4AJbMBn3zHyRak4gUO
 jQLBfXJnlVHh6ZWNEIK6xAQo8YfnRkR3swWL/APy77m8g9eB2PKbifW4dWkK1XQHsn/+Q/knLK4
 yWVIIEg+R0dNqsOaxNRLoAPFs+om2Lu6vrjXInZccNFs/ODg4gnyJulVMBB4A5lhhYO8hFeSgOk
 540ANECGpJ0Snq7dAYuqFPbkMZVBl9pb4n/XgPVlYAbBsCDjrCHX4s0yoQhU8c7bm5c+BtFtBBd
 sTWV4YtQe+s3U1o/G35IWr1+LFxAXHKBNME5c9l6/hGtcFvzwp0VnGJqRVql+92yHg6YtF+nFEb
 bHnCF8NaN7yFglcaQFvOiWR7ixfF4EJ+li8HxSUyoMJmoSc5ZIfEWa+QC2LfaLS6FZ9zfKfhKgU
 d4iszFKh+VZmwW0hlikIWuCC0M=
X-Received: by 2002:a05:6a21:6a0d:b0:3c3:bf10:419a with SMTP id
 adf61e73a8af0-3c8ba637b0fmr8730570637.71.1785347843659; 
 Wed, 29 Jul 2026 10:57:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [RFC 05/32] bus/vmbus: replace SMP barriers with C11 memory fences
Date: Wed, 29 Jul 2026 10:53:58 -0700
Message-ID: <20260729175715.165120-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

