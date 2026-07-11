Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6876C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 06:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8597402AB;
	Sat, 11 Jul 2026 08:47:18 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 421D94027F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 08:47:17 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B1C0D14000DE;
 Sat, 11 Jul 2026 02:47:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sat, 11 Jul 2026 02:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783752436;
 x=1783838836; bh=Wob+hibgnl5E79PVqEPaENt1RVGIKNNn5jb24tC4NPo=; b=
 gDT60xnOOhMBFhphxCtdOudTMKMSxZnHaQAkQz+zqOrIna+o3A0aweqmpHPpz+/r
 xdA/Om9kLwbW4Qg9+PIu3On8NXGLcsgwG/MKRmOKWz5qPSaQF4jmsYWWG9RFMlYm
 uNJoQrl68+5PZ9sKhV9L5w0kguaI3mnS2Ihby2nZKg94mfHEaOUpXq1R77jI7xTX
 jxQD0RpnG3aFXVQCfIHf4TsKkkIywDtaw6Ax3tvmYWUcgR+jThgyuOVXPw6evA2C
 32LRrM3yRsxHWtB2TjruT6dBTIpBLA881vZVPK0sm2i2CyIuDJU+vj2aov3E89Z+
 OMHY0FugheX7eCS0txzikQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783752436; x=
 1783838836; bh=Wob+hibgnl5E79PVqEPaENt1RVGIKNNn5jb24tC4NPo=; b=K
 YlAztbS5/tKJOqrF/UqIE+ytlX3rhUVmRxhzMzVFcWp7bkyR5A/XG/ZvRdAj4vtL
 fZESd7iCLsJSRO+9/KMpwhgoILWZx9CmzI044yQoDpKR2JH+MGp/fhYPrQPmZm1O
 BclyyTXO+ZG2NKR/AnaX8yCGfuKYsOSIgN8plg0rniE1qrbepor82wpOoHhMxk2Z
 XD8ubx8daHSRziab+Ym+B2XgpFk2MM7s4pC/2gDkvoZt9sAVC71dGr0IZoTqu87N
 eUGNv6gSm4hVthVTfkEqU8yj8ids7+40LeLT5x5MyFSp8elAozOI0VIlptEEjqlX
 tujXpjnr8nzVMUGSsx8Hg==
X-ME-Sender: <xms:9OZRanvASY7NESXBz-tS5tD-2aws7vKMbK2w-49emfsakk13ibQiGA>
 <xme:9OZRaon3Sv6uVxjaT7fxxmF1JYXBk8lxONK3E_xuYmDoHQknaSfq4mX_-RkIjIc7b
 8M6YqKCVymSitpveVETFNkWEX5FWn1xGLs_miDMeKJw2s8e8byeNK8>
X-ME-Received: <xmr:9OZRaiuFbw5JOKPq8PgSiF1kD2H9mzaR-znIh8N2_5hA4nwdiBZA1orcScXfYX2aNiWHLp0tdo4bwD4RoGcZDXKEMw>
X-ME-Proxy-Cause: dmFkZTGIYQoLaSiAYswVIhxiqFShUe4KFUR8mchrasmEE9VNnzgR54IG0GZmceK0SuWCi5
 YaxklFToz7T5UIOEtiGdf5tHjWmySJKNX2UarPhSKh1hbI3D8ggD8eAy5Wh44CAkIBH14E
 JgEaqGEQD/4aGZYGMy46WFBfTR19LrO/cLXLGJCXyLYESiRgRXVEQKCxVIH92s9XBTmutO
 J5oRzHRArr3zi9UTLU1g5n4nXyrDmepQtjV+Rxl6cy0hwgTayQItwObx7A0/Ba7+BVoVx3
 dPUn+IFxFSgW4S4FosTU7XWfxCmarg69EHtF24MMnZxk1/zYqQ5UqBNk+dnNGhn6V4WtmN
 3qBm3KOS8UHef+1Yu/RqQAXuwQvFGraT89haNlTnmKLCf5nePkJ7c1gyNwovEG2JrZGGwF
 rrfhEl0TdLa8xru911U9BWzeRvGzJIZVmsPLGzAY53EapZKXc++w2r5y7u1mpgTaDlVtxr
 KZfbRJ4DRYAZDdJoMXfCFJfcMRiB2nC9Ja5F8wiSvzuyeriM48MeKDS5xqQxqdMti/q2lA
 m7TFZZeElkHwg5Pfm+JSPsbLJlHhjhReof4H8BDj8RAfk7qo70goIl/LUiqj7dWHrZqTQH
 esxdA0Q6ert/QUuiiBsfGbHAH4UqBAvfWN2bSNoINPxjyluucKhtB4CfGZeg
X-ME-Proxy: <xmx:9OZRaucV88c1RBQ4k2An-uftnWa43Rzwqs9vQ4mGGtwPPuBEohcObA>
 <xmx:9OZRaizrC3mTEWUiwseSl1sMGU85A4fzGgYQSUOuQSEl2ktU7CcSZQ>
 <xmx:9OZRasG3DA36TofUtXwwhIUVJKWeqElrPGsG6YGhenpCvVVJ_eNb8w>
 <xmx:9OZRauzYrmyjuZ4ckcQUdGm4YcvqdjdsFfaS_c5ApUjoOQ8oPWQLHQ>
 <xmx:9OZRao2-3NzH18sWms4EacfPEcJDosReRmnU60D-Qv7l8H6OISpaRwlx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 02:47:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v4 0/6] net/dpaa2: NAPI-style Rx queue interrupts
Date: Sat, 11 Jul 2026 08:47:13 +0200
Message-ID: <OKaNvhYTQrmsY6M08GMeDw@monjalon.net>
In-Reply-To: <20260710210920.2402309-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
 <20260710210920.2402309-1-maxime@leroys.fr>
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

> Maxime Leroy (6):
>   net/dpaa2: fix Rx queue count for primary process
>   bus/fslmc: move DPCON management from event driver to bus
>   bus/fslmc/dpio: make the portal DQRI epoll optional
>   bus/fslmc/mc: implement DPCON set notification
>   net/dpaa2: support Rx queue interrupts
>   net/dpaa2: pin Rx queue interrupt to the polling core

Applied, thanks.


