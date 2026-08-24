Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E8C5DF97
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 02:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB0014027C;
	Mon, 24 Aug 2026 04:39:14 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2063340270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 04:39:13 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-848743155bcso896928b3a.0
 for <dev@dpdk.org>; Sun, 23 Aug 2026 19:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787539152; cv=none;
 d=google.com; s=arc-20260327;
 b=Io0Z9s6vFd5QZDvoc/C15zYgB50WldraLJuJlBrPTi++mBdGh+LJ6GK+/IgnQhMV7u
 36ByNl4KQOk0Ob3B8cRxkgt31fmGdpBvjI1n34r1cQ8Yw/zoB1rnG+nuWllyWvwD5lF2
 yRsvU5O2P+OKAhBDBRbQQdpYEyZ3Myf87XLz7SOWeo+eHWryLH2uWOP9wztcM66wk0x6
 sE+qx3ME87mJJnls/ZeepDWKRlNnSp4RvRJIDqOLN9CJdD9QI+jZz1BU2dEl7Io88rkv
 s4/kcmY+MEnU2RTGP3IO7dRQE7lCBMhdOxKmBIkA1euSQ6mYU+tE/vdfsnsg3tXExYY7
 FN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bJyPONt/BZGlbFMBQX4ObZngZMOuTh5q4wPN8HcVvOg=;
 fh=LfTIChxJ+C+2cu9BPV1NqYHiK4+huSbNLCnRluuSmvg=;
 b=WYRnq2oSi54ElLup9Mz1kL1BkBqpMgP6SVnZFMLnCibhLKSOyjToQcc0a96PId62iT
 tY1suwSzI5A4yNwgsPlYky0FmztUxG5sLs0tbfL8ChGwvywecvJfwz+dt065OZcYgjpk
 PQ1Zra5AK6SN/8tZTiBwjO8yQRc4mFW6J/n3a6hZthSgeXDoCo6OiHzgyWj7qFt33l4N
 h606gWLk1dkT1yaZToPcXXPQMjJ6+h91BVPwUQqd4dHBtG+sCBCQJgT8hNJ1bRpM3HtD
 op6SnRiIbcHGmwgYIA2ZdQ9MAgjAp/fEKGR3ducV//N+5wek2u8iZmZnzwM3EU9bIbrn
 u2ng==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787539152; x=1788143952; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bJyPONt/BZGlbFMBQX4ObZngZMOuTh5q4wPN8HcVvOg=;
 b=QxWM5OhPuboZPQ0WVC8tN4ExuclFeh2ZdhrcT1kjW76JUzYX0fOvIB3qcqTQKWdSC3
 tXmdBcx08jMEyEKatLDzIWT3zJ4dWiUHM4bq18wMsJfj2Y+MdGWOAU8CKtvdexJv2TWg
 +zddT6ofGhjZ37lzwQuGLLrob2YwHL3z8HgY0O2rvHLbYGITCcyi4m50IGT89VCDwT/U
 tLqvA5V3q1os/B8jYBDWucuYGpg+e0TIcuntKMOCEHL1Wp4BIYKUyw9c7N6lc0jg9clF
 AyPx3KJBROswcX/ORkEFpbVINFZB9ks10ZkrqnCF/90JX1P29UtyUm3AGvWq/Au695uA
 uLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787539152; x=1788143952;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJyPONt/BZGlbFMBQX4ObZngZMOuTh5q4wPN8HcVvOg=;
 b=gNe1sWBMEY0N/uvysJgbaSroQa5QAcijFEBhkO82XuS5eVzc/3hK2rT8lydsSr7AT0
 8j8nriwQWXZ0glPPEYRjJDFifYAU3YU4R/arcNAu8IJM8EF9chAg2+Ryb7IxkLryLCcg
 Gfzk0WVu5/vdxJSMAVwEFI/TjpP15ShGS8Y/Ir36yULKvC5sCaAx4zLsWNQI9ugNKL6s
 sJs4Doeb1I8scHR2C3WhV3dD7ZGcLvJ51GVxoDYBtdUNGERD33lmCJhydaiWAPt1eZ+5
 TU0q0h/QJmK5McxzJo+H3fUSwj5pfTRXmyGjMkrIKZxKosfomFYB3612/gVbPnnD7nND
 K2kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBYeWbIKC3W542UvkVO+MJpvZW8jrp0yzIHXz4QOa90uG66AgZopqYKHHb1PDvf1aZrys=@dpdk.org
