Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC77606A326
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Uvkow6zk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=akwCWGG8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59164402ED;
	Wed, 25 Nov 2026 12:11:00 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id D86DB4027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:10:58 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id DFC59EC0C36
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:10:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 06:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795605057;
 x=1795691457; bh=RbDaPkZtGi7d8Jm13qt7wsHIALm7/2LPRgbTNPufIfw=; b=
 Uvkow6zkAATpIMkAv8CBCl1aPdDy1iilMiJ75nYjhGsIaUPW57kfdCEYw960wLY9
 JjpnfvXt1UKMcqvXcbi9miRZqGVT+2ZvFzQj8SjQuEtyyssflK4tw7RkV60Az43s
 W+Ub/SBcG8zADeO8NECkZCK3TtScRFW2Cyka8wnhQOesRoWf+ephCS3j7n1TDZgE
 Msz0WmuT7cyMGjs/rJY0AVbqGZmujOXkDDhoh2QoT0wuDci8FmfcNJamZnbfFcdD
 bVqGRs9wdxYzksWvVrgpruGM/kHKN0YvrVFziWf7MrNEuYdZBv4PI+WiqUo83Ey7
 YYCHI6sQhjFlXbFeec1ifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795605057; x=
 1795691457; bh=RbDaPkZtGi7d8Jm13qt7wsHIALm7/2LPRgbTNPufIfw=; b=a
 kwCWGG8RfhzqCsj0igfIgU0MHdJgwzKCZoBD7UYUyLqerggv8xtEdXKjF4FV7XjX
 tsvUVqAXQ1zmtVAHhuff2qOrD/9OOaMHsLALi7P+eR0psnsGOcM6n58oQ3r0Aubr
 SoOvXv6AiaRXV0O2NCSWni+rdyzUqGFZcgNRSGAuvL//NPKCt+3ZyJZYr+0C1gHK
 Y49t0K5wJbQjHRjuibVSDJj0cKjpbsXrzadNojnTSmsirHNJCi1sQaVYa4B8h/XU
 hGcEf8V/tF0TNb95DXy0nBy3yST4mAyvmtQ+r+Y4UiusKuAJszGnMCYiVzeUPcDe
 OcdkQUqgsSN+o+d/7Cb+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795605057; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:y3cWm9xL0Nah/5e7TwU3cjUAXQaMVwsODA6tPh3sjLQrxdf
 b71MJPlgHPdO5z9SzOYs4auHi59fR+aBFcEF8RWCD147OxjBDHyHsTp3CWSZCHzx
 1Qgs6Wd9uPpx/WXBQp7C9j/dR22wS3U9uXth0yv32jkQr+qnU1rNHguzZCwZPpVC
 6kHm85Te8GpAN84mU0DEVq9011XJn5LAK80tiMgqAPdD1nx6wSxIcGqG+UxeXKkp
 FQL33XMyoQO66eL+VghjkCeCiaJ5/d8dd+X8c3fFPCHOkDoe0uI43tRdaaKdCBhK
 QddgRSQ9lpU0yLSiyvoCnQ5MC4/XcXaz3uxw7CA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:6PMpp//FqYGVl6XbqXtRdjHFvNkjfV0UE8ICuBBSa6A=:CU6kjR29/CphBLrEFLoom29FAjFRcl/LI2gY4dg1VyI=;
X-ME-Sender: <xms:QcIGa8lKfOiXMNSz9wr6pZ-_Beq9bXSsv4sejQih3ISLxLKCFS0D6A>
 <xme:QcIGa7_u-fEQLP72auMebjG4Qe9OVK4KF3WVXX-Xo1Mo43y6ghpCnDKJOmcJtxE-s
 aOaDUM38MI-rcql0mt9eMVYy9YISMcW6-K7LpHIkV0ZkBduJTMwT7Y>
X-ME-Received: <xmr:QcIGaylL0btpi_PGtbSChGWdNd7nZRRbwDh6zFMVIhKfxEb5AMfAq_Xyzy4cI_nqobAd8yieq3x8Ny0qu9cFwmk>
X-ME-Proxy-Cause: dmFkZTFR/151QdnbI5NRRn9W/OH91fQvM2PCXwAgkuNi5hEncQg5T6qadvrroVoQ1KK0tK
 /ytiLZTfMziSTJeMGdFbDivF+eViGFgMsci8ZAiEDuB8qJzn1K4bAu7PuyhvhijiR3GXU4
 wOLf4kgQq+L9yfYOf575rhvrjC4G5T56JlhZVKB/nLVQnfucW/khcF6xxP7dBF4h7di6VS
 dj3ZDUH/CzLmigym35Pig7T4dHKOGX4dyV5r4X5DVxpGPXaR4ac4fMrZPYVAR58xUzbIMj
 fHQLrn6DAtN8h9aafD4bGqd9Tw0lU24mt95Zf0Ejpn5vGQiSy/VjpoC0U9IA7uMpxCNFHF
 Gt47zo6Hbkr+uhlL9qyXYk0QT6CfkBFvV985F4xtRzNM64BW+6wyr0ipojRKWyTMWhcxIT
 BbxEJqnLQj2Yr6ZD617Y5Bf5q60Q9yZtzj1Jw0Z3jYsesXwTm1iyiPAkuJexS1FKpuLhIG
 dhGtKq4Tm+K7jUL0ut50NBviPrSI5pBvb44R9eyv7UJCNwaVzgyZLJc5JUcfH9/UZJ7CH7
 PBUrP4S9IVDIkZmSu03gUGiq/Zdo4MyvQHmd88zNsVuVaZHpZZIEV15hqsboYCvdwNSq6H
 LY0yvYWh5rd/zC0mVPiS2gVYoxBi+LwcPk27CFKh/hIjke+HzANdw15iVEIA
X-ME-Proxy: <xmx:QcIGaw2Xnjzrd6hv3TWthW2LIOKVVtYA1x4ftK3015OG9tHjm0wiFA>
 <xmx:QcIGa1oMIj82xcA0pfWP3tomT58K39wcbl_1GtI-RRY0EU9IgELAMg>
 <xmx:QcIGa1cssMDcNPY8Hz9XvpY2Aw7y5RQPvpyE3-jnXNahZOdY-bRfBA>
 <xmx:QcIGa8pATlKyccmEDGiaPAxRiA9xUyxi-mFOPdZk7EpEL-XLpQN6oA>
 <xmx:QcIGa-9GhUNsGsA9hquhhaGSVC3giVYjfadneP4FjbNL8DAuwsB3XgLR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:10:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: abhinandan.gujjar@intel.com,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com
Subject: Re: [PATCH v2] maintainers: update eth adapters maintainer
Date: Wed, 25 Nov 2026 12:10:55 +0100
Message-ID: <UBz-7r7XT2WEHHqPi1OzvA@monjalon.net>
In-Reply-To: <20261125050626.3502712-1-s.v.naga.harish.k@intel.com>
References: <20261125045437.3486804-1-s.v.naga.harish.k@intel.com>
 <20261125050626.3502712-1-s.v.naga.harish.k@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

25/11/2026 06:06, Naga Harish K S V:
> update ethernet rx/tx adapters maintainer
> 
> Signed-off-by: Naga Harish K S V <s.v.naga.harish.k@intel.com>

I assume Abhinandan is OK as he is already maintaining the crypto adpater.
Applied, thanks.


