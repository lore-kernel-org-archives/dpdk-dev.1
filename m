Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EED60A261B
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IINWti5B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 862A840E8A;
	Mon,  9 Nov 2026 20:43:44 +0100 (CET)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mails.dpdk.org (Postfix) with ESMTPS id B92D240E4B
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:43:42 +0100 (CET)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-451d80641efso1934296fac.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794253421; x=1794858221; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AMPMKVvqtiRkbDFAFmLkjS+jj35XsIo1ka2wA4y9+r8=;
 b=IINWti5Bo+0RX3qPb3p0wpVlwM3ekiMCkXs7hMt5fnMJP+aYeutx20nJzjCXen0g5C
 s9DASBiUfqvwks5FGxZPAMDT4kLAKcJDFoBqyLBEeafORa3aeY6F96isxp8qP1+HbI8B
 h5J2HEKTP6KeT3LBjccjEgKrWWcbmVswwa11jQ224lijeFITsS2gYDakiG2gnNhZR93F
 Y6JyZn3VPTbkD2Q6gm+J9mTxKQp3DApPY16zWs/I7tTslUD83nFqMZ5ViJsMYz8D802M
 Rb89JZ1b4FUakYZpcOzfZqYf9p17s7dIxqK4XKQjpUcwJV/aX1Fj8zcXIrVi0QQUCiZb
 AD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253421; x=1794858221;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AMPMKVvqtiRkbDFAFmLkjS+jj35XsIo1ka2wA4y9+r8=;
 b=F92jG3fWKDoB9wsa+AxpPdhc0s9hHjTXDLl5cuBGrhgkqq+uFO1v96alqlGBTKKvyL
 hMa5T6Zcwvju5BnWoAO2QrdylpjO0nwDtt3XbipZLpF4rYOMRLCTI7A8gS9w+xlUbY0M
 WXyPCUxtPOzvUCNji9OS+CkIUtCzh3wy1Fr85G+Dd7dRmfSMrIfeAQDm1smy8mwghEvf
 KXgnO8QK+9xlGRe1N+nKXMnQfe0nNep+wKdk1+uNyzIVxSasPfRN9f9yzyBNPtYc3A41
 OBOwT+EtOvG1AQ3+kRTRXXmyaV3vGH6i36Pq+kOIINX/abLGjg79GyrPschowieqaQpn
 fWdA==
X-Gm-Message-State: APuU4Z8o0od5c6U09eLQyxh/sM+WOJa/Y2KPB0I1dQ1FeuDuPJ5OEMHE
 75K+l5cXotuvy6FkeUFYWuPoOj11vE0+AG8LC+eYFFFVKmca4A8yDn1WJiT4NihGKIzOCU3f0Dl
 Thjy2dbL3Iuz4rA==
X-Received: from iobn18-n2.prod.google.com
 ([2002:a05:6602:c6d2:20b0:9c7:67b2:21c8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1206:b0:53a:ad3c:17aa with SMTP id
 5614622812f47-5683cd9c0e2mr473466b6e.55.1794253421020; 
 Mon, 09 Nov 2026 11:43:41 -0800 (PST)
Date: Mon,  9 Nov 2026 11:43:31 -0800
In-Reply-To: <20261109194331.393364-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103181442.381856-1-joshwash@google.com>
 <20261109194331.393364-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109194331.393364-4-joshwash@google.com>
Subject: [PATCH v4 3/3] net/gve: validate minimum header length for TSO packets
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>, 
 Rushil Gupta <rushilg@google.com>,
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In addition to the limits added in commit
03b62d39c1c8 ("net/gve: enforce DQO TSO header and length limits"), TSO
packets also have a minimum header length of 16B. Enforce this limit as
well.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/base/gve_desc_dqo.h | 1 +
 drivers/net/gve/gve_tx_dqo.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index 53e394f01c..c2f7b0caa6 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -14,6 +14,7 @@
 #define GVE_TX_MIN_TSO_MSS_DQO 88
 #define GVE_TX_MIN_PKT_SIZE_DQO 17
 #define GVE_TX_MAX_PKT_SIZE_DQO 9728
+#define GVE_TX_MIN_TSO_HDR_LEN_DQO 16
 #define GVE_TX_MAX_TSO_LEN_DQO ((256 * 1024) - 1)
 
 /* Basic TX descriptor (DTYPE 0x0C) */
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 78eaef3e3d..72730eb1c5 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -139,8 +139,9 @@ gve_tx_validate_pkt_limits(const struct rte_mbuf *tx_pkt, bool is_tso)
 	 * contained in the first segment; the payload must not be empty.
 	 */
 	headlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
-	if (tx_pkt->l4_len == 0 || headlen > GVE_TX_MAX_HDR_SIZE_DQO ||
-	    tx_pkt->data_len < headlen || tx_pkt->pkt_len <= headlen)
+	if (tx_pkt->l4_len == 0 || headlen < GVE_TX_MIN_TSO_HDR_LEN_DQO ||
+	    headlen > GVE_TX_MAX_HDR_SIZE_DQO || tx_pkt->data_len < headlen ||
+	    tx_pkt->pkt_len <= headlen)
 		return false;
 
 	return tx_pkt->pkt_len - headlen <= GVE_TX_MAX_TSO_LEN_DQO &&
-- 
2.56.0.542.g3ef89b7020-goog

