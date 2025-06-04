Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6113C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB61C42E46;
	Wed,  4 Jun 2025 18:43:14 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3BD3A4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:43:13 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so60720881cf.3
 for <dev@dpdk.org>; Wed, 04 Jun 2025 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749055392; x=1749660192; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=996eXmhT5t0GeW44HxL3y0dqJggLVUBDa8v1fsy/2Ws=;
 b=gAw4VUgH0SVJy3oLkTJyQOIMCWTiWmDNWYbdJ+xmREt+9HtnuMhzWDT184ik/p7x4e
 eg/QF3olPppl8qutWNST1ugUsPrJwmIfAM0+PCc2NFxxoXIpR7oYrqhJSBlOkxru+LL5
 SbPex49NT0xzCRr+UrC+2WaW8/kSFdhaNY23iS0kpwnAI4oZzFfZQPvToa6QxoovR2pE
 +myeL6GU3FMisWUEty3n2JBnDb5rkab6U1nLrEo5/Vijy2Mp2i+wTtOY0kwazOaO3EYE
 QvPyVFYv9Icg8/Wt/TsYYPPtmmYzfxhON3o0q4XBFzOxTG20ghw+qvD2CZz4e+H3W7m6
 uRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749055392; x=1749660192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=996eXmhT5t0GeW44HxL3y0dqJggLVUBDa8v1fsy/2Ws=;
 b=dI0rz0qHgya4xXUQyppnc5t+nAKZdjS1aIvkvXhTK6qal18p6L1s18Vv9fR7ZZj792
 EaE/RpzRp3XM+zY2mIAOD3wcMFno8w5/WrsNsgNKLJna6x0dSYjR1aeKerRqRNhyQ+iR
 ZU7CPp6cTnBy7y0BPxPU/3i8ihvEhoeHXfJEq0SjsBQaOKo0sbliDkz/ydRyJsOmApUP
 oRXAkzjCiHCtSJaA1Ht6tUAP3KcYCM/nOgKzLc0aWioq4NlpzRhPwpiqZSNw79y/FQV+
 4sMepeje2TXYXKpuGrAVhODg3Y5GQFI+pwTDsQb96gwsJNOKnJ3GRqMvPciKOzpavQTv
 zYJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt1iD4FBQq+4ApcdkarmjmU743oOkpLmInWWpUfSv+YlpY/Y9qwgOhxWZ3G3EIMMQIKYI=@dpdk.org
X-Gm-Message-State: AOJu0YzXu/xDuiKMqSn37qmWqvBBm8MkWMba1JWSn/shzyJART6keDQl
 A5Bukem7YswcF+C3jmjraAc6qnaVP6n9LAqjBjpSDCc07pJ+mDJiEuC7XXW5wBzQW58CpAUbvlV
 uRfU+6YVAbq32kk+SH8GqCalZMCWNjDA=
X-Gm-Gg: ASbGncuCNUc2vGP3OIqPMIWKDo5ntEcURsXIndq1RpFc8yG7KQw3cCLtSL6Ox8iOc3U
 JwiImkLFh99e5gdfq/UQ40kLV5upMPTMaRU5IAVSmY4pSDro6Z32dJ+bty3NKrdgGGIZqniwr6O
 x0pIqxJcmWQbru9EQAByRhntnK+QK9BdXZgvkOxzC6kg==
X-Google-Smtp-Source: AGHT+IGXqq9tx7pCpXKfTF7UfhMnlAibrKBBORrc6wauvLCJfq86Wtx9ZqYGGO9xk9xr2al4+pUsyMzdp954Circ6tE=
X-Received: by 2002:a05:622a:590e:b0:4a5:98ad:5640 with SMTP id
 d75a77b69052e-4a5a578425fmr59154461cf.23.1749055392531; Wed, 04 Jun 2025
 09:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-3-nsaxena@marvell.com>
In-Reply-To: <20250604101259.4181992-3-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 4 Jun 2025 22:12:46 +0530
X-Gm-Features: AX0GCFv9OCnwXXsVn8Yc4dU8Rl0Exyb0MlWOBUXUsJLZph1C04QFhSMKLEJMrOs
Message-ID: <CALBAE1M7cMhYfNUbvqVQy62YTQfF3RnNmhVLYguKvmWEEmpxPQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] graph: add feature arc registrations
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

