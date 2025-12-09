Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF6D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 09:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D646640270;
	Tue,  9 Dec 2025 10:09:59 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id D07D04025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 10:09:58 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8b5ccceb382so540974085a.1
 for <dev@dpdk.org>; Tue, 09 Dec 2025 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765271397; x=1765876197; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJzE1rltbRHBo9ehVrqZ9kgxCcJtfx0u6MclbAojuK8=;
 b=fd+MPnk+pW01+KAF/Da4+Kz/kyq+OzZMxuP++bGVdQk85UDsV5w5ri5dlszpWs4XVT
 T5USeRHOGQJyH41YentF42Vni4mSNCP/sTUxYXGOIkQn3UPbsUjxErc1W2OXbDLW5Xtp
 igIiQ2IIFEekGX7g8DNfV3/CI7CmHrqjLatPIBZWb9KqN1IQka9iD7nZi0MIkUQhzgSz
 vmvYI/fKaaqhHg3ooAV8rXtVGqXPzVhC8zRU8TWLB/9SWiXrOSCDneC0D8lJDClBx/PF
 mCWvILZuiMF+7NcV4foqE8MY0qHYWNVw8UQvdqDcZds4ikafVGQk+Hy6lYmCu3i+99n2
 XqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765271397; x=1765876197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJzE1rltbRHBo9ehVrqZ9kgxCcJtfx0u6MclbAojuK8=;
 b=t40Pawqk5gOkoNUGqxokf8JVgYl2Q1K7iW9qctyMCVzYCiHq8tim7WfOUyi9fTsCWg
 zwOzwSKvJZB8vllfwE7QjZfejHBU32SBjPIysMYX/hyp9q7hHWGk5J9xNH9h+MxW0rtO
 eWURoIcnitInk215QXEMmBLPxQgjAfWMJG0KBjB2hNapSVZgPjKar4zjcP4BUVgeBtSR
 8RVxg1T0poiALkufCEjFMPrpFX+9g8qhmoLC4CIkR2cm0XJMheT0/rGJsW8JMa0pcje0
 RG7IdFEekC3WJdrvgEgTuP/O7OsFomXz6N9y0VE23+9L16/PPaITXfKpmPpuQ+Tgvreu
 9TNQ==
X-Gm-Message-State: AOJu0YxtN7KIvl6aYyjRqTToNKpgYfjozx0M3+u+zov7Qe2unw3aOHXF
 QJbedwqpUapuUHxXQuUSXQcN1aVs2trBPWqTcAXB+y3OqKmv8RCoAIPmh6WNog7emNGpOMHHWYm
 NZPw0ojszgWl5+m4gPJdfhqjMJWlA7nQ=
X-Gm-Gg: ASbGncvqLW9DD0DYgpLYZrSFRTVWhIGLRn7v70G/dK4K+TM9pEljJSVktKPr7ganWTo
 9U4WyFboNnV8raIbksr0Bj08WEsb68hYH/RaoiSV3gp7UKLyy5DP1bCkcgssz+NIj/AVhdyjpRi
 ZC7VALwN4MNvH4I6OMLVHo/H6Y3mb5jlYIqkvinPvXbgGpvU6LM9rsOMN28kY+9DasSeTYLNWyK
 22KyHYgb+tjKnMRtgNZx/bPWOXqO0V3DUTUikwJWNyn4BirIIUQE8lGzKOXkQ0JHsbimw==
X-Google-Smtp-Source: AGHT+IEv+OLIkmtIE1zoAdXs3nRJJMhLMZ7iaagd+k4nyZ9e02dB1mjhHb0eojwmV0/d4Kfqm0yE4lDXJ6EsEvIglII=
X-Received: by 2002:a05:622a:424e:b0:4ee:1f5b:73bc with SMTP id
 d75a77b69052e-4f03feef8famr164936041cf.66.1765271397303; Tue, 09 Dec 2025
 01:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
In-Reply-To: <20251209085028.115203-5-rjarry@redhat.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 9 Dec 2025 14:39:30 +0530
X-Gm-Features: AQt7F2ptvd19W2WX4afkxfYCjaCEkT_d8JpjG16CUec_3jslUutz7YfxpVmnB_4
Message-ID: <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
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

On Tue, Dec 9, 2025 at 2:27=E2=80=AFPM Robin Jarry <rjarry@redhat.com> wrot=
e:
>
> Accumulate the number of processed objects and the number of times each
> node is visited regardless of the compile time value of
> RTE_LIBRTE_GRAPH_STATS.


By default, RTE_LIBRTE_GRAPH_STATS is enabled in distro build. So why
need such changes?


>
> Accumulating these numbers do not bring much overhead when rte_rdtsc()
> isn't called.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/graph/rte_graph_worker_common.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_wo=
rker_common.h
> index 4ab53a533e4c..c87a6796a96e 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -209,11 +209,11 @@ __rte_node_process(struct rte_graph *graph, struct =
rte_node *node)
>                 start =3D rte_rdtsc();
>                 rc =3D node->process(graph, node, objs, node->idx);
>                 node->total_cycles +=3D rte_rdtsc() - start;
> -               node->total_calls++;
> -               node->total_objs +=3D rc;
>         } else {
> -               node->process(graph, node, objs, node->idx);
> +               rc =3D node->process(graph, node, objs, node->idx);
>         }
> +       node->total_calls++;
> +       node->total_objs +=3D rc;
>         node->idx =3D 0;
>  }
>
> --
> 2.52.0
>
