Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F9CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49398402DF;
	Thu, 15 Oct 2026 17:16:44 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 7CC804027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:16:42 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id EEF0F1D0013D
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:16:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 11:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792077401;
 x=1792163801; bh=E/pvA6utd5NipvEG8raae2OdwvG0YwJ0dbiNJs7Rnx0=; b=
 kh6ufRIeZ4t1XJyaX3l+obsBf3OgIPxq41jgS/+iSo/4QcL+b2SXKbOz+K5CFC6J
 5ttsvKcGHcm8W5WkkrKyMRU6BaswJqsOqAvkRUH5NAsvxbrHqP+Agr4WPNe5L3E8
 fyvJzCPd7Rz46k9W7rdQH7b+nrcLMI3MoOQorsK6SekIlKeNgjs4kwovPS7GIvQk
 Rhb3cbB+TM00KagxacSzFRpn27VdOi2jjyltr7aA2zpvfYPIcOrsP2ZGkSDAbFYq
 2cV9C4zX8gbeEeStHa64ophhKoCyZl7JaEE5eTvms47P2dsYmkbmhkscGVcSqUD+
 TpuMg9Ft/MpdTRFwC35bkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792077401; x=
 1792163801; bh=E/pvA6utd5NipvEG8raae2OdwvG0YwJ0dbiNJs7Rnx0=; b=r
 LfOxjLSIxK6xD+6ulaL4fwFsv9Bt12+XTItc8tZgPB3+S4c1MBKff3hgprhJmfYX
 sFUJLwFms5/PczWPlK1SjQlTY8FLYccFohWGwaZOTxrrj09cvBizCA5YaaecJ9zd
 A5MxKJsOs9t6FsFU+66q0XX84Dnbx/Jut3hePGLYD2npNESkSV57Rftu+SdxAeFu
 fElZt/621tu7ZujagP2pq6zYsbW8+rP5Xx2zIEw5aSRe/siRmpXT6n0rvN0Zw29D
 fel2aD/E24Roxj9XUwUyRaIU7Tqyjpfg5c30y6k9AMh+YGJI65spS0K2eSVYAT6W
 tPt1iKCnUbIBreTjXPIcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077401; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:NyIM1mNF+3gNm+I62RkR805mnfNtty7TJw1WQzsE1uDHCDn
 M53Fjy16kKWVBloLlN5+45tryJzbFHe5SlunDtaePwLn83k2XMB8HhGidTyyZ+OG
 psFwib6DWDXUrLzU3ndCtm6UfOpTO3PTvKQ9GzD1aU9xSOvjJAE5OJUmtV9Dj0qG
 bZSYaM9mokymn3iRS+bEPcOzzKvBka3WwNDW+CPeJIdXwuUyPHT3pSkvT3U7p/gA
 2kgy97ZQmv0ZMAgubS+OKwMDtUvdm6PuAg0I/pX/h1eLFvpvYqpFkUcijtrW2s3R
 A2Ot0uUF76qxJbI1PkcTzP7NWU6/qsx7Tx3D+bg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:wN7VRjweeSBsLt0BDFa5a/rogbe8dHoup5rd/FyjHyU=:fwF8JnagBl7h6ocZyAttXjHV1CdVqolRsIHRStpACV0=;
X-ME-Sender: <xms:WO7QatbzuhMIHTPVLC7DtYQe5FZOlFGwz_3OlIoGt9BwoyE4K34rGQ>
 <xme:WO7Qaud1QQ0BgpKjin3bjXdSfo_gb_FUOYhJ7JckfXd8qsI34YTlX-3pBPOw-3T5E
 rCY7lIn8aI0986Q9YBL_FqssJXgYjacDFucfvgoT3OLPHfZdEMVag>
X-ME-Received: <xmr:WO7Qav0Ym-tBD5zc5p-_9EK63MRo1kENCHiJsOLdIn6cIrubL22kMUIiyZwGf45UAxypdLm54-Pj0tiUNmHEm5I>
X-ME-Proxy-Cause: dmFkZTFaScxB5m2ThO/oqPan1DU7Hfh/L9e4dfjeSwDsOzOkUoHa1cghqoRCL6jzXt4XbE
 aZud7ZayxJfnxJed63Td6KDH5zwX42YGmR/9iU1y7h1da9ABxphkJN7aSwAOVKLv+TCiwY
 CNZRY9nIooDrAFlmuHSPcLqRczys5seYMbVVYLcqAyx0hJ1Fnu0vywdCH9+rCK4eeO1J1d
 iKUNePTu2Lfm3gYwpVmq7YN8I3wuQS4KEIccHSovYi/eSv0TKotr46mMQn1gK8Mjv36Hbh
 +e0dZJWUBGxDZnCs2Tbh9wSE2CCN+xEojdQSMJ5i1Z2DCvKz6gP+e6direii+r5jVS4dYL
 9yIMHSC4VpI8vpLjccYzVe3E26OGYWJFcO1ogF1ZULEnhExH6SFDlTkHm8L7U0SiAO1O9M
 LwZF5kwKfAC+mLgMZc3DtgP7tjl98+9vFldwpVdxTYIw+6anN3Nq8gJo2Qm4QhHK71dsf3
 LORgWMmCnrjjAOjV6QS0rrkHZPecXkawXOYVprtbzFAlpPmYgD7UVfwgMZIrtzVa8ndNBV
 pmB3JhQntT/WkZe+ZOwxvupUKiH3++WaodGRxyHA0GEA1jyBN6ihxm4oqrwEJYQxoKYuRc
 JY+YDxY3/3OdlImrNXQQW2wOwDHhAOeUoC0c0y7Sh11vx/moPOLge8oo3AnA
X-ME-Proxy: <xmx:WO7QatLsIafaC9wzzPYjVqzEp0kr7rEuc2hhu4_gpIsrTAQROuXA3g>
 <xmx:WO7QamE_W6VzhbA7zeGH1_tZIUt_NnIMo9meAU5TXVOjrOHSGzpsEw>
 <xmx:WO7QahVAIGPLzcsOWQt1BHE4UbH7QGx2b6fMpWmeuWMrq39XnoD9Ug>
 <xmx:WO7Qamy16J-8S2bB4800kLLtOX4SO67zXj-tAzBPyrCZeA4-8Ave0w>
 <xmx:We7QarPxo9nDJgJFrBn7d8s-SY68zc7IeVbaaQfAj7ouk3a7GVkqI1D4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 11:16:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Sunil Kumar Kori <skori@marvell.com>, dev@dpdk.org,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, sdl.dpdk@linuxtesting.org, stable@dpdk.org
Subject: Re: [PATCH] graph/conn: fix memory leak on socket init failure
Date: Thu, 15 Oct 2026 17:16:37 +0200
Message-ID: <FkyFKKxFQgakM9egYaZdDg@monjalon.net>
In-Reply-To: <20260602131257.108880-1-bigalex934@gmail.com>
References: <20260602131257.108880-1-bigalex934@gmail.com>
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

02/06/2026 15:12, Alexey Simakov:
> In conn_init(), conn_free() does not release the buffer allocated
> for conn structure, resulting in a memory leak when server socket
> creation fails.
> 
> Add missing free(c->buf) call to conn_free().
> 
> Fixes: 3f90eda5b7fb ("app/graph: add telnet connectivity")
> Cc: skori@marvell.com
> 
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Applied, thanks.
Note: it seems to fix also the normal case.


