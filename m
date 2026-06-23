Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB91CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 09:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8F88402C6;
	Tue, 23 Jun 2026 11:09:27 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id E4C4B40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 11:09:26 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51788280e71so59335961cf.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 02:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782205766; cv=none;
 d=google.com; s=arc-20240605;
 b=G+VLKNtznpVdyOzyFWgccgOBPBiI5Ift7mJRCxqN0mkySQLz9d27e8jjDnsTgVOgu2
 Ss0YMj2lM4xbTWTwUc4X87QHlXGVPlQi57/95J5+cF0YRjgtkz0MDQrGG0FdV0tMmvS8
 P1s1+g6IU5LF4GWRXI52iZ7BzudnSZLqOLFkujUapzhZs4UsOGDXtZUc/QBMz+zibqH5
 qOTNT51U9R1HZVucC2hmaG/GjU0qQFMgJgq+Mxdee+tyCP+8kzkaV5DQ74aW+LeHS/Gw
 qze6tWgZkyURrlurqnncyuTvKOIpgpT6QztURz6z1Tm/RE7VyIFU5q11t33NxkFNZwA7
 PX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j6dmOGjta8dGxXHTz1RbChsB6c6i2a1VRShGCsLcrX8=;
 fh=03TrS5i56qbbYElB2Zm6Cfe6pynd/QlURPYVqMq/0zs=;
 b=WpI1z8FhxtKdsI74coxQYZRbGfiEERVL2W3lunESvUKgBQfid/UJbuJK5s00ZZgEYD
 QRiXIUSBWnlcnPF37R/xHZTOqO0xA+hyMKqR6XniRkmYcSMtUcBwQsUcbtBGEWb+X825
 E4xbj0TPNRuZzQ8RnyvV0iNi2xSIDI992dxREUH8/2PFtPKdfNqbenWbWLw42fy0vGMW
 C1fmHTr87kWjZdgq/zA2xDjRFdWM0JoPNTVXMs+ZJMOpraERMDKYHj/Dk+O1hxI5GFpL
 iUZjvpPuLAoPGq+6MT3/HNWVlad8/YHoL3KWw/4q3c6NmLCOnJmVfmXbL0sP8tVYNzem
 5MWg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782205766; x=1782810566; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6dmOGjta8dGxXHTz1RbChsB6c6i2a1VRShGCsLcrX8=;
 b=UAT2/uEPVMfg+HYmiyn8dIQ/keJZaSubN9fjol/Wwm60Nt22FkFsXnViN/nrLJjY8n
 quqxeuw3JI27f8fI4S65u897fVCd1wz9GjAfDe7jVDGyNvjjT6rPPsjzgXs/ACQcAHSj
 oPALMqwas7vWMNqnRAIp1hZnOI04iGu/8Pi5Yr0yffQ7kna+fpBoXs+HwfNWNwBH7pQi
 Z7BSumLjhuFUqMcyNppW51//E5kxi4GYvQ1+g4lRFR/QwqmCqzq85FzH7JDJeTqMy6PD
 fwjFtzaUdluMFhYydMYLR+mJJ1jn60pNOj8CENyykF/cjGlh9onZKQT4pVX3YSm5l8ON
 8+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782205766; x=1782810566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6dmOGjta8dGxXHTz1RbChsB6c6i2a1VRShGCsLcrX8=;
 b=qDlZXP2LbUDozc8BpeZ3Yj1t3/sn8Yk6c/diqj+CULtF9IQkk39RgSI6QTwd64Ba6j
 WnzIC6drSVmNHnDh+U0pv9gRUiUPsg0Mbs5QUfQ7Kk/2wV7ok9xKXzVE1NBP8OPwerAB
 IeXkdD97wT8S3hbg/EX7WoHlBhRt2VPlqXs6WJAanvi1EzdddOqXSxrUSu37ViSRpIZd
 W5JEHfyz0dnOVeRtWn/9tsq6jE1PUlz7oUyhLInP5YBHayB9Eix8wO9o1OzmVXvRZjAT
 elqaimZSQOkZPchFLAddsSiqJffY+xu9n4UfVPFhm7EGHEYy3NL5vDm6GSwzyGN3IFnh
 kClA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2YNwsT5EPwjZ8p1kdjXEuvfdPyFrK/dASEIS2dhwRKyMOXMbUx9KZ7jyWZehCeJYn680=@dpdk.org
