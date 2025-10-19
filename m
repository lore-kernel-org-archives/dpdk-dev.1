Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA7CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 08:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3297A4278B;
	Sun, 19 Oct 2025 10:59:50 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id CB9D34013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:59:48 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id B54191D000AC;
 Sun, 19 Oct 2025 04:59:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Sun, 19 Oct 2025 04:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760864387;
 x=1760950787; bh=7VZLGNasCdIXcwbSMbPSWmIxt8EvzYmO9BM31B4b+ww=; b=
 iyvvATPmUS5t9h7YibW9n+7VL2Kor9awS8VyBZ04eL932aKF5IBXQ63EmDcoSiYf
 1swqVjV0TmwWwUJhmPT0D8vDW8zjHtog+e8csFt8+h+0gF9oBIII61MEJNY6Y5jO
 zInYNx3gz6yo7iOOloyBLdSl+PHXpFs7atMPFEvWcuOXuZbmJw6KIGN/wYg7WDVj
 oMDmZ/4zrTdPKdKewLNI3UTijINHVGZSPLgMKhuTNIrzEJ+2y6XTWRLbQ7P39u/d
 xPGslUVMuuSzLYXyyDU3NthLAf+w0tRMtLyfvPMZsOkiU5NS60GAEh63BPPj/n6N
 Ff+ciYlfjxx2hotmtF3rfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760864387; x=
 1760950787; bh=7VZLGNasCdIXcwbSMbPSWmIxt8EvzYmO9BM31B4b+ww=; b=l
 nJc4qEibNowQKV2dQ/+2IrTVM7tjaLfTkvxB80XB71lP3m0lnVAd90jkwwc9tjol
 cvfHykYPEVB4QT1T5IH0hgc4Jzeo3Rt9UjYDCWHXyxi/bt3QyAiHo4VFF8XdjRx8
 njLMxyeS9eHls+lfSg4kXvmQTZXm3i2wjaEk5KBP9cMsf8P8YU3kUisAnplaPG/J
 cCCKn6a72goTMXcMlgMo4xp9CK2797mJPdRJksMXxU3Rea/PSphm1l9DfWUnS73X
 lHAoJIupaI/cjXGtilnOHxskjAKBWP/dXBufsnDaVFB4adZA7yUgsZAc5tmMXERC
 9NubdVXkpelbUa/tYtHlw==
X-ME-Sender: <xms:g6j0aLy1fy4goJPkYDLK-WpV2OJTimU8TVxJZW02gcV2rrk-SS9uHg>
 <xme:g6j0aONnJ6oYqqrMapeWuSsH74L9VWbOFzyGoxCrh-RPsglZFFjYUlx1o3JNjkOOZ
 oNm_bsLIJ2C_t7qf4AX9arOxzt4VHLIftVt3XkLjosAIhcZ1GtbnA>
X-ME-Received: <xmr:g6j0aEWkaYe-tJfZe5yeV4N3qmNXPCxEIpxWkT9j54-3-JL3sKOMpvq_vLcemfBX36v488MCw5tvBduJVyqmKpKJ2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeghedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghtthhunhhurhhusehmrghrvhgvlh
 hlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgv
 nhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsrhhutggvrd
 hrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgrthholhih
 rdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgrrg
 htiiesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdr
 tghomh
X-ME-Proxy: <xmx:g6j0aK3z-tWfMslFrBFgZbH900m2ZO0TXfR0jIRlo2QXWqy8vrd8-w>
 <xmx:g6j0aKoKhyclDwp9lRx4o_04gRr4AjoFyWnP5PXfP_ZIi4eDBHwvWQ>
 <xmx:g6j0aJW0e_eAvx57buzJzqGQTaO-UrkDjr9FBpw_i9Ui0d6THla2Tg>
 <xmx:g6j0aNaV-nrqoAYw_9uMUnQrv7UmifzgrKH9SnskSBCjzMHg2oNTuA>
 <xmx:g6j0aDUa5IGloNBE_a84-QVijcs2pNBMuRn6ZWMKnaerfCY-PJWS-Pou>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 04:59:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for
 inter-domain DMA transfers
Date: Sun, 19 Oct 2025 10:59:44 +0200
Message-ID: <4681397.3daJWjYHZt@thomas>
In-Reply-To: <SJ4PPFEA6F74CA2C8C8EAE365AE5505773DA6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <3166338.vzjCzTo3RI@thomas>
 <SJ4PPFEA6F74CA2C8C8EAE365AE5505773DA6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
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

19/10/2025 10:37, Vamsi Krishna Attunuru:
> >I'm not sure about having different API functions for leave and destroy.
> >I think the last leaving should automatically call the destroy driver function.
> 
> Thanks Thomas. The leave and destroy operations are invoked from different contexts.
> Group joiners call leave to exit the group, whereas group creator calls destroy to
> terminate the group after all members have left.

I understand that, but why having a different function?
You could destroy automatically when all have left.


