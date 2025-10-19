Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4955CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881BB402BE;
	Sun, 19 Oct 2025 22:22:22 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5FA0B400D5
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:22:21 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 345161D00041;
 Sun, 19 Oct 2025 16:22:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 19 Oct 2025 16:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760905340;
 x=1760991740; bh=jnoBK4DaWcTAovPIF2OJ8Mkbt/vhlIOregsSsA6g7ZU=; b=
 Xgkv6sk6VdEmurU38qEOR8Z2umnaQjK+SflZyqnBx8eYL+QpdyJ6vFI3tIKDTcAW
 cObW9n0Amlkq4G61nRcI1+b7sAKe75WcUbc0w+RR9hwv6m3055Qk2Fd+eVGuj68Y
 Fog2cFeB121fYrwAxHDcxvzdRgxcihsQaUAAQEhi2RY2c4zQEu0Ao5y64Pvlw0N9
 +RveV+1zg4MagzqfdqW5xP2F2hJb54lkZLIj85RzonvQMXMl8WBnMe3DfWxC4YWl
 kt0hBmSHNf9wWsBVnpjmi5hrWYN7g4M6JZ9ef2x8MJRH75O9zkcMwnvp6lElvncG
 0edJX0ODARn6Fvpd71WFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760905340; x=
 1760991740; bh=jnoBK4DaWcTAovPIF2OJ8Mkbt/vhlIOregsSsA6g7ZU=; b=K
 j9Nyx0uHqGQ18wATJneD1aIj5AfyJrG0yUWVFor7tzCwo5DH3LAtlVjddxpqBCoV
 7QYNyw9NwiJt6dkQZ1iGkWC3jcqvS00v43t2bXGgmxbU5hLS6JKLDLPZHpBg2OUA
 AWGptJUJtJFtEPIQNvSTeY5/K/fFKB0S8gQ/Re4BSzPOWydifg/JJLU7GArkSzps
 3AIKz914ys6GWNoadeExPdTylyIB2rq+YNmsz55yAnNpVbfLPs6Z+zHMEd9X0VRS
 s4gxXNSnz1h4+gvfAZ5E6np0739eE/epcde5VFZM0gNbJdai5Wz6fQGJ9uN0oH6m
 YCFVsXXQ+YaZXxuo8mdWA==
X-ME-Sender: <xms:ekj1aE3155M_Jo0vZcOLUWZcFodeec45hCgOctnTrheowO07jwRDHQ>
 <xme:ekj1aJL_b5t0tCX-6SZiuNmcWHLfScYhQCeY1HVHE1KO_FRzL9H7h5JCYFTJzaBnW
 lT_E2ealEGZt5HedHRbxTipUQgqoAoISenvWWjM33hHkfI56EJkHw>
X-ME-Received: <xmr:ekj1aMxYv3j3fF3ANlVbQTun_07GFg3DFPOpZCYYpH2PDw4yFtJwmiJ495vNnpwiBlyJmqJsyoOnJSVcw4GDsarVxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ekj1aPURuaX0z4FIe7ufNgkk4yM1y0_vZtLJ2mF-z-hbUXjjNR8Wrw>
 <xmx:ekj1aEiBV23asPuuHtUBr9H6l_D-NvtXKcS1WFSXgYADJl1X3U1Jjg>
 <xmx:ekj1aHDZsT8okS2jdS-l9Cq1sd5HJxzi1tCNHjs29nWARekG3HJZlg>
 <xmx:ekj1aCvDkqNelUO6fOpZi3_NW8H74johjlu9tOReQ788WwbS6tAthg>
 <xmx:fEj1aJLDN38me9iXEDd1_bR4B6nlFOXIW7jydKl0FAAUu6_9btb4DyuA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 16:22:17 -0400 (EDT)
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
Date: Sun, 19 Oct 2025 22:22:15 +0200
Message-ID: <3781106.TQGk6oTFT5@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654B8@smartserver.smartshare.dk>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <3916365.44csPzL39Z@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35F654B8@smartserver.smartshare.dk>
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

09/10/2025 19:55, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Thursday, 9 October 2025 19.29
> >=20
> > 09/10/2025 19:12, Morten Br=C3=B8rup:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > On Sat, Aug 23, 2025 at 06:30:00AM +0000, Morten Br=C3=B8rup wrote:
> > > > > +/**  check reinitialized mbuf type in debug mode */
> > > >
> > > > This is in release mode, not debug mode. Comment below seems wrong
> > too.
> > >
> > > Yes, I noticed the comment was present in both debug and release
> > mode,
> > > which I couldn't understand. So I guessed it was for Doxygen or some
> > other parser.
> > > I have seen weird stuff for Doxygen, e.g. "#ifdef __DOXYGEN__"
> > > for documenting a function [1],
> > > so I didn't attempt to understand the reason for it,
> > > but just followed the same pattern.
> >=20
> > Hum, as a maintainer, I would prefer you try to understand, or ask
> > please.
> > Note: we can use Slack for such questions.
>=20
> Point taken. Good guidance!
> I'll try to broaden my scope of knowledge to include preprocessing for Do=
xygen.
>=20
> > __DOXYGEN__ is defined only by Doxygen,
> > so any code inside #ifdef __DOXYGEN__ is for documentation only.
> > It was supposed to be used in lib/eal/include/generic
> > for functions which are really defined inline per CPU implementation.
>=20
> Yes, I get that.
> But I don't get - when there are two definitions of a macro -
> why is the same comment/documentation present in both instances?

Because the author had no better idea I suppose.


> And if the instances have different comments/documentation,
> how is that reflected in the documentation output from Doxygen?

You can have only one instance of a symbol in Doxygen.


> In this specific case, how should the code look to both
> 1) get the wanted Doxygen documentation output,

#if defined RTE_LIBRTE_MBUF_DEBUG || defined __DOXYGEN__

/** Check reinitialized mbuf type in debug mode. */
#define __rte_mbuf_raw_sanity_check_mp(m, mp) rte_mbuf_raw_sanity_check(m, =
mp)
/** Check mbuf type in debug mode. */
#define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m, is_h)

#else /* !RTE_LIBRTE_MBUF_DEBUG */

#define __rte_mbuf_raw_sanity_check_mp(m, mp) do { } while (0)
#define __rte_mbuf_sanity_check(m, is_h) do { } while (0)

#endif /* RTE_LIBRTE_MBUF_DEBUG */


> and 2) have relevant comments inline in the source code for both instance=
s?

No need to comment in release mode, it is not relevant for debug macros.


