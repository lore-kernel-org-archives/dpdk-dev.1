Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE9CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 08:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB031402E1;
	Mon, 10 Nov 2025 09:50:31 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7D27B400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:50:29 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4ed614777a3so24367661cf.2
 for <dev@dpdk.org>; Mon, 10 Nov 2025 00:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762764629; x=1763369429; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FF78OTQdIn0qdZoC+ejdTLTNSJ3u8UezBgk5LOUHEBc=;
 b=ASPNPb09koAx9wuc4khSjl9Pmt3tQGJDEQ2GBeCIqG1T0I9w7Hd0pjwrY1FgI0NRUw
 QM048b9Shkp5YJjEUTwLgC8F8OtCfF94alc24U5Z94+S0czjk+MtrFsk3QOXLJ1jP8xc
 ETsYJD27FOG9wOfU8zqvKMS64C3rSo4BVlVpmd/WFkgY/WCxrQIx2dtMLVfUZLAnjllN
 qjTbstT180jiY4iv5cuLk3FHS64qILgK1VtqbrbRGQeuAsh4/uFdMdzoh2yklmAH/kDN
 9Ll3aOpgP9wprM8+dnU6tsCRh0oZuoOZHWvifG4ARIIaz4dhbAVivjKxE00FRx3wMR3j
 +IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762764629; x=1763369429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FF78OTQdIn0qdZoC+ejdTLTNSJ3u8UezBgk5LOUHEBc=;
 b=RK3MHq3Kiolb6sE9P8Ha5fZm0LR3MJdawO9vJzYUiUpxiZz4At4gSyhc8QFTOhs8uT
 6K9QThNUUs6/Uj8S4U+w9rtSSAQdnNvZwJe7mJQB2A0GT/LxeQTnkC3SHvyDoF47eod7
 AEozXHImR2E5/qXfW7kDoPBg1xh72fTfqdUTZ+KqwPLfQt/OMMQy5uT5648VjlLXC3M5
 /ubzkeZWM2E+c7mq6d6XZwbOjpjwR+s6W5b49tP6yEG/HEP78+77OyQtnz6cg3XDFcoG
 4pyD8r5zQOMl9VzKXlK8HRFL91XEIHFHeYRFpzqVzIeMuUcuv98ncQAa5GGw7g1ZnZps
 Ceog==
X-Gm-Message-State: AOJu0YxH/TlPYRocbJb3mzbuNxtP8gwlmZyuLSqaj47aZA6s4NppzWyI
 USs2sQg/otUnjc+SYvIRFBf0+p+QeFNMIKtItspynYx2+gk+ZCq230CoPf0E8mxKUUNHjjQ41vH
 wCPHMy788aftIgalewzDsEdk3RiG4dl4=
X-Gm-Gg: ASbGncv/ffvRtyqOCYI5f/T5ZcsJQcfqSNR7YiKA1NVFNPRhUt6kfgX3+8zQ4FcmPAK
 fHXiyFy1AcPb5uhqmJn7cyms+DOLzX+6XZbqqqUoJRkM8tNVbohcuik6rYTocSxuXuVvXb5WKQJ
 BT/GzFvISPcbkKjNIJde01rK+v6E4nZuKVIVsV6y0WiISexaYyP5FExXbnU5/aqRemedmakk/PQ
 V3EpkFyiVlAT1Pu7D4GrrClxpfAvkYMosW245K+u7Uo7Jh9Yf81JqZjVoWRK2EvgN6GhA==
X-Google-Smtp-Source: AGHT+IGDjImT8bnd3McIazayy40h9vPo89U6tcSM6XsDYmRXGH7X5XlpIRq++oN0wYg0Qv9rZ44SXKTjO+mYzrf5hrI=
X-Received: by 2002:a05:622a:206:b0:4ed:1cf:1335 with SMTP id
 d75a77b69052e-4eda4f0672bmr95770141cf.36.1762764628593; Mon, 10 Nov 2025
 00:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20251031221304.394997-2-rjarry@redhat.com>
In-Reply-To: <20251031221304.394997-2-rjarry@redhat.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 10 Nov 2025 14:20:02 +0530
X-Gm-Features: AWmQ_bmm44Y1DkcVtMIqqAFtsXVQ7SXwULxADS2ThaVz9qX9Lqw-3Z42xASI2YE
Message-ID: <CALBAE1Mhz+R=g7WyyNdx5vHugjL7ZFdYMbtrzzYnNXGA7SkigQ@mail.gmail.com>
Subject: Re: [PATCH dpdk] graph: fix use-after-free when updating edges with
 active graphs
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 stable@dpdk.org
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

