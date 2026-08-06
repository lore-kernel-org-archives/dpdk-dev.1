Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E5C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF13740DD6;
	Thu,  6 Aug 2026 05:26:15 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6672D40DD0
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:10 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1083750a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986769;
 x=1786591569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKP/fk8at5K5Dy2DFgWa8ygIz1ijbg73jIr/fcjfOKY=;
 b=qI50hSeG4FMgK8vgsmsRjh9iPDOJArpUFO3e0SWahEZGVvZTJKp3Kt8gdQs1zSSLui
 9ySHpelc/tQcSgDHZIUun/v0N/9NJu9WxUE0d+KUuLvcbKxf0VROYe58dX3MeVGwI3Hn
 KPe45kH/9npPQX8IVroiB0BnVAjpglTs/Dj5pCsLIO/QC0HMWQJ9RH6ouW8zYj4Nreuy
 JT4HBAoHEhRVeJ+QgMDh0joRP9zcUl81FHxmV6soTfOXFeqp10D3lP2tnA7ma2KZMVGn
 Mzk8SwmMY9/aq0qdn6yKVg4frLX+QWWqO7wn3sV3+uJ4im6cNE1vqAHnUSlGTkn7654O
 1I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986769; x=1786591569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKP/fk8at5K5Dy2DFgWa8ygIz1ijbg73jIr/fcjfOKY=;
 b=rZRp8HA3dpxXE/WpWQmI6ewqcaDs3l77Lp5GC2XNKMJhT/+8udkjTzJsN6VsfwDpOU
 C5zYnOnMqlv9gW+XOWMynNihm50h7pr7yjYYdtzzKkSKE4r/a+JE1+//9lHJQn8s++QC
 tkLdLNHjBWnsd13O4FZrmoR36GRmUcB1HDIjoKKu7EtOk66ynzqq0e1ZrhEEkQVrhWIo
 ErOydfXvL0+gErGKBJppNfn+fsNqBMsOqL2XEFVRgBRltNrPNltY4GN8E9Pzuf+0P9Ky
 nGeYaIHbVIyDLZh7mnbgehQjB25ppuOTgV0GlXuuWjNXOVuXodPMaJSqUc030ock5nWS
 sX1w==
X-Gm-Message-State: AOJu0YzAvOQy20KAQ6YPP6BQVPoKKDwt2GnI8ah5GlIcgs97A2B2dXTK
 LSX+GGKyhg6TX8fgkSN+WjGOCgPMcKMy4rXk9nzhh+aHTXJpyHrY+PrR8E5j8L4Wgc3FlyQovhR
 pC0VT
X-Gm-Gg: AR+sD115OkXu3Lj+3QbU29/R/CGz35INoLVPHBYFRXzC56mbjUp5Cc8FPuuCEc5nqdz
 hzsG/2OLhgOoeUnZUrUj7v19jqJq29OTmE786stvn20eVankSINutCrng/7FXJuWYxu1yp9F8QT
 nl0CzToGiqylQXCp1eAj2vGgDLdHja2SYAnSDnfrSUNkMMLwl6qTnB2ko93kBvt1kPCnyRMMjoe
 v4e4IQFEZEyhkxIgN8kevlxCE+H0w9ZO0SZpT7k5VtF8u7dGdyV6if18T3LKfLxQCPWqnLMkLa/
 5F20Jcj5uMhyrCHM+GRURP9HLT20CZr0KnQx3CHhMpvK2GMtjN0CdjYyWb51a7W9AgdU928Q10M
 1e8PfPdEPQyvis47JxNv0eQ6uZnV8RqTJmFrGhKkiHGR3hOg43XcQeEgS5Tz17AsWuJMGy3ect3
 PxjfWMIWadnzzQugcVE+ce5ug+V5iAMImkSErRH9SNm4hvii8bX8Z7SFeIDIijKMni+LQHqtcU0
 OiI+K2DM6rTK+ZnL7g2LRxBlBM=
X-Received: by 2002:a05:6a21:4685:b0:3c6:3c5b:fe5f with SMTP id
 adf61e73a8af0-3cb85df2a61mr13899296637.2.1785986769526; 
 Wed, 05 Aug 2026 20:26:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v7 20/24] net/txgbe: replace rte_atomic32 with stdatomic
Date: Wed,  5 Aug 2026 20:23:12 -0700
Message-ID: <20260806032544.21337-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

