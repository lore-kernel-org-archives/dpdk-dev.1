Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DBC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 18:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E201A40612;
	Mon, 24 Mar 2025 19:48:31 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 2A3924042C
 for <dev@dpdk.org>; Mon, 24 Mar 2025 19:48:31 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9B22411401E4;
 Mon, 24 Mar 2025 14:48:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 24 Mar 2025 14:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1742842110;
 x=1742928510; bh=WZVPVMqyX8zyd8kLVsbfFZW7UIke7vkbRMS95zmjVDI=; b=
 CkhYsQyTuS6sv7RuoqU49iWD3DK252fBcsETXRj7QvSt7l87Jh1kKQyU9tSJ1rue
 cKVjsYwML9WLV4FYRxx6oVoc9Rn0CnFWiMvD18u8Ys0YcaBKOc96zZrqz3mBMmgx
 oXly9GtNTEINZ1sW6/8cjmYsx4B8uZnQ9pPm677AkTgcBXHC0JUNgYZmOxvdPr+K
 Dzt6kzu1lWmBnczm7P1eTw/Qfi7fcS53JyTIfA87ue80kDAOF3DbqL+MBX18AXVT
 XTQqxNR/caGyGqfpZTmdZxE6wMQYcvUHQuwQSoxT1eLgzB6GlWWihLVJoaN9opft
 9AQ5BzRjSEfZP8l1l2CTqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742842110; x=
 1742928510; bh=WZVPVMqyX8zyd8kLVsbfFZW7UIke7vkbRMS95zmjVDI=; b=l
 thp21kJB8BZp4xcJTyLriv0Vs8F93EdXXYYDcyhBWm5QZHTz1hqGukLtzwHQl8aN
 lVTOWFI1O5bOYuJIRvC9iF0EQIsXZA0OUUnSVqK+fDj45AD4sjCIH8n/9g31k8Cz
 xE0VG5oYpjGitHCIrrfhHxZvJA7CdtojXavxner6b2IfyN2U3/L3SB+7cc8qGNwO
 zKDDuugICrffEepojpnvlfgJXRkD5ufutfxAjEdeIvfbcrByJQL8PMsfgTiIYVd7
 +8qhacAT7tuc7JNY5Ot9DIsU34udYYDtMJO8dTalqsMEk1TnlzoIgBWVe/yo/Xev
 QZJjXTkS69ydCrrHXBA9g==
X-ME-Sender: <xms:_qjhZ67m7BTW4mFRa8d40iLhWR9yGDnXivOOEmZFQydaFeVId3f4hA>
 <xme:_qjhZz6ofJRd9bu4g3HBQvQRBF66SnK1S9z_iJDfdpfi7ZBfoulSPFwOqFF8j9ReS
 -z0WyqotJQe3pPeow>
X-ME-Received: <xmr:_qjhZ5euwwzOju11iT7Ski2O2sX6DJlQWxwewz0uFQhA11O6s8r2bggbD-Ri-_6Y-XKFEhLHSVkZVESHmN-e6p2vYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehloh
 hnghhlihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehn
 vghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeifvghhsehmihgtrhhosh
 hofhhtrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgr
 thdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:_qjhZ3JsRGj-wvCtgFqzFpuPHgvDxjDrSqQaupWUuU3dmcvHRYL3TQ>
 <xmx:_qjhZ-Jc7O_fgZt0xgCjwTISlRs89UV59VkNIFer1EZc9F1nF72JKg>
 <xmx:_qjhZ4w0VaAqCFZOwVcPIjFA_CYgP1T7BRBVEIS2qtNf2VmrQDi_hg>
 <xmx:_qjhZyK5Kh3a0b2tyfEMec2eovZZeh09Ubpn54B87UnvcE7Ep_Brqw>
 <xmx:_qjhZwjTvC_Qag0BZ03FPocz34WeMgXM3H-cGTFSsI1BD0d0heQXTQjx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 14:48:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, David Marchand <david.marchand@redhat.com>,
 dev@dpdk.org
Subject: Re: [Patch v3] doc: announce bus/vmbus API changes
Date: Mon, 24 Mar 2025 19:48:27 +0100
Message-ID: <4683947.Icojqenx9y@thomas>
In-Reply-To: <1742242184-19600-1-git-send-email-longli@linuxonhyperv.com>
References: <1742242184-19600-1-git-send-email-longli@linuxonhyperv.com>
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

17/03/2025 21:09, longli@linuxonhyperv.com:
> From: Long Li <longli@microsoft.com>
> 
> All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
> It's not feasible or practical to use those APIs by the application.
> Those APIs will become internal in DPDK 25.11.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Applied, thanks.



