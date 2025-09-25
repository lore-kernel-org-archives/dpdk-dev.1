Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF3CAC5AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 08:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3201F402AB;
	Thu, 25 Sep 2025 10:43:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 440494028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 10:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758789825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1CXa6A+i2ivb0Nwvg0zp7C6ZpGneYkEQ37xeWycP6o=;
 b=chHqQPERJkK5v9DfNlpzR/H3Zczr9PP2HjzRHTiEFy8SkCTPfFv+B09qcnRYcoeB9E9CSj
 9HFEiZnplrSlgjejt8Css489Y/A0AV/dz+7wkVuUgHeXFFauNadlU0SSvEbuU4cIgKV/cd
 getYlFqmfIBsuwhSupw0qQjgORtknDY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-k4CbOiXZPXKVb6kv5ht3fA-1; Thu, 25 Sep 2025 04:43:44 -0400
X-MC-Unique: k4CbOiXZPXKVb6kv5ht3fA-1
X-Mimecast-MFC-AGG-ID: k4CbOiXZPXKVb6kv5ht3fA_1758789823
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-36c0f8f1095so1767591fa.0
 for <dev@dpdk.org>; Thu, 25 Sep 2025 01:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758789823; x=1759394623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1CXa6A+i2ivb0Nwvg0zp7C6ZpGneYkEQ37xeWycP6o=;
 b=rI5FR+mkvCgKbuK2UsePMB00/5tSdDQryexWh3eKaSa3Ids8HCga86nQsByiAYJh6t
 OgMjZSqPs2iNGU6X1qYDw3Y0/trlDj4quCtwWMptINLNybP1cwR4HB++brpV6+vSGwTs
 r+UCl9Dr9vGhnJqTNHnNR0DGGOkxt3zQMSK1P1/a7PjBIY01mg+JzmYxs5j4IyXCyDPk
 E5jH3LkPDNLleuUdbmZsAb7V81wWcRQ8ftjNdbx0fvKtVK48gEmX0eQQD6qrXcZJFo47
 Ug5d1NgLMvl4cYm86XTBRu/JHekYmmoUFJeEryT1ek3PkX2BdKoj4Asajp/T01XxSDa5
 0Yvw==
X-Gm-Message-State: AOJu0YwVbTrNDtAM4+hFt9bVI6qAehGBYiuI3fWcNuHX9HOyVYTA5BwH
 To4KwcCTTbzx/h6RgynWN3/0L6dyiXZD/A0Xu6fxvn7z1g+p97yZZccyFuiexeynLJfmC9/DWPe
 CWJzfK00AWFlfX6HH9r3lXH3iGNIuMo1Ws6zUlTZ1DTAu9W1zcl4DosJtRBx1u9qnzwYYboOZNO
 eIdQkhZvRtivKlXEM1mY0=
X-Gm-Gg: ASbGncto8KkHZSqZd310pw7iftLeGZwJU/zR1C7/ABif0Pk9z+n71QllcvM2b1gFP0B
 tEd3sAKA16evQfjec0B0krVGrHjWIkVu3wT2M/2k+vhciJtJDhsoo7oXU4PszMsZBGxbLCUE3dj
 xiexr+RqUh8uOaZOfxqJb6zpM=
X-Received: by 2002:a2e:b8c2:0:b0:336:d0f8:5a7a with SMTP id
 38308e7fff4ca-36fb0ca5275mr5931711fa.6.1758789822725; 
 Thu, 25 Sep 2025 01:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnDexFa1VoPmHavdqdVyJwoFv4FsA+nP+0UiDWp2WW6xGcv5GT5V889FCri/cXfQIblkT1rzqUlP18ZQ9tKfc=
X-Received: by 2002:a2e:b8c2:0:b0:336:d0f8:5a7a with SMTP id
 38308e7fff4ca-36fb0ca5275mr5931631fa.6.1758789822283; Thu, 25 Sep 2025
 01:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-5-david.marchand@redhat.com>
 <aNT03PNYURvMU4zS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNT03PNYURvMU4zS@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Sep 2025 10:43:29 +0200
X-Gm-Features: AS18NWABmtxrvKwXG1hMmJBgSEk0CWFue0dpVgC_FWGlnJUvU_SexnU7J7V6ztA
Message-ID: <CAJFAV8z1Jvv7JCz+4GofoB8WaBOLV-WcnL+QEBkR3aF1c0hHUA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] gpudev: fix driver header for Windows
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Elena Agostini <eagostini@nvidia.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ycSUhsWzYJsB_h9Nuw6_n4i7zAwkdIWmyoT89IiPUtM_1758789823
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

Hello Bruce,

On Thu, 25 Sept 2025 at 09:53, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Sep 24, 2025 at 07:25:32PM +0200, David Marchand wrote:
> > Use rte_os.h and its RTE_TAILQ_HEAD definition compatible with BSD
> > sys/queue.h
> >
> > Fixes: 18cb07563165 ("gpudev: add event notification")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/gpudev/gpudev.c        | 1 +
> >  lib/gpudev/gpudev_driver.h | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
> > index 0473d9ffb3..4a2335834c 100644
> > --- a/lib/gpudev/gpudev.c
> > +++ b/lib/gpudev/gpudev.c
> > @@ -3,6 +3,7 @@
> >   */
> >
> >  #include <stdlib.h>
> > +#include <sys/queue.h>
> >
> >  #include <eal_export.h>
> >  #include <rte_eal.h>
>
> A bit confused. Why do we add sys/queue.h here but replace it below with
> rte_os.h?

I only fixed the minimum possible in the exported header.

To reuse rte_os.h here, I would have to change more code in the
library as this code uses the sys/queue.h API.
(EAL Windows provides one for internal consumption, if you did not
notice, see lib/eal/windows/include).


-- 
David Marchand

