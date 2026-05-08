Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA285CD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 14:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D70AA40150;
	Fri,  8 May 2026 16:36:59 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id D07E64013F
 for <dev@dpdk.org>; Fri,  8 May 2026 16:36:58 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67929ff6dbfso3134655a12.2
 for <dev@dpdk.org>; Fri, 08 May 2026 07:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778251018; cv=none;
 d=google.com; s=arc-20240605;
 b=TyyWAOm8PTmLtOGFUk7VK+mzlQ1huBlWOWnOAaU8LNQAmNFKvWlIJ1B3+xhc1motqp
 UprFb73YuMSvN32LDxnqAb2t0TTPyJ0HdE6akhLEqa3UWHk2+XmP5zLHam/B5/u8atVb
 5i6G0cND68WoGWOyoiPD5zOUdB8+7Ao5hiAtmX1Wc2oKEEsYWadGH6Xef0Ib30hDjcpu
 WYj56YR3P1Hd0nTWjaLMFKYnRjOXUavalZ53sBWllj656oQO7zmMJZntVcY4TkaxeP+Q
 Fev2Jdw9ut7OZxfInarXFT4xtkpA6DrmnAbfHhWdtMc+oYjSa/Voo8Dssl5ymjQXoILx
 QCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WGkOMB6l/DM0HN78LFwvad4T0jor3n0yjgN70crtJe8=;
 fh=jJQij7tmLyA8XtCGbIyYRhm55VjgHig8vxsn6lgGDCk=;
 b=cYdOf+F+RDmT0WJaS4fSh2EB8RHIsiBOnqz6W0GXlHgHkmJvaB/VvIlP2m0q36OJSL
 kk8CINMbdg5tYHlZSaCwwenLZfJTRsrRKl2urmPxNl0xpFtknKIxg+bsnbLHZ8BXaOhb
 10NqFXQmn+C5kN6LLkp403qjOOstuT3LrAe6K3vZh17IvNfgt0WrPZtADpF6wcdwNHKO
 EvDpxBmV/RjwwnpP64T0tJ1IbtLpFkl80bnwK6j6XSOEq2MCUFn4IKgLDEzoEAdyJM0S
 n/Cg3E+uHVFGlVEGJw8CsgT5BkXyKvEE4yF7br3jqdZBSXZMo++kOGS3J6e/gxEpjdwL
 xHZg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778251018; x=1778855818; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGkOMB6l/DM0HN78LFwvad4T0jor3n0yjgN70crtJe8=;
 b=bkTaY0waK6cW1OLbaTWI382ywHZWFNw0gujcc16PsTEc80dXzPULHbLVtnmyXWBy7E
 Mimyu7vmpXno6pdC3+LLxgVZ5AoDXlEyJSPXCpqyQnFVIY5ldm5Cr7X120s847jHxE3p
 uGS8E4wMExc9pEEEXUFZFp6p3vaTPNF+agjx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778251018; x=1778855818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGkOMB6l/DM0HN78LFwvad4T0jor3n0yjgN70crtJe8=;
 b=rd+zvq6KaCOF0EolS5s5XkTDtL6fdSkKBj2vI4WfZdzs+ygemrpTcwnqqLh4ThoXYW
 x7n/jTVDpx7Ce5cYzyN6Aiadm0JLVui/eFyB1Gun9HPpirEGPYFeaY2YLABL08FG5TNN
 GjZAveBkadPn8d9pYIhNP96fd+ElczYxouc52Twfelf8UWeUDliZhgrN99d1vd1zgliU
 o+F5XNZCgCbUXmozPpk4ImBqiZ8E5Zpz6XBi7UNyEbFt/PgJj0407psW4hYuiq/VYQ9Q
 b8ve4lQVTXT4vTgLwyrOQodeKZ45oxAOQdhRdRZOD/0W6FprXNNO6jd+9puGiZhhS+Gy
 vpkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XnvuzfBdMXtwo37aGWaJDWAc0swJOJyDPXB0UOmmi4k7XIw7EqqlqVYB7p9XPKI3g3Kk=@dpdk.org
X-Gm-Message-State: AOJu0Yy8QmQ5epr8fZzFP6bNfxpvIGSts+jWpkChq4ShhwjtaRBxfx2k
 3FTCmvuXFa6qIdyNu4vMmA2ahsxIOC1tufq9U02XofuSBhNQQB7b8ACNDzXPriRL/ZNAHUxW8oR
 Nm3Y+Ogbp764P6+Tc1VrgTFs+yuMg2TfbJnMXy7CaRQ==
X-Gm-Gg: Acq92OFh8AkTpMgo0ctF/BkBHaeejCOpZsVoSY2KVpqwi8b3d482l77TSIOHWuWC2id
 cop/g6KB9PiLrN0b3jvKs/Q20W75LO2DfokyrCozGJ+4ML6NvslkshsKuWn9R5d8jd44O974c6/
 3zz0lgjK2TvcWEZqBfaNwlyggvejgW7FPQUF3DLYQTB9XUt6nm1zC1tPRgZHufb/RIeRSz9rZPY
 a/zWOFad52kItfhm8lgwlrQ3/LjL0Dpa5uJtiVKZVEjeMeAoWm1mv34bE9CYDmijcoH52bK2lIm
 QNowaw5+4uK++72Q3wYe21ah0Yf8DDkBw/jlXNDe
X-Received: by 2002:a05:6402:5050:b0:67e:441c:831c with SMTP id
 4fb4d7f45d1cf-67e441c83d5mr3672208a12.22.1778251018289; Fri, 08 May 2026
 07:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180232.443820-1-abailey@iol.unh.edu>
 <CABJ3N2VwFm307fhAOY-n5Y-MCnvjh0rAee24vUJrmqcdtja0dQ@mail.gmail.com>
In-Reply-To: <CABJ3N2VwFm307fhAOY-n5Y-MCnvjh0rAee24vUJrmqcdtja0dQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 8 May 2026 10:36:46 -0400
X-Gm-Features: AVHnY4KRVLXCyvIivI211tim-J_QSBZ92aYmcJ6SYOGimkDgje9jWjVBCSE0N0Y
Message-ID: <CABJ3N2XGxOi_AJm1VDk2=fM5ZKS7ctbyDXArao=S8fJuxVbzNg@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add ipgre test suite
To: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org
Cc: dmarx@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000444f9d06514f54ff"
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

--000000000000444f9d06514f54ff
Content-Type: text/plain; charset="UTF-8"

Recheck-request: github-robot

>

--000000000000444f9d06514f54ff
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div>Recheck-request: github-robot</div><div class="gmail_quote"><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir="ltr">
</div>
</blockquote></div></div>
</div>

--000000000000444f9d06514f54ff--
