Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD5C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF7934028B;
	Fri, 17 Jul 2026 10:44:50 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 79C624028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:44:49 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id DDA59EC011B;
 Fri, 17 Jul 2026 04:44:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 04:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784277888;
 x=1784364288; bh=2u1l5moxwgS+8/gGtXH4rIEQfy8mXmyCNM0c9WZK370=; b=
 kNc5YAId14ltnqpVNK86cQQ9//8/EW5lxpe6e4LPNfMnGg1CsSm6Af2//Hm3v/kd
 lr7da7m6Ix6sneRsVmuMaiohWRoqg9RllxLlV8ip6Anw9wCuUJjzQNbBpxcK00WF
 nlvFyzWx6ej1NPUryHuOhbPfe+0gfky5IN7NAjXlIAByL46Kg6t5cXar7qa5Mb+c
 yHNLjnvbLulWUn+3n0KMb5MrEVHwv3Nm76KpcukfP7XEaEF63DNdWXq3qgrNwEN+
 DCFU5Yq7EQnf83d0ur/ATksV66TsKHcdptUhroY9JRo0z3NnbAe7dGfXu2o9+i50
 tbtYdtqOh9w/wCGdy5VvqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784277888; x=
 1784364288; bh=2u1l5moxwgS+8/gGtXH4rIEQfy8mXmyCNM0c9WZK370=; b=e
 3b3BbevB6weCE4QjLdMa3Uzkh4us9me8PPqnbzG6V0lvwpt1R802QoJFbCeNPJ9t
 aWX2qNZXKGIDs2IVEQvc0iXo6mDGibxTN1zaeAhEyYiweuTRCt224I0t8JNqsoM0
 Zug4GPmzE+zy8QwqeJvKqKMU55qdGv8FlI24kA6FoLIedlO7kuaVZ03298sE8LLh
 pcPPrD54DGQ0RNP6mrTXN/4HraqCx71Oi48SiFQh/oYQai7MlylaHFjzAiOPWCcz
 b0yhUGMo/UqGfxTGfhr6JZBM2IGZBTj6KEKD7wIDZCZfWY/vl5E/337VpqG1BSUc
 ydJ0zpj6lG73pf8IDn+CQ==
X-ME-Sender: <xms:gOtZanp9gD5411B2dGrVoRXbE4IKBdNEyKBME5_Tz_WenRLN6EWhiA>
 <xme:gOtZartoNtjBqHLGL6SysUjviuyZNVHsLERJO8HauPpRJrCXWvp2-1kRDoLoPStAY
 dvJDYBlMW5eQyJEh8n8Mu6m3ts767XlpkSUtwQCY9wY12SUUC0PUQ>
X-ME-Received: <xmr:gOtZakH1gBumzEqGGTEhJogRor2nwGH5cgzKLKXoL2G_D3qW_GFzbHbG5PxegWcXwj9evhggVGWhpXaLkA>
X-ME-Proxy-Cause: dmFkZTGfva2SUH1Dbcz/IH5z9rdef/Rk2B3yoID/ioGtZw0PIUgIyPRUhaetFihcOE9abG
 RIipFFV9ysovIeSd3+oeA/Cf0HnuZs84D8l1Ef+JaDw8XC11WHB5FI3owVjm+fFcHtJxh1
 77IJKpOcd7HrIG/dRh5bxfuU85yfux9LZYs6JgO1+4vayuAaRSXmDWxFdHKcYKtYVmjP8B
 xnEWjs6WU4O5CA5f2YrY2XVLIKYcGpBHjik5au9qcCf3Iz5vyorAbeJmFQvnMOQ3nJ59bJ
 dLnvMGNFFKxE9EhBLLxn7GqJVvz5w8Dl08kpZUdM92+VYuakj0IjEd1kaiHaAaa3j8KrJv
 LdPHYLoNBLbHISNYbUX8gOQ7NLHJ6zGhBC6+FBXw7k+geUYow9h3rycwC5/4yzMxOYngL9
 YB0bkbR6t+JiP4vOcv4V1z9hAGZLgx1R6d1F21QpQBv+X2SPwyJLxM2cGSgPJX4JFMikyY
 pPHJMGLrio1OdVpN/78DAdXElLxHzOpEN0NbfZQCXF2Oq1J0+ehggRTjJd3djcVM8vfI1f
 evwYB29AQnKldGsW4UGyK7YJIMJnY/fYkHBQ4WDp2G9ASmWwu+XB5RYh3sfswOM7nMq7eU
 ranoZxlwKB1pamqSTMULlpEvj92Ij4qEaUY/3rM7Am/SiZmTjzJ8EexPwleA
X-ME-Proxy: <xmx:gOtZasbNlZZVd4h8e1MPvPvcxzWwm8_puB32srR9Ok_sApqVBH0W4Q>
 <xmx:gOtZakU_va6EvWSBYBUrG1OvJCYI_R-7qRlnLwFD5gNQcx9xQPRdFQ>
 <xmx:gOtZaikM8QsMJEuGj2i7k1CXLF3GcAgFP9mWU2mXwzQf1F5IHFl0Aw>
 <xmx:gOtZavCRmZLyomNBwrMjeF3wczHR1svPuFGV9yAkfP-rOnwgbXmLlw>
 <xmx:gOtZaukP5z9KRSsMDaqLLN_1Cn3oowMT14wDgUQN2M9wKqVxd9zXOhHX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:44:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, kevin.laatz@intel.com,
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, david.marchand@redhat.com, 
 fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v3] dmadev: clarify last_idx documentation for completion
 APIs
Date: Fri, 17 Jul 2026 10:44:43 +0200
Message-ID: <-xlt_zDzRlON1MlTfXvDNQ@monjalon.net>
In-Reply-To: <b79c0cce-f9b3-4e90-848b-0ccd013c5cb4@huawei.com>
References: <20260715104934.3668478-1-raghavendra.ningoji@amd.com>
 <b79c0cce-f9b3-4e90-848b-0ccd013c5cb4@huawei.com>
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

> > The last_idx output parameter was documented identically for
> > rte_dma_completed() and rte_dma_completed_status(), even though the two
> > APIs have different semantics:
> > 
> > - rte_dma_completed() only reports operations that completed
> >   successfully and stops at the first error, so its last_idx is the
> >   ring_idx of the last successfully completed operation.
> > - rte_dma_completed_status() reports all completed operations regardless
> >   of status, so its last_idx is the last completed operation's ring_idx
> >   irrespective of success or failure.
> > 
> > In both cases only up to nb_cpls operations are reported per call, so
> > last_idx is the ring_idx of the last reported operation, which may not
> > be the last operation the device has actually completed.
> > 
> > Refresh the full documentation of both functions to remove the
> > ambiguity and make the behaviour explicit.
> > 
> > Fixes: 91e581e5c924 ("dmadev: add data plane API")
> > 
> > Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



