Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADADC36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 10:42:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD3554065B;
	Mon, 28 Apr 2025 12:42:21 +0200 (CEST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9BC944021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 12:42:19 +0200 (CEST)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-525da75d902so1766921e0c.3
 for <dev@dpdk.org>; Mon, 28 Apr 2025 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745836939; x=1746441739; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyrI6TVX1RQVi5Yw6yOspQ3uJTP09ExK3bnXaT3ut0c=;
 b=PH84J635dL7LBklpqdO6A5zD6QfUxQTJTr4vlox2klBPIufS5pjgq0rl8WMKTT7Idg
 NZD9jcyCptTf5QSG8GGO8NAHETydQLpoEEm+zJtwiU0sRXuWm7u7RTaCgT+oXY8sEttb
 M3bqa3Iwh0hBNErP+9c5t6n44J72o97Si8hEdlU1wnIUL4Sa9b8R6/+3b3HHgAu+BN1u
 juwdC0XRRFRzVz1qpKMEaS9rOiwdod7bje922+u3LjVfWIUC+PwGwVEIMENAD4cZPwNo
 QNt4yVN9LsFJq8n/W+FavtK8asISsi0ld41Z8nj8sceev/pcohDkww7UGWUljzbZhciH
 KYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745836939; x=1746441739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyrI6TVX1RQVi5Yw6yOspQ3uJTP09ExK3bnXaT3ut0c=;
 b=Ta8jWz4O1llTIFD7tdyR0TyzZjqpcilU5xDO00Te+C01VSG3BK99t06hOyVUG2ZDm+
 vz78CCimed/mi+x9RgYSdYYDRba+eTRqPgW/qioMpSN0tRzD/4kgflW9eNf8raFcQ8Rq
 pYlXKVfY+TW8Pzok+e0o1w5UfW3z+V/lCeclN+axt9JP2dNFxVEoxB2YORcoAmhzhbdZ
 ys8jGvtPPtg1/oyCLdEcedtIiMZ9pfX4gOFlc7+DadtNeHnDPgLRT0Qhq0mI5UQfGjTr
 IKiJ3Oqu1fGXOJ/DdXoCf3u4kG+SXJLBdPB2Bx4YRXcRXgCm1Ry7FUIk/BW2nhP3Xayh
 BcwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xYf5erMQsm4nO+Oi3JMc+1Ufz8MBgCG/hx4Yr1tq+pyPRgIsRPxie4AGuYrewvsxkKs=@dpdk.org
X-Gm-Message-State: AOJu0YxZj8PZv9HVWUIw5QFxq/SoQ0otcWJW7WMzMgVoam2iHdut9xc8
 MWZQlTJpd9+ZkhOsQz/7VZPnmCK2PjFCCZkzxevNNhWAkKoC0WQOGhih/Www/wUuU+pMSvrDi8p
 QYvmGOu2d2S8ySmK7olNIXpQ1nTI=
X-Gm-Gg: ASbGncsv8vQDs8SME9AF56uMRostFafcBIPy72Cth5wxHX7mxZ0PjYiHVI+YDTUslTJ
 ZTmvPE9dz4YC4xFUW3Z43v3Epea3AsLD+uDB04Bxalutk36foapsjTUat5zMJwtb393qwi9Ethm
 JuSsG6QtsynwQPdc9BLid/3Zo=
X-Google-Smtp-Source: AGHT+IEXhi7PDRm0k7HbxrHxiaPOQB4H18pX8MH0FtA2Ucy78q8EVlQtsDsb2QQ0o8NAA7ha0DkNQOsDzQGk5lU103M=
X-Received: by 2002:a05:6122:250f:b0:528:4f4b:f0c0 with SMTP id
 71dfb90a1353d-52a89de1270mr6929366e0c.5.1745836938759; Mon, 28 Apr 2025
 03:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250409135554.2180390-1-nsaxena@marvell.com>
 <20250409135554.2180390-2-nsaxena@marvell.com>
 <CO6PR18MB4084AB7880F9D37F0862C636DEBF2@CO6PR18MB4084.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4084AB7880F9D37F0862C636DEBF2@CO6PR18MB4084.namprd18.prod.outlook.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Mon, 28 Apr 2025 16:12:06 +0530
X-Gm-Features: ATxdqUEFYnvXBLp45BAuyfUf5D6hsN2Q0vPgXrUurvzXpRq88eys2fqabbbqLIk
Message-ID: <CAG6-93w02cgBK9m42XVz_t7VDnyemw0CZfwz=0+MR8vATMNukw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] node: add global node mbuf dynfield
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Nitin Saxena <nsaxena@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
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

