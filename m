Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA735C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90D6142E68;
	Wed,  4 Jun 2025 17:54:36 +0200 (CEST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) by mails.dpdk.org (Postfix) with ESMTP id DC4B242DF1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:54:34 +0200 (CEST)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-4e5a1a4e4aaso2351428137.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749052474; x=1749657274; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAt5QqeldIgFQUrmzqaAEfzjUiq55Bo41zQV1LH8BEU=;
 b=hlw/CppsLtBeOAtIErj/wU4FjkA73mq+G2pIn75K3AeE8zWptlyiqpOnNJv7cie3F5
 qAuYLWpUdIYD3AdRDadyNK10ibNm/M+wwujRQsCChRNU6rvY1My0lETjXcqKUjdTfdCp
 cg4EYVtCdvc6YBmgqkETsAsIlij5rg5qkkafDqdBJwhihV7QbSShuf3qkGuS0MlixcIl
 g9ESnkS2WOAtRPIzzxg73B3kx7w4DkNVFj3VNTgdXQqfuLvYj4ZpMl1EJ6LZJQUEEJ9q
 da7Tl+snJT3B+hBAtI3+jQUHLr+5v7QimsSeM+25RYy0yk9YI2CfAkSNxdg9CQbK7u99
 iCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052474; x=1749657274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAt5QqeldIgFQUrmzqaAEfzjUiq55Bo41zQV1LH8BEU=;
 b=D2pDi/+/PUBUo1LpcaiOtIqG2oxV8D08vbemLwHUofgSyLnlKtqDpKzKYzcn2F4tLS
 BiTo1Dx7Xv0AuIwbNxg/dTe4G8jl5xiELFDGfjAHbfSwxpVoFMwgr2RXRWp9wSPjq9pJ
 Qn2FRKfMcZrnLsnse92QFO9lBxb98OYsunu3i6F6K+zqHI6V8iQF/3RyF3xW5ekFT/Fe
 EHtqXh79FHcfMzJFq63Ah29GkvhTK2pMbj2L2M01sB6f6GyAvKBcTPnbGIcFYpFDOQTS
 NpGSuma+gqdR8fxPQjwQK5tJ0R0vLcK+WtcUDdy/LNO1+4d4HAxkT+nXxjYI8/fLL/2I
 Kqfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdZXVdpb9qb7Hr5DNeRUJCKyZ1Q7ocPkobv5oAzDmSx5HPZndt0acsFxdCpRL+57S1krs=@dpdk.org
X-Gm-Message-State: AOJu0YxC3fLAQ5Px00qKaGtoRxEFfT1A2/97B5gFgVJW4RikBbIdcOMF
 C3zeWZQJ4iY2PJJkzyvIR4S0D9Pse1hs+ThVsgF+Fm8VulQvUpcN8ZSPLd/bAaxx7O7WsHyT/x7
 CdjA8bY/Qa4xYkejktEBoomsy7C/phdw=
X-Gm-Gg: ASbGnctqtP1DReWwO6SArgnjcm1x5/S1j+vjeJBZC/SEGL7ng6fk2jQ33ag1epzqJMk
 v7H2vSqLjQpJFbTH13AhGR/QNUqdfLKpgNj5lnhkcZAWSdS1/7F7aeDojknasV2o+xmgc9PBZvC
 AvdtkqaFfR1wOpXGIMwNEicuVR3r3TPRk=
X-Google-Smtp-Source: AGHT+IF+uR5e2x81+LV7XUckoHSYJDhE0Q2kN/SWBXCY8fhby69Bx1xOfOcdoPp4ygfgEdeJsKkkpmDEheLRETq9eHM=
X-Received: by 2002:a05:6102:5811:b0:4c3:3eb:e84d with SMTP id
 ada2fe7eead31-4e746e082d1mr2487219137.21.1749052473877; Wed, 04 Jun 2025
 08:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-5-nsaxena@marvell.com>
 <DM3PPF17CE793AB02EC69BFE7CB25E94EB3AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
In-Reply-To: <DM3PPF17CE793AB02EC69BFE7CB25E94EB3AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Wed, 4 Jun 2025 21:24:22 +0530
X-Gm-Features: AX0GCFsFxb-sFFataG5d5HcKeDZK2N9YU70oxZp86PaokVmcvQw7I_c-eLXSo6Q
Message-ID: <CAG6-93xEZsfcn6obWxZPyPP8v_-0XBEx3E5E_T1C-or2SNwzQQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] graph: add feature enable/disable APIs
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


