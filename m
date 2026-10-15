Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A4CCA464
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 18:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F9CE402E4;
	Thu, 15 Oct 2026 20:56:58 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 24CB4400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 20:56:57 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 946661D000F7
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:56:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 14:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792090616;
 x=1792177016; bh=eZ1adrWSbyxMQkGmqmCa8i6F6iHhX+mbOUlfNDpvX5Q=; b=
 kQyvaKG/DK4O3ZyKGswsL2n/E2AY0siqw16ZGhY6sOFJjiccpdxo940ycOBE1TL9
 Ke579PhLHtQaKS7X02hxbi9ECD5AIJAgsgXTZ9mFv+4QSYBrCsBpCXavAaAHcM3j
 xukeXDa7H7Q91zyGwDJVUND8YrM2r+qgql/jcOD98dnos1dFRU0sjasc7c3UPQ5C
 BHN9sRkN+mx48OaSq7OnAyLOEXNEspvFx3EhZEbIHKuVyW03TX/UI7P62iqCgXnm
 wV7buBM0pLXT/A8cNAc6jujW/ZeoOvxOYAMiJOVxs6WhzWfQzdBNUd62ck/S7lAf
 CymmNiNHaaqS76AD/qtLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792090616; x=
 1792177016; bh=eZ1adrWSbyxMQkGmqmCa8i6F6iHhX+mbOUlfNDpvX5Q=; b=T
 odRbgLF9IO9DJYUaOrBZ6lF9/Cxk379st5CcmpgwVVA4VSUt1xkTw1Hchmp9hsGy
 fIItNPOjES+07KncnCw+7RQzC0s5UAUCcu0UUvQacNvz0umTizXcT+5ZkRJF5sej
 L9Hb0YwgPb8mvG/Jh2RRR/7hVW6YXWP6KAFCc7Y4N99B9KN16oBPsVWc3cv9mLTk
 0PBqKMz/H2rD3z0PQmXJ/F+WmOaQNyh2wbjlO2FWwVWOkxNnHVnqer+Nx2PpgcZ3
 naYVvbLZDC8xSInoTZs8EqTmyo66knpk9JubaMLlGDMPdgryU0URzAQJd5kB4VL0
 0maiN82g9+fyszQ71ta6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792090616; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:AQGJaGDShg8vIodLsN/gz9OiuIqU6JFQRu8bNVs7D6gzabd
 Pq55QNmoyv2RJ0jGfN7LVGCIVhLoYw+zbf3ZNciCbsBlHXe2dRl7DV35m5PohdqP
 mGUMS3qiWNX/H8LSmj15yVUxNDrYZCSphooxl4GbBtjRa7H7DbQgKAtbX48iz7a4
 qdw06NW5vw/ZbpLDauQGR/UdB4rqgpo/jlglY5eEdk8t+IC6giP0QtFN/gcHyJFi
 Zmz6ju4aOV3GYxErhi+LHzCmyOE/Tqf2IFjo2SiM+v8dfTru4en5UamAyEjwGOHV
 6vFE5Q+PTp1bGI/V+0K62sjFr46tMiKl7kCGV9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:9eyKfgi+m/wrukNYPIKIAUwrIM/OptVed+sUVt/4VhE=:s0g9kxhLJWcEMwjJbMAaDDCh59g1MSyd4ngvR2CNkGk=;
X-ME-Sender: <xms:9yHRakLhMn4srjVnvliOtlSPpM-JfAgRc9GSDctUw5P_A4enCtjeqw>
 <xme:9yHRaocge_R1mUOm23Myjn0NUT9PUTtvwInkUHiUPhQFZlcfqKUVnrtfVVhwvO0IN
 SGUyt8wBeY2QcYufw10pKZdORmRxO0hvpjmTiJtAeCPXKN-t8At8OgH>
X-ME-Received: <xmr:9yHRaj3WrqHJ4wvkgCsWAcBG1AyCxn_mqukbjzJKKgdZDxucPKIBhtQ4S3Dks5OeRQtXWothSrWQ-_TUgFkxGjU>
X-ME-Proxy-Cause: dmFkZTFjy0/IpwnnDmQ/nQBOj4KPtYJn33FB87MHbp0uJZy8HxZJZ8CSmldrvS0mdLufmH
 7jBAO6iRAjeRgH9eUFZoe4XPi/RHmEDFXK61sHip9fPAboNJKNbjIFcbKuLU5qbgpYqtLh
 J7UGG/2FvlBB87Ea3dGhCGqOa2AU4vP3ypCI9zBOOJblWz6nImSH8Rzb4i+8bBcN2e77iT
 FihGD/tiP0jQJxbDcaEZpGRBEbvmq2+eeBy85s2dEAw3DINbYz8y0mDt1Fa7oi3+ruGpMg
 /2nZ1Z15cUVolkjfztvvRuLmoF9XB7wy9QHeu4c1UbkWtQ/+k7AwLgEaJ/OQnFHAxicViu
 znyde8V5L88h954wwXyKyYohHh/sUOExRPgKxfvCBMLDjrY+kVTffBqLdb2/lSE2gRPUw4
 aAglM3f/MWnVcfGWOtOMCKnksaBkeEw0MjfklhjfhkKMglx0ursZx5mLvRbmMg7aiOQdl8
 T6YKNbqjghXcgUpBgv35oexLBaYVVzKR/63j0K32IC2WRDCwfXpNuIyf5lb8SSt9M1H05r
 bszbO4p96p4SalCZONp5H/XkRK6TqslodlRVyhjjw0d9S8GwnGIHgO6Mg7oqi8BamWDeQ0
 K3fnMs5wXNNJc7EoMpaGld+xg09jd6ptYD7pG1mAzH8kA3GTobYllB9TRYIw
X-ME-Proxy: <xmx:9yHRapj9-QN1dHzRbTzosir_liAc8BpcrP61yg52fclgIzXDeJrvrg>
 <xmx:-CHRahSS5RdLjxMY3j1Dc3zxLX6ylrZ71oG9mv2M3jj0-sabnpCh6Q>
 <xmx:-CHRaiiuN1mjjnCv_d69XlyriUoMKHqQmdZipaF1PWm13LrbcHpZIQ>
 <xmx:-CHRap6Sbqrekk51b640AhrCphs5y9U0CSY9VDzzhmlLyzfnQDcrjw>
 <xmx:-CHRag1wp05kf5s3v0DxLS2VlgYiP_DBJ-kPRszGMfSkiHkifBgsSPw_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 14:56:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH] sched: fix data race in RED random number generation
Date: Thu, 15 Oct 2026 20:56:53 +0200
Message-ID: <AFEuXescQoukiT1Cxmcmqg@monjalon.net>
In-Reply-To: <20261010015916.1689925-1-stephen@networkplumber.org>
References: <20261010015916.1689925-1-stephen@networkplumber.org>
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

10/10/2026 03:59, Stephen Hemminger:
> The RED scheduler used its own random number generator which was
> weak and buggy. Change standard rte_rand() which has better
> randomness and is thread safe.
> 
> There is no prior deprecation notice for relatedd symbols. They were
> never meant to be part of the API: rte_fast_rand() is the internal
> generator of the dropper and the two variables are its state, all
> exposed only because the drop test is inline in rte_red.h.
> 
> Fixes: de3cfa2c9823 ("sched: initial import")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



