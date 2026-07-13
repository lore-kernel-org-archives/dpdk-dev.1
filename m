Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3DC44506
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64B254027A;
	Mon, 13 Jul 2026 11:59:20 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 8B2AA40276
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:59:19 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id ECB21EC01E3;
 Mon, 13 Jul 2026 05:59:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 05:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783936758;
 x=1784023158; bh=LZErjy2Wrrwxee5IhJpMo4M8C4gea8Ja9gTyJx7F6H0=; b=
 OqWK0zOTHFRLuzpLfDCel7Q/FyA+Rpwep5ItmPBXBv7vkosqzAKYD4Kl6qXdwrSj
 jkyDX3MoZnOitPXtZ/pbKRf42oNVUGEueHsnNngZKISj1eI1wLkzD1AXUFEq0F0s
 YNEBtTnY74a4gX/6SWVZUEVxAxn5eLlB9Zs/VYZRbktb4Jqxl8yVvFMsWmf8eLUI
 LPAxbw9NQNB1T/cqB/GhBPVB+yJ6+DebT70t7FFjOZ4Efvm6w5c9WfKiSJqapUZN
 bnp5uYpLwMiopgFimgBcvUgRde4lC/3uNk4daN4eceGX+rnEsecnsbExgw24PLrf
 6G4SrerzX+3PD6uGHhJwrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783936758; x=
 1784023158; bh=LZErjy2Wrrwxee5IhJpMo4M8C4gea8Ja9gTyJx7F6H0=; b=F
 BFA946ZXr8t48mKQGW+iU4Hk0Vee++xFHJT/BCuVY1NPIokpmxe7PIFJQnN4JI91
 kYutyucPRl2HARrLHeW/OFg1A/8L3w+f0fhQhZc6yUTvhJQl9beOP4WrWzd7tUly
 IsiExnWTmNBTuC9T1bKcpVR/Qpz0QGqJD0T1eMzYBE3ScgfbmwGtgjyxjtV9HUOp
 +weB+CFQhs0XeCP5aATZzTFUAPse2SJ9orNztagUW1dNfBc+RNOHqyq7QbBpAyxi
 b1Bqm2VgvEPMpUvz3wjtqjwhVdv32jxAZ2Nc4wld5Ba9/Q3+Uv9BXv7m/efHGz2o
 lou16x0lrfFuk1avEUUTQ==
X-ME-Sender: <xms:9rZUar5NM3sPdLnra3WiSKrJDsjCfx_79O4dcBQ06GgxkIQjswOBkA>
 <xme:9rZUahBPagY3lHqQMT3E4nA3t8dLyXqbhn9FlaH3KH9d8bnLACR2eiftTFYl0NB1C
 AFHaG1AuDY9zQlCUtSRpc66kqCHsriEb5Qul_oKFn2Pm5X3U36RHw>
X-ME-Received: <xmr:9rZUaqYT324dZbyf5Q-Ph1UNpjOvspbp_NQuE-YKUzMX9MurF43I7yLOo03y59TkMU7g6YxoMLafHisXwg>
X-ME-Proxy-Cause: dmFkZTGa1C7nMz/dr23EMe7f+ng8ibQuM14Vy6Gxhh0sjsvS4DuO247ERjqRSy/K+UMLSc
 eF1OhXaeJZdxP8LVduSeQd4krnf74U0DTLFlLRVf+Jl5C/AVwq5reN7mKH0ypG5o76NMJZ
 OTGMYsD4sh1POjSwotRPWrawqjBg5uNFXEEtMOcIypH1s8BcnpvVShtoWrH9MoB+15KUfJ
 fYYgjhYQvxDB6WFKskFnirsF/37Myx0za6502ZiucJqRne7x+q0AbMC0+hfe4vy0uUMJsm
 3K5BpaLF+6jemdS1o1FCoRUa//aFDIIrb0fKgqxDMeIJwKdZSmhYItBgiPRM79leNPrVWF
 o/tjLwegf4Hyf4rGd9cWXV7jyI6HznRo0A9Sew0445zJGMynytCfRQJdbQYhMnjJ/FTt43
 sXlPJzq3Q8SsZS/RpB0WL3U6Eii4lh77Kt6+CNTdejkjQoBefrjtb4C27XqA7CgoK0khyF
 m5VeiujNeMK6qwMq1lJzLtZwRFYseF6bpBnSdOJrDMX8hTbM8twL86Wb6/us6jJkaR6ibQ
 sgodeMEHh2kODWORfHss8Oq72His1ObBA7jW0It1C5G5YctOPuamI+bg5MFcYREs4iGMPL
 D7a8EQJuKrZaIvSWoeXKhHd3AJe31Ncfzr2+45nRgyDOSa1ZEeyZvvk1EcTw
X-ME-Proxy: <xmx:9rZUakZC2RTX8N8Tiurh4toslfAOo4kyc89YLdm1sWFAZqiWHM1lSQ>
 <xmx:9rZUap8pfkzcDcirld9IK9BT0ciGbGsDu4YJY7vwoG-Hous8TMEd4g>
 <xmx:9rZUarig0ATommP24InMIXLunxwQL92Ds0hcKh_U4zJ4mj1utTeBEQ>
 <xmx:9rZUahf0GuTbCQ2JwsLtDlUC1Ty_7TunTpHqhaIushpZbUxp5j5iyw>
 <xmx:9rZUagHsgd60a10s47675PDSpxT_9RM1zg51sVTbV9-smV6SGWwe2m6a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 05:59:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <G.Singh@nxp.com>, dev <dev@dpdk.org>
Subject: Re: DPAA driver series - mix up
Date: Mon, 13 Jul 2026 11:59:14 +0200
Message-ID: <iSawvfAuRvCNNdxNcuk17g@monjalon.net>
In-Reply-To: <PA1PR04MB10770E11CEC25E074365C3E1289FA2@PA1PR04MB10770.eurprd04.prod.outlook.com>
References: <PA1PR04MB10770E11CEC25E074365C3E1289FA2@PA1PR04MB10770.eurprd04.prod.outlook.com>
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

13/07/2026 11:27, Hemant Agrawal:
> Hi Thomas
>                 We sent two different series for DPAA/NXP code:
> 
> 
>   1.   net/dpaa: bug fixes for bus, net and fmlib drivers   https://patches.dpdk.org/project/dpdk/patch/20260619103901.2274740-2-hemant.agrawal@nxp.com/0
>      *   This was originally accepted and added to next-net by Stephen
> 
> 
> 
>   1.  DPAA bus/net/mempool/DMA driver fixes and improvements   https://patches.dpdk.org/project/dpdk/patch/20260703124950.1895871-2-hemant.agrawal@nxp.com/
>      *   You have recently commented on it, we need to make changes
> 
> I am not sure how, but I now see that the first series for fixes has been dropped.  The series is marked as superseded.

He had sent an email on June 25 explaining you need to rebase:
https://mails.dpdk.org/archives/dev/2026-June/340944.html

> I have just sent v4 for the bug fix series.
> https://patches.dpdk.org/project/dpdk/patch/20260713092616.2902828-2-hemant.agrawal@nxp.com/
> 
> Will you please consider it for merge it again to 26.07 ?

I don't want to take risks with new features and improvements in rc4.
If I understand well, you are talking about the fixes you rebased?
It's a pity you missed the request 3 weeks ago.


