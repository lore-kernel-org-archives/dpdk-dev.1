Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB8C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 22:26:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E9FB40268;
	Mon, 10 Mar 2025 23:26:31 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id E952C400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 23:26:30 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso7070767a91.3
 for <dev@dpdk.org>; Mon, 10 Mar 2025 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741645590;
 x=1742250390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yUcnH+FbBD5LqPFhqLqa9NzBBrBeu/MQnUvxPWnwDs=;
 b=sIRxmNNAvt3JDqO0cxfw+bSjwnui739nGxKv6UrpKL7DFP27tw/L+MYzGtiJHoj8MB
 6HbQtAvEMa0wWVwVm3YC07B7s5gDVBumL0vw8UDtl71wWgQsYzMbhWpg3sOOIJD/9myW
 g9k5E6TSMTwbPkuy9TDyOb0xrLRUKRMdPK/fTWHcCLN6SzO2wFuyYjgyDI/P16JtAL/L
 p+MUslR9ZWkCcueqHi6rOar9Vqn8eiIdrq4CIlVCgjrxVrJMRHgLEsb0Bxeyd9uDmX/e
 0+gICHCLdycYr5Mdtxxzc13Nh45xVlxe8gWbF43oqoafHuLmQldRFzzjtauwJaBWHVAG
 dYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741645590; x=1742250390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yUcnH+FbBD5LqPFhqLqa9NzBBrBeu/MQnUvxPWnwDs=;
 b=gwM6jOu//YbbV4vHbtqpzqDl9uMx1NMWd1wEWKgg+2sW6NbdbFpLUukhoik+1cIot2
 l6+7GNX3pvLA4oYkTH+OW4VOfusxtuaT5+DV7VGXxkMJjyr8gMScWt9XhjJcDHyLcQhr
 SX4te29kc662Xd0uzy6gC7DGxxJuQv8keo5kEhmfbl/pibsy7VX9t/8L8sC/FzapkaAu
 JRssUxsoVE6dhw0Bnm4LH6urb89LeSSf5oscABVn6LqwHahJhBCGX0UUCHlPnBfT6Lei
 uHur8H68Z6OZ+CQA6UNtsJtvca4826qz7vSGtODKOfI6SLXkMLPTiGXZrJorFWQaV5x8
 SLMg==
X-Gm-Message-State: AOJu0YwUup3/tB58Z5q40C4EFoCQWdu23oAAnEKbs9JU72B6JCGf1H+0
 Q1863M0PDfatvUG4Oi7U4tyrqmfdP7fs9GgtrZNrqBgVwx4QuxyzxVRoPPnFip8=
X-Gm-Gg: ASbGncvMpbpSMMu0WTGu+7Zm4BtiExAzIYMem+X643jhbf/PU4IG8eS8rkJ1U79zNQf
 EE0Itd+Vz1quWKMPLqFUS4EAdQ3Y0+XeLLPVC/mhMbxHi0DAvAao3zrf2/5KgkH8M542zUv3G2X
 c3ateKSefR9YvYMmtMB5VKkg7KbdsKtUT7ZEAZjPz0E7ySKI4tk+eTtySNiLqPf0yMyQRpSRIh5
 GOkZVYPfEYY+xw2x75xlkk16j4y4a8WFITrwdkf05wuRYlkdTmM1kalPBRHndwQnqZCp3jQyctA
 5Dn04nxbxx5rIaqnFzQAABHWhwNZfaJb++AJSGQoL9t5Q4kroBmKP8PWGwtEUvLGX6BPEVjQ4FT
 j1A4cuckYL1j8mdJL27jrEQ==
X-Google-Smtp-Source: AGHT+IFANFFGK6xKOeP5UB0/6iX9ZNpdAeQ++f+cz8XTQhi7dnrfHeLY6HJ5VyXpk1uYZjhFieFtDQ==
X-Received: by 2002:a17:90b:540b:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-300ff0a948amr2037694a91.2.1741645589567; 
 Mon, 10 Mar 2025 15:26:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7899f7sm10456304a91.22.2025.03.10.15.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 15:26:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:26:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 00/14] Remove unnecessary function pointer deref
Message-ID: <20250310152627.03cbc94a@hermes.local>
In-Reply-To: <CAJFAV8y+2C7o8YiFgcWwuBpz0QPu-vNDtKqu+WPMxYRxd0dy4Q@mail.gmail.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
 <CAJFAV8y+2C7o8YiFgcWwuBpz0QPu-vNDtKqu+WPMxYRxd0dy4Q@mail.gmail.com>
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

On Wed, 5 Mar 2025 17:52:50 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Thu, Feb 20, 2025 at 5:57=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > A common pattern in DPDK internals is to have an array of function
> > pointers. When using these pointers an unnecessary derefence is done;
> > this is allowed in C because of a historical quirk but unnecessary.
> >
> > This fixes all instances of PVS Studio checker warning:
> >  https://pvs-studio.com/en/docs/warnings/v516/
> >
> > This leads to a large number of warnings marked as High severity.
> > This patchset simplifies the source and gets rid of these warnings.
> >
> > v3 - remove unnecessary paren in ethdev ip_reassembly capability
> >
> > Stephen Hemminger (14):
> >   ethdev: remove unnecessary deref on function pointers
> >   eventdev: remover unnecessary deref on function pointers
> >   net/bonding: remove unnecessary deref of function pointers
> >   net/ixgbe: remove unnecessary dereference
> >   net/ipn3ke: remove unnecessary dereference
> >   net/memif: remove unnecessary deref of function pointers
> >   cryptodev: remove unnecessary deref of function pointers
> >   crypto/scheduler: remove unnecessary dereference
> >   compressdev: remove unnecessary deref of function pointers
> >   dmadev: remove unnecessary deref of function pointers
> >   rawdev: remove unnecessary deref of function pointers
> >   mldev: remove unnecessary deref of function pointers
> >   regexdev: remove unnecessary deref of function pointers
> >   security: remove unnecessary dereference =20
>=20
> I fixed a few missed occurences in touched libraries.
> Series applied, thanks.
>=20
>=20
> I noticed there are some occurences in lib/jobstats, lib/port and lib/vho=
st.
> Would it be possible to have a coccinelle script for this?

It would be hard because coccinelle infers types, and each function pointer
has a different signature.
