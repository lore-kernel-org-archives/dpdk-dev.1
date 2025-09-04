Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D2CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:52:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E241240697;
	Thu,  4 Sep 2025 13:52:24 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 95DF040280
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:52:23 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so812329b3a.0
 for <dev@dpdk.org>; Thu, 04 Sep 2025 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756986743; x=1757591543; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBVXqo1pQ8/iX7/UgFmyvxoMK+hANrIhRCSsPVH1B1s=;
 b=HxLQYA2GHlGnQn53UycE89VGnT25K/RFYRJha2VunngSjn4+ogzxWGoErMQzdizDKe
 gXAAOQTDjkU2/nkVoXL3Pzr1UPBb6zHvEzM3hPofIn6J3kCTZf92U1cRyxmPvXeCYaHH
 GjBQpRjTQAdG/BNcz37f78C8nlFzG/jKpkZ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756986743; x=1757591543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBVXqo1pQ8/iX7/UgFmyvxoMK+hANrIhRCSsPVH1B1s=;
 b=p3dNR4HmpRh1fZxNrG1pji2MYPleOuc9P05dwSHLe6uxTkfiJnhXMOtYixFgwkAdTO
 5xv2Wbr9CUMeYZDmSPtmwWnyBWhf+JrQNbuxq5M9Di3iCMdPicOsrb36Duiyigra/gOY
 fqddD9cTbibZGynxKgkpfKqs2YQZkZPmUdOQA8/nBV+1lU7tciD+mcs7xuxMtl4XHJv8
 A4FFQD7brS/EvENbzYa9GfvXlZLUA5KoUbTD51jQ1PtQUEkYsTsv6BjPZWGZa9Fiz+0o
 EVXnkFXIhp8joR9C7vsFvpxMU4174nFm2h7a59QJk42lN6XADMg3A3gCiprA6jaJr3gi
 /4MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAiD8xs3NZPTGvHS+Y/j0le/HLeZ0jTYoBpEaUDsSEWi+jWsFbcBHOGsY2bStq49HWkBk=@dpdk.org
X-Gm-Message-State: AOJu0YwKpPMYpdEjqJ0aB85+wVwai/oYLLPayMH3xC0u7U8b4/lEKvHZ
 CvfsgjHvd0vv/XFypvqhdaLVjxUcRaEUraoUByE8/BznDS1WDj6TgwNIZBbTZMfX2BWYZpLpCq1
 rDITpKo8PTEM2eecdYcpCFGzygCe9XcY+74pr0aKnsw==
X-Gm-Gg: ASbGncuc0VLSvLISHvFRNdLOXP1XPfArtxC1/lQTmZ/s0ILUnJO5Hn7irzDo0vfsxjG
 i/QF/GEant47QlsTvL6VP7n/LS0x0/snq3nxfjQ9g7PT6a5gp1rPFZotylbksPfuuPTnWMhZal3
 YoADO9LCk4Y7lvJlW2Q6Rg4P2GNuk80YO6ztXz2HkQi+GRifnzp1CxvZrBGR+iJUnCYyhBjhCm5
 ooby9h6wnWbTEXlQrpfkQ8LSuLbBTD4tlO3oz6mrjgWwlHiRDj/u0yG2Ygr
X-Google-Smtp-Source: AGHT+IHKS7Q+wzVvzIxE67n5KfITRBtvSXVyKIY9Eb/hb0YFgKZNa23TKtIeQZpCKMGcOHTRO73ThvpYUN4FQoRUQbA=
X-Received: by 2002:a17:902:d4cb:b0:249:3049:9748 with SMTP id
 d9443c01a7336-24944a98207mr237686655ad.35.1756986742659; Thu, 04 Sep 2025
 04:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250818165054.447127-1-abailey@iol.unh.edu>
 <20250820151850.484576-1-abailey@iol.unh.edu>
In-Reply-To: <20250820151850.484576-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 4 Sep 2025 07:45:35 -0400
X-Gm-Features: Ac12FXz-ecVJzcTxaDbj7ix66NUcD9WGeqDGmHK170Z_RYzvTvzSjUfxawcE6qU
Message-ID: <CAJvnSUCFvbPqbRqY2SfAByNDiA-W5epkZeR_7Mni=RQKJ_4=Cg@mail.gmail.com>
Subject: Re: [PATCH v4] dts: add missing type hints to method signatures
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000abfb8e063df85a61"
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

--000000000000abfb8e063df85a61
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applying to next-dts with Luca's suggested fixup.

--000000000000abfb8e063df85a61
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;<div><br></div><div>Applying to next-dts with Luca&#39;s suggested fixup.</div></div>

--000000000000abfb8e063df85a61--
