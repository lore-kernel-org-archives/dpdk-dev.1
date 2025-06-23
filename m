Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D48C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 12:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 320E24021F;
	Mon, 23 Jun 2025 14:06:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 091C640151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 14:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750680401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Me2iRv++wfwrE4MV8VgxZcoH5DwjZ6y4tzKQmqO4Ve0=;
 b=bQkhaeCLpzWvRVGT3bfDFhmb+wGR4NtKcbCBPNBJiyjHq8CP6Fqc5gaHKqGeIR4y9S/Qon
 nrGa1evXOKK6A4MMJHkZFUPoPq8/Gnrm+DQDb+HQexgaoiEL450irwbftlBE7Eyj4tHRoq
 9Xnz/ZMsncpe4RkxKGanc7dioLJS45s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-e7Dz0ZidOAuHwNDbPOibCA-1; Mon, 23 Jun 2025 08:06:34 -0400
X-MC-Unique: e7Dz0ZidOAuHwNDbPOibCA-1
X-Mimecast-MFC-AGG-ID: e7Dz0ZidOAuHwNDbPOibCA_1750680393
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553b396258eso1906046e87.3
 for <dev@dpdk.org>; Mon, 23 Jun 2025 05:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680393; x=1751285193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Me2iRv++wfwrE4MV8VgxZcoH5DwjZ6y4tzKQmqO4Ve0=;
 b=RpEnY5G6sTEv0p++WgM+m/e1TZ6yRTRAndrCyDc+8VnaGIztF/rwoIuWbFm3xH8ADX
 8vOD7e0eaz6PSufykqL4OaVy7D2wALryd6FGTehHFv0xgee6L9417wjpHtzu14ia4joa
 td4EPM1D4K4btkO0eFmAp4eK27EY4yEm+TCDKBesfxJRsvk+17MHywt6q59DjCsdkLdt
 YU+FA30SJLMBfM9/po5G4sabgQJxx3H1mvzUkO1DZYNE1gwHMA09kQzSn57s4Yb/T48v
 Mlfzc8bLQ0z2vWkbwUOVPj8lPMvFA34NMazONMJK3rYOU1gGQn8bQsTieodrgGq4kFKT
 OD/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/gJFxhbiKRnzxNSfYkjK1zfWV+4ozgrDXYxB5gwwIBbI3hZ5t4jDnFuEFIlRAo3d9gGQ=@dpdk.org
X-Gm-Message-State: AOJu0YwSJqYPl/el5EAZzKiJvCeZk+shprqPO6a1DtlUl3yIs6JqotJq
 6Jpm0zaa+6lt3An5vCE9ob3XljPw+BI/E9CHxKuTC28NjuewdGknT1AsvzIbCuR93lfiqdcYhXJ
 MDmgCoCoj8/IDXzLH9WnsrBCqUpgyvD73KsJB14QzDEYU+i0p97788YULSvlOp1GoQrnsydQVS+
 1ptv+QU1MqYAtuXEXmQrI=
X-Gm-Gg: ASbGncuFPymTEn1VYh1wbKYJVHTgkJ2/zyqqTL018+qS1Q7FgEUQh65QmPm9sX9mYl5
 cXo7AxYhYUzn6jzTjHgnlx6iPIWmfUPJ3kW+X4sl/u0PJ8U9DB7ivbLvUlrc2B4jWGPQNixoTmL
 5yMOXWSQ==
X-Received: by 2002:a05:6512:3b29:b0:553:399d:58e6 with SMTP id
 2adb3069b0e04-553e3bf3e68mr4153779e87.31.1750680393048; 
 Mon, 23 Jun 2025 05:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW6SXPqZIeJXNDMkyW2JJTk+nuxfF3ZlWoau09g5YLFN4desYKr+JgFhVQuF0cqBQ5cglJVo0oTwggGRAGPDo=
X-Received: by 2002:a05:6512:3b29:b0:553:399d:58e6 with SMTP id
 2adb3069b0e04-553e3bf3e68mr4153758e87.31.1750680392560; Mon, 23 Jun 2025
 05:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250617151339.28794-1-marat.khalili@huawei.com>
In-Reply-To: <20250617151339.28794-1-marat.khalili@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 14:06:20 +0200
X-Gm-Features: AX0GCFsNUZB78FAJA-4kfNs2RawMX9yczgJ-nxpvtKD0sehh88nxmvxJkWcM_Sg
Message-ID: <CAJFAV8zdPShwqG6iahrnzPRX+SkVdM3h6beBj+P7vxLB58vt0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/graph: lib/graph: fix memset with NULL
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: khsfFkogZk_Gr8Tgzbj2yRYGXuEnfNfuUbGoIWpGeKo_1750680393
X-Mimecast-Originator: redhat.com
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

On Tue, Jun 17, 2025 at 5:14=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> This was flagged by undefined behaviour sanitizer: memset should not be
> called with NULL first argument. (memset requires first argument to be
> pointer to a memory object, so passing NULL may result in an undefined
> behaviour including among other things optimizer potentially removing
> code paths depending on stat->xstat_count being NULL.)
>
> Sanitizer message:
>
>     lib/graph/graph_stats.c:473:2: runtime error: null pointer passed as
>     argument 1, which is declared to never be null
>
> To fix the issue add a check that stat->xstat_count is not NULL before
> the call.
>
> Fixes: 070db97e017 ("graph: support node xstats")
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>
> v2: Following the suggestions from Jerin Jacob changed the Subject and
> added Fixes line.
>
>  lib/graph/graph_stats.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
> index eac73cbf71..57cd72e7cc 100644
> --- a/lib/graph/graph_stats.c
> +++ b/lib/graph/graph_stats.c
> @@ -470,7 +470,9 @@ cluster_node_arregate_stats(struct cluster_node *clus=
ter, bool dispatch)
>         uint64_t *xstat;
>         uint8_t i;
>
> -       memset(stat->xstat_count, 0, sizeof(uint64_t) * stat->xstat_cntrs=
);
> +       if (stat->xstat_count !=3D NULL)

I would check against stat->xstat_cntrs since the array is allocated
based on this count.
This will be more consistent with the loop on this same counter later
in this function.


> +               memset(stat->xstat_count, 0,
> +                       sizeof(uint64_t) * stat->xstat_cntrs);

No need for going to a new line.


>         for (count =3D 0; count < cluster->nb_nodes; count++) {
>                 node =3D cluster->nodes[count];
>

Thanks for the fix.


--=20
David Marchand

