Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B259CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32AE640A6C;
	Wed,  5 Nov 2025 16:09:16 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 45B554021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:09:14 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id BCB46EC0255;
 Wed,  5 Nov 2025 10:09:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 10:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762355353;
 x=1762441753; bh=h6zaWCmbbDrJlLgnZfZtbe0g11we6RvIOnI+n5KdrkM=; b=
 rt0sgXDV5z++E3O90WgN8YvZkdG99FOX8djabMDmGa7xoVK9X4ZRlGxJnABYF9de
 ZJajkDaltPgAN/ispsFal3bqT4gf0g9nrHOxSlZrLqJHAoRHKFGkY6SLInASdidz
 UBdAPoIwlERgKhjCpeO7VStcrgq3TuXHfhPW9zC8crU9Arq7g0qPAuTWpyco72x5
 ygEbd++k36C4SEoObCMoxaJ+EUZjBz7fPwLnWPafI9ZbCjVtMKkNxUJ4tuS/+bzL
 iBYFssuNGZPynuANqhzEnLfkc/ZZwv708JM1PYzC8yk4J30As9yqs6/Fl/GtOXk3
 AeI3PlxUXcApgItAfZ216w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762355353; x=
 1762441753; bh=h6zaWCmbbDrJlLgnZfZtbe0g11we6RvIOnI+n5KdrkM=; b=G
 S4A7q9D6Za+irRZ72E+gyfDdIWRftSCm8ARx2VFizKPK93Clks9HUiM9wErrgpVk
 zhaezOKWzIeHz5feM0rRtUdbmWSQHcL2FfUfAcrPdhVKo5kkb0132WETtkf8ejF6
 MaOFf0qhjVueIKOGPBBAiV5u6Q4cKMrQHC0NUTfqIuVQXGP+TRvUspRTdP2ZkpYR
 9aqlNcI+hePEV4+kumEWXvj2twtGstS8i8hZbL6VhCcPwqtXD/mwwy1s2X/2amAe
 w7PAoaGENQ23wjgBdFDBwXhfg+eKfb1Wc52WU8fRwh1Hn4Sx9EDVL0Oaxc/vLmgw
 xMC5lCGwwJFynZzURvZow==
X-ME-Sender: <xms:mGgLab-Jvt7L_DazBOZC8ekPffjsu5wzikR4mqiGxBX24FoHwuJ_Zw>
 <xme:mGgLacArjkKvaVt8GVpPWJrtS6L1cjyCwBGEfCwgaItRLjz8JMbVqF51x_TKLPcDB
 oBTc9jEVKR9NNSSDEkIZ0-jjP0D_I8iNci9NNfI4BwD_AjYOP2lvjw>
X-ME-Received: <xmr:mGgLaYLTa8J6GeMWrk_NDEM3rXf6N8sUTJaXWaVZMidg1PmwJgIHl1SKwt2qjfug56Md-ORvliYEkybFbH5MxH1ing>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 lhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:mGgLafnRmRFc-kBVTHuaKis8E1eg5AeNonhCkMefhgGzo_KPPhHk9A>
 <xmx:mGgLaWElLmWP27chXp7wfC04YGypCm0Ej92pNcX2chj0qnRr-38XCw>
 <xmx:mGgLafGTcQaW6D-pZDcaVqTRrQcPV_IuF9jq5WqlxVE46V8mbxR5wQ>
 <xmx:mGgLaTP_05PFWNTcgPHKACQUxOkVpvFG4eFm6i0nIIXvWgPu14Ol7Q>
 <xmx:mWgLaQNv0xqr66mo0n6GWfWCEc02CwSS90v0zOP0d1BZrfd7Sl3su_5R>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 10:09:12 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, lihuisong@huawei.com
Subject: Re: [PATCH v2] config/arm: add HiSilicon HIP12
Date: Wed, 05 Nov 2025 16:09:10 +0100
Message-ID: <20339932.gIjEHFZm8d@thomas>
In-Reply-To: <53e527b7-4c47-4419-82e5-e02f00273f3e@huawei.com>
References: <20251028084259.4925-1-fengchengwen@huawei.com>
 <20251029011626.9298-1-fengchengwen@huawei.com>
 <53e527b7-4c47-4419-82e5-e02f00273f3e@huawei.com>
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

> > Adding support for HiSilicon HIP12 platform.
> >
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >
> Thanks,
> Acked-by: lihuisong@huawei.com

Applied, thanks.



