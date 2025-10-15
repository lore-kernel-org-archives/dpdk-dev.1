Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F26CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 16:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B015C4060C;
	Wed, 15 Oct 2025 18:53:57 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 7D89940273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 18:53:55 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9E4C17A012D;
 Wed, 15 Oct 2025 12:53:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 15 Oct 2025 12:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760547234;
 x=1760633634; bh=+eEMJNjLtZsbZ5qb+zfiL9Yd89whZJa54MU6iHcdhDU=; b=
 SW5iTh7iRmt5nbeEUJnbsK2Tuzyk4rZVPz7HcbGtazKhzjLQkN3E3Q0yZGdWmORG
 YJp7pX+vdxbECA5ibKTxgcwEBJx0FYigljXSuUnhAXLmTxsacHkDj4IwG17y/jsW
 FaKNbYJVfED9+q2jS/wydeEJ2nFriiEYPnMKZt2Q/JV/L3gHMRcgYID/aR1aWbrX
 sE6UskZKjNq9s1jxJKiX8kMny2GMDvEXXurwd3iy00S6Zp0FrJ0AcQWXWaHBsJnN
 YHGred7eZK08jYtk0AZcVShxvLxVEViES07Y9FJTSm9+PBY81cmiQwb5KEyAjZy1
 7xFccjn7sp0/uEMcBa+t3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760547234; x=
 1760633634; bh=+eEMJNjLtZsbZ5qb+zfiL9Yd89whZJa54MU6iHcdhDU=; b=p
 JDShx9pqmL/q3vIAWlQXK9JjQJVthOev5oJS6vshCAJl23onUnqsyEVIb50cTDUq
 pdVZugbbykQtcaJIH8lnBnJ2CrKTKMc8qkMRh4sNiJ96kWKN4GTVEXuW1aWQarRz
 948X6wjzrzPgEUWAYSD/d+blEEG8mKrHQuBfVpOYi/xSSm6zCaba1S2I7Jbi+4w/
 P8AHGtloYACLU6ewodbh9zpjczd20jAyKRnXen/dXPEqEuKjmaaGHzHWEmio+E1A
 fi6+a20+rtMXzWQUM7pd8iLyvk8Z/YWmxyXFuDzg1bSuklOGpIYP9qf4MQmWVT/r
 8m2njrbZipVRixVR6FuqA==
X-ME-Sender: <xms:odHvaA4m3r-Y9Nen47QEeYRjAlYDvIxNrAAI7_ejHXVEqMpUuW9xIQ>
 <xme:odHvaCBJQIvvD31_u4xIqhJWtXBjm_sV3tJ3m08gp-FDf3eir0RwB1SnlaBr8zt1Z
 h2SunUjmW6istf3RedQM0CowmtIywhOBa_FivjWh87LP4apoes-DA>
X-ME-Received: <xmr:odHvaHbsZKNXet8TPNvc-ANKIUim6nDMwdtrrwxn1DmchbRjmZQuo12JFb_TWYKg3JrjW4plXccAO3fJlQNgJazrzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjfhhrvggvsehfrhgvvggsshgurdhorh
 hgpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:odHvaNZyYfJsuG_t1FutryokLUxrDUHbH5d6PcL_cz6l_9GxwrRyWg>
 <xmx:odHvaO823J_HC0oO0jx0RDHNBatTQYL4bm_ohIYT39XYMaohKziIRQ>
 <xmx:odHvaMgrkqmXvEhjg2H182_SLWOki4cDSkYD4cC0GNfgf3lLBTq1bg>
 <xmx:odHvaOeJMwCpkNwpsS6MhPKVRRtlmeD4pok7hLdenFfV8lckCz6IUg>
 <xmx:otHvaM0ifqdLfwBG-cmlMx4KmP0TOXYrJdVd0OL68FkDjAdT4Nr_JAS_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 12:53:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jake Freeland <jfree@freebsd.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2 0/3] EAL memory fixes
Date: Wed, 15 Oct 2025 18:53:51 +0200
Message-ID: <3242560.9Mp67QZiUf@thomas>
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

Hello,

14/08/2025 23:32, Jake Freeland:
> Hi there,
> 
> This patchset contains a number of EAL-specific memory fixes that I've
> made over the last year. Two pertain to FreeBSD, one pertains to Linux.

Your patches have been reviewed, please could you reply to the comments?

Thank you