On Wed, Jun 4, 2025 at 3:43=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> w=
rote:
>
> This patch defines RTE_GRAPH_FEATURE_ARC_REGISTER() and
> RTE_GRAPH_FEATURE_REGISTER() constructors and associated APIs with
> programming guide.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  doc/api/doxy-api-index.md                   |   1 +
>  doc/guides/prog_guide/graph_lib.rst         | 289 +++++++++++
>  doc/guides/prog_guide/img/feature_arc-1.svg | 269 +++++++++++
>  doc/guides/prog_guide/img/feature_arc-2.svg | 511 ++++++++++++++++++++
>  doc/guides/rel_notes/release_25_07.rst      |   7 +
>  lib/graph/graph_feature_arc.c               |  36 ++
>  lib/graph/meson.build                       |   2 +
>  lib/graph/rte_graph_feature_arc.h           | 270 +++++++++++
>  8 files changed, 1385 insertions(+)
>  create mode 100644 doc/guides/prog_guide/img/feature_arc-1.svg
>  create mode 100644 doc/guides/prog_guide/img/feature_arc-2.svg
>  create mode 100644 lib/graph/graph_feature_arc.c
>  create mode 100644 lib/graph/rte_graph_feature_arc.h
>
> diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
> index 5c425a2cb9..a7bdbf892c 100644
> --- a/doc/api/doxy-api-index.md
> +++ b/doc/api/doxy-api-index.md
> @@ -214,6 +214,7 @@ The public API headers are grouped by topics:
>      [table_wm](@ref rte_swx_table_wm.h)
>    * [graph](@ref rte_graph.h):
>      [graph_worker](@ref rte_graph_worker.h)
> +    [graph_feature_arc](@ref rte_graph_feature_arc.h)

Missing ",". See diff

-    [graph_worker](@ref rte_graph_worker.h)
-    [graph_feature_arc](@ref rte_graph_feature_arc.h)
+    [graph_worker](@ref rte_graph_worker.h),
+    [graph_feature_arc](@ref rte_graph_feature_arc.h),



>    * graph_nodes:
>      [eth_node](@ref rte_node_eth_api.h),
>      [ip4_node](@ref rte_node_ip4_api.h),
> diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/=
graph_lib.rst
> index dc6c8c0712..191c8e8a0b 100644
> --- a/doc/guides/prog_guide/graph_lib.rst
> +++ b/doc/guides/prog_guide/graph_lib.rst
> @@ -559,3 +559,292 @@ on success packet is enqueued to ``udp4_input`` nod=
e.
>
>  Hash lookup is performed in ``udp4_input`` node with registered destinat=
ion port
>  and destination port in UDP packet , on success packet is handed to ``ud=
p_user_node``.
> +
> +Graph feature arc

Move this above "Inbuilt Nodes" section as it is Graph related feature.

> +-----------------
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 6b070801de..9740274a16 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -78,6 +78,13 @@ New Features
>
>    See the :doc:`../cryptodevs/zsda` guide for more details on the new dr=
iver.
>
> +* **Added feature arc abstraction in graph library.**

Better to reword as Added feature arc support in graph library
> new file mode 100644
> index 0000000000..56d8f2f34c
> --- /dev/null
> +++ b/lib/graph/rte_graph_feature_arc.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_FEATURE_ARC_H_
> +#define _RTE_GRAPH_FEATURE_ARC_H_
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_common.h>
> +#include <rte_compat.h>
> +#include <rte_debug.h>
> +#include <rte_graph.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * @file
> + *
> + * rte_graph_feature_arc.h


Please check the generated html file of documentation. Some of the
symbols are not resolving. See some examples

  * If a given feature likes to control number of indexes (which is higher =
than
- * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
- * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
+ * rte_graph_feature_arc_register::max_indexes) it can do so by using
+ * rte_graph_feature_arc_register::override_index_cb(). As part of
  * rte_graph_feature_arc_init(), all feature's override_index_cb(), if set=
, are
  * called and with maximum value returned by any of the feature is used fo=
r
  * rte_graph_feature_arc_create()
@@ -126,8 +126,8 @@ extern "C" {
