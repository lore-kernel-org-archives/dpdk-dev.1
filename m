Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF9E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48BBE40670;
	Wed, 24 Dec 2025 23:13:36 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id E40ED4066A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:34 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so63641505e9.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614414;
 x=1767219214; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=d8s2yPV7dgjjAthPjtrgYETJBkQKpjGOKKAhLVB2JXHcv7OSSbZVsjsX3Gn6cfjHS7
 ixBOrypAZbk+dY4ipuFsqA8kNQemDZo8eD2+2LUGesPLuqaUhenQzYdu21y0OVHsK3x2
 GVcn8OctX8OTjlze7MqyFvIkLxU/QJfLT6B2qbaxZDWNmAsRSoRRMkzSA6VekCbYaJBJ
 Q9+IgqGdJIEDdG4xd+B+DoFgR5sPIz+7WXxCql0zUjnH+lDggeIf742xCzFVWuZwhzE7
 Z6HEXWhdy4P7q0hKNY6PU9kJM0vhvgIVvmDt0H5RU9p/N+rRyvArMAk+2Gu7kYD4NWCF
 bq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614414; x=1767219214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=LjoWHGfD9//Ps27AjXKQtsCCicoTF5dewOFUzdQmLGJEJLJDBhUMYxBUARjej2fWaH
 S1YhrlCxzk2+M+/5Etg+1+Inea2P5QNy1MaG08dpr32fiP3ZNe/muYSWCZqhLPF/4UDF
 knD5ujaZie454fbAIfEWNXbDNF86F7iDu9Ykq9e9Q/mZRTarCqyD07Ef+eWyJoTZuY5P
 vDLN2NVNhaQwSuqqb9gZSHSpHV9fdZev7GMWSWezr8AEhrFjhfXrFhvMm5JgZYiZrp2L
 yBB8mV/8rF+EpNYdmic7b8GSKq1gzwY/rl36JKkrk647yZ/F5JJ1Hlt1CjCcWtWwr3ZL
 1vbg==
X-Gm-Message-State: AOJu0Ywh8dtwr+ShGtk0roqyXr6PYV7vh0stI5yEMv9ZpTDs9ZOL6+tM
 Irk7Q8jXUbWrxnZHcBBydlbkRgpQ0hcpJ3+M/SwPaZDgAkMHxGp8ag5m1NRW3AwlWgoAQJBm6oo
 6rT/syho=
X-Gm-Gg: AY/fxX5R5L6ehmRpZZA2yUr8WEUxqBHyoE71VJpRhmQnmAUe/buQzOZVp4CwEObQOxY
 Y9pqPIaZOTWOGAlH1QRJpmUMMQX+vho5Fry71DFQxZxvfdln36DsMoUxSsmH5cM/lkoMgMzUrD0
 +sRtH+dtiOxd2vDgb95QkePhRbskW4oJKZyVx29MIP0z/ssOKxrDJmKrk/k/OMrxLNSwAZD5qkM
 3ijbh5KfLkPt/CVQpezxaG5v1k6/u/8gc7VIDcBAp/AvLZ81ii32cGPFMkVxFJDXkrwoYNJtB4g
 6GxxNIBkdxjE8cq5NHvYq/lFvIzm9HcXdidhY8PiOKhkFxWo73uezaHbB4M9cT21uuDLFjx++Oc
 2mNfy9HQ6gdzzsTkX7K/VqlyowNa5w3ual/SyOSaUlGPxnB0jIdweRl+FRRp6Zj2RGGF4I9IbII
 f48TCrdnWQbIbL6RAtOE+xySV/ldRos+VfWEaMoJCPra9IzQmTew==
X-Google-Smtp-Source: AGHT+IGYU2Lw9ZaYGe5AybldSVPWwmmDXShgdCy7KG9idSfWuFyQFwYPMyI2rucvlm0+jcsGkTNkwg==
X-Received: by 2002:a05:6000:4202:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-4324e4c7127mr23143082f8f.11.1766614414448; 
 Wed, 24 Dec 2025 14:13:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 09/18] eal: avoid format overflow when handling addresses
Date: Wed, 24 Dec 2025 14:11:50 -0800
Message-ID: <20251224221301.52714-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

