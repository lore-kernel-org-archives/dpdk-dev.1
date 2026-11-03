Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3427606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IfTcNWwX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3187842794;
	Tue,  3 Nov 2026 19:14:57 +0100 (CET)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTPS id 68372411F3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:14:56 +0100 (CET)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2eaf3f829b3so44884475ad.3
 for <dev@dpdk.org>; Tue, 03 Nov 2026 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793729695; x=1794334495; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3TslPsfNferc8iSuqtjVUZOK10DB5E09fJreUE8wVFo=;
 b=IfTcNWwXWa8KKciYz/MTMsOnr57sVy+7GZpJHQFrtl4+98EYJ82dvi0ocEkfovij4C
 M/mfKbTcl3IF/5zSs+ejyhHUG082s0dU4awzCMUHpryj4MVIZgf9q7pnWRVvxUORnomL
 f7GlzeLyoQbAsLqe001tH2nrTIqlyfl1lr3ccRNHEyKtZ2YOuLw6re2px6EDEVmq5Nvl
 HPCiRDtE2xEAidBonZCfiWKTh/Gd4kHMhYzhyw1UXoiwT5eFSs1kE6CTSzLyxdspmAYE
 2HKJEJE7CX+66OcK6o+W47IbHvxa/LJVzZtD6T7sOS0i1l+XOKz53sukVLlhHmQwt+w7
 714g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729695; x=1794334495;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TslPsfNferc8iSuqtjVUZOK10DB5E09fJreUE8wVFo=;
 b=vdaquMQAysY8mMQhGEtnPIj56ikj1tirayFubJ3usb4W+9lNse0mqMh1g9/ufMsOzD
 69NTrcMgJB8RuER3OZsLMyn3K4YYRYDQsjv2Eqlt0jmqUu7K2IM+N73ri/NEZv6rVvDc
 BulK/vrUedKhq0xUKyY9n3tc+I6wAFHPU9mcO0ZEobKbDYVukEN6VLn7Ji8DyrWsr6ji
 EgwvnbSZvs2dWEmmfFtUbnGoskeHB96biQ3O9OHZOxZfyhlbe37oQdfjGMj8tMaiF619
 N6+3kewgtOTIRaz43BKspjbOzxPn9SroPg18Z9/g84tZSx1EpjTUciXhd5MYOSprJjUW
 g/kg==
X-Gm-Message-State: APuU4Z/7xfdoS4/9t/kz4eB4MikV4umRmOJp5dUezDZs+tKszLhTxyoI
 bVlC1NlfF8/7Yk7JSaMZABiGZpvg/iVbeXTbbRfSSk+TJs3ubZDrCHUX0BBBRJ7ChmIBAn4EscO
 n9kz5qcNb0LQ7ag==
X-Received: from plq12.prod.google.com ([2002:a17:903:2f8c:b0:2e2:cbb6:3b7d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e751:b0:2ed:218:6043 with SMTP id
 d9443c01a7336-2ed02186a1fmr2333735ad.59.1793729694653; 
 Tue, 03 Nov 2026 10:14:54 -0800 (PST)
Date: Tue,  3 Nov 2026 10:14:42 -0800
In-Reply-To: <20261103181442.381856-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
 <20261103181442.381856-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103181442.381856-4-joshwash@google.com>
Subject: [PATCH v3 3/3] net/gve: validate minimum header length for TSO packets
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>, 
 Rushil Gupta <rushilg@google.com>, Varun Lakkur Ambaji Rao <varun.la@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
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
index 7858c21012..d8a252f05f 100644
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
2.56.0.385.gac671c819a-goog

