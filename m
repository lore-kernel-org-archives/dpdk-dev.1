Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBD606A322
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tK+ntKyT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9079F40297;
	Mon, 19 Oct 2026 19:36:05 +0200 (CEST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 6599F4021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 19:36:03 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c34bff61551so334700266b.2
 for <dev@dpdk.org>; Mon, 19 Oct 2026 10:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792431363; cv=none;
 d=google.com; s=arc-20260327;
 b=qrSjD1LLJ9HTekbGGW30s9+L3UtJYoRaq0y5FNEnN2QyS5jQLLGqe7E6MUbdPSmHrE
 o4OVweRyQ1cxd1Yv3TQN+GWff7dovkIhm9Iwqtw5XTWO26EJ/FoBj5+fCe3r0adtcwbv
 yzK6gbWhut1PufWIKIhtM5gmdjgnL86fvF3pLX50aPPUkhJZ2dFROEmJlRtKASRE5vQi
 bUPlFKqEUK4ehj3d8GqZPfRbGKRKau2kegqq79sy1AGuCrfHPyOZxRItAdjAGEBobqEi
 je2RHmEzOW0/bFkpU9I2ft2fCsSoloN8uvr5dpn2MnXsYOjDjlpCxWKYdx+k18Y8itH/
 3ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tj/4kQetvWkcIiJAfQFR/h2ZfBxbpEBd6mY/QYFfG/A=;
 fh=fi57INd8zw8Au+xCgi/Pp29HGGsLtoE8i7oMl9G2xjE=;
 b=qN5bzBbmBS5ribXS10aizaqhARfluAjisoLpuz2WQD3iaSjrCOhsbXqu4kPIJ4MQib
 +ANvMWISIwy00I/HIv0itcI2gytIUQKUnUqVLFHTnuoQvn3fPve6t64tGwZJC1L4AdEK
 uoCfVZt/h/ijb7tafwqB2ea2cRlQGIQ40k1MSx+811GrXqnndmcVWrzHNj9N0WxXu9rg
 Eqjdfm6QoSMgPWv79JefA8+O0DjHLVcV5J+0pSmbIpfJX4UGbifGbXgzI5KqxntHVzFr
 /5KhOXEJE0DS2/X8WbeoPlS+cBulaE8GP16DSP2GORrVZ66LakOpz1RQULRqsG8yL4ND
 Go0w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792431363; x=1793036163; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tj/4kQetvWkcIiJAfQFR/h2ZfBxbpEBd6mY/QYFfG/A=;
 b=tK+ntKyTIsZYsb1lmfEDEswjpJXYRA5AvjNzQObOp4oRxpnHUWPO8uRzhW4QzNy4rp
 SlSwBv0umbm9yBsESLqkHKwFbMcOoQBgQWqY7oC3AGDa84Xb50ScAVoI8YPs6643vu9i
 XTRqpqS6URZp86yZyu5EbWEixNQFkcAY3YwyO0UAvVs57UuEyocTodHf+lbrLaCW4H+s
 uy7hi7IifF8h2gvz+wuJcyN97T4bspH11EYkX2BSHmRZiJEYjdfvB+iK2sTudRXRrPnc
 IhAEGkaCJ5W8Ljv3YdCBw9D4lT32EVtEUGdPcGMD62fOb5wHJP+A34xybih2plcAdrEq
 y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792431363; x=1793036163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tj/4kQetvWkcIiJAfQFR/h2ZfBxbpEBd6mY/QYFfG/A=;
 b=ccFul+Qp3okwL5jIumM9RsTrkykduFw0MozijNwwsUMCuFGRbOTll5vCoAhssogdNa
 Ab1yjBtru8zz+HAszKk/7/BL2sPYEuGl5sGbxzPUw6MDFgnKrM4VzB5JnlprdnKJ1A+l
 OmKEK6XjtdGuLST5qfZr36xf5tyvKpHfBLDK5BG7HNoGlQY8OiBWwI/385wDExkB7wdd
 CDUG8UnH7QrzXUG+Bk+z9U6FvfWCr+x1G6Dd9P9Ba21FYR/0OmEXFsEc4rSin4MuUR7z
 qDjyA0mRDI7ViA3e+e0z+3AuWNb4Sn+xMNQggXIOSUQOw5VxnYBEjuVbiTAhCj3UfzXf
 ul4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgRFhTiadI3ccTxxOr2/zYfBfLjEMGldsbIGOkAhFc9tVYBIt4zakUaK0LLLMIPNLJv2o=@dpdk.org
X-Gm-Message-State: AFq9FYKlbLcU/mihpka/j2gqLep6/oetmV54ySjGemX/zWOzTpsceF/d
 j6WMoLCik40rDHKC53HwdMnaSSsNtcgJXP+T2ljozlb0eKJVk3+IrTlR+Jt2tc3Ig6mMO+s1o1/
 IxObRIkrjSVyuZRSugKFvi46Lj5GgsFfr54oOlN+S
X-Gm-Gg: AYBFou0rd21YLsmkPaStnMzMZMEvkkl27I/P/M4ahqv/DBHecjzQImSsFHpPw6USRPX
 6fuxulydd5MY2ixUiU5Z/LLBafp+juyhe8ZN9bzvf2dtz0rGL17dp79OG912XNTnZki84VYzkHc
 +G2shPgtd0GzPiH/Xq0g9BeTZjE5WlHB+4SS3rbInLlIw9XrJAOtkbSmGIJpVxMleJy0Tpx5nIo
 zXWgFIlhpLLURm8yB8NugnPcfSLi9jbqeTVuJMjItvtQgii7CTutd2X8OA34Q1d0Z4DbQZzqbe3
 XcIZ2SH2NDIRSuwH8OY3faltlGYhOHaqhF034WkqbdMeJHSWlrjrSsGg
X-Received: by 2002:a17:907:d08d:b0:c3f:98d4:dfe2 with SMTP id
 a640c23a62f3a-c419d8346eemr542365466b.18.1792431362264; Mon, 19 Oct 2026
 10:36:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
 <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
 <CA++LmPX3NA0=qOs=p7m8=4Zxq-=gLdgMJA=EKJy=SxNKysqfwQ@mail.gmail.com>
 <20261019095500.5b577674@phoenix.local>
In-Reply-To: <20261019095500.5b577674@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 19 Oct 2026 10:35:50 -0700
X-Gm-Features: AclHuK_l34zphqxssSu_axCx2hNgXYOGm28Xuz3ZTJactAni5gJ_cTSdEtTHqSo
Message-ID: <CALuQH+UTdRV=PvGaDBC+VxfQ2Qx3O7LNWeOYuP52FFmqGm0NMQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>, dev <dev@dpdk.org>,
 dpdk stable <stable@dpdk.org>, 
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 9:55=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 18 Oct 2026 13:24:03 +0530
> Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:
>
> > > > +static inline bool
> > > > +gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
> > >
> > > Minor nit (not worth blocking over, but maybe can be done as the
> > > patches are being merged): can this be renamed to
> > > gve_tx_validate_pkt_len? This is one step of many in the packet
> > > validation pipeline.
> >
> > Thanks for the review, Joshua. Agreed on renaming to gve_tx_validate_pk=
t_len.
> > This change impacts patches 9/10 and 10/10. I am happy to submit a v5
> > series if preferred,
> > or the maintainer can rename it upon applying.
>
> Renames should go through patchwork. I can cleanup commit messages and
> release notes, that is where I stop.

In that case, would it be okay to merge as-is? I will be following up
this series directly with some TX datapath fixes of my own which are
kind of related to Tathagat's fixes, so I can probably update the
function name in my patch series, rather than going to v5.
