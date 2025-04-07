Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F80CC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 07:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3057640156;
	Mon,  7 Apr 2025 09:04:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 690BA40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 09:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cz3X3HKxxgpdku2SzpzXw21/vxuee7DXIyViadDrP5Q=;
 b=KFfK3b30ByikuC2Xy2hftJAWDyOjqQAFDVYdYesBtOw2YZMtHDu5sr8I4/slmrw8yjcT9D
 jrO3iV2Wn/bcvhEMdmcBumfhy4sLBWoUS26w+GqxCW3xDF1RbsTLpqH5fMA9UXJnez0tgY
 Pl4eTMs1usdO7BW8mE+BbJcRwE8OEgQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-TtNUhM9pMAyh9Zo7Hyfo3w-1; Mon, 07 Apr 2025 03:04:18 -0400
X-MC-Unique: TtNUhM9pMAyh9Zo7Hyfo3w-1
X-Mimecast-MFC-AGG-ID: TtNUhM9pMAyh9Zo7Hyfo3w_1744009457
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30d6259f500so17738931fa.3
 for <dev@dpdk.org>; Mon, 07 Apr 2025 00:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009457; x=1744614257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cz3X3HKxxgpdku2SzpzXw21/vxuee7DXIyViadDrP5Q=;
 b=nHdw/8u5BnnWiVT6UwDWNdXDAC/G3Opln6EVWpmaxQWUQrWugpfB6bqIFCf5aG79Hb
 TwuBUiGfM5jzlEuHc5GfskQ2QiDcu//Ny2Ik9FfcOXOi/nxozU1DH4Krq+87wGFJvqen
 kPIEYY+TMQzJLcQ139pPuJglVhYxgy0wZoKYovDH2kuDGxiNxBcGYY2LL9UGUZhWVmL7
 /UdEc+tcXYdYoNDrmBsId2iCzIDCLTYvKLPmdbevD0CQfM7rJ12rt3l2/4QRC8qUw12e
 wF+bn7xTEkUqxcIVtZFnh46ZGyvjsIFQg4M1Vf7PjRNPvRbYyOEYhVmIHtoRgsZsUIdn
 9JFg==
X-Gm-Message-State: AOJu0Yz3hNCRLwF3H4BH5RrN4QKCBj4nnF/4GQikIixyQiGGofWHoUzg
 MHCILjsIarhHXYtK9rCwRILQ35gWhaz/rFYrunomF3Y3Am4VEdNtk+cIms1GBX0eEHkAU+2/cGf
 g8QDT7dMJwC0iG8O2QsXyMJd6J0q3CYTL/FCuPM6iWHp61jqPqDJLSLcUA10/lB5SMGP1Y6cKf5
 RonsqMDjoUys0K7oc=
X-Gm-Gg: ASbGncuHBF/JI8YdbHsOa3mgvoGeplbBKnVXMezXzEaftd1ahBgvR7DcsOFgcsFJW5P
 9fjqdiluwxq3kE8zRI4HF4SnhrXFkulwnPKcn6LXKZvHaYWT/10EHFt5sk3qnN5bt0/CSpmHigU
 I=
X-Received: by 2002:a05:6512:2250:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54c2335dcc9mr2704202e87.53.1744009456866; 
 Mon, 07 Apr 2025 00:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7VkPNGll9KFZmSE3or4q+u5lRkDDuBdBjoTExoTIn+LL/NJh/3iPdcWBkhDsgXrSXOXnhsNSI/RtbSGequRE=
X-Received: by 2002:a05:6512:2250:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54c2335dcc9mr2704193e87.53.1744009456507; Mon, 07 Apr 2025
 00:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 09:04:05 +0200
X-Gm-Features: ATxdqUGPb2sbufIrsV3A1dSDz6jCto2kUFOaaaw3X2VdZVo8vAUdbU-9vVrv72g
Message-ID: <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DBhfQAzscVWk6SdctvxoRMptSqJmUJe28gGgdbzTpWc_1744009457
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

Hello Bruce,

On Tue, Apr 1, 2025 at 4:08=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote:
> > Traditionally, DPDK has had a direct mapping of internal lcore-ids, to
> > the actual core numbers in use. With higher core count servers becoming
> > more prevalent the issue becomes one of increasing memory footprint whe=
n
> > using such a scheme, due to the need to have all arrays dimensioned for
> > all cores on the system, whether or not those cores are in use by the
> > app.
> >
> > Therefore, the decision was made in the past to not expand the
> > build-time RTE_MAX_LCORE value beyond 128. Instead, it was recommended
> > that users use the "--lcores" EAL parameter to take the high-numbered
> > cores they wish to use and map them to lcore-ids within the 0 - 128
> > range. While this works, this is a little clunky as it means that
> > instead of just passing, for example, "-l 130-139", the user must
> > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> >
> > This patchset attempts to simplify the situation by adding a new flag t=
o
> > do this mapping automatically. To use cores 130-139 and map them to ids
> > 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-ids",
> > or using the shorter "-M" version of the flag: "-Ml 130-139".
> >
> > Adding this new parameter required some rework of the existing arg
> > parsing code, because in current DPDK the args are parsed and checked i=
n
> > the order they appear on the commandline. This means that using the
> > example above, the core parameter 130-139 will be rejected immediately
> > before the "map-lcore-ids" parameter is seen. To work around this, the
> > core (and service core) parameters are not parsed when seen, instead
> > they are only saved off and parsed after all arguments are parsed. The
> > "-l" and "-c" parameters are converted into "--lcores" arguments, so al=
l
> > assigning of lcore ids is done there in all cases.
> >
> > RFC->v2:
> > * converted printf to DEBUG log
> > * added "-M" as shorter version of flag
> > * added documentation
> > * renamed internal API that was changed to avoid any potential hidden
> >   runtime issues.
> >
> > Bruce Richardson (3):
> >   eal: centralize core parameter parsing
> >   eal: convert core masks and lists to core sets
> >   eal: allow automatic mapping of high lcore ids
> >
> Ping for review.
>
> At a high level, does this feature seem useful to users?

This seems useful, though I am not I would touch the existing options.
I would have gone with a simple -L option (taking the same kind of
input than -l but with new behavior), and not combine a flag with
existing options.

I scanned through the series, not much to say.
Maybe add a unit test for new cmdline option.



--=20
David Marchand

