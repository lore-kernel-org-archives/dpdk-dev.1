Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E29C44500
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B026342EA2;
	Wed, 21 Jan 2026 22:08:33 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 05F1642E96
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:33 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so2424075e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029712;
 x=1769634512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qMd58hBiQM+gSoekcx/HedjSQxWUADUlBMQRhIscsg=;
 b=U8cudWDp9xZI2+0aZP8CHx/iCpIkBDMsyyDGjzVXOgha8nbFt0jngksObhhYXKff4Y
 4F5gB+TfG7I4gH5oi44RRQE6PDqiPOocciMjMstFg36TRsaOfC/JYt5lOoXlte6Wf0dm
 0DuI+HbB+aDsuU3QFc6G94gmZehedlBuTsNN5zhQtyzJYdZQztx8I4sbX9bIsNE81xkN
 OgJYxWqkCpYtacbK2YC69GdmX8Z8NelXy3xrlhGAfGFLOGn9ql4Qf3AsT8hUmxeZbcXb
 Za5Z6l3jpefoU/F4Hzh7VvTHAskZ7oeBedLFSYl1Z6zrl3ls82VykACVbXgTixKo1Uuu
 zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029712; x=1769634512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4qMd58hBiQM+gSoekcx/HedjSQxWUADUlBMQRhIscsg=;
 b=Wv62iq3UHfcCCUvoso4PD1kMi/me51bB0ROLZ7z8FSj7HpxpM4YgJHRfmCDsdgAnBv
 6PuYhOyKE1N4OKGmQgOnjH7Bu7uSTrmE6uCSs0JD94/pFjATOmfUVKoLmGHXuYRXj6yF
 U7UXtrO1ZWdy9I9k1ngAIQjyt83js2UwTmPsMJxa+agVPl5ssH++VOyyxI/+/lfx1/za
 A8wYnPudVRRL7DYA/uD/73xKN8T28S+VNOt+ouD/4630TMO6I8B5MTq9x9aiqoGaR7DN
 +IBrTGULLwwkocXYVTYhMlTnZN7a8lTmeE/6Svdwg+3S3ydgVWyVkFUV/3vrw+yqMznP
 M97w==
X-Gm-Message-State: AOJu0YzCDQ0TpP4BlYbof9BFZ0asLRBeY8ahnppl/MJakM+KCCaB4Ylo
 sR6yITxZfq4l6kNwQ7A1tu6yDu+h57NJvD3Aa+TdPpXdrTYtm3nzhNcE8JAQueFLv+O6oknVT5D
 51nXO
X-Gm-Gg: AZuq6aK+V+I3shgXMRNokDa0820JIm+oKJgixPehAnk++osvE2FHpNlOa41QpaPPOWz
 4Y/+Tu6s+ib4BOR7eRHRQTnuW0RJjotHl8LSILwrpM1HonpCjQCpzbQUO1p6/gnMgpmQ4jhZFyu
 cUGDsbB9hQBwWtgZUZ/KqcE34rhXXV+G18f/PEdqGoYTrZPjZfy2Fl6rkTtj7u/BVbHdDRjsk6M
 IX1xSJUQcgHV3OV6LIoh8E3CaaDNt1H+AVIWwT/GFNm5F/kWcnIVQziOLTBasPWt3qBs4OKJOzD
 vMNRTi/vhRuINeeSzusts1xvkdHsWCXmIKLLanfBQ7As2IZl7yNCF23B15Br3mRh76FmgYIAuNc
 c6NzUbDwOzSm8RuD0YVYvhTJpxtycMVnexsvJTgekvb+04RTUaEA9W8bSSrmu40n8GROS+/RE7G
 N4YBQHf9XeDmH/qeP/vrdPmu78FN7U8rlf+lj12p0FytV8YvTuwg==
X-Received: by 2002:a05:600c:4e50:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-4801e34dfdamr263004345e9.33.1769029712590; 
 Wed, 21 Jan 2026 13:08:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v12 8/8] test: re-enable format-truncation warnings
Date: Wed, 21 Jan 2026 13:06:28 -0800
Message-ID: <20260121210810.1044276-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..48874037eb 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -261,7 +261,6 @@ cflags += no_shadow_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

