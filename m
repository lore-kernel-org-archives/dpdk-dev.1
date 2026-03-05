Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2068F30930
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 10:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21AF84029D;
	Thu,  5 Mar 2026 11:51:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9AA724027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 11:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDSz0MSwk0oKvpbUbLHz3RYOZL5qGwP3WNOD7bDH4qc=;
 b=asQ7WElANncIecijdA5Q9QLj53bu3LFJ2de1geQrBEkCDxXOZ1WbH9Dm+VCW4z0aVzlkE4
 9BXfIcdAgtZiUD8svLlCY+g2Ch/NDb/kXYJYG6aKIrPXGfKnRuvhFjMRm9s5NXO14UDvNo
 78D/WT7+5qLoKAccoCMrIOkcwngNlkM=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Pfl3u7fINjSUCYOdckIQFw-1; Thu, 05 Mar 2026 05:51:09 -0500
X-MC-Unique: Pfl3u7fINjSUCYOdckIQFw-1
X-Mimecast-MFC-AGG-ID: Pfl3u7fINjSUCYOdckIQFw_1772707869
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be47ac98f5so12382eec.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 02:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772707869; x=1773312669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDSz0MSwk0oKvpbUbLHz3RYOZL5qGwP3WNOD7bDH4qc=;
 b=U+xUA+i2ACUCg/6k3uoWo9TuQ22s6RaNcEyd2eVIWm6vxIk7V/pTdwc+VdvrIdHX8P
 ZcW5E+IAC6PxSbSkDC2X8MAIEfOXxRl/i/C6d+b/S+Ey5LZO9LVpv9LdNwKxVcgPI2oi
 fuJd2D0ob+ZvxoFq407p6JvtK4CI+GwRQqwdtwuhwualYMkPozkGc64shNIS/Acbv8Vv
 SObp2lR5Q9AtpNdj8B6y8Dd9C35DppVzt30Fy2JXvuzwllMUwqKuYhK3epY7Jn+hW0Da
 iuiNdlVbGtEIyTnWDe6JSamE+i+AH84N9Jz4yh1GAiwzf+tgYOj/lr3DmluereTvclaL
 9rOA==
X-Gm-Message-State: AOJu0Yz7AUETB+eRbgz0oA5r542UPFnso34ZX7WQGhqqzNsYeNdBcLAf
 rqM3ONhPSjygnOcZeATT3p2fta5tKoV0it4o1ClIAOTRsJRqSeNvqSrr7ejpbTamVGUYS9zEXU1
 Nv0fMUug5kEKU1MrlB6DqeCbPx9WtYHLGJcb0SNUt7fcvmvyp45Y2Cb4LUuK3ZXzTaxVMYzoZJH
 XPtrfrwu6jRT6/vJOj4k8=
X-Gm-Gg: ATEYQzzQY1mL/VgGpJZ9V+hjWWff/uy7kpNY18qC9eV5ZG4NWtZ5isUKX4+qaPqPbRy
 9B6+uuEbU+nA//DZtu5ONnP4EUL18BatCUZI0vkFQfCbBauB16MIYy62zixzh3RLY3be8JKG4Zi
 FRmzuJcWRujGdi1T4ERkfF2arkDx1UC3BaMXtthTsCs9A3BbUoYmwZRqK6b0tCq89k/dtqOx233
 7h7dm/P2xnHt2hJVKD80xevXtnMDL3nBSOWpUtom7xNHDe5Tv1VVd3/i+9JCNkpVA==
X-Received: by 2002:a05:7022:e982:b0:128:bae0:89b7 with SMTP id
 a92af1059eb24-128bbfa3cafmr698059c88.3.1772707867167; 
 Thu, 05 Mar 2026 02:51:07 -0800 (PST)
X-Received: by 2002:a05:7022:e982:b0:128:bae0:89b7 with SMTP id
 a92af1059eb24-128bbfa3cafmr698001c88.3.1772707865005; Thu, 05 Mar 2026
 02:51:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
 <20260218090540.89215-1-malikovyehor@gmail.com>
In-Reply-To: <20260218090540.89215-1-malikovyehor@gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 5 Mar 2026 11:50:53 +0100
X-Gm-Features: AaiRm52PZaIUaIVtE2xIhXSQ8T12gSLIke5qJ858_KegCUr7GZlczI12Ljf-zR4
Message-ID: <CAO55csy_NCvfjRdPQ7B8Ke6zx1FX3oC6PX-wF4Ujv-RxsYBfnQ@mail.gmail.com>
Subject: Re: [PATCH v12] vhost: fix use-after-free in fdset during shutdown
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com, 
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QliQ7ID0ESuHstwU-X8vMf4yj_sou0juuVozgxcI1Ds_1772707869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 18, 2026 at 10:05=E2=80=AFAM Yehor Malikov <malikovyehor@gmail.=
com> wrote:
>
> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
>
> The fdset_event_dispatch thread runs in a loop checking the destroy
> flag after each epoll_wait iteration. During process exit,
> rte_eal_cleanup() frees hugepage memory while the fdset thread is
> still running. Since the fdset structure was allocated with
> rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
> causes use-after-free.
>
> Switch fdset allocation from rte_zmalloc/rte_free to libc
> calloc/free. The fdset is a control-path structure that does not
> need hugepage memory. Using libc allocation ensures the fdset
> remains valid after rte_eal_cleanup() releases hugepages.
>
> Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
>
> Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
> ---
>  .mailmap           | 1 +
>  lib/vhost/fd_man.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

