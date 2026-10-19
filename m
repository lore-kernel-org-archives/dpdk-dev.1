Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5FCCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:12:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB0840430;
	Mon, 19 Oct 2026 16:12:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 10D6440297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jiTFKIqBfablKhn6XDD944skKXpsQ++ABp13O6ipK4=;
 b=Lz5PnqyO28KO0qZag09Ns/zrm7bVHUbkQKdgoDxOOqgiSP54KpevBIe4jbjvYSSUHLAysQ
 qRTyIqeCvzQhNSR5zV0FNmX4HMe+x9IS+R+AlKAIgFKo72kk53v1SCp8dCggKY5ahkw+83
 NLvB3EMrnDjVRQIpPgyUqC6OVXbNtHo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Vq5Ks892PseqPnQlgD9vwQ-1; Mon, 19 Oct 2026 14:12:44 +0000
X-MC-Unique: Vq5Ks892PseqPnQlgD9vwQ-1
X-Mimecast-MFC-AGG-ID: Vq5Ks892PseqPnQlgD9vwQ_1792419163
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5ba33814703so1148087e87.2
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792419162; x=1793023962;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/jiTFKIqBfablKhn6XDD944skKXpsQ++ABp13O6ipK4=;
 b=rDL7pg3sJHIVM4d57D+5WJLCQytMy2Ow7ElUNvEYZsqlheNNOvbybCU0FglHqwoEwA
 RVr3UI1m7T6E5DlcHk5a6OhgSh0aR8nUpzywL6aEfrCJXDtSOGp8hJ5Ec4Y14qzmfKdA
 YS1XjKp4G5TVcJb3ff761wjGau5U5jDZ4x6V0hIvBui4Py90MKLkG868S3oAhfETrXCB
 QsPeBSjUSV6A6cKTWXVtMzk/l2f52JdfbndzcvGwDjt1SZmsDUsN2xLTV2321Jp95MHN
 0Yi+IyQ2NTl/9sMe80hPz8b3Cm/FLCMFK74tNR3Gu7ELkczW6NM94vRJIhvDI8s843IW
 EJeA==
X-Gm-Message-State: AFq9FYJWxBNUYdkelPkPpPYPIM0QlytMZ4E8i2Ot99yKw2rzfmfWQ8tf
 1ejoU8MTRofBvfKSsVHROb/ei5K17JLRJu8IGKmMoSiaCHFtXiq+/0UGTqiBqA2yPVGw6+I99K9
 Q3kj5qNVbG1ay+3K6+XeaSTrZpJF8SzPVV6jxZjKydUR8erapYAVdDf+JtJfyyMteDzSGpC7wEo
 uN5JPZFFLo8zAw/j/km6M=
X-Gm-Gg: AYBFou328jQgEUuMllHPOEulCcQ/+OTN2qHQ0vjmkZ5+2snBoO44wJINX0LKjP85Vrw
 UAQFD+d9gl3ytU0yYqs0MirZjGfabg1Qz7vzh5yYpKTmxz4LMd/nqlyCLTr5Fy6LyRTMVZNSdVE
 t6XyVktD3s0NEl6zjbm+NHExzRNUkpHeSHOPUJ193HyYZsQqUePYXRExihHxBf7GPyAS3+/tMYe
 u51Kmiv5WDTOrabxldSDYdVRp/+sydMy1yIIAw/JhkFq5Dd
X-Received: by 2002:a05:6512:3091:b0:5bc:f280:e7d7 with SMTP id
 2adb3069b0e04-5be50a7afb0mr2932254e87.37.1792419162470; 
 Mon, 19 Oct 2026 07:12:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3091:b0:5bc:f280:e7d7 with SMTP id
 2adb3069b0e04-5be50a7afb0mr2932235e87.37.1792419161887; Mon, 19 Oct 2026
 07:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261017203621.3136254-1-stephen@networkplumber.org>
In-Reply-To: <20261017203621.3136254-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 19 Oct 2026 16:12:30 +0200
X-Gm-Features: AclHuK9zcn91t_2z34WLSD5WmLRt4X5yCQYMpySL8Sd8w6LQ5okqr2CbYXTJ42A
Message-ID: <CAJFAV8x9JDsQdxEispOeAcRGsPT9erxGx_c2EHMVWqH-KQV1JQ@mail.gmail.com>
Subject: Re: [RFC 0/3] fix bogus interrupt FD leak warnings
To: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Cc: dev@dpdk.org, "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZYaH2HEhOCMkG2mA5ZwShXBsEXLF8H-IodIpRdQzMx0_1792419163
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

Hello Stephen,

On Sat, 17 Oct 2026 at 22:36, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Running testpmd with an i40e device on 26.11-rc1 prints a set of FD
> leak warnings on port close and on exit:
>
>   Closing ports...
>   EAL: Some interrupt handle is leaking a FD: 19
>   EAL: Some interrupt handle is leaking a device FD: 18
>   Port 0 is closed
>   ...
>   Bye...
>   EAL: Some interrupt handle is leaking a FD: 20
>   EAL: Some interrupt handle is leaking a device FD: 18
>   EAL: Some interrupt handle is leaking a device FD: 18
>   EAL: Some interrupt handle is leaking a FD: 7
>   EAL: Some interrupt handle is leaking a FD: 7
>
> The warning is new in 26.11 (commit d770ee9caed0, "interrupts: warn on
> leaked FDs"). It is doing its job - one of these is a real leak - but
> most of what it reports here is not, and the noise will get reported as
> a regression.
>
> There are three distinct causes.
>
> The interrupt source created by rte_intr_callback_register() keeps a
> copy of the caller's handle. The copy carries the caller's fd and
> dev_fd, but does not own them, so freeing the source complains about
> fds that the caller still holds and will close itself.
>
> The VFIO device fd is closed by dev_vfio_release_device() on unmap,
> but is left behind in the interrupt handle, so freeing the handle later
> reports an fd that is already closed. The VFIO request handle holds the
> same fd and has the same problem.
>
> The alarm timerfd is a real leak: it is never closed on EAL cleanup.
> FreeBSD was already fixed for this; Linux was not.
>
> Patches 1 and 2 address the bogus warnings, patch 3 the actual leak.
> With all three applied the same testpmd run shuts down cleanly with no
> warnings.

Thanks for those fixes.

>
> Open questions:
>
> - Patch 1 clears the fds in the source's copy of the handle. Clearing
>   them at dup time, or not duplicating the fds into the source at all,
>   may be the better fix.

Re-reading this code, it is the only place where we duplicate the
*handle* and it seems entirely unneeded to me.

The interrupt subsystem can not release the handle object itself
(which is probably why it works on a duplicate object).
The original intr_handle is allocated by a driver (through the bus
code, usually), and registered to the interrupt subsytem.

So simply, this whole duplicate handle stuff can go away, and the
ownership is still the drivers and not the interrupt subsystem.

Am I missing some other case?


> - Patch 2 resets dev_fd at the two unmap sites. Doing it inside
>   dev_vfio_release_device(), next to the close, would cover any other
>   caller.

The current fix is a symetric to the map path, where the VFIO
subsystem gives back to the PCI bus a device FD tracked in the
interrupt handle object of the PCI device object.

The VFIO subsytem has no idea about the intr handle stuff.
All it knows about is the device FD, which seems correctly closed by
VFIO on call to dev_vfio_release_device() indeed.

I don't see why it should change, can you clarify?


-- 
David Marchand

