Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B513C44503
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA68427DE;
	Wed, 21 Jan 2026 12:08:12 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DD87B427DC;
 Wed, 21 Jan 2026 12:08:11 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 798AD1400127;
 Wed, 21 Jan 2026 06:08:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 06:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1768993691; x=
 1769080091; bh=4sQKVUMzcE/ZDeI1MMwwCPUZGstRAz0Df1Khvph4bKI=; b=Z
 4QUuYzrxnb50l/cPebiPkKDcSX5u9Q75UlTaJOZUfgaTXF4Edic5+LWBbwdZjlBF
 h1w1uCkXwoklN8cpirsW8mUeMEA7EK0yYbNWjBh/GN8p5jYSZMSCypqRk8fnEIED
 H9jHzGCnQHlr90vQPF6js8SRguM0A1jH8GJVMlhXy/AWn17FvNFoQMr6uCImlhfm
 +zQGuEOV/eHsE9JOU96Z+kX1GD6Wm+REE08NnUdEZpo+r6aZ2CH1qti7xj2HD9c/
 YdBzP6HfbQ7ucPpSPhpi86e6pyp7CV/qKGhW+bZP3DYzjF02I1D2rTLeMYfBje3W
 07Vhq5ZhhMNhcqN6Oo3TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768993691; x=1769080091; bh=4
 sQKVUMzcE/ZDeI1MMwwCPUZGstRAz0Df1Khvph4bKI=; b=am65sbgMkYGrZguPN
 rc+GpkolQAn1Et18IONUwJQRKQuP0m7Gs4baCEDykKv7dYbbMFXHFYNGXgo7YZRY
 HsltrepG/5KGufCMVr/63ofDaJl34kqKIoY32nNd+5dZWxKHhlA390MUlqM1ZCZ0
 xerJZ+B5599GMuGI4Db4sXVthwzURuJDVBsYv1+ciEnYQittZAypvfOgUTMA++v4
 HcxBatlYcmMRXHqvUXS8B/4jVSVR07uAOKgiQ/UkOrYKwZxC+QM1A1OtX1T/Vfvc
 J2k9BNgLn19G+ATO4BVMj8IlQ80sR+7Zev30m1pIG8iuT4X1qN22f754/YZkIyRx
 Civbg==
X-ME-Sender: <xms:m7NwaTTea17xxgMLy1wUv-Ung63WqeyRupRIaJiwBseV-RWMY4TNlw>
 <xme:m7NwaftysJzJvuLyI2hnC6pgsswl064hR7HzjSyRqowbRylDgWDlsrypSDy04Fhug
 MCo_uZIDKhXz0F0OXJmZaTkVinBPnZnJMKhtc0pMQVXtQlj1GK1SA>
X-ME-Received: <xmr:m7NwaX3t2vUSnXxiJiICFVytIXmz-Z3TWSvhR1Yc5-5cX0Ee-2hmUMVn0IoH5lBP_83v70So2j_uv26miksW-ccgA1L17ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehlihhrohhnhhesmhgrrhhv
 vghllhdrtghomhdprhgtphhtthhopehjtghksehsvghmihhhrghlfhdrtghomhdprhgtph
 htthhopehtughushiihihnshhkihesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:m7NwaYVwn7Ol0OH12ctWUgmtwG50z1xtma5zX023OcopJ46Z4TC3_Q>
 <xmx:m7NwaaJC2rX56PpW2RFEfyfcWGFN6Du13p6XWtQyRQfz2pm4mU2Saw>
 <xmx:m7NwaS1Z0_1d6n5fYy2jMBruVtdTgsu0sDOjijF1udvj5zOzK2QuSQ>
 <xmx:m7NwaY46THiz7nhIN8ThdW89lj7eX5c9s7gewD1OwPrHPKiLXVMOWA>
 <xmx:m7NwaYd0Byvty8jqqHuQrfrZlpYxl8dB-oES-j9vLn_CfIzcMyR59_74>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 06:08:09 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, david.marchand@redhat.com, stable@dpdk.org,
 Liron Himi <lironh@marvell.com>, Jacek Siuda <jck@semihalf.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH 2/2] net/mvpp2: fix variable shadowing
Date: Wed, 21 Jan 2026 12:06:01 +0100
Message-ID: <20260121110757.1948723-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121110757.1948723-1-thomas@monjalon.net>
References: <20260121110757.1948723-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With shadowing warning enabled, we can see "i" was declared twice:

drivers/net/mvpp2/mrvl_ethdev.c: In function 'mrvl_rx_pkt_burst':
error: declaration of 'i' shadows a previous local [-Werror=shadow]
 2676 |                         int i;
      |                             ^
/mrvl_ethdev.c:2592:13: note: shadowed declaration is here
 2592 |         int i, ret, rx_done = 0;
      |             ^

Fixes: afb4d0d0bf91 ("net/mrvl: add Rx/Tx support")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mvpp2/mrvl_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 845819e4d8..1074092d43 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -2673,7 +2673,6 @@ mrvl_rx_pkt_burst(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			     (!rx_done && num < q->priv->bpool_init_size))) {
 			mrvl_fill_bpool(q, q->priv->fill_bpool_buffs);
 		} else if (unlikely(num > q->priv->bpool_max_size)) {
-			int i;
 			int pkt_to_remove = num - q->priv->bpool_init_size;
 			struct rte_mbuf *mbuf;
 			struct pp2_buff_inf buff;
-- 
2.52.0

