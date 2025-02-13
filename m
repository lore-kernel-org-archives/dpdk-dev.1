Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3214C0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 11:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85A0942EA9;
	Thu, 13 Feb 2025 12:10:28 +0100 (CET)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53]) by mails.dpdk.org (Postfix) with ESMTP id 63C5440287
 for <dev@dpdk.org>; Thu, 13 Feb 2025 12:10:27 +0100 (CET)
Received: by mail-io1-f53.google.com with SMTP id
 ca18e2360f4ac-8553108e7a1so57282439f.2
 for <dev@dpdk.org>; Thu, 13 Feb 2025 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739445026; x=1740049826; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wWLjhp3SElpBBr4U/XEAFoYWI5RLawY1OQ8YARIqs0=;
 b=QDX/pfK0uLUabdO8xdB4URfE5AzyQnWimT68H5tfUhR1l5xDRCx7pF14t7heXHd3E/
 FpmIMvWZGf41dnqV/UquLgSiU8TLEtARPP5v0we1oq0Fdgei6/9vCyYJU/EKpwd2Pk3V
 FctwAy9Ja+lNJRcb0AB1o8hu3ymOgrCFFePyxAwmnnCAAM+54Y6rHWe7bCpydxox3XDm
 LW0chPc+pnWv3htFfy0E811QAzPb2N4an+MJmRjotgNsah4TmWW8cy7YfV2ToUDxsPcO
 yJ05hrNTjAKtbRhPv22AtUZVU2qiQoGPYqCti6nueTGjwOazZ5A7aFsuqyihZxC6rAMq
 9H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739445026; x=1740049826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wWLjhp3SElpBBr4U/XEAFoYWI5RLawY1OQ8YARIqs0=;
 b=mwmsE0XmPXS/JQqcceacVeQLJ6pzpWOVT8O1SLC7UsFYEas9GnNIOLrFsiG2bBDZiD
 rHSN/Kia1IURRGT1bbY69lfJclkAMQrudgzEKjSC3dQ9aGpMkg7wRuM3SzoCxtiCs/7f
 ywZm+pdmOH2l1L0GINNm5ZY8jsAbgGA0aat4JMSZXDY4JaSjRxGnXDdfEp707K2Db5fn
 Tr7kob6GUmjMOXfzs9rOGsG5P28HojCKn+ea917iz3ZkcXb7+etysfWf+tMRoJsBt+48
 6l6H5JQfx6urbR6OwoD9umtsv0ek46l5RppYF4b1j4AaGQDEi0K0oHuOTKZmpHM5mAtN
 U7VA==
X-Gm-Message-State: AOJu0Yz/gAaYvHtLj4dkxhxje4AnA4XEhkrsSSABk594UvYzMyv9BX5A
 bWWnjIAIHeTZl/Q59ieIvSpxi7tDtPEN7b/+UMoaPwUeXc/HZrvVqvoHDfYpDupF2HGzeC1yHgC
 VtHb+zXdXAy8+cPZd9NIVWByyYq8zvx0NutJd9g==
X-Gm-Gg: ASbGncvQmzmRmTdOx+zTGMwOtW5CjPkNJZ/paPp0eTNpwwjquYFbJi/OXuHtl43G4lc
 P4f/p4RS3uz5RmfbfNs2aJ1d469cO81ssUwd5bnppB/VGINwsnWKpR9QxThDDd3Ru68Ma1tQ=
X-Google-Smtp-Source: AGHT+IGR7x/nWAupDZlAH7hgaiBIlCVAeatgNm4fsF0zYd8Hiakt21X6fwhbwbD6IcbGB1BoLjb3tVTkvHOnC73w3Qc=
X-Received: by 2002:a92:ca0f:0:b0:3d0:618c:1b18 with SMTP id
 e9e14a558f8ab-3d17be05b76mr62044525ab.1.1739445026670; Thu, 13 Feb 2025
 03:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20250119174643.2162110-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-1-ariel.otilibili@6wind.com>
 <20250120122156.2480524-3-ariel.otilibili@6wind.com>
 <f0371b52754c44c789fa8b1250bfc023@huawei.com>
In-Reply-To: <f0371b52754c44c789fa8b1250bfc023@huawei.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 13 Feb 2025 12:10:15 +0100
X-Gm-Features: AWEUYZkEMYJyWzaGzV9ESFmU2kHUF61LI05q8xn85_FbnD0Yd3-MuqDhYGJOUX4
Message-ID: <CAF1zDgbGsOwT36Rop-hoMRBxJ5N52byEABy2OTCCdHWfjTG0jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mempool: make rte_mempool_create_empty a
 single-exit
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Content-Type: multipart/alternative; boundary="000000000000ebe9fb062e041ab1"
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

--000000000000ebe9fb062e041ab1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konstantin,

On Fri, Feb 7, 2025 at 3:31=E2=80=AFPM Konstantin Ananyev <
konstantin.ananyev@huawei.com> wrote:

> Personally, I don't see much profit in such refactoring.
>

Then, please drop this patch. I gave room for other people to react, none
came up.

Thanks for your feedback,
Ariel

>
> > 2.30.2
> > <
>

--000000000000ebe9fb062e041ab1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Konstantin,<br></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7=
, 2025 at 3:31=E2=80=AFPM Konstantin Ananyev &lt;<a href=3D"mailto:konstant=
in.ananyev@huawei.com">konstantin.ananyev@huawei.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Personally, I don&#39;t=
 see much profit in such refactoring.<br></blockquote><div><br></div><div>T=
hen, please drop this patch. I gave room for other people to react, none ca=
me up.</div><div><br></div><div>Thanks for your feedback,</div><div>Ariel<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; 2.30.2<br>
&gt; &lt;<br>
</blockquote></div></div>

--000000000000ebe9fb062e041ab1--
