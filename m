Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C040606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PqTtBGMf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92564066C;
	Mon, 26 Oct 2026 19:11:29 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 24F9D40A72
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:27 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so1604154b3a.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793038285;
 x=1793643085; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6QQ7dND048LMUMB+c45coWtulAIzsM9WPyOEcOkTWgA=;
 b=PqTtBGMflbJd3clAMl1UEAmlhaNx/R6MCJWbhQLkdfLkeSxnO/PwDuQsOlyTUh3LDY
 M/0GtLjjnOBAQxH3z1imSrcJC1VdBmqn5RjAcNRfhz5o2ktgz+YBJekXVYrkN+MFRxre
 fYggkwTe33esmui1JFIdn0QMvYqbJlJW0PYBouOXtM1Ht+r3uGRxEdvLWlv+7H1KUpNE
 V1gt4CsRUS/Kt3w8GTBTGVJpeiiNJbLWc+SFFRvLEbcmt5mWWFemzyXCIWVPOoyOKX7k
 GGGO59Oy7COvLR8d4v7wIMzxR3OaZph4YSUBpQMhpSXU2/vbg3ZQpif+PEw66KfyxcF2
 5r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038285; x=1793643085;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6QQ7dND048LMUMB+c45coWtulAIzsM9WPyOEcOkTWgA=;
 b=nvXG2wgBL3TPjDj7EUlb+o9AQbCqWnNkoJ1hfK08N3vsifgg3wvIkb4ZtsOOhtlRCf
 c/ih1TqptPn2sWG/k/bGdqaYgZ99AIt2Z+pvPrHFRUDFCYCygeqrYYgfnesUuIQm78QN
 ll92a+FAtu4sfsJAGZM79MoL4CiTUe1gsCl/2Dj3bjw/ap0TknEEuIQB4osKz40w55rp
 yEO9hCJuMfksJfUt+ngzumcknfZhMpRLBh0qbvJRL9Zc973iLB86vSLKpJdhFarh2whO
 HJ1wmgKvagSAEavTXFY3iVowz5X+6YVDJJmrQb7L3Vcj0nov2FCmf7dOELdOZ3FJJFNc
 ADtA==
X-Gm-Message-State: AFq9FYJIZ4lTVyBMsvzynbLC8v+Td4s8Yd+K/SIBUBgCu/daY4SsaY+t
 JlaJDVrfwn5stCho0b8b/dpSf7veZVZrnGGLZ+ES5xdTxoBuRIuIUfxI2VNCod5cfumeFGmsWhx
 fXRTvQBA=
X-Gm-Gg: AYBFou26DtzrnHz/MifkYqV/aAIGYwVyigfzLC2NFm9KP5+1kC7IeIh2p3RY6+tPDf2
 YEEtOtKy/Tp0/Q6LXnvQ/KTTwuEWSJkTERfQAfRj5Fe0y//DClmV3mtZCBfj9JiavRKeI5RJ9Ut
 tSRJ+3+UZCCaSzPAwuU8mz+lEa93eJDNL5m67KgHYQ4Rs9uwUKbGlQi5ba/5aPZDADJByQNbQPo
 +eTwvTIuPJNuFKYsWjX1bNvGqHf5qTG9tloUxgAWavCWRrq4Djoc/8g7cXiOMe0gSvohd5Nl00J
 gzjAV/SmsbKRvE6/gFUK9M01lqMmEAWrSCC0/ki7uNhridujl7s/MbLfjUAZt2jLdGlpOJx7L/V
 TB3FUm6LTWizIjpzyjbwVU3VGV87mNHIl5eaJD0jJbWKywIS5SakILuVKA3DOE+/W3uR0ZiuDkj
 /Mzc8HjlYwiFN4AN4kOcC+YaCl1/k5VHVYIiSjNkpRb2tni5qIALThiGjCNa+RjZX/5RoT8Wc01
 wds1BBPuupKzC1E7zewCffsRCY5DDgiMSiUIE6GeGEdWmVth1WQUgNT9zjBY1FTZ5RvfGO5Uzky
 xY5wXStAThK3yMKyBtuC3A==
X-Received: by 2002:a17:90b:2686:b0:3ad:6090:a17b with SMTP id
 98e67ed59e1d1-3adeae6d892mr5584861a91.17.1793038285543; 
 Mon, 26 Oct 2026 11:11:25 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404276e6sm461889a91.3.2026.10.26.11.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 11:11:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:11:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 00/13] Validate multiqueue configuration in ethdev
Message-ID: <20261026111123.089dc6c7@phoenix.local>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
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

On Thu, 22 Oct 2026 19:44:27 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We have various checks in drivers about Rx and Tx multiqueue
> configuration.
> This series is a followup of the VMDq cleanup, finishing the job with
> DCB and RSS, and then rejecting invalid multiqueue configuration (useful
> from an ABI point of view).
> 
> Some drivers misreported their capabilities.
> It is important drivers maintainers review carefully those changes.
> 

Review: [PATCH v3 00/13] ethdev multi-queue mode validation

Applied cleanly on main (a635140ba9). Every commit builds with
-Dwerror=true for the touched drivers (except mvneta/mvpp2, no musdk)
and the touched apps and examples. check-doc-vs-code.sh full mode is
clean at every commit.

v2 items addressed: incremental mode now checks the changed drivers
(adding "VMDq = Y" to mlx5.ini is reported with a trusted commit),
intel directory detection (03/13), Cc: stable on 06, 09 and 11, RSS
commit message (12/13). Shared-directory rte_flow checks behave as
described: a doc-only item in cnxk_vf.ini is reported, and an item
missing from every ice doc is reported against ice.

One item left.


Patch 12/13 ethdev: check RSS availability

Warning: the release note still says RSS mode is always rejected. The
code rejects it only with more than one Rx queue and ignores it with
one:

  * RSS mode (Rx ``RTE_ETH_MQ_RX_RSS_FLAG``) is rejected with more than
    one Rx queue if the driver reports no ``flow_type_rss_offloads``,
    and ignored with a single Rx queue.
