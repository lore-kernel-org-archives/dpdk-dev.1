Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2810F92EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 18:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60DB840B98;
	Tue, 31 Mar 2026 20:29:17 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id B8F6740613;
 Tue, 31 Mar 2026 20:29:16 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 44727402B6
 for <announce@dpdk.org>; Tue, 31 Mar 2026 20:29:15 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id B778BEC0261;
 Tue, 31 Mar 2026 14:29:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 14:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1774981754; x=1775068154; bh=OHqeo2KcAC
 9hZEE1RqX0/0H4XEFpOHFbEq3ODJP92P4=; b=keDpXMiSU1Z9+bWoucLrjpn4Zw
 lMcMKhcE3G5Np+5gufCmnpJw1nZ8HvFjiYgTvhlOAjaGSyPWpfAvLgnyJk8bHSxJ
 EBAxlPeR7u2ln1yWnIYjY1OdK/rit46N5KPvX6+36yJq2JOBunMQIlmfjhLY+uM5
 niWr1M2rolHvtLZf3m/Kr2CIJTBzfzVEi/FXjd9gh2/VscbQfdpotTqJqJ1WkNTl
 cnMhfsFNXjfxE1LdOq7WABVm9Z551jEUNR/T+iyU52V3bZlnYAmZ7gUFCVKUjtJL
 YYsxar9U2Fq/Z28NPBWQjTn4L+IK+yr20kTAxGjv58GT99WVn+pvCkpQihiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1774981754; x=1775068154; bh=OHqeo2KcAC9hZEE1RqX0/0H4XEFpOHFbEq3
 ODJP92P4=; b=nXkCelT+J3Uc2sXu9q4v0Gm+H6L1r7+9f1GdUG8+vylszSKC9PD
 JlnAd7Bh9ZcnJE8esASsZS7KsKSC2SqUojYv19zVS4blq3IPKGeI5wsGgIUEyn9/
 75sTVzOGkeeW4ruRhs414O1DXTwmLhf/6f/kHqXFePDdaRKpaq8q9FfntHE4ZkAB
 cPEG4iSJgHTPq7x/4e6IYjPkLRz8pAnBAkORrbtF4OSM7oDNaLjcaDHN4UCCTMxN
 cuVeq1LEwKRll+uVQMmuFbZTsNTwSwCRgLV+yNrgHrW2UOmJ72L8wwsRhO7y9rR/
 0OyN3haT63sRYP4bLuAMzuOUVFNi/LKxSAw==
X-ME-Sender: <xms:ehLMaZ0FldaO41W9tp_U2I1KLKW26fdlZ18yX4r-D5fsMHXb5f4qzg>
 <xme:ehLMaV8D2AVrsU3t7-N559rQp1m3wfTgCKqugiB78AkTVYKYoG3wiOqkhMmYk2Kb_
 -jzXCUA-nGc0gulY2xoenPnkAacaLe9DLzPiVvOm1BIAqTANKVgyQ>
X-ME-Received: <xmr:ehLMaU-WRRby5enMQtS8OAsc1bVFqPHnhJr411vmg624tg_eG1Q194f-Ie4Gtc881HSFSWoFBPToV4158NvzF44hzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecunecujfgurhephffvufffkfgggfgtsehtqhertddttdejnecuhf
 hrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvtheqnecuggftrfgrthhtvghrnhepffeivdffveffleekfedtkefgfeevjeegge
 dtveekhfegtdduteetieevgedvvdeunecuffhomhgrihhnpeguphgukhdrohhrghenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrsh
 esmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:ehLMaToOILoUR0FyHiaOIEublF7UGe7fCo3YSQa-3HwX7R8_LzeOKw>
 <xmx:ehLMafqVCPLWcC56_NWkd6Xs-vplhkqN4kq6SyrMJxQV0btjuAPIaw>
 <xmx:ehLMaZn4UzvnSaFTCzw83GF9_b5CeDwW0Qa66O8hk-hx1hr7k0V0NA>
 <xmx:ehLMaZFESzD7Cmn0qyLAaNgr2z7k4nUCp1LNVZboWk5maucbZtr9Ug>
 <xmx:ehLMaX2Zl_lijOskafKsYq5WdC3h5-qGWpmpGc2vWSV4oNw2UQ2zJMn3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Tue, 31 Mar 2026 14:29:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK 26.03 released
Date: Tue, 31 Mar 2026 20:29:12 +0200
Message-ID: <24347542.6Emhk5qWAg@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

A new major release is available:
	https://fast.dpdk.org/rel/dpdk-26.03.tar.xz

It was a very small release cycle:
	699 commits from 102 authors
	1077 files changed, 41087 insertions(+), 20971 deletions(-)

It is not planned to start a maintenance branch for 26.03.
This version is ABI-compatible with 25.11.

Highlights of 26.03:
	- ACL custom memory allocation
	- cryptodev 256-bit NEA/NCA/NIA algorithms
	- OpenSSL AES-XTS and SHAKE algorithms
	- BPF atomic XCHG instruction
	- no more format overflow in libraries
	- no more variable shadowing

More details in the release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_03.html


There are 25 new contributors (including authors, reviewers and testers).
Welcome to Akshatha S, Aliaksei Belovus, Ashok Kumar Natarajan,
Congjie Zhou, David Zage, Garvit Varshney, Keegan Freyhof, Luigi Rizzo,
Mike Bly, Mohammad Shuab Siddique, Mohand Alrasheed, Rajesh Kumar,
Riley Fletcher, Sandeep Penigalapati, Scott Mitchell, Sergei Iashin,
Song Yoong Siang, Talluri Chaitanyababu, Vee Agarwal, Vinay Govindaiah,
Xavier Guillaume, Yang Xu, Yehor Malikov, Yongfeng Wang,
and Zhanibek Bakin.

Below is the number of commits per employer (with authors count):
	229     Intel (25)
	107     stephen@networkplumber.org (1)
	 88     NVIDIA (13)
	 47     Marvell (10)
	 27     Red Hat (4)
	 23     Huawei (4)
	 21     UNH (3)
	 20     CESNET (1)
	 17     Free (1)
	 15     Microsoft (1)
	 13     Realtek (1)
	 12     Broadcom (5)
	 11     AMD (4)
	 10     ZTE (3)
	 10     NebulaMatrix (1)
	        ...

A big thank to all courageous people who took on the non rewarding task
of reviewing other's job.
Based on Reviewed-by and Acked-by tags, the top non-PMD reviewers are:
	 38     Stephen Hemminger <stephen@networkplumber.org>
	 19     Marat Khalili <marat.khalili@huawei.com>
	 19     Bruce Richardson <bruce.richardson@intel.com>
	 18     Patrick Robb <probb@iol.unh.edu>
	 17     Konstantin Ananyev <konstantin.ananyev@huawei.com>
	 15     Chengwen Feng <fengchengwen@huawei.com>
	 14     Morten Br=C3=B8rup <mb@smartsharesystems.com>
	 11     David Marchand <david.marchand@redhat.com>


The next version will be 26.07 in July.

In the meantime, we'll meet at the DPDK Summit in Stockholm:
	https://www.dpdk.org/event/dpdk-summit-2026/

Thanks everyone


