Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B927F33810
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8C3402D1;
	Tue, 17 Mar 2026 09:24:32 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 9D4D740270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 09:24:31 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 28883140001A;
 Tue, 17 Mar 2026 04:24:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 17 Mar 2026 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773735871;
 x=1773822271; bh=N2ML/sjIiRQrwb8PyYJ+07FeI9Y5qf9W7XPy/9juTZ4=; b=
 lQWcqYd8UJ4HxtFq4qHXHeYH9ImPI+aZDn/h89goctyz907kc3JD3MYymCv03BQf
 g0ip44vLNKEuF3cypH3PCBTnTU8f4uHNotGn1vT2hVV3bVX5jM9Y48MC0z3wT2KF
 baz5UDx2HaYRYQDJC7dtlL26GNhTG+fakqMi2eujOq4tl7+2r6KVNC6nE3Bc7FSN
 zvJ7/1+oJ2D6CeN6CH1AZ8Mq8jgs2IVV1ymWbJWtcbFX0778KG0O0KPusmddPhW4
 t/xCbdqAIgbC1+wDqkMNJDRmj+tlFnm79dzuMTCIB0CaHuMofDkY9ngkYzwGULX5
 vlh5YicU5HZpjOxLM3N8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773735871; x=
 1773822271; bh=N2ML/sjIiRQrwb8PyYJ+07FeI9Y5qf9W7XPy/9juTZ4=; b=Y
 kjXuifmpB5PVpnPdE1LVhbBPvjua/QUlnO9hJKg1J9MBTfhgOX3XDfJDU+nNmyTx
 UC5QBqMj757ITfs6pBUZqCRvNsjyIuuCBwelS2k1S0mOOWBnOHit2JOdqml+t0cw
 9IeooAc6lpLkb92+mpKccxn9reeeKHXfmFCGCzEOpmbBnJQx9n+u05hkopMjDemP
 aVp3QxlRSwuqL7DJCA8QhH+R7hgBfkEuWDJSgdWxF2yga+Nx4igVQFh+jmrqDjKC
 PzqNzPtXjGfUNvkz9HEHsNCIu6NHByGiziNT3Sl4mmUJGhiiIjPudh6IvtC4bCrm
 j1n6MjbyC3nVRaKGrevaQ==
X-ME-Sender: <xms:vg-5aUhsTH4ZHdQAcB69tILSApWEegEmzWrylozTKkXn6h5VLKi8GA>
 <xme:vg-5adJLxLzNRsUWhd81THoX9r1OXGmaxErstkOJBZDydq0zAgRlgGsCrBH-1TZHS
 0xB6WU2Yo4-IxZhM4sq50aKPxKra4rYpGROm_TpjuW59fpCGNDfOQ>
X-ME-Received: <xmr:vg-5aUD-HSvSIxmTOEj0PQoQJFW3lmJND9vGlPD3nnHA8G6DPgvzbPN9sLY57p580iHm0UTBaJzVz1bFw-hJYuKD5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtjeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 qhhirghnfigvihhliheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuhihohhngh
 hlohhngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:vg-5adiBYZTj9Hp4daPjVt91PEj_BGTgJSEzth4Ww2sC6tJuLK4OIg>
 <xmx:vg-5aclmNjlSSObMMtyIEwYa_-7WZO9zpBpzKUA2_sVpLmc3we1xmQ>
 <xmx:vg-5aZpn7iQdPho0QBhCv7wKVibIf8h1S-0kuRyiNiv4fluZ3RHxVQ>
 <xmx:vg-5aVGuz6VSlm5UaK57t_Fy5rq27sr7klMak49fuRr8hxgPbI9sPA>
 <xmx:vw-5aUjXfbP-ocWuxgDIDXftNouMrUnkvNq-9xvYRirPwDpLIZtb9-Tt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:24:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, qianweili@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH 0/2] support driver forward compatibility
Date: Tue, 17 Mar 2026 09:24:28 +0100
Message-ID: <2768879.BddDVKsqQX@thomas>
In-Reply-To: <20260302110206.49670-1-fengchengwen@huawei.com>
References: <20260302110206.49670-1-fengchengwen@huawei.com>
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

02/03/2026 12:02, Chengwen Feng:
> This patchset supports driver forward compatibility.
> 
> Chengwen Feng (2):
>   bus/uacce: support driver forward compatibility
>   dma/hisi_acc: support driver forward compatibility

Applied, thanks.



