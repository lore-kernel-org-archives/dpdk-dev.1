Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE42109C04B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 17:33:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 550A0402CE;
	Wed, 25 Mar 2026 18:33:14 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5A3E34028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 18:33:13 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1271195d2a7so207012c88.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774459992;
 x=1775064792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlXBbllao6B9CMTYZN2GiTeQ25gAQQRYt/kY6ddaH8w=;
 b=N+B6bjUhwa5XIEM6dFoyY5R/D2iOdK1+V7zi2C+lTzyGvtfxUGc9Y1jf43MIpl1kmR
 1Ge4ES18XrL4pVljopKTwVx29UEY7u/cyFx1H4YAjiPCdvv+HWYaPXY15cUQyAFSvCX2
 2d1Ij6xbjkRUPwjE4V4Hne86i8DEcRblQYhhFBjYjuHdbyh0gHlTH3NeadRepk7XZ1Ge
 aNJ4UYyKa4JAxPZ6pFPtXImDJlLBFFVmYnUK6JvNue9hpDvWAZqx02zOm2X/KJYWui4E
 7+Kn+ZPJWHOarJgLdsfCu+bH+8wlEwrBnUynhCSirAparZRXIKPnHowC5T/uFMUnLgY1
 7rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774459992; x=1775064792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KlXBbllao6B9CMTYZN2GiTeQ25gAQQRYt/kY6ddaH8w=;
 b=OT3cdFsHiV+3O9CUHrqcmIZ7R4+BMRNGHDKt2TWtPmnNova/G+yoMDVNI5mbx9jDVS
 9YtuJg4QT+0P76mBd9Exg293ICPnmtYSp6d5SfDWRBZy1F6OkCILiwJze5IYs4BZEXNY
 Zgc/QDHzxeEtupJyX/RLSI6ZsE2B+aoNdIFveKTd1prV5Cq/GkuIOXmT6PHKv2gBbnaL
 O2uVZGJ9nX3zS0ZtzAqI/72EhAnJWU3pZNzFbLbyjuGX48JV9R4TkvE32xtlXid8Jumd
 kNxp/AyEA2fgMOZsARh8m0ZpS9OE89xiFtOzjx96e3wCe4mP4tBxhwJGZFQhB+GxVCMb
 5xIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz4wWEhmgtIKQII8X+BhnFemY2afXgfv2/7UddJT4e/RyamZApuvBK0lI196lfANsx76I=@dpdk.org
X-Gm-Message-State: AOJu0YzTV/j8LGX+DtigtLY0Lo/WwcC0r/no1YQcN7Ase4n33unWLIvr
 ng3kdDMxHxpzhkyJmGViN00QdmCkZzK31Ye+txoPL/J2q89jZDT8jQaSRbDTsqHJeg0=
X-Gm-Gg: ATEYQzywXGzt5nlwhhmRI/rODHE8sFeCspgnxt2GLyny0f89rGcKnoxM0ACjsOPVakY
 K578Zt6Z+ql71yjVy/G9C7UPlFboYX42gKfOA4ln9w6Yb7UjvQLHF9UETwxrsiZUaRAZsHHAK2m
 uIqYOIzottpoJexwnQVA1uI6dH7oljF4ioFaH/fzJv9Oos75EmxdOX9AJhKH4VXpg4WrjFNvMMc
 //7agKgJ4xlAqbJHAomLqCUzevE6BxoQy5ceguXql77ISjb2pzbo95esChpmWUBFhk49FQrnYDa
 xqRpI5571XoQbqxZbeJCLI7JJxECrkKWHEZypVxhOuPIWO/QhWh/C7qB7fZB17LrzhQ+q+CeMst
 e/IBa0sLe4y+AR+UKFtHArFc+8xMNjXke+Ly4KqFM5gfgTl79KbQdH+qvP8HrvAqoREafKXMLtx
 z5Amws/+7nODePBJlYIIddu3WM7LEich7kbws=
X-Received: by 2002:a05:7022:6a3:b0:12a:713b:896a with SMTP id
 a92af1059eb24-12a96e63de8mr1909008c88.17.1774459992087; 
 Wed, 25 Mar 2026 10:33:12 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa7273848sm355836c88.7.2026.03.25.10.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:33:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:33:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <20260325103308.6047c665@phoenix.local>
In-Reply-To: <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
 <20260325091921.687599ec@phoenix.local>
 <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 25 Mar 2026 16:22:45 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Mar 25, 2026 at 09:19:21AM -0700, Stephen Hemminger wrote:
> > On Wed, 25 Mar 2026 10:36:56 +0100
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > If an application clones packets instead of copying them, it is proba=
bly for performance reasons.
> > > If the drivers start copying those clones, it may defeat the performa=
nce purpose.
> > >=20
> > > <brainstorming>
> > > Maybe segmentation can be used instead of copying the full packet:
> > > Make the "copy" packet of two (or more) segments, where the header is=
 copied into a new mbuf (where the VLAN tag is added), and the remaining pa=
rt of the packet uses an indirect mbuf referring to the "original" packet a=
t the offset after the header.
> > > </brainstorming>
> > >=20
> > > Furthermore...
> > > If drivers start copying packets in the Tx function, the Tx queue sho=
uld have its own mbuf pool to allocate these mbufs from.
> > > Drivers should not steal mbufs from the pools used by the packets bei=
ng transmitted.
> > > E.g. if a segmented packet has a small mbuf for the first few bytes, =
followed by a large mbuf (from another pool) for the remaining bytes.
> > > Or if the "original" mbuf comes from a mempool allocated on different=
 CPU socket, the "copy" would too. =20
> >=20
> >=20
> > The problem with the Tx function is how backpressure gets handled.
> > Not sure that it is documented well enough that if a packet is not sent
> > due to backpressure, the mbuf in the array may still have been replaced=
. =20
>=20
> Most drivers should be able to check for space in a Tx ring, or whatever
> other backpressure mechanism is being used, before modifying a buffer.
>=20
> /Bruce

The wording in tx_prepare documentation mentions checksums requirement but =
not vlans.
