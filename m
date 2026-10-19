Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F6CCF2D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8285740663;
	Mon, 19 Oct 2026 13:32:20 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id DFF2E40664
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:32:18 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 6D6F6EC00FA
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:32:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 19 Oct 2026 07:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792409538;
 x=1792495938; bh=mvZMZvXyBDa7HwxgIHNZjgCVVEY1ndi0xMjtup5pBfo=; b=
 VEVaLqfqr61R4/aDiu6eNFQpSzE3iBJjQ+h8h/jbvEe8lmDUk55PBYyeIEONI5OZ
 wiUGhEcD3jQozSMtZgdMVaBEJ8kyN4c0h8s8KE3EUTvIii0iWRQS52Erglfh5+k6
 LdQKEsoHRU24Wc66lfmjFlBoN4NBPUwSKLpykTPkpYvuJFhKlcCzbnWLw2M1bohW
 HHQ2N6Rv4t4OxrMkEiki1hE8aET7hVACpJxRo7HXz2eXKtEqEBQAr/uqb0COqBwV
 Ez3oj0EXqVOG32TIxXU4is5yLTRUj6/5vnm6O+w7oRGOW0I06dtKF8DE92HVMoH3
 cMuVv5/BN+43ormZ3uArCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792409538; x=
 1792495938; bh=mvZMZvXyBDa7HwxgIHNZjgCVVEY1ndi0xMjtup5pBfo=; b=e
 28DgKwSa7hpJHE50VIbt3yksvKT0COZzSrBUmeTdbXinV9BbyrMSJnCmxr0wH9BG
 A1rUmFezuw54KHwL1Ng/aG6a/Yj5byJ7tfc0vpfUpmcghiLKRVv5DKpvGHCFNGNL
 x82S2KZfq8PTMrwt4vYLtpPtp5GMihvIsuo9faTgfpduYLwNOcHLkaN3amDbTTrG
 1ZhD25nPelFEqAgrCN+RbOleKaTH6nO2yHxX7hmT9eAXW+vTsik0eqVITzcsmmv5
 cSazgJ9FSIgTgC/q18dUO++om+I5oPc2LxMmoJMMdeEWLNcUdyEg9UMbweVh8TQX
 8qNM3FIy7iDsYBnnxknWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792409538; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:hiA1PiT4mYXELQkDGh9KLw8r5rGMJCt9HxNFnP7oXQWoos/
 yzX064LpqmqKj2ZYzO8LMqvfZZmwSnLeCs09KcAj/Eryh7OHPltdxT7+ZdPFnBed
 o/JE/X0cLV8/xuBRY3+xO6krsUXSFpQ8WqG8nI3sh7AJ/sMxZDi4Am7s2ynt8YLq
 Pe5r/0aE0P2TP+jm5Sf0wX9iajSPRWl1tAzkmNYoofN7LCMeQvBkBkOl+97G3Bsq
 5bmi/0UdFS36LF90goIIja2ehPzfms718bUUU8pcqPGInJW6KG961NxKQbq+kssH
 59Dppum6H/e7/10h7mMr6DZqcLtSBOROzsRIo5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:gdNr1wkLYnjHrhIMUBdSXSo2kpd0+bFzMIFN26whsbQ=:gRHzvLKFWVx/ZZWKZFkmeyKhHei+YMdnmHJhQW1m4is=;
X-ME-Sender: <xms:wf_VakL45H0gEBVg9XT6_liwOycQj-o0H-1tNeftbnEXH_5mfSu7_Q>
 <xme:wf_VajP7yfgk_qQPmkH6zduSEhIE9nF-XN2nikJ6nlAKPN8z0Vnl94187QCEwGDZP
 U0xL8QthXlxkEGSbkhT9h4FEAtngvUTJJ52pcgjNSW04DnOUWImri8>
X-ME-Received: <xmr:wf_Vaq6EQMaubQ3FklvbV3MhA9aiU0ly-VsuUMjNgeDvcLcKDal-8BQRnM4X4KpUuLEcLQkWdWjg1zbJavyBjWs>
X-ME-Proxy-Cause: dmFkZTGoj6Gk9iK7xD4dJy//6sabvI1wyG4rpJIN3wt4nRP71G/N4BeWlrbFImo2rftUGW
 zs0ba++W0CDoywsZDvUaHmBydgw2sBxTjRnwyFSKl0AnbCVmmuOa9qSdUjAjo6MOgtYnkP
 +MmUniZ9reoEUJ6uxYQFubr43nkVG7Lku4kJ/cZ8GdLVXcJduZqsIOgQqT+HoaGdpnu7TW
 7BhqO5PTO8qvAwtT8MaHKbczp3AJQmKmPZBIZjsZv9yBYvVKaX9fWhK8F/g+/pf6EuYXNS
 /wUfmEtJ5eao3nWVAX0YPxXmGvQ+IeX3d3EAlkVgCyAtr4HP6xkVJxPmXXWmfZ6gbAQCPD
 LLZHrxyJVIQ5ydpUJQc0sqKVHuxKoTFo7hjGkdoutfHUFp8RTej8/meqvWgfmrRA5aYyE8
 fn+ATTABXTOHSgMRv5OdvnmQ0ziTGAI87P/VSuIZtx+Evgfopoux3VuHsbkLAL2XpXTB5H
 51r9V0SSk8kvuLeVnedJVx33owV+m5d3vsn2BXJ9bnZDlPduGHMJM5dRnMZgc5FOJRe8JS
 uDX7rraBLB0sZG50XCoomRnGhOpofB3LfH1vG86gA6NAS4ur6jGvRlrIbMZJS0vXKAvLyj
 3sYIbwNh2dw4JAhe4u4RGTk2QK9oUQDYeU4/obszc+R8fvieQYhJYJv6R9YA
X-ME-Proxy: <xmx:wf_Vat7v_QlyG2A71UC-oGbfL8YjkmXKAxBLP4anHjymUR1n8ulU6w>
 <xmx:wf_VagEkhzOudFhYH0xpduqXy7U-4Ew6JBETgq9uWVWYLr96eOqVQA>
 <xmx:wf_ValU4h0r9QKJA4TUz0r-M1OGeWNyS5HZVirjtj2El7jFyifQE7A>
 <xmx:wf_VasWqTl-rwVFMvGv6hf8Xm5jMxrXxjfeWSJtByb5pZsyzgdHa7w>
 <xmx:wv_VakVP5X4IMs6JGt7VHZUH79pUuMU82-1cjXfalkYW9q9aheKw825p>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 07:32:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dpdklab@iol.unh.edu, kishore.padmanabha@broadcom.com,
 ajit.khaparde@broadcom.com, Alexander Goodkind <alex@goodkind.io>
Cc: dev@dpdk.org, test-report@dpdk.org, stable@dpdk.org, tarick@bedeir.com
Subject: Re: |WARNING| [v2] net/bnxt: fix aliasing in firmware command writes
Date: Mon, 19 Oct 2026 13:32:15 +0200
Message-ID: <1KJFoaOTQOSsFVpUvuxtUw@monjalon.net>
In-Reply-To: <20261018030249.80449-1-alex@goodkind.io>
References: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
 <20261018024910.5D1706051830@postal.iol.unh.edu>
 <20261018030249.80449-1-alex@goodkind.io>
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

18/10/2026 05:02, Alexander Goodkind:
> > Missing release notes update
> 
> Comparable fixes, including the enic aliasing fix [1] and the checksum
> memcpy fix [2], did not include release-note entries. I followed that
> precedent here, but I can add a release-note entry if the maintainers
> would prefer one.

We don't mention fixes in release notes.



