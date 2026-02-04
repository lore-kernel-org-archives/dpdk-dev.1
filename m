Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC5E9537B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 11:22:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34CF4402EE;
	Wed,  4 Feb 2026 12:22:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F2AD8402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 12:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770204119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5jsPfgo770P1GeILWVwhzyxOBcHH4SEyT5/pWNBDMM=;
 b=Jr8rVQa/X+QUYttjpeEN4TkP4gaeRH76dFGCxKJ2L1nZ7IzC9CMaxAXBKaNBM9uxGltMyE
 tGsHhtyD7ecxf7/Bw8BjDepSF8TdPhkznbTtEciWUjV2+7dRCKhMiiY266VAeJfkFZiGzF
 K8en8GB8+flwb2uWPtBvWvlviVKfjoM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-3E1yEu6wNey9OL2UZ814QA-1; Wed, 04 Feb 2026 06:21:56 -0500
X-MC-Unique: 3E1yEu6wNey9OL2UZ814QA-1
X-Mimecast-MFC-AGG-ID: 3E1yEu6wNey9OL2UZ814QA_1770204115
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59ddfe54013so568998e87.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 03:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770204115; x=1770808915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5jsPfgo770P1GeILWVwhzyxOBcHH4SEyT5/pWNBDMM=;
 b=o2njm4IxjFSFz0LK62k+er67or+wIokt+zLVVDD7TtwPmAWdLBDDo1SbilZsQsdldQ
 Eq4KLgEKi7N/1xyRyCF9AIH/j+MepJn5cqMj6o532AiKmLXcMc8x39wzLTaOeFdtVYT6
 ZaYOpA8FyjIn5MluFiM2tzEbWwmTDwxjYlsokOWz3H9nv5LSdBKP+cjSgHSNoTxZ2Qkx
 li+/99izKJ66J+w6DN8x0yJt7Divlq/dLybCdpGQoVdGNtXEa9M8BiMNNLDIKYujMYBv
 cvWpiPql+EipnlsJaNVQUF/UFlHkDatgCy1DYNEbARxoRl+VZkd+jXCVTbxSdcy03QVG
 oHfQ==
X-Gm-Message-State: AOJu0YzkZqYJbJcWtTyvgKe72+bZLsgif6sLEl9XonHvrFYUlNV2r5hP
 1J0Wj8p7wv84SxreM7GUO1NVbI/ySN+zNkKZ3S3kIE38Wt7ssjI0zM6pnPmEs7SFAOChbZQFkIU
 U+sttu10nRkeVHQcfAwyt/hpqkRB+AWqUMigftx3ToNV9zy9VijiLY3g92tr6+Xhbq7KaD45zVZ
 ltSH1PmAbxkUOac/guLxM=
X-Gm-Gg: AZuq6aIXYb3o3adzNgGm+CzjaCY9lf9nR5iuaLlOxDfSDEROg94WfVnY8BmFNNaZl1Z
 GHLuVtLtNu0VYpZ/7kU8qzQpNDCe+Ppe4V+/EoMStj6NdiiGb8kuOX09JIxBIZFRs++L0iO33Rq
 DmyJDQ+jSj7EP0pKjNLSoSQpljbI7tqUaHg8yA3jNI4DwC+zCgI1/Wp4NVhXcWQhbYXE9r4JDO1
 m+QVZsQKFletXYLeZo9lcK07vjTBTX5kPO/2Z6Ec2XCKWtYSyLnvrQxag==
X-Received: by 2002:a05:6512:3a8f:b0:59d:dfe4:da51 with SMTP id
 2adb3069b0e04-59e31707d0emr2321596e87.20.1770204114601; 
 Wed, 04 Feb 2026 03:21:54 -0800 (PST)
X-Received: by 2002:a05:6512:3a8f:b0:59d:dfe4:da51 with SMTP id
 2adb3069b0e04-59e31707d0emr2321589e87.20.1770204114210; Wed, 04 Feb 2026
 03:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
 <20260129014313.939831-4-stephen@networkplumber.org>
In-Reply-To: <20260129014313.939831-4-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Feb 2026 12:21:42 +0100
X-Gm-Features: AZwV_QhgIRAoHtqlpEcjdRrrKpytaLHLTLcjnQhwBSLKcylDNV8OmzNCSH6Zpkk
Message-ID: <CAJFAV8zbhHRKatGVknZk-mdUfSZ6nPp30Co1YoJokFCVhOWB=g@mail.gmail.com>
Subject: Re: [PATCH v14 03/17] graph: avoid overflowing comment buffer
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -C51MIR3lP55enzrwoiUtPOcLFQeOIvdsCizPzGmz8c_1770204115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 29 Jan 2026 at 02:43, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The library builds a pcapng comment to put on each packet but
> the buffer is not big enough for the largest possible graph
> node name, etc. Change to use asprintf() to allow any
> string length. Note, if asprintf() fails it is better to
> still log the packet without comment so no data is lost.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/graph/graph_pcap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
> index 08dcda0d28..602be79ced 100644
> --- a/lib/graph/graph_pcap.c
> +++ b/lib/graph/graph_pcap.c
> @@ -194,7 +194,7 @@ graph_pcap_dispatch(struct rte_graph *graph,
>                               uint16_t nb_objs)
>  {
>         struct rte_mbuf *mbuf_clones[RTE_GRAPH_BURST_SIZE];
> -       char buffer[GRAPH_PCAP_BUF_SZ];

GRAPH_PCAP_BUF_SZ definition can be dropped, as it is not used anymore.
I will fix while applying.


-- 
David Marchand

