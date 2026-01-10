Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AAED277CE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 04:20:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09675402D5;
	Sat, 10 Jan 2026 05:20:05 +0100 (CET)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) by mails.dpdk.org (Postfix) with ESMTP id 5652F4021F
 for <dev@dpdk.org>; Sat, 10 Jan 2026 05:20:03 +0100 (CET)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-5ed0b816d76so1140169137.1
 for <dev@dpdk.org>; Fri, 09 Jan 2026 20:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768018802; x=1768623602; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gw40RPgnxLtk2eACIYxg5X5N2y8bq8k48ZJbs0y75Tg=;
 b=kaO7LNJysQ7B0GWw0r1fMwWQYXm6LoMtFRSTl7eh8lnhG/VKnSME+5MG04CD3zZoV4
 jf/VIH4l7m7dWOdULXFr/K+kPRSVqI0IPhmEXc5kYtNFb2O8VdLJsggbl3OYyhV/TeZJ
 rU6BHUBpXqACHjclGTRXWS9wIqhpoEU3F+6b1GibSGiZQvt+k9mFiIJNl3vGN9Kd4bj0
 SpEYMItdohwSBqWbcjim09rrrBySnbUKf0y7gSn3HRSuCrUIxVGy5YNJI1+BNyuZmPGo
 7xPL6UmcNQbGV9S+fQeBEG4kRZ3xlTaZ/WKQauX9COuyIpzHah/bYAlU7sr4pGN6/9sR
 9U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768018802; x=1768623602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gw40RPgnxLtk2eACIYxg5X5N2y8bq8k48ZJbs0y75Tg=;
 b=ELS0gv5IKI4yEh8QV+Zh4e0yF4jQS+KE7xlKnnnnAiJD+feU56kC6UzdADjZk++tRo
 N4LlI3y8qKaqJRmWoBNAiC6Wk4d5uF+wCeGaB3jGuT/WcosexQQwwpJ6EWSa8it6zapJ
 EG57KyhbAmj9+G6nLC+3GtoIiKiw0aLlAj8H/cV6byzI/DCMFMPK7O/qApFkmkYsExJT
 IWlIGaaa77JDWSXsKtn1jNrZp6eMyyHVmeS6ZMAyoGWRz4qN6F66tbX7SETSU/hndMo7
 2nPwuMWBCgAgteXn2MtVt5o9z/lxQpuqsUX9qUcR/P9TP1psQ+zldncIwlrOFOjvKPtS
 T5mA==
X-Gm-Message-State: AOJu0YzXRoQSrcDn2kf8BtdLlfXJfDGFRKPVFs5xbU9seBHGwR2tGuPu
 3o8UCIDwQ+UxnzGgVHqR32i1qTWAfRI/jdsu8uj6+yNbNh1IUtG670Ge+DrONocMRUcX2sDy0kN
 qDyQhZNMV+GHDLl6RGz3xxUxrXTlH25M=
X-Gm-Gg: AY/fxX65OoaGgIvsSvr/UTTw0niCegQGAlqSM7EH7WSx1q5iTft/wUY6t2lhxMPCZXP
 /4Ptqvmt9sqLPbEmP0x8b/52q3RNF5837U6Mg0LyXkPODW9VijfKgM7QnkhN9VgIyWU64w0gEDX
 PMrOarBKic2OlTXvHrTecCR6Cw5tYNWg7rWaQjbsxi1zft1xeRNdltuHxrtAR0TZgVi5O5ap8pZ
 MTKV5zKx3j9/NuaGy1Z8qr7xV9xGryLDkuMV+vZ5e5vyHmYcjYV5ZwsBxRurUh7/YMdlCGs5VjF
 T57FyQ6CzSW9AP+qXC2IcHl1p0M=
X-Google-Smtp-Source: AGHT+IFqyBoGRr95YZFHFVzit1VAvSJtUkMomJ8UsOWIZ+TFKk1nn5MVZV4nph2B3Udm8QQzItnSQGgVjsjoWdPzn+o=
X-Received: by 2002:a05:6102:5803:b0:5ef:b033:8abd with SMTP id
 ada2fe7eead31-5efb033b5famr269188137.45.1768018802126; Fri, 09 Jan 2026
 20:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65638@smartserver.smartshare.dk>
 <CAFn2buDULHpj-5m1TXEcp0xUfMpTA9dKqEuEC98UhDp4qW21og@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65642@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65642@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 23:19:51 -0500
X-Gm-Features: AZwV_Qg186kDybe_sviruHupT2eDrX13-MOqeFPbIvcyXwaQ1lFWkQnNnVT9iYM
Message-ID: <CAFn2buBV+1z=L9Jnd52Kavvhxujpmpw_gaqmahLKAORcLWX4_Q@mail.gmail.com>
Subject: Re: [PATCH v11] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
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

