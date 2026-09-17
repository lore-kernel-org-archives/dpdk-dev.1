Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660AC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97135432C0;
	Thu, 17 Sep 2026 22:11:47 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3FC224326A
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:41 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2dd77300825so400645ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675900;
 x=1790280700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfwpIzxQF3ORyR94Mn5NkNYKP96IVPCaCez9SQR0vNg=;
 b=MvQQrBHPjVhhQxnpcXOuYW5tPD5DzLKk+3Q9OpAAOJtqo/Y8CVUl3T77BTLYmFpw+v
 MlL1rPCSh1LyhHT4739qOMHXzfHGWLLaSCiJRXLo/4+5j/5oabid4Ncua6pa+dkeahw5
 +iv2cL3zli1lQK20RqiduvEmwn2eWzhP9yMI4kEb69OfvjI6Q55Q1YzGF1uHeUT+jdSy
 93Fxjk3GrvTBTNK2VoHT2AYLnjovS61v0bJ+ygM5AWcVkC5i6+SY4S0VU1D2IWCgzvrx
 U2EhYItwaY3p7GwAGxpEg9xPeBOGlj75I2jvZ9pVt21q63ZpQjY3aUr2k7TxmRvRIl+f
 AX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675900; x=1790280700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YfwpIzxQF3ORyR94Mn5NkNYKP96IVPCaCez9SQR0vNg=;
 b=dOS9cM67JqQQeYjo4oBPEUsB0dhdoY6slOYH934QC9coSLee0+xLfIBZjttDNHBgYD
 9Yx3dciE8fK5X+kH4PXvAYIEa0Vb+rKnfrvEJBngzBz4m7Yhg1ADTwp6TuA9EHPKFyfI
 TpvMnT/6Rm8SFhHOEBwTdET1BsfI/SKxFOo0zH312AijhwUrPvXujNxuCwfKKzI2QilO
 e3a2BPvyZdrADZ8MTNw6Zr/cWnzEH7UmUWUbFhMG3F93BtJxcoVTrXQnIisknnOAJJEB
 SmRKPlf0Pl5UxDEqk8M2zcz41mZGUXaoqBq+Ft/bCtnFDWtJ/TegRGiYbuId6f+8apr6
 HqHA==
X-Gm-Message-State: AFuF++kPuAUbBQdXBnyp6AL3JM6lg/kFXaZi7Nhu9+LyzfI46zUafIcY
 vMrMV7sPdxqMVcKzE2smfbwZiKknOCAMPfrM0nphNRGHrtyIf8G4cZSLB2gwCwbUe+11eLEhfxv
 KVoca
X-Gm-Gg: AYBFou2eAJdyToeXbR4F3lyOD7UCVuFtQ/q1nKUFOoLQJaZQyoPU38atKtnXE5yMH+V
 HqZSHj/5QwIeRqQ9AtSFGJCoqjr9ZNn0eRWoMy1xL2QCa4rOiuJDHxyR9+30sopn0Oc8/BtveoG
 Vg0zrDKQGJvfdwa93GO6bS7S1D8CKIohIwZOHIzeyAE0KYWzHhSy3Yhbg6tHIDMKyfrStD3FhMk
 zbiB+U7ffBcakpYG+YuJXpwuzfCZuvgW8TIMW+QYiQA2b6ESulRRTRRQJQdHkQIB6ZugErYpnWt
 eVp7Qa5QAEt1dhzwSNFNke0wFlygKvQY7sO+dcE1/0BKIZdSaDH9S8meKHKjacLaBKAwNx8aVMR
 fc5nlZTLqcE03cjABfXVyPGiKeuRcR5gI210Xg+TQIlTfRMkqnhxrw23HbWQsrv9+jqdtDKLarW
 JP/yGcv3nLybhXgCwvEmnalOrKVrlwRyKM7X4/r3BgwvIclmlEj3/0sXaV0Q3Y9oO1nd8lmEpOW
 Aas02RDAd7akhiooqp4XvSpowU+XXiz6sGgCQ==
X-Received: by 2002:a17:903:3c05:b0:2dd:4070:8eb with SMTP id
 d9443c01a7336-2ddb1b97f0amr5401855ad.20.1789675900211; 
 Thu, 17 Sep 2026 13:11:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v8 20/25] net/txgbe: replace rte_atomic32 with stdatomic
Date: Thu, 17 Sep 2026 13:10:24 -0700
Message-ID: <20260917201119.2168234-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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
The previous rte_atomic32_test_and_set return value was inverted
relative to what this code expected; this patch fixes that.
A standalone Fixes: patch is queued in next-net.

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
index f9b5cbe61a..5c16c4f07e 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -897,7 +897,7 @@ struct txgbe_hw {
 	rte_spinlock_t phy_lock;
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
-	rte_atomic32_t swfw_busy;
+	RTE_ATOMIC(bool) swfw_busy;
 	bool link_valid;
 	bool reconfig_rx;
 	RTE_ATOMIC(bool) pf_running;
-- 
2.53.0

