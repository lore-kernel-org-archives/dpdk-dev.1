Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58104C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 00:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25FE2402A7;
	Sun, 12 Jul 2026 02:36:38 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 13A9D4026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 02:36:37 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6370F1400075;
 Sat, 11 Jul 2026 20:36:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 20:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783816596;
 x=1783902996; bh=fQIzB+hpAN2Qx3+PzgDY5OBqVGTxyRJJKKIcP5jZYuE=; b=
 Uvu35AiiyKrtLAqWziVZ7aju+Vna+OZ19aPxJpDTQHeR1XyrU+H0a3z7vWRHJOeN
 90p2qrNtNAQQTTdvJgEorab4FSkPK7nyRaH6jQFj41SNalV9+SXnp25vwxeDo5xV
 NQVdih8RriWn0vZOiFRoawzRJvk1dpKe3mLhsThhtHI+2Atrn8hhX3RLDtX5KD74
 VDeBzmhU/7FGxwPgVg9xz6mt0uAMBZ2vOtFqgArWmoSOBN/XEKD7nz+KEBMSZVwa
 TJvFw+idzEPSxT9S3gsil/b6w0EqGChVd4r7PlV/B+qCXO74OnV+ThK3xCeD5i0y
 /JJUim2nsqryBIVu6bFOug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783816596; x=
 1783902996; bh=fQIzB+hpAN2Qx3+PzgDY5OBqVGTxyRJJKKIcP5jZYuE=; b=l
 jLQbpKwxTU3VquCyNYvywpDQiM26Pwjy15ftOEpXLRNKrLjnFnO9xj4S8vvSDssQ
 muAUVMKFezRJixTfnYvaRo8X8UEzRzFMx2CCexvqOLIC+abm76BzwQQLbwQq/83W
 D8opTxTV1FtSHYaSUeTKVXF1XB5WB8eTka7dE3/Rph2vHAnROB/PjTuFF5GkBC0s
 WH8yrGWZgJQ2HUk9dGnh8Lf/uroOXpFUbloex86n5t+BxaWWVsf/ZzIIMKANNW45
 6BpkeF0paddiP1rIFGbnhPMOOXSoe/prBsjsPiGaiaWzBBvccWacH2/Kb23tw8mB
 qCfVPj89iCIyImvEznwnQ==
X-ME-Sender: <xms:k-FSarSmXWH4tcjM6qiZVBc6bA6Q6DWbXAfDgx2oPoeuJ0tGkcAFKw>
 <xme:k-FSahGeLfyTBbuy8pzNmvItG-cDWJIIYsKImNtYYoEKjsbOQhlGDNW7UgfanvrQL
 qE2oYvZIOPUW-9ZNuj-rvpczYLZNFX3NxwKM8Vqnpq0Pu1u91Fwrg>
X-ME-Received: <xmr:k-FSav9FsKwNwk-OQgwHcW-5jsrGuYw6FNh0hOu1-OpPshdoWpF6FojVfHFrDqnpXTjFzEky8naC2x5R1hYV>
X-ME-Proxy-Cause: dmFkZTFaSTS8mS+Ou1sEyosNy9Ouxlf4vAf33ncvHGCWJQLGVp28xjCk6G4+hUaR5Zuako
 OeVrUoFeSAR/x9MXZfmRzdOkDgCiCBKBg4TbsB2U3mup8xJJHQs/i0jR+XwpneD4ajzjmf
 Zv+PnXqOmfPQKrNUNFsKgS+XE0iOgByGPxr0IGF7PpkmrySXpBZe4OtRHJxddIVS+OITit
 39ugvC4yq4i2zKaencXgarfU7cR5C4IT3CpGCwhNrDdM2NwyyxLs4WyUOYXL1ONTlYHYJ4
 Mrt1leupl32VHwl1PHH+2FRbz/hg14V1GBp3Plu3OTgf7A7gUVoohHcvX2u9YouCxLIEr9
 hXa+169l1lM6RYESo7tVEnO3ZEsMIxm8HIwLf/+7Guor5LNWRSZJjvvhEqMcQa66NShlrn
 FW0bQOWwq9FckarlJKshAuhxghKoNqMaXNZxsQoBNGqk/3WYtFXf6lVyMxgF/cegMMWrAY
 TdWF0vHOP2vLg/kVA8GyKn+WxH5CyrxRtpwzpjV6ixbGxt7qQ1ehwYXp7MiHoHUOmlFSht
 chculFETCVWRaErFUxUk1uVA5Ok1gAnOdumtKrgpfs5FfY0SWZqQp2hKqfTmGAzZX4o2Tm
 zNbv49q8kR4NdlRawP+3iF41M+BG6X6Nd6MOjy7534ehbVi0Ovwy6Y+7LQEw
X-ME-Proxy: <xmx:k-FSajLf1kAndcWOIoQz3G9je6q8MZWug89mn2EevZKYH_I2rEtL3w>
 <xmx:k-FSaqb8mfrfDM22HU7v7-IMoPDa7YUqW6HE1pc-SBnz_OkkJZzkbg>
 <xmx:k-FSalI6YNINXxE1lnCj4d9TJlAYm1GZJAcQUpy1gsNgy8SlnVM1AQ>
 <xmx:k-FSaoD8V1H6XRIDgBhjZZF_6qWULZiMT_jySwMOumVdNQ_tO7Zl4w>
 <xmx:lOFSanh5k798Ct2RsMe4EOuPy5FNtdhueJxgSJ5ze_M0wF_RD4JGxBCC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 20:36:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v2] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Date: Sun, 12 Jul 2026 02:36:31 +0200
Message-ID: <XD7BWPEmSkSLy6khWeEyng@monjalon.net>
In-Reply-To: <20260624032357.2153-1-fengchengwen@huawei.com>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <20260624032357.2153-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

24/06/2026 05:23, Chengwen Feng:
> Currently lcore_conf is a global static array. When multiple
> ports/lcores are distributed across different NUMA nodes, datapath
> suffers from severe cross-NUMA memory access penalty.
> 
> On Kunpeng platform, sizeof(struct lcore_conf) reaches 133760 bytes.
> Such a huge per-lcore structure significantly amplifies cross-NUMA
> overhead in multi-port multi-NUMA deployment scenarios.
> 
> This commit refactors lcore_conf to pointer array and implements
> per-lcore NUMA-aware hugepage allocation, allocating each lcore's
> configuration on its local socket to eliminate remote memory access.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

There is an issue with this change as found by AI:

init_lcore_conf() is called before parse_args(),
so the new lcore_conf allocation happens before --no-numa can set numa_on = 0.
As a result, init_lcore_conf() always uses rte_lcore_to_socket_id()
and allocates each lcore_conf on the lcore's NUMA socket,
even when the user requested non-NUMA allocation.
This can also make startup fail if an enabled lcore is on a socket
without hugepage memory, although --no-numa should force allocations on socket 0.

init_lcore_conf() should be moved after parse_args(), and it should use something like:

  socketid = numa_on ? rte_lcore_to_socket_id(lcore_id) : 0;


