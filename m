Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29658C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:10:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28ECD4027E;
	Tue,  7 Jul 2026 16:10:12 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id AA8334025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 16:10:10 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso6533875a12.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 07:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783433410; cv=none;
 d=google.com; s=arc-20260327;
 b=P19UYaN5QxMwwm7fGtoxXTCpNLXC2vF1AcyOGQcQV6L2sOffsSQ4F1HaM+p0fZGO5z
 Uwh2UlmdK6ORqzvt4wVJDCa1i0bUpDbfpZhETVU6JalIb/ZT3za29ZmgYBvFQfgVsZu9
 IPOn1bGeXnjnPryu6Ed5OIfqlarG7TR96lz97aZs+2kqP1RJtQxH5mVxcfC/rug5caUS
 urRem+rWPH6U7WvER1ICmkm/7R2GMiuglOa5DWfcbrei+K90ca393khR+jEQYhdlV30+
 Jq8wyH4qYpdlW4f4NbvIkfgrDoH7WZjJNgPIfLOk4LlL3HJC6CiX2Xv3h5A2h55XaAxS
 Ky4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mc+4zCZ+U6KLdsjZ5dHJ9IQuglX6YbEXMn1L69f09Fg=;
 fh=60MDIcqpvdQ+k38Mr7uKHDt3asNSR/q9/9pya2nXK1o=;
 b=QIwTl9HnGuFPGvaDbYCMD/+8ec8SHexCl+n4n1QbiiY/P2Tkwn+IuYDtffOKy0xJ+T
 PpH4yynk66Klg2mM7apK5EFHeqzbNBDUXUkyAfw0OmUfgydqF/cJLmypPtEd136esU+N
 9O/ZwMi9WZvedZPN3BirlP3iRdbz7HXGkFxCOycKrBX8+kHyGpZMZg2mrHOmTU62KqJv
 7ZpY4N6knydhY4eiBkbSz1fcOINjUz2JeI8zXKeWViMUmLC1vMmnNa5njut54LEJ+YTT
 9U75UDcaL+ornGCqkpmKLE4iXan5qq00gtK5Hy01zfeV8/vXrbRXNcqcCT2CvjNPNvLn
 4LIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783433410; x=1784038210; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mc+4zCZ+U6KLdsjZ5dHJ9IQuglX6YbEXMn1L69f09Fg=;
 b=aaIYYAQtu5H31a8xnjU7gUBmRHnta4GKfD5brkdpiL5N912fv0b/CADZR+NKG+IZzF
 r7uBY2dl303DNwSLvKQWz2h/BHSaGWxVwRehiOYdJfTMwMcdhe+/zE89ME+5YFbs7JTJ
 s5BymIeFBxKytMm9GgwNqHMvb/74tFcPwW88U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783433410; x=1784038210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mc+4zCZ+U6KLdsjZ5dHJ9IQuglX6YbEXMn1L69f09Fg=;
 b=PHHeSUgOzyWiAVIfnqzDkBlsdnbnwPrb7X6UTPXezIA2/e75vAJaOiL1lZXsA5n3jO
 yuox8p/VJK7a3Zt/ekdu/xSJM+n8/nHdXYLTqkX9r+1yPocrLDhrgfu5Ry12/WdR7rqA
 3StYzeXWMFdIGmNG7D3+R3tAjBW9Jd+TrfU5L3zOdG7GyjEqf12f3yIuX2sKv0iAu0iZ
 xn60SyX7CUjy4KxE4V1TGfTPpaFpY8r/n1XQkEi73fjX5k8DLwgVBCB6o0VcT5ssmPD0
 6DnxJ72H4quLANp0Fz+dgjY5jCXXWwttjzdfPIpjnx91xNZnvigLDbRun8gq/QhE4rrc
 1lrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprWsFZ6yB0Bk2WPFwH56jJ0ygXMYJP4GZZ9yOW/MYBwzDA8YvXu02tUefaWxIBdXa4Y7c=@dpdk.org
X-Gm-Message-State: AOJu0YzRCQ6o96Ck1lXPZCodyg0crmYDAKSV28bxgqeDBUJ7UcDsmqqW
 ysEMuHEKHiOqXlPtECn6ZhBtsA1+/aqMjKT4G7+rMbm/eTgKMXOMgts0qVXSh6NiKuZI0sCrefG
 ZSy1OG3qIqHWFOjSiPWIna4jFzMCjj8FCNRZqW7CzWw==
X-Gm-Gg: AfdE7clvTBVuSXC0GnGtl2jSO1w2tSwYzLUbe97mIurhXLm4UYutBcrnu12YsWGkLoW
 tACGM2hc+tE6/V18zN3IFP2es4+DrpYV1CbyQp4+KqTVDESM9276nzO5w3mbP5npviKPaYHr+id
 1xdZ7AP5+wP4raUXsJ31i4WZo5qPrXqzT0jh/y5gaTxJxHG9v8rbuBV5OScE/MHF/SHZOSY6jrm
 ebzIM5uqo7BWEeZxLt2rvLcabt5P6gxGC2XbDXa1mIJnjQZ4SDMMQpxTLLQ2sYTE8+XWXxmhUz0
 HlPztrocUP7jsh3lVoRKrCPapGU9/w==
X-Received: by 2002:a05:6402:51d0:b0:698:b055:a509 with SMTP id
 4fb4d7f45d1cf-69a85c186c2mr2621495a12.24.1783433407960; Tue, 07 Jul 2026
 07:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260508141319.52648-1-abailey@iol.unh.edu>
 <20260511160013.78676-1-abailey@iol.unh.edu>
 <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
 <CABJ3N2UPaeLyD7Mv1vtoQSvRJLK0MUfC0LHvvuz-kvjx1YKwcQ@mail.gmail.com>
In-Reply-To: <CABJ3N2UPaeLyD7Mv1vtoQSvRJLK0MUfC0LHvvuz-kvjx1YKwcQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 7 Jul 2026 10:09:56 -0400
X-Gm-Features: AVVi8CcqPFb1-_oNv50u7c-pvS4mRoncfLmhawq4YkXGfUPBvuIrAOxPK1DsBiM
Message-ID: <CABJ3N2VPwsAoDyY4x=k=JQoU74UkdbQQRAy2LQgw_W9r-q8awQ@mail.gmail.com>
Subject: Re: [PATCH v4] dts: update test suite names to be clear and consistent
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, lylavoie@iol.unh.edu, 
 knimoji@iol.unh.edu, ahassick@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c333e9065605f2f2"
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

--000000000000c333e9065605f2f2
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

    I thought that I did this previously but tried again just to make sure,
referring to "git mv". The commit is clean when I change the name of the
files but when I squash my commit that actually changes the contents of the
files it makes the overview incredibly messy as before. I tried doing the
moves and changes in different commits and squashing them, as well as just
doing them in all one commit with the same result. I did not submit two
separate patches because then the first commit alone would break doc
builds. Is there something else you would like me to try in order to make
this cleaner?

--000000000000c333e9065605f2f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Luca, <br><br>=C2=A0 =C2=A0 I thought =
that I did this previously but tried again just to make sure, referring=C2=
=A0to &quot;git mv&quot;. The commit is clean when I change the name of the=
 files but when I squash my commit that actually changes the contents of th=
e files it makes the overview incredibly messy as before. I tried doing the=
 moves and changes in different commits and squashing=C2=A0them, as well as=
 just doing them in all one commit with the same result. I did not submit t=
wo separate patches because then the first commit alone would break doc bui=
lds. Is there something=C2=A0else you would like me to try in order to make=
 this cleaner?<br></div></div>

--000000000000c333e9065605f2f2--
