Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE886C982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0A3342F03;
	Wed, 16 Sep 2026 17:44:07 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id BEBDE4028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:44:06 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 65977EC0102;
 Wed, 16 Sep 2026 11:44:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 16 Sep 2026 11:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573446;
 x=1789659846; bh=xLpFx1B2pxZqO8CA9JlM95prpZEQLnhXtJ+iyENxyXU=; b=
 HpLHCKW93vdKerzLCq7UUIcsUWSYjdd9GoPQkEhtAeX/6wQEqShcy8pqAMycSiiK
 ocDz87LFJvnwBpqrlECZC8sv8yU1lJmc+uepHXfRFwaDAO5JVhvSSc7PqYOnJAKC
 99+7lAwJV23fCzBa7Dgk3XmA0LWQ53JGh4zt0fwyZyxSweJ+0s+vcT3aUfZHM967
 hvcjIZBgVMha9K8zVx8T6I+/5OF6ymPyUHFuY9dfa99us36BNtE/TV+DzWNoSQFG
 8tTOatud8iI2kAU8kRk5IxF8320w5HeXKfNvCsrJxPgMtd0/dI1EeFMCD1C48sO/
 //PwaOI8I/zu2PNkp47TeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573446; x=
 1789659846; bh=xLpFx1B2pxZqO8CA9JlM95prpZEQLnhXtJ+iyENxyXU=; b=k
 MoV2A9zKRjSEa+j//LYKVwxbzRSYHGxY/Qm/mBxszMHmQtBAKqS+mRJQ5tuVtLeP
 +HN91DDZlY0owac0Idb0xHvs5NyY1cANlzzHbfNHm3DvinVdOlXkrcQFDVYcKkz5
 ccfN/NLuLvxyEQIFfqKdI0k8Tl2hbBWZjYuPCF07FVOh3bgvwF2WjacywYC9wErm
 O6mmocbyzm8Vxd8b0kIJ8uY5H3f+frbMccELTZqHqIU1LKuauVhauRDHcAVqVmv7
 hCs8HYeM2obvIKWrm5JpYsZpxJ3hEH6Ws2tDuP6z+Qg4BiHTOCPEgR5IC3AJOcRo
 Wo3D8qKH2gtQMiyHGeq2A==
X-ME-Sender: <xms:RrmqaqYdMQfi_AQndRpCqKo6p5A1A4Sjy3vKMcnfQ9TyySbKtuPYfA>
 <xme:RrmqapuwPzsMUxfRBLz-pbYi_1oOV5o6hQa-GCWcvxXiLuTOlNJAgLKIXMS3Td2t4
 8xDcHX94a9yQodL23Lpbs7M-Q8Q_MBC-1VrZNfmzubc4jPdBVsXKrg>
X-ME-Received: <xmr:Rrmqant9rLr3jZZdnKGCxtndvssk-OYrhkWhqDp6tQoUn78Bl5ekvNSa5oiobmKc8IWGTWCVZt9OrQdVx-GlM70>
X-ME-Proxy-Cause: dmFkZTFFtG8ndmKwT+ikgqIrlLMijC3f+nAs/TlunyfczAms3rnxmD44DFGzi7QfG4e5cm
 M9xkToaAeg/xNEsw15K5/gsIhYhQ4zYN+luhRUT+T5P2mtfvmBSZmPfxU1mT8UBLfo2w/+
 zka24QhdDSd6trmzh0P6og1KXqAfhHOxMVOkOw6gPhGSsYgIEpVURWqE3tf3aLuVspxb8T
 /ZcU+BX1hBOV6UQH+6hDbgnJSrE1Nw6UqFMBNJqzPIvGi08ahqCH5SAWdKPsCks45W+xGS
 KYXB7RFgJWIfh4n1XtvyiWk0DHlRInwsPE7ZvNIbiIHJyK5lZJ9c7kJiAN/xzF8NttvOkw
 MhExcqLCuQLnsLN6wHrpR3JntSshg+Ntkwj9o3L30EIsCOFkx1X8ifXOq6mH23QaWKVbbw
 l83u7XKLOsuk5SjHrQJqlstTkgtadIZQ4M9awBYysOOwUb5cAnmoEt5MexyT7uuAmH8lZP
 FKJrFRcG//amuer872tcZPmTRiX7Vphx/RGAFTfeVzSP3wufX6XYtWTKCREa1nL3ySxunu
 tStWw0ueTdV1yD8T9JLbCwL/Ea3nW40rIuvQsj4o/nm4Wzki3KrTK8vmaSYKFsPUalc9vE
 IOw1CO6ccm5prgvJmvfx+dNaoTmTulTSE85999nz+YMHJ/VfHyeS5EWfSPVg
X-ME-Proxy: <xmx:RrmqaueOJaSYsT8H3Oz8DHuWRQYV_RH1lv0bvkk98IGujuH3AonofA>
 <xmx:RrmqaoZYnuVfSFam9JjiQuBDp4lHdNiPoq60b9Cy8MusH3v5EqZEBA>
 <xmx:RrmqahVeVv_b5BU4pK7DuqEdQzk7YupHJTP0ouMEZ7CK3Kmutv3t5Q>
 <xmx:RrmqaqhqbyvLGN74fkuri9Bb3AQdWBpjR_UtgdOAAgc7-IFF4UAwOQ>
 <xmx:RrmqahYxnf4KLzqaDIpkpQ65oExRzJYhuMHzsnRwK7mt7KRygqRA-50a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:44:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] MAINTAINERS: Remove Long Li
Date: Wed, 16 Sep 2026 17:44:04 +0200
Message-ID: <olYc9AjhTxGZQEGP1gY_6g@monjalon.net>
In-Reply-To: <20260914160220.2283910-1-stephen@networkplumber.org>
References: <20260914160220.2283910-1-stephen@networkplumber.org>
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

14/09/2026 18:02, Stephen Hemminger:
> Mail to Long Li at Microsoft is getting rejected.
> Confirmed with Wei that Long has left MS.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



