Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD97BC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B576140A6B;
	Thu,  6 Aug 2026 07:10:32 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2F03E40DC9
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:31 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1169981a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993030;
 x=1786597830; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BPuQF2uw1+t9JN0vsDgm7SuntVqOxxMTyT4s2P96GmM=;
 b=rCszEZUMmbP5n/YjmChu8irsP7BXReTu0va+C/gvSNk9poUVibwFYnmw17RvIXjet4
 P1cuchUA0BSiR8sZjGaPYKZFWP6aQ/H5IuQW+kvKuPBEN/ysaAma48fjVqc5DQuUbU3e
 lxnUAWFNCcaJ+G/VpfB5myh4Rtb4iC47U1pVTpoIAroEZW6dPV7oRAK/9QT+hjqN5WwR
 WHyC3eh3kUeRkCN2RYPMOkCQQ/51A2giXfaWl+Q+ex62EQ9+d8kWspSaSLLxKNhTupjo
 YWIYvXL26eELHiO2RSNDCVrsm/3Ij4wAkK903LdbIZ/jgCEEjlz1U5AX3QLk6KAuMYjb
 gEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993030; x=1786597830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BPuQF2uw1+t9JN0vsDgm7SuntVqOxxMTyT4s2P96GmM=;
 b=YWRgkMuyJXku7PmneUtD4f/xgRqxeNpGn6rqjgVAe/9HJIkWycHGWHDkRzmXt2AdRN
 JFrX6vTfa2JfTPuGjLO0ybLKB8uz21otdaCSJ8XVeGGQbOoeBBh/LT8FC7H9WdZ6kPh/
 1aXuvb5tHN0bx/92N7QQdvitAeyYDc9NkbL8Eej02y+zIu5jYKlRfG2YWUfHXsBlPdjw
 6NZXxqrZWwhIMJAB1M5Y/Cjv4m/WP8icZ4wl8XyIJK+4AbIvqZ1GQmvVxDvkvF5DLiwH
 a3TKtuE5YPbyl4P/pAy6ZGPtImslOGddsTC5IUnacl2f/SECQVtPjVzdN7HQP9whgpw5
 iAjg==
X-Gm-Message-State: AOJu0YynTwvjG+HRfhy0S/7qbOBiemlE7PX1Hv0oSZp6SBhEujMUVhut
 Z1V44jGiqdh078IgmLTcs6+s7inpNrt3QRjgJ/lkCxymKdVcH6O6lW57c4HL2AMfiIXOvxbT1JN
 kwFHSRFY=
X-Gm-Gg: AR+sD13ISxohMWMHl8PQDO8tpIgc5TbABI4pxEtB/VISfJFaAFbayiram6/B0EyEqdE
 7Z+IxUcUY2BmEgK103WwM5j02M4rxjG5J2Nbj8FJFYDzoYswfv4x7IZ8U0wHJTQdeUj6iyZaiA7
 fFL7mAuLRVyNYmq30lhS7tttoZ1AQ35kQ8wsOzlHr2pB5w8bwR9Om7NSgcqJVNdEXPVhKKrRM7r
 dCM5sbBpOjH4gStOJy/59knkf8er4SgQ6daP3SVytjQcbFw2VkltH/GI7xHWQlPdAGSwghEAtGG
 niuWWgURcnEITs3oMSa2fgAK6yOR44ma0QpPLVGI9cqydGeIJaCYMX77msV+8NRBCJb3U0uQkxd
 3sywaSf4EzkGIoWrK6pGVLxoJvbgHvkPC3ogM4jApat0OmNLv+rL9hYStiy5Qm17bmX6TJZwptt
 vicQnK+ln9GwVEUV6GxSRWRNLGt9p5Fp8poVCRf2+aS+lB3ihXQ6u6AZk0EqBSTl16Pl/Cf5U+l
 m1k+1ew10wXr9fmRKgZOJRSIBk=
X-Received: by 2002:a05:6a21:e58c:b0:3b3:241f:66c6 with SMTP id
 adf61e73a8af0-3cb85efbc8cmr16182349637.26.1785993030324; 
 Wed, 05 Aug 2026 22:10:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH v4 15/23] net/r8169: get network headers
Date: Wed,  5 Aug 2026 22:09:09 -0700
Message-ID: <20260806051004.166778-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

This driver was getting network protocol headers indirectly
via rte_ethdev.h. Use iwyu to update to full list of includes.

Replace POSIX/libc byte swap with equivalent DPDK function.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/r8169/r8169_rxtx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 00de0471f4..5786624e27 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -5,21 +5,28 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-
-#include <rte_eal.h>
+#include <stdbool.h>
+#include <string.h>
 
 #include <rte_common.h>
-#include <rte_interrupts.h>
+#include <rte_atomic.h>
 #include <rte_byteorder.h>
 #include <rte_debug.h>
-#include <rte_pci.h>
+#include <rte_log.h>
 #include <bus_pci_driver.h>
 #include <rte_ether.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
-#include <rte_memory.h>
+#include <rte_bitops.h>
+#include <rte_memzone.h>
 #include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_prefetch.h>
+#include <rte_random.h>
+#include <rte_stdatomic.h>
 #include <dev_driver.h>
+#include <rte_udp.h>
 
 #include "r8169_ethdev.h"
 #include "r8169_hw.h"
@@ -1535,7 +1542,7 @@ rtl8125_get_patch_pad_len(struct rte_mbuf *tx_pkt)
 
 	if (trans_data_len > 3 && trans_data_len < MIN_PATCH_LENGTH) {
 		udp_hdr = rte_pktmbuf_mtod_offset(tx_pkt, struct rte_udp_hdr *, l4_offset);
-		dest_port = ntohs(udp_hdr->dst_port);
+		dest_port = rte_be_to_cpu_16(udp_hdr->dst_port);
 		if (dest_port == 0x13f || dest_port == 0x140) {
 			pad_len = MIN_PATCH_LENGTH - trans_data_len;
 			goto out;
-- 
2.53.0

