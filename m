Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA4C44515
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 21:39:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0508F40297;
	Fri, 17 Jul 2026 23:39:28 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 28F084013F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 23:39:26 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 517DD7A0015;
 Fri, 17 Jul 2026 17:39:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 17:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784324364;
 x=1784410764; bh=HnwVVz9fVkrTEudogU2hKpLwvshlxc6C9RONyJ0JzKQ=; b=
 PZTiF5I6A3SbXVYk14S0HQZN8RqtftKvJUmPH4zaFruzdLxSKEZc0xZjWJJFQH8p
 f2Am0rbEwAOKBOpLweHFTXqkypzUw6BUX1PraFUlsEdhRqJ4zcFvoUxK/gMq2rIG
 fQR48CJApX0SB/jCv7LJVt9ILJ5l3NlrSe/zE7ffEpibOtu5ncUvUfuYCELNrJVQ
 5Rl43TBg0y4tqHxElRQjjNmFQaxjQ8jIHlsYVAQecH+LZL+ZfhaiDj8tlsAH1Alz
 xVDoNJnFOKiLZlljJxawPCu2sxSrcNPpn8oUE+/6aOTPrStOmeRojjns0mIRjtXV
 v2Tly4i9RuGdwwJjJ9CX4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784324364; x=
 1784410764; bh=HnwVVz9fVkrTEudogU2hKpLwvshlxc6C9RONyJ0JzKQ=; b=O
 iUJJoMouLXy20Q8dZkBc5UuEsn3NGpRcVQpQtnBB/LOhYidq/r04Wo+xq1JDNqaP
 xk0xXPPoLGkD/wsUDDTzh4ZWcwqcD6C7b2nyYQ8b4MKiBeu36SUxeUryJqZUtEEz
 pQZgmCWggNRhvsYK5dlNMrI9gDRmaHbH1uOxKNMJE43qyJR98hYwntB1AAizT6hM
 wxiHiUDgD8qF/TDE4UIHl1chBZYnZIpC+2/jcpWKbH4C4GzL4MjjflVZTqHawHik
 xzld21TeCKjl92l3n2L/N05G+J+Rl+772Qnnqoq/JJYc32ZyNT8mBJ6B2ZGjBbkh
 7avdRNRbB9WfFADHI70lw==
X-ME-Sender: <xms:C6FaanIhssGZt6K-wTYtX3LX2CAA0j-9MzOoSb3hiiNCTSH26Um_PQ>
 <xme:C6FaaneWp_X2JXq3ZlPN5R6LnlBKYJv0amKOEYJ6S6_z6AFhW3mr3ihi9t3wNRvMI
 xlLlJuM8PH3aZ1RURFzggTPI3uf07hV7dP3saziLlsyqYonw3m3wwQ>
X-ME-Received: <xmr:C6FaaicEPSANlXbxKhBQ1dyORKMQzeQrDiZEc_uXnI8f1w1sb8vYEzkWXKUnW86yyjE3T4kYmI61qQ7J9g>
X-ME-Proxy-Cause: dmFkZTFqAqokgjnQ1R0qxEmchrrFnS2XELqTyjPsI1xazsbgPz2pu7bLFhuAwGNq8tOSnd
 sQBhvmrxDa+IYp3RIFEtXvt1n0cC+QUiJ4FrWXevA/hmqaj8Ort2hSn1lO1NMVjh3R42Df
 AGRBz1fofjyBIkDVrE55D2f07n8MN015LIxp6V842c8G3uQiVncLOb1trkH92OqlrUWNPk
 Oni5xoT53UIoOxn/tFsllh6GMNsYiMEMjBIPdv3pIfmaAcXrzYsikEaoSU76EHtHja2ACL
 atAd3i/pIuZ88tSngUN3y7Bwr2AT0j0U0pwhrWN1G8owQjTN0MdM4aByOfK4BZW2FGRjPz
 egm+/hJYXGbmFdSADz217z5SqYdu3JoRDcIWy2W8SQ3gwxZJRR5L+XiOkXmTDtWJzHFw1+
 yGvhiq9NrtIB1e5H0Bci5vT0ueqCJylSMSna+FYoFCx1+dGwtRW1UEgzCv0qZPt3E9pEBB
 XurZVLOtjfNpkwIBTnUCvTKoEsh3vnbAKsP3LoBanB/Dx8N0dOCM93EXZM9fJVces+clos
 KCxYZ8hXZecXpQziTSH2WpGBe97efT13/yR2e5oPBg1AbP4JSvGszZKHiL20/+85LurcEt
 vB9KyJpyG0yRXw41QeyX96EfbxBZ1fAHa017GHKfkIwXawMOlogDFr7uelDg
X-ME-Proxy: <xmx:C6FaaiNuPQraxHPy-bHp5WPB__2IJJrjzYtEzlPRwAb6BMroiYlpFg>
 <xmx:C6FaahJNqKMbqYfrXBwqxQa9ain2L-fUOUO_ybYIde8DA0y2KlKWGg>
 <xmx:C6FaarFFWbQCJ4ebmy2fO6lGCv1qO3d-Vylp9mEs-Kg3zHwwDmNvMw>
 <xmx:C6FaahQwkqX-4JuoDA3EYg21WINpeXkM4SXUBCBddNNpEplOBwJUbg>
 <xmx:DKFaakLKIKDYnwaBB9gpkpN8iLA-yeG2xNhdYi7uFVVWvpKE2yEAN5mi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 17:39:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/12] doc: improve contributing documentation clarity
 and style
Date: Fri, 17 Jul 2026 23:39:20 +0200
Message-ID: <CURiMqY8R66-Lj045EG2RQ@monjalon.net>
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

16/01/2026 21:14, Stephen Hemminger:
> Nandini Persad (1):
>   doc: correct grammar and typos in design guide
> 
> Stephen Hemminger (11):
>   doc: improve ABI policy documentation style
>   doc: improve coding style guide readability
>   doc: improve documentation guidelines style
>   doc: improve Linux uAPI header documentation
>   doc: improve new driver guide readability
>   doc: improve new library guide style
>   doc: improve patch submission guide readability
>   doc: improve stable releases documentation
>   doc: improve vulnerability process documentation
>   doc: improve unit test guide readability
>   doc: fix grammar and style in ABI versioning guide

Applied, thanks.



