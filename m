Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC42EC44512
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 09:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A584B40297;
	Sun, 19 Jul 2026 11:22:54 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 82C3940276
 for <dev@dpdk.org>; Sun, 19 Jul 2026 11:22:53 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BE7E07A0036;
 Sun, 19 Jul 2026 05:22:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 05:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784452972;
 x=1784539372; bh=VWCO6Td5qa78zYSkIuHPCNdrOcJurAwV7+YycXcwNKA=; b=
 XHbZvj2pSmpqQguEX6mneh7X2qs4F6OapsijXGlPeh/mIQ0uYVtdKdGw/gy6A9FW
 86j+kjUDAahq5pQYUAnppCvGOnM767Gupv3wJ3rPh9ZSxi4vysLvx/AjJ87gUJI/
 WJusTXH7rNbCGWP/TRzl3ATNHLAkgDg5WPSsuiPoYL6CM0oQlp3twZpVZV2dswOO
 YMHoC8WJ970nmRpA+1w1QHupL5RRYjijok4UsvOblrp2nPDwljMaqXy87n4zjppB
 5flhD7iB4kcAm3uiVovHy82ebONkC6XWB0fMvEM6rMkKz5zUTrTokH3DJdnISe+W
 52dhyi+qCwhStHeacfS6pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784452972; x=
 1784539372; bh=VWCO6Td5qa78zYSkIuHPCNdrOcJurAwV7+YycXcwNKA=; b=E
 hcGnn+QR/DhEwwvERvTCPeMzxcsfg50KV/44GYLrrkTcWhz8XVPnhNpzggwWWLMX
 G2QT+qXE1cu1e55rRVbURDVjfFJygRYd5Nvbm7m4qyGBAwEDm5sw1do8Z7xM7Lus
 JhdKandA4NVTh+B0pjy+AhXozpOa2020RpzKlbFpAaFTJXZmJoWbuh9iLeuQr7CM
 46TLONzjP3HcKUb+5DhxwQ2vcSGVjLxGPL99QRxfG2zYUyO1XcuSwwQ/6RCboKnF
 lMDcIBV+LIOAxEFpyHCPa05+E+ckZ7rNDCl4K8HISF43CfZQGiZ8BhtnhrknDCkU
 CaaRNDBmjOn+NeVPdpp6A==
X-ME-Sender: <xms:bJdcaqcE0z8K-cMFf2QJvrSUmuADzOtVdE7sMi-DQ0UXF6TwLwQkfA>
 <xme:bJdcatJe9-L_nJH-ZIWbN8QeuZEANZzXhEQqO6nXtghwXrXlWLxC6Ym9xIQpESiTV
 socIyY1yKBj2dwAepycWV9CYe3Sql1nSuzeJNvG2QeydZkvNStsDyc>
X-ME-Received: <xmr:bJdcanFTVb6D0mFEPJKZOM8BKIhozpvFzWNqnEYteLRVwm524xfUodT-GVwBKj8-GdWVQ6gPHqxTMgHM9g>
X-ME-Proxy-Cause: dmFkZTEzEOPPVN6W4jZuvwCDz7Cq517fanCrRmsa/zRMS72mKEnpVBuu1nFUEUTP52Ccon
 PboykJcGTe/rFFoB8V2J04zqFWrYvgrGf+RRx0YUL0hv0SW5yBT8vntcTUwPAZk99lhSLr
 xk1CxiVl7OWu1WvO76PnnmqEPrjsTN8zNV7qv50JtDJRyTjvZEwp84+zjH4a6lxRZXcXNj
 QunJx4Ijx9wT2Jwsz9WafLBm69Fb2RlMMfw1vNBE5BPhYRvQ/w9zxKD9mL2lYwLEMfPQLk
 awQUH6yvEQ0/Hsl4nWmOzpaBEzS7tC72ic0BgIHIFcs2ZGggQU7Xq0n0YVqKIWJlBifHq9
 jcwcxUnr9WM6/BjPbOgkaQKXaAwqkjBw0175PRZFBIqSEHfPaPANFHH71I6kjmFYEKL+y1
 xG/2Dc3Gq/XRxBakMUp57uKELPPW3alFaaSehNvlOlmXsYK87oUz4fIuYVsRAhvLqq1Ngk
 VRLLm+y4Xv1VXmn5ozuKTQoOGLchvorVdaFtR8CBRkw2Xfu+CBmNfIQnKBxJi1Eaw/6fgB
 VApIVzNd3kueCSbgjNFazO4zGgNlVTyWooZFxhwz7kMKrHG9c6MPo7sDZ4/L7Ys+wD3DV6
 AUp5UPEmuyHmxEMKJH+SeB751pf0c8dvgDTtupJrGITgZ/nBzyutbMDX1R5A
X-ME-Proxy: <xmx:bJdcaoBO6ZRMAcTtzZyGiASwR1EZegFuf7a2uF1bwHZkW42xGRw0hw>
 <xmx:bJdcai_HoKp-IymQaB4ERtYUh1DeMKYYF1hg5igQn96mtuNILfo6rw>
 <xmx:bJdcasB4ql44hlhguFPtUw7VcqG8E1L7A7xavVQ53Oj77RkhtMqlCg>
 <xmx:bJdcavS4h661Zij-lkSLYQU2OMPTKMcxNnTDZfHUWYtHcLtjPVVYaQ>
 <xmx:bJdcak_OQbF634qdhTc2Q70aDL5omLgmCcpRobgyFosO25-oux-ubhW6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 05:22:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shaibran@amazon.com, evgenys@amazon.com,
 amitbern@amazon.com, atrwajee@amazon.com
Subject: Re: [PATCH] MAINTAINERS: update for ena
Date: Sun, 19 Jul 2026 11:22:48 +0200
Message-ID: <077wO4ZZQJSfJKkE2sCeVg@monjalon.net>
In-Reply-To: <20260620164001.129129-1-stephen@networkplumber.org>
References: <20260620164001.129129-1-stephen@networkplumber.org>
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

20/06/2026 18:40, Stephen Hemminger:
> Email to Ron Beider <rbeider@amazon.com> bounced.
> I assume he is no longer available and other listed maintainers
> for ena driver will be enough.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



