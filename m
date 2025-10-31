Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAACDCCF9FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 09:18:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAFF2402AE;
	Fri, 31 Oct 2025 10:18:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB7D440270
 for <dev@dpdk.org>; Fri, 31 Oct 2025 10:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuDINOMLd3SQH6869xuhD/l/uoRup+frK/bePHjolu8=;
 b=G3AL/DdrnXpwRiMu/LSgdNAhjyV8JHwWdwFq1esepHgwcoHKFEkVKEG2JcnMFOguy0/Bu2
 F7wKkPA4PBhoaD24TjQFjqpiKmBRD2V6kBosi67lakeltWzPuRwxpHJdlmUDbP+npMpxEv
 v51lPSZwo+CZO9u7NOSl74vHB8gELOA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-P1xr3C5LNkWs4dLruwRCug-1; Fri, 31 Oct 2025 05:18:08 -0400
X-MC-Unique: P1xr3C5LNkWs4dLruwRCug-1
X-Mimecast-MFC-AGG-ID: P1xr3C5LNkWs4dLruwRCug_1761902287
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-368ab6919e9so10780891fa.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 02:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902287; x=1762507087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuDINOMLd3SQH6869xuhD/l/uoRup+frK/bePHjolu8=;
 b=MsFsVN3FH0gnI/nY/qw31yIGWCS/qkNWb083Xvs7iXFfgjKxIOp2V/HmpY63h40OnB
 FjaVsFeNIwEMTMrUurySeX7aURAFd9W7Wd0pJkaaM/gzKlOA43CXxO6l+kICoNAig3Eg
 /xd4LRUF6QwyLfsSc1k3XGx8Aot+e44mzB7dkl8TwQFHgsg+RtwOxBzWypKzBbk02CWX
 HLnL/u9P9+QodkB4OKK1Kk87NadjS5p7y6zfOGPOAmhLdHnXHJPUK7dVDQb3x/CtDBGF
 r9eNrNcWyVsjdlCBTx0uLjEy4b6yHvWf8MzT5ou77FrJu0GKPIyLkwlfbWYK7pFJwEnM
 3tLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMrvrxPusD94G+R1eJlEIb3+SxlKeScKineibA8l7mzuLgYT81zk/ID7MW+B1gZpQ+DiM=@dpdk.org
X-Gm-Message-State: AOJu0Yx4glVR3if8AiErE2MkJ14G6+3EJ1hl4YHjiMqrbKjkHUWHycLE
 wlca4GczfqrYiJftYBPPgA6CqBe9070i+TXDBFSyB3wZMVum+Xc9ekTVjES0OIPItCryb01dFcu
 YFDpJDeaPIp1RbU7RwQ9iZQXTUZ5ksvdWpxLrNhnmNOTdAZ9tk4wAnUwHJs6O3U4QuTEUSj5ra6
 i2jDOIl9VaEZqTRqQLlrs=
X-Gm-Gg: ASbGncsl4Ft8lYsdflhRmP3MUIYsD1SShXs/AOGdZ40FXvKZFvE4ZjGfrbpt4ZZRIBs
 izBHJam6wXsjlQSAOYwKiwUUK+csa6eAFgfiXE0xwz87ZISyQD0GwKxKFWDYClIciNNDsZkc1nL
 SvQmqm3Db7Bp2QpL/EFDnQ5znxL8rKPrc96plZ6r9q1GIEZZtYzA0SbJ4org==
X-Received: by 2002:a2e:a593:0:b0:376:4320:e34c with SMTP id
 38308e7fff4ca-37a18df596dmr8493761fa.46.1761902287303; 
 Fri, 31 Oct 2025 02:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErUlXnsg6aFwEvS6PO4YUDn4CY4uRZ9OVRT+YLiKfzKkA9bjOOkGGDPa7SgSGvcJBD9bka3xJ2mHdlgzOj2aE=
X-Received: by 2002:a2e:a593:0:b0:376:4320:e34c with SMTP id
 38308e7fff4ca-37a18df596dmr8493641fa.46.1761902286885; Fri, 31 Oct 2025
 02:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Oct 2025 10:17:55 +0100
X-Gm-Features: AWmQ_bkMH-oXKrDLNlyQOtl3iopKvlOZkbTZSLfmdZggeqtFqfy3QOBDy2qrVcY
Message-ID: <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
Subject: Re: Disable SPDK testing again?
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Patrick Robb <probb@iol.unh.edu>, Aaron Conole <aconole@redhat.com>, 
 dpdk-techboard <techboard@dpdk.org>, bruce.richardson@intel.com, ci@dpdk.org, 
 dev <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aIE9OEIbYDejSk9lGr3mLhShTwC2z5FfsEkN2x3L5vc_1761902287
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

On Fri, 31 Oct 2025 at 10:11, Morten Br=C3=B8rup <mb@smartsharesystems.com>=
 wrote:
 > While it is just a warning in the CI dashboard, I don't think we
> > should waste resources on this testing.
> > Opinions?
>
> We should ask ourselves why they are doing that.
> Is something wrong (or incomplete) with our handling of -Denable_libs?
> Are we including unnecessary optional libs?
>
> It seems like they are using -Ddisable_libs, not -Denable_libs. Don't the=
y know about -Denable_libs?

I reached out to some SPDK dev when I was working on enable_libs.
I also Cc: one of them on the patches but never got a reply.


--=20
David Marchand

