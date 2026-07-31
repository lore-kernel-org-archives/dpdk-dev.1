Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446FC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 06:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4C0402BE;
	Fri, 31 Jul 2026 08:21:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AE7BC402BE
 for <dev@dpdk.org>; Fri, 31 Jul 2026 08:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785478916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q40BLgb/v977q0uSeUH3rliV2Mw5v2lkN2Mi1hS2CV8=;
 b=DD4+lkSv3m/yswI19gr+7b9aZbfrLjBPdn1DgJUkhfgevaxIa7pCsai9sP288ZXy/kLvFX
 VytkmAT40kUW0lhnkYhgF+yXprmA+h8hlud36M4HMoN/6M/ino5z5OHY06ZPkj+pfukijR
 bffm/4g4rvnUZeFeFEUkdVW+1J2nB18=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-wfgQxql8PuqmMZR1bdmZMw-1; Fri, 31 Jul 2026 02:21:52 -0400
X-MC-Unique: wfgQxql8PuqmMZR1bdmZMw-1
X-Mimecast-MFC-AGG-ID: wfgQxql8PuqmMZR1bdmZMw_1785478911
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aebd5e989cso353387e87.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 23:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478911; x=1786083711;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q40BLgb/v977q0uSeUH3rliV2Mw5v2lkN2Mi1hS2CV8=;
 b=natW6HtKWMRWE/74ZEuMIYkD7FeD2akxydVsNnRXa1SzAKq7PG9uuqTSn041J0BTLW
 XW0K5riCDJnS9RvMLjcgXu/GQdhxP/YIgaI0sF6BTRK0LQ9GQ7mWjLIBKUrqmACjrdG1
 QGThah0e7UjjDSMnHWcClAvyeqwJcpHgOtKsNUlk7yYbJsXW15FIDMtINTdW+34Dpz2z
 dPmTXV7FZTcVuezS0QuMuKe0I954JEhmgiigqSr9UEGRayzisPG1CfsT9NzOi9aOhpe5
 yPrjSKdf9Se+uNluVoAeL+4PZR67rzXiaenvc1FoCj7PL5xg3DJE1yO/TDdRIYHNwGyq
 +bQA==
X-Gm-Message-State: AOJu0YwNtZiok5a16ZSL3uwGbcKb+EETHMxiEvxI/bVoVvPSGzAhZroo
 g3t00V44hjW2lJR+WKp6l2nb/HrHhvnM/MFI5pY2lnxQKABjneanO+Lq9vryOAdRXna4scUeZCP
 1+ZRW3lal/Sbvm/8iv4cy+Kk6BOqnmt+6wBhsjGhQwnoyl8RQjOZeA+OVvIPkPcy7o2XzHCrLC0
 X3k2t1YWYVZTqjo4Uttw8=
X-Gm-Gg: AR+sD13MgUwC30BcxZ8rEi5rUHkJbR+zjUwaDismHdAktdAJy+owAvQOi+aDyEim7sF
 D4k688C5A4fd0NbpriG2JlcOIl0PewIw6TygczeXWvytq2tpCLylUOl6Dw7EyIeiDN5JCclLHHp
 eOOeVj7Piqoy3FJ7D/ewuFqHpW2GXSUeX+F3oHrEQK1lKQSiheVDPTxG63YaD7eroj+w06qzYXb
 dLu9l34N9mNJo7rD1il4rXmRYNxv4Y/KQdFXcrZ/j4J1Rds
X-Received: by 2002:a05:6512:668d:20b0:5b0:1cb0:9a25 with SMTP id
 2adb3069b0e04-5b2e201067fmr83424e87.64.1785478910680; 
 Thu, 30 Jul 2026 23:21:50 -0700 (PDT)
X-Received: by 2002:a05:6512:668d:20b0:5b0:1cb0:9a25 with SMTP id
 2adb3069b0e04-5b2e201067fmr83416e87.64.1785478910203; Thu, 30 Jul 2026
 23:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
In-Reply-To: <20260731031355.3578236-2-pravin.bathija@dell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Jul 2026 08:21:38 +0200
X-Gm-Features: AUfX_mwc7XavIFfhpJP2j9avMHEqr2rqI4fcr5t8GvToxS81htwNo74l3t09AxM
Message-ID: <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
To: pravin.bathija@dell.com, stephen@networkplumber.org
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, fengchengwen@huawei.com, 
 stable@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FziNblqCfGo5s0sanJHS5lOoh_R3YYDf_gPf-rZeWMk_1785478911
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

On Fri, 31 Jul 2026 at 05:14, <pravin.bathija@dell.com> wrote:
>
> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> The vhost-user specification (vhost-user.rst) states that no file
> descriptors SHOULD be passed with VHOST_USER_REM_MEM_REG.  However,
> it also says: "For compatibility with existing incorrect
> implementations, the back-end MAY accept messages with one file
> descriptor.  If a file descriptor is passed, the back-end MUST close
> it without using it otherwise."
>
> Some front-ends, notably libblkio, reuse the same message-building
> helper for both ADD_MEM_REG and REM_MEM_REG and unconditionally attach
> the mapping fd.  The previous implementation rejected any
> REM_MEM_REG carrying a file descriptor with the error:
>
>         expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1
>
> This broke teardown and memory region hot-swap with these front-ends.
>
> To reproduce, run any libblkio (v1.5.0) application using the
> virtio-blk-vhost-user driver against a DPDK vhost back-end.  The
> connection is dropped during cleanup or whenever a memory region is
> unmapped and remapped.

Is libblkio fixed now?

I am not a fan of such compatibility fix, having to accept one buggy client...

>
> QEMU's libvhost-user reference back-end (vu_rem_mem_reg) already
> tolerates zero or one fd in this message.  Align DPDK's behavior
> with both the specification's compatibility clause and the reference
> implementation by accepting the message and closing any unexpected fd.
>
> Tested with:
>  - QEMU VM bring-up with runtime add/remove memory regions via
>    QEMU monitor
>  - QEMU post-copy live migration between source and destination
>  - SPDK vhost-blk with libblkio (fio libblkio engine, write + md5
>    verify)
>  - libblkio alloc-mem-region and map-mem-region tests exercising
>    ADD_MEM_REG / REM_MEM_REG / ADD_MEM_REG cycles against SPDK
>    vhost-blk
>
> Fixes: 1d730eea6a42 ("vhost: add memory region handlers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  doc/guides/rel_notes/release_26_07.rst | 8 ++++++++
>  lib/vhost/vhost_user.c                 | 9 ++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index 3d18ba2dd0..86042bd5e3 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst

We are working on 26.*11* ...


> @@ -85,6 +85,14 @@ New Features
>    to support adding and removing memory regions without resetting
>    the whole guest memory map.
>
> +* **Fixed vhost REM_MEM_REG compatibility with front-ends sending file descriptors.**
> +
> +  The vhost-user ``REM_MEM_REG`` message handler now tolerates
> +  an unexpected file descriptor sent by the front-end,
> +  closing it without use as permitted by the vhost-user specification.
> +  This fixes interoperability with front-ends such as libblkio
> +  that unconditionally attach a file descriptor to the message.
> +

... and regardless of the version this was put in, this is not a feature.

We usually don't put Fixes: in RN.
The AI bot nags too much.


-- 
David Marchand

