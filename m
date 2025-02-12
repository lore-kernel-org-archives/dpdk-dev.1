Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE06C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 11:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C97F8410FB;
	Wed, 12 Feb 2025 12:53:32 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id AF831402D5
 for <dev@dpdk.org>; Wed, 12 Feb 2025 12:53:30 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id E1A251140165;
 Wed, 12 Feb 2025 06:53:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 06:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739361209;
 x=1739447609; bh=oW3Iw0QZT/KtfGefoNOIQoxupBrQl3FHnk55+RMfhPg=; b=
 G/HNh+6PWm6LsdiDmpqO0kS4FPFzQC1xpnw0JM77VyR0LwtWVXGKBK8jdBF2pkDP
 VA9Ql5ksab6lnSB/KWWACT1FIIEjOcKYn9EqmvlN0sAbM7ypQJ/ffOh2u7TpX9Jk
 0a2tKC15AMpxcz8vl13f7RTpwWO75Im7T7TIpALlpAKj8zgFS2WynF6iyF1Ck205
 gxswcDsyes1PmtaTOCdLiLEbWBKc1dykYZjw/1KAxpz5swz9+7lQJGV8Vd3ek1bY
 VkD9eQE65nczm3JXuhQ+xXu0Ub9yPiOQzlE0gqXWgrqaZSQFJyncq8EeDSL3n0wE
 kl2MqDgNUR8jIzNuMegLTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739361209; x=
 1739447609; bh=oW3Iw0QZT/KtfGefoNOIQoxupBrQl3FHnk55+RMfhPg=; b=f
 vPr6qqJUYgafnTEoN7HKahig8rd9QLbmGczbNRT7ibWr9bJtQQM3h91hCIF3dss5
 N1eIhOOVQFWAX7g17OgWWJeE9dDeqvRUFmKyiE6eNBQvMPo85WH+8Dp2t2lbM4B4
 zzAHJaV9Grx2+4BCko7nARW1PRaDZZFN3P0DA1hbl/X+V8qhoHNy7IS6r+SXiMo6
 2VU+5oy7+vOGpBnoDbpUOpaXSAemuDksC5wOa0DWPokCW86mEe01ygV18uzYjT2Q
 ffPxzpSb/1UYCcJRy+AMOa2RSLQKZE0+LDH/l5voMS1wNQUpsGL+hg7ZdHuvpAhu
 nwsUjzallHlJ8jd53eu7A==
X-ME-Sender: <xms:uYusZwiF3IrhBFBDBLMqA0GEL2wsjo7Mrob6RdiUV17NUu3D5JVM6A>
 <xme:uYusZ5DwvxrAnYKhOL5fZ_-nEcRvQVfDGFPMcZzQmWB5RXnMX4BJ6TLdSZI02t2oZ
 iFxg9q6nbS_W5eyHQ>
X-ME-Received: <xmr:uYusZ4El-3G1Tt-H7OOdl-GZL3hbl5a-yH6P_JeNscdcnIK_j-jbbkI1UXGVtmUGpm7C-N5OhYTjetmxOhoOrKC-TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeekvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:uYusZxRKcOF83WtzfC9P9Fv8OoEiNslqPazEeWOOfZk8K4DuvLVH0Q>
 <xmx:uYusZ9xGEb76838VPqR1M8_nBilOnGyzAGCWVjQU1v4sV_JA1c7QDA>
 <xmx:uYusZ_5vuw7tg433KnTlvZkU2XzvI0AN_lqgWN40_0l-WyPwMZlXnA>
 <xmx:uYusZ6x0MqEV861pHPYCQXLlJ2Q3_8aT9qCeKTmbTPLaSncCkean2w>
 <xmx:uYusZ4_T09nk4kwwOGTrvhYfcD04iAMosxqCVGm0AAK9hRaOgCozLQIR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 06:53:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/19] minor fixes from PVS studio bug list
Date: Wed, 12 Feb 2025 12:53:26 +0100
Message-ID: <2793506.9PvXe5no7K@thomas>
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

> Stephen Hemminger (19):
>   common/cnxk: remove duplicate condition
>   net/cpfl: avoid calling log (printf) with null
>   raw/cnxk_gpio: fix file descriptor leak
>   net/ntnic: remove dead code
>   net/i40e: remove duplicate code
>   eal: fix out of bounds access in devargs
>   net/qede: fix missing debug string
>   examples/ptpclient: replace rte_memcpy with assignment
>   examples/ptpclient: fix self memcmp
>   net/octeon_ep: remove duplicate code
>   net/hinic: fix flow type bitmask overflow
>   crypto/dpaa2_sec: fix bitmask truncation
>   crypto/dpaa_sec: fix bitmask truncation
>   event/dpaa: fix bitmask truncation
>   net/dpaa: fix bitmask truncation
>   net/dpaa2: fix bitmask truncation
>   net/qede: don't use same loop variable twice
>   examples/l3fwd: fix operator precedence bugs
>   common/cnxk: fix null ptr check

Applied, thanks.



