Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07537CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:19:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B77A7402BE;
	Tue,  9 Jun 2026 12:19:05 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 2ECDD4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 12:19:04 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 80C2D1400166;
 Tue,  9 Jun 2026 06:19:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 06:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781000343;
 x=1781086743; bh=auNzyxHzqhB8ZicvtgbeSeYMiSP/7wmNy/tocWoglic=; b=
 lPLDDCZ4xpqguYE6jxZym+rDkgbzquKcCZQJr4J6qLXyQf8y+P8usSZeH1ZLJA2f
 eU/8AZpkah8TZxLg7iIG8WJ95/xglXpt8nUIHuyyCwTiYFvuy1tyBBu/FkdTrx8y
 9YPiBhmkaCegX0NQ9TgI/LTxPveALmUs2/kDpu5rX4vaMwdXhIC/EfrobZcbOjB1
 hWD3n7jv4HtAtCwZ1LED2XTUpTCqK06H0ufmChxZO/baL/NyMsLURjgJDAe1ygDc
 zWNTZ5X6aIcDYceLFFLP5bLNRQPwdLVHhIqQJIeCPKbQE6wVCDk8uw7/FjSNZ8Ia
 mUfkfKQEEEIBbf90n7gbhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781000343; x=
 1781086743; bh=auNzyxHzqhB8ZicvtgbeSeYMiSP/7wmNy/tocWoglic=; b=P
 YOGvzrRevLQhPIg7EYvIcS2VPbEk/F9eIfvOmZjM2zKD1uRsoEVTgDe1YhtOTlx/
 kcMHigZh8tSzqS82KFs8szmeF7J6kqgYQa5kNmETVELJe+VWEmz482YLyLmCiirO
 wG1vNmjbPZbpXNp89Kok1FWzwP9fQ4xMb5z1sykA7Rk9ju5prg+6ZsBZbfQBjCix
 EAggK3anBgv2wQU5Xf9q+AVk0pmApzT5k3Yv2aTlHA//JX+UjfgEXRhvI7Ojr/K0
 kvYEBGi39cXMgXYQYOXc+0evd5winSn8CYoISJEsl0QQt58G/HIpqC2E3WYlOao0
 Th6LiaBQtH8uDxhJPhNaA==
X-ME-Sender: <xms:lugnamLvwdzwnOVkfJj-7KpMw1nYcwiK9hpOXEri6j8qHjUOzrsrhw>
 <xme:lugnaifklIMNATUf-A7M-fUWjK07e1r_yvxnmjVHEq2S_Kt9ss6v7WNNM9Cvb0BzE
 wliBZ1w6XXUW3gflqdTjmdajSOiWippTv_rC6xDUQMbzR1Hei54xg>
X-ME-Received: <xmr:lugnal3h6MzueCkyGvE0-qY8Uwm9MWw3u4TgNOcgE4lDZ822KQT0JYNbT3rbN_YexJ1e5JlDZcIbYYdp7mwdA9UKqQ>
X-ME-Proxy-Cause: dmFkZTFKthcx/0uGQCdGgbZIwy2IFgpR5nDQ6Ob25Ia8hfqEJ2WnwlXweEh0IwJwM1Obl8
 tdZRDxzyaQcG5npqNGDFiMp+gg/zQO2pEZqF9IfZz61GMpUvrEd3Q+5YMVXC2Y6wB+Weqa
 i+D1EmaGyHqyFNY+zMjtKAFKzqIAjnSewiw7mMS04ulreKkqMtp5kyp3UgXQzZl02Ts/6M
 ELPvKiP963MWosfaX0j9HTqhOFtqPlcOfMeGmARrPJsG5Qb6UX0c2Xolz1D40fBjrsKyBy
 d6zLyWJoRmp/dUFT1uUst2+XpkzpFIe84hkB35bz85JRaaHnhCqn/Pa4hsOPVnDqiih3aU
 PfmM3DhsTIhd5iMqTInMqsIv2jtbu5KgoRyO/cPR6K+RJucVBIjvGgcutgQUsA7OAeTx8/
 fIEmSm9l4Wiw8mGiTrjO8Xl9AhsxEuPMduApjV3JE+P2Jnnml5jlAMY57LWBLGbI/u+H3g
 M4aJXkNFUWGOl+na3vcSDJKtzciVAZ0iSpyaqIzVBAJpEwbam5zUa1mbUoWpxy4i6TovZq
 QFJbUqHIRlpHjbImeT2vnWSRfcmMsOJM8fVwxZqRFeds97zIOkR/hd4WMxJmPko0SK6DI7
 qWghhaqIDdFG981x6ZHkBP7nTUO5Om02fQI8VmnltcCMO2rEhMe2QUQ2PUFg
