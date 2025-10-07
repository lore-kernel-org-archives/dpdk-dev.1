Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113FFCCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 07:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F414042E;
	Tue,  7 Oct 2025 09:58:55 +0200 (CEST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) by mails.dpdk.org (Postfix) with ESMTP id 528CB402A3
 for <dev@dpdk.org>; Tue,  7 Oct 2025 09:58:54 +0200 (CEST)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-574d36a8c11so2491621137.1
 for <dev@dpdk.org>; Tue, 07 Oct 2025 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759823933;
 x=1760428733; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iUDQg2eveLaLpckNxeBfIWLwcl35MWBo8HytgzlPHu8=;
 b=1auOsgGYV6wKjxxHpW932rjiZa4ZlOv6wvwxLnH2DEqjX8r1IIr2uc2g7UBYflOE7e
 6oUdBHCDbjMk/tTm4lO+faGZ4LziNMRMlxLQ+cItsMxhV/f+J7d8mcnuxWSE1JdOoy8b
 ZrN3Z3YbczGvU+VoJx6xIuld3rYZRNJplC4TibHY2ug09YX60gRol/qW9KvBPez49x4J
 Nxe1lQ1W0FST5b6PIJnD6NNgH6WR9YmlNY2kmFuuML07a86VcC85TkH1KvWQMu2gugTt
 +oDrdTJs7EAr8ZyPariG5056/2XOKh4j90JvC6dunqrZ1yK3EXMYZPFIp246TI0h/O2c
 pywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759823933; x=1760428733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUDQg2eveLaLpckNxeBfIWLwcl35MWBo8HytgzlPHu8=;
 b=ohPVSFeoQ6PSplL4p+h8p1U+fTtAbA1OdgvdTYKIGOjRgDfvMxAOEoUhUazJzE68tm
 uPq07QKfLsFC9l631ie3Y256qcI0vHrPlK6/Qi8+VIKg3Wi+1TMEiLWf1mX5pM8BIqrL
 pz8dq7ru1fRx+xN9wk0bDrHV1smyILmAuJAYyYZg5VrTVwvSo/COG0NB4YoCxvTRKaiJ
 FQ/LSWArMGRnEAP11NXe8LSlKLMo/0WR6kXN4oqc5KGbadKGjN5UA6lps0/ZmSTpddoz
 H0ceR8UOJqDxq+TtwgkIEBzegX/+LhUxngl8p80K9i+okQXjoXJT1+HfYiXE0ga+78KH
 MQnQ==
X-Gm-Message-State: AOJu0YwdqhS9WqDY+ULtwA484CxuZI+qF/yKi1FTfkQACndVfa5e9ime
 VCTfhRG64YW2sQzbAc8+y8JjhdA4JxZVlVNALeGVEjK588ZtIJlyL+seb7mclLujFZy79pHDMI1
 WqgKSv8afNQUYPd+5bBIG4Dj3YoJxKfb7lH0M2O17Pw==
X-Gm-Gg: ASbGncvsv8qC6ozHnfL852RAyBBvKr3GWviDvEVR2FeWZznRyNl8o6oT4yg5FCN8/nA
 sQ/K/hI+BR0lklBNJ5wzPRayo/odo+5NzqGZtObEOvA4uzCFhPFg3ekoE0lx45KlT71ew7KBD9C
 R541FLij62+cjoOIk5LCmuJO0hs5Gef3pTrQAcBvJTGDJyBNPIy2xQq+z6pPw0iReRlqVQJf4Sw
 vmXMdeg7IYPzwiSMc2SYg3N/xDvzF0g
X-Google-Smtp-Source: AGHT+IGyQbWyi+sRdX416ko2ty38QMEKsve5Z9qoL0T94+Ugty2/SY8Bunp8MPlo/ksGU8yXWhMUTGUH9qI+33rd6rc=
X-Received: by 2002:a05:6102:80a9:b0:5d3:ff03:8f6a with SMTP id
 ada2fe7eead31-5d41d12dc77mr5173724137.30.1759823933508; Tue, 07 Oct 2025
 00:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6549F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6549F@smartserver.smartshare.dk>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 7 Oct 2025 09:58:43 +0200
X-Gm-Features: AS18NWDeJfDVWhxNkHMpRjyPLW7YTc87F_86HvPt2y5GxNkWR_Z_UPnn99iFS7w
Message-ID: <CAOaVG14WRb0YDk6UzzQ6zJ1iwjU2KFdMBVH6_Aypvq7yotYfSA@mail.gmail.com>
Subject: Re: Minutes of techboard meeting, 2025-10-01
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev <dev@dpdk.org>, dpdk-techboard <techboard@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Patrick Robb <probb@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000006c998606408cf0b5"
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

--0000000000006c998606408cf0b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To help with definition of fast free flag, I would like the documentation
to be better.

Something like:
Fast free flag allows driver to avoid expensive atomic operators on ref
count and assume all mbufs in a burst are from the same pool.

Should also add debug asserts in drivers implenting fast free.

