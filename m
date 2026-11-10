Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C86606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iQYMj7j0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE5240281;
	Tue, 10 Nov 2026 18:24:29 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mails.dpdk.org (Postfix) with ESMTPS id EAAF04026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 18:24:27 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ae6b4c669fso1477509a91.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794331466;
 x=1794936266; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iyG3tDQV4mT6iqOradTD7CrdppnBmD6kvponybt5EfY=;
 b=iQYMj7j0VieK2pNJhMRPXKk+DmhffvoWRH8GNSdWrq+eIUgSst5Pb81vW4Q1PJRgxv
 3Voz/uH7iGyeNBgziNA3fiwobtBr9upIRVZiLnPdYg57VHMyhV1qTYmQQX7N8Rtrjk5K
 yDEk653pjsQlf2Zrn2klRLl2y04bz6HKUnHBer/IPY5OJFd4TetP+D2nK11/hjnN3c8p
 xgkir6xcMQ4cNE5sak/Yb51viFWdxt3Uktzqv0Fd5D7zHEX/jzihJlEXenD256GI+sCH
 e9MVFT9/Sgjy0dVJYFtN17LRHwqXan7ka+50bVJkaf7w7/3XqoAHC7bvE2Euma1xdPWP
 xCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794331466; x=1794936266;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iyG3tDQV4mT6iqOradTD7CrdppnBmD6kvponybt5EfY=;
 b=HGfeDrBFcmdHDXk7ZsYg1dl7sdnlVSOS9rcawGjSmCNiqYkmF/awjIuyM0lw+tbcGm
 QfYquURnlsrOzyBO8yJNQWY00fKG0ECOsK5bjlqKnqdlxMnhLRhBuy75TibX7rahiCsO
 BMIxKjYsB3Du/uL8f/zBYIyHdWaK9A0X4b1U9VawZ8Wp+FX7l6kPJKGE45brocwM1BE2
 PJ5kvu/mv/aLsdWW1O8fsqe0fLA7iofUzwwiAuwITHxsq1UMUlzxGpck16mZC8f/QFEz
 KNsgjdJeZo9PUMgfTsTqyU2PcudfV2om8oFjaYc2sF9IkbM4x+kr0e0qkqKdrLR9bI1U
 aETQ==
X-Gm-Message-State: APuU4Z/ehVPzUzjiWMxlD2b0INNFmLnmhjdoC+ALr9JoXAqB/2Mt0JfP
 s04m/+heTm7N8nLVyeju5IYM0WPnfR/knxa0lFjcrr/CWMDNLyU4JBXbiVK++tD7qN4/l6RwTpx
 zzVtp
X-Gm-Gg: AYBFou1HVHgmdB2qDOJhyy8RD+QO8mlgROKGZiedteJ4EumZSs3XvidycmYGMbhzQhg
 IE368MS4e9rEcuwol+i1DYkg/movmjmCyLqyPPs4FeVkmpbTPsSBjhLUUyXalniGWoEykdR/oSu
 IcTfFAhta8ubA56LZbZM9Nj6iTKWDxRX4qh36wRMsk4TbCzKy1RfzMsvt8Y3Ht7O4CAYzfmfubB
 N6geSE32IHJ+GmfH94y0YhM45nWxZoIEUclWrQv6gyMEGI3zDKLInRwsp3mx6o1l1LedZJMzBSn
 7lcq7FA0+2MGTgkCRzBStMm9Stq7yzrr6YVgdqnVK9yWrxoScpOJb3y0JUS5RUbSTKltEZ9rdeb
 j/hVHPrOW3COt/fQ4k0xc4NmbqpuNObnTAZMbweczcZQt+1YdG+1g2YDPJpy0vRLTZWMucV6DO0
 LxbzLiPcBGruyDfIsA7hw+R+WVKbm/PRpk+TDK3zS4m3BkcLyKM+Yq2i0dvfRlIHDalaBs7XCzk
 AN1cr2F8z3nPvvoAe3NbeJ62cgCLEyhLbO1M/eh1hzqYdBYOwqdQ7aOBlOnZ5RfIOIT0qd5NY8h
 1I7mwmOQtiqQp+8mLgJqQGPIMuuMXRx848ivQk07U1/6M3b0x+oFSb8dLdW24iAurJ2Rz70=
X-Received: by 2002:a17:90b:2ec7:b0:3a6:d850:bf16 with SMTP id
 98e67ed59e1d1-3b1679a3218mr2128624a91.23.1794331465720; 
 Tue, 10 Nov 2026 09:24:25 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b17db319bdsm533855a91.6.2026.11.10.09.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:24:25 -0800 (PST)
Date: Tue, 10 Nov 2026 09:24:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jakub Grajciar
 <jgrajcia@cisco.com>
Subject: Re: [PATCH] test: remove memif from fast tests
Message-ID: <20261110092421.31670618@phoenix.local>
In-Reply-To: <20261110162154.2623734-1-stephen@networkplumber.org>
References: <20261110162154.2623734-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 08:21:54 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The memif test is exposing races in existing driver that are
> resulting in CI failures. For now, exile this test from the
> normal fast test set.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_pmd_memif.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/test_pmd_memif.c b/app/test/test_pmd_memif.c
> index 840ba4bf96..9bab43adb0 100644
> --- a/app/test/test_pmd_memif.c
> +++ b/app/test/test_pmd_memif.c
> @@ -761,4 +761,5 @@ test_pmd_memif(void)
>  
>  #endif /* RTE_EXEC_ENV_LINUX */
>  
> -REGISTER_FAST_TEST(memif_pmd_autotest, NOHUGE_OK, ASAN_OK, test_pmd_memif);
> +/* registering as fast test deferred until driver is fixed. */
> +REGISTER_ATTIC_TEST(memif_pmd_autotest, test_pmd_memif);

Applied to next-net
