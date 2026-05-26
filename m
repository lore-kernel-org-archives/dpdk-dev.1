Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3531CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 09:49:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04357402E1;
	Tue, 26 May 2026 11:49:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3C6B2402D7
 for <dev@dpdk.org>; Tue, 26 May 2026 11:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779788942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fS8mutOYRP1s0apWurEdxlWkc4iGUZL3pWgYDD/XGSU=;
 b=N/fwJ9qV09HXcQyOBBGORJho95PHpRLg6ldnP9nMHnaCaEbMCj0WE1KFxj+wL5c60cvwH1
 kmCvxHfeMzopPiKFSzPDei0rEup+LbZggVTIA3md0bxkyEJsq41iX1ePmbaOtQtv7GEnUn
 WfKvJ2kdJb6OJyhrrVcSopNaf68XQ48=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-0mAIlyxbMVevJM__ZrQ-Ew-1; Tue, 26 May 2026 05:49:01 -0400
X-MC-Unique: 0mAIlyxbMVevJM__ZrQ-Ew-1
X-Mimecast-MFC-AGG-ID: 0mAIlyxbMVevJM__ZrQ-Ew_1779788940
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a405bbccdaso6044642e87.0
 for <dev@dpdk.org>; Tue, 26 May 2026 02:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788940; x=1780393740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fS8mutOYRP1s0apWurEdxlWkc4iGUZL3pWgYDD/XGSU=;
 b=AX0hE2s8dsGlJprtOYRz/a+jkx3SxQokFrNLx3lOlat2P1tzT5cA0Joui4H1Dit0RV
 L4gjSxfzgM9cFGM3heDI5fhIH/tE9f1t2XbXOycfQem+UeDVmBlir0x9hClPs0pC5SCm
 YX5OS6+ivakFXZOA+JVr3EjZ5VGLhBhdLdL4BsvYG+R29GvqD0lNXSSlgpzpPlFLeUnk
 1ycbwTFinhtK25XfNdYnZFM99wDankhP9SszI8E3A7a+RgvTcChGqqVGcomhsQM8s5DA
 KF8klvXxK8cmjttJs0HDNM9YB3645Qar7/cGkamgRZUMxo8lWJpfqvDyggP8WLtO/dVe
 WTTw==
X-Gm-Message-State: AOJu0YxulLLM9rXxTpKAH2cRfJ57hBQijX+E9oP5UVNFyhDiMC/ijGpU
 a1Q5Kd5NDJf/jdpKnxNBGFcmP3ZvIrO2S9+4Up4a4AB/JlbzAId9Gy3MA52vk8EKleNRQVs/kBA
 RcMPzLe8lRia8pSf2kagTMEXayxHeq5o2zmPcrFoE43gxya8voQURo9h3cZKF3K4nMfcf/9Z6+S
 ur/KLgatm/3S5FKBkBsoo=
X-Gm-Gg: Acq92OGO0IZ+RedalBkwdCgTK82P5yQpnMjFZ0FgTvvrI1ntaSx301b66m3ge7I5DW1
 u7KF20lkk8uoLh2CXFMmFmZkNL5YwFaGUoQtE2Bir7sK0Za9QUJlhyvAe55GuBM/SsZfuTg/Tp4
 a2SeZ1+pMEB8F4S+/YJskCUxxcNEqCa5DZFTQIbsvIzYnabbyhkKVgtyNsI6SStnCqL4qYIauQa
 EU4Sm6gEZvPe7kJSoo75JTWw/IB4b7M51BsfdkBMyHWgdsOFbN5gOqcy+rHXqSkc56lAQ==
X-Received: by 2002:a05:6512:48cc:b0:5a8:87fc:2b34 with SMTP id
 2adb3069b0e04-5aa323c3ee8mr3765319e87.32.1779788939617; 
 Tue, 26 May 2026 02:48:59 -0700 (PDT)
X-Received: by 2002:a05:6512:48cc:b0:5a8:87fc:2b34 with SMTP id
 2adb3069b0e04-5aa323c3ee8mr3765311e87.32.1779788939092; Tue, 26 May 2026
 02:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
 <20260526084212.3145685-5-david.marchand@redhat.com>
 <ahVq9dJrOK04Ujwd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ahVq9dJrOK04Ujwd@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 26 May 2026 11:48:46 +0200
X-Gm-Features: AVHnY4JGYJgJwsEDb1qQQVxFb3Fgx1G9Dv0cfOABnkOzCz3ctG-P-jTczVm7eWw
Message-ID: <CAJFAV8zC=LUR8r4s7q5o9W2KaAa3PjKD8+qoAUsV70Ddqvgp1A@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] dma/idxd: clear device at scan
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Akq8Psld3ZIVb1_Pl_RO_t_h8JcxsMNnRBpNG6ysNk_1779788940
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

On Tue, 26 May 2026 at 11:42, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, May 26, 2026 at 10:41:44AM +0200, David Marchand wrote:
> > Currently, the device object is only manipulated by the dma/idxd bus
> > callbacks and EAL is not looking too much into this object.
> >
> > However, in the next refactoring, EAL will expect a clean object, like
> > when checking that the device has been already probed
> > (iow dev->driver != NULL).
> >
> > Request a 0'd object when allocating.
> >
> > Reported-by: Bruce Richardson <bruce.richardson@intel.com>
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/dma/idxd/idxd_bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Out of interest, did you (or Claude :-) ) run a scan over the other bus
> drivers to see if any others are similarly not properly zeroed on init?

I did check, the "legacy" way.

All other are calling calloc(), or rte_zmalloc_*, or manually clearing.
I hesitated at changing the malloc+memset pattern to calloc, but I
left it for later.
The series is big enough.


-- 
David Marchand

