Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D483C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5853E402BC;
	Thu,  6 Feb 2025 21:13:18 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 713364026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:13:17 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2166360285dso25510745ad.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738872796; x=1739477596; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9y1Wx5d36bHP1tIhz2Awy+z1sIcrZmnxy8iEXDxNFnc=;
 b=UUKD8DVcTh1vXl8LyPxgURXm3tUEuMjhr/KkZ090+D5lb70fuwrqZlTSQBVjlbEuek
 qY10iwSx71n/KGIjffEjiKOkMZKiTATsNfX+ZFxjGvR8Ak5hlveJo3/NKjZyTbrExQBR
 j2G6sAtH7aB1jfveG1HENhVqTrHBQw0y4vCS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872796; x=1739477596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9y1Wx5d36bHP1tIhz2Awy+z1sIcrZmnxy8iEXDxNFnc=;
 b=TYl2BG8pc49BJSOuYMgvE23+EGUOlz9a6870lxEOFfZ8yn1DlONDpoqnzzCx0wnrH8
 FsSSmFh3+H1ACw7ighaWPn+WlDifUR02nsGo9/OXFhMO4zNhtYQ1fhaj9FvzJFCVO/Hu
 +r9hSTnVkQiHGlQhijCDtOHolxymaDSodO/1qUpx0QhKuSdgAoCHBxja36RKPziSPNet
 d3td0uNkON524agHrbOdLT6iM9FggkXRrmxfy+nQnum5+/OsrU8F4Fb2IUdNt7fe5Oar
 39QFhLsY3Z3+wFnCi6rpxP4ZcMyaqr9IWBw/9ctcblaxcwy39IXGWTaeK6glKXwmpW3Q
 VYZA==
X-Gm-Message-State: AOJu0YyGsE8onlWM29n14uwFS5vHtuHjcFTpJGTTdA21An8Rb1gxwNOn
 RTwutAP1S7uNVp9y89JZEbNeKBogkWuUBl3aJLbGLSS9VpNDDWujtb3y17vL7+tXD5FGUslImJI
 /2sOyQKztnG9b9MkL9sVYdbmHE3YvGZFjcXRT5g==
X-Gm-Gg: ASbGncuAHWjE+dk0mCFwWIK5ZdgnnXh8bC5V1UgMSwENJyvz7CsEuCRnEl7UFx2nb/M
 a6f3oYIxZ1jdx88NV4FuMYRwqy3rTcWkUrjOFsOz85gi84THuSchealzGcvzNolgH3X0SgfY4x/
 XSapVy7yA7IfNGkByiQ4PUMI5a7GetIg==
X-Google-Smtp-Source: AGHT+IHazpBJAtwVjhYzDT3qgV2Ox6cdkyveofvwNXyLArg3XTEHuh320ZCAXPhNIB8IfJWg0dchl9voWz8XVr3UPZY=
X-Received: by 2002:a17:903:1c8:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21f4e702dd6mr6652955ad.27.1738872796313; Thu, 06 Feb 2025
 12:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20241216014353.2036-1-chcchc88@163.com>
 <20250206025322.2182-1-chcchc88@163.com>
In-Reply-To: <20250206025322.2182-1-chcchc88@163.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Feb 2025 15:10:06 -0500
X-Gm-Features: AWEUYZlP2z8r7yZkf_2hhKA16PFlN7uRfWwaUkxc1TaCbEIvpXElO5OkroBipc0
Message-ID: <CAJvnSUB4kYHNQ83pJjvVwODSztSrEDFVq2xnY_8-KNMMZQg=9w@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] graph: mcore: optimize graph search
To: Huichao Cai <chcchc88@163.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000055a07d062d7edf11"
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

--00000000000055a07d062d7edf11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-intel-Performance

Triggering a retest due to testbed instability yesterday.

On Wed, Feb 5, 2025 at 9:53=E2=80=AFPM Huichao Cai <chcchc88@163.com> wrote=
:

