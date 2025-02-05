Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D787C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1F8240A87;
	Wed,  5 Feb 2025 17:25:18 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 8DC7D4066C
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:11 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9d5e0e365so2580968a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772711;
 x=1739377511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yzqN0rb+p6zknth1raMaRc1zwdToLdLcpFjEjE+Oog=;
 b=zPqeWO4myrR5t+Wv8hF/9WcKG0qa35SHpK4El+WXD4zjQe4ABvUZT+tsuWtYPgXhBx
 eqiBWegzVws4lHxBqtCwlltiQU3D3rUtEPuml9AFl96hVXQLxs+q8oosp53QLuR0MSw+
 c/Ke8VeCJYd/anDDSxAsBNaK71r4Tg5ioyZsVug/ylMHVbhiay3oFVY01EtiTx36hMTJ
 b69DnjGsrjx5M+lZDHlTTJi/NMjkYgGfSQ9+hoDz/XNTKuN/HeNu1oy+AhkLa7IPOpP2
 LHH8i3S0OP/YwGXgY7vp+DVwcPE3eHBnjT4KEPTiJNB7TL21C9IShk3RWnCk3if2tyIC
 UsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772711; x=1739377511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yzqN0rb+p6zknth1raMaRc1zwdToLdLcpFjEjE+Oog=;
 b=WElFMsL1FGdQIOYOLaMvMBeZ06da0Ms++CXt4Gc8hIkUkLlvXfJOzkWKTbj4xwYzXY
 ibc0Zk7IKTL0pr+vcSuDQu7rSBJSYksIabjbnHto2jkZV7i6NBIMnsTgutpLgbHmmg5s
 z4fGtFgfFr6KIXRWJg0OQklcFEy3zd30jLGRjm7rwkcAyzZBicZ4g7rXPwwAUZD28Eh6
 ZvCtwV7Kq+WVDrpXKfGCKHXHiJCBol9at1c/pZ8NPJCGWGEe3aCozp/aCiKWhE0VFa6U
 R315m2YH7PoXRAAxEoUYKnRBe2La/qQFumhotLj5GEwp0i0tdpMPLoA+8ZtFZSMDuX65
 iGZg==
X-Gm-Message-State: AOJu0YxB7fpLLUbEVX1PX2YwSxoOSob18WRSnJ2oQkKMOpFLKQJdiip/
 pc9JCS7/FNd+sdsoPzvgxXUtJJC+BpHMkqVgzbVD5r6vw58xGVdA+P0uo6p+fpat3QppSsoswXB
 v
X-Gm-Gg: ASbGncu0J6GNmd3V+PmYMECCDYzDcErWis5qIWONbyyb6aeRGLTulNZcPt8AXJp+Zno
 w14xnyAsR7EWgg9tQSlaA2QTiBhvb/XA7sl94hHFwwM9emBrCL+5k7y/b4/YJ28/3agnk+tk4N9
 Ue37cGqYlL0mnNLcGnNw9i2NYWWyOaOQsE4Sff79LmMc82hdMk87U9PQRMVyDyZDb2xPEdI3c27
 LUP7OmwuoG2RQjlZY0l9hsDX5h82V/KLln1LgUamLwvQQifRLt35l5zBwPwkGp/v5EMLq4mJ5wK
 Hhl7iNtZJemnI2OQFX/NsY5FlT3ZrUi+MBJp0w5iE2Cp9R/T/WM5N8oov72rKDI5zoXG
X-Google-Smtp-Source: AGHT+IGtRIywwPWEgt4swryeJWvD6xYGrM2Pa20biMSOj8NOM0UQCLKmnYY5M1SIoeu7Q+BM+abU0g==
X-Received: by 2002:a17:90b:28c4:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f9e0834932mr5378711a91.29.1738772710746; 
 Wed, 05 Feb 2025 08:25:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, ashish.jain@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v3 12/19] crypto/dpaa2_sec: fix bitmask truncation
Date: Wed,  5 Feb 2025 08:23:13 -0800
Message-ID: <20250205162448.161161-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The dqrr_held mask is 64 bit but updates were getting truncated
because 1 is of type int (32 bit) and the result shift of int is of
type int (32 bit); therefore any value >= 32 would get truncated.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: a77db24643b7 ("crypto/dpaa2_sec: support atomic queues")
Cc: ashish.jain@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index ec6577f64c..7ad8fd47dd 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1491,8 +1491,8 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			if (*dpaa2_seqn((*ops)->sym->m_src)) {
 				if (*dpaa2_seqn((*ops)->sym->m_src) & QBMAN_ENQUEUE_FLAG_DCA) {
 					DPAA2_PER_LCORE_DQRR_SIZE--;
-					DPAA2_PER_LCORE_DQRR_HELD &= ~(1 <<
-					*dpaa2_seqn((*ops)->sym->m_src) &
+					DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) <<
+						*dpaa2_seqn((*ops)->sym->m_src) &
 					QBMAN_EQCR_DCA_IDXMASK);
 				}
 				flags[loop] = *dpaa2_seqn((*ops)->sym->m_src);
@@ -1772,7 +1772,7 @@ dpaa2_sec_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 		dq_idx = *dpaa2_seqn(m) - 1;
 		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
 		DPAA2_PER_LCORE_DQRR_SIZE--;
-		DPAA2_PER_LCORE_DQRR_HELD &= ~(1 << dq_idx);
+		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
 	}
 	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
 }
@@ -4055,7 +4055,7 @@ dpaa2_sec_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(crypto_op->sym->m_src) = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
 	DPAA2_PER_LCORE_DQRR_SIZE++;
-	DPAA2_PER_LCORE_DQRR_HELD |= 1 << dqrr_index;
+	DPAA2_PER_LCORE_DQRR_HELD |= UINT64_C(1) << dqrr_index;
 	DPAA2_PER_LCORE_DQRR_MBUF(dqrr_index) = crypto_op->sym->m_src;
 	ev->event_ptr = crypto_op;
 }
-- 
2.47.2

