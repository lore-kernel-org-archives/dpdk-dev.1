Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C7D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27FA840656;
	Fri,  5 Dec 2025 21:15:58 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 300DD40651
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:57 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso21371675e9.3
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965757;
 x=1765570557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Em9xfpoWR/4OoAagxdlQwSlaYckBjg8U0t/YUSUD40w=;
 b=zLzwhqsaFMjgk1fxwF4xE3QcxFTjue8jRKYUgbH4GArueNquv39+PNUnf/JsUdq3xC
 XIXTmZJPSKge0xzOCIyvUHDLh7857T4MCSqF0Q56Gkj4Oq/Ekqygo0DW79kvACeLfe8B
 k0R/wHHsUzXKgLNhf7aR8hUDiQkABi/G3QHsncn1JRA0u4JvyRscik+IYkCEme+81j/F
 BhfvbT/pRvU7VS7CUpbUcb5tzSJsGQi2ZR0BdXVP1bUZmRURMzuEbmoH7zj9bOx+7RS4
 resXo9Ivi55lRX6wiUVemaGcJbPToh8q84XDWLNyab8IXfHuo7vgc0KcZ5aMBhBsnLPL
 Dnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965757; x=1765570557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Em9xfpoWR/4OoAagxdlQwSlaYckBjg8U0t/YUSUD40w=;
 b=lJiPjyb5WGh9Dw54BEupgDAbUO7v5tbEae8oUf/tQnRZUVRab7fgtLjS6KFU0aaW76
 iQPxvfQl9+frh7kxMFC/UvSSX56md3p5CMu+NEiS636Co2b+p5qoT1+ZZHJIIuJt8RuM
 6Zgi62buEv6KQF43LL/4fqE+G9HkqVwwiEDS+q04J9RgXrmAE4UAhc5f1ZCzo1OOrjZK
 0a+yvN6C3nkxynb5Vt9nInHtJQwDddsurtCtDN2S5DGD50oPcjYUfP9vur6l7y9xj89o
 Kzkvl5hH5AVXJumO0x66STHVDxyNV2T6owjfyclrYsA8fon3UoM0dkQpl1wDRHhqhD1b
 X6YQ==
X-Gm-Message-State: AOJu0YzaTJT/1fHFq42aUT1v5ASFwfPiQgfv7y4gRgFZlhPv2okZfaMd
 jg7r9rE9ojkfOMxB6DtpCRL1wZOrV+mCRXh8pui9SiZJFKXbDa555uIVLnYUo1PT7OHAPx92DxD
 ZfZKn
X-Gm-Gg: ASbGncu/L3sztZ1hxYxG6/GDcT6ZoGQgExgNB/Qc+NFdtOX2iBD/Uc/622L3dKEwuUo
 yOrUZ991/UgNlvgH3ABYiXGg8LIetFSA6s8Y/XaK8jhoedUsaBB/RWjaY4RdGTZbVoLtpGJjRoU
 NAxQ0emVTjo8Owu82Kwm9n0J0lJrDObKz59TAlMaEAX2qVxVV3ePxnD5BG98MUsV6wb05D+Uyu4
 eYAjBh2hZgBHWmdn16J/JfpSE3lcsoOMWoYl2jO889uft2oDoXK4MjnepIWX+TPk0umQn8vWuNO
 socOjHuxrArbWQ8hQlZqvqsLGzbsBw1Z8suoWkmTJYdkxqduUZZo0d1jVh08A1WORsBMy7ddonZ
 240AKwZO5VmJIrT2jf4o8HTMy3HFeDdua0DDuBfYufbEjLReJcTpKXp/IqxTJNRXKnciMXG/0KF
 wFIy29qvA5mo7x/fh+BVA+Wn949Go4uCwH9OAIog7kxFk463EM5Q==
X-Google-Smtp-Source: AGHT+IEKAtDFzUvV0lZxZ+RKu6uBeZaMetIu3B/9wQrSDdzAw3XJanZFg+QvDv0p+z/3lr5R/pOMfQ==
X-Received: by 2002:a05:600c:8b55:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47939e4d008mr4978195e9.32.1764965756717; 
 Fri, 05 Dec 2025 12:15:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/16] eal: warn if thread name is truncated
Date: Fri,  5 Dec 2025 12:11:36 -0800
Message-ID: <20251205201537.251131-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/linux/eal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