On Wed, Jun 4, 2025 at 5:06=E2=80=AFPM Kiran Kumar Kokkilagadda
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
> > Subject: [PATCH v10 4/7] graph: add feature enable/disable APIs
> >
> > This patch also adds feature arc fast path APIs as well along with
> > documentation
> >
> > Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> > ---
> >  doc/guides/prog_guide/graph_lib.rst      | 180 ++++++
> >  lib/graph/graph_feature_arc.c            | 701 ++++++++++++++++++++++-
> >  lib/graph/meson.build                    |   2 +-
> >  lib/graph/rte_graph_feature_arc.h        | 134 ++++-
> >  lib/graph/rte_graph_feature_arc_worker.h | 305 +++++++++-
> >  5 files changed, 1314 insertions(+), 8 deletions(-)
> >
> > diff --git a/doc/guides/prog_guide/graph_lib.rst
> > b/doc/guides/prog_guide/graph_lib.rst
> > index c9ac9e7ae0..fef384d836 100644
> > --- a/doc/guides/prog_guide/graph_lib.rst
> > +++ b/doc/guides/prog_guide/graph_lib.rst
> > @@ -609,6 +609,8 @@ provides application to overload default node path =
by
> > providing hook
> >  points(like netfilter) to insert out-of-tree or another protocol nodes=
 in
