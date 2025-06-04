Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D274BC5B559
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 12:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E66D442D80;
	Wed,  4 Jun 2025 14:04:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55092402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 14:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749038651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrdWZXHqEqpX+Fp7EhdjCHQOCU1cZd/aYn6VLF/0ksw=;
 b=g2SHGuX1yfUeHeW2q7RvVSmRv/d2rs5vrwyzQCDBn6JYkkX8m2OYUGej97SN9m1c0Lzcxj
 sJ4a4Owf03+VY9QREXpJlXnWjSKDrhFGMx2Dxrh7cRUxwOyBiejYL9ypxHWMfn1gm5Z/ZL
 sxGutqqaW2m2G0KkJy2Xf0mk+P5hr+U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-gfXwF9YiPC6tWZ1xOM63cA-1; Wed, 04 Jun 2025 08:04:10 -0400
X-MC-Unique: gfXwF9YiPC6tWZ1xOM63cA-1
X-Mimecast-MFC-AGG-ID: gfXwF9YiPC6tWZ1xOM63cA_1749038649
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-551ec3101c7so3094668e87.2
 for <dev@dpdk.org>; Wed, 04 Jun 2025 05:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749038649; x=1749643449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrdWZXHqEqpX+Fp7EhdjCHQOCU1cZd/aYn6VLF/0ksw=;
 b=ncuuULL1wUzpZ7pqd7yI5DvGmE7G8tRUtWKuqP64Vlbu4zgM7YniXHBMfUOZrD2Jru
 ZjZVsCzqYNkhJFuWAm8AoGPDFlylWqeJRRcDVz1XZTpQR9y0+VrT0U7hQZprYa49mGzO
 HYYHcR84lvqiefres8bxa5b5wCnfl+J5+VvYikpqHSrYXogED8oWGFhxpmHEC3mCwBe7
 3PzS1/LR8r88sIVn6SWLHb4GDUDlQxBf8Ejbbs7KhlIOOUC4sY5V+0W9rEgY/Ybkooxc
 1uHx320E5afX1g5DD52b6v723cKZ11dEgDKl5jlBdFhvcqqFFGlQpsnIIOHY/YA2rqB/
 +aMA==
X-Gm-Message-State: AOJu0YwXgKT48ciBsZMFuNnzoCKXJxGxQSMy5wKCDAUvHJMa6YL40Ch9
 h7egisApcxEKxxktnXQ74mO0JYQRJZf8h7wSJu3fxvYBOqXfSv6rC2p/ZKw7hxgger3NPK50jIu
 rM9YXfx89IJ2D6Fpa+wM8cDPZaKLfl3ba2SyogL7bXseq/5otiLPAyPcZhs7ZQlNbLgEzSGLK4B
 buRs/kh3ZBmnXkUj5mC2g=
X-Gm-Gg: ASbGncvBilwlgbnuctDPBEtS65UtJv48lNGbm+fsRqX9d/2n1LgSbUegqtAFAwAQGMD
 m0xtq/+5ySQbvj3x/A2KXfJRNrS/Ly4gFhkAY4AkPbm7zU50GzsG0064SP9RGsiL/gHnNHsU=
X-Received: by 2002:a05:6512:3056:b0:553:2ef3:f731 with SMTP id
 2adb3069b0e04-55356bfb2f9mr716391e87.29.1749038648817; 
 Wed, 04 Jun 2025 05:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1OcrdUx0JQv3a/uh0mXSzXXZp2pivGeCLy3hqgVswcudhybN5RFxJEb3j/2qeO551ddcOpp1skEUx56qvEc=
X-Received: by 2002:a05:6512:3056:b0:553:2ef3:f731 with SMTP id
 2adb3069b0e04-55356bfb2f9mr716359e87.29.1749038648113; Wed, 04 Jun 2025
 05:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <20250603010127.GA30135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250603010127.GA30135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 14:03:56 +0200
X-Gm-Features: AX0GCFuYOM-uicIxoGfG6rAu_hEZdzyGAGXz2hwl9sNHTXu_7bZeeTeZSIvC8ao
Message-ID: <CAJFAV8xoy+Tuk-mOi93W6bo=0Su2Q-cPy5vjoZ6i4U9N0BkGZg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] allow pmdinfo to be inserted and parsed using MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hxLuYfWvLxYxj_2I4IzAG_skK7rrrMMC2_oelRnHR7g_1749038649
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

On Tue, Jun 3, 2025 at 3:01=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> On Wed, Apr 16, 2025 at 02:44:54PM -0700, Andre Muezerie wrote:
> > DPDK uses GCC attribute "used" through macro __rte_used to indicate
> > that a variable not referenced in the code should be assumed being
> > used and therefore not be optimized away. This technique is used to emb=
ed
> > information in the binaries, by having crafted information stored in
> > them.
> >
> > MSVC offers similar functionality, but it differs significantly: MSVC
> > requires a pragma to be used to send a command to the linker telling it
> > explicitly the name of the symbol that should be included (even if not
> > referenced). As a side-effect, variables called out to be included cann=
ot
> > be static, otherwise their symbols are not "seen" by the linker. This
> > restriction requires some DPDK code to be refactored.
> >
> > Macro RTE_INCLUDE is used in this patch to ensure these special variabl=
es
> > make it to the final binaries.
> >
> > The elimination of "static" for some of these variables caused name
> > clashes when __COUNTER__ predefined macro was used. As a workaround,
> > predefined macro __LINE__ was used instead. However, when __COUNTER__
> > was used directly from a header file, __LINE__ had to be used from the
> > .c files, otherwise it would also not result in a unique symbol. This
> > required a parameter to be added to some macros so that the __LINE__
> > could be passed from the .c file to the macro defined in the header
> > (which was originally using __COUNTER__).
> >
> > With this patchset commands like the one below provide the same JSON
> > output as would be obtained on Linux.
> >
> > python usertools\dpdk-pmdinfo.py build\app\dpdk-testpmd.exe
> >
> > v4:
> >  - limited the use of __LINE__ to the header files, reducing number of
> >    changes made in previous versions of this patchset.

Open question, since the submission of this series, __rte_used is used
in the new symbol export macros.
It seems those macros are not affected by the problem you described
(and fixed with RTE_INCLUDE).
Is it because the symbols are explicitly listed as exported?


--=20
David Marchand

