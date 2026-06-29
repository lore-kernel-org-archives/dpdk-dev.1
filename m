Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6047C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED23D40299;
	Mon, 29 Jun 2026 11:30:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79A1E4021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 11:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782725399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r2Zbz7U4Ktm1eQmQ1uwrMtEP8u2tR+xZ2b8OQo1Xw1s=;
 b=F61QlDnLy4KUZHdQ4w6A0ts0V/aZ7LA5Hw9G5pOg0hMLjOIOlKJN5N3Zumtlbhsa6CWHip
 qnMXoapCjlDG6Qk8XR5NNbzmNe7kcqAaHutXMNqAQj0dTgN+ImHxGQQnYTHHOhXH1HNXtR
 6+/TyxVD78Xxxund8dTWcyVTMW3SEi0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-XdEmC6vuPrqa7Ry4yvUFoA-1; Mon, 29 Jun 2026 05:29:54 -0400
X-MC-Unique: XdEmC6vuPrqa7Ry4yvUFoA-1
X-Mimecast-MFC-AGG-ID: XdEmC6vuPrqa7Ry4yvUFoA_1782725392
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb55ce6adso965382e87.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782725392; x=1783330192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2Zbz7U4Ktm1eQmQ1uwrMtEP8u2tR+xZ2b8OQo1Xw1s=;
 b=oQNzlnpkrh/zbEbUlNq9bQCSmW5Vqu2Bb8fLBEYXNGTVeFCNdzVXuIm1tJ6gVTcjXv
 6K15necmOui0pW6jNDY6w6mWN6cfSqFXvX2gJHjuT824sdsp+MA6+C87IWxgEtUxysIl
 oS/y0H4Pqzw+vPKxDhN+vGE0qa1RGy4Q6kiFMrRL/kLFz2PXh/nOKN/i7vI8sGFv619E
 J0375aCuiNGHQ8DGY1OG3EYT7s6AV1aabK37NdEBmcyj+MksSE9skNqtbBiyNTouhsbZ
 JaKRDa0TpEzIAKLBEObd0CkG0KU6eRVnDm0UTmHC7mKpYTwnjeJEsKP1KFtydTEpP/L/
 wTGA==
X-Gm-Message-State: AOJu0YxkQbbdgtEETTTilYd2htW2V5DdSfOxZ+MwfLdjFIb05zoujs20
 ECq+g1P7LzHUt38kIt9huFHjZ9izmbFFm6RjEK6WagB1U2L4yZjZG1NjFTMlB7BfaFBrKpMTOFs
 43hU66MSsPpcRf+Ec3zDegjHeE0VQN0qoe4TgEz9i16zybqtH7WT2q81O6z4PExvZIZ0PYKrKdG
 1eAUaWswiYgjYtxB1wIko=
X-Gm-Gg: AfdE7ckxmwJ13CsPZc0a2uafCSDrBMPKfDZBo7NP6i4mRw4rDFQ1Fuqo8b0mw0y3c+K
 /qDyRvNR29LSk+2bNM8Rn11vXnDCZqBr+LLHVXbMQgfP1wOeTg7zLMXIpLvW2PPUKLBMA1DM3uL
 2p56IJ8Pa/+xGu+MeJ74RLJpBBuNBMmO90ZGksFqE9hzQpTd6J7ltYfn/jpwqZDekbRVGbBro4m
 k/4sMKGb1Irnm4kKvLLk1k1nWjJ5XqTAbl66Ax/XJBItBEWyfYPlYqWSuU=
X-Received: by 2002:ac2:51ce:0:b0:5ae:a9ec:bb1f with SMTP id
 2adb3069b0e04-5aea9ecbc0fmr2390862e87.59.1782725391789; 
 Mon, 29 Jun 2026 02:29:51 -0700 (PDT)
X-Received: by 2002:ac2:51ce:0:b0:5ae:a9ec:bb1f with SMTP id
 2adb3069b0e04-5aea9ecbc0fmr2390848e87.59.1782725391317; Mon, 29 Jun 2026
 02:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260624000531.1562655-1-longli@microsoft.com>
 <CAJFAV8yScD-2zevEo30YrA+93NwYi0qPseHZUbw2riwmnDSk3g@mail.gmail.com>
 <SA1PR21MB66834BB21B6AA86BCA50B046CEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB66834BB21B6AA86BCA50B046CEEB2@SA1PR21MB6683.namprd21.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 11:29:38 +0200
X-Gm-Features: AVVi8CcDySd_yOjcg0f-qh6LuaLP9BAXhxP9zkRCL0vSORuRFTboBDMMh2MDuFU
Message-ID: <CAJFAV8wPbJpoT=41aPO2Mc5HRfeTEJrx3yDDi+YHSuw5iKdWvw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2] eal: return error on devargs truncation
 in hotplug MP messages
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aLjY40tS7DT3JDrKdaqpNNFQeTrelWrH1rPrHfTsjFw_1782725392
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

On Fri, 26 Jun 2026 at 20:20, Long Li <longli@microsoft.com> wrote:
>
> >
> > On Wed, 24 Jun 2026 at 02:11, Long Li <longli@microsoft.com> wrote:
> > >
> > > The EAL hotplug multi-process messaging uses a fixed-size buffer
> > > (EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
> > > When devargs exceeds this limit, strlcpy silently truncates the
> > > string. This causes secondary processes to receive incomplete devargs
> > > during hotplug re-add, leading to failed port re-initialization.
> > >
> > > For example, a MANA PCI device with 6 mac= arguments:
> > >
> > >   mac=AA:BB:CC:DD:EE:01,mac=AA:BB:CC:DD:EE:02,
> > >   mac=AA:BB:CC:DD:EE:03,mac=AA:BB:CC:DD:EE:04,
> > >   mac=AA:BB:CC:DD:EE:05,mac=AA:BB:CC:DD:EE:06
> > >
> > > produces a 131-byte devargs string that gets silently truncated to 127
> > > bytes, losing the last MAC address.
> > >
> > > Return -E2BIG from rte_dev_probe() when devargs would be truncated,
> > > instead of silently corrupting data. rte_dev_remove() does not need
> > > the same check because the length was already validated at probe time.
> > >
> > > Fixes: 244d5130719c ("eal: enable hotplug on multi-process")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> >
> > Re-reading the function, I have one concern about the fix.
> >
> > I agree there is a bug with multiprocess.
> > But this change here also imposes a limit to 128 that was not there before,
> > even if multiprocess is disabled.
> > It may not be a big problem, but we are calling the the multi process
> > machinerie when unneeded (it ends up with a ENOTSUP).
> >
> > I sent a small patch on this topic, could you have a look please?
>
> Thank you. I sent a review comment. This patch looks good.
>
> I'll modify this patch to have the length check inside if (do_mp) block.

I did it directly.

With this adjustment:
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

