Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8423BD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 201E542709;
	Wed, 14 Jan 2026 23:25:57 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 160D742798
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:55 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so3129455e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429555;
 x=1769034355; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtZhsEytm/IH2LQPDf5kgHnF2xnLeXs/9/DQsxeLN9w=;
 b=yK++YDead8YNqzDxhs6Zzk4uy+uQaDcSpgWvEoegdLpwXD9zNEG0MX+0WEPdp1r/zG
 f69wlaAkNNo9gBqbjzNsZOlly8kq+V86Y7rigIVZ/22pl+UbiEQh3HwystjAgHgs16y/
 kLCFY0eWmI7tFaNsGwNkxJz9ijp4H25yl8LkpzRWjCwhS6cMU+wRGhXd+Xr3mHIuftMn
 oF4f6TlpWO6f4bxjRAESIwwATZMok+z2dXiz8X9lfQEpf2ukIKIHI48w+ck7nSU7B0vT
 3fvphxPlgWMIOJU4hlM5UeM85iG0wxSan6X1iFajp+FEXF5bnjg75ozf5CoT9rrGyM8H
 cYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429555; x=1769034355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtZhsEytm/IH2LQPDf5kgHnF2xnLeXs/9/DQsxeLN9w=;
 b=PLm6Qoh8649zrI/Wp2ZGbINZnV6zmi5yyFsSevTwuOURGwpBtiVElX8RZ6SzsKq/y6
 ZF/mPOSFFN/tHzUu83cMqBlCELYinhr2UP0JRBGeFNJrTjnkgoGPcOl1oY/2nz/G9TLC
 noSaF63GPy5jNLVfkqMWDN5kSP071DqbpLzrtdxMoSi2u8y8avcDFWaJl9iPlpOSxYL+
 BNlDeANliktlLrXuJTX0Pcjdc1rDVawnUpDHIgctt78ivGobda5iW0ePO4aqJ505O9P8
 XraHsjiIiVtx31mP5BTDCLIpykhhLHz9Od3TMnvzjENuIXY8NjvT8J2CezbNtsEarfga
 qzrQ==
X-Gm-Message-State: AOJu0YxqP8hGlUjKoa9rOKkoIX+66fXvU7IEW0QP4rDwOo9qQ7s4Cy8i
 knqgeX/05eGb4llQxgGKo1oF98J+uql0VPtNZuK/3XxUUclcx0ytiohIQ9TV7unEh7OZcmCtDE7
 AjfZG
X-Gm-Gg: AY/fxX7ySClW0klrqS4fFGdkuYzvXVrcXCSLYrNFF0Z3So6vgIHL8t2LzfrDnWhfI5/
 32zUpxwNzwvPWx0oU42UuQHCyJATUL0OgH27nvG9tzzPiIA/QxWWSMo12uK7ruENeKv6PLVvqMA
 zONykgSAl7HDJcpjRSTWV+h93/lSW/xTZbYu0Va7Js1b4mSlqCcoH69iyCq2/EmWbUoojPpAphp
 CBcA2jLA+bVjQvCfQLpj8DNtbpi6c/zwZ1fo/V3oRfXD1Y0bSn3GlcKCzpBYay05JlCX5zA8SJT
 Hyet7vELdLU6Isi+VG5VG8Jkfl5Izwdpk9kRUyihT9Z3v3NGVh2F1DZI6OjvtuGBHCl1GEOTzZ3
 aWfDimLvH/iXBtU3roCF0mTKAt95DYEaZwAdyx/JXH4OWpQpLWiumfz0Zka3gWA31eEYVKvxyw8
 npSiDjUGjlH1vrgDnEy01i5ZvVZuLlCkwyb7dpZEjKIL+ySN6W3A==
X-Received: by 2002:a05:600c:3ba4:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47ee334f7b8mr53544625e9.22.1768429554686; 
 Wed, 14 Jan 2026 14:25:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 29/29] fix pipeline
Date: Wed, 14 Jan 2026 14:22:10 -0800
Message-ID: <20260114222458.87119-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

---
 doc/guides/sample_app_ug/test_pipeline.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 40c530af57..686ce152cf 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -30,7 +30,7 @@ The application uses three CPU cores:
 
 Compiling the Application
 -------------------------
-To compile the sample application, see :doc:`compiling`.
+To compile the sample application see :doc:`compiling`
 
 The application is located in the ``dpdk/<build_dir>/app`` directory.
 
@@ -149,7 +149,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | At run time, core A is creating the following lookup  |
    |       |                        |                                                          | key and storing it into the packet meta data for      |
-   |       |                        |                                                          | core B to use for table lookup:                    |
+   |       |                        |                                                          | core B to use for table lookup:                       |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | [destination IPv4 address, 28 bytes of 0]             |
    |       |                        |                                                          |                                                       |
-- 
2.51.0

