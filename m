Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB30CA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 574A740279;
	Mon, 12 Oct 2026 23:44:43 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id EBEF140272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:44:41 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1474493a91.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791841481;
 x=1792446281; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qIPqHFu0YkNGc7ULxOBhfoflcc0WQpP5Ln3PQliaG4M=;
 b=DCjS/aVvyQ9QZ3/GmN4ggQ7L0+54kXxqABhCTdhtk4I0OuDnUs+vGF5mx5OO3aBqOY
 sagdhqht68iOQNQQtZXIZKx+LYN/bwrlb8sPM5y8aTRBOpzyVNltJPz4JSY+Xmq2oG7g
 Bj7ryb+QnrvSfE7x3NZ9Ny59rbGX5slujMjHQk2DTVprKnTgLBaSzfM+gV9dneeVQQ1X
 jnP1uJzp6+FpELmRW1JWNurYCQEKIon+UqemOkxjuCbc6J4ljwQGcwI4AIAA8H4nCkf5
 4si7nQcNMRACB4YUM1DKVfDSsqVvKfxasvAtg/wW/IrZ/9hJ/S6Mp8DtAXXhym9+kBhe
 WbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841481; x=1792446281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qIPqHFu0YkNGc7ULxOBhfoflcc0WQpP5Ln3PQliaG4M=;
 b=K0afDCy+CqskW+Xnq3pZJMtfsrmEGo3fLmT9t6cOg3SBtZGIKv7DKkU64N02rP1GRn
 4LMIx28pWxjsZW634KwzYppoS/Q90lc/HzMGi2ITaWTAiWAp3WbeQez+cXP/QHMhQgnC
 XbO07z6gcJJnZcOvW2gJsjpfy6QSHWJOUGyww847zjvM02klPoUAnFXYSU+8tHWhkuRp
 CcbD4rCpwxWExVpdu67SMEulLmsoFmXPKLl8RPyR78zQdu2pl9ml+VZhoD0MdeLk4UNE
 i0nV3ISUS+oDT9g8b3v+0pakcKK6DtNS42LMnBwQZ9ezlxUlCRT8C5WbBtmYNNzjBxv3
 bo+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5gTb7KsFHPyLCQz7kciJd+6ooVQZzPXrDYDW10QEbv6+KQP91BemK35F/OTlJWjtesmM=@dpdk.org
X-Gm-Message-State: AFq9FYL7vSW9cwV9rJ257/ZAVC1F9F/tFoLg4eQ69KbjfOlibh8yymDs
 i00IkXQ4zy+tMaB7F78i9Msr1Y4eYlBC+yW9MWjB2fm15nA42g1n7sHMiJVeiOPjyL0=
X-Gm-Gg: AYBFou2WxK1NkGrA46g7vtlGokIRqA+dQ9XIFX9+wkpufVEWWfH/5XbkH0j6t7KH7nn
 cSCeOSsDY5EcxuoaRE0mVseOoPzn21Y/w7Anlc3TGEJPHyduCCPElHOUKsgfehSFK5g2/LLjxMW
 d7ifaFbsyMTrFJjwd9FGbmycQz4zPtY0zca6TXpPW3V5/Pd48W3kce1rP6bPXd1+k3500c3uWi2
 dVixfnw9sdelhPKkhp1B0+QTENtx9jYENaJMgXF3C+u+LkFy2dXophBUqbxb+z81A4Q60H5Rvi5
 HUuXfIWNofZSqWr4z7CGIJTrkzUrgjAlPLIYFEavXEFBUnavIiTcs1FHxmLWCxieY/OMpUlh29y
 xqQIysIDrTrugANQ29xe7w69KpRoqq4pLOqMHb342vYUnoLGOCY35JLg31yEoyEy16JdRcbdqg1
 V3u2V8SBpujn6yQskJip2+50iagCpVzASB5hmppd5XZ/0Fd/qwps29dzXwUo7QxGGYLmFpcQIEp
 lUU7Il9hLBjOKhDNhVxySawjBzFXNqUMY2sNjw5ryYvz6UsQuU=
X-Received: by 2002:a17:90b:35cc:b0:3a8:878:ebab with SMTP id
 98e67ed59e1d1-3ab3ab35678mr8742900a91.35.1791841480869; 
 Mon, 12 Oct 2026 14:44:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab39238608sm18669655a91.17.2026.10.12.14.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:44:40 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:44:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
Message-ID: <20261012144432.692dbdc3@phoenix.local>
In-Reply-To: <20261012210917.161343-3-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
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

On Mon, 12 Oct 2026 21:09:09 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> Document the data plane limitation in the file docstring of
> rte_bpf_ethdev.h: packet callback execution expects only one
> thread per port/queue pair at a time, making concurrent bursts
> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
> or multi-threaded software PMDs) unsupported.
> 
> Rephrase the existing control plane multi-threading limitation
> to explicitly distinguish it from the data plane requirement.
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---

Worth mentioning that packet callback doesn't work as expected
across primary / secondary. It only has action in the process
that registered. 
