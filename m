Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB720C8302B
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 20:50:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 121914025D;
	Sun, 29 Jun 2025 22:50:10 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 8F1BE40151
 for <dev@dpdk.org>; Sun, 29 Jun 2025 22:50:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 04BF31D000E2;
 Sun, 29 Jun 2025 16:50:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 29 Jun 2025 16:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751230206;
 x=1751316606; bh=pyY5Ki/ZMT5kBdATVRNmZCrhdYjVqvawK88uJaWjxHw=; b=
 cuDdDNiu00CkU9pbvUt8TC1G2+sDR1KO+UPhDXD3BQkMtLSCRGr4rxAbN1hy22tn
 cC2WLz8BEY2fvHTb0YCaQmKuXQxeYsCDEghc5SwsawkvFGxYe0Wny3D+H6R03fIV
 ZmjCsCG4yMx1zmmWkV8EsKlbn/0EVlu1knMEuT2ZWwMdwwvpv0YcCSaIkDab2KPI
 GiVezEgchS97mW+R4FEjXNRP2JKZv2V1xHaAWJkDUS8GDJD9Ov9EC+GzQRaedMFV
 QNahdcHmH9FPsEkn+IRa/xzvft0ZEMhQFqditPCNzLjnPwuyQB/Kh/ePWffq/H9D
 ICJHyb1ZNqojyuuWRVJrQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751230206; x=
 1751316606; bh=pyY5Ki/ZMT5kBdATVRNmZCrhdYjVqvawK88uJaWjxHw=; b=k
 Onwanzc/VXc7EXgnn9oB5i+rJS6xiauT3s5Kjn1/bNVJzLf27OGCswAqjHxlLg11
 pw2pXqnrfFUMCI0XdRx0kYZKkW9yByOhjE4iq1NhC68BlS6lyyT+vkEh2YRcyRDv
 ZzT5gJSkBqMhie1wZa44SoUuafJJJqufWXcEyywpSssN+a/SeaJTKcQkVpPbQSC1
 ufh9g/rSblxxqPwlZzYe6CldeClYc4e+yv09I1YLfsqmKQ/B9cQSQPHMNKxKlMo3
 AB8hgHoTEXWpoEm3hWU+xO4VOHzqdhaxq7wzgs7H/TJ1BaBeZRSlXIeakAvnXoV7
 m1g6mogqsrLYVpX/XyzrQ==
X-ME-Sender: <xms:_qZhaLGXRCq8LkCqAk8NqDxeFqaMtBJSpgl7ueGa9yUugTUWctSxIA>
 <xme:_qZhaIW4nzwBZOswil1EUwprZ3dT9R3yKzABlMoOU2MS-lPGxth-furXgmaXmZOIg
 WgB2O78WGQmhZD2Sg>
X-ME-Received: <xmr:_qZhaNJmxbdpy_9WF9rj2bvhTPRqJR_F4_cocx4lmr-IGL4Zpkl7cAYDjq8yUqZU3jOT_BcOnS8wg90I1h4S0lAevw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:_qZhaJHf6MNUs2OZEIfVp3dRCK1wJNgS506QzpWMNIn0mFn_ntBL-A>
 <xmx:_qZhaBU787Y1MFaKsDM7uqWyaKnlvVXyvqU8JtcNyhod6CNUhiFNcg>
 <xmx:_qZhaEOi55ogkJndyoJWgUlnx9nn-uLnIks5mA50A8VuWMtrlxifbA>
 <xmx:_qZhaA3ayTIXYPuY4zELXKRY120OU72LjWQZnmBnFKVNT82mDtmsiA>
 <xmx:_qZhaFlzoarI1NzfeqJLckRBkjZnNe2D_kf-GJZWo5KQfxGfQyHQZXd9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 16:50:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] build: error out when missing elftools python module
Date: Sun, 29 Jun 2025 22:50:05 +0200
Message-ID: <4032111.3CdzvNlvnA@thomas>
In-Reply-To: <20250627152759.145084-1-bruce.richardson@intel.com>
References: <20250627152759.145084-1-bruce.richardson@intel.com>
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

27/06/2025 17:27, Bruce Richardson:
> In the case where we use the meson python "find_installation()" function
> to get our python binary, we can fail the configure/setup step if the
> elftools module is missing. This avoids later errors on build when the
> module is missed.
> 
> Old output (error logged and config continues):
> 
>   Program python3 (elftools) found: NO
> 
> New output:
>   Program python3 found: YES (/usr/bin/python3)
>   Program python3 (elftools) found: NO
> 
>   ../buildtools/meson.build:15:31: ERROR: python3 is missing modules: elftools
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


