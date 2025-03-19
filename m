Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CBC35FF1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 03:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BD82402C4;
	Wed, 19 Mar 2025 04:52:54 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 1A1514025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 04:52:53 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 7132E1140167;
 Tue, 18 Mar 2025 23:52:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 23:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742356372;
 x=1742442772; bh=MoW8pThnjtwokzZTbKd7MMpP7keEpLp5uHLQ2BXvwIM=; b=
 thckc9p3p+smXgSG8gm3cd0Uzx1+MD7iTe7WG2gld7bUCjHNlOKPQT7pHD37Mi11
 EBFUP8H2nPUkIexNvJyTVnp3S7VTstoYVeCM/iT07CxM4PFRUCkcky9CaNq/SmiK
 NaUFmXz26uqBG275Gf+j6L06ba2Ef0jvDqY1vq7+ZZ7fQm4c1DtZAYG/VRHvFsYt
 QMfFbP978OVnomcVB+Cd9RxfXoEm2v75es/VT05tBFOsAM+yEQzn43G6tWZIedy2
 Y2NZikj39NrMVyKgjY3gOWfPhpyuDFKdO6RxcfmIogCIhntUQ/GGfcVIAtFOhlog
 MEwFp4X79nK/9i6yFIt5vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742356372; x=
 1742442772; bh=MoW8pThnjtwokzZTbKd7MMpP7keEpLp5uHLQ2BXvwIM=; b=t
 O3HhOPg3wBoyW0tNoeIIMIlE20LZlXBIHyJIQee5YViNaBzXlqe62iWJadNlb3Y7
 an1EHUG4cB0WQSMyOB2cigpUbv0ky8+ADLyxkGYO+6DuqX0x2ZNUIq4KxuRFZ19J
 hs+9YdZrQBHHT7jT3XGSY2byf0CTLRYIMfEJM+1SYXDFCV7Lan3tAG71PlCnc3Vh
 ryiiflOKwMnc0TPijCMv6rciNwJGb0eYdTrU3CfFEGMvYsc5bh8LwZasVmjp5IQe
 PjPbVVrHNcRsWR28d/H6tCMOCHwBuCTF6OO46tSHTcRvox50/ZCMiEvVFE83krsk
 2P7AetruwZFWXGrnkpdjg==
X-ME-Sender: <xms:lD_aZ43dX2dMWUBOOEgij-dAY1BzyjKtxXSLVo3xqhleJpctj36XpQ>
 <xme:lD_aZzEf0PCXtFrY3cP8fSy7HND-9ChhLgDtbCz2LMsUjcKuAPp65mBJi-fLZNSRH
 rzhSZ8rhvxmwsdkPw>
X-ME-Received: <xmr:lD_aZw6mL7vNpiya6XogmHeAkJgpTJ351uPzmgJDyJyvSRxSs6r5OAkT0q08iPHkvgS0b84BnmwrLGT9ya7Y17svow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegfedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
 grthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:lD_aZx20RQA7GYUC49zIdSWp1MjPYpHBsnJoovoX_CB_6q7IW9uIKg>
 <xmx:lD_aZ7GCfyolzujhgDutRdwPJpmeL1PTFXRka9Fxi5NzVOHCi6bJ4w>
 <xmx:lD_aZ69HyCFatbL4OFt0h1wyzBSI6gtc26Ck07i4ODhw5rArdlCHIQ>
 <xmx:lD_aZwlRn5y2s_JPORN6ByautJi4H_t4Vjm8TbkY5WrqwOAS8IcVmA>
 <xmx:lD_aZzBUSrIfY2P80ZaMvUq986l5bsKwhwxdDF-zDp8qNQNJ1rglVLpH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 23:52:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH v4 1/1] usertools/devbind: allow changing UID/GID for VFIO
Date: Wed, 19 Mar 2025 04:52:50 +0100
Message-ID: <3603683.jbyF5MZJ3u@thomas>
In-Reply-To: <97c9ebdb-4516-4ad6-a53b-77a9080fed59@intel.com>
References: <4cd0282dabfa59e715028ecf255468529655b487.1725285449.git.anatoly.burakov@intel.com>
 <c5d0388620157638338f67291f8862c6c96cec96.1733131888.git.anatoly.burakov@intel.com>
 <97c9ebdb-4516-4ad6-a53b-77a9080fed59@intel.com>
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

02/12/2024 10:35, Burakov, Anatoly:
> On 12/2/2024 10:31 AM, Anatoly Burakov wrote:
> > Currently, when binding a device to VFIO, the UID/GID for the device will
> > always stay as system default (`root`). Yet, when running DPDK as non-root
> > user, one has to change the UID/GID of the device to match the user's
> > UID/GID to use the device.
> > 
> > This patch adds an option to `dpdk-devbind.py` to change the UID/GID of
> > the device when binding it to VFIO.
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Reviewed-by: Robin Jarry <rjarry@redhat.com>

Applied, thanks.



