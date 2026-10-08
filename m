Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA7CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27A934064C;
	Fri,  9 Oct 2026 01:37:01 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id D4066402E1
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:57 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-878b44611ffso2790659b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502617;
 x=1792107417; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wV3uRDjDKw+4gpUNqDku6XevfxOokDYpE3PMKcchHQM=;
 b=kacX6FLUl00EYbgG4sB0AGkz3HtKwTK9wsfoZGCMObuLoyAnMWQQ5PD1/W9qguf8vb
 PvSxjHGJGHN8OrC4jXCwPJ00gTodxfDNRK//52sliMk8pYgC3LqknEZrkX4KuWGYvTfJ
 p3sso8Y5thipYkxT2U7equ5mK8/XRx4oC3sUFDiuohw+lhYHhwRMeD1fz5j88KX5zMEi
 wwps+3t/3DUFgm0TDWlh8/Js2TDyi+Uy3lkDmOtxvLGhx8QhHo41dMkot32Sn98UuuNi
 aNLQ14GE3by9afw0T70ZXjcFOmbkyWsyC41aScLXW2kxB29qxswIC65sy82Posiw1bho
 x+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502617; x=1792107417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wV3uRDjDKw+4gpUNqDku6XevfxOokDYpE3PMKcchHQM=;
 b=vjRb6vEFtjRkLcz6lcLiraVbUphUwEmtkFzWSREgq4TrgN78lL7wycXow48dgz3mNR
 slBt76SBy7sl62oJjL62SnbOrVM0SBXL+DQ44Im6eKAZWtBjJ7x/rwycLpKow5Zw9qD0
 xoYiyPCT1CrMR7z7djS0YnAwaoQ8NqGdO52vN1chjNqs0VQVmms+9Gy9pV5nHpfTrekk
 cokcpRJwpvkgRaBsh6f2RUmX6AWggh0B14/rI5TsQiVYhzgbW5JeSsbXoshFidCbVwta
 6ot7y1lNYFSY+I0YC3JTXbgnQ5V0nQJ504KyYNwV+GhfiMLp7qS60rMi2v8VRjwaJhKv
 ksyA==
X-Gm-Message-State: AFq9FYLeR3+i52dlxCTixZQ5NtEfBKG8tzOZf6xq6EEAjMGp9arVu9rb
 w6JuvbbqvxSo4Jp5+LH9VwkLAl/PPqns8WdVgvj3f1RNtIUNCcAH6862qFwJwIcppNzq4erwFnU
 s24gElis=
X-Gm-Gg: AYBFou1hI2zTHnpP8E/V4Kxn5ILeiTAXOWY+7EMpE+wd2sWRZ1ujw9NWCTzfdURyPFG
 YFejxH6jymiOnMm6K+PT66yyVeajYO2kFkUv8LA3ctZZixs+IqI1g6SfiGBV2lxoOtTaiYx0WjR
 kRjuWU+ugFbNYGnRhRC3WSV6VhHY1sIIscRDq/kQt7vx4fhsWfhoqqj2jry7SV/VNcuwNxf+ryR
 PVkzQg2EwrHYnSmQgrhWH6pYVWul9mPXhlckgXEET5lSgVSx1rHLhomM1vUDG/jKv10ozvAPVpD
 fpuI820gHdHdwYQTU9Y9+HHmM0RlJuMJsJIz387YnuSrlgKJ3hsvC/reVfaaxWiGjwDQT59VTAF
 1/twmPCHXgV5Y8k6j5PRUQQwWhUjBHYU3nWTBheFxhM8GZ+QH4qAXbk+7bN3PGfJtfxh9inBjjk
 0g088dKBayZ6abwALKKoxaE7ZcnOr2/B+t1U2cvcv9J4R2And8URGYRcJZdh1VMtr6JcQxBOJUn
 X96xNEqSalat8KZIu3t1TfNLkW7WPdktfzlWA==
X-Received: by 2002:a05:6a00:2883:b0:881:f152:3861 with SMTP id
 d2e1a72fcca58-897c701055bmr55990b3a.25.1791502617045; 
 Thu, 08 Oct 2026 16:36:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 05/29] bus/vmbus: replace SMP barriers with C11 memory
 fences
Date: Thu,  8 Oct 2026 16:34:58 -0700
Message-ID: <20261008233649.1260843-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

