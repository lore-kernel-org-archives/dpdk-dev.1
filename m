Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41644C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB91340E17;
	Fri, 31 Jul 2026 07:00:23 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id DBE0140DDC
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:13 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so446909a91.2
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474013;
 x=1786078813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKP/fk8at5K5Dy2DFgWa8ygIz1ijbg73jIr/fcjfOKY=;
 b=HkizXbdiayWKJlFk6t0WoiAJ/1pn2hrVXSZJpacPggd9VIRQGY+Z+GtO0al6i4sa94
 9UN23mTi4FXMH4pI73FJy3He5Aw0yzXVlb80x2gl7UD8Nl9XGYaDJvdTr4sToIZsD57j
 Ymli3UlSvy5mCUySEgnKnOeJ13qbf6Bi2FxW9ynlFqO+MAeuiqbRwmJpnhiVKSaF1faO
 9uLbrkYGyb+zI9QxA7WtpLZGfLbJcjEEtudNCjCGf9VFVEthdsB6T9ru0WnQPSJ2vVAl
 ZbE0/IqjKMebS3q7CJs8HWlDrLqZCELv/2QxiIdA6+G6NLhzxkoPqQev8QWvyYHzy2gP
 huXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474013; x=1786078813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKP/fk8at5K5Dy2DFgWa8ygIz1ijbg73jIr/fcjfOKY=;
 b=NbEJzcJdOth+jWzMV0uuCcrhfLFsRBjmcLrXPWThmYMqchDuJJSvwLVsl7Lb9rFegD
 SFA2AlnZO/tJABg0WdgSQ6yOxQWyeDh/zieN0af4NtKQNnzBO5163Arh1eX71+SslaHr
 vJLcMEwpmXKGG9bjeWbzxmpN/Y4eTIe/HoXtcMCksWSYOj7dGsd18/CIFP6Q7rU/G/+O
 H1cQRWXsuU9VeCPy8js7wJBgBNLShQUkXErJQyJULYtr8QJF7V5dnq6JcT1aayiWxcYx
 b13OztMTGwOleBzhnjXdcfzxz3KTc3qPYeoyb6sePJyxpiJu3p6PI3J3Fvs8jaPP4Not
 0E9Q==
X-Gm-Message-State: AOJu0Yxujl84qlpI/Wuhtb+IXr+zSmZLFDm0rT7DTG77azJ+9+WaYj1r
 P7Ghcte8Q++jC0vaZfA+vZ38eXOC5E6L0jcTwMpFokJtcrbGjXMAfPDz6xXRSRDqNbwoTV2WUs/
 z52QZ
X-Gm-Gg: AR+sD13uqQGnkulB52gEzK5kPBnf9nzw+pDSCDy3daEykCblAse5fmnwnv7dBd4RKDm
 wei4EtUwC6jUgdHmQl0PX4LLAlsx9MyF7bkzmZI63vl8FPyPg1SkW6XMtcC+b2cu4XGPQ66u6T7
 DH1jYNbmIdMxpX2INBFtTpkWaupSKRqePATShOq9JE52OK5FFM92ViV3ksECjUSI4xOBquM1/ag
 pj30TJgLB6Fd1oLFEBi6aZLoG3+r8Ofi9oL8duZ6RLIb+AVZqsUWrRdRliy0lnfXddpx0WXl+nq
 ueh4rMxXUyOhcscWNb0laD7PndJNlocn4exKdBkuBXLMbu27f1O0PSH8KHgkImoo9G1AKwSmsUL
 eDRce2LhvBqkBiUWU6PMqv/Qb9DhWP1t9p/M1Wtp3CLBNX1V+JUlquAbqTou/CFr/SnrRwHJ9VK
 +oTUSgJrOC0kfZkSW3/tap4dJ/Y05xBeXiHTjSezlYb6GcEo6KKZQ9orCtVpW0B5YdUQnYCobBB
 lPHZ6XYRHlUqFUZ8ZDpk9CGcQI=
X-Received: by 2002:a17:90b:1a81:b0:37f:9ce1:735a with SMTP id
 98e67ed59e1d1-38fb144ae76mr611423a91.27.1785474012827; 
 Thu, 30 Jul 2026 22:00:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v6 20/24] net/txgbe: replace rte_atomic32 with stdatomic
Date: Thu, 30 Jul 2026 21:57:58 -0700
Message-ID: <20260731045948.769926-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

