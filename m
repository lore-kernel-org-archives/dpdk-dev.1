Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E04C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9455740DDC;
	Tue, 15 Sep 2026 15:22:43 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 68911406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:22:42 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso24648415ad.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789478561;
 x=1790083361; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L2mf003kdRHgMyGvxJM76xKZCFLUsb/NGFaevpjZokY=;
 b=uMDmGDU9i5pZqwmAMCeBf7fnHGsQmeo+k9txZikVm/Hiv3qri0xgM23+3s50WL27q7
 7t0PJOZ+y1yqyhRUG8Dgc/faUJxH1AIq4zhUogCcJhL9dUO2vqx+Gb9j5xbGn+oGBGwD
 JCj9dnY0CqHZH9c2oUYL+3qOj4pwT3nYnV6hDBeMrIhBz5gZHLOvYmEZcwfZ2PH9EVf/
 3oiw7WGU9I74Q8peFShSF3fGmyYo4NW6yGXKNWuh4OaFn7fvAhwbC/UJ6dwG95DFkWpl
 MZb+OwFfCLVZq3p2t4e/fP43N+NiaemRtt0GL0aNmD4YBwzfPy+105O72rR9ILUmIpxL
 rGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478561; x=1790083361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L2mf003kdRHgMyGvxJM76xKZCFLUsb/NGFaevpjZokY=;
 b=LR13WcfwODp3MEQCv5jxr85FxpsKqkq5OoQcKRu1HTrZe/qnKeFEAcmPQmmhF2BqyG
 GmVpZFxEvCgRR98EgfvVyDCUQHadCVD7euxVhT8Dk0jC0CUtkUVUkAAwSLq8Vi7fsUUi
 DA8q0K5v6aGMz5v3CeAgJd3EbuURaSZDDjPBHxOACuCFt7T5LtI23hExME0lhhtWR/zR
 7ZIpD3PSfvOQpy+9NDcBE3CcEHvGWtkkD1uCTozi4XpwfgTOwnDxhbJ4cr58yqB2/aoS
 iP7xYdO5uUgAHH0WkJ6J/bqGvnq/92Yhh+H/iYk5WLFrnjwp5cpxJn/GFEYewGMhsvdt
 Gj5Q==
X-Gm-Message-State: AFuF++n0datAFkSwv9IuiGoeXe8745O4K+trADQREM6H7ZZGydhPMWF/
 h8dJjRjw9xxgoVxhXB0KPMDUsMWpBEmwr31UGxCmZa4nlKU6aplApnj4BikaYIGzgHQ=
X-Gm-Gg: AYBFou38soAlgI4XJZr55lbAVofjluC27GSrTcCiHTNF8mbFsBXWqOkFlLQiyAsGEQX
 HArnqZl4Kkc6yyT1VNHxxjAXwINX1jCiejc9jUq+E6fnexxzC5NUmvCLNWaO79mOxBjBVWqhXyr
 dZwqAcpIjiJ9Ufn1FDJIy2NWnM+6GkbUnyHjyUY0tvrJOQcdpcuhXz3tuk6eZj21KzyiItszCh8
 siek4G6yKmpRisUrNlUDwxCH/zoK/mz7SLr/HdSlKfRClrKtHaNwsufsufSxvGuxe4XXK1DZNjv
 P6Ln5bAQq88uW9ntRw5VcjU4OOsK6B86IiSqhup7qd+TqakNFA2F2Mm8S8LBqTeJulq8yfp8WVR
 6IBFX3JQ8Qjpz219Gc2UmT4UsIfHuA5FB6yA0q0k5kEUCXk5Dfc0meKFqKnnqTY0JsN9fncGz4I
 0joRbZgq0Zxm+eZexcSFuPPpcEFGYB5u75i/tH0nZoLFlsaI4WQKSAwyAnSDJh+tbZc17QLL/NB
 xBX6u7UUGhgc/xpqpvO7/LqjeFp875H+Bu0Dlh6
X-Received: by 2002:a17:903:1ac6:b0:2da:e634:370e with SMTP id
 d9443c01a7336-2dd6c6eb5f4mr151364545ad.14.1789478561374; 
 Tue, 15 Sep 2026 06:22:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd3e2dab98sm60754375ad.28.2026.09.15.06.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:22:41 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:22:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dangshiwei <1138222970gg@gmail.com>
Cc: dev@dpdk.org, stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn,
 david.marchand@redhat.com
Subject: Re: [PATCH] eal/riscv: implement prefetch using __builtin_prefetch
Message-ID: <20260915062233.14e585dc@phoenix.local>
In-Reply-To: <20260310133524.28087-1-1138222970gg@gmail.com>
References: <20260310133524.28087-1-1138222970gg@gmail.com>
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

On Tue, 10 Mar 2026 21:35:24 +0800
dangshiwei <1138222970gg@gmail.com> wrote:

> RISC-V currently has no-op implementations of the rte_prefetch*
> functions. Use __builtin_prefetch() to allow the compiler to emit
> Zicbop prefetch instructions when the target supports them (GCC
> 13.1+, Clang 17.0.1+ with -march=rv*_zicbop).
> 
> The Zicbop extension has no cache-level hints, so rte_prefetch1()
> and rte_prefetch2() fall back to rte_prefetch0(). The volatile
> qualifier is stripped via uintptr_t cast to satisfy
> __builtin_prefetch()'s const void * parameter without triggering
> -Wdiscarded-qualifiers.
> 
> This replaces the abandoned v1 series by Daniel Gregory
> (Message-ID: 20240530171948.19763-1-daniel.gregory@bytedance.com)
> addressing reviewer feedback from Kardach and Hemminger.
> 
> Signed-off-by: dangshiwei <1138222970gg@gmail.com>
> ---

There is another patch for x86 that does same thing.
https://patchwork.dpdk.org/project/dpdk/patch/20250223125215.358925-2-mattias.ronnblom@ericsson.com/

Would be good to have single common file for all arch.
