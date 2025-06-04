Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9526FC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:50:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADAFE42E68;
	Wed,  4 Jun 2025 17:50:42 +0200 (CEST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) by mails.dpdk.org (Postfix) with ESMTP id 98D2042DF1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:50:40 +0200 (CEST)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-4e45ece38cdso744223137.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749052240; x=1749657040; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JJggeB8UpZrZ3/IuyrScIUWO7HTnthliHh3jcj+uag=;
 b=U6TJxoD5WrQp74/UbxTz9O+d+f+JtGNSyrJkqR61DRJBBuywASSwsb0c3mDtLafKl4
 yLIJjHEEaPt5xEu/InE5ffIYMID/7pWvqogpZ6XzeBOnRJVBqX5wwVlbm1tISs3dW8pd
 odnoL+MzZEwLJ7ywt+OZJTUkDVV0wVqgMHys1hAHEwR0BZsDqnLkvWjaqCIo8+A6QWDK
 gAityl/a90L4K62QfznWg5x95tVI+OzEnscGXhCU3xi9E6uXQfMua4FUsRIUF+DqNtEI
 44Ea8VkDa4BIX5Ip3H/edzSkr6Gh2DRPdRxcuuHefRfQidTpuXmKtQ5n1oYFJugdxULs
 VLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052240; x=1749657040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JJggeB8UpZrZ3/IuyrScIUWO7HTnthliHh3jcj+uag=;
 b=CQkY5RSDDvLNmlg/VrLXD+Y98RVUefEXrIJ6SWKBSYjmyDHIlkAP9L5WBK7xYbnXJL
 VNxUK0+vKy5y5xo+My6HTE22f6mPx/inVvAtA2r7voCt3X20r7dEub+mY3BlewTO9ZCx
 NegbVVHPXyjhkoqaG52y2/eY+VAlh2kR6L3J3eW9+KRlxpBfiDZj/CZTQxfKFabpCVi3
 2HMeoZdsFBzB+fif5vgU583JH6HoD0BqLyZdOaeqjJl/W6/j5FooyZWdnUiJOZAX4Ry2
 08clwmAU5mepfqk07G/AgnWzPPAVRVgF6RBAM3LMm3iLK2Y6QzLOtvsB4J1F7byapuC1
 OvWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbgVAj1m2HPskvT0JRyWheexX7qzfDBKfh+IeF4yYZNKEOLizsZJS6smJfZI3bdERohlY=@dpdk.org
X-Gm-Message-State: AOJu0YyRfaxPf9GOx8FFI6r3abKEhvLD0pSDxuGzkk5w9W73Iv869GT9
 XRnRdDgERQf9nXrYU3UqlhmQkQCLwd9Kt3EIPvwTJPZgsspMfhp4RrX2PolISXu+RZ6KGWYTXQ0
 kVe9UNsu3pyEkc+jQdk0LM5YIlUkvB8Q=
X-Gm-Gg: ASbGncsIzMAqcix8nEuUxuNt+5iT4llnm3dNlRnHEWQ21JnJV2IruncrBd5YQZ2ucNo
 h07F/Uj67CKGC8Hz6ESKvq/hHhwA4jyBFSqohx2thCfUpoTaNR2AvBSiHgPaTzEpbQa3czvkZcs
 C2/PLCaxlFAdWofUIoPQBwoE6fsyqGNYJeN/3pKa9KvQ==
X-Google-Smtp-Source: AGHT+IFQrMn+ss2iKQT5mFtVKz9GbQOuyQkqDsuCjMlx5//JRIZFa4ywseGZlibjMfCLbNjN6BriOQOdReZSi7hZD+I=
X-Received: by 2002:a05:6102:c14:b0:4e5:8d83:c50e with SMTP id
 ada2fe7eead31-4e758bcac31mr31496137.10.1749052239889; Wed, 04 Jun 2025
 08:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-4-nsaxena@marvell.com>
 <DM3PPF17CE793ABE46D170841F018BCE2E1AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
In-Reply-To: <DM3PPF17CE793ABE46D170841F018BCE2E1AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 4 Jun 2025 21:20:28 +0530
X-Gm-Features: AX0GCFvWinF-9mSA3YSyskVvZnBy2Jz2jcd0a55c_4MdbNp6eTw2kI6sJoswX_g
Message-ID: <CAG6-93yDuhTaQtxE3nwh7KNCygCyPLJaR3WPEom-ai8NVafRsQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] graph: add feature arc init APIs
To: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Cc: Nitin Saxena <nsaxena@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>
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

Hi Kiran,


