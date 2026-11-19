Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E6606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=hFj0lzat;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tiCLKBMD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0139A40151;
	Thu, 19 Nov 2026 16:27:04 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 4AD17400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 16:27:03 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 26B527A0319
 for <dev@dpdk.org>; Thu, 19 Nov 2026 10:27:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 19 Nov 2026 10:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795102021;
 x=1795188421; bh=OtM4OG7wg42CtC7NWTQ1Rxg4O3GxRgm/V26DKk7avp4=; b=
 hFj0lzatNYqIKJwrosRi8ChS+eOMIRIdHeNPzbppUKy9FjvaS8q7RVgcMOb8/m9B
 0xbaMifA61tC7B1yPjF4s4eE4+i/rjFqV8NBfSF5ZCmPclheuRNo5tgR+fWv3EVn
 WNx2AkVqME4XvCgMj7YBWei39OprIm4h2u0Lz95d8E0+za8KsPjZEwjg8EgioC2D
 xEQQLsyiWzQ4qzlFLWEi493dun0J9uZrgHOfJk6x1yNxRvt5stiHvwNM6MZYPD1l
 KcSyzniVo89SCLOmRspi/hxfnA/cE+3qmDAyksiqw40/tGqQeWELaHJxHgF/xHim
 zIKE5iZ2OwppsoMaSn7kOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795102021; x=
 1795188421; bh=OtM4OG7wg42CtC7NWTQ1Rxg4O3GxRgm/V26DKk7avp4=; b=t
 iCLKBMDvBUSFJV1/04LSMO1gW4fI3ZOGFiCReUIfJ7NNqpjXXWHoUydVzWxOMTQ0
 nzKjyStexM51QwL8IPqUylNuc1WLrMtcIsox3iLLd1lDIn0O0wn+cRqVjVA5JxvD
 LOvGr7Y2qKz7w3J61qDZ12x/v9JnuJs96vLzXxr/mfzPM0/010ETlxbYltayCmhL
 ZAUe7OtzHIY0oq3VPuy07TJoV2jqNNvEaZZDztf97zmXYtbncvr0GLvFiFQ096L4
 iYYxVWfDjXeQ40wDD5XLpmiXCTZPxvVtFSytvjXEFQVSjwjtm7g1fabjkGxOIM3k
 HJAmtcaJCXuPir3SdauIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795102021; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:OYqNN98xvUAyrm4gYC8rx+ocFZ4JT/Ui/wuZv0OzCcLW372
 hRft2pBUEM/XkuRQsoVqbNTLLi/ATVT9U+4vaFapjeGjzfZaDjdn+lxovlMpsp2S
 NDwMCbjEeBBw8x5Mb6r7zMll6p0+j4N0KQxDSYj21OTeNu4sTCPVsvADwfwyHHgt
 TioCMVw7w0xetoX3WrP6p4UJhlKIMabjaj2pM+52wUGb7KwWSexr/+21EpCBASZg
 16hnKeAECFFbEDVkJ8QPxBDT4NjIsFqUOGC45dXiEX4r1AL1O3daJDrsO7k2joTn
 TgEEKectCwomzZbacyzpSyC7QRvqQkybTJGksSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:B+JMjfnY+9bPt92njw1uLoGiHElUIfka6ms6PJfqKD4=:PO/wVZ8JVs59G+JTw5kS6Y+7ilfWU5CNhkyTO0FZGAA=;
X-ME-Sender: <xms:RRX_asVWOdRA1Wngm0VWgah05IXKcF5YEWEi7Ff8EUkhRLT-WdJYnA>
 <xme:RRX_as7cpXVgCoBiziGKJU6bbGSIoTIeV0AKLeagPvYvX9v9WMPtt69TqfaZSQuaI
 ZIU3eaeSl42ixxYYjuBk-znAVu1072Wm3USUfszhIL02VdmW3xZVIY>
X-ME-Received: <xmr:RRX_ajIh51wdDrqLr-0KsdZEKuKcUsjv9OijSOXlsDgDtywANBEExG7LKoer_Zd55GTczopJ-rEjW4eUi73WsP8>
X-ME-Proxy-Cause: dmFkZTGSsj5AjAY1JBhaJfL29PtmVFKT0hXgrt2hwyQ1mu693UCIcL5DWGI7IJ9RToymWG
 VFzQMfBYFCwXAdyJAmIlRIXTpIhIY7+MOj2EYqGRiO7YjJn8sqIr0tB850mXa8l0DP/JHt
 YLEvcCevONnhQ9zgy+/WCd7YINxZpDs9NbL9DbvqwQ0m4Q36nYplW7/qY5aZNGMu4NSkq1
 VDeoDeWvyqVhfSLWFh8Yk072gVmBIjEVgNn335TKSwISpTb6bx89j6UQRlYOh9GoGmnkVs
 GA5mJUMuZcfd5lS2Ks4jnooq31s6tXNxseflJwgUs+HeW/g+UlxR5G9K4BdV0cxSKwNDTj
 aT9g3CxO7bX2LWydglHRQ8X8VpaoTSRitZ3mKq2ViN2hMTBa/XVEJvCA6Vc6vHub1nMjlk
 JRLf+4vKUHT73zBNz+Bi+UO/cfLfvHAm1gTHrg0uxtMxyXznZ8k+2gQklSxLmu95yP2heF
 PMdhqhrogjCSEObHJs7q63Ngv7ootwQfG9NEpOk9QRP6CBWdahZZ5E0TPd6C2zu70qpOa6
 X4szZZ22q2/WfvU8ERbxzhCM2CT41QsVh+4DVjycuMgHcdZ7lp0U69R0E2FswLUFD7vgQs
 YCoHx18o47yJ8u0AU9qA9AugyxwdPDynCRTmUsi40+woJFvoWRpAZUaBh5Bg
X-ME-Proxy: <xmx:RRX_atKt5wSQqOlwb4xM7CrwgWGDH-BWop3UGZhwS7nrTnUIbldT3Q>
 <xmx:RRX_apWksMpYRYgiYuIbFtQmMM-5TjkcC659mYaRpnRrAd5i_Bzuiw>
 <xmx:RRX_ang6Shg_nGW4Y1IejRccrmvWeRQwRiqxqgjDQJYi63rQsDPNCA>
 <xmx:RRX_as8yieizcljYAsd0ezGdbdk0W6pHayr066CcWjjGx7PrJk7ASA>
 <xmx:RRX_arhuU-tX30La63nbuDFZGIz6OovuRGXcrw-VT2r6eU2CsXyzJV1->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 10:27:01 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH] maintainers: update email address
Date: Thu, 19 Nov 2026 16:26:59 +0100
Message-ID: <J19UV5RCRPq1bmOhBplsWA@monjalon.net>
In-Reply-To: <20261118234407.1688949-1-luca.boccassi@gmail.com>
References: <20261118234407.1688949-1-luca.boccassi@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/11/2026 00:44, luca.boccassi@gmail.com:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Switch to my primary email address.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As discussed offline, primary email is switched also in .mailmap.
Applied, thanks.



