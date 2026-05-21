Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A50CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB69E402A2;
	Thu, 21 May 2026 17:16:18 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 2CF96400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:16:18 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BDBF8140002A;
 Thu, 21 May 2026 11:16:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 11:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779376577;
 x=1779462977; bh=O53uOqGaezycXDoPhX1UV7Ny9qEo2UtgWT16GyBv0h0=; b=
 s4IlnIx4J5mDubPGscQCyzYFA2jXjCCNgIh86YxAJI5HWls5OzCxxKMyMWlO9xE9
 GR8MADPALqWavk+2zEO740ltBtfcOlrOca465P+usMnyauS32PPFqLali565OCCY
 EUJijYxmYS0cFIkkUNB8fbZdl3XS8coMcSN72DslT4u2/ULh7dCIsCTqfb8Ofx2Q
 abZ+1eVrtHJUwmH9xMXQINOVPw5QI2IxF3q4sX2C8vpUj5bRLMzB9OA+aClrxWWQ
 +8AP5r/hf5g3EcTlVwiBlICLmlhoQXa5CGBAXtsi5oQZtDdiu2QoUlwDsWdGChJe
 i4D0QcpYXY7KA9jczSoFzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779376577; x=
 1779462977; bh=O53uOqGaezycXDoPhX1UV7Ny9qEo2UtgWT16GyBv0h0=; b=o
 MjVYZG5bMn+K9uARTRP5xqWaB9KJd2CFWEqjxCFpwANHr/MWiBjSrjif51OuShDg
 /1URKFrY6E6R20V3+gX4gU61/9wdWYBOBdw04uuCtRYXrdORf+jY3EvdgocDGClh
 WQgjG188Wr4HYQ+3MB0dhLSinON9Qno9W0Jha5iN2eJ+q/Gc3xDs4y0hOhsz6QJI
 QV064RwM1lS0Hr9LXVNeaOMMtAd0jVtIZ5jemBmkuIjEFVmBRQ/2Zp+2v28aPQpY
 KCEUXy48dai2/UiWLGaQOyzqwgnAZvKH5V0y6QKDTO2OcAvLkaf7+yZcU5pwh2me
 Opt5LYFQRNl9qr1ApXg+A==
X-ME-Sender: <xms:wCEPat6KAWtrMdWhFL9CeM3ANgtH1WzNzt5XD8DM4pNpwLlq3Tig4g>
 <xme:wCEPavN_qxhdiLSaaeQeMJS8W1almxkUO4_6064VcKOfBUOB0NV8aaZKjo_DJz8nP
 -Tg8llqyXeXycYJviyjHW_DPxUeQH7BSjU6orB0WbCjVNLH5MzW7w>
X-ME-Received: <xmr:wCEPajl_kh9y33cDRsN4VEaiHtXWCGUgo29Zl4b063uGdmx3zi4UdxBEbtZo4f8rjUyxGsmHBRwB6nz9W5StxltJ-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhujhhivgehsehlihhnkhgurghtrg
 htvggthhhnohhlohhghidrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfiho
 rhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:wCEPauRYC3iEyySYQcYNdoQwcsMeR1Rn6Qeo-k4IzeanTKzV3F1mlA>
 <xmx:wCEPanC5Xy1wN0PknoOABkFNVebAnYe7ax7OgZrf4vIJGaniMD5H1g>
 <xmx:wCEPalQYZ04HlQwWMkn9i14CxadQrt6aHWVjwBwIDbF98o-PJT_RkA>
 <xmx:wCEPalpPkrFrXOaIbQ46ekJWlCtYOHWVb92Ckbyh2MXV3zPIi4MBMA>
 <xmx:wSEPainbnB5z4tRBt2ocKTnXKYBQ-uvD8YhJc2TkrznK4p8N9qS-Ruv3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 11:16:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address feedback
Date: Thu, 21 May 2026 17:16:13 +0200
Message-ID: <9XBXAO5XSSSHFRFv8zy4yQ@monjalon.net>
In-Reply-To: <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
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

20/05/2026 04:17, liujie5@linkdatatechnology.com:
>   common/sxe2: add sxe2 basic structures

Are you planning to add a crypto or compress driver?
This is usually the reason to have a common library.
If you don't intend to share some code between different driver,
then you should not have a common library.


