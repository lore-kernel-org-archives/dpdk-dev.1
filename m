Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF6C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 14:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9DF040269;
	Mon,  2 Jun 2025 16:10:08 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 88E304025E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 16:10:07 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d0a47f6692so306878485a.1
 for <dev@dpdk.org>; Mon, 02 Jun 2025 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748873407; x=1749478207; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQaFbxgR8npVk4PdG13IbMtQXwfO1Wu1Sz6DzM/x/HA=;
 b=Qclxx0p+RW7Moo0N5fkX97vL8Dg/eydFjmRH4+4pQfGNxcqmstzkzByh8srE8A9heT
 4Di04luJ8j3azTNKQLi3HyuceCRlS5sVbX3+KeEC4NEZ+54x6v589ZtPJ/Kkp0U7AKyI
 aYOAnPGg3DhMCJJBwa2I6ZNN2KaySQrO8eCi8JIjoPqjCGI3PmwaYNxhpj2Vmt2GQqE+
 oTs7uLQ08KwoEKZhiutBu1RzUxE74+HBY+yMlkNrGffGOmnhQ6JjC/qSGSCqc3nAu8Iv
 LztcjW/ltzg64Ifp1YO/f4oCRlvA73p2klRVhVGHWgtj4joy8HgWFOwoEKmTzrFvzgA6
 iDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748873407; x=1749478207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQaFbxgR8npVk4PdG13IbMtQXwfO1Wu1Sz6DzM/x/HA=;
 b=AtkNUiVpUyM3qaTpi5LRtzCaGtxEnqwHmHf93D4N4tbrDVXoq6uAudB/MgASi9cvPU
 8EZCKjnAvpmqsmMi2mfa+3FRpV4i06x8BNbm5GsWur/jGnk/aQjVAdcTEnaFQs+eX+UG
 5geSI0j0Mwupsk2To9Felp7rQrpnMzI24vkMBETefZImIFHEeD96kQbDdTIfdemEs/bS
 extidJvYmKkn2fud2x/vT60hUmvKn1zM9ddFExJUkO4zzyLT6R8ofNSDBlatbrIWCVkW
 AfOvNLJRNMN4+fn1sDJHkE6PYObfXw9roO9c/q1HXYI6M3A7Gq4FyC5lIWDJBp/Qj+us
 mv6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUUlhTQo1ILa31PLYNRjZ1U/NbP7uuD/u6MNrm6ujpk5j8VV87hkqpWeBlbBHVoUzHj4=@dpdk.org
X-Gm-Message-State: AOJu0Yy6RW4gsTYRNLjnlI5PATP15qDs24IhXmgsYS04UoDo3JSDuBaP
 WSOVlUjTwWhwsIxrC97V3GD9XKUB/C3sAiWPGNuCiTHKL6ZrEDtBgxacPhfxwSDIVgb/jCl2Jke
 1lgcJIoOP4elQN7r2E/3KL81CeHzE364=
X-Gm-Gg: ASbGncuw/NIWksc2bnLzjFLHbHTKfEN3hULNpz4FdD3rWTQPU9h83hHFoB4lWf+VvYd
 6VLnDrdu9YAYdANVIkbeBfrD9ghU82NVKtl7OUe0w2b2EbrD9I3t41xGqhibgTVPUhWKOhQizxC
 90tUnhTNWWktWrJfUbvU0q4frloauIdy0=
X-Google-Smtp-Source: AGHT+IG66qjDxrC9xGS0wceWCkiSeTbtCCpTivfeB2SO8pUrGaS/UFGwwsEduu6WHdi44a9lZ96aqzPn4SfA/2ppuFw=
X-Received: by 2002:a05:620a:4408:b0:7c5:3d60:7f8d with SMTP id
 af79cd13be357-7d0a1fb91a0mr2054407185a.19.1748873406439; Mon, 02 Jun 2025
 07:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250529222437.91818-1-pbhagavatula@marvell.com>
 <20250530162532.52464-1-pbhagavatula@marvell.com>
 <20250530162532.52464-4-pbhagavatula@marvell.com>
In-Reply-To: <20250530162532.52464-4-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 2 Jun 2025 19:39:39 +0530
X-Gm-Features: AX0GCFtLAZ0EVtsKwiqb5QbT6rTaBpZh1ZntV_6kXAdlCCDw3LYbff3s9wG1CNA
Message-ID: <CALBAE1MqAYy+XA9U8nkS2FtDqEHbexZZo71ahPQ_noDurE3Ygw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] app/eventdev: add vector adapter performance test
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, abhinandan.gujjar@intel.com, amitprakashs@marvell.com, 
 s.v.naga.harish.k@intel.com, sthotton@marvell.com, pravin.pathak@intel.com,
 hemant.agrawal@nxp.com, sachin.saxena@nxp.com, mattias.ronnblom@ericsson.com, 
 liangma@liangbit.com, peter.mccarthy@intel.com, harry.van.haaren@intel.com, 
 anatoly.burakov@intel.com, erik.g.carrillo@intel.com, dev@dpdk.org
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

On Fri, May 30, 2025 at 9:56=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> Add performance test for event vector adapter.
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Series applied to dpdk-next-eventdev/for-main. Thanks.


