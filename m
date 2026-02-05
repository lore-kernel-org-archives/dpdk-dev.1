Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26471E8B39F
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 14:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DDDD40E5A;
	Thu,  5 Feb 2026 15:30:29 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 53EB340E09
 for <dev@dpdk.org>; Thu,  5 Feb 2026 15:30:28 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A94801400155;
 Thu,  5 Feb 2026 09:30:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 09:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770301827;
 x=1770388227; bh=2sRPFfrVXjz4pUgACZRoUZIwQNJjIzI2jGIGo0Qab4w=; b=
 H/rMJxtM/78OPCXQu9IAzxN/CJKG5I+1N9wrKfcbRu55sGXt9JI7NqKjzBpqUjZD
 hfUvEss4apwpJWF1+liBi+S/gZZnCBoi0CCz89Qr6LmM0KTvsiH865np0Zs+Y/x9
 +/tTImgyBewNe/Acrw0mt9ABogaMT3zkFAb3oYfOdnJaboVmlKS04khuVMdQJBdc
 p6OdhP7UjjbkyuSofPxD3C5S43rFJD2d7iUEKTru/A1ytJSVb8z9qns2iNsSGYCq
 WlClkrxXeHax9LsmmguZ0kN+E4b9T+sMq5VxTichvThEt3f8Kx95tshRvf4GybHk
 80LTAcC/wwSaxY8alTnpZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770301827; x=
 1770388227; bh=2sRPFfrVXjz4pUgACZRoUZIwQNJjIzI2jGIGo0Qab4w=; b=C
 7ZtTDTaSRh7XFaHAO6GtC9cXCqhcMO99VpbqaIlTOhQPWWRK9jKZfkes2h2b3dhr
 aAPUANDnninBv2TZAjsQMPvCVJJUUoj0EcQn0iGOKj/L756kUnkzCaFP1DLh9KGn
 ValuI/dtPxFx1irKIgvsgjlOTYz083VxOTeKw7z2iLK2QFfXOZRuK8Pbe+vXZSVN
 x4eYsB4L6hbbRnw2RcrcGRDtZVgXKPqOBh32uCyqCqqR0gEglLdMp3xOwcmQj61V
 q6NG8Pqb1ykPF6JIN3uO4k7amWPARrCvapHreSu2747AwZSfopVlxMHJOOc9xFog
 gQ5ZDVs4kGgYAyCsz1EWA==
X-ME-Sender: <xms:g6mEaeZecWuzROSEKH53IvRjLn2fZyvIuh1WB3nnsWugbfLd0JcsCw>
 <xme:g6mEadv4OkzoF4WiU1YhfHFYnO54zXx4pViIDsOyTVCz6Mhi-jye7jYSiMp0mHGp-
 QmLKaAOQFVmOWrr9bwbwvbEUpE6MBzdzXIDyxro-zGXV5d_gU3Ba7E>
X-ME-Received: <xmr:g6mEabvAk9Py9qfQxYTCsXdKl6EuQ1y7XOcdzGcteKbsx2XJ93gTmYJz6MNr_usVRw5bvr4W3R1ULJZAnWLtdQRrHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehheegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:g6mEaSexCIT4qBE5nMYRSUAQxDcDiq5afHbfuCv3lWz1z8Ye-lDhLw>
 <xmx:g6mEacZtGV1cjwh1haCseJ1LNPN-BkeLpVhCOJEVlIwXG7ZanexaZQ>
 <xmx:g6mEaVXq1YqfXXweo_bPzZYEW2NU9RZn6h9Gv-NryU6cUbTJk9Gh2w>
 <xmx:g6mEaeihv_M15LiSiQu2qQ5vAei3sr_rvfokcTe7ZwZcInVF9W0xWQ>
 <xmx:g6mEaaDbefzjIUHVY5PMm6HoqZfqs9NmqH_8kTNxwBp0QVEWvu-PX31K>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 09:30:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] standardize SPDX tag
Date: Thu, 05 Feb 2026 15:30:25 +0100
Message-ID: <2888376.taCxCBeP46@thomas>
In-Reply-To: <aYRYW9PMGfu3NI_j@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260204204945.3893117-1-thomas@monjalon.net>
 <aYRYW9PMGfu3NI_j@bricha3-mobl1.ger.corp.intel.com>
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

05/02/2026 09:44, Bruce Richardson:
> On Wed, Feb 04, 2026 at 09:46:04PM +0100, Thomas Monjalon wrote:
> > SPDX lines are fixed to be more standard,
> > and the checker is improved to detect some of the fixed issues.
> > For readability, the script changes are in a separate patch,
> > but for the sake of atomicity, the patches should be squashed.
> > 
> > v2: update the script and README, and remove useless parentheses
> > v3: keep Linux uAPI imported file untouched
> > 
> > Thomas Monjalon (2):
> >   license: standardize SPDX tag
> >   devtools: check SPDX syntax
> > 
> Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied



