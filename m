Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E7C44528
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8245A40609;
	Mon, 20 Jul 2026 10:33:15 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id A3874402A7
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:33:14 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92ea24a2dbfso834484585a.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536394; cv=none;
 d=google.com; s=arc-20260327;
 b=Fc76qfdbp4Msw8UXFPva/b2OMmV4eG6V0JBCowwLaHer3wVR+XMZbRrsVw/IJ5UkyO
 YtQ0Rt+D2f5e7Ku7BO2z8rRsUJqqfaRl09YKL0491yZjmpskvWElXbFOb3L5bfZL1GCm
 9gleSN3Ca94rgYGWnpjK9afh2BbBY2WUT1sbh3Cs0ovPtL9srk6jhodDueCS+kiUylgx
 dpr1pPjTQI15XkiJYqFOTjnmAqdM0PYnENeL1zyo8nHfYDAlRAuMBCon/Gg1Ee4Ko3xq
 tKmHoXHwFngzu4y9ojsdfjV/6kil7zdzv6Ycd6TVyFZjpjt8m0xF4AJzegt3DLk6KP+t
 7tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=EAWkP9lFHmV2EYiYYxUswzNQlLTzHQ6J0BiCKB259fE=;
 fh=wIMuiJ6Z1JfuRH08Ibdq8CcLiTT130wtemRG6bkomU4=;
 b=cxRR+gZ25cGXk6fPBO3dgwvRTxsle8hHZMAioFhcSdfzvRK7IzDEn2HNAEPCuUTM14
 CcM87+EqEukE9heZRlpJyxnKCYBTplTGu5oNqNg44L5HR+bWzFeH5OqgKVDCeYToH0Jg
 Au1RQPOwiVL0Vc3hIDj5D8NHdj4QkU2ffWgQfD1YVlHNorXulSmisal0Jy1wWQp/Vw+M
 aOXlYyPzhxWFek+s8+fZz470RfngQUdD0Bd/gULuxc8uewczYb4wmfWTYxxQNmA9msTx
 O/eOsS3wDxc1yzGYqOtxr9C24TufctQ4k2Lq7bOwIxNJo/Ka4QMQMNH/O3JgZPO/GFZh
 nGrA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536394; x=1785141194;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EAWkP9lFHmV2EYiYYxUswzNQlLTzHQ6J0BiCKB259fE=;
 b=Us+GR4t/1+XXnAUeXJC1WRhj9BlJud9d+QzHGQ3RKkILU5A3HHm8onby3bZQyzO/Ts
 XnJ35QPx2k4u2mFCzX4K63KW/BJDfi6rwnQZBabNcldAVMkTGrQqNmBXFtX2nJrS+a2s
 wE0B8nngtydi4xK8VmAvH5BoHxnC/bT3uJ+CDGqwnIPyfphV92htkjqd4NeROaYU9FGF
 Vw9WR5QkxhKdmUFjyX8Vu5+Pm7WOpV7MHh9qMhQRjazWJhKz9wFzJcYKM+C0CQrN3NbO
 +irYXNslKrckzzFaNd6VdPIoaBmV8fMqJYzgPRFTG3iIEhfo46JQi6UEPhpGLx8x7TE1
 VN9Q==
X-Gm-Message-State: AOJu0YzxTmZQk4ah90zyyLYIkHM/2yMA86y2efXjdTYekHVbtfx0/2eZ
 wBY7GysWt1MUrotQajKW3rJUiNSOF/sfjvOkUf+lGs7ysybjo2vwIB+PSMSm3FvVZs3uvLb1Kn1
 XXH3TPtQ2BylX3Rz7VnwznL+YeF8gH1piRkg1
X-Gm-Gg: AfdE7ckcNOJwUHyAUG12WLbfl6r12yWxd/c3/piOWbNsHV/Y19tlxM/2hflIKblthbq
 28xIwiPYsPgPR6O/aQwOWn4cJ4m0pxL44dbvNGMLgte/e/CWuZ4jAG3QfXH3eLOcXqQ7JuQ2pVA
 tBek3e634u5UYwhQxlZpwi4tXeqpgyVNIAxNKLkFGAmvT8zUIcQPgw6WtvGAipx0VdeLTW7Zwxu
 8gdGZkX+wSTRz//HaTpVxmDUi3H5zKHvCpvUSbS+0LdE0RNyCpHUauuocA=
X-Received: by 2002:a05:620a:288b:b0:91c:d0b6:13f5 with SMTP id
 af79cd13be357-930b3eafadamr1272512885a.19.1784536393820; Mon, 20 Jul 2026
 01:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260717095842.419130-3-maxime@leroys.fr>
 <CAOaVG16_NrF=PNTzCVEuC_BWzt+4+4WHP6yXnHH=QbzitP2xiQ@mail.gmail.com>
In-Reply-To: <CAOaVG16_NrF=PNTzCVEuC_BWzt+4+4WHP6yXnHH=QbzitP2xiQ@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 20 Jul 2026 10:33:01 +0200
X-Gm-Features: AUfX_mxnbv7wx2C3yMJf0_iHwzvslfZWrv4BFbCvw7EWrtMvrM7AXyENKePxCHg
Message-ID: <CAHHRULUiZp2bLHONoDPhqexWd_ptXRLAQYVC=V3ojXonhecq1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/tap: drain queue FD in Rx interrupt mode
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>
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

On Fri, Jul 17, 2026 at 2:34=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Don't use int as a boolean. Use bool. Ideally find unused pad hole for it

Agreed int-as-a-boolean is not great. But bool in a structure is
discouraged by coding_style.rst:

   "Uses of bool in structures are not preferred as is wastes space and
    it's also not clear as to what type size the bool is."  (Ref: LKML)

and that very LKML reference is Linus recommending the opposite of
bool for struct members:

   "please don't use bool in structures at all. [...] Use bool mainly as a
    return type from functions [...]. [...] just make sure the base type is
    unsigned [...] you can specify the base type as you wish [...] for
    packing."

The current tap PMD follows that too: the existing flags (persist,
flow_init, flow_isolate) are all int, and stdbool.h is not even
included in the headers.

So for v2 I'll use uint8_t for intr_mode and intr_mode_set: fixed
1-byte size, unambiguous representation, and it fits the existing
padding so neither struct grows (pmd_internals stays 144 bytes,
rx_queue stays 80). That matches both the guide and the referenced
LKML guidance.

I can also add a third patch at the end of the series converting the
existing int flags (persist, flow_init, flow_isolate) to uint8_t, to
make the driver consistent

