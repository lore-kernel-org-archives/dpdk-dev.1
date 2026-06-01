Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD146CD6E60
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A684B4025F;
	Mon,  1 Jun 2026 12:08:24 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 2360C4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:08:23 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8C6807A010F;
 Mon,  1 Jun 2026 06:08:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 06:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780308501;
 x=1780394901; bh=eVO3WtomUq0MzPKp0ApQyDwto+aITtLPdq8pc8QINlQ=; b=
 ng5dHI0u2CS5JtMRH4ihCg3vrrKjeqFo7XPMTAlsDCqseaJhXso/rGBmXwvmK3cN
 j/iMS5cmktGmhKj0nWoFq4qfLEQQkDrqTWHQ065Ee6q1cQ1avumf/cZtPQLv+swf
 A3TQgEeuu1YQ/YyNmHXvdq50RoeZ48w2U/pMn0U8bNX2PcD4SugWXQCaOHMXRE9V
 bJrICuqj23FABIdeBZijv3e04Peq0J8WPcGZIYQXaPd60bkG7+I2An0ud4eAUlE1
 oNb+R2FlsMDnEqDUMVoDFVND7WNS1g8UoCdsV7USLD5oCNTP7XPY23CIEZz5W6LW
 TH47FSNS7edcLgG2yEKmjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780308501; x=
 1780394901; bh=eVO3WtomUq0MzPKp0ApQyDwto+aITtLPdq8pc8QINlQ=; b=d
 SVSbmj83BxKDSwdHW+ghmvZNlno/XlZRJVLJViy6S9IT0/L+KpecBAQNvpy5R+AP
 R1pa2GXrmcDYgCmy/2piPRhM4nAaPZFresNzRc4ix8Bz1swTlInfZVvulQcRMBUm
 n+dniYDsISXEzBmH2ISuFGwbMUOadRCv3/vao3o0UJe61wVPT37neFERm+5M4eV+
 avNo3aj59RCu/5n0NRdv/Uj8XcKMsk1gG6mXmZjFhQqF0Wx18OefJzD5Sl22Viln
 0ZtsZ3kRdcw7fSuLYWAZg9JuvLMFKVYktO2BnIeXVXYaaJMN/fUMxVQfGvQ3aD8K
 jblwpwy/b8B9ei2fkrt9g==
X-ME-Sender: <xms:FFodajOXsiXnPluxUbL6jwIV5IUvQcAHLhFCihdaG0v6RjEhZONyDA>
 <xme:FFodaoCSM3DOvlh0jYhu6LhaORV7QoEmvjCCyix1kbpNKfv43cNMsQ9-mn-qo61zw
 FjCqTErAkKa0Q905Kzgh1_sxBLdt7AqU61wDCU_fQOK9IpoEMH6>
X-ME-Received: <xmr:FFodaiK8bp05ekyg_NosjN505HVoIsDUoxM-lK9mWsbtFCGbDC9_LDzDAMMSTS_CJxxZQOKWEpzgJAvEgwHDQUWSpA>
X-ME-Proxy-Cause: dmFkZTEVwkDu2KzBGnFyP9e+UyKPLL3QBtZxKOCeC3LAWEs9b0PFUuzWvSfaBb4yBYnXLN
 lSQ9FAaU/MufKuYAy4bugNFfVz2UX31bTTsIxy3/pC8thrky+mnkJSVPgVP/nlF5uZs1hM
 F98Cx/r+Zz2cQ+nphBhiISut+VjspzBtxOodxJ6zFImBh5f4Z0E2vvdixK2VkkLR0Kbc7p
 GXqS3Xbf6agym1io4wQHRQEeAwqnybj+8Yik41GipKQAwuZJ/BbHMboOeKnq96VLlihfDj
 nRHNdgACqIwS7PD1eu8o/DvPYmpSdYgW4+w7e3eibsEIU6wIelJNphfXmKeYZIezTHb6KY
 HjF/OkictlUQ1yQNO19FtT7JH5FSHOxgOyal4A8ZOlA7rGuNjMX0kw+vNPbWDwHR1vQ53J
 HAxow27ls25WcKrk4tDpyqTWk4KFft2j36ecTjwNs/0Y8YFKB78f8YLIksW7aYmT05P9fV
 u809I/IsRmkmQWS92BqWefhSiLYM3QuK5nUD30anj8yOe1/objErz9QofUmPpGadH8PgtO
 Dn9a/ChKJAF6O7DLffsIbSQRuMp6nmFIjR0SPWPbHJC0G/MRBNUgskOrGfNkdAeWyCikJV
 wris7h6I5pa+JcqE8imAFHswpzb4xfOA8tUmxEDAnIE/SFOHDDL+juVHJZ0w
X-ME-Proxy: <xmx:FFodapOh7f500qMTcw1-SqCZ7eeB7jajn673V37XzvQX8eEC5AKKAA>
 <xmx:FFodao6baAvHvwmi2FGTiyBuPFQh_Y5Sqs9W0m0Amy2dILleZWz-9A>
 <xmx:FFodaj7tHNd9HxLcBlR9Qjog_SrSU35mSXIaOojz8t_kqyqk9_zfBw>
 <xmx:FFodauFF3TVtZT1UPBr7L7gCecNjTiMEuvX5RPiPqc_YSCP5fSqvnw>
 <xmx:FVodaloURmmxnJvLSlV0PjWfIlXyDPGXz_abgs0UPX5zUWj2xvH6nenH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 06:08:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 dev@dpdk.org, david.marchand@redhat.com, ndabilpuram@marvell.com,
 mb@smartsharesystems.com
Subject: Re: [PATCH v2 3/5] trace: add PMU
Date: Mon, 01 Jun 2026 12:08:18 +0200
Message-ID: <e8qx6-ahRfCal3FuA9qU2g@monjalon.net>
In-Reply-To: <20260505053023.3854665-3-rkudurumalla@marvell.com>
References: <20251024054830.933910-8-tduszynski@marvell.com>
 <20260505053023.3854665-1-rkudurumalla@marvell.com>
 <20260505053023.3854665-3-rkudurumalla@marvell.com>
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

Hello,

This series is failing in the CI tests.

Are you working on a new version?


05/05/2026 07:30, rkudurumalla:
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> 
> In order to profile app, one needs to store significant amount of samples
> somewhere for an analysis later on.
> Since trace library supports storing data in a CTF format,
> lets take advantage of that and add a dedicated PMU tracepoint.
> 
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>




