Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA95C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 15:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D109B42E54;
	Thu, 19 Jun 2025 17:52:11 +0200 (CEST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) by mails.dpdk.org (Postfix) with ESMTP id 3A997400D7
 for <dev@dpdk.org>; Thu, 19 Jun 2025 17:52:10 +0200 (CEST)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-4e79de9da3fso251071137.1
 for <dev@dpdk.org>; Thu, 19 Jun 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750348329; x=1750953129; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyJGS8EUdkXIpDK62Nhl/fz6jJZAPDhlxvBuwJEeFwM=;
 b=Mz4r/37p2Ijd9mcshUQIJbUn/73VazBbtpxH0z8Ww6N15R4Ib48Fda3gUaOzWvnbvF
 uj7EHZ9Ga5SHv5Eabn3Ft2ZPz3sUvmPi2n7uaK2dHdYnt6Bu5m9PNPqBbLRe70x9ASuF
 GleVs7ht3p1rnm3LlApM/wXQME1QS/WpQlDZeG32JDx6eO/pgv4uqchDfjy0QOQDZXzU
 qZ2egyCydas9gELHIZKYwDbJYY1MWx3l3WlOOLi6N/nyay0dBINHARNaJFX+L1G0i1iu
 F9XI0cIk8WVXciEgUPG53zEUZflM+OWeur7VAkesF3XGcn02UTUsnIDybxTmJFNEVyyR
 1b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750348329; x=1750953129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyJGS8EUdkXIpDK62Nhl/fz6jJZAPDhlxvBuwJEeFwM=;
 b=nNcbC3rQLoDiNmFaFkre47xXCtCeTCEeDhzm12t6WPGuNt2cpYrUD9RwEarW6XnOFs
 K92fF+Zh9aYetZ6af571bj984FVRkHykt2cmTg54eSEcOnIlw+LjpmSg25VqX+vOsPAy
 jXyhVgztfu1S2UgD2nbnvT2qhxIi4HPGbnv6eRCq3xBxS4Ay3MRd4A79yIuSKhh9hYhx
 k7m+ggDCfOSWzCrywq5Ofssl6F3nuXaB5YCohLq7Kg7FY5+mwkxF7jeifVfqyjASswB8
 YYtzxHU3Y6Y6eNrWrr5Ko7YXz1P6Kh/eGrpy+VcgP4NYFZbFs4jup+f4hfqlfjjKdc2x
 0wcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYlretktBsM4nZ+kvZvH0NCuxt+fFvnRT1rjdkwTfaXzyDHuHHQTWLNZhFKoV7ukLk+gc=@dpdk.org
X-Gm-Message-State: AOJu0Yyusr/oTj5aCkq7jP1HM1W5CAE8w4pRLxrrAFN1r6HKePJSA80x
 27LPI9hCzLUEPKfRPRALI37B8iTFyqTJPYpYSRZinosf5EmSAnHAXtMjbb+FvdvgP+GmT7wUtjw
 lsCHnwwN0DMxUz2dJHjTWhYRsPkGNly4=
X-Gm-Gg: ASbGncvutvHOSOJyObvd4YMvMitSUiEICNrHacl/frViAKQoBfrU1z/uf4zT3abj0RP
 cM7ujdEwWHda+c5ZNHpreej93Gw/0ZxRosIbb3XnmkqNSawlfGRLdJacKlLx6FtHUNIeCzRTn2/
 k7SPci6E/V1cAhZ0pEaLBgH8JGT62dY9L38GPZ4/FHaA==
X-Google-Smtp-Source: AGHT+IGgEU4lFZRDjeJxbOcS/H356JcqBFXKVBlGEuOJ42UCcSpGVuf/qVZX8DlcunbYF0LFgolUU8YIAGJsk8ojtYM=
X-Received: by 2002:a05:6102:dcb:b0:4e6:edcf:3890 with SMTP id
 ada2fe7eead31-4e7f61178b7mr16171561137.10.1750348329371; Thu, 19 Jun 2025
 08:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
 <8151763.UjTJXf6HLC@thomas>
In-Reply-To: <8151763.UjTJXf6HLC@thomas>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Thu, 19 Jun 2025 21:21:57 +0530
X-Gm-Features: Ac12FXzyvCPGHwMNSlvUV_fBrsLTJwFKFFrBfj6sUkCPlSKb4aCaGOCbRRFUrh0
Message-ID: <CAG6-93wju7RiNzNEiqq=3HLC-Tk4F=tfCig9by__V_xaVqyqLw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>
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

Hi Thomas,

Thanks,
Nitin

On Wed, Jun 11, 2025 at 5:15=E2=80=AFPM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 28/04/2025 12:37, Nitin Saxena:
> > Currently each rte_node registers separate mbuf dynamic fields for thei=
r
> > own purpose. This leads to wastage of mbuf space as once mbuf get passe=
d
> > a particular node, the registered dynamic field(by that node) is no
> > longer used.
> >
> > This patch series adds a global/common mbuf dynamic field which is
> > reusable by all the nodes(including out-of-tree nodes). This helps to
> > repurpose same mbuf dynamic field for other nodes. It contains two type=
s
> > of fields: (a) persistent (b) overloadable.
> >
> > While persistent fields are those which does not often changes during a
> > graph walk such as rx/tx interface, buffer flags etc. Currently there
> > are no persistent fields added but they can be added later
> >
> > Overloadable fields are those which can be used by two adjacent nodes.
> > Same overloadable fields can be repurposed by other two adjacent nodes.
> >
> > This patch series also updates ip4/ip6 lookup/rewrite nodes to use
> > overlaodable mbuf dynamic fields.
> >
> > Changes in v6:
> > - Incorporate comments from Pavan
> >
> > Changes in v5
> > - Rebase on latest main with version.map changes
> > - Bring back memzone based node mbuf dynfield for secondary
> >   process [Pavan]
>
> Please it needs to be rebased again on top of feature arc that you added.
> Thanks

Rebased patch-set v7 on top of main. Sorry could not do earlier
>
>
