Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7DCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 08:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 410C740292;
	Wed, 27 Aug 2025 10:24:31 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id E0C354028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:24:29 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 14D497A0073;
 Wed, 27 Aug 2025 04:24:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 04:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1756283068; x=1756369468; bh=dJK2+j3uRmeExPIraWwjZ
 Hnn2Rrsjxabb6Y3hU70hUQ=; b=rz/rwU8rtYryYqvsve/5RVZRCksqbRdwdSKZQ
 0cwb6MlTMM106PtPNioOqYDmsHkQDm4LLY9gpk9msEnrQ1/Kg4vep7v5b5SMpBWy
 g/Nqb+b9IAvd5fyksgDLtdBe1ALREpAMAxdKnZUhJ6fE5m+kRZ4rDZaCR/llF0a6
 Tw27eRRb503WYkQB+l745ND73iASF3g8r+LUKBNKHXzMdcTb4a2oZQE4+fWdtBAW
 ePEdUcW75YH22qN6txWGdJ/QKqV1OUIwl6MhEaZ75PbYLpBch1w7xwgOsZHxwUgt
 bdv7KDzv36qMB/EP/ATMrIPc1eAWiJ8Dn3gLqf7f+AGAp48Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1756283068; x=1756369468; bh=dJK2+j3uRmeExPIraWwjZHnn2Rrsjxabb6Y
 3hU70hUQ=; b=gmcbEjmzCDQlk6xbyE6fpv3G0tdzRFIwVfXYgBYzSIr3zY6bAs/
 4fUzhqF9GSKS5b1LDdScc00eZ99IWDrG6e44dBO16pyO8buXVjcPOHBHZwKFcHqQ
 Gc0c8+Wg3982oMEu9/lMu8XpxWII7K00WVQJOjUlplVo0RcpK4xn6bDrZkx8gsqc
 xJN3wNsv0jSujX7fytIMBGqWen5S+vQ1Zg6kcN38huDRb6RQHB6H2r6m1DseIEUY
 HoE5CEHnpsR616etrMySFztqLISUxKVxkHvQXSdXIR2zun4cXdLZ9cRmeU9TzlMI
 hTnkh7pgopae3Ssn1KY6E0yMBpmjgmIOHMA==
X-ME-Sender: <xms:vMCuaO4uyFB85hX9dCxuwOMX6ZR0jdCkZ9z-Rl9NYq2S202RGBi-iA>
 <xme:vMCuaDKcfu-MP4mSv4rRu6jdIJ3v9g0tpWvBYss3qV2bMVJpgVO5seRKcuib7NXg5
 Jft5_9O4kPbubfVpQ>
X-ME-Received: <xmr:vMCuaOGB9bnKEnVjfrK4-IKdXvCgowmqKLdCGz2mxZn_67P-OFMLpZQ8D9kxJxFOYdzgK0YHG05TBFePDKbvIV0430HinLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvledvudehvdduudevuedvveehge
 duleegiefgjeehudehtddtgeduffejiefhgfenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpd
 hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghv
 seguphgukhdrohhrgh
X-ME-Proxy: <xmx:vMCuaBXexhVInqj8oY5imlvox6Swn6B8qESuRmuGhZOS9a_sPwd4Iw>
 <xmx:vMCuaBjuBEuUXvtCw3boha3Cn8mp0YF7mfpl6yxxJ11lgxWAoPMfEg>
 <xmx:vMCuaKTlR04bHdkMrKcBerBk2n2qGo0A0o3pDVWUng51Y5yRGAqu8A>
 <xmx:vMCuaMELyZnJbXRNkr6d52AzOQNgjg80FEfhxmw2AwZ28iAuQr9dgQ>
 <xmx:vMCuaHJoci1GCSdPVxPY9iPR0sqldDDP98UBBwhcZwq6SX-YjbObDocx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 27 Aug 2025 04:24:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 0/6] devtools: improve Linux uAPI script
Date: Wed, 27 Aug 2025 10:21:43 +0200
Message-ID: <20250827082413.1417226-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

The main goal of this series is to check Linux uAPI headers quietly.
While doing so, few minor improvements are done.

Thomas Monjalon (6):
  devtools: remove superfluous curly braces in uAPI script
  devtools: remove superfluous fallbacks in uAPI script
  devtools: move uAPI processing into functions
  devtools: remove unused variables in uAPI script
  devtools: make uAPI check exclusive to other options
  devtools: add quiet mode in uAPI script

 devtools/linux-uapi.sh | 146 ++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 66 deletions(-)

-- 
2.47.1

