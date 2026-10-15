Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC57CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DFDF402E4;
	Thu, 15 Oct 2026 13:50:30 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 25917400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:50:29 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9E8A51400140
 for <dev@dpdk.org>; Thu, 15 Oct 2026 07:50:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 07:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792065028;
 x=1792151428; bh=ksE1b0fhgM2Coc/aqgWBCVkgY+LWnTHjX2zhWOSoMOo=; b=
 fNj+vLtdNuhfeelze9H7/caHb+a2nAuel1G9nwUCjCqww50kv1OYGT6M0uC4XPeb
 Ssb3qzhSRscsxUTMkuZDts/vYtt5DVIX5uDg/j9StOiMui7EDQpGtXB6y+Xeh1/0
 UMyHK/ia53RRAtZwwAEOxTcQh8eZ8aY+6L1Wp6ijLO7ajRz8Hn10ljCIMRska08u
 j1LDy5okqUXfXYjFPZZuyLEYMLZHVyVQZiV819dD86neMTo6ceoiDh5/I4a/u6it
 RV01M6BIoabDculwF8j9SlYQkRgWQ03oB7rhZlX2mJyW5UGopw17hBmm7ozT+VGx
 oYLB6ZftvOYOwEH28ah5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792065028; x=
 1792151428; bh=ksE1b0fhgM2Coc/aqgWBCVkgY+LWnTHjX2zhWOSoMOo=; b=Q
 KVe7gojGf//DH+qttXK7ib8cu0Dz61qhpWPtWRuBpbn6FAtMLzCalsHvpRra52A1
 zjTg8M0hZ0yYlLbDzPEzMfP6tFCZLk9WXXSFpsT4ZXTvUQMOqI43uyG4MQWf0Zh1
 5WFNS5QXGGXdBK19op6QPwaWQAU5c4jN3aePbRAMztor8unrfbgV6ueNlgV9sY4p
 z5JLQRGGGd/QJeqz74xQq2NqNNa98m0Pi/dfQEQYte0Du0bffze+UtUrpHlIJLFx
 SDePnN//7r6g5ANKxxmjhIfm1qVuMLRIw6S0e6TPkh3co7Kq+pAy5wHAUxh9p3Qs
 843F/LjITbLbIWSRQwdWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792065028; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:QE4Wpt7xm+WMB7iFzYdANELpYZjdfZ1asq39CEJH6cs6w3s
 lP3tTIpp/5VdXa2b5gkWO8e09toqebWdJ3H2h8QUdGyhkwDd6yURrhf24EtCkZga
 1/vpB8lD7aiOKDv6r7AipU8mKP1EuIfZ+aUV4VWHPMyojHeJXSGqftFsPv1kp+wm
 dqj152bFENfTN4gvSQ6XyLtXysIw2jdX5ie9K879v4DvB7nVoMcH2LCskeOT0FEp
 RyU9cW9+vcTpj/mouzzUAeP7B2Gpt/ORxBqm/FLU4bC6zBux5t9KtKQWReHJvmwL
 PmpLmDe9q6FWWIhEiqfpFdm/3QsPQi2rhaWH4bg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Dz8KugCxjmRIYeQJyDjwTWwpzmPKMOxIgi1PBpVSuyM=:4Qax8hXvvcXk1ijX56aVqfW63DfQwIOgExLEjNuElTs=;
X-ME-Sender: <xms:BL7QanBLg_sz-xO5CxkgxSUN82VIbVqEg1a_tUHYmSnOvZWYh0Ikrg>
 <xme:BL7Qao8MhAbO17JUdCnbi1dvqNypma1fxgv3nQSn63t6Wog6_7wcmpp4jvucUAtKM
 4ZWTB0DpXi0QSAzGrRMLJPr7iI1mAZYClx83gM0dM8V-oXkvJSbWW8>
