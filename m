Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0CCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4834067B;
	Tue, 11 Nov 2025 23:19:12 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id D3AC04066B
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:08 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-340ba29d518so146826a91.3
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899548;
 x=1763504348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WswHmz5BXygJKldYf/zQi60YARb8X8LhhXJcn5DVyuw=;
 b=z15SanrwmNX7Q8q4lB/n6Y/bjtemFrkbJhr25NiXdIhEtycgar3r7l3YVIDAjj65m7
 faW21+ytatMOeBkM1A/NDILarFgorPs1W/Blqtw1iNVD7pR2fdlFZ3BJtNWoecquojd0
 lEbrs68SI1eff6/MXIU9ao8n3Q4J1aM9iTswmTdO/shjMhuYjuU+LTDBRZXkkVWOKWJm
 jFtQ5OQiH8sg2YIeuf+6fMxJ+X/roQ02hoCeTyOleIehLTUqX/d4A36vd+MqBIqL1x9q
 2qOKCpUfBcBCYHIsO0GjongKIrrHsP0A7JfxMO4z9BDE0MY6OYiE44qAfzjSzgvkx5Vj
 Fz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899548; x=1763504348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WswHmz5BXygJKldYf/zQi60YARb8X8LhhXJcn5DVyuw=;
 b=TX3jQqtND8xLH1Ih58aX7B8ee9BozHOUZgd2wsPC0l/d1NjHpsLRWS82mwU4QhmY6y
 zblkw0Cgyx9UBMi2zyouJ+1iRVT0D/B9iME1aIyqkB9r0LljWQUgC1BVb3jjIC47zb9q
 3dfKh7DBwDJpHCRXg04KyG/QW/+aa96XQFWfyN8nBKEM0t1bLRHN5LTkWaNIO+NK545p
 k0Yoa/4va/QSLJPPk6TsR3678Xk8AL/MtD0KR1Ad2McSCMZygxSbZcr23L1cNSMNRcz4
 R8zoMTUTmpW9x0DofjPTlewb9RFrSowXmcr0o8Pko5eAMv8tfkxsr8Pi2/Wmrhf6DCNh
 Zi4A==
X-Gm-Message-State: AOJu0YzShVBfB79uHejsOIomBuNrjMBbLd9ai13lEiDdCRDaAfKmx6cD
 2jI6kdmgg6nANlxGTotydF+QffYOiLeHtyVlqbSaH5lZ6zbIeESuaS+PywsaGAI1J36ZGfKOZZV
 6XWBu
X-Gm-Gg: ASbGncsLLb86TpyloRcsdu5loJCv4EPrjpjSG6qot1hWtSGuNheD1+rTJ5CXY8vtR2K
 66+m+1DNsiarbov0HQenSEfiBAJQ8E6is7hHgmQZYBZKPo5M9RVTAtHmmu8SuLdh+eBNKDnSup4
 6TOjllm+XQsASZeYnQnhulFMKV40rUx3twb84b3CIJ6FwtQjIwBsioDswKD9o8wOYSa2yuy3G8e
 eZg7E2GUSi61fYUWDsPaHp94cZPW1lbrceuvebi7p2HSKvjoxGMdHXbAlkfztv50sspIT4VCMe/
 lHc/l5KZoq+gpU2z6VSYzqUxkS4tk+MH7ADHbIoH+/iCjoraiOslWiONPeiAFoXg3Q6vcBJnb/h
 MQmTxRMSkl73QSyKzYuOQpedAQ3ykzsL1BXTC0fRjh2X42JZlB2HlDnZu6mqsQhyj+YFJDbKreh
 Qcf3Y8AlR79S49VCl40hFPYqCsjpix86XainHcoUYmDn5FIi8rgD6e6buCgRcJ
X-Google-Smtp-Source: AGHT+IH0+NCGXQTg1XEbDpYSJh9uqwnHFqHoAYhwD+V6kCqMEYjJGnfgvHWautD2G9y5p77tg74+4A==
X-Received: by 2002:a17:90b:380d:b0:340:c60b:f362 with SMTP id
 98e67ed59e1d1-343ddde90c8mr974308a91.6.1762899547995; 
 Tue, 11 Nov 2025 14:19:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 7/7] test: re-enable format-truncation warnings
Date: Tue, 11 Nov 2025 14:17:24 -0800
Message-ID: <20251111221857.443752-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..66cbabe9fe 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

