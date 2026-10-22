Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDA606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=fLZ8R5wz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E746840264;
	Thu, 22 Oct 2026 19:17:08 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id F41144003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:17:06 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so46734a91.0
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792689426;
 x=1793294226; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9vy7EhP1Mg2YLSsoHNq9OYQoxk0+K1L2gv4TdzwdwwM=;
 b=fLZ8R5wzseSXfNrY0BrN90ZMtghIjPK+MVhYiUmzXGp44zelUEKdUNQFUDToNRaZoZ
 Z2+Dv/tw+ED/9CeCn3L0GrvyYcEEoS6brxcy3GsKvWJt2Vi3qtlFS4FoY6nY6bMpxEYi
 Hp/q56MEUQfZYHVmM9UWgKU6vBzC+pyRdLjhps8PYI8+KtEt1w1WkSDoRhBZamZgEhhd
 JtnsMYIq8IdnsaesBYX9xiV5382oSS13upVHYHQ6T95A/e7ME3qF//Buoxd9U0N2NhGA
 xmTNUj5XUck6t97Wi6tnaalzaumrh3897JJYwGsswgVyi51B21IiHNeOiw6XbzIn7Tqm
 wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792689426; x=1793294226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9vy7EhP1Mg2YLSsoHNq9OYQoxk0+K1L2gv4TdzwdwwM=;
 b=WOlA+V7PbUCWdxZ9Z8dkO9W77jE/gurjOPc7Ome61OOXIft6BHsj6c+oGrSbWzNhH3
 dMaDBO+WdhNEc0125cnx36265fdmbCIi8PsvWLDcHZ1ca8+IG/OQCngqs+GC2AZU05Az
 CcrdULQpyD9HSjghL4VEPMf0hXzCmHBj0pHJbZqQc3BuPM8UP4/69eTrvV1bDIpPzy5m
 Hxh6CyLXqHpcrbLx6nDFdrnSNM1fekX2sgjS33IzZU0j2Dyz0ZCia7sZpxd39MvZYXPc
 QAyZHPuxOawHC+THG0B7ni2dri19MK+AlYUnJfGXJV5KEzGihPi0DCGG9UsZkP9MEkQh
 rOew==
X-Gm-Message-State: AFq9FYK1fKH6aF6UepsSl2yKZ9HYFfsSMr0m3m83bMzEfl2GNRJazuXE
 HEei5gRG6J69osvlya2/vCDqdaYzFBzbd+1DdyEY62QYS6QYwXCPx2GG/0diIiVf1PM=
X-Gm-Gg: AYBFou3IRKuerrj6U00g2l+uTS03gJrS+svPq9OGfDOLeR7HeTqUuuFpg8Cm249RYHt
 FaDm+fd6cBNMP81WoVnajAjQRk+v0Yzbbx/ovzmyLBFRJFIXUeUwwA3+smnLF5YUGHKDvZmH4Gb
 kctwso3Crlht2VUikQHo0CF865eSXVgnSoj40gjkQYZ/x16Gl5mEUU6bx+78hMsxhLQGXOecTDl
 nzV7RPha9EvUbhGeKvhtESVlLoLPAwvSmzDy5r6ZfzF1EFvV+5MOsxOKv0BE6/OlcSuviAj9RAJ
 7dwIK/4IRYr4rBHUaF89Q69pfTqBYKcAzYYpLFJS84mRsp1Mjs+OckHQ2nzMj2obGmQEqhgBNRp
 rdQk9VPvdbYbJk79rVQ4x3wqXT3kTOWnaPKMHCmPtEmbdz3FG2qiPd5xwA0lHT6jSiIj/LZVB5H
 S8QO+ifxNFDXWrmvFM/c0YZfG57+kVAx+gxTzt8qaIaxrBQY5sg1U8QMJHk4nXsT6wwjMuRH/yt
 wKhmAOYd1JFJQfBg4lrjw4azt4o+s9aHzPnAUFkprPLuzOZw9wRxHUHQENonDSPorjzt9/RYu3S
 qJ8RAUzSd4RfRGVAwRlLug==
X-Received: by 2002:a17:90b:5547:b0:3ac:80dc:f40b with SMTP id
 98e67ed59e1d1-3ad86ed848fmr4598685a91.33.1792689426000; 
 Thu, 22 Oct 2026 10:17:06 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48879a0sm5125799a91.4.2026.10.22.10.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:17:05 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:17:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/16] Wangxun fixes and new features
Message-ID: <20261022101703.3f2aebae@phoenix.local>
In-Reply-To: <7FB1146D440010CF+20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <7FB1146D440010CF+20261022111017.3605-1-zaiyuwang@trustnetic.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 19:03:06 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v9:
>  - P02: build autoneg_advertised from one mask instead of three ifs, and
>         drop the out-of-tree reference from the message.
>  - P03: fix the same wrong RXS field in txgbe_e56_cfg_10g(), and add the
>         Fixes tag for the 25G commit that introduced that copy.
>  - P10: report module removal and cancel the AN73 watchdog only on the
>         transition to not-present, so an empty cage no longer repeats both
>         on every poll.
>  - P12: reset invalid bp_capa values to 0, log AML40 ffe_* values above
> 	0xFF before their low bytes are replicated across the four lanes,
>         and document the applicable FFE value range.
>  - P13: clarify that laser_off disables the E56 PHY PMD through PMD_CFG0
>         for DAC cables, while QSFP modules use the SFF-8636 Tx-disable byte.
>  - P15: rewrite the unknown-module comment, drop the debug print that ran
>         on every watchdog tick, and drop a commit-message bullet for a branch
>         that is not in the parent tree.
>  - P16: clear TXGBE_FLAG_NEED_LINK_CONFIG before the administrative-down
>         early return, so a 25G SFP port can recover after set_link_down() and
>         set_link_up().

Still seeing errors in AI review
