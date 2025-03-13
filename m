Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA4C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 16:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347AE41141;
	Thu, 13 Mar 2025 17:25:02 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 6EB1B40ED3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 17:25:01 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-301302a328bso2477939a91.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741883100;
 x=1742487900; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCzJbOPAH6tG8vEmd1no/Al34RxIvoosmiLn5VUTzsQ=;
 b=ayzxN/Wa5jwM+mdroUGyo42ItQrjr7nuAlRmcCunkhPsjUI1jpdwOUTZLlIus/SqDT
 qsrinCFNwUYcCA/us4C8HQd89tjzWEuDIFEircaw20ls6KVRycEJL0odVEnR1OLzIz90
 Ggkyp1WyUtI1PE5apoFThBmmfMkOdvqfA1C69oq8DkfX5tA+gAISh5JLqVnNBddErWn/
 /VX6HBqfCBYLUitDJECISs5JnJnmvVQyp/Y2cJDzJzWJLEIWhkfRffurBIRRLZW/g3V3
 ZnV5IhV4+Fjgp2XiB+s/12ofrRZIJ/wgbWuQcN7KmVh2+DWNEjEBX234OMmVZIydkfJy
 jQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883100; x=1742487900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCzJbOPAH6tG8vEmd1no/Al34RxIvoosmiLn5VUTzsQ=;
 b=GREwNxfro0/Wv8sf3A22UWxurlxK8hLiyDtNkcpGzAJ8bz076Z8s6TNJuetfWgyr56
 J8xG0/CN2wtrSBu8BKQQIz90Cu3+hBg70tGKchG+N+egxwfDYUw5M7T7sRGqRKHtoBDH
 KuWT1oVklMlvX3TseQbF80QHJjfCvSR3vYD1alcsg5wPF8+PCedYUwOr4RxhxNiEmncJ
 qPGcJxBlhof3o1ssq6yescBVhPZ+rc/rZU5YegEJ/y0OT4sEAZVnzM+oJUSy+viZL9qp
 tAFlDHrxtPx0WfmfO5Z8ps6fKKkLlrMZmhPxkoY9mPyR1x8rEzKDAUi1Rwk6NirwEzhD
 fLXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB155y3aPr0hTGT0W+3oHIrb2LLRxXWYQR4NGv+pinQ7EWvKedM8huicb1qv7+nXVimxo=@dpdk.org
X-Gm-Message-State: AOJu0YxMZJZBrDr02jQzomNEfWffBIwHW0kSy1wYvr54rPyKfYovhfjL
 Ahy69rGzy0Shx/ycjZGFSgx2Lp2eRgsVCgaARbJUXn0qKQeStgxPu6aHxhAyVuk=
X-Gm-Gg: ASbGncsRFkVF9FA35Vs1Tu5ZMX9Aap5G1PPn7jpSVyN5Gy7imKfTwRAJ3L/vLmlRJjr
 Br0f0OhCvQTQdWu6V59FGErn/uraUGd7tIqV1b46d3hZ+wqHPGXXwnGVeFEcQ6KNxLx8ZuXrt0M
 /QjoBRurOErU9ouQNxH0/kCwDhWNlay090P85k34igyGzoo2XPMNYPbZgDYLo/c81BIGwfbLIFd
 gm09NWwX0Sqka5Ca8evgPEErN3jQrggTaGhlJ8iGCWlO1E1BHnxKKYZ7/mwhwcywYz1uKfprSA6
 yMCtA+ipMW/mJ/9FlmNWbfNajM61CKiyWTBow4JXK5QbYAakFnv1lct968o/YAyLkmHrNs1ROS1
 kMV6Txqq7MQqiqhjKkpa2nA==
X-Google-Smtp-Source: AGHT+IG2nqMeXWBZ6/AYWQPl7hIeShYmlG2vWjOE2aRhGiAj95mK3PVrQvoVfnhyVgBT/gqe2QyJXw==
X-Received: by 2002:a17:90b:540d:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-3014e844d4dmr208170a91.13.1741883100317; 
 Thu, 13 Mar 2025 09:25:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30118218707sm4033680a91.3.2025.03.13.09.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:25:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:24:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <dev@dpdk.org>, "Tyler Retzlaff"
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Message-ID: <20250313092457.35c2148e@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB0F@smartserver.smartshare.dk>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
 <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
 <3711940.zToM8qfIzz@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB0F@smartserver.smartshare.dk>
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

On Thu, 13 Mar 2025 15:41:33 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> >=20
> > 13/03/2025 09:56, Bruce Richardson: =20
> > > On Thu, Mar 13, 2025 at 09:00:09AM +0100, Morten Br=C3=B8rup wrote: =
=20
> > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > Sent: Thursday, 13 March 2025 00.02
> > > > >
> > > > > On Wed, 19 Feb 2025 15:55:17 +0100
> > > > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > > > > =20
> > > > > > 14/02/2025 18:20, Stephen Hemminger: =20
> > > > > > > The Linux version of sys/queue.h is frozen at an older =20
> > version =20
> > > > > > > and is missing the _SAFE macro variants. Several drivers =20
> > started =20
> > > > > > > introducing the own workarounds for this. Should be handled =
=20
> > in EAL. =20
> > > > > > >
> > > > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>=
 =20
> > > > > >
> > > > > > We may want to unify with lib/eal/windows/include/sys/queue.h
> > > > > >
> > > > > > =20
> > > > >
> > > > > Not sure, we have several options here:
> > > > >   1. Keep using Linux sys/queue.h and add enhancements in =20
> > rte_queue.h =20
> > > > >   2. Make rte_queue.h a copy of FreeBSD version of queue.h (that =
=20
> > is =20
> > > > > what Windows did)
> > > > >   3. Use the bsd version of queue.h.
> > > > >      On Debian/Ubuntu this in libbsd-dev package and referred to =
=20
> > as =20
> > > > > bsd/sys/queue.h
> > > > >
> > > > > I chose #1 as simplest. But all of these could work. #3 means =20
> > DPDK has =20
> > > > > least new
> > > > > code, but adds another dependency to the build. =20
> > > >
> > > > +1 to #2:
> > > > If Linux sys/queue.h is frozen, and is a subset of FreeBSD queue.h,=
 =20
> > #2 would consolidate all the queue macros in one file. =20
> > > > That seems easier to navigate (for a developer/reviewer looking at =
=20
> > the macro definitions/implementations) than including sys/queue.h,
> > queue.h or lib/eal/windows/include/sys/queue.h depending on O/S, and
> > then defining the missing macros in rte_queue.h. =20
> > > > A comment at the top of the rte_queue.h file could mention that it =
=20
> > is a copy of the FreeBSD queue.h file. =20
> > > >
> > > > -1 to #3; it adds an unnecessary dependency.
> > > > =20
> > > > >
> > > > > No matter what, should add to checkpatch to block any new files =
=20
> > that =20
> > > > > include sys/queue.h
> > > > > directly. =20
> > > >
> > > > +1 to this.
> > > > =20
> > >
> > > I agree with Morten, #2 looks the best option to me too. =20
> >=20
> > It means we want to remove lib/eal/windows/include/sys/queue.h, right? =
=20
>=20
> Correct.
> All queue macros are consolidated into rte_queue.h.
>=20

I have been trying this, and it possible but there is some fallout.
If application includes <sys/queue.h> and other DPDK headers include <rte_q=
ueue.h>
there are declaration conflicts. Ends up being a compilation failure.
Tedious, but not hard to fix all of DPDK to use rte_queue.h instead of sys/=
queue.h
but what about user applications?

Since that would be API break, best to put it off to 25.11.
