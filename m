Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE069C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D853040B9E;
	Fri, 25 Sep 2026 09:09:58 +0200 (CEST)
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by mails.dpdk.org (Postfix) with ESMTP id 86C204026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 21:22:32 +0200 (CEST)
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4c5b53d710cso154509b6e.2
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790277752; cv=none;
 d=google.com; s=arc-20260327;
 b=AUmG8QLRMvud4Dve9LRgH4DQVCtMFfAd2DXAGVnFAh5+mSAbzRFrjq6Tx8FHYZ27h1
 ATaoi0d4Gdu5bhZWAdE03TS2wSpAGEcwS+rbkJl3ePk5aIHDJdTUAcPZzpd0Py4wCGYf
 aR76coqu2/Mn++qbOdZChLsM7jJ/DtiIjgBGzR04IRjoXcD6oCD7j0l3KiKbobYSJfAF
 xio5EZgHjRdFBcCcOCsst+FIFb5+ENJG5sFJ9ENS9scsfRhzc4psG933q6aorpNCnnnj
 1U3p/ZlFKUjFxLt64FQkrkAaHku4seatk4w89jvfR8FRnNfk1Sz1y7N8X2zAldAPy/5e
 T7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dtv84qs/2Fb8Jp9KaloZ4VeXb4FhvM7RvhZ4HlXwbIc=;
 fh=tOro1SEtNvsUPah0gdvv/QuHWPJr79HE3ENiciQtBTE=;
 b=awNhTE/eOr/sWqiuQaXxHzefQZHizetWQoKsTQxQ54sxQ3rzB5QPs/CmRpDsWxH5op
 /yXlOOppjQV4Qw4rM1heZxh4Uj+drGt/wsQ8vsKGHT1DJIKlvZODIPsMUNfR151Vthgn
 jT//kuRd4huLuMHGPEGkZTCM45pA+tAzcrfHBJ9e2mC7RN0P8B1SvzijJ8veiA3iPooi
 9aRnURdNCvfX7wEdWPGuPSZfMYfw133LAY/g6kysLHxcGCh31wIgGjVUMKQxM1EP5DCA
 VvkpWxD7JEfjidiwM4uYRoUO7q/QFjS75BQB5T0Skn4OG5OW/W77454cYVCwY/Lv8Ex7
 HMGw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790277752; x=1790882552; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dtv84qs/2Fb8Jp9KaloZ4VeXb4FhvM7RvhZ4HlXwbIc=;
 b=ZWXrX4nc4FwfaxKQd5YBqm8rXIjXYz9moX0GnkQq3EP5oDYoy28xfTGRNE3dp8YFTJ
 NCdVxE8Zox0fHohKaAms27oJTrOBC/3Hop/BzKPFCGC3hm2wPDK8CLzX95G47Vmkiaq7
 zD6c0eUZmk6ipHIE7Ywl53lEogYRlQajvEOPRrJTZCioN3iLH3eRH73VaYenuwNUF4lo
 SgAmgOJsg7bs2fl3BlsV4+wfPRm0avIghQ4YL4N9T9Ybyg5t0HCqm3skX9L8aqdxPZ0f
 kbkwdgBnaYk52wo+KzSnJiCSz6LAxShzlaYgWahj9ZvxDYOMkc6ITBSTUWUEN7MwGccl
 y/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790277752; x=1790882552;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dtv84qs/2Fb8Jp9KaloZ4VeXb4FhvM7RvhZ4HlXwbIc=;
 b=NQkA6UtgOR8KeYGBH58NDjC8ZJxsNwfHtSk4mz7b7aEFxfN5lUtdPJNTT3zv1+sp5G
 6phF87bxxrM6Vp7l7sNhHUxuEG2aw9+yt3Pa9+GfXMh5BCN+k/Kb/1xvUYllcB/p971v
 ic76SUUnwH49Z7922X32Aa3l4eI+D7BH2O+YWBeEWtln9wahRiYdQ089XCR3gvvdS/Vw
 ohVeFWK1/QqvzWtO5E2f5VjR93s5e2H1oV2hSFJz9xAfnEpBn8SdQuwq/f6oC/5UxDJ7
 pgnWH4eG/mCR2yd2Y4TgZchUiZHC0p2heBE8KnAmsA6Esa+q41wLtfNvviqxf4eZgqCZ
 xbQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlqnER4cxx1MshYJJdYpeQ7NG3WBM0yV6IiO0vTpexmO/XMxKst9hIONDIdIU6A/+xyNc=@dpdk.org
X-Gm-Message-State: AFuF++l4AjamIAYCsUQ7lPMDWU24BoTeYqUCMAEKpBiaJIrwRT31XZhD
 4nPFTad55iGo3tkg7nl7jj7mNGAprtAN4p3OuIfnnIwVh0U+fTY9/GnTqtghTA8xp+kIproMQ3M
 WBhAlljvjD+SlO95hfBVnRZSu7oyLWoA=
