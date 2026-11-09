Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EC606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p43jLFT1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E80D4028F;
	Mon,  9 Nov 2026 19:42:37 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mails.dpdk.org (Postfix) with ESMTPS id D083E40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 19:42:35 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b09c07b3d2so758355a91.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794249754;
 x=1794854554; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Duw85SthtZbxXbynMnisNKDLqLO/ejMPGWq3zSPN6o8=;
 b=p43jLFT1EBjh1fn1j6np/rGebvcQynn/gI92dfCG5NWU2245R1LLZNyo1nLH0+uY3a
 NkLJ1H6ju2NjJ5c4J5ZsOiQng0wV4hFdIMBiYE+lA1J8U4LXqGIIVs4BB1uTf0jSQX4y
 ybK27hndkMqg8CdnzzE+0oOgiwuJM20GhmuzHaiI5oBGOR3K2llg0LhX8RQk6HZ/MfaS
 +KTrinbSdgYz6QJ4RtSNckHs5bO9KXYWuduQt/KarxBFqwFAGzZMtl0YRqEIY0/Ml1eH
 j0t7YCehScNZgENy/Fu1iu8aXjDANaQUXxkOZ5Ap+qfehFhm0JDgtnrCA1jLN2OfjRBn
 uLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794249754; x=1794854554;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Duw85SthtZbxXbynMnisNKDLqLO/ejMPGWq3zSPN6o8=;
 b=ON9aWSx26CiKeZrQAp7R7bvfn5ENykD+0u8pBZZxdHjJrK6qFiS45cBe41DoJlvRbr
 LxIFeVNWm5mevglqlWsHA5DU35FPtAYOgl+i2hOtaQCuI7vYfcGo/heLLt6GpTeX8wPT
 078NXcm56LeB9YUZ7ADksPOozP0iEXazdxappjLB0Pq4fQj92Wk+a/XLYAoRK/W2PkCr
 UcUIwri7xTNe1aut0fGwM/3At+kM719Q06QmwRJLMLag8tGs8O/72ABnBCIt+ay5I8h9
 eQBjWUh+WTgdTfyv4QtVz7PLRYNmunmaLjFTkZtNOiJwYqVV+8p7PInTEogcsVS//USv
 LJCg==
X-Forwarded-Encrypted: i=1;
 AL+hErEbqPGHpWUfkB/PH+KidRilxu2VolRmnwDOd1lJ3eG4sEHCogj2lcBu/SkWpzEe/C7fsow=@dpdk.org
X-Gm-Message-State: APuU4Z/1xz8qq9wD1O/zgFA4REizwsBkW4434ML/0lBLUFoCp9huHQys
 i5mS/GmYMRrXpGTwALP1ERd/sUSGjvmTXXT5pPEyNGy9MHGKSYfrjQLrMWTjAvuDQ/s=
X-Gm-Gg: AYBFou1CkS0i71eG9zs4RlRDkyr5kOuy6LUQN2rtpMDigMQ3nbazyzWRCtv16/HzQzK
 vt8n1z8GhpcWk+EUvvrItOCGZd4xqC71ccFmPx8bg8ISJPchpJB5eeGnLse3CV3VsVPyc3txIXy
 fJWz7hui7v9wFrhFt7mWbE8hLRsGwDKYB0wtS8GJJDXX8jJaclcPRzUoWN3yNPdDS9TtuwZGDle
 NKX1SDrx4z3urcvXBchT+u6Cw4H4EA/e+puVmuMIlX0jZwtmWg8duUCEzkCHsNz84q+hXda4kJN
 PTcLO6gR17SkJFYeL7G46vItansW2cX8BYyDhGGhQpzRVuxs2HeUROD2mD2s22nFWO5z9Azgw7Z
 1lZUC+N4hpg+bclXGgv1rLEgcmlt4uXC04xvFVihK7Af4tc4R6QTzT9rxG2gUMT7DKEGFBmXb/z
 02M87qjxOoIUc7rHCNAwQodlgZn8zdpSmwwEkRYDZKjfsiMNWUH9v5oBmd37Lsjdr+BNftpYTze
 NcqRpXIpxW7V1Uie8/E/sxNBg/zq3L8IGzifQyF9YqpBWo2ItRrhVEJSpUOJfogRz4TyxKxPSh2
 cn+izRg03l6GwR9bMoMvB9Pw9b1ycO9BERYHUxKSqN5SiKivOi151Ouy7bAty3IG0Bp1kVsL
X-Received: by 2002:a17:90b:4acd:b0:3b0:97bc:62d with SMTP id
 98e67ed59e1d1-3b166caf04amr485833a91.32.1794249754179; 
 Mon, 09 Nov 2026 10:42:34 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b168f081dbsm53891a91.1.2026.11.09.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:42:33 -0800 (PST)
Date: Mon, 9 Nov 2026 10:42:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shuaisong Yang <yangshuaisong@h-partners.com>
Cc: Xingui Yang <yangxingui@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Hao Chen <chenh@yusur.tech>, "Min Hu (Connor)"
 <humin29@huawei.com>, "Wei Hu (Xavier)" <xavier.huwei@huawei.com>, Chunsong
 Feng <fengchunsong@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net/hns3: fix hard-coded default value of UMV space
Message-ID: <20261109104231.2ce65a52@phoenix.local>
In-Reply-To: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
References: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
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

On Wed, 4 Nov 2026 20:40:33 +0800
Shuaisong Yang <yangshuaisong@h-partners.com> wrote:

> Fixes: d51867db65 ("net/hns3: add initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>

Applied to next-net. Corrected the Fixes line to use 12 character hash
as required now.
