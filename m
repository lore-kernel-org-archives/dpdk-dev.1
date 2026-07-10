Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E192C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CA0F4027F;
	Sat, 11 Jul 2026 00:22:58 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 2A7E340270
 for <dev@dpdk.org>; Sat, 11 Jul 2026 00:22:57 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 7B1321D000D4;
 Fri, 10 Jul 2026 18:22:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 18:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783722176;
 x=1783808576; bh=1Agu0dy4bMkRRPSZmSYCs83PVEF2d2+yxgJxDWgUtZs=; b=
 hQaNX/T7MpkIZo6ss3/LE0S9My8GmT+5iQNC4G+IcDTLDxzS6vFoowiCdy7TtInO
 BHd3g444wLTw9vXHm5K6D5ZTX9fFPImlQRxI7wxYFi4xEfdVdfSxAzRw3PYjJxFQ
 /axK6/DvMcURpIxdT27ofrX7p5ZFLL/SjVmiQD1QRYH/DqqcXEbhSU4kZ7DNoeQj
 qy/RLuUhDXLeTSpWbhf/7eFT9ehONtAHb7bGAtOmggfC1uwtCtkQETs+Q1/BeD/J
 ei8vyffzZDqDzBk2WZ1CdQo2IG0r6Fubs70YWDaxGQEcy+fOsHTO+RIgYHhf64qE
 fgGSPwr+WtwkDC5hKd5P9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783722176; x=
 1783808576; bh=1Agu0dy4bMkRRPSZmSYCs83PVEF2d2+yxgJxDWgUtZs=; b=N
 kSxR4Sc2ZOVPCUiWiCLZt6eDjQmBrHQojgxVkQn2EABKEb8mGSU5ClHG0HsHBn2Y
 xAkC8jBsKWBaHzY7lQYXkjREqDfprbiLccqXqKDZL1XZYmkb7K71BGPxEtJG86hx
 A3ihrdg8oH+fZkPArG8hsypPbk4+UY8Du/HyTa6ntKeB8xRRufpZKj4WRL9qiT0m
 sOoxwi/SF0fc7Q7AjEBGHDRxXJv5IIT0d/Sh8usI0u+W8XGto0eaq5UQizbhcQR6
 Q3CBNpJpYWxsDQ4z3L6x16if13KkUDp3nmoBnNl/+gSE+NaTF71Cjys0pI5xIXkw
 5INpMXWH4X/N9+eJ1Djaw==
X-ME-Sender: <xms:wHBRatZtjTUHOrtcFeQqYBf3vaFFtH_h8a2yIG-JcsaSbDRuwDmC2Q>
 <xme:wHBRaovzxVDnDzL3ps34CYDgZ40-Z1r36sEnCkilfzm1CJ0dPFMyIGiAKEOSCyqiD
 MlVA6ql67pwXNq75i6J7IDN7Pz1Ku0_P0DddTus3PxAA46NdS2npM8>
X-ME-Received: <xmr:wHBRavFG0CY3nXIjtv_RcujGoFJYORj9XzEVRvKk52c1poquZGSzhvJiXcNm0RZO_eqOOFeGGDVBt5giEXyD6BObCw>
X-ME-Proxy-Cause: dmFkZTE7UW/EabxKG1eeoUkb84Z+trN0P6uwsBJkGwcUXutbat6c/jsuSAjCIQGkTkurq5
 k5WELzdH3mjQ5+h8fMqm23nNkswa4qkGogQkhL6a9B7KsEl7cBOJD1dyhD+SFoN2PUnrWB
 EkNRw2Ezu3EXenlql6p8Xm30nUlK0gxsFBKnMNIJgP8uYYfFPjTvzxeG7rLe24kfSI6vj9
 COp54OixR0BNU6DkUi6pSW+XxfKz9BvlA2J/pCnCRK+Ogs1GEOJ29Uo0zo3Qbp+rZqr/oF
 pL8Jzu2iI0MIW2JbhCvWOZbQ0/RAr9DSYBCOx8aE+WDEB13k1Utcvqb8ifmMXljFS7s4Jb
 DIHedO6yFCB9qZZN5ASi70kyQ3cGL6UjZ6xChWE4BmFpGjL0ujCt+TVZroHqJaPfhZ0Ekj
 gpLu8YWCZIZMKJHURq7jHQn6onQmL2VwSW6eioxQcpW4wuTwunnS4oftY5d9e5B/Lp9nD4
 VHWivYPtY7YhR+kludyzDvCpdNyFi57JTNLCV9CQ36clxTs1AqQkgXjvmkyzK/BqQ8z0SW
 smQiWcAVPwg4KcbQLAIsjFyo4xOOdhuFBLrFGS67r8yX9Goc5hrM4AjwN/2Acc2Co3haWg
 6GHLWvx/KG28RSpmVeLbbpHe+74oL3gL3+YdGtKOreSsZTHnlt5JNPbXUyVw
X-ME-Proxy: <xmx:wHBRajyyaLzqOgSSqEwNrgUcgEAJRUlCbU901uJ_HLTp42pYP92y_Q>
 <xmx:wHBRaujTg9R7hCgUWRgVlGajtTRFquQgy8IA5ZdiGCmRd8XEq9V0tA>
 <xmx:wHBRamwtLl88JSmZEeDmO24pbnDgWYahEvciCa8jifjKI3sWiIQMtA>
 <xmx:wHBRapLaafV0BsD_Dv8AyXA3jxbHOh0lEyIB01VU7rcOkN_b5QqyNQ>
 <xmx:wHBRakZuuECAVk7PEcpIA4KlT4uj-UPClSJ2P4Ebn9jn4PH-v2DVa2ZM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:22:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH] examples/flow_filtering: fix null derefs and memory leaks
Date: Sat, 11 Jul 2026 00:22:53 +0200
Message-ID: <7ak0_vY6REuy4xAALDQskg@monjalon.net>
In-Reply-To: <20260331125347.346362-1-shperetz@nvidia.com>
References: <20260331125347.346362-1-shperetz@nvidia.com>
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

31/03/2026 14:53, Shani Peretz:
> Add missing return statements after failed calloc NULL checks to
> prevent null pointer dereferences.
> 
> Free previously allocated memory on error paths to prevent
> leaked storage when a subsequent allocation fails.
> 
> Fixes: 3ebb8789136a ("examples/flow_filtering: add more snippets")
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Applied, thanks.



