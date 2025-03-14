Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F6C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DB6940289;
	Fri, 14 Mar 2025 14:55:56 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 3E88B400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:55:54 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 9E1351382DCE;
 Fri, 14 Mar 2025 09:55:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 09:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741960553;
 x=1742046953; bh=QvJeVpkrpqEwDtJthbFCLpeaEcNUow8v43aMmANFibQ=; b=
 WmoeFqfRS9G3otS0hAVqIDMYc3oRktRVTrjquhEkPwfzv8Cx+ljVXZml8VolxTf8
 07ilVvB/zEmiHsqDwNKRJkXLA9ll1bbNVntuz+awpC7scz/kML77ziJ3m9buOxzO
 k4f6F/3SN3iiSU3IGIZ8BffdTbBRlO3ot28pyVh7HO/sC1UbNu9yfaju/kXJ9nJx
 yvdh7oftJ2clurzhDonCW2XVLM+69UOKXUbKEnUuJ+bbqVFOiE9qIi41p7wKmjDk
 R3D/NSowG4HIptfqZ1nEbgzhW7dgTuJhRwwofY0CmUammBgbIt2AJXSdqUtMUC52
 iMVGzA3qEl67UbSGGOGMVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741960553; x=
 1742046953; bh=QvJeVpkrpqEwDtJthbFCLpeaEcNUow8v43aMmANFibQ=; b=O
 +hQbasOtvdzl3/rTHwFR3WxXRCheCReLQe3mTNt7n0NMNPbQdfUYEYOemjbJcf1D
 yL0BWm6t7OuT5ig/yVQehT+K9LvIbAYy1vjZgSmtNii7Aox5Eixefh0q2GtabChI
 YDmPvHB/L1xkEmh1Fb/+fa1PbhRoJpZC2NzzyBdtFLNwlJ6qwJ4TQcSxG3Mpw2xJ
 XPhSmdNKb7K/Qnj3Ltx8WtNUknjbTpcOrVaukq7IWoTHTFLQFUUNIsjcugnGaqPz
 uK8rU19c35Mu3ziP9p0GZcAz8uzFqaRoYPMgaiMP+PFLVF7r5eAMk2+ZHE+vPi4t
 uG+4pD3L3kUOZS/mUD+sQ==
X-ME-Sender: <xms:aTXUZ24OrOuYA5yuuI4kyKqbo5yhPV25J96C4UndYiNEpL32w7yVJg>
 <xme:aTXUZ_4Ul-aR2K9gvD_8qhFT9Ebupd3ekSs8LmGmvcMNVgdnPDjveDVWVWdV2EG8P
 d_ctrO6U8KCWV_WUQ>
X-ME-Received: <xmr:aTXUZ1d8uIBRnkf8QVcIs8i-Nev0MYg_Y9i11d7TYS31KeeXRIOjXdIi-33rNDlIX-rmWl_aJ6hI7ueLRe_rbtMwPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedutdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:aTXUZzKHWuWQwchvQ0a7ScZpA9HQa60GEteYir1clAeAI8oZXsT-Wg>
 <xmx:aTXUZ6JAXjdU6riMmD4iB4_jNtB22HstUjKPTotA4WqiQasqFE2sqg>
 <xmx:aTXUZ0ytcdMtqDXaq9e8ER3CAKjNIuUvxGTjSyonRNQp-Zu5Qaqk_g>
 <xmx:aTXUZ-KixkUaYEwhlU7nYODYh6SnRWOuPSR1DIRzHgNKXDrmOeCDhA>
 <xmx:aTXUZxUAgF910MwN6U0jJfpWuoXPnYqWVhW_GYD8-4hycfSaOld7P_K2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 09:55:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: enhance the license check
Date: Fri, 14 Mar 2025 14:55:51 +0100
Message-ID: <4046361.22IY78Rhhi@thomas>
In-Reply-To: <20241210091039.3439504-1-david.marchand@redhat.com>
References: <20241210091039.3439504-1-david.marchand@redhat.com>
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

10/12/2024 10:10, David Marchand:
> Reformat the license/exceptions.txt file to make it easier to build
> a list of exempted files.
> Display all files committed in DPDK that are non compliant
> with BSD-3 license.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks


