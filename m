Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDABCF9C42
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 686DB40613;
	Thu, 20 Nov 2025 17:23:43 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4AF4F40431
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:23:40 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2953e415b27so13215255ad.2
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763655819;
 x=1764260619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUEql0CZZcFWo+XSFT3zB1JbeSKgzOFqtwj3oEjP22Y=;
 b=SzFQfsUVCeRglA4tJn09fzi1dxCgGYFbcYr4vYQS00nn+FZIqGv96knRLaNgGW6ELO
 G221Gl2ruih2csNVXVG+Mo2Ycs8XqiOZljfn67y3qkoK6bfDdOs6LEbF8l1a2vqfDE6e
 ATtjzAkAmhiVbqguZpi/rWs2JVQMqEhOb3eEm+TPjEtu97m/HkfxAV3oXKD7eCo7lWIK
 Mz6ET1A0ZO2+4+zEZPdVi1WGAfkh2VULuGPX5jpzBRUFfPR6KXQMHoWIFwS1AFO4sE+7
 QRgT8R49lJmmzf8zauFIROn9EyO4L5eAUf7ZXJ79Lf/Q4wWEwz1GiYAcuDEVGB3EOIUD
 qWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655819; x=1764260619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUEql0CZZcFWo+XSFT3zB1JbeSKgzOFqtwj3oEjP22Y=;
 b=C7LAxvccDoKFbRPNbSyNayep5v3xq4M1lozC43xK8JBYB4sYFx8lJIPSgQaACIBQal
 tAl7wErCT2enV1K9wtfDfewUq8//dimtzCuwyq4fE0v0z5tbidEfSMfm44YAAc3lShw7
 Od8L3RYTixRK1y0s+XtUaSK9KsLBP0XMzI5rvsm9a0GUIYFQksZz+BHLWX4d9wc5u8JK
 Usjuh82Rz51NPluzc9RkSBGqAlLO63+NFNe7wq/VITDNa7q3N6xRfxLwtW3zUK0oBSoa
 IP6XY8UTSKDCyXa1rRMYIy0wJw+v2oHeebq4eSier+dmHvWW0kO7Hb122wugOo9/lUSb
 vtyA==
X-Gm-Message-State: AOJu0YwXWzxfO3qR+Z6D7YQKF8sqcsIjULT9ALEgvRfIanv9/zAuPJTn
 8OV8TWQ7p3DsOymeRYC1De402Jt+pt7ydYQDhCA/p++SXnqBkW6xER3bPI/cyYd45526F2zb/17
 f797R
X-Gm-Gg: ASbGnctunYKG75AguxliMMKoaB6yNLOrCDKkKrkgU1DMPOlf4h8RX0UEBE9yivcRIe+
 g2Zqadkh0mo278oztXArpwUCXTiO7hazFgtXyL9nfR35FcJtFhxG1m4H9XweuZNHi/R97c6EYQJ
 /tt3jeX/BEa4gbJJGcBEiEKYyYBX+qUHHi5ftlW+l/oeXWgPeLMzgDTWldGr69wMcQApcRJbhOr
 Bix2wZiapWPi49tGIfa5yngkZb9FE+l6J1VmTq3SS1OX10PEUH1V8hkd8k/SieOVZilSjW8twlW
 nXUkLtaAZsz5MR5FCDfy48jTkICp8gKMT22Q0EleVnNL4aIRBZF3/eZsAZGi5YuRdIEkSDcZoyu
 1Kd3BThsHrjtvwvrA725GPZ3WCVn8VJBS5dOtMFSAvi81E83ekxLK7EZX9qlflzn/w6ouT4R0zI
 L3uL9rQei7fyUCPSoa9vk2R2eFUpWgNGwknD83lzkUlrGBgR8fLv3mk0n8fNY+
X-Google-Smtp-Source: AGHT+IHVB+PwYybuK8w1Bz0iYz6i7BX4XDjZ8PsdQLxVpETsVN8QaqyK8SD8g9RDkkQ1sccXtlfqEQ==
X-Received: by 2002:a05:7022:6726:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-11c937305a6mr2152796c88.0.1763655816786; 
 Thu, 20 Nov 2025 08:23:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e3e945sm12096427c88.6.2025.11.20.08.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:23:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 4/4] examples: enable format truncation warning
Date: Thu, 20 Nov 2025 08:22:02 -0800
Message-ID: <20251120162327.78062-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120162327.78062-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251120162327.78062-1-stephen@networkplumber.org>
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

There were several hidden bugs in examples because format
truncation warning was disabled.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..25d9c88457 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -78,10 +78,9 @@ else
     examples = get_option('examples').split(',')
     allow_skips = false # error out if we can't build a requested app
 endif
+
 default_cflags = machine_args
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
+
 default_ldflags = dpdk_extra_ldflags
 if get_option('default_library') == 'static' and not is_windows
     default_ldflags += ['-Wl,--export-dynamic']
-- 
2.51.0

