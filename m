Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FCAC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A495141132;
	Tue, 17 Jun 2025 17:28:17 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id AA030402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:28:16 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7d3da67de87so187780585a.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750174096; x=1750778896; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1LOEkzNFfvKA7XO6U25oVKb8WiBiZvDW69tAPYIn0E=;
 b=jC7hTDjETtlUukeOpV5U/LI0NZx2avKf8Fthnd6usGjdPzSRZzhI2SXEL6EkVlLdc+
 Yu4HiRjC9RgqCv4AFN1PQ0/749Krp9+Y0VVnLJmjTmg9bkGHO9yGh5fgeu6bH1UCRGkQ
 jl2t5HT6yfxaShtWyWT4Vb6TXgnInZ/joEW+QO6Eiu7MwOP2USCAzGG9VEVPQlKQMD26
 niIV2Y4gEQYAu1m6botB+ylbvznGk45e8N29a8MaNBYZRPzGq92t2WcAKGrDIjy2g1vJ
 b+I+mBWsA0kd0QgneVLmX2mpOrgNIj4wP6GhblWEBPMmoQ3zwvlTQk38CbwWhsPYrPic
 uShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750174096; x=1750778896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1LOEkzNFfvKA7XO6U25oVKb8WiBiZvDW69tAPYIn0E=;
 b=U5ZfGJYPY1VW9q4Z8LtOBiKhfOcQNHH+r+tn4KSVmSvyWBcVLgY6RGtS+5lJGPFsIP
 Ygpj9TkOerGy9Gu06SDUMfvjrBW2GSNorIyh0W4zbDj+Es1yfO0hUhvD52gyGG9c8XaH
 ikXs8WVhZpMKRnFukuWG5tYlXir/reVzrFtqAWMSh/1hh6zI8mMBpvmuQTw55ZVKQ3Vi
 aM+KDxO9KollgP68QvXdMrZ5xusNgZZ7WjTBy7+pPuI3PDXBAkYWuAbB+9gQmsFKVHTg
 d7BTkW3d3vuvQRQwWDAE71WtYFwTDtu4ECG8tWb2uSFQG0iFFPvF+I14hkDrbSBHq2U9
 mlnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSstzx0WdA60P6y6Upxj7ToB+LMPtZRFjVk85nhcZKy3yaTcId9aXnMhGTLOv2xApb1p4=@dpdk.org
X-Gm-Message-State: AOJu0YxIi48hkfrXc+v9Ripw7kKvEGRIT5VTPnJl7gouFW2rnDlZ+3A6
 g2QBvtePTfcQMZcmnMSCTwYMhQoekOeMnE/50WwE+L79sSg08P66gJHxvXhFZMItzKuoT01oenO
 F3NscL11etdhnlrrAu658EmGJCoUmE0k=
X-Gm-Gg: ASbGncsd05TXLRVHUOfknwcromy44P9Jat1fGtYx18CdzTqW8cp4BoBlRpsZcPnDo/J
 KoV0rXbxboGlR8o/QGYCXiAf8g++gyT1t15q8ysNUiKjY0ig1OpSDLRkHIT7lFtydB6qwIlRmmE
 X0iPoWbgG5yriAv1YambvDOGqS+4EgJ4MHQ/8+dNosBQ==
X-Google-Smtp-Source: AGHT+IFLBDby0L6dchSu/BGCwVvki19IDUmlKFOM16ib3lIXasyUhw789fh0YyQ4VhUBfAQthdmqR9hAi8NMb4i2cDw=
X-Received: by 2002:a05:620a:2954:b0:7c5:50ab:de07 with SMTP id
 af79cd13be357-7d3c6c1ab9fmr1950822985a.21.1750174095945; Tue, 17 Jun 2025
 08:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250617151339.28794-1-marat.khalili@huawei.com>
 <20250617151339.28794-2-marat.khalili@huawei.com>
In-Reply-To: <20250617151339.28794-2-marat.khalili@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Jun 2025 20:57:49 +0530
X-Gm-Features: AX0GCFvbaFOMvbPIP5ElRbKT_eTvtYsKeLcLQvpzOXLkNtSS6C5X5NqowVTMRWY
Message-ID: <CALBAE1M2Ux9Kr2GvS7BjNLn8nM_DvjWnkhp2pwdESKq-WJeRiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, dev@dpdk.org
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

On Tue, Jun 17, 2025 at 8:44=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
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
> To fix the issue remove `__rte_cache_aligned` attribute from struct
> rte_graph_cluster_stats and struct rte_graph_cluster_node_stats that it
> contains. There is no need to keep them cache-aligned since they are
> only used in the slow path.
>
> Fixes: af1ae8b6a32 ("graph: implement stats")
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>
> v2: Following the suggestions from Jerin Jacob changed the fix to simply
> remove non-default alignment. Although there are many ways to make
> alignment work, I personally agree that it is probably better to keep
> the code simple as long as performance is not an issue.
>
> Although reducing _actual_ alignment of allocated objects would probably
> be a binary compatibility issue, here we are only changing _declared_
> alignment to match the actual one, so it will more likely fix things
> than break them.
>
> devtools/test-meson-builds.sh completes successfully.
>
>  lib/graph/graph_stats.c | 2 +-
>  lib/graph/rte_graph.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
> index 57cd72e7cc..4324717f33 100644
> --- a/lib/graph/graph_stats.c
> +++ b/lib/graph/graph_stats.c
> @@ -29,7 +29,7 @@ struct cluster_node {
>         struct rte_node *nodes[];
>  };
>
> -struct __rte_cache_aligned rte_graph_cluster_stats {
> +struct rte_graph_cluster_stats {
>         /* Header */
>         rte_graph_cluster_stats_cb_t fn;
>         uint32_t cluster_node_size; /* Size of struct cluster_node */
> diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
> index 097d0dc9d5..826204cad9 100644
> --- a/lib/graph/rte_graph.h
> +++ b/lib/graph/rte_graph.h
> @@ -202,7 +202,7 @@ struct rte_graph_cluster_stats_param {
>   *
>   * @see struct rte_graph_cluster_stats_param::fn
>   */
> -struct __rte_cache_aligned rte_graph_cluster_node_stats {
> +struct rte_graph_cluster_node_stats {

This is a fastpath structure. No need to change the alignment here.

>         uint64_t ts;        /**< Current timestamp. */
>         uint64_t calls;     /**< Current number of calls made. */
>         uint64_t objs;      /**< Current number of objs processed. */
> --
> 2.43.0
>
