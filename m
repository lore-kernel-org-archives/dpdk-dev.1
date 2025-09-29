Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50032CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2341B4028C;
	Mon, 29 Sep 2025 11:07:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B1BBF4026D
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759136824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kc6SnLAwT94bSV0wn96v2EIj021int87v+pXCcGh7g4=;
 b=OvGEZu7YoFg99zStPAkf16nJ74CmN3DtiyzIK/7cJS1DJS+j5RufBcXRnmgEI4jT+Nquqm
 aKzoMNbdXYQG1IllM2gmv68RlAOfTTUE2//d+/gKtHTDuqYLAoVAGZC04YV59lSH+cKNj6
 W22u/jfQ648D8hTtiv1TiDzeQGYrrtQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-VCwisQRtMRi0jydogMvrcg-1; Mon, 29 Sep 2025 05:07:02 -0400
X-MC-Unique: VCwisQRtMRi0jydogMvrcg-1
X-Mimecast-MFC-AGG-ID: VCwisQRtMRi0jydogMvrcg_1759136821
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-368348cf7d5so20947651fa.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759136821; x=1759741621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kc6SnLAwT94bSV0wn96v2EIj021int87v+pXCcGh7g4=;
 b=D/z8fbO17Db0jJsScQJPiV2tHymWcV4tHhVWdwSBONSiSy9fA/n0ZT0BL0wPtGcczp
 yDOn8MY2H7/Tu3lqzAJ638r70OW0gaVnTh5nU1rAkc1oMG3Usu8xBM0x72ip3eKlu9Mz
 bxPjab/kk396/H3CYzHBDWcIC/fj/p5HmJEXkhc26vfs/Gs6E4cQlcvRgwjY3LVeHTPb
 BMNUbPw4qH8eXIQocDJprNvTzw+/FZSFwGdtiI/W/zTiOkpVq2+XMDE8rVQiCsGkxYfr
 /HV9dfllP9eADnbUMfeuAfO/KkgJjqCi8ooa16XnySL6ptX1WUbhBZ4+Dp+3ByYZ2CD3
 ryug==
X-Gm-Message-State: AOJu0Yy01TKiExRl6Hycsl6iw+5pRczWpTKxesBT5wqgNOpW7yA+HZX6
 lhERSsIJA5rXnOtBuAMApx7h3srvOQq9GglaZ2IiQsyPoYcQkSowpkF5y553xz7HmhgwxmqlT/e
 qucRvvReVC+KSje6F8BSpemc59+YyuR/V1X1fcDrNwNVxOvgodllMBjgX9j6wXY36fmWkoADDAf
 EvNaizu7ehAra8UPkiEzw=
X-Gm-Gg: ASbGncuWlGYwbTbl+0Dhaf8gQLrWNRAJZ9+XnNSl/3D6b+qGxNev+EKSGCR5Xgz4TIa
 jNBbPXNfPA/dIPFepEkrwRGEyVgFRuIR5cOHeXZcttlwA5AM7fIsQ5ZIjrBBJGaX9GEkCLmWxZf
 q5MiC9P11nel9+idwkB37CNQM=
X-Received: by 2002:a2e:bc1e:0:b0:35f:a210:2a02 with SMTP id
 38308e7fff4ca-36f7e78a86bmr43819521fa.26.1759136820805; 
 Mon, 29 Sep 2025 02:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv28E0KfUTOGAw8ZRmDq8+mIeTocfU+dWrHLXNJU7hh24+l2p79o8/UglvCfK+VOzlMnxogtAwNxPHd0Zh/XI=
X-Received: by 2002:a2e:bc1e:0:b0:35f:a210:2a02 with SMTP id
 38308e7fff4ca-36f7e78a86bmr43819451fa.26.1759136820308; Mon, 29 Sep 2025
 02:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-9-david.marchand@redhat.com>
 <aNpAXuCNZmNy6bAR@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNpAXuCNZmNy6bAR@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Sep 2025 11:06:48 +0200
X-Gm-Features: AS18NWCdZhSFYoT5ohENzZDgzxoUH5jEJxqUTkhumJY6vcbdXzxl1Ca2oooNtmo
Message-ID: <CAJFAV8zKKRdiSyHvNwQu5u6WUrrJX2uAApfThAwwkhR+JFuARQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _dRzEK0-3EZqD08x_n26Py5Fw2WIQG-XF5dvbwH3fbI_1759136821
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

On Mon, 29 Sept 2025 at 10:16, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Sep 26, 2025 at 02:41:01PM +0200, David Marchand wrote:
> > A problem with the current headers check is that it relies on
> > meson dependencies objects that come with their include_directories
> > directives, and all of those point at the library / driver sources.
> >
> > This means that we won't detect a public header including a private
> > (as in, not exported) header, or a driver only header.
> >
> > To address this issue, a staging directory is added and every header
> > is copied to it.
> >
> > Drivers and library headers are staged to two different directories
> > and the check is updated accordingly.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since v4:
> > - split global_inc (isolating config include path from EAL headers),
> > - moved all changes under buildtools/chkincs,
> >
> > Changes since v3:
> > - removed update of global_inc (which was unneeded, and probably was
> >   what triggered a Windows clang build issue reported by CI),
> > - moved all staging operations under a check on check_includes= option,
> > - moved staging directories under buildtools/chkincs/,
> > - renamed all variables to reflect those concern the headers check,
> > - made chkincs binaries depend on staging deps instead of having the
> >   libraries/drivers depend on them,
> > - added C++ check for driver headers (missed in v3),
> >
> > ---
> >
> Played around a bit last week with options for doing chkincs, however, I
> didn't find anything obviously simpler or better than this. Let's go with
> this solution!
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for the review.

I got an interesting comment from a rabbit (in the middle of a lot of
noise ;-)).
https://github.com/ovsrobot/dpdk/pull/106#discussion_r2382870892

That's not a common case, but this could be tricky to someone moving
around/renaming headers.

What do you think?



-- 
David Marchand

