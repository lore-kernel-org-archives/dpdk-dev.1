Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9086C982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E4E42F03;
	Wed, 16 Sep 2026 17:42:56 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 3201E4028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:42:55 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D59DD14000FA;
 Wed, 16 Sep 2026 11:42:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 11:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573374;
 x=1789659774; bh=cBK63Lq/MMITGitzIin+lt12tj6X7D+sblx4qTvodbQ=; b=
 SGeqGJDjIbbJx4ih5eTDcjTA1tlTLa/XCGqgBwoXBX64rG4reOB52ZkDFyDVSiR1
 xMs9CJaKJLyTOkcPEFQWHd1NiCvMLY3R12+V+qOSWmUb1CXkKGl7PsfKnXlxNSci
 WV60QUFGnlDVuWIx2EehPE2fw6qa34Uxp46mY0Dq2Qr/EBoqcIezPCQt9+9wlMIL
 N+SPWfnzYGOh5KPgk5cR+xwKdOjKz3Dr2UXhJI3fiwIEU62no0ep7Mh3G1L7oUCB
 +5nCgt0gAcxBoYiB9Ay/m+aFlkUgWDHj4KOILo78b4SCLTOyV3Kti7KHC8q+Ched
 D3n6ni9U1z+e16HgtVRlBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573374; x=
 1789659774; bh=cBK63Lq/MMITGitzIin+lt12tj6X7D+sblx4qTvodbQ=; b=H
 JmGrgVvUBxIt2Fn/UhyeJmWf3wEgrtr24xCf1K8FpdUz0MMKfloUeAdGkXDlh3WG
 nTaCHmKWu+se8Rlq9ys0Ef9Y2ypQhSPwbE150kznYocWhW+h9CEP1L/0vxTdc7AP
 wuMCkerN/GPOjn5nm8iYAXH4+g1a6rWn54zkL8gmpJ1szAysr2tCGFd2ZBydb9E5
 Wc31K3TGu4VAXzKulPfnXqRqMal0FjCqTpWHoviKT+TLiFHAR7cVg89DXjQpPSdy
 6JEsB2tjrmFBCWZUX4hciQB9cmhlgVGCsdkwgfb7v12jgeolhS+ggtVfMQnPnnaF
 N/mP9ZNp7TTgobUITfrwA==
X-ME-Sender: <xms:_riqalRwDeuT5jQB0aLm0jg1yEBb5ir6r6LdDIUUkRqGVGW3Ir_MtQ>
 <xme:_riqarE4v072f6ojbMvCpxVrgiPEo_NU_85eL21yKKqaEOX6pbqY4Xfg-5T_r6HVT
 xXdpmNdfg_yexWxmEn_2sDvIAVDqmaV7hOMB2icVGnWM3JgWv3wT-Y>
X-ME-Received: <xmr:_riqatkyhSTDnXI8cQcpdCgYuVvCsrh89mdA21jBjct8xvaMkgEeBrdeEPqmiUnzN3Eu1f-ueXKQx028AqFa1d8>
X-ME-Proxy-Cause: dmFkZTGaouHgaVmGIkBnpWaUvvI0oTr1PWoq/uLMDO+NCKbqOW6OL/OeunYNRxZUxG83Pu
 Sx2Grpdk3ybLL0ns6HYGHu3Sv0LFJzbUDQyTSnitLiAduztBsZPgvbdcL/Jjwvd0O0paej
 MjQy8YyQ6ppvxOTeag+bPhOb237uKzWpKTWCOaPrpZoVmgUSb9K5J2sB7zGmMgZ9j+8vYk
 xSTm89PvSk5y+UXYK85PhhpDwqv8G/rseCv7nPJ5KMD9/qR5hZTaIza26jXryl8lgGoIWX
 T9v91sRobJvlOrVVsNY7jWZqv9CAG4yEmBRjFrZMun70dy0k3BJ5Xg2kibia4vt2MPdXTT
 V/X4BrsYHSkuAeN81DzDTRsVuVOgeVdOQTGKzD39q0RqZ7FqSltW4HQ/syF77Vew6SAv8z
 2vIwQdBx2ZOyCk3mavfKyFcQP5fOeYpNpMhMe4HeBRMW30Z/s9UL44dL4lUZkmQB5g8pYR
 iwX9znSdnE5wVWAW+qMz2GvELYYijQB26HnYCBndN+P+2n2hurpWY2qPt88OWcAWjqtyoZ
 jO/Zx+E6eBWD4DmymJj3YSdGIaUX3MtQ8O1J5OQQr8ilNQe/evOY+l+fTpBzFcT5/DtqNg
 u91Fyb1iAGqlMo17+kdPvPr4aMGMGpmReQrhn4Wa0p8fPI7dfg1b/WXeWTJg
X-ME-Proxy: <xmx:_riqau07BR_N2osPN5efiVSRbsK_jADqBahrVfULHkEEVaFh_sxtMA>
 <xmx:_riqahRo1uH808X471jFVCs3-cVOPPVb0R4nJ6kCS7HzTp_Oq6Dd8A>
 <xmx:_riqaouRFjyEe5FE8pXipZBDPDdstIz2au1d1Fhh8IJ0mTblo8RlvA>
 <xmx:_riqauZXSXynfltDRjtxxWge2dsPHIRCNu5ycWxugf8uzuFEHNxpZA>
 <xmx:_riqarSeRGuOx6lz7ujhrq-klnoAB3v8STBIl7hI5VIjZxAy6xvZgLYY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:42:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] MAINTAINERS: update for NFP drivers
Date: Wed, 16 Sep 2026 17:42:52 +0200
Message-ID: <5b4t-tavSNqwydLzLyjQwg@monjalon.net>
In-Reply-To: <20260813220631.41472-1-stephen@networkplumber.org>
References: <20260813220631.41472-1-stephen@networkplumber.org>
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

14/08/2026 00:06, Stephen Hemminger:
> Mail to chaoyong.he@corigine.com now bounces with
> "Address not found" error.
> 
> No other maintainer listed, so this leaves these drivers as
> unmaintained.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

You already sent a patch for this.



