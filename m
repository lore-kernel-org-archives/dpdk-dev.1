Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB9CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED787402E9;
	Fri,  9 Oct 2026 01:36:57 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id BEBF9402BE
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:54 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8874539bccbso2976979b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502614;
 x=1792107414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/mdh13ZWAWINO7CYDkTjZrVibhR2+kLukrdjLrzOkTQ=;
 b=P0B2A2GROCDfNDFhO4GC3B0frllNZhtuli+Yr41sZpvUntLVXJV/qrXAyz7GRxEjJW
 eheNZHONSpa2tDAQqsRu642MOjN7+acLCKW7OEMJvj+YfLwdQ8hd32a4oTwtuaYSUTN0
 qX8pY0ndlmWn69tVWFJmxQCB8j4J9D8I8661XCOzIfvq3P/JNZubsjLVPG7MdEbODTt4
 HUTNSkEVed9gW/P5XXnbVqlkSskBnlHzOqRbcRNoYGvJWuODXXR09nvhkCstCaF2jtpJ
 /txJ77hcH6KDbQwXxXxYzEpg8oI1U0LLGJ8MrSM4cbwdmBzMU5L0+eOpqltuJidaXeSb
 mCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502614; x=1792107414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/mdh13ZWAWINO7CYDkTjZrVibhR2+kLukrdjLrzOkTQ=;
 b=OPTbZ2/n+8+Lx7HcdPok6OTghqLRmUvGsw6MjxgP0smnpnPjj9cZ41XwB4saW50VUI
 GYY1g6W8wNiP0DSvY1DaLbcmXN1KHX4QlrGwZkBFdKdpLzA95JP+YTWW6hYEGWiBPpNq
 CdHxSwNEeJfGd1Ax/ipE8z4SM+UARHRN0zV6P2GsdaIVDQAWcQiHIiKbh1y2JkMNXynX
 m8y+3M/RqMLJYLRnVxs/WBvRE/67z6bJO3cV0UffUGyA64z/gOxA8uunwkVuxfdTsxPO
 jdtaPHV7X2O5+r4Y2vJ/rzIlFLz/yjutCquDoenZqDGoE+wG3MaseVP7P7CaIKM/xH2j
 k4Ow==
X-Gm-Message-State: AFq9FYJNqTOVZsLKZRyc0zpsfSuiwL3cnzHnkj8+e2R6F9rim9/jqFfw
 NvE0M2sNl/zVDWqywtm4QgJJ96nxCLZGDy160cVoELxRgCPxjsaw03kRpsHj9uHKAi2D1Q2n/6n
 qGF4NwsU=
X-Gm-Gg: AYBFou2Naq3JVJg4pCrq4noiuBVgQ+nVDHpLkaqf0ywOgt9xWpX9a79HeeLMn+FkFGX
 HOsaUmc4v82n9Jo7NzkUj1KFDn2zdMARTt/g9WFKAoBFTxiLDcEw5WZQsbkvpDB0F3RdN7Ik+7V
 0djG82DMxpG8CC9LzKcnmTZLdvI/CkXDkWHUr+gNrse91osFQtrtBGmgIF5es9jFJy+bOSQNPY/
 lfnC/2NvOfrdODtn3RF0kadLMWjUN6Njm7moeqfgH03b8d9vB2fYMIUDMdMHDaU96czHy3Zs9Gt
 4BOsHMY30kPtxsEybH8NfdoFZSi6RK8oeHuUPlD2vn2Ak3ZArkHCcamMx9kQG2od+hBlLLYwftu
 NRWANGUJKkwobiO880CJsxMPEsVwLc9W5z3PTM4GSiSP788TiRZEV/kEq2FV+Xxas0P2N8myFkm
 j/Np1k5c6ZkwK0D4iQOVVcDQBfekidmf0CNKV83ktWlzcyGI6Iv70WfeWjf1EnGKpcJjgwhLfxa
 5iaN769V/AXtLsdnCpwon1FZ+APPW3LrCVzYw==
X-Received: by 2002:a05:6a00:22c7:b0:882:89ee:a898 with SMTP id
 d2e1a72fcca58-897c7fc3b62mr45707b3a.46.1791502613921; 
 Thu, 08 Oct 2026 16:36:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 02/29] bus/vmbus: remove packed attribute from ring buffer
Date: Thu,  8 Oct 2026 16:34:55 -0700
Message-ID: <20261008233649.1260843-3-stephen@networkplumber.org>
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

