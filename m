Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636FCA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEA9740279;
	Sun, 11 Oct 2026 22:12:19 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 8FC784026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:12:18 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so7159535e9.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791749538; x=1792354338; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ILFJiG7Wcr8fEtDwGOLFe0E295oO8Ek8tKzznqv7jv0=;
 b=R0vh3vlLMXlAhLUfWbF1Zl2tWxhGgMgWi40N4dn50gxyVcRJteu8R/2VXKRITGMonZ
 5dl0ddxZ3e0N6tq1jKQkKjMAnH5sS/4s1QjWuEGs7nUAmOnT72wr+odXUHzlkXaQuKJ/
 7g4AK6BrFa6Qe1Eydxc8itb8DVd05owXdGZyYbt/81xWgrN/z7EOHjl5Y3QRGwYw4tl9
 dpTCDEoioD7Zwq7K5hq9e7btP+1Z9yf1ai0q3B//AlzqE6Y9DAOjrcm1VaY4mhMF9LWx
 FxWZdQK4D0cowoDmra3S5UzHmgrUtZ7FcadlbnXLdMsLyCGNJ42TJXBmLk2FAkDzV5uO
 BA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791749538; x=1792354338;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ILFJiG7Wcr8fEtDwGOLFe0E295oO8Ek8tKzznqv7jv0=;
 b=HM0TwZUvB3d2inXvhFhLjAjzCzaceEx8CJ70RH0iN/6JSME8UDVOLAujYiFW0We44V
 zsgh70q6SVBYoow+8KvDzBo+hKKXQuM0eyh5g5cxyh6QAjsSZgOUEqzR4iXZtDLD4ZYl
 u4mRgFYR2zkzg180S65qDChCliFqYv15HvzbTkKGuiyKYe0V30yefhaWRA3LdQnFCFbL
 FHeTXgVi3bpQfbK+K56U5fh0WvnGvGy4BS8Q0qAOzCV8uMrer2rgxpJjcyDpZG3Kz4gR
 lXDEqOtwlpaPkKDXrt+se+rj87byfECrB2mR3jTBR7ZdulfEZq23cFVjNGmGBhLVZqOX
 ObEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuihuoWz038pWaacCoFTwFrQxa3XZEPuY2FjXgTdiqwv/2tU2v+O1k6VlbJ9IKchgTQxQ=@dpdk.org
X-Gm-Message-State: AFq9FYIaPyh65/pCCo8bKjqoTqo4Jwu6yYjrBGKvFbU9mtldYTh8XxHZ
 shuUixD2lKSL9Xghb2EcHY/Xrb+4CVtoWTzgmFa2skScJIQZi9mkmIqm
X-Gm-Gg: AYBFou2w9rYo7LeyDL2mmkxk1uLmWjrEzaBPA+CKr91fsVqdSYovXGHAEUTyFk5YzXE
 7vvmbL5I5UrKfVEcbtBHXei9OZeSq4Xo261kt+MBLVJHf6EvqGFGzlWHFM0f8BOE2GKn2PWIsbV
 pY/G5P3lhKoFvtWclKkEkRgGYlqtLKf/CCIDCpPggdNMdEowKU4Guey6PDqNECHRHut8sqkS+KT
 oUIZRp+NEs8euGJVqm+16iZe4xerwsveA5QVJPYjYfEzRM3KpJkikJMeNvbZW7A3XQa+D6h2eER
 ubpmyfEl05rn3I6fzuY6gm3LpEsVB8klZpwGnWJDk0V7aEVq9f7rFd1YVfLCCzSy0ZAaYy91rNw
 13WEY3sBn4eih8OMPBkJ9OPQe/5hPnOQSeSDCREM6WZMsaqxNlpztS/HRA7JIsaoONCyFMoI8UJ
 jK20xYX5RjeCpKZpuXcxjy834nb8Y01VxhtImtGEK9/BQaiv3qb0rl5ZmJ1rvU9y6CCNE=
X-Received: by 2002:a05:600c:4f10:b0:4a0:d1f4:b1d1 with SMTP id
 5b1f17b1804b1-4a18e4bff89mr167049485e9.24.1791749537676; 
 Sun, 11 Oct 2026 13:12:17 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.57.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19ba624b3sm90021795e9.2.2026.10.11.13.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 13:12:17 -0700 (PDT)
Message-ID: <76317fc7-172f-46d7-ba1d-9f0024db61d9@gmail.com>
Date: Sun, 11 Oct 2026 21:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] bpf: add callback flag to skip multi-thread check
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-5-qm2k21@gmail.com>
 <20261011124832.74d0d174@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261011124832.74d0d174@phoenix.local>
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

> Rather than introduce another flag, I would rather the application
> do the right thing. It can just not set the offload flag.

I can imagine a complex app where this new flag would make user's life 
easier when switching to a new version.

We can always skip this patch if there is no consensus, nothing depends 
on it.

