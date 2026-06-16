Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DBCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C81240B94;
	Tue, 16 Jun 2026 12:47:43 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id F2A40406BB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:41 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so34382955e9.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606861; x=1782211661; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsayG1stnmmVKyDsEqHlS0mwxIbbvXhUSD4Jp7HJoJk=;
 b=QIGZb7XNbDfG2DFC+kN2Wpsui/k90wO0Ftear0dLelZcMbX+d1FyZfrkkNAb4Cxvz5
 FyUixAlpqwfRr0F5ne6PQ3Fov5oKwRFpmHFN6rrwkXHUOfh/CXSbJuk35Bojk/bdFyTB
 I5ptYe7xxjPvCQGu8EYO0Qfsq+oY7qUdvAxW7st4L6XL3zfwGESFC5usCMaYEGKRNhQq
 flnApqBWtt01zYHfLmRWhlax49RtF9QY/kG19xychUX3SHSfUyAac1nxYiB3o0+KvIT8
 SCVoNNGnewFHyRq8344azDZY/gUGdv9wQMlCizW4gZnzC210TC4UesgG8vxnrV+ya/jm
 ED1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606861; x=1782211661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsayG1stnmmVKyDsEqHlS0mwxIbbvXhUSD4Jp7HJoJk=;
 b=jA0orNwRQoBAJG5P8Lc89zmiGgEphuu0m5ZnAJpB+lBtX6nqQaZ/Ae6vXm++kKRe2m
 AUh9aXncxtjpC6OInMUs7csS2XBLW73yzD+G28oHAmNcdc0toYzpXcxpUz+MfLc4l0NH
 h5s+XjinYpxE2MY+TgCo/XmdvgYGnt8jXh/ixC5wxhj2wvq47EuJSfSPLhGMNZQWQWhx
 tG57YHgm/MkngXQ9EDjkLnRl8gweMfEkr/VjFV0yLhk4g0jnpoBAM7rWMAFMDKOlvyQI
 rJxra2OjsBaPwdLwC4OTJlQGzN3jyexmV8C9RljcaUo8Ojqk6EwLekMw1y6xvY3DoQH3
 RYUQ==
X-Gm-Message-State: AOJu0YyC6wsc/VUj8TmI+otsBIGi5iL5pPHWtgbtulI5UEJLC526PWl7
 qXPyY25tMOQfnjpubuHpwpQyEFrLP+NncfciGF3s0r/cXfQj8xo4uoG2+RiXeLpH
X-Gm-Gg: Acq92OFIFYTLhFBIBsXAT0joRYCBopu3slgXENAXXsvLd5Qkn0f8tQEmaLhI2WKBsi2
 qxPkhSLT+52lB7owlEmj7teQB74FM8aRjbQXf/Uat20+vw/eZvSKLcMJFl8ALo2oXXq8uEoHxiZ
 RgOU5iWTrhA7Z6ikuE1uaH3fr/dkoQEScPNhEITbzO3vUXnR3mcbm6FP+sWfVIOxFQawIOOmjS2
 ukyYG4VCqquqq7yRL83xASuldpXIjWf2VAAys22f8fdhxTLRHhG8XJQ4HEhoifhzWAZkTLbP+Dp
 BXUK75O9pdArthgm4mXdjmQhNtnjnaZzsaybTVruxQwVDvAZiVfgxlKptwLDIicW2UB0KUjWDJZ
 j5Sb1sPJ8MWLjUt8LKVk92tvj8w0yg96bfQnAR9KQUjn3+u6b76gkqab4ISX81+MJbtwGu0wPAi
 Kjb3Pm6U2HcXlmbo6U0e4sMHB+tQdzV8RNOR/q/zSs6l2Qf9ppWjwK
X-Received: by 2002:a05:600c:4743:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-4922ff93c07mr45890225e9.12.1781606861481; 
 Tue, 16 Jun 2026 03:47:41 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3dcsm40981287f8f.13.2026.06.16.03.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:41 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 1/6] net/dpaa2: add L4 destination port to the RSS hash key
Date: Tue, 16 Jun 2026 12:47:10 +0200
Message-ID: <20260616104717.723087-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

The TCP/UDP case of the RSS key builder added two extracts but both used
NH_FLD_TCP_PORT_SRC, so the L4 destination port was never part of the
hash. Use NH_FLD_TCP_PORT_DST for the second extract so both source and
destination ports contribute.

NET_PROT_TCP is kept: it maps to the hardware's generic L4 port
extraction (parser L4 offset, valid for TCP/UDP/SCTP), so this also
covers UDP traffic.

Fixes: 89c2ea8f5408 ("net/dpaa2: add RSS flow distribution")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 13825046d8..e7578b7576 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -425,7 +425,7 @@ dpaa2_distset_to_dpkg_profile_cfg(
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_TCP;
 				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_TCP_PORT_SRC;
+					NH_FLD_TCP_PORT_DST;
 				kg_cfg->extracts[i].type =
 					DPKG_EXTRACT_FROM_HDR;
 				kg_cfg->extracts[i].extract.from_hdr.type =
-- 
2.43.0

