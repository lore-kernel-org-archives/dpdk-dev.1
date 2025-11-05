Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E18CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5213840A87;
	Wed,  5 Nov 2025 23:37:15 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 5B910402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:37:14 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CFF9B14001D0;
 Wed,  5 Nov 2025 17:37:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 17:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762382233;
 x=1762468633; bh=+JGUlBRXUtCt0boFai1VH60YUMgnYZ1oaiaSZZjDcDg=; b=
 DriUCoizhrTe6Wge55tqWCdOjF1ZqS8/hkz3t84eQaRgks6n8zepbTSYtVtpa1Ap
 pufESk074dU8XxVW1z+xnVwn58F6mXE+VTsXJ/wcfw3gEO0mKh3iG/D5S0eZEhJH
 h0kYn4IuP1iye+adU7IOF2JVPR2eBRA/4wtzd4QhZWMkYHsKiaMRudNMBHfQIm1k
 6DG/LnnMa6cEmhxBJCJn9r7vBo+26JkZftaTZKmVz9bvakOSC4YdZTSYspFpi24U
 TdmUEuC9pKKOfCsK2NHB5vQ1ho5qM/bQt7MAVUpFKd6FqzhICihR332rPbiUiFp9
 f/kr8wdZLiafhHogu7m+Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762382233; x=
 1762468633; bh=+JGUlBRXUtCt0boFai1VH60YUMgnYZ1oaiaSZZjDcDg=; b=g
 csli2nWMGkJAFZ9JorHirQVAxtQ+tTIKKowgJ65V8tzeOuCQro6eR8dfKHj9J0ak
 5IozRe9aMbaWQtCu6zAHbLABV1qBhG1GNIKCzhQCBpykzwgh8OuzBSSmmzWCP7fW
 GQBVKoxvzXRNQojUuVaAFkEscJSDPKszjfwfnpjo96oIiBHVA5UFIH25SHW+7nEa
 7tEHAYRV2C4tVi6Gv0LnOt4wBEyAnyb/YoQJQ9z9exAQuj20ZZCw5JMrnmwSK3CS
 f9vFfoPNVMTolTv2+2kqm03BiVGs12qvKocQ4e0n5sfMeRyGR9bT6JbUAecLBMZj
 f8fkF/hlfr+Gk/Jx+hsIA==
X-ME-Sender: <xms:mdELabYDATHiKjrq4g2-bifAXKdEaR-Q1yB_sh1dWVzlkaCV8h7sqA>
 <xme:mdELaWsFN8iKyept59S4D94gtsz27PUIxDZ2dso31VkrivB-cPHRDNz4py3QqADY3
 1CIEsDVskf38PP_kMWa1TrT3vwaAhv4K2Ra_Tt4CIsvhmHASDPPkg>
X-ME-Received: <xmr:mdELaQt67oUJstY1rzcl_a4grP-VERl07nbexsz5GxGPaK9yrwELk-aFgQWBdD9JqAxsxTzK8Q7d5LWrpP1bIRs3yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:mdELaTd45yzEHARhnSsc1vRLxGQrebeYpvQLngWRuQj2v6X3KfBPZw>
 <xmx:mdELaZaPjM1W2h3JC6Rq2BmhLHrOo9axHbYjCE1t0crltezF9yZMMg>
 <xmx:mdELaeUv_GcDccsMFov8lmQ4X7rq0h0-Tg72JSLtr6cA0qYehd-Smw>
 <xmx:mdELaTigSoDIF_uKFl8QaKCRP1V1xvjrON-x39-sSDW3iudf-aA8Qw>
 <xmx:mdELaaZ7LaLo-6Me4uDICZT99kSg9oleH_Dg_LUyKBgwVOZ-oaUGh7OI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 17:37:13 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] check-spdk: check that tag is on first line
Date: Wed, 05 Nov 2025 23:37:11 +0100
Message-ID: <2592245.3CdzvNlvnA@thomas>
In-Reply-To: <20251105222827.904627-1-stephen@networkplumber.org>
References: <20251031142018.49319-1-thomas@monjalon.net>
 <20251105222827.904627-1-stephen@networkplumber.org>
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

05/11/2025 23:28, Stephen Hemminger:
> For C files the tag needs to be on the first line.
> Add a check for that.

Good idea, I didn't think about this script when fixing files.
> -echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
> +echo "total: $missing_spdx missing SPDX, $not_first not on first line, $wrong_license license errors, $warnings warnings"

Can we just integrate it in warnings?

By the way, it would be nice that the quiet mode does not print this last line if all is OK.


