Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C23CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 08:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD17E40299;
	Mon, 29 Jun 2026 10:51:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 14D104021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 10:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782723084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SCs1FhhlugZfyqeb8EqjIlWIQ2hrbctehPCIeYy9ZE=;
 b=H4uVFkp5lxBp2vljcGzL5ryleHmYYihhU+1xA2b8To8pnbw9uUNPrFTMBN9NqmTt5whkFm
 Wn0Gy7sDcATD14jNEEjlpPhImnKosTafinWZsrjnXTPUCDjw6EX5v6hI+qk+BUm758Rkng
 JYcax5LWdWmdoMGpcZxqhssVZU5KpNg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-s-KZbGgHMUimadCPz95EoA-1; Mon, 29 Jun 2026 04:51:19 -0400
X-MC-Unique: s-KZbGgHMUimadCPz95EoA-1
X-Mimecast-MFC-AGG-ID: s-KZbGgHMUimadCPz95EoA_1782723078
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39b00c1cb1fso3064271fa.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 01:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782723078; x=1783327878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SCs1FhhlugZfyqeb8EqjIlWIQ2hrbctehPCIeYy9ZE=;
 b=NQ/XoD4cYEuK/p/T5NbkIwHyPsvVhHhYXf7gqwas/PZ1KuGYpjjHm8Vkr1fqUSMfhW
 6GBqRrttUYHk9Zx5Txx9rrQ8oSqxYTuiHhIh3h6WHe58nd8sU+L20XiBXPmI++Yc/EP7
 MLYEP0SjQbfm3Qfitd3fHYzQiD8rcWIPDluaMlXwzio1uwfB84xle2iKAL0XNVSefEvq
 WtWZzv6Jd0YZOK/8RQ8MRa+DH4L/56BQZiZ243euR2E0B66GagfBeGEIGxe89NWz94z5
 hYeSbSZwoMO31pw+H42qDBiNNhow1t1F7HbDke26J1OLdndGNAfNiOE7enTWnBrfrSA9
 iTvg==
X-Gm-Message-State: AOJu0YwFNilIKm3Ac28ID3B3xf9L2vQETtxDNl6YOkuhbGH8Ht9CzOw8
 zSCwM9R+RjfhtrwMRzNxUCJ/nS5/x0+v4CrdFOmvojf2yofP97i8s7xe0fBPN5YwRAboKSmYpnW
 eG2wo+A7jh+SdJME1NjJwKJb37pKCoC21TJtjvSQQX0W4Lkyr65AbfiNEBAz8AbxOeXJW/aWc+W
 9lW/5AsEpmMJFA1feUiVM=
X-Gm-Gg: AfdE7ckx54IlJuP3rZ+vYVApxMcYWt6nT+gHlHdqfgfybJkAZhL0+T8sYcAsW2JiU6R
 nU65k2lrhNWRYAVjWdRZqUj5vzj/HRDkpbvXf+/6c4f6ocqc7+H+02gZXYs9eMaHbfTQkytNJq+
 PSnjKKxgNtlWK6gEcZ/3zz6EJPbJmB9ehrHWdizg7WD6qeZ3pb9GX89+hxhMFgkH+hl2aZ17OC7
 VoFslJpfvpyAbLfzd27P8ytcx5XJxRShse3wHlCcIaMYcqeIB5oPO8t0cg=
X-Received: by 2002:a05:651c:220b:b0:39a:fbc9:6851 with SMTP id
 38308e7fff4ca-39afbc988bbmr11266471fa.38.1782723078226; 
 Mon, 29 Jun 2026 01:51:18 -0700 (PDT)
X-Received: by 2002:a05:651c:220b:b0:39a:fbc9:6851 with SMTP id
 38308e7fff4ca-39afbc988bbmr11266451fa.38.1782723077705; Mon, 29 Jun 2026
 01:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260625072254.4190227-1-david.marchand@redhat.com>
 <20260628140557.1718861-1-david.marchand@redhat.com>
 <94368ef9-ab61-44b1-b56a-6a1d263230b8@huawei.com>
In-Reply-To: <94368ef9-ab61-44b1-b56a-6a1d263230b8@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 10:51:03 +0200
X-Gm-Features: AVVi8Ce6vvpJVAuwZ7ntp5Mw792i1z1CSyhyaJg8Dl7dmVYPCfZZ2fK8GwZQ7FI
Message-ID: <CAJFAV8wjiguGURehAcUSYLybAPRBpXR_R8m_q=4E-iKDv_E6Jg@mail.gmail.com>
Subject: Re: [PATCH v2] dev: skip multi-process in hotplug
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, longli@microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qcb8-Nj0idtvLeGxAuHi9MeUiuJlaS4J04vwf6UV8Bo_1782723078
X-Mimecast-Originator: redhat.com
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

On Mon, 29 Jun 2026 at 02:42, fengchengwen <fengchengwen@huawei.com> wrote:
>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> Minor suggestion: how about replace "bool do_mp = internal_conf->no_shconf == 0;" to "bool do_mp = !!internal_conf->no_shconf;" or bool do_mp = internal_conf->no_shconf;"
>
> the no_shconf's prototype is "volatile unsigned", most of invokation is some like "if (internal_conf->no_shconf)"

This flag should have been a bool in the first place...

Most of this code is already not compliant with DPDK coding style, I
don't mind updating for consistency.


-- 
David Marchand