> >  packet path.
> >
> > +.. _Control_Data_Plane_Synchronization:
> > +
> >  Control/Data plane synchronization
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >  Feature arc does not stop worker cores for any runtime control plane u=
pdates.
> > @@ -839,6 +841,11 @@ which might have allocated during feature enable.
> >  notifier_cb() is called, at runtime, for every enable/disable of ``[fe=
ature,
> >  index]`` from control thread.
> >
> > +If RCU is provided to enable/disable APIs, notifier_cb() is called aft=
er
> > +``rte_rcu_qsbr_synchronize()``. Application also needs to call
> > +``rte_rcu_qsbr_quiescent()`` in worker thread (preferably after every
> > +``rte_graph_walk()`` iteration)
> > +
> >  override_index_cb()
> >  ....................
> >  A feature arc is :ref:`registered<Feature_Arc_Registration>` to operat=
e on
> > @@ -869,3 +876,176 @@ sub-system. If not called, feature arc has no imp=
act
> > on application.
> >     ``rte_graph_feature_arc_init()`` API should be called before
> >     ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
> >     application.
> > +
> > +Runtime feature enable/disable
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +A feature can be enabled or disabled at runtime from control thread us=
ing
> > +``rte_graph_feature_enable()`` and ``rte_graph_feature_disable()`` API=
s
> > +respectively.
> > +
> > +.. code-block:: c
> > +
> > +    struct rte_rcu_qsbr *rcu_qsbr =3D app_get_rcu_qsbr();
> > +    rte_graph_feature_arc_t _arc;
> > +    uint16_t app_cookie;
> > +
> > +    if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> > +        RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> > +        return -ENOENT;
> > +    }
> > +    app_cookie =3D 100; /* Specific to ['Feature-1`, `port-0`]*/
> > +
> > +    /* Enable feature */
> > +    rte_graph_feature_enable(_arc, 0 /* port-0 */,
> > +                             "Feature-1" /* Name of the node feature *=
/,
> > +                             app_cookie, rcu_qsbr);
> > +
> > +    /* Disable feature */
> > +    rte_graph_feature_disable(_arc, 0 /* port-0 */,
> > +                              "Feature-1" /* Name of the node feature*=
/,
> > +                              rcu_qsbr);
> > +
> > +.. note::
> > +
> > +   RCU argument is optional argument to enable/disable APIs. See
> > +   :ref:`control/data plane
> > +   synchronization<Control_Data_Plane_Synchronization>` and
> > +   :ref:`notifier_cb<Feature_Notifier_Cb>` for more details on when RC=
U is
> > +   needed.
> > +
> > +Fast path traversal rules
> > +^^^^^^^^^^^^^^^^^^^^^^^^^
> > +``Start node``
> > +**************
> > +If feature arc is :ref:`initialized<Feature_Arc_Initialization>`,
> > +``start_node_feature_process_fn()`` will be called by ``rte_graph_walk=
()``
> > +instead of node's original ``process()``. This function should allow p=
ackets to
> > +enter arc path whenever any feature is enabled at runtime
> > +
> > +.. code-block:: c
> > +
> > +    static int nodeA_init(const struct rte_graph *graph, struct rte_no=
de *node)
> > +    {
> > +        rte_graph_feature_arc_t _arc;
> > +
> > +        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> > +            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> > +            return -ENOENT;
> > +        }
> > +
> > +        /* Save arc in node context */
> > +        node->ctx =3D _arc;
> > +        return 0;
> > +    }
> > +
> > +    int nodeA_process_inline(struct rte_graph *graph, struct rte_node =
*node,
> > +                             void **objs, uint16_t nb_objs,
> > +                             struct rte_graph_feature_arc *arc,
> > +                             const int do_arc_processing)
> > +    {
> > +        for(uint16_t i =3D 0; i < nb_objs; i++) {
> > +            struct rte_mbuf *mbuf =3D objs[i];
> > +            rte_edge_t edge_to_child =3D 0; /* By default to Node-B */
> > +
> > +            if (do_arc_processing) {
> > +                struct rte_graph_feature_arc_mbuf_dynfields *dyn =3D
> > +                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc=
-
> > >mbuf_dyn_offset);
> > +
> > +                if (rte_graph_feature_data_first_feature_get(mbuf, mbu=
f->port,
> > +                                                             &dyn->fea=
ture_data,
> > +                                                             &edge_to_=
child) < 0) {
> > +
> > +                    /* Some feature is enabled, edge_to_child is overl=
oaded*/
> > +                }
> > +            }
> > +            /* enqueue as usual */
> > +            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
> > +       }
> > +    }
> > +
> > +    int nodeA_feature_process_fn(struct rte_graph *graph, struct rte_n=
ode
> > *node,
> > +                                 void **objs, uint16_t nb_objs)
> > +    {
> > +        struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_ge=
t(node-
> > >ctx);
> > +
> > +        if (unlikely(rte_graph_feature_arc_has_any_feature(arc)))
> > +            return nodeA_process_inline(graph, node, objs, nb_objs, ar=
c, 1 /* do
> > arc processing */);
> > +        else
> > +            return nodeA_process_inline(graph, node, objs, nb_objs, NU=
LL, 0 /*
> > skip arc processing */);
> > +    }
> > +
> > +``Feature nodes``
> > +*****************
> > +Following code-snippet explains fast path traversal rule for ``Feature=
-1``
> > +:ref:`feature node<Feature_Nodes>` shown in :ref:`figure<Figure_Arc_2>=
`.
> > +
> > +.. code-block:: c
> > +
> > +    static int Feature1_node_init(const struct rte_graph *graph, struc=
t
> > rte_node *node)
> > +    {
> > +        rte_graph_feature_arc_t _arc;
> > +
> > +        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
> > +            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
> > +            return -ENOENT;
> > +        }
> > +
> > +        /* Save arc in node context */
> > +        node->ctx =3D _arc;
> > +        return 0;
> > +    }
> > +
> > +    int feature1_process_inline(struct rte_graph *graph, struct rte_no=
de
> > *node,
> > +                                void **objs, uint16_t nb_objs,
> > +                                struct rte_graph_feature_arc *arc)
> > +    {
> > +        for(uint16_t i =3D 0; i < nb_objs; i++) {
> > +            struct rte_mbuf *mbuf =3D objs[i];
> > +            rte_edge_t edge_to_child =3D 0; /* By default to Node-B */
> > +
> > +            struct rte_graph_feature_arc_mbuf_dynfields *dyn =3D
> > +                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc=
-
> > >mbuf_dyn_offset);
> > +
> > +            /* Get feature app cookie for mbuf */
> > +            uint16_t app_cookie =3D rte_graph_feature_data_app_cookie_=
get(mbuf,
> > &dyn->feature_data);
> > +
> > +            if (feature_local_lookup(app_cookie) {
> > +
> > +                /* Packets is relevant to this feature. Move packet fr=
om arc path */
> > +                edge_to_child =3D X;
> > +
> > +            } else {
> > +
> > +                /* Packet not relevant to this feature. Send this pack=
et to
> > +                 * next enabled feature
> > +                 */
> > +                 rte_graph_feature_data_next_feature_get(mbuf, &dyn-
> > >feature_data,
> > +                                                         &edge_to_chil=
d);
> > +            }
> > +
> > +            /* enqueue as usual */
> > +            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
> > +       }
> > +    }
> > +
> > +    int feature1_process_fn(struct rte_graph *graph, struct rte_node *=
node,
> > +                           void **objs, uint16_t nb_objs)
> > +    {
> > +        struct rte_graph_feature_arc *arc =3D rte_graph_feature_arc_ge=
t(node-
> > >ctx);
> > +
> > +        return feature1_process_inline(graph, node, objs, nb_objs, arc=
);
> > +    }
> > +
> > +``End feature node``
> > +********************
> > +An end feature node is a feature node through which packets exits feat=
ure arc
> > +path. It should not use any feature arc fast path APIs.
> > +
> > +Feature arc destroy
> > +^^^^^^^^^^^^^^^^^^^
> > +``rte_graph_feature_arc_destroy()`` can be used to free a arc object.
> > +
> > +Feature arc cleanup
> > +^^^^^^^^^^^^^^^^^^^
> > +``rte_graph_feature_arc_cleanup()`` can be used to free all resources
> > +associated with feature arc module.
> > diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_ar=
c.c
> > index b28f0ec321..9cad82947a 100644
> > --- a/lib/graph/graph_feature_arc.c
> > +++ b/lib/graph/graph_feature_arc.c
> > @@ -19,6 +19,9 @@
> >
> >  #define graph_uint_cast(f)           ((unsigned int)f)
> >
> > +#define fdata_fix_get(arc, feat, index)      \
> > +                     RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feat,
> > index)
> > +
> >  #define feat_dbg graph_dbg
> >
> >  #define FEAT_COND_ERR(cond, ...)                                      =
     \
