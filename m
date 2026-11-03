Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B9606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=IDOCkY1m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F154060F;
	Tue,  3 Nov 2026 19:47:30 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTPS id EA7F3400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:47:29 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-945ae2daa3eso342178585a.0
 for <dev@dpdk.org>; Tue, 03 Nov 2026 10:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793731649; cv=none;
 d=google.com; s=arc-20260327;
 b=Zd+Z53W8tQswjwVHddUAwrWHtKHeeeCH7dynVmuzvuyQNOBQ9jPX0tyPT71vS2XXbg
 qfmstOanTah2xutOt4h8bdO4wawGu8Us9DfGy2Ikpq2fAJBvlxFn4qe0seE638ZD+arD
 6u0RHHa6ZZucnyiTD8LeoMJ7GikmF4JB7plEFaxoHSd0LK2s23ILodgXbgKjjgw/O7kX
 fLql4vd/oY9tdSRzQ5yz4maI1CH3V33EodhiVQRaMrdOwF6GxF+4QY9wDvL/uXIS9+xL
 3Se8eBrcm2qOHG0slrZhS+Cv8r19+kzPKfmdYB+O41VUP1D4opyhG3ny51zONuQBih5s
 87EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fHO3btPOZtCI+GifAGvVF6DDtp4pMn8cIo9zL3OzSNg=;
 fh=ipdgZN6PkT7WCSPRMMvLQSvOZUAMrvYV9ZvxlOA+sTk=;
 b=JMvNtHPHRXpTKvf4U1VT3SGFdTEzKkeIfneYhN18RK0/gE5qTWPkQDRUtss3Gwn9if
 8eBJMx1OfZkjYC8O3t00PK4WRR8+fKGAZjlEoqBewtt/EeJQS8HB1+51JrbVdnRUWBIs
 XLTIgm8k6K3FQeXOFoxucvdFmB+wOqkKQHhpdOAPBqKwShTffSWUwFdDvSEbDx+xKG4Z
 d5syfxHDmlGeMtXu51CMQ+cTbamFmrY83x3CXbkaZH8IEkU6sdwbcL81Rd9fBbwjQE6N
 h96+EHDC5G9PlfSuglVi/oCmFlG/MoVkCi0ZxbC9L/D+JOzMr4SvpW7iV/qmX4zjFaBa
 y7ow==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793731649; x=1794336449; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fHO3btPOZtCI+GifAGvVF6DDtp4pMn8cIo9zL3OzSNg=;
 b=IDOCkY1mkVP/3VC6otwhzMgOSicyyDN+qcP72K7xpPvhHwHP0SFGaTViAWV6z+iYEl
 n6ffnv+HjrRaox92EHjlrhwnxLZQOjVqViES7PqGFvVOzne9kvWIS516a5GNbN89IqaT
 FdZrA77DcQ4GC3SG5lyqxlB92z8xp+1Lz5Tjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731649; x=1794336449;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fHO3btPOZtCI+GifAGvVF6DDtp4pMn8cIo9zL3OzSNg=;
 b=0vHBwcI9F4neArp3zXVpSfbsxd32Y/J4xla9bu1+gjaycUAjM0H8hg/3OJU24Wcz44
 ATKvrygN4Lfa0EUbgUXP33/iKa4s1X1/s6eypzyxoi0+5O7qos83XvXvwWJxkEuaXYfd
 Be0REDfrZpG9M6GfvmwmJirmfe7RshYwPWBAQ5y/SF4D4RgcntdLqZoiHhQkrE+eyx0K
 a6ww6gfjarw3qqEI/nlG+02ydvm/65W+QPwRpXcgHke3nGXeUYV53+8fdaptTQZPrQR1
 qhczmWEgOvpJ8uNiI9cOcbCpi9rtIH3tCZNtvY24rlwYkLeL6Sc4V7EJYyZa3mda2lJ8
 3Axg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrWu3NK1kLAX02qEv5RXiqiDJ6F6dLYK6M6XlJ+Cdrx6G0GSsA8L8dIEvjFlxmZbLK4bs=@dpdk.org
X-Gm-Message-State: APuU4Z/ApANrEE0JlHm0V7wsaIJ4jdDdJgkqxBUEaA3x6h/fuYuEudp7
 ILveXIspHpPsDkZgH7iAqCTMlkcrwTFcM03CN5/SIekBts4tCSfRd2VE1EyIpY6VRxjgrmLJqoz
 /Ey5GR5d3nLOsgws9TiE8mhWM4Zt9Er06x0qs1ZMNUw==
X-Gm-Gg: AYBFou0sjnxb1zYKjdaZF0RZJ6RNsUyVDNZ1G28pGQO0wEqayfDMEpZy/9eZanQ3VGL
 SY58GTMSTlZKsNPEXjtC4iAeGitW736Y2EPdfvKgNaXDsptcq0jrtV+5PrNqCJSm0S3IncMop8H
 V8cj7EzvRxN9+M2qC8mQGMQ4m1DgafdY5BFI/ur36MloSfdMk3tDiq/GoLTGfPBzczbx+L6NPnS
 3wYeP0ioojDJAr2EKsw81kLk5YIqlPVM/UquloksxZ2iIgH0hzPHzzdJPCVZFeSuJiVsQg0MwZP
 bBIenpe5GTZMPmwsPEX5asPI30UNlqHTekqkCo/Nn0vH4/iOJX5oZpzWKkb8Zezlfz/A66XxCmt
 jlEclHIJBqpVL0BQffooOQTEMLM8AMXDQIu1HvBYUMP946N3SCa/bbFMF5SbogSu9EjZja/Cg/a
 US94ZGfDoQw5Z9qv2x1fOleh49zfssJQkMrVdQL7sMQRFpjonzqSO1zcL2H51aJc08lPXFkgR0F
 Z6IZPQKrYdGA/ebuuxp1R3L5HMX
X-Received: by 2002:a05:620a:1a1e:b0:93b:fde4:4923 with SMTP id
 af79cd13be357-944217ce7c4mr2255510785a.63.1793731648811; Tue, 03 Nov 2026
 10:47:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
 <CAKYPG+wWtzvvNCaDfwQV8tGSb4bQ=A5zfA6=fXNXWx9kbsKYWg@mail.gmail.com>
 <42f34325-47cc-4685-b871-2fdcaa5ce2c0@arm.com>
In-Reply-To: <42f34325-47cc-4685-b871-2fdcaa5ce2c0@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 3 Nov 2026 13:46:52 -0500
X-Gm-Features: AclHuK-t92hyAzC612U_pwJQiaLyuNK1uE3XPJwK6TwDGgw0TSjQSIXXK0jqC40
Message-ID: <CAKYPG+x5EUwVoonsSw7zzPhjgWsu-T8TQ3x-hLYW9af97J1u6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: refactor cryptodev throughput test suite
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c00ab7065f63b163"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c00ab7065f63b163
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

Thanks for letting me know, I'll be sure to delete the entire quote next
time I send an email that doesn't reference a specific section. Thanks!

Thanks,
Koushik

--000000000000c00ab7065f63b163
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Hi Luca,<div><br></div><div>Thanks for letting me know, I&#39;ll be sure to delete the entire quote next time I send an email that doesn&#39;t reference a specific section. Thanks!<br><br>Thanks,</div><div>Koushik</div></div>

--000000000000c00ab7065f63b163--
