Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2902FC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC48842E9A;
	Tue, 29 Sep 2026 16:04:44 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 5242F42E50
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:34 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8804c1728f9so3321671b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690673;
 x=1791295473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfwpIzxQF3ORyR94Mn5NkNYKP96IVPCaCez9SQR0vNg=;
 b=0hrIN5SBMQ9APT1WXZ4Q1/18sC67w1NpfLtrKPpul3p/PJhBxBB1xhZ8Xa/R1WHILM
 Wl4JFD9nRq7NtJ8GmQpAuGuXH/27urfTXYMVDOaf33ENqGYSnKTWT+HLVskiPYDGVPW/
 I63GWjL1iLTNbf7saxS/sfzXEUL6MaMfwRTBWpVs0nmRYUOCj7kxHGvscRapaqjUzZtM
 2ECjqxXiTq0QGSU3ElKPGDGsFKBHUe5EkvLs3r6frUGpWFtNGCt5dvyLaENGoNo4N8NR
 AYHU6uGEiZ4ZS2yzKrGngiG65dlchFAus+I5R8UVTgvSGc5s7Ukt2a7sMXoP9/Txs+jF
 G0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690673; x=1791295473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YfwpIzxQF3ORyR94Mn5NkNYKP96IVPCaCez9SQR0vNg=;
 b=lu7Jcxfss4W30HlzJQun2imxFawnAENpqztWKzf+QBgfbR0l/Qrks+1kjX06RwTf3u
 Af/ivQtIEDlBjynFYi6mt+L9/bjeC6/QoRkRGVFTxTRr2eTHz+XXU2rLgc6TXoWY5zs0
 jOyhPZocE05r/z64d1DhDmHmj9IgYCDQyeqYumtPLscJDloxbshGMpzh/mVFxW3DPBVv
 UfiISQHqVxRPvveibhEmtb9mqKmkA/dOG6ZIp6bd1cpVI1t/ylYg2xrYajnYdizjIAJA
 fy8VgXTysHbbDb03QAeL/IyhBhX4yfsgYrW2TlbW/YIMcw+NM87+UF/T3+pwnRxLnFcX
 SsOg==
X-Gm-Message-State: AFuF++mbhi/NKxBkBpI8RwQHko8TgBuUENwZVh+h8NRICSPGIDUFhwIf
 1lbmahjK5oHc6ZXk/mqiCTpx1oE4YpxTCA+Kob9Z/fVEbM7RzkP2OnDKtMt29MrnvA2V4aRanHf
 ebOGPAj8=
X-Gm-Gg: AYBFou0MW/Pu8AfP/MPmyUI5yNz9FFVLZe/F5CIVkR4ndMjH2IEYDoZnhRNEHUsaKJK
 POdg2OTCp8i6gfDGjezy4GqoMoPLK3zb9qtzFNzLo5c95tFSIO8pkDV2Lb+9gxbYx82fNwBB92Z
 hIFaSBui2U/KXyxwIRUAvWtz7V9DxfylVN85m+KpfiWwNIN0iirMBxbrcmbtiy77te6wzeQOvoi
 joF3sWXklreJ7VMwbw7L+n4LiPKm+rTiVITpKjafURfqNLdXFreDVwDXCElAzk2cRQduQtZ7PAN
 pPhg3g6scBLyBP+E72wfKS3xbPj8BbC2Kp0lOiZMX4meU6EMgSi6CjtW+fzX/KsIaXtgFjyV0wS
 zeWG3LSkpAjzets+tXujBh0QfJsdy//r0SLygVO/ZGz/taoAZQIoVqjkOBgPc2TrZYjlFEbNJ3E
 loqtf8RTwx9ZCsYD30gSju7RYZExvsXGvYLGVxTbCvv6pqWVX+d4ewbLZ0uWUhuNS+tC+fBTDwe
 b+88w6ihmEGeKp4baOP3TFJdGROPYQ5QQF5uRq22DT+TzKU
X-Received: by 2002:a05:6a00:339a:b0:882:df10:5faf with SMTP id
 d2e1a72fcca58-882df106bc8mr5702099b3a.7.1790690673302; 
 Tue, 29 Sep 2026 07:04:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v9 20/25] net/txgbe: replace rte_atomic32 with stdatomic
Date: Tue, 29 Sep 2026 07:02:06 -0700
Message-ID: <20260929140409.234453-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

