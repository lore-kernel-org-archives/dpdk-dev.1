Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDEDC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 12:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1115640DD7;
	Tue, 17 Jun 2025 14:42:10 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id DF1D640C35
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:42:08 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a44b9b2af8so32949531cf.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750164128; x=1750768928; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxdjRX0wCaRrNPW3Jp7+rwkMZP11WD92mqWKJ9P+kj8=;
 b=Q+HNA/Yc7UNoz6qXPoCQSHT/EPNaPKSjfrgtw9Dg/Vb0y+8FEdWvDHlvkV2hS/wR3L
 GeaFAQcqoCR/Bjm8CH7L0k+9S09frtMPZJ/rAiN+mw8zC3L15nFbjcX3Kl7C6XXrmH0t
 gv+Qk5WR+k515YnkuFDNdRiCJpltF+NdiRUdQwIuVQVWbeHxh1Rt7IRW4C27LEJcwuQy
 YuCyIRdHIJv8pOFMOjCnT0XYRTRs3gB81+uX432WB5KKpqKozoNkp8Psfj52rB1C5STs
 eu6KZlAP+ZViD7mZD1yfW+Hrxst9xtfIgZnUEhmmLDHR/1rw0MBUKhb0As6g+dX3xUCE
 k7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750164128; x=1750768928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxdjRX0wCaRrNPW3Jp7+rwkMZP11WD92mqWKJ9P+kj8=;
 b=BUEYNOX0lGBv4J6wCW8KJRe0I+T8XQnTlZStXPbHXDJ2uQLlHJqkiVyoa+US5SwuIO
 9N8VSHtDNmbLCGJecbvATsjasexnMgQ/NubxglgBInNr8WkdsVCzDntzxPFgiTDxm0tq
 tUxrxRtAUKekKPqBoCxrMrsQuRj1q/pZVd0oNeiIAPrzRVMMukml3i7b/k05JShMwlcm
 Y5ECyyGQE9P8Mmdvl9TIo7UiJH/wURX17O0mxPlJwWljokchpE9aXAJYGHqo4IIRpdVi
 51BCQjnpZ9Yn0nLRu1sl6CIqaFwnet5Zv7eUecK5xALPwcjwxuUyF6HEcwkSJgKKfzWT
 2gPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS7mTrwvgOcu1VViuu2tJd1TttMFwBHmj0liEbN6EyyT87MRP9N6msuYOGW3+EfcerHdc=@dpdk.org
X-Gm-Message-State: AOJu0Yw1xBEjkkq6soosA06xw33UkV6BbWiPNdoX9J8fCE9RLCFFWQQh
 ygvjEmqcIZBmpsXHwi6kie3StCHs/YKeydM9C4x60oTcq0IgHiEPX2VXZ1sRtue4ggETCzRM2te
 GMH8/YlpMVNgGeniOL0DPRi2XG6lw5IA=
X-Gm-Gg: ASbGncsvzKgEMSwrSic5YiNiuMjgc4koEP+3iaAJm5Bma1HemH5uLkLnKkRrabooWuC
 PataKMWeGmCH58pUTE8CvyqO4K4dADImP0rBsEFxuJeKUrxkvaWneCLztE5i5szVg2bODVGrAMV
 LgAoi9F3ccK/ocRid2hO2p7JnVK5BZxrHsrQbEqnQSxvcEZtNBcOnn
X-Google-Smtp-Source: AGHT+IE1GLN2Q1qXajuzg523OX3YCDS/GCnRfq60TCX9Apm2h+x23L1xOSI0bgO0C4/EOpGoEaM9edG6J7ygltjFwVM=
X-Received: by 2002:ac8:58c8:0:b0:49d:89bf:298f with SMTP id
 d75a77b69052e-4a73c4e816bmr184337331cf.22.1750164128071; Tue, 17 Jun 2025
 05:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250617105209.50526-1-marat.khalili@huawei.com>
In-Reply-To: <20250617105209.50526-1-marat.khalili@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Jun 2025 18:11:41 +0530
X-Gm-Features: AX0GCFvGFS3ZklztedALAoRHcuOUIX_QFNEQwMO3uZq1BI2-fGueQb7m2TKqMDU
Message-ID: <CALBAE1NiJjW2oRA++TXGiVqFSiR5KHe3dVy8AEDcg3fT4Z4mfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/graph: avoid memset(NULL, 0, 0)
To: Marat Khalili <marat.khalili@huawei.com>
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

On Tue, Jun 17, 2025 at 4:22=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
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
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>


Change subject as  lib/graph: fix memset with NULL. Also add Fixes:
With that

Acked-by: Jerin Jacob <jerinj@marvell.com>


> ---
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
> +               memset(stat->xstat_count, 0,
> +                       sizeof(uint64_t) * stat->xstat_cntrs);
>         for (count =3D 0; count < cluster->nb_nodes; count++) {
>                 node =3D cluster->nodes[count];
>
> --
> 2.43.0
>
