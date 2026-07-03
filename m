Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663EFC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 15:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 515274026F;
	Fri,  3 Jul 2026 17:37:45 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id DF8904003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 17:37:43 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso330254a91.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783093063;
 x=1783697863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bP1+v0+iiH4l1kjuXCYZxbYvXXjNzcGoC2S5MaVxCnY=;
 b=IT/bne/NGKBDOb+YwLzCXeJXkqGwZZnQMLswKc1QeASjIz0OxWBqpulvchXKKTcj7k
 Yugg4ohRgR95qj7VrU6PJu8tGYe+kGwEYl2vYhVkGIOXVxd3y9rJwSIPis0YwC5FM3pv
 YlXPgoayAlwHyAdlaqYS72aRnFNECWFjEkhF0HE+b+W2snp+/z10fvMx9OAQSnGl84yG
 6YGG1tdadd5VMXNPvGw6bdb33guJicZQ2MApVs/coN01OmyBZ20D0Lo1pwcl+F6WTR57
 2LWoNE3U6w38WflE9XOHu7YsRdO16030r2lSyvqdsliWa9qWzKZb5ioiDoKopTz5vEue
 Gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783093063; x=1783697863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bP1+v0+iiH4l1kjuXCYZxbYvXXjNzcGoC2S5MaVxCnY=;
 b=RdUaho8tQd4vl/fZzP8Ita6zOi7DbeRGe9uwkg1kq0heLR0k5h+ZZlHiCacvo0okBx
 vG7ZkIBImPH+WiatK65PC9Oyt6iV1+BJcw2usnF2rt5ON2WHHvfKGLn87sUVoIQ6rTkI
 lIgSHVOkH86sgcPJ2QOOIsO2DCxNivqucTUsBT6n2uBGO3Gpuw73k6YkijAGBLGKxcAr
 S63Jp9UbWoTwlaP7J+uYFIhz2hmnnERhZsB2s4pBzlq9aQZSA4ICJshI1d0MLQkkZ4ko
 3eo2S/7W+VZ9Y//LwWuaSwHPEdALdkT4BqDa6Jlxn55O+gKKYAhwHPD2wJqAeYRpxl1K
 Ki7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxFbds92uHapS65XnCYgqKgNLNGB1zJxbZck7Il5HLeY6s1HK8pfCvjruGis1fiN5h5fw=@dpdk.org
X-Gm-Message-State: AOJu0YwoKi2Dl8fZM+vFLo+1Z9DV5WX3goImVjJ2Nfy0xEbgJPjJ9AMD
 MDUz/SDCylcfIb10O3BjHCD3mfkkXk/Hf9Q3C8hwB/VbNMh5X9aMhrdqs2NMwcMxk2k=
X-Gm-Gg: AfdE7clRYDShFFO+xkug/R9sCIDilMroNB5gYEfVc1dLsYJBw6rLTL/wCYF9O6dR9sq
 KgCdfzR5HrCoSEO7gTj3xfO9HVLrDXYA06RXVI8xZU8xezQ7vY4BklxRn6dUlXOcdpjleqpyllV
 Z/ki8WJGlcYVxjl8108EHUW6lJ2bIfVKqwq0CcIW6oCIiMf+Ate3GjMv3KVZL7XeHSn2+yosK3P
 dHOEBrq1G6WYEeuBeKWif4+eYC6XqNIkkqSybK8ksy+QFIqHxF6YpSeg4JK+Sm0DaX4byS26RwM
 YfyRLHXdKXJQMXG70dk/bD74g3whtujC37QMk5+Zp2zQpspgod47jMJqcVWXaoW9WSa4NW85yax
 NFWIT0mSbdsDEJcpD/V5UEzgbacy5TlICePp1jwP4gUqP1Zp7ndnB1QQNzYkpW/aft6HPCIIBhf
 9NVyuAmoRAWOw595H6h+mST+5Yn9ePa/0/EneAQRLZpIQByPjHVXQ5kUzXJBc7f61Y
X-Received: by 2002:a17:90b:3508:b0:37f:9ce1:cdb1 with SMTP id
 98e67ed59e1d1-3829fdd997cmr32627a91.31.1783093062882; 
 Fri, 03 Jul 2026 08:37:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f3b252222sm2127294eec.23.2026.07.03.08.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:37:42 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:37:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>
Subject: Re: [PATCH] test/bpf_validate: use unit_test_suite_runner
Message-ID: <20260703083739.5aa77dbf@phoenix.local>
In-Reply-To: <20260703152910.80285-1-marat.khalili@huawei.com>
References: <20260703152910.80285-1-marat.khalili@huawei.com>
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

On Fri, 3 Jul 2026 16:29:09 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> Due to github CI running out of tmpfs space after adding 29 new BPF
> validate tests they were temporarily disabled. Restore them as a single
> test using unit_test_suite_runner.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
