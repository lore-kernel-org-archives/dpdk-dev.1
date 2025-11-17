Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E9CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E78A04060B;
	Mon, 17 Nov 2025 09:31:41 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 437CB402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:31:40 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b2ed01b95dso71776085a.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 00:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763368299; x=1763973099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vu7DLvLtGjdR3DKJFGu0E2mHMVOgKF1udE+mmQJMY9E=;
 b=a14GxbcpmGr+SyLKm67PfQe9trtto89ZjthEaG3UspVkkLtqSjabg4eYqP1VibZ7t5
 3StFXeZVmir4F2HsIlwpyZs6sfWka3MtZJ+nklLV1EwJbOmfgZZYep8awNkNub+3fvl7
 9aUclhmICwwqsItaDqIupbooC79kFxEZJ7yct++tW6gQkcDGtmQp697DvLEj6+oZIF6M
 4rb8YiFAv7LkPvF2rpTKp3n41Q+iUXe59QGm/r7k0GCoL0IOzJ/t6D9WDKvy5DGxhxS+
 3lrIY4Z0KDBFsye6U1+mMMtSPEAAjoVEtCkyQGKnZ8Nhc99HtZVp88deB7ZaVSTyDoUd
 GekA==
X-Gm-Message-State: AOJu0Ywr2LaeBX797stK2+izHIaxR8ssw1pyIAggK+kXRiDofT8FXCzG
 XwuRZRCyHb/MWTrAdbuhlzuIVqsDEiB40/+xoomoBRXsdAWixhxrL0Q04JKyCIqfK/RpdHUy8pf
 ioxrqYk1UvVbSYK77dUM1aZTkqtcqDoE=
X-Gm-Gg: ASbGncsbZfKt5OmtupYQkI27d6LVCSnHHHUf5kfaNG1RGDlaD6Pjv9bCfTDZB2EU7bx
 hdCrL4yw6ZctzHlZf0quq4wDgPvhiIpsRq8ejBvLQuTuFqzE8SPjZx6DIhK1qMNI/4hyxacxl48
 SUxU9wXCbTFpusqGvGXKYAq9AZdNxJLj82xBw0d3L0TWXj0xVffCcHTKGYxmk4sasrgfrKJet7n
 6KPD3WmykxxxVlyDAY3QZXOw3wVfmTsIqFMWA3i8g3DQI4pOw5kMxPcwyqoE76MchoX
X-Google-Smtp-Source: AGHT+IHS3g7LShGqol9YqL2wQ9tAMUkKPtR4/vx26SnnzlYSlRdV7HFxItOBhwfJ5zXAn3Oc/KjdGpCqipyT+igJi8A=
X-Received: by 2002:a05:620a:1a10:b0:8b2:767c:31d3 with SMTP id
 af79cd13be357-8b2c3145404mr1520744385a.6.1763368299481; Mon, 17 Nov 2025
 00:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-2-hemant.agrawal@nxp.com>
In-Reply-To: <20251114062454.2731559-2-hemant.agrawal@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 17 Nov 2025 09:31:28 +0100
X-Gm-Features: AWmQ_bluvke1goGC_6mS9hCdJohnkMGg-RUUi9LuajPW6hYT--6QzxVwW-yAfco
Message-ID: <CAHHRULUv9o76_zkomOi4jYnd3ci7dbxQD2bXmudWA00aVUwttA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] net/dpaa2: clear active VDQ state when freeing Rx
 queues
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com, 
 jun.yang@nxp.com, stable@dpdk.org
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

Hi Hemant,

Le ven. 14 nov. 2025 =C3=A0 07:25, Hemant Agrawal <hemant.agrawal@nxp.com> =
a =C3=A9crit :
>
> From: Maxime Leroy <maxime@leroys.fr>
>
> When using the prefetch Rx path (dpaa2_dev_prefetch_rx), the driver keeps
> track of one outstanding VDQCR command per DPIO portal in the global
> rte_global_active_dqs_list[] array. Each queue_storage_info_t also stores
> the active result buffer and portal index:
>
>   qs->active_dqs
>   qs->active_dpio_id
>
> Before issuing a new pull command, dpaa2_dev_prefetch_rx() checks for an
> active entry and spins on qbman_check_command_complete() until the
> corresponding VDQCR completes.
>
> On port close / hotplug remove, dpaa2_free_rx_tx_queues() frees all
> per-lcore queue_storage_info_t structures and their dq_storage[] buffers,
> but never clears the global rte_global_active_dqs_list[] entries. After a
> detach/attach sequence (or "del/add" in grout), the prefetch Rx path
> still sees an active entry for the portal and spins forever on a stale dq
> buffer that has been freed and will never be completed by hardware. In
> gdb, dq->dq.tok stays 0 and dpaa2_dev_prefetch_rx() loops in:
>
>   while (!qbman_check_command_complete(get_swp_active_dqs(idx)))
>       ;
>
> Fix this by clearing the active VDQ state before freeing queue storage.
> For each Rx queue and lcore, if qs->active_dqs is non-NULL, call
> clear_swp_active_dqs(qs->active_dpio_id) and set qs->active_dqs to NULL.
> Then dpaa2_queue_storage_free() can safely free q_storage and
> dq_storage[].
>
> After this change, a DPNI detach/attach sequence no longer leaves stale
> entries in rte_global_active_dqs_list[], and the prefetch Rx loop does
> not hang waiting for a completion from a previous device instance.
>
> Reproduction:
>   - grout:
>       grcli interface add  port dpni.1 devargs fslmc:dpni.1
>       grcli interface del  dpni.1
>       grcli interface add  port dpni.1 devargs fslmc:dpni.1
>     -> Rx was stuck in qbman_check_command_complete(), now works.
>
>   - testpmd:
>       dpdk-testpmd -n1 -a fslmc:dpni.65535 -- -i --forward-mode=3Drxonly
>       testpmd> port attach fslmc:dpni.1
>       testpmd> port start all
>       testpmd> start
>       testpmd> stop
>       testpmd> port stop all
>       testpmd> port detach 0
>       testpmd> port attach fslmc:dpni.1
>       testpmd> port start all
>       testpmd> start
>     -> Rx was hanging, now runs normal
>
> Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
> Cc: jun.yang@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
>  .mailmap                         |  2 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 10c37a97a6..d92d4fc24b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1035,7 +1035,7 @@ Mauricio Vasquez B <mauricio.vasquez@polito.it> <ma=
uricio.vasquezbernal@studenti
>  Mauro Annarumma <mauroannarumma@hotmail.it>
>  Maxime Coquelin <maxime.coquelin@redhat.com>
>  Maxime Gouin <maxime.gouin@6wind.com>
> -Maxime Leroy <maxime.leroy@6wind.com>
> +Maxime Leroy <maxime.leroy@6wind.com> <maxime@leroys.fr>
The order is incorrect. My new email address is maxime@leroys.fr, and
it should appear first in the list.

Thank you,

Maxime Leroy
