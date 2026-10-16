Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F99CCF2E4
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB3B40B94;
	Mon, 19 Oct 2026 13:47:10 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 352D040291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:25 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-353804b591eso249328eec.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172784; x=1792777584; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cys0YFX0zC9O/IIyJ+gXaaZQnndJmzYXJYrpHkGNNMU=;
 b=nMj/VX8+5ZrzuytNhH8FGSlehGs+nm2kfA0eOrnR2JKfn+HpRW3p8KW11aSJzlHnXL
 FcVt1ITsvOhyrSha8wdEKU5ObV8I5fYf1Y15Vw2sDET0W0nONtrqw6t7Evy0PRIelPZr
 y8yvHgoeGgQBZetS1JvFNn5d9bERo/pHNSDjvg1taSp7BWg0ZYogm6u1MKccxl4WWpNu
 gPdPwAoMmriCG5GwCrQnitNe+ob0t8IJb21S9eShWI3aThvcB4+Keof68NfR+muzZTdX
 /TUE7h0b85gBvnToMQjlKO8p9LXJVnbXLEwifGeCcPD73DD7ovsDzhi6p3avmmpzcBFt
 m9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172784; x=1792777584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cys0YFX0zC9O/IIyJ+gXaaZQnndJmzYXJYrpHkGNNMU=;
 b=hFu/IdCnivcSvcmTk5BbEYTiMrzODP4f4K0/sylZZOb8YxPQuwj12jWGXVwqeSqvEf
 XO77PD0vF0M9N0VxBFwZ4OiLO0JEX3fsOpRcoNyw1FM+tgZuKBDhMvd/TnYrkOvaqapd
 QlqBYaPwarA8UE7ldr/tkN3XA4sOOGopZx0+l3lcsD7eNvZ+mONbkkelFkOB2rlUeTV0
 pnPLVzKbdyqLsQcIZmqX4HFLgdZLtlw/cDVoLJGj5VMArrCymjAf3HSUZK4HI0TUfR1N
 bfmiKJIfRc/N+VbzSPl/RMIvQkHcEhNW7tQ1yFvlVndLNIJ3alVQrHgYUcQGHmczCCto
 6R4A==
X-Gm-Message-State: AFq9FYKd7XCkzTXatKJxor22CCrZMtBwpBDM7G3ezzkyCuva8mY9RMq7
 Yy74uIr77myzKDl54w0c+MOkATaneqG9Do6aJxkxdqrsMK0Mj9OxhP7Y5rxjlA==
X-Gm-Gg: AYBFou1VaWQYowHxnpbZ96ehp2P0jFj9jPmKzGJleqhRpl5/sY4zRDCRemD//OCUHfZ
 fWD8HZ4t9qksauvQAiRI6/QXYv/Jh02gRjDGvXhKSAlkh2eefUxKXqleikYgHjU1V0ndM0OoogR
 UT18m9c+uQBJR9Rc2hAxoBJYjVMqKXoJR1PEd71cXbGylcjZLBXHOKgnGoyf4stcBknZUc1Tw6p
 iasyMFzEZujiFI31eh5voQvXG4NAQ4+ugqqwpNbZlA+yMKAuXoKDC38nP5+72vLHuLX2M2xlFO4
 kY50RizzW6fmZcsTTTTXA+DhM6KNcws6XIsSaDYU4/0xWJ9VU1ryU66JSaj8FFvaoZ3T+CrcAWe
 EakGj4etncmzmXzrm1pT6R4QUNihYLeTZMAwE+DboKtA6JwlnDJ4eyZnw9izqidJPyA7W37FGNy
 S7hrVTNzN3ioQYHYWOdn6M24f6tjk1ix+jOrvASvZEsAN/P0wVJXU+3/kKbuaROEdL1vFi6xoI8
 G5QVvszdF4=
X-Received: by 2002:a05:701b:42cb:10b0:169:b1b1:1445 with SMTP id
 a92af1059eb24-18512e2515fmr723306c88.31.1792172784162; 
 Fri, 16 Oct 2026 10:46:24 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:23 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Rushil Gupta <rushilg@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>,
 Ankit Garg <nktgrg@google.com>
Subject: [PATCH v4 10/10] net/gve: enforce DQO TSO header and length limits
Date: Fri, 16 Oct 2026 17:45:45 +0000
Message-ID: <974e46780a800b596c6e747e0716afc579d58433.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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
index f686a8c110..52fcdb285a 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -127,11 +127,23 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
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

