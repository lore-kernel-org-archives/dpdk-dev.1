Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD97C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 710114042E;
	Fri,  6 Jun 2025 10:06:56 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5C60E40150
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:06:55 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a52d82adcaso24476981cf.0
 for <dev@dpdk.org>; Fri, 06 Jun 2025 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749197215; x=1749802015; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ao/7DNfevBMEA6qkMggTxXmcR0/LT+Iv0/dV55dJUng=;
 b=A5lOCAui20vdCevLW3FlJgM8qLJctXQx9GPgxl9jXscG8VKTIMTFwa8UVt9XLH81LQ
 t0VFvEuPOOGGiXXHZX4xALanIvAUeKInHVC4/sCE2r/voAFs2Q2F9pq8ihzSIBhhM8/Z
 R5gxGTY5sGKu8O+aiS6KTHpmXZRCHVTsNYiuu4coSHBZ4U9G7+/fc8RTPBk3hOXcO0fH
 UvbK75Gsfjg6pgQZuLzJDqtXXgxqaF9DQta4hDWfkO8CGMvgwTDqaKWcTQ4by42jGicx
 hL1J+Ad2eOXjnlwkpO8yoq5yENBu+gvjhuftzUgkH1v4jD8CqjOSB0U6EDERyyPdxtNS
 RoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749197215; x=1749802015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ao/7DNfevBMEA6qkMggTxXmcR0/LT+Iv0/dV55dJUng=;
 b=jkU+7onnm+vcl4sTVxW+htvkfRDa9HRuZGlIqEQkq8bU0Sx6cuCTgYM6fOF5cWmvQd
 0eh2jA/EHOVXEClR7k/C8KFtD8OkU7BH5pbrz1cqvEHLhu4JFJeyHQk/H2BZyUt9o83q
 RtTiAwXolLaEfRjW7MzCYXyRSLayLaCXM7K+8xBCIsHsGRRxKdM983z67Ld6rKss8Chc
 WnYBzJH974aCIw//vNBezIQt84aIL9SxcX7/yrDbgmutYS5k7xOAkfh6ovE+hW8G0Dyc
 JRmCsD12iCvuFEgJZZrT9ViureWx9lzbFMHajfLhvyZgRELPb+7PxIPkdo+gOa7CHdVy
 tSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6fJ+EAEB8oHr3NYAQVKg17CFIfMfRpKVnl5JZYxMoGzKdsxamZ3OOSEcF8W2Oa4ZEdBA=@dpdk.org
X-Gm-Message-State: AOJu0YzoZTga7LxWyB1RJez05j1C5FL/mh+NhxLppDxfaaXFDa7zLLaW
 bpndJ1LoohJSJSWmFnbmD3mYl6PZB+l+fIgPXYrLqKrU776bs7tOBF9pkh567YlQ1Ar0dyv1C7d
 BqJ8/TybFcKbcKewStRYMFbrYLcHaFnY=
X-Gm-Gg: ASbGncsf+/sRUbO0JtBvmfE/kyXgElcFg/UfKXZS5Pm6NuL+4whMYPkOouASy7jXdTm
 MTcvITs9z0eZRzV4t7rV4LYLxRKJkWLwzxysIbPNNi9IjpinViJGWb0cb7eRDv/4u/xRiyptGxt
 1dJlLxTf0qHYUYwfWFGTXEzDb/LkgmYrE=
X-Google-Smtp-Source: AGHT+IEIYQ4n1fXR8Ek8W5+wAYi3QpVSI7bnHi6Cp/AqtCmupUbAo6MphTnyqtg3q/K2fSeqKssiB8F91yjClCCr+NU=
X-Received: by 2002:a05:622a:2510:b0:4a4:41fc:cc29 with SMTP id
 d75a77b69052e-4a5b9e005d8mr48135351cf.1.1749197214376; Fri, 06 Jun 2025
 01:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
 <20250605173315.1447003-8-nsaxena@marvell.com>
In-Reply-To: <20250605173315.1447003-8-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 6 Jun 2025 13:36:19 +0530
X-Gm-Features: AX0GCFt8DqPim5KyZy23AfakZQawm-fTZArmP1qUK0m28531iWa7rmmiYcDcHLc
Message-ID: <CALBAE1No3docfFnXsuGOJpmZp_kd8aj5ENG-_Wz2LXwDidPTVA@mail.gmail.com>
Subject: Re: [PATCH v12 7/7] test/graph_feature_arc: add functional tests
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Thu, Jun 5, 2025 at 11:22=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> =
wrote:
>
> Added functional unit test case for verifying feature arc control plane
> and fast path APIs
>
> How to run:
> $ echo "graph_feature_arc_autotest" | ./bin/dpdk-test
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>


Series Acked-by: Jerin Jacob <jerinj@marvell.com>

