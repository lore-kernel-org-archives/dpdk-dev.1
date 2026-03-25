Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A31093168
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A70C402CE;
	Wed, 25 Mar 2026 15:02:50 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 09E394028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 15:02:48 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8E2607A01EF;
 Wed, 25 Mar 2026 10:02:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 10:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774447366;
 x=1774533766; bh=nUzbwwdI/1IHwp7Cb+o7aRd6pAxCXpwsojCWSqrnlxI=; b=
 iTn5FCS6OAw+NuH0aT47vCrSX17dlnnV7Wirqq7hIb3C7DNbK2I06jUFvBsajO0T
 gjVsICAAxgkxu5vGZo9YqAhZbmoK2XbrOKomntrJv6wHEg8RC4KmOCAMMoSj3sz8
 dQWvGgECQBet8cz+s3IHZp0xHjnyPap9SW70o7epj6x7BM08ymWayAd+RLDr19QH
 xgRTjRljzgATm02z54cEMHwJ5svoSNIySC8MKm8OJGoSXnavG+2xhv8NyUY8oJIi
 2O2a4a86kqMSk+9BHBmaygv9y9PrmDlOW1nrrQqL47mZt4HBAce3qAe40TQ2oy5n
 As18Yt+8NbkDxAM/n+IJuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774447366; x=
 1774533766; bh=nUzbwwdI/1IHwp7Cb+o7aRd6pAxCXpwsojCWSqrnlxI=; b=i
 JuBZeKGEg3glI9Jp7/1ijCUjtropm1zmVs2AmR3giV8sIitx5mcir+M+VkCnoVgz
 DJzs3DPXFfBzvJqAGSrMx2phSrcOttordjcxwtfzNM+hzIMv4aQh2bwvQi83MJP7
 F37R1Mzrkl1Vo4WmhNY4PvtGdiab5lFjf7rC8SpNGHUjJy2IFYTT5w5atW5OdFn9
 ou1NjvMbg+Xn5uPxsYw21OH9U2Bh2le1ClYhA3B9o3rOqF8HRdtO38hGcUT4UsO2
 ID6uEo5/twxAQdVibVlrNngjkAoy9k0BXMiicA4kc1qPC1/rjsdiP1PjTSnKNO4Z
 EmvZNk0Cde0d5GWTCLxbw==
X-ME-Sender: <xms:BevDabixFLTeWzMzIWMQ5pl8TnJDU6mSmtKsBkiemXvxp7t_77devw>
 <xme:BevDae7hR8W-TUJvZZTd85zlnEkGZwe5F4HcRqFIGrZeCYJ7w8khfkrmDgpE6lnV6
 i7oj75fhamvph84dNdzy1xKqaj9aS20URX_Xqu8spGWwXOhcKWa2g>
X-ME-Received: <xmr:BevDaTaZEeO1vrGiYzC_2PbSrQxvgE4uWxYqHqjfgn_ZDEGpmLmlRAogfu4rK4sX5yL22d7XGKJuXYabTQRfVYGpvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegieehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghhfvghifhgvihegtdeshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgs
 vghrrdhorhhgpdhrtghpthhtohepfihffhgplhhighhhthesvhhiphdrudeifedrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:BevDaT7qjRVKFk4-Q27FgGNQnS0bNCWeLtsAj-7vd1EQ9u87RSGDLA>
 <xmx:BevDaWAtHpjwXRlN9sBlSLvOLMiwizsrW51oogXa0HDuObngMCkeuA>
 <xmx:BevDaZfrGfpmU34-adTX70_7ieDV9Rz_cNm0L7r0CAwPOzK2T04-ug>
 <xmx:BevDaVJBID74XT2guvDrEfNhPZbH7ChL0mFWMwa0zZ3lrdwSnvFQEg>
 <xmx:BuvDaas3J21_ASHFBSBJUWiEamY5lyhKMQNQXf6dZtn6O8_giiSCOQla>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 10:02:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Feifei Wang <wangfeifei40@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, dev@dpdk.org
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Date: Wed, 25 Mar 2026 15:02:42 +0100
Message-ID: <4852774.Lt9SDvczpP@thomas>
In-Reply-To: <4112223.CQOukoFCf9@thomas>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260324074236.613d2f1a@phoenix.local> <4112223.CQOukoFCf9@thomas>
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

25/03/2026 14:37, Thomas Monjalon:
> 24/03/2026 15:42, Stephen Hemminger:
> > On Tue, 24 Mar 2026 09:55:03 +0800
> > Feifei Wang <wff_light@vip.163.com> wrote:
> > 
> > > From: Feifei Wang <wangfeifei40@huawei.com>
> > > 
> > > Change hinic3 driver to support Huawei new SPx series NIC.
> > 
> > When merged did small changes to Subject to resolve check-git-log
> > warnings.
> 
> Compilation is broken in the middle of this series.
> I'm checking if that's something which can be repaired.

It looks really not ready to be built in the middle of the series.
We should not have accepted this series, it is breaking git bisect.
I will let it pass because I'm late.


