Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69722D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3466040A6B;
	Sun,  7 Dec 2025 20:13:23 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id B977A40698
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:20 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so29976535e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134800;
 x=1765739600; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=auNjR9qqxvgesKvG3ZChHqDBICFvV/VU2H5NqO9BCqEfmJpn4G/RHY9e7f98HxtB3j
 zdOEQfckr2hm/5k8ZEbYrhmu7ABbMePUHtMWJTEqduaHvIIWydj0j2E2r1ZebafFlmHn
 MLu0yalbaGK49hb81fP6O+ko5b7P8uJZYVWG267vkrcxdcVyajdq4uF6z++yS+8kg7lF
 0XdmvjVLuDh5Xptgd1YiDQZf+ttp7EJVflcAS6Adqqo0vkEKFPWna5Mxmymkleqczrup
 FpO1pHzYe0EztWAmB0GJOlIBM2B78Yojv1rx1zM8wHJfddGWPSNtB0frw5CTZ3RfP35P
 R6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134800; x=1765739600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=UG3UtrCceHr+y8wXtvSnI9y6CYjChKzX+RYkzflTklNbQuH1zqgOdBhBeFhkAcLXMh
 lR7GKqin1hYNV152KpmlVhhUh5JNtbX8lyDbM9Uhe+P50nM5XzVoKwpYsFfDNC7RwKC7
 /6T4ClVJ7bfhVaL9hgIuR5995PSwwuDgptTyY+wOA8P5pp1djeieIqBYNOkyoLfn8y94
 F/c8qtYyHNwssjDQZXX3JuIfZIrxcdPme7M3JUvV2Q8eAmnSdcDcRgXPv8an/Nv4iCXR
 TPcGFPkz0Yk3eeMKNaYDf9QtLqDSj3Jcp51LQ3z2MG29j+E94yPXHwwPt9NROmMiVMw4
 Zr6A==
X-Gm-Message-State: AOJu0YxYvNfPIwVoMhyEdYM0AFeKz6Z5BuTtYvLOppEXmW1Q3f0RmLVq
 f/9DbqggClZcvOB8eJRtl+EEO/OQJTa7QR6ivwZIdpSLaMF1S6+5dJi9Y1LRuaLdRh6SFGWJA/A
 h2LR+
X-Gm-Gg: ASbGncsZGtp9/VSyHRK8QbwkM1vzydk6sXLh5GywELudD6L37mtLUC5Df09ZH6afJyG
 0p29/DYT/pQRgQvm2lOT2p3Hfv4UoGdFaM7EhLRarCJ3r51dV2FJUg6KCcqYN4zGVJTtxj4bZxB
 3/2cyIM1+JnXRwn+p67EuXhEQUC+HgvdejNqRBCNQOzueLI30ch5HDcTWb5fCC2ToV3d0NnrX9j
 dm0uPfFO1FY+ifJZYFmY832qeJHbHYvjAlWYs2+CiPYz4xxBkZ1Q23/VWtlEvHin7ocT7ADHSQf
 zoDC5gMuZaJpLZv6Q8g4UapZa4T/doatXcFxRTLfK4AHi7pvPoCSh8ylAvAxbWpes0ldaCeRCQl
 jRzzHzMo0wXg+yCLeFrvISCyrK4DfYv1VDad8Rk+53tW5RWlnXmeRUegMPhUAaqHcTYDfeo6YTW
 KeH/6QsyQt1IxSb6odJGbxQwSuOVJsPLh3pSF5Inn+XvpyrOFVSQ==
X-Google-Smtp-Source: AGHT+IHQCkEGT/CvPXra87/a9JHDgl5G+tJGb9vE096fVlmxAI4sKHL7JdHLDvf+oIFwLCEnAmVNEA==
X-Received: by 2002:a05:600c:190c:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-47939e32fa9mr52312425e9.27.1765134800333; 
 Sun, 07 Dec 2025 11:13:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 17/17] lib: enable format overflow warnings
Date: Sun,  7 Dec 2025 11:12:08 -0800
Message-ID: <20251207191242.165619-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

