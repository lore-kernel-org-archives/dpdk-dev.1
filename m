Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226CC35FF3
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 03:26:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2210402C4;
	Wed, 19 Mar 2025 04:26:51 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id F13AC4025A;
 Wed, 19 Mar 2025 04:26:49 +0100 (CET)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 13A1525401A1;
 Tue, 18 Mar 2025 23:26:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-13.internal (MEProxy); Tue, 18 Mar 2025 23:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742354808;
 x=1742441208; bh=vw1Pr4OYOrQFaoxCR7rDvEThswZU6yjbJQRQvJ2WOqQ=; b=
 itFL5ya8+4nvsSo2wGpfk7fMaXCofppLZWMBSYD86JCmWvw9tk3ve+gCK/4HhqZu
 CaLfhtSpNzjPKWjb5P4Y8Mwp/Bsg2XOg3WAPKAwHkxckBE+WN/pyNzxzsK+QNMoa
 LS1kWd82D0SSBHRft/TIBZBaa2mMM3UTyNikGKS6gXJwZ21IuMujw0ZE9Gwz7Ni0
 q76IZRpjy073ZYVoTh/CG97HwqWvqU4JLd7A5wu+KFrMML0gEl/Aw23cRB5XFfGG
 eBufXSZF0BLyzpNjZl70QCxKpsMzaLejVa/3jtqcQLrVKkmcRyzVikxIqzV/jBZ/
 TbU8kXDxyNKpgIGyzHOdUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742354808; x=
 1742441208; bh=vw1Pr4OYOrQFaoxCR7rDvEThswZU6yjbJQRQvJ2WOqQ=; b=M
 kOAEYpkd99IcelS6NEUrDYjvPVYoiu/H0SgcRwb9OIsX1rMufcvWrlIBpRwZF3Yo
 Ej+WurOuXguorpL97fnyGHDA+hKe57pBp1lk7m8qyZRNv/qrMmYCgWGNPz9UAHOU
 Pb115Gb5kBcBH6DYoup+YZo2DJKIFrd7dTMVwRTjnhzr0oJyE1oN41Ed6nTKXsZ4
 u+FqiCzNtNTOfOeVX0FimGtKck0h4/kTMQkrMwaQtR0mEqZgvGm/RRQxcJbclmvw
 L3xaLiuZ9PwcniBGViDXJbLP6Tnw2/JTdM7Uf8Z7x7tLC/QI5K257ijdRU4FpuFw
 3zlV7kFX/Im3YKs5D+5Hw==
X-ME-Sender: <xms:eDnaZwMDu1o8pglQdCg9oGlYbXzntAEq5NxjA4JF3jKRtUBwzkWtLA>
 <xme:eDnaZ28WD0_zepsDmCIIgHZfa-wc62yPdDOyXLUjw1i8vG1tSCyvU-wWg9ZdN3nhE
 ZIrDMayXi2jrIG_KA>
X-ME-Received: <xmr:eDnaZ3SfSB93eOU5ySRcs7VkOa9RRJa8qAcbS6xnzT3f1lxgHK8fgkyR6keOGmdOQkZWqADsNwxe5oMLzcTrvjsKEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkth
 gvjhgrshhrvggvsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepghgrkhhhihhlsehm
 rghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhgrughurdhnihgtohhlrghusehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepvhhfihgrlhhkohesmhgrrhhvvghllhdrtghomhdprhgt
 phhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepjhgvrhhinhhjse
 hmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtoheprghnohhosghjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:eDnaZ4uIAW337wC-HXusNqB55PvnM7OjfLk1b68Q4uptjkC6zc3cuQ>
 <xmx:eDnaZ4fJu3AUpGCFrYdfL74KcniLfGg77M_RMbGXaZR9qda0ZVGoYg>
 <xmx:eDnaZ820XhIct5gd-9L0LbF-RXEcU-hV22Atj-GjDrXm-FTquG9v0w>
 <xmx:eDnaZ8-6XM4GMmltuKPjbSGZNGhk2BCJgbokZQRo-as5WKLBpxVoZA>
 <xmx:eDnaZ_xM7npD2Ru_NGIMgjyfIg630yQyH-9vEv8Er_2nPEdGMssgvdjH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 23:26:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tejasree Kondoj <ktejasree@marvell.com>
Cc: Akhil Goyal <gakhil@marvell.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Volodymyr Fialko <vfialko@marvell.com>, stable@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: Re: [PATCH] examples/ipsec-secgw: fix cryptodev and eventdev ID
Date: Wed, 19 Mar 2025 04:26:46 +0100
Message-ID: <30709127.czjnFlTdjD@thomas>
In-Reply-To: <PH0PR18MB46723B375FB48ECB0D807CEFDFE02@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20241202064906.804328-1-ktejasree@marvell.com>
 <PH0PR18MB46723B375FB48ECB0D807CEFDFE02@PH0PR18MB4672.namprd18.prod.outlook.com>
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

23/01/2025 11:27, Anoob Joseph:
> > Subject: [PATCH] examples/ipsec-secgw: fix cryptodev and eventdev ID
> > 
> > Fixing cryptodev and eventdev ID numbers.
> > 
> > Fixes: 0dbe550a4af5 ("examples/ipsec-secgw: initialize event crypto adapter")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
> 
> Acked-by: Anoob Joseph <anoobj@marvell.com>

Applied, thanks.



