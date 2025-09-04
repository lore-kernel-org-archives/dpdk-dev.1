Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E4CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 07:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8732940F16;
	Thu,  4 Sep 2025 09:22:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8FB40280
 for <dev@dpdk.org>; Thu,  4 Sep 2025 09:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756970577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tds1zfvY3WHvvCxtnWG3Z98K7XhGLFF6rI6J1IEhGs0=;
 b=WjxjPFleE+ITaejC4ZF8vwET+ZDqissLhLxgbmZQvZ8R1q2VzLiFH99tX2/JgtcwaZHmGg
 MLGTcelbvKXXRsWMYNAeqVT8uTpWaXdKD+dymvdS9UH+CJZXwHJHOs9mUk94VBKnv92yY6
 n3JuGmA4gEMrp8FiN07j7vQZcMJnLGk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-8c0csny_OcKcBb0bC1fEAw-1; Thu, 04 Sep 2025 03:22:56 -0400
X-MC-Unique: 8c0csny_OcKcBb0bC1fEAw-1
X-Mimecast-MFC-AGG-ID: 8c0csny_OcKcBb0bC1fEAw_1756970575
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-56094c1cd55so101550e87.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 00:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756970574; x=1757575374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tds1zfvY3WHvvCxtnWG3Z98K7XhGLFF6rI6J1IEhGs0=;
 b=beXvazrepOI/UiR10Q/bGZ2HmWcReGHMLtNxmrWOIf3oUghXi51dk8gYmd7hGFtgkX
 TJzfKKT0wOfEgZnyNgSz2/atuPJ0z+4B0unZiKKfq1VVrjjRib+/9vew8NNFNxZk/2mb
 zUob7Wv1MvTEdeikZ/CB/r51tFYaPZEDbv5Sb4cNsvLX8dSnQXeczJkqxYnIf3UFG/ra
 BCOexODTYY7hJSmUN5MdtSvYz2lsZTnijDsa/tWcXL5XDjPneLceaTBNRZ/ex+QhN7K9
 sgfltsfwKrYXgCQ3R+V3MiTfhV/7DIfTRXF9AriSDRiie+NzJlLWC+8VBXoJ8v1BJa8y
 t5Lw==
X-Gm-Message-State: AOJu0Yw8ZRjSPcP+CXOAUcEk4fMVQWoaVb39YIr0ZzgQ8QIGGh4qynaV
 3p5HGdKuUGY239vY0xyHMiwOrcfP+tRVmE7tZbSY53rH5zsGzT72H+Hs39CXBQfNx7993pHIAGO
 D4g0fbvQmNHJGfxKKEqJS17fecpLQGPltonf9Gzxz7p4c91pXCI1QyNneaVkvgTQfZKHwOLZ0T1
 +cWBvDnewxau/CoXt57zw=
X-Gm-Gg: ASbGnctg+OunH6Pjuu3jot+Q/pvnVQ59oElnBWrpFxzB6FzIYmIStLcK3m2VjmBfiu8
 IMc+ORof65iu7Z7P/KNn7gGieAaWaN5DoTGwdkR3sziJPF/0hBuHBwRB+E17vqoJ0863nd/2pmA
 iB0NBmoFaFU9E6+ORObC/ftxE=
X-Received: by 2002:a05:6512:6398:b0:55f:3b94:2119 with SMTP id
 2adb3069b0e04-55f709888d1mr4675619e87.45.1756970574474; 
 Thu, 04 Sep 2025 00:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjBQ70lsjdNx1v/rWKtVEF0CZ0U+l0o4wRen6xfN69pUEpCzd7OqIkD8rI+kYoLgdlISl8ahjEKojryHsFEfs=
X-Received: by 2002:a05:6512:6398:b0:55f:3b94:2119 with SMTP id
 2adb3069b0e04-55f709888d1mr4675608e87.45.1756970574041; Thu, 04 Sep 2025
 00:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
In-Reply-To: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Sep 2025 09:22:41 +0200
X-Gm-Features: Ac12FXyNJBX5JgFqkBa_4ib9WGks-dbM2lHtpmNHpGy8qP8oRQMasG8S5rPnJuI
Message-ID: <CAJFAV8xGTw2ibWBjB7CgAL_Vyk4EHKa19NbbRZBLriF6s1=Yhg@mail.gmail.com>
Subject: Re: [PATCH] pci: pci_vfio: Retry vfio setup device reset, if device
 is busy
To: Thanushree Sreerama <thanushree.sreerama@nokia.com>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uF7rDlk3v5XW31Z2WRMhlWvhSWNKyiZA2tGQqEi_9s4_1756970575
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

Please have a look at
https://doc.dpdk.org/guides/contributing/patches.html before sending a
new revision.


On Wed, 3 Sept 2025 at 16:24, Thanushree Sreerama
<thanushree.sreerama@nokia.com> wrote:
>
> From: "Thanushree.Sreerama" <thanushree.sreerama@nokia.com>
>
> Add proper EAGAIN handling for the device setup by retrying the device reset
>
> Issue:
> asc-0a Disp_0[18237]: EAL: Unable to reset device! Error: 11 (Resource temporarily unavailable)
> asc-0a Disp_0[18237]: EAL: 0000:f4:02.3 setup device failed
> asc-0a Disp_0[18237]: EAL: Requested device 0000:f4:02.3 cannot be used

We are missing the conditions where such an error is hit (iow, why do
we get a EBUSY here).
Please describe the functionnal impact.

Please explain how those timeout/retry values were chosen and how they
are enough for the issue you faced.


>
> Caused due to:
> 92d847a35e1 ("Revert "driver core: Fix uevent_show() vs driver detach race"")

This sha1 does not belong to DPDK public repo.
I also see the patch could not be applied in the CI, so you'll have to
make sure this patch is rebased on main.


> Cc: stable@dpdk.org

If you want this fix to be backported, point at the commit where the
issue was introduced with a Fixes:.


> Change-Id: Ic3ae8701fccdbf1e8e2a575d48e707b4c58e939a

Please remove this marker, this does not make sense for upstream contributions.


> Signed-off-by: Thanushree Sreerama <thanushree.sreerama@nokia.com>

And please register to the mailing list, otherwise your patch waits in
the moderation queue until some dpdk admin looks at it.


Thanks.


-- 
David Marchand

