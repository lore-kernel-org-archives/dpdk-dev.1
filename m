Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A345CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 374504064E;
	Wed, 14 Oct 2026 00:35:00 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0CF3E40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:34:57 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e82462a3f1so2096705ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930896;
 x=1792535696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/mdh13ZWAWINO7CYDkTjZrVibhR2+kLukrdjLrzOkTQ=;
 b=nl92r71onFPvHw9cvlb1mUm9oOlD0c+Hm7MnziBeS6mF6X97D+1Q3CqIiSYzfSAPrD
 WiVJ7kCmaz37ZXk2nwzu60DTM0Iu/Cp6sZLJl3CTnBmmwvhXV5ZYP4BHl3+DT4b53KJ4
 0Z81fj6cREgjUnXdxWG6wVH0yHW6/jMlFng1wLzM/RMYymkj7JT1KPUXSLuKHknxi81r
 SnqMT/EJ+SPqJwRpdzqhb9HagBR7UwgIE2gsh8hy8xhGEk8jxWpi8Bgy0Poh4x6p1AfU
 rOxPo6FnYMUXk8YQj1MeID4cApT4Aah3hynmQweeFx1klcd7nUY2o1Crqua+t3tE9eYq
 HUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930896; x=1792535696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/mdh13ZWAWINO7CYDkTjZrVibhR2+kLukrdjLrzOkTQ=;
 b=B3s93fQAhaXgRUjyBLEBPfkfJ8y7x/s2m2vbeTlzE8m6o+0TwK1B4IQPn/P5NoF2Dd
 ASknc+xmQ2uws1MLi/il4QARHj3doMWW9n7fr1rUr5yZhtAlmpexCBF2zBZmTxhDEXs2
 p8iAZfYjTszXzTw3K2+y11Dvex4gJPTkRvRXl6sy097iTdpzTMkKoYaRAwFMfOIfQxRZ
 4H6gosoc0AuaRjZ2yiuEqhPGBnOR/cbK6s7tc9NG4RRf4uX4vLXKqufWwqYll0tcnPmp
 M4fRWFg1fc5U4B1R/17S2HPWzgcuo+r2Eo3QKk2izwYUP4uixNLfQ1ztcKqFuEitwq+d
 E8Wg==
X-Gm-Message-State: AFq9FYIOHdwwciUdmvhx1HiAxOWgaxW5C+0gpnHVv5EEYnISpaal9IPk
 2fpf/biuFUvx2/zByQbJkZSjE8NpShlBOe/6UIiUMtu67efFa5LUs2BDOpgxfCDFp0YOCbbH1fE
 /6dte5PQ=
X-Gm-Gg: AYBFou2y+SBXtr/DVHKxepckoSB/rCnIAfOnqeZqe2Q472BnIF4q1/D9WY4bpnpBTwj
 WNI4D+mkrUcciIck0/+4W60ccOKfkLhy11ev9QuGyjyqK/hkV4FZhTZZF8BpwyFxcfMFwbc1WMF
 Qyxq/+k0pmAgDJp09cyxEOMNZqwUENh08ITcgmnQXCHzLo5vh0Lzm9elhqBy+F9APw+AomgyQ8P
 xajA9Z7JU3HCVQaqeZEmtm1ocooKJb1G8euSo0amAM+nRUjS9TTkul9kSTFhuo39FHhzjk6vAJW
 MtNkaF+PgJ/GIzS+dafmL6d2kyeQORFyHhLAXyiMRknlOcNF4H9aTqV27hUs06F+oEaCiy5xZ+e
 a8QGSh0OYCkCRXftVT6QHTYr3tANbIg4JLtfLSKpogC8TRfqwZW4QzCjHDDGjGzlVrFKolDOVCR
 ASXV6gAk40BHquH2+zCbeLdVAtqfwHJrYg5yEIEreTnYoDNKfu0aAk7cT4AvPscbK6bRYYNU2XL
 7HA47Sxmjdt8ajaAZKUlbl+RPH3Oa2GsACM+g==
X-Received: by 2002:a17:903:19e8:b0:2e8:79d:15ec with SMTP id
 d9443c01a7336-2e84280afc4mr126198165ad.6.1791930896098; 
 Tue, 13 Oct 2026 15:34:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 02/29] bus/vmbus: remove packed attribute from ring buffer
Date: Tue, 13 Oct 2026 15:22:15 -0700
Message-ID: <20261013222410.2257622-3-stephen@networkplumber.org>
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

The attribute came from the FreeBSD structure this was copied from,
which ends in a flexible array member for the ring data and is
asserted to be page sized. DPDK computes the data offset from the
page size instead and never declared that member, so nothing is
left that packing affects: all remaining members are naturally
aligned and the layout is identical without it.

Byte alignment does prevent atomic access to the ring indexes,
which clang rejects with -Watomic-alignment. The write index store
in vmbus_txbr_write() no longer needs a cast through uintptr_t to
launder the alignment, so drop it and the comment explaining it.

This is not a fix on its own, so it carries no Fixes: tag, but the
two ordering fixes that follow do not build with clang without it.

Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/bus/vmbus/rte_vmbus_reg.h | 4 ++--
 drivers/bus/vmbus/vmbus_bufring.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/vmbus/rte_vmbus_reg.h b/drivers/bus/vmbus/rte_vmbus_reg.h
index 6370a07f95..210328c877 100644
--- a/drivers/bus/vmbus/rte_vmbus_reg.h
+++ b/drivers/bus/vmbus/rte_vmbus_reg.h
@@ -69,7 +69,7 @@ struct __rte_packed_begin vmbus_mon_page {
  * Buffer ring
  */
 
-struct __rte_packed_begin vmbus_bufring {
+struct vmbus_bufring {
 	volatile uint32_t windex;
 	volatile uint32_t rindex;
 
@@ -111,7 +111,7 @@ struct __rte_packed_begin vmbus_bufring {
 	 * page aligned and starts at rte_mem_page_size() from the beginning
 	 * of this structure
 	 */
-} __rte_packed_end;
+};
 
 /*
  * Channel packets
diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index dcd66390a3..b49725da3e 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -160,11 +160,8 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 	/* Wait for previous producer to publish their windex update */
 	rte_wait_until_equal_32(&vbr->windex, old_windex, rte_memory_order_acquire);
 
-	/* Publish our windex update; prior data writes ordered via release.
-	 * windex is 4-byte aligned in practice (struct is page-aligned, windex
-	 * at offset 0); cast launders the packed-struct alignment-1 attribute.
-	 */
-	rte_atomic_store_explicit((volatile __rte_atomic uint32_t *)(uintptr_t)&vbr->windex,
+	/* Publish our windex update; prior data writes ordered via release. */
+	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr->windex,
 				  next_windex, rte_memory_order_release);
 
 	/* If host had read all data before this, then need to signal */
-- 
2.53.0

