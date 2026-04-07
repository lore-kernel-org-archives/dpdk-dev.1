Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5418EDB7F0
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 10:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B98674025F;
	Tue,  7 Apr 2026 12:35:37 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 8976A40150
 for <dev@dpdk.org>; Tue,  7 Apr 2026 12:35:36 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 11CA914002FA;
 Tue,  7 Apr 2026 06:35:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 06:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1775558136;
 x=1775644536; bh=F1vWAufNHuE9yDUtm0X5rZNfBGnIU80I9YLXhPKQkvM=; b=
 hDjyTX2iOz00Etxg9S74YmHup3UbHwRHlRVYzQRpJJjpN7kWfTPpP5SULUkw6Qmp
 By3Reuz9xO4wJtWK99ilCgaJ0hwekuRCwhA9arnvDUUe95bKRncoxydLQSiNVXz/
 RL81Va/fSFiu/guocy6MAJ0xv6Cuz4ppDtOTVTQwTLMri/E+BZ9sCy09uGkbjhTf
 modhy/u8D3N5ox/3WHDjShn4czOu7w8kFWQXVgDJpZ+1MHtdMdX2wkHP+LpoCL/o
 s8BTMxbrWn7bfwbOvbj6SI3bqPZKMKYxhM99Pt1Q0R1wSOvviaLEDMEjMjETCt36
 kJZ2WbCABLhmMDJ5xpR2EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775558136; x=
 1775644536; bh=F1vWAufNHuE9yDUtm0X5rZNfBGnIU80I9YLXhPKQkvM=; b=Z
 z9rRXGIaHxYk6TPOS4i92zEe2GRnDoElaJnEf3ewc4fJRZ/wwVmmnfRsFYGdZ0qI
 hta0cTMQ3bq/t3B6cBt/FSOIjn9TacsDtWWpsubh6ktC8jv09/vt12MMmGUYcF/6
 fx+0uPG074efJ3xvvn+CzZXI38t/UAtM4by7JWFgRieYQ7wFv5Atze+PKgjeSOh/
 CSmYhm55uWlaQeG/e60U5FhOaUg59/+uO0OPqOJOSsSbHCqOF55SkgTiEKas7bOS
 0qrKClHnJNd9ewQtlPJppArHerPwHKxpRjlIgpBxdvhMOm0bRr6Vsi7xZhaM7XRW
 Yeq49rrUaD8EA8Kxct15g==
X-ME-Sender: <xms:993UadvHfhRt6GyT4maR_um2TYnDqovTj6PLE9gMaMt79mAk8PnFZQ>
 <xme:993UaSzHGIvQJtVCQFn61ZAxYJrjaQgfMZSs4G7dPovBtE-7nMchNCGBjajZ5zm21
 h3W48xed3d-_h8J8ZZx4-SKYqgktW9IKjrLeMjnTxRCZKACRTtliA>
X-ME-Received: <xmr:993UaThfDVAaZCuzK6baS2Xov-s_bSow5ltcCtvfZnIlKe3UkAsJsTZaRDDKY0R9jAUS2lLYlxIivBM2S0--Qtzmgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:993UaWB6cUmMst0nds60R0EIWAQb4NSQYWChpZEfFd091ZGHMMgVCQ>
 <xmx:993UaQtRDH7_h_7uSLRLl4iOxvdq9W9ZvepA5DudVz9-JX7b39AlUg>
 <xmx:993UabasDCRKdkGW23FVBXf-a2zYKGXhkITMXTCs4pzBjkU5dQBZvg>
 <xmx:993UaTWLH7JezC7Nn83b__X7bG8i4vMPMpfmcSuZpTITpc9CLbavMg>
 <xmx:-N3UaVPBHF9DYfihQm666op9FB-V4u5ZSR2gKjilQDHH6rppr8el0Jve>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 06:35:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add link to mbuf layout history
Date: Tue, 07 Apr 2026 12:35:32 +0200
Message-ID: <3499650.mvXUDI8C0e@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657D8@smartserver.smartshare.dk>
References: <20260407080544.614206-1-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F657D8@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

07/04/2026 10:44, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > In order to illustrate how mbuf is kept small,
> > add a link to a page showing the mbuf layout for each version.
> >=20
[...]
> Hadn't noticed that illustration before, so good idea linking to it here.

You didn't notice because it's a new page.
Thanks easter week-end :-)


