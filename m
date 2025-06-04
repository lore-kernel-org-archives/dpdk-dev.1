Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0574FC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2930642E68;
	Wed,  4 Jun 2025 17:59:16 +0200 (CEST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) by mails.dpdk.org (Postfix) with ESMTP id 3898842DF1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:59:14 +0200 (CEST)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-4dfa2aeec86so2947904137.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749052753; x=1749657553; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVSttnZZtscZZEEGScba1TxZU1ITFGMuyj4TfsXyB9Y=;
 b=AR1NLIQ7hwLEpbkpaCRVEbnhGHWFPGELWQgMOu8Sq5LNT+VdLRa/uLTgm2IfDCvZSJ
 0NzcwF2LXB560VKPdVgHkccjxNr9sBXJqwcKpIHfQVauvghF9/stDOvDR/vntIIe1QUV
 QqDvLXT/74cs/o8/YTzijjY6nCRpHhT7+X/6AXaVAulxbGInF7ljgaYENGEQfVpEvtGW
 qBmL4JfflAUJTm23rq6RMMexgXe2CHfqLtHZHW8uHBydJYqBpCqcIcmG7QC+Wf/Cq8EC
 9Sq5P9hVFLaDrQOE8stGCTlxG+pWYg1Z/bTNvO+crdn6ef7HIC3bvEs1KjTDK4P61LMo
 yDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052753; x=1749657553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVSttnZZtscZZEEGScba1TxZU1ITFGMuyj4TfsXyB9Y=;
 b=V2bwHFRHTttIhJxEb2HcheuGP4VkgBRfdwM1UDJqIJEcZLqwBvah14/qeePda/6gyC
 Fzu9y62EMDvWagfm5C784WGibyRZa00+c/pms+9QNbokFxMYqLAIJ/st7w25UPrBR+NI
 Ok7AzR9tJRhie+D9UXwXfexEl/GeqxAgvCKyEXkWf0imgE+vz7yY237H5GHJxGzxGknk
 5LPncEjfwf9wkLzeSJIAbugYTXKZ3FxYiewoxqxnNG6Jzh/KL0nUsZmdhubLYcVi12Ra
 asHhS9FINrssQrnZGN+Imf89Lz2RBirqdi87556WWdP/+/8MwfmQV71HSHtMwppDTEKO
 JQdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9B+WthZPOlYtEjNCaqrCAr0A9lbP3o8JkEWEcWUKQNaAVFsYhsQBS8ch9leBBY/36SeM=@dpdk.org
X-Gm-Message-State: AOJu0Yxj+Y4mPG8RuG9YmmhjlPTurguj8Pg1TkMFCtm1auBUh8Qm3ft9
 3JOT5wjcducGMjvlH0EbIj6l64TeTNXUb8xAokftuvJr+j263cq2Zd0Vhs/FAqy9Lw5pWdIsAfV
 BLqp40gYswfDxVxapOR4Axc+JtHxovlI=
X-Gm-Gg: ASbGncuvY5r/uW12jNnLCfO+fpMmAgOCVGj05E5aABo597GuO7H9nX56k425HbYp1CB
 UH5ee/9hmtwAxygSEFmJHcMzvjNKa1okY2mg2AP8hIsvp/LMD4ewmStcmhDxnsRZ+WTtLYmK9xy
 dcHKdS6p06hDZ18LWMb+dcG3dAYnQHXyE=
X-Google-Smtp-Source: AGHT+IF/kbRLDy13Zly1dqCR+RwXgp31YLExlnDq4LPLpb17tsT/cdPChis3Moni8yORWMHehM5fBuG4OTu9TZqyzoo=
X-Received: by 2002:a05:6102:3c94:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4e746de3494mr2658462137.12.1749052753344; Wed, 04 Jun 2025
 08:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-3-nsaxena@marvell.com>
 <BY3PR18MB4785A878550F3A7524A0BC22C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4785A878550F3A7524A0BC22C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 4 Jun 2025 21:29:00 +0530
X-Gm-Features: AX0GCFsVXzf3W3aYid2b36dsYxTvrrk7hk6LAIqqM7dmxImiWn7du5-8cyfC23Q
Message-ID: <CAG6-93z=Wf-33uwWm-izcVK+mBWzUnhu_irR=QfvtcoH477DiA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] graph: add feature arc abstraction
To: Jerin Jacob <jerinj@marvell.com>
Cc: Nitin Saxena <nsaxena@marvell.com>,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, 
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

Hi Jerin,

I have fixed all your comments in the v10 patchset.

Thanks,
Nitin

On Fri, May 30, 2025 at 6:39=E2=80=AFPM Jerin Jacob <jerinj@marvell.com> wr=
ote:
>
>
> > -----Original Message-----
> > From: Nitin Saxena <nsaxena@marvell.com>
> > Sent: Monday, April 21, 2025 8:47 PM
> > To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> > <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> > <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> > Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> > Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> > Subject: [PATCH v9 2/5] graph: add feature arc abstraction
> >
> > Feature arc abstraction allows rte_graph based applications to
> > - Allow control plane to runtime enable/disable feature nodes.
> >   Fast path APIs helps to steer packets across enabled feature nodes
> > - Feature enable/disable based on indexes. Index can be interface index=
,
> >   route index, etc
> > - More than one feature nodes can be added to an arc and also provide
> >   mechanism to control features sequencing order in fast path.
> > - Does not require stopping of workers for control plane updates. RCU
> >   mechanism also provided
> > - Once DPDK inbuilt nodes adopts feature arc abstraction, out-of-tree
> >   nodes can also be hooked (with no custom changes in DPDK in-built
> >   nodes)
> >
> > Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> > ---
> >  doc/api/doxy-api-index.md                |    2 +
>
> Programming guide is missing. Also, mention this feature is optional in t=
he guide

Done in v10
>
>
>
> >       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +* **Added feature arc abstraction in graph library.**
> > +
> > +  Feature arc abstraction helps ``rte_graph`` based applications to st=
eer
> > +  packets across different node path(s) based on the features (or prot=
ocols)
> > +  enabled on interfaces. Different feature node paths can be enabled/d=
isabled
> > +  at runtime on some or on all interfaces. This abstraction also help
> > +  applications to hook ``out-of-tree nodes`` in DPDK in-built node pat=
hs in a
> > +  generic manner.
> > +
> > +  * Added ``ip4_output`` feature arc processing in ``ip4_rewrite`` nod=
e.
>
> Move the doc changes related to node to the relevant patch.

