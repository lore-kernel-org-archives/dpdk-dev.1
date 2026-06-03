Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AAFCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 424B2402CC;
	Wed,  3 Jun 2026 17:44:35 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE08402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:44:33 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E3A807A0081;
 Wed,  3 Jun 2026 11:44:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780501470;
 x=1780587870; bh=ZMuxXTygW+ty9gln+qrjqJgLcqeaVgXX+pigQ3iVM6A=; b=
 kjE50iwrLd47rHE5kUdtj2g7ppNyIZUOPJvqXZFoKF+qmncFnpc/woDGgvPGUphg
 7ElWMz55egBbWAL36cQpa0tsoDwD10zuR1csQh3TJe1hQdHIdaqMPZVa7EPgG7sG
 badQUNVpMTC6KP5uVrOkr8vXLrrg9arw9idWDiglRHXxlERLVSPn0aE89sCuHZ43
 xNzWlqYcTojqp0HeIKXTFFJKhwnFPZC0W6ziwiq08aS01OCoGmvWvVC3zby38bMv
 Scg/QQiEXPC1j0fw20DeeUHyqzMJ2WYnLLt2ljxjlRvmsfo0bfvJK5VVAk56J8FD
 EXzXgoEAzUK/ixZHG9o8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780501470; x=
 1780587870; bh=ZMuxXTygW+ty9gln+qrjqJgLcqeaVgXX+pigQ3iVM6A=; b=P
 6M9+YR3MRMnYJd5IMu38aOusx6suJSPX97QEIOeFnscglsEvm+qeS33Ar6D/xwlr
 d2GB7T1UG4q7/TtTXjlTl8OxGAj2ss2oHBKjpPAjO/Yt2PDTkeAB+DW/q7t1sYka
 joUCUZFyCRKVFDXxGEM8Q4cggTe9Gg7M7KJCZa9+NZcw5lmRU//r4FLWkk8CLB0t
 4k6SLAvkgcFl4Oqto4CCZvl71zrJgrkWdfuCKFobkG1/Du5/ct/OEwAEsNxIszre
 IirhI5eClPg/KjAsKP4qZSJFeHsSTugucGZ3AQOHvmwdYUtdcl7tZTcwhNQOHEiQ
 RfP3s/73gX+41LDx4nQQw==
X-ME-Sender: <xms:3UsgaozPdCR3Ag3T-3DuIIq-OfMQt9ONTrLxCh7PMpG-8vUGaM4sQg>
 <xme:3UsgaoGRdfLhSLPIwkXAtOP0lF0y5UVPi_QiVJax2oMY3USeORvTPbHBoXuk8yYZ9
 pTw7w9UWKGbqws9OTspLl72RnCm7-ISNr8UMH5vu6aUpVUv2R_12g>
X-ME-Received: <xmr:3UsgalsTBqbfQjLxfZ6Zu0VmqFzJFI9FDNmP_4JxUG3TVwPNjII2drpi1KaZIYrzg2IYyXO55VCo83EoYmzr06wsdg>
X-ME-Proxy-Cause: dmFkZTFGrOhtg3t6G6QrQtuPZuXOXXm87TCNlc4wS7MJwR20owfxs9XXBd3KFiRQNnBgj8
 /4iWKGMhLKDaQA3ljKOYgRr8A73/w2FW6Z4f+36qNNkPcQ8kFWpUiNNANg8pu3ilRrpyIh
 epKU6w4uZzuzC7YpEGXohGtASZLmpFZzV5sAqnO2bTrMunuS//j57YgzYCPJcdZ+t0dFSh
 PdKwFnVvQr+ztL2rcZ7T8VOFkeDT8wZxfNUOHEnKBuWZITlwBuwOzJgo/aLvqUMPZULyG5
 ccEsUWegJKKApQx5bkLsdwFSyvp9SW5EjE+oAczPX5Kx2Uf5aBE+rZWqh6TnKLeUB1ZPT+
 Bj+Hgov/vBRUgku0EKz0+VTleomsgdDW4OzbUjHrMR/0FWsluX7UikQfwUXOMuawJRBw/b
 aFptj7/TVLva2KUSksQtwHpics2UDCT6UGs0l6Wd3fr7hoDYuyVAWkaxjLxO5xq4f1mH9t
 7A74/VlAyT8fzL7XQBR6axSbNi628QoKHF9VcX/UxW2ojA6popTgljflKwzA29ZWDDUnu2
 lAOTrrtaTep2rFySAlAJWbIFe9Gp2cQ85ZlxkiBg15J3iUJtc/zBjr6wnC3MrKajQBqzxx
 pQ3xvX0N0qKjWAu8jTKJ3jm+1kkvptUoYpwJqbwwEhQxgKHFpiUMd7DeG8qA
X-ME-Proxy: <xmx:3UsgagA9jBqgGn5JyPuByufHZQTQLd3Y2cchkfAiO4urkAz1R46a7A>
 <xmx:3UsgaoCPDs8LwRNkLmLTlxKbBGkUkC_EFqORVbmSJBjHjfQswTFLHg>
 <xmx:3UsgairrHrNbLdYLZ0OiJeSfQhrJiL4KAYjra4Qwr3l0Lwy9N3kwqQ>
 <xmx:3UsgarHqwgsw_XiK65CBFfvOFitQ2P-uiDd-WjVtQoOJROfSr4rw6w>
 <xmx:3ksgaofdbJZOYi4TnRz1RCUIOa07ugUXIesNpRIQ6ktA6LLWJ1puZwvf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:44:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>,
 Jerin Jacob <jerinj@marvell.com>
Cc: dev@dpdk.org, Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
Subject: Re: [PATCH v7] mempool: improve cache behaviour and performance
Date: Wed, 03 Jun 2026 17:44:25 +0200
Message-ID: <xfJder14R4683NtQsvKG5g@monjalon.net>
In-Reply-To: <20260601164007.252063-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601164007.252063-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

01/06/2026 18:40, Morten Br=C3=B8rup:
> This patch refactors the mempool cache to eliminate some unexpected
> behaviour and reduce the mempool cache miss rate.

I feel we need more opinions about this behaviour change.
Bruce was suggesting some user-tuning. What do you think?
Also the decision may be easier if we have some performance benchmarks.
Who could help to show some numbers before/after in various cases please?


