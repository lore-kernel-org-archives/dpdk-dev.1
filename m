Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95947C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 11:56:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AEA740299;
	Mon, 29 Jun 2026 13:56:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 82E804021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782734175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H2SLjYsr6ryXw5IpW38UJZCr9mtAmahNMoOR43hZtf8=;
 b=EkNPLEW9OosPyHhxB4ZxBF2Vhyvn+0OXdfmmpX2n31skCwrjiVBzpNn3PHb7HZFCnRrOrf
 RXng5dSIHZmoO0HJIEkG8SFyAzuLUwVWCXIVk9ZGwrUf6/bVPzK2A4x8/lVY5Bvauz7Ezf
 4/cCHQxQsBcaO/Snc7MyPHjGv/J+sE0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-WQh6CUHdO1ypHb-a-0UE-A-1; Mon, 29 Jun 2026 07:56:13 -0400
X-MC-Unique: WQh6CUHdO1ypHb-a-0UE-A-1
X-Mimecast-MFC-AGG-ID: WQh6CUHdO1ypHb-a-0UE-A_1782734172
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39ae216b900so9316301fa.3
 for <dev@dpdk.org>; Mon, 29 Jun 2026 04:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734172; x=1783338972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2SLjYsr6ryXw5IpW38UJZCr9mtAmahNMoOR43hZtf8=;
 b=o+0Nw/bqt2DwJwnJRCjQoksDDvogmcKsmiXlWoQwJiSy1EsN4muKidDUHPNaTdKCrj
 TTdHsmH72W+tpK5saJvyiEhvEXfoDEkztRLc4lU8ecuasUiOcWW3UBL24xGjM2omUtL7
 fERYdBPHDn/PB/iyaditivAIdbVozhA0JfnSCNVK4+XDzunrObRco0/KeydrsR6LJu51
 xHkUF7vDvr7pTbfSY+QAHC8LDfkLLNduJNfnC9ZRrrJd62tU7aWGPajkTABGx/4MrkBI
 AiSr75gcvT0pIu2WxKge55mx8uJi2DSpcR7S5Hq/AuWr27SLc6LyOKCUU3ujRdp9jtD0
 vnpQ==
X-Gm-Message-State: AOJu0YwQkRL50it2JcdjgScB61Visnb6lcDwmWvTLaxmiPAW9bmNT46x
 iA09w39jyHJxW3dkCY3Yg9jOZqRsiPAn/RTt2RExYstYm57kPF1jB45k7vkvVFgF2L3qfPEG7LT
 gfSp5q4zxyOwaYTWMtPlJ+9IE0oVgVYSmPUJ1HAtuoxhGepHHOxuOIbCKTR6Nb0SBvRk5QCGWEu
 xw+p2qQ1biVgP+50ThbII=
X-Gm-Gg: AfdE7cnr2xtLOlWj4saDHD3vLE68o2VVVs3cK23yfCQ20YyyGJyZrVWcJiqrlYPhsTB
 VZWBfRSudu8A17o1OuAefWmgrMYcWisd5ddoAZUflspI+qecwpghDWwhzdKbtR2Sq0ohKXgvkR4
 mzL8ce5mzgxvcb1xnDxVhy7CUp0kQjKiIHWIwUsr/DOEhzBFAdMV/CGeUW6Da4mBWepaR7rqBNw
 bYaCJnS/U0QLEv1fRaAOPp1Dr0yVXN80XCo5L0DLr+WBSa75Wd7BdZI+b0=
X-Received: by 2002:a05:651c:20cd:10b0:399:87c9:4573 with SMTP id
 38308e7fff4ca-39acb69a85amr27952661fa.22.1782734171798; 
 Mon, 29 Jun 2026 04:56:11 -0700 (PDT)
X-Received: by 2002:a05:651c:20cd:10b0:399:87c9:4573 with SMTP id
 38308e7fff4ca-39acb69a85amr27952501fa.22.1782734171190; Mon, 29 Jun 2026
 04:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260624113550.821516-1-bruce.richardson@intel.com>
 <20260625130813.1527333-1-bruce.richardson@intel.com>
 <CAJFAV8yP-Mp75so4qoKqOHUzbgWqBi-e8JDLY6yZDpjhodU-tA@mail.gmail.com>
 <akJcdJ9beQ560Opd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <akJcdJ9beQ560Opd@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 13:55:57 +0200
X-Gm-Features: AVVi8Cc_ZZH8BQoJvdQKxUuMKXKjAKcI8gg9sKnC15Bw05hd7VrRHhUYgMWq6Bo
Message-ID: <CAJFAV8yDzrhj7KVYYiXXQuP6xn_ooZvwpocd0-Ms-VptD3pnfA@mail.gmail.com>
Subject: Re: [PATCH v2] build: drop dependency on libbsd
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kDyzmorV5gt7WANsSFtqJYPnn1qduRu1l_48UHmRh8Q_1782734172
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

On Mon, 29 Jun 2026 at 13:52, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Jun 29, 2026 at 01:30:32PM +0200, David Marchand wrote:
> > On Thu, 25 Jun 2026 at 15:08, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > Glibc added the strlcpy and strlcat functions to version 2.38, released
> > > in 2023, meaning they are natively available in modern linux distros. At
> > > this point, the value of having the libbsd provided versions of these
> > > functions is reduced, so let's simplify the code options here by
> > > providing just two options for strlcpy rather than three:
> > >
> > > 1. native implementation for BSD and recent Linux
> > > 2. DPDK-specific fallbacks using snprintf
> > >
> > > Since the strlcpy and strlcat functions are the only two items used from
> > > libbsd, we can then drop completely any DPDK dependency on libbsd.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > ---
> > > V2:
> > > * took the work further than v1, dropping libbsd dependency entirely.
> > >   Now DPDK just supports native strlcpy or it's own fallback version.
> >
> > We still have some references:
> >
> > $ git grep -i libbsd
> > .github/workflows/build.yml:        libbsd-dev \
> > .github/workflows/build.yml:        libbsd-devel \
> > devtools/process-iwyu.py:def uses_libbsd(builddir):
> > devtools/process-iwyu.py:    "return whether the build uses libbsd or not"
> > devtools/process-iwyu.py:    return bool(get_build_config(builddir,
> > lambda ln: 'RTE_USE_LIBBSD' in ln))
> > devtools/process-iwyu.py:    keep_str_fns = uses_libbsd(build_dir)  #
> > check for libbsd
> > devtools/process-iwyu.py:        print("Warning: libbsd is present,
> > build will fail to detect incorrect removal of rte_string_fns.h",
> > doc/guides/howto/af_xdp_dp.rst:          libbsd-devel \
> >
>
> Sure, will respin and try and clean these up a bit. I assume from the
> detailed feedback that there is no issue with the high-level approach here?

Consumers of dpdk may have been relying on the libbsd dependency (and
RTE_USE_LIBBSD config...) but I think we should proceed with this
removal.

https://xkcd.com/1172/


-- 
David Marchand

