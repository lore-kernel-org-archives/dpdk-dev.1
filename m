Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3CCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:06:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC3F4042F;
	Sat, 23 May 2026 22:06:00 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 77823402D4
 for <dev@dpdk.org>; Sat, 23 May 2026 22:05:58 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5148cbdea08so70835911cf.2
 for <dev@dpdk.org>; Sat, 23 May 2026 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566758;
 x=1780171558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXBF0Xxlrz43whu4eZFSCadmrWC48zvBqylfwrOAnBM=;
 b=zWpk3PuCxI/IPGh+DKFz3v5CDWZrMpGJGodOCIvYBXHu6XsHpgbD8osXSgLWMmbnAl
 m1So1sfjHSscdTul7T4YjEUCY0i2d/aTv29SiOYkO+CcDsWW+jQpVVoNI5SDMbBVDZ6h
 Nu05XU3jZmyspbXSrD2gpL+gPHR94VzN7h0TpvBaXNiDbmkOhhXKOohA9+qydndlbfvP
 MYiVRBpgqCRBKDfFFxsNyjfh4fWESVQm8YWZzcedY8tsaFBLZscrtSZIeIeIz4v9L/mt
 UyMR/njBr5Pk9aOlJYQB/bT242hydTDiox47k5xON4IaEBGC0T/raYmYNVg/klVJ6b96
 dAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566758; x=1780171558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KXBF0Xxlrz43whu4eZFSCadmrWC48zvBqylfwrOAnBM=;
 b=r+I9ry3yVQ4BXRxwjFaOjmleEBag751g/HdDIqhNExoP+UsRVXAeCazTq2v7KBIwme
 kok26WOuEvQR6dWYjonJK//v2bMgm/Pt3hz2MDAWqvvymx9hb5ZpABazso1E3jevMK5r
 I89Ug9CzbzG1MLIrgvoIrZmfp9byQ9SiK94CHaDKzbyo0rAcMGl2AWcej6jQvaLpJ8V8
 /5notLjODSfpIy7OpXowt+O1G/Ww9qPqdK+qgG81TW4Mie4UQsroPnJXEWvbtgdoP2bY
 yg4BW7mE3rW4T1REPeamB2WeQ27Hhdu4XX6dAcQDBYnRXaHzkZsUVq2NqOGKBc6pW0Sg
 zhfw==
X-Gm-Message-State: AOJu0YzaZl7pVZcmgDIYUcguJKBw1CZtJVIwmY6nHGn97NF8Q7+76EsW
 TTV0VD5xyxjqIO6sFeMtN+GD9VFqU//UVOUCq3UgITOmDEjB+eFgiF7xmsrcI9mTXH1quXlCTNl
 C18/t
X-Gm-Gg: Acq92OGFS+ZjwYYkLAQ4Ez56FHBVSf5/bJyN9psOIIDMHyx/EJv3lokyF1/zJ+PKN9x
 CAB+wiltZBEr8woGhwAdVc1q4IKc+NOUZyQ6/Dx6rH+RJQjAIlgmNCWxVy/0MdXDCSGaIb0B1Kv
 3txB9ettMBDT+LYvLWtT0bCj1UMxz4oGB9k4wFsg+uJUBp2MzEJdpXF/KL5ziiJu+UbCArNPeNi
 iyOvr73lY1yOb3AGziCBGyvFDqkqu1py5akyK7bFgLfWLK1+rXR/cIwZy4GvfizGntj8DoiWyAD
 XOEV4iSkC5C8idxt79Dr8eTXJXupA8zUBjhpFlLu0FxxiRnyThA94QLNYD3ddzYFf9R9tRY3Rfv
 gnkcduONMIHIbFtAt7FOIfLczHzZvCTu2oYtqE4sizVemOSitvqff1UZHT7WikEc3bSi1yKMjnM
 zORHaOnK0sG3KiPzp7SecI1wqlK8imJ4ydkRn6yxag5NqvEYBr1BdLnub51Barlg==
X-Received: by 2002:a05:7301:168b:b0:2be:833c:149d with SMTP id
 5a478bee46e88-304491e11fcmr3675195eec.28.1779566345499; 
 Sat, 23 May 2026 12:59:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 23/27] net/txgbe: replace rte_atomic32 with stdatomic
Date: Sat, 23 May 2026 12:56:37 -0700
Message-ID: <20260523195839.454952-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

Note: the code for the AML spinlock had a bug because
old rte_atomic32_test_set return value was not what the code
expected. This patch fixes that. A seperate patch for stable
has been sent upstream. (Drop this note from commit message
when rebasing after the fix is merged).

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

