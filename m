Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A8BCCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56DD140A84;
	Mon, 19 Oct 2026 13:47:09 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id C44D74026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:18 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-141395927feso306585c88.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172778; x=1792777578; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJxQiFT4bMNZKrKZTfLNdqggu7IsCcFUxZLxhSzQktw=;
 b=NuYqBmVJhizYlK3N8xHp9bfmOf1wOVDXiV/rLueHuN5kI7scooFheExCqrT/Gfg3Dl
 iowLSTi7sJkAHDQRiSYe/kGZ2xicYg/M95GiLRyHJJey8uvIOKqGxqQZzig1yct9lG4O
 DRIqHdLnq3koWth60FKWxKPfZQP/+WCNj2pRPVL6HLKVhZrNGUUHB8CKo0GgPOpIKnh9
 KwNUwjsOlGU0iwoykgKOOoghM2MnPL3ou/es+6m90E49ziGeeGRBshdEIsLm6G1hsoG5
 /SN0O2G1CjbW696Xvqs/kXjS0gtiDZDPEG3HENCs2z3+oFo74l8mUALR5TqNDJQFMFus
 WA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172778; x=1792777578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mJxQiFT4bMNZKrKZTfLNdqggu7IsCcFUxZLxhSzQktw=;
 b=nOeKeLQrRT/MvaEnjyBEoNzT+7J1tRTbDFzyUtoftQvPdjAfzB3/xcovkicZ72J9mj
 LfwARnHMgMsF7EHiaCRJZENN7BTY5vPmCJ6UHrtOno3u/oRx/q8jN4jepLeWaDRwMdx7
 sNJyb0BA24PfXZkqR10N7A0KJlmSc6UVB0ExxUTKY1Ozhr4cxyJllXEIiv2n0iNoVQAZ
 OpmezN7ZKZf1DRYVPox8uKYfpoVddW2xp/52SiLfx3p6Z6cgcMMzHAavr2Hkp8pfwugf
 Rcqdw6jIgKjySXWHjmhKo2smZPtS/tCuo5TY7lkH+7dPsQZlWrkNbNDf48QKd7i+Af2r
 PoUg==
X-Gm-Message-State: AFq9FYJUSsK3cRM2S2CKQiFZ2IPJkLE1zH6c2ZUvitSzCw2qWwLyvfXE
 4iShYep/GY/0u7O+eiA+4YUcy0yTFe5YDF3i5itEKIKBKFR6YIlDEOff43SNeQ==
X-Gm-Gg: AYBFou12Xm1bTAacx3mzabsC1TzwM8WXbpRt6pPLIVvFAhnW3AwbSGh5uE1x8+p+GsD
 zUAmj1aQurg3+zkn1V/3rOD41GJQhwJONpvB52ruGXvpGYn54L/cX67ilMSE1GB8evuGO3lZ042
 zubASj5FBD9UFoKOR/EVHnRSTZAxpNBEMXwGxhO4KpBw6IqnV4bNVaacPY59Mr8OG3AnPATiq6g
 xl4uhGPKV8oRcVeHLQrZNohZ0FO4YopihHZQxuF4ep/YkxKzYR+4SHDujGFYeXjoK2ca2G7H0o9
 f9wCptCoYR4iIucOe2KsJWAyZLjxQuAVi1iZIKXg/VEBwSd513u9CqACAYVVfNuWSq3IeN+DeTc
 fpTd25rfw1bfOguv5ns2K3rTZ7/qhAup9DbF/88cZdykfV8QBgLVnRz8Oh0MHFe04GgYLVzleV2
 skHkbNYVy7msYEqTA4eTrSFXQ6wVvbGJ5LNUOZ7UojWoCQUMk4xpnTVBztqSQwrZjdkbhgyr1E
X-Received: by 2002:a05:701b:42c3:10b0:168:6ad8:e89d with SMTP id
 a92af1059eb24-18511eb6876mr828356c88.11.1792172777553; 
 Fri, 16 Oct 2026 10:46:17 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:17 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>,
 Rushil Gupta <rushilg@google.com>
Subject: [PATCH v4 08/10] net/gve: reject Tx packets that cannot fit in the
 ring
Date: Fri, 16 Oct 2026 17:45:43 +0000
Message-ID: <0a5ec0b0bcfe33414bb5020959ec8c16c572cef1.1792170902.git.tathagat.dpdk@gmail.com>
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

A TSO packet needing more descriptors than the ring can ever have
free fails the ring space check on every burst and blocks the queue.
One slot is always reserved, the cacheline overlap margin must stay
free, and up to GVE_TX_MIN_RE_INTERVAL - 1 posted descriptors are not
reclaimed until more are posted.

Drop such packets and count them as too_many_descs.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 281700b463..46a03d482d 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -123,14 +123,30 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* Max descriptors a single packet may use. A larger packet can never pass
+ * gve_can_tx(): one slot is always reserved, the cacheline overlap margin
+ * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors posted
+ * after the last report_event are not reclaimed until more are posted.
+ */
+static inline int
+gve_tx_max_pkt_descs(const struct gve_tx_queue *txq)
+{
+	return (int)txq->nb_tx_desc - 1 - GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP -
+		(GVE_TX_MIN_RE_INTERVAL - 1);
+}
+
 /* GVE expects at most 10 data descriptors per mtu-sized segment. Beyond this,
  * the hardware will assume the driver is malicious and stop transmitting
  * packets altogether. Validate that a packet can be sent to avoid sending
  * posting descriptors for an invalid packet.
  */
 static inline bool
-gve_tx_validate_descs(struct rte_mbuf *tx_pkt, uint16_t nb_descs, bool is_tso)
+gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
+		      uint16_t nb_descs, bool is_tso)
 {
+	if (nb_descs > gve_tx_max_pkt_descs(txq))
+		return false;
+
 	if (!is_tso)
 		return nb_descs <= GVE_TX_MAX_DATA_DESCS;
 
@@ -294,7 +310,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		nb_descs += tso;
 
 		/* Drop packet if it doesn't adhere to hardware limits. */
-		if (!gve_tx_validate_descs(tx_pkt, nb_descs, tso)) {
+		if (!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso)) {
 			txq->stats.too_many_descs++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
-- 
2.43.0

