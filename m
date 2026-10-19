Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516C606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=ZDVlr3TR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86ED840A79;
	Mon, 19 Oct 2026 20:37:12 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 77E4640297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 20:37:03 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8a05e3f0d23so840611b3a.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435022; cv=none;
 d=google.com; s=arc-20260327;
 b=or0nzZQj119oyz0i5EeDbad8ocEYCugz4N+TypkjGPv5wbmf+yFA9uuzYfj07ZN45F
 pQSKNunOSzmuDA9WTZL06eDWA8VtDYl+jgQWvQNIFel6wPMrlUfNgNWILtPKx8VbPnXA
 yn/qXkr/9UFlY/CJdXmMeC1vECkFBuvwYvBeufUZmxIc2zJgplf4dQGYmsImi5xmuLMx
 xDbUXzst7EZc1NUEvI/mgZWJvSGXH2JWwzJU1Rso8cXiKAttflEBbUg2ZppIjvlhRNew
 odKS1VfpW4pkuoXvZBXxrPBN+WCxBqBAj+OE6BwYN6OZVID+vvtAgErgXgDMqVbNBnHS
 kvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fVVuKpfqyT34xwCbc/s2R0Q6URv69RFe0mfaigrRfvw=;
 fh=dSkGRygyk6/4OBXdHnOBdoIFfIyL5meo+nJYYic4syA=;
 b=InfqZyzLReM5qNkQwPJz+LDet1fue7sdeQrir8HAvRwFAYUsIYIzTnBbkwatlMUNll
 zpxzjthWwhc/qn9HcqUS61Xuas/NWrvGTLzl9cc0vk9FkdiChhOxOAvz78qDYuITCt1j
 MwY+/lP/ePgW4P2u6+09jzvDHRYfLRxWIz39PhR/eEYZP2VkEWfR+Y/11bN/pajSMj7o
 fKbY2Zu4wmxcV7hrrjSjuulFB4DZ8Rwc4G+rtFkRHbu2n0Rj/CsnY6TTV6NkS+ZdkWez
 p6dR+oaQfddiqpDlOqzZVAHd+TmMhTirfPiVRFueDzq1PsfrRIal4dwl8WlT1BmoQNUC
 Z+tg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792435022; x=1793039822; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fVVuKpfqyT34xwCbc/s2R0Q6URv69RFe0mfaigrRfvw=;
 b=ZDVlr3TRX/IKnLHMiMeO3F7RxrcJwFlkll+oinf/QHJNZQH7AzRMHj62/NY5xbFZsF
 xRM68djPUQ/mZnUQzaWMzPWWroDFTbEVm1Lw6e+Gv0mrfPls9JHLcqEj9cxlTaUxtpKx
 6ZTrq95/jH9Nm5Zfh2mIHudKxzF04OuT3bNpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792435022; x=1793039822;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fVVuKpfqyT34xwCbc/s2R0Q6URv69RFe0mfaigrRfvw=;
 b=y+h0Hzq9e+0suD541OtxOCsWgiwgH2w4Mo34cg8d6e8NMpdbNs2fj6Lp5Pn+4FY2pC
 SO/JkS9LT8urfRQZHcklp/8pIvkdWRx+GOuAoupcslTL/T1GFTz8prq2SfhXDE1V2KPt
 NCnUbA+VothYEG32k95KluoCWZRePIFsXIvV+BxTziCHxNUTT4D7owq13O8f8a4vqYkc
 Cz2eHfKoIfLtMe0TXuHgW56V7iwqPqqiw6r8GAteLMsZo2lGfDvbdeShD0l6VPtEVpVS
 7N5tgCrhj7rj740ZBxhiVheOdkyKZK7jVe/25beOfUqORyC6PvM2fQDNvqkB8eJrEf/s
 mGgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwji2ZqwTQrcN+syC6G2Ii3bH7Dc8oYnAwNO5w6fgHBOS/oz2Lo42hvR8jVpWnpEgp/XEI=@dpdk.org
X-Gm-Message-State: AFq9FYKZGtxgTHKOsBK/5sCFtwfmTtggU6pCRIe61QE1g8NiisieSVzk
 sObKiRKPZ2wThsZzaywrCX1/0/BNNdDo4/42rYNYFZHRp0N0HADmMOjiiRP2u2af/rbt97AO36r
 HuL7HB627JkqfjUt7cdP6up/w+uimvSKXVueseBTnFg==
X-Gm-Gg: AYBFou3H6IGCEUDCLiDy0EpJ47MyU4/NYhd2B8UNYMW3oNncU0AwjIl7gkJ28kM9nTq
 d1c81ZP4MERBOImeQ2LIcZyVMfr/VNS3LTB5ALTBE6eJPyWqd22yuYpyzvbnBwtYTyeatkEBYhz
 9yYJfnGepfgRh3kV9e4xB0ydQKjBVSkMRnsFTOnY/ZKJCrdWF32ImbFtDKV+w+ylDD9Jnx5cjft
 CA3Rz7n+mzUhSeHGfz01hWeH2SXEzwrMIJj9iYHDDPkNSkMKhrkudBq5FfRvsYljjtGa0HYGQFi
 p/qWpELtEHh84e90uo2iDnTccFARNM0l/vGahTp7VkPMNZcwHlXp1LYOW9fixjAC6trs7g==
X-Received: by 2002:a05:6a00:849:b0:891:3049:8ef8 with SMTP id
 d2e1a72fcca58-8a04caf9667mr6323990b3a.47.1792435022444; Mon, 19 Oct 2026
 11:37:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901183701.431831-1-knimoji@iol.unh.edu>
 <20261008191139.1094155-1-knimoji@iol.unh.edu>
In-Reply-To: <20261008191139.1094155-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 19 Oct 2026 14:36:49 -0400
X-Gm-Features: AclHuK8zSiJnbcWzyjJb60kINL17inCf-ZKE3Yunr6qwdowJ1bEwwxZqDXQInbU
Message-ID: <CABJ3N2URmbtMNrR+gtFv8DVkL7+g=Ui8xuxzOoot5Aqm5Nf9Rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000cbd4d5065e35ccf5"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000cbd4d5065e35ccf5
Content-Type: text/plain; charset="UTF-8"

>
>
> +from framework.params.eal import VirtualDevice
> +from framework.params.types import LogicalCoreList, RSSSetting,
> TestPmdParamsDict
> +from framework.test_suite import BaseConfig, TestSuite, perf_test
>

Same issue as the 2/2 patch, Imports must be updated to import from api.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000cbd4d5065e35ccf5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
+from framework.params.eal import VirtualDevice<br>
+from framework.params.types import LogicalCoreList, RSSSetting, TestPmdPar=
amsDict<br>
+from framework.test_suite import BaseConfig, TestSuite, perf_test<br></blo=
ckquote><div>=C2=A0</div><div>Same issue as the 2/2 patch, Imports must be =
updated to import from api.=C2=A0<br><br>Reviewed-by: Andrew Bailey &lt;<a =
href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div>=
</div>

--000000000000cbd4d5065e35ccf5--
