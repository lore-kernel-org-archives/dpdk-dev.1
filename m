Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B15DCA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E7C40279;
	Sun, 11 Oct 2026 22:31:17 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D24A74026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:31:15 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso8825155e9.3
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791750675; x=1792355475; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fFXGrtPceUgfawh9xQ/JfIT5cgvHyONSZQ3Ksx+tB+w=;
 b=Df1Y3XT7UNX/HQxY6VXlusP9VoO9XI+dhceIIObdZfJnpqfDsAVxSfgjgo11Fpkx1v
 MWYnT1x7xlF0bGAip71fGUEU2U10SLqEblcK5LxCSlQiD5FfnODQcHJpVsRtj8uBqb3B
 ZUdoxz3BdCswg3HxaLhwzwYza+QH8Wi4UzjhR7sT3norV1TQcMN5m3FE0dZ0euNDJgBu
 HhIkdLtooE2McggXBdFb4O0ZAfEyB1KY9qtzUx/s0yLj5Qq6AG9Cdhq2WZ1se+mvsWOc
 DEX0ChkbQc4A/lNyYol7rSjNpEBH39YiHdKIGu2YDo2P6J269HSZxgVs06JcOEL+Z8B6
 EklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750675; x=1792355475;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fFXGrtPceUgfawh9xQ/JfIT5cgvHyONSZQ3Ksx+tB+w=;
 b=iRp8CjEK8Gmk8Mhr2JtKY5h4FqzMqPisURakfehKwf+Dzd/c0Yz+VyQTO7B8Jx/1DJ
 4dSCrdVdS9QPidWu5PRJS/rgnE5qZCehWMxu8w9tCvxo+dQGYD4Cxe5ynWTbKXJxpeZ5
 lgZwlumLaJ09gOWpHVZnBKFWPez424i05qVICEJmBTKwKkCOd5a+wak/TMBAMdfo3B6z
 GljfAnS1ZQHexf5sEBqzJp0mAETZ6JgyshPF1AV/ueMfR07gpkc1MPW0pNHxdoYrv1MK
 Hovkg/3HWxf60dvEcCPjtQkG5q2A0P2/EG84WM++gb6o3GiqS3A6yuFX1NOjnj7lATpA
 ajlA==
X-Forwarded-Encrypted: i=1;
 AKwUvByanWwInz4cyBsPLAJ4HO8BLyOVJXn8UdsUXYxlOCVls3SCSo22pQrBgFDREXg3MyMr9Io=@dpdk.org
X-Gm-Message-State: AFq9FYLeanXZHChiYdLvPUSwElE85v9UTPPPHIyMCZx+YrLHkQhsDPTb
 03CiuQe4+RqxMa07V2eM9/3TzaJrcj0q+c+2/6F2PGLumhz1hKPt4zhQw1lqW4xnEPU=
X-Gm-Gg: AYBFou2yE0G6ed4OxTyL9i3KS9yZMuDw3ZQFQxMp3iF4pYuIjgLvHa66EcyY5jMar+w
 T91JynrVwTslNvXMFC0v4qOLKOKrbacAGyLl4DwojCZCeuvvURoUHWX+Gqe1nku9n8FHyqQmxRx
 SvhqIP+O4vqZc1uTiVf2686MeaBIKz2tP5Bqb81jY+RBbbvbSrUjrWkCEsApG1molTVMj2LRo82
 hnAtWt3aIyn5Sv6kmIW7cbuTYEf0L9NIcTPHtfQkhVONgIu7JwK+9BcZXuegKohKp1PTd60pL+B
 jURX3+af+cnpOLxNPFQFaeqrQEJxhmEt+nojm/lNnYjiscWxBWksJFwhpTVlS82B1l6z9QG9lOX
 dbuSpqVdlwtseo2uF7qkPprF9sBPcAKhy4PWGz0tZzBcCKuAY5KMIl+ryJ5j39//QHK3ImDbXzc
 7ewIAXPclXGirlHuKw/e6B6gEy4+9eBx2zzfIkI/FXS6YpdOzfvRQWfd2A1X0POegfd+Q=
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a18e4c85fdmr153877065e9.34.1791750675257; 
 Sun, 11 Oct 2026 13:31:15 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.48.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ada3edsm15564894f8f.53.2026.10.11.13.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 13:31:14 -0700 (PDT)
Message-ID: <9aa99f0f-a0ad-4457-88e4-30b81df7a86d@gmail.com>
Date: Sun, 11 Oct 2026 21:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] bpf: make callback handle atomic with relaxed access
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-10-qm2k21@gmail.com>
 <20261011125417.132bcbbb@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261011125417.132bcbbb@phoenix.local>
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

> Since inuse and cb are inter-related would be easier to squash the mb
> conversion and the bool and the atomic cb into one patch.

Apologies if number of patches seems excessive, it really is a matter of 
style and taste. Technically all of these patches are all solving 
different problems and can be applied (or not applied) independently. If 
the maintainer decides to squash them so be it, fine for me.

Thanks for the reviews btw.

