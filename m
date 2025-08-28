Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC2CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 07:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 461504027D;
	Thu, 28 Aug 2025 09:40:12 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 64B794025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 09:40:10 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a20c51c40so4716985e9.3
 for <dev@dpdk.org>; Thu, 28 Aug 2025 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1756366809; x=1756971609; darn=dpdk.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owmVYyb6N/nWJ/WSjGR5ersxoj5znKEbhfitR9sSSRs=;
 b=Qg/WD52gp79KyDhHSHCRsib8WD1vE26oQYtDiy4T/ZffR20xuW8s2VytFhaXzfZ7M6
 H+gTh4LZM2tA3/hgq1lUY6BzIvImD4Fg6M6+HhNpjRThDyPhkHYZPRONdHdtJ2azxscb
 c5zGlzycdQ0BwLVgDweTg3T5a6PMaGQzdpC8ViU5lv2eZaPKEpmU5xlMX0SH0K9iEM+q
 hS1fykRz3QwUjuk4zPo/VJpkoGN3zv7PEokGGfLPWMddDOg0xHEdlODv6+cvmq3hkRyS
 qGZhah0Mg+d8CG5p4WKrL3BcXw3EtFEPOKe6c8Jl9G3kroMoWsLDJXah9VcqeNHgQ3nI
 jXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756366809; x=1756971609;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=owmVYyb6N/nWJ/WSjGR5ersxoj5znKEbhfitR9sSSRs=;
 b=aOPWe7w+4JK89BuDBu4W3tRtgulMy2jiQZXTtW7w970fuCREpIV4K2ay5+UbauKisx
 6OQykie7gX/u9PsNrfuH3aYv+LoVNiOUyblO0GjZ8v142TpyvmAoUAqyrvdQX8X6Vtpi
 wcx3xefmjmHJurZJAVPpzlXwpEgCZ8FOPxMO3yUuggJ5w5YmaNtoLlg23Cvhoxlq48a2
 8RlQtsveB82Wuu5JDG3wg31ps12X6onmsTgbDveMjFKTW6LJgz3xEBHGzHnfRuilgY78
 q5jDCizGRsePzPMJXuZQ/oDwStZHiP6RPGJYDjhfSB3xMfKJ4FI5440x2X258ZfFXV00
 SsBA==
X-Gm-Message-State: AOJu0YzQWv8clTSY+MrCAh/APBZgVtMv1B/TTfxtD75FMlGJfLwFHnA+
 lWvLGbu6G+mVIk2EwWF7E4MQI8UEYQIdyqOp5dWFfQ79XZKwN3a9ffOivruM5nGs6EVIAGpuMkq
 nFYa9aOIN
X-Gm-Gg: ASbGncttYyvWOEMnq4Khs9O2j1LPpjXJdIehMkk33Lv8ZS4NtaIn+HbslA2+0Ss6AEz
 Als0j6grzi9b4MynUIfpR7/gEgEr7BA0GdUoWWDkHYosWNV36bQUbUHdJbLloinPch+n4Otqw6b
 E4I2+xfJZvKf706TXn62NQAkOLTKR9qTMahAENCG61cu0xjrLVTCySZZ1yFLloSimoy/Yfdzjqo
 kCBXzCp8LoYHrjKR3ELe17Ex7SqaJFIxVwz38rGe2IGu7O4y3MGFjW3wzpJ5mGSlRJmukQfOGLF
 U6uW7/9epq0H/Y0Tp+XBQnU/UNkupR3JwrnaYXjPwYEZGD0IrdmX6wdsEXZ+AboJF5hnYibkckv
 JoHyUAjkIIZDOAdye2qIMShuvzLrt09UyA3wN/A==
X-Google-Smtp-Source: AGHT+IEdPTdqiefZ4XsoxVqHWJduYsjBC0O0QVC6Lvz7ON0mcKIlgKa4QCwKxeKxw9OhAwFro7XMzA==
X-Received: by 2002:a05:600c:a48:b0:455:f59e:fdaa with SMTP id
 5b1f17b1804b1-45b517c5db5mr164042295e9.21.1756366808952; 
 Thu, 28 Aug 2025 00:40:08 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797ce6d4sm19229345e9.14.2025.08.28.00.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 00:40:08 -0700 (PDT)
Message-ID: <976dc985-91b7-4fb3-8df7-5b807b1a65c2@6wind.com>
Date: Thu, 28 Aug 2025 09:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dev@dpdk.org
Cc: Olivier Matz <olivier.matz@6wind.com>, dsinghrawat@marvell.com,
 palok@marvell.com, jerinj@marvell.com,
 Laurent Hardy <laurent.hardy@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>
From: Thierry Herbelot <thierry.herbelot@6wind.com>
Subject: net/qede: workaround for operation in Ubuntu-24.04
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello,

qede stopped working with recent distributions, as explained in this bug 
report:
https://bugs.dpdk.org/show_bug.cgi?id=1379

For reference, one workaround is to disable all optimizations when 
compiling the qede PMD with gcc-13:

diff --git a/drivers/net/qede/base/meson.build 
b/drivers/net/qede/base/meson.build
index 4ad177b478b7..a35ccbfc677f 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -50,6 +50,7 @@ foreach flag: error_cflags
                  c_args += flag
          endif
  endforeach
+c_args += '-O0'

  base_lib = static_library('qede_base', sources,
      dependencies: [static_rte_net, static_rte_bus_pci],
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index 3783e24db708..642a47da1e98 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -23,3 +23,4 @@ sources = files(
  if cc.has_argument('-Wno-format-nonliteral')
      cflags += '-Wno-format-nonliteral'
  endif
+cflags += '-O0'

This enables operation with QL41xxx and QL45xxx NICs.

	Best regards

	Thierry

-- 
Thierry Herbelot