On Wed, Jun 4, 2025 at 4:54=E2=80=AFPM Kiran Kumar Kokkilagadda
<kirankumark@marvell.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Nitin Saxena <nsaxena@marvell.com>
> > Sent: Wednesday, June 4, 2025 3:43 PM
> > To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> > <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> > <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> > Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> > Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> > Subject: [PATCH v10 3/7] graph: add feature arc init APIs
> >
> > This patch adds feature arc init()/create()/destroy() APIs. It also add
> > APIs for adding feature node to an arc.
> >
> > Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> > ---
> >  doc/api/doxy-api-index.md                |    1 +
> >  doc/guides/prog_guide/graph_lib.rst      |   23 +-
> >  lib/graph/graph_feature_arc.c            | 1329 +++++++++++++++++++++-
> >  lib/graph/graph_private.h                |    4 +
> >  lib/graph/meson.build                    |    2 +-
> >  lib/graph/rte_graph_feature_arc.h        |  248 +++-
> >  lib/graph/rte_graph_feature_arc_worker.h |  303 +++++
> >  7 files changed, 1902 insertions(+), 8 deletions(-)
> >  create mode 100644 lib/graph/rte_graph_feature_arc_worker.h
> >
> > diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> > index a7bdbf892c..6d8b531344 100644
> > --- a/doc/api/doxy-api-index.md
> > +++ b/doc/api/doxy-api-index.md
> > @@ -215,6 +215,7 @@ The public API headers are grouped by topics:
> >    * [graph](@ref rte_graph.h):
> >      [graph_worker](@ref rte_graph_worker.h)
> >      [graph_feature_arc](@ref rte_graph_feature_arc.h)
> > +    [graph_feature_arc_worker](@ref rte_graph_feature_arc_worker.h)
> >    * graph_nodes:
> >      [eth_node](@ref rte_node_eth_api.h),
> >      [ip4_node](@ref rte_node_ip4_api.h),
> > diff --git a/doc/guides/prog_guide/graph_lib.rst
> > b/doc/guides/prog_guide/graph_lib.rst
> > index 191c8e8a0b..c9ac9e7ae0 100644
> > --- a/doc/guides/prog_guide/graph_lib.rst
> > +++ b/doc/guides/prog_guide/graph_lib.rst
> > @@ -815,7 +815,7 @@ added to existing arc as follows:
> >              ...
> >              ...
> >              ...
> > -        .override_index_cb =3D Feature-3_override_index_cb(),
> > +        .override_index_cb =3D Feature-2_override_index_cb(),
> >          .runs_after =3D "Feature-1",
> >          .runs_before =3D "Custom-Feature",
> >      };
> > @@ -848,3 +848,24 @@ this callback. In case of multiple features, large=
st
> > value returned by any
> >  feature would be selected for creating feature arc.
> >
> >  .. _Feature_Arc_Initialization:
> > +
> > +Initializing Feature arc
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> > +Following code shows how to initialize feature arc sub-system.
> > +``rte_graph_feature_arc_init()`` API is used to initialize a feature a=
rc
> > +sub-system. If not called, feature arc has no impact on application.
> > +
> > +.. code-block:: c
> > +
> > +    struct rte_graph_param *graph_param =3D app_get_graph_param();
> > +
> > +    /* Initialize feature arc before graph create */
> > +    rte_graph_feature_arc_init(0);
> > +
> > +    rte_graph_create(graph_param);
> > +
> > +.. note::
> > +
> > +   ``rte_graph_feature_arc_init()`` API should be called before
> > +   ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
> > +   application.
> > diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_ar=
c.c
> > index 6135b262d5..b28f0ec321 100644
> > --- a/lib/graph/graph_feature_arc.c
> > +++ b/lib/graph/graph_feature_arc.c
> > @@ -2,10 +2,57 @@
> >   * Copyright(C) 2025 Marvell International Ltd.
> >   */
> >
> > -#include <rte_graph_feature_arc.h>
> > +#include <rte_graph_feature_arc_worker.h>
> > +#include <rte_malloc.h>
> > +#include <rte_string_fns.h>
> >  #include <eal_export.h>
> >  #include "graph_private.h"
> >
> > +#define GRAPH_FEATURE_MAX_NUM_PER_ARC  (64)
> > +
> > +#define connect_graph_nodes(node1, node2, edge, arc_name) \
> > +     __connect_graph_nodes(node1, node2, edge, arc_name, __LINE__)
> > +
> > +#define FEATURE_ARC_MEMZONE_NAME "__rte_feature_arc_main_mz"
> > +
> > +#define NUM_EXTRA_FEATURE_DATA   (2)
> > +
> > +#define graph_uint_cast(f)           ((unsigned int)f)
>
> Not used anywhere in the patch.

It is getting used in enable/disable APIs. I have moved this macro to
another patch where it is being used

<snip>