X-ME-Proxy: <xmx:lugnajh6L5PwPc8c_PbKXDzfSHQPGLNjPUDVozJiggBVPhgv9HzliA>
 <xmx:lugnajRiI8PSdiVsN2pQHAPYpPsE-cz5MTtaxh_A7EHDlelNhrVj7w>
 <xmx:lugnasgLBmk85KLW2LOPzKE2ElnD0vpXrlXv3MDQv6jeXNZ5OT06Pw>
 <xmx:lugnar4v6tzjk_bLo7CP6Xsr_wV9MfFxjwzdDW-GSdkwxS9u-ODSzQ>
 <xmx:l-gnal2TNwUk1Vm_JcXLVonXnxaWEts6npea03Ad11pojCww_JeNk1Kv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 06:19:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
Cc: stephen <stephen@networkplumber.org>, dev <dev@dpdk.org>
Subject: Re: [PATCH v14 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Tue, 09 Jun 2026 12:19:00 +0200
Message-ID: <yn1tpav2RhqsEPrB7tKEMA@monjalon.net>
In-Reply-To: <202606091748234877352@linkdatatechnology.com>
References: <20260608074257.3043531-21-liujie5@linkdatatechnology.com>
 <T4eYjXumTvWFDg9HUrMwEA@monjalon.net>
 <202606091748234877352@linkdatatechnology.com>
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

09/06/2026 11:48, liujie5@linkdatatechnology.com:
> Hi Thomas Monjalon,
> 
> Thank you for your review and for guiding me on the mailing list workflow.
> 
> > Please could you send your new series as a reply of the v1 cover letter?
> > It would avoid having a large indent in mail clients.
> 
> Got it. I will configure git send-email with "--in-reply-to" bound to the 
> v1 cover letter Message-ID for the next version of this patch set. 
> Apologies for the inconvenience caused by the deep threading.
> 
> > Also I'm still waiting for a reply to my question about the need
> > for drivers/common/sxe2/.
> > I'm not going to pull any sxe2 patch into main until you explain.
> 
> Regarding the necessity of the "drivers/common/sxe2/" directory, the sxe2 
> hardware architecture is designed to support both standard NIC and vDPA 
> (vHost Data Path Acceleration) functionalities. 
> 
> The code currently placed in "drivers/common/sxe2/" contains the foundational 
> Hardware Abstraction Layer (HAL), firmware interfaces (AdminQ), and common 
> register definitions. 
> 
> Apart from the "net/sxe2" PMD in this series, we are actively implementing the 
> "vdpa/sxe2" driver, which will be submitted in a subsequent patch set. Both the 
> "net/sxe2" and "vdpa/sxe2" drivers strictly depend on this shared common HAL 
> layer to manage the same hardware core. Separating this code into "drivers/common/" 
> is essential to prevent massive code duplication between the net and vdpa 
> subsystems in the near future.
> 
> Please let me know if this clarifies your concern. Once confirmed, I will 
> send out the updated v15 series as a reply to the v1 cover letter immediately.

OK thank you, it's clear.


