Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFDE7DEF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 15:52:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA320402D8;
	Mon,  2 Feb 2026 16:52:00 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 38FC24026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 16:51:59 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-658381b28e8so6454485a12.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 07:51:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770047518; cv=none;
 d=google.com; s=arc-20240605;
 b=f40x69uj3gCh9/IKpGgeaVRrLoSZ/NYJh4mvnmO7j9aEiMC6R/gWPlIEW+xAbyLi3c
 qWoNPlXH+FtOtItgSpTVAXMfgwtYmBdkh+r7opYjcAKzCZXXaXeC7bq4VyFsPR5XtrDo
 UMHgDKNfnUKw0YeQn8a01kCBlnPDID5gpuD+p7VVO6swsBXwuWXMIz8BH0V6m/9N7rzm
 erqFCGUJtIUa8I9M5LRoveffeWHzYqhAQomG9Z+jIraIJwt9z7OvxX0CvsxeQVYXTzO3
 R8/OeXh5OGnsd0/AGz5hNZdIThMv8Mj1x6xFjFcrX/Ko0mo+pjYPkNdIqQp9jWm9WKEf
 2PPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4EwvW4xGwrxPqeQx5TholScFAySQFdI/7y2ZEo+eJ6U=;
 fh=rTn2UC6z3wUuQcQdr4kb4tkQrhU6yFssxceokaAIb9Y=;
 b=LSEWZnk2yXFfyPn3QNZ6RWpho7R3OAOU/zv6s9svekdEKYnN9yVFR+lCwpGx6HV/io
 HLsUl4egCcdGVsEr5AfIorxi4H6yX1IRa0c9UiG4C35ST+VsWqcLpy5QoVfDENAyv84/
 bQKbWI3jPcPPNoHZP142+/bMyB925BiyoORxabEDFmEk/BjSG3EllKedvTFAI32omnOa
 DzUBP0Frg1FWDfAPGnj5PlFP4BRbWx0SAdRxrLZ4NmluVCAZp+4Id2MxCyakRBP5HxSf
 B+34oJbqpThskV4FRyW2Oa225RkKfW71kWNoFPZFG4kSIX7Lxpa2LtF/dYsY/dsrI6zi
 oYNg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770047518; x=1770652318; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4EwvW4xGwrxPqeQx5TholScFAySQFdI/7y2ZEo+eJ6U=;
 b=VFukmQ9I+yEKEOhzt7MGzBzq+/uj2Vz9fBqmyARDqtTiCqig8sCSXYZHFgjlDGyNMp
 0IiH6e1FqoPF/+X5Qkg4oMf/rsxJ9xoTkpd4MNavbQjSIE3mK3dIBnQoyUGGh5dvVZ7k
 nZrRww7oXsAp5ohf1EZOw2YWqRb0CUkAL2cEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770047518; x=1770652318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EwvW4xGwrxPqeQx5TholScFAySQFdI/7y2ZEo+eJ6U=;
 b=EO+bP0dHsmD/OR1Ep3TtMtnHPIlRyRc3J9k0T6Qu5pCiPtnxmVvBwyo20scjYz3ovy
 kYp5V0HURsBxWt0nus585Ej6WhSIZLH6BEkiWum3PVgs3AT5Of7aKLK7GeSJQhKbY0/o
 Xr0o9BqkVi5C0gpSrzfH7554W2t/EyWhuwR/Gptw96qv5pqodH7ujRsIuY1YWXmUdheb
 1zSJirKwqQbnshI+uxwd+xA46/Wu/AajwvjfPFeXyiNctYM4fCa6tVlRhNLnSGV6EgeW
 2Fjn2hhVCT+ySEDfTBBb6LMUw8mFRtBlCfZjavRs9MDu3XQk8gkNhQL07numMm0vM+hQ
 sCDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPoj4oSxpe9wUMoGkGiBIVvrbCoPI97WnAIKFRzP11iKb5DSi8LfRaPzs+puibHPJXFnA=@dpdk.org
