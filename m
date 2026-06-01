Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCF3CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FBBD4042C;
	Mon,  1 Jun 2026 17:41:24 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id CFDAF4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:41:22 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 207507A0571;
 Mon,  1 Jun 2026 11:41:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 11:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780328481;
 x=1780414881; bh=+5kQp+ohKSZ+dVYzExTbL0gdY6F7YYDcnho0Qui/uIU=; b=
 FCMaWqZZhUmVVMskCOLFb3fW5nEvLTrn8xXMBhvjGgncPLJT7uoGmbp81JFCu3Xs
 Mo5Y7bVnDyJ0Gzt+cc4tdcyIDf+OCdz0F8euxNbcfo9rbItmp0oFwxUs/qh1TgSt
 6DS1UTzpNX0OpIiHyzx4aLd0/FIseIKiCOYwOgcOKRb1jZSVUvwmj58sA+KcC7k6
 pjD1Zc+ipM8ijb64fF7XGf5LAPdAJUlZKXDg9vBnLj1gBzX945UYCnM2u1UnKqS0
 ex8lbekErkXE1ld2E+46WV8AReeuRmMJXKJ5JQBanxiJKJWFyuqUF6+zerMD4NGd
 3eB7bUQH1MrrQqwJuXQRnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780328481; x=
 1780414881; bh=+5kQp+ohKSZ+dVYzExTbL0gdY6F7YYDcnho0Qui/uIU=; b=a
 TlTj+bELhVbC+KDvo97m3seOPH53Qjh/OqUTpoT/5h+8cMzKWuklWRKlAPr4JpcL
 Y//1qIVmhZaN6G21NKa8yGggnbJgiablAfJJM8AkBtYW+D7KdWahF8PqZLZn/THN
 Kgsl/lIpCjSuyDAwqnB2Nz6UG/fvIRYTmxdUJK1JJUcgODcwxJFrV8yeNI6YN8dl
 XEzxnDo3OXvpUPkf1sC03dZipi+YM6zugl3sL3VNLYKdVp4f0NdWthnh+zlrl4FM
 dxo4PWTR9cIpOkQ9F9DHvsjItcoJQqFu1xdDeUU+9SQBgV29mPzu4LzRNlHBEBLK
 v3GciOU+kDfWIC11gltdg==
X-ME-Sender: <xms:Iagdah2VXLPECeThiRJKAAWY9WdBOJMOssFHE0ZQ96Kd5xVxhE1FNA>
 <xme:IagdaoMMsTPclq6r-tzuV2Ogz4gvAKftw4KxQKmy3nmZnXBC7QKh826UDt-0W6s64
 -Vvy9yPbWztfcRwMjPAm_N4tfhQ_iQgyELsdddn2eWLZj6mOP2x>
X-ME-Received: <xmr:Iagdap0PN6RBqK6s92zG9CnW6dEn0jLGFvknjaitzIV62LHpnOx5lMLdPxJ6hj8yJnNPhntrvUZmOIz7N5GxNqSNlQ>
X-ME-Proxy-Cause: dmFkZTE+QsqHSVs3BZABfYLlCBm6IKgsh4f5M48dAY2WJbhtBdDlqDjxGZVU8Q9vuEP0um
 RZdRFzZ0HY/mmHBPd5H9oqw6BIbkjpwY6h2FeSdDrjeVvzkS3Wf0h9CY2oteRcIecJoQgt
 m7CAF6CzLP5foMP2nanFUUR/LtnoW5IX6S21OZzzPxWCwn6xwDxdNT+eB7RsNG5hDTMlly
 9yMUqQOMgvDRxzhKXnqIjbDhEU21CPGKggA7skKfaN7151xUq/UZyN6tHnYoESwsEkCSF7
 UmpkI36aVUdUN58J61dsXz2Zw89SX8MNfcipyoE9JDAc4SllE4Hfdr0X2NFytmFxOmiGlL
 x3feQPYUnr+tC2fO5pH9Ih2USCpb5LA8KRvBwOYZBWHUZLQccNVPD3dq6AVEHMkoH6ilQg
 OPfv1UKF8ebsXjoPsENSf/Aq9lCmb+ftAOGZTBONFG/U66apzkgZpMJRFuU6xZJf7GVUl8
 rQMVr591AUzDD25xOlINnpmY7sSukBXvpV91u3wBwom98DF7Zue6S2DEo9doY8JwTQ+u2G
 u5JymdVgdFVeWiCv3RlwXiWVBsrYlIcsurC3lFV3LbKY/uHv9sqqLyMyK3R+ThsW+3eK5j
 Yqr4ldPvV48dk62gWM500ZUDW0dFqZ3H2AwCSmlBLlG3VVJqgBpVmibYY7Dg
X-ME-Proxy: <xmx:IagdanF0Y1FYddejqKEZX7faa1SEeln7Sae55xybd9xqZ1R1sdpmmA>
 <xmx:Iagdau4nDMZd1IPIXRDvinPssyq_40aESfN47x5Q_lgEaqUZgvA8zg>
 <xmx:IagdalvilEsxvyHgH2igWzl7lCMh89B5rFXh11P_efETdtsBHwUvWQ>
 <xmx:Iagdan5Y5zQpIXoQz_M7Sbt9dZ1h3zmNUJBCJsphPXICQZk0jnDruw>
 <xmx:IagdanNCQ5I8Mnijl2YBZ7C4pBSLElg7YGmfeVjL-QTt9KKfnFBYOhIU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 11:41:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, wathsala.vithanage@arm.com, mb@smartsharesystems.com
Subject: Re: [PATCH v5 0/2] few improvemnts for SORING lib
Date: Mon, 01 Jun 2026 17:41:18 +0200
Message-ID: <FBjugSZDSq6pNxxxgi84Ag@monjalon.net>
In-Reply-To: <20260505154728.82235-1-konstantin.ananyev@huawei.com>
References: <20260423091625.123642-1-konstantin.ananyev@huawei.com>
 <20260505154728.82235-1-konstantin.ananyev@huawei.com>
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

> Konstantin Ananyev (2):
>   ring: make soring to always finalize its own stage
>   ring: introduce peek API for soring

Applied, thanks.


