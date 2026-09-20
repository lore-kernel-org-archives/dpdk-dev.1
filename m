Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5925CC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B641440DCA;
	Sun, 20 Sep 2026 20:14:00 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 10AE6406BB
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:56 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so1995172a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928035;
 x=1790532835; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xe9TqH1KWaIRFShQ2jSA3iMbD0dc1xg6g18+WpJzlaw=;
 b=VWllq9Lp5HX7V53wPpEuviA2ne09zJbwmWSX3NxD+M/njR9dlw7rn/1qZbOnNfkq5B
 BtURkT5g+xqs0e1jiD3Iqds0Aqz6Zqf7udd+z+JuGD9pDjkO7TrbtYskVNuFTQeJbl8+
 W7hGm7eQ6IwjcHpBip9a8/nxChsBxGf4+QyU8J+Ef04mLnf2iwoTNNS0GSR4v0Oh/Lxl
 ZWbN4T2CB1bAjUYrTsARL6Hw4xa+u3y8zyLDg0Yy51ZLx2a+yNeZFxAGVsbepP3dJLDi
 bMdCPornwdsrw6AAZFCYmZqvBvqUCa3YUzDxyXn9mqp9bgtCjLoApfCSoARPhFgrXHea
 m1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928035; x=1790532835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xe9TqH1KWaIRFShQ2jSA3iMbD0dc1xg6g18+WpJzlaw=;
 b=YjIwQK65VLIq7aq+xOazPv8EdiVChzCYLH3mVUl33q5ybMgNR7VEnxZ1aigRzXYhiK
 WrMAKi5hI/i4Q7OB4Ke0bPsWV++29pRYC4IGQ9rU8pCA7xTqQzh6oVOwE/e3+gGdfAfr
 sO2veemLnoFwBCdOCKXCrXN0YrU1yjwpU6/596UkCMkihec41K0sh48CCgeC4/Ctpg7a
 eNGP0LdmzVylOApi5kK3s1WtV68HBlt18gZSOuQvONybk7Piyg2hhf+O/4u4N2hj2sun
 d+wapYf60IQXGIHI/qVbqCf/S4RuE9Dc6RoqB5IjF1omrqh/bKV7T5JaLrj6GZhyu26E
 EPlg==
X-Gm-Message-State: AFuF++nKFHbUhzH8JcDiSUnvdKJMlHcJoHEWQ2C38AWbc1+WzT/k2QYv
 KEKNtET243YGytxHKy9+TsKwkxATjLZbODTe2oOiujDrdL1RRPJHNyVjrhN5x2Fr5Ozh/R+TKyM
 b72vE
X-Gm-Gg: AYBFou2z1UGu2bDGto19CFMYHX04zKqizBuXs6VwKhp5LUTPZSBCoaf8w+QTH1/lx3h
 5xuERS5Oc3K622ilVNgwOfycVvQAQWalXANcu3AQUVlViQvch996eLbKf9/KPLkyaveenvFLb0Y
 5rGWA6wF74fDjd4pRQY+mhZSY+3EQcGU4PgK37L1P+JX9k9VMOaoAvgi8gELPoTodG/hDheOz78
 f2g2dy5T6PJ5zlLxJjb3ORWNqBEXrzfzKBOpufx2Xzmb00jH1XvQgZotdstIuGVkWRFKuc+97fi
 QlUNd47uqiYwOWIe/n4IuMInNQI6/uJ+DDyFwIp4W60xubYmCUjsdbKlCN/tlYI8YE/aHW+TzYV
 N7rCDW8Vsq5f+PxkI4CAuxAWZb8J+kp2oisDBvF2o4Md5Cr0pdHAbAx8WILlJ6FbTjI4vne48xy
 wMTEJ4Pe4LLbVIj2eh/kmLkdjaFjcPB+ZGI6PFBZFDFG/9+4vwru3OkBNHqLvxLvI1ZXiFae6Nm
 YCWqK+cUqcECxTD4gG2MhRQHqIKIxWzgJR2pw==
X-Received: by 2002:a17:90b:4a4a:b0:39d:f253:5fc4 with SMTP id
 98e67ed59e1d1-39e54c9ad06mr14130803a91.17.1789928035121; 
 Sun, 20 Sep 2026 11:13:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 03/33] bus/vmbus: fix ring buffer ordering on weakly
 ordered CPUs
Date: Sun, 20 Sep 2026 11:09:55 -0700
Message-ID: <20260920181347.747210-4-stephen@networkplumber.org>
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
Reviewed-by: Long Li <longli@microsoft.com>
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

