Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E04DC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 21:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DDB740E1C;
	Tue, 20 May 2025 23:21:50 +0200 (CEST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 30D1640E17
 for <dev@dpdk.org>; Tue, 20 May 2025 23:21:49 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso1081041766b.0
 for <dev@dpdk.org>; Tue, 20 May 2025 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747776108;
 x=1748380908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFcj26jR1CM5cvk9mIqsnYeWLzcUIQB4jOFs7biKjKQ=;
 b=znN7dKr4wNChtUv1FQdRnqNKcxbc8aKuXnUu9xsFDsS3WPHKq5lq3IREz9VnHICF1C
 iR3+spGPzPF5/C8JsNpmmFkfkoOLTG+kVMd9WaJ+12J2DgNPrg0epb39UBZxTS6MPDtC
 gROxuDVzCwWZHXGZrAtosbyaj4Z2tUH7Iq5ULbm/PjCTsPAmZqGxdWV4/PMJcwjhL0Mr
 lmKSCDKaVTtteCraQD9LN0JgRZOvub0L4FuHDsL3iPU/A2DQVXeMeLoRp4f/UnkeDKvn
 Lob5FeIMo1gMGfF+VBltCj7pvYeFHBzuh3ASoWQ7PfzuqULeYF5tZhoLpVv9vcBQFTeC
 Y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747776108; x=1748380908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pFcj26jR1CM5cvk9mIqsnYeWLzcUIQB4jOFs7biKjKQ=;
 b=OSctKZE1mtjQVKPtNEwNL/DCDYqOiVGrH+mYCoTR8B6zHypy84YtaNy8IBZZc54R5a
 Rn7bJqTYQHqHDb5j3YYdOf5tSIpUMf0e4QELYBJYPSgjlg+rvInZRht2pADIi0W/nz8M
 3rpIhoP1kLFA+wTBgpzXgG3ZJlZati6PhMTKpEKmvt1MukdHrpeL9n8duxVxFLHb4qbR
 hV6V6oBosr1PuzBYRJDXUbtGnZHgZpcGkXCO0Xuoe61CYosXC/t3d41vXWGTZO7AEaDr
 jufXRBoVTCoj6EwQLxUVFm4UYDcq9OKLCJgalpp08qpkcrpEqlrv8o3gerEj6a/IG3GE
 NkCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcnLupwfw0drqZ2jjhT5lkQzsTygpp/x02eUYavcKNHGDmlnVmZ5kjBwfdG1fsGAlAlBE=@dpdk.org
X-Gm-Message-State: AOJu0Yx9gvXsBZQwmL18L0MGmhkpyk47xoJv1g9TWPo8ys9qHSebpmnX
 mSM6AAJJpuGt66rdulQu5LkZz0SljVaNN+lbXZntKyLMBVqLmR+NQhoSe3bn9z/Tk0Y=
X-Gm-Gg: ASbGncsXPBAi0vd3zFiDpfGBAoDTR6rAb9sP/ssBPN9Un3DJssmcvzjmLECThI9WEi1
 eddc9lwDW4FdokLlRvkLZE85SDBN53AatyDXaQp6EEB9FBrAd9yqKCgViLyHc89j4wH+d4f7hvH
 7t1Z938f62W01nhdt+E7mRC6vTSeXfyfHae9zF74/MocvVSsgIsnKD++Pe4R8dxJCM9Iozl38Ro
 CfQX41eH+beHzM30xZCrBLJGHohBxBVnwPd2wZonzCpqxGYP63iSL8nL4K8JK4RgBGwJk7lSE9w
 KaD1I1cYk0+TbL9wvuq01UwdePPZd3PDKFnhZFG4GtFhhrrU2wXSIc+MJ6fhPahS3qQxyo+n8Td
 tESWTxfQjjWkFQ+P/ScPQ/IJyxE+b
X-Google-Smtp-Source: AGHT+IHjpIviqNszfOJ1cnVh2TX2JlDO1RATMuFaURzAcTP2hod0SLN2i+87nk3PTi/68KVK90HUHw==
X-Received: by 2002:a17:907:7ea1:b0:ad5:7529:94d with SMTP id
 a640c23a62f3a-ad575290c0bmr619378166b.42.1747776108405; 
 Tue, 20 May 2025 14:21:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad5572f6402sm546117366b.178.2025.05.20.14.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 14:21:48 -0700 (PDT)
Date: Tue, 20 May 2025 14:21:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Jie Hai <haijie1@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: fix offset calculation for GENEVE packet
Message-ID: <20250520142137.366c8235@hermes.local>
In-Reply-To: <20250519160711.4024414-1-skori@marvell.com>
References: <20250519160711.4024414-1-skori@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 19 May 2025 21:36:55 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> While parsing packet headers, offset must be added to get next
> header but for geneve header parsing offset is overwritten.
> Also inner_l2_len is not set in case of geneve packets.
> 
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> 
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

Looks good, but why reorder the assignment to *off ?

Could just be:

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index be24690fdf..cdad463398 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -252,6 +252,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
                        return 0;
                geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
                *off = geneve_len;
+               hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
                *proto = gnh->proto;
                if (gnh->proto == 0)
                        *proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
