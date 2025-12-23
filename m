Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7CE6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E464066F;
	Tue, 23 Dec 2025 19:14:40 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 608D340649
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:38 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b79f98adea4so748905466b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513678;
 x=1767118478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=KTR3V3x3nwkzYSA6yvRdB+rnibIrK3sZuQN/fzZx2IwrB/Bv5UISfKD8DrdgOD0PLk
 /XCwD84IY+UZbF+NrysM0Tazdyx96JIartR78PyQTF7A4bZ2sI+fe5qZOFkVGUwhg//m
 Mz+gHdWMN1ZN8s7/bvwo42Lb0srk7CAMZSsV7b/J/acnJqmgzEEztxBjNfg0XqYVjoK/
 DoCGWf01I4k5i5IAMnnqG55dn4gkuOf54Igl/Ze9KnP8SJkCmM569y5WVXA6VAZk+CcJ
 3fQIyv2s/9B9DcZF5G89tpPGjexsefs1G5MztFaXLzPT1ppf7vdcc8eQympi93BVi6/L
 iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513678; x=1767118478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=RZtT79sebvaYz8E2TLpbmgM/3vqu/QFkbeHxTrdZ7bAWy4E90d/TggxZ4gPwWq9Wz3
 OrmzU2L0egHLM03NuigJ4ZwiXP9tt0Ftl0qDaVN9nbvH7ngNFrf9mNnIxJgbAdx6ktao
 GfuM53xe5FUeSyLJv3NlWdGLnC6MZ9mAFXdF3zwwfvrpw4t0uwySZ/b6wuZdjWahunlO
 oHCtLBYv9CL5Ic/thea1d2OoNA7nhwuG3EtR3vJDPTL8gaBIFu8o/6g09EITqDFJ9dLt
 BMTU+NA7zf3TMHdOU80BWa0U2b5qvnZSKru/fnRWcYfiDU+7vl20ptoc8CBLdvKkNG/l
 bquA==
X-Gm-Message-State: AOJu0YwbmfwcfMTwTcC697eJAhneWK/Kwo0+acC+RW0MUXUmTPJF0fmH
 9BUf/bdlt7xB4EebOQgam/YJwsWz2yLsqdjm0MD70N+BZddpfqOIhuLjVcX2P3CaaEvtVGmGOD8
 3XiwxI50=
X-Gm-Gg: AY/fxX4YOO0H3ITjSeqofvDOZvsJ8ySc6IkFj5LFOmPWZyDZDNqxUguJLSM7AYU4D7S
 a56QX/F5/Mb5bV8wfl/Wc05pi4gH33MWLPUL3BhKtWxxEXzOciSo7+Kng0KWRdcL8Blg7PZEgx6
 bZm4YPoKQXfG7lZuWqDzXKc29K8yIVhIxF3ADqs2mn1tRdu1zY4LItTOeoytz9Cj03KD0qTrm7b
 l+49WEX0xgsdIZn78ZrHJ7ZqamqKLfO2a/aBWFLIMSuKsbx5wWj0i4c9s5dQVYAlbJhh2hMi/bj
 BMdQqYSVaztZOd9kg62o0xGrydU+9VxeDBeGt+ebTgcUPvKfIrnh/OIJ3zZyHrRiBHpivQWSXgD
 I7Rofa6q8KSU/mUMDLXfEk3CDZVXFASnB+nctrXAzfPf5IWNZKJNEknS5QNeD3MfY77drPKgBKB
 pElD3b7th+U+9U9bb0jlYkvcMOMU6gd6NI/+peBQXNMa3Jp2SqHnFxf/3qPPgB
X-Google-Smtp-Source: AGHT+IGuOLlrTJcvkaAAvNF6/YXVrN/3CLVXIPx8rqCJpXLhn1dGW4t7IBfCvOmTs+GwY5eX0xyMKw==
X-Received: by 2002:a17:907:3f99:b0:b76:f090:768c with SMTP id
 a640c23a62f3a-b803704ffe2mr1582680666b.30.1766513677902; 
 Tue, 23 Dec 2025 10:14:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 09/18] eal: avoid format overflow when handling addresses
Date: Tue, 23 Dec 2025 10:13:07 -0800
Message-ID: <20251223181418.40834-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

