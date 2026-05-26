Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C969CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4E2F40DD6;
	Wed, 27 May 2026 01:26:17 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 4B40440B8F
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:11 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso3066083eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837970;
 x=1780442770; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeOpC7d1PRzg9NYlS7eKeuSdURhoXbXJ6RT78c2vlOU=;
 b=P3TvIjLSKPOe0w4CSQpSMBRNTnJ75OQwLPH7mNhY6/Q0ryYNOiWl0MlNSF8gh+OZ4/
 SdE5rl8TmVQ4uE5wZ8lpnMpiYwsNqFYLvzvOG13r/JOeNSEcBQFws21EsQ52VZQsD1TA
 pwtbiHnKC9AieTj3psqjza/H5V3XeL/E0tlGroucxgRUVwNlEIrFIFvP1AaPRhIN5Oy1
 PU4IvooSG0Dr48byz+cfdjfD3Qrx3Bf6ilq3BZdZF31XuELVXtuPRJE2vAlltrFY15LB
 CEjYUADurg4t83G6/oKJF2+fv/5awKA5bIdbWwgA/qxpCFxqCKb8mtK5RW7KMMsc+gBm
 7Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837970; x=1780442770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeOpC7d1PRzg9NYlS7eKeuSdURhoXbXJ6RT78c2vlOU=;
 b=kJdUKTuf1NjbiEvmJNkVCLOpV2oxfqNwogjtbdb1d7ATu4Za5ARCrS+GRJ8+iqvZy8
 1jAYuTr95YIkAHzyDxrIKt7Ie/mp8aJtgUwzs9rjOWq/9BjQRnbmMyKz4wzZ0obHIme+
 deDFxEZycuE/0hBhDeIK1OPvCeaPaC6WPgbtola6+Ttx/LmZ7P/RpmFDSHCTLQxt4CZS
 +gmL/zbfUHMj/q9SRPV+9LRgMnTFFJijxXihfJhAaeFDDF9jHt4ZXDu/eqwSG4dhd4B7
 ynIVZ80y/TRt7V0DRWiFagLD/5wOVzZYe3DqPTWGMvrym2XfudBXarwRfo58rTiGRsLp
 3dYw==
X-Gm-Message-State: AOJu0YySiuCQonT7fRKX/tGuj7IINrKO07Rl4+IUxhLsWx6tdNibX/Mq
 dbA3L/6COREpxNMBaXk66Dc7SZY4CVF8IDx9wNAkN8KEv6dnwUWkglL1lJsE5PZ1M1shtcD+zbO
 zJWX4
X-Gm-Gg: Acq92OF1i2Xl2kUd+ZfyUdB1dJRF9tn526Nk4CSJ4WcDa1l/KiN7+41iH32yR/WZ9h8
 NVEAJ1s18E4EOwA2iFblDFHfM5dWZRmWCh3aajIUG+tD31Sr7VyYDFJ0zLrRaoCPtv4aOe3FaOY
 oclQIFLyRAOvnfubcLKDQMA5dNRu7/vc9UP8sGFTPypRvXmz0AkzdGcCedre0+UtRKCsBdpBeKk
 0TMocqoSxT3M3vezRXLj7/EFU+VesZOx/UaHvmOe5A47gWQiPKKrzYCu52/9/4E3PT9lV03JH+U
 V+4E+H/1KSWtg8J2ZPqin25CBfpZxn3HtA6CHaoxyINWYxqzUSitXMQh8eo4BhDVcUrH0u0t/gj
 CjJK6fjmth31LeWT7h0y0xBd63qmWkxRJN3C37iIveskIOwr5aSbQAc3PBjUV/8hzfnzyP9tdyq
 +OnLI92EuOSKZZCjrvhPoFJih96G9kqI3ikPpc2v9w4jQ10kj/gfYtinP0T6o2+A==
X-Received: by 2002:a05:7300:b54d:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-3044902c3damr9941293eec.9.1779837970336; 
 Tue, 26 May 2026 16:26:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 23/27] net/txgbe: replace rte_atomic32 with stdatomic
Date: Tue, 26 May 2026 16:24:13 -0700
Message-ID: <20260526232542.620966-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

The swfw_busy flag guarding the AML SW-FW mailbox is a one-bit lock,
so convert it to RTE_ATOMIC(bool) and replace the legacy
test-and-set / clear pair with explicit acquire-release:

  rte_atomic32_test_and_set ->
      rte_atomic_exchange_explicit(.., true, acquire)
  rte_atomic32_clear        ->
      rte_atomic_store_explicit(.., false, release)

Acquire on the take pairs with release on the drop, so accesses
inside the critical section are synchronized between successive
holders. Default zero-initialization of struct txgbe_hw still
gives swfw_busy = false, so no init site needs updating.

Note:
The previous rte_atomic32_test_and_set return value was
inverted relative to what this code expected; this patch
incidentally corrects that. A standalone Fixes: patch is
queued in net-next.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/base/txgbe_mng.c  | 4 ++--
 drivers/net/txgbe/base/txgbe_type.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index a1974820b6..c58e1d6589 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -185,7 +185,7 @@ txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
 	}
 
 	/* try to get lock */
-	while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
+	while (rte_atomic_exchange_explicit(&hw->swfw_busy, true, rte_memory_order_acquire)) {
 		timeout--;
 		if (!timeout)
 			return TXGBE_ERR_TIMEOUT;
@@ -266,7 +266,7 @@ txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
 	/* index++, index replace txgbe_hic_hdr.checksum */
 	hw->swfw_index = resp->index == TXGBE_HIC_HDR_INDEX_MAX ?
 					0 : resp->index + 1;
-	rte_atomic32_clear(&hw->swfw_busy);
+	rte_atomic_store_explicit(&hw->swfw_busy, false, rte_memory_order_release);
 
 	return err;
 }
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index ede780321f..d3c82d51a4 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -880,7 +880,7 @@ struct txgbe_hw {
 	rte_spinlock_t phy_lock;
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
-	rte_atomic32_t swfw_busy;
+	RTE_ATOMIC(bool) swfw_busy;
 	u32 fec_mode;
 	u32 cur_fec_link;
 };
-- 
2.53.0