Hi Pavan,

I have incorporated your comments in patch 6
Thanks for reviewing

Nitin

On Sat, Apr 19, 2025 at 12:33=E2=80=AFAM Pavan Nikhilesh Bhagavatula
<pbhagavatula@marvell.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Nitin Saxena <nsaxena@marvell.com>
> > Sent: Wednesday, April 9, 2025 7:26 PM
> > To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> > Bhagavatula <pbhagavatula@marvell.com>; Robin Jarry
> > <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> > Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Nitin Saxena
> > <nsaxena16@gmail.com>
> > Subject: [PATCH v5 1/2] node: add global node mbuf dynfield
> >
> > This patch defines rte_node specific dynamic field structure
> > (rte_node_mbuf_dynfield_t)
> >
> > rte_node_mbuf_dynfield_t structure holds two types of fields
> > - Persistent data fields which are preserved across graph walk.
> >   Currently size of persistent data fields is zero.
> > - Overloadable data fields which are used by any two adjacent nodes.
> >   Same fields can be repurposed by any other adjacent nodes
> >
> > This dynfield can be also be used by out-of-tree nodes.
> >
> > Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> > ---
> >  doc/api/doxy-api-index.md              |   3 +-
> >  doc/guides/rel_notes/release_25_07.rst |   6 ++
> >  lib/node/meson.build                   |   2 +
> >  lib/node/node_mbuf_dynfield.c          |  57 +++++++++++
> >  lib/node/rte_node_mbuf_dynfield.h      | 132
> > +++++++++++++++++++++++++
> >  5 files changed, 199 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/node/node_mbuf_dynfield.c
> >  create mode 100644 lib/node/rte_node_mbuf_dynfield.h
> >
> > diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> > index 5c425a2cb9..763cfb3f3c 100644
> > --- a/doc/api/doxy-api-index.md
> > +++ b/doc/api/doxy-api-index.md
> > @@ -219,7 +219,8 @@ The public API headers are grouped by topics:
> >      [ip4_node](@ref rte_node_ip4_api.h),
> >      [ip6_node](@ref rte_node_ip6_api.h),
> >      [udp4_input_node](@ref rte_node_udp4_input_api.h)
> > -
> > +  * graph_nodes_mbuf:
> > +    [node_mbuf_dynfield](@ref rte_node_mbuf_dynfield.h)
>
> Missing blank line here.
Done

