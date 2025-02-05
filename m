Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE794C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FDBA40B94;
	Wed,  5 Feb 2025 18:20:29 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id 3BB9B40A72
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:23 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-71e2bb84fe3so27629a34.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776022; x=1739380822; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgWd5PLP0gx3Tb7mjdi+VvaEd6Sj6xeh89zcNq8Bc1g=;
 b=ep2aRRQLeB0ifSPYNhHZGi2D0RkOT4zhEnxH+JF9mTgQ0elM0/tjGlQPKRO+eOl27x
 4fwHUSN8OySVTi87WzQrWeOwkzDZYB+oLUUHGu0dSL+H2bbhAxCm6OIpa8jw9p6LyEt2
 4UoCOD1jrZdUVbyfi/jUgy4OufnZEbUz2Q3Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776022; x=1739380822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgWd5PLP0gx3Tb7mjdi+VvaEd6Sj6xeh89zcNq8Bc1g=;
 b=mq7XQDh5CvVX9aO13Nqa9Ey7duMZeXFNowmtAJRLKmn2GVPvTSTX5FOlqZgVfET4G3
 WRpPh5GI8DOA8dUCNtoDWoSpZDXDazL4NI0/vJeW7epq4yMFKAHwlpHe02YCzfzCR5nv
 4pkDEzYlE9xB5VkwccJ2VPqNaiRzYnOHHxEsaqgMlGYuSAENuK/c8se/xMS+6jA+VH10
 IaseiXQuYT24lpd0zaIz69nbEKgs3cs09cyNiQDbnHr/1SbbXiJougHfKohz2tXH236I
 t4Sp78eqcpe8KU1419NoCF4j2QeoKkcwzhW7wty6qB3QJAC/P/ZVcccDnlM4uRdoNvNW
 oz+A==
X-Gm-Message-State: AOJu0Yx3suxPep7qQRDaHjK4O9GpP5T0a1OUHT+eBe1EycahcVxipjWU
 rCvfAxsoZZsxUznRG1ihkTJSEnRAarlx8eYH5XzsSZB1N/eQKKuoRZuwtrF9xg2FReHPkn1sqKE
 KKxAqFUdeWhEPi3lm+8r3tig4Qb+E3Ft5dnUl4Jze4/9wJA2X+7rNBCwtdbWD6NhzaJc7nr+LRu
 BIqDdgiCE/yRdMXusE2bh0itywIUV9
X-Gm-Gg: ASbGnctUXRB956kU6hBwD9okJVzpjTUKcqkZ4bO11i3NLg8JH3V3dPtt/8psuN99Zy0
 oabO0yelBtmoLYTEi4SGQRIZnTa0eT96Mnpf4xa8eu+dAu4o/6hT/gRa+TGsWUKmRNJA2Nx8sJJ
 z9LkDdATrdXChQ1I3C0Z0B+PZ+ydLAB85JY4ln0rhht9elytnZkyiMSuJtNp6zPPcjxKOFX6ysw
 IKb+/GzBkX/WAUATIb0M1r4PURAZ0HCxO2++Iey7mSaFds8eJtXLMgNgebCGC21YZse09bOQKUQ
 N/Jy/eH5+aItmxQlMZePT8WSzVVNLjOr1RHxWK0zUoJ9hSXz1jSEv5QDfjV6ZP2eGXkWhHbh3xD
 jLleyDh1c
X-Google-Smtp-Source: AGHT+IFwnKsoaL68Ro13y7BvxpmTd9XTvGe8tzfLDNg7wBlhwh8t2buCN7pPk29rt7SzvsfQtNeo8Q==
X-Received: by 2002:a05:6830:6501:b0:71d:4086:6072 with SMTP id
 46e09a7af769-726a419c77dmr2615599a34.7.1738776022318; 
 Wed, 05 Feb 2025 09:20:22 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:22 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 11/11] net/bnxt: address coverity control flow issues
Date: Wed,  5 Feb 2025 09:20:04 -0800
Message-Id: <20250205172004.50395-12-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449072:  Control flow issues (DEADCODE)
reported by coverity.

Coverity issue: 449072
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 5e0d906fbd..e6f316539c 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1084,7 +1084,7 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 
 	if (bit & BNXT_ULP_FEATURE_BIT_PARENT_DMAC)
 		BNXT_DRV_DBG(ERR, "Parent Mac Address Feature is enabled\n");
-	if (bit & BNXT_ULP_FEATURE_BIT_PORT_DMAC)
+	else if (bit & BNXT_ULP_FEATURE_BIT_PORT_DMAC)
 		BNXT_DRV_DBG(ERR, "Port Mac Address Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_MULTI_TUNNEL_FLOW)
 		BNXT_DRV_DBG(ERR, "Multi Tunnel Flow Feature is enabled\n");
-- 
2.39.5 (Apple Git-154)

