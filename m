Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9520C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D004114B;
	Thu, 13 Mar 2025 18:01:09 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9483A41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:01:08 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-225477548e1so23940285ad.0
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741885267;
 x=1742490067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwBS1pyCI3e6CbCPjfyYjjTqYA1YP3SAKDfLkEh9Fro=;
 b=iUoBYr9Z0dGK1sj4jIG4Ezv5grWVDvmHFp8Dm3epM7YWSAR1bPY99rT8aq13gSK8F3
 rHjxv3ZQVFFD+GCuPpZgrBnMudHHjNpvq9lVtmQ2ezQQdTLe+DDm/m1Uznkgf2eJMjDL
 JRTHRlUwBmL9SIpIuMyZeFcOeTCCts8DJPN07qrQEqPEVLUUQjDS6PkZ/3tAg+Rg2Imf
 866HC1vpRMWA+fn6b+xq7yVhf7OKL8uFalF4JpDwr91xFfzfzcSY7EMvXa1rRpFMwpwx
 J5NYl5zZkWoGMBE1ryjvNCJWnA7R5Ov7RPJc+jObhAMvSwc6WfMxDUX00pTPjNRHLTUt
 Fdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885267; x=1742490067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwBS1pyCI3e6CbCPjfyYjjTqYA1YP3SAKDfLkEh9Fro=;
 b=fuQ1fdRQ8cLRGOGtkXXBXmUtW+PDKoby0QDakM98didRF6mZk+VKM1j1cmejwYxUlI
 MGxqBOTwRp6bCdvagb1z7pKfI2YzEuc84YtFiR2Luz3QEJ4aQrMnGN45km0fm7uu72CJ
 tRFbAJaz7tirx6ZbXy8KYuM2c5hXgCUq8lEqACfSHxtM7nm/HVww6+ikFP2qDzhP8KVd
 52JX2ZZrgGdRXszRVyYBQJXIifWRHJvxpKi0AU9Hzor22j6Da0y6bcGoepC7WREMCO81
 sctNQvUsQGR+LDLtqOvoVSqW6F/BtkXrs9ZxYcjoG9HGyXXPcio0IFY4UM6M45lLsYG5
 gHog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVACOd3P0NpQszpjr73VTKn/7tR+cwWYrXQSgFqluy5oZpDQ2XC8CTWzJmRdnx4TlvkNI4=@dpdk.org
X-Gm-Message-State: AOJu0YzuJGj8PhOI9yippoOVqoFwSVXEYxxkXgMu1QGVTPbRzwnYszlE
 9I9404QUdwWeDaUiv74gAypUn6/HQNdfKcRr25KXhCFAQ0RusfG9S3dCgkWuxDM=
X-Gm-Gg: ASbGncsB3Z4NS5B5MkAMcWLyp1R2O/b7j6eg5pqh46ea1Be/4uGuDw9Sq3AKPbwosnT
 Iirp86recPZf1tA2r42fkyyav2El14G6hQlsIhXUiwNf9KKr5VnP62wtbVrKUk/+UsCxH57/QCq
 bQVzmzw4pSt28vAGkSCabz3LsEfM2ZCupDTDVe+nQEi0WXfECK0qWdmG20W8Xb9qjsJH59GaveI
 0EIRi37/WcBQGvG/d7fqjHkXXSHCsXNEMHlPXPZBUxPHuIpX+6D1nY9HabXGho7uLMq88zyO+2i
 ltZOJ1XRaBJjzYbhcp82Sfoub5Yf7fqK3vQvld43RnbccrFltakKvNg7p4J/v4EFjJLNBgh67UB
 2sNgu+g3ozg0qkTEFt6RVgA==
X-Google-Smtp-Source: AGHT+IH6UglrbBf0i1HuxdpSSIo/c2Kb4MhEqD/4SjllsTdMcJF2emPx4wvdA5JuIRATThY/STIsRQ==
X-Received: by 2002:a05:6a00:1891:b0:736:450c:fa56 with SMTP id
 d2e1a72fcca58-7371f0b0c30mr305368b3a.5.1741885267449; 
 Thu, 13 Mar 2025 10:01:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9dd388sm1505293a12.20.2025.03.13.10.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:01:07 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:01:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <dev@dpdk.org>, "Tyler Retzlaff"
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Message-ID: <20250313100105.52f70995@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB12@smartserver.smartshare.dk>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
 <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
 <3711940.zToM8qfIzz@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB0F@smartserver.smartshare.dk>
 <20250313092457.35c2148e@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB12@smartserver.smartshare.dk>
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