>
> On Fri, Jul 17, 2026, 11:59 AM Maxime Leroy <maxime@leroys.fr> wrote:
>>
>> The tap Rx path is driven by a SIGIO trigger: pmd_rx_burst() returns
>> without reading the queue fd unless tap_trigger, bumped by the O_ASYNC
>> signal handler, has advanced. That avoids a readv() on every empty poll.
>>
>> In Rx interrupt mode the application blocks on the queue fd through epol=
l
>> and polls only after a wakeup. The epoll wakeup and the trigger are
>> distinct signals, so the burst can return 0 right after a wakeup because
>> the trigger has not advanced, leaving the fd readable with no further
>> edge: traffic stalls.
>>
>> When the port is configured for Rx interrupts, drain the fd
>> unconditionally in the burst and do not arm the SIGIO trigger on the dat=
a
>> queue fd. A data queue fd can be closed and recreated on a later setup,
>> so the mode must stay constant to keep every fd on the same SIGIO policy=
:
>> it is fixed at configure time and a later change is rejected. Close and
>> reopen the port to switch modes.
>>
>> Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>> ---
>>  drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-
>>  drivers/net/tap/rte_eth_tap.h |  2 ++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap=
.c
>> index 99ede19e49..ea9ef76335 100644
>> --- a/drivers/net/tap/rte_eth_tap.c
>> +++ b/drivers/net/tap/rte_eth_tap.c
>> @@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int is_keepali=
ve, int persistent)
>>                 goto error;
>>         }
>>
>> +       /* interrupt mode wakes through epoll on the data queue fd, not =
the SIGIO trigger */
>> +       if (pmd->intr_mode)
>> +               return fd;
>> +
>>         /* Find a free realtime signal */
>>         for (signo =3D SIGRTMIN + 1; signo < SIGRTMAX; signo++) {
>>                 struct sigaction sa;
>> @@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, ui=
nt16_t nb_pkts)
>>         unsigned long num_rx_bytes =3D 0;
>>         uint32_t trigger =3D tap_trigger;
>>
>> -       if (trigger =3D=3D rxq->trigger_seen)
>> +       if (!rxq->intr_mode && trigger =3D=3D rxq->trigger_seen)
>>                 return 0;
>>
>>         process_private =3D rte_eth_devices[rxq->in_port].process_privat=
e;
>> @@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)
>>         struct pmd_internals *pmd =3D dev->data->dev_private;
>>         int intr_mode =3D !!dev->data->dev_conf.intr_conf.rxq;
>>
>> +       /* The queue fd is created once and its SIGIO trigger is armed f=
or poll
>> +        * mode only; the interrupt mode cannot be toggled on an existin=
g port.
>> +        */
>> +       if (pmd->intr_mode_set && pmd->intr_mode !=3D intr_mode) {
>> +               TAP_LOG(ERR,
>> +                       "%s: Rx interrupt mode is fixed after configure,=
 close and reopen the port to change it",
>> +                       dev->device->name);
>> +               return -ENOTSUP;
>> +       }
>> +
>>         if (dev->data->nb_rx_queues !=3D dev->data->nb_tx_queues) {
>>                 TAP_LOG(ERR,
>>                         "%s: number of rx queues %d must be equal to num=
ber of tx queues %d",
>> @@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)
>>         }
>>
>>         pmd->intr_mode =3D intr_mode;
>> +       pmd->intr_mode_set =3D 1;
>>
>>         TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
>>                 dev->device->name, pmd->name, dev->data->nb_tx_queues);
>> @@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
>>         rxq->queue_id =3D rx_queue_id;
>>         rxq->max_rx_segs =3D max_rx_segs;
>>         rxq->rxmode =3D &dev->data->dev_conf.rxmode;
>> +       rxq->intr_mode =3D internals->intr_mode;
>>
>>         dev->data->rx_queues[rx_queue_id] =3D rxq;
>>         int fd =3D tap_setup_queue(dev, rx_queue_id, 1);
>> diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap=
.h
>> index 3180719c34..abe22aac9f 100644
>> --- a/drivers/net/tap/rte_eth_tap.h
>> +++ b/drivers/net/tap/rte_eth_tap.h
>> @@ -50,6 +50,7 @@ struct rx_queue {
>>         uint16_t queue_id;              /* queue ID*/
>>         struct queue_stats stats;        /* Stats for this RX queue */
>>         uint16_t max_rx_segs;           /* max scatter segments per pack=
et */
>> +       uint16_t intr_mode;             /* 1 when Rx queue interrupts ar=
e used */
>>         struct rte_eth_rxmode *rxmode;  /* RX features */
>>         struct rte_mbuf *pool;          /* mbufs pool for this queue */
>>         struct tun_pi pi;               /* packet info for iovecs */
>> @@ -94,6 +95,7 @@ struct pmd_internals {
>>
>>         struct rte_intr_handle *intr_handle;         /* LSC interrupt ha=
ndle. */
>>         int intr_mode;                    /* Rx queue interrupt mode */
>> +       int intr_mode_set;                /* intr_mode locked after conf=
igure */
>>         int ka_fd;                        /* keep-alive file descriptor =
*/
>>         struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets *=
/
>>  };
>> --
>> 2.43.0
>>


--=20
-------------------------------
Maxime Leroy
maxime@leroys.fr
