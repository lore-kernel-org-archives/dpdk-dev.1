Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40AC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5051940A6F;
	Mon,  7 Apr 2025 17:13:29 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1F57F40261
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:13:28 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22401f4d35aso48574365ad.2
 for <dev@dpdk.org>; Mon, 07 Apr 2025 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744038807;
 x=1744643607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0JK6pgXzR5v2Y2bA4QjvfTKgOEhCUv/w6XEEc3h5Zg=;
 b=VZr72N8bCEdw0vLZuUbgKVFta/2hkYu4vGTXFFoNimtkKwEOZN9zFDodLlsa1Iwhro
 y1Dccmn4vh40YleNUbazbietyVA0VMnKZSPACPPH4i6o8PaxiHtbDFkAM1unMtygo35h
 CT/p+NHZK9+RrkciD+dB4Q3qh/lrRdSH65R8LfndSDuuUXRiqf0nXtpuu5J0gessCpen
 iJQd77U9Hpn/Ga+wT0L4m6VBz8RELd+whwxyRPkQedcvC/Y7A6uuh2ueWHZ7NU3PM66x
 O2akkKdB7I2FVGGbgay83cz2Bazbs9qA0OLniAFS4NCiZpVs8s0W//AQDiafCS1JKY87
 QkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038807; x=1744643607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0JK6pgXzR5v2Y2bA4QjvfTKgOEhCUv/w6XEEc3h5Zg=;
 b=Tpc+wHUjx7l4KHFnzo/2fomk8W8AqDDZlLLPP3lz0MQYNFeLBeorXGkV+lniPiDiaW
 sGe6GOdYzxgXnth7l1j3xdTv8w5wtYGlUB0hrE0WW119kpwORvZwyY7OQZV3RPloQj1I
 qXTRLQ699hOtMV3Oxv93AREqoyuk2UhcXX/8yGUE4cikkKdC0GHoE8z5iSnw1SzYbTMO
 C+COLf8ImLifeWM6ELiy9KYeAvOnqGmZoXkCv7WkwMUPHs+MQqbM3ZOPvJEHco3ze9xe
 fKVAYdB40yxhBmp6+umSzH7hMi48NUyoFj6y3V62qainpf6d+lJuDD+hUY77N5ujxFVY
 nIXA==
X-Gm-Message-State: AOJu0YxJWOF0x2si2QaZusonTHo4lesPSh5VAOpMdgfju+dIQLzEQX2f
 uKhhai8kWwO/k5Hp89Jh/JYqWFdDmpRprK0Cqcs0b7oS7Qv98lB7L6ZOTQ+sL7gWb1DGA/F0517
 4ewI=
X-Gm-Gg: ASbGncsBL5gHSggyNPa/+ysUjbbtSxeIVtfZ8kOhDETL/yehGS9K5ve3okUl8JDJE96
 7eXWwoihNJ/a3v4W4UmvI2eRyydhwKJ5iT+e9OYA2tlR0Gipry9N8cuzrZgVWW07DPYKrSn09hI
 RULgX98/0rSrI12RGXrzVgk4UBhjcubsLvAeBrLznswOGfzOjFbka6U67wTr/imdkCcyX7QU2HJ
 pnjtDfCsHFwVWbYpjGiPiEMVrvNwGnFpHNEbKPREc7OtonhpdFL7EwqfEirogYWpcWfDrVZCgtp
 i5T3K+QEPEtr0OP5185tVeLXmAnKLkpwvA5afedW5Zq/wLrj3Yn8JG1Yt3bNi3X3LvhxAuVBfHX
 LX8Rk3cgb8sCTdiSyrrJ1
X-Google-Smtp-Source: AGHT+IG9FqKWXwJKel/OODuOr264Pf6RcDwTDhqP2JGUNtHEhldG5onK95yd+R5xVm6XoG3VXR0TtA==
X-Received: by 2002:a17:903:40ce:b0:224:e2a:9ff5 with SMTP id
 d9443c01a7336-22a955165a3mr139934195ad.9.1744038807223; 
 Mon, 07 Apr 2025 08:13:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978776601sm82076275ad.237.2025.04.07.08.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:13:27 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:13:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 1/4] usertools/dpdk-devbind: add bind/unbind for
 platform device
Message-ID: <20250407081323.757a7d5b@hermes.local>
In-Reply-To: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed,  2 Apr 2025 06:58:32 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

>  
> +def unbind_platform_one(dev_name):
> +    filename = "/sys/bus/platform/devices/%s/driver" % dev_name
> +
> +    if exists(filename):
> +        try:
> +            f = open(os.path.join(filename, "unbind"), "w")
> +        except OSError as err:
> +            sys.exit("Error: unbind failed for %s - Cannot open %s: %s" %
> +                     (dev_name, os.path.join(filename, "unbind"), err))
> +        f.write(dev_name)
> +        f.close()
> +        filename = "/sys/bus/platform/devices/%s/driver_override" % dev_name
> +        try:
> +            f = open(filename, "w")
> +        except OSError as err:
> +            sys.exit("Error: unbind failed for %s - Cannot open %s: %s" %
> +                     (dev_name, filename, err))
> +        f.write("")
> +        f.close()
> +        print("Successfully unbind platform device %s" % dev_name)
> +

Although other parts of devbind don't use it, the current preferred Python
style is to use f' strings.

Also if you use a "with" block, then the close function is automatic.

Lastly, when I looked at adding vmbus support, it was rejected in favor
the more complete driverctl utility. So at least in theory, this patch
should be rejected, and the functionality moved to driverctl.
