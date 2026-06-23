Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C407CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 12:30:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15FAE402EB;
	Tue, 23 Jun 2026 14:30:01 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 06B6B402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 14:29:59 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F20A67A01A5;
 Tue, 23 Jun 2026 08:29:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 23 Jun 2026 08:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782217797;
 x=1782304197; bh=nQHFe0L6KCJjafFvLWFgTLph7C21PvhWQKs5xJwdIes=; b=
 jy1EDTyiIU0mKP8G1MtwF+N05Y/j7FDTpGvaSS80syG56HFUm5dvMNRhfjRrq5UX
 kfJCOeCVqsGp5DqIk6KSzjJ9cn8ftS/mLBdDvvdcHjP9rIO7m8JHI2SfzTXtz18n
 pLWM1EMzhA5/8IPpMmcO/bQLipqnM0Nep5VM2rVFUbqOxSJMzDXVw2YiBiR+7GeN
 JAJTYIeTc2hz37VQtpoPvRiA2covicl88T/bsxvUHPy+inGL6HIBTm8MY2zC0zcF
 rDgiHWbf0EYL+U7NPHnhEbXhRMAiSCIqX410AIztxQMtFinvspD7g0WZrlP7KDkh
 SCb8PiRd+/lRyoEzOjxqTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782217797; x=
 1782304197; bh=nQHFe0L6KCJjafFvLWFgTLph7C21PvhWQKs5xJwdIes=; b=H
 Ef/29bu4lIPwbkF4Fpe69fnF6tAFee+G5fVdbFj4b3/hign01k2/nMgutN66F/am
 LGJ1r4V0SNhTaTwV+j7Ytw75W3eQfAmomik9TuXu49/ZJq+yFkBfQcEfwkcr9/5F
 zNMF39rJZnEJLPfKlJI3yiCOr17B0wEqm8+ll3Tkx8og/y0NzhITzwbw7p9huKR/
 ACGo7RR8i/I8MrWvIvSGVpLGDrJ5i9XJ7AgdU0AuMan8XTSDrGSDeEwEUthbn6LA
 gTlYXNWRUfRNWiOIhOKsPN/IzHSMdXFLNE9xEU2wnl0cuEy1hE4xPv7vtd5BymHQ
 g23CTmwsZNyHifEGzZ3Tw==
X-ME-Sender: <xms:RHw6aiJQlzh-hDt21txgLqraw1Skfc8KzQsQGz36fyATnNVkcu0l9g>
 <xme:RHw6aueVWwMOmLPLyM9CXBii2Xg1QA-7xIKWvMv9k3IPc_j8n25jO_ST0AYc5TmLO
 7ylnAlo1Ssye7TrfwoHs6qBdd6XL5Td8NW_qcnpLsZDh-ol8Eps>
X-ME-Received: <xmr:RHw6ah0QNRUfjOTAF_9PzI2HQdjseakMJIelDaKzCHY6aa10RAR3eHOsLMXlKARQJytAAmBJDmo0O4UKimdN_XDMqw>
X-ME-Proxy-Cause: dmFkZTEk0ctUxHf8F2T4o2GdwfjQokn6AX5tJaaztZlhJhANG+H6ZL7IDXcwJxfohPuuF7
 +v9y6FX6Ch483RjL/QyBqgxNpCQ5CMs/UMtQ6qPo/otEojZBwMOtUAFbjkjZTz11AKD74m
 MJkB3q1fkpYQdPfW4URNdMW4cTxu/wvNd8DkBSbFXsNdUQmA7HxLz49RNRyJWp90LqMkuy
 3LSkCExf8IW+sG3yLRLgsgEnmq8wirELf2c+xiklYl8YKopsriqILkmKjHt2pboXIlY8F5
 5+j2JjuOuprmbvu71CJd4mlttvsHglTkfuKkOgF7PlGAYsYHqze/ovJhdFHGo74nLAtOkG
 gN2Nb5yLIJqAya4cUXVygNE+WT/AFA17I2Q65ZLdLb5BwYvc6Hl6w0BaxmA+SmQAl3k2yA
 ++suuaKlv2cJdN2gPIgJmtgHY8xGM+8LCBy9tJ7AJJfTtPqb+tXeWKPHHZfNQ8xkVZKwLo
 VPZW7+LRUaF34ee9hYRIB+1n8ymqD0eHYT4xBYfrtu9zoH8mhuJEnoxxNey1YDfYEvAMqQ
 gwySy1hYRv0zhmS1SQYx7PjkJxnHLNxIN7C4q6k6OPTY6OZ8mlNDuGyrTlR9fLkv5d4f+R
 WE5mTxIhEYxQFpgFjVteq6elEADDiF+h9yjOHnoinauHeh8D/eFa2H3JbiJg
