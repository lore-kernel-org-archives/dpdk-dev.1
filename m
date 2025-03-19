Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED62C35FF1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 04:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45F1E402C4;
	Wed, 19 Mar 2025 05:02:50 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 7DAA14025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 05:02:49 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id A958A1140090;
 Wed, 19 Mar 2025 00:02:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 00:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742356968;
 x=1742443368; bh=RjNzaz3ddoLRKg3KEKXvJLqOujqCzQQfV5gjcHA7ris=; b=
 kwzy/HRN6+OMDRQw4YH1azKWztbwQuxzMfPpPqWX77A9w+X2UHHJhTCOaJS4uaT7
 OEdWbBAOrKE5N5PbgfGhhNLCiaubEX4wMTBWWtP9Vq50y0voSAXdjLV/O+khxErl
 1l8AC0fycPNqDY+mbGhv5bqnT93w8Hwp7t/Unc1GyE6NldCdDx+xKeKgyaiv9Qy9
 36P/BtFVoFXv9P64UPVsp2066uxV491DjEa1vbY8nehJ6BsAb7JHxDTiwSLF+9Y7
 /RAh8fD1Lq096Cuvzrsw3TN5hoPgpenrsw6xWPhqnm0XbI1zo1HzzKM5cJ75YZkW
 IIqS9Hgr4V6qnwbVExaa2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742356968; x=
 1742443368; bh=RjNzaz3ddoLRKg3KEKXvJLqOujqCzQQfV5gjcHA7ris=; b=3
 9tBUf/Oxp8/dZ43nmVZ4qBp0AhHzMcgBIQ1LnN6mnL458j3Wukt2hQ+SVk39jtyZ
 7zdLeeuQFI0+0iNoY+7rH27h7OPqZQyeNVMFzjzvjmP0wpDR9k88Ttsmtmx21fDS
 Ykfcy7U8JANoDabtQ8jSxVLET5XJSGx9y+jyAz/ayLbNQctOV/o8+sJGHKaoZWu6
 rcDy+Jhmi++/JT5xVShE4VGlT95K+gHR70oGBwf1/CE6WTfPtc9Xd6cJzaKsFZ/m
 pS5+Lmg8d3t6yKnMbgxkWQfKHyBKOaIDhbATyQdDTUlHFuxRPf+5k7tLTlPddqKP
 UZVquyWqeKU35gmIosPHw==
X-ME-Sender: <xms:6EHaZ2hpP8upeOM_ihXCDnfN1anyqtzd5jKpM6IF8P9iYD4TIYcH1g>
 <xme:6EHaZ3BtiSYJ_6n8R188xf9j4XelfYEYV8dabgsoE3dv1CJ74h5YfyNYAaRJSkMp5
 U4FImyISMutVm0nKw>
X-ME-Received: <xmr:6EHaZ-GQdtvY_liEHFTkCjVRAntvxdeuix6EaARlhdaaN-wvfd-LtInO3pSTuY-mloQ57D9dO-igNjspZoizcWPsKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
 grthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhm
X-ME-Proxy: <xmx:6EHaZ_RB9emkM9sKy9U-U7d3etV7HMJC4r3chRsjlebzUus1hY6gcg>
 <xmx:6EHaZzwR4pe8WKUDfBCEEwwAg38glFTha8cwC8hvpRQp457lmmguxg>
 <xmx:6EHaZ97a8zIQGcZYMyQmp5auKF_CWD5RQmOSv54EmW3ZeK4LelML1A>
 <xmx:6EHaZww2vYPAjdJIQiMaISpqnDClD7QQyrymDvTE68MkSJ-2XeXhXg>
 <xmx:6EHaZz9-HXCbeXYS7dkNFpwZ76RjHa2kn0nghk6cmrR9ArIul_CXaR1e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 00:02:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v1 1/1] usertools/devbind: add documentation for no-IOMMU
 mode
Date: Wed, 19 Mar 2025 05:02:46 +0100
Message-ID: <4908462.D8ZAKjAxdT@thomas>
In-Reply-To: <Z7RW7fTOcGVP4RiE@bricha3-mobl1.ger.corp.intel.com>
References: <a1a8fce7e0eb311e7ca673867862a549270f5450.1733132101.git.anatoly.burakov@intel.com>
 <Z7RW7fTOcGVP4RiE@bricha3-mobl1.ger.corp.intel.com>
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

18/02/2025 10:46, Bruce Richardson:
> On Mon, Dec 02, 2024 at 09:35:01AM +0000, Anatoly Burakov wrote:
> > Support for `--noiommu-mode` flag was added, but documentation for it was
> > not. Add documentation for the flag.
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



