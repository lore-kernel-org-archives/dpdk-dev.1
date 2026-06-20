Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF4CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243D640E2D;
	Sat, 20 Jun 2026 04:32:10 +0200 (CEST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0266440BA0
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:07 +0200 (CEST)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-80236b44a1dso5824537b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922726;
 x=1782527526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeOpC7d1PRzg9NYlS7eKeuSdURhoXbXJ6RT78c2vlOU=;
 b=axC1acQueFO/3FdxS7WVczBxqVbgmcf1CSZWE826qAD9BhICR7AzxZ4j0ATTufa7E2
 LyhcF7HXKmjE/Fq0Jefy+9PHVLD1Pf/wmIcW8O1JY5GPEjd+NtPccUm/8V1ry9lKdPxI
 9f0VytZEgzBewTxvAs5KzjduTISqbGQLRsP+3VYtohShGq5BP+NxN1VV803uvTlHVSfc
 R3PoqGf2r4B0p4otNHMndZeUUi4uiam5N35Ioezf0xNDvBgmwcoyKsMGUyO16+BXa0sB
 hrBml/AAzzhb0bqffDSt9zyXj9XwBKvUk8Ng0lIKvxFeOIW1WjAhTP+8G9v3hvjvPU4E
 NVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922726; x=1782527526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeOpC7d1PRzg9NYlS7eKeuSdURhoXbXJ6RT78c2vlOU=;
 b=c69EU2V3SlFG/Mj136oK3UswXGadhFkahJoDErZsThzw5GmcXvhubowe+dqNkS0zl6
 mpaClAN3spF0YAucXHm1A3fhcqPjo6jWxKMPlIFXoNsBDIosJoAxv7HTXt3BMgRrK+TW
 hQ5AL/SeueCSO7AInNiVx4m3PCk9EESYBrGxNOiQAGedoFAnXiL0nqpk8YIfjUv9Z8E0
 xosUqq9uDXq32hKHvboBXz3oDjj3D1llaHqhE2oybCRjQbu0KpbfBvgrpEVFVAjlVkn/
 yTLn88zOCUHvzMhz8kASrJuVyyKk65JiVlZbF9j9VWdyD71PAZas5X+SM77VP5c+NVnR
 VF+A==
X-Gm-Message-State: AOJu0YxQ1vaHFl6b/CFZlmPtXynPQRZmWVJi3lExTCVTbkJ05ozp5u0A
 2U9NI14PvxcC4ujsThCXxQ8GqpcNJC60UzJSLtx3rJvHrS93wTBsPDFiVXuvxtdRK1x3+8R6Nhb
 fY+KN
X-Gm-Gg: AfdE7clt91sPodv6p+x/BglF3evQoB+jQaINDL53dFGEWrAbilrcJ6R8k5tPvW7kLcP
 bEBFPPFdIT/RW0CzN5lMzg92j2gJX+MPA62nIwu1LiED5F+G1nYaqyUgIxXOMyzDeCEDehsC7VD
 ipQVXadJTtbCaGiu5VqD7A2Q1todINPdb882sRZ1rXDzLievQRFfF8+/rE9aOohIz7ZCbG9syhq
 SXuWf5nyfURps7VnTcU87IBM7dECmM9wLX5AtA37HsVLVf+pOP/CFvpmAvEelcDnBA3cq97+nEU
 ugFNplLTD9AKyhSyaquwIhtPobg/sVALZ1QO52AYe68Qm5sthURx8Oc8pom6QI4Y68J6cUTJdnS
 /GIqvYyNKUd4rYw9L7ZHpPn8CHx/yrALLvbjqSN8Lw7AYMljCBDfc9f3VsWQ0OARw09FAhTCDij
 ExQ+R6xlHQxAcl+WehEJOjSQu+avD2Nq1a0BSEWHm1MofmJHkTeO4=
X-Received: by 2002:a05:690c:883:b0:7d1:8eec:5b34 with SMTP id
 00721157ae682-80131aa6e3dmr66800857b3.12.1781922726270; 
 Fri, 19 Jun 2026 19:32:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v5 20/24] net/txgbe: replace rte_atomic32 with stdatomic
Date: Fri, 19 Jun 2026 19:28:45 -0700
Message-ID: <20260620023134.42877-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

