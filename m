Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C6C021B8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 19:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D3FD40287;
	Sat,  1 Mar 2025 20:36:02 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A64A040281
 for <dev@dpdk.org>; Sat,  1 Mar 2025 20:36:00 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so5205036a91.2
 for <dev@dpdk.org>; Sat, 01 Mar 2025 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740857759; x=1741462559; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7pLaPZCLhBoky1ruaR5dnGszWx5KdcTnIjK0snBILsk=;
 b=AvvuzEXrwO7+qSrBR/oxuViJR87dYBs3kJizs9TEidbDvXe+DS8MTeTRmaSqMvHac8
 NGDqL7UQJNO/0EjshTC5NE/2VJSm3E3K+S2vg/rDGzXkF+oHuqX/DIXaZKj9E33XzKoW
 NZ+tFvmxUW7esi18cG5ztN0kUvs5jpH3NSgvH7iLP7eqt5W24SFzRxGtBzMzoBT1aVeN
 bLPIH0avpozTfGzmYnFhuYq0Mk4AMXCn6B6t5hSTLu/HW/MGJNCEPgyOow0qsQ+FOwMu
 EB+rkvzcsLtOQ/xTHsxroYnncGQuGVMDf1mL6GlxKhkf2SlVSsK62AZIMJfzoIKX5Xav
 MXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740857759; x=1741462559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pLaPZCLhBoky1ruaR5dnGszWx5KdcTnIjK0snBILsk=;
 b=t2hDLNdOwSkqo+p9G2kI/Jrgrb0W31iYfrVVxqAeQaLDQVOVR7sSZ3C13t4+fcAddx
 /V6MBE4vPfXlM2830GTVtq8rmZ0zS8kZyH5C8sfpYbSV4A96jAOA5yHezvHB/dMppq46
 /W4s2q9LgLJ4SEvm6T9rgXGgO5hP4ZHKE1QI2e89PWwzn04UGmE/4Qk7ckGbUdfu/85d
 hvGezzM0ucOEbNc1Qs2CRmtTvlUlNyhoCRXru1Gu8Rb4GcuM2GLxOY1/S45X4oXrWPFl
 CJMxIVQFhYvawQZIQYroB4Is+qFvPgyM8ygPxd5qrAo2Rla5dqXY+d5O9nNAOqrFcy0j
 1YSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqQ2bLUFoMSX/A6Pn1oRR74As2idSVqhAP40QR2s5zJOLv5qsS7u017HBZZ9njxt2iT4U=@dpdk.org
X-Gm-Message-State: AOJu0Yzew3WFo8WW9Bi14FSLmL5kNQZMI9tYYu7tq+hlGrHYE2JNiuBW
 rg+JbDxwHviIPdV5kMaLFgEISHAR8Z29WgSISSKZuXaKfQPDuboLQ9KZur4FXPaAkSqSqz3He8t
 ylI8Oo2nmh8iJDveeAzXruR2luf0=
X-Gm-Gg: ASbGncu4ycd4mVyRfiKqP1DLpAXtKV9C4Us2Qi6NbJgeTpc9lz1NeXWHxg6u0mFD7QP
 yhWYVxPNuLcYtg2+e6NeAXs1EacuMgyjkgthY+3wejuGamQNivSJr2hghzz4Toi/FI2Y/lyiKZB
 b+cWYmOcaf9TonB4RWA5I6huxnhOk=
X-Google-Smtp-Source: AGHT+IGfujraHf+PltZ5UakWzX/0nm/qt80037mKaJEXpJZkHxEXZ4p5G6K9anVsj0jArZ7pTQt5iYLPyz1sgSBDQU8=
X-Received: by 2002:a17:90b:1805:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2febab2be22mr11443959a91.3.1740857759445; Sat, 01 Mar 2025
 11:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20250301022622.GA6940@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250301022622.GA6940@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Date: Sat, 1 Mar 2025 22:35:48 +0300
X-Gm-Features: AQ5f1JpQ0DQKiqw4HKAkr8AsjgQ76KfajzyaJQwqnNJhFKotQyu7vYYV2XdrCjs
Message-ID: <CAEYuUWCgT8DUyHvUdnDo1r1YisU2JYfctRCNaq=kFusXPe_nQg@mail.gmail.com>
Subject: Re: Segfault in rcu
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: honnappa.nagarahalli@arm.com, dev@dpdk.org
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

Hi Andre,

> @@ -386,7 +386,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
>
>      cnt = 0;
>
> -    char data[dq->esize];
> +    char *data = alloca(dq->esize);
>      /* Check reader threads quiescent state and reclaim resources */
>      while (cnt < n &&
>          rte_ring_dequeue_bulk_elem_start(dq->r, &data,

In the last line, "&data" was equivalent to "data" when "data" was an array.
This is no longer true when "data" is a pointer.
Removing "&" fixes the issue.
Maybe coccinelle can check for similar mistakes caused by mechanical
replacement of VLA to alloca()?
