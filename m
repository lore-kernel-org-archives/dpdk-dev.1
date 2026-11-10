Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E54606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NJIunTsH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D9F40281;
	Tue, 10 Nov 2026 17:51:39 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 983E84026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:51:37 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso1195102a91.2
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794329496;
 x=1794934296; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pKwZRaEYGyXnWaTtKRRdDWeN2No4zqn/ioOCnLw1sw0=;
 b=NJIunTsH6TGmHFlr2jGXLYh9BsfrRWEPX7eu5tI2EXElO9i/Unqqmro4X6cW8sUkph
 uGInwziGP0kXvPh+ygea466OMHAUkYnlgLXUo5W3XWMBT4XOJLnm06aXRfcHNY9daugH
 FkA3Lacxs1TeWHZazKCWyT9C+ds2rN8n+K5fMZpLVK35wi6IWARrShcSRJdjPOhnJ0dG
 ZKMRq8MMgl9YbdVv7oO1rgLVqNajh/7GAwaq7AhptcC1aEyeFS9VXMkHrsxExXa6R5n+
 ASNypIbFTTIwTXXkQ+bunE+5YLZRDYME7nK4bO/l1Q77fZI1/MgRlzkX1hMcM8CfvqWe
 /bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329496; x=1794934296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pKwZRaEYGyXnWaTtKRRdDWeN2No4zqn/ioOCnLw1sw0=;
 b=N7F+/gpEEL3m281x/DeF5kmRzx2mav9e9pKdAeQ2u5F6rKCXCkVfHzAGgMT6KrgdJc
 nTtBznk7aou2NdPNMWEvE7UMxgs2iZzmZ/2XKgd/AG10uralVph+aD0KGAAs2oaLcn+V
 BKBIWE3Kyjh2J5aOOWDZswdJON/IAhO+6MTLoe1qs822NEq1ytsSdoPZHW+rvq1zUp0M
 dqxU5uDoiuEzox7HB/DRhq+aWeNgiIeOZTt7ue0U+OFEVn3jRiQA0yn0lv9AqnrKxPJr
 miL9oyvfw2/DmmSmQFjV896FgBmb7Y3CtyWGzYA1uKUhe/nefCdxVamuNZJrgUl1NcIt
 V1Yw==
X-Gm-Message-State: APuU4Z94QOu9fucFxJZjIiAYvRdRsfjyywYQMk1gi3kX52H0PEhtcNDf
 x44Sxfm7uy1NqBIyXKBKUpqbfqV5PlwCNYypioaoy1fcaoRHTS+qDyAVPvqFnKQd41Q=
X-Gm-Gg: AYBFou2lpeAujFS93nfQAC4nCml+TqHNFN+01PaCGRyTKPddWFxvGhDHoH/eQaaRPMb
 KTF354Ls4as/mRobYzRwk0x4ifB586wGKtx08OBf1i4a+NX20i9Ob8BWuz5bhyDGZkjz8jH32VC
 8au7Vddw4te1yqVRAoFmfvNCBJudAtEBQZtct4Xio1O2aqIA/dQLkEO9TbkBeq0Qt9xkvZq8gMS
 66f933jsPWguLp6OtiIeXkUj1ibjrS2d4y8exQfQ6WtD40GxOqItwuP6ZAvrZJBLFy5skS1EOfB
 K7brVqk7Ea/7AXoiiLVQ8dALiHlr/nnHESNNBSOTM7QUDuUHcKKH8+rzkC9qIKW7AH8ImqTo1IT
 fjF8L0PW46qLlar7wLbPjlr4J73DdNcKKvQnbBx4ZRopGsv0Wwe757n5DxZZHUaYoWQM0/m23SA
 8BfW3txnzY/KLpUduEJkHG+H/sVPbAv6vnk2QyCZs8kKCi4TuHBgy3p9H0dsTi0R1VKymTyCCYW
 sDJ6dCCdvp0OgEALnbLLDk1w1KMBVBLI/aiDK2+AvWChpjRQyld3ft12Gfnb1w9Ix9OnBRy076B
 VRz2ewQPEK+sP/Z2FDiwQdxxbrKI5C34PGs+ceo3kA+9e57ceCVAhD+OOAC4ElHB5Wan+gk=
X-Received: by 2002:a17:90b:3c09:b0:3b0:b35e:b373 with SMTP id
 98e67ed59e1d1-3b166ac9e5bmr3386797a91.4.1794329495827; 
 Tue, 10 Nov 2026 08:51:35 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b17e0d0e16sm402347a91.5.2026.11.10.08.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:51:35 -0800 (PST)
Date: Tue, 10 Nov 2026 08:51:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <dev@dpdk.org>, Frank Dressler <frank@dressler.pro>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, Kevin
 Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH v2] net/af_packet: fix build with old kernel headers
Message-ID: <20261110085132.67619c96@phoenix.local>
In-Reply-To: <20261109154730.146345-1-bingz@nvidia.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <20261109154730.146345-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 17:47:30 +0200
Bing Zhao <bingz@nvidia.com> wrote:

> The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
> but it was only added to the uapi headers in Linux 4.20. The build
> fails on distributions shipping older kernel headers, like RHEL 8
> (kernel-headers 4.18.0):
> 
>   rte_eth_af_packet.c:1057:41: error: 'PACKET_IGNORE_OUTGOING'
>     undeclared (first use in this function)
> 
> DPDK requires Linux 5.4, so the driver does not need to support older
> kernels. Check for the symbol at configure time and skip the driver
> when the headers lack it, instead of failing the whole build.
> 
> Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> ---

I liked the v1 better, looks simplest
