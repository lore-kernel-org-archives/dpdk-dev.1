Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5E8CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881FB40A8A;
	Tue, 16 Jun 2026 12:47:49 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 552B840E0C
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:48 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49230a567a9so3079915e9.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606868; x=1782211668; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4uq8U8rirmw+4C2K7fdB9PhXtBaMTxn9k4SLnK+6Qg=;
 b=QxZFA0ORPgK1lgSKMtNxs0nNk6oz4BxgNrTVvjGKkyyb0EHBd8qcspQTdSA3xZmBSe
 6wSvs9qobg9JcyEv9bLiIWskCtQRJX3JAkwIhxnfjVucioOhdhU7gfPznoECY/HpUqEt
 9ssldNgtBhKaxQl2ebp8KHaVWIOrT4NTIu4rfwzNaG1b3vCYXUE3eEYKiSICGlw3T406
 cl43jkbxvxMtL2U6fzt+jKHHT4EMPTIt+xB6fFzhhVd9yCdKTeyZ/OdEr8H4ftDO36vA
 FOlqlfxf3b/gMlIrKge5ZXEJyQHPZmqok12Zgo3dlE6LWXBv4IQdCfsJAeFaU/5vlHCA
 yKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606868; x=1782211668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4uq8U8rirmw+4C2K7fdB9PhXtBaMTxn9k4SLnK+6Qg=;
 b=LHItzNd9ut5TZJm7IgdlPjRL2VuAzDJgb9rde2/7w5Dh7Jx8oLBTkI47Bcc18/YaEI
 UiGxHM92e7tz/ai6OI1HrKA2FqaRJNfpaewcieXoDbIUEVX6mj9xdkpcOkQeU+cqKN4y
 o6uWQ8S2m6TM6jMCQk6QlRRQ8UD5wxtTg7NfgcIidWYRyusAbya25IMMjdAco1QEZpYp
 PMDT7go+KK8EKfedaTs3nRUfVaqIjjU5KoaYOTYmXmTopLGnpXvin1NDTgML84QwbcOE
 ISnaxXuYNuu6VxRw2wbl2gDiWVl751HnnwkkKwleYogmpOygOCJSgEEBOIH7ofjqHxWe
 B56w==
X-Gm-Message-State: AOJu0YwP5kOxGbALs7tcxCMavy3ZhwGtHST/XQGK0G/NQ1gs8lUFEtS0
 xkcAeATVUOAEe4GFQcl2T0IZAMH0pi6nX0EbBmvwftzJGEgl9/HBrvJBJJWHa4vr
X-Gm-Gg: Acq92OHu0rEoV6AWYNmSBxn4hyJdzPy8rdRC5loj7gW7UEaTp5uEKT2Q6RNUjy/G9Ne
 eCLam1C5CxT3twq+fu+/4NKlBQLz8AzuGakI6usQBU9iUAeIayvTVxyYYLs3lOQ4j+NoMsXwfgG
 zrOv8iCLeie3wEkEG1z/22pXsJ+XNH56maPVWrUItbfDFEQSYtPdHUwehYWNHdWTR9d1/4rfFd0
 /s1nWJ/8MRixe3OPI+4xmxPOG0rvgYRXXJuHMp6c6NfhhQYlT7uWRZcjLQO2ZEUwbYreaGTtU7u
 z/qAnHfHMjWf/y2Da8245DPdXKQDUOMrYBY97eEYeU7jMoCCeB8YaLQEbnnMa6PS+3OFSkBpaAa
 E2ub1nhoWLRjJ2OaIo8KY0BXZ2QX9kGJQlmIijNo6/nBDMhGi/No7Ag9HsEAmXDhqfoSU9rZymx
 fmQdpmpMXl9QbHwg2cz7QRrfzIaSa+zzY4dM00YvWoh5JZS8rt55Bs
X-Received: by 2002:a05:600d:640f:20b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-4922ff92614mr34791875e9.4.1781606867660; 
 Tue, 16 Jun 2026 03:47:47 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9b45bsm43483605e9.15.2026.06.16.03.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:47 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 4/6] net/dpaa2: set PPPoE configured flag in RSS key build
Date: Tue, 16 Jun 2026 12:47:13 +0200
Message-ID: <20260616104717.723087-5-maxime@leroys.fr>
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

The RTE_ETH_RSS_PPPOE case tested pppoe_configured as a guard against
adding the extract twice, but never set it, leaving the guard dead. Set
it like the other protocol cases.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index f1d670f213..2724672a5e 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -260,6 +260,8 @@ dpaa2_distset_to_dpkg_profile_cfg(
 			case RTE_ETH_RSS_PPPOE:
 				if (pppoe_configured)
 					break;
+				pppoe_configured = 1;
+
 				kg_cfg->extracts[i].extract.from_hdr.prot =
 					NET_PROT_PPPOE;
 				kg_cfg->extracts[i].extract.from_hdr.field =
-- 
2.43.0

