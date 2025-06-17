Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5AC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 12:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8344A40C35;
	Tue, 17 Jun 2025 14:46:34 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 834E940609
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:46:33 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4a58ebece05so59359091cf.1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750164393; x=1750769193; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQhdN+UM6Q/nJVG+Y2y1xU6STHIQrw8odCfxzWeotP4=;
 b=H9mpjOrQ63Q05dQcPZ5uS0WZRI6d30UcbhznYrEicc96Q7HGmLSxQgDtZV2vvCdCLK
 uYW/pyOVoFgABu/aEIpraRuB6CBDTRljKEHoOiE6DA1BToWYWEqpMEOycxn5flUDXRLY
 DR5U4lQW/wFfN+DqrRI94jwQ5uXEOUaOnlmeh4SUmCX0/n1zEMknPpjchwH04NDC9Wba
 AFimS5qvBY6O51UDu2HWsmWIRGh9I4eIfD32RMTthRFS9eMwyhdFdHKC8ia6237ibR88
 cQ3N9hBR23s8zJEnDAZOeCYGKAHCI0Rr/Sp6PMPcECY1zKipRSn81RoQQhPYKBt2ns5v
 P6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750164393; x=1750769193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQhdN+UM6Q/nJVG+Y2y1xU6STHIQrw8odCfxzWeotP4=;
 b=WFymMt9Ei7JbB3uACKTDOkV7pgIMf9gucyCOe5lESa2X3OzufC/AmzRSM7p4J0gweL
 lQf7F0hd10Q5HJJ/lGmgCgcrVdgV/YNnHco0wzGXbowvB8758edKEDZfkxT8h96CWCmB
 8j/3sq5T1j+K3Xr9koCIqBLVBw9DAqbDl1JWgrHtxaSZl72NqkvpMcHfopziHIqeX9en
 RH9AECHxt9eUy0zadZNi2/gG2QuB1kkHlxfg6vSwrupUAaDeQoVkEBfslsOTdhowixfb
 /w2F1+be81W4wwpBORiP1+Xwn3XxHlQBETm0wWLbUbKswGJSsZjogRts+NlOiagFXkoE
 uLpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu697vwOcqk60EdDUxJxu5ooEf+tcZpYhV4l2zXjnVcTnqRLDL86AnnvVe+hGU25wOrRQ=@dpdk.org
X-Gm-Message-State: AOJu0YwT4dW84LNYJU7A8Lw5q465C0oWG9suAguyZuFNA+mS51vNTA8r
 g51lGL3Z8wimVL0MCd5IzHml20y6rlV+q8lm+WSXEDxIKjdFZ7v96vnesbvrhFCfhWnV1jGv/5n
 xTjAOYnp6YISuykfUOhbzVhd5zmk7NUQ=
X-Gm-Gg: ASbGnctrKcH6rK2AiCBGudjVdy+AX7ZZLsx3uclotNqYPwKevDVTaQ17sWqsoFSj0qb
 6ewjufGEEyowOJ04aKgtGGqBCRudmhT6SJu0n30foSbaavWCmnI+dyA51SY3NUV553H1woRjB9i
 eRLPISpTOzZyQp3wvXHdYExP0ognCwh+ee9JXhedyikQ==
X-Google-Smtp-Source: AGHT+IGKu91VhRzEJjZhxPAFG+UO0O2CzP0YbZ3PFibUsSa769YgD8pTCXP1pp8cBEpDOp9ZYuaD67ZGzKcU1IWrLgo=
X-Received: by 2002:ac8:5e0c:0:b0:4a4:3e89:d5bb with SMTP id
 d75a77b69052e-4a73c631859mr218207721cf.49.1750164392735; Tue, 17 Jun 2025
 05:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250617105209.50526-1-marat.khalili@huawei.com>
 <20250617105209.50526-2-marat.khalili@huawei.com>
In-Reply-To: <20250617105209.50526-2-marat.khalili@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Jun 2025 18:16:05 +0530
X-Gm-Features: AX0GCFsZqzYhfMfWQqXg2Gx1v1mfyhW2LmSrjUhx5jKdH9cN_Qsk2REgw_ikVsc
Message-ID: <CALBAE1N19pB_D6w-LYE0v-vT+RYb7XGoPO-2eTjpgRHw8dzm+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/graph: rte_malloc for cache-aligned structs
To: Marat Khalili <marat.khalili@huawei.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, dev@dpdk.org
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

On Tue, Jun 17, 2025 at 4:32=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> This was flagged by undefined behaviour sanitizer: struct
> rte_graph_cluster_stats is declared as `__rte_cache_aligned` but was
> allocated using stdlib realloc which caused misaligned allocation. More
> than one test needs to be executed in series in order to reproduce the
> problem using graph_autotest, e.g:
>
>     app/dpdk-test --no-huge --no-pci -m128 graph_autotest graph_autotest
>
> First sanitizer message  (similar ones follow):
>
>     lib/graph/graph_stats.c:209:13: runtime error: member access within
>     misaligned address 0x606000008ea0 for type 'struct
>     rte_graph_cluster_stats', which requires 64 byte alignment
>
> To fix the issue replace realloc calls with rte_malloc and rte_realloc
> specifying correct alignment, use rte_free to free the result.
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>


Since this memory is used in slowpath, heap memory is fine.
I think, better fix will be to remove cache alignment from
rte_graph_cluster_stats.
Not sure it will call for ABI change though.Run
devtools/test-meson-builds.sh to validate any ABI breakage.






> ---
>  lib/graph/graph_stats.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
> index 57cd72e7cc..7ae8ee4987 100644
> --- a/lib/graph/graph_stats.c
> +++ b/lib/graph/graph_stats.c
> @@ -203,7 +203,7 @@ stats_mem_init(struct cluster *cluster,
>         cluster_node_size +=3D cluster->nb_graphs * sizeof(struct rte_nod=
e *);
>         cluster_node_size =3D RTE_ALIGN(cluster_node_size, RTE_CACHE_LINE=
_SIZE);
>
> -       stats =3D realloc(NULL, sz);
> +       stats =3D rte_malloc(NULL, sz, RTE_CACHE_LINE_SIZE);
>         if (stats) {
>                 memset(stats, 0, sz);
>                 stats->fn =3D fn;
> @@ -248,7 +248,8 @@ stats_mem_populate(struct rte_graph_cluster_stats **s=
tats_in,
>         }
>
>         /* Hey, it is a new node, allocate space for it in the reel */
> -       stats =3D realloc(stats, stats->sz + stats->cluster_node_size);
> +       stats =3D rte_realloc(stats, stats->sz + stats->cluster_node_size=
,
> +               RTE_CACHE_LINE_SIZE);
>         if (stats =3D=3D NULL)
>                 SET_ERR_JMP(ENOMEM, err, "Realloc failed");
>         *stats_in =3D NULL;
> @@ -301,7 +302,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **s=
tats_in,
>
>         return 0;
>  free:
> -       free(stats);
> +       rte_free(stats);
>  err:
>         return -rte_errno;
>  }
> @@ -309,7 +310,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **s=
tats_in,
>  static void
>  stats_mem_fini(struct rte_graph_cluster_stats *stats)
>  {
> -       free(stats);
> +       rte_free(stats);
>  }
>
>  static void
> --
> 2.43.0
>
