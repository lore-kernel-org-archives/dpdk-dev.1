Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC4CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30B45402BE;
	Tue,  9 Jun 2026 11:23:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8C71D4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780997001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dy/NbJYXtjfNB8idZVJInBkyZ0GmsoG0fAUeFha7i5A=;
 b=GnE/oSUvL0MRXpiTUJ/K9jXth7yD9EqKHWRulau0vaXb9iVawwXARTf/8JNx4ktlfMQbT3
 J1ygWaXf+Zw0+XmZMLyCzmqONQO+jKHMBuPZK6lX/WMAWrAmiu5Zze5Gbk2yP3D2ErA5FZ
 Wp5uC/Iofi8yx1vs31jrP+TvCTanBRI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-sGthPzZYNRuxFd2X2zjQlQ-1; Tue, 09 Jun 2026 05:23:19 -0400
X-MC-Unique: sGthPzZYNRuxFd2X2zjQlQ-1
X-Mimecast-MFC-AGG-ID: sGthPzZYNRuxFd2X2zjQlQ_1780996998
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa65bc0be6so1948105e87.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 02:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996998; x=1781601798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dy/NbJYXtjfNB8idZVJInBkyZ0GmsoG0fAUeFha7i5A=;
 b=XXgia32Nh1rivXvutXS9BlePpgpz3WIuLLroXyQRplAKICYqJLQ5h6OGsKSpfWJze5
 wOd76sgc4XZSkn1mantylZJL6h0OQshRoIN8x2ZXWcACuahb4rH13k9dw9Be+vsv9Sik
 HqNYtLZ1j+N5FFz3gSLeGQi+EFBB87IdoaPuiv2eJgNnfukKb+CLsPaP1yknm/44fOiU
 i2lUOXZzFel2QH/C8bYXGNa1ccvyL+CcWXoRXRBw3Q9XnzHqc9hppdH+vf0Tj0TEWuXE
 fpA2tfJxfR9QQ5D3wb07rpRLOO2cVJmX0xRe8bvy4iUjLGhKPl9iZt7v9sKWY7QK2PfI
 HUvw==
X-Gm-Message-State: AOJu0Yw5cWOu/SEd1flDxFhfoqHpB5JPFwvHDrFQ3S03gPihHxRUDmV6
 XO+SNpEUF/gZ1CPIg2Qhjtub5NnFZPQr9ls4Ijfre3U+s3TI7wIW+0jH+ByeDLLO8Co5REZa7DO
 lQJ2ok2BsPo6Fue9ta5XfR4zmUEQ/UZgHppyTh3R7SCJEznaf7mJ9+9HT1tXH8jaq0XVvPVDtqo
 YyK2wWwNmrgzo3MoxgEEdncsXcjifE8g==
X-Gm-Gg: Acq92OGxZUCrbXyKnjrNocfVQuRSwwnhUIu9/7jRBHNsMigcLvI9eLtRNqyoUJWV0td
 BCidcYJZ90yrX7lYS3Ab7wo91rfQJuOV02A9FVgQtZ0zfPhRq3RzHHMlq4fhCXbfSWuFH41iIqr
 C1RQpGsTL2NdnQdn7tShIwZpsoRN1EiwmMIEufwP7aS5wvOo6dJ45h53zXCE6NfkvtQ+SklyA2w
 8vsb1fYFrul2e/OulbR8wJxV0wq2JelyBoapOCLxh3mCw+GCVIgAQHbzvA0njmbc2Smjlr9mf0r
 GNXG
X-Received: by 2002:a05:6512:239f:b0:5aa:143e:77b7 with SMTP id
 2adb3069b0e04-5aa87c4c723mr5492333e87.43.1780996997708; 
 Tue, 09 Jun 2026 02:23:17 -0700 (PDT)
X-Received: by 2002:a05:6512:239f:b0:5aa:143e:77b7 with SMTP id
 2adb3069b0e04-5aa87c4c723mr5492315e87.43.1780996997070; Tue, 09 Jun 2026
 02:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260602225722.950617-1-stephen@networkplumber.org>
 <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
 <20260603085359.739ab626@phoenix.local>
 <CAJFAV8zEg7YNuoO-U-fwnWCJ4MWk9Zm0Zp9pwoirRRn9LHFKrQ@mail.gmail.com>
 <20260605111233.725bb792@phoenix.local>
In-Reply-To: <20260605111233.725bb792@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 11:23:03 +0200
X-Gm-Features: AVVi8CcpjgbwCEgQs5XvayQTvFAmuxAE-GlFW-bJnKRlfHFfPAK2YNaneFCa70E
Message-ID: <CAJFAV8wSidG+myr46BJ1yNMJ8nPRC=3D6-7g3RF7Ea7ABzFsdQ@mail.gmail.com>
Subject: Re: [PATCH] eal: fix function versioning with LTO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VvGYJqX3x5It95Uh5sBU96xvNz2vb5g4Z5tmx_GCCZs_1780996998
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

On Fri, 5 Jun 2026 at 20:12, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> >
> > Looking at bugzilla, we had various fixes for LTO over the years.
> > We still have one open bz btw: https://bugs.dpdk.org/show_bug.cgi?id=1709
>
> That bug was fixed a while back. It required addition of hints (__rte_assume)

I have trouble identifying the changes.
Please close the 1709 bugzilla with a mention of those changes.

> > > > LTO is kind of experimental, so it seems good enough to reply "not
> > > > expected to work in older LTS" if someone reported an issue.
> > > >
> > > > And in practice, no LTS release call the versioning macros, since a
> > > > LTS drops all compatibility.
> >
> > Just to be clear, we don't need fixing the macros in LTS: every time
> > we prepare a LTS rc0, we drop any kind of symbol compat.
>
> Agree, this is not LTS related
>
> > > >
> > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > >
> > > > I would like to reproduce, but I can't build main with LTO.
> > > > What patches did you apply locally to avoid warnings on the hash library?
> > > I use Debian testing and GCC 15 but shows up on older versions as well
> > > I get no warnings building main
> >
> > Building from scratch, I do avoid the warnings I hit yesterday.
> >
> > The fix looks correct, my problem is with the form.
> > Fixes: tags accuracy is important.
> > And I prefer we stick to "It is not broken, don't fix it".
>
> Could argue it is a GCC bug, and applying their desired workaround :-)

Indeed, but the end results is the same for me :-)

Can you send a v2?
Thanks.


-- 
David Marchand