Done in v10
>
>
> >
> >  Removed Items
> >  -------------
> > diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_ar=
c.c
> > new file mode 100644
> > index 0000000000..1c94246f4a
> > --- /dev/null
> > +++ b/lib/graph/graph_feature_arc.c
> > @@ -0,0 +1,2050 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +
> > +#include "graph_private.h"
>
> Move private headers file after public ones

Done in v10
>
>
> > diff --git a/lib/graph/meson.build b/lib/graph/meson.build
> > index 0cb15442ab..5d137d326e 100644
> > --- a/lib/graph/meson.build
> > +++ b/lib/graph/meson.build
> > @@ -15,14 +15,16 @@ sources =3D files(
> >          'graph_stats.c',
> >          'graph_populate.c',
> >          'graph_pcap.c',
> > +        'graph_feature_arc.c',
> >          'rte_graph_worker.c',
> >          'rte_graph_model_mcore_dispatch.c',
> >  )
> >  headers =3D files('rte_graph.h', 'rte_graph_worker.h')
> > +headers +=3D files('rte_graph_feature_arc.h', 'rte_graph_feature_arc_w=
orker.h')
> >  indirect_headers +=3D files(
> >          'rte_graph_model_mcore_dispatch.h',
> >          'rte_graph_model_rtc.h',
> >          'rte_graph_worker_common.h',
> >  )
> >
> > -deps +=3D ['eal', 'pcapng', 'mempool', 'ring']
> > +deps +=3D ['eal', 'pcapng', 'mempool', 'ring', 'rcu']
> > diff --git a/lib/graph/rte_graph_feature_arc.h
> > b/lib/graph/rte_graph_feature_arc.h
> > new file mode 100644
> > index 0000000000..d603063def
> > --- /dev/null
> > +++ b/lib/graph/rte_graph_feature_arc.h
> > @@ -0,0 +1,634 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +
> > +#ifndef _RTE_GRAPH_FEATURE_ARC_H_
> > +#define _RTE_GRAPH_FEATURE_ARC_H_
> > +
> > +#include <assert.h>
> > +#include <errno.h>
> > +#include <signal.h>
> > +#include <stddef.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#include <rte_common.h>
> > +#include <rte_compat.h>
> > +#include <rte_debug.h>
> > +#include <rte_graph.h>
> > +#include <rte_rcu_qsbr.h>
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/**
> > + * @file
> > + *
> > + * rte_graph_feature_arc.h
> > + *
> > + * Define APIs and structures/variables with respect to feature arc
> > + *
> > + * - Feature arc(s)
> > + * - Feature(s)
> > + *
> > + * In a typical network stack, often a protocol must be first enabled =
in
> > + * control plane before any packet is steered for its processing in th=
e
> > + * dataplane. For eg: incoming IPv4 packets are routed only after a va=
lid IPv4
> > + * address is assigned to the received interface. In other words, ofte=
n packets
> > + * received on an interface need to be steered to protocol not based o=
n the
> > + * packet content but based on whether the protocol is configured on t=
he
> > + * interface or not.
> > + *
> > + * Protocols can be enabled/disabled multiple times at runtime in the =
control
> > + * plane. Protocols enabled on one interface may not be enabled on ano=
ther
> > + * interface.
> > + *
> > + * When more than one protocols are present at a networking layer (say=
 IPv4,
> > + * IPtables, IPsec etc), it becomes imperative to steer packets (in da=
taplane)
>
> IP tables ?

Done
>
> > + * across each protocol processing in a defined sequential order. In i=
ngress
> > + * direction, stack decides to perform IPsec decryption first before I=
P
> > + * validation while in egress direction IPsec encryption is performed =
after IP
> > + * forwarding. In the case of IPtables, users can enable rules in any
>
> IP tables
>
> > + * protocol order i.e. pre-routing or post-routing etc. This implies t=
hat
> > + * protocols are configured differently at each networking layer and i=
n each
> > + * traffic direction.
> > + *
> > + * A feature arc represents an ordered list of features/protocols node=
s at the
> > + * given networking layer and in a given direction. It provides a high=
 level
> > + * abstraction to enable/disable features on an index at runtime and p=
rovide a
> > + * mechanism to steer packets across these feature nodes in a generic =
manner.
> > + * Here index corresponds to either interface index, route index, flow=
 index or
> > + * classification index etc. as it is deemed suitable to configure pro=
tocols at
> > + * the networking layer. Some typical examples of protocols which are
> > + * configured based on
> > + *
> > + * - Interface Index (like IPv4 VRF, Port mirroring, Port based IPsec =
etc)
> > + * - Routes Index (like Route based IPsec etc)
> > + * - Flow index (like SDN)
> > + * - Classification Index (like ACL based protocol steering)
> > + *
> > + * Feature arc also provides a way to steer packets from in-built DPDK=
 *feature
> > + * nodes* to out-of-tree *feature nodes* and vice-versa without any co=
de
> > + * changes required in DPDK in-built node's fast path functions. This =
way it
> > + * allows application to override default packet path defined by in-bu=
ilt DPDK
> > + * nodes.
> > + *
> > + * Features enabled on one index may not be enabled on another index h=
ence
> > + * packets received on an interface "X" should be treated independentl=
y from
> > + * packets received on interface "Y".
> > + *
> > + * A given feature might consume packet (if it's configured to consume=
) or may
> > + * forward it to next enabled feature. For instance, "IPsec input" fea=
ture may
> > + * consume/drop all packets with "Protect" policy action while all pac=
kets with
> > + * policy action as "Bypass" may be forwarded to next enabled feature =
(with in
> > + * same feature arc)
> > + *
> > + * A feature arc in a graph is represented via *start_node* and *end_n=
ode*.
> > + * Feature nodes are added between start_node and end_node. Packets en=
ter
> > + * feature arc traversal via start_node while they exits from end_node=
. Packets
> > + * steering from start_node to feature nodes are controlled in control=
 plane
> > + * via rte_graph_feature_enable()/rte_graph_feature_disable().
> > + *
> > + * This library facilitates rte graph based applications to implement =
stack
> > + * functionaloties described above by providing "edge" to the next ena=
bled
>
>  functionalities

Done
>
> > + * feature node in fast path
> > + *
> > + * In order to use feature-arc APIs, applications needs to do followin=
g in
> > + * control plane:
> > + * - Create feature arc object using RTE_GRAPH_FEATURE_ARC_REGISTER()
> > + * - New feature nodes (In-built/Out-of-tree) can be added to an arc v=
ia
> > + *   RTE_GRAPH_FEATURE_REGISTER(). RTE_GRAPH_FEATURE_REGISTER() has
> > + *   "runs_after" and "runs_before" fields to specify protocol orderin=
g
> > + *   constraints.
> > + * - Before calling rte_graph_create(), rte_graph_feature_arc_init() A=
PI must
> > + *   be called. If rte_graph_feature_arc_init() is not called by appli=
cation,
> > + *   feature arc library has no affect.
> > + * - Features can be enabled/disabled on any index at runtime via
> > + *   rte_graph_feature_enable()/rte_graph_feature_disable()
> > + * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
> > + *
> > + * If a given feature likes to control number of indexes (which is hig=
her than
> > + * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
> > + * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
> > + * rte_graph_feature_arc_init(), all feature's override_index_cb(), if=
 set, are
> > + * called and with maximum value returned by any of the feature is use=
d for
> > + * rte_graph_feature_arc_create()
> > + *
> > + * Before enabling a feature, control plane might allocate certain res=
ources
> > + * (like VRF table for IP lookup or IPsec SA for inbound policy etc). =
A
> > + * reference of allocated resource can be passed from control plane to
> > + * dataplane via *app_cookie* argument in @ref rte_graph_feature_enabl=
e().
> > A
> > + * corresponding dataplane API @ref
> > rte_graph_feature_data_app_cookie_get() can
> > + * be used to retrieve same cookie in fast path.
> > + *
> > + * When a feature is disabled, resources allocated during feature enab=
le can be
> > + * safely released via registering a callback in
> > + * RTE_GRAPH_FEATURE_REGISTER::notifier_cb(). See fast path
> > synchronization
> > + * section below for more details.
> > + *
> > + * While *app_cookie* can be known corresponding to current feature no=
de
> > via
> > + * @ref rte_graph_feature_data_app_cookie_get(), however if current fe=
ature
> > + * node is not consuming packet it might want to send it to next enabl=
ed
> > + * feature using, it can do if current feature node is a:
> > + * - start_node (via @ref rte_graph_feature_data_first_feature_get())
> > + * - feature nodes added between start_node and end_node (via @ref
> > + *   rte_graph_feature_data_next_feature_get())
> > + * - end node (must not call any feature arc steering APIs) as from th=
is node
> > + *   packet exits feature arc
> > + *
> > + * Above APIs deals with fast path object: feature_data(struct
> > + * rte_graph_feature_data), which is unique for every index per featur=
e with in
> > + * a feature arc. It holds three data fields: next node edge, next ena=
bled
> > + * feature data and app_cookie.
> > + *
> > + * rte_mbuf carries [feature_data] into feature arc specific mbuf dyna=
mic
> > + * field
> > + *
> > + * Fast path synchronization
> > + * -------------------------
> > + * Any feature enable/disable in control plane does not require stoppi=
ng of
> > + * worker cores. rte_graph_feature_enable()/rte_graph_feature_disable(=
) APIs
> > + * are almost thread-safe avoiding any RCU usage. Only condition when =
race
> > + * condition could occur is when application is trying to enable/disab=
le
> > + * feature very fast for [feature, index] combination. In that case,
> > + * application should use rte_graph_feature_enable()/disable() APIs wi=
th RCU
> > + * argument
> > + *
> > + * RCU synchronization may also be required when application needs to =
free
> > + * resources (using RTE_GRAPH_FEATURE_REGISTER:notifier_cb()) which it
> > may have
> > + * allocated during feature enable. Resources can be freed only when n=
o
> > worker
> > + * core is not acting on it.
> > + *
> > + * If RCU argument to rte_graph_feature_enable()/disable() is non-NULL=
:
> > + *  - rte_rcu_qsbr_synchronize(rte_rcu_qsbr *) to synchronize all work=
er cores
> > + *  - Calls RTE_GRAPH_FEATURE_REGISTER()->notifier_cb((), if set, and =
helps
> > + *  application to safely release resources associated with [feature, =
index]
> > + *
> > + * It is application responsibility to pass valid RCU argument to APIs
> > + *
> > + * Constraints
> > + * -----------
> > + *  - rte_graph_feature_arc_init(), rte_graph_feature_create() and
> > + *  rte_graph_feature_add() must be called before rte_graph_create().
> > + *  rte_graph_feature_enable()/rte_graph_feature_disable() should be c=
alled
> > + *  after rte_graph_create()
> > + *  - Not more than 63 features can be added to a feature arc. There i=
s no
> > + *  limit to number of feature arcs i.e. number of
> > + *  RTE_GRAPH_FEATURE_ARC_REGISTER()
> > + *  - There is also no limit for number of indexes
> > (RTE_GRAPH_FEATURE_ARC_REGISTER():
> > + *  max_indexes). There is also a provision for each
> > + *  RTE_GRAPH_FEATURE_REGISTER() to override number of indexes via
> > + *  override_index_cb()
> > + *  - A feature node cannot be part of more than one arc due to
> > + *  performance reason.
> > + */
> > +
> > +/** Length of feature arc name */
> > +#define RTE_GRAPH_FEATURE_ARC_NAMELEN RTE_NODE_NAMESIZE
> > +
> > +/** Initializer values for ARC, Feature, Feature data */
> > +#define RTE_GRAPH_FEATURE_ARC_INITIALIZER
> > ((rte_graph_feature_arc_t)UINT16_MAX)
> > +#define RTE_GRAPH_FEATURE_DATA_INVALID
> > ((rte_graph_feature_data_t)UINT32_MAX)
> > +#define RTE_GRAPH_FEATURE_INVALID  ((rte_graph_feature_t)UINT8_MAX)
> > +
> > +/** rte_graph feature arc object */
> > +typedef uint16_t rte_graph_feature_arc_t;
> > +
> > +/** rte_graph feature object */
> > +typedef uint8_t rte_graph_feature_t;
> > +
> > +/** rte_graph feature data object */
> > +typedef uint32_t rte_graph_feature_data_t;
> > +
> > +/** feature notifier callback called when feature is enabled/disabled =
*/
> > +typedef void (*rte_graph_feature_change_notifier_cb_t)(const char
> > *arc_name,
> > +                                                    const char *featur=
e_name,
> > +                                                    rte_node_t
> > feature_node_id,
> > +                                                    uint32_t index,
> > +                                                    bool enable_disabl=
e,
> > +                                                    uint16_t app_cooki=
e);
> > +
> > +/** cb for overriding arc->max_indexes via RTE_GRAPH_FEATURE_REGISTER(=
)
> > */
> > +typedef uint16_t (*rte_graph_feature_override_index_cb_t)(void);
> > +
> > +/**
> > + *  Feature registration structure provided to
> > + *  RTE_GRAPH_FEATURE_REGISTER()
> > + */
> > +struct rte_graph_feature_register {
> > +     STAILQ_ENTRY(rte_graph_feature_register) next_feature;
>
> Doxygen comment for this

Done
>
> > +
> > +     /** Name of the arc which is registered either via
> > +      * RTE_GRAPH_FEATURE_ARC_REGISTER() or via
> > +      * rte_graph_feature_arc_create()
> > +      */
> > +     const char *arc_name;
> > +
> > +     /* Name of the feature */
> > +     const char *feature_name;
> > +
> > +     /**
> > +      * Node id of feature_node.
> > +      *
> > +      * Setting this field can be skipped if registering feature via
> > +      * RTE_GRAPH_FEATURE_REGISTER()
> > +      */
> > +     rte_node_t feature_node_id;
> > +
> > +     /**
> > +      * Feature node process() function calling feature fast path APIs=
.
> > +      *
> > +      * If application calls rte_graph_feature_arc_init(), node->proce=
ss()
> > +      * provided in RTE_NODE_REGISTER() is overwritten by this
> > +      * function.
> > +      */
> > +     rte_node_process_t feature_process_fn;
> > +
> > +     /*
> > +      * Pointer to Feature node registration
> > +      *
> > +      * Used when features are registered via
> > +      * RTE_GRAPH_FEATURE_REGISTER().
> > +      */
> > +     struct rte_node_register *feature_node;
> > +
> > +     /** Feature ordering constraints
> > +      * runs_after: Name of the feature which must run before "this fe=
ature"
> > +      * runs_before: Name of the feature which must run after "this fe=
ature"
> > +      */
> > +     const char *runs_after;
> > +     const char *runs_before;
> > +
> > +     /*
> > +      * Allow each feature registration to override arc->max_indexes
> > +      *
> > +      * If set, struct rte_graph_feature_arc_register::max_indexes is
> > +      * calculated as follows (before calling rte_graph_feature_arc_cr=
eate())
> > +      *
> > +      * max_indexes =3D rte_graph_feature_arc_register:max_indexes
> > +      * FOR_EACH_FEATURE_REGISTER(arc, feat) {
> > +      *   rte_graph_feature_arc_register:max_indexes =3D max(feat-
> > >override_index_cb(),
> > +      *                                                    max_indexes=
)
> > +      */
> > +     rte_graph_feature_override_index_cb_t override_index_cb;
> > +
> > +     /**
> > +      * Callback for notifying any change in feature enable/disable st=
ate
> > +      */
> > +     rte_graph_feature_change_notifier_cb_t notifier_cb;
> > +};
> > +
> > +/** Feature arc registration structure */
> > +struct rte_graph_feature_arc_register {
> > +     STAILQ_ENTRY(rte_graph_feature_arc_register) next_arc;
> > +
> > +     /** Name of the feature arc */
> > +     const char *arc_name;
> > +
> > +     /**
> > +      * Maximum number of features supported in this feature arc.
> > +      *
> > +      * This field can be skipped for feature arc registration via
> > +      * RTE_GRAPH_FEATURE_ARC_REGISTER().
> > +      *
> > +      * API internally sets this field by calculating number of
> > +      * RTE_GRAPH_FEATURE_REGISTER() for every arc registration via
> > +      * RTE_GRAPH_FEATURE_ARC_REGISTER()
> > +      */
> > +     uint16_t max_features;
> > +
> > +     /**
> > +      * Maximum number of indexes supported in this feature arc
> > +      * Memory is allocated based on this field
> > +      */
> > +     uint16_t max_indexes;
> > +
> > +     /** Start node of this arc */
> > +     struct rte_node_register *start_node;
> > +
> > +     /**
> > +      * Feature arc specific process() function for Start node.
> > +      * If application calls rte_graph_feature_arc_init(),
> > +      * start_node->process() is replaced by this function
> > +      */
> > +     rte_node_process_t start_node_feature_process_fn;
> > +
> > +     /** End feature node registration */
> > +     struct rte_graph_feature_register *end_feature;
> > +};
> > +
> > +/** constructor to register feature to an arc */
> > +#define RTE_GRAPH_FEATURE_REGISTER(reg)                               =
                  \
> > +     RTE_INIT(__rte_graph_feature_register_##reg)                     =
               \
> > +     {                                                                =
               \
> > +             __rte_graph_feature_register(&reg, __func__, __LINE__);
> > \
> > +     }
> > +
> > +/** constructor to register a feature arc */
> > +#define RTE_GRAPH_FEATURE_ARC_REGISTER(reg)                           =
                  \
> > +     RTE_INIT(__rte_graph_feature_arc_register_##reg)                 =
               \
> > +     {                                                                =
               \
> > +             __rte_graph_feature_arc_register(&reg, __func__, __LINE__=
);
> > \
> > +     }
> > +/**
> > + * Initialize feature arc subsystem
> > + *
> > + * This API
> > + * - Initializes feature arc module and alloc associated memory
> > + * - creates feature arc for every RTE_GRAPH_FEATURE_ARC_REGISTER()
> > + * - Add feature node to a feature arc for every
> > RTE_GRAPH_FEATURE_REGISTER()
> > + * - Replaces all RTE_NODE_REGISTER()->process() functions for
> > + *   - Every start_node/end_node provided in arc registration
> > + *   - Every feature node provided in feature registration
> > + *
> > + * @param num_feature_arcs
> > + *  Number of feature arcs that application wants to create by explici=
tly using
> > + *  "rte_graph_feature_arc_create()" API.
> > + *
> > + *  Number of RTE_GRAPH_FEATURE_ARC_REGISTER() should be excluded
> > from this
> > + *  count as API internally calculates number of
> > + *  RTE_GRAPH_FEATURE_ARC_REGISTER().
> > + *
> > + *  So,
> > + *  total number of supported arcs =3D num_feature_arcs +
> > + *                                   NUMBER_OF(RTE_GRAPH_FEATURE_ARC_R=
EGISTER())
> > + *
> > + *  @return
> > + *   0: Success
> > + *   <0: Failure
> > + *
> > + *  rte_graph_feature_arc_init(0) is valid call which will accommodate=
s
> > + *  constructor based arc registration
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_arc_init(uint16_t num_feature_arcs);
> > +
> > +/**
> > + * Create a feature arc.
> > + *
> > + * This API can be skipped if RTE_GRAPH_FEATURE_ARC_REGISTER() is used
> > + *
> > + * @param reg
> > + *   Pointer to struct rte_graph_feature_arc_register
> > + * @param[out] _arc
> > + *  Feature arc object
> > + *
> > + * @return
> > + *  0: Success
> > + * <0: Failure
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_arc_create(struct rte_graph_feature_arc_register=
 *reg,
> > +                              rte_graph_feature_arc_t *_arc);
> > +
> > +/**
> > + * Get feature arc object with name
> > + *
> > + * @param arc_name
> > + *   Feature arc name provided to successful @ref
> > rte_graph_feature_arc_create
> > + * @param[out] _arc
> > + *   Feature arc object returned. Valid only when API returns SUCCESS
> > + *
> > + * @return
> > + *  0: Success
> > + * <0: Failure.
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_arc_lookup_by_name(const char *arc_name,
> > rte_graph_feature_arc_t *_arc);
> > +
> > +/**
> > + * Add a feature to already created feature arc.
> > + *
> > + * This API is not required in case RTE_GRAPH_FEATURE_REGISTER() is us=
ed
> > + *
> > + * @param feat_reg
> > + * Pointer to struct rte_graph_feature_register
> > + *
> > + * <I> Must be called before rte_graph_create() </I>
> > + * <I> rte_graph_feature_add() is not allowed after call to
> > + * rte_graph_feature_enable() so all features must be added before the=
y can
> > be
> > + * enabled </I>
> > + * <I> When called by application, then feature_node_id should be
> > appropriately set as
> > + *     freg->feature_node_id =3D freg->feature_node->id;
> > + * </I>
> > + *
> > + * @return
> > + *  0: Success
> > + * <0: Failure
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg)=
;
> > +
> > +/**
> > + * Enable feature within a feature arc
> > + *
> > + * Must be called after @b rte_graph_create().
> > + *
> > + * @param _arc
> > + *   Feature arc object returned by @ref rte_graph_feature_arc_create =
or @ref
> > + *   rte_graph_feature_arc_lookup_by_name
> > + * @param index
> > + *   Application specific index. Can be corresponding to interface_id/=
port_id etc
> > + * @param feature_name
> > + *   Name of the node which is already added via @ref rte_graph_featur=
e_add
> > + * @param app_cookie
> > + *   Application specific data which is retrieved in fast path
> > + * @param qsbr
> > + *   RCU QSBR object.  After enabling feature, API calls
> > + *   rte_rcu_qsbr_synchronize() followed by call to struct
> > + *   rte_graph_feature_register::notifier_cb(), if it is set, to notif=
y feature
> > + *   caller This object can be passed NULL as well if no RCU synchroni=
zation is
> > + *   required
> > + *
> > + * @return
> > + *  0: Success
> > + * <0: Failure
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t in=
dex,
> > const
> > +                          char *feature_name, uint16_t app_cookie,
> > +                          struct rte_rcu_qsbr *qsbr);
> > +
> > +/**
> > + * Disable already enabled feature within a feature arc
> > + *
> > + * Must be called after @b rte_graph_create(). API is *NOT* Thread-saf=
e
> > + *
> > + * @param _arc
> > + *   Feature arc object returned by @ref rte_graph_feature_arc_create =
or @ref
> > + *   rte_graph_feature_arc_lookup_by_name
> > + * @param index
> > + *   Application specific index. Can be corresponding to interface_id/=
port_id etc
> > + * @param feature_name
> > + *   Name of the node which is already added via @ref rte_graph_featur=
e_add
> > + * @param qsbr
> > + *   RCU QSBR object.  After disabling feature, API calls
> > + *   rte_rcu_qsbr_synchronize() followed by call to struct
> > + *   RTE_GRAPH_FEATURE_ARC_REGISTER::notifier_cb(), if it is set, to n=
otify
> > feature
> > + *   caller. This object can be passed NULL as well if no RCU synchron=
ization is
> > + *   required
> > + *
> > + * @return
> > + *  0: Success
> > + * <0: Failure
> > + */
> > +__rte_experimental
> > +int rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t i=
ndex,
> > +                           const char *feature_name, struct rte_rcu_qs=
br
> > *qsbr);
> > +
> > +/**
> > + * Get rte_graph_feature_t object from feature name
> > +#endif
> > +
> > +#endif
> > diff --git a/lib/graph/rte_graph_feature_arc_worker.h
> > b/lib/graph/rte_graph_feature_arc_worker.h
> > new file mode 100644
> > index 0000000000..57aeaff01a
> > --- /dev/null
> > +++ b/lib/graph/rte_graph_feature_arc_worker.h
> > @@ -0,0 +1,607 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell International Ltd.
> > + */
> > +
> > +#ifndef _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> > +#define _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> > +
> > +#include <stddef.h>
> > +#include <rte_graph_feature_arc.h>
> > +#include <rte_bitops.h>
> > +#include <rte_mbuf.h>
> > +#include <rte_mbuf_dyn.h>
> > +
> > +/**
> > + * @file
> > + *
> > + * rte_graph_feature_arc_worker.h
> > + *
> > + * Defines fast path structure for feature arc
> > + */
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/**
> > + * @internal
> > + *
> > + * Slow path feature node info list
> > + */
> > +struct rte_graph_feature_node_list {
> > +     /** Next feature */
> > +     STAILQ_ENTRY(rte_graph_feature_node_list) next_feature;
> > +
> > +     char feature_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> > +
> > +     /** node id representing feature */
> > +     rte_node_t feature_node_id;
> > +
> > +     /** How many indexes/interfaces using this feature */
> > +     int32_t ref_count;
> > +
> > +     /**
> > +      * feature arc process function overrides to feature node's origi=
nal
> > +      * process function
> > +      */
> > +     rte_node_process_t feature_node_process_fn;
> > +
> > +     /** Callback for freeing application resources when */
> > +     rte_graph_feature_change_notifier_cb_t notifier_cb;
> > +
> > +     /* finfo_index in list. same as rte_graph_feature_t */
> > +     uint32_t finfo_index;
> > +
> > +     /** Back pointer to feature arc */
> > +     void *feature_arc;
> > +
> > +     /** rte_edge_t to this feature node from feature_arc->start_node =
*/
> > +     rte_edge_t edge_to_this_feature;
> > +
> > +     /* rte_edge_t from this feature node to last feature node */
> > +     rte_edge_t edge_to_last_feature;
> > +};
> > +
> > +/**
> > + * rte_graph Feature arc object
> > + *
> > + * Feature arc object holds control plane and fast path information fo=
r all
> > + * features and all interface index information for steering packets a=
cross
> > + * feature nodes
> > + *
> > + * Within a feature arc, only RTE_GRAPH_FEATURE_MAX_PER_ARC features
> > can be
> > + * added. If more features needs to be added, another feature arc can =
be
> > + * created
> > + *
> > + * In fast path, rte_graph_feature_arc_t can be translated to (struct
> > + * rte_graph_feature_arc *) via rte_graph_feature_arc_get(). Later is =
needed to
> > + * add as an input argument to all fast path feature arc APIs
> > + */
> > +struct __rte_cache_aligned rte_graph_feature_arc {
> > +     /** Slow path variables follows*/
> > +     RTE_MARKER slow_path_variables;
> > +
> > +     /** All feature lists */
> > +     STAILQ_HEAD(, rte_graph_feature_node_list) all_features;
> > +
> > +     /** feature arc name */
> > +     char feature_arc_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> > +
> > +     /** control plane counter to track enabled features */
> > +     uint32_t runtime_enabled_features;
> > +
> > +     /** maximum number of features supported by this arc
> > +      *  Immutable during fast path
> > +      */
> > +     uint16_t max_features;
> > +
> > +     /** index in feature_arc_main */
> > +     rte_graph_feature_arc_t feature_arc_index;
> > +
> > +     /** Back pointer to feature_arc_main */
> > +     void *feature_arc_main;
> > +
> > +     /** Arc's start/end node */
> > +     struct rte_node_register *start_node;
> > +     struct rte_graph_feature_register end_feature;
> > +
> > +     /* arc start process function */
> > +     rte_node_process_t arc_start_process;
> > +
> > +     /* total arc_size allocated */
> > +     size_t arc_size;
> > +
> > +     /* slow path: feature data array maintained per [feature, index] =
*/
> > +     rte_graph_feature_data_t *feature_data_by_index;
> > +
> > +     /**
> > +      * Size of all feature data for each feature
> > +      * ALIGN(sizeof(struct rte_graph_feature_data) * arc->max_indexes=
)
> > +      * Not used in fastpath
> > +      */
> > +     uint32_t feature_size;
> > +
> > +     /** Slow path bit mask per feature per index */
> > +     uint64_t *feature_bit_mask_by_index;
> > +
> > +     /** Cache aligned fast path variables */
> > +     alignas(RTE_CACHE_LINE_SIZE) RTE_MARKER fast_path_variables;
> > +
> > +     /**
> > +      * Quick fast path bitmask indicating if any feature enabled. Eac=
h bit
> > +      * corresponds to single feature. Helps in optimally process pack=
ets for
> > +      * the case when features are added but not enabled
> > +      */
> > +     RTE_ATOMIC(uint64_t) fp_feature_enable_bitmask;
> > +
> > +     /**
> > +      * Number of added features. <=3D max_features
> > +      */
> > +     uint16_t num_added_features;
> > +     /** maximum number of index supported by this arc
> > +      *  Immutable during fast path
> > +      */
> > +     uint16_t max_indexes;
> > +
> > +     /** first feature offset in fast path
> > +      * Immutable during fast path
> > +      */
> > +     uint16_t fp_first_feature_offset;
> > +
> > +     /** arc + fp_feature_data_arr_offset
> > +      * Immutable during fast path
> > +      */
> > +     uint16_t fp_feature_data_offset;
> > +
> > +     /*
> > +      * mbuf dynamic offset saved for faster access
> > +      * See rte_graph_feature_arc_mbuf_dynfields_get() for more detail=
s
> > +      */
> > +     int mbuf_dyn_offset;
> > +
> > +     /**
> > +      * Arc specific fast path data
> > +      * It accommodates:
>
> Generated doxygen html is coming properly for this block. See generated h=
tml documentation

Fixed doxygen output in v10

>
> > +      *
> > +      * 1. first enabled feature data for every index
> > +      * rte_graph_feature_data_t (fdata as shown below)
> > +      *
> > +      * +-------------------------------------------------------------=
-+ <- cache_aligned
> > +      * |  0th Index    | 1st Index   |  ... | max_index - 1          =
 |
> > +      * +-------------------------------------------------------------=
-+
> > +      * |  Startfdata0  | Startfdata1 |  ... | Startfdata(max_index-1)=
 |
> > +      * +-------------------------------------------------------------=
-+
> > +      *
> > +      * 2. struct rte_graph_feature_data per index per feature
> > +      *
> > +      * Start (Reserved) ->   +---------------------------------------=
-+ ^ <-
> > cache_aligned
> > +      * (feature_enable)      |  struct rte_graph_feature_data[Index0]=
 | |
> > +      *                       +---------------------------------------=
-+ | feature_size
> > +      *                       |  struct rte_graph_feature_data[Index1]=
 | |
> > +      * Feature-0 ->          +---------------------------------------=
-+ ^ <-
> > cache_aligned
> > +      *                       |  struct rte_graph_feature_data[Index0]=
 | |
> > +      *                       +---------------------------------------=
-+ | feature_size
> > +      *                       |  struct rte_graph_feature_data[Index1]=
 | |
> > +      * Feature-1 ->          +---------------------------------------=
-+ v <- cache
> > aligned
> > +      *                       |  struct rte_graph_feature_data[Index0]=
 | ^
> > +      *                       +---------------------------------------=
-+ | feature_size
> > +      *                       |  struct rte_graph_feature_data[Index1]=
 | |
> > +      *                       +---------------------------------------=
-+ v
> > +      *                                 ...            ....
> > +      *                                 ...            ....
> > +      * Feature(index - 1) -> +---------------------------------------=
-+ v <- cache
> > aligned
> > +      *                       |  struct rte_graph_feature_data[Index0]=
 | ^
> > +      *                       +---------------------------------------=
-+ | feature_size
> > +      *                       |  struct rte_graph_feature_data[Index1]=
 | |
> > +      * Extra (Reserved) ->   +---------------------------------------=
-+ v <- cache
> > aligned
> > +      * (feature_disable)     |  struct rte_graph_feature_data[Index0]=
 | ^
> > +      *                       +---------------------------------------=
-+ | feature_size
> > +      *                       |  struct rte_graph_feature_data[Index1]=
 | |
> > +      *                       +---------------------------------------=
-+ v
> > +      */
> > +     RTE_MARKER8 fp_arc_data;
> > +};
> > +
> > +/**
> > + * Feature arc main object
> > + *
> > + * Holds all feature arcs created by application
> > + */
> > +typedef struct rte_feature_arc_main {
> > +     /** number of feature arcs created by application */
> > +     uint32_t num_feature_arcs;
> > +
> > +     /** max features arcs allowed */
> > +     uint32_t max_feature_arcs;
> > +
> > +     /* arc_mbuf_dyn_offset for saving feature arc specific
> > +      * mbuf dynfield offset.
> > +      *
> > +      * See rte_graph_feature_arc_mbuf_dynfields_get() for more detail=
s
> > +      */
> > +     int arc_mbuf_dyn_offset;
> > +
> > +     /** Pointer to all feature arcs */
> > +     uintptr_t feature_arcs[];
> > +} rte_graph_feature_arc_main_t;
> > +
> > +/**
> > + *  Fast path feature data object
> > + *
> > + *  Used by fast path inline feature arc APIs
> > + *  Corresponding to rte_graph_feature_data_t
> > + *  It holds
> > + *  - edge to reach to next feature node
> > + *  - next_feature_data corresponding to next enabled feature
> > + *  - app_cookie set by application in rte_graph_feature_enable()
> > + */
> > +struct rte_graph_feature_data {
> > +     /** edge from this feature node to next enabled feature node */
> > +     RTE_ATOMIC(rte_edge_t) next_edge;
> > +
> > +     /**
> > +      * app_cookie set by application in rte_graph_feature_enable() fo=
r
> > +      * current feature data
> > +      */
> > +     RTE_ATOMIC(uint16_t) app_cookie;
> > +
> > +     /** Next feature data from this feature data */
> > +     RTE_ATOMIC(rte_graph_feature_data_t) next_feature_data;
> > +};
> > +
> > +/** feature arc specific mbuf dynfield structure. */
> > +struct rte_graph_feature_arc_mbuf_dynfields {
> > +     /** each mbuf carries feature data */
> > +     rte_graph_feature_data_t feature_data;
> > +};
> > +
> > +/** Name of dynamic mbuf field offset registered in
> > rte_graph_feature_arc_init() */
> > +#define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME
> > "__rte_graph_feature_arc_mbuf_dynfield"
> > +
> > +/** log2(sizeof (struct rte_graph_feature_data)) */
> > +#define RTE_GRAPH_FEATURE_DATA_SIZE_LOG2     3
> > +
> > +/** Number of struct rte_graph_feature_data per feature*/
> > +#define RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc)
> >               \
> > +     (arc->feature_size >> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)
> > +
> > +/** Get rte_graph_feature_data_t from rte_graph_feature_t */
> > +#define RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feature, index)
> >               \
> > +             ((rte_graph_feature_data_t)
> >       \
> > +              ((RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc) *
> > (feature)) + (index)))
> > +
> > +/**
> > + * @internal macro
> > + */
> > +#define GRAPH_FEATURE_ARC_PTR_INITIALIZER  ((uintptr_t)UINTPTR_MAX)
> > +
> > +/** extern variables */
> > +extern rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
> > +
> > +/**
> > + * Get dynfield offset to feature arc specific fields in mbuf
> > + *
> > + * Feature arc mbuf dynamic field is separate to utilize mbuf->dynfiel=
d2
> > + * instead of dynfield1
> > + *
> > + * This arc specific dynamic offset is registered as part of
> > + * rte_graph_feature_arc_init() and copied in each arc for fast path a=
ccess.
> > + * This avoids node maintaining dynamic offset for feature arc and if =
we are
> > + * lucky, field would be allocated from mbuf->dynfield2. Otherwise eac=
h node
> > + * has to maintain at least two dynamic offset in fast path
> > + *
> > + * @param mbuf
> > + *  Pointer to mbuf
> > + * @param dyn_offset
> > + *  Retrieved from arc->mbuf_dyn_offset
> > + *
> > + * @return
> > + *  NULL: On Failure
> > + *  Non-NULL pointer on Success
> > + */
> > +__rte_experimental
> > +static __rte_always_inline struct rte_graph_feature_arc_mbuf_dynfields=
 *
> > +rte_graph_feature_arc_mbuf_dynfields_get(struct rte_mbuf *mbuf,
> > +                                      const int dyn_offset)
> > +{
> > +     return RTE_MBUF_DYNFIELD(mbuf, dyn_offset,
> > +                              struct rte_graph_feature_arc_mbuf_dynfie=
lds
> > *);
> > +}
> > +
> > +/**
> > + * API to know if feature is valid or not
> > + *
> > + * @param feature
> > + *  rte_graph_feature_t
> > + *
> > + * @return
> > + *  1: If feature is valid
> > + *  0: If feature is invalid
> > + */
> > +__rte_experimental
> > +static __rte_always_inline int
> > +rte_graph_feature_is_valid(rte_graph_feature_t feature)
> > +{
> > +     return (feature !=3D RTE_GRAPH_FEATURE_INVALID);
> > +}
> > +
> > +/**
> > + * API to know if feature data is valid or not
> > + *
> > + * @param feature_data
> > + *  rte_graph_feature_data_t
> > + *
> > + * @return
> > + *  1: If feature data is valid
> > + *  0: If feature data is invalid
> > + */
> > +__rte_experimental
> > +static __rte_always_inline int
> > +rte_graph_feature_data_is_valid(rte_graph_feature_data_t feature_data)
> > +{
> > +     return (feature_data !=3D RTE_GRAPH_FEATURE_DATA_INVALID);
> > +}
> > +
> > +/**
> > + * Get pointer to feature arc object from rte_graph_feature_arc_t
> > + *
> > + * @param arc
> > + *  feature arc
> > + *
> > + * @return
> > + *  NULL: On Failure
> > + *  Non-NULL pointer on Success
> > + */
> > +__rte_experimental
> > +static __rte_always_inline struct rte_graph_feature_arc *
> > +rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
> > +{
> > +     uintptr_t fa =3D GRAPH_FEATURE_ARC_PTR_INITIALIZER;
> > +     rte_graph_feature_arc_main_t *fm =3D NULL;
> > +
> > +     fm =3D __rte_graph_feature_arc_main;
> > +
> > +     if (likely((fm !=3D NULL) && (arc < fm->max_feature_arcs)))
> > +             fa =3D fm->feature_arcs[arc];
> > +
> > +     return (fa =3D=3D GRAPH_FEATURE_ARC_PTR_INITIALIZER) ?
> > +             NULL : (struct rte_graph_feature_arc *)fa;
> > +}
> > +
> > +/**
> > + * Get rte_graph_feature_t from feature arc object without any checks
> > + *
> > + * @param arc
> > + *  feature arc
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *   Pointer to feature data object
> > + */
> > +__rte_experimental
> > +static __rte_always_inline struct rte_graph_feature_data*
> > +__rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> > +                          rte_graph_feature_data_t fdata)
> > +{
> > +     return ((struct rte_graph_feature_data *) ((uint8_t *)arc + arc-
> > >fp_feature_data_offset +
> > +                                                (fdata <<
> > RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
> > +}
> > +
> > +/**
> > + * Get next edge from feature data pointer, without any check
> > + *
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *  next edge
> > + */
> > +__rte_experimental
> > +static __rte_always_inline rte_edge_t
> > +__rte_graph_feature_data_edge_get(struct rte_graph_feature_data *fdata=
)
> > +{
> > +     return rte_atomic_load_explicit(&fdata->next_edge,
> > rte_memory_order_relaxed);
> > +}
> > +
> > +/**
> > + * Get app_cookie from feature data pointer, without any check
> > + *
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *  app_cookie set by caller in rte_graph_feature_enable() API
> > + */
> > +__rte_experimental
> > +static __rte_always_inline uint16_t
> > +__rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_data
> > *fdata)
> > +{
> > +     return rte_atomic_load_explicit(&fdata->app_cookie,
> > rte_memory_order_relaxed);
> > +}
> > +
> > +/**
> > + * Get next_enabled_feature_data from pointer to feature data, without=
 any
> > check
> > + *
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *  next enabled feature data from this feature data
> > + */
> > +__rte_experimental
> > +static __rte_always_inline rte_graph_feature_data_t
> > +__rte_graph_feature_data_next_feature_get(struct rte_graph_feature_dat=
a
> > *fdata)
> > +{
> > +     return rte_atomic_load_explicit(&fdata->next_feature_data,
> > rte_memory_order_relaxed);
> > +}
> > +
> > +/**
> > + * Get app_cookie from feature data object with checks
> > + *
> > + * @param arc
> > + *  feature arc
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *  app_cookie set by caller in rte_graph_feature_enable() API
> > + */
> > +__rte_experimental
> > +static __rte_always_inline uint16_t
> > +rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_arc *ar=
c,
> > +                                   rte_graph_feature_data_t fdata)
> > +{
> > +     struct rte_graph_feature_data *fdata_obj =3D
> > __rte_graph_feature_data_get(arc, fdata);
> > +
> > +     return __rte_graph_feature_data_app_cookie_get(fdata_obj);
> > +}
> > +
> > +/**
> > + * Get next_enabled_feature_data from current feature data object with
> > checks
> > + *
> > + * @param arc
> > + *  feature arc
> > + * @param fdata
> > + *  Pointer to feature data object
> > + * @param[out] next_edge
> > + *  next_edge from current feature to next enabled feature
> > + *
> > + * @return
> > + *  1: if next feature enabled on index
> > + *  0: if no feature is enabled on index
> > + */
> > +__rte_experimental
> > +static __rte_always_inline int
> > +rte_graph_feature_data_next_feature_get(struct rte_graph_feature_arc *=
arc,
> > +                                     rte_graph_feature_data_t *fdata,
> > +                                     rte_edge_t *next_edge)
> > +{
> > +     struct rte_graph_feature_data *fdata_obj =3D
> > __rte_graph_feature_data_get(arc, *fdata);
> > +
> > +     *fdata =3D __rte_graph_feature_data_next_feature_get(fdata_obj);
> > +     *next_edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> > +
> > +     return rte_graph_feature_data_is_valid(*fdata);
> > +}
> > +
> > +/**
> > + * Get struct rte_graph_feature_data from rte_graph_feature_dat_t
> > + *
> > + * @param arc
> > + *   feature arc
> > + * @param fdata
> > + *  feature data object
> > + *
> > + * @return
> > + *   NULL: On Failure
> > + *   Non-NULL pointer on Success
> > + */
> > +__rte_experimental
> > +static __rte_always_inline struct rte_graph_feature_data*
> > +rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> > +                        rte_graph_feature_data_t fdata)
> > +{
> > +     if (rte_graph_feature_data_is_valid(fdata))
> > +             return __rte_graph_feature_data_get(arc, fdata);
> > +     else
> > +             return NULL;
> > +}
> > +
> > +/**
> > + * Get feature data corresponding to first enabled feature on index
> > + * @param arc
> > + *   feature arc
> > + * @param index
> > + *   Interface index
> > + * @param[out] fdata
> > + *  feature data object
> > + * @param[out] edge
> > + *  rte_edge object
> > + *
> > + * @return
> > + *  1: if any feature enabled on index, return corresponding valid fea=
ture data
> > + *  0: if no feature is enabled on index
> > + */
> > +__rte_experimental
> > +static __rte_always_inline int
> > +rte_graph_feature_data_first_feature_get(struct rte_graph_feature_arc =
*arc,
> > +                                      uint32_t index,
> > +                                      rte_graph_feature_data_t *fdata,
> > +                                      rte_edge_t *edge)
> > +{
> > +     struct rte_graph_feature_data *fdata_obj =3D NULL;
> > +     rte_graph_feature_data_t *fd;
> > +
> > +     fd =3D (rte_graph_feature_data_t *)((uint8_t *)arc + arc-
> > >fp_first_feature_offset +
> > +                                       (sizeof(rte_graph_feature_data_=
t) *
> > index));
> > +
> > +     if (unlikely(rte_graph_feature_data_is_valid(*fd))) {
> > +             fdata_obj =3D __rte_graph_feature_data_get(arc, *fd);
> > +             *edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> > +             *fdata =3D
> > __rte_graph_feature_data_next_feature_get(fdata_obj);
> > +             return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * Fast path API to check if any feature enabled on a feature arc
> > + * Typically from arc->start_node process function
> > + *
> > + * @param arc
> > + *   Feature arc object
> > + *
> > + * @return
> > + *  0: If no feature enabled
> > + *  Non-Zero: Bitmask of features enabled.
> > + *
> > + */
> > +__rte_experimental
> > +static __rte_always_inline uint64_t
> > +rte_graph_feature_arc_is_any_feature_enabled(struct rte_graph_feature_=
arc
> > *arc)
> > +{
> > +     if (unlikely(arc =3D=3D NULL))
> > +             return 0;
> > +
> > +     return (rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
> > +                                      rte_memory_order_relaxed));
> > +}
> > +
> > +/**
> > + * Prefetch feature arc fast path cache line
> > + *
> > + * @param arc
> > + *   RTE_GRAPH feature arc object
> > + */
> > +__rte_experimental
> > +static __rte_always_inline void
> > +rte_graph_feature_arc_prefetch(struct rte_graph_feature_arc *arc)
> > +{
> > +     rte_prefetch0((void *)arc->fast_path_variables);
> > +}
> > +
> > +/**
> > + * Prefetch feature data related fast path cache line
> > + *
> > + * @param arc
> > + *   RTE_GRAPH feature arc object
> > + * @param fdata
> > + *   Pointer to feature data object
> > + */
> > +__rte_experimental
> > +static __rte_always_inline void
> > +rte_graph_feature_arc_feature_data_prefetch(struct rte_graph_feature_a=
rc
> > *arc,
> > +                                         rte_graph_feature_data_t fdat=
a)
> > +{
> > +     if (unlikely(fdata =3D=3D RTE_GRAPH_FEATURE_DATA_INVALID))
> > +             return;
> > +
> > +     rte_prefetch0((void *)__rte_graph_feature_data_get(arc, fdata));
> > +}
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +#endif
> > --
> > 2.43.0
>
