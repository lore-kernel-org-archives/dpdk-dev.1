Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBFFD8FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 15:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D73884026F;
	Thu, 26 Feb 2026 16:42:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0ED484021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 16:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772120525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PiR4s/qXMJwDqWXl47wVmZyhCzVFx39ZOsBgd+xO9+k=;
 b=ae+k806IR8EcHDmu98+KZ6Q4NxmavV/ztVBI11qnVPwlze7s1Hbh8eHll7P3+9uqcC3QNW
 3IdKZtyEG3v4+ttht052/obQibbKL4FuCFdf2A5G7n7fL+9v25Hbwusxs+4+w8d/P8GPyk
 Gb7lW4rjfj2b+O/N6rNiPGJ+PFC9EsI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-CbkCqm3KMmKy4Vk69sammw-1; Thu, 26 Feb 2026 10:42:04 -0500
X-MC-Unique: CbkCqm3KMmKy4Vk69sammw-1
X-Mimecast-MFC-AGG-ID: CbkCqm3KMmKy4Vk69sammw_1772120523
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a10a1a2e78so516038e87.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 07:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772120522; x=1772725322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiR4s/qXMJwDqWXl47wVmZyhCzVFx39ZOsBgd+xO9+k=;
 b=Su9ZwRbP9W3yR9aHE/ZMn3zVDx0AdTXCg/ZvXgyLATn8sKPeofxzWS0HY9z7JZ8+hw
 1YFw8m44x3fEd98znTRhhkXhJQCAn3yAxANGdid3lAdriqGd4I/Rq1LmeR1vnFU138yH
 VbHfkiisB6h9QUFFYBtKSDlWS4+QZTPdCpqm2RJJtDW67NVWZFpb0zlDMQARzYX8bz6L
 cy3m4b8gss8xw6DeWqb2YLezndi3okEMXFJE1cyKDpK4ws4AI7D/NBkp4/5wI1jwzulN
 FPr7eOevQbyv0iQAg5KHzIdjuD2InkGw4onRlrJ+lQ6HRWdYNqAi9Vcb/gtkZQUsdU3e
 +/VA==
X-Gm-Message-State: AOJu0YyVYu6aLqpT/cHlwI+si87v3kM0rPmVt3PfEvPW2yPlsbio1nhB
 1K0jQiUV3eRiO5HGNO4srKOgqXZjHB+J6LZRG44a499yCUGjFopHhfUPUkLQpSp+LVBWL1wcdmR
 T0eDJgR63C+2tfv9WYOqOTFExYyJnkUzii4f/dK/9j68h9eLZ2A/XD5jJVyZMdwEhPFM/5yH5Da
 INwS2c0y7Z4ykS372RI2U=
X-Gm-Gg: ATEYQzxj39rQnKJxO2tQCFPxTCqffqNtlbLbcBqCmbUT4iAis/TRB1SydmU8wtuUFHl
 pR4L3WPPerolX6sjeB+MLidH6xm6nrTIXZUz93vDOZs2cXrCzDSn7B0hWFXeGFcxOXGbFUpqfWf
 KVoLTibZWnDfBo2N8CDprWgaFhm0RN6GWeyAYIEByQu7jPMZyktsO1dPUTKpU+zZG9E/MyD/ORf
 uhrBpljHRAFaXNhHVMRsuj7KKQXLAmGiAS7bV7co2FEpZfvb6/DtZijcVMSw3bCO8Au/w==
X-Received: by 2002:ac2:4647:0:b0:5a1:d06:50e8 with SMTP id
 2adb3069b0e04-5a10d065120mr496164e87.6.1772120522443; 
 Thu, 26 Feb 2026 07:42:02 -0800 (PST)
X-Received: by 2002:ac2:4647:0:b0:5a1:d06:50e8 with SMTP id
 2adb3069b0e04-5a10d065120mr496156e87.6.1772120521987; Thu, 26 Feb 2026
 07:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
 <20260219143852.200722-3-ktraynor@redhat.com>
In-Reply-To: <20260219143852.200722-3-ktraynor@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Feb 2026 16:41:50 +0100
X-Gm-Features: AaiRm50529qQgb30ZvaEAcZ3vkRVWqOncnu6ZICfoiu_mmHEPdF-Rjo_hON4R2E
Message-ID: <CAJFAV8y7F1taC9bP4693x0PcstJxW-E45o0DpV2Mw==YGd2+Kg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] eal/interrupt: add interrupt event info
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, dsosnowski@nvidia.com, 
 viacheslavo@nvidia.com, hkalra@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SBPzaABuacWf2QP0HcTveuvVHtpKckwH4C5YikryL2w_1772120523
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

On Thu, 19 Feb 2026 at 15:39, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> Add RTE_INTR_EVENT_* defines and a new API rte_intr_active_events()
> in order to retrieve them.
>
> As the events are in the context of the current interrupt,
> rte_intr_active_events() must be called from the context of
> an interrupt callback.
>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

I have mixed feelings about letting this API in the open.
We only have one user (the mlx5 driver), so I would mark it internal
for now, and open later if some external user asks for it.

And on the name itself, maybe: rte_intr_active_event_flags() ?

[snip]

> diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
> index 1b9a0b2a78..bff4f98f85 100644
> --- a/lib/eal/include/rte_interrupts.h
> +++ b/lib/eal/include/rte_interrupts.h
> @@ -40,4 +40,10 @@ struct rte_intr_handle;
>  #define RTE_INTR_VEC_RXTX_OFFSET      1
>
> +/** Interrupt event flags returned by rte_intr_active_events() */
> +#define RTE_INTR_EVENT_IN    (1 << 0)  /**< Data available to read */
> +#define RTE_INTR_EVENT_ERR   (1 << 1)  /**< Error condition on fd */
> +#define RTE_INTR_EVENT_HUP   (1 << 2)  /**< Hang up / disconnect */
> +#define RTE_INTR_EVENT_RDHUP (1 << 3)  /**< Read Hang up / disconnect */

Nit: RTE_BIT32()


-- 
David Marchand

