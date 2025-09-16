Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A07CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EC30402E8;
	Tue, 16 Sep 2025 17:30:55 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 883B6402E3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:30:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A84137A0308;
 Tue, 16 Sep 2025 11:30:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758036652;
 x=1758123052; bh=IxxWJUkMQd9XFWr7TvPnwaiF2mpLUC3DZmTKV1ibEcY=; b=
 mjt3kkc+YA+sJV6iIlAMrgdggyG3vJWl8K1KQxWoaV79mkgr4LkzjxoLePg46vLV
 0BktgXachl+RMthbnmlAiH+r7aJW0N/aluVWmFS6eV5P0kNeYTFe9typfPGLGxnP
 IbeLDxBuOM5QYeHDc6tXc1ibVGHveNuD7mu6ECVLs0gB1rmPy4RRIogKTlPH63l9
 ++avXYyqiGBQ/VNlFr/Cf0DMmueHwRXUNdTeC5CobUORgArGUIx4lKLlLLqQ9UMO
 6jVtC3TpjgxVKa04iGh1ChVb44h3XNlK6FMq51mE8XQ5Io2+ZKn1S1lZvU6i69cV
 ngt2p4ronEwLN7p25Vt2Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758036652; x=
 1758123052; bh=IxxWJUkMQd9XFWr7TvPnwaiF2mpLUC3DZmTKV1ibEcY=; b=M
 cylK038NmJWnZnVETWQP3ZZLGNKmVBl8ROabYzVinJzgCeWqg2sVy3MUzdrabzti
 ILPp3IyhVDEoJ0zB4F5t8H/6+A3cX12lBjVV8WicC1V9eTxuP78nxpUx5obRBdmU
 uv9ygy+gunHeKzjLwaY7jyOJjpF52xpiVevVPWy+R8Cds8/RUFA4NbWA7soEwINZ
 bMpXkdA9w2C75/GUrnJhJPF0DaiAT2ZDFMzMoHgfBVciHnXyrF1KKWi4uuIVU8zu
 IjyIroOgDyl0/K+TfJ/SqaVIhzF83twPEhAf2gXqkD4cKlI/ZOxkSxfOwa1rxXhb
 ob2lXsUGZciglh4EuQaVA==
X-ME-Sender: <xms:q4LJaNrpmJnb5ZmSGKLf7jxt3MYrj5JgvLUErmiOpuBLB5gJtvqR3Q>
 <xme:q4LJaHDkNXewT9DJkqj3LA5GM6huUy4F96AEgAs0wu6D1hNJb8kqCVSit3rdKY4SX
 XV1EChLyQL9E3SbcA>
X-ME-Received: <xmr:q4LJaPznPONExuu3BuUH880AwJeA7BGiGbsac85e58KuWg0MetDRX2A22YrDtfKTbKar-rnt0KF-taELYRjCP6pc9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdelfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephhhurghnghguvghnghguuhhisehhuhgrfi
 gvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehs
 thgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeihrg
 hnghigihhnghhuiheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhn
 gheshhhurgifvghirdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuh
 grfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgrfigvihdr
 tghomh
X-ME-Proxy: <xmx:q4LJaE0K78icokWmAS2Q-C9TtL4n91MbkeIn-A2uJCj6H4N-AbI0Wg>
 <xmx:rILJaPz-syR4zlqLvo6s7P2oC5oS_f1DZhTX5KrZYyVdjn0hGAZKFg>
 <xmx:rILJaLHNvjcVqZx3JLjbraHHlCuhyVWhgWc41hRnPoXVJGThPxMbwQ>
 <xmx:rILJaCb6g5g-dj0ud6apTQINAFC2aCzSXUqhk6VbJx-G3FlWS1eVWg>
 <xmx:rILJaDcNMO0i1F18fUhVoMEzz4ra4tOaMIh4ZbzuaSUfNA1PXu40WP-s>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 11:30:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, yangxingui@huawei.com,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH] maintainers: update for hns3 driver
Date: Tue, 16 Sep 2025 17:30:49 +0200
Message-ID: <879020074.0ifERbkFSE@thomas>
In-Reply-To: <20250915075405.1823997-1-huangdengdui@huawei.com>
References: <20250915075405.1823997-1-huangdengdui@huawei.com>
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

15/09/2025 09:54, Dengdui Huang:
> I am moving on to other things, Chengwen and Xingui will take on
> the role of hns3 PMD maintainers. Update the MAINTAINERS accordingly.
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  Hisilicon hns3
> -M: Dengdui Huang <huangdengdui@huawei.com>
> +M: Xingui Yang <yangxingui@huawei.com>
> +M: Chengwen Feng <fengchengwen@huawei.com>
>  F: drivers/net/hns3/

Applied, thank you for the work on hns3 and other parts of DPDK these 2 years.