On Thu, 13 Mar 2025 17:40:26 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 13 March 2025 17.25
> >=20
> > On Thu, 13 Mar 2025 15:41:33 +0100
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > >
> > > > 13/03/2025 09:56, Bruce Richardson: =20
> > > > > On Thu, Mar 13, 2025 at 09:00:09AM +0100, Morten Br=C3=B8rup wrot=
e: =20
> > > > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > > > Sent: Thursday, 13 March 2025 00.02
> > > > > > >
> > > > > > > On Wed, 19 Feb 2025 15:55:17 +0100
> > > > > > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > > > > > > =20
> > > > > > > > 14/02/2025 18:20, Stephen Hemminger: =20
> > > > > > > > > The Linux version of sys/queue.h is frozen at an older =20
> > > > version =20
> > > > > > > > > and is missing the _SAFE macro variants. Several drivers =
=20
> > > > started =20
> > > > > > > > > introducing the own workarounds for this. Should be =20
> > handled =20
> > > > in EAL. =20
> > > > > > > > >
> > > > > > > > > Signed-off-by: Stephen Hemminger =20
> > <stephen@networkplumber.org> =20
> > > > > > > >
> > > > > > > > We may want to unify with =20
> > lib/eal/windows/include/sys/queue.h =20
> > > > > > > >
> > > > > > > > =20
> > > > > > >
> > > > > > > Not sure, we have several options here:
> > > > > > >   1. Keep using Linux sys/queue.h and add enhancements in =20
> > > > rte_queue.h =20
> > > > > > >   2. Make rte_queue.h a copy of FreeBSD version of queue.h =20
> > (that =20
> > > > is =20
> > > > > > > what Windows did)
> > > > > > >   3. Use the bsd version of queue.h.
> > > > > > >      On Debian/Ubuntu this in libbsd-dev package and referred=
 =20
> > to =20
> > > > as =20
> > > > > > > bsd/sys/queue.h
> > > > > > >
> > > > > > > I chose #1 as simplest. But all of these could work. #3 means=
 =20
> > > > DPDK has =20
> > > > > > > least new
> > > > > > > code, but adds another dependency to the build. =20
> > > > > >
> > > > > > +1 to #2:
> > > > > > If Linux sys/queue.h is frozen, and is a subset of FreeBSD =20
> > queue.h, =20
> > > > #2 would consolidate all the queue macros in one file. =20
> > > > > > That seems easier to navigate (for a developer/reviewer looking=
 =20
> > at =20
> > > > the macro definitions/implementations) than including sys/queue.h,
> > > > queue.h or lib/eal/windows/include/sys/queue.h depending on O/S, =20
> > and =20
> > > > then defining the missing macros in rte_queue.h. =20
> > > > > > A comment at the top of the rte_queue.h file could mention that=
 =20
> > it =20
> > > > is a copy of the FreeBSD queue.h file. =20
> > > > > >
> > > > > > -1 to #3; it adds an unnecessary dependency.
> > > > > > =20
> > > > > > >
> > > > > > > No matter what, should add to checkpatch to block any new =20
> > files =20
> > > > that =20
> > > > > > > include sys/queue.h
> > > > > > > directly. =20
> > > > > >
> > > > > > +1 to this.
> > > > > > =20
> > > > >
> > > > > I agree with Morten, #2 looks the best option to me too. =20
> > > >
> > > > It means we want to remove lib/eal/windows/include/sys/queue.h, =20
> > right? =20
> > >
> > > Correct.
> > > All queue macros are consolidated into rte_queue.h.
> > > =20
> >=20
> > I have been trying this, and it possible but there is some fallout.
> > If application includes <sys/queue.h> and other DPDK headers include
> > <rte_queue.h>
> > there are declaration conflicts. Ends up being a compilation failure.
> > Tedious, but not hard to fix all of DPDK to use rte_queue.h instead of
> > sys/queue.h
> > but what about user applications? =20
>=20
> Perhaps this could work:
>=20
> If _SYS_QUEUE_H_ is defined in rte_queue.h, including <sys/queue.h> after=
 <rte_queue.h> will be harmless.
>=20
> If each macro in rte_queue.h is surrounded by #ifndef MACRONAME, includin=
g <rte_queue.h> after <sys/queue.h> will be harmless.
> Alternatively, surround a group of macros in rte_queue.h by #ifndef _SYS_=
QUEUE_H_.

Most applications include system headers (ie. sys/queue.h) then DPDK header=
s (rte_queue.h)
> >=20
> > Since that would be API break, best to put it off to 25.11. =20
>=20
> It might be impossible prohibiting user libraries from including <sys/que=
ue.h>, especially if some 3rd party library includes <sys/queue.h> in the l=
ibrary's header file. The application developer would not want to modify th=
e header files of 3rd party libraries.
>=20

It is possible to bracket every macro with #ifdef to avoid collision
but gets messy.


