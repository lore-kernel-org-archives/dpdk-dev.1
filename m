Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0958C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09AE0402DA;
	Wed, 19 Feb 2025 18:49:38 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id DA6614028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:49:36 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 7458513808BB;
 Wed, 19 Feb 2025 12:49:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 12:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739987376;
 x=1740073776; bh=z30/+0E5OJtR19yMWDWhKcLWoNeUlwZkQZPaTHRDrpU=; b=
 I7/DndVPxUFrD42xZ9KxjbhELBAlOdyc7Cyfeof4lZy+DWdalWFp7scXKtDHkOfh
 0w8WzbbkHZtacwAg8tN/KYVr+Cucps+yQXpQ4uUpGSFDkFMM7Zt5nOazrKVcfg5W
 F/x7w6kM4mJgZ+YQMVHmNRewuajX0K0cfeqr7rnbEZkO/MLUikNbp36F3j/niNyF
 LWvkJLw6M58aMH0cf6DowBjqhaujaYCnLS6n3YNXKq8FfEx0JOHZhyLaHBZaNi5I
 zKLH5G5nDxNE9HKE3XHRb2lF4BQ8x0azBlAyNkt+6+nqiRFkk/qteQO4T6w4Z0yH
 DHk6J/ZeYhbswXzmNsz9dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739987376; x=
 1740073776; bh=z30/+0E5OJtR19yMWDWhKcLWoNeUlwZkQZPaTHRDrpU=; b=N
 Gegzp20sz3sWb/ROQocYBfU/Bf0H0x/ufdO3aIk3G/J5MQY5UPpzHkbtZegvvlZh
 4hb1ahKPNwCBbilrOiLVO2hSyQzFUbSmCCREQ+/GqbqczgI0fvJEfryYH9Kxt3pB
 fM9UmWxzfNhY0FryMA2PxqqjcaFeBft3N5CnM7NAibzp16HVgD33QdzFbWkVEYJo
 ls/dFaiNHJZ3xMnVIJ/2impImSNIaJkzbfMyPsdzSxt+tv35iQkNj4oaQ+sf9wQ1
 T3QDJao6QLwhvvcfa8cPN8DZKXT44xtpNofNwp5WxwLy5GjaDIlBuPl10Y24GtL3
 Uht9iNO7Vi75eYVQTLrmA==
X-ME-Sender: <xms:rxm2Z50j8Ufk9Cyq8wnO19l7rUw536EwH51uIDji3hmxTALhMZ530g>
 <xme:rxm2ZwFUXYraR5UEPleKfTqSBD24wkndW85AdhXAdHzNTOhlMrI_q6lm5GClbwEsF
 I_G6iE8IcyrrajJzA>
X-ME-Received: <xmr:rxm2Z54CggkWmiR1ggQMtVqddQ4GpiUdcqZiIyybjkyOczXjFm-UFGDXhAaZBPsYzfYYUvUmCgaWAOjaQuPAqI7SjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
 fufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgr
 lhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrh
 hnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehluhiihhhiphgvnhhgsegtvghsthgtrdgtnhdprhgtph
 htthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:rxm2Z219QI2V6j1eGKHd2sSaZdglbciDJq7BvdzzIBWnGLsTxYn1Gg>
 <xmx:rxm2Z8EZ5Xdy15kPeYP5YVQ4o6N2Cwvi-z_f79YlzZ225pc5QS5EHQ>
 <xmx:rxm2Z3_5gX5FtvMeNXL_6JoO-h7m-IjoLVRB-Y9vO4IQe-z5i9JXQw>
 <xmx:rxm2Z5nmMDnRT6UM5eW5xZG3wrzJXLK5uCIlUqjjap8pMZ7CUs-VNw>
 <xmx:sBm2ZxQ-NxRHmMnx1dh-40FVt2fi--pUG38xfhPwnEMr7KGfKJQHqJmz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:49:35 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH] config/arm: add Phytium TengYun S5000c
Date: Wed, 19 Feb 2025 18:49:33 +0100
Message-ID: <3584058.CQOukoFCf9@thomas>
In-Reply-To: <20250213071459.458-1-luzhipeng@cestc.cn>
References: <20250213071459.458-1-luzhipeng@cestc.cn>
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

13/02/2025 08:14, luzhipeng:
> add support for Phytium tengyunS5000c
> 
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>

Applied, thanks.



