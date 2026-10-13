Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C23CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:08:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB07C40272;
	Tue, 13 Oct 2026 11:08:36 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 37B3C400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:08:35 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id C2DB11D00146
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:08:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 05:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791882514;
 x=1791968914; bh=CWhNdwQ7a6DHNRw26hcIK+Y8LI9sOQi2QEblnOs5GRI=; b=
 ZfOP4DM0pd82PZi8hU5wP6J7KiJ5ZHFx0iC4xoFWALcknJwqqsv9c7a1WrqwBafh
 h8+hw2cHfVXYU+mOd+2keMkaLtVzda1lkmi+be6ED2nNVc0g+GUIZtYE6XIz4mh9
 3TDrkpopIqQJk31pqIaaBrUmzVgI6dme/kDXgydi33R5e0OD1caCPA5Gyh/iS8xB
 CK2enP8ee/iwJI8B7G4+a0ioWke4/6TZMkXcthEH8NfMMJtSa018IiukmMhPFe1B
 uSYiCpbht+CaafMFjZEOBcTvx7/RG2ZgkEbTDuVpsWv5qOd8HsYh9gB77Rb3gC7Y
 M6sm4Y/uWAqm4UuYt2JMKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791882514; x=
 1791968914; bh=CWhNdwQ7a6DHNRw26hcIK+Y8LI9sOQi2QEblnOs5GRI=; b=T
 +vNNcr38VJtIE40yeLrKurLLwsceoYEv4g42UB1WdPkjEiE9bL9L8FMSfJJQAcKx
 /QIGUd6nvn3HjvvV4qZlvVCsfmIpN8JeyR6TtZaIogBKtxQzvZSvbK28bWTHtHsP
 RdVZhJTRlatrXmtGvjtthiDiOxQexbJ3SRch3X+3JRUfH8ylcJLDIvKypuWHHxLV
 /z/maA8cSvR2J+i+EZ2qp46h3XSwV8h6E5NQVe5x7Fc9o9axVTV314QjZVfvy0fh
 kTZygbm7WFjn2a41TWUIepXlhWwUlhuLLLF/jaXZNI4GEyPrFpHLn/lNtP22w9Bf
 4iS/0J2mDw6SzZsctrvPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791882514; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:nd/chqPf7j5i8OwY4saf075afzFUhzY74QT6zDiXI2a2ki9
 gSJUL1APAWccmg6Au0NUKHH29mcTtzWCCcyOnRzhcR3IW+1VhIWePywFOO3UYvNq
 yz+ovRfnOXktJnpIFnhLM89SzxK31QixtkcbZn7BGFk7vYQspyhR3iMbZ9emHSKR
 asaGs0sEnnxB8i+ye1YGd3FtnLFF2hr7QN44A5Arcl6XNQ7wcb3Oc/sX+tMRDfNd
 hEwojyAQWGZA83U2Fvz6xKH9dOUJfKV+/Lgpi7f4E+/cFxsscYb2/qZDJuvrhklQ
 lUHfkYwwnf5+8l+RZfBs0zlOi13R39Mc4ZYynQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:PzT7seCTsr8tv5iNU+GI3UWxWB+LvQJ19r7JRwX1cg4=:TWksBMrsQyFbZ9Qvh+WIiTMk/oOSPtsDWKeJmr0DAJA=;
X-ME-Sender: <xms:EvXNaqkJFxMRrxqj6vybgAIcO6ZZMqk48PuhEoBjoqDI73upgW7FBA>
 <xme:EvXNah902lMZrN2G72MgsbQQDDsFah9F4_4-Wjq1cmQ1DfL68LCRUQ0k5b_WZOZ7i
 2rbEk8ZrKhrJUdNWAsr0HHwY5wYMpNXMThFR-vWhKSWS16EH4DdxmU>
