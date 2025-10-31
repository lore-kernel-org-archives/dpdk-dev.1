Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FDCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 07:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15982402AE;
	Fri, 31 Oct 2025 08:51:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 57C9E4026F
 for <dev@dpdk.org>; Fri, 31 Oct 2025 08:51:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761897104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aQdpfEfZTQNwRLanLErAocMZTLSF73qx9PiOhRHYnY=;
 b=iXwtysQWIbJMx+ROo1zKxT855ga8c4Acr84hUojQjI17oaEAiJ2neLI7uQzAX6IhmSQ5Kd
 yVn+FXWydu/2JGt+yciMTMsqp32CT3R6rBadbYvdEM8MsBjqoc40Lf04CoYXCaVXcy1yEA
 lH1gS6y8+q+X6IyxdkzugNzIxgzHN1s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-xRfC6romMK6sKZMKpSpPHw-1; Fri, 31 Oct 2025 03:51:43 -0400
X-MC-Unique: xRfC6romMK6sKZMKpSpPHw-1
X-Mimecast-MFC-AGG-ID: xRfC6romMK6sKZMKpSpPHw_1761897102
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-37777da28beso7998901fa.3
 for <dev@dpdk.org>; Fri, 31 Oct 2025 00:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761897102; x=1762501902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aQdpfEfZTQNwRLanLErAocMZTLSF73qx9PiOhRHYnY=;
 b=DOsE/fyQaFWjZAH0pGzDQGSy1GV1fovXyF52V2MVVG2M5xm22VIt4fh+PMcE22Q1aD
 HpxZw0ABv50xlj+abHQzobqnaG/1vY6x1V6zQhhcsJwGPx+m/UpqqaxwgRV1sy1nwW1G
 +C393IS/AFy8WF8Dhupcb6IAcWQLKcz9NQa8BvyOtzJinyaeFRmoc24LAh87DNXJ5saI
 JjCSwKBxc6tECNNS8fRtH+IJcYYjR2uy7BvGAsbw9PbDxSqPGOyHC0C4ejir3Cl3+iHP
 1WabAFt9wEfLp8JNoy5Gms98744MrEb///oBQK15jCNIBBa00lmvD2IZnrXrEdvRqroL
 xFRA==
X-Gm-Message-State: AOJu0YzZ2MaHR37PN2YC09Smw1yM/Y2AZoEJQD9YfrkCc00mRjQBpgtV
 iDmejyWIOiZfYPBxUoyXmhf/t6dCHau/a1mQNJLXmsKm7rQvK50viySEMt4JI3HvLkaFAONGcB6
 STE/A8INM1qIotJX9RtG+05xpZecojcXEH/tE54toiM9YPEiBsHbUCRRNJbxhe2E5h1hTVBwmMy
 GZTFMjyrKEvCjj9E/4/A0=
X-Gm-Gg: ASbGncsLqxp1JE6CXXRymAbJ3vc4A0JwE1P+2mJdRMztRyJe5TEdSoWnU4MwHNnvluM
 Y/VXR0yFuplLihL2ZqTs72OB69Wcq961YrO+HOoqdMtITWbJy211EwvkYyV3FuEzIHmlYk5J9Ov
 /uaGs3Ku14gqFFbDL2l7AlP6FhOwe0e4YT2R+We8xvinubW4ofn3zGG04Fkg==
X-Received: by 2002:a2e:a90a:0:b0:378:dc27:90a6 with SMTP id
 38308e7fff4ca-37a18dc61e0mr8764831fa.23.1761897101602; 
 Fri, 31 Oct 2025 00:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHseicVMvp6lfKqxgERh95jekMORUST6lbqAMeM0IEMbQMZuHqOrVtns+le2Q/em0DK5bmxkhbf5qReCPV5Q+U=
X-Received: by 2002:a2e:a90a:0:b0:378:dc27:90a6 with SMTP id
 38308e7fff4ca-37a18dc61e0mr8764751fa.23.1761897101149; Fri, 31 Oct 2025
 00:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251030175329.4041960-1-thomas@monjalon.net>
 <20251030175329.4041960-2-thomas@monjalon.net>
In-Reply-To: <20251030175329.4041960-2-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Oct 2025 08:51:29 +0100
X-Gm-Features: AWmQ_bkwi6mcNCO7itghTdFebhURACd0f3qaj8xRorIJZ22IdBqir4H4KtFS_R0
Message-ID: <CAJFAV8yFGNY152CaOWL+0YScDr7xKyaU9PpjS8TMaVjzRUa-eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] test/hash: check memory allocation
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bTvgPu1dK8iqCiqDDlkJZengyMgSND58wVuOEEymf6o_1761897102
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

On Thu, 30 Oct 2025 at 18:53, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> When reserving a specific memory amount, it was possible to pass
> the first allocations and fail on a later allocation
> where there was no check, resulting in a crash.
> It is fixed by stopping the test if allocation failed.
>
> Fixes: fd368e1982bc ("test/hash: test more corner cases")
Also
Fixes: 9c7d8eed1a45 ("test/hash: add RCU tests")

> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

