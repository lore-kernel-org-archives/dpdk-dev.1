Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B46C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34FF44028B;
	Fri, 17 Jul 2026 10:09:44 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 510B04028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:09:42 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9C55A140006C;
 Fri, 17 Jul 2026 04:09:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 17 Jul 2026 04:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784275781;
 x=1784362181; bh=03BnwPaEMFLfjQBz+16MZ4cMYsePoCjNTz2bRcYT+NY=; b=
 Pk2mhXPG150ml5fJm5tW3SG7SWUpe05RrLoOW8YaeFQAz7u/RfvJ6VEIuAppkMuS
 K9NBO8vDh2J+RJc0YFwunQq15+FlEBth02K7ELAo83V1kEmz/QWyJq8RKzqF+EzU
 7t9zAQrV1vCxgbczyNs3HYjuPSmh6SuCS+ORu/nZKQFKUbbqeaKyLBFIqh4qYIMo
 DLfAC/HSv2Mk2teTIAat4L05TJwAl+AkKVaswXRT4mqqwLlPzuw1EpmrD6uq62cK
 62VrGqR3gyuvIoH51u9FvBsIpGInt64Zz/1tjjesZcF0LC06BwAXDG9ppR8hw3Ru
 /jfSok106VIxYJi7PPqTfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784275781; x=
 1784362181; bh=03BnwPaEMFLfjQBz+16MZ4cMYsePoCjNTz2bRcYT+NY=; b=E
 0msOZdriUWvZAeXPRqt8m9M2VFqJFn24TT4MDvKdhYBvpgvqEaKsY6e5+fGkjXJA
 RJ6wLQUxIJH9tT4pkFOmVvL22de0Sk5THrPX1qydjM31OFHW5/vEEhbIb+b0P811
 xABEPBnp9ER7IfmpVGxdxyS6N30Jrb6fJTwnCYiaGQq7FwuZFM7clfPJcskvAC0M
 mWpYEq3JWeoWiAH00HUu1cwsBWcTXa/UNSW3JlANpdzr6OF4Y/n2+hLDWc2rbEAl
 g5zkNpsCEI7EfqytAsOiD9MFLC20g6SuR142oQ6iyvYGTWfkf9AkfsRLJ7sOLzPM
 lghzWkkfc/bxEZwpDrITw==
X-ME-Sender: <xms:ReNZaodbdEIOGVrkAe0cGYnO4aIqG8qfLkbxWYrFxq4XjrndVBRCRw>
 <xme:ReNZaqXDy1J1ZPDToYGpxF1rJfD_90WyzZffrbaO0GQQixtdc424Z_0OVEinfZDRu
 a830bItsZST4Hu-VGOagNWKae4iCmkWsYDae0i7Kr2juk6nhMA>
X-ME-Received: <xmr:ReNZaheVdzI5-sLuWx0fXRxyKJHvlyAK5g0FHlZcBgImF2Qy6xAmgvGyWwyefqAVQ5whujKuJ-OEF6QoNA>
X-ME-Proxy-Cause: dmFkZTFo7m9kvlNQpS/FNlQ9+fkTYWuFx4Qz2fuCL8d6BV6+tbrV/W2RgIl81yHlr7d64b
 oOyTAW9lYpUPI8s/H94l1ELW+7efaDrsGaS+Yuoc10ka03FUpWxE/0Nxs0r/5IYQ1+b9CG
 MQDYdUZ/YqeDEag/I2oT6pqUVRF6R9oi+ibEklWNguSoq5qRQWqouanIdQKSter5em/yy0
 NppRaHYt55wxvr7XFi6G0sr30pWoKcexOLABlr0D8mgDrrEAgXI2bQC/NnXQC/oojbBakh
 kR1Tpfd352w4Uo7rZSIRnqXzCgGWTXoBlI8+JLGAXmRbp545MT3nQXTFXJwkumywLGBICK
 o0FNK9FCIt9b8sg6e6wH/KenbceOJyRBDRbZWKwXMQ2984kdXgflAcADxDH46r1JzSqOa4
 kPk5+UkFmiywKp80vERxIkCF5Apnyy0f6f3NN7wxOtQIWRrOXQfE92PbGWesDPa/BPxZof
 Z+sF64iXDli50ajzjP8xyAFoZEoSDQw0H93G5vQcMRPkoiCKDxjeHiytJq1CE5ofryZeLF
 9UWw+iStHcw9oqf6SL30u9ocORdMMkjLu9iuyqaWQ95e01IT5aI/uewXofEKqAx/DmoLHE
 zFvFLgu9zO7Lw6XfIvlcHCCs7Uh1VE6XMhVJx1+bqR6n4gd5m2B6CvhLdeDw
X-ME-Proxy: <xmx:ReNZamPlP7MzWaQDSyyGOZA69V_N0eSoRXn6nAS7IOQmXY8YcA4TKA>
 <xmx:ReNZaviqeXneWcuqleRbfjYmB2mdwJ8jkdJIZ4waxW9hzNB7qjKXGg>
 <xmx:ReNZap2pKI4zMEJ5ESc-PRaKpfGrNImc-iBBG87-z1asBGXAvuPhow>
 <xmx:ReNZaph7sD-QiaVXygLq8P0SaK9L9llbApzjI20_rlGF13KNeAF9dg>
 <xmx:ReNZau3j03HXGPcuqLbgbMqZjd-CINdey5yeTKeEIh0csEOucn-wb-jA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:09:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 6/8] doc: add missing globs to doxy-api.conf.in
Date: Fri, 17 Jul 2026 10:08:53 +0200
Message-ID: <89E6AkFFQ-mRyIB3PXdwvg@monjalon.net>
In-Reply-To: <20260707085048.15295-7-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-7-marat.khalili@huawei.com>
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

07/07/2026 10:50, Marat Khalili:
> Public headers starting from `cmdline` (except for `cmdline.h` itself)
> and `bpf_def.h` were not previously included in the documentation build.

Why bpf_def.h is not prefixed with "rte_" ?


