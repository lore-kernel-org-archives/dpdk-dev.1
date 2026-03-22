Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB36FC72AD
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 14:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1D75402EE;
	Sun, 22 Mar 2026 15:16:13 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 94331402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 15:16:12 +0100 (CET)
Received: from L30177.local (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 34188780383;
 Sun, 22 Mar 2026 15:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774188972;
 bh=SkXWv6pcG/3RpvlMtEBkNLyoam82FT/My5AITzwvEm0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=V3edmW4OAGEcSBUcT2LfRFHaejvCd2s6D3PqVrqZJTPCW5mjlkw5hnvXMK8NcrvX1
 +GzZkgyNo4mpozeFnXtPQI+dNPFa2uAPSkr5cRtFtEchDsj+ejB6IZWZDJGF+tNf26
 V0QST0oWRbV5KDibNN2Sw4l0QK7FNVwDHJ0U6TjXuKW4RragUjLKYzJW11uBq/P2r4
 VKMGz+4+BQhiEPw9IYPJS4DqDjDA4kXn0U447eXdsVvYMvfuQ1mOlNwADGJ2RNkoFq
 jJcOuHRkiJLWqDVD70tr062FIYOX867AEh6ALvoZ2VNOcUweZlVscJCSo5+yf/OuMm
 D6P0p+T5nqWNg==
Date: Sun, 22 Mar 2026 15:16:09 +0100
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: Re: [PATCH v3 00/9] net/mlx5: per-queue Tx rate limiting via packet
 pacing
Message-ID: <ab_5qf3lsLsVhzCo@L30177.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260316090438.70b8f7d9@phoenix.local>
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

Hi Stephen,

> mlx5_get_queue_rate_limit() doesn't bounds-check queue_idx before
> array access (the ethdev layer does, but the set path checks it
> too - inconsistent).

the fix in v4 goes in another direction: the redundant check was removed
from the setter as well, not added to the getter.

Both rte_eth_set_queue_rate_limit() and rte_eth_get_queue_rate_limit()
in the ethdev layer validate queue_idx >= nb_tx_queues before calling
the driver op. The driver callbacks can therefore assume this
precondition is met.

In v4, neither mlx5_set_queue_rate_limit() nor
mlx5_get_queue_rate_limit() checks queue_idx bounds, ethdev is the
single validation point for both.

Best regards,
  Vincent