> ---
>  app/test-eventdev/evt_common.h         |   9 +-
>  app/test-eventdev/evt_options.c        |  14 ++
>  app/test-eventdev/evt_options.h        |   1 +
>  app/test-eventdev/test_perf_atq.c      |  61 +++++-
>  app/test-eventdev/test_perf_common.c   | 281 ++++++++++++++++++-------
>  app/test-eventdev/test_perf_common.h   |  13 +-
>  app/test-eventdev/test_perf_queue.c    |  66 +++++-
>  doc/guides/rel_notes/release_25_07.rst |   5 +
>  doc/guides/tools/testeventdev.rst      |   6 +
>  9 files changed, 362 insertions(+), 94 deletions(-)
>
> diff --git a/app/test-eventdev/evt_common.h b/app/test-eventdev/evt_commo=
n.h
> index 74f9d187f3f5..ec824f2454c1 100644
> --- a/app/test-eventdev/evt_common.h
> +++ b/app/test-eventdev/evt_common.h
> @@ -39,11 +39,12 @@
>
>  enum evt_prod_type {
>         EVT_PROD_TYPE_NONE,
> -       EVT_PROD_TYPE_SYNT,          /* Producer type Synthetic i.e. CPU.=
 */
> -       EVT_PROD_TYPE_ETH_RX_ADPTR,  /* Producer type Eth Rx Adapter. */
> +       EVT_PROD_TYPE_SYNT,               /* Producer type Synthetic i.e.=
 CPU. */
> +       EVT_PROD_TYPE_ETH_RX_ADPTR,       /* Producer type Eth Rx Adapter=
. */
>         EVT_PROD_TYPE_EVENT_TIMER_ADPTR,  /* Producer type Timer Adapter.=
 */
> -       EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR,  /* Producer type Crypto Adapte=
r. */
> -       EVT_PROD_TYPE_EVENT_DMA_ADPTR,  /* Producer type DMA Adapter. */
> +       EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR, /* Producer type Crypto Adapter=
. */
> +       EVT_PROD_TYPE_EVENT_DMA_ADPTR,    /* Producer type DMA Adapter. *=
/
> +       EVT_PROD_TYPE_EVENT_VECTOR_ADPTR, /* Producer type Vector adapter=
. */
>         EVT_PROD_TYPE_MAX,
>  };
>
> diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_opti=
ons.c
> index 323d1e724dce..0e70c971eb2e 100644
> --- a/app/test-eventdev/evt_options.c
> +++ b/app/test-eventdev/evt_options.c
> @@ -186,6 +186,13 @@ evt_parse_dma_adptr_mode(struct evt_options *opt, co=
nst char *arg)
>         return ret;
>  }
>
> +static int
> +evt_parse_vector_prod_type(struct evt_options *opt,
> +                          const char *arg __rte_unused)
> +{
> +       opt->prod_type =3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR;
> +       return 0;
> +}
>
>  static int
>  evt_parse_crypto_prod_type(struct evt_options *opt,
> @@ -494,6 +501,7 @@ usage(char *program)
>                 "\t                     in ns.\n"
>                 "\t--prod_type_timerdev_burst : use timer device as produ=
cer\n"
>                 "\t                             burst mode.\n"
> +               "\t--prod_type_vector : use vector adapter as producer.\n=
"
>                 "\t--nb_timers        : number of timers to arm.\n"
>                 "\t--nb_timer_adptrs  : number of timer adapters to use.\=
n"
>                 "\t--timer_tick_nsec  : timer tick interval in ns.\n"
> @@ -591,6 +599,7 @@ static struct option lgopts[] =3D {
>         { EVT_PROD_CRYPTODEV,      0, 0, 0 },
>         { EVT_PROD_TIMERDEV,       0, 0, 0 },
>         { EVT_PROD_TIMERDEV_BURST, 0, 0, 0 },
> +       { EVT_PROD_VECTOR,         0, 0, 0 },
>         { EVT_DMA_ADPTR_MODE,      1, 0, 0 },
>         { EVT_CRYPTO_ADPTR_MODE,   1, 0, 0 },
>         { EVT_CRYPTO_OP_TYPE,      1, 0, 0 },
> @@ -642,6 +651,7 @@ evt_opts_parse_long(int opt_idx, struct evt_options *=
opt)
>                 { EVT_PROD_DMADEV, evt_parse_dma_prod_type},
>                 { EVT_PROD_TIMERDEV, evt_parse_timer_prod_type},
>                 { EVT_PROD_TIMERDEV_BURST, evt_parse_timer_prod_type_burs=
t},
> +               { EVT_PROD_VECTOR, evt_parse_vector_prod_type },
>                 { EVT_DMA_ADPTR_MODE, evt_parse_dma_adptr_mode},
>                 { EVT_CRYPTO_ADPTR_MODE, evt_parse_crypto_adptr_mode},
>                 { EVT_CRYPTO_OP_TYPE, evt_parse_crypto_op_type},
> @@ -721,4 +731,8 @@ evt_options_dump(struct evt_options *opt)
>         evt_dump_end;
>         evt_dump_nb_flows(opt);
>         evt_dump_worker_dequeue_depth(opt);
> +       if (opt->ena_vector || opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_=
VECTOR_ADPTR) {
> +               evt_dump("vector_sz", "%d", opt->vector_size);
> +               evt_dump("vector_tmo_ns", "%"PRIu64, opt->vector_tmo_nsec=
);
> +       }
>  }
> diff --git a/app/test-eventdev/evt_options.h b/app/test-eventdev/evt_opti=
ons.h
> index 18a893b7040b..4bf712bd19aa 100644
> --- a/app/test-eventdev/evt_options.h
> +++ b/app/test-eventdev/evt_options.h
> @@ -38,6 +38,7 @@
>  #define EVT_PROD_DMADEV          ("prod_type_dmadev")
>  #define EVT_PROD_TIMERDEV        ("prod_type_timerdev")
>  #define EVT_PROD_TIMERDEV_BURST  ("prod_type_timerdev_burst")
> +#define EVT_PROD_VECTOR          ("prod_type_vector")
>  #define EVT_DMA_ADPTR_MODE       ("dma_adptr_mode")
>  #define EVT_CRYPTO_ADPTR_MODE   ("crypto_adptr_mode")
>  #define EVT_CRYPTO_OP_TYPE      ("crypto_op_type")
> diff --git a/app/test-eventdev/test_perf_atq.c b/app/test-eventdev/test_p=
erf_atq.c
> index 30c34edabd3a..b07b010af1b5 100644
> --- a/app/test-eventdev/test_perf_atq.c
> +++ b/app/test-eventdev/test_perf_atq.c
> @@ -145,7 +145,7 @@ perf_atq_worker_burst(void *arg, const int enable_fwd=
_latency)
>  }
>
>  static int
> -perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
> +perf_atq_worker_crypto_vector(void *arg, const int enable_fwd_latency)
>  {
>         uint16_t enq =3D 0, deq =3D 0;
>         struct rte_event ev;
> @@ -161,10 +161,8 @@ perf_atq_worker_vector(void *arg, const int enable_f=
wd_latency)
>                 if (!deq)
>                         continue;
>
> -               if (ev.event_type =3D=3D RTE_EVENT_TYPE_CRYPTODEV_VECTOR)=
 {
> -                       if (perf_handle_crypto_vector_ev(&ev, &pe, enable=
_fwd_latency))
> -                               continue;
> -               }
> +               if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_lat=
ency))
> +                       continue;
>
>                 stage =3D ev.sub_event_type % nb_stages;
>                 /* First q in pipeline, mark timestamp to compute fwd lat=
ency */
> @@ -173,8 +171,8 @@ perf_atq_worker_vector(void *arg, const int enable_fw=
d_latency)
>
>                 /* Last stage in pipeline */
>                 if (unlikely(stage =3D=3D laststage)) {
> -                       perf_process_vector_last_stage(pool, t->ca_op_poo=
l, &ev, w,
> -                                                       enable_fwd_latenc=
y);
> +                       perf_process_crypto_vector_last_stage(pool, t->ca=
_op_pool, &ev, w,
> +                                                             enable_fwd_=
latency);
>                 } else {
>                         atq_fwd_event_vector(&ev, sched_type_list, nb_sta=
ges);
>                         do {
> @@ -188,6 +186,53 @@ perf_atq_worker_vector(void *arg, const int enable_f=
wd_latency)
>         return 0;
>  }
>
> +static int
> +perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
> +{
> +       uint16_t enq =3D 0, deq =3D 0;
> +       struct rte_event ev;
> +       PERF_WORKER_INIT;
> +
> +       RTE_SET_USED(sz);
> +       RTE_SET_USED(pe);
> +       RTE_SET_USED(cnt);
> +       RTE_SET_USED(prod_type);
> +       RTE_SET_USED(prod_timer_type);
> +
> +       while (t->done =3D=3D false) {
> +               deq =3D rte_event_dequeue_burst(dev, port, &ev, 1, 0);
> +               if (!deq)
> +                       continue;
> +
> +               if (ev.event_type !=3D RTE_EVENT_TYPE_CPU_VECTOR) {
> +                       w->processed_pkts++;
> +                       continue;
> +               }
> +
> +               stage =3D ev.sub_event_type % nb_stages;
> +               if (enable_fwd_latency && stage =3D=3D 0)
> +                       /* first stage in pipeline, mark ts to compute fw=
d latency */
> +                       ev.vec->u64s[0] =3D rte_get_timer_cycles();
> +
> +               /* Last stage in pipeline */
> +               if (unlikely(stage =3D=3D laststage)) {
> +                       w->processed_vecs++;
> +                       if (enable_fwd_latency)
> +                               w->latency +=3D rte_get_timer_cycles() - =
ev.vec->u64s[0];
> +
> +                       rte_mempool_put(pool, ev.event_ptr);
> +               } else {
> +                       atq_fwd_event_vector(&ev, sched_type_list, nb_sta=
ges);
> +                       do {
> +                               enq =3D rte_event_enqueue_burst(dev, port=
, &ev, 1);
> +                       } while (!enq && !t->done);
> +               }
> +       }
> +       perf_worker_cleanup(pool, dev, port, &ev, enq, deq);
> +
> +       return 0;
> +}
> +
>  static int
>  worker_wrapper(void *arg)
>  {
> @@ -199,6 +244,8 @@ worker_wrapper(void *arg)
>
>         /* allow compiler to optimize */
>         if (opt->ena_vector && opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_=
CRYPTO_ADPTR)
> +               return perf_atq_worker_crypto_vector(arg, fwd_latency);
> +       else if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR)
>                 return perf_atq_worker_vector(arg, fwd_latency);
>         else if (!burst && !fwd_latency)
>                 return perf_atq_worker(arg, 0);
> diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/tes=
t_perf_common.c
> index 627f07caa1b7..4709de8b07a3 100644
> --- a/app/test-eventdev/test_perf_common.c
> +++ b/app/test-eventdev/test_perf_common.c
> @@ -102,16 +102,20 @@ perf_test_result(struct evt_test *test, struct evt_=
options *opt)
>         int i;
>         uint64_t total =3D 0;
>         struct test_perf *t =3D evt_test_priv(test);
> +       uint8_t is_vec;
>
>         printf("Packet distribution across worker cores :\n");
> +       is_vec =3D (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPT=
R);
>         for (i =3D 0; i < t->nb_workers; i++)
> -               total +=3D t->worker[i].processed_pkts;
> +               total +=3D is_vec ? t->worker[i].processed_vecs : t->work=
er[i].processed_pkts;
>         for (i =3D 0; i < t->nb_workers; i++)
> -               printf("Worker %d packets: "CLGRN"%"PRIx64" "CLNRM"percen=
tage:"
> -                               CLGRN" %3.2f"CLNRM"\n", i,
> -                               t->worker[i].processed_pkts,
> -                               (((double)t->worker[i].processed_pkts)/to=
tal)
> -                               * 100);
> +               printf("Worker %d packets: " CLGRN "%" PRIx64 " " CLNRM "=
percentage:" CLGRN
> +                      " %3.2f" CLNRM "\n",
> +                      i, is_vec ? t->worker[i].processed_vecs : t->worke=
r[i].processed_pkts,
> +                      (((double)(is_vec ? t->worker[i].processed_vecs :
> +                                          t->worker[i].processed_pkts)) =
/
> +                       total) *
> +                              100);
>
>         return t->result;
>  }
> @@ -887,6 +891,31 @@ perf_event_crypto_producer_burst(void *arg)
>         return 0;
>  }
>
> +static int
> +perf_event_vector_producer(struct prod_data *p)
> +{
> +       struct rte_event_vector_adapter *adptr =3D p->va.vector_adptr;
> +       struct evt_options *opt =3D p->t->opt;
> +       const struct test_perf *t =3D p->t;
> +       uint64_t objs[BURST_SIZE];
> +       uint16_t enq;
> +
> +       if (opt->verbose_level > 1)
> +               printf("%s(): lcore %d vector adapter %p\n", __func__, rt=
e_lcore_id(), adptr);
> +
> +       while (t->done =3D=3D false) {
> +               enq =3D rte_event_vector_adapter_enqueue(adptr, objs, BUR=
ST_SIZE, 0);
> +               while (enq < BURST_SIZE) {
> +                       enq +=3D rte_event_vector_adapter_enqueue(adptr, =
objs + enq, BURST_SIZE - enq,
> +                                                               0);
> +                       if (t->done)
> +                               break;
> +                       rte_pause();
> +               }
> +       }
> +       return 0;
> +}
> +
>  static int
>  perf_producer_wrapper(void *arg)
>  {
> @@ -930,6 +959,8 @@ perf_producer_wrapper(void *arg)
>                         return perf_event_crypto_producer(arg);
>         } else if (t->opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_DMA_ADPTR=
)
>                 return perf_event_dma_producer(arg);
> +       else if (t->opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPT=
R)
> +               return perf_event_vector_producer(p);
>
>         return 0;
>  }
> @@ -947,115 +978,103 @@ processed_pkts(struct test_perf *t)
>  }
>
>  static inline uint64_t
> -total_latency(struct test_perf *t)
> +processed_vecs(struct test_perf *t)
>  {
>         uint8_t i;
>         uint64_t total =3D 0;
>
>         for (i =3D 0; i < t->nb_workers; i++)
> -               total +=3D t->worker[i].latency;
> +               total +=3D t->worker[i].processed_vecs;
>
>         return total;
>  }
>
> -
> -int
> -perf_launch_lcores(struct evt_test *test, struct evt_options *opt,
> -               int (*worker)(void *))
> +static inline uint64_t
> +total_latency(struct test_perf *t)
>  {
> -       int ret, lcore_id;
> -       struct test_perf *t =3D evt_test_priv(test);
> -
> -       int port_idx =3D 0;
> -       /* launch workers */
> -       RTE_LCORE_FOREACH_WORKER(lcore_id) {
> -               if (!(opt->wlcores[lcore_id]))
> -                       continue;
> -
> -               ret =3D rte_eal_remote_launch(worker,
> -                                &t->worker[port_idx], lcore_id);
> -               if (ret) {
> -                       evt_err("failed to launch worker %d", lcore_id);
> -                       return ret;
> -               }
> -               port_idx++;
> -       }
> -
> -       /* launch producers */
> -       RTE_LCORE_FOREACH_WORKER(lcore_id) {
> -               if (!(opt->plcores[lcore_id]))
> -                       continue;
> +       uint8_t i;
> +       uint64_t total =3D 0;
>
> -               ret =3D rte_eal_remote_launch(perf_producer_wrapper,
> -                               &t->prod[port_idx], lcore_id);
> -               if (ret) {
> -                       evt_err("failed to launch perf_producer %d", lcor=
e_id);
> -                       return ret;
> -               }
> -               port_idx++;
> -       }
> +       for (i =3D 0; i < t->nb_workers; i++)
> +               total +=3D t->worker[i].latency;
>
> -       const uint64_t total_pkts =3D t->outstand_pkts;
> +       return total;
> +}
>
> -       uint64_t dead_lock_cycles =3D rte_get_timer_cycles();
> -       int64_t dead_lock_remaining  =3D  total_pkts;
> +static void
> +check_work_status(struct test_perf *t, struct evt_options *opt)
> +{
>         const uint64_t dead_lock_sample =3D rte_get_timer_hz() * 5;
> -
> +       const uint64_t freq_mhz =3D rte_get_timer_hz() / 1000000;
> +       uint64_t dead_lock_cycles =3D rte_get_timer_cycles();
> +       const uint64_t perf_sample =3D rte_get_timer_hz();
>         uint64_t perf_cycles =3D rte_get_timer_cycles();
> +       const uint64_t total_pkts =3D t->outstand_pkts;
> +       int64_t dead_lock_remaining =3D total_pkts;
>         int64_t perf_remaining  =3D total_pkts;
> -       const uint64_t perf_sample =3D rte_get_timer_hz();
> -
> -       static float total_mpps;
>         static uint64_t samples;
> +       static float total_mpps;
> +       int64_t remaining;
> +       uint8_t is_vec;
>
> -       const uint64_t freq_mhz =3D rte_get_timer_hz() / 1000000;
> -       int64_t remaining =3D t->outstand_pkts - processed_pkts(t);
> +       is_vec =3D (t->opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_A=
DPTR);
> +       remaining =3D t->outstand_pkts - (is_vec ? processed_vecs(t) : pr=
ocessed_pkts(t));
>
>         while (t->done =3D=3D false) {
>                 const uint64_t new_cycles =3D rte_get_timer_cycles();
>
>                 if ((new_cycles - perf_cycles) > perf_sample) {
>                         const uint64_t latency =3D total_latency(t);
> -                       const uint64_t pkts =3D processed_pkts(t);
> +                       const uint64_t pkts =3D is_vec ? processed_vecs(t=
) : processed_pkts(t);
> +                       uint64_t fallback_pkts =3D processed_pkts(t);
>
>                         remaining =3D t->outstand_pkts - pkts;
> -                       float mpps =3D (float)(perf_remaining-remaining)/=
1000000;
> +                       float mpps =3D (float)(perf_remaining - remaining=
) / 1E6;
>
>                         perf_remaining =3D remaining;
>                         perf_cycles =3D new_cycles;
>                         total_mpps +=3D mpps;
>                         ++samples;
> +
>                         if (opt->fwd_latency && pkts > 0) {
> -                               printf(CLGRN"\r%.3f mpps avg %.3f mpps [a=
vg fwd latency %.3f us] "CLNRM,
> -                                       mpps, total_mpps/samples,
> -                                       (float)(latency/pkts)/freq_mhz);
> +                               if (is_vec) {
> +                                       printf(CLGRN
> +                                              "\r%.3f mvps avg %.3f mvps=
 [avg fwd latency %.3f us] "
> +                                              "fallback mpps %.3f" CLNRM=
,
> +                                              mpps, total_mpps / samples=
,
> +                                              (float)(latency / pkts) / =
freq_mhz,
> +                                              fallback_pkts / 1E6);
> +                               } else {
> +                                       printf(CLGRN
> +                                              "\r%.3f mpps avg %.3f mpps=
 [avg fwd latency %.3f us] "
> +                                              CLNRM,
> +                                              mpps, total_mpps / samples=
,
> +                                              (float)(latency / pkts) / =
freq_mhz);
> +                               }
>                         } else {
> -                               printf(CLGRN"\r%.3f mpps avg %.3f mpps"CL=
NRM,
> -                                       mpps, total_mpps/samples);
> +                               if (is_vec) {
> +                                       printf(CLGRN
> +                                              "\r%.3f mvps avg %.3f mvps=
 fallback mpps %.3f" CLNRM,
> +                                              mpps, total_mpps / samples=
, fallback_pkts / 1E6);
> +                               } else {
> +                                       printf(CLGRN "\r%.3f mpps avg %.3=
f mpps" CLNRM, mpps,
> +                                              total_mpps / samples);
> +                               }
>                         }
>                         fflush(stdout);
>
>                         if (remaining <=3D 0) {
>                                 t->result =3D EVT_TEST_SUCCESS;
> -                               if (opt->prod_type =3D=3D EVT_PROD_TYPE_S=
YNT ||
> -                                   opt->prod_type =3D=3D
> -                                           EVT_PROD_TYPE_EVENT_TIMER_ADP=
TR ||
> -                                   opt->prod_type =3D=3D
> -                                           EVT_PROD_TYPE_EVENT_CRYPTO_AD=
PTR ||
> -                                   opt->prod_type =3D=3D
> -                                           EVT_PROD_TYPE_EVENT_DMA_ADPTR=
) {
> +                               if (opt->prod_type !=3D EVT_PROD_TYPE_ETH=
_RX_ADPTR) {
>                                         t->done =3D true;
>                                         break;
>                                 }
>                         }
>                 }
> -
>                 if (new_cycles - dead_lock_cycles > dead_lock_sample &&
> -                   (opt->prod_type =3D=3D EVT_PROD_TYPE_SYNT ||
> -                    opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_TIMER_ADPT=
R ||
> -                    opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_CRYPTO_ADP=
TR ||
> -                    opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_DMA_ADPTR)=
) {
> -                       remaining =3D t->outstand_pkts - processed_pkts(t=
);
> +                   (opt->prod_type !=3D EVT_PROD_TYPE_ETH_RX_ADPTR)) {
> +                       remaining =3D
> +                               t->outstand_pkts - (is_vec ? processed_ve=
cs(t) : processed_pkts(t));
>                         if (dead_lock_remaining =3D=3D remaining) {
>                                 rte_event_dev_dump(opt->dev_id, stdout);
>                                 evt_err("No schedules for seconds, deadlo=
ck");
> @@ -1067,6 +1086,45 @@ perf_launch_lcores(struct evt_test *test, struct e=
vt_options *opt,
>                 }
>         }
>         printf("\n");
> +}
> +
> +int
> +perf_launch_lcores(struct evt_test *test, struct evt_options *opt, int (=
*worker)(void *))
> +{
> +       int ret, lcore_id;
> +       struct test_perf *t =3D evt_test_priv(test);
> +
> +       int port_idx =3D 0;
> +       /* launch workers */
> +       RTE_LCORE_FOREACH_WORKER(lcore_id)
> +       {
> +               if (!(opt->wlcores[lcore_id]))
> +                       continue;
> +
> +               ret =3D rte_eal_remote_launch(worker, &t->worker[port_idx=
], lcore_id);
> +               if (ret) {
> +                       evt_err("failed to launch worker %d", lcore_id);
> +                       return ret;
> +               }
> +               port_idx++;
> +       }
> +
> +       /* launch producers */
> +       RTE_LCORE_FOREACH_WORKER(lcore_id)
> +       {
> +               if (!(opt->plcores[lcore_id]))
> +                       continue;
> +
> +               ret =3D rte_eal_remote_launch(perf_producer_wrapper, &t->=
prod[port_idx], lcore_id);
> +               if (ret) {
> +                       evt_err("failed to launch perf_producer %d", lcor=
e_id);
> +                       return ret;
> +               }
> +               port_idx++;
> +       }
> +
> +       check_work_status(t, opt);
> +
>         return 0;
>  }
>
> @@ -1564,6 +1622,70 @@ perf_event_dev_port_setup(struct evt_test *test, s=
truct evt_options *opt,
>
>                         prod++;
>                 }
> +       } else if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR=
) {
> +               struct rte_event_vector_adapter_conf conf;
> +               struct rte_event_vector_adapter_info info;
> +
> +               ret =3D rte_event_vector_adapter_info_get(opt->dev_id, &i=
nfo);
> +
> +               if (opt->vector_size < info.min_vector_sz ||
> +                   opt->vector_size > info.max_vector_sz) {
> +                       evt_err("Vector size [%d] not within limits max[%=
d] min[%d]",
> +                               opt->vector_size, info.max_vector_sz, inf=
o.min_vector_sz);
> +                       return -EINVAL;
> +               }
> +
> +               if (opt->vector_tmo_nsec > info.max_vector_timeout_ns ||
> +                   opt->vector_tmo_nsec < info.min_vector_timeout_ns) {
> +                       evt_err("Vector timeout [%" PRIu64 "] not within =
limits "
> +                               "max[%" PRIu64 "] min[%" PRIu64 "]",
> +                               opt->vector_tmo_nsec, info.max_vector_tim=
eout_ns,
> +                               info.min_vector_timeout_ns);
> +                       return -EINVAL;
> +               }
> +
> +               memset(&conf, 0, sizeof(struct rte_event_vector_adapter_c=
onf));
> +               conf.event_dev_id =3D opt->dev_id;
> +               conf.vector_sz =3D opt->vector_size;
> +               conf.vector_timeout_ns =3D opt->vector_tmo_nsec;
> +               conf.socket_id =3D opt->socket_id;
> +               conf.vector_mp =3D t->pool;
> +
> +               conf.ev.sched_type =3D opt->sched_type_list[0];
> +               conf.ev.event_type =3D RTE_EVENT_TYPE_VECTOR | RTE_EVENT_=
TYPE_CPU;
> +
> +               conf.ev_fallback.event_type =3D RTE_EVENT_TYPE_CPU;
> +
> +               prod =3D 0;
> +               for (; port < perf_nb_event_ports(opt); port++) {
> +                       struct rte_event_vector_adapter *vector_adptr;
> +                       struct prod_data *p =3D &t->prod[port];
> +                       uint32_t service_id;
> +
> +                       p->queue_id =3D prod * stride;
> +                       p->t =3D t;
> +
> +                       conf.ev.queue_id =3D p->queue_id;
> +
> +                       vector_adptr =3D rte_event_vector_adapter_create(=
&conf);
> +                       if (vector_adptr =3D=3D NULL) {
> +                               evt_err("Failed to create vector adapter =
for port %d", port);
> +                               return -ENOMEM;
> +                       }
> +                       p->va.vector_adptr =3D vector_adptr;
> +                       prod++;
> +
> +                       if (rte_event_vector_adapter_service_id_get(vecto=
r_adptr, &service_id) =3D=3D
> +                           0) {
> +                               ret =3D evt_service_setup(service_id);
> +                               if (ret) {
> +                                       evt_err("Failed to setup service =
core"
> +                                               " for vector adapter\n");
> +                                       return ret;
> +                               }
> +                               rte_service_runstate_set(service_id, 1);
> +                       }
> +               }
>         } else {
>                 prod =3D 0;
>                 for ( ; port < perf_nb_event_ports(opt); port++) {
> @@ -1728,6 +1850,20 @@ perf_eventdev_destroy(struct evt_test *test, struc=
t evt_options *opt)
>                 for (i =3D 0; i < opt->nb_timer_adptrs; i++)
>                         rte_event_timer_adapter_stop(t->timer_adptr[i]);
>         }
> +
> +       if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
> +               for (i =3D 0; i < evt_nr_active_lcores(opt->plcores); i++=
) {
> +                       struct prod_data *p =3D &t->prod[i];
> +                       uint32_t service_id;
> +
> +                       if (p->va.vector_adptr) {
> +                               if (rte_event_vector_adapter_service_id_g=
et(p->va.vector_adptr,
> +                                                                        =
   &service_id) =3D=3D 0)
> +                                       rte_service_runstate_set(service_=
id, 0);
> +                               rte_event_vector_adapter_destroy(p->va.ve=
ctor_adptr);
> +                       }
> +               }
> +       }
>         rte_event_dev_stop(opt->dev_id);
>         rte_event_dev_close(opt->dev_id);
>  }
> @@ -2119,6 +2255,9 @@ perf_mempool_setup(struct evt_test *test, struct ev=
t_options *opt)
>                                              cache_sz,                 /*=
 cache size*/
