Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8155CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D8C40279;
	Mon, 12 Oct 2026 22:53:28 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 31D3A40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 22:53:27 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 6F52C1D000E2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 16:53:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 16:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791838406;
 x=1791924806; bh=OHj9CxjgEoQ576YF3VYckh/j4Snm8qHFX5/V8dnjBfg=; b=
 nJ525YGIh9oxfVvqGJTxsoih/3DxsXf3hE36rQyJboxjsiwUOSiv52PAnOKoqYlo
 axDrKfz2wvL6BumKJN/LG0U/VEyYvqAlF8hxIje6dcrEFZ7WB617KlPiVAKOVc1f
 nhH7rGyaFeV78yBHpKzRPLgO2YDMHfAuOFSF4RZ4pA7kM2PJCq/zYUh93ByCsEgZ
 2X8EO0mW0oC4ffGqB5CLjYsbCogirANzq8rChbJ8TOXDYpJlveQ3xa1LE0s1JcLk
 ItDQvONuNCPIg1kPTKjr4gUTZ5X9LtY2uZk9BRnifYTBFdXbaGgqbaYG+qDJrcdA
 MmDJ8Mt4fpwBh1hS7rG/Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791838406; x=
 1791924806; bh=OHj9CxjgEoQ576YF3VYckh/j4Snm8qHFX5/V8dnjBfg=; b=O
 4HDFVAG5cLboD0gfN9Znr9cS7maOqJe7yiT0Y/WdhDS7B8k8kg7u3Wc3wFT0/zxw
 vCusyg8XbZ6DV8f1eveRFifd4f1zuNcafR6cGKmTrjSP8RFigRkCVw4g9RnbOX8O
 UFAUGFCQBCX7XlCLESCXJIkirv+SeK35NzqZcO5tldqU/y5Hju99b1tllG+/Wrkk
 lm0R+jyIwnGAsgu6EVKaUIcKoTVyL1tczgmTRgDqQhPmxQB+g9pjAgE8GwnrN6NC
 nYuiv3ghHpmOpmkZoXXYtN8IjclXEUjGeIZl17g9k4RQ15WOGHCZ5Pwa0jxyGmti
 XDu5CbR28uK5QUDRKRgwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791838406; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:OT/jcq9bjty8THXyUp8bLLhYBD/K8GWHjFy1qbnHhKSJ5G4
 eRfk2mSXEp4xCKo1WHoeOnrRDfNqomz5pv/R4/ULKYEWEWyp2gZZD+4m6rBAr59C
 fNyP3g7BlMYK17mPkbbn3qiMkPIhRqSWZFArN8rR/saoqnqxG7cgdKLEeY46BWxY
 GlpQJNCyHd/o8DmeKiH1NibKGysUfEUhJClJlW70c/Vx15TyZBtf4RgqqOGjCCdL
 7dE4cOSXxHoPoUGQikua8tfph0g+4Z+bk4QUMBISCARbAbOwIDLYgZcSvvhfUQA1
 R5p9mECU98B2MV0qozFbYDe9FdfxJcJ366XMzqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:CSFT4zz2lhFMd7glqPFG2CbCLkqYUJEAH4RDTwXp138=:8mvXj5kociN+9fBTiOm4gH2pqhQRKPsLXfD9jXCM+nw=;
X-ME-Sender: <xms:xEjNarswXG3X6cVpizacXkNCf0hxdQM2acwcUK9Swd6zHmu8hPXSzA>
 <xme:xEjNaoe_JFsdevqhWlcPToutKlEIzsvwnePCvVC5VipE-uraqms9d-JEvKMHw6cTI
 gcFGf4RAcq1tVuN4GLPOsJ8Ugw1gh2azWDnhi_PRC8qe7bCWcFsyTU>
X-ME-Received: <xmr:xEjNag8n8Pdg_nEBTewqpdJjSx7QIhxWCF4AgFB1QZS4UlAgnmGTtP3JqQgN2upEYMtGsc4p6bryntFXsCktl_Y>
X-ME-Proxy-Cause: dmFkZTFZV9RZ6vwZxKwAxP0rX4nFiiqAEvU7E3K/zvT6pE7nBzt8qHYY/qyH0cPfU6+2Go
 PI8YTWlu5Iz1bQarGgrAWeqt5EcM5R8heE0MlLTxx229XXdUg74wLP6fvToAemg/YAFOGJ
 3OAdHt0t1AcByIr6Uo66jqPq5v+JKQoh9HUMM5f/HPVmAj8r7ehP+YFTMxtAzehTLu7LVn
 q9XSlqIhZk1/x2tx6CBCf4lTqkA7Eo0bbAkJMsytQvc2BpY5IX4Kbp+H6zUVyrY6DjchH7
 e17OTXMXEXa7LqKSI9EfrVgtbDQUrr1ws9xlGe/cTiGFPvEJpCvxAL4XAxlLYc8qoyrhMH
 XCHQfxDWQz6pxSjW9zbFcJYByCj/zX2sVYmzOvasHqJfz66Ba+YA0k5yCrdHdElOKGFMnC
 MZrODMCmL1jLHdIMXtNVNFcIe9fxeMhb+Q4LytfWYDL6Av3sta5dfD/7iFD6KBH4kpcbg6
 /xTW80LLsmd0zxWXO99/jMLLRCpUzKlcUFAqY0oFhuDj44XbJfVn8uKKP11aT6ufBlPv5a
 8/XE8Y3Q435KubIK0RNQ4A9QAonQUQz6Stf5XaGxY8CuzqKHP9UkxSV9jTrOqMPcx534Bw
 j1XVCKXao9N76hw8MKnUKPi2OyKjALX7ZcowNWIOHE0EuzjqG7gk7/b0vaog
X-ME-Proxy: <xmx:xEjNarT734oSRyNJAdnoeBwivApy098sq1avJNQt9hfKm-U4762I8A>
 <xmx:xEjNapq4jwbfImE3ZPbHsELOGsAuBhPFaxq-D54siZCjOkyxSoQ66g>
 <xmx:xEjNagmrkLKamrY2M4okWaMiz0lhxqa4ymgi-BA0HUfmxvZWp_iY-Q>
 <xmx:xEjNaqcYD_1TXpwV6YCAQcgNVyqOeZZcczdiJEkNv5oD65YD8pC1Dw>
 <xmx:xkjNanX8eZnRNixZdDal3lO7-HYkA_mtcEBhBKAGrzd5C9Dg5hFEFGeb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 16:53:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Aleksandr Khromov <haa@amicon.ru>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Robin Jarry <rjarry@redhat.com>, konstantin.ananyev@huawei.com,
 olivier.matz@6wind.com, sdl.dpdk@linuxtesting.org, stable@dpdk.org,
 rrv@amicon.ru
Subject: Re: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Date: Mon, 12 Oct 2026 22:53:20 +0200
Message-ID: <i7mEH1UETDSvlR5D7MTk4Q@monjalon.net>
In-Reply-To: <20260929072153.56119-1-haa@amicon.ru>
References: <20260918074729.79205-1-haa@amicon.ru>
 <HTNMG94CQuKiMcKhE4so4g@monjalon.net>
 <20260929072153.56119-1-haa@amicon.ru>
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

29/09/2026 09:21, Aleksandr Khromov:
> On 28/09/2026 16:18, Thomas Monjalon wrote:
> > Should we merge this patch and expect another one for the endian issue?
> 
> Yes, please apply it as is. The byte order problem is a separate,
> pre-existing bug that only shows up on big-endian builds, so I would
> rather fix it in its own commit.

Applied, thanks.


