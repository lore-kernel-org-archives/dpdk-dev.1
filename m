Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7E106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E90D427D0;
	Wed, 25 Mar 2026 21:46:27 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 7620B427D0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:23 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso147732f8f.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471583; x=1775076383; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9HjVNRhQb+xwhUAD0mV1LLBJonJBbbxVK7ZR+Obmdk=;
 b=lTnPpkzeKGvY8TKj+HNkDYHN3v/cdhAFNM6DYkFJdDCibyWcGHy9rtHBqbbXFDunk4
 /7c6OXUmFX02nZpZC/C9+gib4XC56B+113jN6SThCBDzoXIzhgjIpdSQePnB05pUMvQv
 5P/xG5p5dX5ip1GSiVQ1qvEiFruU0YunE9ZCr5QnfqYJqO8QQLwGDpo2mEL821Nftz6/
 8U7dNu6V/sN37Kzf6bIuq/LTynK/8Gg5LT51Q8K7OI5rwUX0G+mVS/cbaIVbigqDWRIH
 5NE0jv1YYkLDn7itDCwtA6p2LStjbaMzQ+qWvm3jqt5A4ztjBrh9hT+NL5HV/1ExC5l+
 XCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471583; x=1775076383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9HjVNRhQb+xwhUAD0mV1LLBJonJBbbxVK7ZR+Obmdk=;
 b=msF1UtMCsgfDL3kXFOcKydzVnNBuJz3W8t7g3FXcJ7m0nJSFND7BbtwKkTvySGtjV5
 FwsEsZzJu1QPnA0b5Y5jmWsT5Kb25aXaY9tRhWXjbffkKOoFW4ZbxK1gLO1vpUybnYpj
 HomSf3m2GUy4mNdd0SuMKXTJA/7r9xYNtgcNvEbWYVpBsmD7cz/aD7sHXBgjNSywIxCE
 HIMKggReNjD40RVlMwini1GRQ3cgJODPbueM69GC1gB6f2SVikuOi05QpnHVbmJzl7rX
 YDDdtugLo6cV9t8pbvhVaRfEWt9Z4TbP5u/Fe5Yx3Zzb1nZ1O7na5p7oZu67RgtYEO2z
 IJvg==
X-Gm-Message-State: AOJu0Yw7isbCkNmUq8KMH60eNzbVDuUL5OPs3AspxhnpzDtO2TYd6LUm
 7cPiXhJUKeW6ScfCNQPFLkAVUqAQl8p52njlPTyiFKcy6AdEnpi3ano4MGjVriPI
X-Gm-Gg: ATEYQzz8YDPBPRZ9vFJ2ipyDijjQzlf+zy64pCwzOykYIMrTtIXODPC9aG92V1VCQj1
 wcXCHPHVFN34H2HVOx7u6iAmgqO22t+dSk3zQfvZ7wzcpbt346V3E37arLsW59SLyMyexPc0gYt
 p+2o5S6vekJ2eiUx2SWm4t+ELr838wIsWdHUByIQBFFpU7k8dKgcrHsuYoBJu/VKPQ8aIxk52qv
 rBwBU2DzrQoumOo4/gy92yw8Ta+M/6zl3qLuhmrJBbN25V7Zfe1JJHnn4VA4tn2ux4fxUaW+GFY
 sHHBH8zFrJC/1Rzl3s9EWjwc03L9MNiMHKv7UF6DoLKtbB28Rc24YqRBlBl2c6k5pAZjFr+42Rf
 5+sG+qrFu4P24zI+vKQaYpKIphjFr4LH12xbatGZ17+K/puBJ2g/hJXTAm5jRYixEcI+OC+8EKK
 kuzKWRXWmWfBPUf7uU
X-Received: by 2002:a05:6000:4310:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43b887f0b7dmr7187788f8f.0.1774471582960; 
 Wed, 25 Mar 2026 13:46:22 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91943312sm2677543f8f.12.2026.03.25.13.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:22 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 13/17] net/dpaa2: add SG table walk upper bound in Rx path
Date: Wed, 25 Mar 2026 21:45:40 +0100
Message-ID: <20260325204544.101444-14-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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

If hardware or corrupt DMA data fails to set the FINAL bit in the
scatter-gather table, the while loop in eth_sg_fd_to_mbuf() walks
past the end of the SGT buffer. Add DPAA2_MAX_SGS as an upper bound.

Not tested, found by code review.

Fixes: 774e9ea91992 ("net/dpaa2: add support for multi seg buffers")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 8275ba9780..b316e23e87 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -335,7 +335,7 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 			(void **)&first_seg, 1, 1);
 #endif
 	cur_seg = first_seg;
-	while (!DPAA2_SG_IS_FINAL(sge)) {
+	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
 		sge = &sgt[i++];
 		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(
 				DPAA2_GET_FLE_ADDR(sge));
-- 
2.43.0

