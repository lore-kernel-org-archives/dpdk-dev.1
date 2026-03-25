Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA2109E52E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 23:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 874A6402C4;
	Thu, 26 Mar 2026 00:40:55 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0AA9440285
 for <dev@dpdk.org>; Thu, 26 Mar 2026 00:40:54 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 74356140012A;
 Wed, 25 Mar 2026 19:40:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 19:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774482053;
 x=1774568453; bh=mQEryovSgvxzotWXi9QLyDpgJbIAn7UGx7QNeYv8Yc8=; b=
 D2iJNsQUs3tIYizbR5vz+gVpCnHf4wNwT4sdttkVQDk0F22VaNjdtyjh37SmV1Xz
 2uLTGM1W42DVcydzr/785f88C2H15sVorjiwxBTdQlw6FAAH4iW5Hed+BMsujCjp
 V4vnqAq5uJwEuCLBnpR/vNzZqwUMSbMfbrpIf3Q8hh07lK/RfenoDr32NnfDDJgy
 lmucBYeoGP9VXLwOD9PsvaoUw7sp+xgRpOcUmEj1Ei+8FMds1HVYvAqhLJEEbS3X
 xfwL05g+0/HsRdGvgqByf0h28bd8hFOw5Ckv9nmkqZ/w9plHIBfCqZe5dSz5hSp7
 FiJ/4etM/R5Yyq4MA8st0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774482053; x=
 1774568453; bh=mQEryovSgvxzotWXi9QLyDpgJbIAn7UGx7QNeYv8Yc8=; b=R
 BVQuBF1NkrCuHcE0tcvj3s/iG5PWAb06euW68a3sMqHxqqtHp6Qr4Ixa8pLpyY9v
 wZcnXGM5az03pkIYvq+yTeBBjDWD7uWOGcUEpliDuJ30/H1EKgAsO7WIxiOdJiGI
 HJ6jkwfD9YB0x8cskkLvgEnLQZY0niC+zrzcy2TTWcKlTGkTvSo+AkMPbZ+fFGkc
 C531B5f+MFo+RkHVTbEdGbjXuZuYc75fUb59POiyH0AJW731aiyLDbNcUSltVkmI
 dzIV+yCSiEa/Wj452OyXqAOdukxRJpNRoKUbvtycJSMRD1MRM4ATHhfQAqNHaTuP
 AsVZK0eYKe0P32t/+weUg==
X-ME-Sender: <xms:hXLEaR8VPEzliIQjTC0e9jYUwRzrA9JkFZrpa-Vg9vtAKfTM4_qZiQ>
 <xme:hXLEaaDDumiss2OQG2S4Eq6nywyQX4EfdA-AF0oke9PIzO22jWPW619-JaW4hoCky
 MJaanO1Z9TihOm8EcqpvDhxHiEvdXnxg7Zc7xEBedO0K9srJNBx-Pg>
X-ME-Received: <xmr:hXLEaeK9W1ZE6F91lLoGrUaTht3EysHuUYZQJmzNLDCQox378vhBl_sWCGHAjYUUMT2owgYaG0MZRyDLPJDndwA1-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepohhrihhk
 rgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:hXLEadnc0uv9PcmCyFFd-ur47IjaQaeMZ8nNGyarTL3jsn22ObdJaw>
 <xmx:hXLEacEGvdXcFq_imUHEv1fhJ5CfAAyBJvdHYC6IGT-SWId1cq_uzg>
 <xmx:hXLEadHJQ1a6jk79lWO-zGwRtLMlCVivAbxxAASkyMtpu3_1QMtcqg>
 <xmx:hXLEaZMvPFcV8zS66FQIEu4bRg2f6vy232GfDXvi9su_56tVSnerrg>
 <xmx:hXLEaYtdgvlZ6EXM4JNr6MHMPPq3TeCMmfZVjKQcAzcHqflAuWfgpfZf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 19:40:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH v3] examples/flow_filtering: add more snippets
Date: Thu, 26 Mar 2026 00:40:50 +0100
Message-ID: <7318516.0VBMTVartN@thomas>
In-Reply-To: <20251202095022.263763-1-shperetz@nvidia.com>
References: <20251113101347.162908-1-shperetz@nvidia.com>
 <20251202095022.263763-1-shperetz@nvidia.com>
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

02/12/2025 10:50, Shani Peretz:
> Added the following snippets:
> - Steering by Integrity Check Flags
> - Match packet type
> - ECN in IP Header Modification
> - Random Match
> - VXLAN-GPE Header Fields Matching
> - VXLAN-GBP Header Fields Matching
> - NVGRE Matching
> - NAT64 Action Usage
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Applied, thanks.



