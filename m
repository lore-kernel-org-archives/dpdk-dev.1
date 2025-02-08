Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F22C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59AE40685;
	Sat,  8 Feb 2025 21:32:15 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id A7AC64066A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:12 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f74c4e586so7555065ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046732;
 x=1739651532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c80/9TdpxlsXti0oFqXAVasGclPwFBVacHO7egCHovM=;
 b=XEh/IFDraDORZ31kgB9DanRYCIpKc5eQ+93bH9bsNvttp9w5WzNSzMMr2NK1nxnfPL
 M11C/wLiRRFgdA7OTF+alqgp/BVlHP4f2Okr5GCVnZFTjIKihTPAVN1gon2f37kW5Bl8
 loQVQTWdbjWmaNFfFiSybbAfyfShv5M6ADNCDASoQYe+noBGsb4Zjp780GvvhO91lAZe
 Ooxw5Hb9DxQeM9JXJWdfoxN+AZrNRJcwmxRxQ70TcOZazaXVuceJMQu0CQR5aMELujnE
 jS4NrKo025Uqgr6DSZRzSDew4sP8JiNAjBskqIRrzpuP7B5xJngA5IbdpHIbYBd/6Qkh
 OYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046732; x=1739651532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c80/9TdpxlsXti0oFqXAVasGclPwFBVacHO7egCHovM=;
 b=IjMeI6JDU3pAdEbptTapDQn4bJ6854rRB0oFvfxq/A7SybFQsBD7jh0Fs77p/Z3OFs
 f6X8UYixC9Q3Iq+94QGGPnKKwb5Dz6VpHSLnwwFeG1p6QJabKF7vBWbR0EqOyFRCXflT
 f//jpPjcBHtQlHppaOYFEVWjSXbPRS9wRdNy8zni6w+xn87NErF5SBYiNNhv2SvxBgrC
 wb7k1izlAG0RzPSu6DVTeWGV/19PMl7Shrb+kpu1dNZT2ZwWr6YxaO+TRpJ90Rqku5sD
 8r8Utt6ZGWHT3x/a5GwJSxZqIaFn5lQKm8ezxc+HaspK1Cff5nmw2NJC8LL94F1q0kYB
 BHqg==
X-Gm-Message-State: AOJu0YwvLMKp0MskRYK5mmHInu+RTrKf9CqtmKCkqaolbLIwtx6YUt5F
 Wigw/5aliWVYSsA9+EA88xgcTihr2hrC7eiyJf5ClEm4r2qaVJ4L31vP+LqiuY9EKndWL62LSgY
 Kbv8=
X-Gm-Gg: ASbGncv/JWSaZbEQMHl6Ocxj1SBa5qq0ZkNdirEyD/wvJ+LbbEhM2/7pO60Y3t1q8Fi
 pKJhzGDSEKwX8NEQRZ77OiJEBWVk70NxldTb3CFAa1wjtsrEUVK1ExivCo9vQ5d9k+KY8VfWpvR
 ZJL9DDEjFam35l+5Vf2oiGDV0R9MW0aSgewaOqHjBZrYcd07yfVXOa81K4vplVlXPoQOvJEKq/b
 AH8t4/uVz4rO1V5zOGwYoEIEDq6JWtXYq2iM/pVSwWvMfM3JrzKbNx+Zppsi0/bn9rG1DJmH7Is
 X9buUGwJ78r9nQCllat1Ti6jNj6J6Z1HcV/n6oBCyNZQZ9d9/p7jzEGuAcsnGjepB5d4
X-Google-Smtp-Source: AGHT+IGFVrN1E21lo9RR91PmMH2yQNwkjKorAMI5ICVgVZgm9UtyRWGEkJiqj4Sr0JYZAO94BINWjg==
X-Received: by 2002:a05:6a00:1acc:b0:728:ecab:51e3 with SMTP id
 d2e1a72fcca58-7305d47f31cmr9550886b3a.11.1739046731870; 
 Sat, 08 Feb 2025 12:32:11 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 14/32] table: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:06 -0800
Message-ID: <20250208203142.242284-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/table/rte_swx_table_selector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index 18e021fe6f..da693cdba6 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -225,7 +225,7 @@ table_params_copy(struct table *t, struct rte_swx_table_selector_params *params)
 	if (selector_size < 8)
 		selector_size = 8;
 
-	memcpy(&t->params, params, sizeof(struct rte_swx_table_selector_params));
+	t->params = *params;
 	t->params.selector_size = selector_size;
 	t->params.selector_mask = NULL;
 	t->params.n_groups_max = rte_align32pow2(params->n_groups_max);
-- 
2.47.2

