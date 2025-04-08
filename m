Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BCDC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BEF540A89;
	Tue,  8 Apr 2025 10:42:38 +0200 (CEST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by mails.dpdk.org (Postfix) with ESMTP id E4E184027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:42:36 +0200 (CEST)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5240a432462so4569905e0c.1
 for <dev@dpdk.org>; Tue, 08 Apr 2025 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744101756; x=1744706556; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RQKNzVKenzpbHHU7zRbELLwfCLrUKdjzjNY/NGp6NU=;
 b=D/zD1z1QCONZkHpfm2hOnCs2vINTkdq6anzYXs1/odGoE8RskgfnGBmOK0BB9Q+hre
 jL9qjXXHMkynb1cuvgSJia+yttuNyb48Z0aVO7V6gJyXqB3ClSGAdWVqnpraYG07DiFL
 SG7TwwO909jCojMKyZEqc4jWeKzHt6w68sPEKrfqrLctPilyY+LsMjGMwI5GxL7F9hrY
 w4gnSYREowfz2FLjA1C42M7pgTvbPQA7AQuCmSxQd87GexNaou+E/VX8LoPg50kjvCxB
 kjnrwrdkzGoTFcGckKEQylQ42n0j2VArrJXJ46vXvwiX0IfbDc6nlbgXi8NgjFX01ftj
 Aj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744101756; x=1744706556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RQKNzVKenzpbHHU7zRbELLwfCLrUKdjzjNY/NGp6NU=;
 b=mTVHzG9wNAWT6hZaq7REc1/C67S2F6zqeXtJ2tJSWnjhx1QPJTDOLXjOkVEWkojjsM
 FbTRWi8mGAXd18YS+xv3lDzrlRIbNFJykUga0RG/cFEyaJ8IFch9zdqYjHdAHyLI5xlK
 KwbeFBPHiuVLMoVp0qTZI/DMrzsSH2Cvu50bYo/o5XmaLWbn2RJxEP2kRLwMpO2FaMwb
 /Nl+uVwZOvQf96QuIacN1qN/sDTN/toyyss9xPIRGzHs+2AI/dpQKTZsCMV5agDcCGhn
 DczK7gsmpSN1S+PLG4Y9TRckGUed7jVZOgR8YXHrxDhsmLEtpx8wh3y0IyJ4V+NOnHeS
 DSaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVPTOryckkyHQYCJeZCRHNSIYKx5Ty7xXvafXGBaKpr6t1RZ3MRLw9bGtAJZsqxNo/z20=@dpdk.org
X-Gm-Message-State: AOJu0YzI7T+0dc8Z94xmH/WRpxuXb43rw3lo+4IAgeVScmba8c3BldbM
 2uTxMuKQ+LIxPRNd53RhPO2keeghQ5tFb+MAaO1Gnf5J2iB7iTCyl3BJ1MFNsjr2qQ4iFhGJqqT
 /UMQUJJ7pHcDbZ17omc7NgN6/Sbs=
X-Gm-Gg: ASbGncvB5bsL4WkJbueq33QlMwcEGxmDrRv1nbDyQGL3uRZIczgFZprqMviWjFSmFmX
 2W4VmVB6+FxF6OSXiVsVFwKE2nqZL2ng11PQpIT7t8gxK96HCX0JtlFRh2ikEvkqKPIeniEGRW6
 LgeOkOFSmgUs84jEBVTkMbIkJTdhSC+1CYDI4npw==
X-Google-Smtp-Source: AGHT+IGYMLImfoxQBYcmL9wKShOb6mq/XlRPt96q7uM3Mj6gd2YK5yWb0PhEwbeGiOODSSKCcfAwbF30cwdZSK6wSec=
X-Received: by 2002:a05:6122:200a:b0:521:b3ee:4970 with SMTP id
 71dfb90a1353d-5279ab559cdmr2141808e0c.2.1744101756103; Tue, 08 Apr 2025
 01:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250407074800.1651203-1-nsaxena@marvell.com>
 <CAJFAV8wW5GFzGHJpSM4dcfys54=PD+RfWCr7AsbUqZqf0RZhQg@mail.gmail.com>
In-Reply-To: <CAJFAV8wW5GFzGHJpSM4dcfys54=PD+RfWCr7AsbUqZqf0RZhQg@mail.gmail.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Tue, 8 Apr 2025 14:12:24 +0530
X-Gm-Features: ATxdqUHQaSoDQ6YznHFfaRR-lxvFNeXwGAFrCOy74Kd-MMHgE9VihAqaWATkY-8
Message-ID: <CAG6-93wK6YbQC=TvNm_MTHJ4Cbk_PJmvLyr_8fP+DmvoSu=2GA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] node: add mbuf dynamic field for nodes
To: David Marchand <david.marchand@redhat.com>
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

Hi David,

Thanks,
Nitin

On Tue, Apr 8, 2025 at 1:05=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> Hello Nitin,
>
> On Mon, Apr 7, 2025 at 9:48=E2=80=AFAM Nitin Saxena <nsaxena@marvell.com>=
 wrote:
> >
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
> > Overloadable fields are those which can be overloaded by two adjacent
> > nodes. Overloadable fields can be repurposed by other two adjacent node=
s.
> >
> > This patch series also updates ip4/ip6 lookup/rewrite nodes to use
> > overlaodable mbuf dynamic fields.
> >
> > Changes in v4
> > - Fix github CI
> >
> > Changes in v3:
> > - Fix CI build error
> >
> > Changes in v2:
> > - removed usage of memzone for saving mbuf dynfield [Stephen]
> > - fixed checkpatch issues
> > - redefine RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE to 8 byte which are
> >   currently in use. Size can increase later based on the usage
> >
> >
> > Nitin Saxena (2):
> >   node: add global node mbuf dynfield
> >   node: use node mbuf dynfield in ip4 nodes
> >
> >  doc/api/doxy-api-index.md              |   3 +-
> >  doc/guides/rel_notes/release_25_07.rst |   6 ++
> >  lib/node/ip4_lookup.c                  |  14 +--
> >  lib/node/ip4_rewrite.c                 |  15 ++-
> >  lib/node/ip6_lookup.c                  |  15 ++-
> >  lib/node/ip6_rewrite.c                 |  14 +--
> >  lib/node/meson.build                   |   2 +
> >  lib/node/node_mbuf_dynfield.c          |  44 ++++++++
> >  lib/node/node_private.h                |  40 +------
> >  lib/node/rte_node_mbuf_dynfield.h      | 141 +++++++++++++++++++++++++
> >  lib/node/version.map                   |   3 +
>
> I did not review this series but I noticed some version.map update.
>
> When pulling main, you'll notice that exporting symbols must be done
> via RTE_EXPORT_*SYMBOL macros now.
> No version.map touching anymore, those files are generated at build
> time, so developers don't need to care about them.
>
> In lib/node/node_mbuf_dynfield.c, you need to include eal_export.h and ad=
d:
>
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register, 25.07)
> +int rte_node_mbuf_dynfield_register(void)
> +{
> ...

Will do these changes in the next patchset. Thanks for letting me know

>
>
> --
> David Marchand
>
