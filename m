Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 17:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35DE240280;
	Tue, 11 Nov 2025 18:32:49 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 373864026D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 18:32:48 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 928961D0013F;
 Tue, 11 Nov 2025 12:32:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Nov 2025 12:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762882367;
 x=1762968767; bh=4AQywcVYfUkJIEyjLKc5hx0jE7DxtWybUE26P84AIDM=; b=
 VA68rRR/RI0Yzqi1HTnUcrXQSAPQFqm0p/tSUWbT4kqGkE0eDceZm5XR3EnUc6a4
 HdyEVNhk7G++dE6NP5EWs2XQejHJy1TZza8Gi+APG3oIEYM2Rmkh/nWkS9JUCfP+
 tziPe1yckVRK3L9KlC/SnB+VBaB+LtrYLMtdFI88X1SM0uuf2Vx9sqhc8puCksEn
 WjMJSMhJgrhJ/iPj6TDSR6EnFboEsB7e+vzcdUS1f0GKimJixox9GM9DmR4sapTf
 2JnDsPQWINiM2O1+FmAWQdi1PQclqTYs3EK0L72UCsUoDCyfOPJW8pBePs8S2aYq
 nOWpJsw81gcjUkiQD38EZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762882367; x=
 1762968767; bh=4AQywcVYfUkJIEyjLKc5hx0jE7DxtWybUE26P84AIDM=; b=m
 /WVG/PPfYe0BcsQ1nXt7DVDRacL42CN8tMknVKbvjwIVstbjpNJ0WlNf8kIXd2H4
 YKPOJr33SJUJZeVQRHqBHFuzBuJU1amZWPvjmoN+bukUXhwnuRCZksh/N9yVqnhH
 h5KY61kgc4MgHGkr1L/d6oDzu5ddolWbSsH3BPqA9vBppeBB6kiX+l2lFt4w/kTu
 Y8kWeNlYhGkSQE+AK/cBZHtDLFTBuZ+fTaORml4GdYcu4r57I0zk68NsEeAsMG3a
 i78lu7z6Pbhc5XIQAgZDrFns+wCQtK91/SD5LCcGBT+ZLJqvr92cN73f61vL1dVh
 Jv4IdHeVNDM0/2gXE3qDw==
X-ME-Sender: <xms:PnMTacrTiBjikwwEkBsdcXhJGjK-1RNGvAxMVzXm_6DTsS4EvwMfaA>
 <xme:PnMTae-VbIzNq37cwBWMpK8NxJNWwjvvuvJwDKk2RMVKpO3KPG03QmDCdiR-mukOq
 FnRVXTK-51gFG9LOvGYJ_AwcBmKTnJ3SS3MP8NTinTu8nuHXEixbw>
X-ME-Received: <xmr:PnMTaT-aQ-I9I_G-EJLhnrerI1-0wsc9QKXNdTaFoAD36kPmxwaI8In0ZYt_x4wWNDjXabLrbrufNlX12tsgc1C8Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddukedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:PnMTaVvmBMAvwmVV6rwqdkmwwU4TBX_W6G4GzIb4R7JrcIWDXlWSkA>
 <xmx:PnMTaerMOKOlAF2rV_20mFgaThqSpoSavsYSo9qCk_1trh06bBDPXg>
 <xmx:PnMTaanE24KPLxPjD80hF4l9nD4ejJrvfV6uFbInCxhirbiiN7fxrw>
 <xmx:PnMTaawP1e1CJnK9WrCTWJuSq-XL02eG2a7hg4HYmIxtfpY2aptY-g>
 <xmx:P3MTaaRqL6XNK2VAIl0wP3wOfvBrDI5-1fIz_PMghKgue0r09ClqKCvx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:32:46 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] format telemetry scripts using black
Date: Tue, 11 Nov 2025 18:32:44 +0100
Message-ID: <13405941.IdSKlfLAKj@thomas>
In-Reply-To: <20251017141927.1156370-1-bruce.richardson@intel.com>
References: <20251017135622.1152341-1-bruce.richardson@intel.com>
 <20251017141927.1156370-1-bruce.richardson@intel.com>
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

> Bruce Richardson (2):
>   usertools/dpdk-telemetry.py: correct script formatting
>   usertools/dpdk-telemetry-client: correct script formatting

Applied, thanks.



