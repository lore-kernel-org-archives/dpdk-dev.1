Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C532940659;
	Fri, 15 Aug 2025 18:26:54 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 44B9E40666
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:52 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so14277125e9.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275212;
 x=1755880012; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtL21v67XzZiioSeCE+Xq4/SKi2DFPQ8eg0ECcboZLs=;
 b=n9j0jhC2RbUKvyNxv8h8UxQ6AQAWHISEi3Hnq/Jkggu3rbXCCSaePZlY4im4+xQaaW
 qjWBM3I7xFSif/heo5tyoSqjpS/vFZHrs+4uQXNn6z0XLI/+xRx+apCugmkNM6LIAzGg
 yWXteF8j1nNGxt7ESVoP8mLQlKCktktf/2IyfGdZ+y3QGn2ia3U3228fm9HKZh5N2HGR
 0IKL3bbsqxTXyzz+PI98GkQFZlPazTK2aLzmkhQ++I5Rt8J+qf624Gm7cXfP6ILwuloe
 gDQvGHu4dMhZUYO/l80FGK327Kq+74CRreCEWDA4DAyUIxBj7WmdzWi66J3bdW+v5JDj
 6suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275212; x=1755880012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtL21v67XzZiioSeCE+Xq4/SKi2DFPQ8eg0ECcboZLs=;
 b=QrugwTeLvNxM7UKD2LIpkdYIsFqm0YuJD1XQMYADzfoBJKiCEXl9JHSUo14nHzXVhj
 V4EGkhJydsLjHBHzMrcAbvW3/XQ3csfU7iq/+HkY7/psRpf0+P0OpbAqOKHGr/6u7jA5
 H0xaI/W2ns7VIe2vD4gjUFhc3MW0fJwNjBFR15vebSmMsu3RSA5qLM+EfhL0lBAQl3Il
 5G2kJhsvT+P2bwlwEQ9PSI6AMmQpTWG2/w7Ow22xegOYC585IiUNHdMFEcIIVMK0wnms
 lyrmbRN1d2Rtw34pW+M2mxq6tKD3f62gfWdw5cjeCxMWLhnjTMU8+2yBbjVZPiKvrNNN
 vvZg==
X-Gm-Message-State: AOJu0YwJ7WDzNyd5aFuYpjDryP6ljP6qhIbj5MSL/eGe4gbxn25rUsaT
 YIrhfu44cl7tbUFXzxVQUfzoiK3KHO7FrgNARL7ZO8ixfHOTzh6DVEWIeGqzAedCJZtItpPgRcR
 CbGYD
X-Gm-Gg: ASbGncun6ZvaX4AmL1GkpDIqTt0s3fZnuod6CGYcNI9HAx5CkOQVq0s5/4Rmb242vv9
 H7lGtTGezJxh8nlKQbLHyKO51gIDbTFiIU9doKwLdMAPeGT/HfRd9wGMJjLoRGjJ1xrFhU1xPxk
 aiy+ZYEhkF5PKHSxMzBvXbHjZ5zq+XW1WsQlL9Ux2cQtzKJlnimZpH30kzTf7tAYBRCbQV7/iaU
 l8xyujce/ZGpy63S5WGWFN98cZPW5eU8hfDfNt22plBAwxD/CZ9gmuZec/FwV20A2EXnobz0hDM
 e4qI2hwReu4nD3ociSgYRT1YfWGF9M9iTmnAXFGpPPGSB61nKukO9HQvrpNqY/R7aYLGmifvrP8
 zhYHmnYT92IbeIUEuoJAHX+nsQWBIPaQpa/k3ToFcxiQ5gKmhT17wUeqgydP5VKLRwiiX1w7h
X-Google-Smtp-Source: AGHT+IF8b3laBQRiRoladwQUKSY8wEBZoYsGTIKFWlAbyPdhWglVEIPu3Ii0dHt36KO6NlGnDe9z0Q==
X-Received: by 2002:a05:600c:198e:b0:458:6733:fb43 with SMTP id
 5b1f17b1804b1-45a21848ec9mr27059475e9.19.1755275211730; 
 Fri, 15 Aug 2025 09:26:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 7/7] config: enable comma warnings
Date: Fri, 15 Aug 2025 09:26:23 -0700
Message-ID: <20250815162629.161782-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
uses of the comma operator.

Don't enable it for drivers since many drivers still use
comma operator unnecessarily.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 config/meson.build  | 1 +
 drivers/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..d9ff0e31c0 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -313,6 +313,7 @@ endif
 global_cflags = [
         # additional warnings in alphabetical order
         '-Wcast-qual',
+        '-Wcomma',
         '-Wdeprecated',
         '-Wformat',
         '-Wformat-nonliteral',
diff --git a/drivers/meson.build b/drivers/meson.build
index b62880db02..4c08a1dd9d 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -59,7 +59,7 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
+warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']
 foreach cflag:warning_disable_cflags
     if cc.has_argument(cflag)
         default_cflags += cflag
-- 
2.47.2

