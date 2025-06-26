Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BEC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E71BC4025D;
	Thu, 26 Jun 2025 16:00:22 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id B18FB40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:00:21 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d3900f90f6so99903885a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946421;
 x=1751551221; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOddBWcA9vhhlD9AZaf+TP+o5s4RfXBD9X9KYSS5v38=;
 b=dweqLO+2oItKX0P8benlaEp52uKfUDPG1BtVGeiCY+fL9zaLbw1vw+6btuiVqq9Z7I
 pw8mMkNv+yY4+AddDIr7Q5dWGfmivkCKl3QmVNDxNOchc21RZFqEZtrhS7qzBWlXjZnl
 DJ5vn9q3Y6CIKzgu8NI/e+B+LRopa+kyIwVkj5W7AstgwNPuWHMs4aj+AoU9kAbR54gW
 oyOfk5oxhh+toEY1d280HvQaTJhT4w0XbIXJUzcZVuflhWXg7cqEZAb9vUt9y2mV/VpT
 wg8PZ/XTxaDPaxykqYUfh8PpzGj2cdskziix+RBoEE44ATL52D1Y6+PEftfEP2MyQhgt
 JQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750946421; x=1751551221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOddBWcA9vhhlD9AZaf+TP+o5s4RfXBD9X9KYSS5v38=;
 b=BbS4zXdXjBfh0b7DebIIk3d/tdnTB/pbxksAXEQzm4CR/vN4REIdZiB6kZnamiNg3u
 thP1m0VQ+2I/svaPEOJAtM7JQ5fa/Pn60zzrfU/UFiwlxOSKoKxGW+MqBV4lOeomWwNh
 I2Le6i7/Yvwyy4+sBu/rVVF5ZRSAjdplm9IZ7jnaw9vWh2keEkx9U48AM81TF9URjT4D
 KplGe1MVaeP0CgieGzKyJSmyct//3RY6SlmY1/rvFYd0OGoyFIIm95qXpHvlmXBTZ/Z8
 /sNHi/2MMZVyUsOMkdprMjHquHO0BuA5QGsB3AxbjJwPK0G7TX1hmz6UEf3yXIc8tU6P
 Y7qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtqcHeAdU70/RPMrLrJU8xh0p+K6RrGduM5ARbx560I0QzwOMHlJQwjEBc2Jipvrmhkck=@dpdk.org
X-Gm-Message-State: AOJu0Yy7FoCqcs4Hci89dCuXjpNyvMp97JCKZSwqcBE6l7LGh0djcH9S
 vrIsYYi7I+iDcGJuG8ypMSmNPIQOtkbWkqMxZHZ1tXah4StXlZr9dsxSV9SO6RkDkeE=
X-Gm-Gg: ASbGnctURG4gd1ef3CWu5L2WAyWQmtDRDXKps8KsLnR00MUpMnpmVPuKT3htEUfs3iz
 iaiAoF2FUiiDumc8Um6kZ/aGkq/7/5raWZBxnM88zAqZPB+zOq1XkmKiVwsxOvR3+g8ShhWG/MA
 YFzXbYQSlZIB1rz0NQJJ/fzQ1nLYO8hUlS4CWEUz7ywBtgOX1UThk1RuhrMhInet7Y3ygO+E8yt
 +TkfN0E8Yf+HYXJsSr4ww7niJr/EBikjZeIWiFq+c3ssA21HziV2tJzq3gZRKSsHE4WQX+3vyq/
 4t2u/nO8W93pW8GvWAU8P+MYddhgEO6blsnyGkBuO6KOXkFJB0B9MLpk5TuuvgBD5nYyl8o/4/I
 pj3kh9Y5pHm9qMLo9fjyf/8KuDEV5nONTk/DK0FE=
X-Google-Smtp-Source: AGHT+IHt3C1ssWKbQYA/GXqT8x7N7cYCG+aTQM/+wqdFz37+Sz8dTbNAy475uleK6tZxi/EbH9LoBQ==
X-Received: by 2002:a05:620a:4492:b0:7d0:a1c9:65a7 with SMTP id
 af79cd13be357-7d4296d50dbmr1079322385a.6.1750946415260; 
 Thu, 26 Jun 2025 07:00:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44313689fsm4083285a.16.2025.06.26.07.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:00:14 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:00:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
Message-ID: <20250626070011.291d8f70@hermes.local>
In-Reply-To: <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
 <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
 <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 23 Jun 2025 17:12:43 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Mon, Jun 23, 2025 at 06:01:00PM +0200, David Marchand wrote:
> > On Tue, May 27, 2025 at 5:29=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote: =20
> > >
> > > As the number of cores/cpus on platforms has increased over the years,
> > > the use of coremasks rather than core-lists for identifying DPDK cores
> > > has become more and more unwieldy. At this point, let's deprecate the
> > > coremask-based EAL parameters for future removal, and point users to =
the
> > > core-list based versions instead.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  doc/guides/eventdevs/dlb2.rst                |  6 +++---
> > >  doc/guides/faq/faq.rst                       |  8 +++-----
> > >  doc/guides/linux_gsg/build_sample_apps.rst   |  7 +++----
> > >  doc/guides/linux_gsg/eal_args.include.rst    |  8 ++------
> > >  doc/guides/prog_guide/meson_ut.rst           |  2 +-
> > >  doc/guides/prog_guide/multi_proc_support.rst |  2 +-
> > >  doc/guides/prog_guide/service_cores.rst      |  8 ++++----
> > >  doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
> > >  doc/guides/sample_app_ug/ip_frag.rst         |  7 +------
> > >  doc/guides/sample_app_ug/ip_reassembly.rst   |  7 +------
> > >  doc/guides/sample_app_ug/multi_process.rst   | 14 +++++---------
> > >  doc/guides/sample_app_ug/qos_scheduler.rst   |  2 +-
> > >  doc/guides/sample_app_ug/test_pipeline.rst   |  2 +-
> > >  doc/guides/tools/testbbdev.rst               |  2 +-
> > >  lib/eal/common/eal_common_options.c          |  6 ++++++
> > >  15 files changed, 43 insertions(+), 48 deletions(-) =20
> >=20
> > This patch will need some rebase.
> >=20
> > I see you fixed a few docs, but there are quite some misses in
> > copy/pasted blocks:
> >  =20
> I'll take a look and respin this.
>=20
> I'm think of separating it into two patches: first patch with the doc
> updates to remove use of -c flag. This should happen independent of the
> deprecation, I think, and second patch just the deprecation notice. Does
> that sound reasonable?
>=20
> /Bruce

Should also drop use of -n in all the doc examples.
I had a patch for that probably buried somewhere.