X-Gm-Message-State: AOJu0YxZ/vNq2z0fEQmWXkXkJ3IVsQECIRDUvETiANhThB9hvSBWo4YZ
 1ouhADp4ZhwETP3HjY2gC2BZbXRAx67IN04zvTP0OWra77Bt/R5VMvhQb4usKhY37thqmKjZctO
 n/75rIcvtlEho6OJxiotcy9fHZnZMDxesCKesO16ysQ==
X-Gm-Gg: AZuq6aIDDlxZtRpSGw8oCeAxHP6e5pZ2q7LPPWoCvDVaOfc7Zk6V1hTURmwSJ4fh9Qg
 80RyE5pouWrRDKhO73Iz7Sz/torrL96wYC/HI79/mk03MEGfjz3jqlrqZtHNH5qcQbhJ9E3oGqC
 anXI6M1YTPf7HouMbMU5MDTRkbBbQaErbuDLVCHbzVif5y88msmpQz7a7KY7gEvcqN0NkHi0F5V
 dPeWTasu4PSriRG/7SAP0yux1fAnH4EzLOu0ana72FVv44Q0LKJBlPAADwQcX8MUp03CqOLCW+Y
 9Y100RwLtJBt+AYaLqg9Wh8BjCwo
X-Received: by 2002:a05:6402:278c:b0:653:ea2a:252f with SMTP id
 4fb4d7f45d1cf-658de55ab42mr7533053a12.6.1770047518311; Mon, 02 Feb 2026
 07:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-4-abailey@iol.unh.edu>
 <CABD7UXOj5zDHc8e8L+7qCxjAL1zEun4hRPvbuOdnRTKGTfbCgw@mail.gmail.com>
In-Reply-To: <CABD7UXOj5zDHc8e8L+7qCxjAL1zEun4hRPvbuOdnRTKGTfbCgw@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 2 Feb 2026 10:51:47 -0500
X-Gm-Features: AZwV_QjEmkFD6pBwnfXSIu7P-SLFT3ZO3whfR7m6DvnWUaSguPDwAQ5N0wX0dWc
Message-ID: <CABJ3N2WrFwNsB3DraFX9DkDFjCyer5E-aXOH-RccGjJO-+onfw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] dts: add cryptodev throughput test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
Content-Type: multipart/alternative; boundary="0000000000009094a10649d94dd0"
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

--0000000000009094a10649d94dd0
Content-Type: text/plain; charset="UTF-8"

Hi dean,

Thank you for the review. The current implementation does draw values from
tests_config.yaml file, and the config class is how those values are drawn
from the config into the test suite.
I realize this may be confusing as I had failed to update the
tests_config.example in this version. This will be updated with my v2,
thank you for pointing this out.


> Would it be worth creating a separate cryptodev config file in the
> configurations directory, or adding a cryptodev section to the
> tests_config.yaml file (similar to the single_core_forward_perf
> suite)? I feel like this would be more consistent with the current
> design of DTS, although if there's a good reason for the config class
> being in the suite then disregard this.
>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
>

--0000000000009094a10649d94dd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi dean,=C2=A0<br><br>Thank you for the r=
eview. The current implementation does draw values from tests_config.yaml f=
ile, and the config class is how those values are drawn from the config int=
o the test suite.<br>I realize this may be confusing as I had failed to upd=
ate the tests_config.example in this version. This will be updated with my =
v2, thank you for pointing this out.<br><br></div><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
Would it be worth creating a separate cryptodev config file in the<br>
configurations directory, or adding a cryptodev section to the<br>
tests_config.yaml file (similar to the single_core_forward_perf<br>
suite)? I feel like this would be more consistent with the current<br>
design of DTS, although if there&#39;s a good reason for the config class<b=
r>
being in the suite then disregard this.<br>
<br>
Reviewed-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_=
blank">dmarx@iol.unh.edu</a>&gt;<br>
</blockquote></div></div>

--0000000000009094a10649d94dd0--