>
> >  - **basic**:
> >    [bitops](@ref rte_bitops.h),
> >    [approx fraction](@ref rte_approx.h),
> > diff --git a/doc/guides/rel_notes/release_25_07.rst
> > b/doc/guides/rel_notes/release_25_07.rst
> > index 093b85d206..2dc888e65d 100644
> > --- a/doc/guides/rel_notes/release_25_07.rst
> > +++ b/doc/guides/rel_notes/release_25_07.rst
> > @@ -55,6 +55,12 @@ New Features
> >       Also, make sure to start the actual text at the margin.
> >       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +* **Added rte_node specific global mbuf dynamic field.**
> > +
> > +  Instead each node registering mbuf dynamic field for its own purpose=
, a
> > +  global structure is added which can be used/overloaded by all nodes
> > +  (including out-of-tree nodes). This minimizes footprint of node spec=
ific
> > mbuf
> > +  dynamic field.
> >
> >  Removed Items
> >  -------------
> > diff --git a/lib/node/meson.build b/lib/node/meson.build
> > index 0bed97a96c..152fe41129 100644
> > --- a/lib/node/meson.build
> > +++ b/lib/node/meson.build
> > @@ -8,6 +8,7 @@ if is_windows
> >  endif
> >
> >  sources =3D files(
> > +        'node_mbuf_dynfield.c',
> >          'ethdev_ctrl.c',
> >          'ethdev_rx.c',
> >          'ethdev_tx.c',
> > @@ -30,6 +31,7 @@ headers =3D files(
> >          'rte_node_ip4_api.h',
> >          'rte_node_ip6_api.h',
> >          'rte_node_udp4_input_api.h',
> > +        'rte_node_mbuf_dynfield.h',
> >  )
> >
> >  # Strict-aliasing rules are violated by uint8_t[] to context size cast=
s.
> > diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfiel=
d.c
> > new file mode 100644
> > index 0000000000..6005e72ed6
> > --- /dev/null
> > +++ b/lib/node/node_mbuf_dynfield.c
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +#include <rte_memzone.h>
> > +#include <rte_node_mbuf_dynfield.h>
> > +#include <node_private.h>
> > +#include <eal_export.h>
> > +
> > +#define NODE_MBUF_DYNFIELD_MEMZONE_NAME
> > "__rte_node_mbuf_dynfield"
> > +
> > +struct node_mbuf_dynfield_mz {
> > +     int dynfield_offset;
> > +};
> > +
> > +static const struct rte_mbuf_dynfield node_mbuf_dynfield_desc =3D {
> > +     .name =3D "rte_node_mbuf_dynfield",
> > +     .size =3D sizeof(rte_node_mbuf_dynfield_t),
> > +     .align =3D alignof(rte_node_mbuf_dynfield_t),
> > +};
> > +
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register,
> > 25.07);
> > +int rte_node_mbuf_dynfield_register(void)
> > +{
> > +     struct node_mbuf_dynfield_mz *f =3D NULL;
> > +     const struct rte_memzone *mz =3D NULL;
> > +     int dyn_offset;
> > +
> > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) <
> > RTE_NODE_MBUF_DYNFIELD_SIZE);
> > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> > +                      RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> > +
> > +     mz =3D
> > rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
> > +
> > +     if (!mz) {
> > +             mz =3D
> > rte_memzone_reserve_aligned(NODE_MBUF_DYNFIELD_MEMZONE_NAME,
> > +                                              sizeof(struct
> > node_mbuf_dynfield_mz),
> > +                                              SOCKET_ID_ANY, 0,
> > +                                              RTE_CACHE_LINE_SIZE);
> > +             if (!mz) {
> > +                     node_err("node_mbuf_dyn",
> > "rte_memzone_reserve_aligned failed");
> > +                     return -1;
>
> Please return proper error codes, or set rte_errno.
Done

>
> > +             }
> > +             dyn_offset =3D
> > rte_mbuf_dynfield_register(&node_mbuf_dynfield_desc);
> > +             if (dyn_offset < 0) {
> > +                     node_err("node_mbuf_dyn",
> > "rte_mbuf_dynfield_register failed");
> > +                     return -1;
>
> Please return proper error codes, or set rte_errno.
Done

>
> > +             }
> > +             f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> > +             f->dynfield_offset =3D dyn_offset;
> > +
> > +             node_dbg("node_mbuf_dyn", "memzone: %s of size: %zu at
> > offset : %d",
> > +                      mz->name, mz->len, f->dynfield_offset);
> > +     } else {
> > +             f =3D (struct node_mbuf_dynfield_mz *)mz->addr;
> > +     }
> > +     return f->dynfield_offset;
> > +}
> > diff --git a/lib/node/rte_node_mbuf_dynfield.h
> > b/lib/node/rte_node_mbuf_dynfield.h
> > new file mode 100644
> > index 0000000000..b5a3d6db3f
> > --- /dev/null
> > +++ b/lib/node/rte_node_mbuf_dynfield.h
> > @@ -0,0 +1,132 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +
> > +#ifndef _RTE_GRAPH_MBUF_DYNFIELD_H_
> > +#define _RTE_GRAPH_MBUF_DYNFIELD_H_
> > +
> > +#include <rte_common.h>
> > +#include <rte_mbuf.h>
> > +#include <rte_mbuf_dyn.h>
> > +
> > +/**
> > + * @file: rte_node_mbuf_dynfield.h
> > + *
>
> Please mark the file as experimental
> i.e.,
>  * @warning
>  * @b EXPERIMENTAL:
Done

>
> > + * Defines rte_node specific mbuf dynamic field region
> > [rte_node_mbuf_dynfield_t] which
> > + * can used by both DPDK in-built and out-of-tree nodes for storing pe=
r-mbuf
> > + * fields for graph walk
> > + */
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/** Size of persistent mbuf fields */
> > +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> > +/** Size of overloadable mbuf fields */
> > +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> > +/** Size of node mbuf dynamic field */
> > +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> > +     (RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE +
> > RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE)
>
> New line here.
Done