X-Gm-Message-State: AOJu0YxRz/890iUkY0O+wNeErP7xRzSsaIIXHy8/cUTpl3ibJMiRKm7j
 g8/F+yApjFcbBSrfsiqqy87mTzH/pliZFz2cGjhtMqvqhIY8lNnbh4KvHSMrWQfeOhIMISMmfwI
 wZkS73JS1HIuPnlkXcmInoGzZpax0osg=
X-Gm-Gg: AfdE7clHqX/g2lewYdIT3KeRh/JHMBVAy8fR14tw5O6Kmg+7PMeXuVXaCEnSGU02aCi
 dhaCCKjY6zJHDJn5CVlhexPG7t+MGs+SFOIYykMVOh2mKiDqSY/rwkcYjJ2hgC2ZH4JwnqqE4FI
 3D6HBjc6uUW7OAY7rNcaQI6YRFjx/XKKHWIuO3cGyCpyltiyY7bR5m9hC6Nl6+7WwhIfgAyBWcE
 dqhBq6zKkxEb8FTB0XmOrW7cw9dMhPYk26xCGFKiQeFbrSmqq/9/tdCAw2xcvWH/izw
X-Received: by 2002:ac8:6906:0:b0:516:e974:6f72 with SMTP id
 d75a77b69052e-51a06af44aemr224373321cf.50.1782205765952; Tue, 23 Jun 2026
 02:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65938@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65938@smartserver.smartshare.dk>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Jun 2026 14:38:59 +0530
X-Gm-Features: AVVi8CevFtpU7KzxJtVvFT5yFAqn8MXx9CH-d1nyMvC_LEgBFM5vLpQa0G5gLys
Message-ID: <CALBAE1N1czL9k0WwcNnC60F3m0XTnr4V_JpDcNr6Y3Qgc-co_A@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: thomas@monjalon.net, david.marchand@redhat.com, dev@dpdk.org, 
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
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

