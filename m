Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F75CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 21:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B3140264;
	Sun,  9 Nov 2025 22:38:50 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 4D28F400D6
 for <dev@dpdk.org>; Sun,  9 Nov 2025 22:38:49 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 917A9140015E;
 Sun,  9 Nov 2025 16:38:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 16:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762724328;
 x=1762810728; bh=z7Q3uaVxLSnqpiTKMauBTmxagwS6qaQQ1Ctale8WBh4=; b=
 ZSIWb+jfaFc3/n/j2v6YFO4xgse+CziK2C/kjvIW757A5ZQ6qifbz/JHRdbroU/S
 UsYYq50JraLxPuy3Bxa8uuzXwXQYLjyYKfAzK4hhBisJM9XvbXnWTV+QiRBLA7n0
 Eiog3K8XdPmCLeMfdjz22ckTOabixuQj2bw2SLd81kf4MPQFmD86IjvHLuXGT+cK
 FjQjFhqJ38CdYT9ZKRCDPUgwq+YuspyrmmtcKkONCLnV0QmfGOUTPbTSOHkk/Fyz
 VnG2hYwOUMBhWObI+8U1oMbmNqLY27Yv8FrXPhU7hGZ4+cg/K6uyHjVUD/hmaHfx
 lWuoYTQvOSV79adUZAJ3iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762724328; x=
 1762810728; bh=z7Q3uaVxLSnqpiTKMauBTmxagwS6qaQQ1Ctale8WBh4=; b=K
 tc5ewSW5EMtwHYLQiNpb+FZno4oP8ZN7rq04jhqckt4BfUn3dn83+XxIMvN+Pq1N
 r7TeE0ViBJBeKdTJ1eHkErGATunzwxJvVwD0OWM8QOPw/ZBDZwyi2seTZV72DHqC
 9FVnL9E8DWiDgY+3n/jUdtvISBuyhHYy6vz8hOV3fKW6v48DA5Q2rEPfHZkG5gRA
 Jkc31JnPo8GvSiFOrPy0zBJqsJQphJlMoButNJ9OILw2jcSJtKvS4rmfJqBF8dpR
 NeyAS6l7UGa6v71nIVqylrNxInP+6uqIrSjsspUHRbpYjmIwR5Q+ldkFt1fUyi1/
 ZVftIiiHXzH4may8SUIQA==
X-ME-Sender: <xms:5gkRaQvhfknogYtgWQWK2nl006XywHuo2BF096e0PWm8Gfrzl6a6bw>
 <xme:5gkRaQi1znlVrqyEgaOVMwO0l1NLDPIdTqZqS1UM-u89qG69MmmRKKRWjbPVQvwnp
 MwLox64KnBmbQjZDm82s8cREC0dR3t_1ZlAzQO4x8T8MEB1ovW8PQ>
X-ME-Received: <xmr:5gkRaWYcJsPC_2UO8sL6xWyXgW3sIGeNl06MRWgkEAo73DUKw0ru6-xyp8bxIWwog0imAWsg3WrGEEvwc259OoCFvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeihedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrsh
 drrggtrdgtnhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehs
 thgrnhhishhlrgifrdhkrghruggrtghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
 hruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheptghh
 vghnrdhqihhguhhoseiithgvrdgtohhmrdgtnhdprhgtphhtthhopegurghnihgvlhdrgh
 hrvghgohhrhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehlihgrnhhgmhgr
 sehlihgrnhhgsghithdrtghomhdprhgtphhtthhopehpuhhnihhtrdgrghhrrgifrghlse
 gshihtvggurghntggvrdgtohhmpdhrtghpthhtohepfigrnhhgphgvnhhgtghhvghnghdr
 phhpsegshihtvggurghntggvrdgtohhm
X-ME-Proxy: <xmx:5gkRafYyyM9OZsEMy2IBssV8nTJ4xxadWvHd8CZsgzqeZIAOCPOeog>
 <xmx:5gkRabwfjzhRhYf88pgqXPVJNDQIZxMYoeAvyoFMpKqVS_Nllc2BeQ>
 <xmx:5gkRabd7NbfLIi5C_n45fWYpyRUDHaq-kgzef5WyGbDdIDRGVm-TWQ>
 <xmx:5gkRaQ7ZGlcY6CMG-44GOQE4aSB82JrOTZtfLCAVUibqioPBE4Caew>
 <xmx:6AkRaXj33tdlsq2rMlDr3iNv4N_tE1v6YHhc-6zt6N91TiEkQukTwrLS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 16:38:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org,
 =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Qiguo Chen <chen.qiguo@zte.com.cn>,
 Daniel Gregory <daniel.gregory@bytedance.com>,
 Liang Ma <liangma@liangbit.com>, Punit Agrawal <punit.agrawal@bytedance.com>, 
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>
Subject: Re: [PATCH] config/riscv: add rv64gcv cross compilation target
Date: Sun, 09 Nov 2025 22:38:43 +0100
Message-ID: <2429522.4MS8fQxZnU@thomas>
In-Reply-To: <20250923150734.2208125-1-sunyuechi@iscas.ac.cn>
References: <20250923150734.2208125-1-sunyuechi@iscas.ac.cn>
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

23/09/2025 17:07, sunyuechi@iscas.ac.cn:
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
> 
> Add a cross file for rv64gcv, enable it in devtools/test-meson-builds.sh,
> and update the RISC-V cross-build guide to support the vector extension.
> 
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

In general for RISC-V patches, I wish to see more collaboration
between contributors interested by this architecture.

This patch has no review but looks harmless,
except adding one more build in devtools/test-meson-builds.sh.
I'm not sure we want to run this build in most CI runs.
Maybe we want to replace the generic RISC-V build with the vector one.
It could be discussed in another patch.

Applied without adding in test-meson-builds.sh, thanks.


