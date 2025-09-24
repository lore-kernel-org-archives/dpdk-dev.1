Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627AACAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3AD640613;
	Wed, 24 Sep 2025 17:46:48 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 062D840613
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:46:47 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 46AE27A0193;
 Wed, 24 Sep 2025 11:46:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 24 Sep 2025 11:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758728806; x=
 1758815206; bh=QJPQ37idamN3QufDhgDP7/lGE0ygJGRqcI3KtA7dTY8=; b=q
 J2/9X3P+fhe/e4vx8blNB2zvoA/QJdYI936HxHxQt3Mj0B0QnrTh3i/Sp/I4uC4N
 kBA9tD8+xJxxgsEeax0cyZEU11p0L9TCFOwVpv6Ou35iz5A8f6fKk+1iX2PSkKwQ
 N41yVwBlEfEOXycEZxLFhHuH3hO6DqGtP2S8piEo3rRNg3+cKgwa915sJJZARiq1
 5sbcGyM18EbwFQWD7vV9g2HZUdjbeE+hoiFfkhifxWGmMqiAevZdlZPyqyvr4UJo
 ZEs7j07+Luj9agPV/r6LmTNnGgpVpgYOEFSMDxq+b32Aa+ok4Z42fwC2RgYcxhO8
 wsENGZ+JsSQkY+/soJbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758728806; x=1758815206; bh=Q
 JPQ37idamN3QufDhgDP7/lGE0ygJGRqcI3KtA7dTY8=; b=OGp/MJrXurl+V7HB2
 X0JdxYPnpLQYsxIWB9ZxLgX5Aafa++iYCBN/Wa5oEjAnZ6aMLQj7yVCuLB4NQ2N3
 yi/tLK0L8rYBWOgMJC0IetkyaTrTxgz8zsFgjvSw96PY5JqvTuIXQSrk0rYOPGXF
 XgSgnO00olOAkIGi2344BdzynnAd816FWfidsRilwG37FSD3QbFFG9Bx+bMVpyHf
 FPT6cdRRwVDfCz+KXZVoNd5mh23/Xcbyp35Ut2FbxibdVs8TP5hJb3nqmXvYjVEr
 QoTMHrt/bmIBgrSg+3FnYZvu9ERNAc1WWaoW9afdYz3tGXSfNZWSOtB/zER3XwXt
 hOMiQ==
X-ME-Sender: <xms:ZRLUaL7A5c6lHe4CPp34jKNxnGN7Dp7PfkvFlcU_21U-sVhe5U9ASQ>
 <xme:ZRLUaNOx0LeR7VrfYvuxgfGS19pb0PwWEOLumXiTBbiG8kLOt5mw3gcGEZmTqlKEW
 0juL4h8aHQE0FXrKd3THK2TUpOuneoW9lra4y2ETPWYudgQw7e9Dg>
X-ME-Received: <xmr:ZRLUaFNSIrvXVONh6MEyD0_OXMKTl1es0GjPy4EcPoKa00ebb1hiWGGDZK-LSi2oVeKghEoH8gL1tdX1BVu3qxAyijzaR_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeige
 etuedugfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:ZRLUaN8-qzo3EZQ7gN1XlRhJBcw6efW0E7yKlhQcDQGU1WOxbEk5Jw>
 <xmx:ZRLUaB4VQ2GTtbJh2lDXway3WUjhSrY8QLyFpvokxAI1zZgJ0EtjnQ>
 <xmx:ZRLUaM06C1LGID37lvpwMX9pO2gHi095dq7ZG3lzORqTGExBjR_-tQ>
 <xmx:ZRLUaAC1XupSY7D-aogmZyBqT-TyiLDVuTAOcoGNq0zVWZKoCWg-gQ>
 <xmx:ZhLUaDheBMje5ZoTwfkh_hd1UXRE6aAPxgsKvI3TFaRSzxFDvrL_0jjx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 11:46:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v3 0/2] lib: fix AVX2 checks and macro exposure
Date: Wed, 24 Sep 2025 17:43:16 +0200
Message-ID: <20250924154641.2684705-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918073135.1273767-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I've found the AVX2 function is not used in efd library.
Then I tried to make AVX2 compilation simpler in efd and member libraries.

While at it, I've hidden a macro which was wrongly exported in the API
without having a correct prefix.

The v3 does not have the patches removing build-time checks:
  - efd: remove AVX2 build-time check
  - member: remove AVX2 build-time checks
because I'm not sure losing inlining for cleanup is worth.

Thomas Monjalon (2):
  efd: fix AVX2 support
  member: hide internal macro

 lib/efd/rte_efd.c       | 3 ++-
 lib/member/member.h     | 9 +++++++++
 lib/member/rte_member.h | 9 ---------
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.51.0

