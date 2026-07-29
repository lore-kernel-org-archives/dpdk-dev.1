Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84721C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C4A406B6;
	Wed, 29 Jul 2026 19:57:27 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 83F0240144
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:23 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so1462397a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347842;
 x=1785952642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hl0zjZMva04Raq3K6JRrNhF2RoaTxheQRYdcSBAhrM4=;
 b=Ka33I/hm3BslesxvvcHC3CNox9d84kg2WtxEdV/HIwe5q9rBFla/3quxoMZknjY+E+
 lSNfF7NAXIUnbce3FDNAW9Xa8tWA9IHavoh7zBGPX6UWqetM5j8VOa8PXQ0NaQOLVWpO
 yUczMBY7g54GV6FZTic8hS4xSIqlQUYUVRRz3Yy3FOF18ZyUmwK9ym7CIqbtyjnN5Nc/
 efF6VMAOuGl1A7d48iCoaFugFRNBScOE4NxhMlOApk3yOJSRDmSRM/D6e64yRdJF6I3u
 gYZwFRKojbLHEz5fbQDj1TefcYeUnKgvqT2RZmXIPVsLDuYFq/buiQJyt1U++g1eFuWW
 N9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347842; x=1785952642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hl0zjZMva04Raq3K6JRrNhF2RoaTxheQRYdcSBAhrM4=;
 b=acBU5FvkmJregz1kSoRVynccCv7da2nOn5RyH1lltuEicYVSQbEpp2aIjjnLylsDFK
 btshe8vJbhx9RNLfx796Y2i3ulwZbwBsj21BzkPHu5+JSGzZTdSlE1Mpu++uQk/R4QYn
 RwoE2bZ78EGyvem00Yv9StVjKwnu03A9RA6FQKkBgRMVH+ZBbpAm1NVrbhDgaHe/Q2dL
 cLwQMlRbreAUref1mR5kkCq6xyrWWXKAvU9jBRLnt5PVPN3GQ5Jj/F0Ayn/nYvc5NE3V
 +NnPz6OXwjuciQ94dQuClSXUQUp1pYLTIZ2WzB1vwmyLLZga5ZFAH1gXLQUjlIiqhSXJ
 1i6g==
X-Gm-Message-State: AOJu0YzRwFNzjrcibsVg+iianw+XKqcavRhpgSU3p2AJKGmPVlYQlz+5
 tN004UP/r2T/SlQ8BXkpseznf5CAAmYgq3Ly4YeuSjVZIZ1uesHbggwCpjE9+QzpzTDyAMEEt1t
 GhIHj
X-Gm-Gg: AR+sD101OiRHVSDxY2DW+q8oLKCo6W1dGy20j7NP6YDYrn8rgFcSaa/wwxVBbTQ+hGw
 BRXfbUxDr1ipUseWCrxIrtSxE+D+ycuag9GNqEbmhE24ybhqIlPl+7G/DgzwPJZTOv/i1AI+C/e
 6LESCo1lyIUVn19flDrI7cT8JkxXNVAwo8izdRpdaL5PZwxzsv7T23rgOtk8LyVq49XBAiT3LaK
 +SoZ7OCerSLUHcCjLTz9Dur/bzpiXb/hNpvaOsl35o45igdWv7HEPK19FlvAvKLfySIl7b/N4Ay
 qwDw8Wtkhxa2Jp/a5oOX77nT/aAasyqqJylJ0cQ4V6fT7y878ZYzBEmUtc6R9PihgyWiUCVwZHu
 TtzHwBaN26aoNmcrPzUIszTkqTR6AbHeij6CtbLcoEUO7kANidcyyG6VZ8bnQEI95oUO8XSBB6u
 DO5lCp5BHfxSE7s/X8tSycMv2jZsPgV559IEfPhx3OMoQ5jAD3wLTCfXqszob1XPAE3vZuJfxHr
 D/+m2CQoFLl0p5CzcCjP9i0JBQ=
X-Received: by 2002:a05:6a21:6f84:b0:3c3:8ead:6df0 with SMTP id
 adf61e73a8af0-3c8b6cfe9fdmr8939803637.28.1785347842670; 
 Wed, 29 Jul 2026 10:57:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [RFC 04/32] bus/vmbus: fix missing acquire on receive ring index
Date: Wed, 29 Jul 2026 10:53:57 -0700
Message-ID: <20260729175715.165120-5-stephen@networkplumber.org>
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

The receive path checks available data by reading the write index and
then copies ring data. The link between the two is only the comparison,
a control dependency, which does not order load against load on a
weakly ordered architecture: packet data can be read before the host
has finished writing it. Load the write index with acquire, pairing
with the host's release store. This is the equivalent of virt_rmb()
in the Linux hv_pkt_iter code. No change in generated code on x86.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/private.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6efac86b77..aca5b534f9 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -12,6 +12,7 @@
 #include <bus_driver.h>
 #include <bus_vmbus_driver.h>
 #include <rte_log.h>
+#include <rte_stdatomic.h>
 #include <rte_eal_paging.h>
 #include <rte_vmbus_reg.h>
 
@@ -130,7 +131,16 @@ vmbus_br_availwrite(const struct vmbus_br *br, uint32_t windex)
 static inline uint32_t
 vmbus_br_availread(const struct vmbus_br *br)
 {
-	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
+	uint32_t windex;
+
+	/* Pairs with the host's release store of the write index;
+	 * ring data must not be read before the index.
+	 */
+	windex = rte_atomic_load_explicit(
+		(volatile uint32_t __rte_atomic *)&br->vbr->windex,
+		rte_memory_order_acquire);
+
+	return br->dsize - vmbus_br_availwrite(br, windex);
 }
 
 int vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
-- 
2.53.0

