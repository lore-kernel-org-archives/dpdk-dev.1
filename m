Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B5C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 09:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E0B402ED;
	Mon, 23 Jun 2025 11:41:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C0412402A1
 for <dev@dpdk.org>; Mon, 23 Jun 2025 11:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vp0wM08Ul53Vor5Noyi/pT3/FAlIMHXbGpiGYQebzA0=;
 b=hbMHzikpgn9731vCL1c5a+47PK56kJXU7RP34cJwOA7NYY9vYGdzlRmUzUAspJhO3fc1LK
 aRNwXSee86rqx730rRl99qlE2oCreEDzQsnej5QEai8pezuozaZffdWMTVSByy7cvYRf6/
 ZIom89ID5voZBOrdhgU/8ycmVNSWyJI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-E_-S9vCuP4aIvA4x3H9opw-1; Mon, 23 Jun 2025 05:41:15 -0400
X-MC-Unique: E_-S9vCuP4aIvA4x3H9opw-1
X-Mimecast-MFC-AGG-ID: E_-S9vCuP4aIvA4x3H9opw_1750671674
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b4b645bb4so21488581fa.0
 for <dev@dpdk.org>; Mon, 23 Jun 2025 02:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671674; x=1751276474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vp0wM08Ul53Vor5Noyi/pT3/FAlIMHXbGpiGYQebzA0=;
 b=FzuKgb7XcwUn5Pz26dMvtea1ZwiwhWPtMuaDn+7khB3eU6luQC/wjPycvZ0eAUAza3
 W1ULRvc2aAMFXDXAp4Bb/Kq/mlxsbq/wsXK/0h4IlZMoVvK3R6crhmzfKoconja89a/N
 GVd8QkOXg0bGADsXjBpd160PmAU3Uq636yVusUPf4FOmmbh/zO1FKX438EH1r5G7ZptX
 k8KNVyl9QtYX4mqQ155uHOpSGtoWkACet2j5Xs+lcMtx5O4ErnwahU1PQgxReS+vqA08
 PFjbu9eg0o5kcyDYweEBrrYJzfKY+PffE/Wlf6uMa3liSPJE0E38YwCW8UY16jQWqDDj
 Io2Q==
X-Gm-Message-State: AOJu0YwLG7GzTkHmYEkt6lRh1khxICFH8Bm492a7wzuZty+rBA6RH+xJ
 1atGn2AFVEqFYyib8KA9tDpf9kvhwFAzL+anHQ+tRae4Pu3568VEt4yZhxsRANvQw9X+po8wBzk
 +S6Xon2R8RTrUGavHpGGmD2KCpKEuBgKVFiaqN8IJHzh+7Icg62WdabY1Zyd3jhvq86OEJMbJkU
 BzqF8Cx92Bynd1Ji07DIw=
X-Gm-Gg: ASbGncsvySs4oPciBKyP/ni22H3pgvq6Zot7S8rDdgRna31MSPbKJbSOwKS6D9DOoBZ
 6MvsyPdGefOoOt6qSVJH5D8088tSVtHc9fqyg85dpJP1FTwDGKXtCureSYBN7cRdT3oWpRbjrN5
 gFuiVq5g==
X-Received: by 2002:a05:6512:398b:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-553e3c0305emr3824834e87.41.1750671674189; 
 Mon, 23 Jun 2025 02:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpp4QpgA09XReheDO5otPBJ2kwCVaz3BczbGZOMLOVkBPRXi3jIoZDe5vd1rzt26L/Zwdl4QnJJNbHJculbsE=
X-Received: by 2002:a05:6512:398b:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-553e3c0305emr3824824e87.41.1750671673737; Mon, 23 Jun 2025
 02:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-5-david.marchand@redhat.com>
 <aFUnmJ8NMj5S49kq@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFUnmJ8NMj5S49kq@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 11:41:02 +0200
X-Gm-Features: AX0GCFuPihb_KCfojzq9cqptALRFMuMVuavQaOJCkpEvOWQMizfAgxFcVjGiIqc
Message-ID: <CAJFAV8wspToWPy5MCFWUNxba+aP8G-cSpMcXfM0C595sJvxwQA@mail.gmail.com>
Subject: Re: [PATCH 04/10] eal: fix plugin dir walk
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Timothy Redaelli <tredaelli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ignnV3nxPgkJlSthz2BHrPjzU1B6bulrsSN3KMQtWNg_1750671674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 20, 2025 at 11:19=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jun 19, 2025 at 09:10:30AM +0200, David Marchand wrote:
> > For '.' and '..' directories (or any short file name),
> > a out of bound issue occurs.
> >
> > Caught by UBSan:
> >
> > EAL: Detected shared linkage of DPDK
> > ../lib/eal/common/eal_common_options.c:420:15: runtime error: index -2
> >       out of bounds for type 'char[256]'
> >     #0 0x7f867eedf206 in eal_plugindir_init
> >       eal_common_options.c
> >     #1 0x7f867eede58a in eal_plugins_init
> >       (build/lib/librte_eal.so.25+0xde58a)
> >       (BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
> >     #2 0x7f867efb8587 in rte_eal_init
> >       (build/lib/librte_eal.so.25+0x1b8587)
> >       (BuildId: e7e4a1935e4bacb51c82ab1a84098a27decf3b4c)
> >     #3 0x55b62360861e in main
> >       (/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x9e061e)
> >       (BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
> >     #4 0x7f8667429d8f in __libc_start_call_main
> >       csu/../sysdeps/nptl/libc_start_call_main.h:58:16
> >     #5 0x7f8667429e3f in __libc_start_main
> >       csu/../csu/libc-start.c:392:3
> >     #6 0x55b622d9d444 in _start
> >       (/home/runner/work/dpdk/dpdk/build/app/dpdk-testpmd+0x175444)
> >       (BuildId: d821ec918612c83fad8b5ccb6cc518e66bee48cd)
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> >       ../lib/eal/common/eal_common_options.c:420:15 in
> >       ../lib/eal/common/eal_common_options.c:421:15:
> >       runtime error: index 18446744073709551609 out of bounds
> >       for type 'char[256]'
> >
> > Fixes: c57f6e5c604a ("eal: fix plugin loading")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> One thought inline below...
>
> >  lib/eal/common/eal_common_options.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_c=
ommon_options.c
> > index 83b6fc7e89..153f807e4f 100644
> > --- a/lib/eal/common/eal_common_options.c
> > +++ b/lib/eal/common/eal_common_options.c
> > @@ -399,6 +399,14 @@ eal_plugins_init(void)
> >  }
> >  #else
> >
> > +static bool
> > +ends_with(const char *str, size_t str_len, const char *tail)
> > +{
> > +     size_t tail_len =3D strlen(tail);
> > +
> > +     return str_len >=3D tail_len && strncmp(&str[str_len - tail_len],=
 tail, tail_len) =3D=3D 0;
> > +}
> > +
>
> I wonder if that function is worth renaming to "rte_str_ends_with" and
> putting in rte_string_fns.h?

I'll have a look and see if we have potential users in the tree.



--=20
David Marchand

