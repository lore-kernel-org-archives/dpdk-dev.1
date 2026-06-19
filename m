Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E66CD98E6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 07:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C8C4027F;
	Fri, 19 Jun 2026 09:30:13 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 8D657400EF
 for <dev@dpdk.org>; Fri, 19 Jun 2026 09:30:12 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 940F27A0187;
 Fri, 19 Jun 2026 03:30:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 03:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781854210;
 x=1781940610; bh=u22f7t+SHuMYIAjr4C6PFoli/UCGMqFKLKki4r/R+eQ=; b=
 N6Q4k9Sc9MqvU5LhTYj06a3gP++pbopFSUacGz27MvQ4vdoZ5rDFBUK86yZAgS1+
 4ROfuWO0vr2F5CAYHRi8QSebn4HrVwfDGcdYQ7CZFwo1brBVaAwmXeLrL8gVLy0z
 oRmASaS1kaRgZ0VYcG3TghGTeYZXM9xiiCrWNJyLQkATGC6upT74TdgoL2HVzwwO
 HkEdfppOvl3hY/nIHS6m/SAAY+ARiiNaD1S//NWXxh9jv4O1/c7+fladlbDjWNgs
 HxzWm7A+BS20fhWN411ls08fViRaWRUv+cXmAm4ainuAwgMVpIsceGYSRsdqoQWs
 MBIRndrWmYcW5k489I+OzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781854210; x=
 1781940610; bh=u22f7t+SHuMYIAjr4C6PFoli/UCGMqFKLKki4r/R+eQ=; b=Y
 1il2AL/ao/0lSQeug+AsqQBAxLdjVrxiCn+RjIpNaCNvR1i7TS6h0UuMbzvdCbOI
 +R+BHRGfLdLSjltI9KrWgrGgq+Np7EJgLZUlnxApu5D+decDJVaaFtnENFMC+lk5
 8DE1p01Ju9LBwJCEkKo7AF38R21KLsI2aClQZyx2q9sgL8xQH+rCaJgltYarnCEO
 rzkzcUD+sTo0qZnDs1+L0S2kCeL7qQnnqgptQvbHflwYx3OWYczBdxsIOrWoveFf
 XKxtOJS7bmZNlVY8Uz7NkADCFLIqopzLog662Fw5hv4Q+VYOqeJegTI5uB1OEU5N
 FLQpQ+ujIcymcMFEoObCw==
X-ME-Sender: <xms:AvA0akBDv_IGLkZKMqQD03nakeOiLHGkGKI4bpcAgMV9L-ddNvFYBA>
 <xme:AvA0aq0Nc06o6NWpWrOE5Qk9EUBQAqPj1AIf2UH5LNFg8KSGNPSYRKZHcFO7DMi0S
 PY4IVtRC__rc6BminJULWObO5FjhEvdRFxIBtiq9iF25kQ_7Z5n9q0>
X-ME-Received: <xmr:AvA0amvzVkJSkg9vsNgFkaSQVzWtb9aLKfc33KZ_QhWsUKGg57fyEasybhSDUpd10nGmAA2BHdg0X3ZZEgmf9XBr6w>
X-ME-Proxy-Cause: dmFkZTEGE+YiwON8glP9sYJJlD12dJ1edc5MXaNx64A6PvoPDqm7S0kbLlFx4OF1UKpDyk
 q8aR7f/vHj6fcrmXsEZws7gTqM/cfe1zPkkbStQrE7NTuT2gKbP4iDUbH40+L8/7g7AXKS
 7i/0VXda1QNB/TXyFKHx+YWfOpiAPlUhAPLTqw/FNGf02Jj1E4OPzy70Ps3novrRj2bjLH
 1M7fq0+RFZL0r6FHPKDokXz1zVCvzZSFPWDQ+3FIomLgyQ+mrC46G3kpLnk/+eFaWhG1cs
 kc65hp4w3BpERGc7+iDiXkTfD6uQCZpkj5BYVA8hmdTXMxnXWqN6vUt1hXh1JsShrQFTmu
 HPmw/Cl+sUN0BE5am9oawdQL2DVX1EI7fQTC/ts1IZiPSKAAwlQY5eLJf6ebx6euKbV7HF
 u4juIpPsERYJPuZn1r0SVdxCvZmVShevoE7A5Vx+oa46cZAShzy+woheJWzP1LA8Ow3S7P
 BUCtRQFnCAdeQf3TBmMEptOdFe9107+Lbu8vqBU+HJsBFvpuZnkqgEpNyLJhL9u3W5wWOy
 uTVLuAYFyAl/zNnlZnNraMswQwaBzPDd8M2581e1Q1t2SlS2ifDvheFdjdhdp+5lyGc4FC
 Bd6nO/mqiKQWgqO+JuyhtnU4jej/NYgCYP4VCT07LMRWyEmWbdRvbrWlVItA
X-ME-Proxy: <xmx:AvA0ai6-LUDoMeGRbehfeKxojSBVylFeCaqvrfsajLXK86xy8zMPyw>
 <xmx:AvA0avJVPdfQFYyfGmF2Jw13b_XqT9v9EoJyoaDJSbomg8rUL_uWaA>
 <xmx:AvA0aq6HN8DxufKNxedCa6_j2i6OilNCZ8mTjpRj3-C8H4w8AvZyJg>
 <xmx:AvA0aqyUVB4DdUk60kBRLtOcNEst4hJ7eXT9PnTWM_A-Wiz-9Vvd1w>
 <xmx:AvA0aqO2rJaeaVkzYNNxm5OrCfFLqKv_na6IrSoEnOakJNeZFmLqyN8z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 03:30:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: Re: [PATCH] examples/ptp_tap_relay_sw: forbid shadowed variables
Date: Fri, 19 Jun 2026 09:30:07 +0200
Message-ID: <ThFRyEjjSHK6mmXj3Zn1hA@monjalon.net>
In-Reply-To: <20260618130554.616501bd@phoenix.local>
References: <20260618142526.191340-1-thomas@monjalon.net>
 <20260618130554.616501bd@phoenix.local>
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

18/06/2026 22:05, Stephen Hemminger:
> On Thu, 18 Jun 2026 16:25:26 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > By removing the compilation flag no_shadow_cflag,
> > it becomes forbidden to shadow a variable.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> 
> Thanks, example did not exist when the first pass was done.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



