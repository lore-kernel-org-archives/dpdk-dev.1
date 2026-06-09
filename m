Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A72CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A6BC402BE;
	Tue,  9 Jun 2026 10:52:38 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 8901B4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:52:36 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0975FEC0221;
 Tue,  9 Jun 2026 04:52:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780995156;
 x=1781081556; bh=E/bD7qWR14YfOrLI+UFVVEpXfPa0852xKlen64ReUfc=; b=
 Gt/6+xCSxampc6SA6YIvCB6kDs0Lahd0Y75twRJR+dCd0OJqoPW1RLDw5tYGoG6u
 cd8Ppn+WRSMZYvUerUNHiJsmz5uPPsKZqshG82XIt2+A2nF6NU3z7mL9rwnsE+YC
 ZzRYsZT8k1rAReWFHYR7ldUH6xcVGfKHoLracMgSw9QN4StFG1coSG7f50//+/bT
 pEtk1j1GlAvfxitPRToFdmKO/1ruw4TB9utGDREWmHsi5ns9vriiXpxsylIc4WLt
 BVqHyGtNewfGvHX4o55tUD8GvhEtDtrK5gxJv/YtKLymwj+RnUJCoSYHixQyGZog
 XseVnkZ7UB9LwS15FdJMcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995156; x=
 1781081556; bh=E/bD7qWR14YfOrLI+UFVVEpXfPa0852xKlen64ReUfc=; b=X
 qihY8hwI9cXoQ99JlLEdkeLnqOcWwuJdsoxjE/R8HuW560gXnkHs+gYg/LmcSQN3
 lqEWiqQmPMOywxsnUDysiSqMOOvBJ60IPw54pPUkRQjK7P0+fhRdeWQDFt61rGBR
 fk8a7jVls3t0owVHxgUVztX9dLY3+booV8oSNPfaGGsBGSDsQElUDfItrfz3VKdX
 Fw5iFNkpe97SOvVrb7LdLYZjkZ7iTx6B38TNd1+MsUEeX8v+odLJJInEwN2HfFe9
 /ndxXAyx8hkUh+DpFIEzUL4zCEjnSVgI+BGfHUj7jZ27K2E+7Hf3mNZzXw0ocjsV
 HxUFqZW/Oel3mxNw4PLWQ==
X-ME-Sender: <xms:U9Qnaht150K4yti9LRFRtFfL37ltlwezQvZFzfnjRcPWlaiUqPVHow>
 <xme:U9QnajZ4o9L0_srvhNDIhVpSDEpTpQ8dXzo5uRPUTOt3gJDuljeTRb84GGN6NoI0W
 VWZmNyNRM3e_-x_VWREsGZCIoAZqgbq-clgReQ8hRxZLa-9RRn_5g>
X-ME-Received: <xmr:U9QnagX7m4mI-8kHpv3B3DSDWldbmBi1D5F99acBQwAhqnSKmI5LiItUQir3Reqgnmb_gt2pZ2nnpi69SgTyKkBSOA>
X-ME-Proxy-Cause: dmFkZTEUawKGoxwqa73j5hD1JWpv7tYUOEPQ3AArKBjDXd6zFbo7fKl+9WtvT7IEam3NAY
 cQqvF1apQfuij0Rx13nCBGTRsY6vV/qb8xm6dqhF8bS6UhRmG/G1Poy8JqpRMlN5/04w5T
 HjXxAs/cb0EPpniwtspXONrPgyY+vYuJJcm3EXinjR1i2yqnkmJ2xtUaADep8bb5zSgauO
 dem1/1UIqwB0z1rbLzLzD/B3CDdbbKov810LW3JtZ/91tlfAl2/6xPqVP6MWjuGv2yBDdN
 /sH7kz1w2UDa31gRky03FiU+gJOItpRibFuaw5HXY3k8TA/7OAEqWHHC9cy/Hx4PIDx4pN
 FMz4rZxwMRsqVA3bcx/U+n1VoAuZQO0Dt25EtGO70+gYhPvOZIzJ89Wn/g6zetgv+i6S9d
 dMRhzUHDCVY8L3+2dur53W0Rf5BfsjavXv9oJ94tOXyT9MlGtJ7W6bmhFkiEat5qCXKFLG
 xdqNPVG13M9yimVHxAfym8CTp9DFksDRfAI0VNuoYy1yMrNT6nXE/duW0tWmLNF8FkZT/d
 jLD8hVVkKdegbGwYNc+2O5xMZLvRTMxRbrQ42v9ztakUjM7w2L4XBWgGBu1gS9msrFup8G
 7c8O/IkvGbM0l7SMlDSspty6PARNKzYsdmZ1tk6rp4QCJcwgKWemCeIk6TVw
X-ME-Proxy: <xmx:U9QnaoSg_XAQlSwCERZM_OKOSumpww7oEnFkoEq-y8gSKZYyiCvXaA>
 <xmx:U9QnauNKp7Sqf3VqN8lTIZzCmFDblmRhLrg8YZ9PBgqtNxbuHHCdNw>
 <xmx:U9QnamREtP8e_kpvbTCWpeybBlGYRb_rE5G2dvj14OQFo5WDSUXZ1A>
 <xmx:U9QnasjF2P8jEFXiTP67RZ1YFKhi2I2dWJDAs2xOCctBoWBTNj7ZwA>
 <xmx:VNQnamvIufjb7vy9K1WrVw7mMjlniFTqUxYH2TGtTdWUCEYdkXRBcukY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:52:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com
Subject: Re: [PATCH v8 2/4] examples/ptp_tap_relay_sw: add PTP software
 transparent clock relay
Date: Tue, 09 Jun 2026 10:52:33 +0200
Message-ID: <FtOw8lUNTi2iReVfgCFy-Q@monjalon.net>
In-Reply-To: <20260509232551.2844201-3-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-3-rajesh3.kumar@intel.com>
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

10/05/2026 01:25, Rajesh Kumar:
> Add a new example application demonstrating a software PTP Transparent
> Clock relay between a DPDK-bound physical NIC and a Linux kernel TAP
> virtual interface.
[...]
>  doc/guides/sample_app_ug/index.rst            |   1 +
>  doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 +++++++++
>  examples/ptp_tap_relay_sw/Makefile            |  41 ++
>  examples/ptp_tap_relay_sw/meson.build         |  13 +
>  examples/ptp_tap_relay_sw/ptp_parse.h         | 211 +++++++++
>  examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 432 ++++++++++++++++++
>  6 files changed, 910 insertions(+)

You didn't update the file MAINTAINERS.
I assume you will be the maintainer for this new example?
I will update when merging.