X-ME-Received: <xmr:EvXNaglVvlRTYnH8cjzkIbP_w2v4dUvDLM98IIawZWF99LBkix03XR1KOgkTP9IlDCBKI6d37OYoNIf35zdNZsg>
X-ME-Proxy-Cause: dmFkZTGQqxJkgE9gmqLkJNhwlD0+UypsQzsMKW8oTNOMtsgTed4RGt9TCUsEEVCbIefqR4
 cXFREy4e8NdBrP7bI6wLeK3oblPEXEzkDz8RAyGs7oubH1qRuALXiWO6eXJI5InCnu0f9y
 E4Hu0S4gLuvP+o/jBBVAK5m75zh33zUrlw/S+yRRWnIeKF5c69FGNKqnXs+bHIAcU2HgBV
 lEKB9p3rr+BRqh2mW+Z6blpE59dzApjoqB3pgeC3HSZS61O/ZqWFXpDlLFq6tKDmOHxTaY
 qyFHPjBBTyRsBMnr5gRPCABG1OCglTUloDT80pQGStzAHzyjUq48Qyu3MyP0XzI6celfPE
 n8B+qvLOBJHMiV3mGpGxpOp4PBUkeC5iChJrqi2VjT+Cv8wpB3NegXpPae8m16OacJU3RO
 SIESAVPTjJAVEAUVShCagte6m1Q7MelhK3BYr+3kTzHxw/vZML0ZBWQsRAGzhSE6IMrWFh
 c4rsrd2CAweikEa3AfwEBmtMbS3kwxAiWg5kNyDlbGmDtVOktbf52ooCzoeu4h6T3vAuMf
 hbI/mdIc72XRkr2OEuiW0UrOwLoV1d8Gn8qJSo1cnm9gzVlo5bbxg+4kZCMz+Dbw7Na4KM
 468yisxAvLeLo52+HpXJ1F/ffER2v5Vb6TjqbzuIrQ/CFs+/T1x/m20KoPmw
X-ME-Proxy: <xmx:EvXNam0L66r6FTvOZepEATzq4_3bYbGPi7KMk7fSfMns0XFYHvmIyQ>
 <xmx:EvXNajrZvW4gCo6iWOCcfJpZeuBvWJUKCtOoNsxcZRTT-UBwVtjfig>
 <xmx:EvXNarenlx5i_5cz8LBRgal9Xe9Dn-gi7NVm9Wt332coIFII3-O7MA>
 <xmx:EvXNaqoINkPXam3oPkSh3o9wx4DpUloiWc4OSdoXnp7zFm1uJsxQ0g>
 <xmx:EvXNas9pvEj6-0E3Btq4GeFAZAFTpxcQuUFRTR29WDr_PX71PUOg-bo7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 05:08:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] cmdline: add cmdline_ prefix to dprintf
Date: Tue, 13 Oct 2026 11:08:32 +0200
Message-ID: <JHIRxFo3Rben750dv-Oa4A@monjalon.net>
In-Reply-To: <ap_g8oAzdlRSd3d6@bricha3-mobl1.ger.corp.intel.com>
References: <20260908101534.71961-1-marat.khalili@huawei.com>
 <ap_g8oAzdlRSd3d6@bricha3-mobl1.ger.corp.intel.com>
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

> On Tue, Sep 08, 2026 at 11:15:34AM +0100, Marat Khalili wrote:
> > Macro `dprintf` defined in `cmdline_cirbuf.h` may clash with eponymous
> > glibc macro. Add `cmdline_` prefix to the one defined by DPDK.
> > 
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> > ---
> >  lib/cmdline/cmdline.c        |  2 +-
> >  lib/cmdline/cmdline_cirbuf.c | 28 ++++++++++++++--------------
> >  lib/cmdline/cmdline_cirbuf.h |  6 +++---
> >  lib/cmdline/cmdline_socket.c |  2 +-
> >  4 files changed, 19 insertions(+), 19 deletions(-)
> > 
> Strange that we have never hit this issue before, but good fix.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