On Tue, Jun 23, 2026 at 12:40=E2=80=AFPM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> +Thomas Monjalon & +David Marchand, as intended by Jerin
>
> > From: Jerin Jacob [mailto:jerinjacobk@gmail.com]
> > Sent: Tuesday, 23 June 2026 08.57
> >
> > On Tue, Jun 23, 2026 at 12:15=E2=80=AFPM Morten Br=C3=B8rup
> > <mb@smartsharesystems.com> wrote:
> > >
> > > > From: Jerin Jacob [mailto:jerinjacobk@gmail.com]
> > > > Sent: Tuesday, 23 June 2026 07.13
> > > >
> > > > On Mon, Jun 22, 2026 at 12:11=E2=80=AFAM Morten Br=C3=B8rup
> > > > <mb@smartsharesystems.com> wrote:
> > > > >
> > > > > Added graph node profiling stats, build time configurable by
> > enabling
> > > > > RTE_GRAPH_PROFILE in rte_config.h.
> > > > >
> > > > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > >
> > > > Please update app/test/test_graph.c to validate this featue.
> > >
> > > Ack.
> > >
> > > > > @@ -92,7 +92,62 @@ rte_graph_obj_dump(FILE *f, struct rte_graph
> > *g,
> > > > bool all)
> > > > >                         fprintf(f, "       total_sched_fail=3D%"
> > PRId64
> > > > "\n",
> > > > >                                 n->dispatch.total_sched_fail);
> > > > >                 }
> > > > > -               fprintf(f, "       total_calls=3D%" PRId64 "\n", =
n-
> > > > >total_calls);
> > > > > +               fprintf(f, "       total_calls=3D%" PRIu64 "\n", =
n-
> > > > >total_calls);
> > > > > +               if (rte_graph_has_stats_feature()) {
> > > > > +                       fprintf(f, "       total_cycles=3D%" PRIu=
64
> > ",
> > > > avg cycles/call=3D%.1f\n",
> > > > > +                                       n->total_cycles,
> > > > > +                                       n->total_calls =3D=3D 0 ?
> > > > (double)0 :
> > > > > +                                       (double)n->total_cycles /
> > > > (double)n->total_calls);
> > > > > +               }
> > > > > +#ifdef RTE_GRAPH_PROFILE
> > > >
> > > >
> > > > Please introduce rte_graph_has_profile_featue() similar to
> > > > rte_graph_has_stats_feature() to reduce if def clutter as possible.
> > >
> > > Disagree, see below.
> > >
> > > >
> > > > > +               uint64_t calls =3D n->usage_stats[0].calls;
> > > > > +               fprintf(f, "       objs[0]\n");
> > > > > +               fprintf(f, "         calls=3D%" PRIu64 ", cycles=
=3D%"
> > > > PRIu64 ", avg cycles/call=3D%.1f\n",
> > > > > +                               calls,
> > > >
> > > > >
> > > > > diff --git a/lib/graph/rte_graph_worker_common.h
> > > > b/lib/graph/rte_graph_worker_common.h
> > > > > index 4ab53a533e..0d8039575d 100644
> > > > > --- a/lib/graph/rte_graph_worker_common.h
> > > > > +++ b/lib/graph/rte_graph_worker_common.h
> > > > > @@ -144,12 +144,26 @@ struct __rte_cache_aligned rte_node {
> > > > >                         rte_node_process_t process; /**< Process
> > > > function. */
> > > > >                         uint64_t process_u64;
> > > > >                 };
> > > > > +               /** Fast path area cache line 3. */
> > > > > +#ifdef RTE_GRAPH_PROFILE
> > > > > +               struct {
> > > > > +                       uint64_t calls;     /**< Calls processing
> > > > resp. 0 or 1 objects. */
> > > > > +                       uint64_t cycles;    /**< Cycles spent
> > > > processing resp. 0 or 1 objects. */
> > > > > +               } usage_stats[2];       /**< Usage when this node
> > > > processed 0 or 1 objects. */
> > > > > +               uint64_t full_burst_calls;  /**< Calls processing
> > a
> > > > full burst of objects. */
> > > > > +               uint64_t full_burst_cycles; /**< Cycles spent
> > > > processing a full burst of objects. */
> > > > > +               uint64_t half_burst_calls;  /**< Calls processing
> > a
> > > > half burst of objects. */
> > > > > +               uint64_t half_burst_cycles; /**< Cycles spent
> > > > processing a half burst of objects. */
> > > > > +               /** Fast path area cache line 4. */
> > > > > +#endif
> > > >
> > > > Is it an ABI breakage?
> > >
> > > No. The modifications are enclosed in #ifdef, and disabled by
> > default.
> > > It is generally required that when rte_config.h options are modified,
> > both the application and DPDK itself are built together; and then
> > API/ABI breakage becomes irrelevant.
> >
> >
> > Yes. I don't know the current policy for this. Adding @Thomas Monjalon
> > @David Marchand
> >
> >
> > >
> > > IMO, we should keep our structures lean in release builds. This means
> > that fields used for detailed profiling, advanced debugging, cookie
> > validation, etc. should use the #ifdef pattern rather than the
> > rte_lib_has_some_feature() pattern; especially if they affect the size
> > of a structure. And when those fields are not present, any code
> > accessing them cannot use the rte_lib_has_some_feature() pattern.
> > > The mbuf and mempool libraries also use #ifdef pattern for similar
> > features.
> >
> > Yes for the structure inclusion we can use #ifdef. But inside the
> > function we can use rte_lib_has_some_feature() scheme. Reasons are :
> > 1)It will remove the ifdef cultter
> > 2)Detect the compilation issue even if the feature is disabled. This
> > will make sure reduce the build options to enable build sanity
> > 3) Compiler is smart enough to understand to disable the block if the
> > feature is not enabled.(Just like #ifdef)
>
> I agree with these advantages.
> But a function using rte_lib_has_some_feature() cannot access non-existin=
g fields:
> https://godbolt.org/z/s3nKx45Ms


I missed that.

You can add these new struct updates in the slowpath area of rte_node.
Above offsetof(struct rte_node, ctx)

Use RTE_NEXT_ABI, Get around off, ABI breakge issue.


>
> So sometimes #ifdef is required in the code too.
>
> >
> >
> >
> > >
> > > >
> > > > >                 alignas(RTE_CACHE_LINE_MIN_SIZE) struct rte_node
> > > > *nodes[]; /**< Next nodes. */
> > > > >         };
> > > > >  };
> > > > >
