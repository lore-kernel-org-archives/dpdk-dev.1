Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA8CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 12:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BEC54026A;
	Tue, 11 Nov 2025 13:36:01 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id CFD8A40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 13:35:58 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 3344B1D00217;
 Tue, 11 Nov 2025 07:35:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 07:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762864558;
 x=1762950958; bh=lS1RAI/7nosypiqw9U4uYSyvcgEvQeybFNUrf0tZ5SE=; b=
 wemdcCvegBzBEZoIR/Jz0OpD8LgxvIn+7F1pH1mTQZTRvJmvvSp0141ffkmuuL4G
 hao5FG8CV6qwhWXTdtD3LQA/D6PsVsYxKB3IZeqQy3KTt6AhG9NmtU/6HykoTzjB
 9Q9NHjjbSOrT+TX4+JCc2em633gdL5BytFcydVimL0vlAdX+/851CMo7m2mI+Mrl
 cy9m+Z0Jt4pFTdEotzUYfrHiDEeIjORIvV2V3uW0DpiHMsoOPhsQggORJeqgT0u8
 U5l4zz59lvqovXXFFxAjbThtm2pF4SLsgRqRkolzgoYPo2ZXfSjJIilRXt6E1XhT
 0ACParKrjy1bgpzixPbWBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762864558; x=
 1762950958; bh=lS1RAI/7nosypiqw9U4uYSyvcgEvQeybFNUrf0tZ5SE=; b=q
 5epyiEuQtCN1UZJMaGmfS90o8Zso3sx1ft1gCP0c8e/LYl8DzE2/0wP0DTMfM0E9
 TRC98kUbHo06LNHTWGHbEAV7xuR+DJ/zbpA6GCA33f1y+WzBj9HdmFzaAeWOF/y/
 OmQC4BkywqNyza5KFHIaLqB9/+3FoG7p2SiXuvLAPhwIxPzdQ0OQXolH5k5PedZd
 nDA51PqkfJjdNgEICLQWTUwi/Sm4mDlH/IME3JLtf1jkblE7s9c1G8Oc1Uc4XYad
 G62rcGB8/08HB2ViYGptfIc3DkDVD8OR3FSnUGhK7n4cq//rv3Mxvs8ZfFp9/TMG
 pxleRwm9IWJ2prmfmrRLQ==
X-ME-Sender: <xms:rS0TaWVv4YYuu68EVFkq9PvuDX4_uKuhr0t6bybPv-Vg7iB1fcd0aQ>
 <xme:rS0TadhKXc6mGBROw7KtgpVw81IyN4XyYPB8BWkrTaMWSVMOe7uVvXFprkXEBOXpj
 dDTtapXT2jRkhHOAwQHRKvMPcWPXirivRrtb55kYDYzjCHMrBmuT8Q>
X-ME-Received: <xmr:rS0TaZZkHwx7OnrsZlGL_jcScVSt-kpxX6DVNEiP1SP2C1_xH3zf51S0QTxDdiNuUERxbeKtC02fyMpGJL8RxbcKFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehhuhgrnhhguggvnhhgughuiheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtoheprg
 hmrghnrdguvggvphdrshhinhhghhesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhh
 uhhishhonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehfvghnghgthhgvnhhgfi
 gvnheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuhihohhnghhlohhngheshhhu
 rgifvghirdgtohhm
X-ME-Proxy: <xmx:rS0TaSqc0ipa_ahEcABO_9ky3uwXHq9TGOIHTPuVLXLUeNbQkLUJyg>
 <xmx:rS0TaeMV9sESQaAfaagl4Kk1EO5WqztL11xIJOv8OhcaWbWlIBiHxQ>
 <xmx:rS0TadqxZENZmXQ4JoSEM4llhI5YFCH6WAJDjoOTDlR2A9cX2rUn_w>
 <xmx:rS0TaTdqVnI0UbQGYaS8190jzvaeNnlNN3MmGzIwo6uesHLRsHIghQ>
 <xmx:ri0TaQTeeo4hGDJcZnhJ8i2b_f4YzYOcBJyKoyuTnWGjobokKVVLLI-d>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:35:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, aman.deep.singh@intel.com,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH] net: fix incorrect L2 length for GRE tunneling packet
Date: Tue, 11 Nov 2025 13:35:55 +0100
Message-ID: <3201124.d4nMDBE73Y@thomas>
In-Reply-To: <20250723104710.558623-1-huangdengdui@huawei.com>
References: <20250723104710.558623-1-huangdengdui@huawei.com>
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

23/07/2025 12:47, Dengdui Huang:
> The meaning of L2_len in the parsing result of the rte_net_get_ptype()
> is the same as the L2_len field in the mbuf. For tunnel packets,
> the L2_len should include protocol header of tunnel packets.
> 
> Bugzilla ID: 1754
> Fixes: d21d855464ff ("net: support GRE in software packet type parser")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


