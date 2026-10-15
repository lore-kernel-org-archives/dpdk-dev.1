Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC501CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D06BC402DF;
	Thu, 15 Oct 2026 19:22:09 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id CDEBB4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:22:07 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4E21C7A00CE
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:22:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 13:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792084927;
 x=1792171327; bh=tKpTsx73IyW++HVgopWq1I20PDt9rQ/qU2GPBlc9JHY=; b=
 EZ7igwfRZO79VYRLd8+p9Z+AaTW4TnuCG5M4BsZquP1z4Z89LdfOYfJLUGVGbnia
 Cdl9O2tzOIHa8LIlNmmVkHylTVIBhmJ0pXiWK0+pyD7VAxX7bXQdAgVCaOTZ4mwS
 9UcB4jU0QZy61RAn1ESEirPE1S98KYOj/JddUpsl3wEAtd5pNDS4fQSFtalqelSv
 V0hBvVHH+YBdcxREM9MfY98Qkzy/IOrnKR9tNZTpwDXJcQBqKxSmawBDGIgHWtsP
 Ka5DINffqTLQ8a5RxZgGOILTjN0ZhRx/bC8S1vFLmrpO7r38eLGJKcHYVf4BSHmV
 jUVuu1pccCw3Ick2/oRxgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792084927; x=
 1792171327; bh=tKpTsx73IyW++HVgopWq1I20PDt9rQ/qU2GPBlc9JHY=; b=c
 PQx+Pk2vd8AQEZcGNEGwWVWJEqvfVfcUJO2aubGpgZwAEUycrUSsTevtLzevvOwh
 TSxt4lK5aT5S2i6MqkgQ69xlwVYSmmjj9mqiGpqKhQXh6RCvqYO0he6iWYWjhmz1
 leGyvubFGsIdPcIuuM2gX/Amsu0FmkgSuWN72KE1SdAvRRQN4IodfxTZRT469un3
 AKfytNOU6AJbrQEfAK9f8uRGtcljg9SADKwTEQuJ+fEc/2Lnb1lnWzVByOypHJmq
 +HZV+CPHFPiErnQuaUyBuh1DlpxZVhDLUB+rqkWjTA20rsjWigCx26qU/vSIc0PW
 7x4iUWvdDNAknNuXHUUkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792084927; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:cdL3UAE30tZSyMxENOwnAnOHYlnB5NdRUfyXYdRbaY9WTcl
 Nqn/ntoSTjvYp4ML14cf+zwKZtudrSJs9BHNpYYbzlggJWHezbgbTYp4lK+eZY5T
 jrGmkEzVrQnhVzWfJAFofSb+eVLcfN1a0yCUt0S/Unh77yrGdt9IYXfwEt4eFVT4
 tKe0R+mgdi9jmunVmSDo1QD4V4be6Uq2/PgZE729/xjfH1uLoGn5269PJ4yyW/CK
 D0yY/2386VwpZzLqH+4O1SKQuIOCq2VWCVgYXmoPi6QGgw0Xq5UER/27hrMlPeFA
 lwm9Fql6jJbDHcfclxhiXa0YR8qlQUExid07o1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:32Pxjtgq6QwY+sAxr8R2GBNFJsVJvbTTwgMEQH9TLLs=:kdhVy28EhWup0efom66QskfrFtA76WEFe77w7jsbMjM=;
X-ME-Sender: <xms:vgvRalKQEf_WMf7N38KnSYmiLt0vUBmUT7EliZlfNjSCoYWRBlQ7qA>
 <xme:vgvRaslsUthBxnjvH9ODqbYA68ksy9epyEm00YsuvOTT0097RNGy4YB_iy_wf00DG
 1zTScZEvXh8PCk832z-wFCfEs-f6Zsnfcb2eE_1nRkUNF3Dc8itBA>
X-ME-Received: <xmr:vgvRahP7C0jzFXxhqMoDcn2KWcXGF5Qdw0EnUy6ny-pIvvNl-8WnvZnnZvQPI6zLfgqTeof9fvXU4G9376HNi7Y>
X-ME-Proxy-Cause: dmFkZTF/JY+4BqtrDGExTAahP0TW5uif752hyAwsbkN0zO/sQK51WJvogbyqKxi00uKq6K
 HTuVgceUjxfneUydLzm+7C7VrpXgXVGQzGVMSMCmhjvtnf/djG+mN0yS3nUSY0CIjxYJGt
 s4AUwfjJIwhO2e9x/iD+4x0bQr9CtkHkTp3Bt3h0LXWxpURS1DNvFLRE7M0a5HlP/W0mGM
 WscsMD3m0ROJKrixnXT6nW9BrNV4yKlyTCg3taXdDJfQfx2yoUW712KxQ4YICDd/DT1lmL
 DpnjMqBS6MmlvReFPWu+Rbj0L/JXEnkUpPJ3/bVVFLiF+eBx4JZRHxURQRF0rhPJ5gOnn9
 iMju9OK8CTe1nBdXZz0/6sB4ekGOP+aXVeHffi7bpnubIqjJ4+F+TvrSt7bUnx37g8GvmT
 8HjGFgBNslWX4uOorLsxaJfBfFTG0wBvmj8Id2Fpiz1roGEs8U3F9JSSX0rBvILIrilmYG
 uwUP7T8wJAhhl2bMKkZiQgUXSME2BA9/3dtQlnmRNIuFR/M67OawMkqxg7+Uwhb7SrdRR1
 N+vklupLe3Lt+nBK46yqj1OdByuBeDxJUgZ7gAtvA+CrZ70d1WIi0MFMz5sio5oW/8CHPX
 kE7omyvdQoWZHAQQ3TvivGi+//eydxU6m5F6UaL22+AvCSv+g51YPMSTqzng
X-ME-Proxy: <xmx:vgvRaq3fXXskP63_6vs5ZK6jJ4nXfRpZ_hv8bv6KeLOE_8o-3rp9uw>
 <xmx:vgvRaok9fLpq2I8cHxsTlbw-XcCYETxlOkFsF88pL5SOyvD2jSNgKQ>
 <xmx:vgvRapVzHBQLXevO0LXqFax0WzrqMWYBaiiuNr0k84Wnxahskt1bMg>
 <xmx:vgvRamvRZhg7mcWYBylUlGAYKJdBKtug05VUEldjfkRMxR-lsqLiAQ>
 <xmx:vwvRan1ftrxjp1yvcB7PI0ZniZuSUsCjolCGVRUGSsv_Sw_OmmmOVppi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:22:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v7 0/2] introduce pile stack and mempool driver
Date: Thu, 15 Oct 2026 19:22:03 +0200
Message-ID: <ItqMX3UyR721OV9AeSB9fA@monjalon.net>
In-Reply-To: <20260914155901.943571-1-mb@smartsharesystems.com>
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914155901.943571-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

14/09/2026 17:58, Morten Br=C3=B8rup:
> Added a new high-performance lock-free "pile", using the Stack API,
> and an accompanying mempool driver.
>=20
> Morten Br=C3=B8rup (2):
>   stack: introduce pile
>   mempool: introduce pile driver

Applied, thanks.



