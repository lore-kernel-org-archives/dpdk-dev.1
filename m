Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CF606A320
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=LubLuD84
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7686840297;
	Mon, 19 Oct 2026 20:34:06 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id B15564021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 20:34:04 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-868b3248b2cso1625840b3a.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792434844; cv=none;
 d=google.com; s=arc-20260327;
 b=ZY+t8yIuVLrNA/S3aMxzprAvrvjKyul8Pm32zCa3hAnoSsZAWKKY6tkY3p1Bcai5sD
 2aS6K2Y4Q4uS53LtRJBy3UzQHf3QYrsRdpvNWfW+ieFd2Ke6zVg8AvOjrYrbPn1K7HoL
 DOQt8WdnQf3f/QKNn61y6U1Dh1FlkFquJvJZgZdDoxC+1KXlfBu8wSLA2MyFD4Nptlsm
 siHADZ1KMhdSYq9SbmY+2bQLiaJjrnyBEGfOpo5cEWVxBWf8XOmg317rDGVk5EjMsqiD
 h72X2xJjsxvsdMGnnDA7vkH1vBA4MfB5zqFRM0xRb7VEoiRXCtTQqyIsQkaoASA5Vt5f
 LZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5TmCXUZq9txcqsjAVy2xyFlVTwLZQAXJMMvZJI95zTM=;
 fh=jiMQR57QsklOVwPDjLMJ3TheIGD+z1SJ/Bpcr2iE1pU=;
 b=AE3oOmmCepn9CaWbLVJcDzeRFYHIQIo9EZZC1Vxxjh0g0naxsH0PefmrzznfDNB6oW
 MFsabtpgURyV0NT83q0BIRCMCZdkKHM8+RVxNYkF/zIzEND1dAbDp55Nvqh2gl2M/rYY
 PDoLB0a73rM90WfsmBd2ucXvaUSnkmcIkuwwuRm0f8UJlKkocu6xTVcI+SfTr1oWzb7U
 AeDm70mxmsj/Sytair7lm+l0qvHR8IT3+KWHMyMzxpS8ziY9rKSlcsnvcCfpwcefSje1
 GZ//UBpObCUwizatMQgLACWGgnNEJrqBHX/8TsnFhx69r2OufSj6EaYXNmtPy53DtcgW
 oubA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792434844; x=1793039644; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5TmCXUZq9txcqsjAVy2xyFlVTwLZQAXJMMvZJI95zTM=;
 b=LubLuD84PWjHnIQJ2rqX/RnGMQ2AeuVEcFn9uvdAsqBGyRQSWzA8uAvnqk8v2pzXAg
 qJyJ+V/6ZJeoELVn1KDHFzIWyMvq4tsFct/nt2G5RVFnHtFFrICZJiDA5DpnA4UTHrZE
 xNRzPobii0i4/TvbgcSBSBdgoDuam85pDFhLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434844; x=1793039644;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5TmCXUZq9txcqsjAVy2xyFlVTwLZQAXJMMvZJI95zTM=;
 b=XPBO1KJZ45DEuy4GIOPpwFTd3jH4JJ77AQviGVNxtImHWSAy+4dZBAAoRIJig6Qi2W
 sB8QniaqhN7ibonn2LR92yeQ7fgCHIvDCWCelhj0UfU7DOaS6pi1dcu02ZesAmBuxd+s
 ZDyu7XhdJ3zvE0C05VGayjObxAvci8pDfy0DBP/Mu4Ou1u+yNo2i2mLDdLHEcGGG1wOp
 uj1e9u0jeLMzcXPMRvbuDS7jl7JCOyMtbKY46VMcCZdY6wsbfP+1ZdrjXvbgblHI7nPU
 I9htblYiNIXR48DwnYhac7fojvAC3Q+12ejqLuhXiauzKrlUgrEyHM9AcNeCiIjiDYNk
 +VrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDNKuaZ0HeBFvzVEWSb9taDsoiWhlkz+kiWeT+nqTKJx5+xYYHhqfqLD8mFW1D5THWXY4=@dpdk.org
X-Gm-Message-State: AFq9FYIQQ3kPCGIgumgqWwXv/hpkTM3mhNdEuBRjb+e4gNF1G5zIruSR
 K06fgcPCAy8/9Lb+pJHpn6hyTR3Dpiu3tPHe2Qwx9UuRHDrI2VgblxXKO1abiG9vNjW1K0KNQLx
 xCyw+zL1n1U/FlraE0kvi4QitaVLUY0HerT1orof3wg==
X-Gm-Gg: AYBFou14lUEwCz51xUBXp/EjurSFzI+6frSQUnelNlw7jij+HhvUoAOyDwJk6tfLIG0
 d+xCbqDimS8jTvqTVh6alrMPeX580vlToxZcPeAQhKK7KddE/9DLurW4NdY13RspyJ8qSZaONTi
 TYbJ1uNUdA44r7WsRhgTJS7vkbRKGqq7ChUSJWsLLUZQF3kAQU1fB7L54b7DXWwdKXd4ZB+JkJK
 1pM9TL2JR5zQFQVe+Wre/Ace2SxBBb97z+Dgs9Dsd/epD5E/EuimG+hHEgGPwUOVculGPhZejJC
 5Spf3uSO3nXFCbksVUAatpqfKDCQ+V8Tp+ujLrRt7c5lvFFq2iJJLUp+HeDIR8TpjbXcVJXuNxS
 bGsr8GQ==
X-Received: by 2002:a05:6a00:1749:b0:89f:ed19:f093 with SMTP id
 d2e1a72fcca58-8a04be3ee09mr6216374b3a.34.1792434843881; Mon, 19 Oct 2026
 11:34:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901185957.453730-1-knimoji@iol.unh.edu>
 <20260929193432.513234-1-knimoji@iol.unh.edu>
In-Reply-To: <20260929193432.513234-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 19 Oct 2026 14:33:51 -0400
X-Gm-Features: AclHuK_x9KKq0XLt9UZa7TCDfHaOdauxW4N75aNsgHZHj3sUjpQ12qT02f8EHhc
Message-ID: <CABJ3N2WuXDxHQQE0Vo+y0eTgRKuL2mMULi8gXusEQYhU7xUryg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002724a9065e35c2ea"
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

--0000000000002724a9065e35c2ea
Content-Type: text/plain; charset="UTF-8"

>
>
>
> +from framework.params.eal import VirtualDevice
> +from framework.params.types import LogicalCoreList, RSSSetting,
> TestPmdParamsDict
> +from framework.test_suite import BaseConfig, TestSuite, perf_test
> +
>
The locations of these imports have been changed with the api refactor and
need to be updated here.
Fix these imports and this patch should be good.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--0000000000002724a9065e35c2ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br><br>
+from framework.params.eal import VirtualDevice<br>
+from framework.params.types import LogicalCoreList, RSSSetting, TestPmdPar=
amsDict<br>
+from framework.test_suite import BaseConfig, TestSuite, perf_test<br>
+<br></blockquote><div>The locations of these imports have been changed wit=
h the api refactor and need to be updated here.<br>Fix these imports and th=
is patch should be good.<br><br>Reviewed-by: Andrew Bailey &lt;<a href=3D"m=
ailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div></div>

--0000000000002724a9065e35c2ea--
