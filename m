Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F16CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 08:50:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B4E40280;
	Fri,  7 Nov 2025 09:50:53 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9301C4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 09:50:52 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ed83ad277fso2573651cf.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762505452; x=1763110252; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WVkpfFE9zei595UnrhWaaosCCgnihPVC0RLOWv1bpI=;
 b=TW/+JMasvuaihhreiTsqpQbyjFYIoIp3V6UYiM8A59cHjaC2jaXEgLmhoP/GeGA66T
 q7jQWRrvpbQgkhBT9aJ1RH3lPKcDpDpoK5Qjqi8XGYfF6JiT5cc7Z25xpfSTd8uFBWkq
 l7r/X3K2wUfMGTSJahnjN+Zo2R10gnxVv0yMj65FYqk9MfYa5ps8Adp3S5XBh6NyoKsN
 LpeIep18hLzritSRl5Uh1U7XYAlAYJ+ufkLRFgzF94nNu1IFkLY8NVdQ+iMWhiGb1WY9
 hAIgqto1tSw3aZiJIdhDWcyRG1bkl5UKUI/sSQ1o+3fXNcRUiYJleCIY14praua7tBkV
 qk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762505452; x=1763110252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/WVkpfFE9zei595UnrhWaaosCCgnihPVC0RLOWv1bpI=;
 b=guLd1acfvxkEp/wxfNW7ZLAl2GPlLwxjYOE7nEPVaHEEYHVcpOv4PM9Muaevm0e5s0
 Lf0lLNDizuLwFhMGwV2MWzupH1EtCx0qha6KZv3KLiW23kss1tzdEax/eCL/5K7gO0XS
 1W61VdgZvU6ESSd1yjQFYdlUXijNxfNk2u2EhfYjkP8RkV31Vq2YpPlJi8zOchswk+1d
 vfmVMw5Kvi+TJ/TkvDE7qdouC3ddOHu6y5O9pTrhDHE9TaRxJJU3z0tN9wDsTpyZZj2Q
 9cRWfnoWGln22Uk2S4AR5mF7fcv4Al0x9mROjIFYfRjwLk2xMLgZtlFQoTbaq2La/8nQ
 4Zhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj2YKU665MTZDtbYa9tgSK2CALQEi5enD3st8MeyZLYIwd62ANuH+N2zB4mJCMC9mq1FM=@dpdk.org
X-Gm-Message-State: AOJu0YwmhyRjYkEslhHx5iZ1v08iWO8s17jFVse+0uvL3oAyikfGduuy
 4QM/wWgC8LKmjSK2IIkKXLdktM/TRFdNkEBI5FLXIYvedRnF9HxVcZTnfUXuxeRK/b4MT2UkVqv
 vSWHFVNLetLLZGmzdsrzop9lCHhXrbpQ=
X-Gm-Gg: ASbGncsK/4sq9EG+iUy1d2lNfR92xFk6vi7PE9yHdzgopr3XKcFARF7i6FHVETqsTnl
 iSpMOgIxOjGjw3aJ/CAooP23ye5DxQ23qJydZTp0p8t/mK/D4epjQu7eA1xcud0uQTdz1u0ltbR
 IAK+UqCazdsJzVgtX/IuCM9rbK103iBIASTO2rg5lBn4KhzgxhDw6NJConsLgp9/aKErm6ddojn
 S0zERTK/PPIvKgYMF/i2O6EseOoKjsKlje44WiJ4dZ33k4WIb0OyRipG66hTxWyr9A3e5s=
X-Google-Smtp-Source: AGHT+IEmTloRCBJOT99pJMGIufk+NVnOJR0YSOSQ3taw3Bu2uokD6kEjz4ra5Mxzc39kvL1oy4IenEJw8jGg7lrNPh8=
X-Received: by 2002:a05:622a:89:b0:4eb:a439:5fe8 with SMTP id
 d75a77b69052e-4ed947d16bdmr27302731cf.0.1762505451797; Fri, 07 Nov 2025
 00:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20251104080901.1610706-6-skori@marvell.com>
 <20251107070330.2155154-1-skori@marvell.com>
 <20251107070330.2155154-6-skori@marvell.com>
In-Reply-To: <20251107070330.2155154-6-skori@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 7 Nov 2025 14:20:36 +0530
X-Gm-Features: AWmQ_bnu_70C8sH0nmxwvwyhRHZXepPXkYLMFYaA60kkWU_Hy2SgJY4SYtU1z14
Message-ID: <CALBAE1PVigFMAZW_U6TfdBqv=w6WHM=kdA_7dMBcoJEo_GU_Ug@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] net/cnxk: report link mode
To: skori@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 dev@dpdk.org
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

On Fri, Nov 7, 2025 at 12:41=E2=80=AFPM <skori@marvell.com> wrote:
>
> From: Sunil Kumar Kori <skori@marvell.com>
>
> Reports link mode whether fixed or autonegotiation
>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
>  doc/guides/rel_notes/release_25_11.rst | 8 ++++++++
>  drivers/net/cnxk/cnxk_link.c           | 4 ++--

Series applied to dpdk-next-net-mrvl/for-main. Thanks.
