Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1BEC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B20840679;
	Wed, 29 Jul 2026 19:57:26 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 4D65E40647
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:22 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1326066a91.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347841;
 x=1785952641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1I9zQ1bEizYnbmQuUYX7/Bcbd4uHKRrLbvTayStbUo=;
 b=t7LSZZMqb1tJXks+NNjpGyNY1FsXQgSbJtAEQd0FcfnrVEcGDFjNeZ2HyeYCdSdE1v
 iBuJ3GF1Xq/9H8rxHerufvX5E1W9JvbglMrCIEC5sZ1Gv7MFxhA6LEIGrP7U3/84GrPI
 mW0FX0hcaycT84txbSZN1vW3XW+3YpvyIv15rfZ75LjkGBl3jM9W1csbDutmYyBLIJcP
 xj+fAmSN5wUoHz9xy+P+JDCxyC2gwi046ZieJVnvl6hOTbjv3ElirxefMpy3vnGKn13A
 7GvHWbE+jI9nXdxlMPWxCxP3C8b7Yi3jT9iRE5u7VwYoYCS2nHgPj8G0c8vJrAluTolX
 2ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347841; x=1785952641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1I9zQ1bEizYnbmQuUYX7/Bcbd4uHKRrLbvTayStbUo=;
 b=FecoIlhye553UjrO6bkq0cqbFPxC1bGgSb7yXqZtVMdY0kKnpaISu1fuzMPaIz31Jp
 9480GlavBxA0B05mU6EVyJAtwH16rpvWfFH/45OtNV/TxcW7R/SAQl9KV8j/qD9sCxM0
 lnRqoe8lmPRvDDTRWCLW5bakWipNG0G3XNZMGFTDbLUE5Ljl3RXR3Gd+fjDhtfgAIo2B
 fPyBzvtizy3a/LZmR6F769OhpGdHDPRgxfmQMehajS0x9etg2d8n0xdfGiZ5a/6DGiEt
 ikDbu7OzbNP8XJMk0Fk13FGu2lmvduoOa0S5s0J52jw+z7AgTo6mDjdSohNG8L2K6ul2
 SWAA==
X-Gm-Message-State: AOJu0Yxz0UlErtJ2i39C8bfTsaJYDU2PmzFk4Xotb1eFucKUUltmS9rn
 Y//dtg+ALzW4CRgJZF0V21HZRNsfrx7fgAvs71RdAKQlAvuRk3jcKKb4Gi8WALYppJsNV8I36n3
 /0HOX
X-Gm-Gg: AR+sD13k8AZMePLo48jEbkS0e1xch2ZWlz/SVoIVbVIa2DpgwiaxagFTgZU7elp/fxC
 XAdNqui59xk3TvWQXfxEufhnnpbAPtCNZYO2t5/VS004yZnx7i86+ESC+mcsg6y3Vdb/+mcCu1Z
 IbTO3qa+jWnJmsSkyYmStpLjerSWmCzWLn3zvhE4kVpIYUn9qHNnd6Z+W9yLnIC1ThqRN/dAg2L
 xAADmPvIVpgwvE51uXlbdgKGSWwWJ+4mzGij2aQRWq6cl0RqdFeI7jf5rYNT2MG2BffqlD6Pqt6
 szBLxR7+y5FXAxnpCYOk/iZC2RawhsX0eATwZdbd7Mb63oKFCVL+W+erkhgHTM/Y5avIiYK+Pnm
 1T75FpMniKn2sbsl/X0be4IqLpPA+bdM8jRgQbvlRA87GiFLZzbZHfWLXpwGStBf18OPtVjMvIs
 eigiZpJmMwa/9HVDBCdA07s7IcZ9XOEtE67mcaXBADH41iA0dsxVSbDN7LIByOjRRf/YyX1p5bs
 kaEX62LWazZlBqaT6+c2fp14HDY+kCkwccadZw=
X-Received: by 2002:a05:6a20:a11c:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c8ba5c0303mr8687753637.38.1785347841434; 
 Wed, 29 Jul 2026 10:57:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [RFC 03/32] bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
Date: Wed, 29 Jul 2026 10:53:56 -0700
Message-ID: <20260729175715.165120-4-stephen@networkplumber.org>
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

The read index update in vmbus_rxbr_read() was only protected by a
compiler barrier. On a weakly ordered architecture the store of rindex
can become visible to the host before the data copy completes, allowing
the host to reuse and overwrite ring data still being read. Use a
release store for the read index.

The barrier in rte_vmbus_chan_signal_tx() must order the earlier ring
index update against the load of the host interrupt mask, and a write
barrier does not order stores against loads. Use a full fence, which
matches virt_mb() in the equivalent Linux and FreeBSD code.

Neither change affects generated code on x86.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/vmbus_bufring.c | 11 +++++++----
 drivers/bus/vmbus/vmbus_channel.c |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index fcb97287dc..f622869974 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -237,10 +237,13 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t skip)
 	 */
 	rindex = vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
 
-	/* Update the read index _after_ the channel packet is fetched.	 */
-	rte_compiler_barrier();
-
-	vbr->rindex = rindex;
+	/*
+	 * Update the read index after the channel packet is fetched.
+	 * Release store ensures the host can not observe the new read
+	 * index before the data copy is complete.
+	 */
+	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr->rindex,
+				  rindex, rte_memory_order_release);
 
 	return 0;
 }
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 6887fbad46..2648d8e3fd 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -104,8 +104,8 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channe
 {
 	const struct vmbus_br *tbr = &chan->txbr;
 
-	/* Make sure all updates are done before signaling host */
-	rte_smp_wmb();
+	/* Order ring index update before reading host interrupt mask */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	/* If host is ignoring interrupts? */
 	if (tbr->vbr->imask)
-- 
2.53.0

