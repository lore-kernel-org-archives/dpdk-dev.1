Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6DC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF0740270;
	Thu, 26 Jun 2025 23:14:56 +0200 (CEST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by mails.dpdk.org (Postfix) with ESMTP id 66A814026F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:14:55 +0200 (CEST)
Received: by mail-yb1-f175.google.com with SMTP id
 3f1490d57ef6-e81826d5b72so1228684276.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750972494; x=1751577294; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOLd2wVG27k/Ap81PeWNMcJdCNfL/IO7LM1V1DqNnUY=;
 b=oKFJeqmgtOkkDLjS2eKcPXshrPhQH5u/8MFxrGijwgqDg+HmMOdfLy6XipaV3atc8t
 pfxvoq2zEmTgqDsJiZHL2vwGCJoQbqngxcO5SRr8XTO3GKICIcGQp25A3a+3awGo/Jtt
 4KXfNypMZxUcrGFPEe3fmfQySPk2hU6RfzRU0aWf8BDcJRwkWb6RwXejGFaEC3cmXG0N
 XNDobBe5VPmZaCj0j6YDyKai8TZ2MjdggNvaycee7brUwQJWDb21MG9u9aGPdiM3pjPu
 LpD2hqVLUPd8bUmXltW/56aGNrUHaFYVX/HMCU6JusL9Axr6OIYhRxggPeOSsmU/X+OC
 CR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750972494; x=1751577294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOLd2wVG27k/Ap81PeWNMcJdCNfL/IO7LM1V1DqNnUY=;
 b=rNxmBB79pl9TLvMsbKuwOhlEylRNJWu2kYcyHt5hm6m8IPKOfRfPBO3Z1TuFTtMzIC
 t/OKlgxNjrS02e4uGZ4Y32BcUesfCvRXRRGKB4bWcErriVT5krYMoudH3euwU1mCqzgD
 s/W7vPuiJtbA9EJbBfPu72j4+ePTgyrjS0919H3kN0TS0u7zA7JGdzkNwnkLYYfPaLr4
 MnBdfM9XsjIGKLaeYAzloZFQ2gXstJo4262zObLrhhoB7L0v6U5bNG9ZIiMXlAH7f8dZ
 XdIXyhedUqdhqJoL8LkGXj97XCRsQF2tNBPYUs3eUOJkjW+bbiPVIcQzUQM1yq4atFQk
 DrYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfQx4Mb8FTJ98odkfqWjSMC9EJH+eS3VPllT/L9/LMDDgl2tk/kYftMvkUQHR4ssYfXyE=@dpdk.org
X-Gm-Message-State: AOJu0YyI7aQWh+JPVYJmln/xRwRyYI+2ATi2y46aKAGdaT2/Tz1Mccwo
 BTcfDVCINkxNX2Vu4qdXASggv/lo3UspFj0YNb16pNNpVaMLWCvDwSk60hY5WbCqibECS8uV0Bh
 9jp3CS/FGLuDoJ/ueRMbdwSOBxOf6ZOiTCkBV8Fw2
X-Gm-Gg: ASbGncuy6v892LjCQGkb2RyyKZBR0iLetu4D2mmrXzmSD0MmC8mpM5CgavKeIS3VmHf
 srpVivgmlXd/A7dgUoXty4EM2hVtjML1Pb7rWSYPkAecEIUiQ+r4lDbxr/D7u8Kyzn713ttLi+L
 XP3LlhjJFgLfPp7/kgMsIZur1xQf/oQB2eSI55W/xAgnn23TDh4H0VEnE6Wi6815l538rpJ9VU9
 A==
X-Google-Smtp-Source: AGHT+IE05QPhMKMuMB9KN6EOy9fgIoNI/l2AyrGeNctWKRnjSVEep2DjxbnKKUABwFdK7tMsgwcrV82Gdtwd2G+v0Eg=
X-Received: by 2002:a05:6902:1890:b0:e85:e364:3d4 with SMTP id
 3f1490d57ef6-e87a7b8c6d7mr1360016276.44.1750972494397; Thu, 26 Jun 2025
 14:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250625182751.1936925-1-jtranoleary@google.com>
 <20250626071022.232b146b@hermes.local>
In-Reply-To: <20250626071022.232b146b@hermes.local>
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
Date: Thu, 26 Jun 2025 14:14:43 -0700
X-Gm-Features: Ac12FXwCKc7_UWreTyOmEW2TgiMFZLsRfPHLIB3HyzcAyLF6Z9wnjuNEZTDQJiA
Message-ID: <CAAESxLK6q5AjcMyNuHYmnqb8S2085nqTS-ogBqAvHV=xqzZqvg@mail.gmail.com>
Subject: Re: [PATCH] net/gve: support gve driver on FreeBSD
To: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>, 
 David Marchand <david.marchand@redhat.com>
Cc: joshwash@google.com, dev@dpdk.org
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

Thank you all for the feedback; I've made these changes and will resubmit.

On Thu, Jun 26, 2025 at 7:10=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 25 Jun 2025 18:27:51 +0000
> "Jasper Tran O'Leary" <jtranoleary@google.com> wrote:
>
> > This commit adds small changes so that the gve driver can build when
> > FreeBSD is the host operating system.
> >
> > Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> > ---
>
> Looks good, fix the feedback and resubmit.
