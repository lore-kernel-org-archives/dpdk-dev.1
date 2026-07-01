Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5158C43327
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B12D3402E0;
	Wed,  1 Jul 2026 10:11:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8342E40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 10:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782893509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Pyadb3Re1hcOxsWJpREiK6bYT38cKRGeF5Qe7wX6rU=;
 b=inB/xuOM9sJdL3DxR6T/Fb8JlXVNWhLVKTz0nV41BLBqg/bJn6JAEClhrJDOYs3RHY/kph
 EDnzdKycZEoiOupRDyWMu9VCCGMyyipvEvABF9y73S+s/8/H/e7RB+7z4KOz/wxUNiAIh4
 yXj6b/JATxPVA5p6ZQ21BdF2Wr3cEPI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-WcjLa4UDP96jtyGxPOEgVg-1; Wed, 01 Jul 2026 04:11:48 -0400
X-MC-Unique: WcjLa4UDP96jtyGxPOEgVg-1
X-Mimecast-MFC-AGG-ID: WcjLa4UDP96jtyGxPOEgVg_1782893507
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3998d89ef9eso1693151fa.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 01:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782893506; x=1783498306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Pyadb3Re1hcOxsWJpREiK6bYT38cKRGeF5Qe7wX6rU=;
 b=qz3aLcrMUfJlDzy9d9+odFHWW+cBpGAb7BijFyMgQbAq9YTAYVvwEj3ofyQPXGrwEM
 hXpf0RqxrUzX4wW2M7goghA2Hf/thqIUwQfxuci0VV4OrrpJ7140H0mPGJLicst95R6C
 WoOg5t0YnRIUyt/pHLayLmdOATeqrN1c3t5kPQkV0r8CHlgdO4PW+aLNivCw2no8+VoP
 OGm+VTgRexHOzLJf/pQVEJb3XfZgvFTsERgxhBm4Msd4Wzl7azWcjEQLXKhQxMFmJq3H
 C3ldzdNy4raMVDGb+Z/r5Uz6Izf6yIBCFqd1KXWS7mh0ay4MPWzo+b35bPS3bReDGJgC
 OjxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rouo+Y2CL3gB04ptEghTy+4WIcw9UtBKkmjbOTTFb/xj5y0aOqVJnNIN3sOF/iU8Dy3gaY=@dpdk.org
X-Gm-Message-State: AOJu0YwrEMDG7DiKhhrj112+h7AJC7uNd5N+wl436K9PRO+lUARNUisa
 3j1yBeDzWbYR6PVEb88wcXDUf6i8KCvHPGFxq1hwQASfQNtZ85e4T1WDDTf6eGT0bA8ZEwtEfwS
 vsmqzjaDLDLndkGJLPzJnzaaO1Wk29ceC6C2JshrSh/upMeZvGIGihaL4g6ZIvW9L/V2JJPEKvZ
 f8Snr2tWlkkv4WeqLaiIES/pG01AbQow==
X-Gm-Gg: AfdE7clOBgGATuBqgpvQpkb4P9QfbcFpiuxxssquTdoy738AzTadLd7FeT12aKAsF2B
 ToPAngYvEcDXXt5tSJo3GHZMy2xLiyT78l0ixzWX3crxaAYNHeEz2dPJNrMGKtiNzURBOZjBkcH
 8H9g7/OvKznpmsrrFMOMUXf9C13DuRW0EGjfkgO87FKd5jwFgHhjMAr5pK1rsoUKXsTQN3dreJu
 p4nseHcRShhuQEJlZD6E2bzNtFgEygrsAXVE20LPrtnVHPTXajTvlJ1TTo=
X-Received: by 2002:a2e:9203:0:b0:39a:fc1d:46fb with SMTP id
 38308e7fff4ca-39b340712b5mr1062921fa.24.1782893506548; 
 Wed, 01 Jul 2026 01:11:46 -0700 (PDT)
X-Received: by 2002:a2e:9203:0:b0:39a:fc1d:46fb with SMTP id
 38308e7fff4ca-39b340712b5mr1062881fa.24.1782893506051; Wed, 01 Jul 2026
 01:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
In-Reply-To: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Jul 2026 10:11:33 +0200
X-Gm-Features: AVVi8Ccj7GBFLXwszlcbdMyz2-7qDL9mNrFeH1FuiaKFPl9iAsqbcxyqKlQdvVc
Message-ID: <CAJFAV8wOpRcDPip62f4EuAv_HDK_PuoGf75ZdqiKX3Er14OQXA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix dmadev incomplete ABI validation
To: datshan@qq.com
Cc: thomas@monjalon.net, dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gEMSalcpeIjzdToBJIdUKOvJRoaIIpHfHZIRH2wV9Ko_1782893507
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

Hello,

On Tue, 30 Jun 2026 at 15:24, <datshan@qq.com> wrote:
>
> From: datshan <datshan@qq.com>
>
> Fix dmadev incomplete ABI validation.
>
> Chengwen Feng (2):
>   dmadev: fix incomplete configuration validation
>   test/dmadev: add config and vchan validation tests
>
>  app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
>  lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
>  2 files changed, 283 insertions(+), 59 deletions(-)
>

This series is not versionned, but I guess this is a new revision.
Don't forget to flag your submissions with a version number in the future.
I marked the previous patches as superseded in patchwork.

Also provide a high level summary of the differences between versions.

All of those steps are listed in the contributing guide, I suggest
(re-)reading the whole guide, with a highlight on:
https://doc.dpdk.org/guides/contributing/patches.html#steps-to-getting-your-patch-merged

Thanks, I'll try to find some time to review this week.


-- 
David Marchand