X-Gm-Message-State: AFuF++m4WKR6z5YnZFHNcVCJHQsD1NELfcXqt9iC2okuhCxkRZv/bMYg
 cpI3BO4EQiOE3wZSH2M5VVt5m+JS+6+qfgRJKcZvwuEdbZDPZqdi8Y/INJxCh7KugJNdLuS7Lc6
 FCRRqZyu9de9qjDlCOR7iEpJW1tyC95Q=
X-Gm-Gg: AR+sD12yNXzQNILRN7lRRvYJCegQJKMK+AjkjBmzjpOpH4IuVBCW20Rdqs7YfATt3wc
 oAIUk+62PngetQ/IC8F1JcgayQZBzhOSjS9E7WHTEyAd5Z4oFRxlferPzAUz7Ro0vHeLcuS9Jy/
 4Jt/N7CcrXhj44cJnH2jZNBRPOcF7Bt7UY2w2eLq66p0G8hAlefkupXb9UmkwZy71pL8rjQm8dD
 EYE/54R/hoDi2re5qZ1AYXL8mLSJrQy9Uk/FLQL7pU54NvrBLJRvHr9/ntE5bpl2MnFbnBU5NYC
 QdJxHhTzeQyFlFzDcWb0nFyYb4ReQq+0xQEfzj7c5CvK
X-Received: by 2002:a05:6a00:4fca:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-851f9f115e5mr32223351b3a.15.1787539151881; Sun, 23 Aug 2026
 19:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260823151625.18687-1-wpan3636@gmail.com>
 <20260823084316.75b12c6b@phoenix.local>
In-Reply-To: <20260823084316.75b12c6b@phoenix.local>
From: Weijun Pan <wpan3636@gmail.com>
Date: Sun, 23 Aug 2026 21:39:00 -0500
X-Gm-Features: AcwNN1WV8XuNrEpgKe8-7Jl6gNNvoOlr1ywSDMIUmvMec4KyC2x3z7MV4af8N7g
Message-ID: <CAMEmXswc7xvT_WFuxOpN0LcAnjbiq7doEPEhzLS-0zvw=zjq=g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] net/bonding: restrict secondary control operations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
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

Sure, please feel free to shorten it.

Thanks,
Weijun

On Sun, Aug 23, 2026 at 10:43=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 23 Aug 2026 10:16:25 -0500
> Weijun Pan <wpan3636@gmail.com> wrote:
>
> > diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b=
/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> > index 2fa1ac4028..7ecb05d407 100644
> > --- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> > +++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> > @@ -254,6 +254,19 @@ Like all other PMD, all functions exported by a PM=
D are lock-free functions
> >  that are assumed not to be invoked in parallel on different logical co=
res to
> >  work on the same target object.
> >
> > +Bonding device configuration is owned by the primary process. Secondar=
y
> > +processes may attach to an existing bonding device for query and detac=
h
> > +operations, but must not change bonding configuration or device state.
> > +
> > +In a secondary process, bonding control operations such as configuring=
,
> > +starting or stopping the device, setting up queues, changing members,
> > +changing the bonding mode, updating RSS, changing MAC addresses, chang=
ing
> > +MTU, or configuring ``rte_flow`` rules are not supported.
> > +
> > +Secondary process datapath support is limited and bonding mode specifi=
c.
> > +Applications should not rely on secondary processes for bonding datapa=
th
> > +operation unless support for the selected mode is explicitly documente=
d.
> > +
> >  It should also be noted that the PMD receive function should not be in=
voked
> >  directly on a member devices after they have been to a bonding device =
since
> >  packets read directly from the member device will no longer be availab=
le to the
> > diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_no=
tes/release_26_11.rst
> > index c8cc86295d..8df012c99b 100644
> > --- a/doc/guides/rel_notes/release_26_11.rst
> > +++ b/doc/guides/rel_notes/release_26_11.rst
> > @@ -55,6 +55,12 @@ New Features
> >       Also, make sure to start the actual text at the margin.
> >       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +* **Updated bonding PMD secondary process handling.**
> > +
> > +  Bonding devices now use a secondary-process device operations table =
to
> > +  keep query and detach paths available while rejecting unsupported co=
ntrol
> > +  operations before shared ethdev state can be modified. Bonding-speci=
fic
> > +  control APIs are also restricted to the primary process.
> >
> >  Removed Items
>
> Mind if I shorten this text, it reads like AI autogenerated verbosity.
> I.e 10x longer than needed. Release notes especially should be succinct.
