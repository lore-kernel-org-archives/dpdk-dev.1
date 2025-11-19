Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B1CF2561
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 00:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8830C40289;
	Wed, 19 Nov 2025 01:28:04 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id C09554027A;
 Wed, 19 Nov 2025 01:28:02 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id E66791D00189;
 Tue, 18 Nov 2025 19:28:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 19:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763512081;
 x=1763598481; bh=MMVzV0wkcFEqqOAuT8i90lQJs1K0pzmpWHpQkZSZxX0=; b=
 qTMG0zBmg8WMFDIg5F2SmZSeb7BgCNNga5/SWRv26bPWbZSPndwvh9bIqQiEbmON
 zrcxFYJ7nJqvs05NRytn9Be55JFsWvF9VG3FxmMpII6Q4WB4OYhN3QeCX3ghgQgn
 lkm3Y2XOd4MwnLkvAyJNrsg1wFfL5trfDt8/BdNYpSn0zdtc1GtbKMe5qO2d33ka
 t2ISsQx3rw7HuyesaZve1GXiuXVUZxmwmGh+8Joztu9S8P7+6IurlRF4NGqHnlew
 H/wfCyV4ZJCSiZrh2wuuc+9HMOE+kO+L7xV/bQS/pFLMznySdt9yJMGSgmIBLTLY
 sh3Ql8mBQ9vuo954HuB8zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763512081; x=
 1763598481; bh=MMVzV0wkcFEqqOAuT8i90lQJs1K0pzmpWHpQkZSZxX0=; b=0
 Uh/QPfScerdrLxtvcf4Qe8k6Q+pX/LTZr9Qfd1JvptSpZl0HqfvSRwdZYlplVlJc
 vad2PsonDWWmzVwf/w1ZLjSUR8hnqJLcWk9jYbQ+inlDK9/l0UtQ71Hax7NwgP97
 RUmXP/95Y/D6V69byPBatTV7Z2VRVQliZXb4VZrWKX58RBB5iOPYiEPNZ/BqiS9V
 DoWI/DKVHmz16DPRngfq3/UDGHa90wb1ULJYxbUjpwUQT3NS3uZJRlY9PmO/ONGu
 i5ZqtT7wfYwS2V299PxZ2cjlDumgfEKr4ksDqOni+ORuGffh19iQ1RGjWgmkjE5/
 2laI4rSEx5s7cYHc6aKSg==
X-ME-Sender: <xms:EQ8daR0XOhZ6eRuBwinxww0IwWgly4m5ZQcQpyi5OziJK_eUAdCdtw>
 <xme:EQ8daTgz0mrqQNXiUJFIhsJ1GQlKB1grBWeeP5_jxqE7s-b9FnJQkWFMg3lB300Bn
 _it-3_L8qKuvQg0TKt1xI3jgmHmAPGKnfNaI2i5CLNs4D7llWwA8UE>
X-ME-Received: <xmr:EQ8daVYyD6XggXpHg9NNBRUPaCkg0l1Kar_fqOC7iDJXMJPoP-cwkEKxAb0KEl7er_IlQBqJ6EkAfbxC0vfb88Bkpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvjeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhope
 hsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:EQ8daTSZJgXN3v_9UtVL49NMnB9LH50QSwH6kZ77kNtyYi1szGskZA>
 <xmx:EQ8daQSGFtZ_OscAWDXO4mGgjoyp0KbXtRdBNS69G8K6spveT8zaHA>
 <xmx:EQ8dafTRT-2q7q1XEBqxI3nh51xEKCAB8FA2OtGmZuibBCQSXJOCHQ>
 <xmx:EQ8dad5Zoxu4MO5NWlNY4XNx8ybyNYRI5obCIyaK1FRKGBuDs9JDpg>
 <xmx:EQ8dabUcLtI1zSnEO0KyNSX38FwmhiiANXFohJGEWrLJUXbgNW5EdMwI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 19:28:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Christophe Fontaine <cfontain@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 dev@dpdk.org
Subject: Re: [PATCH dpdk v2] net: ipv6 link local compliance with rfc 4291
Date: Wed, 19 Nov 2025 01:27:58 +0100
Message-ID: <4832942.kQq0lBPeGt@thomas>
In-Reply-To: <3249247.iZASKD2KPV@thomas>
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251118174526.321856-1-rjarry@redhat.com> <3249247.iZASKD2KPV@thomas>
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

19/11/2025 01:07, Thomas Monjalon:
> 18/11/2025 18:45, Robin Jarry:
> > From: Christophe Fontaine <cfontain@redhat.com>
> > > Modified EUI-64 format interface identifiers are formed by inverting
> > > the "u" bit (universal/local bit in IEEE EUI-64 terminology) when
> > > forming the interface identifier from IEEE EUI-64 identifiers.
> [...]
> > -	ip->a[8] = mac->addr_bytes[0];
> > +	ip->a[8] = mac->addr_bytes[0] ^ RTE_ETHER_LOCAL_ADMIN_ADDR;
> 
> In all other places, we use the operator OR, so I'm not sure about this XOR.
> Also, rte_is_universal_ether_addr() and rte_is_local_admin_ether_addr()
> are comparing this bit with 0.
> Is this bit always 0 by default in MAC addresses?

After checking with Stephen, it appears that XOR is really desired.
This bit must be inverted, so 0 is local and 1 is universal.

Adding this comment in the code to avoid confusion in future:
    /*
     * The "u" bit (universal/local bit in IEEE EUI-64 terminology)
     * must be inverted for IPv6 link local address.
     * 0 means local scope, 1 means universal scope.
     */

Applied, thanks.


