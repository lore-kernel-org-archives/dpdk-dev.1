Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB923CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2B1F4026D;
	Wed, 10 Jun 2026 13:06:42 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 6553340269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:06:41 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CC6A214000E7;
 Wed, 10 Jun 2026 07:06:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 07:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781089600;
 x=1781176000; bh=VR7VU2N8qCAcfukDxEvijelQ/BVJKpDoSBEdAehIbNg=; b=
 fYe9e0GEDsuja9IQ/U7UkFDHxylrG0QYHdfn5F3M1a62AqcQt8EGOtJ+/QpRj0wW
 stMrLoMVTAsau8cEn0D22CIG/48/rF3OFRVflQMA7K9wDkek0IaJjkZztzsMeatd
 dkPVgQWeqs6sQrhuHL+wQEit+AmsYMOuQ2pXFNnAJwtsJv4yfDdo9drb4KgMNyWs
 7/kl78aOCRK1IPhlhFVL4IgkjCcO+1/fp8f5lNhVOVys42EwFkJd9jWFDzf/VSf1
 kUwtkqdg8yqNJWvoPwxbRRXAm5ecexrRI6DVyR+fVmrY5Pm+JRPWKnB432rptJGF
 H9OrVRU1gtp3qAZikPpIwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781089600; x=
 1781176000; bh=VR7VU2N8qCAcfukDxEvijelQ/BVJKpDoSBEdAehIbNg=; b=M
 zWTMNfnvU75mTLYMUPTKnXGgfYDuxIB5/BIEXAK+u5r3Uq3SipGrQaM5Uggqn4ka
 uuPnKcA1iCCiXWeS4b0jTGoxeKhz6aqKdgpPhV+TIY8kL3L0ZP9jfaQ7ZLUMQAyS
 5u4zFunXAUUU3RFF/sS6QUEFNiU05OLi4zCQK8aJXKBqengbVnxV6xXQu3jppdt3
 VK2/Yd26a+ojKJRxZHITaoJF9lne2MJhpZiP3yjZsaTpqoqYkBJa/hK9HGPxGy6Z
 73cC7Ny3z8zvOJgoQiamXmAnLdbGDLfBw+qn0Q3ZcNlYX0Bvn641XqxxnddoTfN3
 53Kt/ypl/A0VMeHVbM5XQ==
X-ME-Sender: <xms:P0Upaq8Ep8qrJ5Tw6YEwXlB420OxUt-3UWKRbz0dajaZG0o49U4vnQ>
 <xme:P0UpavAjPgj7ilkgKTdS-tibShc7GMbNyr7E8ucycSxiwYRGihlr77zwvydWuEX4K
 IwugJTru5KcvGdsykoL2hWzJxS5GlGkGKveBx4rHwuTMaEdDb3ebQ>
X-ME-Received: <xmr:P0UpavKfk3Nj0izQnpikBPqpXZ_OSCyiwbs3sFMKnblBiAdPXZUqIxGP0Z2hj6OKyOSx-WTwtRhx5Mmsuack1cR5ig>
X-ME-Proxy-Cause: dmFkZTEXyGdtXyO7h5rU35MlDkUMmzbzXfNjBloyfO3/gRciU4iuh7B16YTMQbOSu/debd
 uz56ydN8UbmtuQsORIUD/WSSi3WGt7wwgTXZ7ueoDWHEBZXglRy86wCZvkKbN0YUbCyqWf
 uUG55xk4nGn2fpE6nauyTkMjuH12C6y9QakHAdhqS3uuuCUD4iVHNhSQH5xuvVTeMGNI/K
 LnJrttnWdQOH0UJpsxrbSufLT40Ak7XyBUHCsXzQoJYneiorQkDJF0ioJ4bc4JMphf/7YS
 4rttEPxTQ2gngFbumtm1G2e/bQupGUNb3QyIp1mFT0lc9AKPVtfvslBMyac9wueyVzJ7SB
 DH3ms224LnQ+paDNFQWmB0YM1P0vbZxLnRUbRrr5YNXXDv//o+XzpJg3DhmbPjG84t/Kom
 RE/pXPyasULpuBeL87TYnL633beucJosav5Pu0Ug273aA00qCsC0dSkJ5v11gY65+Yp8UI
 7oi+ZtE6mWkjLsoRuJa+uTo82ByoeBCaJqcbq9c2sYw9ykt2bqkTG4Yu+LdhV6wvbG23xG
 mz0LodInUvBQLdXe6SqdKtzXyWIUg5wtLEsCAfbeD1H+Jv1r51VLaQKLwK/EWCkNHRUFeC
 gKZqbe9/jGSAQu3Co92abglgeDm260taW17W8cAJgzy6wGMOJJtwOxPGCR6Q
X-ME-Proxy: <xmx:P0Upaql9eNj9s2nj1s7Yk-W3kIokCkVQH8Mngli3yyM1pHua-GCY9A>
 <xmx:P0UpalFffQawDKFIVY7qcaUkujb3XMTapr5GfcBOSIeteWbx9lwhfg>
 <xmx:P0UpaiHfemwI1UVVoJqe8qTgP7TAKiHFAeYqox1HkqjSDuWxei2qMQ>
 <xmx:P0UpaqMilk84dLKlfo0MBCwLZxxvFY_IICUtv-W1J6JJOkVnNc3xHw>
 <xmx:QEUpapWC5Z4FEnxILEtLGaGQNnmv0VF07QjgjLywd2HHkp8R859ZIO4x>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 07:06:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v8] mempool: improve cache behaviour and performance
Date: Wed, 10 Jun 2026 13:06:37 +0200
Message-ID: <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
In-Reply-To: <20260604114851.12586-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260604114851.12586-1-mb@smartsharesystems.com>
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

04/06/2026 13:48, Morten Br=C3=B8rup:
> This patch refactors the mempool cache to eliminate some unexpected
> behaviour and reduce the mempool cache miss rate.

Applied, thanks.



