Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F007C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 20:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2A2440E2B;
	Mon, 21 Sep 2026 22:15:57 +0200 (CEST)
Received: from mail-ed2-f40.google.com (mail-ed2-f40.google.com
 [74.125.228.104])
 by mails.dpdk.org (Postfix) with ESMTP id AB0CC40B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 22:15:56 +0200 (CEST)
Received: by mail-ed2-f40.google.com with SMTP id
 4fb4d7f45d1cf-6a60590a85cso6455421a12.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790021756; x=1790626556; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PlP+9A30OnYTHaKclN7cug+J6aRTh/yBgAOyKnJLkk0=;
 b=RIgqQqDpdo6zqxry5frU0M6IxdePHdmxwW1vTlU2FIW4X3NlIRZJKPGBehnnJj7Gk+
 YHqHptJrWZpHSyW1MCE95bfQumHnz1pj5gS88g9VVvMBHjrP3F9NYJTQurikGljHVsrR
 /Xdm67Qi60vP2apeF2ThNBJgor6fOdM0Kxoc8V8JNQRKC41DIcYR9CDOufANpCntS0Jt
 7QlYEZXPrLtWJqhInRbBlfK8vrEiECKXILaaO/zn8HXhqyuIuhELBZKsIVzWJ3DuGjRw
 bcbWxNIIJLhcm5az70gJHtuKBDaJZCDgHi5wEZu6FyrQXWpU9/pVFWrmBJNLJrYiXYjE
 oECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790021756; x=1790626556;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PlP+9A30OnYTHaKclN7cug+J6aRTh/yBgAOyKnJLkk0=;
 b=dnz3MjIOSrH4jT0at5Q4ofRSzynPgkV4UO2d6MfPHW790rdNXxKkKJCL4T4SYLtIxz
 9PFRQ9FBp5ydZgTgkDWOVJsGA82bfMTvuo9pHUx86sHJtbnna6zMk4WE/YkpVmRRjTX1
 BoUrKKg+c/5iX2iUENBTLhhgRnMqO0tOUQdjqKQzXKVPz+oZ1r5D4zxNeyB8lm+abr00
 e7puwM3YuFQcPx8q33I5bo41DFipM5JfN3pPfRUBlitJ8VjseFhap8lebD7kFQwemRlP
 U3P4DNoRVp/bIyZ8um5FmZt4PuCs2kWfbS2YSE8mfSVINbh/3ENIWTazqnWzEmQmCFaP
 MWiQ==
X-Gm-Message-State: AFuF++l91DKCxYOQxWJ/nSr2DGHet/5FyduSSbbvqI/algLGvph23Otv
 yrAICN7b4x6kM1T/37ugqpRrATzqoQSpGI54lej4qLJokXlfRbh4D6eqAJswH6Nf
X-Gm-Gg: AYBFou3NgDqxNK86vQ84tifXp0i9o/FCPBNcBbfiL7xQeHQ+pXHpmIobiq4ByG32vEB
 zo+UuChYQJSH6KIh2RoOEbWwJF2uXg4Zvcyw5xB22yfjP9+F0DCc0ER/K18jvbdaOG5+T4h3YpL
 FVIePBcWaru+F/zEXOaxdUl7v59rf1zzWfHBA4vX60X3nAKQJSw2uaw/jyU710wPgf31gtM/Fip
 96vBIpsc8ErEwN8Di83pMPaV+ZfJ/hOBWCLXlsGL0lAdkwdVHufqVWxXHXOK+TtIn2PAra4sGzq
 TqeJ8dGGluLM9kTM/UJvZyyqzgZf61k+RXelW5GugkUkoEuAMt6gkvaPm6utmm6A3j83fLYVHFH
 qhgWYH/XZN+Of2BszYZvkS0Mh08bhbOCuAGu5vIKnBv8gZlESIVxg8IwHMTcYO6vjykrYQv10SG
 6Zijii2go5qazpLpP1RFcVwBruvd5DT29yKcclxq/9ZSJ3FGD+lW14QnvHAsxmNA8Yyg==
X-Received: by 2002:a05:6402:1913:b0:6aa:48e8:3273 with SMTP id
 4fb4d7f45d1cf-6aa5798181dmr9968415a12.26.1790021756039; 
 Mon, 21 Sep 2026 13:15:56 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.40.14])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aaa1264d99sm135256a12.16.2026.09.21.13.15.52
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 13:15:54 -0700 (PDT)
Message-ID: <643ed06a-0aec-4eeb-bbca-1a2ed5ff4f98@gmail.com>
Date: Mon, 21 Sep 2026 21:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] test/bpf: remove redundant library guard
To: dev@dpdk.org
References: <20260805090350.37661-1-marat.khalili@huawei.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260805090350.37661-1-marat.khalili@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Persistent loongarch-unit-testing errors do not seem to be related to 
the patch since the first test failure happens before the bpf_autotest 
is even reached: 
https://mails.dpdk.org/archives/test-report/2026-August/1034609.html

