Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F361D0D17C
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 23:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEBBE4028C;
	Thu,  8 Jan 2026 00:08:00 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 3CAEC40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 00:07:59 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-11dd2370722so4252037c88.1
 for <dev@dpdk.org>; Wed, 07 Jan 2026 15:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767827278; x=1768432078; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iPbRcU/2COPEy8Ee6n/D7q30Bejy+Mw/yDqAJTbFALM=;
 b=Cc6eKg5TFSvsnC2GFtlxzaacUaGt7l1tUnswIaAnQjxuqNlAqc+kM3W8wyRqM0WNFc
 Ea7g2laSOgjrN1OFWr+1ObJ9BnU5DtOv+/4NDl/4sOlEdXiINCPVkXBaSVrKvuT1gwLZ
 P3wp0++NAhzV2OXa9Q2Q0nV2amh787Al0gkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767827278; x=1768432078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPbRcU/2COPEy8Ee6n/D7q30Bejy+Mw/yDqAJTbFALM=;
 b=tskc5B23Nf0Q+GXEX2jhEnsyN6TyAjxpwRIkkXFnOuYzc8OACckeY8pPN0xENBb2RQ
 9x6UHBZtYx4/Yqc5hTOamJnqIajmW71k/+AN9kJbgqT+3mUAHn631fgXB+vy2zc4HlwX
 GqEhFQ3qsAtEh0Mo6IZ3tXymJj4QlMO2wq+0SKTe3Sss35Fkk3ChUKb8uDDa5VAYUJvm
 vKtFX9+ntkVgxBv4Zi5MCoIVHD+6E82W776sIIHVxqq9Rpy5BDYn2cGuBJP0Kmp5q1JC
 cUL5F1E1n6qy8VrbmcgyGphjMr8fg0R0k76bkdEcrziT1mLP3ur+EzFxq1h8I7Mpj7O0
 ecPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc69aYXhl6lqYeVG9gCpJgNWMtrxFn6dqnUj/iCDHtsJd6qht094uL2Gt7N8WL3jC9wDU=@dpdk.org
X-Gm-Message-State: AOJu0YwRIJ8czoDSGZuwjrRy7oJ9elrwGMcm+4LrJBzemVAygVO2BeAo
 PZI1nrde0B8Kv8M5P/nEoWvmISNShUFSZizMqWFocb6UUT7y6sce6Oyhan8GMTnORT3xVyYwOGq
 p9UuvsgwxDyVwMLZrnkUskOZzV43Uc9DI3oXZzoLsaw==
X-Gm-Gg: AY/fxX4V5htWAuRKhEpxp8gC9874sE6qfDvu0vjVZXmje11zWt1MbmoGbSGejcUc5Ys
 8/74TjQHg//QDfiK6oWn46ijUAEPqXV/VIS1GKmGHzhaPNpUmCLJDl+y4liRak69HRrvboL4Mxm
 LETIjuOLn+RTMpwTRcNU/W7Z8LqvZHkmkKHcEqI0Q3mhIQIQv1+0lNB3nrFxpsRcCNkmoZ6Rnpa
 7KQrSSQomUSNpzHwvHcK1JwRxQOtyoX/U6ETHGWZ0dv3OEr02HpxfPvx7kQnr7pPJpI7WKX97wB
 GutSmHaBW7byZy8kWOZ41O31REVc
X-Google-Smtp-Source: AGHT+IE97SVRGJ+bHprCcHoh8Z6tjAojLDS44gx8dryskKs+/6/koNGdX+QLHiO5aD/X/vil84BASbtvePIj5kuKwqM=
X-Received: by 2002:a05:7022:aa9:b0:11b:9386:7ecc with SMTP id
 a92af1059eb24-121f8b5f7a4mr3532114c88.41.1767827278323; Wed, 07 Jan 2026
 15:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
In-Reply-To: <20260105190647.63244-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 7 Jan 2026 18:05:54 -0500
X-Gm-Features: AQt7F2odstdp2ATP8XO0ZdaregJRDsiRLNfNLx-Ml3NvZAXgvWmxfqdzbTgPFDY
Message-ID: <CAJvnSUB+Pgm=9ndLEVEiQVKYxuWGksSno42HT2-eeX2Fqx0xfw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f2f29d0647d45c0a"
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

--000000000000f2f29d0647d45c0a
Content-Type: text/plain; charset="UTF-8"

Forgot to put my tag on the above reply

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000f2f29d0647d45c0a
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Forgot to put my tag on the above reply<div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--000000000000f2f29d0647d45c0a--
