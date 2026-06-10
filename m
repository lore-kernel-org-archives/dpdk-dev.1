Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B7CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 10:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C9A4026D;
	Wed, 10 Jun 2026 12:55:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 53A1140269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 12:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781088914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cs8MSVvWk2NhuEhefqml/tKaS0hNX+SKaxVo9/PNdOU=;
 b=ZD16QOdJfUdIeQsRCNohbsv/JKu6k0VcPGu/6ja856OOR9Pzk69HJQO/cQjMW8lgGGIClb
 RLRIDhgCu8aBesK6ISWaf/vhJborh8uqB9wSSboXbPSQFGhZQxzDrZ1heATsitXAjfUMXo
 UJuOznPLOX9ErBD9hsa5Qi/RCUNGnnE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-8EZ4mByoNXefC6CI9I98Rw-1; Wed, 10 Jun 2026 06:55:13 -0400
X-MC-Unique: 8EZ4mByoNXefC6CI9I98Rw-1
X-Mimecast-MFC-AGG-ID: 8EZ4mByoNXefC6CI9I98Rw_1781088912
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68dae27dso4278092e87.2
 for <dev@dpdk.org>; Wed, 10 Jun 2026 03:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781088912; x=1781693712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cs8MSVvWk2NhuEhefqml/tKaS0hNX+SKaxVo9/PNdOU=;
 b=KXarMRECHaHO2bXYiHDiagBtx0gqB+8ojfsdsnkSSZ8MtsBLe3xdgqJrg0Hz+f7Aq4
 7x+aIrQhmUJChHfrQ2kXdvludJys9h+YbEReAocd2R5dAOG9hye9ll1r2/OFhFy0VaSW
 agjFkq4bUXGWh5Oa2S7hE56fXQhqapCGdVa91qPzI1rxNLhikTEtVQbhWgaK80595o9K
 pyhTWAaBwSvNMFyExsZ6UMhp4C/fbFUueJiKQ+aARckl2xLEDVDbfI3ieUcfvHhWQZ8L
 BBPgZB/vKNDr/6Bcm1a9tfh48SgxQsfzTRrxOp2pE4W7KQD7UpJg+yel7GF0qiN3YnC8
 4gfQ==
X-Gm-Message-State: AOJu0YwvafnGeTViaqtaidpujmbyBWo8Q371FsVPZsXt9CWrnU1AnJP0
 c4USiJOcmeiAS7AkQkXb9bdYbfhq043OaGWbdf6JigPHbJyOcZrypGOxAVUHAqc/4RntyP7OQ0H
 /+D3XjNOmdstgKrzjomSvv9E8mA5ygxBMxJPHnekVWRRyeNygEWRXI0J7IeA/+xQjzalZM7rPXe
 n41UN8TkOpR+a9clLfQxHURE+UGyA=
X-Gm-Gg: Acq92OGmDnwMP3gxkHMxqLykJIMx9Qwbksc5wHiunsIQY6KkGp0dVAYN0v7P41U5oYp
 ur9sAiVPfDrxsFG4EVvBtPRKgFGHtQoHjDIQAIva7BxAmk12dDO9HT/J9T64KHYfLWl/SPt0gC9
 fEqlJtPII3ZedCbA1juyA0eMy0+VKYZN/F4y3wNJI+wDa95RNO/Bo2XHdh/OAMyJKLrX4Ploxmz
 gjqLnEWTrrQ9LSnUx5FYXtrwkSadSGDlzVji4+OsE1DvdXOyB2RivfIUlBKaE3Te2L/vy/y7aUu
 CaMJ
X-Received: by 2002:a05:6512:2215:b0:5aa:6bc2:647a with SMTP id
 2adb3069b0e04-5aa87bc8f63mr7074556e87.31.1781088911855; 
 Wed, 10 Jun 2026 03:55:11 -0700 (PDT)
X-Received: by 2002:a05:6512:2215:b0:5aa:6bc2:647a with SMTP id
 2adb3069b0e04-5aa87bc8f63mr7074549e87.31.1781088911319; Wed, 10 Jun 2026
 03:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260602225722.950617-1-stephen@networkplumber.org>
 <20260609135532.80396-1-stephen@networkplumber.org>
In-Reply-To: <20260609135532.80396-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 10 Jun 2026 12:54:57 +0200
X-Gm-Features: AVVi8CclAPvqJThRRBOa1p0fxsmF-6ONT_t2anlErN5YitirwMc7LAMZzBQdNxw
Message-ID: <CAJFAV8wQo2ZmzOxK-FAjL=iX8mwmHtnY768wnFreoPbZZm5AKw@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix function versioning with LTO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QAOI-v2RCoFMyCxiB9aAtSYRXF67gwgz2YNAogB27rY_1781088912
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

On Tue, 9 Jun 2026 at 15:56, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> When using function versioning and building with LTO,
> GCC gets confused by the symbol versioning using __asm__.
> There are no uses of function versioning in upstream repo.
> This was found when adding additional parameter to
> rte_eth_dev_get_name_by_port.
>
> Assembler messages:
> Error: invalid attempt to declare external version name as default in symbol `rte_eth_dev_get_name_by_port@@DPDK_27'
>
> The workaround GCC 10 introduced was an additional function attribute;
> clang doesn't have or need this attribute. No need to backport this to
> LTS since there is no function versioning in those releases.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

