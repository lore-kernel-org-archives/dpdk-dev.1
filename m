Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A24ECD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:17:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E61164026D;
	Wed, 10 Jun 2026 14:17:48 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id A884A40269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 14:17:47 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0A3121400179;
 Wed, 10 Jun 2026 08:17:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 08:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781093867;
 x=1781180267; bh=HkORoX60XsPI0zGyePXzL5Dz22en1pZFSYcqwzuOLPo=; b=
 aC6uCo7m3a8X+faad89SiGvQMgf8fdWLMDnmcCVkN8hxKfWrDWBMFdtuVagXtCqZ
 rVlk2T0sZqfaMkInHf+AKfmm2Hp/Fl+zQe16HbgbTQWc2ywOUfLTfPUGUnP6AyWA
 /qFEemDUIspX1ZpOYeY9svez8ByU01FO98yEkmGBTqjNLrXy0cQiw0rgJdVZgWj+
 Dnn9ECWR6lDFIgVkOKPXitivQ0FBTqpzemX+gJ1RhsJ6HRF/TAeJLMWywODYqoI+
 QbexfwMSIy2LXSCvfsN3/ur+J7v07iCH+y4Lub9lCtWlFed1Jrm4BThQwA5s4y/N
 33pxYLDZtoGYd9ZvjLHOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781093867; x=
 1781180267; bh=HkORoX60XsPI0zGyePXzL5Dz22en1pZFSYcqwzuOLPo=; b=P
 w8hgeSde5nLFU5LpmeNU6kBWsPX41JGFMvbHrEx5cHSbowRr5PujDYmx/lX7rZG8
 jcj0dYMNBKrMbpQC31R7b4gOOJpL7iHRtWCBKVUGO2xyZtgCNEgxUiAiITRkgawV
 XPNvvFn9teWES3jxTNcXCDdgbVQZLmLkNXeK0mvarhMYTAYLGKFjIelkZaCwkiyp
 z15xxj6Yle+rTdHk+xk5qVoRueCekrY1r4DBLMy+J79A4qksl1bciJHv7p9NVdDq
 IuqOOO2XGCRCOGAOWrrTxWgA0Bu8ZNLNLnuEHBzaLr7Kgj6vZsIe+wmfN3rKSDQD
 xyREL2aCBU3KROFf8zJvQ==
X-ME-Sender: <xms:6lUpasmw_oL0n8OaJ0ElmRTkz_rzQOi8iVwQy1TJUZVbbdhZSTuV_g>
 <xme:6lUpanQpKC-GDbwzYNyMEnC-IjwOfbxWEa1vo8u-dsu3bYxj1v0sUZS1bX3mmTl2r
 MZC_GamH2N77Kl1J6t1RxAfFasKlP4wEQvMaTWrEaxNZ0Nk6gLdNg>
X-ME-Received: <xmr:6lUpauLxMoDFiLZmw8iDCJ_aByfOIPO2_j7FIvwF2-X7lvmtXkrVHXVMs_Mu_K4Jbo3yCL4y0YRkTNY_4lqMTAne-A>
X-ME-Proxy-Cause: dmFkZTGCr0nCbitYzswCn1s0X0SyVKJpMV7v1cvYy0d78FOF9gHAt9Mn7SUxp6fHPHi0Lz
 a9Of1X2y0J8JuFnPw9F3HIVsM7QQ04oY7bk972a3RXX+90KYjympvBd7d/SVr1B8JSp3Rm
 spXJo+Gjv6mRDYeaXiTWhPNei/o6vTDxerq0VSlHtGd5eJpMLme/Ox70NBRhV5bxC85s5E
 YldSDA2TdV4/77Dzt+c+kj8g9JWg15IIUkxjFim+xYVyEq7vIQXJIFF4ztSb0sRkZffCvs
 sVvti+dpOUFaHz6FGVeRwRJizzaPcbzWgFrj3/wTr9ZZEhlM+UvvkxXSdNaYgJm+P1FxQg
 Jo14R96Oo64NFnokHEtUsVLADWpxsNjgps8fqLdlk92JdgUKyUx4VPWMdmODhVhu4gLPUU
 mQMx8Y9VpLQ+mUC7uI718qFyE/53Dx0et15YvtPz64LVkkqJtls3PHvMTmY1muSAnSpvFG
 tFkUkoWn0XPrxKBreIkiC7eseLyZR6vzPlnSfhgK2UaiGF7/wVIHPUMVbG89w6WZCM4e2g
 gScM4QuFloppBt5dbN0w3iJ647P2paj1JknuLFf9ZtPJ/zSN7cxEomgYkKLD52CL4fbVNt
 MAQhSuW16Zawqh0R72NXv6aaYUrcrRyjPCEiifVdA+9kZ7nnvhzSp2G83Z7w
X-ME-Proxy: <xmx:6lUpatDvhm4OQNEU6SBQ_wft1MXTBeKiKpzQPpDrGp6XZh4oyMbzvA>
 <xmx:6lUpanCOu2E-XLSC71UkVeaj_TkuEuFFeAA9cFf-rwl_x83V-vB7yA>
 <xmx:6lUpavBvtRMTezwKf-pGKdsGmlC29wXhIs1yG3iDUafV9IXx-UPv9g>
 <xmx:6lUpaioGKO1ivt6s8DvzrQsyjNObEPkupvkrU58zoKWzT7v8HWtZBQ>
 <xmx:61Upamwz3hUNlDUKzywQr5OHc-td3oThnZ-K-7jh8OY3TlAKUrHt2Ua2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 08:17:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v7] net/idpf: update for new mempool cache algorithm
Date: Wed, 10 Jun 2026 14:17:43 +0200
Message-ID: <b0-eVG8rSLyIiCcsmRSskA@monjalon.net>
In-Reply-To: <ailLDte3Xo8jsUWf@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65902@smartserver.smartshare.dk>
 <ailLDte3Xo8jsUWf@bricha3-mobl1.ger.corp.intel.com>
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

10/06/2026 13:31, Bruce Richardson:
> On Wed, Jun 10, 2026 at 01:21:38PM +0200, Morten Br=C3=B8rup wrote:
> > Intel idpf maintainers,
> >=20
> > PING for review.
> >=20
> > The mempool library has been improved [1], so the idpf PMD - which bypa=
sses the mempool API - must be updated to match the library implementation.=
 This patch does that.
> >=20
> > [1]: https://git.dpdk.org/dpdk/commit/?id=3Df5e1310f16e0909e7e7f7180712=
3644c63b23cba
> >=20
> >=20
> > Venlig hilsen / Kind regards,
> > -Morten Br=C3=B8rup
> >=20
> Yep. I was waiting to see what happened to the mempool patch before
> considering this for next-net-intel.

I've merged it directly in main with dpaa mempool patches.


