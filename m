Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1561F44872
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B4EF4026C;
	Fri, 10 Apr 2026 16:33:04 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 90149400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:33:02 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so332804266b.1
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831582; cv=none;
 d=google.com; s=arc-20240605;
 b=KrpQphKW3gqg5Nd7QPGIDp+S+Xo98najEc461TzHQZo4IOkVw67l+yJUUHXMnz2d5J
 qbgEX4souwNX+invoOGmOCbr7tTlvwH+CP12CLPJ4lzgIiUVw0wxkuNENGm8rVgK47Mb
 miPaZSpkcuTWVPfm2qCnEm2o9dEIW1MbNhS20ciEQ832cQsevhbudTqm2kvgimd+NC/p
 EaQP5nbwsjGLBDstVUZukSH8q1HWtYpqrPbR/vhWoBm6IS2/rQ3Z3t/amYVbkqURIw/u
 elM56UBe4nxsVMWIq8B8+V8Y3gwBYX/cahQZcyL6zNj5K8Ziu0Yn8YQNSrGf190ulHAu
 9b4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tj1tM0NVwE453nitbneVMAo6mbpNDIgQdk67MWPc6TU=;
 fh=52L7fDMUwbOnuICi8WLVtxJFOcvT3+vZov9tofBOVeY=;
 b=gBJiL2ILdC1KLFSUN4/qE4tCDEsn1IH2rFigo9FffAqdtMhpbTOo8zXtmkoIhb7rT1
 pTtL1TGwnfl4iWTVfJr8BPgUnpM1MIrHYSFi5x7GBGAh9Dx64Ilb5SYbKRqL6qBtfEa9
 fFzmtMJXJVWYPawp74U+VJd5tDEslXEfknel8sXxYe7YBNxlANg2kQ28eP7eznubF8rz
 yTuLKABISxASDQshgYVeRUDKCk5Rz6rN4rbujYT+lq0CPo249s0Y+jWKFuUHWh3IkC7F
 iIkROuT4/8ZxOWQy9m4H6thXb0l/a8GfDhZ92hdVpccsK0TK2bYy52MxbXScHJMdRH3Q
 bGkQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775831582; x=1776436382; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tj1tM0NVwE453nitbneVMAo6mbpNDIgQdk67MWPc6TU=;
 b=jkrwmrhZIpJSyPkwTArf0MqgZXocasSBap4d0XhOIVHg3QqZKF3nNdNjS8lQaUqcmf
 bd/fU/PA6r4FN0Di3E1Mn1CuiiczD/ZAhjKOqt9RiPCdrC/XDsM9fgb4/aqwiEHbaMlN
 HD4T2m46TRSSDvYtbbAM5levXzNpzwHhX+nzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831582; x=1776436382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tj1tM0NVwE453nitbneVMAo6mbpNDIgQdk67MWPc6TU=;
 b=H++RhOZ+PtlGsegeivbjeZJyZfIlN6ME0wVUqF5kb4Pc2Hr3MmiX5SBmqvjEt8x93q
 /2inbS/xORKUs3y4XGOGKSb2W5zYjgxXeFazPsc+a2y8Ro1fwpx7nCeSHxXivixaNwd9
 VvrEN4I3fkP35ekJuZfAA9SH/mvpJxLMbtKFnW3j5yYiRY2wOvfgs/yy4D0VlRSdm/F0
 s8twfWo7vMLhgYMBp17Fb4AFKVnGCbaZhdlP1vI7zSFPKP1KCk3DVEqaSq0LKhN0cjME
 10MzfKPVozAQ3hgOBoBYQJRwkq7hnhb8jQZmesBDu/kO7eDanrG631ecL1DHBTrUO9/7
 YyAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkfdKfdBAYXozbw5ME6seOqwclMpKlBpVNlYopkxoe3I6YftRp3aHOY7HFa60bmvRgRRE=@dpdk.org
X-Gm-Message-State: AOJu0YwBsOeKFToo7DQ0fV6TjImL3942gpvaRrBSdDQSa+xWRRK/bBX7
 +PM5i4FXSSkmSa7DtYaB+8QIMw7lkivGfJJCW1eOt84X7kMbnbRwm0HcaUpnWdTIZjteVHXOp5d
 139v2GlC7jTMqQPafv/M0UXqPkHXKWGeiau1PWFpprA==
X-Gm-Gg: AeBDievowo78BqgXNDsUohTuZbmMUBqyqTXhqB8azI1herblHbWotmGypxD/dzeUpbF
 YdSI47G88eDImzk8GeWlO9c5mSZzIDrDN3HgMmQx+pu7tIgb6VgC5nOJNtFVraf79598jIyA5As
 iISNL05jU+xiBSRQp6fli6idO1UFEYfkYIY8X0adXLgS9g7rHNWJUGpnUn3+A9CNzpvUKfB+8re
 aPaN5bKuPdv4CEKAe1/PoT82ZcfRCywh3PoUw46EtsnoYUSdEe8BZQYCryaHwRAl7Q+5kqeNuTq
 F04H5zQ+gjclOffVNq6/ypaVyQ34svAo7Efg5KQf
X-Received: by 2002:a17:907:3e8a:b0:b9c:1a5:acb4 with SMTP id
 a640c23a62f3a-b9d72832198mr196526166b.45.1775831581827; Fri, 10 Apr 2026
 07:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260225182616.71972-1-abailey@iol.unh.edu>
 <20260312185330.226227-1-abailey@iol.unh.edu>
In-Reply-To: <20260312185330.226227-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:32:50 -0400
X-Gm-Features: AQROBzA6dSxPnZ4xQxY4AoNDH8xn5q2GolzRwS7jKr6r5LBVCKbspjnwu4O96Wg
Message-ID: <CABJ3N2W68R3A-osKBAUG0KOJLsy_zeWkVySK3eutZNUh6mzXUQ@mail.gmail.com>
Subject: Re: [PATCH v8] dts: port speed capabilities test suite to next DTS
To: probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009db17b064f1c029c"
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

--0000000000009db17b064f1c029c
Content-Type: text/plain; charset="UTF-8"

This is a simple update indicating the status of this patch.

This patch is in its final version, awaiting review to be merged.

--0000000000009db17b064f1c029c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is a simple update indicating the status of this patc=
h.<br><br>This patch is in its final version, awaiting=C2=A0review to be me=
rged.</div>

--0000000000009db17b064f1c029c--
