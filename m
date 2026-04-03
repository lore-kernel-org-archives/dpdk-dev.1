Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042CE8536F
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45E5C40296;
	Fri,  3 Apr 2026 16:25:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 791B54028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 16:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775226331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNFxT+zmujp917uyWj3JgWmczfXsZNRN6ml0K/+DC/k=;
 b=H1A1Cv5YqdGVN053z042IzBK/qNPvvkxZ0IP8Cz0oALZKZg9BDgaGA0kI33K/9k3dRwmV8
 uy02nYV/0r7WeCaxrllaCSMhiT9T8iaGbEEsKehHY9Dl31Z7JLpvpoIZonPIKwr/JsuB8I
 XGLW8g54v2vmLVquCKEtAeXYPiuhuOw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-RPnY469MOGWPcyyksy46Og-1; Fri, 03 Apr 2026 10:25:30 -0400
X-MC-Unique: RPnY469MOGWPcyyksy46Og-1
X-Mimecast-MFC-AGG-ID: RPnY469MOGWPcyyksy46Og_1775226329
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38cc82a2515so10718161fa.2
 for <dev@dpdk.org>; Fri, 03 Apr 2026 07:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775226329; x=1775831129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNFxT+zmujp917uyWj3JgWmczfXsZNRN6ml0K/+DC/k=;
 b=Vfy+fjr854FPPL6HnSIEcPJ44EPSx09QpspA7U8DlffJ6QuAY6w/Z7jtL+rtb7TIRY
 qN+OwCOuSG7uMP0stE0Nc1/GlOBW3d5xa9bNxF3qkAiTFcpWKNvkJJu0xrk4GGHhf39l
 y3lwVm4y+LDKqMf+37GcT7Lqs0eUIsFWFZEr/EqAbQVZo6WZN6+k9IPC6fwCP+fBwL4v
 ceLBgyQci1qktMTewkAv0nTjNYJojLOOsjGCt+8zMuEvlvtKotd1c4oqwNtOonQNKFxP
 NW/W1EJURZ9A6knc+pzc/TTzUmWyBZxvYh82WGwe0q79bEeeT3rKTUBUtvJ8tHwlT2cB
 n1dA==
X-Gm-Message-State: AOJu0YxO7yUvJlYhKWYPWQt56VV3YKCWtUUOVtYW7XAUDmwQLtzxVUXa
 cLYOq8a8Zt4HX7YPNxEpND60jAPY+Q2UFV6IVnn315QvjOkfE8xF6xBwfaZ2jJcNDnUWG5vTo8S
 iGkR8Yav3Oz+9vD3yO5WOfDlNsTgyfY4NxwJyyQ3W/4A2hkCMWehRl0mMCT/gmvs9TL21ymY17R
 syF64ozSEX0/ujxH4TL6M=
X-Gm-Gg: AeBDieuXMH9Fuur8+YgDyJfa/0tyITXPe0VY3iB/SGw1Iw0POvXOb0pvoHNpoARhZwI
 Xt7YfX6P/ZZuFY4u1G6m8FvQNoqv4b3zjpLz7HHE4mVeh8Km/TBBipJKV0vLbJrlnq/vqLmsfhr
 3CKNRuXy3SZif1ZMEldusp4pOsAsLz2tZCO+5/5+aGsYOfnIuEohi90yl8HXlfbeScEd/MOpk0G
 vRdT7NT3Rhz6FBpIf8OPw7thGs47ro7exWeKaXd6jCkk8T6pbQ3QN+5hDwuIP2Q5klwOg==
X-Received: by 2002:a2e:bc0a:0:b0:38c:7ef:9dc5 with SMTP id
 38308e7fff4ca-38d8d368fd0mr11512221fa.2.1775226328824; 
 Fri, 03 Apr 2026 07:25:28 -0700 (PDT)
X-Received: by 2002:a2e:bc0a:0:b0:38c:7ef:9dc5 with SMTP id
 38308e7fff4ca-38d8d368fd0mr11512091fa.2.1775226328326; Fri, 03 Apr 2026
 07:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-8-david.marchand@redhat.com>
 <32a077bd-1344-459e-9f78-fb38490ca21b@huawei.com>
In-Reply-To: <32a077bd-1344-459e-9f78-fb38490ca21b@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 3 Apr 2026 16:25:16 +0200
X-Gm-Features: AQROBzA_9o50l-zSFHXNJfbh42AM0Dpm76s0Ntrd1MDTNKvlWgcYoP1yt16uHaI
Message-ID: <CAJFAV8zXHbAbc5NAdDNtypT0i_da5BJcEx9V6+DFzrxTt=VqEQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] eal: configure initial device probing
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g_2k8tt4j0da-PSrifPtQfJb-0qaChxWES2TI95zW7w_1775226329
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

On Sat, 28 Mar 2026 at 05:01, fengchengwen <fengchengwen@huawei.com> wrote:
> > diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
> > index 95d327a613..fac45cbe66 100644
> > --- a/lib/eal/common/eal_internal_cfg.h
> > +++ b/lib/eal/common/eal_internal_cfg.h
> > @@ -104,6 +104,7 @@ struct internal_config {
> >       struct simd_bitwidth max_simd_bitwidth;
> >       /**< max simd bitwidth path to use */
> >       size_t huge_worker_stack_size; /**< worker thread stack size */
> > +     unsigned int no_auto_probing; /**< true to switch from block-listing to allow-listing */
> >  };
> >
> >  void eal_reset_internal_config(struct internal_config *internal_cfg);
> > diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
> > index abee16340b..6a5ddfd8d1 100644
> > --- a/lib/eal/common/eal_option_list.h
> > +++ b/lib/eal/common/eal_option_list.h
> > @@ -32,6 +32,7 @@
> >   * Format of each entry: long name, short name, help string, struct member name.
> >   */
> >  /* (Alphabetical) List of common options first */
> > +BOOL_ARG("--auto-probing", NULL, "Let EAL probe all available devices unless some -a/-b option is set.", auto_probing)
>
> This commit only check auto_probing and no_auto_probing conflict,
> I think it no need add this arg because auto-probing is default behavir when -a/-b not exist.

Introducing the --auto-probing was an ask from Thomas, so that
applications can start requesting an explicit behavior, rather than
just rely on the *current* default behavior.


-- 
David Marchand

