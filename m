Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA5CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 22:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDC642E76;
	Thu, 11 Jun 2026 00:46:12 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id DEB2C402C9
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:46:11 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6B4C61400108;
 Wed, 10 Jun 2026 18:46:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 18:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781131571;
 x=1781217971; bh=GINnlI9WA6DXhTFf2n3+tT8U3geRbFxXdZgp9XK3sz0=; b=
 oPAtY/IA/z1L1Jk3fZXT1PLei+UsGFd1bnL9ZnQHDh4EJV9i9TQK39NUKeynLjk7
 PSkp1X6Y7GUnwCpo9nf9/IlQGrnhpKmQ/E819Z3BEhZx52yhNM0itwk7mwittF8y
 BglXzBf1LUJcM3l+U3A7MRTIPTlyt3RzIW1jRv/PCO12bdKaxvhAmuOSGhZpemSs
 jG6KHPyBx33X2jNUlsrwqG8EhtkPyzXW3AI35xZuFzarByLoSODxSyC1gfN8w1iZ
 wuw8m5UPULk4bMKsucDG0NRUZcm0q1y2H8LxI5BlC+ilMLMgZmqdHDhOWud05AUx
 XheMRYFepm5cvNesyzzMfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781131571; x=
 1781217971; bh=GINnlI9WA6DXhTFf2n3+tT8U3geRbFxXdZgp9XK3sz0=; b=W
 6PGTPh+tJzF/NfYHLOK2ljVYJIMg9qq+MaauMJCVAFtnzDillna+cUgjcPaIz+eA
 Nr9aJUxolXyQq/1xcKloKI2mFpUd1LA7WF0g1q5Rve/UZ5LZLu6dJXhRhNj2sd+u
 sVVtPzFeZY/r+2/JGTRpN9KlMA9ngocEz2ggtgJgzX2VBnw1oynI5V2WL2fxUIgQ
 NxzloU7LqFZbeDSuJT0J8EuxtMpsVY9q/kGUuiEgB8V9inCoc/N5Cy1NKcA+pE2m
 1Ll7eSKXKuEzqRCFTSaA+mYNFNmQdxl3Owq+rMSkcWr4GCJ0gWFnrlWsFwz3SgoY
 YgT5xdMsYvJScUb23M/xQ==
X-ME-Sender: <xms:MukpaouNfS03RlWx8NA2lQeBaLL8Ej77kdZX59KEhephinDDuWKrJA>
 <xme:MukpaviFEYRGxoyEI0oGbNBTjlXww-sStaI6nR-vyOI62THV5UJqHrM6gQ3_-Mr9B
 shYmE1iOqeKfXZOcMRQR61UGH_0uRPHsr_1jkDp7WsfAhakMgbz>
X-ME-Received: <xmr:Mukpajo2Tf7pisICYkc07gfar950sFjWfudH3CJuilAeo4BRPcv0gyJLRY5eL7seaR5VkAh9Lu7qaOOm26CsuJYwAA>
X-ME-Proxy-Cause: dmFkZTGhmLnEfCFiB9AiOhwClx5BreeALYDFLkXYo8S6QjWXhaa+DhdppDndPOaD08T5qm
 MZE5zGvQjCaCtAxBMFPDf1pueAPnERsu1gMBGQ3yQd7UPBsZlMIB0eg93VezknuqDPxy4j
 aXLvXda85AQqRxKlxOB1ucgXNEPrF2G4L8WOhWrggfwHXqKnvCCxF92nbURsseY3ctGx/E
 0+7i3eturQGtQbm1JD47K5oLKqNcKhHSBnqnA1kshwpTpiLhTS7x5XESg0EowE/nW6PB6+
 iDi1zmXIMr4PK2yXJz+QWtXos66xBWVXMcTojEBoyt/jNi86NpvLxQtrzf9ZbR5BD6qTLA
 STc2i1HD6zNX5fkLEafViCCzWa7cc8hkzVVvxNkiuXLus2+ztxmZMxe/2EdrGQhfKW/ty6
 q/BWwvtLq7J2ulnSjCccz9fCz8u8o9DBc7G8gEBXo+6+/bMy7PiBGWi1Y5UVcH/qJzKvc4
 UjJBR7jNmYytI7ZyqRnSY475NEMEjeKM8S64pwgQehBMpPXr9MAwhCtnG72+PcHO2cIaeI
 nyoX1uqsvu62nuPFPUBQl12FVrOk1Wq2tV8c/9K3Clh34362Oa/lpYKtgBiQkkHws6+GTK
 fDVNRyn/xW+hoCOb9ESbudf/5MDky3vMZO1Aqt1csT9wUO7SmqifumGAGrmw
X-ME-Proxy: <xmx:MukpassteX2I8qs50XFCjvTbi7Gwto-zlbEuI7mmfiAv7Hq1kTXKJg>
 <xmx:MukpamafbSBOmaXiaj6REpEOhAyDEKZJx7tKeaNzXN3J2NFyOCSFSw>
 <xmx:Mukpajag0yaWd0lp2NX_JOMdFd1uNBsIQJ9hI34LZt75JoYjA7GFSw>
 <xmx:MukpanlJEliZH6iFDb3prbdr-2Fwoi7I1IduZmJfpX7QhJf917AG7w>
 <xmx:M-kpahPQe-HxdO9WJEJAnKjSUO6j0YLDLNxWJxDxZQx9WBn3-OrfeTvX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:46:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 stephen@networkplumber.org, dev@dpdk.org, fengchengwen@huawei.com,
 yangxingui@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH] power: fix duplicated typedef for setting uncore freq
Date: Thu, 11 Jun 2026 00:46:07 +0200
Message-ID: <k2rk1VWPQPiTA6Lad56cTQ@monjalon.net>
In-Reply-To: <20260507112754.3418377-1-lihuisong@huawei.com>
References: <20260507112754.3418377-1-lihuisong@huawei.com>
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

07/05/2026 13:27, Huisong Li:
> Remove a duplicated rte_power_set_uncore_freq_t definition.
> And this ops is intended to set any available uncore frequency instead
> of minimum and maximum one.
> 
> Fixes: ebe99d351a3f ("power: refactor uncore power management")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied, thanks.