X-ME-Proxy: <xmx:RHw6avjhn2bLxx1y0mX2Ar1V4GZVzyi8w7AWQzyixpaHx4Fzl-NF-Q>
 <xmx:RHw6avQONuwjZBiMD6XbrqWt3-hGsMVLc2D_Z8fyseBtOr3tyvcs1w>
 <xmx:RHw6aogZLm4db-NAoWx_uqr183FcURVnNA7MAvfVdpfjBKi64fYrSQ>
 <xmx:RHw6an6KUjiFaDbod6VQrQijwwt53weVKLnaWynpz6qBOniUf7W4bA>
 <xmx:RXw6alLCgjsKjMq8W2JY5RWUgAKp2nfINXDE4MFgw_QAa5dhGtz0Bp1v>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 08:29:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Date: Tue, 23 Jun 2026 14:29:54 +0200
Message-ID: <DGHVaJ2SRzSz_1-YcgGmxA@monjalon.net>
In-Reply-To: <84ce7f7669404239864c61819267d9b6@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <3BbIFKkFSyOqZrm3k570og@monjalon.net>
 <84ce7f7669404239864c61819267d9b6@huawei.com>
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

23/06/2026 12:29, Marat Khalili:
> > -----Original Message-----
> > From: Thomas Monjalon <thomas@monjalon.net>
> > Sent: Tuesday 23 June 2026 11:19
> > To: Marat Khalili <marat.khalili@huawei.com>
> > Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>; dev@dpdk.org
> > Subject: Re: [PATCH v3 05/25] bpf/validate: introduce debugging interface
> > 
> > 12/06/2026 12:47, Marat Khalili:
> > > +#ifndef LIST_FOREACH_SAFE
> > > +/* We need this macro which neither Linux nor EAL for Linux include yet. */
> > > +#define        LIST_FOREACH_SAFE(var, head, field, tvar)                       \
> > > +       for ((var) = LIST_FIRST((head));                                \
> > > +           (var) && ((tvar) = LIST_NEXT((var), field), 1);             \
> > > +           (var) = (tvar))
> > > +#else
> > > +#ifdef RTE_EXEC_ENV_LINUX
> > > +#error "Don't need LIST_FOREACH_SAFE in this version of DPDK anymore, remove it."
> > > +#endif
> > > +#endif
> > 
> > It fails on Alpine Linux.
> > Why adding this #error?
> > 
> 
> This is interesting. My mental model was that Linux is never going to have
> LIST_FOREACH_SAFE, but DPDK will eventually gain its own polyfill. I was
> actually expecting it to happen before my patch is published, so this was a
> reminder to remove my own definition since it clearly belongs to some common
> library. Turns out I was wrong on both accounts: there are Linuxes that define
> LIST_FOREACH_SAFE, and I managed to submit faster. Apart from these
> organizational issues the whole else branch can be safely removed. Do you want
> me to submit an updated version?

Yes would be nice so we will have a full CI run on it
now that the dependency is merged in main.