> ---
>  app/test/meson.build              |    1 +
>  app/test/test_graph_feature_arc.c | 1374 +++++++++++++++++++++++++++++
>  2 files changed, 1375 insertions(+)
>  create mode 100644 app/test/test_graph_feature_arc.c
>
> diff --git a/app/test/meson.build b/app/test/meson.build
> index b6285a6b45..acb0d36c6b 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -90,6 +90,7 @@ source_file_deps =3D {
>      'test_func_reentrancy.c': ['hash', 'lpm'],
>      'test_graph.c': ['graph'],
>      'test_graph_perf.c': ['graph'],
> +    'test_graph_feature_arc.c': ['graph'],
>      'test_hash.c': ['net', 'hash'],
>      'test_hash_functions.c': ['hash'],
>      'test_hash_multiwriter.c': ['hash'],
> diff --git a/app/test/test_graph_feature_arc.c b/app/test/test_graph_feat=
ure_arc.c
> new file mode 100644
> index 0000000000..b46ab4457e
> --- /dev/null
> +++ b/app/test/test_graph_feature_arc.c
> @@ -0,0 +1,1374 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2024 Marvell International Ltd.
> + */
> +
> +#include "test.h"
> +
> +#include <assert.h>
> +#include <inttypes.h>
> +#include <signal.h>
> +#include <stdalign.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <rte_errno.h>
> +
> +#ifndef RTE_EXEC_ENV_WINDOWS
> +#include <rte_graph.h>
> +#include <rte_graph_worker.h>
> +#include <rte_mbuf.h>
> +#include <rte_mbuf_dyn.h>
> +#include <rte_random.h>
> +#include <rte_graph_feature_arc.h>
> +#include <rte_graph_feature_arc_worker.h>
> +
> +#define MBUF_NUM 256
> +#define TEST_ARC1_NAME "arc1"
> +#define TEST_ARC2_NAME "arc2"
> +#define TEST_FAILED_ARC "failed_arc"
> +#define MAX_INDEXES 10
> +#define OVERRIDE_MAX_INDEX MBUF_NUM
> +#define MAX_FEATURES 5
> +
> +#define dbg(...)
> +
> +#define SOURCE1 "arc_source1_node"
> +#define INPUT_STATIC "arc_input_static_node"
> +#define OUTPUT_STATIC "arc_output_static_node"
> +#define PKT_FREE_STATIC "arc_pkt_free_static_node"
> +#define ARC1_FEATURE1 "arc1_feature1_node"
> +#define ARC1_FEATURE2 "arc1_feature2_node"
> +#define ARC2_FEATURE1 "arc2_feature1_node"
> +#define ARC2_FEATURE2 "arc2_feature2_node"
> +#define ARC2_FEATURE3 "arc2_feature3_node"
> +#define DUMMY1_STATIC "arc_dummy1_static_node"
> +#define DUMMY2_STATIC "arc_dummy2_static_node"
> +
> +#define feature_cast(x) ((rte_graph_feature_t)(x))
> +
> +/* (Node index, Node Name, feature app_cookie base */
> +#define FOREACH_TEST_NODE_ARC {                        \
> +               R(0, SOURCE1, 64)               \
> +               R(1, INPUT_STATIC, 128)         \
> +               R(2, OUTPUT_STATIC, 256)        \
> +               R(3, PKT_FREE_STATIC, 512)      \
> +               R(4, ARC1_FEATURE1, 1024)       \
> +               R(5, ARC1_FEATURE2, 2048)       \
> +               R(6, ARC2_FEATURE1, 4096)       \
> +               R(7, ARC2_FEATURE2, 8192)       \
> +               R(8, ARC2_FEATURE3, 16384)      \
> +               R(9, DUMMY1_STATIC, 32768)      \
> +               R(10, DUMMY2_STATIC, 65536)     \
> +       }
> +
> +/**
> + * ARC1: Feature arc on ingress interface
> + * ARC2: Feature arc on egress interface
> + * XX_static: Static nodes
> + * XX_featureX: Feature X on arc
> + *
> + *            -----> ARC1_FEATURE1
> + *           |        |         |
> + *           |        |         v
> + *           |        |   ARC1_FEATURE2
> + *           |        |         |
> + *           |        v         v
> + *  SOURCE1 ->-----> INPUT_STATIC --> OUTPUT_STATIC -----> PKT_FREE_STAT=
IC
> + *                                     |   |  |             ^      ^    =
 ^
> + *                                     |   |  |             |      |    =
 |
> + *                                     |   |   --> ARC2_FEATURE1   |    =
 |
> + *                                     |   |          ^     ^      |    =
 |
> + *                                     |   |          |     |      |    =
 |
> + *                                     |    ----------c-> ARC2_FEATURE2 =
 |
> + *                                     |              |     ^           =
 |
> + *                                     |              |     |           =
 |
> + *                                      ----------> ARC2_FEATURE3 ------=
-
> + */
> +const char *node_names_feature_arc[] =3D {
> +       SOURCE1, INPUT_STATIC, OUTPUT_STATIC, PKT_FREE_STATIC,
> +       ARC1_FEATURE1, ARC1_FEATURE2, ARC2_FEATURE1, ARC2_FEATURE2, ARC2_=
FEATURE3,
> +       DUMMY1_STATIC, DUMMY2_STATIC
> +};
> +
> +const char *arc_names[] =3D {
> +       TEST_ARC1_NAME, TEST_ARC2_NAME,
> +};
> +
> +const char *arc1_feature_seq[] =3D {
> +       ARC1_FEATURE1, ARC1_FEATURE2, INPUT_STATIC,
> +};
> +
> +const char *arc2_feature_seq[] =3D {
> +       ARC2_FEATURE1, ARC2_FEATURE2, ARC2_FEATURE3, PKT_FREE_STATIC,
> +};
> +
> +#define MAX_NODES  RTE_DIM(node_names_feature_arc)
> +
> +typedef enum {
> +       START_NODE,
> +       INTERMEDIATE_FEATURE,
> +       END_FEATURE,
> +} fp_node_type_t;
> +
> +static int fp_test_case_result_failed;
> +static const char *fp_error_node;
> +static uint64_t fp_end_feature_counters;
> +static uint64_t sp_enable_counters, sp_enable_cb_counters;
> +static uint64_t sp_disable_counters, sp_disable_cb_counters;
> +
> +/* Function declarations */
> +static uint16_t
> +source1_fn(struct rte_graph *graph, struct rte_node *node,
> +          void **objs, uint16_t nb_objs);
> +static uint16_t
> +input_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +           void **objs, uint16_t nb_objs);
> +static uint16_t
> +output_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +            void **objs, uint16_t nb_objs);
> +static uint16_t
> +pkt_free_fn(struct rte_graph *graph, struct rte_node *node,
> +           void **objs, uint16_t nb_objs);
> +static uint16_t
> +pkt_free_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +              void **objs, uint16_t nb_objs);
> +static uint16_t
> +dummy1_fn(struct rte_graph *graph, struct rte_node *node,
> +         void **objs, uint16_t nb_objs);
> +static uint16_t
> +dummy2_fn(struct rte_graph *graph, struct rte_node *node,
> +         void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc1_feature1_fn(struct rte_graph *graph, struct rte_node *node,
> +                void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc1_feature1_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc1_feature2_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc2_feature1_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc2_feature2_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs);
> +static uint16_t
> +arc2_feature3_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs);
> +static int
> +common_arc1_init(const struct rte_graph *graph, struct rte_node *node);
> +static int
> +common_arc2_init(const struct rte_graph *graph, struct rte_node *node);
> +static uint16_t
> +common_process_fn(struct rte_graph *graph, struct rte_node *node,
> +                 void **objs, uint16_t nb_objs, uint16_t max_indexes,
> +                 uint16_t mbuf_arr_offset, fp_node_type_t type);
> +
> +typedef struct test_node_priv {
> +       int stop_enqueue;
> +
> +       /* rte_graph node id */
> +       uint32_t node_id;
> +
> +       rte_graph_feature_arc_t arc;
> +} test_node_priv_t;
> +
> +typedef struct {
> +       rte_graph_feature_t feature;
> +       uint16_t egress_interface;
> +       uint16_t ingress_interface;
> +} graph_dynfield_t;
> +
> +#define MAX_FEATURE_ARCS 4
> +static rte_graph_feature_arc_t arcs[MAX_FEATURE_ARCS];
> +static struct rte_mbuf mbufs[MAX_NODES + 1][MBUF_NUM];
> +static void *mbuf_p[MAX_NODES + 1][MBUF_NUM];
> +static rte_graph_t graph_id =3D RTE_GRAPH_ID_INVALID;
> +
> +static uint16_t
> +compute_unique_user_data(const char *parent, const char *child, uint32_t=
 interface_index)
