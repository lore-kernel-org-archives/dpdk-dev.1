Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF3DC71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 17:09:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29887402DB;
	Wed, 11 Jun 2025 19:09:10 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id B8FA640144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 19:09:08 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 275F611401D6;
 Wed, 11 Jun 2025 13:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 11 Jun 2025 13:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749661748;
 x=1749748148; bh=ynUK2AIOF7cSYAdgITd2Bv9SxY2FppDgtlg5jT7Dqu8=; b=
 Oi3dGb6ZhIW7oOur6ciZEUmN+zryxV/uxT1v1nDFgt4+F+AiFjbLA4a9xaLbA5bz
 sP3LarI4/L1WPXosG5TxYyjA03/BIzlJLFmL+08+HLUOtSCIRlZdzm1YlbAuIuX2
 GG+MYLF8ueFhI+xmtl0ZQUs/I7jm6wCHgLOU22Bjh7cUKoxnkViGYKo/F6oBmVPX
 hjhMipIIh8aYMpwwm0VU7t3DzeD1T8uqZYuPuyYf0W4m+dlBS/ct5EQW91cyf67G
 IWUAKCz0raqx4YOIKDeWGhZn9RUcLdURbCR/+GngpqikL0va81YRHrF67+mnNfgT
 FhvcHMbSsFkVVcYKUoWXqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749661748; x=
 1749748148; bh=ynUK2AIOF7cSYAdgITd2Bv9SxY2FppDgtlg5jT7Dqu8=; b=Z
 rV9zsCj8UpnMOSNO+jirRYN2awxY8lgTHkKNtyW6oTFBQ8jK90U1ewa3iLSbRIxq
 6+HAFOljpuXmvU1Sv3mxOroDc1yb8wyHUmQzUIGYl7NLQJbbuSDbjWoJKeyuQrp1
 JcCuymquABX2HRyP0ADwdZrSOwQRpzRizVT4ug7MSh4hVMhgGcJIROmdMLZRXn/9
 HYNZZ1dHn3l8lCaggiO2eAxtswc/PVCM1syx+cga/O2yup9MHZBODWPzQv4UI6T3
 s7FD0sVaPvlXBfkeD7TvdkdPQ7E8FaIHX0LflQNg1owqpH2uD1M4NrU/RN+7Cg5H
 kyN+xmu4UbL7ONMDAWzsQ==
X-ME-Sender: <xms:M7hJaPY3xy-Ob7IGpMmqdtort5Rh_Cidin5krj-c5ib68e0pj7hzMQ>
 <xme:M7hJaObz14bf7teWo5Ay14H0shIwBMNYcAaoa8U-kDnV_BjpcpPTuVDEP8GDZ-G6L
 cc5C9S_c49tfrbQcw>
X-ME-Received: <xmr:M7hJaB_Ve7K_0wg5oL9G6jNUpR5plgL4tqOBOVGaCrztOVHQ7mNlzem6GEfEjUbV6QBK6PtFcU8LGP8a8i0hxQq-Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:M7hJaFoEq99vu7hZFw7T-t4eUSJHDBGU_2FSKc2Qh0KIAmcjoPt9Qg>
 <xmx:M7hJaKp69SwdjJNYV0zqeqi7MeJO7qD2wN5qMT61wGVR7YYwvKh_5w>
 <xmx:M7hJaLSSWLIw3KWTyH1XKqf1nocXa-WJpWDauR69PbU0Yxl0VbMd6w>
 <xmx:M7hJaCrAEUy3mi_b78XRnWLqsgUYqcrUffqmz1nASxZUqu9jOj2w4w>
 <xmx:NLhJaIYTBToHeY5HF-9WTqSn2Fa4TiT4iCUp06_cvjPHplApRNzpaE86>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:09:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/3] argparse additions and rework
Date: Wed, 11 Jun 2025 19:09:06 +0200
Message-ID: <4056767.kXSN5OTJKJ@thomas>
In-Reply-To: <20250611123649.481811-1-bruce.richardson@intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250611123649.481811-1-bruce.richardson@intel.com>
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

> Bruce Richardson (3):
>   argparse: add support for string and boolean args
>   argparse: make argparse EAL-args compatible
>   argparse: use enums to remove max-value defines in lists

Applied, thanks.


