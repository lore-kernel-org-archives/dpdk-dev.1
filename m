Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56EAC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 13:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F5734114B;
	Wed, 12 Feb 2025 14:21:56 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id C9DA0410FB
 for <dev@dpdk.org>; Wed, 12 Feb 2025 14:21:54 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 52D2013801E1;
 Wed, 12 Feb 2025 08:21:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Feb 2025 08:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739366514;
 x=1739452914; bh=S7SsrdxQMnl9UPnsiVieiV7wAzHP3aDrucllNMqz4go=; b=
 mP39ctpjx3VScV2uLLPR1bA3JyIXJeMsVOjnM05avdjV5u1OLIcm64BH2VqNJbyX
 e/zGkraTWxWw9lEGh5vCruiwRwOaYUbZ+gV7nLtBh6hglTUa7ovmdhAJnOAulbQj
 a6ox+YaHuZsIK333mkEaJDZ1+Sw55h9AXY2FnauwKXvUklXPXt7qgm/N1TVIOYkH
 R+b5OEx7qmEBUHYk6Uz7fXMWsaXjmHCeGMlvDG/ou5AKwUYCP14nHUz9awJaDQUo
 K2EM+7DSOYTatEVQKsz4v6w6mkrChiM5smM190vnxvORJuNq1he1yGHroVG5RSJQ
 V4KPDNZ9MrKVVgaozOACvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739366514; x=
 1739452914; bh=S7SsrdxQMnl9UPnsiVieiV7wAzHP3aDrucllNMqz4go=; b=H
 e2Y17mqq0wSeHEemQ/xLMMksK3H4Fsv1hPTdQxg3stEErcOj1UR0xNsNMO/IDzmQ
 KPqvxPrP4FHb2h1RRMJZ+yhhEZZ3COzMcRQG6hszvf7I9Q454X8TgbdO8po5VrCB
 x/rYHoJNDqK+PJokhRkMOLSIAJPU+RWqc7EZvhJFIMKlKlibK8t9cD2fiWEMhpny
 fEltYAqLEyp5BFYRnCE8OSdDrA+Vdmch4hxaXRiOMoe0W4jN+6MU5ePjwOqZfAVZ
 dNLuVcdzcsNczSTpIfmK4NMyorGWrOV73Ca2IP4pCBjn7kKzqI0RUxrSXTeSNfB0
 PeTxLZBW26GooL8/9D9NA==
X-ME-Sender: <xms:caCsZ-AYjHuhiPdIxeYO7ZV7UsJyoZtKE_qqaeqCK0AcyhyskxLyaQ>
 <xme:caCsZ4jzde-eelzPsGYl0wBGcD3mnpYt0TQpqmfRUuU8mFdk8PSPo3s9z8l0qohDD
 N4w1WKnWkkeHW6YqA>
X-ME-Received: <xmr:caCsZxk5xVZBSOFhRs1mhok9FMWjpvbOYW2ECz3nTrzB_MexZekubkRieMJBD6o44wBzJnq1h7wGHTw5tCd8Nx0n4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeellecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhurg
 hnghguvghnghguuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtoh
 hmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
 pdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhmpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehhrghi
 jhhivgdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonhhgse
 hhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:caCsZ8wxNbk7f7ekYV81VLDgmsn4sl4AHK2NzOZ9SnU2xTO0cneaew>
 <xmx:caCsZzRAt7JSiUczoOdCWZQMHrKcq5WHiyxZ2A_yImGjZf8ngZ41-w>
 <xmx:caCsZ3aqi4Qva1XmdKrVnE75-9pchJa1ede5D5hb2phwazpDxgFd3g>
 <xmx:caCsZ8QpA9ZwdDr4HvviwV5a6wKrM8xjYwzgJ2CoYZThUAylWhGTCg>
 <xmx:cqCsZ-GZiAnskE3rzDulMKgjjKYFxa2oxRc8lnG1tiC1BuobFUZHhbcG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 08:21:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, reshma.pattan@intel.com, stephen@networkplumber.org,
 lihuisong@huawei.com, fengchengwen@huawei.com, haijie1@huawei.com,
 liuyonglong@huawei.com
Subject: Re: [PATCH v2] app/procinfo: add xstats parameter to hide zero
Date: Wed, 12 Feb 2025 14:21:50 +0100
Message-ID: <1811548.7aRn1RRit1@thomas>
In-Reply-To: <20250207031333.1782995-1-huangdengdui@huawei.com>
References: <20250124100032.3497253-1-huangdengdui@huawei.com>
 <20250207031333.1782995-1-huangdengdui@huawei.com>
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

07/02/2025 04:13, Dengdui Huang:
> The number of xstats may be large, after the hide zero parameter to
> hide zero only non-zero values can be displayed.
> 
> So display xstats with hide zero:
>     dpdk-proc-info --proc-type=secondary -- --xstats
> and without hide zero:
>     dpdk-proc-info --proc-type=secondary -- --xstats=hide_zero
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