> In the function __rte_graph_mcore_dispatch_sched_node_enqueue,
> use a slower loop to search for the graph, modify the search logic
> to record the result of the first search, and use this record for
> subsequent searches to improve search speed.
>
> Signed-off-by: Huichao Cai <chcchc88@163.com>
> ---
>  devtools/libabigail.abignore               |  5 +++++
>  doc/guides/rel_notes/release_25_03.rst     |  1 +
>  lib/graph/rte_graph_model_mcore_dispatch.c | 11 +++++++----
>  lib/graph/rte_graph_worker_common.h        |  1 +
>  4 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
> index 21b8cd6113..8876aaee2e 100644
> --- a/devtools/libabigail.abignore
> +++ b/devtools/libabigail.abignore
> @@ -33,3 +33,8 @@
>  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
>  ; Temporary exceptions till next major ABI version ;
>  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
> +[suppress_type]
> +        name =3D rte_node
> +        has_size_change =3D no
> +        has_data_member_inserted_between =3D
> +{offset_after(original_process), offset_of(xstat_off)}
> \ No newline at end of file
> diff --git a/doc/guides/rel_notes/release_25_03.rst
> b/doc/guides/rel_notes/release_25_03.rst
> index 269ab6f68a..16a888fd19 100644
> --- a/doc/guides/rel_notes/release_25_03.rst
> +++ b/doc/guides/rel_notes/release_25_03.rst
> @@ -150,6 +150,7 @@ ABI Changes
>
>  * No ABI change that would break compatibility with 24.11.
>
> +* graph: Added ``graph`` field to the ``dispatch`` structure in the
> ``rte_node`` structure.
>
>  Known Issues
>  ------------
> diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c
> b/lib/graph/rte_graph_model_mcore_dispatch.c
> index a590fc9497..a81d338227 100644
> --- a/lib/graph/rte_graph_model_mcore_dispatch.c
> +++ b/lib/graph/rte_graph_model_mcore_dispatch.c
> @@ -118,11 +118,14 @@ __rte_graph_mcore_dispatch_sched_node_enqueue(struc=
t
> rte_node *node,
>                                               struct rte_graph_rq_head *r=
q)
>  {
>         const unsigned int lcore_id =3D node->dispatch.lcore_id;
> -       struct rte_graph *graph;
> +       struct rte_graph *graph =3D node->dispatch.graph;
>
> -       SLIST_FOREACH(graph, rq, next)
> -               if (graph->dispatch.lcore_id =3D=3D lcore_id)
> -                       break;
> +       if (unlikely((!graph) || (graph->dispatch.lcore_id !=3D lcore_id)=
)) {
> +               SLIST_FOREACH(graph, rq, next)
> +                       if (graph->dispatch.lcore_id =3D=3D lcore_id)
> +                               break;
> +               node->dispatch.graph =3D graph;
> +       }
>
>         return graph !=3D NULL ? __graph_sched_node_enqueue(node, graph) =
:
> false;
>  }
> diff --git a/lib/graph/rte_graph_worker_common.h
> b/lib/graph/rte_graph_worker_common.h
> index d3ec88519d..aef0f65673 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -110,6 +110,7 @@ struct __rte_cache_aligned rte_node {
>                         unsigned int lcore_id;  /**< Node running lcore. =
*/
>                         uint64_t total_sched_objs; /**< Number of objects
> scheduled. */
>                         uint64_t total_sched_fail; /**< Number of
> scheduled failure. */
> +                       struct rte_graph *graph;  /**< Graph correspondin=
g
> to lcore_id. */
>                 } dispatch;
>         };
>
> --
> 2.33.0
>
>

