Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BFCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 13:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C9EC40151;
	Fri, 24 Oct 2025 15:52:15 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 90A7840150
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:52:13 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CB6347A0102;
 Fri, 24 Oct 2025 09:52:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 09:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761313932;
 x=1761400332; bh=N2W+8BzYeodH0Pue130iMdenMq+or9uQydiKMRNsZQc=; b=
 SS/EZxGNNotKdjRD9CFTXPCZ/aH/lRY7h35JUDR4jmKEKlxmiSsucGUDM5xWLZ6F
 ycG4nvav87EbVK3RT0Wt5SV50bXh4P4x732wZMeMASm7dvy6UctSkX4p38ZlauDh
 kFD3aNnKbf92ZgfCSA20XVQqrmRBGuybqHCXb5ZihSdOi9A+Qbxr0EV+QekDtNge
 hyShQU9VFYNF5mjPaFoPqY/vMsSBCS/3Wsv5TaTg7mmqV42QCzoSn9H1Rk0om5xc
 g5l4Zz1sJlJuurY7G0Mn0cM4ylaqxWxw9LyozRg9kLXjAbF/SD99rRMp1MQrSdAr
 YSDqi6WgmFIBThOa9LUjqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761313932; x=
 1761400332; bh=N2W+8BzYeodH0Pue130iMdenMq+or9uQydiKMRNsZQc=; b=w
 Ov+84Be5lge3w5LbcmHM/mAT5WEq4sgw2aAlVm65ya+dBb4WvpYZPJCkjgVs9UXM
 YEbemS+uqsNeZuA39eIqw1Rel9BnhNNKc4ziaHUWju065xCHUjtiZdLcAhSw84K9
 /puHzJjV8Bpnap57zyjR0ex1x2FCiGf48Ewhw7SaCrH0kqTVkPFpbb0i8K48aqQQ
 fIE5QjPRjXgFbxqhyk6395xzbsH7VOVK7HQy9cfG356FPuGqsIFaWNF9gBV4Fu1K
 JSUm1N5Nogn+Y7gUzc2RFbc7PxOuuSZ9ril8r6kIM4E5u78QJK0/Wt9ihKuBV7i4
 2cxZ5wbcDpm89FnWLUTbg==
X-ME-Sender: <xms:jIT7aEqgNVJs1e4UfcwDwQyzdQWxCrnMVHm_LulF2IOC9lMIZcY4Vw>
 <xme:jIT7aO-mp7wunzMbKgT0O77gb3_1gLohTpz2yhF_tFsiH8pWCN3WMMNf38NPryujS
 kx4N-hP5xM49B1ar04-Ux4-8j0lTuwHUIkF6frx8h6sQGN1Zyc72g>
X-ME-Received: <xmr:jIT7aIWARfVhjAnCRcq5EM8c_e0dFeVE1n6LkJtvpQFccP1wjOBsMJLlGFGlLo8VlY-TsqEsxMYbzdUtH6bloji4bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelheduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvlhgrughimhhirhdrmhgvughvvggukh
 hinhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:jIT7aEAufWIhcVKBnlECfycy-eUmp1eayt-z_yuD0LiOONPsr5AXxA>
 <xmx:jIT7aJw5WL7O3xaQuayz2h0972klblSE_q7cwccDVJ8UZNVtz-QjRw>
 <xmx:jIT7aBAz7Zv3E7yQSCTrA6_X5YmC3JO_ocaVzcQzUlyfOG4JEBnF5g>
 <xmx:jIT7aGaZAN1bRDtg_5MEWLsZh2f8M_9n2QDP-8O1ogCPYL3Cxmh03g>
 <xmx:jIT7aNZCYEpL3lxpCAszZiRpxpdnNrJBRAdwZH-BmmDkiBjYgz9B0q4D>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:52:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH dpdk v2] fib6: implement RCU rule reclamation
Date: Fri, 24 Oct 2025 15:52:10 +0200
Message-ID: <2728875.otsE0voPBg@thomas>
In-Reply-To: <20251015095347.333685-2-rjarry@redhat.com>
References: <20251015095347.333685-2-rjarry@redhat.com>
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

Pending for review please.

15/10/2025 11:53, Robin Jarry:
> Currently, for the TRIE algorithm, the tbl8 group is freed even though
> the readers might be using the tbl8 group entries. The freed tbl8 group
> can be reallocated quickly. As a result, lookup may be performed
> incorrectly.
> 
> To address that, RCU QSBR is integrated for safe tbl8 group reclamation.
> 
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>




