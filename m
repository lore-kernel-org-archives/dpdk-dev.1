Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D5C9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D04504028C;
	Mon, 28 Sep 2026 11:37:14 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id A932440041;
 Mon, 28 Sep 2026 11:37:12 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 155AE14000B5;
 Mon, 28 Sep 2026 05:37:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 05:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790588232;
 x=1790674632; bh=A03XwUhoFA0g6NrAPww5SsyyJDJhCC1XzWrjzoIfoTM=; b=
 pRWSn9xsVKkAJxEJFDXbkJt7w8Wvlckya+Yyx+mrB+K7HILKq0kBkTd7eZIX0qCz
 9j2Y1oh1+06FCTE1oeHdqdhzzNKN1OoUNtFXY79Cu2/eL5nuQR1+hCUOrE3He0NA
 EpBjoS3x7yL5Y+OWNHLMNHWWaairb80o7xSqmKS8A1CJHOvHCJPRuDF3Te5dIKbu
 +RAhEktcrJB23KNZlrtF6NG+Jds0QBGsfpdapPJpml2lyTE3hNZ/aE9gsnzRH9zW
 VRNxrVytX/shrWI9uskICyw225UwUZvHZpmEyWLUVKyut01EdSqdFrE12KicadlL
 ic6Y5Ohop4S2wb5JtayVTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790588232; x=
 1790674632; bh=A03XwUhoFA0g6NrAPww5SsyyJDJhCC1XzWrjzoIfoTM=; b=x
 kqEZpjDWXFT9U/CwmpVQoUkekaJtw7xH7T2fNRfoU6hPuxACiuAJJgqrIT2xzr4e
 3Y1c76vlkkQ0MdCzqRGLeL8EcTblQBUcAmEPtMbg0Mg677EsNbc2W+MwSsbLPLkU
 Bj8nP9nI1+Bfm4HQvyEtrOwouuN/YQCktrcxhXzrf9xk0GqhUuDb5QDzI4Vwo6x6
 ts/eEja/9Wy81GCByl8pV3ZsiHb5V4UfYinb3Yf6uWQx0I81n3/9DZYnDIHJHoO+
 k/O6qxVeFxOSgAXYnk1wWYC4dDMCbeUab9eCvPM495UwvNYB+8SQFUbn9oWsId7L
 8f90CJtQ6nupMjV377bAQ==
X-ME-Sender: <xms:RjW6au-Y0m2Q3qIzIBwO2r-zH7WzkMiaqSbe138vZ2p9QN9fx7xglw>
 <xme:RjW6am2pZGEX8C3nnzN0PjlZUlwwUGbqhQW42NmQ8ahbCM7G2cwaqoW-OM5ibFHPv
 ouEou7vjuxwa0V8-3nOBWpou6uECLTnEmegVTPpx2MbWth4xOU2944>
X-ME-Received: <xmr:RjW6ajgfKWg-0jP0-BW_Aye-2y8yvvpdxjKpXLgvqSBRvBey_xYCbuhtjq_h1w8EYCEp5A46yVMTeORGy2MFs6B-U0AnEqs>
X-ME-Proxy-Cause: dmFkZTFDihG6aQPNxGzpwSUO8if/uShKNuXtFamariGyPCao32TkH6ws/LX6fXGWgldq7u
 nJ027jv1oSNWwzaDEWp0/0yudda8C83H6gQEamLfl/2qudKHG+v43nNveXoX7scPlyUWXe
 d44Z5n4reG3Y1wORTv3wvGYOMBaQUBhIBkMTMXZV//L8xi5p+UQTT7/+ZLb95nfC7+sxUL
 sHZGuLtYsXCsGtLThfCiSo8vsvLrEEKSaU93QhOT1zlpQ0BuXEtt5mRlkQy7xew60fCc7G
 dLEU9TCDhZThfTHiOLdXNhG9kaU40BMQSDJq0DAVYh63hRIjxOjYEL3INTXFOsp+u7qugj
 wKzTlpv0coeneN7LAdeWk4aa8gThRqQbF+gV4kQmUJoI6Jm7Y8gS3x/jd60iUumLgkOjOo
 yat7DXQlqjRRl20nJV8yC8WMw5X9kCnEX2vg0wEKVg+j4cY13p1RmOlDt5oYQbuoY0+6Ur
 J9egSMVu2uFz2jZTYwCWA4G7xNXn7ElxS25BPruDMEPQC8smntmhwms4sB46ykk9ay3844
 fjmPeWkqXS9IVjt/p9hb1/1XlN7pGe9+ridmjnCu+gek4IaVExaTUTDatQKA1FP6/g25SM
 e4zSbhpyENE48/FKR5XQnP7a5t4MWugWhdDCScbC2to+zUND7wCSFX+JCEsA
X-ME-Proxy: <xmx:RjW6amYZmfXvrsuolNqt3sRt3YT9j1vOsakH4tUvPFhUxxsXYUo7Cw>
 <xmx:RjW6avWV-XkdCQb0gJMz6cKCPTMUexw8nM4tNdkAR_yx3351njkp7Q>
 <xmx:RjW6auGWSEW2R4yVHkC7s83Nkz2XUyDHtmjU3DCktCeZD8wOLyGRNA>
 <xmx:RjW6apZuzIVUyqe1k3rjMQTVo7QWNI7DTKCFX1AfHUfxnHD1naO2iQ>
 <xmx:SDW6apfPn9XkZjnW62HwqMsbd7XBeRS8Q5JVFwJdClIDTaz6ygJg11bz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:37:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Akhil Goyal <gakhil@marvell.com>
Cc: Sucharitha Sarananaga <ssarananaga@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>,
 "kai.ji@intel.com" <kai.ji@intel.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: Re: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding support
Date: Mon, 28 Sep 2026 11:37:07 +0200
Message-ID: <LZGjqyc3QPSiooArUsg_Gw@monjalon.net>
In-Reply-To: <CO6PR18MB4484629FDC6B984AFC24D7F8D88D2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
 <CO6PR18MB4484629FDC6B984AFC24D7F8D88D2@CO6PR18MB4484.namprd18.prod.outlook.com>
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

28/09/2026 11:21, Akhil Goyal:
> @techboard@dpdk.org: This patchset has a ABI break
> which was highlighted in deprecation notice in last release.
> Since this is an ABI break Cycle, I think we can merge this set if no objections.

What do you mean by highlighted?
I don't see it in doc/guides/rel_notes/deprecation.rst


