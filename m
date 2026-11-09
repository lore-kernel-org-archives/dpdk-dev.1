Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A1606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BJCrrqyV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2700C4028F;
	Mon,  9 Nov 2026 18:47:05 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mails.dpdk.org (Postfix) with ESMTPS id BDA5940270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:47:03 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b16896b8ceso7652a91.1
 for <dev@dpdk.org>; Mon, 09 Nov 2026 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794246422;
 x=1794851222; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ksrFLXL2ztzYPPOc4Pk3sXsLOAZZW1dDws3nMeN9ujY=;
 b=BJCrrqyV66jH+g2h04Yw8MoNKgKB8i2oG4AOkpDfAZN7eXmFwuSsLPe35s6/swFPJk
 tXDIdi4lTFBrAkFNfHVg3O1aLp+qiQtOHRWsFbP68bCjo44MwRT7fCvICbPLKxX8WQlI
 52ximcL+N17T8JaMGOEPjHUT/olVcwVi275r5D/xxZPXKGEk89JhFXtrtMjdFNaUGNpt
 kcmBN8sronbjwBajiSb45FN6sRA2WQZAep9C+okgLoj94WlVz3eFTCiLHhbRTpeysaD6
 9A/kCTnOsCpOaJ6qKDOS1qMD9DkuG0gBo8gh5Kzq5laS8QcV5Vjol7j/eFSoVXr5M6AI
 wU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246422; x=1794851222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksrFLXL2ztzYPPOc4Pk3sXsLOAZZW1dDws3nMeN9ujY=;
 b=tGZkLpGMFhkHbZEq6O1Aze0s5j5zalnfFK9X56CdqyQ931ysrMH9hs5cHrgdqMpz0n
 wKMhvkq0j6DHU/uUICs5XqGllfdTK9dMo9EWNOhYb6l7pxj96D7GpHEqPTTbKkTmlbJS
 wkMuk2eiLGZ0RKp7S9l4l7WUaRDMNKTYEukCwKNSTw0EiAdNv1Wqfsu6n7By7CE0mlF1
 wpXhd57+I47LS39XyZe6XD83HGJRbahHXD5w5EvxF6O/vwPWS9kOI8X0RoLRMZYt6XKq
 xUeiOlv8yz3a3sUMGzX2ds6B3tyAgmanA1rRufUDOXtuFoNQx0eeqpFkZcK1BWQ/wpe1
 jhtQ==
X-Gm-Message-State: APuU4Z8ZKLjM+LvE0NYbIwwME/KFVTaK017k+pg0tkyTL2//TX6gXzRU
 C3SN6TVZjSoyngzwtOsQhQeSE60bLgzq5olzeCQosqRASeTtgfOwlnqE2zjisBYsnM0pBX8+WI9
 oiyObITQ=
X-Gm-Gg: AYBFou11bG0puhh5XTgDkWY1iPDOhQyBt4JCeWpcVJyQhDhRydea9gVCBGj3WvWHRHl
 J7gZ+IHJhuj08trjN7FABxEg8+zErua7yOa6veFEpVwsmgSTd06vpWnhyfx37/aCxCkTorUCH5O
 VsIu4GF1j6MIaOFT5J2IOEhCMub5FUUZPjgzeX7WmFWMoEZMgeBmzX3pTAMtLBWGgCkXSyLhDom
 fKUck+MzwvO+bhddKWAHTevawcHBlEVg3+l7olqW/0QHn6EhlD5kM1uXotsio7aLnWEKuyb+sh4
 zap3aHHOBgAc64JxpHjllK/E+mUO+hLCZ/tTnzVh5M2dzw+6pCeiwgGfWFJz0YS2SGi6f7osjzo
 oRBSOypYeZ5IEFT9n+CK7H94k7yIqM8HYJDpOBup5kTEAh9M8GNWjFAKvEPYUIHRJnS6UA0QRaf
 FRT406zJwtzE3UaP0vV1+qY8kB3f5ukwY2C4nd9DwdvkjOqQL2sRbgYa6Q2O7JgJdJE/L17E/LB
 PFRwbIwRDoQHjaTuKcBH+fCY47ORhprKSNOiLHFY2nIrPKVJwfMxwEifBqZLCKMMx08vmPMPSP/
 2qvmDnjVmyOROpSCgLTkl3Gj06+MF0FIUjrUw9ixbFKcLTfOHNGMXL7MImGI/hZuHYn7vd8I
X-Received: by 2002:a17:90b:2249:b0:3ac:adce:60ad with SMTP id
 98e67ed59e1d1-3b166cd488cmr322592a91.22.1794246422265; 
 Mon, 09 Nov 2026 09:47:02 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b168a8de09sm9663a91.0.2026.11.09.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:47:02 -0800 (PST)
Date: Mon, 9 Nov 2026 09:47:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <dev@dpdk.org>, Frank Dressler <frank@dressler.pro>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>, Kevin
 Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH v2] net/af_packet: fix build with old kernel headers
Message-ID: <20261109094700.12df2349@phoenix.local>
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

No. DPDK should just fail build on older kernels.
Since current DPDK is not tested with those releases, anyone doing that is
working outside the tested environment and has to fix it themselves.