>                                              0, NULL, NULL, NULL,      /*=
 obj constructor */
>                                              NULL, opt->socket_id, 0); /*=
 flags */
> +       } else if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR=
) {
> +               t->pool =3D rte_event_vector_pool_create(test->name, opt-=
>pool_sz, cache_sz,
> +                                                      opt->vector_size, =
opt->socket_id);
>         } else {
>                 t->pool =3D rte_pktmbuf_pool_create(test->name, /* mempoo=
l name */
>                                 opt->pool_sz, /* number of elements*/
> diff --git a/app/test-eventdev/test_perf_common.h b/app/test-eventdev/tes=
t_perf_common.h
> index d7333ad390a4..99df008cc7b7 100644
> --- a/app/test-eventdev/test_perf_common.h
> +++ b/app/test-eventdev/test_perf_common.h
> @@ -16,6 +16,7 @@
>  #include <rte_event_eth_rx_adapter.h>
>  #include <rte_event_eth_tx_adapter.h>
>  #include <rte_event_timer_adapter.h>
> +#include <rte_event_vector_adapter.h>
>  #include <rte_eventdev.h>
>  #include <rte_lcore.h>
>  #include <rte_malloc.h>
> @@ -33,6 +34,7 @@ struct test_perf;
>
>  struct __rte_cache_aligned worker_data {
>         uint64_t processed_pkts;
> +       uint64_t processed_vecs;
>         uint64_t latency;
>         uint8_t dev_id;
>         uint8_t port_id;
> @@ -50,12 +52,17 @@ struct dma_adptr_data {
>         uint16_t vchan_id;
>  };
>
> +struct vector_adptr_data {
> +       struct rte_event_vector_adapter *vector_adptr;
> +};
> +
>  struct __rte_cache_aligned prod_data {
>         uint8_t dev_id;
>         uint8_t port_id;
>         uint8_t queue_id;
>         struct crypto_adptr_data ca;
>         struct dma_adptr_data da;
> +       struct vector_adptr_data va;
>         struct test_perf *t;
>  };
>
> @@ -320,9 +327,9 @@ perf_process_last_stage_latency(struct rte_mempool *c=
onst pool, enum evt_prod_ty
>  }
>
>  static __rte_always_inline void
> -perf_process_vector_last_stage(struct rte_mempool *const pool,
> -               struct rte_mempool *const ca_pool, struct rte_event *cons=
t ev,
> -               struct worker_data *const w, const bool enable_fwd_latenc=
y)
> +perf_process_crypto_vector_last_stage(struct rte_mempool *const pool,
> +                                     struct rte_mempool *const ca_pool, =
struct rte_event *const ev,
> +                                     struct worker_data *const w, const =
bool enable_fwd_latency)
>  {
>         struct rte_event_vector *vec =3D ev->vec;
>         struct rte_crypto_op *cop;
> diff --git a/app/test-eventdev/test_perf_queue.c b/app/test-eventdev/test=
_perf_queue.c
> index 58715a253748..36fe94e19032 100644
> --- a/app/test-eventdev/test_perf_queue.c
> +++ b/app/test-eventdev/test_perf_queue.c
> @@ -147,7 +147,7 @@ perf_queue_worker_burst(void *arg, const int enable_f=
wd_latency)
>  }
>
>  static int
> -perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
> +perf_queue_worker_crypto_vector(void *arg, const int enable_fwd_latency)
>  {
>         uint16_t enq =3D 0, deq =3D 0;
>         struct rte_event ev;
> @@ -163,10 +163,8 @@ perf_queue_worker_vector(void *arg, const int enable=
_fwd_latency)
>                 if (!deq)
>                         continue;
>
> -               if (ev.event_type =3D=3D RTE_EVENT_TYPE_CRYPTODEV_VECTOR)=
 {
> -                       if (perf_handle_crypto_vector_ev(&ev, &pe, enable=
_fwd_latency))
> -                               continue;
> -               }
> +               if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_lat=
ency))
> +                       continue;
>
>                 stage =3D ev.queue_id % nb_stages;
>                 /* First q in pipeline, mark timestamp to compute fwd lat=
ency */
> @@ -175,8 +173,8 @@ perf_queue_worker_vector(void *arg, const int enable_=
fwd_latency)
>
>                 /* Last stage in pipeline */
>                 if (unlikely(stage =3D=3D laststage)) {
> -                       perf_process_vector_last_stage(pool, t->ca_op_poo=
l, &ev, w,
> -                                                      enable_fwd_latency=
);
> +                       perf_process_crypto_vector_last_stage(pool, t->ca=
_op_pool, &ev, w,
> +                                                             enable_fwd_=
latency);
>                 } else {
>                         fwd_event_vector(&ev, sched_type_list, nb_stages)=
;
>                         do {
> @@ -190,6 +188,52 @@ perf_queue_worker_vector(void *arg, const int enable=
_fwd_latency)
>         return 0;
>  }
>
> +static int
> +perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
> +{
> +       uint16_t enq =3D 0, deq =3D 0;
> +       struct rte_event ev;
> +       PERF_WORKER_INIT;
> +
> +       RTE_SET_USED(pe);
> +       RTE_SET_USED(sz);
> +       RTE_SET_USED(cnt);
> +       RTE_SET_USED(prod_type);
> +       RTE_SET_USED(prod_timer_type);
> +
> +       while (t->done =3D=3D false) {
> +               deq =3D rte_event_dequeue_burst(dev, port, &ev, 1, 0);
> +               if (!deq)
> +                       continue;
> +
> +               if (ev.event_type !=3D RTE_EVENT_TYPE_CPU_VECTOR) {
> +                       w->processed_pkts++;
> +                       continue;
> +               }
> +
> +               stage =3D ev.sub_event_type % nb_stages;
> +               if (enable_fwd_latency && stage =3D=3D 0)
> +                       /* first stage in pipeline, mark ts to compute fw=
d latency */
> +                       ev.vec->u64s[0] =3D rte_get_timer_cycles();
> +
> +               /* Last stage in pipeline */
> +               if (unlikely(stage =3D=3D laststage)) {
> +                       w->processed_vecs++;
> +                       if (enable_fwd_latency)
> +                               w->latency +=3D rte_get_timer_cycles() - =
ev.vec->u64s[0];
> +                       rte_mempool_put(pool, ev.event_ptr);
> +               } else {
> +                       fwd_event_vector(&ev, sched_type_list, nb_stages)=
;
> +                       do {
> +                               enq =3D rte_event_enqueue_burst(dev, port=
, &ev, 1);
> +                       } while (!enq && !t->done);
> +               }
> +       }
> +       perf_worker_cleanup(pool, dev, port, &ev, enq, deq);
> +
> +       return 0;
> +}
> +
>  static int
>  worker_wrapper(void *arg)
>  {
> @@ -201,6 +245,8 @@ worker_wrapper(void *arg)
>
>         /* allow compiler to optimize */
>         if (opt->ena_vector && opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_=
CRYPTO_ADPTR)
> +               return perf_queue_worker_crypto_vector(arg, fwd_latency);
> +       else if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_VECTOR_ADPTR)
>                 return perf_queue_worker_vector(arg, fwd_latency);
>         else if (!burst && !fwd_latency)
>                 return perf_queue_worker(arg, 0);
> @@ -234,8 +280,10 @@ perf_queue_eventdev_setup(struct evt_test *test, str=
uct evt_options *opt)
>
>         nb_ports =3D evt_nr_active_lcores(opt->wlcores);
>         nb_ports +=3D opt->prod_type =3D=3D EVT_PROD_TYPE_ETH_RX_ADPTR ||
> -               opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_TIMER_ADPTR ? 0=
 :
> -               evt_nr_active_lcores(opt->plcores);
> +                                   opt->prod_type =3D=3D EVT_PROD_TYPE_E=
VENT_TIMER_ADPTR ||
> +                                   opt->prod_type =3D=3D EVT_PROD_TYPE_E=
VENT_VECTOR_ADPTR ?
> +                           0 :
> +                           evt_nr_active_lcores(opt->plcores);
>
>         nb_queues =3D perf_queue_nb_event_queues(opt);
>
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index f9e14d12698d..98c8e2a36b8f 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -88,6 +88,11 @@ New Features
>    details on the new library.
>
>
> +* **Added vector adapter producer mode in eventdev test.**
> +
> +  Added vector adapter producer mode to measure performance of event vec=
tor
> +  adapter.
> +
>
>  Removed Items
>  -------------
> diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeve=
ntdev.rst
> index 58f373b8677c..c4e1047fbb8b 100644
> --- a/doc/guides/tools/testeventdev.rst
> +++ b/doc/guides/tools/testeventdev.rst
> @@ -130,6 +130,10 @@ The following are the application command-line optio=
ns:
>
>          Use DMA device as producer.
>
> +* ``--prod_type_vector``
> +
> +        Use event vector adapter as producer.
> +
>  * ``--timer_tick_nsec``
>
>         Used to dictate number of nano seconds between bucket traversal o=
f the
> @@ -635,6 +639,7 @@ Supported application command line options are follow=
ing::
>          --prod_type_timerdev
>          --prod_type_cryptodev
>          --prod_type_dmadev
> +        --prod_type_vector
>          --prod_enq_burst_sz
>          --timer_tick_nsec
>          --max_tmo_nsec
> @@ -756,6 +761,7 @@ Supported application command line options are follow=
ing::
>          --prod_type_timerdev
>          --prod_type_cryptodev
>          --prod_type_dmadev
> +        --prod_type_vector
>          --timer_tick_nsec
>          --max_tmo_nsec
>          --expiry_nsec
> --
> 2.39.5 (Apple Git-154)
>
