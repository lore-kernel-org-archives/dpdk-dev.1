Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5FFC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 23:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBB7A402A0;
	Wed,  5 Mar 2025 00:32:55 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id F082E40275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 00:32:53 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6087513826AE;
 Tue,  4 Mar 2025 18:32:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 18:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741131173;
 x=1741217573; bh=jLae3Z1uOlq77iWNazSCUDhbAzNGtrMjTMeJdcgGrmo=; b=
 Xr/OJQMoTisuQ+u9QgHjQlWpxUnr8hxRcuC6kTnJGt+PLMUqh7eSyDN7wuW/udjY
 +XAoikVywwhcrWc92R56BveQ/Lrv09gyvfAolyTu8btxF9IuIORt9ixP5KMpG/Ly
 yHcyMBIJAxI8xhj6TTvurH2T0oSCKLbpd9nqLHQU3MBTBzLduXVKBbnUh2w9cWDV
 5yq/RQpnithPpj169vv0CTNEIT+hCq1AngLd8u9wNnIugkxU7xujU9b73YXQo5zi
 rdoroQd7cJSdd+q/ED60UpYNg4xWGjadJhomso8ySdkmq0Z+osUWLHyGHGP7ai0t
 rE5YNoGBYd+2qvRuJCeAAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741131173; x=
 1741217573; bh=jLae3Z1uOlq77iWNazSCUDhbAzNGtrMjTMeJdcgGrmo=; b=j
 mbZPTsJeNumN3mdrKIt+eXIgOxLamr/KprKQ9UWoP/OH/9Wr20+TMkB/zhUzJWow
 SIkbaYEdbCH7MlLR2V4nj2B2jR/yCoqcfhYNi60uil1VXxPSq6sBEcRvpDPSsO5H
 F+2GqPLC+CZad79UdTVT8rC9BSAHZgocOrzlfF+Lk0/o2bV8BzGaBGtdWYXpnFMO
 ykc8IztHziTNBhXw9EF21xQ4+Dm8lbPa9jOsq4rPxpGdQFzfGs6n6X47BVZu/ovM
 y3KGEV0/nf0GeloP0JXpX0W/75b8sYVdalraR3XNk0OMLiTb1ZZwNqcPBwZOSFVq
 nRJejs8UL1fex5JSKZ4ig==
X-ME-Sender: <xms:pI3HZ8GDgLm-Z64K8XnWCgyNS8EUcpyg58n29l0pzabpJKb6vn6W5g>
 <xme:pI3HZ1Wb-Y0RJy3K9Ddin-n1nQFYDi4w3tjZinKRojJ4vWvqYaGP770-nFDYqDrnK
 OT_8rLRmrJUV7nuCg>
X-ME-Received: <xmr:pI3HZ2LZkZSf3MnBVXVtO2GkuXVH9n329Ckv9lgnUtd_3XHiyiA0QG4ZoauHqSoUbgkt7aVPNK68EUGfePMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefvdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifrg
 hnghdrjhhunhhlohhnghduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsg
 gvrhdrohhrgh
X-ME-Proxy: <xmx:pI3HZ-EGo_Il_623A-0pZSDhbEn4ZsnAGemAN46hwKIMNXIqrEMBag>
 <xmx:pI3HZyXYR3nIfzPNgfHLtYlxNJgdKKuaHkNwt5IFPA745zLcbTVO1w>
 <xmx:pI3HZxPiygj3rMVSjna3-CI_LzQ4bgtrdwY_3cSMyd0HVV93axUY6w>
 <xmx:pI3HZ53loFvukE2a5fCMWxqW7m2XgF552mm90R7CxHg3Z93z8BryIw>
 <xmx:pY3HZxRX-INNQUQIoMyYs8fy2jXNnquSSyYn-w-vwLVkVLxC1vjc-Vf9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 18:32:51 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 00/16] net/zxdh: updated net zxdh driver
Date: Wed, 05 Mar 2025 00:32:50 +0100
Message-ID: <3442926.QkHrqEjB74@thomas>
In-Reply-To: <20250225081206.68cc5fe1@hermes.local>
References: <20250221020346.494392-2-wang.junlong1@zte.com.cn>
 <20250225104311.732507-1-wang.junlong1@zte.com.cn>
 <20250225081206.68cc5fe1@hermes.local>
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

25/02/2025 17:12, Stephen Hemminger:
> On Tue, 25 Feb 2025 18:42:52 +0800
> Junlong Wang <wang.junlong1@zte.com.cn> wrote:
> > Junlong Wang (16):
> >   net/zxdh: optimize np dtb channel initialization
> >   net/zxdh: optimize queue res alloc/free process
> >   net/zxdh: optimize link update process
> >   net/zxdh: update Rx/Tx to latest
> >   net/zxdh: provided PF/VF msg intr callback
> >   net/zxdh: optimize MAC ops
> >   net/zxdh: optimize promisc ops
> >   net/zxdh: optimize VLAN filter/offload ops
> >   net/zxdh: optimize RSS/RETA hash config/update/get
> >   net/zxdh: optimize MTU set ops
> >   net/zxdh: optimize basic stats ops
> >   net/zxdh: provided CSUM/TSO/LRO config
> >   net/zxdh: provided rxq/txq info get implementations
> >   net/zxdh: provide extended stats ops implementations
> >   net/zxdh: provide ptypes FW version EEPROM ops
> >   net/zxdh: provide meter ops implementations
> 
> Applied to next-net and updated release note.

In future, you should provide better explanations in the commit logs
for your changes in zxdh please.


