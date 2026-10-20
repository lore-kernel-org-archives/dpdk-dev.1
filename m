Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED07606A328
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XYl6PKH+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54AB74066C;
	Tue, 20 Oct 2026 16:59:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C1F4940283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792508386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9J5C60jrnudovDuhZ8BsAY7cHlJugh7fpYDimy35ww=;
 b=XYl6PKH+DWubek4cCSe9aUCXTua2uuuYp8wnRtU9QWoWC9uoEISqsGIdNjOyt8RhYpK/E3
 mnHfxAh1pTL029PxE4vcV8OpzXJPWUlPss0Q8o/Wu23kyBFhguoZf2fUt62LeFFsNIbQi2
 GV/q99U7BLpJREIaqOdwfLbe9lyj1zk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-m-hfwdgJMFWTFOJz7I6fWQ-1; Tue, 20 Oct 2026 14:59:39 +0000
X-MC-Unique: m-hfwdgJMFWTFOJz7I6fWQ-1
X-Mimecast-MFC-AGG-ID: m-hfwdgJMFWTFOJz7I6fWQ_1792508377
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab3dac2898so10421361fa.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508376; x=1793113176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J9J5C60jrnudovDuhZ8BsAY7cHlJugh7fpYDimy35ww=;
 b=NVMo+obum82mu15eQZD8MkAZbbZzQxDRRRrpoy2znFortagzt80knvW5r8a/SBlYqH
 RBOapjGo+sJBVkg4HEeHv0nDKUXfxYQQ8BXMUc6vaf3TZH65bQ5qeKa8Ii4qJ+hR5OHS
 G3aW1DU3CPsereYiEF8Yi9Zx2ww/o1ZffkNJik5+CITtgIgPxaYeZb1knenwkKlhrKpy
 v6v0OTWjexb5bgYnP8CBWQWyoPkz2pwz23+NOr7E/d+OuPxnlH8x4RnSY3AQWOP5xe+b
 t5u+IyE8eDMOS8lVKV6xTkmikTyrvDMbftUyLFB/Lqo7v9r8Qsml0hAfV2CYYX0Ujrie
 8AOw==
X-Gm-Message-State: AFq9FYLo2cvKVjLGtrt07tsanttVhIDK7Ln3XqSSHEWfeEltcScDYsw7
 0ZSOMeyGMYx1Q7jAdyghXInE8j6ztudOJz5F0+okLj7x08hyboYGmzIQzdivWq27JYxLOLQescX
 0jbxvQRaLopXeTtueHKD9+PL+XwpC+dcEqE0LssuRkD1/U0qR90glB7/SfITAj0/XkIa8g/hus4
 eiin9wKcelUZMLCofPkh8=
X-Gm-Gg: AYBFou1ZJpKLgk3R4M3c48ma/FUX9Or3x3eypSxnytqZTZwAp1AiVzHTn83uVPefY8w
 DIy96lyClJJ7Vsa6bOxrHQL9TapKUkC7NpozuQbC57Brl6xS0cKTUlH7JJT1nFmWgvJBl+C/bsG
 BvXXlxv4AzPKgsFGiKQ9GM8teBWbZ6rvHoeyZlajEB8d/MBKLTVU1u0zxIrxVRl0QHHyC8+zjuV
 QMUJptliq0hJy6nlvNmqag1r9QE1HtoFlC0wXZ+VnRJaqj5
X-Received: by 2002:a05:651c:1b84:b0:3a9:82c2:ec1e with SMTP id
 38308e7fff4ca-3ab291767e8mr24195421fa.15.1792508376617; 
 Tue, 20 Oct 2026 07:59:36 -0700 (PDT)
X-Received: by 2002:a05:651c:1b84:b0:3a9:82c2:ec1e with SMTP id
 38308e7fff4ca-3ab291767e8mr24195311fa.15.1792508376153; Tue, 20 Oct 2026
 07:59:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
 <20261015112916.2622825-3-david.marchand@redhat.com>
In-Reply-To: <20261015112916.2622825-3-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Oct 2026 16:59:24 +0200
X-Gm-Features: AclHuK8y2FCAzfzyXiCgSVCTdRZ9HoNM56U-A1FfrZUlNHAtSeOH1NzGjE9jpRg
Message-ID: <CAJFAV8yUQ2qHU4GXxEdXZit_f=1M-VdJmQrWRMZAQ2TwJB62dw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] eal: enforce internal API check with Clang 14
To: thomas@monjalon.net
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xsTXN30JU2UdYcF3w_P8-T14ePIa9VZfql5jZaRoC-8_1792508377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 at 13:29, David Marchand <david.marchand@redhat.com> wrote:
>
> From: Thomas Monjalon <thomas@monjalon.net>
>
> The __rte_internal macro is intended to prevent calls
> to internal API functions unless ALLOW_INTERNAL_API is defined.
> Unfortunately the check misses some calls to internal API
> when built with GCC or Clang.
> Clang can be better to diagnose such cases.
>
> Clang 14 and later support the error attribute
> and therefore select it instead of diagnose_if for __rte_internal.
> Unlike diagnose_if, the error attribute only rejects
> internal API calls that remain after optimization.
> Internal API calls can therefore go easily unnoticed,
> making internal API checks less strict with recent Clang.
>
> Prefer diagnose_if when available to keep strong Clang diagnostics.
> Retain the error attribute as a fallback for GCC.
>
> Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Series applied, thanks.


-- 
David Marchand