> I just tested building our application with modified macros using GCC.
> With the changes below, GCC emitted slightly more efficient code (fewer instructions).
> It shows that using uintptr_t instead of normal pointer arithmetic confuses the compiler.
>
> /**
>   * add a byte-value offset to a const pointer
>   */
> -#define RTE_CONST_PTR_ADD(ptr, x) ((const void*)((uintptr_t)(ptr) + (x)))
> +#define RTE_CONST_PTR_ADD(ptr, x) ((const void*)((const char*)(ptr) + (x)))
>
>  /**
>   * subtract a byte-value offset from a const pointer
>   */
> -#define RTE_CONST_PTR_SUB(ptr, x) ((const void*)((uintptr_t)(ptr) - (x)))
> +#define RTE_CONST_PTR_SUB(ptr, x) ((const void*)((const char*)(ptr) - (x)))
>
>
> Snippet of code emitted using const char*:
>
>     if (likely((eth->ether_type == RTE_BE16(RTE_ETHER_TYPE_VLAN)) |
>   4dc47e:       41 0f b7 45 0c          movzwl 0xc(%r13),%eax
>   4dc483:       89 c7                   mov    %eax,%edi
>   4dc485:       83 e7 ef                and    $0xffffffef,%edi
>   4dc488:       66 81 ff 81 00          cmp    $0x81,%di
>   4dc48d:       74 0a                   je     4dc499 <service_ingress_dedicated_management+0x1b9>
>   4dc48f:       66 3d 88 a8             cmp    $0xa888,%ax
>   4dc493:       0f 85 3f 01 00 00       jne    4dc5d8 <service_ingress_dedicated_management+0x2f8>
>         if (vhdr->eth_proto == RTE_BE16(RTE_ETHER_TYPE_VLAN)) {
>   4dc499:       66 41 81 7d 10 81 00    cmpw   $0x81,0x10(%r13)
>   4dc4a0:       0f 84 1a 01 00 00       je     4dc5c0 <service_ingress_dedicated_management+0x2e0>
>             eth = RTE_CONST_PTR_ADD(eth, sizeof(struct rte_vlan_hdr));
>   4dc4a6:       49 8d 7d 04             lea    0x4(%r13),%rdi
>             packet_type = (union packet_type){
>   4dc4aa:       b8 01 00 00 00          mov    $0x1,%eax
>   4dc4af:       41 b8 12 00 00 00       mov    $0x12,%r8d
>     if (likely((*(const rte_be32_t *)RTE_CONST_PTR_ADD(eth, offsetof(struct rte_ether_hdr, ether_type)) & RTE_BE32(0xFFFFFF00)) ==
>   4dc4b5:       44 8b 4f 0c             mov    0xc(%rdi),%r9d
>
> Snippet of code emitted using uintptr_t:
>
>     if (likely((eth->ether_type == RTE_BE16(RTE_ETHER_TYPE_VLAN)) |
>   4dc47e:       41 0f b7 45 0c          movzwl 0xc(%r13),%eax
> +            eth = RTE_CONST_PTR_ADD(eth, 2 * sizeof(struct rte_vlan_hdr));
> +  4dc483:      4c 89 ef                mov    %r13,%rdi
> +    if (likely((eth->ether_type == RTE_BE16(RTE_ETHER_TYPE_VLAN)) |
>   4dc486:       41 89 c0                mov    %eax,%r8d
>   4dc489:       41 83 e0 ef             and    $0xffffffef,%r8d
>   4dc48d:       66 41 81 f8 81 00       cmp    $0x81,%r8w
>   4dc493:       74 0a                   je     4dc49f <service_ingress_dedicated_management+0x1bf>
>   4dc495:       66 3d 88 a8             cmp    $0xa888,%ax
>   4dc499:       0f 85 51 01 00 00       jne    4dc5f0 <service_ingress_dedicated_management+0x310>
>         if (vhdr->eth_proto == RTE_BE16(RTE_ETHER_TYPE_VLAN)) {
>   4dc49f:       66 41 81 7d 10 81 00    cmpw   $0x81,0x10(%r13)
>   4dc4a6:       0f 84 24 01 00 00       je     4dc5d0 <service_ingress_dedicated_management+0x2f0>
>             eth = RTE_CONST_PTR_ADD(eth, sizeof(struct rte_vlan_hdr));
>   4dc4ac:       49 8d 7d 04             lea    0x4(%r13),%rdi
>             packet_type = (union packet_type){
>   4dc4b0:       b8 01 00 00 00          mov    $0x1,%eax
>   4dc4b5:       41 b8 12 00 00 00       mov    $0x12,%r8d
> +            eth = RTE_CONST_PTR_ADD(eth, sizeof(struct rte_vlan_hdr));
> +  4dc4bb:      49 89 f9                mov    %rdi,%r9
>     if (likely((*(const rte_be32_t *)RTE_CONST_PTR_ADD(eth, offsetof(struct rte_ether_hdr, ether_type)) & RTE_BE32(0xFFFFFF00)) ==
>   4dc4be:       8b 7f 0c                mov    0xc(%rdi),%edi

https://godbolt.org/z/5bc1bTrhe
In addition to less optimal assembly, it also prevents clang from
vectorizing and unrolling (even with constant length).
