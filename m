Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A251CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:46:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F5840657;
	Tue, 16 Sep 2025 16:46:40 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2C5CE402E0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 16:46:39 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6CD2C1D000FD;
 Tue, 16 Sep 2025 10:46:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 16 Sep 2025 10:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758033998;
 x=1758120398; bh=5BFhn+otPp9H8aycSNeCkv6oTZqTu3LXELm5mbR/rTY=; b=
 Pn17KKkgxMYsPDOiTOPwvvuh/7vSQHzxx76MYYbL2stO1FmQ/Um8fUU4lAvT3ExH
 vGj7BKdrgBM9rAlj1dwu9JNuJHGMWdhzc63rvoPKVjRmPuo7fomItsTB3lM9eaKY
 eswaKP6DALY4BhLjoGM0/SG+VO+mmW9c/R8O/OaUtapyOKQprPThggBgPIWq5OSq
 Zgo1SWLE9EnYmru1i+Pqf0+vGUAL4UFtfi3tBl5sHeJaciSi9HGS2nOwZR0eysYw
 I/OD2ZAuLqZsFJXlEzZ07UUbrlAL/23lrY1SdLvOPySakaOWUCbTklqHtChEiuJX
 G1DCmpM0tnvahXus0kCX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758033998; x=
 1758120398; bh=5BFhn+otPp9H8aycSNeCkv6oTZqTu3LXELm5mbR/rTY=; b=A
 c7uWm+vXnN2PaQFnBQ0cZD5jZygp6pR5w3H639NR4964EUn5C6i1hrR9BxkJ2COZ
 2fv2AnMeNnk0Uafn5WKO77PUuGK14Ld1Oz1xTRj4T2Sj2ICAMfiKGB294ssbzZ01
 Whqr16+QoNyqjxaAbra65dTzEj8T+wj7NF3AawRJliidUZnKsYNkQIxxBC5Cf0Ic
 BjbChSVrPWM6ovN5HsnKyPXnwHIofoHN064/XcqbxRIK0C99qyB+Q7eLWi3i1P7y
 KMZj9Lrh86cYjNsSOI/5U4k6KtIxeYr8+l/W/l22PF4X3f4xvmHhCxMX7ou9jdFo
 6bloJ+iLltKGIyhMxKP9g==
X-ME-Sender: <xms:TXjJaCk0W3aSb9cUzr9L_Zm0AKbAd9hQxgLStzjRdi0BnjUpcZG5mA>
 <xme:TXjJaPEUfQhncaMuDprVuZ57aag64YQfVcApUCqPR_oiksXkKUG_e6_2FRggVVMD7
 VlpmKDIhp5OUUaYwg>
X-ME-Received: <xmr:TXjJaCUQ0iLfOiw9RZJU8MQiXDPYCJMKhAB0jh9z6_2ITadgBmwrqCAbGXrTt9YlHivvqWmssa9qOpjRFdntDLlc6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdekhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:TXjJaOwTV7rIbWTeUp6rGq2cSneHz0JQ7QXhuKKw5ZybfwjqTvY8cQ>
 <xmx:TnjJaIPMY8C-vLQ7Ewg-BibZDzO09QxDx1cFcNwfuMAXCbpCcJGFFw>
 <xmx:TnjJaH5DxqASY8QR2dBLYcatflNWwJBllrPPKmHNKrJmuGkFbrQUxQ>
 <xmx:TnjJaBPcza5vEOtdXP3NcEe-rMoWD2OHC_vNh6Q1F-rHkWdk1NCrOw>
 <xmx:TnjJaOuMUFD2LswotAMpeF7ECXbqms621qqmi8vCcc1pQzYFM8WeXX0L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 10:46:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update for packet buffer library
Date: Tue, 16 Sep 2025 16:46:36 +0200
Message-ID: <47516182.fMDQidcC6G@thomas>
In-Reply-To: <20250903110006.44202-1-mb@smartsharesystems.com>
References: <20250903110006.44202-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

03/09/2025 13:00, Morten Br=C3=B8rup:
> Add myself as maintainer for the packet buffer (mbuf) library.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
>  Packet buffer
> +M: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>  F: lib/mbuf/

Acked-by: Thomas Monjalon <thomas@monjalon.net>

Applied, thanks for volunteering.


