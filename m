Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD414CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E99B4402AB;
	Tue,  2 Jun 2026 18:19:32 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id BCBDE402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:19:30 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 387471400112;
 Tue,  2 Jun 2026 12:19:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 12:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780417170;
 x=1780503570; bh=fQGa19uvW197ZGWJVN9/cW7gF3ieqW5P8rsoUSWh9dI=; b=
 fiuIB36xjb55Vxcz4AhUMEIgMl/xsZD6g3W+xlLCTFHUiVBwvWiovY/8UDESEyO6
 e54nskK2yuOPpor6RBPFgmLNWdw26tIOPaJZb8lKrpDEai3AqotAcZhRhTCXc/xY
 dnjlOD/ZO8UxjbfT0PPCBE5FL3kEUf3Zt5uKEdKyA3UWrq7QCD/a35LC+WxLqebb
 m9Abke9rzO/L9Y5hWOHwwp6sbT3z0cFnvEURlnrL85DjcEFMDos0KV5QIkWJKP5R
 i6kG4Seg9zCedTtyFz44Bu7q0YGUF7W/hljxBw/aLPjTsogrl/LozJAmHRNZ3hrj
 +IxrPFi9yEiMb3BCyEWHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780417170; x=
 1780503570; bh=fQGa19uvW197ZGWJVN9/cW7gF3ieqW5P8rsoUSWh9dI=; b=E
 9cZk7EWKIafiVPtMkSJ93jBP0IQ6xhW5KHv79nWdcN6jdSLznIDhvtevCIwwRHgl
 0eRnmXwuf8QrsqC2PHmNHW6335zZux7UkxtqdWnCIQjD14oFxCErAaswWAJx2DwK
 9mzWkYv6tavkYwzFiqVoQRrFPwXAh3X2+ts/Iw/snQGSKZuAyTwPt0RndURrxrAe
 Zlo/C5TA6WEB4nZ1oyL0Qlt+t7qxrufDkQjypf3B8wDELeWMPJwyDz06uqYfmxcO
 43WSV/qeht+DzlujbU/tUn+7TOa59/9+xnhiceWGJpZ18ie7bWS9sK/EIvZRRLqf
 5KVXf76fpb+sW6r0wueZQ==
X-ME-Sender: <xms:kQIfariwOHtqm86rbkdfK2xOiYrXwv8BNypDwElc_ULy5XSPQmRitQ>
 <xme:kQIfauAtHLjx7IRv7XmNfrw8H1GCJXOpSa24IgP3A2qV7Exg2kc8LrPKKkyjN59Xx
 kfuMVgxlV46-QRN6oB8IZUFyk97wOAEQMlLXLT0V_nC7bcTcWitnA>
X-ME-Received: <xmr:kQIfaou-_3MkjMPFP2WcL2VLIn2SJvoZA-s95hg1zkNlrFi2IiuqMFRHMWNxBHCYYots38vvdDGQeSYRmFaHAicang>
X-ME-Proxy-Cause: dmFkZTFUjIeQf+swTnfvQmy6NSLNeHM6vabRNf2QBnyPyjS13+bpizx2xOPlYnIHebIkbW
 tYkfD7KZ3f2tSpKAFRsM5eJdKAq2vHW0F9KPkSOz6qC8wLCJCtd2YAx8sYxjadde3bUIAA
 LpFHIBi+vglK8u7m3Yo+wgpZzz1eBsLccrhBNdNZiOVIO/z6GGliVbBdvHyYYvPZFJjkUH
 oNePJlPLEqn0vxPgSEKsNj7M5V2dEzKMmMjvXz5UP2ob90jCvKFiqkAGNDojOONX20wZe+
 OBNh2f+3o1u3IB0sWfM+sdOBjnInPEiIPo58OgLopLsbqDG7L3K/be3iZ/o/YdAh/wThGv
 obHbaqXEmKDXY81wgOpBJTxz+x3nwO32Oel42EMEv1xaFQAoy1A4J3Ofk5ydVpSXiqFjEs
 RSr58EjuTlwCTMm1a1dNkYSSYVgj1lvUjyrvQ6qfDOMSs8g9ftasXlaEJGvSBdPlXTKVB6
 7r2YrHKGVoRDdlDmpHeWtzjHhNcdA6tV/OxbF42IoI/ABdAaKB8BfkdHCl8/QptzjGeG/T
 juUyzc5J1H9dno2YHp/rb9XrALQ9PiOsBrB8jebHG61h1exHIXtr6aXuomRg+As9N9oG5z
 EmysCUJo1sn7Sx7m4JviexIXJTCAKBS36SmulxQJO6NPJ8jOkjj6Z8bWveXQ
X-ME-Proxy: <xmx:kQIfajZME4OdF2ieMfNoql-PMlJOYKB7fTV3jlouJPAmS4ApbSamRA>
 <xmx:kQIfarV0PiVWJ1lsWOtJBfqiy7-rZrozqg9NIEKr5_pdMai7yoQyhw>
 <xmx:kQIfan465iKfO9fjdsJ1VmexcPH6XSFdZvzny3ODsYsCD44WpyC5gQ>
 <xmx:kQIfamjOUMAbrJ41nHRUF6bRC_NaPZ3C2TlUBUVekG1KrmR9qgeNcA>
 <xmx:kgIfan3PKegyQOpiaGOoKJfqMsvrXGveNK4qSvBZLqbpvR29HUTEfeh1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 12:19:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/2] RISC-V vector extension support
Date: Tue, 02 Jun 2026 18:19:27 +0200
Message-ID: <NOczNvfMTIWh_wwnqbpjFw@monjalon.net>
In-Reply-To: <20260505062142.575105-1-sunyuechi@iscas.ac.cn>
References: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
 <20260505062142.575105-1-sunyuechi@iscas.ac.cn>
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

> Sun Yuechi (2):
>   eal/riscv: set default SIMD bitwidth to 128
>   node: lookup with RISC-V vector extension

Applied, thanks.



