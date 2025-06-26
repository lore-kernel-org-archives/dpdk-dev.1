Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F166C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 17:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0019740276;
	Thu, 26 Jun 2025 19:26:38 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id DD5294026F;
 Thu, 26 Jun 2025 19:26:37 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a5840ec53dso15832431cf.0; 
 Thu, 26 Jun 2025 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750958797; x=1751563597; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQJzwlcWJy319I1OGf/IesVAOl53EVDBQKccfJWLcWs=;
 b=IEgDIqV/D+b/MPRU7aoOcDyOEkEIinhXQkVstR1tzlBI1KVU9xkEV8uDiS1pJGZwJO
 faksphn/fQ9BVNBahmALiepD5a+wv7W+04J9pNLGP1G1C2qTI0kw+Nl7rdAR6BV5OTn7
 nKoBZU7nsS4AmLFquznsb8Zv96mokY/zRE8ktnqC5Viu+W/AMzyCibpHL7xz6FuJm7Dd
 jKY3grTB9R9UkaNZuT20U2FYQvMIaQU5c1FxKHZcqHSNrX1S6uNs4m/bNkpYJX1hgfsN
 cXqQZBvvyZ3le9AVhzE+Be69dvhLOJD56YePM68w2vLFA8J+SavfejMiv3AAdUEUTV/n
 ZByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750958797; x=1751563597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQJzwlcWJy319I1OGf/IesVAOl53EVDBQKccfJWLcWs=;
 b=NbNP0UDHuyJoN2d97i1PL2EC1Ab+UCbe66/DbaQHGEiGXTrqigh6iPepwQkJfce+ck
 8LRCLcQ4T7mdzmmI+jZYhNJSaEX73ZXx75cSagQ3Mer8NHsZZgefz+iOMCydztK2HdrI
 FpKOcD9h3gABkcsBZ1MTL+jaE47tXlb6l32CVlY4JEcWavcZf7QsfjwU+bQZKmSaZMIz
 Q61mOdzmICYyB07HEVoCTmkPdDAD3SNlAetLE4AydwA+SLmnzyUocjBqo1RIOIvByqca
 VFY326+WJy8+7QS95/toXtKI5BzqVp6yD6+pvY7Idi77TNGtmlphkEPHZUOCUCgUSebo
 9Wwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+jN4dRkvsHAUbbU6nKRPp6jqkYToKwiCgqzTpdRA62qR7zWm8Vng1OBD6KfnE3U6W+85TcTSr@dpdk.org,
 AJvYcCXY+GI/lvcSpDZitEH4LRg7gHwbBmdgi8vjomVJWWHsxT2niE6tavkpLpJBezKrQSXv63E=@dpdk.org
X-Gm-Message-State: AOJu0YwMyb+IyfXris9+LfPeFfY70fAmPDDelgfzW+ykzpUYmzpli6HI
 Ai3quJvcB19x3CC9ZsF/BN+0GOltpubTLlhhHt6lDgn1sC0jtUOg5e8bB2A/T9NOIiFklK2cMGb
 Ns4wNdRHBpLSYRgFc0XzzRdzV6Ut24k4=
X-Gm-Gg: ASbGncsHTxhPGTjNOvOUDnidgStrzwKrwftPu9edI3kAqOJ4g0yWreZhr+cnFMXUU9z
 LJbzARneE3J+axdqV3XKmgcOkMgZjj9dsYlgEqt4uxGjSzf4S/h44unYBo3+OOPUwyZoeImcDLN
 9OQqipb5qT22Yl07QanZrYA9LaR1UNdZr8u8PcQrkZCA==
X-Google-Smtp-Source: AGHT+IH7mdyk/5naYevuqR8jnYVDj9rrLyBw3nhYsBJ76d0ex0pezkTAguIprwA97/7OjSqJ/6EXQFDqhPsaD8EEVSM=
X-Received: by 2002:ac8:59c6:0:b0:4a6:fa8e:50a8 with SMTP id
 d75a77b69052e-4a7fcd0a40amr4983151cf.2.1750958796756; Thu, 26 Jun 2025
 10:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250622181352.440499-1-pravin.pathak@intel.com>
 <PH0PR18MB408634F09235215A9DC29685DE78A@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB408634F09235215A9DC29685DE78A@PH0PR18MB4086.namprd18.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 26 Jun 2025 22:56:10 +0530
X-Gm-Features: Ac12FXypslivJO7g4ylJuh_TOZy3ulN4-2LquebZ_zugVUgnH5g4UD6OE36I0eo
Message-ID: <CALBAE1MGDwtb_DUsB58KA2p32qkYr3e4aVQhaR5U=-9R=G8iQw@mail.gmail.com>
Subject: Re: [PATCH v1] app/eventdev: fix number of releases sent during
 cleanup
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Pravin Pathak <pravin.pathak@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Jerin Jacob <jerinj@marvell.com>, 
 "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>, 
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, 
 "chenbox@nvidia.com" <chenbox@nvidia.com>, 
 "tirthendu.sarkar@intel.com" <tirthendu.sarkar@intel.com>,
 "stable@dpdk.org" <stable@dpdk.org>
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

On Tue, Jun 24, 2025 at 11:57=E2=80=AFAM Pavan Nikhilesh Bhagavatula
<pbhagavatula@marvell.com> wrote:
>
> >During cleanup, only send releases for events app was
> >not able to enqueue. Current code is sending releases for
> >entire dequeue burst.
> >
> >Fixes: f0b68c0b2af7 ("app/eventdev: clean up worker state before exit")
> >Cc: stable@dpdk.org
> >
> >Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
>
> Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>


Applied to dpdk-next-eventdev/for-main. Thanks


>
> >---
> > app/test-eventdev/test_perf_common.c     | 4 ++--
> > app/test-eventdev/test_pipeline_common.c | 4 ++--
> > 2 files changed, 4 insertions(+), 4 deletions(-)
> >
