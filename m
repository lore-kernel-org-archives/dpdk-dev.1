Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C328DEE4997
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7A25402A0;
	Tue, 30 Dec 2025 19:29:18 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E60AA40267
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:29:17 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so19322315e9.2
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767119357;
 x=1767724157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEf32X5Ol3BLVNGcI5cm8yV1Tb45So1h0+lbgaLk/4Y=;
 b=bufZr6Lx6CrJ9QnWSAVzVlm5xDZMfkOVNl+aKzqFwUSLpnL3GUllwbNPy1mTyS07S9
 IZ34gTkasDPGef7LIUn67iEOOoaf0LoVbp8w9hqFuk8dJFltoJhq2esWkBGedC2uMmWw
 R9tQ5Z9nMC5ZmQ3XM3jePx+bYqP9CuehQbgVAxZCcxzfUmLxTEUtsJaza0Fdba/QymfQ
 1Z84Dg2c6wFhvY1GGznuwlVB0HxsssoHiK+JJd2ZVyqfkrsP9vnxlxFwF45M80p/CfWw
 R+9vaQSttEg3YqIyokVHkVlAt/xiyN8A/Rfzoe1Ki7paGKLQg9N8L24pzxWXmvLXSB/y
 2Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767119357; x=1767724157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SEf32X5Ol3BLVNGcI5cm8yV1Tb45So1h0+lbgaLk/4Y=;
 b=e22e0YFlIIEdjmfIRKDgFiX4mDqId2J0FDNcOVMWlxZQMBEHiZ6SA7NB6MebbvjN3Y
 AqyA2k9nKaYS8GnOxMQottt6TcnVHP8tbf+3Jo+wtl0Fs6N/PhVtiujSS0m5zpHlLD5R
 JsooQLtUFu73XFDI2r2vCJW4L6OxrHsEIGkl0bWKOrZwnJt1A1dLgk9MHKLa+6vF4I8v
 h80Abcaj2/MFn9EwEbBVzTr3Fod6VMUWLrB2RidCpwceISOCtQ4o0evMBmeHClojBeB1
 xgUcRNuKxf55TyroOy19RPiDnaTIPTEjg6QOSiq5WndjhGrKmslIyqI81RinAqEBdtH1
 4uXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmSjHjb+qglFv0hNPecP6glI4VEc6wa71gwD31UcJLirPmc24ZftZXkMXJ3Z4VHF2eoKU=@dpdk.org
X-Gm-Message-State: AOJu0YzABlgU9iUTEGMq3KYAsqQdYgroqH+cIgMccgDihONjZ2hFtzfZ
 jCHW3SGdaVhBJHbXmGWDb2OHB6bS0YJCjLOZbh7o04ShKk3JgF6AnycBHvzgdDG49HsZB5Fxwoo
 FC3D9FEA=
X-Gm-Gg: AY/fxX5alu5pi0qxa3CCfpj8QPxMgEX+jyz87y/ylwGRy/qb53DqCkpd22oVkYLPm/C
 hniuWMF1WjN/CW3TJ3y3Bz4X4fsxNRlShBKfPkjqCIega5Rc/GMXgzkQIeR3FIS+2iPiwGq31Je
 hL4ZgaTuylf30t6oZUrHVEtTyh11vMl7vnKtJHWH0k78TugAKNQV83tBzbLPca69xfn0QQUmH3b
 cfwY6Y2XiIMvUTdQDeCsqcmQWissthi6vHHBTqqcmxUI5zd5FgxEfJOMboaD88+vSWTa9/6VzCm
 3qnU+81Fm0OwClDaGjNZAy06hN9DWkAysitNMNQmcfSVroOsx3QrvQMHgJC4DA4KP6QoqAX6lqj
 bp+2DBGytxeOAgtn3/RN5/6A1UTwX/AY5EDUOQ/p0Ck4HuIQsIMv0d43M1oGDGXYEEqFiWO7HzK
 5Kp2vmzHKUbrRkvu35V0mm54hjGQYDQgsOrlqsOr/HDoc+egesIYzqHoFFYUnuG1U=
X-Google-Smtp-Source: AGHT+IEiYq+VBxA0gxr5ZmYu8JVooAb7DZ1rS8wMClJugQCbesnKemfKxwggy8J8LqgsdtjXAPGphg==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-47d1953b3bemr376940725e9.3.1767119357413; 
 Tue, 30 Dec 2025 10:29:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c6ebsm272033005e9.4.2025.12.30.10.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:29:17 -0800 (PST)
Date: Tue, 30 Dec 2025 10:29:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v2 1/2] net/zxdh: add pcie bar channel check
Message-ID: <20251230102911.74b72d22@phoenix.local>
In-Reply-To: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
References: <20251222102535.401064-2-zhang.tianhao2@zte.com.cn>
 <20251230081127.813605-1-zhang.tianhao2@zte.com.cn>
 <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
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

On Tue, 30 Dec 2025 16:11:26 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> After obtaining the DTB element register, check if the PCIe link is abnormal.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---

Queued to next-net and fixed the indentation issues reported by checkpatch.
