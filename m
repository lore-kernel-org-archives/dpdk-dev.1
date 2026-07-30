Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3DBC55165
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 07:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628BF40279;
	Thu, 30 Jul 2026 09:11:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C63A40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNd163oz7tdpI2YNBunVZEzBH+hfP2cq7oDlPId2KPU=;
 b=dxMtfg6nhX2D8vmyebuaaqOnMJvqZPZ7oaPlaidOvjTEApbDrzV3qaw1t1NQCxz6Crp/hG
 xQnQt6e8PdvopKP1WVQ1pUHzROP2EZ8eB5lKJDd143u1oUDwRBZSlSxGynH0tOpGX2mR5R
 XeWu51dvaC5P1TnU6Yo3dBYFli0IPzQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-CbnxtlCUOv-Jz2NAfBxUGQ-1; Thu, 30 Jul 2026 03:11:51 -0400
X-MC-Unique: CbnxtlCUOv-Jz2NAfBxUGQ-1
X-Mimecast-MFC-AGG-ID: CbnxtlCUOv-Jz2NAfBxUGQ_1785395510
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39c79b2836dso7473981fa.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 00:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395510; x=1786000310;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bNd163oz7tdpI2YNBunVZEzBH+hfP2cq7oDlPId2KPU=;
 b=feLjFcMy4kZyWBYpPNhapYjOzU9csc2KzlX9GdydvhPNjd1uQ9CRtA7TGDMmibZrUL
 +xQcDgsFMOqdaZ0Gmy/G/PDMXjBQzR/HvBJCXhcW46Ks32J73/MaqPat3Wzd3WVwojjz
 6Lv84+4JoYKVr6RbotdB/zFtWqdBztumRrGB8k6sKD9Yf7J8M7wLDQ1DEGEDctRKuw80
 JeujV7OL51vQSILysNeS5ihvpOrpfW71TCpLkD19GE1FX+vEeAIVzdDFSi6itFvfHIIj
 iirJfah55EJp3i0rv2/ShcQZb7FlJ/1YeUj9m4p4mdJ3ZIYCnTSNsanKwfIyhvT/nNME
 wm1Q==
X-Gm-Message-State: AOJu0YyseYSEljMFxjEqjmScjjB1RWcI2xW5Sxup8TTOgkF9iTyzED1B
 5Y0upMSNzUNtjmXV5c/SlojuskKVOmRWh6+Bo2Fr0nwUrzk/9WxZgfI1CfClGBFXYc+0x/q+B4i
 c4thZwHn4E1ab/E7epTFNESg4VuV7Cz4JYemqFU5wXFHyLmV/7va0HlfnKgnYGJm3kJF32LrXC5
 oXFS14EtHRotD4WeptDE0=
X-Gm-Gg: AR+sD12sbP/D66bGrMucWqjxDPFWD4gfuXghKy/9DCFrrHTqN9nn72lYWDmJqVklK82
 OcwxvUs7tkCZF0hvqC+R7PIQKQZjG/YN4LrCZtj5/MT4gICjEq8C1sENloXvcrM2+Y0LdgiHDIJ
 +5o0cw9p1iWQGB2qAJIcmqEBYx6nhOX0JNFjrotY6g17XFIg45zpJ5EXqJk0liKa/T1bErxZd5H
 nw0G+AsiLiAS8GOH2TrceUNXP6aLLLJ0subEMtHn24GDYjt
X-Received: by 2002:a05:6512:3dab:b0:5b0:2176:69f6 with SMTP id
 2adb3069b0e04-5b2db3881f6mr246539e87.37.1785395510189; 
 Thu, 30 Jul 2026 00:11:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3dab:b0:5b0:2176:69f6 with SMTP id
 2adb3069b0e04-5b2db3881f6mr246535e87.37.1785395509681; Thu, 30 Jul 2026
 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260728114600.1870123-1-david.marchand@redhat.com>
 <20260729094343.2330526-1-david.marchand@redhat.com>
 <20260729221352.71f2e449@phoenix.local>
In-Reply-To: <20260729221352.71f2e449@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 30 Jul 2026 09:11:35 +0200
X-Gm-Features: AUfX_mxJoOr6Jle4qzP8e8ozrfcGeAtLEtE4rm4sv3JskwVsSgBtQgHEdXfSSsw
Message-ID: <CAJFAV8yojQwhP3W1VXmmfHTDns-tXW4vwWPDpciMDrWuWy1dNA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: remove unreferenced KNI and examples figures
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ciara Power <ciara.power@intel.com>, 
 Xiaoyun Li <xiaoyun.li@intel.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sean Morrissey <sean.morrissey@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dGzzdRM1LRApyAsQIsAw7IQOZ63rY2pjBsaIHEwOXoo_1785395510
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

On Thu, 30 Jul 2026 at 07:14, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 29 Jul 2026 11:43:43 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > Those images were left behind after refactoring/removal of KNI
> > and examples.
> >
> > Fixes: 0d547ed03717 ("examples/ipsec-secgw: support configuration file")
> > Fixes: aa0d7c2d3283 ("kni: remove KNI vhost support")
> > Fixes: 59c51be41c2d ("examples/dpdk-qat: remove app")
> > Fixes: 207361b35031 ("examples/exception_path: remove example")
> > Fixes: 46971b273ec7 ("examples/quota-watermark: remove example")
> > Fixes: ab6ebd70205f ("examples/load_balancer: remove example")
> > Fixes: 079981e98090 ("examples/tep_term: remove this application")
> > Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
> > Fixes: 3aaa46977de3 ("examples/kni: remove deprecated example")
> > Fixes: f78c100bc871 ("remove KNI")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Maybe a python script to check for unreferenced images?

I have a 5 lines shell script, that's how I identified those zombies.
I agree a more global script could help.
I hope it can be simple, and it must be called as part of GHA and/or UNH checks.


> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks, I applied this cleanup.


-- 
David Marchand

