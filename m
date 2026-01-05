Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B6CC2A062
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 08:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DABAD4026F;
	Mon,  5 Jan 2026 09:17:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 997B240267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 09:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767601049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAbZuvz5dc5zNVggDdeXWZ+momZo2c+cE9stJl+mzzg=;
 b=N0qjo59nJEZaAUQYy6jNItji1kdvZ21mf2PLq7cjB7ycIBRykSkPVzxH4bQcdQn/KsPwTc
 arVii0lpcyl3KeDvy55oxXX80odZQ4VqrMsnXUblaBMO1ga2AenGN8DSasnRBwlAz5Ff8A
 or7QGAOHWtqtz2/valB+bbKUHOybSkU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-EAX20WUEO3aRcHIw8OX0HQ-1; Mon, 05 Jan 2026 03:17:27 -0500
X-MC-Unique: EAX20WUEO3aRcHIw8OX0HQ-1
X-Mimecast-MFC-AGG-ID: EAX20WUEO3aRcHIw8OX0HQ_1767601046
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-37fd511c59dso66123081fa.0
 for <dev@dpdk.org>; Mon, 05 Jan 2026 00:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767601046; x=1768205846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAbZuvz5dc5zNVggDdeXWZ+momZo2c+cE9stJl+mzzg=;
 b=JKjl6rAF5D0LvGifK+mY0FMm87Nad75v90wi38SmM6ARqOiy24XY6cXSe+heYCbghw
 5g0wmmGbJVthjfNgimM8hcCsTvlCTMAOfkc354Qpf1FLyjT23xLuKkttN7qhRHhbOTyA
 DlxmqxWZRwu88LrDCSuTsx5AKEvel8pebLZG8fAbnvA8Nln66abgCEN+M1ZUMnNRLm0o
 G58s92NiP3bErufNd9p+rvzqk5I88l6P3F3Eg219kaBZJccsFb3zoAR+rXOcBIkgHJPT
 di7w3lM+IwiUymu1y0NwqbxzCX1AprhHw4epP07REtEwVe0pt/rrZhQQYI6h5MCVBTaR
 GSzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA+VkPIWJYwUpKV1K9CyQ8SNo7p5tZtCQxQQ1dwx/pdxHQ3cEPq/xWwVxFIHSySuhOVxI=@dpdk.org
X-Gm-Message-State: AOJu0Ywt6KVMaHuBZJd7tWTyBcV0chdDDmGys4dYMeZZGVsz3EsawUHt
 a44WJnPkojOzYnhoIxholLvoGWscqpQ/XF7a/axIgwbXr+0SU7wZHPab2Z671zQ2bjSVgYXpw8c
 oJ0KrK+VhI5lDaqLMXTs5E07JJ8x/Qutt7u/ocW21lbjvjNrbZStVoPJfRmVbDLcrUjo2PEETsd
 E7eIhxFJdFOrU6Em6ZcrM=
X-Gm-Gg: AY/fxX64TIyERnVeyeBbJD20vKRCSoBr/BB2iiSHNOdhBxdAmCh9+WOifrYRwuNSC7O
 Io6vcZxe43DMxQTq2Qn2q6lmlH5C6stPGsh4tFETIn/hVJDcXXJNvPb8KXRtwMy3rP5aiV1hzPU
 ZMzBCdHLHTfQK0kZySQBdhV3UtE5Kg0gTJpZ0dnBQLvyQhcVA3nWSW8vbeXObGCZYpHrVt
X-Received: by 2002:a2e:a9a3:0:b0:380:a1c:7045 with SMTP id
 38308e7fff4ca-3812156a0f6mr145544991fa.8.1767601045570; 
 Mon, 05 Jan 2026 00:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZMW6w926C6O72zp6C/JbGUZ/+j9SKqSNPxWvEgNLNDs2lyg5dJv8dPlfzzALbpnr1xPU76wV+To1WANVRdrc=
X-Received: by 2002:a2e:a9a3:0:b0:380:a1c:7045 with SMTP id
 38308e7fff4ca-3812156a0f6mr145544871fa.8.1767601045123; Mon, 05 Jan 2026
 00:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20251017111109.1734792-1-ciara.loftus@intel.com>
 <20251222171605.706e9f62@phoenix.local>
In-Reply-To: <20251222171605.706e9f62@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 5 Jan 2026 09:17:13 +0100
X-Gm-Features: AQt7F2pxsWEWhBZTEr_Do8f6bY4ZrQ9YGnuiTASmu90O1r1-R4twUOnU3XTbQhY
Message-ID: <CAJFAV8xgmnc6Cmo5zsxvkDOHzHFXk+YrT19QQc5_Sci-_cEevg@mail.gmail.com>
Subject: Re: [RFC 0/3] ethdev: introduce device reinitialisation API
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: __aiiMDaGweJyPNYopFlHW0QRCFY6jAC_ciRnD204aU_1767601046
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

On Tue, 23 Dec 2025 at 02:16, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 17 Oct 2025 11:11:06 +0000
> Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> > This RFC arose from a discussion [1] around whether a generic API that
> > performs device reset and reinitialisation would be useful. While the
> > net effect of a call to such an API can be achieved with a sequence of
> > calls to existing APIs (reset, configure, rx/tx queue_setup), the
> > benefit of encapsulating this all under one API is twofold:
> > 1. the burden is taken off the user for supplying the device
> > configuration in the call, we use the existing device conf under the
> > hood and only need the port_id as input.
> > 2. it can prevent potential unnecessary/repeat reconfiguration steps.
> > The PMD dev_reinit ops will only perform the necessary reconfiguration
> > steps after the device reset.
> >
> > Patch 1 implements the API, Patch 2 implements one example of the reinit
> > op for the iavf driver and Patch 3 integrates the API into testpmd.
> >
> > [1] https://mails.dpdk.org/archives/dev/2025-October/325386.html
> >
> > Ciara Loftus (3):
> >   ethdev: introduce device reinitialisation API
> >   net/iavf: implement device reinitialisation callback
> >   app/testpmd: support port reinitialisation
>
>
> It is reasonable idea, but unfortunately eth_dev_ops is likely exposed enough
> to applications that it could be an ABI change.

eth_dev_ops is opaque to applications.
We don't guarantee driver ABI.


-- 
David Marchand

