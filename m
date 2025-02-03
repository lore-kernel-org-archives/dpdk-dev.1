Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75100C02192
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 16:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B80540265;
	Mon,  3 Feb 2025 17:22:02 +0100 (CET)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mails.dpdk.org (Postfix) with ESMTP id 19B4440264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 17:22:01 +0100 (CET)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-30241e6b540so2758861fa.3
 for <dev@dpdk.org>; Mon, 03 Feb 2025 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738599720; x=1739204520; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wsmCrZFqE0WlmN5roivxnNfEeYVxMERXInFYe9cjTJM=;
 b=TovaurW9+qVPhCHBKLYHI+uVZJT5RLu28Ztafry12OtWrBqncyjFL7JNs9QGBr05ZR
 Tf9dnJsW+Uqa8XYMW03MhnCmnHqMZRTh+KL75Bbg+1ZEh0DusITabgI8cbHhq2CuC6Ci
 89x25C9ezON5AF80D8pDUV4DvGoxD/WDYYZb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738599720; x=1739204520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsmCrZFqE0WlmN5roivxnNfEeYVxMERXInFYe9cjTJM=;
 b=UA8L8etBafXBlBbkx2AHAB+eZZQNhHeqPdjnIIMaYP1fJWhEM1Swt+U06dNC2jxNu5
 EWFnipM/2mFQmdri3cNKlp0RsFTNubQYWUC+JmJj3fEGRE6CwxFclRTd0ySgog38fjMT
 pZa3F35F0Yv/xzoUhXBOkRJjpS7Kw1nD4jrYPeMwfhX7NGtpxuypAEVPtp2QPGfQ0Viw
 PSaxDiq0y3IUGTG0FPO5dFTXEtkURObPBsOukuWnkseSbaNMYA6lDgClI+IQPwYiQq0a
 Rv9gVfEKR3ZQkHJO/VBxkutIN4POvec5oCHG7iGG7G1kALT804S43/v3LaDM0pA4JUVB
 7PLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkj6BvMabrdWufAqJeFCj0yIpVHYre83V51l1E6xN2yUQ7PxkFFRGmPAoiA7vaZxAF/rY=@dpdk.org
X-Gm-Message-State: AOJu0YxcEbJt8CtG81F2yqzNVL0KPpoqNhJgkXCe2c0k5wAbJIy03FcJ
 +YSJJ2DapyIInvOz1ZBmszUKMBrwuxBvH+oRq4tE6lJ1tYSMlhCAAenN/dJ4rSKAKEUhWlM+ngc
 cva6eJdlOGJD2sihUanNjthJnxJN2V4wm97r/9Q==
X-Gm-Gg: ASbGnctJU1UTLXA9xcqhOoJxe1qY+npyK4BCvVw61wWPIzvFdl5Q9duoOLhU3noV+kZ
 y2zFqIKzPA6XbAMcuxI70lv+RKojRli61JXO/ojngd5ACfKXFMj+2DaP39NVHsbLWW0kC3+1dYm
 fDZC7A9PpxPSOQwvR1tVW3LNUzEUVw8oA=
X-Google-Smtp-Source: AGHT+IGauGm+AS5EAADHo2D4FSCigZlampuQmWxMtkWInpkTt1GaXHmISBkpbagZx/LlFgBzViYH+o9k6aPSsVVLCLY=
X-Received: by 2002:a05:651c:1501:b0:300:3a15:8f18 with SMTP id
 38308e7fff4ca-307a0ff9689mr21198221fa.0.1738599720414; Mon, 03 Feb 2025
 08:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20250131193803.168498-1-npratte@iol.unh.edu>
 <20250131193803.168498-3-npratte@iol.unh.edu>
 <32f36fbd-7cc0-4ef6-94a7-54b8b392f205@arm.com>
In-Reply-To: <32f36fbd-7cc0-4ef6-94a7-54b8b392f205@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Mon, 3 Feb 2025 11:21:48 -0500
X-Gm-Features: AWEUYZkYqXcTKKTuJzMQTXQaVSkicoPfFwUXeWQAb7Zou7BPcfeV3q-9LdR2K9s
Message-ID: <CAKXZ7eiPCYQONWwCgZ7ee_9WVa-=Z5sJ2phZveAEid-A4nhv+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: rework run-time MTU adjustment test case
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: yoan.picchi@foss.arm.com, thomas@monjalon.net, probb@iol.unh.edu, 
 Honnappa.Nagarahalli@arm.com, stephen@networkplumber.org, 
 paul.szczepanek@arm.com, dmarx@iol.unh.edu, thomas.wilks@arm.com, 
 ian.stokes@intel.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

<snip>
>
> The start and stop could be grouped by forwarding sections:
>
>    set_mtu()
>
>    start()
>    assess()
>    assess()
>    stop()
>
>    set_mtu()
>    ...

Alright, I'll fix that real quick!
