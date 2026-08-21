Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA5C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF94540DCF;
	Fri, 21 Aug 2026 21:29:29 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id BF15140DD2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:28 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso1755313b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340568;
 x=1787945368; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N3wL0wiWRjbBjJM8/UvNqTovPAHCu6AN36OK4sZ2dqc=;
 b=EnEO6akzAEux9cUi2vsaKjHMCk1I4pX+wSUgRuKuYYQP23GcNZY2SEtO8IWn9NDmet
 zvoVT21LaRgNre+N+VM9qqxPVAQIjpuIl5QVD7BpnPBP+hLP1amvwXswnrdPVZUdff/p
 GGEscOaAMQYv2hxAgqx0nFiOG6riEgHFp6h1ydOk8GugxZA0ZL/hRsGV5+MnR/y7CxGS
 6/gUlmFuDM86OxKzV4XkBVQh3jARIMk3Z42/Blu6lUfxLMZhpjZEqwYbpapzlBJbLIfG
 4s2HFrbdyCBwkWbXiLikUIQyH4WTjX/llR4POXjFkY8782/E5ZmW6a41cMs1NCU7NqgN
 KWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340568; x=1787945368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N3wL0wiWRjbBjJM8/UvNqTovPAHCu6AN36OK4sZ2dqc=;
 b=RIrYAXvoaCoVr3ygTrmWBI27Ll38yhF/rsstI1E36OamX2YtnZDoWwBiCccaePJ5ro
 Ojg3rc6+N0BAntG16k9RdpiIExDidjROrE3MK7mXbq42gIZ1LLI4rbdu4NOJuBj1EdYa
 If+4MPUYml/JNRQ8FsZ5Jvz73Fg50zy6iFxM2B2apyoubJtbmEJ3B5ofUWCmIOyEtHfQ
 BBcb2a/6JnTlZz8wmGd43j35gjO8V2HqiY278iABfK/sYM4gUrXOnUxSPKHprBH2G4X7
 wUfU16d6vDeq62oCLLrM3rIQ8Du8XG8ZrG1KBxkhREIzfSx7RazUuIHV3+laQhMMXfnK
 EddQ==
X-Gm-Message-State: AFuF++lpEyJ9ZO+LcXKt/3sY1dNEL9XPu9Wa3ol3OXw+jVC98tZT+0Uw
 PiCQnjhc+dGE4+A8bH1InSObQS0F1vJgVVv/LJ1fTIJfuE3rxVuOPuvu/nFPCLs5ZXhNxeZkTq+
 TGP8P
X-Gm-Gg: AR+sD12dHq98pV+ThA7/0oX5XmI6W2OzfeHnYvB94mPzrt6lvz9NhBmSvc6kDSAxgMT
 WM7EfasMlCA/IBRpX4PkeAesV/82BY0LKh7BuOte9sm17RXI5MiHMHdi9qns3VfK4gV1GneUoNC
 c/z4JOnD5JxDSPVFDebRsKdleEtL+Pbtg1EA1lVnrPi2QBFE4NE/ux9dM8VB2Ho+/UalPuwcCod
 qVxgobY9MFzwcyKPwbGK7XAX/2R2TMQnMwzWrHWPnsKI/tFI3R13z88JXvMa2VJUK5vGze9Gc/9
 gmetKVjd1S+NlpbqFvQQNT9+1BZ1Rz1MoirwteWATIKQn7LLdSzLvjztMz9WU6Nyi8D5X7OB6ck
 wett4IJa04IpMqeCm+STL2R3TOnyplhGWgF3+/6E4YSaQkUPLB8vFBnu44tqt4AwP0LbL+TPaKQ
 IM2uJqalRf0BGhf50ApGXGdZyerASHMbAaW3CCbiMiWPR3o1LGr7CZc80iLjSQRXhekliRquKSP
 eKyEXyNNERVzYlMmCfcgCnoUA0=
X-Received: by 2002:a05:6a00:10d1:b0:848:5540:2377 with SMTP id
 d2e1a72fcca58-851fa070c14mr12178446b3a.17.1787340567845; 
 Fri, 21 Aug 2026 12:29:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>
Subject: [PATCH v2 25/68] net/avp: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:20 -0700
Message-ID: <20260821192646.146382-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/avp/avp_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index 8af6c45381..026f45c688 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -249,7 +249,7 @@ avp_dev_process_request(struct avp_dev *avp, struct rte_avp_request *request)
 	while (avp_fifo_get(avp->resp_q, (void **)&resp_addr, 1))
 		PMD_DRV_LOG_LINE(DEBUG, "Discarding stale response");
 
-	rte_memcpy(avp->sync_addr, request, sizeof(*request));
+	memcpy(avp->sync_addr, request, sizeof(*request));
 	count = avp_fifo_put(avp->req_q, &avp->host_sync_addr, 1);
 	if (count < 1) {
 		PMD_DRV_LOG_LINE(ERR, "Cannot send request %u to host",
@@ -286,7 +286,7 @@ avp_dev_process_request(struct avp_dev *avp, struct rte_avp_request *request)
 	}
 
 	/* copy to user buffer */
-	rte_memcpy(request, avp->sync_addr, sizeof(*request));
+	memcpy(request, avp->sync_addr, sizeof(*request));
 	ret = 0;
 
 	PMD_DRV_LOG_LINE(DEBUG, "Result %d received for request %u",
-- 
2.53.0

