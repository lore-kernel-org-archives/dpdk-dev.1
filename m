Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3912C35FF3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 07:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B16564069F;
	Fri, 21 Mar 2025 08:49:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F6A440693
 for <dev@dpdk.org>; Fri, 21 Mar 2025 08:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742543362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qD3430GbI6OxEoPt2cyucqlI1/FiL3OEosSAFhdEt90=;
 b=UeIekxDtRo5oLgvHqPavIWApYO9+m9rCwudgzA1sel+7pPTciDGrOIWbo4+vXqVyfeIVTg
 EBXX9m4P4K7YaY1aonoXaAWuk8P1dTyPQw0/CGtGPLavhtjeDPJbgOD3Tk4d4tGMgCj7ic
 hEki8EbHPyw5W/HHSh/pXnktYdDsNmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-qaoA1POtNa6kmuFUYAP88g-1; Fri, 21 Mar 2025 03:49:20 -0400
X-MC-Unique: qaoA1POtNa6kmuFUYAP88g-1
X-Mimecast-MFC-AGG-ID: qaoA1POtNa6kmuFUYAP88g_1742543359
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-549aec489c5so802112e87.0
 for <dev@dpdk.org>; Fri, 21 Mar 2025 00:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742543359; x=1743148159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qD3430GbI6OxEoPt2cyucqlI1/FiL3OEosSAFhdEt90=;
 b=fRyy5vdO4n9R0Z5wLIqDSi2jq2ggXyC0cF6KBSPXqik0QK2RcT/GHS2fIvnQKndBPx
 9+XbcDHbsyhfFFqLVxjP2wLrSllFctIekqLx7dE25pigJ5QKNdc3JPLhQA0Xa08KgBZP
 pngQfyC5IVbh6Vz/VUeKd26sihY8Rw6WxoEfZlPspMgCwpPiFuqnUjk3V0MiBn6JsUoC
 /da5Xht1mQ9BSYD4eAe0lyHpmOMl2CnjoSrpXu3nWBC9bJZEwzYSHey7oppHyt4Ts5iB
 yvWMcyh4VbkvRd6rRz/yw9aqjVqHJhgWzpXxYDOBw4g6MFgcURwz5Ln/Gh0/qaCQBGMh
 5HXw==
X-Gm-Message-State: AOJu0Yzy4fbV6c62z1WraLIb/3kJpHJLnxay9CrIrYbb/Kk8VErMt6R8
 MkJlfw+auE4zItaAFmq5oTyYZm+640LftCLMZkd0DYV5uvgWL0DAWwDfqIvq4RQXX/0rdU8CAWu
 qpLxjaXZ6yvNAwnsotJf5cz2yndMDkAWE0F9Lr9WTgln/UpcxaeQFRv/7B7OFs6k3aBIifaFEiV
 F4lBAdIt+Duqg/DFo=
X-Gm-Gg: ASbGncuvH+GXt33CNs2XY67CbNjfZGx9AwfHo9Qs+W3oXVPBC5IZwMzk3upNchdL9ya
 HL3AwSRZRAm8Q6yaJm1eNNE4oPMAne9Wa05MlwSs2oNqv9hA8ACq9x7P3VDhXxaCAOrakLWrpEx
 o=
X-Received: by 2002:a05:6512:6cc:b0:549:86c8:113a with SMTP id
 2adb3069b0e04-54ad647e332mr885447e87.15.1742543359384; 
 Fri, 21 Mar 2025 00:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ1/eaGbf/BQU4J/WgT5yX3b9IdWVheSRpz6/754sIpujjUuPXx5TzEoAmyLyGKsjP5Gy3e19k/LXulBQGsdQ=
X-Received: by 2002:a05:6512:6cc:b0:549:86c8:113a with SMTP id
 2adb3069b0e04-54ad647e332mr885430e87.15.1742543359043; Fri, 21 Mar 2025
 00:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250321040316.104126-1-huangdengdui@huawei.com>
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 21 Mar 2025 08:49:06 +0100
X-Gm-Features: AQ5f1Jr5CkBzlN0eESIZcYmyARxQ_55Ni0F1dqdVveFQmGg-ceSS1sEI06w5efs
Message-ID: <CAJFAV8ygEGSfwb0Pc4hf-QM8dHTYNyD64craGxu0ptamvHqBKg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix the problem of dma-perf infinite loop
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, honest.jiang@foxmail.com, fengchengwen@huawei.com, 
 roretzla@linux.microsoft.com, lihuisong@huawei.com, haijie1@huawei.com, 
 liuyonglong@huawei.com, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uxB777Uu5U5g1jM4poxrsQ_SsvAzs7CLCXPosrWAUEM_1742543359
X-Mimecast-Originator: redhat.com
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

On Fri, Mar 21, 2025 at 5:03=E2=80=AFAM Dengdui Huang <huangdengdui@huawei.=
com> wrote:
>
> After CPU isolation is configured, an infinite loop occurs when
> dma-perf is executed using the default config file.
>
> This patchset fix it.
>
> Dengdui Huang (2):
>   eal: fix wake a incorrect lcore
>   app/dma-perf: fix infinite loop
>
>  app/test-dma-perf/benchmark.c  | 5 ++++-
>  lib/eal/unix/eal_unix_thread.c | 3 +++
>  lib/eal/windows/eal_thread.c   | 3 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)

We can make EAL launch API more resilient, but the dma-perf
application should not post jobs on non sense lcore id, in the first
place.
parse_lcore() should be validating that the requested lcore_id is valid.


--=20
David Marchand

