Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77FBC43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 11:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1814402D5;
	Sat,  4 Jul 2026 13:18:38 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id CE04D402D4
 for <dev@dpdk.org>; Sat,  4 Jul 2026 13:18:37 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 3E272EC00FB;
 Sat,  4 Jul 2026 07:18:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 04 Jul 2026 07:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783163917;
 x=1783250317; bh=e9oZveu2lbv9yMOf6eYuIZ7kl6i8rUynf246cJC1qzU=; b=
 I16n8ghM1Zyzn9OJIPvqrqSTABcmNPw4cyLP7ot16BrqR3c9j+Uw3jbSbZuhp1zm
 ZFqXn6HKySujH/EPsC49phX+dOKBwmvUVhH/KmLtRku33gXZdCEnDbQOfhIuMcqQ
 +53Y+rxSoVOymkhHHbh1huGw8JMtqS3sTVgcR0X34ER/PTmjMjpiYoCTjEDit3XL
 KpAtD2gShIEHpcueUdXcrCvsQbCalUKDwj+oVDzWzu9twy2z4yCZnPJ/iEsdDtMU
 LqCeCarPA9lVw3v763cEglOHn6ex4MugAVSlWtfMHi7CjiYjtckwqDnejANSXWTX
 T1PD5hsfYcpvbRiNDy7U2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783163917; x=
 1783250317; bh=e9oZveu2lbv9yMOf6eYuIZ7kl6i8rUynf246cJC1qzU=; b=d
 SRNnj5cf+5XcFhrhaa/hAgMsO9o9Ge3ioUVLKIkGZ4vWX5vNcH0vbQrOEEPq08Yo
 YdG8Ybnq1pq8tmPfZp8XLoSVoEQM13pUC7JL3K+4c3dgnb91sbS0EYM9joUnaHI2
 QNsxxyRQClSlncoe0VVgVpQpwHddB60GfoFhTrW5Yxoa6MYJ9c6FZRfh6lyUH7a8
 wR3y6zqIHgYVkSyIsB2T6E90hLIPUCpHI5FB9Ni1/S5m1YUP6ggxDGAz+5BqQVhC
 LoXlsxt3KNns8ziklLf8vKns5At4Qeo3ZgmgcpQkUjAmN4XnAn8yK+BRdKrlJfsK
 XG70T/EySSud3IQInXGwQ==
X-ME-Sender: <xms:DOxIarQWBz6RVwjLlu0odoytXDsEQNLyyZXZy_Eh0__1o7gHAxjfUg>
 <xme:DOxIapFPBY8j-GjuNyn3jtz-CoC5xLe-5rqtlWd3G4GOQ-iFDOZEP4jJ_OgwyE4in
 bujKLgYB5wSa9i1VbYd3UyptqLdGodfNq3GR2BeNTEtbYf16Ijfeg>
X-ME-Received: <xmr:DOxIajkwatEIBYWdhpmMevQqm2-Zj0W_Ke_1F7woiOAJyhuFvAWF3_t2YHcL8rk5SCT5R5tor_wVbflyYoXb8AcctA>
X-ME-Proxy-Cause: dmFkZTGrjpCsNALh/h1WuUi+njlMHhG4otV1yNl5CHpXqzitaMAsJB73b1G80Fn+qoPgAW
 cPHn6ZoUb6jo61iRBntVX7VGBjlRBU8vHyiCIrAFjq4YilHhpVp+Dd0m/xjEGGEFRqNNdJ
 tH8jvFmV1jOjQEOaGEq0xdvMi1JmneCOHesOeofB1TZvI7T2H+39wz0EpdHSy6EVQy6LET
 WHeq4iB+U+N0irKWyIUaQtIjkh5goLOSJBMam1j1243Ps+BGOghF3lnsv5msXNRxuEvWud
 XTuYcgctY+gByF2b4l1SIqn/3N6it3saEWLMRpwdPiQGnjyXpVbuuZuIsnpjnCpqPKITrc
 Fa38fcIxosCLJSmfT5AZfiOPPLuzFyOXnwSoZIBt2yXEz4x6/KYaF20PodXp1UcNjzzYvT
 IqXuSFUEfozlaG/UO+z7ZtNVYtzB6EE5Rh2nwnjUc8vK9FFLOoCZhAmHMzedq7xlKKXvBG
 lELQdekqRBGMdEyubRbpKp5AZ94XcaCjCxVln1Gbtnyvf2PUQKxZgoX2x5k60uiL6t6hoq
 f00Wv0Ave0uzfDPYU94Bs4HwDLdctMUxTUyH0BHjX3vcn/uS4BUAUW2zYOSbh1/cnuwTHN
 tbHKvoO7BNJ7ja/ZQ2NkAPKpL07plx8bPEt5Pily77/s1K3FH7vIJQpueSSQ
X-ME-Proxy: <xmx:DOxIas1dqUzq0gy7JlGJLleMrzus3Uf7o-vcn5GVms5OJi8xrCbaCg>
 <xmx:DOxIanQUqEG-srbAqHe8WyMsbpijxm3zdfyosNOdoK61obCgWsIOew>
 <xmx:DOxIams2u5FYBu_pPsFaOlLQqbeTgD_t_IjX5GMsVvf5B9R2Bgr7jw>
 <xmx:DOxIakbLBB5oXeS7dQNmgsc10Z9LAaSp0VCgKwY3A_awt0F5IwyEUg>
 <xmx:DexIapCKtjJNt2lBppnSXnebUIRpi-x4g9xRdhA7HV0sHwypyWYrZRTT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jul 2026 07:18:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH] test/bpf_validate: use unit_test_suite_runner
Date: Sat, 04 Jul 2026 13:18:33 +0200
Message-ID: <BdGkgCfVQSSHCAbHvd3HmA@monjalon.net>
In-Reply-To: <20260703152910.80285-1-marat.khalili@huawei.com>
References: <20260703152910.80285-1-marat.khalili@huawei.com>
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

Recheck-request: iol-unit-amd64-testing, iol-unit-arm64-testing, github-robot, github-robot: build


