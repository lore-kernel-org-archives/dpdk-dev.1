Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82606C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 10:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86FCE40B8F;
	Thu,  3 Apr 2025 12:27:41 +0200 (CEST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44]) by mails.dpdk.org (Postfix) with ESMTP id 72AF44060C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 12:27:40 +0200 (CEST)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-86d587dbc15so735097241.1
 for <dev@dpdk.org>; Thu, 03 Apr 2025 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743676060; x=1744280860; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiyZx9G+7LkaDxWtSyvt22VHLi6cv6tYrER4bcCw4UE=;
 b=Pao88anfWo95FLEMGfB7ExT9LPvwTC+0102dIQLdBFrbORZbn5gIkbeLrBKmvz6bAl
 FHDQxrUhWSJK5wRmefxh2kewiJ3fHaY7hDC1I8rx95vp3USWqkh1EwVlHKQpmh5xLaH1
 KyVKF5otFr8I9kLuU+eLmqRPCse98NsbNqFjW9Ez6p5hliX1Q+Ffe8R56MfLiUJ9Tvaj
 hFG7mQAX6lPfP1xF1QaiWO9PH5d+3ySb7SXstpyBdgHeQ6ljpWiJ29cK9VJVCZaDMVAb
 UGbFcqBHPh/RPpemsmSvXx8jVyEwEl58qKJI7Zg1dvqHawNW5gURIenGvu13/cYrgnGl
 sljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743676060; x=1744280860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiyZx9G+7LkaDxWtSyvt22VHLi6cv6tYrER4bcCw4UE=;
 b=NhrADUFzw0r+lMeHjflzNXLwzrZgG+EWflJdsr4QitQamb9Jr2AttM3MevQ941Pfpm
 lMUInyXOKEhV8QFzC0RzDWegSa9f6SQ5/GdCELfx6UgwuVVYiqw4RHXCt3HDn8jF/bZf
 xzFp4iBcfufk2oVb79HciPNKV8ZSYjCT4S7Uj8oPtVo9sFsNBT498yNfJWADCjEqyRfc
 Wam3YoO0+1h8xI0DNc5v4NIdJPRU69BhYk9o0C8eKdZWqmU49tGlaPi+YjMDtyYyEo+O
 CmVFs83qU5T5XZeiM958MLI8u5o5XEV0RWEUErzUojtQ8aNKmNmNT1TTrLe2B72NiCbw
 Xb6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKdif04sMOvbzmbQj5vPKb1ryIH6uPNWHNRPcGm8zxbuWuYjALwQ5k1wgG3rrKgVE0Zxk=@dpdk.org
X-Gm-Message-State: AOJu0YwzhuMxn+lCjVKERqmD/yvEnbXDWoBR54CgtgfYXovJlFhe+uE9
 Hp/pqTSzOleptKTW9FlPW8rDdSsUe0uVfOCF/EC/Z/b/K7aTKidZeTl+Q1sBHXTZLlqeB2DRk4G
 nB5l/hT2ADnNn2JanwfxxqnbJRUs=
X-Gm-Gg: ASbGncufkMG2xznFPS8dHmBtonwkSMtLvIHyl7mPsMu61+SZbb/H6OBexoC37k+MLJ4
 yRFANkeU4IMQOHO1P25JUDA0wHz/Rk2rcKeIFU8LeSP6nD5Bq8SzJzDA8SByAS9CV1N0TT0pUXt
 /1ycWu8Ah32ccN5TCdloCfoJxmUNw=
X-Google-Smtp-Source: AGHT+IGSn0AjcuQKICJRCMQWBEI1CaxcGyjWT2oBqLGZXwg9/IGNRV2JeSmMni0ppwj4ZwNBuamtlMXYqwFhkIOG++c=
X-Received: by 2002:a67:be02:0:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c845b9933dmr1804136137.12.1743676059692; Thu, 03 Apr 2025
 03:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250401042053.3518757-2-nsaxena@marvell.com>
 <20250401071522.67cf34eb@hermes.local>
In-Reply-To: <20250401071522.67cf34eb@hermes.local>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Thu, 3 Apr 2025 15:57:28 +0530
X-Gm-Features: ATxdqUFuribIInI6c6br5PsKMm56vPjYmcCAGk-UTb5n1DeR-azRMR0elEoqBlo
Message-ID: <CAG6-93zdmJ0V=zFzj-r3GZtjEiygLpHbhE_8SW6odoocz5S-5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] node: add global node mbuf dynfield
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nitin Saxena <nsaxena@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, 
 Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>
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

Hi Stephen,

Thanks for commenting. See response inline.

Regards,
Nitin

On Tue, Apr 1, 2025 at 7:45=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 1 Apr 2025 09:50:46 +0530
> Nitin Saxena <nsaxena@marvell.com> wrote:
>
> > +int rte_node_mbuf_dynfield_register(void)
> > +{
> > +     struct node_mbuf_dynfield_mz *f =3D NULL;
> > +     const struct rte_memzone *mz =3D NULL;
> > +     int dyn_offset;
> > +
> > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) < RTE_NODE_MBUF=
_DYNFIELD_SIZE);
> > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> > +                      RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> > +
> > +     mz =3D rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
>
> Seems wasteful to have a whole memzone for this, the data is small.
> Is there a reason it could not just be a global variable like timestamp.
>
Replaced usage of memzone with global variable in v2

> I would prefer this was a clone of timestamp code, and put in rte_mbuf_dy=
nfield.c
rte_node_mbuf_dynfield_register() is local to graph based rte_nodes
and it is not targeted to be used by non-graph based applications

Do you still think we should move this API definition to rte_mbuf_dyn.c?
