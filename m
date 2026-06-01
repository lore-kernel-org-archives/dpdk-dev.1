Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A43CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E5BB4025F;
	Mon,  1 Jun 2026 14:37:45 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 2F7454025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:37:43 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0F2DE1D00401;
 Mon,  1 Jun 2026 08:37:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 08:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780317461;
 x=1780403861; bh=d8qn0o0XmOVbHOhDUACHxMQF3jar5Z3CpDlaGdw+790=; b=
 oJK9H7EiIC3pSnHDUQy+fceD2WMXJfalfNKs4FTdvFXdo2yCjVEF7awkzQQ0uvcX
 U6tAxTGt6CR4bR916mYyq3ffrRkkSB83O5+YcJ/rtLqOkxdUSkYTTy1UnrTkUACM
 sIAf+7j1nuM2WqRe8rsNxCfVkbbHqWN1MRfrcKo0ujXSTfIrCGWghsE0pygEONdW
 OkfJhn45F+SCug+ydKpq3M7XXF3fb7XxQvnlU1/uOBRjznei0rvlDMU4Oe5xP06J
 UtzyfSJKnm3PhWFwhyKqSUlROnJNBZfwSThjs8e/ROESetlThdj4XA9wBZTJtkyy
 rBJUp7z/BynsECanKqlgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780317461; x=
 1780403861; bh=d8qn0o0XmOVbHOhDUACHxMQF3jar5Z3CpDlaGdw+790=; b=X
 YrKgBpx6EvTssPW1Xk/bXH4VjyE20M9kPT8Lo23irZgICopgST2x0c8ZfgwaR3AB
 CauMvSGW8uRpqHfS1dy2Z2QI11PVgerbWbX5jDlIdfcAfs0agINm9j44UA9LPO3L
 md+djoZJ2O0AF7x+iDtUy6WkkqlRwcFWY+81mTZrEGoxNmszeDvBmsxWM0CjDUmB
 MyraQnmO5rowjmHFLYOD+3br/QnrKOHIoJtk+4zaj7u09siiiN0wM5RUA9euLVDq
 jcneuk6oujT/x8H+VbDymxD9iuyluo6wPJR8qVT9BE0s8XrWhKr375GJE4bVw9ff
 Lwm3uChbTNm87Xihxqpbw==
X-ME-Sender: <xms:FH0dalxIh8EbjCr6LN-KWqgKAPGfQNSVv5afNenAmBk1qZJ7CbQRuA>
 <xme:FH0datD6NlcJa3DgznTT4165PfvJLnUA_HHvHGYU8-GkIBuyF7eD-eGbStNdlDNrs
 ps7HGBa7m9b9xIcZH-a8DkCmur8ux7xJjEaz5fvGXGkIrfaTAe6>
X-ME-Received: <xmr:FH0daiYm4Yk94XHJc_0wWtJRpLKFwoSiJFYU_RrjgwETQMChK4IcxVat1XdEMRR7RBNTafZdN_j29eWrxn3JuJ56og>
X-ME-Proxy-Cause: dmFkZTG1epfujPuQAOtCfKpDApXdnTxgmQtyUpisGiGMlBXvIGYPM1aHOUudb8yRr682wH
 LqY2wm2kY35ojzZHqggoPin/l5r4xHJIWh1RE/ga639t9cl6p5oCAWdGggeV6iv3XNa8Ke
 QAh9z8BbywgQLFiy9nfu8E9b3ZjulY4jxRARQbWeFfV0eoZVbq0j9TGDC3ud5VaG7sqcCr
 qPuvGyw5Wf/JMAXNw7CBluBeQBQXqP2OyUWJ7TE60onJHJldBUuFhDRQviQx2Nf4gdBkqe
 MT7K6L4CpceNe4bnDfWCVTtD5eyVUx6jgT66ljNXuuzIJPMy3ydsZW3nP9tvasInTSkfPI
 n3FaXc1oG9m7R6ZOfGwQTCDnOtOxdlXrSGJnafhIQqScQsN5N4x6uGEGn8NSHXDRy3rJoJ
 Dlvruy7Rk3w3QtAz060F2xhrVk+z5q7Q80WMb8zLIsWOpz/ujyNLlQtIY4sfr2tpYbMLHA
 VN2nWqOnYtEs+fTHoZWRMkriS9B15tvPHq5w0ns5w/vGBzpPsoYC+VvtmG78Ur0TRAiT5K
 d0Nb/Lj9OeXa1gmmeshX9mHG5vwvZ+xr+8FHhsaRa9soPbSAKISiPaWYs7++qVDABn2Spo
 zPaV+UvSHSATtB8cQ146eV6Ciw514JRgxfMsNYiYxfbF5ZF5syIhVA4Xx22g
X-ME-Proxy: <xmx:FX0daljjvCZo7tzZ-IsM5vgqH7itYz3f1je4CvCkCeP709mA2on8mw>
 <xmx:FX0dak7moIW2TLcAbvOloVRie-UKs2fdQaRu4VF5swbj7GVVGk0lGw>
 <xmx:FX0das7jgssYzTgFXgR1sWIeB5weXF17EDwU7eHXjp9wqlceaTW86w>
 <xmx:FX0daocgOFN0_2OxF0Usyxx7LqnYKKD6mcTI-JtH95zpV47eClm2rA>
 <xmx:FX0dapaQ-tCOKiJ6Y2vI61WKZSvPuA4Ghm3C5igiu-YZjh98xXua89v3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:37:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wenqiang Chen <chen.wenqiang2@zte.com.cn>
Cc: dev@dpdk.org, ran.ming@zte.com.cn
Subject: Re: [PATCH] raw/gdtc : update MAINTAINERS entry
Date: Mon, 01 Jun 2026 14:37:39 +0200
Message-ID: <QoUVyaBOSxeWosiZpLk9Tg@monjalon.net>
In-Reply-To: <20260529062058.82782-1-chen.wenqiang2@zte.com.cn>
References: <20260529062058.82782-1-chen.wenqiang2@zte.com.cn>
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

29/05/2026 08:20, Wenqiang Chen:
>  ZTE GDTC
> -M: Yong Zhang <zhang.yong25@zte.com.cn>
> +M: Wenqiang Chen <chen.wenqiang2@zte.com.cn>
>  F: drivers/raw/gdtc/
>  F: doc/guides/rawdevs/gdtc.rst

Applied, with change in .mailmap, thanks.


