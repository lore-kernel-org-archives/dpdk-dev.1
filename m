Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE9D35664
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 01:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BCEF400D7;
	Wed, 28 Jan 2026 02:23:30 +0100 (CET)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) by mails.dpdk.org (Postfix) with ESMTP id 1D646400D6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 02:23:28 +0100 (CET)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5ec87b1f525so3050912137.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769563407; cv=none;
 d=google.com; s=arc-20240605;
 b=QkLlIfRSUsZDh5hVmlbIWsySGjcN8H9r+gWWJNBZmXPRPwR51X15g+GCR/16mdtOSy
 3cdqfd2HWxGvA/1WAZQSBK7wF//rudlzH3GHXT52X0W+nSWyR/IJW92cuI7U02zvzqRV
 Jz4/pC/9x4nqlgOJdRlEAa+TBaeEDLWitabXYC//mbUv5y37GFU1LFSY1aIvES0l1RLL
 X2/ScYBdqrjldLhNkYU7PUPRuUxNwPY4uhYsyjlEGk6yFaaO7hN2a+PTyfdJNoC3G9bB
 dTGZeoEEWt0kLj+e14ZASRvPSUjuDmnkJ6IhhKE3U7TXNMVSRK7sisuYNR055Q311ngR
 EHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TcXWpvityc2Cv1qxsla9zgXKMHIaJtTYm8Zvmro6kUc=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=LiW2kVv593gMtRknHCCgdqDmIZ0wBelIB5t8AzYak5Fv5xzkKsWNLaJieSha4UuPSF
 cCnI25dmfSnIdWSwl+dzhZEUODM++hNkZruNM5aQb6SqpKhdu/sxOVNurZbcwj3KtDFs
 dowNxdRD72gYnyoHVvS6fPeUwc5gz2JI3IEJ25wrPhJ3S9w7c3cd6oGThsK0rCbA/6yn
 JSoTRjYu5rgu/WKLZL8Sa6gfypGlaEtBVKggD//uLLwRO1YmQGYpDzyhrYCi+gr0dE47
 Z1N+RvMRFXTLM+TYM4xoZpe3GryI93WlD9a1OFVjqQPPDLiNSZsN6a3kyD4j/mgF4gt7
 oIWw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769563407; x=1770168207; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TcXWpvityc2Cv1qxsla9zgXKMHIaJtTYm8Zvmro6kUc=;
 b=EKl6QPklkap7SajNFP3Joc0es50SVMjsqrOagHJpXVfF7fU9Zp6xE2Hvtqn//DmOWr
 bDWlAUbUaeDM4rXF1iUvQ7hpih6rDvxiHj6nSQd9m1y41QT3wMwUZJRPNMDUu0zEDEw6
 ebrimO5I8LCNZBC0ngnTeZnc442hzuL1/2gQEV/5D/JNqwxgW7R8EQT+spVfR+m1bbqe
 VeiUjJ8IjoweEg30BCYy0V+6qj76wP0mtCr7SvOZeknMP8tLzSuYG3rQhrGJhvJZHzho
 3gdGu0gBb06OR/oNKuCUEtjkYp4iLh3OUcPifpHKMjBPXVv+13vzU3L9T5IdSJj18MrV
 B+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769563407; x=1770168207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcXWpvityc2Cv1qxsla9zgXKMHIaJtTYm8Zvmro6kUc=;
 b=xEZsaHhSnsBRF3Lej3Rs0YCJcoOigvbrIXIHbBsyw2JE5r55MfffaEBatGqIEq71Dk
 fUB8FTO4ah8udHGqoPKSW8SpUYazChXOfztaqrtwSaqD+Ms9hjDpN3DOWDLVpt963zFP
 XxlloSDwLGZvoFRckLPasbM9MUzQmW+clAekPbYfTHCh/GYURx7JjQWXDKDanTBx9x/7
 7WjiFA+aeimZCpEsp3QFH65Fq1U/YnryVUhASXpc1+/M0/ejjF/5/HcA3kel1ycqmAfx
 AnZLe+zL7X6gNtKwOVHlSfrxtzMjO2TljtrUgESGN/I1qwpO79lAm60f+AQP3ds5OvsM
 fSgA==
X-Gm-Message-State: AOJu0YyLeapPwekCwAUIPopszvSGRgk/75IugIVKiLVQgheGs1uZIu9I
 ZDP9e0jh/evppt9mtCVJU9OycAqlue+zHDFGsmNsD9XUZt7HDBJ3A6hLf+ROqeQWc8O9nkyKtoh
 6q3GghIK9wkjvz8ttMGLLwwMVgpC1QUt5cbbR
X-Gm-Gg: AZuq6aIzXFTh2F+OziRDbQVSvBCVpm2jqtry4IlUiphke3OSQF+Y6Ao4vDXDFMQl4vI
 GD5yv9W6fLhFzjrFhLKCZmvGxk1vMbT4DA1Y7z7XKZ58vhgyU5GHYxyZp6ZvMjD23hJaFr+c1Ll
 zMWoPgFsLzYMQ/Lt+Cv4Mi/iOfMq2m74DAK/razuKOAeddAgdC1qi/l2ZSCMdYQvOB8TIpkYL4A
 SkfPjznqRTuzIh6uKXRWwDIyAJkEXnXaa2ULvGPFkdLESsG/J5XgHZZcqfVC8Nz6i81+RNBUjHv
 EP1QU4V3
X-Received: by 2002:a05:6102:32cd:b0:5f5:4027:b6f1 with SMTP id
 ada2fe7eead31-5f7237a71efmr1592365137.32.1769563407276; Tue, 27 Jan 2026
 17:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-3-scott.k.mitch1@gmail.com>
 <20260127105440.267abdec@phoenix.local>
In-Reply-To: <20260127105440.267abdec@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 27 Jan 2026 17:23:15 -0800
X-Gm-Features: AZwV_QiaskWggEIg5r-SgCrJrqBetWuuyc-pvFzFOIJ2fcYzZKO6i5xeZW6RDP0
Message-ID: <CAFn2buBzhD=+5fG44xVyVYvLdunSxK7hTUAqi8+acPqoLf508w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

> > - Add rte_prefetch0() to prefetch next frame/mbuf while processing
> >   current packet, reducing cache miss latency
>
> Makes sense, if you really want to dive deeper there are more
> unrolled loops patterns possible; there was a multi-step unrolled
> loop pattern that fd.io does. The reason is that the first pre-fetch
> is usually useless and doesn't help but skipping ahead farther
> helps.

I didn't want to go too overboard and there are trade-offs (fetch too
much may evict entries you need). The upcoming GRO support (in
follow-up series) enables ~64k+ payloads which increases the memory
footprint per packet. Would you prefer I remove prefetch+1 or OK to
keep?

> > - Replace memcpy() with rte_memcpy() for optimized copy operations
> There is no good reason that rte_memcpy() should be faster than memcpy().
> There were some cases observed with virtio but my hunch is that this is
> because the two routines are making different alignment assumptions.

ack. I will drop rte_memcpy. Under what scenarios is rte_memcpy
preferred/beneficial?
