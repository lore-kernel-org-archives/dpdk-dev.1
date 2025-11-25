Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28D7CFD36C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 01:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E05D40674;
	Tue, 25 Nov 2025 02:07:38 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id A8CE5402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 02:07:36 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 2E865EC0178;
 Mon, 24 Nov 2025 20:07:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 20:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764032856;
 x=1764119256; bh=rzZAIEGZ8hvE+5mbxHwYpktXQtMdB8EkkkgJ2zdmHoo=; b=
 VRJukdoiKMrAAlKw6N6lkImKB8Xm++Bwf0ISqAU6hsjYkuUmtihfuTpHIxhyTPNH
 +PLj3P5j2v0KAOv/fYdc4HOKuJUrn1lk8bh442DPcF6JKPP21UVQWy4r4wTT+Bh/
 +wy10VAKZtDs5xSCVKPKBJ8GCvtQHOywWLDThqO76Qm0DLcrLxI/UlzjTgtr5vYV
 Dq6QcHGoaA5R7XvVNLv8rG9Lz8g9hg8nY2mpSvVkfCzkgJXr0eIOJDMmhihWWOGH
 722aF4JYspSEd34CTuwGIWweM0NI9IcSwf64mtTrlKhZ5i3pxHjkvgJIfpP2LqTU
 mXfk7HypFU16vbf/OfIDOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764032856; x=
 1764119256; bh=rzZAIEGZ8hvE+5mbxHwYpktXQtMdB8EkkkgJ2zdmHoo=; b=m
 zet66gt3icZ/YqP9Cr/YPyzDlUA8zivZxbKu2zLnECFtOmXVm68nFA91PK/I4yq0
 nzpdovhWTdytueV/WO+CtZl+chLBgGtto0OHCG572VAr9TmB48LeuqRXtuBGMsSo
 XF4zaNn9FsJHC0K9fYhpTTpx1vHEu3Ngq+99lSdOCWZQ6XF5/jkMJojGAXdKhwqQ
 z+X152NBiq7SICJg0VROVf564GMnwi5CByY7YP6UX4MxXwplNyUC4u5bBm+/T1ep
 hWGrTOOI9kEJKcqmUFl5X9NuvZJLFFTOfIOaNpdT5xb/yyNWZUV+gCydnMHN8cev
 KEZjTCFK96pDIGOz2ySBA==
X-ME-Sender: <xms:VwElaaSEomvlslvuvZBmb9iSL9UGZjA3rRhwMQXFRfDrY_GfI3ISKg>
 <xme:VwElacG-OBik7HhzClnlZVgP_wnzRY3EPjhFheHlumMe8aKpRZCph5Gt49tswhEzM
 80cqANM-9haQwqd_H2r9OdBffMc8-DJm_t7GHVg_91zVfwgr6zO>
X-ME-Received: <xmr:VwElaamndZK5FYzVUTE5pzoJLq7xCeo-f-e5POcG6cnWWhE8jbcZdAxwzrHURkFsgz9dlEB7KC03bcDknUa5eAmAGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:VwElaX3YGQfHyQTzQ3IW43YCD6Hznph9MBIj-a3UO7Ztu7-p1Tg1Mg>
 <xmx:VwElaWRxBmyW-auuI2xvFWE-rUcNup10dClZDrjrPeQWjAW07Qt-8Q>
 <xmx:VwElaZtoqDBHS44YXqcR_qdiUbyzSUJ8mZSMgfG3IIHOWqFNIMAHtw>
 <xmx:VwElabZJWshDAnxY2CMTLQL6nMi6O9cZMTNKS46N9FblU-HrVEVUhA>
 <xmx:WAElaYTZf9bK7wlco-aUT-6dgUA8tghRoujVZddb5ejucgbegk6Qx3R2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 20:07:35 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: remove KNI diagrams
Date: Tue, 25 Nov 2025 02:07:33 +0100
Message-ID: <3974675.VdNmn5OnKV@thomas>
In-Reply-To: <20250814154604.6878-1-stephen@networkplumber.org>
References: <20250814154604.6878-1-stephen@networkplumber.org>
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

14/08/2025 17:46, Stephen Hemminger:
> KNI was removed from DPDK but the diagrams in the documentation
> were left behind.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/prog_guide/img/kni_traffic_flow.png | Bin 366308 -> 0 bytes
>  doc/guides/prog_guide/img/pkt_flow_kni.png     | Bin 51088 -> 0 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)

Applied, thanks.


