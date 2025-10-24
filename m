Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D51CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 13:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D631140151;
	Fri, 24 Oct 2025 15:50:06 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 5138A40150;
 Fri, 24 Oct 2025 15:50:05 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 624B51D001EB;
 Fri, 24 Oct 2025 09:50:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761313804;
 x=1761400204; bh=chOTZxE4Zsd73GS6h1XGrtDJyNKJkLJx4CofS2l97vo=; b=
 dgPScwhmOd7mS85vxeWQmEVAbpXYEUowNfCpirTitsAvRYIJdu0sXDiGZa+2Q5GQ
 4R8RJNnURQoIcKcW5HqZonynsGGuDHK1h9kP7KPQKLZg4sSUMIocevH8hwKXfAhU
 HbR5ooHKk73Ki2cvTENIQsVm6QyjzBJnTIVQ2nN3VC5y6P7spOTNsOdzyOFJMii5
 cMk8odphvKFGrEiw1iPg/yVvmshLQ3p9g+8eba8WRkievqaFVbFF5PcpuS9F70kN
 Pa9kbMAmbdchXsDeHLZ2Vg0QkRatJxA99erxQE2+dCenJUpnCXyMT5LKSdgigjfE
 vnyBVeKajPSgKbAK6yqZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761313804; x=
 1761400204; bh=chOTZxE4Zsd73GS6h1XGrtDJyNKJkLJx4CofS2l97vo=; b=y
 d7+VFfQj2nSLEQLeUaRzMyjQTVsMGMVTwOW7VMGnDLo8e2YWYsdIOHHVs9m+0od9
 2mzPjtnvJFmFnZXqmFr1ULXjiaSOuaEsBFEET6ueI2ihOkAn7tGmdPFiZYmqL+hB
 VhgBypaQKiDkp2ObSPwLks+PMj8w6SU0w7musf+l0AEz/B1xB5hmiWS+iRII6Nbb
 OwSc9+dT6iE+2nmIsDY00CfHCEheAj65zuV890NvxbQ5FPhTRAb2CTLD9XEoQVzL
 SCiOfi00gyxMC2ggCtDU5z1gBT9HM1Y8XU+LqPYVBYd3dac+OywGxvNFfBQqH8Op
 qFU3B8pbbtwoFTnTnjivw==
X-ME-Sender: <xms:C4T7aA7fZFFQQ394YHmMym4Vx3QyhQlu6SOsk7Gf8H1jhmDRc4kE9A>
 <xme:C4T7aM2rcZw09UG75sMXC6fCrS8TDUPNEm6HrH-cAADwitmqowECVYvwbbT14GHwv
 d7WxMx0iDVj5JZwC2plvqrmJEzoAsoTGsVKVdWvS5E000qzjAYI5w>
X-ME-Received: <xmr:C4T7aOfKxPERx467eAEPew44TRbmTMQ5ft8W2CoNednvg2s_edShw5R4ubnbwB7bbKuFQRqM9AQGPtQuaKovku4ZUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelhedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 oheptghhvghnsghogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrgh
 huphhtrgesrghmugdrtghomhdprhgtphhtthhopeihrghhuhhirdgtrghosehinhhtvghl
 rdgtohhmpdhrtghpthhtohepshhkohhrihesmhgrrhhvvghllhdrtghomhdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:C4T7aKfy1xxsPX17lsuyH4XFSm0hzaTY1O8uRNDenPkiIPOxTt6W8g>
 <xmx:C4T7aBw3LLuB8UQefHUGGJAMccfKLZSpjjC4PdcLkqZcNHu8Yv7RWw>
 <xmx:C4T7aB8N1g-YcEBEfUEr3m45TgeXEVClcZWQ-2DrMqcQgsn72cnZtA>
 <xmx:C4T7aJhENlBcknLVznVzqZM6qyMiA60IBfO41ZvdFJvqsLtAjXC-ZA>
 <xmx:DIT7aPcb7ddIVrDELQBXn4KyVuoOI-sKXwS-zbogTKH_htD3xRy6y_xj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:50:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Yahui Cao <yahui.cao@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>, stable@dpdk.org
Subject: Re: [PATCH v1 1/1] bus/pci: fix resource leak in secondary process
Date: Fri, 24 Oct 2025 15:50:00 +0200
Message-ID: <25345423.RjEADstKbi@thomas>
In-Reply-To: <54e4e95f31382c1bb3babee07c107f1e39dc9093.1761297496.git.anatoly.burakov@intel.com>
References: <54e4e95f31382c1bb3babee07c107f1e39dc9093.1761297496.git.anatoly.burakov@intel.com>
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

24/10/2025 11:18, Anatoly Burakov:
> Right after setting up VFIO device, we attempt to fill region information.
> This operation can fail, and if it does, we do not release the device fd.
> Fix the control flow to free the device fd if getting region info failed.
> 
> Fixes: 4b741542ecde ("bus/pci: avoid depending on private kernel value")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.