On Mon, Oct 6, 2025, 16:40 Morten Br=C3=B8rup <mb@smartsharesystems.com> wr=
ote:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 3 October 2025 11.18
> > Subject: Minutes of techboard meeting, 2025-10-01
>
> > * Use of FAST_FREE and multi-buffer/scattered mbuf flags
> >   - The flags for enabling fast-free and supporting multi-mbuf packets
> > are
> >     now documented incompatible
> >   - Previously they were not defined as incompatible, but that seems to
> >     have been assumed for some usages.
> >   - Techboard discussed how best to resolve this incompatibility with
> >     regards to:
> >     - ensuring correctness
> >     - avoiding major churn to DPDK code
> >     - avoiding churn to end-user code
> >   - Options discussed:
> >     1 change definition back to not have the settings incompatible:
> > this
> >       necessitates checking drivers for correctness
> >     2 keep as explicitly incompatible and report error if both
> > specified:
> >       this could break end-user apps, and requires changes to example
> > apps
> >     3 drop the fast-free flag if multi-segment mbufs are also
> > specified:
> >       "hides" the issue, but probably minimises changes. Would need to
> >       decide whether the dropping of flag done in drivers vs ethdev
> > level.
> >       Pros and cons to both options. Needs clear documenting.
> >   - No firm decision reached, will discuss more over email.
>
> IMO, the patch [1] making MBUF_FAST_FREE and MULTI_SEGS explicitly
> incompatible should be reverted, at least for RC1.
> That will take the project back to the state it was in before we started
> this discussion.
> And all the examples broken by the patch (because they use both TX
> offloads) will not need fixing.
>
> [1]:
> https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-3-mb@=
smartsharesystems.com/
>
>

--0000000000006c998606408cf0b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">To help with definition of fast free flag, I would like t=
he documentation to be better.<div dir=3D"auto"><br></div><div dir=3D"auto"=
>Something like:</div><div dir=3D"auto">Fast free flag allows driver to avo=
id expensive atomic operators on ref count and assume all mbufs in a burst =
are from the same pool.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Should also add debug asserts in drivers implenting fast free.</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Oct 6, 2025, 16:40 Morten Br=C3=B8rup &lt;<a href=
=3D"mailto:mb@smartsharesystems.com">mb@smartsharesystems.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; From: Bru=
ce Richardson [mailto:<a href=3D"mailto:bruce.richardson@intel.com" target=
=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.com</a>]<br>
&gt; Sent: Friday, 3 October 2025 11.18<br>
&gt; Subject: Minutes of techboard meeting, 2025-10-01<br>
<br>
&gt; * Use of FAST_FREE and multi-buffer/scattered mbuf flags<br>
&gt;=C2=A0 =C2=A0- The flags for enabling fast-free and supporting multi-mb=
uf packets<br>
&gt; are<br>
&gt;=C2=A0 =C2=A0 =C2=A0now documented incompatible<br>
&gt;=C2=A0 =C2=A0- Previously they were not defined as incompatible, but th=
at seems to<br>
&gt;=C2=A0 =C2=A0 =C2=A0have been assumed for some usages.<br>
&gt;=C2=A0 =C2=A0- Techboard discussed how best to resolve this incompatibi=
lity with<br>
&gt;=C2=A0 =C2=A0 =C2=A0regards to:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- ensuring correctness<br>
&gt;=C2=A0 =C2=A0 =C2=A0- avoiding major churn to DPDK code<br>
&gt;=C2=A0 =C2=A0 =C2=A0- avoiding churn to end-user code<br>
&gt;=C2=A0 =C2=A0- Options discussed:<br>
&gt;=C2=A0 =C2=A0 =C2=A01 change definition back to not have the settings i=
ncompatible:<br>
&gt; this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0necessitates checking drivers for correctnes=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A02 keep as explicitly incompatible and report error =
if both<br>
&gt; specified:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0this could break end-user apps, and requires=
 changes to example<br>
&gt; apps<br>
&gt;=C2=A0 =C2=A0 =C2=A03 drop the fast-free flag if multi-segment mbufs ar=
e also<br>
&gt; specified:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;hides&quot; the issue, but probably mi=
nimises changes. Would need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0decide whether the dropping of flag done in =
drivers vs ethdev<br>
&gt; level.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Pros and cons to both options. Needs clear d=
ocumenting.<br>
&gt;=C2=A0 =C2=A0- No firm decision reached, will discuss more over email.<=
br>
<br>
IMO, the patch [1] making MBUF_FAST_FREE and MULTI_SEGS explicitly incompat=
ible should be reverted, at least for RC1.<br>
That will take the project back to the state it was in before we started th=
is discussion.<br>
And all the examples broken by the patch (because they use both TX offloads=
) will not need fixing.<br>
<br>
[1]: <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/2025080319421=
8.683318-3-mb@smartsharesystems.com/" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.68=
3318-3-mb@smartsharesystems.com/</a><br>
<br>
</blockquote></div>

--0000000000006c998606408cf0b5--
