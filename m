Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB1CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 17:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 262DD402A0;
	Thu,  9 Oct 2025 19:29:12 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id BD66F40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:29:10 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id CABE81D0013B;
 Thu,  9 Oct 2025 13:29:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 09 Oct 2025 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760030949;
 x=1760117349; bh=qwlWMOlDxyhe6FCbCp7wEmyLduoi1NTZXA4Xjt50/1Q=; b=
 akK3HU5g7vD2eipfxm4ghIZhZqr7ihSkD/ck+WLKLUMAmDLvmPDqzgRJL+7sMeXA
 y+E1F+ELNmGDzWXo98HewoaC4TLqVZWLybpJbeAOZQ+f94EPwMnrBRowcrX5SlXh
 lW4icmOtBfbIFrYCaQ6XA70duuAoXEE6jY9NyNHRJIInIILHIBVwL1dbO7sdEIib
 4Tq5bd3mlDUuJTzxdzGe0kbdKi7+aJGN+Iaofl54P0exD9Alph9I+pYcHqT4Gu7e
 YF9GXQZeoLT1mYojylgTKBr+2SDzoLjhwLkUGJpji/r/qSl5Liwl+LRxKsty05eL
 xOlw5QSBroB0Yjb1IIZy8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760030949; x=
 1760117349; bh=qwlWMOlDxyhe6FCbCp7wEmyLduoi1NTZXA4Xjt50/1Q=; b=d
 JUDJL/OaS74ZyitB59MecRNYKjKzzd4yXdz1Rgjt6bcwuD/uaHlX8EmPcLHsUF5s
 pHiJp5a1GUitzJ32WA9T6Q5xMOxNourAYc+aQibhE3UzHGnMIxx277B9+ufE2d+6
 kK84IVujJaDx4kLZX3vgFVa2U0RbF/pY0FyvJa+gk8hqzC5i7EY87HaC0Se4yQyw
 Z+v3aPKLXODbo6okgWFPKFXGdNTId9oEIPhXUTmfX95L699vaeQrkEqWAxd2NdI0
 kfqp27cFN0KZHfVvPJS2LbT9GA27cjF+hgD2YNfEF5Uxhth8PwPuj79GMgF66BYn
 Ih7Xt0mQLopFbWLm+j/nw==
X-ME-Sender: <xms:5PDnaANHsdZs9dRkXEjwbmCR2aH65klNB_hD7rYUeWNdpwMCuOPVJg>
 <xme:5PDnaBBOWRJnM0Z1vsykYRNwvPImG4LXIIL4mfMRG-en20G3NVUT7RxXlj4O5XVgU
 TMGPhwsJm4tZM5riejbq-IqJumX_7yhFl_mHF8ku61fFw9MEFCrUQ>
X-ME-Received: <xmr:5PDnaHL4wlbAYIScPPGxQw0ZE9cPeEpECJ4FZu90wrMli9sLv9QW3LJs_Qy1LrgZbybqC4FCtif-nXBdOfc_ynOqKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeijeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhn
 thgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehk
 ohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtoh
 eprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphht
 thhopehivhgrnhdrmhgrlhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:5PDnaKMvu4_PGecee_BhDbK1Q0NO6BO9khnKLtfUOY3bomosVolOeQ>
 <xmx:5PDnaF54UDd69i36O1fQD63xKwkT1F_6RkzKYK9CMelF8QHltfzPBQ>
 <xmx:5PDnaM7R-MjTxu_azPYADCn-QLSmISDH6pSWHCh63pqfbrCqzN3QKQ>
 <xmx:5PDnaDH3llR5NWdtAg2janGJf0nMDXKTfEvxk7bURLepkep_Av1qhQ>
 <xmx:5fDnaDiPnzEDAo8W2mkjtnTzBX4DAHP-bF2L6wIG76LqF3xA1xl6xAc7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 13:29:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Date: Thu, 09 Oct 2025 19:29:04 +0200
Message-ID: <3916365.44csPzL39Z@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654B6@smartserver.smartshare.dk>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <aOfnq0bx0py_XTQz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B6@smartserver.smartshare.dk>
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

09/10/2025 19:12, Morten Br=C3=B8rup:
> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > On Sat, Aug 23, 2025 at 06:30:00AM +0000, Morten Br=C3=B8rup wrote:
> > > +/**  check reinitialized mbuf type in debug mode */
> >=20
> > This is in release mode, not debug mode. Comment below seems wrong too.
>=20
> Yes, I noticed the comment was present in both debug and release mode,
> which I couldn't understand. So I guessed it was for Doxygen or some othe=
r parser.
> I have seen weird stuff for Doxygen, e.g. "#ifdef __DOXYGEN__"
> for documenting a function [1],
> so I didn't attempt to understand the reason for it,
> but just followed the same pattern.

Hum, as a maintainer, I would prefer you try to understand, or ask please.
Note: we can use Slack for such questions.

__DOXYGEN__ is defined only by Doxygen,
so any code inside #ifdef __DOXYGEN__ is for documentation only.
It was supposed to be used in lib/eal/include/generic
for functions which are really defined inline per CPU implementation.


