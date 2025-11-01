Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA3FCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 11:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC8B6402D1;
	Sat,  1 Nov 2025 12:13:36 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id F223A40150
 for <dev@dpdk.org>; Sat,  1 Nov 2025 12:13:34 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 313197A0104;
 Sat,  1 Nov 2025 07:13:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 01 Nov 2025 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761995614;
 x=1762082014; bh=qFuJQpsPsOQji3Wh3a8EOf1RujWn/9pEnQ70Vo6dwzM=; b=
 CxYorCvVAQYysdiCj5Ff64AqLxIHxI9AQ7fNB4o+tRTV3sHOmGtH4TeEViRBWxEU
 aBXi7KbV6ni5s3j2EXqLVY42ZgE4kmC/iLg8eztpp0XWDAl10UTlingnt1mcXOr/
 7DhUoq8rL/4UGSZTjCacJCbraAjo3QaEiypMmZ/ABehynVOdPiftr0bS7xCudLrl
 TWbN0q/bN2spQkGqz4J5AQ9epqnJxkhks0YqYVJa1vQnHJW600MdGcN+6y6ZyBfA
 FjLYUleiAqzewt7+0HbooKpW6E+SXI4h+m47Yjs66SFzPa19LwjMkINO24KB+pBE
 vFvIlX0/n5dHxFKXzcMnRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761995614; x=
 1762082014; bh=qFuJQpsPsOQji3Wh3a8EOf1RujWn/9pEnQ70Vo6dwzM=; b=Z
 0ugIshjViQRVPTSgHje/CJa9ogFfM1L0yzOLFkxo6+vj1clvN+HJPt1FjqVUFo0d
 DuhX3C/R37UdG/XzNo6ZkxLNgP1rLCXtI8VKq99KPpKpBXNRuZWZ8NYnCDVCZTuN
 s8/S54DZIgDucb2pmdkq3b9EEMbW38f5DDFzpgjgs2CfxJxiFfW51GsWB9czUF0x
 kh/6B7qFOnj46CFy+X/QhPg1Vt1670f2ZLmDay6BTDSfM1r5SWYr1mJ0QGFRI4dG
 GZpO/L8LFDa9cPv5ieg08cqIeXdq1ECRsAo8tOVFq4mTSoOXsExwdYYMisIGZkS1
 nngjLk7i6Zu3EGdiLuskg==
X-ME-Sender: <xms:XesFaR4vmjZhXEjAZlbGZQNDhxbbF8tCrc2am4GgZgwbWm_7v5VQWQ>
 <xme:XesFabPwTfs8YL7II8Gx_heAiaozWBrWbPPClE49hn1CMgcqGS2xlzCo901ErEOkR
 rmHbbKIEf-qBHI2MbEBatQ2UVXTc3e72D_rQlQpzczXuAcuBhewvg>
X-ME-Received: <xmr:XesFabNXczR9pdCzx-qey0qv8wjDXMkxmFGvwQwdkNkDlhJ2ONpB-w3E42Zf8d_FgeyxaeP51paW694lQEtp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:XesFab_IfuEIpbo3zEEB4VF2ESIuUTyazLshZVpw4vmXCTVyB7dvDg>
 <xmx:XesFaX4JtNEAbohqOzLCVpfQsQ-qLaII1M9TgMFVpCGpzv4VA6DLog>
 <xmx:XesFaa2HMTYQrA1P3fP8alDyi-jB0MK-N8CSu06RCWkZy0Br_CIZ7w>
 <xmx:XesFaWCwPpZQD6uKHNrYd387b996K3PJtpx7O5p9J1R7SF9abDkj0w>
 <xmx:XusFaZjH434asBE-sc5snyINa6IobmN98klHFJ3ZTT5mXq8tWupahTfR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 07:13:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] doc: fix note in FreeBSD guide
Date: Sat, 01 Nov 2025 12:13:31 +0100
Message-ID: <2436889.dTVjPilprF@thomas>
In-Reply-To: <20251031115342.4064625-1-thomas@monjalon.net>
References: <20251031115342.4064625-1-thomas@monjalon.net>
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

31/10/2025 12:53, Thomas Monjalon:
> The note about the prefix of the package pyelftools was not showed
> in the documentation output because the syntax was missing a colon,
> so it was considered as a simple comment in the source file.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Fixes: 9e6f75e259a8 ("doc: update build section of FreeBSD guide")
Cc: stable@dpdk.org


