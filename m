Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C41CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F2A40BA5;
	Fri, 16 Oct 2026 13:31:40 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 4B54F40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:18 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so4055775c88.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132037; x=1792736837; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BUx3ZHZ2RaEGtJQEY4o3+V+Nr9oF3qsYPQ9EGgxPVFY=;
 b=RWU7vUKMHNrf/PO0lB5AwK1lY1pZReAsw5n3CLcDnVHga4kwXrf1icqvj2k3In0Ls7
 3L6emvsQAKhvnU6UxDOfIwMdq90TISyQtaDUYwWurZD+eKsZIcT93ZRSQ7qcO6hSov3n
 elNphd4kw0N9tK1y81Tvfyk+eMLBOrhKmn0i+/fu8pPdZqIxNS7HbanlgNklWEFrcKWa
 GWMvr/Zbjm8ol5heao2FNyJRMdHSbbAR88Z4aP2HvVkh/ymlXxpMy3oLx8l8lCRBqUR0
 g861Y7tpiTv4SfuMv1M1HwUiysSnTa51vetNmR+Vcxni0kgB85v8bEMf+Mpk+PP/8vBq
 Oj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132037; x=1792736837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BUx3ZHZ2RaEGtJQEY4o3+V+Nr9oF3qsYPQ9EGgxPVFY=;
 b=JinaXRy0jqft/vbTti3zPz52K9++2dUSRx8gLrWJw35ZpBTux5zEY2/1OqyaItLxQL
 K8RgfNWepdKhVfgHHoGz7T1RuzEUhTWzS71jZdtjcGj+lljFDvP3dzl9nPfjJevzTQ77
 Em5mdsz37CXZKEiWw7oZ18ec/VZror3bG/obxY9y425j7H/rciKmTyKp8q1yGNZijMTA
 /rb/jA+VaOX9rUFrn1n/SHYVBeQkqZ/iih2w+66xzCIHyrbH6rxqO29WDuhXvxuYz/BS
 fg7VjUkJSGZdhVDBXKQhMlEupYTSU16nVCPamQi44rfWcsTluczJXGEYE8WmB9Kf9joL
 mubg==
X-Gm-Message-State: AFq9FYIXW24elC1gSPX2Cy4PdqvqpKmB37kzJ2ve5PYlfQWi2zLs+Cvr
 0x2ob2fmRjNmzsXdIcFPKDBqB+rxpo7PfjmqyjCCxIQbQf4v4pO9VEuH6ACaZg==
X-Gm-Gg: AYBFou0K0hnavTDp3xSEWUiyP5X/LXIapQLqd7p3AVuJ+lRQGwYffRjDPVEmibxmV2m
 73wKXRXkXnZzxzA0IDJbzL8mQ4Sri6Bf35KcfZU+1NsGsahMulQxzHGP5yt04kPxjq0M70Ydx4K
 SroYSNazKvL8mCnQiaXVuSAnHUIhDMZ2KZexNdKfU7+OTsTDqaGr+i0zkmpFm4KFDX9T0c5h+NC
 UKM5BidqrxbDTWBjEm4i51C6kMEFxH2jxKVpZbiDFFc+22Ti47eMUdxhMznhNgEA1KmIXzupUXx
 /U9gq8rCYhQo/SGqCcv1nOf+ATZD2TMEFINvIg3Mgm2gsR22vFTucjZfOtlRd4X6HLBRXkdP7wy
 dZBA9fBRcMh3WhO+M1k+JLgJ46ekB2eemuSkJQcVtVygEXlnhtZLCaGeGcwBTMaqvMA3U6blb/1
 AhI1pJ9YOdKKWxfXqe3Ikw7yND91WvorzwRxhnON7HebA7goSQatNo+ObfaowcXk8tYJU9rRwg
X-Received: by 2002:a05:7022:5f13:b0:14d:38f1:b51a with SMTP id
 a92af1059eb24-16a5f7c75a7mr26977878c88.19.1792132037251; 
 Thu, 15 Oct 2026 23:27:17 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:16 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 10/10] net/gve: enforce DQO TSO header and length limits
Date: Fri, 16 Oct 2026 06:26:47 +0000
Message-ID: <e93cc4f1a5365c35ebfb4cbe47ca3bebd030e7de.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

TSO packets are not checked against the device limits before use.
The device requires an MSS of 88 to 9728 bytes and a payload of at
most 262143 bytes, as noted in the Linux driver. A packet outside
these limits triggers malicious driver detection, which drops it and
disables the datapath, stalling all queues.

The missing checks also break the driver itself: a tso_segsz of 0
divides by zero in gve_tx_validate_descs(), headers longer than 255
bytes are truncated by the 8-bit header_len field, and headers not
contained in the first segment give gve_tx_validate_descs() a
negative first segment length.

Drop TSO packets that violate these limits and count them as
invalid_pkts.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Fixes: be8f0eb81f98 ("net/gve: fix DQO TSO descriptor limit")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/base/gve_desc_dqo.h |  1 +
 drivers/net/gve/gve_tx_dqo.c        | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index d50d88765e..53e394f01c 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -14,6 +14,7 @@
 #define GVE_TX_MIN_TSO_MSS_DQO 88
 #define GVE_TX_MIN_PKT_SIZE_DQO 17
 #define GVE_TX_MAX_PKT_SIZE_DQO 9728
+#define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
 
 /* Basic TX descriptor (DTYPE 0x0C) */
 struct gve_tx_pkt_desc_dqo {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index c23b222ada..0b328e4af4 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -130,11 +130,23 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 static inline bool
 gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
 {
+	uint32_t headlen;
+
 	if (!is_tso)
 		return tx_pkt->pkt_len >= GVE_TX_MIN_PKT_SIZE_DQO &&
 		       tx_pkt->pkt_len <= GVE_TX_MAX_PKT_SIZE_DQO;
 
-	return true;
+	/* Headers must be present, fit the context descriptor, and be
+	 * contained in the first segment; the payload must not be empty.
+	 */
+	headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+	if (tx_pkt->l4_len == 0 || headlen > GVE_TX_MAX_HDR_SIZE_DQO ||
+	    tx_pkt->data_len < headlen || tx_pkt->pkt_len <= headlen)
+		return false;
+
+	return tx_pkt->pkt_len - headlen <= GVE_TX_MAX_TSO_LEN_DQO &&
+	       tx_pkt->tso_segsz >= GVE_TX_MIN_TSO_MSS_DQO &&
+	       tx_pkt->tso_segsz <= GVE_TX_MAX_PKT_SIZE_DQO;
 }
 
 /* Max descriptors a single packet may use. A larger packet can never pass
-- 
2.43.0

