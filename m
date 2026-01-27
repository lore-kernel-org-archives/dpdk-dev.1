Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF41D340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:35:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EEF641148;
	Tue, 27 Jan 2026 17:33:41 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 1013B41148
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:40 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48049955f7fso51584925e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531620;
 x=1770136420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=V0UVRmMHCE99ziX+Kgy+F9Mx9VCAnAWZjfScDH2kmbB+ESX3IdBLghoIRuyYc1asYh
 VUsvZXGSSjWuq4y2u7bWIeCk3p2ElWPYU62L+bYf+dIng+MMqtp00aDEYn9XYVY45c23
 s2AQU9hkSKYhmmMJ3iRDEOoYlQuLq7W+fTzdB80EU82KWcnO9VBMvWG4GNyO6fRt7gJW
 rIRtiMH37JGl5pnveEY4NoJvPYpN2MA1eKm0SjFTJCZnSDXrCpuFIGJgcJ4Eoliv1SFl
 ItuZwQp+uy1mP48kp387uxW7PXUtPFeZjtX/xP1Ao5T0ZRJipD//tXNIJOjmlwDRjMDq
 q7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531620; x=1770136420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=kDqKWxsc8XuCAcT7xlpQ6Z+HibK0LBmBxFqxZ+xt1LWiG1im9NdUsY3JZIpZ+D1fqI
 sr9ASen4ytgw4SgOOfqwBpar+xvgErVwHFpnlGjbBo9Dr5UxS80+iTzY4KG/cwxZXVeS
 0qhviasbYPQYY+Bt2ucPob7V/eDVGMHSSMiYqcJWqX+oMAKEXdzuzPBjtV/yH+CnZavv
 qAHGxtkw/Y/bJAnDU935S8Z5A81U4FtqieouoMmw/TY0tk8nLBP2vuFVcn2L7oPEvgke
 hkHWBkXgfBUHniULlpzbRRDUVm26yMvW/PfSVj0KlvaSTp8SAtkp0AMD48adQ4kkjSYw
 RCxQ==
X-Gm-Message-State: AOJu0Yx5kUC7n39MliwKOrikTkGOh3n+DLMQZ5kqWbdoLMQa84P+Cx+t
 2MgUvFzkAAiLY7oZEgaFepopMY65clU+AHvav8glG1Af0FE4McU88JSoLoMhxxswqWhL1w12prm
 hbT35
X-Gm-Gg: AZuq6aKa7G7peQsFbYRrIpep/dd2MS6k4sEGzQbO/xM99+35Tlv1A5VFDGgXX3FWkpM
 4N6gVWVXV6uutbzplf11o3Gu96TU5KN7MIqBIH6VEzHZmuo7burumKkOzI1XZ1+f6lkJfY74om8
 MxAGGHrPaWiHLtr6RuRqDSBPIbOCYw8Wm4BNOvmJ3QIF1LkxO2g6gc8j8F5wO3qVxL1Zx0FW5/N
 9tDEjJLwB3fGXeeHPbDuGu/xh0e96cbtmWb4BBgT66MqXbgvDuZ230GQUZjiCznEUbxj9yibBiV
 fT7evy2KkjB7N5VeDXp2DphzduuPvizufcCymxG6qbdqysi+2NBD03GS+rvgHY2fGn4cqUMBJ7y
 Hp7gU9t9nn1Ip5b/tcPfbiWAb0T7fQ0lMcNLIM+DuLW/Cq7IhOjxa7h8mX1Oh8HFBVvIzxjiAIm
 PGz39HWMU8/5ORX/v2sbFeKweYos0uSZHERjeb+8ehB8oJhrJdtA==
X-Received: by 2002:a05:600c:190c:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-48069c4869bmr32138235e9.21.1769531619647; 
 Tue, 27 Jan 2026 08:33:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 17/17] lib: enable format overflow warnings
Date: Tue, 27 Jan 2026 08:30:31 -0800
Message-ID: <20260127163258.75566-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

