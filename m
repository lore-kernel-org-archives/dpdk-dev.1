Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ECBCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDDA44025F;
	Mon,  1 Jun 2026 16:39:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B6D534025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 16:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780324790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=59LdPZBS3nKGVfO3GYUdUa9YSBKbRn2I0jKl4wNQrxI=;
 b=Zy7d52ZkKIrxKmV4+SXk60hC/EzOfSa5WNvyWrXSd1xjYZ8FZ/7ioSMXw5iH/UMckWsUpS
 vhJ0I8EHbX7ybHif9SQL69dhmfPSf9ySyFhZ7CgebhW5Po8z/EVWH6QJ1bBHL9mbNl1ehK
 sqIch0B0M97xp+bSaBZuwOhMQxvDHCU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ltotQfK5MhO6V6W5PbHIPQ-1; Mon, 01 Jun 2026 10:39:48 -0400
X-MC-Unique: ltotQfK5MhO6V6W5PbHIPQ-1
X-Mimecast-MFC-AGG-ID: ltotQfK5MhO6V6W5PbHIPQ_1780324787
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3967e27c060so6472681fa.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 07:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324787; x=1780929587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59LdPZBS3nKGVfO3GYUdUa9YSBKbRn2I0jKl4wNQrxI=;
 b=RwRaSK5sQ3JZai6UFXqexnPBYQhMcHweqaQ3p0oQqXOyAl99749p6/k0GFlYnxkIr7
 nOySppWkAeqO5yrcEufR/L2cKlficv+zcc0KpVgOSpfZelSFiUTChTk8XL5H3tDCWE6S
 vcJYpC4HJ0d02U0Mp4H4gc+8O71FbagGxrKufeEeygQ3mdAi+WfYGWYObzd4HY1HqB9n
 Zhi3oTAfalrk6mIevP8JfxR8J+lqr+s8dvj2NCdOtx24zhXPm/ThuJojLxHWUmFhiZey
 ymH9dpUD4qe4EoVoDibmIrSB93HPhL6LHgzyFVlZdvQ9dloUk+p0YKAsmIvJSZvRa5Xc
 ukxQ==
X-Gm-Message-State: AOJu0YxYMTlegSpwpWOT/UiOQGe+GAcxFiF/RYy98SkdtU6dLElcYTtx
 UbDRpRGcbhwhIrDd2JY74V+T3EsH5W9WuGI6j3LRhGB2e/KmdGipBbgfFCxypRYMaAc71jK+K0N
 r46+amurfa4P4OPWhgNguqGIm7uwt9DseTfs84xBI/uuEULvH5gfbkSLA34/GmZmDCdQTgSZ3bb
 Dc4OayJMXEJsMssefDmGU=
X-Gm-Gg: Acq92OFCR0J96ItTvhopxpycDhlim6KV/YnRb/scxLY2dkD+Cx/qF5QzlJ4Q6lUy9J4
 e1fVHG8vJah7s7t3izZXi7/cqZpEzrFBPypX694F7SMGV1Y3Y4FYmZhOUY+qjKAEIFUA4eMb3Ow
 zq4FkVNtjbKy52N/x7GFRLKpopiiEfmGDfgaoDcVyw4Aq8MnJrcrXuMXzLC0Q45RjHRLcI3s6Pd
 ys8ftO5do4zUDG4Wenqp9oFtjuQ7x45DPcc/v+KVXSsb9WkdnHcy7mjgy86+AJI4fMCCRj9YsqK
 ba5w
X-Received: by 2002:a05:6512:3988:b0:5aa:63ad:77f7 with SMTP id
 2adb3069b0e04-5aa63ad7b10mr2670080e87.25.1780324786939; 
 Mon, 01 Jun 2026 07:39:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3988:b0:5aa:63ad:77f7 with SMTP id
 2adb3069b0e04-5aa63ad7b10mr2670064e87.25.1780324786433; Mon, 01 Jun 2026
 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260601132402.1125588-1-david.marchand@redhat.com>
 <bUYoD1-ARAaefqQHkOtV4Q@monjalon.net>
In-Reply-To: <bUYoD1-ARAaefqQHkOtV4Q@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 1 Jun 2026 16:39:34 +0200
X-Gm-Features: AVHnY4L5E831T3RtJoT7ooRSt0Pqr5MLkYjwkgBwwWwy69gmVdgYS1VAK9aO36A
Message-ID: <CAJFAV8zkunAVfXt9_e4WO3ohagc2OU2C2XY7n_zjEckNa7g1Cg@mail.gmail.com>
Subject: Re: [PATCH] devtools: add Vertex AI to review scripts
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J-8oE3a1DbvRgNOUwbVQqHJM3YT9hfLiC3NvdBq8uf4_1780324787
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

On Mon, 1 Jun 2026 at 16:21, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 01/06/2026 15:24, David Marchand:
> > +    if args.auth == "auto":
> > +        auth_method = detect_auth_method(args.provider)
> > +    else:
> > +        auth_method = args.auth
> > +
> > +    if auth_method == "vertex":
> > +        if not VERTEX_AI_AVAILABLE:
> > +            error("Vertex AI support requires 'google-auth' library. Install with: pip install google-auth")
> > +        auth = "vertex"
> > +    else:
> > +        api_key = os.environ.get(config["env_var"])
> > +        if not api_key:
> > +            error(f"{config['env_var']} environment variable not set")
> > +        auth = f"direct:{api_key}"
>
> Could we have such code in the common file?

Indeed, I'll wait a bit for more comments before sending a v2.


-- 
David Marchand

