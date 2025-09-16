Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C55CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F088D4066E;
	Tue, 16 Sep 2025 17:02:34 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 1F55740661
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:02:34 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-7639af4c4acso59380886d6.2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758034953;
 x=1758639753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sSLziMS2AyXy4gUf9RXhywdNFTmR3cg2FbXWBTrVCs=;
 b=Ypi+jX9ecGAJT0BYdpXb3/DybqQ3wkJxbPeWxkP5cSg7kWSgWF0jyqfJ27U4XYQVq4
 uwoO8eVzlTmx4c4jEdp7n2eMGce1c6odPNTdrDv14h0zRxYtWzFBYEAMP++2B2SSRvZy
 sfb7niuRrPcGMRkox6TVWaVbs8Y7QVe1wxhmq4aPgyYjp4vtyxdr+3yBwOBuWEt24ey2
 20nJfZIR9xJsU0X2G0MShF3zHt3TUimbmKjBElawQQXM26dcbOHPlqD4vWtbt4mgRKbN
 YGN8VwXX4gEzpYLdeLfF7CA2qq1CZhWVE5nTgnP+tGjrx/oX2DWyDoz+ZXppbboY6yhl
 mZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758034953; x=1758639753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sSLziMS2AyXy4gUf9RXhywdNFTmR3cg2FbXWBTrVCs=;
 b=AmZ4kltZTAXAurfNo439hJI6ohK0CnJ8nHI51Ec9494iaJ0nQs+CYZCi+L//DU/rLq
 Zzd891qlQlJ6imeDnfu4wUQFXEUgVSKgxoDDLMnaqjPNYwRAXhLpHMfKBbekOoEadHNS
 L3lCAbk2fxA/V1+e7D7oxJjst4vIukjf+hn+V11eL8aoofp4YcLkS7o/eIygEPVlNjUx
 x0r8dbqiSiihTawuq7H8XdGMF1DtE0H1X9dHE63Sx1xz+B414rf9mTOBf1H18GnPqgwu
 wMItBibTxBz/UmFSnuz3kGdb5aAb0xrqTv7WtKHOIVpbE2dI0fOp5DtOOlRtj52Z6g2q
 qyiw==
X-Gm-Message-State: AOJu0YwANGGWGqRHiqSIYhxXupZXHWWCnOgVwvsoSCWvp5FV0b3luTfk
 D6JDESsgoXbxznkFX7bdG0gLrhfesEsNs74W5aqElbEml5FLvsu8y0XmIVLsQjhbVAijXKRTPhB
 /kRWC
X-Gm-Gg: ASbGnctwANX3dxtatufPQy+5yfGgaUkb3IbbWMdIL0I1xqwxMcXSQbgJQw+BvP+b48w
 EbT3jDchQZNMBmzcrz6UXoFDWHw/Rkh7ooqgeb0PWNwoxCPnDoeoNMM/AJFQCACZ5Cag+Tmqp56
 FdnvSOdP+qizLknD48kM/arbVjHsFT93RE05TryUa/p0lMTDxVN5fwccUqjiYhdql1TWsaBpJJe
 U3+F1dDTsJTL9kOr5SrlhJXfthnvi19s338uiZMy2r6s/kc4bPGxX5mqE/8xB3k3I6j6tejQfcf
 94nLltZ2qQudJvr0TGHgnwed0E3bSynteLxbRF+2NTZj8KrPncMEqL0m5chYG2rEvoVU5xKwxoa
 6Xkr9v36IGq8Y8SuNIQwi8RJxJRokMH324s1H3rh5zZz46qL7MqGyvHJjOtYZJuy23pJlsS9B
X-Google-Smtp-Source: AGHT+IEp3JqYlKV2lTKJDzvB9S2YxBE3ZwYvM1mzoBKD8C8pH+hFAF1AB0Wcj+RO5GhzZXEK3hOekA==
X-Received: by 2002:ad4:5f0a:0:b0:785:c22a:95e5 with SMTP id
 6a1803df08f44-785c22a9664mr77481796d6.58.1758034952825; 
 Tue, 16 Sep 2025 08:02:32 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bee7c80dsm94324306d6.52.2025.09.16.08.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 08:02:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 2/4] hash: use static_assert
Date: Tue, 16 Sep 2025 08:00:45 -0700
Message-ID: <20250916150219.104936-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916150219.104936-1-stephen@networkplumber.org>
References: <0250818233102.180207-1-stephen@networkplumber.org>
 <20250916150219.104936-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that static_assert is available, better than pre-processor
use of #if condition.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/hash/rte_cuckoo_hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index 16fe999c4c..90fda7d7e0 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -24,9 +24,8 @@
  */
 #define RTE_HASH_BUCKET_ENTRIES		8
 
-#if !RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES)
-#error RTE_HASH_BUCKET_ENTRIES must be a power of 2
-#endif
+static_assert(RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES),
+	      "RTE_HASH_BUCKET_ENTRIES must be a power of 2");
 
 #define NULL_SIGNATURE			0
 
-- 
2.47.3

