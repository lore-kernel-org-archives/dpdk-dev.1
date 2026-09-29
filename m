Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F5CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE33640E68;
	Tue, 29 Sep 2026 10:07:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E40384013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 10:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790669244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icXFCgDUpgVoCPUSvksom/cy3O1pHawYRKekv8y045k=;
 b=K3pGrIM9kGuFVllId2HEsEDQJPuU3vBJI6CXi2UasV98qh8E2JKtvlURwccgen+6OqxoJt
 EvYXFEn0UkJjXtxAxds9qkp+1aq3vW+1Udvt70RrrXWqQ0cx6U2WjS0BXWT9s7OWSbbkhx
 0FNqo0t29cabr5RIxxy4ROXIyms9a+o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-yypT21BMNAieImDRffN9SA-1; Tue, 29 Sep 2026 04:07:23 -0400
X-MC-Unique: yypT21BMNAieImDRffN9SA-1
X-Mimecast-MFC-AGG-ID: yypT21BMNAieImDRffN9SA_1790669242
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b8ee32b66aso2207317e87.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790669241; x=1791274041;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=icXFCgDUpgVoCPUSvksom/cy3O1pHawYRKekv8y045k=;
 b=h6q1+BqrYMyLiFvsiS8kD0anqZdiSM7U8FPFC69rQhkzfAzGrEawIsKX7hoqWO1pR9
 13yRLSYM2U5WMtym1l/ZLC7F+8ClWQRD9Cq2ujdhWj8HmcTJpNQLlXMLWi+IJy4RdHoO
 x/41Hw98EykmcNVP2PoxdH43/57YeqA13oqjvAnDVNtpuoKvBn6pgW1bZ7wOmNzLqY/5
 84GlZsD0eUVCRiz3wQiBgFyA1JEaapQ6A0L7ZmzJdqVbY5uvfxDQT1JM6XFMZaKm6zuv
 cQYJUrrD9T2DCb8meaw0jpAQcjcGX0WlaY9k3Q+iQPBjomPWlPVT4JResFSPjN1N5ZjT
 8/0w==
X-Gm-Message-State: AFq9FYIrE6f5XyxCMpo1m4dJ0o2oTDRkmDmUVmGyh4UfqyWQafNXT3xR
 nT7S+7BKZHwDfXKLdyd820/JwmwVebC/LWUtJd53v1bnF6vNhr2GoCnRpsHJXslqq8C9eC6rFgh
 6PYR3gZCkbs2YuGgpIP9IpLUchMqk6K/vb6ere79v+AcWc+vSmb8uWzUNZIV/WMLATpz4uGvRcv
 j44dasWFDG4urnRCI6XFo=
X-Gm-Gg: AYBFou3ecdIlSN2y5NKEgZH4s22DLk3agX2X6ku3g8hCkejI8uTHpNpj8Iy/3UgA7WR
 dVcolL+KFWO7sI7Oa6gfgjnsHhAp92FrV9bWvPB4angPErNM1+SHoDUW9TDyBPvZsUSo4A0dlFU
 5eZkQHoExVT985QsEh1HxJwko7bD4XDy9ie01PzZf6RzklZbYJkUuyL8z4pI3T76kT4syP4Om7K
 Xe77Wu0b4nY8VDGL6+LrrxYobByPL4sO+waJiTzNWK/TZLK
X-Received: by 2002:a05:6512:3d14:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b8df093011mr4955465e87.21.1790669241392; 
 Tue, 29 Sep 2026 01:07:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3d14:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b8df093011mr4955454e87.21.1790669240925; Tue, 29 Sep 2026
 01:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-5-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-5-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 10:07:09 +0200
X-Gm-Features: AclHuK9hLfecX3Dhlbvn9vrMSc2FLbvRqlZT3Hy5wr9e0kZtEqPDJ4n7SYzPIZU
Message-ID: <CAJFAV8z2m58Oh-b-aTBkCJuW7c7q6iqvHhjfvV4TVVx63cy2qg@mail.gmail.com>
Subject: Re: [PATCH v8 04/25] net/ena: replace use of rte_atomicNN
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Shai Brandes <shaibran@amazon.com>, 
 Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein <amitbern@amazon.com>, 
 Wajeeh Atrash <atrwajee@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Iy-ufDvLucWDdRV49k9TXMytGPld0jRY4e5zbh9nWTE_1790669242
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

On Thu, 17 Sept 2026 at 22:12, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Convert the legacy rte_atomicNN operations to stdatomic.
> * Remove variable ena_alloc_cnt is defined by not used.
>   It is a leftover from previous memzone naming scheme.
>
> * Convert the legacy rte_atomic32_t and rte_atomic32_{inc,dec,set,read}
>   macros to C11 stdatomic equivalents.
>   Memory ordering is kept at seq_cst,
>   matching the implicit ordering of the legacy API.
>
> * Do not use rte_atomic for statistics
>  The DPDK PMD model is that statistics do not have to be exact
>  in face of contention.

AI complains about the change:
"""
While the DPDK guidelines do accept that statistics may be approximate
under contention, the problem here is that **concurrent non-atomic
increments are undefined behavior in C**. Multiple Rx queues (each
potentially on different lcores) can increment `ierrors`
simultaneously. A non-atomic `++` involves a read-modify-write
sequence that is not atomic, leading to:
- Lost updates (the classic lost-update problem)
- Potential torn reads/writes on some architectures

The correct approach would be to use `rte_atomic_fetch_add_explicit()`
with `rte_memory_order_relaxed`. Relaxed ordering is appropriate for
statistics counters where approximate values are acceptable, but the
operation must still be atomic to avoid undefined behavior.
"""

-- 
David Marchand

