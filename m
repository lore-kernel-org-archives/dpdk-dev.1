Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DA2CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D684025F;
	Mon,  1 Jun 2026 12:03:47 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 000D04025A;
 Mon,  1 Jun 2026 12:03:45 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A58EA7A0104;
 Mon,  1 Jun 2026 06:03:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780308224;
 x=1780394624; bh=G0uZoGBaKlDR5CATDxnGs+BAyHPzV/gTrnWELcjGETU=; b=
 rXnayRYRxWHukwQtamUvc8r2dRT6IIiDkIIICUeRrjiaQL6WCgM/VwtLP4yobK1m
 BWVrk8PvW9XF3gs1p3vyMP3aNTjVuGOfa4XZNcobMUl7ja4D0FcaEl0+hEYbkLy1
 YFCy7IPfJA6EdZRoI8fAYkKw4bYEW09cXeNlDroR2fh4T1qi8Kcm2QGafraRCY0h
 6ElPQepwOtR1iqEzp25RWu0LxcMmqr/56IxwFMVz5bFHhcllePz0q+7DcuTBOF60
 DvMEuzNwuabwloW3+RDl1Jp7Aia4Nmf9qe5wGz0NjYn/2BfYOsxjuzl2YA1mWtIs
 En/6DKCtaSozlbMoAeYH1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780308224; x=
 1780394624; bh=G0uZoGBaKlDR5CATDxnGs+BAyHPzV/gTrnWELcjGETU=; b=H
 N1CZ3WDguah2ZbSiy1iCMf7Vrf3u6GEt+bwybqOrg92WLC6uW4iG4c+ZE79/4f0m
 PFM9aIkumsSZ7nfKHm30HeBdAGkVD+Chg2Vs3TBZUwdD6xEOLAlpTcSrQ8ysPgag
 SGL9djQTtFxXFkRBw8MF1Y4bbF+LoYuggXPgIK3vkZk2KTeM1raNuRFtsLR1IUda
 1t5nmLdK6vQ+FeGEokyGMCK0w7KSy1zTe13Q0bQnXMIF+Iy5SCqBzKC3wVUNNLtI
 hRGNLfTGpC9aoMs1Ei2b/fkCNscarUMeVEpbmbxND/yBmqD7PefyjepPlgRSwsxP
 5GBd3J4NcTxz4zNJwlCRQ==
X-ME-Sender: <xms:AFkdaqEcCXoj8ysfBQT3dVNmLMqS8uHt6ucCeWZIvXzTZZzwbVU9Pg>
 <xme:AFkdakQwAixdGYCiiHCxprqoxOwYRbBg3QiaW5KriL96YNmltuEHNaHAuTi1R_2yU
 lsB-bAea1NGM82ft7IkKvzHrhUSHqTfwHa3Pfkw1Q49iDzav2ZglLU>
X-ME-Received: <xmr:AFkdavvsNIFRDp6_bVqyVVadtBCflQxn4HXu5tEPw6iLj8ONge5rwdqc4ozmuz7lZbtALoDdNkmInRYnOEMT2UCKRg>
X-ME-Proxy-Cause: dmFkZTEyNMdAF7JugPQ9wouzAV+gprVMIF5D79DovPbNqYjx8ZJ1u+ydwp0krjzVxTZ6Nn
 ljM+NoiNmLtfFTdmVAx62cqG3SPMpKfWTYffkSYfLxrWh5IwA8FhmPBG8+xlLtEFei9xdW
 TVOoVtXGH056jXjswECf6sL6WKUPoh8gGFPAD1k/oMbklc5/nZVXA1rSJyQI4NJyg36m4w
 MO9+fm4LZmDsOig2nyVbPuQo2sbnqWepa0y2w+wzwrnWdBo49/YvlsTPE372m11tBtRKBr
 wyroquHHQU+3K7fCaKaIfbhO7Dm6FAuNI/cORZG73G8cI9cg57kRGnVmVDTc/SG6HB6VnP
 Nh/GCnX5omBAYR5DU2tYteVPfcATz/shyWF9Hp3s2o+cSj5jEFf19T5ncfHqh42sfNB6mM
 4gsuoBDonBX3nyBv5gzBsQqqW7hFuqZYOw/GJtY9XA0nZjEEKbSHWhbB+CSY1y5Q7kNtfZ
 bTRwyPNr6pOvBZOEL5v2RSwdpmHtQlvoe6eJqEZAk5NtMflPLN3Vey2lGulV5pU7JnQ/6S
 JXgZYZ4ONgu/+q9iD7FpfYqwkFUw1ec+ExTPluZoiXT4/Btqfg6kOW2amzGYrspmwzMxvz
 x3pa6F1UEMs80DdsJGM7GumYyBMj3iUi60wzfpfwQOFEbZo4X0Fc/7+WfKZQ
X-ME-Proxy: <xmx:AFkdakKqR6n22BHj2aNTmfwLxYAemU5UK3Usfattc3G4r73FWMlq2A>
 <xmx:AFkdaskkFvD_ouubKd92gbQlFRIImCpAbHCj3KroHAjuTh7xNH-ehg>
 <xmx:AFkdalKvszl-RdlGlvI1w0ah_jBSFS_kR07JHdbYVh4heFLEziESNg>
 <xmx:AFkdah4hEyM68h8VXsLX-ZNALNkKYVzFlrRnkYyt-F5YJsM3dsWfnQ>
 <xmx:AFkdar8npM2_xBFVmAamoXZdy7VnArhGapWWdfDRygnoPSRQhl0TCf4Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 06:03:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Michal Sieron <michal.sieron@nokia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal: fix data race in hugepage prefault
Date: Mon, 01 Jun 2026 12:03:41 +0200
Message-ID: <EHj7g9ZXQOGUyi5M5pARcw@monjalon.net>
In-Reply-To: <20260520170812.759638-1-stephen@networkplumber.org>
References: <20260520125756.530808-1-michal.sieron@nokia.com>
 <20260520170812.759638-1-stephen@networkplumber.org>
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

20/05/2026 19:08, Stephen Hemminger:
> The prefault step in alloc_seg() reads a value from the hugepage and
> writes it back unchanged to force the kernel to commit the backing
> page. The read and write were not atomic, which races with concurrent
> access to the same physical page from a secondary process attaching
> to the hugetlbfs-backed mapping during rte_eal_init().
> 
> Replace the non-atomic load+store with a single atomic fetch-or of
> zero. This touches the page with an atomic read-modify-write without
> changing its contents, eliminating the race while preserving the
> original intent of forcing a write fault.
> 
> Fixes: 0f1631be24bd ("mem: fix page fault trigger")
> Cc: stable@dpdk.org
> 
> Reported-by: Michal Sieron <michal.sieron@nokia.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> --- a/lib/eal/linux/eal_memalloc.c
> +++ b/lib/eal/linux/eal_memalloc.c
> -	*(volatile int *)addr = *(volatile int *)addr;
> +	(void)rte_atomic_fetch_or_explicit((int *)addr, 0, rte_memory_order_relaxed);

There is a compilation failure:

lib/eal/linux/eal_memalloc.c:604:8: error: address argument to atomic operation must be a pointer to _Atomic type ('int *' invalid)
        (void)rte_atomic_fetch_or_explicit((int *)addr, 0, rte_memory_order_relaxed);
              ^                            ~~~~~~~~~~~



