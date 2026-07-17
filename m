Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C826AC4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9738402D4;
	Fri, 17 Jul 2026 14:51:46 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id D6E75402BA
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:51:44 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 57A8014000CF;
 Fri, 17 Jul 2026 08:51:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 08:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784292704;
 x=1784379104; bh=Qm2dXTihrY/TM8rsJErpiHpgKGY6ekMqBzZ1ljqTD/Y=; b=
 Js8t2YdOrs2vyUVz00gKMDwbFaFkKAQYN3BifZEjCoTf1cVDokLokFo9TXV3HBSc
 VKqUZXiacmrl6BUv07g4EWYK0QR3go/IkDd1Xj/xVJbyZ7JiVMjAY2PNYwmKhuCE
 O6/rel4stfgxb/eLDQyt8DXGoSsUCt3BF6M9XcOOApEUkd22sKmJLA10uRy2qIJQ
 JX4LUaY8gAsbbBqX/KT90NoNem7d3ItF9ayrkpBnwmNO0OaJrTurejzTgyDNUNa+
 y6RimvQocD4IbE+Mdq62bjCpjAjLdyqI6Jh2EuHWzUjx+6BEtXdzro18CVeZjgzX
 nqt6oj2+CoBRtNcKtg2aqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784292704; x=
 1784379104; bh=Qm2dXTihrY/TM8rsJErpiHpgKGY6ekMqBzZ1ljqTD/Y=; b=p
 TvLg1yjwxbADUQtmVaflxzfNsOPkFarOzAVrxr+0nvoafPHaDJNA9X4199D/Q7+G
 IehVv4bwEbFxNYRA/JvDJqba7KV7Xm3PZuQICiTkxcKzjLHYgd+Q3V05UqHmCoNf
 x3x4d/pCSR6k++qiB6ZhzCxnpsgvRcfnEntlbtasMU6Q90yHoja6AX2PIYE7O/7D
 5kXLCSExctX8Xehmb+zEIQnDQW5YhW/msnZByn50MzJ191YhRx5TTaIe1qkpFL46
 1nzpdzZOuSQx0K0NE8kA8Jk/n1j9NSLVMN6obebImGIWa36tOGm8N/qPspQfSn64
 LpFn9hCZUgPEYTy3R+A6g==
X-ME-Sender: <xms:YCVaah8hwfpv5_NR0TCnpHDWn3bcJul5Xi5PZWFSA4qeBBkkcMZK7g>
 <xme:YCVaaqDfKFB1xwKfNFXAaXcXSwtYOiDUwO0P8qo19YVnMTStdyF23DwSnGfdlO25l
 fLHyMiZNaoemPQZpK7tpFoSue0WV0xBZWhGhaQSZ35M4ZOlO7wIIQ>
X-ME-Received: <xmr:YCVaauKpZZ057IH1jHdDIHiXuUdjKQuaYnOlYpr-H8BSBrT2qfUlezCmiCC4xqkD49LdIH5JwsffzisSgg>
X-ME-Proxy-Cause: dmFkZTEU9l0QX6OaVNlDde5Zr0WzjcEHwnpd5Ouv00q6qG6i1zMwFNiasiVURJrp95Q418
 azywC09++NWlFYMw7xOgFBON00XfEx1fgcAdgkNeBXYZMkf6q7BI8IjgNvuvIayzd2ibAs
 mHUJxnAoAApOiAHRsvI7vkqu3fPAB4qLg1ZTA0hnxCYb3SSfvG5ySQfYMDZe5MBWgvHKyp
 cdMg8APNdXG8evepV8auUZ8Z2forWNWcP1Y2SQMI5eDHDtFG4j7dg2r/rUTuYIVE2xCZ4P
 OWL09Q4VJ+ifB7rcgVa8HPCzV1wxo+6ptxqRZTLXw9Sv/HUk9tabDz52UNda92uRwMTNjW
 r5NjMV8JOrHYwzryoBXAfvk47XJDVUWC96MpRGVEj6DFHl1MYue1zYK12PASTsXN4L1L7M
 vspzv+hldMIx+qfA8MNEDHvsbPNEI6t91DJ6NLg6aE53Y+iRaMcm8kfmlgrNf4fC1M9Y7l
 /Wy8QooIuu0v1i5o+qrMkig3TzpjNEtezW2G8fr5JA8d6wJ31IKQGx61j4+nDVWKrMumQL
 8JaysB9WlV85aConXOgOnzrlOWZIWAbGI97XCV8lcH8txnc+jd5PAS/SL0RCKiqeI406c/
 hWqngS7mBIgK285+tcBAjv4kksyUxDG16R242Nbodd/iinYGGwfqJnZbbFDA
X-ME-Proxy: <xmx:YCVaatlYFKVm9M4E9K2iDEjPHIOKBCOQArw3ovFefIiU_mCXODFLFA>
 <xmx:YCVaasHSBtxvIsNzg9LDPAFik3LmgU_X3BhvYZ7OQSPP3N9KoDectQ>
 <xmx:YCVaatGl92ApNlTMScFSYi7Xi4csLG5mOLizNVJTLarW84aPUV2-Ug>
 <xmx:YCVaapPbeE3cAKIpRX9I-bqFLHzDsleIRtGuCq5g-BkMvKNoIxsDNg>
 <xmx:YCVaar0OsCxQqbOzOb2ytHCzE_2OEQ1nAQTezRHqAFoIXs_Dd4nQBD2->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 08:51:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 8/8] doc: add missing headers to doxy-api-index.md
Date: Fri, 17 Jul 2026 14:51:42 +0200
Message-ID: <FoC0dWG_S2adDZql-PwRQA@monjalon.net>
In-Reply-To: <5803e998c8404b5387ba9ef0bcb530b9@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <--xEtZJ0Sj2LGPVvl3IDnQ@monjalon.net>
 <5803e998c8404b5387ba9ef0bcb530b9@huawei.com>
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

17/07/2026 10:30, Marat Khalili:
> > I'm not sure we should add all in this index,
> > especially the *_trace.h which are not really interesting.
> 
> These are all public headers, all of them have a man page and an HTML documentation page generated. Yet when a user clicks `API Reference` on dpdk.org they arrive here: https://doc.dpdk.org/api/ . Without listing all public headers this page is meaningless and misleading; web crawlers could also be confused by lack of direct access to inner pages.
> 
> I don't know specifics of *_trace.h pages, maybe they are special and should not be exposed. In this case we can add an exception, although I'd rather put them in a separate section explaining why they are special and not worth bothering with. After all users might be similarly puzzled.

Trace functions are not directly called by users.
Yes they are exposed, but no they are not part of the Application Programming Interface :-)


