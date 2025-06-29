Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B68C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 22:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E90C402E3;
	Mon, 30 Jun 2025 00:30:45 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 8973B4025D;
 Mon, 30 Jun 2025 00:30:43 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id BA44540151
 for <announce@dpdk.org>; Mon, 30 Jun 2025 00:30:42 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E1BFA7A0099;
 Sun, 29 Jun 2025 18:30:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 29 Jun 2025 18:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1751236241; x=1751322641; bh=Ufm0ZXpY/X
 X8kFiGzYE7WKTkiPbAWUPik46t/pNChu0=; b=LSCG8SMh4fh25+cWz6PbniCGNw
 n4C0KZLCim+hvw3Yx/jQDUKE11QDT+ODkjEGV7EjZwW3hEGdLmexJccEkZ11bYqW
 WZ4/adhLbJ6LnvkzqsEftHSh32dtS9Dy64hUbnqu61jAInW+VrS63rIbOmXtLG1n
 Nm9ac7Q4miWInqrBOBagD+JmcdqP/TLhRN5VE2HR+kvbpMgJIbpNoR0FFHAmUolh
 hQuX+tDTwZbwd4rKIO9DaoXLoiHDz5fl6stJiJIFBfRMMhO6kBnxQotE3/BaIS0c
 jzOiTjR5meBDwEMmt3BUYWaB0XoXm+ImJO/wr6YwoIv8joY/Oo8JsO53FZ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1751236241; x=1751322641; bh=Ufm0ZXpY/XX8kFiGzYE7WKTkiPbAWUPik46
 t/pNChu0=; b=jq7DcUrnaZZA4Hr7nL2CgXqdi66L9qo4xoY6Ustt8dCCj58ijkr
 OAaA545ACdTIDf77+oCUybDWx0+1ZOpLxhrhO6V7VFAUg2hR3+Efe0dKHJAKRxtI
 Szl24iGFf6aCj1jKV11MWdFQkXdlKTwq4c067fOc+2WVUKNaH1kGU/pmYekT6BmA
 1L7vkbMdXkyeFtrEtF2wIO88FXHDLDADMG2QON1ndKuODMwVKicsCkN19J3HH9je
 B0LnfcLNWO3QjMn9j8IXPjyj9410cP8XnegzcnYWaeyj2nuAMKn4cOzlBzwYZohY
 7HrXxpVQEcbmWSJizVGd+7wOnMTwxAslVqQ==
X-ME-Sender: <xms:kb5haMq37F_IWKhAM4OXELm8hNkuauHLfK1UYPiIVaSAf3292XJ1pw>
 <xme:kb5haCrZF2eSB9J1um97gWNW8o4PhsK9IkXuH_-qFNSucSC5qq_R3SxEa8iGWXSvE
 PmBWnSfv1uFhM4FOA>
X-ME-Received: <xmr:kb5haBOLW-iaX1jYu5GOe2tucPRlvetsYjI4zZCWXCSYoL8RlKGvMMSSBwYtGC_pG00rJLUDgzvUIFDBNHiOhGJFtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgggfgtsehtufertddttdejne
 cuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepueeguefhteduvddtjeevjeehgfegje
 egieeileevveegieffvdehheejveevkeefnecuffhomhgrihhnpeguphgukhdrohhrghen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:kb5haD61VCJXWJc_-X8TaO-IqDOrhM9IVUQFtbz8lg5ejfA2jPEJGw>
 <xmx:kb5haL6jUs5cnyiRgHjwbqTeh09jhINXfEUSqiJnikb0fGhM0ehvWw>
 <xmx:kb5haDgIW1BEZ_SW1qge8y3NLr1DWDjyjHQWlOW8DwRhVDB6Ui823g>
 <xmx:kb5haF5hYpaixELslAdho3TiAoIv_rtRzhEje0BXbWmr5s1-pUAOOA>
 <xmx:kb5haOYBMnaZGNUuK8qZVZuKG9ABx8HbH1WW6Oje4l-acBJ1ruueG5HN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Sun, 29 Jun 2025 18:30:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: release candidate 25.07-rc2
Date: Mon, 30 Jun 2025 00:30:38 +0200
Message-ID: <4829359.Nya5fj1elA@thomas>
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
	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc2

There are 141 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_07.html

Most significant changes are in multiple drivers.

Please test and report issues on https://bugs.dpdk.org

DPDK 25.07-rc3 is expected in one week,
with a focus on fixes, tests, examples and doc.

Thank you everyone