X-Gm-Gg: AYBFou1w8ONOZk+ULblxe8THxtJ71UvMj1I0W4f3YkAhiErgCHAIBvd0zu+OA+hmamC
 HTD5lhRSYZpK/HvuBYR30F4spIYfGfIQKirRJiCvSKvdHlBGp9mIg1UJ3Iv1VGemz/9/jVETNpr
 N9xmEjBjjh0TrmRug9iRMzqTNJas5EppAvQkzYHYQnh8m60eApx140oHDVUwG4LlyTRIAXhEH7X
 r3Wo0mAMlnQ0iabbSDkS5tEN1/IR9La/wP6tnGBUI6uBN1RWOMP/NCcM8X7TttOxJyD1Kmvox17
 LmlDE+gggGgT/rFInfFD0V8RDASfZ6LJk8jI5Bv7SZXFgQN6942VQBi6kcS1BuTwgg==
X-Received: by 2002:a05:6808:bcc:b0:4b3:7d74:b33e with SMTP id
 5614622812f47-4d72cb3f36cmr3674735b6e.17.1790277751901; Thu, 24 Sep 2026
 12:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20260919140549.1f5f3c0b@phoenix.local>
 <arDxMec8YX7KDdAX@bricha3-mobl1.ger.corp.intel.com>
 <20260921084211.4f78c451@phoenix.local>
In-Reply-To: <20260921084211.4f78c451@phoenix.local>
From: Md Rayhanul Islam <r97yhan@gmail.com>
Date: Thu, 24 Sep 2026 15:22:20 -0400
X-Gm-Features: AclHuK9krq0pEv4JpiiDsc_p_ie5MWV_Y6ich5eJkcN5_weFx97R-H5TpRu-k5A
Message-ID: <CAOuoExR6THPbnNqrF4oaOCkhaZ6Dht3mT8qfqhEU=9Xku6LoJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] make PCIe DMA work on Broadcom BCM2711
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, 
 Chuanyu Xue <chuanyu.xue@uconn.edu>, Song Han <song.han@uconn.edu>, 
 Md Rayhanul Islam <md_rayhanul.islam@uconn.edu>
Content-Type: multipart/alternative; boundary="0000000000007391e6065c3f8513"
X-Mailman-Approved-At: Fri, 25 Sep 2026 09:09:55 +0200
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

--0000000000007391e6065c3f8513
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for the detailed review. I am reworking the series as an RFC for
the EAL DMA API and PCI bus hook, with igb as the first user.

DMA properties now come from each device=E2=80=99s host bridge, and cache h=
andling
is in EAL. I will also revise RX buffer reuse, TX completion, and
descriptor ownership, and add separate burst functions for non-coherent DMA=
.

I will also remove the extra guide and shorten the comments.

Best regards,
Rayhan

On Mon, Sep 21, 2026 at 11:42=E2=80=AFAM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Mon, 21 Sep 2026 09:56:17 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
>
> > >
> > > Short observations:
> > >   1. Too much AI generated slop, extra docs, comments on everything.
> > >      New code should look like the surrounding code.
> > >      This looks like AI wasn't quite sure and left lots of docs for
> future self.
> >
> > I really don't view this as a bad thing. A little too much detail in th=
e
> > comments is better for the future than too little. Given these patches
> > touch areas outside the usual behaviour we expect from DPDK platforms,
> > having extra comments is definitely useful.
> >
> >
> > /Bruce
>
> There is a fine line between a couple of sentences and three paragraphs
>

--0000000000007391e6065c3f8513
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Hello,</p><p class=3D"gma=
il-isSelectedEnd">Thank you for the detailed review. I am reworking the ser=
ies as an RFC for the EAL DMA API and PCI bus hook, with igb as the first u=
ser.</p><p class=3D"gmail-isSelectedEnd">DMA properties now come from each =
device=E2=80=99s host bridge, and cache handling is in EAL. I will also rev=
ise RX buffer reuse, TX completion, and descriptor ownership, and add separ=
ate burst functions for non-coherent DMA.</p><p class=3D"gmail-isSelectedEn=
d">I will also remove the extra guide and shorten the comments.</p><p>Best =
regards,<br>Rayhan</p></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 21, 2026 at 11:42=
=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.=
org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, 21 Sep 2026 09:56:17 +0100<br>
Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com" target=
=3D"_blank">bruce.richardson@intel.com</a>&gt; wrote:<br>
<br>
&gt; &gt; <br>
&gt; &gt; Short observations:<br>
&gt; &gt;=C2=A0 =C2=A01. Too much AI generated slop, extra docs, comments o=
n everything.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 New code should look like the surrounding cod=
e.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 This looks like AI wasn&#39;t quite sure and =
left lots of docs for future self.=C2=A0 <br>
&gt; <br>
&gt; I really don&#39;t view this as a bad thing. A little too much detail =
in the<br>
&gt; comments is better for the future than too little. Given these patches=
<br>
&gt; touch areas outside the usual behaviour we expect from DPDK platforms,=
<br>
&gt; having extra comments is definitely useful.<br>
&gt; <br>
&gt; <br>
&gt; /Bruce<br>
<br>
There is a fine line between a couple of sentences and three paragraphs<br>
</blockquote></div>

--0000000000007391e6065c3f8513--