>
> > +/**
> > + * Node mbuf overloadable data.
> > + *
> > + * Out-of-tree nodes can repurpose overloadable fields via
> > + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are no=
t
> > + * preserved and typically can be used with-in two adjacent nodes in t=
he
> > graph.
> > + */
> > +typedef struct rte_node_mbuf_overload_fields {
> > +     union {
> > +             uint8_t
> > data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> > +     };
> > +} rte_node_mbuf_overload_fields_t;
> > +
> > +/**
> > + * rte_node specific mbuf dynamic field structure
> > [rte_node_mbuf_dynfield_t]
> > + *
> > + * It holds two types of fields:
> > + * 1. Persistent fields: Fields which are preserved across nodes durin=
g graph
> > walk.
> > + *    - Eg: rx/tx interface etc
> > + * 2. Overloadable fields: Fields which can be repurposed by two adjac=
ent
> > nodes.
> > + */
> > +typedef struct rte_node_mbuf_dynfield {
> > +     /**
> > +      * Persistent mbuf region across nodes in graph walk
> > +      *
> > +      * These fields are preserved across graph walk and can be access=
ed by
> > +      * rte_node_mbuf_dynfield_get() in fast path.
> > +      */
> > +     union {
> > +             uint8_t
> > persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
> > +     };
> > +
> > +     /**
> > +      * Overloadable mbuf fields across graph walk. Fields which can
> > change
> > +      *
> > +      * Two adjacent nodes (producer, consumer) can use this memory
> > region for
> > +      * sharing per-mbuf specific information. Once mbuf leaves a
> > consumer node,
> > +      * this region can be repurposed by another sets of [producer,
> > consumer] node.
> > +      *
> > +      * In fast path, this region can be accessed by
> > rte_node_mbuf_overload_fields_get()
> > +      */
> > +     rte_node_mbuf_overload_fields_t overloadable_data;
> > +} rte_node_mbuf_dynfield_t;
> > +
> > +/**
> > + * For a given mbuf and dynamic offset, return pointer to
> > rte_node_mbuf_dynfield_t *
> > + *
> > + * @param m
> > + *   Mbuf
> > + * @param offset
> > + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
>
> Missing return field in doxygen.
Done

>
> > + */
> > +__rte_experimental
> > +static __rte_always_inline rte_node_mbuf_dynfield_t *
> > +rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
> > +{
> > +     return RTE_MBUF_DYNFIELD(m, offset, struct
> > rte_node_mbuf_dynfield *);
> > +}
> > +
> > +/**
> > + * For a given mbuf and dynamic offset, return pointer to overloadable=
 fields
> > + * Nodes can typecast returned pointer to reuse for their own purpose
> > + *
> > + * @param m
> > + *   Mbuf
> > + * @param offset
> > + *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
>
> Missing return field.
Done

>
> > + */
> > +__rte_experimental
> > +static __rte_always_inline rte_node_mbuf_overload_fields_t *
> > +rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset=
)
> > +{
> > +     struct rte_node_mbuf_dynfield *f =3D NULL;
>
> rte_node_mbuf_dynfield_t
Done

>
> > +
> > +     f =3D RTE_MBUF_DYNFIELD(m, offset, struct rte_node_mbuf_dynfield
> > *);
>
> rte_node_mbuf_dynfield_t
Done

>
> > +
> > +     return &(f->overloadable_data);
> > +}
> > +
> > +/**
> > + *  Register rte_node specific common mbuf dynamic field region. Can b=
e
> > called
> > + *  in rte_node_register()->init() function to save offset in node->ct=
x
> > + *
> > + *  In process() function, node->ctx can be passed to
> > + *  - rte_node_mbuf_dynfield_get(mbuf, offset)
> > + *  - rte_node_mbuf_overload_fields_get(mbuf, offset)
> > + *
> > + *  Can be called multiple times by any number of nodes in init() func=
tion.
> > + *  - Very first call registers dynamic field and returns offset
> > + *  - Subsequent calls return same offset
> > + *
> > + *  @return
> > + *   -1 on error
>
> < 0 on error.
> Please return and document proper error codes.
>
Done

> > + *   dynamic field offset on success
> > + */
> > +__rte_experimental
> > +int rte_node_mbuf_dynfield_register(void);
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif
> > --
> > 2.43.0
>
