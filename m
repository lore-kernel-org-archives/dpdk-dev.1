Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B9FC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A08240156;
	Thu, 26 Jun 2025 14:53:25 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id F03AF400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:53:23 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6fada2dd785so13498936d6.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750942403;
 x=1751547203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXN+Bc1bYY3t1MsDgwfluQpWH4RaPk1JQ4NzGx90Q24=;
 b=DCYapTXqtbOYvGqgh3BSbgflYmI8fKbRiM9d/6zhldOu99p3U0zAR1IudCWbErtUwa
 RQI8UW28Ns3/BQpTjA2P5nqC5PucNifb6AqoP1F/aFXWsrYlrHhFz0Kxdu+uB3gTX0cz
 bZVwGydo/KI0BgZl2fFn2QVJL90R9uIIh1NQxb8KHsWWUoEA58NYCcsrAdqstVzEGP6T
 Dr2ls3c9C9SwS/hC2yXjb5qlhInZyYJOJOCMwUHz8ZTphGhe9xX1ybFu5L5TOnwh3CpQ
 zSE+jjwep2uMKXzPWxJ9WjbLe3KtBqhU2EEwUiwNReUAgM9lqKNtMUv4yGI2cHtD/Di7
 rxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750942403; x=1751547203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXN+Bc1bYY3t1MsDgwfluQpWH4RaPk1JQ4NzGx90Q24=;
 b=UVtzvks3UJGTHh/lDt0F8wMVoPG8PIGC6ZuNQNDvpxJoo5+Buv41V3eAdwenQb3Ild
 1qzCPRAmhZ7FCbf/K0010znJtOlHzha8uAIJ8GpfA+tfqv8hkYcOAApEe5kyNqDOAqJo
 TR92gTkMfVzqqyjDwG27ebppXfUPsV6MuCQbnNakCIVlqSQNU00e6YfZTFydSq9Xvrsz
 mWuFH6rVJnvAuVDB7gRqxwloJQT9JcJgoivgsQDf3DgZuLknZINQpzL1mOG4UA3jiRhY
 5w6su8NWxrv22RW0fDFGgMV9QR4VBudFYF6PwFBYSYy1S7YVh1NJjs25tYQBVfr2Q3dK
 +R4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyBxl3zQbSYnQBq/H7ErI6wsHU4/Y3kYFHHfUw98IZI6I8bKhtHzpXlkqnBWxsXekGBDQ=@dpdk.org
X-Gm-Message-State: AOJu0YxLces/OvmYziVu1+b3kb68lVPCialKepIKCQGD61FuVxgVgg82
 nGWS0nudFjpVB7yGQCTtDDHx7PuwJXxo5ID2w8agRsCg2gAlxzxHoh9QgBMrufdYZmM=
X-Gm-Gg: ASbGncsE95lJzvdaAo5JeTdqwM+ynewfrORn++g/W0y6vXhPP9mtVB7ABeq8KxvxEI3
 Lzw2Ku7AhJc/jFVfKBrpYCUE0aJV7oqxWIrmxu2MnYIYgSa03/LjDkzXAYWwvhq/9kjPvHTXz/C
 qbcNUgjb5HjtGNrsJ+T1UDD8qbFJTKytcPpEi7+oed4RJQ1acNz3/SYNOm63wVARFPuuCAUxmk3
 BAKsspzVBImholU9+yVgfKDQ/wFDuhwDUyXEY3nHIiPcx86mdLezXc4ZdwSW6VyCfJZ9IoA3xSk
 IuwZL9D2Jen1/iwPeHALejFUweN0iBT/90pE164/YxEKyhpTEV+LBqQ0K/tgecnp79h3h4+GK0K
 6G5e7OfXWoSNFPrX715UgqgxA3C+yVmKTf1CPt+w=
X-Google-Smtp-Source: AGHT+IF1lo9Rm5UegiAPl68b8LqOvC/wV57vFGbzUkxHaDnDwb8n3NF/pD5PVR782FT3ArYFBzWJ0Q==
X-Received: by 2002:ad4:4ee2:0:b0:6f8:997d:fc82 with SMTP id
 6a1803df08f44-6fd5ef2fc93mr109266226d6.3.1750942403246; 
 Thu, 26 Jun 2025 05:53:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3f9999fe6sm714665585a.17.2025.06.26.05.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 05:53:23 -0700 (PDT)
Date: Thu, 26 Jun 2025 05:53:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 dev@dpdk.org, techboard@dpdk.org, Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: DPDK libs as one big shared object
Message-ID: <20250626055319.1ef24c96@hermes.local>
In-Reply-To: <45747073.doPnVEEUbh@thomas>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD09@smartserver.smartshare.dk>
 <45747073.doPnVEEUbh@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 18 Jun 2025 12:01:45 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 18/06/2025 09:39, Morten Br=C3=B8rup:
> > > Why are we still building one .so file per DPDK library, instead of j=
ust
> > > building one big dpdk.so for all DPDK libraries?
> > > I think it's legacy from when DPDK libraries were versioned individua=
lly, and
> > > thus not relevant anymore. =20
>=20
> I think it helps with selective packaging.

That only impacts disk space. The linker is able to only load what is neede=
d at
run time. It was a choice made in the build process. Not sure if was the ri=
ght one
most other projects don't have so many libraries to worry about.

>=20
>=20
> > > Wouldn't building one big dpdk.so eliminate the problems with circular
> > > dependencies between DPDK libraries?=20

Yes is why most of the big Gnome and KDE libs are all one shared object.
=20
> >=20
> > Obviously, the source code should remain organized as individual direct=
ories per library.
> > I'm only suggesting linking them all into one object, so any DPDK lib c=
an call any function in any other DPDK lib.
> >=20
> > Perhaps only the core libs or always_enable libs should be linked into =
one object.
> >=20
> > Here's an example benefit:
> > I'm currently trying to convince the PMU lib author to make PMU depend =
on EAL [1], so missing error handling of sysconf(_SC_PAGESIZE) can be in th=
e EAL for all uses, instead of copy-pasting sysconf(_SC_PAGESIZE) error han=
dling to everywhere it is used.
> > But this is difficult with the dependency chain for the patch adding PM=
U to Trace: Trace depends on PMU, and EAL depends on Trace, therefore EAL d=
epends on PMU.
> >=20
> > [1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FD08@=
smartserver.smartshare.dk/ =20
>=20
> I don't see a problem to copy-paste in the few libs not depending on EAL.
>=20
> The real solution for EAL dependencies is to split it more.
> The malloc, init & logic part should be in separate libraries,
> depending on the real low-level EAL.
>=20
> Then all libs could depend on the low-level EAL,
> and avoid copy-pasting.

There have always been two overlapping targets.
Embedded standalone and standalone network appliance , where building more =
than is needed is a nuisance.
And distributions which need to turn on everything

