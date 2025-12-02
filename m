Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E3D1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 102CA4065B;
	Tue,  2 Dec 2025 18:26:38 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id C64AC40657
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:36 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8b5c81bd953so39508485a.1
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696396;
 x=1765301196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=nZD/Cfrh73laKsYHcRdbZYUuqUcl+LRn4+07K/2ona4piDSxIL3KxffIyV7CDRAa57
 fU9c5n4iAB7uZJuwr/GpwIC3l6dTF1YS9cV6d2jZ3g1MhhwPn7zEq+cUSYpYFbMBqgki
 m4Pta1YNx3eM65DP9BAhuqt0FmYpft2yZw/10cX2oIDqRlavbSNCdBT171Qxu0jPIO7L
 TAStRsTR0qeaWWs5OR4jBipnFIk5LxSVrWWultig5BYpFjt0oh3qzE3/xdn0XdpiSji6
 NF256iItM8+kVj6AGMwmeqz/c0vxrqzKgYvlfazQJwlU/7+rxpRPz3GxXU1EhHTk+lHu
 zXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696396; x=1765301196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=wRYl5UqTbDJ1sqDLtTRKcJC5+U9d23lsSkGtI9Ng1WP6mOTvFUSIIPyMwXmBSXniY5
 OvflgMZ39UOT8bGdjjwQxZwO0AcTRd47WbFOsQrMKQ7lYvD9Bsldi8FIWrTy8usKucKg
 hAxz7NZk5XFtgAKjvgXbf5O+mwwEbCoB+vUYAvf3J1ScQN1sVJsRVk4zlfALoLrB5lfx
 vTYZQbOQnwdvCxn5NDpMrErl6KaLswMG40MHJYFK0Fm1/e5dvUtixOOSQpZZYO9hHwHh
 2OiaKahDh3f7Vw4XpIEM1CNRdGNyNlYvU98S+oZ2i+/yX6IxI5N6GQnNTmXiQR6rplsE
 STsA==
X-Gm-Message-State: AOJu0Yz4TKw6qP5TjrevodHiX9oMfc2BbVxBFFdRw8cHOfkSEos7yqC4
 vf52xVZEHVaofWK0mExgxARkqHwA0IQmGj8VxD4UWwVTc7V1mytiA/ZRWUQ0lYHCkmvPJzfCIC2
 uHXnW
X-Gm-Gg: ASbGncsEd4fotxyi/GRHDZtmkY7Mb8yDaRobhzofGBipSleDs394TqnMpjeoxdhPcTJ
 Ms6vlprk0xftC4NBwgaxCemiNG3gL9/xZ5UWrvUM22RYnMqONwCDAbGW8RhXQV73/zDwhWwmZLk
 fAZND1gYROSQrFCosp7fAmMUENseAbAh/qqNZn1h1uYTVvNxOgKrZ1ixgS7qFmvmoU9J74nwq+X
 XHiqiK0Og4Lgw628GegjtMmpkBV0NVgUwasavJzRgowYEAgpJHOpr+Z5xAsrLpDdndnSSuSM3Hr
 EKcFIkwEXMwlM50v+pCuk5zuQ0t32OR9nkt+V4UVbqztbTzfGnpVNGDbs0oPifoO6n9Itn6IN7R
 oD1ag0PbRRkFJfHfKp6Mud6nUk+eyf9xc1FLW61VFVJ4h6FFe2IpsIbyfaZmrdFc0lBjxwi+FfA
 ekv3xoEPJhqv1HCoVb9qIGmsOWARq+r6h82WRetkJ8oYKTqTalXW9p8ICOWpgv
X-Google-Smtp-Source: AGHT+IH1zVcCjrIpq3jBEPykWvORa6n9wxYwAAjCuNXRtp6ZI7NrgWUHkm5mL5yRFsEz1zASx9SnSw==
X-Received: by 2002:a05:620a:458f:b0:8b2:e922:5282 with SMTP id
 af79cd13be357-8b4ebd6f987mr4247700085a.26.1764696396025; 
 Tue, 02 Dec 2025 09:26:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 4/8] eal: avoid format overflow when handling addresses
Date: Tue,  2 Dec 2025 09:24:30 -0800
Message-ID: <20251202172626.283094-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