On Sat, Nov 1, 2025 at 3:43=E2=80=AFAM Robin Jarry <rjarry@redhat.com> wrot=
e:
>
> After creating at least one graph and calling rte_node_edge_update to
> add a new edge on a node which is in use in the graph, the node memory
> is reallocated but the active graph still has a pointer to the freed
> memory.
>
> When destroying the graph, it causes a use-after-free error detected by
> libasan:
>
> ERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x7c4baa5e4da8 thread T0
>     #0 0x0000005ad224 in graph_node_fini lib/graph/graph.c:256
>     #1 0x0000005ae657 in rte_graph_destroy lib/graph/graph.c:504
>     ...
>
> freed by thread T0 here:
>     #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
>     #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
>     #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
>     ...
>
> previously allocated by thread T0 here:
>     #0 0x7f1bac4e5e4b in realloc.part.0 (/lib64/libasan.so.8+0xe5e4b)
>     #1 0x0000005ab6d7 in edge_update lib/graph/node.c:271
>     #2 0x0000005abb1b in rte_node_edge_update lib/graph/node.c:339
>     ...
>
> Use malloc+memcpy and add an internal function to replace all references
> to the old node memory before freeing it.
>
> Cc: stable@dpdk.org
> Fixes: c59dac2ca14a ("graph: implement node operations")

Acked-by: Jerin Jacob <jerinj@marvell.com>


>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/graph/graph.c         | 14 ++++++++++++++
>  lib/graph/graph_private.h | 12 ++++++++++++
>  lib/graph/node.c          |  6 +++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/lib/graph/graph.c b/lib/graph/graph.c
> index 61159edc7261..6911ea8abeed 100644
> --- a/lib/graph/graph.c
> +++ b/lib/graph/graph.c
> @@ -277,6 +277,20 @@ graph_node_fini(struct graph *graph)
>                                                        graph_node->node->=
name));
>  }
>
> +void
> +graph_node_replace_all(struct node *old, struct node *new)
> +{
> +       struct graph_node *graph_node;
> +       struct graph *graph;
> +
> +       STAILQ_FOREACH(graph, &graph_list, next) {
> +               STAILQ_FOREACH(graph_node, &graph->node_list, next) {
> +                       if (graph_node->node =3D=3D old)
> +                               graph_node->node =3D new;
> +               }
> +       }
> +}
> +
>  static struct rte_graph *
>  graph_mem_fixup_node_ctx(struct rte_graph *graph)
>  {
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
> index 21912c0ae63f..26cdc6637192 100644
> --- a/lib/graph/graph_private.h
> +++ b/lib/graph/graph_private.h
> @@ -299,6 +299,18 @@ int graph_node_has_edge_to_src_node(struct graph *gr=
aph);
>   */
>  int graph_node_has_loop_edge(struct graph *graph);
>
> +/**
> + * @internal
> + *
> + * Replace all pointers of a given node with another one in all active g=
raphs.
> + *
> + * @param old
> + *   Node pointer to replace in all graphs.
> + * @param new
> + *   Updated pointer.
> + */
> +void graph_node_replace_all(struct node *old, struct node *new);
> +
>  /**
>   * @internal
>   *
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index cae1c809edc4..e3359fe490a5 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -325,11 +325,15 @@ edge_update(struct node *node, struct node *prev, r=
te_edge_t from,
>         need_realloc =3D max_edges > node->nb_edges;
>         if (need_realloc) {
>                 sz =3D sizeof(struct node) + (max_edges * RTE_NODE_NAMESI=
ZE);
> -               new_node =3D realloc(node, sz);
> +               new_node =3D malloc(sz);
>                 if (new_node =3D=3D NULL) {
>                         rte_errno =3D ENOMEM;
>                         goto restore;
>                 } else {
> +                       sz =3D sizeof(*node) + (node->nb_edges * RTE_NODE=
_NAMESIZE);
> +                       memcpy(new_node, node, sz);
> +                       graph_node_replace_all(node, new_node);
> +                       free(node);
>                         node =3D new_node;
>                 }
>         }
> --
> 2.51.1
>