X-ME-Received: <xmr:BL7QamHmQIdwtOMWjb7QAujBp3u5xqz4Qmpn0P0mYHKKywa5PddkFNbowauDQvcQjWjt_E3KF0RCspu6R9Prl4Y>
X-ME-Proxy-Cause: dmFkZTElU+8M0KyGXadYj845yA67D9bPautCy1khY2tauX43Fy4EHds3MmbkaaDriKAghP
 Aa6hTmmmxUoZdDk5YgV2ql4DEsDouYdqp2AtzTcXLBJamC0KUJTiaJKvqHIg6/ovAs5eaz
 dnz5nb2MZIYqdt2lZOX0qlNLZwHJtXDZozbVhEKzLtypgJOki9ARmhe8NWZFLes44OENU+
 9NbL7XuzahHF29SEB32IyLQpICzOFnHPR2TWpu0sB3Cuw1VMiwITwTBlEK0X93VIj6y165
 N2Tkpl2L5nstqDQiA8J6JCdN6R9tCmx4ngoTK7JwZBDwz67eqD6sW9gdAGAQj9Pgf7wBAK
 yOpXROixLiUqZpQpl4hh26iJN4Bj4wIAEC/Pi4NaLgtjPmvejR++Ag7vdqVBFNKiGzEFmf
 IHx3Fv4cq20Kf+D3lJqlOqiBRFTIDR92S9gqdWMxLV5bbufmLQyLPkfiwmvyjg+G4TTG7d
 tStjg9DzQ1qDxq5JPyGcuXcZotbLdqXim7vnUV5/e2z+zgMgDGIk+0pS8zhXw5CVkEwk2j
 WcbeCY5bpMri53Dzf4kpa/1tVONt19r6aaIuZg6cejh0ciImyNzr+BN4j7d/5aFOYwtH3m
 DLx911FHPTSWg59TBKlRGb7i8L/jR7M65od6Nq1n+eNfv7SUcuEWS+StM95Q
X-ME-Proxy: <xmx:BL7QauMjNoB7tVeAm1WJOwQwUtbqbQDPd_KLkokwjrNebAHJtVEjGQ>
 <xmx:BL7QaofMoc13kNQpx4DEKMF-XSGoDc1BqWUco5kfkIwesHyyaAMksg>
 <xmx:BL7QaruJug8RgiScZ2oFj_8_I6sBBeesLab-6GgTKn_fQNpyWrkCTQ>
 <xmx:BL7QapljpKEzno040fSwFhDm9CrqUt93pyyKbdIzVPwTER5GVV0h1g>
 <xmx:BL7QakEV8sj_DBh0EVCqm1zcveKxVoiEq0SMEUO5WFh3j2tLaEHhOgyQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 07:50:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
Date: Thu, 15 Oct 2026 13:50:26 +0200
Message-ID: <RcoKQBVWTYKPV4WELHVFcA@monjalon.net>
In-Reply-To: <395f7d87-087c-4da6-908c-e9f569a7ea04@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <CAJFAV8zqXgiwAghLZgR4Ha0dnvwtf9puECJpmv57N2zTE2dMxQ@mail.gmail.com>
 <395f7d87-087c-4da6-908c-e9f569a7ea04@intel.com>
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

15/10/2026 13:21, Burakov, Anatoly:
> On 10/15/2026 1:18 PM, David Marchand wrote:
> > On Thu, 15 Oct 2026 at 12:41, Burakov, Anatoly
> > <anatoly.burakov@intel.com> wrote:
> >>
> >> On 10/15/2026 11:13 AM, Thomas Monjalon wrote:
> >>> 15/10/2026 10:53, Burakov, Anatoly:
> >>>> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
> >>>>> Testpmd commands should use the driver's public API
> >>>>> rather than access its private structures directly.
> >>>>> Note: ixgbe_testpmd.c should be considered as part of testpmd.
> >>>>>
> >>>>> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> >>>>> operations are available through the private adapter structure.
> >>>>>
> >>>>> Rely on the public bypass API to check availability
> >>>>> and handle -ENOTSUP in the commands.
> >>>>> Remove ixgbe_ethdev.h, ethdev_driver.h
> >>>>> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
> >>>>>
> >>>>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> >>>>> ---
> >>>>
> >>>> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> >>>
> >>> I forgot to say it is mostly written by AI.
> >>> I didn't review it myself.
> >>> Please double check.
> >>
> >> It doesn't look wrong to me, testpmd code should not be using
> >> driver-internal things anyway except through pmd-specific API, which is
> >> what this patch does.
> > 
> > On the principle, this looks good indeed.
> > 
> > My fault for just moving the code around, without considering the used APIs.
> > And there are probably similar issues in some other drivers _testpmd.c
> > files (at least net/ice seems to include ice_ethdev.h).
> 
> My guess is this doesn't blow up on ice because it is not using the 
> graph helper yet. I'll see about fixing our other drivers.

Please could you make it as a v2 of this series?


