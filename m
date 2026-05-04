Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEECD3427
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 16:09:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB350402BC;
	Mon,  4 May 2026 18:09:21 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id D88A1402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 18:09:20 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so7263985ad.3
 for <dev@dpdk.org>; Mon, 04 May 2026 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777910960;
 x=1778515760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/FWJDqocW3NhnvoCuq8Rk1jtqve3w3elp7njJvA1Lg=;
 b=VyetAUyuaCaYUwdWR8QMZJzGQ0J57yZVOPIm+2TxMDr82nn6LTddoJceXjBkuBrrEa
 MUsVWozyXZUT1+4/86uGGc3ycX+OWmXdwyAhF8ohOvTKaUzHJbTMK258W0NbvqRAboy2
 UTcBeR6khzZvpI5RAoGm88316QZbjICRTTKBIo+nMBIcLrJwzKLQ0v/GSoKnA7jG8dia
 dRduHKGFbF1Oz1/lGoVbT9uTu/Gu4Qrpm67bj6J5WAXI+H0204HLE1ZfdXySPSrazwZP
 oqma3hEeoEvY7WyVGIIro14KwLjFDoln3sn6BsKRW4UC6yQneln6YnrkLN+DkYOnOfjA
 Fwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777910960; x=1778515760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/FWJDqocW3NhnvoCuq8Rk1jtqve3w3elp7njJvA1Lg=;
 b=U72SNkRTZ+C3wlMg2pi66ircpTyx1AF/IKK+WWEqiHFbGdHkQcBK5RnTXR3UGpSKcl
 2N/eOf4ZGnt5TZUz/fZJpRk4RJlGlAMukEkAtutZTWNTewOaDV06V9mI8zJ0jEJ0jaIA
 P5X1goBNhKKHGOzdcBUuLlEl49dmhBn7ITvRPozubpabWTaj1qAyrXX/WyDCigQGXqzd
 0ljAgebxRyVYL7k2RqbJaJYNPrKGJTx+pnLa/tFqdHF5ynE2UxzPfCUc8L4vy22iRJmS
 ApK+4HLhfmFpVy1sG34+0f3C/HnYvhqOvNzydlatIEOX1zNkwhWsFFf0lqY7RMjTyhvU
 Iw5A==
X-Gm-Message-State: AOJu0YzO9a4nx+FLjYsP5rtEjVxM9NWfGrQGsB9wxJYOFyT0aQ19SM5Z
 MJLvZSNcPr5ENwMTTN/+vnfsaAaHz+o5IvtwMbAaW66G1vOqH557AUz3SrdDzA5XzlD0AZID4Yv
 7vW69
X-Gm-Gg: AeBDieslxZEroI2DJUXfOVKwSb+V4gAqbq9/H/aYtUDdRbknyKqPx5GQND0jXfVO7FT
 Gy8fOPxPcrx71W6i5KF7eRaAROfliIZyd3d+Bwyam9ewqfj55WbobjtNTwWgIR7L7heflYnM4TC
 ZKRmnJOUAQtef8cjHjjNl5rSIxKmCZ3uzbNWTUxngLFlQba2ZK6LE3qjoKa1tT7K89nQ/JA7lfo
 c3w0TyPGMmKgRUj9Bw7SplYFTxhKbUkyazhRgAHSfDp1DNR7SrRrk1pNUvSXMBojyFsKmPHdo9J
 WcesX/JF9YDhmrugvy7FsmOrrPF7FHOJo6J8n9uIFQ8gmkx1qRG0N70MjxYJprGsDlLnFkHWL/e
 cS4YsLsATEXVgJ6V4Y8EAm3RmGMo6H/ju6mG7o9IOlTz8bgcICfyoIwSx5ebE+rIHq5Q8AXTJdV
 92QcitqhVrDyJKPIbW2Gv+fksGh6XPk07B0vWbziEoofwjL/RF8ZeKKdRY
X-Received: by 2002:a05:6870:6394:b0:42c:f4f:dfa5 with SMTP id
 586e51a60fabf-43475fc5896mr5018131fac.6.1777910485954; 
 Mon, 04 May 2026 09:01:25 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-434548ccb52sm11143502fac.1.2026.05.04.09.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:01:25 -0700 (PDT)
Date: Mon, 4 May 2026 09:01:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v10 4/5] vhost_user: Function defs for add/rem mem regions
Message-ID: <20260504090120.2c00c986@phoenix.local>
In-Reply-To: <20260407224205.3910803-5-pravin.bathija@dell.com>
References: <20260407224205.3910803-1-pravin.bathija@dell.com>
 <20260407224205.3910803-5-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 7 Apr 2026 22:42:04 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>=20
> These changes cover the function definition for add/remove memory
> region calls which are invoked on receiving vhost user message from
> vhost user front-end (e.g. Qemu). In our case, in addition to testing
> with qemu front-end, the testing has also been performed with libblkio
> front-end and spdk/dpdk back-end. We did I/O using libblkio based device
> driver, to spdk based drives. There are also changes for set_mem_table
> and new definition for get memory slots. Our changes optimize the set
> memory table call to use common support functions. Message get memory
> slots is how the vhost-user front-end queries the vhost-user back-end
> about the number of memory slots available to be registered by the
> back-end. In addition support function to invalidate vring is also
> defined which is used in add/remove memory region functions.
>=20
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---

The rest of the series review cleanly but AI flagged one issue.
The initial description was a mess. Asked it to be clearer.

## Review: PATCH v10 4/5 =E2=80=94 vhost_user: Function defs for add/rem me=
m regions

**Warning: incomplete cleanup in `vhost_user_add_mem_reg()` mmap-failure pa=
th.**

What is wrong: when `vhost_user_mmap_region()` returns -1, the handler
only closes `reg->fd`. But `vhost_user_mmap_region()` can fail *after*
setting `reg->mmap_addr`/`mmap_size`/`host_user_addr` and after
`add_guest_pages()` has appended entries (the `add_one_guest_page()`
realloc path).

Impact: leaked mmap and stale `dev->guest_pages` entries. Since
`nregions` is not incremented, the next ADD_MEM_REG reuses the same
slot and overwrites `mmap_addr`, so `free_all_mem_regions()` can no
longer reach the original mapping.

Fix: when `reg->mmap_addr` is set, take the `free_new_region` path
(`remove_guest_pages()` + `free_mem_region(reg)`) instead of just
`close(reg->fd)`. Keep the explicit `close()` for the case where
`mmap()` itself failed before `mmap_addr` was assigned.