> +{
> +       uint16_t user_data =3D interface_index;
> +
> +       RTE_SET_USED(parent);
> +#define R(idx, node, node_cookie) {                            \
> +               if (!strcmp(child, node)) {                     \
> +                       user_data +=3D node_cookie + idx;         \
> +               }                                               \
> +       }
> +
> +       FOREACH_TEST_NODE_ARC
> +#undef R
> +
> +       return user_data;
> +}
> +
> +static  void update_sp_counters(const char *arc_name, const char *featur=
e_name,
> +                               rte_node_t feature_node_id, uint32_t inde=
x,
> +                               bool enable_disable, uint16_t app_cookie)
> +
> +{
> +       RTE_SET_USED(feature_node_id);
> +
> +       if (app_cookie !=3D UINT16_MAX) {
> +               if (app_cookie !=3D compute_unique_user_data(arc_name, fe=
ature_name, index)) {
> +                       printf("cb():%s/%s/%u: app_cookie mismatch %u !=
=3D %u\n",
> +                              arc_name, feature_name, index, app_cookie,
> +                              compute_unique_user_data(arc_name, feature=
_name, index));
> +                       sp_enable_counters =3D UINT16_MAX;
> +                       sp_disable_counters =3D UINT16_MAX;
> +               }
> +       }
> +       if (enable_disable)
> +               sp_enable_cb_counters++;
> +       else
> +               sp_disable_cb_counters++;
> +}
> +
> +
> +
> +static int
> +get_edge(struct rte_node_register *parent_node,
> +        struct rte_node_register *child_node, rte_edge_t *_edge)
> +{
> +       char **next_edges =3D NULL;
> +       uint32_t count, i;
> +
> +       count =3D rte_node_edge_get(parent_node->id, NULL);
> +
> +       if (!count)
> +               return -1;
> +
> +       next_edges =3D malloc(count);
> +
> +       if (!next_edges)
> +               return -1;
> +
> +       count =3D rte_node_edge_get(parent_node->id, next_edges);
> +       for (i =3D 0; i < count; i++) {
> +               if (strstr(child_node->name, next_edges[i])) {
> +                       if (_edge)
> +                               *_edge =3D (rte_edge_t)i;
> +
> +                       free(next_edges);
> +                       return 0;
> +               }
> +       }
> +       free(next_edges);
> +
> +       return -1;
> +}
> +
> +int
> +common_arc1_init(const struct rte_graph *graph, struct rte_node *node)
> +{
> +       test_node_priv_t *priv =3D (test_node_priv_t *)node->ctx;
> +
> +       RTE_SET_USED(graph);
> +
> +       priv->node_id =3D node->id;
> +       priv->stop_enqueue =3D 0;
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC1_NAME, &priv->a=
rc) < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +int
> +common_arc2_init(const struct rte_graph *graph, struct rte_node *node)
> +{
> +       test_node_priv_t *priv =3D (test_node_priv_t *)node->ctx;
> +
> +       RTE_SET_USED(graph);
> +
> +       priv->node_id =3D node->id;
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC2_NAME, &priv->a=
rc) < 0)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +uint16_t
> +common_process_fn(struct rte_graph *graph, struct rte_node *node,
> +                 void **objs, uint16_t nb_objs, uint16_t max_indexes,
> +                 uint16_t mbuf_arr_offset,
> +                 fp_node_type_t ndtype)
> +{
> +       test_node_priv_t *priv =3D (test_node_priv_t *)node->ctx;
> +       struct rte_graph_feature_arc *arc =3D
> +               rte_graph_feature_arc_get(priv->arc);
> +       struct rte_graph_feature_arc_mbuf_dynfields *mbfields =3D NULL;
> +       struct rte_mbuf *bufs[MBUF_NUM];
> +       rte_edge_t edges[MBUF_NUM];
> +       uint32_t i, idx;
> +
> +       RTE_SET_USED(objs);
> +       if (priv->stop_enqueue)
> +               return 0;
> +
> +       if (ndtype =3D=3D START_NODE)
> +               nb_objs =3D MBUF_NUM;
> +
> +       for (i =3D 0; i < nb_objs; i++) {
> +               switch (ndtype) {
> +               case START_NODE:
> +                       edges[i] =3D UINT16_MAX;
> +                       bufs[i] =3D mbuf_p[mbuf_arr_offset][i];
> +                       break;
> +               case INTERMEDIATE_FEATURE:
> +                       edges[i] =3D UINT16_MAX;
> +                       bufs[i] =3D (struct rte_mbuf *)objs[i];
> +                       break;
> +               default:
> +                       edges[i] =3D 0;
> +                       bufs[i] =3D (struct rte_mbuf *)objs[i];
> +                       break;
> +               }
> +               mbfields =3D rte_graph_feature_arc_mbuf_dynfields_get(buf=
s[i], arc->mbuf_dyn_offset);
> +               if (ndtype =3D=3D START_NODE) {
> +                       idx =3D i % max_indexes;
> +                       if (!rte_graph_feature_data_first_feature_get(arc=
, idx,
> +                                                                     &mb=
fields->feature_data,
> +                                                                     &ed=
ges[i])) {
> +                               fp_test_case_result_failed =3D 1;
> +                               fp_error_node =3D node->name;
> +                               priv->stop_enqueue =3D 1;
> +                               return i;
> +                       }
> +               } else if (ndtype =3D=3D INTERMEDIATE_FEATURE) {
> +                       if (!rte_graph_feature_data_next_feature_get(arc,
> +                                                                    &mbf=
ields->feature_data,
> +                                                                    &edg=
es[i])) {
> +                               fp_test_case_result_failed =3D 1;
> +                               fp_error_node =3D node->name;
> +                               return i;
> +                       }
> +               } else {
> +                       /* Send pkts from arc1_end to arc2_start*/
> +                       if (mbuf_arr_offset =3D=3D 0)
> +                               edges[i] =3D 0;
> +                       fp_end_feature_counters++;
> +               }
> +               if (edges[i] =3D=3D UINT16_MAX)
> +                       RTE_VERIFY(0);
> +       }
> +       if (ndtype =3D=3D START_NODE)
> +               priv->stop_enqueue =3D 1;
> +
> +       if (!fp_test_case_result_failed && (!mbuf_arr_offset || (ndtype !=
=3D END_FEATURE)))
> +               rte_node_enqueue_next(graph, node, edges, (void **)bufs, =
nb_objs);
> +
> +       return nb_objs;
> +}
> +
> +uint16_t
> +source1_fn(struct rte_graph *graph, struct rte_node *node,
> +          void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs, MAX_INDEXES,=
 0, START_NODE);
> +}
> +
> +static struct rte_node_register node_source1 =3D {
> +       .name =3D SOURCE1,
> +       .process =3D source1_fn,
> +       .flags =3D RTE_NODE_SOURCE_F,
> +       .nb_edges =3D 3,
> +       .init =3D common_arc1_init,
> +       .next_nodes =3D {INPUT_STATIC, DUMMY1_STATIC, DUMMY2_STATIC},
> +};
> +RTE_NODE_REGISTER(node_source1);
> +
> +uint16_t
> +input_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +               void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs, MAX_INDEXES,=
 0, END_FEATURE);
