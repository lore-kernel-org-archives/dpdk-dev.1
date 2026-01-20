Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DECA5FAD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0305240ED9;
	Tue, 20 Jan 2026 17:40:35 +0100 (CET)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47]) by mails.dpdk.org (Postfix) with ESMTP id AB46340E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:40:33 +0100 (CET)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-6446704997cso4775710d50.2
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927233; cv=none;
 d=google.com; s=arc-20240605;
 b=fi9w4sKhP2SeK1+12gqIakI5HaK3rjXAa2ayPNLd2bYmArsywyeG3/uLrZGYq9PC9N
 z4D0CjopJ2vbAqJe0aOu9Gsb79hd9qJVASohFAi+6vLOMMyBMxcaQGlD75HpH176FdEO
 5VDe4qkNtXL0E0lbErANEdJJuM6jYgjTg7BYAUXXTJYLlw8VNaBzy2K/lYpz0GHX8ruD
 64+1waI134Bc15mJaNFjZI0V2sTPg00ZX6X9BQfq7hU6jdl3pFj/fZIPgQ4+zQE2w/Ys
 hvEyyx+zuHPQgM/wJsMD9DjdTuBoKfgR2HT4acyNPsvUw3ve+zn8meX/baJpmpoiBhod
 emkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IgNe+sxMlfaQr6zlvEAlH0Lqz06wAPLUw4iJ0pl2jRA=;
 fh=XaAs2mHT30LNI11mN0t0DZwpA+BQtuO3YRtEFYhFIQo=;
 b=B0fjvQWpWmsVQzWqNzVR8mA2rZa1g5rPwoWfvB1fruWI9TZr6JI3iHQ/C2XxM2h3ao
 fXl1m182Pu9wWhVhJ+dKfEaBIAZ1ugXI9TrsUf5SCs1b2VefnawLCSyhJJIk32AGZSSQ
 vg/sgciU0TrQRqinzbjq6JOYv6wU5lUfYD9Ek6/5W40wwdnZuZbwkWuMm5P92ND44CSP
 +hiPLndkGaWALFO0u1pNEZr38x9Ve9cBpu6TsCk3jR7kw3Nut5AL7evQ/V+cW2ybzjg2
 OqShwa7Nq17e3Z9So4bsftqVL88m+z51ml5lJ8vtn5y3WVCsadP9qJZQjcNW9RVfSCCq
 N/NA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768927233; x=1769532033; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IgNe+sxMlfaQr6zlvEAlH0Lqz06wAPLUw4iJ0pl2jRA=;
 b=H9eP6euv2ZHTj0l5XuHUDGNkDjZsdBThCgIY78KC5xz/S6W3ua/NRl/T5mLmgpl7wC
 Q+U3+jnLeunqaraZUV5OQDEiYmz/AAJy2EqSYKgc+SuReDhps6gpcvl6NTTf3EyBsx9e
 hTSuuoRXaZDEvfyz83ICmfKQUfJeI7AtXZcso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927233; x=1769532033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgNe+sxMlfaQr6zlvEAlH0Lqz06wAPLUw4iJ0pl2jRA=;
 b=DoRQlzTvJ1EkDyJO1A0zJK4/Kl6mM6QkOa84zsuuHVvyhMA0v1Q06CElc/4wo3uytJ
 7wIcZUdU1i0AsH9pf+mNS7FMlh5A631mrroEQpJ7BcuflbRT1QWNijPvjYDBgTbbSSI0
 zaWumuMTf0aMOPnG/5vdurDV2hROblw79YqDYQEA6NLmDYaLDrChgeTqwOssGhqqQJmM
 C6t79Ocgh47B/QmN8QA4Sc99MkMDe/hclRD9ZZ8AHpcjsDwRoZ75ro6n+lSsIXlABdeq
 mtWqoO1Ofky3ohM1c6Hl0HaCqp+dWGA4yBJzmYYwYLqHkFnhL4lIgX2VFYAzTldBjXjU
 MP6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnR0Imq9JGlg9A9hjgJoYHn6bsX8K9AhLCizFKYgyozPK/HQus4zaXhgOcowtqSMn/CBI=@dpdk.org
X-Gm-Message-State: AOJu0Yyh5N9jP4uJlaRWDqxU8t77VxWddBLdf+M8PTI+b8P1SVOZfcF9
 i5qBd7yxIfdftixBcNbvWfoA9zROX7th8yc2W8V6IkCi5borVhVFwwU5BYP3PWW9LsGim9Azb0z
 a7mN7BBzNBk803zp0ZEbWYbAgtzngMSi7D47IO0abYg==
X-Gm-Gg: AZuq6aLllx99kN0HAd4seFq0VdU1wAr69CLJ9iQ6faO5HQO3z19kV0v8hZTZ3QncxCS
 tLjKfxtSdEmZd6ijUwR0/bNT93oXqgSe8abYZUTJKjNlArHCgZDNQ58ni6Q4OR4IVd3Ut0O/geV
 K1Fb4kJ/dJLiswjCxosbvghofuBA95hwTYMVtZfhN/wJulh/kfHsHGyuAw1u7aW5o2pKrsSFB4K
 ZAgDj6fccFE2XEbyNuMKi/W3JohJpZ1cio9L2ArCbtFSlK7ucjags3/hl4pwkONirINYeovGoZo
 BBthJc9Bbw==
X-Received: by 2002:a05:690c:c4fa:b0:787:ca6b:385e with SMTP id
 00721157ae682-7940a21c1e7mr16251387b3.39.1768927232905; Tue, 20 Jan 2026
 08:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
 <CAJFAV8w0kGw4Dxjr1xhuvhbcEK4WAw-G6Yy9iBQ1d5sKkQm-Qg@mail.gmail.com>
In-Reply-To: <CAJFAV8w0kGw4Dxjr1xhuvhbcEK4WAw-G6Yy9iBQ1d5sKkQm-Qg@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 20 Jan 2026 11:40:21 -0500
X-Gm-Features: AZwV_QhTf0coTVFf5KwWk7fNaT6hCBx5NvrhZo5SHwMh-yFTzi9yr-Q_NgjRtBE
Message-ID: <CABD7UXNBy0AkhuK-SN1C=BXXGq9Z--BM1Df8mNDkJjTrueJgpA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
To: David Marchand <david.marchand@redhat.com>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, sismis@dyna-nic.com
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

Hi David,

Thank you for pointing this out, Patrick and I will review
