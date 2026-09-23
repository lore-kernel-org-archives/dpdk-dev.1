Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C64C9830E
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 19:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F116F4027C;
	Wed, 23 Sep 2026 21:19:50 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id DA43640276
 for <dev@dpdk.org>; Wed, 23 Sep 2026 21:19:49 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 3C9A0EC00DA;
 Wed, 23 Sep 2026 15:19:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 15:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790191189;
 x=1790277589; bh=M6D/9nziPJeXiND6Jup2d7dEVMyaFErHKBwmQDBDmSw=; b=
 rvXoTs3ilgGKu8E4OdbNBMqM4y3RmR1SgPSQGnGDNegEv+NwJjvzUnSXxp8JqdkP
 +Ub37pxQ0DUHuLZ21V/vVDuK2fSrZ/qW6q2ucZqLefE436zGbn0fXMKIiJedl1Vz
 actyyxLVkV5rdt9A6YSwqGn2c83VJKscjuOk9+8+OnIvuBy4UI4Tq136MzwUfNwa
 S1mMCq80HN+Rm74HiulLo+Ge9rtFrxcjXN8Er786EyQPHzD9ypaNfWd9RH06KO/p
 49/OiQDNRjovffW6i6ysiJVYfhoSveiM50P9miDR14202QV9MF2sr90C0wrz+Jk7
 FPiDwDeZQSpFv+BYO40lvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790191189; x=
 1790277589; bh=M6D/9nziPJeXiND6Jup2d7dEVMyaFErHKBwmQDBDmSw=; b=c
 pm0DM9h9mgjAvO5YX7ND49vGyngO5aC2Jhs9OhaT2XGFFYhmp6g9HrkF/eIMOMZD
 AqbyTvwMOT/uhlMp3i37LhnNmv1uPSRmoQcvNv/BykmMqGEN/aUI5aFmG9Qfwt06
 zDcLU5dctkf5T3vt7S6Cvpc8Ki14bvYrSSidNFC93sKRhJtdThCTEWmEZYTlJFgk
 JQlm0gYYGx++A7CEEUmz3kZrixxo+uXG9PNJLT5xRp9yditizcN/NFOsytx8jTLj
 2u6J8rAjc4pOuMW3ug5lBhe8QIcTMSUz7wNfOlSIwYJgCJU/eEBIGp5GwA8+S1hx
 G4Q540KGcXhYW86WrbkZg==
X-ME-Sender: <xms:VCa0alQJ81wKqoAmuIUOKkajJZdUL9_1Uk-daE3qEvRKoDaEbfPKUw>
 <xme:VCa0au7x3WlLUVP7GHO92yXeAMHY6KWGunC-Mo0TBf9CnnFgjyw0YTkyhi3kAOgq2
 gA7LmvUYyWYyun0D6_Cpwsp2FESHYoRVSBwcTK2bOM1nxADHhu7VyM>
X-ME-Received: <xmr:VCa0aizgFlR78R_Oglt1NnDchRm_tAYt88aGPZT9cqSGH9TkqCgqIRkyMVs---tobYpN1aDni5l9EQ0-u7mMPBQ>
X-ME-Proxy-Cause: dmFkZTGVDNZbFn36QcC+/9qR252/A3o84IIGajxyEwoMPQ9Sh5+Wsvram0izBXBCb45kKv
 ZAPYmasAhaTFKCGiGjr+oQr6xALkHlrWyhJmcfJ6zzmdb3TsEtS1fwTrbATM19MVmatHuC
 mUxSWXRD+KHPCBXlpAgkzXrn/huyMT46Mc/3t0rePfhx3x30FrD7DNBEkTVeNd/eIuttOT
 4FIeH5UHlRnleM5JOyraMKsr3Ipy5PhYCopayxiJjHIGVVGAHM1RSm9BiLWSQeztfalWGw
 aFf6vcwa584W8L4IRMYhRD55oC05AK5HFniDDBOAa9Qprw86PlF5xGHG+nDFxf5w8KetRA
 0D4KKVhL88DoGa5+UsON5YU0I2uPOjOGjgnjr2eGijtW6CocE2Gdi4Am+k8/kk4ZWuW+Py
 ml7f6gnoTlIZSqVLsx/IXpzGzS9AHX+WaZR5N1fzT14asoJQ/RTir+HHkF9pA3pRQlfhrt
 N7PsFbSxc/7CA7VNTGARl4jJmTTVe2X5VlfbsJ6qiGEflIf44COTYsP0UIabIpScJdmqk3
 qPKm0ck/ppnkRY1xVv4XuLMXfvUBZ5MSSGzFn/BXq8csMEbnowaNvg/nQkQor8Owk4HTAn
 OE0ZG0zAmZFHW2vI8S9NRNqqzfHKbfDJ48Gv6hVV0554T0pV/O/PiSrPvp/w
X-ME-Proxy: <xmx:VCa0alS7444MDJFtQEpMaYT80Z1GT7fBq_yyxS13S3AP-UC5JcWNog>
 <xmx:VCa0apVInmhris0YpE8Dmw_xIMuG7K2pPCoC1idJ8ZHys7M-c319rg>
 <xmx:VCa0anbTFrn7mggap9uWGJ9vMYC-E-BiuJblnFnON_BexQEoYf4A1g>
 <xmx:VCa0av1CvUJG4qwFy4aL0YIPPWmlvWUrn2ghV0IybAk8Q8cC-D6yfw>
 <xmx:VSa0atb5aOt72TwhFwvBXKRpkasKXvEdBXRiQRpg0_Z2TiKLEVe5_fbo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:19:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Date: Wed, 23 Sep 2026 21:19:45 +0200
Message-ID: <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
In-Reply-To: <20260923184207.626576-1-stephen@networkplumber.org>
References: <20260923184207.626576-1-stephen@networkplumber.org>
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

23/09/2026 20:42, Stephen Hemminger:
> The existing check-doc-vs-code.sh only compares rte_flow items and
> actions, and only for drivers whose directory matches the ini name,
> so none of the drivers under net/intel are checked.
> 
> Replace it and parse-flow-support.sh with a Python script covering
> the whole NIC feature matrix:
[...]
>  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
>  devtools/check-doc-vs-code.sh          |   84 --
>  devtools/parse-flow-support.sh         |   92 --
>  doc/guides/contributing/new_driver.rst |    4 +-
>  doc/guides/contributing/patches.rst    |   27 +
>  doc/guides/nics/features.rst           |    5 +
>  8 files changed, 1169 insertions(+), 180 deletions(-)
>  create mode 100755 devtools/check-doc-vs-code.py
>  delete mode 100755 devtools/check-doc-vs-code.sh
>  delete mode 100755 devtools/parse-flow-support.sh

Thanks for working on it.

My concern is how easy it is to maintain for all contributors
having to insert their rules and exceptions?

It is replacing less 200 lines with more than 1000 lines
so it looks a lot more complex.
It is probably fully generated by AI?
Can we make it simpler?


