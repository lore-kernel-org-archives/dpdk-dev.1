Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8D8C83F14
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 21:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B120F40E39;
	Wed,  9 Jul 2025 23:26:43 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 2236B40654;
 Wed,  9 Jul 2025 23:26:42 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id D25E84029E
 for <announce@dpdk.org>; Wed,  9 Jul 2025 23:26:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 550E4140031B;
 Wed,  9 Jul 2025 17:26:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 09 Jul 2025 17:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1752096400; x=1752182800; bh=w5kTtaFEwB
 50y7TckAojbFR2ysYL/Zr8ikpLO57cc+8=; b=Emm2EV2h+rSNWyJ7nL+tj10n6S
 aNffARu8U9UiRVoSdm7dAFKxShrCmk7sqirwra4j4Pi/F8l6zyftkQu+wdqWIqk2
 4eP86/y8UrPzFQFtj7QGJWngeH1p0Lc6MjkOFjo3rddgXJGTGXbuqX54NnR6kDXl
 54IPtsW08lFWMvwFAy0+aBsWJ0EvbE9mTbGHEs3z3OdMcOVYD3JxsnuZNtgxZWDA
 24JvyZYHsUAZqPUJeLbvWzAJu1pCIyL5w2YDbw5VSuDNRszczUWpW4/8Q9f8Sy8K
 Bhr57w2+sllR/+/Dusc3TBO/qqX/BEq20HxyhOPfXqR2MEE9E1ZTSO6bHesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752096400; x=1752182800; bh=w5kTtaFEwB50y7TckAojbFR2ysYL/Zr8ikp
 LO57cc+8=; b=S3CYZeMfIhHoU5+QNRBq/ePV8jjO0ly42rNMGyvhmssbx7vdIJc
 FqqaRxCUWMO5WJDw8C5jIWWlvaGhdxRUi5lT5StF8AMP73R74EiczYDzKTZwr4T6
 aKDwx/0wUfGb/+Rr31vefgPWLyzpUrAxtZBQOKEXC9OITUyfAEMykCDkKk8G3a1x
 0/4KjRAOXyo8dFalqtcGa2/SzLHLvPvugIeAaekGhFgLpk4Lg9IujKYl39OxIKZD
 Q/eLw99BjtxazvTYjvvaCYtJVrUe/DM93DPpp2Trl/PlJAdpqHCIlWUM9HMdSQ4H
 eOzR86dJXXp4uwKJfKHmKnaUlKQPFtSsP2A==
X-ME-Sender: <xms:kN5uaBmL50vZydru_RkmXg-McNney_12vJBXy1oGSwqf0kqSeYwWzw>
 <xme:kN5uaIF8S0pWkyiAqZdplXxrJVzOZvidnWORxwyfxEsr5yEo3Zr0X2i1hw4mdoWGQ
 I34FCJ5U-zRLeDFkg>
X-ME-Received: <xmr:kN5uaIT9i7-CEpXKgz4ywSug88_0Fz0Stpd9LSDja9DZgeUUYxfBFaWStAmJnK8i3JfwVizgAtH5oeegHnPZCDu9Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgggfgtsehtufertddttdejne
 cuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepueeguefhteduvddtjeevjeehgfegje
 egieeileevveegieffvdehheejveevkeefnecuffhomhgrihhnpeguphgukhdrohhrghen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:kN5uaHz0Mf4AanUPAm09q81pzsEzj4iXXzg_swoKoLDAhjl8oTlVmg>
 <xmx:kN5uaPMBsm_gfNxaQD6WeEP6opSldEmZH6RwZEttIbCB9fwFgWFF5Q>
 <xmx:kN5uaOMbtKOEZ5-YDuLoY-kMOinOjfOSiSniYoNF3ZOCnmPisHyRUg>
 <xmx:kN5uaJS-rNUuHQk5Z_o5ozoSB5wDdhudi-zJ0obXST-XXJE_kZo9dg>
 <xmx:kN5uaIH6AxlofwsXNhxT73_XhF5e_cwjXbQl0dffcbZtZObRU6hA7xup>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 9 Jul 2025 17:26:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 25.07-rc3
Date: Wed, 09 Jul 2025 23:26:38 +0200
Message-ID: <9991491.lyo4hBLbkK@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A new DPDK release candidate is ready for testing:
	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc3

There are 86 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_07.html

Please test and report new issues on https://bugs.dpdk.org

Only documentation changes are expected at this stage.

If no major blocker is discovered,
this release cycle may be closed during the next week.

Thank you everyone