> > @@ -61,6 +64,139 @@ static STAILQ_HEAD(, rte_graph_feature_arc_register=
)
> > feature_arc_list =3D
> >  static STAILQ_HEAD(, rte_graph_feature_register) feature_list =3D
> >
> >       STAILQ_HEAD_INITIALIZER(feature_list);
> >
> > + /*
> > +  * feature data index is not fixed for given [feature, index], althou=
gh it can
> > +  * be, which is calculated as follows (fdata_fix_get())
> > +  *
> > +  * fdata =3D (arc->max_features * feature ) + index;
> > +  *
> > +  * But feature data index should not be fixed for any index. i.e
> > +  * on any index, feature data can be placed. A slow path array is
> > +  * maintained and within a feature range [start, end] it is checked w=
here
> > +  * feature_data_index is already placed.
> > +  *
> > +  * If is_release =3D=3D false. feature_data_index is searched in a fe=
ature range.
> > +  * If found, index is returned. If not found, then reserve and return=
.
> > +  *
> > +  * If is_release =3D=3D true, then feature_data_index is released for=
 further
> > +  * usage
> > +  */
> > +static rte_graph_feature_data_t
> > +fdata_dyn_reserve_or_rel(struct rte_graph_feature_arc *arc,
> > rte_graph_feature_t f,
> > +                      uint32_t index, bool is_release,
> > +                      bool fdata_provided, rte_graph_feature_data_t fd=
)
> > +{
> > +     rte_graph_feature_data_t start, end, fdata;
> > +     rte_graph_feature_t next_feat;
> > +
> > +     if (fdata_provided)
> > +             fdata =3D fd;
> > +     else
> > +             fdata =3D fdata_fix_get(arc, f, index);
> > +
> > +     next_feat =3D f + 1;
> > +     /* Find in a given feature range, feature data is stored or not *=
/
> > +     for (start =3D fdata_fix_get(arc, f, 0),
> > +          end =3D fdata_fix_get(arc, next_feat, 0);
> > +          start < end;
> > +          start++) {
> > +             if (arc->feature_data_by_index[start] =3D=3D fdata) {
> > +                     if (is_release)
> > +                             arc->feature_data_by_index[start] =3D
> > RTE_GRAPH_FEATURE_DATA_INVALID;
> > +
> > +                     return start;
> > +             }
> > +     }
> > +
> > +     if (is_release)
> > +             return RTE_GRAPH_FEATURE_DATA_INVALID;
> > +
> > +     /* If not found, then reserve valid one */
> > +     for (start =3D fdata_fix_get(arc, f, 0),
> > +          end =3D fdata_fix_get(arc, next_feat, 0);
> > +          start < end;
> > +          start++) {
> > +             if (arc->feature_data_by_index[start] =3D=3D
> > RTE_GRAPH_FEATURE_DATA_INVALID) {
> > +                     arc->feature_data_by_index[start] =3D fdata;
> > +                     return start;
> > +             }
> > +     }
> > +
> > +     /* This should not happen */
> > +     if (!fdata_provided)
> > +             RTE_VERIFY(0);
> > +
>
> Why panic? Return error.

Removed in v11. Have removed other referenced to RTE_VERIFY as well

<snip>
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
> Do we need above condition? Do we ever run into this? Avoid un necessary =
checks in fast path.
>

Removed check in v11
>
> > +     rte_prefetch0((void *)__rte_graph_feature_data_get(arc, fdata));
> > +}
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > --
> > 2.43.0
>