--00000000000055a07d062d7edf11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<div><br></div>=
<div>Triggering a retest due to testbed instability yesterday.</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Feb 5, 2025 at 9:53=E2=80=AFPM Huichao Cai &lt;<a h=
ref=3D"mailto:chcchc88@163.com">chcchc88@163.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">In the function __rte_graph=
_mcore_dispatch_sched_node_enqueue,<br>
use a slower loop to search for the graph, modify the search logic<br>
to record the result of the first search, and use this record for<br>
subsequent searches to improve search speed.<br>
<br>
Signed-off-by: Huichao Cai &lt;<a href=3D"mailto:chcchc88@163.com" target=
=3D"_blank">chcchc88@163.com</a>&gt;<br>
---<br>
=C2=A0devtools/libabigail.abignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
=C2=A0doc/guides/rel_notes/release_25_03.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +=
<br>
=C2=A0lib/graph/rte_graph_model_mcore_dispatch.c | 11 +++++++----<br>
=C2=A0lib/graph/rte_graph_worker_common.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
=C2=A04 files changed, 14 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore<br=
>
index 21b8cd6113..8876aaee2e 100644<br>
--- a/devtools/libabigail.abignore<br>
+++ b/devtools/libabigail.abignore<br>
@@ -33,3 +33,8 @@<br>
=C2=A0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<br>
=C2=A0; Temporary exceptions till next major ABI version ;<br>
=C2=A0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;<br>
+[suppress_type]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D rte_node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_size_change =3D no<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_data_member_inserted_between =3D<br>
+{offset_after(original_process), offset_of(xstat_off)}<br>
\ No newline at end of file<br>
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/=
release_25_03.rst<br>
index 269ab6f68a..16a888fd19 100644<br>
--- a/doc/guides/rel_notes/release_25_03.rst<br>
+++ b/doc/guides/rel_notes/release_25_03.rst<br>
@@ -150,6 +150,7 @@ ABI Changes<br>
<br>
=C2=A0* No ABI change that would break compatibility with 24.11.<br>
<br>
+* graph: Added ``graph`` field to the ``dispatch`` structure in the ``rte_=
node`` structure.<br>
<br>
=C2=A0Known Issues<br>
=C2=A0------------<br>
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_gra=
ph_model_mcore_dispatch.c<br>
index a590fc9497..a81d338227 100644<br>
--- a/lib/graph/rte_graph_model_mcore_dispatch.c<br>
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c<br>
@@ -118,11 +118,14 @@ __rte_graph_mcore_dispatch_sched_node_enqueue(struct =
rte_node *node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct rte_graph_rq_head *rq)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned int lcore_id =3D node-&gt;dispat=
ch.lcore_id;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_graph *graph;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_graph *graph =3D node-&gt;dispatch.g=
raph;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SLIST_FOREACH(graph, rq, next)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (graph-&gt;dispa=
tch.lcore_id =3D=3D lcore_id)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely((!graph) || (graph-&gt;dispatch.lc=
ore_id !=3D lcore_id))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SLIST_FOREACH(graph=
, rq, next)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (graph-&gt;dispatch.lcore_id =3D=3D lcore_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node-&gt;dispatch.g=
raph =3D graph;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return graph !=3D NULL ? __graph_sched_node_enq=
ueue(node, graph) : false;<br>
=C2=A0}<br>
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_work=
er_common.h<br>
index d3ec88519d..aef0f65673 100644<br>
--- a/lib/graph/rte_graph_worker_common.h<br>
+++ b/lib/graph/rte_graph_worker_common.h<br>
@@ -110,6 +110,7 @@ struct __rte_cache_aligned rte_node {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned int lcore_id;=C2=A0 /**&lt; Node running lcore. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint64_t total_sched_objs; /**&lt; Number of objects scheduled. =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint64_t total_sched_fail; /**&lt; Number of scheduled failure. =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct rte_graph *graph;=C2=A0 /**&lt; Graph corresponding to lco=
re_id. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } dispatch;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
-- <br>
2.33.0<br>
<br>
</blockquote></div>

--00000000000055a07d062d7edf11--
