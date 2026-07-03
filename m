Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E636C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF225402DF;
	Fri,  3 Jul 2026 13:32:21 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id B5F16402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:32:20 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 2C0851D0008A;
 Fri,  3 Jul 2026 07:32:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 07:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783078339;
 x=1783164739; bh=amXq+8mgmkBv4KR6V7RL6MaoJBuMrZi5phN6nhQ8Glk=; b=
 BCMljlBakJO2PEbHJILXCHwKd+R4gAxZwK62BlYfR9y7rJt7EC+t5DtWAf3VW8yg
 tJ5uwL9sfnwKQ8JC1hBJe0RvUbpBu8kCEDHPdQ2isURzfDAvrHu/dMmYMNNrKo2F
 RDohFeluI0bnIrQfJYM+rkLLM8v+N1RprZaukfKM2jrAtT4mTcNn1ynPDC2lCrDx
 EzwysvDhsQye2s70sAHDgoGJBYphoq2TL0ATuKwwXT30FFE+hcj82xWcrOleTPlL
 qEpZnCHIn9xk6RcOE/pykgRZ752ITRR4wAyNj9kqKiZeWdPgB0a6r2HxCJ0qqDBQ
 ym5ed//+k32npz0Mb5P9qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783078339; x=
 1783164739; bh=amXq+8mgmkBv4KR6V7RL6MaoJBuMrZi5phN6nhQ8Glk=; b=X
 cJJkfa0zFWrDX29VfbC6z3XKf/Tukar8cNEztidL/cVkqqJ822cQuAlNFLL3YO1z
 yT5dKlqlaB567XbwPH+gAwazecP623GbmLRrea7A859kzWOE/Ixh1FVPqHKRYGXX
 hPau2JZxD7t4Tdj/sIH9GZa14oBaoCylRNbSD7L7B88Gko9pSd0+NjUc3gyO2Bo7
 wUSK5EWdSV9eOakI0uInmTOGVLVTZvwyCLvl3jDqyblkQeTcKi4zVIgkcdQCSUt/
 ox1V9mTZ3mAYtmoF3mlf8AhJylE27Mo2xVkbk0YO5aPoCsn41NZPwueDMDoL+AyV
 qghXHwXJx8kSIKik3SyxA==
X-ME-Sender: <xms:wp1HalFO36Ewtgs9-Z5oxzGJMolY7VyijcqUrbRSbM8vaXDt_tnyjA>
 <xme:wp1HauoJtZolTeNHLKKay3GOqWOrRalGXXe6O3cpuWyJyFzwAqUgyMg8xnNqCGXSB
 08qXqj7ymOSumoWZIEiUKnv7UbbOr_M9SVaPwl_Et-xSoc6pt4X>
X-ME-Received: <xmr:wp1HamQnSnEhjNPLfivScZOnpkZYf3rBj2N0chlxLFQKGKp4IPwNMpwXQyLQos8eeLFiqNPIwy7VoHNSRfESf3UK7w>
X-ME-Proxy-Cause: dmFkZTEoBg/5s4gy0j8EV6R0fDs/HI+6OQUdF3uyP+dez9R5Ufxi/QZvtDVbDNS7go97f4
 lLC4ehNUEwCxHOzaTJxJ/ck/t3mHp5osbWaSieIT+jBD5vdoAqFnOLWMDsrT3pxdilwjnF
 t42WLMLr2gkmOVTnGxTEhcYBHLizLg9zO8Y/LbzX0rlvbzavIGilpA9Youfsa6W42X/9oT
 7hiXxWy5+6tU70FfgaC1jaaiFzHJKuJVTxwP6XMqdT9BXj0U9Xl9wYP4HbQil6TZbeyGOz
 fW+gt85egcDYRsry3NANpuzxhiqiQogxKpudBB4afJAtVHsd0dclWDzBDKQsbarn7iS4mu
 2w4KR3UkazlZHAHL9jKmFXDluY+zJjKRRBXE7QkHuazUiwWGK4uLN/j8+ZcI6ilnJdPThX
 7e/yNsq8NR2qZX7rcjqFGmxToixMJc/nvcOYEYMB5pFSsFYarmIp5KIoKMAqqYOZoWR+Kl
 S4QFxYa5REVrtk7p8JEvK7Wk+gm0Rk8v4JYs7fg97gKeWYtIe9H5ivSkkXtDgbN8UVs5O2
 x12ik+PYIt2DopWSwPIrM7SLT+UiPicHp9ofGhw9aj7cbTPJdo36qlODOXpiH0PS26Rltt
 kvP+W3DLpwBX0bP9rYxkw2O/9KDZtP+bMURDJv6ncAmuQ3uvzqS4xnKO1bjQ
X-ME-Proxy: <xmx:wp1HajOV-JWYlOHeGVS0t-ovkqkIZ3CQVyDOOV1dDkyOmVACMDaAHQ>
 <xmx:wp1HahNhZSoRfTS9DrJXgv2e0zJv-_zwe51jiD_DSRZYnmSiAOvVEg>
 <xmx:wp1HarvqrwLry8cAbW5qsNhBQXHNV1qVOvAgyvma27mkSE4k0j8WBA>
 <xmx:wp1HajVvkCrnNAOCGMk25m1chTWDxgj9c18SMDVp2LupI2lQFdVOpw>
 <xmx:w51Hah0CccFiW9PN76AeEY_SL9FRZYoqQ179MLE5oSKeyZFqFk_nAwOT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:32:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] test/bpf: remove validation tests from CI
Date: Fri, 03 Jul 2026 13:32:16 +0200
Message-ID: <uL3Gmts1SCa1M0sJvOuIOQ@monjalon.net>
In-Reply-To: <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
References: <20260703022738.2574548-1-thomas@monjalon.net>
 <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
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

03/07/2026 10:48, Marat Khalili:
> > The new tests for BPF validation are triggering a strange issue
> > in GitHub Action: the last tests are killed by signal 7 SIGBUS.
> > 
> > The series fixing a lot of BPF issues was merged
> > but the related test has to be removed from the fast tests suite
> > which runs in some CI jobs.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> I think I know the issue, it's tmpfs exhaustion. After some recent changes each
> test consumes 25MB in the --file-prefix directory independently, easily driving
> small VMs out of space. My ~30 new tests were the last drop for the CI.

I don't whether it would improve, but it is a lot of tests,
could you take this opportunity to group all BPF validation tests
in a single registered test?
At least it would reduce the noise in test reports.

> I will try to prepare a fix today, of course please do everything that's
> needed for the CI stability meanwhile.

I've merged this fix (fixed) already.

Thanks for working on it.


