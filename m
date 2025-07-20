Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 08:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BD8C4014F;
	Sun, 20 Jul 2025 10:46:47 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 26A7F400D7
 for <dev@dpdk.org>; Sun, 20 Jul 2025 10:46:43 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 585B17A0136;
 Sun, 20 Jul 2025 04:46:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 20 Jul 2025 04:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753001202;
 x=1753087602; bh=/H0GZrDdbrXEQ8tswnu/R7UE4aAdzExiPOimLZZEuxk=; b=
 xxFd+XIdnHU1GS/KBHFJSav6xH6bH879wuHzAkeYwjStselCTpiIPFUmJBP2qKOY
 Jch1/2MLcpoiQFC1x13G5ijd01jn8ln04O/moWJoWn8c4j43GDiAzv/hV7J3Ghi6
 39V5NYnM/TQhWO8UNlebIEiHVKVfsAGdmSCg7OhKXl9C5S4Jqlc5KxMzYisbQbP3
 MagVyg6UGWnbg/9iGcz5q7S1shlbRhs1BjuK0jNsoxsnPRvz1G6qVqkUM9bCq71f
 E61Oq351miq19LF8GvGXfRtHcUMXRlufIycdDE0usUrCyaIxzyIQF4Q7VAmGE5sd
 Q49mwZZIzkL/l4AYKMA4eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753001202; x=
 1753087602; bh=/H0GZrDdbrXEQ8tswnu/R7UE4aAdzExiPOimLZZEuxk=; b=c
 lOvRrOWYYZCp+oayN7kreY6gV4Lo1zwCuOcNNFAe9tzvXhWcMfL8Z3S2zB7FyfpE
 vIh/8B8RWZ6fcNVnmPDjaCfWzUNUPRlDww0v5QgrfBJNymLupchuvWs6Qg7xl8PL
 gw+JuHM/E672h0wpfokNU8c+5mleMBzqFDHhPyXSyj05uu3K/eU8yC43wrAY2TW6
 qoFLsK2W9RDxzYBT9m2LbC+49b4+ppqVHqTfgd2k9qpnxfObDIADGgYiMqqzYUFz
 8hs2CSS56GEZvv1+W0VVlG+8Hn8zwm0D7m9BwPi9ug+vvoDSDRRthTQb8qO5hWU3
 7p7EY7Vv57JkIJ2ESoLCg==
X-ME-Sender: <xms:8ax8aGD4Mvh99FCvvhA-nXF7t09nf8LeduPz-_d00-gHhAINa9h4lg>
 <xme:8ax8aLYKLR8q8CM90rSIjcQS3sNwxPNuWY_YlPRubMPgjd4h8Ht1oEfHTSRjFch4l
 j-RZBUNP1RkFwtH0g>
X-ME-Received: <xmr:8ax8aBbUw9Tdw9FKxB64ngvrzuFDZPCwjn9z_D1lE7BGfopfqWRwhGM0DZD9rNraYpCOqz1lU2YzQSCiLtksxt5O_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeikeejhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeehieekleekueejkeegfeeige
 fhhffhfffhleekjeetiefflefgieeigfehvddvjeenucffohhmrghinhepghhithdqshgt
 mhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrvhhinhdrphgrthhhrghkrdguvg
 hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepsghruhgtvg
 drrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:8ax8aC8fH476s5e4fG76rMRUAPZNngEhKlDg0-Xo82NH7uHsCpanpg>
 <xmx:8ax8aAiPuNMM44EG8GfMBz5itnUWICV8dXJMQ2V6DOeVVE1XmqroBg>
 <xmx:8ax8aCdMt26rKcXCtJyNCsJrAAUTX2ollrZv9g2trPgaUH_vQGaBFQ>
 <xmx:8ax8aHrEACdMoyiAuRSylSCEFfxYYe5qW8vvdDuDuvt3GVToLsXhMQ>
 <xmx:8qx8aKojzegpus5zhB9KOSuQqTe5IlmU2TLF3uQuo9JiSjNEbEh6QH8f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 04:46:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin Pathak <pravin.pathak.dev@gmail.com>
Cc: dev@dpdk.org, jerinj@marvell.com, bruce.richardson@intel.com
Subject: Re: [PATCH v2] mailmap: add new email to DPDK
Date: Sun, 20 Jul 2025 10:46:38 +0200
Message-ID: <3295268.5fSG56mABF@thomas>
In-Reply-To: <20250719042158.39269-1-pravin.pathak.dev@gmail.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
 <20250719042158.39269-1-pravin.pathak.dev@gmail.com>
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

19/07/2025 06:21, Pravin Pathak:
> Adding new mail for DPDK contribution
> 
> Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
> ---
>  .mailmap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index c7d55c7386..1c5c367f6c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1240,7 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
>  Prathisna Padmasanan <prathisna.padmasanan@intel.com>
>  Praveen Kaligineedi <pkaligineedi@google.com>
>  Praveen Shetty <praveen.shetty@intel.com>
> -Pravin Pathak <pravin.pathak@intel.com>
> +Pravin Pathak <pravin.pathak.dev@gmail.com>

You must not remove your previous email.
You must have your main one and old one on the same line.

Please check the doc:
	https://git-scm.com/docs/gitmailmap


