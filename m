Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316ECC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 07:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21652406B4;
	Tue, 15 Sep 2026 09:39:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 645FB40290
 for <dev@dpdk.org>; Tue, 15 Sep 2026 09:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789457991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZMTMeNNc2NH5HZhZP8e7xuNo8v+rrHZRZVQxVlBnaXg=;
 b=JznGmA224U+Aew63jj+WOAH6QDmwKqMmpF0F9XZTUz0PNCUHNi1BstydUfLGNlPBJksjdb
 BMl42oUwfI03gNynSP8f6Iio2mIJVgaT7MHCxoRm9CFbIrg/sfMAZzjQDn3Uosr3q4rPJr
 dQbPF/q3EpIgSiGdKwm3LAwA8pXL1vI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-tL38KYhIN7Oibaksy3Xi0w-1; Tue, 15 Sep 2026 03:39:48 -0400
X-MC-Unique: tL38KYhIN7Oibaksy3Xi0w-1
X-Mimecast-MFC-AGG-ID: tL38KYhIN7Oibaksy3Xi0w_1789457987
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a49cdd876dso17522471fa.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789457987; x=1790062787;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZMTMeNNc2NH5HZhZP8e7xuNo8v+rrHZRZVQxVlBnaXg=;
 b=VTjuyGhGGRu5taFvcLCCvfEfCXM4BAyKRQKWl/HibbWknDb+O6Cv3sjg9eth28qLBG
 rqvSB20LcMLnpuLklJdSasaBZK34RecnppZ7aDNhr9H66movdPOIcHXnrObTgS/LFcxM
 ZfCKMTxQIdMRrfCLOBe97WVWUFU6Jb+rXrUhpG83A95c/K3llJ1bbwRtozW3Osi5z67t
 e2TDIISrEXOrGnvLbHoTtfvIkjO2W4HZEUjXtAR/1HuoeP6R4ywCCcsjFYfkxTVb1xJA
 E3lq6m1g+7Hc3KJ3/wi3/HCrL1AHYJmHrQaxzPIs9vkj/xMNZQTL0VLmm3+5zYaO00pD
 Odrw==
X-Gm-Message-State: AFuF++n+S25fDIDICBMu4Y1IC5YW3DKFuZvoghxf1JHIiGQJ0k4efeXU
 t69ZIgb5qpxT1e/oLucR3PsS+EfMx/qAH0MP+WZsgRXsrD0qbBcCUzqEpIdQQdsqOQLWJUe5Zp3
 ERXCXXQjiXYQRQ8FsEEJIskrgejahLZ5op50kmmKLCEZcHEoj8JLbrcR7CBsYL3f++otZCyhldA
 Mh8YaYNUDjk++VCMJ7JOE=
X-Gm-Gg: AYBFou2KboUx4gOTpBJzJPy27BpcoHd6J1RORVQYWzPf5NYGGs3lZJ/kSdJMl15MqDV
 pqmUQGXqHFv2zDDhVRHFvVQ4DEmMxpyxt9fpgbKV7jdnZ4AGJ9j8rFf/jveqndVp8NYFV2uLusJ
 rhLS689Weq23ZIg5nDMiO9Mw63hB0xnmGye3fEg9+VEL98Mw9nzQnEUazFmf2qDuoSInKRGWqWt
 ORbXPYajZdY8E1FJDCAcgp4KJNNsVt3T1Con4urwTZbdPa7
X-Received: by 2002:a05:6512:3f0c:b0:5b6:1a7c:aa1d with SMTP id
 2adb3069b0e04-5b8ae6b6414mr1571108e87.53.1789457986675; 
 Tue, 15 Sep 2026 00:39:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3f0c:b0:5b6:1a7c:aa1d with SMTP id
 2adb3069b0e04-5b8ae6b6414mr1571097e87.53.1789457986178; Tue, 15 Sep 2026
 00:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
In-Reply-To: <20260819191036.679330-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Sep 2026 09:39:34 +0200
X-Gm-Features: AcwNN1XkwL6eeyGbSoL8A-7bqbq99E0vhLfg5gtfbFGbu8yLnmY4Gxjz8kCJTaA
Message-ID: <CAJFAV8xJwza40_eG9gvsEvogYuDgAa+SgRU8Rhs+eie0G7x2Bg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] eal: uevent overrun mitigation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Long Li <longli@microsoft.com>, 
 Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s2_VXmRG--PyWQL7LT356slP_c31RqYalY_gM1Yyn2I_1789457987
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

On Wed, 19 Aug 2026 at 21:11, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This set of patches is an extension of the proposed patch
> to handle netlink uevent socket overrun reported by Randy Tice.
> Mostly impacts users of Azure VF events (MLX5 and MANA).
>
> DPDK uses netlink uevent to track hotplug events reported
> by the kernel. Since this is a one-way non-blocking channel
> there is no fool proof way to prevent missing events if DPDK
> interrupt thread does not keep up.
>
> What this series does is:
>   - use netlink group to only receive events from kernel
>   - increase socket buffer to have more headroom
>   - report the problem more clearly in log
>   - document requirement for control threads
>
> Stephen Hemminger (4):
>   eal/linux: filter uevent Netlink in kernel
>   eal/linux: increase uevent socket buffer
>   eal/linux: report uevent socket overrun
>   doc: add warning about control threads
>
>  .mailmap                                      |  1 +
>  .../prog_guide/env_abstraction_layer.rst      | 14 +++++
>  lib/eal/linux/eal_dev.c                       | 56 ++++++++++++++++---
>  3 files changed, 62 insertions(+), 9 deletions(-)

Series applied, thanks.


-- 
David Marchand

