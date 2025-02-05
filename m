Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E773F40289;
	Wed,  5 Feb 2025 17:41:55 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id DE93F40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:41:54 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 752AA1140126;
 Wed,  5 Feb 2025 11:41:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 11:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738773714;
 x=1738860114; bh=U6Z/sQiWtrOxVwpqBJRSYz7hC0GnbJEUdcNz+g7BRsQ=; b=
 Wvqe8w9TLsAh8ay6cA3T4BdulQyG+mAcRwbmlqFTJ78ttxyBavujL6iBfVeL/Ubj
 8++HCAcfJSs01UE14qLfmQ34giwyBqKk5VdJqKeFIy79RNVClIGgYahbEyMLsPbG
 dTUGTlrsRvR+2l/vbj5qKVAMEWNy0Z8O/MKFxQvKKAdicAoHoqn7etYLxmeGdN24
 wrtLPldxj4AH/K9UwAbADUQLvGaye8uSNOcHZi6Wdoj8RB46t6FNiTgiKlCo7sj9
 wSatC2dyFyatPKs3/htHoAs746xanUGbMFLx3HVneJRnfk57AfRuD0m+D1Y6ojTL
 6H+Z3Er4KvsVjjqB+eIyqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738773714; x=
 1738860114; bh=U6Z/sQiWtrOxVwpqBJRSYz7hC0GnbJEUdcNz+g7BRsQ=; b=V
 PEdyLlfKG4JTOe/oFdfEY0p9KGqS/B+avcVYKODeNQk+BDS0pud3ck2bv7QJEn/3
 Z2c1OIZs3rRkRPjHCaCxTaDbyLvP4VkcjZ2+jI1ND0UY/EBDyRfdrirf42KkWwea
 y23/yp1/eEEr5cZNC3zCGYLCuZN0cAzUbaWt6j+GBOF+x0J8G78SO5ftU4jyzQIi
 ymYqFDYmWH0bq0eJMns3DJKVyYZYfOS7uQQsoYGq3LK8g3LICC7IBdLoKRjxkxeN
 CJ1fheSy8W/oPIRJ72TH6yOHLv3/RUJEhiLZ/ac+OlNb1aQztBFApFBKaGQ66Tls
 JQau9SvCKofRxk1DC1WXQ==
X-ME-Sender: <xms:0ZSjZ2bL2SeFlMqpE2NJvBlI-eOMmQnpoIBucAGUbm-FJexHEe59Dw>
 <xme:0ZSjZ5Zad-I6JKAFQEuaAYTHwLyqzr4xnkMFJRsburAcKnmIUZUA1AECavZIKPhLR
 C2fDgrQeUabrw0czg>
X-ME-Received: <xmr:0ZSjZw-u3DVqmrQ6k3NuDkCdh6vgXlXTn3zwE7gNDdouYNG0heVVeEXk5OFps7xeFinodnZPVHxPD1dd1qoJh5TILg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrth
 hhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtohepnhgusegrrhhmrdgtohhmpdhrtghpthhtohepughh
 rhhuvhdrthhrihhprghthhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:0ZSjZ4oCD_AvqKH5-uiekhaMrz2JvD8gz7_nRJ2UThLPWWVXp0iK6g>
 <xmx:0ZSjZxrVJ_IYuvJlmRphBdrkXqgdENPV_-eU4r-wHJynAGC-Or984Q>
 <xmx:0ZSjZ2S0SWWwaDB37Eg23iNqZNoMuggqYhD2rDsuJXUPIgmphtOXWg>
 <xmx:0ZSjZxo4Qc8pkAMgnbT0VFNU01BHrNLmVhjgVj-v9X0ckd3Hu4my9Q>
 <xmx:0pSjZ6ANt9xwKP0GZWSK_pttxg2Jhf6FrLZKjtNc-A97aZPBFDyK08uC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 11:41:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v3 2/2] config/arm: sort SOCs alphabetically
Date: Wed, 05 Feb 2025 17:41:51 +0100
Message-ID: <3364792.clyjiGRsXx@thomas>
In-Reply-To: <20250106183146.540161-2-wathsala.vithanage@arm.com>
References: <20241028233139.922029-1-wathsala.vithanage@arm.com>
 <20250106183146.540161-1-wathsala.vithanage@arm.com>
 <20250106183146.540161-2-wathsala.vithanage@arm.com>
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

Recheck-request: iol-compile-amd64-testing, iol-compile-arm64-testing, iol-unit-amd64-testing