> +}
> +
> +static struct rte_node_register node_input =3D {
> +       .name =3D INPUT_STATIC,
> +       .process =3D input_fa_fn,
> +       .nb_edges =3D 2,
> +       .init =3D common_arc1_init,
> +       .next_nodes =3D {OUTPUT_STATIC, DUMMY1_STATIC},
> +};
> +RTE_NODE_REGISTER(node_input);
> +
> +struct rte_graph_feature_register arc1_end_feature =3D {
> +       .feature_name =3D INPUT_STATIC,
> +       .arc_name =3D TEST_ARC1_NAME,
> +       .feature_process_fn =3D input_fa_fn,
> +       .feature_node =3D &node_input,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +
> +static struct rte_graph_feature_arc_register arc1_input =3D {
> +       .arc_name =3D TEST_ARC1_NAME,
> +       .max_indexes =3D MAX_INDEXES,
> +       .max_features =3D MAX_FEATURES,
> +       .start_node =3D &node_source1,
> +       .start_node_feature_process_fn =3D source1_fn,
> +       .end_feature =3D &arc1_end_feature,
> +};
> +
> +uint16_t
> +output_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +            void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                OVERRIDE_MAX_INDEX, 1, START_NODE);
> +}
> +
> +static struct rte_node_register node_output =3D {
> +       .name =3D OUTPUT_STATIC,
> +       .process =3D output_fa_fn,
> +       .nb_edges =3D 3,
> +       .init =3D common_arc2_init,
> +       .next_nodes =3D {DUMMY1_STATIC, PKT_FREE_STATIC, DUMMY2_STATIC},
> +};
> +RTE_NODE_REGISTER(node_output);
> +
> +uint16_t
> +pkt_free_fn(struct rte_graph *graph, struct rte_node *node,
> +               void **objs, uint16_t nb_objs)
> +{
> +       RTE_SET_USED(graph);
> +       RTE_SET_USED(node);
> +       RTE_SET_USED(objs);
> +       RTE_SET_USED(nb_objs);
> +
> +       fp_test_case_result_failed =3D 1;
> +       fp_error_node =3D node->name;
> +       return 0;
> +}
> +
> +uint16_t
> +pkt_free_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +              void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                OVERRIDE_MAX_INDEX, 1, END_FEATURE);
> +}
> +
> +static struct rte_node_register node_pkt_free =3D {
> +       .name =3D PKT_FREE_STATIC,
> +       .process =3D pkt_free_fn,
> +       .nb_edges =3D 1,
> +       .init =3D common_arc2_init,
> +       .next_nodes =3D {DUMMY1_STATIC},
> +};
> +RTE_NODE_REGISTER(node_pkt_free);
> +
> +static uint16_t override_arc2_index(void)
> +{
> +       return OVERRIDE_MAX_INDEX;
> +}
> +
> +struct rte_graph_feature_register arc2_end_feature =3D {
> +       .feature_name =3D PKT_FREE_STATIC,
> +       .arc_name =3D TEST_ARC2_NAME,
> +       .feature_process_fn =3D pkt_free_fa_fn,
> +       .feature_node =3D &node_pkt_free,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +
> +static struct rte_graph_feature_arc_register arc2_output =3D {
> +       .arc_name =3D TEST_ARC2_NAME,
> +       .max_indexes =3D 1, /* Let feature override with bigger value */
> +       /* max_features not provided. End feature is a feature hence shou=
ld work*/
> +       .start_node =3D &node_output,
> +       .start_node_feature_process_fn =3D output_fa_fn,
> +       .end_feature =3D &arc2_end_feature,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(arc2_output);
> +
> +/** Dummy nodes */
> +uint16_t
> +dummy1_fn(struct rte_graph *graph, struct rte_node *node,
> +         void **objs, uint16_t nb_objs)
> +{
> +       RTE_SET_USED(graph);
> +       RTE_SET_USED(node);
> +       RTE_SET_USED(objs);
> +       RTE_SET_USED(nb_objs);
> +       return 0;
> +}
> +
> +static struct rte_node_register dummy1 =3D {
> +       .name =3D DUMMY1_STATIC,
> +       .process =3D dummy1_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc2_init,
> +};
> +RTE_NODE_REGISTER(dummy1);
> +
> +uint16_t
> +dummy2_fn(struct rte_graph *graph, struct rte_node *node,
> +         void **objs, uint16_t nb_objs)
> +{
> +       RTE_SET_USED(graph);
> +       RTE_SET_USED(node);
> +       RTE_SET_USED(objs);
> +       RTE_SET_USED(nb_objs);
> +       return 0;
> +}
> +
> +static struct rte_node_register dummy2 =3D {
> +       .name =3D DUMMY2_STATIC,
> +       .process =3D dummy2_fn,
> +       .nb_edges =3D 5,
> +       .init =3D common_arc2_init,
> +       .next_nodes =3D { ARC1_FEATURE1, ARC1_FEATURE2, ARC2_FEATURE1,
> +                       ARC2_FEATURE2, ARC2_FEATURE3},
> +};
> +RTE_NODE_REGISTER(dummy2);
> +
> +/** Failed registrations */
> +
> +struct rte_graph_feature_register sink_valid_feature =3D {
> +       .feature_name =3D "sink_valid_feature",
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .feature_process_fn =3D dummy2_fn,
> +       .feature_node =3D &dummy2,
> +};
> +
> +struct rte_graph_feature_register sink_mismatch_arc_name =3D {
> +       .feature_name =3D "sink_mismatch_arc_name",
> +       .arc_name =3D "mismatch_arc_name",
> +       .feature_process_fn =3D dummy2_fn,
> +       .feature_node =3D &dummy2,
> +};
> +
> +struct rte_graph_feature_register sink_no_feature_node =3D {
> +       .feature_name =3D "sink_no_feature_node",
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .feature_process_fn =3D dummy2_fn,
> +};
> +
> +struct rte_graph_feature_register sink_no_feature_fn =3D {
> +       .feature_name =3D "sink_no_feature_fn",
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .feature_node =3D &dummy2,
> +};
> +
> +/* failed_arc1
> + *  - max_features not provided
> + *  - end_feature not provided
> + */
> +static struct rte_graph_feature_arc_register failed_arc1 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .max_indexes =3D 1, /* Let features override it*/
> +       /* max_features field is missing */
> +       /* end_feature missing */
> +       .start_node =3D &dummy1,
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc1);
> +
> +/* failed_arc2
> + * - max_indexes not provided
> + */
> +static struct rte_graph_feature_arc_register failed_arc2 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_valid_feature,
> +       /* max_index not provided and neither override_index_cb() in any =
feature */
> +       .start_node =3D &dummy1,
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc2);
> +
> +/* failed_arc3
> + * - start_node not provided
> + */
> +static struct rte_graph_feature_arc_register failed_arc3 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_valid_feature,
> +       .max_indexes =3D 1,
> +       /* start_node not provided */
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc3)
> +
> +/* failed_arc4
> + * - start_node not provided
> + */
> +static struct rte_graph_feature_arc_register failed_arc4 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_valid_feature,
> +       .max_indexes =3D 5,
> +       .start_node =3D &dummy1,
> +       /* start_node fn not provided */
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc4);
> +
> +/* failed_arc5
> + * - end_feature has mismatch arc_name
> + */
> +static struct rte_graph_feature_arc_register failed_arc5 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_mismatch_arc_name,
> +       .max_indexes =3D 5,
> +       .start_node =3D &dummy1,
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc5);
> +
> +/* failed_arc6
> + * - end_feature does not have feature_node
> + */
> +static struct rte_graph_feature_arc_register failed_arc6 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_no_feature_node,
> +       .max_indexes =3D 5,
> +       .start_node =3D &dummy1,
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc6);
> +
> +/* failed_arc7
> + * - end_feature does not have feature_fn
> + */
> +static struct rte_graph_feature_arc_register failed_arc7 =3D {
> +       .arc_name =3D TEST_FAILED_ARC,
> +       .end_feature =3D &sink_no_feature_fn,
> +       .max_indexes =3D 5,
> +       .start_node =3D &dummy1,
> +       .start_node_feature_process_fn =3D dummy1_fn,
> +};
> +RTE_GRAPH_FEATURE_ARC_REGISTER(failed_arc7);
> +
> +uint16_t
> +arc1_feature1_fn(struct rte_graph *graph, struct rte_node *node,
> +                void **objs, uint16_t nb_objs)
> +{
> +       RTE_SET_USED(graph);
> +       RTE_SET_USED(node);
> +       RTE_SET_USED(objs);
> +       RTE_SET_USED(nb_objs);
> +
> +       /* Feature on an arc cannot be called if feature arc is disabled =
*/
> +       fp_test_case_result_failed =3D 1;
> +       fp_error_node =3D node->name;
> +       return 0;
> +}
> +
> +uint16_t
> +arc1_feature1_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                MAX_INDEXES, 0, INTERMEDIATE_FEATURE);
> +}
> +
> +static struct rte_node_register arc1_feature1 =3D {
> +       .name =3D ARC1_FEATURE1,
> +       .process =3D arc1_feature1_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc1_init,
> +};
> +RTE_NODE_REGISTER(arc1_feature1);
> +
> +static struct rte_graph_feature_register feat_arc1_feature1 =3D {
> +       .feature_name =3D ARC1_FEATURE1,
> +       .arc_name =3D TEST_ARC1_NAME,
> +       .feature_process_fn =3D arc1_feature1_fa_fn,
> +       .feature_node =3D &arc1_feature1,
> +       .override_index_cb =3D override_arc2_index,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +RTE_GRAPH_FEATURE_REGISTER(feat_arc1_feature1);
> +
> +uint16_t
> +arc1_feature2_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                MAX_INDEXES, 0, INTERMEDIATE_FEATURE);
> +}
> +
> +static struct rte_node_register arc1_feature2 =3D {
> +       .name =3D ARC1_FEATURE2,
> +       .process =3D arc1_feature2_fa_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc1_init,
> +};
> +RTE_NODE_REGISTER(arc1_feature2);
> +
> +/* add arc1_feature2 later using rte_graph_feature_add()*/
> +static struct rte_graph_feature_register feat_arc1_feature2 =3D {
> +       .feature_name =3D ARC1_FEATURE2,
> +       .arc_name =3D TEST_ARC1_NAME,
> +       .feature_process_fn =3D arc1_feature2_fa_fn,
> +       .feature_node =3D &arc1_feature2,
> +       .runs_after =3D ARC1_FEATURE1,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +
> +uint16_t
> +arc2_feature1_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                OVERRIDE_MAX_INDEX, 1, INTERMEDIATE_FEAT=
URE);
> +}
> +
> +static struct rte_node_register arc2_feature1 =3D {
> +       .name =3D ARC2_FEATURE1,
> +       .process =3D arc2_feature1_fa_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc2_init,
> +};
> +RTE_NODE_REGISTER(arc2_feature1);
> +
> +static struct rte_graph_feature_register feat_arc2_feature1 =3D {
> +       .feature_name =3D ARC2_FEATURE1,
> +       .arc_name =3D TEST_ARC2_NAME,
> +       .feature_process_fn =3D arc2_feature1_fa_fn,
> +       .feature_node =3D &arc2_feature1,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +RTE_GRAPH_FEATURE_REGISTER(feat_arc2_feature1);
> +
> +uint16_t
> +arc2_feature2_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                   void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                OVERRIDE_MAX_INDEX, 1, INTERMEDIATE_FEAT=
URE);
> +}
> +
> +static struct rte_node_register arc2_feature2 =3D {
> +       .name =3D ARC2_FEATURE2,
> +       .process =3D arc2_feature2_fa_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc2_init,
> +};
> +RTE_NODE_REGISTER(arc2_feature2);
> +
> +static struct rte_graph_feature_register feat_arc2_feature2 =3D {
> +       .feature_name =3D ARC2_FEATURE2,
> +       .arc_name =3D TEST_ARC2_NAME,
> +       .feature_process_fn =3D arc2_feature2_fa_fn,
> +       .feature_node =3D &arc2_feature2,
> +       .runs_after =3D ARC2_FEATURE1,
> +       .runs_before =3D ARC2_FEATURE3,
> +       .override_index_cb =3D override_arc2_index,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +RTE_GRAPH_FEATURE_REGISTER(feat_arc2_feature2);
> +
> +uint16_t
> +arc2_feature3_fa_fn(struct rte_graph *graph, struct rte_node *node,
> +                void **objs, uint16_t nb_objs)
> +{
> +       return common_process_fn(graph, node, objs, nb_objs,
> +                                OVERRIDE_MAX_INDEX, 1, INTERMEDIATE_FEAT=
URE);
> +}
> +
> +static struct rte_node_register arc2_feature3 =3D {
> +       .name =3D ARC2_FEATURE3,
> +       .process =3D arc2_feature3_fa_fn,
> +       .nb_edges =3D 0,
> +       .init =3D common_arc2_init,
> +};
> +RTE_NODE_REGISTER(arc2_feature3);
> +
> +static struct rte_graph_feature_register feat_arc2_feature3 =3D {
> +       .feature_name =3D ARC2_FEATURE3,
> +       .arc_name =3D TEST_ARC2_NAME,
> +       .feature_process_fn =3D arc2_feature3_fa_fn,
> +       .feature_node =3D &arc2_feature3,
> +       .runs_after =3D ARC2_FEATURE1,
> +       .notifier_cb =3D update_sp_counters,
> +};
> +RTE_GRAPH_FEATURE_REGISTER(feat_arc2_feature3);
> +
> +static int
> +create_graph(void)
> +{
> +       struct rte_graph_param gconf =3D {
> +               .socket_id =3D SOCKET_ID_ANY,
> +               .nb_node_patterns =3D RTE_DIM(node_names_feature_arc),
> +               .node_patterns =3D node_names_feature_arc,
> +       };
> +
> +       graph_id =3D rte_graph_create("worker0", &gconf);
> +       if (graph_id =3D=3D RTE_GRAPH_ID_INVALID) {
> +               printf("Graph creation failed with error =3D %d\n", rte_e=
rrno);
> +               return TEST_FAILED;
> +       }
> +
> +       return TEST_SUCCESS;
> +}
> +
> +static int
> +destroy_graph(void)
> +{
> +       if (graph_id !=3D RTE_GRAPH_ID_INVALID) {
> +               rte_graph_destroy(graph_id);
> +               graph_id =3D RTE_GRAPH_ID_INVALID;
> +       }
> +
> +       return TEST_SUCCESS;
> +}
> +
> +static int test_perf(uint64_t end_feature_counters)
> +{
> +       struct rte_graph *graph =3D NULL;
> +       int i;
> +
> +       fp_test_case_result_failed =3D 0;
> +       fp_error_node =3D NULL;
> +       fp_end_feature_counters =3D 0;
> +
> +       if (create_graph() < 0) {
> +               printf("Graph creation failed while walk\n");
> +               return TEST_FAILED;
> +       }
> +       graph =3D rte_graph_lookup("worker0");
> +       if (graph) {
> +               for (i =3D 0; i < 10; i++)
> +                       rte_graph_walk(graph);
> +       }
> +       if (destroy_graph() < 0) {
> +               printf("Graph destroy failed while walk\n");
> +               return TEST_FAILED;
> +       }
> +       if (fp_test_case_result_failed) {
> +               printf("Feature arc test failed for node %s\n", fp_error_=
node);
> +               return TEST_FAILED;
> +       }
> +
> +       if (sp_enable_counters &&
> +           (sp_enable_cb_counters !=3D sp_enable_counters)) {
> +               printf("sp_enable_cb_counters mismatch %"PRIu64" !=3D %"P=
RIu64"\n",
> +                      sp_enable_cb_counters, sp_enable_counters);
> +               return TEST_FAILED;
> +       }
> +       if (sp_disable_counters &&
> +           (sp_disable_cb_counters !=3D sp_disable_counters)) {
> +               printf("sp_disable_cb_counters mismatch %"PRIu64" !=3D %"=
PRIu64"\n",
> +                      sp_disable_cb_counters, sp_disable_counters);
> +               return TEST_FAILED;
> +       }
> +       if (fp_end_feature_counters !=3D end_feature_counters) {
> +               printf("end_bufs_counters mismatch %"PRIu64" !=3D %"PRIu6=
4"\n",
> +                      fp_end_feature_counters, end_feature_counters);
> +               return TEST_FAILED;
> +       }
> +       sp_enable_counters =3D 0;
> +       sp_enable_cb_counters =3D 0;
> +       sp_disable_counters =3D 0;
> +       sp_disable_cb_counters =3D 0;
> +       return TEST_SUCCESS;
> +}
> +
> +static int
> +__test_create_feature_arc(rte_graph_feature_arc_t *arcs, uint16_t max_ar=
cs)
> +{
> +       struct rte_graph_feature_arc_register reg;
> +       struct rte_graph_feature_register feat;
> +       rte_graph_feature_arc_t arc;
> +       const char *sample_arc_name =3D "sample_arc";
> +       char arc_name[256];
> +       int n_arcs;
> +
> +       if (rte_graph_feature_arc_init(max_arcs) < 0) {
> +               printf("Feature arc creation failed for arc: %u\n", max_a=
rcs);
> +               return TEST_FAILED;
> +       }
> +
> +       feat.feature_name =3D DUMMY2_STATIC;
> +       feat.feature_process_fn =3D dummy2_fn;
> +       feat.feature_node =3D &dummy2;
> +       feat.feature_node_id =3D dummy2.id;
> +       feat.runs_after =3D NULL;
> +       feat.runs_before =3D NULL;
> +
> +       reg.max_indexes =3D MAX_INDEXES;
> +       reg.max_features =3D 3;
> +       reg.start_node =3D &dummy1;
> +       reg.start_node_feature_process_fn =3D dummy1_fn;
> +       reg.end_feature =3D &feat;
> +       for (n_arcs =3D 0; n_arcs < max_arcs; n_arcs++) {
> +               snprintf(arc_name, sizeof(arc_name), "%s-%u", sample_arc_=
name, n_arcs);
> +               feat.arc_name =3D arc_name;
> +               reg.arc_name =3D arc_name;
> +               if (rte_graph_feature_arc_create(&reg, &arcs[n_arcs]) < 0=
) {
> +                       printf("%s: Test failed for creating arc at index=
 %u\n", arc_name, n_arcs);
> +                       return TEST_FAILED;
> +               }
> +       }
> +
> +       if (rte_graph_feature_arc_create(&arc2_output, NULL) =3D=3D 0) {
> +               printf("Failure: Feature arc %s should have already been =
created\n",
> +                      arc2_output.arc_name);
> +               return TEST_FAILED;
> +       }
> +       /* Verify feature arc created more than max_arcs must fail */
> +       for (n_arcs =3D 0; n_arcs < max_arcs; n_arcs++) {
> +               snprintf(arc_name, sizeof(arc_name), "%s-%u", sample_arc_=
name, n_arcs);
> +               arc =3D RTE_GRAPH_FEATURE_ARC_INITIALIZER;
> +               if (rte_graph_feature_arc_lookup_by_name(arc_name, &arc) =
=3D=3D 0) {
> +                       if (arc !=3D arcs[n_arcs]) {
> +                               printf("%s: Feature arc lookup mismatch f=
or arc [%u, exp: %u]\n",
> +                                      arc_name, arc, arcs[n_arcs]);
> +                               return TEST_FAILED;
> +                       }
> +                       dbg("Feature arc lookup %s succeeded\n", arc_name=
);
> +               } else {
> +                       printf("Feature arc lookup %s failed after creati=
on\n", arc_name);
> +                       return TEST_FAILED;
> +               }
> +       }
> +       return TEST_SUCCESS;
> +}
> +
> +static int
> +test_graph_feature_arc_create(void)
> +{
> +       int ret =3D 0;
> +
> +       ret =3D __test_create_feature_arc(arcs, MAX_FEATURE_ARCS);
> +       if (ret) {
> +               printf("Feature arc creation test failed for %u number of=
 arc create\n",
> +                      MAX_FEATURE_ARCS);
> +               goto test_failed;
> +       }
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_FAILED_ARC, NULL) =
=3D=3D 0) {
> +               printf("Feature arc %s should not have been created\n", T=
EST_FAILED_ARC);
> +               goto test_failed;
> +       }
> +
> +       /* Cleanup to verify recreation */
> +       rte_graph_feature_arc_cleanup();
> +
> +       dbg("Feature arc cleanup done\n");
> +
> +       return TEST_SUCCESS;
> +
> +test_failed:
> +       return TEST_FAILED;
> +}
> +
> +static int
> +graph_feature_arc_setup(void)
> +{
> +       unsigned long i, j;
> +
> +       for (i =3D 0; i <=3D MAX_NODES; i++) {
> +               for (j =3D 0; j < MBUF_NUM; j++)
> +                       mbuf_p[i][j] =3D &mbufs[i][j];
> +       }
> +
> +       return TEST_SUCCESS;
> +
> +}
> +static int
> +test_graph_feature_arc_features_add(void)
> +{
> +       struct rte_graph_feature_arc *arc =3D NULL;
> +       rte_graph_feature_t temp;
> +
> +       if (rte_graph_feature_arc_init(1) < 0) {
> +               printf("Feature arc creation failed just for adding featu=
res\n");
> +               return TEST_FAILED;
> +       }
> +
> +       /* see if duplicates fails */
> +       if (rte_graph_feature_add(&feat_arc2_feature1) =3D=3D 0) {
> +               printf("%s: Feature add failed for adding feature %s\n",
> +                      feat_arc2_feature1.arc_name, feat_arc2_feature1.fe=
ature_name);
> +               goto test_failed;
> +       }
> +
> +       /* Create new arc1 */
> +       arc1_input.end_feature->feature_node_id =3D arc1_input.end_featur=
e->feature_node->id;
> +       if (rte_graph_feature_arc_create(&arc1_input, &arcs[0]) < 0) {
> +               printf("%s: Feature arc creation failed\n", TEST_ARC2_NAM=
E);
> +               goto test_failed;
> +       }
> +
> +       /* Add features to arc1 */
> +       feat_arc1_feature1.feature_node_id =3D feat_arc1_feature1.feature=
_node->id;
> +       if (rte_graph_feature_add(&feat_arc1_feature1) < 0) {
> +               printf("%s: Feature add failed for adding feature %s\n",
> +                      feat_arc1_feature1.arc_name, feat_arc1_feature1.fe=
ature_name);
> +               goto test_failed;
> +       }
> +
> +       feat_arc1_feature2.feature_node_id =3D feat_arc1_feature2.feature=
_node->id;
> +       if (rte_graph_feature_add(&feat_arc1_feature2) < 0) {
> +               printf("%s: Feature add failed for adding feature %s\n",
> +                      feat_arc1_feature2.arc_name, feat_arc1_feature2.fe=
ature_name);
> +       }
> +
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC2_NAME, &arcs[1]=
) < 0) {
> +               printf("%s: Feature arc lookup failed while adding featur=
es\n",
> +                      TEST_ARC2_NAME);
> +               goto test_failed;
> +       }
> +
> +       arc =3D rte_graph_feature_arc_get(arcs[1]);
> +       if (!arc) {
> +               printf("%s: Feature arc ptr cannot be NULL\n",
> +                      TEST_ARC2_NAME);
> +               goto test_failed;
> +       }
> +
> +       /* Make sure number of indexes are overridden by feature*/
> +       if (arc->max_indexes < OVERRIDE_MAX_INDEX) {
> +               printf("%s: Feature arc max_indexes mismatch %u < %u\n",
> +                      TEST_ARC2_NAME, arc->max_indexes, OVERRIDE_MAX_IND=
EX);
> +               goto test_failed;
> +       }
> +
> +       /* arc1_feature1 must be first feature to arcs[0] */
> +       if (!strstr(ARC1_FEATURE1,
> +                   rte_graph_feature_arc_feature_to_name(arcs[0],
> +                                                         feature_cast(0)=
))) {
> +               printf("%s: %s is not the first feature instead %s\n",
> +                      TEST_ARC1_NAME, ARC1_FEATURE1,
> +                      rte_graph_feature_arc_feature_to_name(arcs[0], fea=
ture_cast(0)));
> +               goto test_failed;
> +       }
> +
> +       /* arc1_feature2 must be second feature to arcs[0] */
> +       if (!strstr(ARC1_FEATURE2,
> +                   rte_graph_feature_arc_feature_to_name(arcs[0],
> +                                                         feature_cast(1)=
))) {
> +               printf("%s: %s is not the second feature instead %s\n",
> +                      TEST_ARC1_NAME, ARC1_FEATURE2,
> +                      rte_graph_feature_arc_feature_to_name(arcs[0], fea=
ture_cast(1)));
> +               goto test_failed;
> +       }
> +
> +       /* Make sure INPUT_STATIC is the last feature in arcs[0] */
> +       temp =3D rte_graph_feature_arc_num_features(arcs[0]);
> +       if (!strstr(INPUT_STATIC,
> +                   rte_graph_feature_arc_feature_to_name(arcs[0],
> +                                                         temp - feature_=
cast(1)))) {
> +               printf("%s: %s is not the last feature instead %s\n",
> +                      TEST_ARC1_NAME, INPUT_STATIC,
> +                      rte_graph_feature_arc_feature_to_name(arcs[0],
> +                                                            temp - featu=
re_cast(1)));
> +               goto test_failed;
> +       }
> +
> +       /* arc2_feature1 must be first feature to arcs[1] */
> +       if (!strstr(ARC2_FEATURE1,
> +                   rte_graph_feature_arc_feature_to_name(arcs[1],
> +                                                         feature_cast(0)=
))) {
> +               printf("%s: %s is not the first feature instead %s\n",
> +                      TEST_ARC2_NAME, ARC2_FEATURE1,
> +                      rte_graph_feature_arc_feature_to_name(arcs[1], fea=
ture_cast(0)));
> +               goto test_failed;
> +       }
> +
> +       /* arc2_feature2 must be second feature to arcs[1] */
> +       if (!strstr(ARC2_FEATURE2,
> +                   rte_graph_feature_arc_feature_to_name(arcs[1],
> +                                                         feature_cast(1)=
))) {
> +               printf("%s: %s is not the second feature instead %s\n",
> +                      TEST_ARC2_NAME, ARC2_FEATURE2,
> +                      rte_graph_feature_arc_feature_to_name(arcs[1], fea=
ture_cast(1)));
> +               goto test_failed;
> +       }
> +
> +       /* arc2_feature3 must be third feature to arcs[1] */
> +       if (!strstr(ARC2_FEATURE3,
> +                   rte_graph_feature_arc_feature_to_name(arcs[1],
> +                                                         feature_cast(2)=
))) {
> +               printf("%s: %s is not the third feature instead %s\n",
> +                      TEST_ARC2_NAME, ARC2_FEATURE3,
> +                      rte_graph_feature_arc_feature_to_name(arcs[1], fea=
ture_cast(2)));
> +               goto test_failed;
> +       }
> +
> +       /* Make sure PKT_FREE is the last feature in arcs[1] */
> +       temp =3D rte_graph_feature_arc_num_features(arcs[1]);
> +       if (!strstr(PKT_FREE_STATIC,
> +                   rte_graph_feature_arc_feature_to_name(arcs[1],
> +                                                         temp - feature_=
cast(1)))) {
> +               printf("%s: %s is not the last feature instead %s\n",
> +                      TEST_ARC2_NAME, PKT_FREE_STATIC,
> +                      rte_graph_feature_arc_feature_to_name(arcs[1],
> +                                                            temp - featu=
re_cast(1)));
> +               goto test_failed;
> +       }
> +
> +       /* Make sure feature is connected to end feature */
> +       if (get_edge(&arc2_feature1, &node_pkt_free, NULL)) {
> +               printf("%s: Edge not found between %s and %s\n",
> +                      TEST_ARC2_NAME, ARC2_FEATURE1, PKT_FREE_STATIC);
> +               goto test_failed;
> +       }
> +
> +       if (create_graph() < 0) {
> +               printf("Graph creation failed while adding features\n");
> +               goto test_failed;
> +       }
> +       if (destroy_graph() < 0) {
> +               printf("Graph destroy failed while adding features\n");
> +               goto test_failed;
> +       }
> +       return TEST_SUCCESS;
> +test_failed:
> +       rte_graph_feature_arc_cleanup();
> +       return TEST_FAILED;
> +}
> +
> +static int
> +test_graph_feature_arc_feature_enable(void)
> +{
> +       uint32_t  n_indexes, n_features, count =3D 0;
> +       struct rte_node_register *parent, *child;
> +       struct rte_graph_feature_arc *arc;
> +       rte_graph_feature_data_t fdata;
> +       char *feature_name =3D NULL;
> +       rte_edge_t edge1, edge2;
> +       uint16_t user_data;
> +
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC1_NAME, &arcs[0]=
) < 0) {
> +               printf("%s: Feature arc lookup failed while adding featur=
es\n",
> +                      TEST_ARC1_NAME);
> +               return TEST_FAILED;
> +       }
> +
> +       arc =3D rte_graph_feature_arc_get(arcs[0]);
> +
> +       if (rte_graph_feature_arc_is_any_feature_enabled(arc)) {
> +               printf("%s: Feature arc should not have any feature enabl=
ed by now\n",
> +                      TEST_ARC1_NAME);
> +               return TEST_FAILED;
> +       }
> +
> +       if (rte_graph_feature_arc_num_enabled_features(arcs[0])) {
> +               printf("%s: Feature arc should not have any_feature() ena=
bled by now\n",
> +                      TEST_ARC1_NAME);
> +               return TEST_FAILED;
> +       }
> +       /*
> +        * On interface 0, enable feature 0,
> +        * On interface 1, enable feature 1 and so on so forth
> +        *
> +        * later verify first feature on every interface index is unique
> +        * and check [rte_edge, user_data] retrieved via fast path APIs
> +        */
> +       for (n_indexes =3D 0; n_indexes < arc->max_indexes; n_indexes++) =
{
> +               n_features =3D n_indexes % RTE_DIM(arc1_feature_seq);
> +               feature_name =3D rte_graph_feature_arc_feature_to_name(ar=
cs[0], n_features);
> +               if (strncmp(feature_name, arc1_feature_seq[n_features],
> +                           RTE_GRAPH_NAMESIZE)) {
> +                       printf("%s: Feature(%u) seq mismatch [found: %s, =
exp: %s]\n",
> +                              TEST_ARC1_NAME, n_features, feature_name,
> +                              arc1_feature_seq[n_features]);
> +                       return TEST_FAILED;
> +               }
> +               user_data =3D compute_unique_user_data(arc->start_node->n=
ame, feature_name,
> +                                                    n_indexes);
> +               /* negative test case. enable feature on invalid index */
> +               if (!n_indexes && (rte_graph_feature_enable(arcs[0], 6553=
5, feature_name,
> +                                                           user_data, NU=
LL) =3D=3D 0)) {
> +                       printf("%s: Feature %s should not be enabled on i=
nvalid index\n",
> +                              TEST_ARC1_NAME, feature_name);
> +                       return TEST_FAILED;
> +               }
> +               if (rte_graph_feature_enable(arcs[0], n_indexes, feature_=
name,
> +                                        user_data, NULL) < 0) {
> +                       printf("%s: Feature enable failed for %s on index=
 %u\n",
> +                              TEST_ARC1_NAME, feature_name, n_indexes);
> +                       return TEST_FAILED;
> +               }
> +               sp_enable_counters++;
> +               /* has any feature should be valid */
> +               if (!rte_graph_feature_arc_is_any_feature_enabled(arc)) {
> +                       printf("%s: Feature arc should have any_feature e=
nabled by now\n",
> +                              TEST_ARC1_NAME);
> +                       return TEST_FAILED;
> +               }
> +               if ((count + 1) !=3D rte_graph_feature_arc_num_enabled_fe=
atures(arcs[0])) {
> +                       printf("%s: Number of enabled mismatches [found: =
%u, exp: %u]\n",
> +                              TEST_ARC1_NAME,
> +                              rte_graph_feature_arc_num_enabled_features=
(arcs[0]),
> +                              count + 1);
> +                       return TEST_FAILED;
> +               }
> +               count++;
> +       }
> +       /* Negative test case */
> +       user_data =3D compute_unique_user_data(arc->start_node->name, ARC=
2_FEATURE1, 1);
> +       if (!rte_graph_feature_enable(arcs[0], 1 /* index */, ARC2_FEATUR=
E1, user_data, NULL)) {
> +               printf("%s: Invalid feature %s is enabled on index 1\n",
> +                      TEST_ARC1_NAME, ARC2_FEATURE1);
> +               return TEST_FAILED;
> +       }
> +       /* Duplicate enable */
> +       if (!rte_graph_feature_enable(arcs[0], 1 /* index */, ARC1_FEATUR=
E2, user_data, NULL)) {
> +               printf("%s: Duplicate feature %s shouldn't be enabled aga=
in on index 1\n",
> +                      TEST_ARC1_NAME, ARC1_FEATURE2);
> +               return TEST_FAILED;
> +       }
> +       for (n_indexes =3D 0; n_indexes < arc->max_indexes; n_indexes++) =
{
> +               if (!rte_graph_feature_data_first_feature_get(arc, n_inde=
xes, &fdata, &edge2)) {
> +                       printf("%s: FP first feature data get failed for =
index %u\n",
> +                              TEST_ARC1_NAME, n_indexes);
> +                       return TEST_FAILED;
> +               }
> +               parent =3D arc->start_node;
> +               if (0 =3D=3D (n_indexes % RTE_DIM(arc1_feature_seq)))
> +                       child =3D &arc1_feature1;
> +               else if (1 =3D=3D (n_indexes % RTE_DIM(arc1_feature_seq))=
)
> +                       child =3D &arc1_feature2;
> +               else
> +                       child =3D &node_input;
> +
> +               if (get_edge(parent, child, &edge1)) {
> +                       printf("%s: Edge not found between %s and %s\n",
> +                              TEST_ARC1_NAME, parent->name, child->name)=
;
> +                       return TEST_FAILED;
> +               }
> +               if (edge1 !=3D edge2) {
> +                       printf("%s: Edge mismatch for first feature on in=
dex %u [%u, exp: %u]\n",
> +                              TEST_ARC1_NAME, n_indexes, edge2, edge1);
> +                       return TEST_FAILED;
> +               }
> +               if (compute_unique_user_data(parent->name, child->name, n=
_indexes) !=3D
> +                   rte_graph_feature_data_app_cookie_get(arc, fdata)) {
> +                       printf("%s/idx: %u: Cookie mismatch for first fea=
ture [%u, exp: %u]\n",
> +                              TEST_ARC1_NAME, n_indexes,
> +                              rte_graph_feature_data_app_cookie_get(arc,=
 fdata),
> +                              compute_unique_user_data(parent->name, chi=
ld->name, n_indexes));
> +                       return TEST_FAILED;
> +               }
> +       }
> +       arc =3D rte_graph_feature_arc_get(arcs[1]);
> +       for (n_indexes =3D 0; n_indexes < arc->max_indexes; n_indexes++) =
{
> +               n_features =3D n_indexes % RTE_DIM(arc2_feature_seq);
> +               feature_name =3D rte_graph_feature_arc_feature_to_name(ar=
cs[1], n_features);
> +               if (strncmp(feature_name, arc2_feature_seq[n_features],
> +                           RTE_GRAPH_NAMESIZE)) {
> +                       printf("%s: Feature(%u) seq mismatch [found: %s, =
exp: %s]\n",
> +                              arc->feature_arc_name, n_features, feature=
_name,
> +                              arc2_feature_seq[n_features]);
> +                       return TEST_FAILED;
> +               }
> +               user_data =3D compute_unique_user_data(arc->start_node->n=
ame, feature_name,
> +                                                    n_indexes);
> +               if (rte_graph_feature_enable(arcs[1], n_indexes, feature_=
name,
> +                                        user_data, NULL) < 0) {
> +                       printf("%s: Feature enable failed for %s on index=
 %u\n",
> +                              TEST_ARC2_NAME, feature_name, n_indexes);
> +                       return TEST_FAILED;
> +               }
> +               sp_enable_counters++;
> +       }
> +
> +       return test_perf((2 * MBUF_NUM));
> +}
> +
> +static int
> +test_graph_feature_arc_feature_disable(void)
> +{
> +       struct rte_graph_feature_arc *arc;
> +       uint32_t  n_indexes, n_features;
> +       char *feature_name =3D NULL;
> +
> +       arc =3D rte_graph_feature_arc_get(arcs[0]);
> +       for (n_indexes =3D 0; n_indexes < arc->max_indexes; n_indexes++) =
{
> +               n_features =3D n_indexes % RTE_DIM(arc1_feature_seq);
> +               feature_name =3D rte_graph_feature_arc_feature_to_name(ar=
cs[0], n_features);
> +               if (rte_graph_feature_disable(arcs[0], n_indexes, feature=
_name, NULL)) {
> +                       printf("%s: feature disable failed for %s on inde=
x %u\n",
> +                              arc->feature_arc_name, feature_name, n_ind=
exes);
> +                       return TEST_FAILED;
> +               }
> +               sp_disable_counters++;
> +       }
> +
> +       arc =3D rte_graph_feature_arc_get(arcs[1]);
> +       for (n_indexes =3D 0; n_indexes < arc->max_indexes; n_indexes++) =
{
> +               n_features =3D n_indexes % RTE_DIM(arc2_feature_seq);
> +               feature_name =3D rte_graph_feature_arc_feature_to_name(ar=
cs[1], n_features);
> +               if (rte_graph_feature_disable(arcs[1], n_indexes, feature=
_name, NULL)) {
> +                       printf("%s: feature disable failed for %s on inde=
x %u\n",
> +                              arc->feature_arc_name, feature_name, n_ind=
exes);
> +                       return TEST_FAILED;
> +               }
> +               sp_disable_counters++;
> +       }
> +       /* All packets should exit */
> +       return test_perf((2 * MBUF_NUM));
> +}
> +
> +static int
> +test_graph_feature_arc_destroy(void)
> +{
> +       rte_graph_feature_arc_t arc;
> +
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC1_NAME, &arc)) {
> +               printf("Feature arc lookup failed for %s\n", TEST_ARC1_NA=
ME);
> +               return TEST_FAILED;
> +       }
> +
> +       if (arc !=3D arcs[0]) {
> +               printf("Feature arc lookup mismatch for %s [%u, exp: %u]\=
n",
> +                      TEST_ARC1_NAME, arc, arcs[0]);
> +               return TEST_FAILED;
> +       }
> +
> +       if (rte_graph_feature_arc_destroy(arc)) {
> +               printf("Feature arc destroy failed for %s\n", TEST_ARC1_N=
AME);
> +               return TEST_FAILED;
> +       }
> +
> +       if (rte_graph_feature_arc_lookup_by_name(TEST_ARC2_NAME, &arc)) {
> +               printf("Feature arc lookup success after destroy for %s\n=
", TEST_ARC2_NAME);
> +               return TEST_FAILED;
> +       }
> +
> +       if (arc !=3D arcs[1]) {
> +               printf("Feature arc lookup mismatch for %s [%u, exp: %u]\=
n",
> +                      TEST_ARC2_NAME, arc, arcs[1]);
> +               return TEST_FAILED;
> +       }
> +       if (rte_graph_feature_arc_destroy(arc)) {
> +               printf("Feature arc destroy failed for %s\n", TEST_ARC2_N=
AME);
> +               return TEST_FAILED;
> +       }
> +       return TEST_SUCCESS;
> +}
> +
> +static void
> +graph_feature_arc_teardown(void)
> +{
> +       if (graph_id !=3D RTE_GRAPH_ID_INVALID)
> +               rte_graph_destroy(graph_id);
> +
> +       rte_graph_feature_arc_cleanup();
> +}
> +
> +static struct unit_test_suite graph_feature_arc_testsuite =3D {
> +       .suite_name =3D "Graph Feature arc library test suite",
> +       .setup =3D graph_feature_arc_setup,
> +       .teardown =3D graph_feature_arc_teardown,
> +       .unit_test_cases =3D {
> +               TEST_CASE(test_graph_feature_arc_create),
> +               TEST_CASE(test_graph_feature_arc_features_add),
> +               TEST_CASE(test_graph_feature_arc_feature_enable),
> +               TEST_CASE(test_graph_feature_arc_feature_disable),
> +               TEST_CASE(test_graph_feature_arc_destroy),
> +               TEST_CASES_END(), /**< NULL terminate unit test array */
> +       },
> +};
> +
> +static int
> +graph_feature_arc_autotest_fn(void)
> +{
> +       return unit_test_suite_runner(&graph_feature_arc_testsuite);
> +}
> +
> +REGISTER_FAST_TEST(graph_feature_arc_autotest, true, true, graph_feature=
_arc_autotest_fn);
> +#endif /* !RTE_EXEC_ENV_WINDOWS */
> --
> 2.43.0
>
