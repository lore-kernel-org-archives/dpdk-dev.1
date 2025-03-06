Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA6C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:03:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F03F4064A;
	Thu,  6 Mar 2025 18:03:17 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 9AB0B4025A;
 Thu,  6 Mar 2025 18:03:16 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 1B11F138113E;
 Thu,  6 Mar 2025 12:03:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 06 Mar 2025 12:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741280596;
 x=1741366996; bh=p9hUGWUTdx+4eFWklB7TK4T3IFAzXgWfm+3iZYrrQmY=; b=
 TJsxtHAT4xqk6yT3KLa/P4LB2O4ulez7gDkNLHNJyR22VH3iFHQCPCgIpa8Yvvtz
 kKmv2bIofdPFrYaWFWUFoL3l/JP6JrN867mjQNif1sRMwzhPxtX41aoharWuFoaS
 MtU35q7OK1ZeQRPe4T1O1x+wvEFCUBp8/Ky5OEwHjHyVTik0Y1V3ymkZBCYOeMqT
 0B1uJ7X2f7JrpFWzMNYGznDyafC16VxatXnKmZvEE/lE54E+nS1Zjf3+Rb+tdOOb
 SlM3I073eNcKd1VXT9O3rJVsz+6WmdXTtS+LMbGD0kqU6+Nm87BWt0uH18ztXTDh
 1ClsnvibvVKqkHOFs94fZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741280596; x=
 1741366996; bh=p9hUGWUTdx+4eFWklB7TK4T3IFAzXgWfm+3iZYrrQmY=; b=6
 brnBDL4Z+1R7/mQx/OL+DKDo1SyySraWFeNDw5IgHnLpX0LdJfi/FNon+j5O1ZJm
 BQPwdNep+Zhg9KujL0hj/1R5uWehL/kv6zxqdlNqcFyoZ7kJhDhSK+6yowOvnX+P
 bvdNfJ/RPXdkUgp7MctsoLwg2OCnoYjuu1AlONMyyUstBu6SoeKX+Tnp3jgCH51p
 FxtBkx4VoWtn0stQFTSgd2jzJTbGzWknpBGXdoDhTLPydH91b878Xoiea4brnYah
 1rF1vC1SNlSp8tg0LE1q5lNDRCeovjiiKX+j/E0AFezfUx9BwVuX44WzwpoTd+P6
 vKBTlultjM3pfm9Z8JGTg==
X-ME-Sender: <xms:U9XJZy8-vArt6jFj20NYWSofEOl7PQ9ksBtbBheJcqRr2Jk4FbvIDQ>
 <xme:U9XJZyvQTg80jpPOW_nvhAGDBRx8DqvOs6rnC05WFs5MKxVpgA6BHcW0i-bycPeOz
 ST0DY3hjXXtz0Tp_Q>
X-ME-Received: <xmr:U9XJZ4CcmXxG9ulmvrujI9R_xZNYuef3vX32KPPZtyX0ZrgLoVLR-k1KwqWw6Rkf9nWqunYTr9Y8Zg2TkILj9qHAww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
 gurhgvfidrsghohigvrhesrghmugdrtghomhdprhgtphhtthhopeguvghvseguphgukhdr
 ohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:U9XJZ6cO5pqBl_Ezn-qBYJxx6rZVlyxM02lPuFhjDoPZFlLmqliQqw>
 <xmx:U9XJZ3MLVjU3FlhsONI_rfhzC_J_d0B4IwkmsucERPlvyYjgj0I_cQ>
 <xmx:U9XJZ0nO1sy7zQi1OkPG_M1aIMNJrdTp4aAgooa1eAIwL10vHnY-bg>
 <xmx:U9XJZ5v8tCCIfp2vzIpTXsz8gn2hWK5zj_4e0IhiWEk2upXEOA16Jg>
 <xmx:VNXJZwpUBd_eFmxqogy38YmUkDKoIvQ9GNed6cCm3da2odvPbou_88tH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:03:15 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] doc: update ionic driver guides
Date: Thu, 06 Mar 2025 18:03:13 +0100
Message-ID: <3443079.yIU609i1g2@thomas>
In-Reply-To: <20250227201418.51132-1-andrew.boyer@amd.com>
References: <20250227201418.51132-1-andrew.boyer@amd.com>
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

27/02/2025 21:14, Andrew Boyer:
> Update broken links and add a link for the DSC3-400 product brief.
> 
> Cc: stable@dpdk.org
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>

Applied, thanks.



