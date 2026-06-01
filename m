Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA466CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF5644025F;
	Mon,  1 Jun 2026 15:49:28 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id D0DA74025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 15:49:27 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F3B837A01EA;
 Mon,  1 Jun 2026 09:49:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 09:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780321766;
 x=1780408166; bh=vsEVAxkwvWMBzqH4zZfssFiLOJGuDjXcnRwpOB3lBlQ=; b=
 jRSSm8eyG0QK5EWH/VG3K/3GwdPtfNeEi8ko2v5EL7aykVLnq2yF0N5cqBDERzro
 I19V2WhtWjbZgWYE4XKZEkTnJFP8OnqMyFEW6lSlgv0Ls2h1XNeTdOVeJsdfqTjL
 efWIq/ib/ZzIfQskIZrss0X9dwdtr3Cu0I7WK/0o45TEFyauijcI0x22ItQc/EnM
 oJQyVqcsaXX984TqRdK9jAGF0Nz8AUWYIh9C76ro0WnbPfiGyaLCIHvA5Bvuook3
 iLe974y2pEBX+vtVSNOv5QJf5a+Dd+XQ/52x13ShMlb4RGtWkNpRVYGaFLxi3kr9
 MfQEfh87st6Ax/kCkRZJiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780321766; x=
 1780408166; bh=vsEVAxkwvWMBzqH4zZfssFiLOJGuDjXcnRwpOB3lBlQ=; b=c
 tnhoFq3oS/tbmn3lHTFFrc5eTnAe2RlEmEjfO+oVOSdgRao+YA8aX/a/espNnQ7c
 oKNqkedsnOxZo37aaeMs57nDf+jgCC74bNTIOp5YWuCvAMeVluAiGgB2S437Y+a+
 1HTopBeu2+xLVe19x6jM1hJLOIBNFSG8VrC849ykb7mZlmd2MdYDAGZ6kPXkdade
 TWG8A1serMgdmZAdEt1n8QO5ADgMm9GbIz+duGjcsmYM6OXSl7vT170JZkVb0Nl+
 TAEl16qI+yWwYERZJX0xfPb4cvzvDe4X+P4m48BqG4xYomHh5XCAq1SQeHPRdWZo
 SiY/fKR1vTThIJFm9iWXg==
X-ME-Sender: <xms:5o0damIjF4oXWzqDeIcOnJoqE3AMTZQUiRUADBDpj0R56ovg_7NCZQ>
 <xme:5o0daplqkn62r3RlTKyhma4n0IB0zB1ulfo5XgiuzJ_N53QVrNksEoytetiCvIv3C
 AKa5cYt2scTG8ftzXQfHXGsMhKuwGHy8TOpLzszRoJ8MqFN2lI8>
X-ME-Received: <xmr:5o0daqPsE-u2uknaQRaEroUT9wsMIbd8Y40u3sakABuKdJCfpTxmA7bI8OeLJYQTHLR39zxKZLchr0QI2gPY7bsCrg>
X-ME-Proxy-Cause: dmFkZTE+Bo3D1zx9Eiz23OXDLzqSlH1roeOE7ZgGgi9gufg8/M0814GP7qUKkj0O8acSDs
 yKmClDpBVXyyVQiR2dYqs87bMKeIY/V9RzYkie9v55kw6iZhFUmnU+aMHIhS6FlIouleog
 NfeGJJofzPok2bq193BDGYsWBdfyRsdjqsC1Xrr2DOKNCvJ0k8ysvWzEjHAtHi4IHgamZk
 9vTHbWqQSKKJn5p3G5p+NrVNSxVfIIWQv4JT75IoMSFYbgk8kAizUaTHLdqchR3tIjowCk
 GgvqIZHfyteak0FwG1BZio6uQHmb3JyuI2wc9ApKPlUWf8qX6A8icdFys4eJUmhFVS7Jtu
 zZ4YwCFveCh6Hg9Nvi5ZB7s3vUcwxMRojgcfn04EUxkTER6t20fBqdBOSJyYU9OC7gUydi
 fn/B2GajHkD/64ug1p/qltslvgO1igCGdcq66BCkzGzhPjMOjdFyEF321xlfFpCcXgx88w
 uk1J68dXWDdcWtpCEfTSxvmb96ywejeSm+ragZrOMAtAUwoHCL/cKMBH53M5lhySc4CQw3
 fNt0UrrOkuGAZJdD21ZmWTSN6kjP+Puiqw6pjFup31KFkUrm5dWQzO2UidTdNUD9PuhYy0
 b3dCPk0wIs5+j1QIBWCTRBAxu93xWKeyKtpU91jucdIiaI+Y8xQ0hQcsfNSQ
X-ME-Proxy: <xmx:5o0dav0Zh5lwmL7WkHq1rrHL6gu52dXhUnlWY74-qppvJ27fKYWsbQ>
 <xmx:5o0dapnxLb4rNmZWD75MIqWYIPpp5zEyG9FBD--STgTSAMkCMUasCQ>
 <xmx:5o0damV-TC1wC8un4wl3Dj6qVTfHJVzaW2pGfAxI4lHzIiLXEyu_Tg>
 <xmx:5o0davtLUlOFvYIiLbKUZfrLIiixrvwnf4gc4mEwNH8-x8EidDRiWA>
 <xmx:5o0dau8EqT15OTZPKjk-1tZ3o8xdrMSBfFwmmnQx9ar08buS5rFCgcWK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 09:49:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] ring: add cache guard after ring elements table
Date: Mon, 01 Jun 2026 15:49:23 +0200
Message-ID: <uLNrSKuFRe-A2DQ6JSk_CQ@monjalon.net>
In-Reply-To: <20260505161329.258182-1-mb@smartsharesystems.com>
References: <20260421102358.118204-1-mb@smartsharesystems.com>
 <20260505161329.258182-1-mb@smartsharesystems.com>
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

05/05/2026 18:13, Morten Br=C3=B8rup:
> Added cache guard after the table holding the ring elements, to avoid
> false sharing conflicts caused by next-line hardware prefetchers when
> accessing elements at the end of the ring table.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

Applied, thanks.


