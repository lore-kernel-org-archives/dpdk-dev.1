Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735CCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 00:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E91402A2;
	Wed,  1 Oct 2025 02:12:10 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 5FA28400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 02:12:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 6FC861D00026;
 Tue, 30 Sep 2025 20:12:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 30 Sep 2025 20:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759277527;
 x=1759363927; bh=3KsFhFhCs+MqQMOwhEzffpJImh7hOPZCLiPCeQmK2vQ=; b=
 Q7TiZ7MMXWM6QCDdY1QEgLxAhNORXscIDo0+N555v4EDkt94Un7Yef4zwehkGMMr
 yw6ncTRfwty5SCXb/zqRKW6Lii2fMtFvIBARvau/np0GNu+e9f+oZ8V9SwscPx75
 jLgAozFEZ6Z3w1MNwkp40IHm8prwpAtZkTTOI8XTOZOraPN+Gt38D3SUwVTnxUGo
 +CdjOJ2A4rTWp/ez2z9Fcy5glsr086l3AX/WflL2y64hrxfRkypZM0ComyPMo68C
 xfCAp7PN2uT9msnrWp2MEvCBfo57uRdknHQg/bNUOr3IQsK9S3FSKMdd9u6egaUR
 aHe0iNXkJ0qrmI/VI0/qMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759277527; x=
 1759363927; bh=3KsFhFhCs+MqQMOwhEzffpJImh7hOPZCLiPCeQmK2vQ=; b=a
 Zi4IDFJdJgWLFx9jGppHiMjotHOeS9CUccyzlAuceQLLXgwxBmYvyGl0hL8RnS6D
 UOtiRCXWUwJf5B+H6bugMUwSVe6FtQcgradXgnsMctWzQMqlUtQY6GTinC9kbUDg
 7JiPDQbDkNrwu+cXi5xPrDwpMZWJ0gyIeBIEgvXdlQSinQUoa6UVmHHizyomNEoY
 xypHyyVgmWWyDp3UcPa9Yh2LxabWOlIuhOmt+g5mCXe72g4nJ4qmlklEeiP3rTH9
 zKMrUqz5TJFzbt0MqFSwLW87yzdyWdCSIgtf7t2wTtvyAKMm2epESvbPTehfbFnz
 IY5oRpLl14uNNsTe/+vWg==
X-ME-Sender: <xms:1nHcaK5FjCsaQ5yPt7kqKfyJv-GPWkxeafnfSnsMXnxylx3szF6eJQ>
 <xme:1nHcaM1YuLWV9pFddVeIQFbpO9-VS69ci7xwwQ5kpDaJRsNR5PjTSgtGmIhqFyGwu
 MehztkxfbSv9OM-WeUMMV4oQ4DuHKZcNUOit-ruP7o7GlY1o922yGo>
X-ME-Received: <xmr:1nHcaFBFe_j7uPZfCkVgXp8xxTmg1W5bYDveFUK08qBoVfh_Ew6NZtLFUjK9d7Fp8dpSikdrQC0uiaJBnM1vPWRoxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthht
 ohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:1nHcaHOk88nQIscdn4qCcaxNa-gOzu2Htino159bn-DGWHoLCfqeQw>
 <xmx:1nHcaKaxQ396r-AuAgBNyaaTxwK4ykCXzdvcolh7QuUZ0pNr1f0MSg>
 <xmx:1nHcaGs3Y57RXnUXZQfOTRgfJv-pQOfxno3QJH3itIs1I2WwJQj_QA>
 <xmx:1nHcaMOJItu65bJn8XnBzFkW3iK3v4wUHr7oQ-LA46wnzVn6-nHeKA>
 <xmx:13HcaKnfLZd41Qbll_PT9an4toP1M-m_j1QndWzs0Ft8iPCoAxz8ZR-2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 20:12:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: Re: [PATCH v3 2/5] mbuf: record mbuf operations history
Date: Wed, 01 Oct 2025 02:12:04 +0200
Message-ID: <4350189.usfYGdeWWP@thomas>
In-Reply-To: <20250930233828.3999565-3-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
 <20250930233828.3999565-3-thomas@monjalon.net>
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

I forgot to mention it is experimental in Doxygen.

I will add this to the header file and each function:

 * @warning
 * @b EXPERIMENTAL: this API may change without prior notice.



