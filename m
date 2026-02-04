Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4BE8B38C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 02:59:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215D14027F;
	Wed,  4 Feb 2026 03:59:28 +0100 (CET)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) by mails.dpdk.org (Postfix) with ESMTP id B2F6F4021E
 for <dev@dpdk.org>; Wed,  4 Feb 2026 03:59:26 +0100 (CET)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-948c440992eso809296241.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 18:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770173966; cv=none;
 d=google.com; s=arc-20240605;
 b=eej4gc5YYGZ4iy6kxLoluAmKmlOh625IfeTQmYNTQefara40iUPsSREkNsSXwsxQuq
 LZfnJKBC4V8bZZncxFYWYdtIFbkAHmSh27PizDhHTbd2uiEVo0R9CIjlHQGJpBBISTGF
 mM10Uok/mmKctbMqBusHWMH7a3PkvJEZ4RGW2jfyMlTd8Upz+RYqqwuVHPnbEwiKF/Px
 8zZZfNEKzgiVtJdr8DEmPIMLyUpMil47E5+XzGjawvqbTZWBWiSrxQUoDpbz/qJVIoWI
 Gtt+DbkMR91GQ68dG8MSJPOLnBVQBMS8GsH2yeBHfm3XkPQ/G15c+zpKAWBmM81lQg59
 j6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ldo5QZsBY4omfJ3VGLnqbnIzPH3qkUP5ZWdyQdfLsLg=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=YOSae9j2QUfXFovCZr2jOzoubfpRRHeYv9DMpaKJY/bn7thylLD58mDoXGTzVxAylg
 e+U9SFH97I+gIVoI/fDJYiwmzvhMCs36nOg6N3s0U2pkRwW3G3eABQsd8OCLj4gfzpcm
 wP30Li+NQqvb4wKmryJalUwbtOCN7m7QDr1Gt+HwqjQFaBXfYMyell/Y5fdgX4TaCNdM
 ZvXqdRSFWYgqxwDcYObE/x/Spz2C5EglZuXsO4U7rMV9HG5+GCEnFjipRXdIRQXg5u8o
 EZQZ1weznfgWWyawlSnL/dE6vHF5v0Tm6On0qYjEeZ9ie5SsCa1uQ2S4hqASFpGn+KLN
 A8PQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770173966; x=1770778766; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ldo5QZsBY4omfJ3VGLnqbnIzPH3qkUP5ZWdyQdfLsLg=;
 b=hAIWd24ZTRnvXR/KGAqzS96+xlmgW8fXyn47upTi8VcoVpj7Fd54PqRqKS7wNYr39r
 iS27C5B8xn7ZFqJ6TpW2YvDO3idv6u8NL+83IllqiV2uURNPkWXBwA73lYnHnhVzYauN
 ch6uKaDg0a76Ctqz8b31qC1w/JGVfdLlOqruz+tkM6cJ6hItr7R37WwnNjOLSC0jV9yR
 H8t4xW5WQgxtzdGCetBEYDeq8XYG+HP6ibmQ/df0QBIUBmzbk8yFL/4joyYB3ccnfMg3
 Rd7CDiwoQ2LnK5Pq2be71E38R8+jVwWGpt+fHlBepMzyaPM9dk5hHa0EkjTH+92hX7gL
 ivNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770173966; x=1770778766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ldo5QZsBY4omfJ3VGLnqbnIzPH3qkUP5ZWdyQdfLsLg=;
 b=mlWa1QZlboCFQ/ptgoqJzCNfrw7pDLyexkkj07W2g8YKoC7StyB5Tp6E0ifd4BFRuk
 axdMwZ9BJOXzU59FwL3fapWr4VsXXXlb2bT7/QVVh80h6CJU/1BE4GqqKljXI3YhRL1i
 s0uAN0AhEvR+TTu8YPGmXjjDY323w6G7gsYCZZxBAxZKRTz9z5iSmF02jU/Adbv2WmT/
 1lmIW+Cw33UZ5TN8qkt+1UlCvoV3RktXoRN+hVspGsr7WESGFbsi0isM1nn91N5oEMO1
 /KoHNriAZUQ69rKk7lyN95apgvAE/Lg6/EAedE+0q8ECoidzKy4j90Qeyl2W68pWD7Iv
 Vp4Q==
X-Gm-Message-State: AOJu0YwwD2rbIHT/lICjUa+rU/6GsaoH9LjUkqhFPEgCfJ0WKpfPLxf2
 sgYFJ0QZDpzM9Ho23FWI+u2UEO6Ckx3Mmzj/83zQCypnwLjEg+Wq4FMDSjICc5N2J0KTRqTSSEc
 SS6724TFy7pIBFlHamrjxBlU/EcN2V2OR7w==
X-Gm-Gg: AZuq6aJKoyFDCPZM9fJNWBgk/zQWBO5WJ5rMwhulqsM5Dnz0Rrjkw3GETUnRwrQS7h0
 OvvPnhveYSZ7BndaloOziOX3Kh/6Q9Nu6QiYJhGtbgwWv731FBXxdVY9cZ4gLDzGIHGaPqpK6+J
 S1ZWyuv+zhPguLc8c5TlxAU65P3CutzkrAEZC8sqN9P7KlryPwJgHf6xEdP1F96pJMIjbwmTpoY
 zrc8LCR7wnKr3qzHFMZEdQezrQb/Upp36T+D+yavhsI/0uq4CKVK3CT37qjQETfFGTM7ITx27XQ
 6pGCNDVjVl81+x8L8O3mJt7OJ0UKWcHONcZNFN+u
X-Received: by 2002:a05:6102:358f:b0:5f1:c9b3:9fa5 with SMTP id
 ada2fe7eead31-5f939466637mr458919137.8.1770173965824; Tue, 03 Feb 2026
 18:59:25 -0800 (PST)
MIME-Version: 1.0
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
 <CAFn2buBHCKj52h0k3ApW_5jG5BK7PUYu2Agmqs0576mUZ_+yXw@mail.gmail.com>
 <20260203061214.770b5f00@phoenix.local>
In-Reply-To: <20260203061214.770b5f00@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 18:59:15 -0800
X-Gm-Features: AZwV_QjRbxfgLJWqH6TLQy4QedTyxLEeNM8uLWBA-YQvcVos-_ES-SsXNb_tEqw
Message-ID: <CAFn2buC+s-v=GB1urhaE5gBjy=JVneDY79Zzd23Zrho9rR-FGA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> CI system doesn't know what Depends-on is yet.

Thanks for confirming.

Should I wait for the depends-on patch to be merged before posting
updates to this series?

If I have other not-yet-submitted patches for af_packet, should I wait
for this series to be merged? I'd like to post them in parallel to get
early feedback and I can rebase as depends-on patches are merged.
