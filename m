Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4CCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 08:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96A9C40656;
	Thu, 28 Aug 2025 10:09:39 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id EB5C64069D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 10:09:37 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b001f55so2864015e9.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1756368577; x=1756973377; darn=dpdk.org;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bkUGm0+dAgzKFuMCprLk/jaT9LbDo+11wLzz80fasA=;
 b=e3fJnt0kVGbM8WWtQjfKTi+38IVVELJGRuDkCFwg1m83/A/pTJxORt6EWYp1iXEJaE
 9vn/zEcmh9JvzePgVAF9iLvstKexdRQySgbBmqa0McPYnftZQA3Vl6OI/4Uo9Vs3ydhe
 FkZWR0IIQ+9EOxi+S6hQo+IVA+0cFIAMmgmIU0CQKTDZubSJJaesqdVnxxqChUOfB+ul
 0npgzhdhEXtVt/LQBfB0R6XSQ58vNauPpPhqpLYQyA06bddKKD/zEycQsj8pvbbZ7pc2
 pUELgQ1JXu+2LxPInm3yKpNoemjZLrliV2nR+XueFC3TcA9y6DX3M7c0tBtl+F0jnpp6
 bTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756368577; x=1756973377;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3bkUGm0+dAgzKFuMCprLk/jaT9LbDo+11wLzz80fasA=;
 b=iuLERA3Ap2tL+9x8oGhopV+CkhUCr5hXCLsvfcXPcNSBtkYYRkKjc2ZfuUNTQwLYdE
 av/BrwXcjBe03erKCgg+mf6m1y4Z/aweqdybM47+9jgvEfb/ozWnSdpRbYq21syj+7x8
 hvw4T8ezAzAdQie2QbjCuSGeBKg0plL8uCY/9mDnozaCysKdamd/sFN1EtsOye/cEp8O
 Jbr4qBOlcI/YQ5QZemOthXZwyLFhANpiTfeMXhO1a77e6DDSMn7CXPvXftfGZqdh70HN
 DoQ2WEdIpWuprXCJDL5CBSJ+AwW4jPu2OPGipAb7DVjY1IoqLlO3qEPA4ZbG+XIwHJVq
 d3IA==
X-Gm-Message-State: AOJu0YwZTI2oGDHo1nSdqDhe2sAl7F2HrcpI2VnMh17mcEX1SA81IC0d
 +e3r9RVvIkmhhAFVDO27cBCjsTPRTXEBofZKcejJpivW4bYfRGM/38c1p1NjQP4Z63/KrI2HP2J
 XeMTE9eoH
X-Gm-Gg: ASbGncuMSmbFJpFLvJtGfkHcGzrOA9KKYcZOcIFtuBCtn8E1ExXe5636gCmZGMQLyrv
 zDsjm/l+7nlfahoEuUZ6n6vwMHgldnQr6ohfW2uUnAPfEU/r08gdOqiyl00obZQ3K2e4FxeE4hy
 Z8ROJmVUY9BtcoLKVSD8lr+yQRtp7HEQqXpgj6rnWBEt585GK6GJANMBrR8OT+VdBcqnhsIdDNi
 BO3NGezdKowEsC8wbVXXzRVbzAxYnRoB1EJbvbPEovGNzhHLl0glqyxuiE9hdiHBTzqykCGTuu2
 3bytxEyvjkkn3q0AFSJ396zdDxDtzUuBe4Kq/Dt1hA4xwEL+0kb7UWlJl+FZNu44mA/NByw7F5x
 hzsO4vZDsr7Mri4naFzcFE3CvqX8IqGNNS9T6DBX6VMLofvZ0
X-Google-Smtp-Source: AGHT+IGVP1N+6Cz8ULPccUCTCOS3P1bdqCWtjoTawVEYHclnq330cmFfJpskiKtVWE0RTPKgEKLnKw==
X-Received: by 2002:a05:600c:1552:b0:459:d3d0:6507 with SMTP id
 5b1f17b1804b1-45b517d9eecmr168347645e9.32.1756368577077; 
 Thu, 28 Aug 2025 01:09:37 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c9c9324dc9sm15010533f8f.3.2025.08.28.01.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 01:09:36 -0700 (PDT)
Message-ID: <3bbf5e67-8acd-47f1-90ea-405f62cbbc4c@6wind.com>
Date: Thu, 28 Aug 2025 10:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thierry Herbelot <thierry.herbelot@6wind.com>
Subject: [RESEND] net/qede: workaround for operation in Ubuntu-24.04
To: dev@dpdk.org
Cc: Olivier Matz <olivier.matz@6wind.com>, dsinghrawat@marvell.com,
 palok@marvell.com, jerinj@marvell.com,
 Laurent Hardy <laurent.hardy@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>
Content-Language: en-US
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

[resend because the original diff was for the 24.11 branch]

qede stopped working with recent distributions, as explained in this bug 
report:
https://bugs.dpdk.org/show_bug.cgi?id=1379

For reference, one workaround is to disable all optimizations when 
compiling the qede PMD with gcc-13, as seen in main branch:

diff --git a/drivers/net/qede/base/meson.build 
b/drivers/net/qede/base/meson.build
index a6dad3ec7bcc..c0d8b8ea979f 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -55,3 +55,4 @@ foreach flag: error_cflags
          base_cflags += flag
      endif
  endforeach
+base_cflags += '-O0'
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5cd..2a06419effff 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,4 @@ sources = files(
  if cc.has_argument('-Wno-format-nonliteral')
      cflags += '-Wno-format-nonliteral'
  endif
+cflags += '-O0'

This enables operation with QL41xxx and QL45xxx NICs.

	Best regards

	Thierry

-- 
Thierry Herbelot

