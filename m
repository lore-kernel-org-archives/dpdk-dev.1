Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACFCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 21:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A03F4064E;
	Mon, 22 Sep 2025 23:46:55 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id BC2914042F
 for <dev@dpdk.org>; Mon, 22 Sep 2025 23:46:54 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so2444430a91.1
 for <dev@dpdk.org>; Mon, 22 Sep 2025 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758577614; x=1759182414; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wKA7/86kIl2kaOGS9G9opHcVQXRosFHtd7YbNC9VMt8=;
 b=J2DFG+VSH9zyWdfvzCcze14/ZCtIolV92VrPMIzkuqObZBAJCIhLsNn9gCcAARIP9T
 22oFf5MFe1PldtNqJYNLfaIrKX4pKqKUPoarCroGrk36dGpANlDcSmvspJbuC4CchwBa
 gVqwxzSFBnjAfI3PcOHB/XiKU+eOUuwiJb1e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758577614; x=1759182414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKA7/86kIl2kaOGS9G9opHcVQXRosFHtd7YbNC9VMt8=;
 b=UNInpJEZv10Mx+kLa3EzXy/buneqN+7FwyOWGB0tX4Ql6n9XZY8zDQkloVgzYxGsv9
 gMY49+zZM8t8lkRuDxevhIXf4nQ9HxCfDSaUZ5U1pCFWFE6WA3YnufW/uMXkmKZNgAGa
 p97AHvJx0PdiTVgVV/BrwoEhAp/jooqIJoJjd2FFfASPf7kv2NZ/JsX8ZuOPL6P0jPRK
 muqaAH0jAOMCsEV7/aYZiBCvdBheGxILTr4+GJ51II3aCvO5YoRlsQorEXM1IJY+E0On
 uKmEQ0PESc0V/gLoqYQr2V2pq5zoM1uWCfESlwYNEjqzS87dtNCXh+Mht11lSWXynoyb
 mxNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNh0M1zbjWL6+RdRHn/+mwKAwgxOYe0FTSocCL9YberXS6VgCPTAGSZ6egBkAelSGTeO8=@dpdk.org
X-Gm-Message-State: AOJu0YycUgeM1WXJCsC0YOvstMQ2U3IyQb3rztbuO769Y50jDLqtdyJ8
 BIin4OuVC1VF0xMDtvjt9K9GOt8G37UHZfKH/jBMMlbAOvYwMmD1Y/PbgOPIktDQAPN8IbhWyzz
 cZo6BBNS75vXad91CbHP2rjBf1O35mGf2xwZx1FDrXw==
X-Gm-Gg: ASbGncsEuFILwpgg99JdQ2Ek40oLm4Gtfd5eop1wnnXMounotAtTqyH43LyQaCSP9wZ
 wkGWZ/df1+ShuPAjO5xkNUKqKK94SzLQqNzKhRZfKcvNYIcLp3Zi74TnjEz+53rg/7m9AGUd/lv
 4LJVQ7bKEKuSdr/vyTzI+E7nIt0hEIqPlrE/O9nTlPwIodnBjJZWd6w5RgHFDEQMYUzA8bJVVdm
 KZpFuacFORE7Sxg91y4vgaIReum/QXJNkHYIZql
X-Google-Smtp-Source: AGHT+IFlpbdxG8Z0HEMdr3fbrdku2LsI7kqubHmDPM45G+kSq7EeaMHuO8plL7ebGAhffx6h5coq/aJwTCFXBEgtoLQ=
X-Received: by 2002:a17:90b:4ac5:b0:330:9fe7:b014 with SMTP id
 98e67ed59e1d1-332a95d03bcmr450218a91.31.1758577613927; Mon, 22 Sep 2025
 14:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250910194259.1027220-1-paul.szczepanek@arm.com>
 <20250910194259.1027220-2-paul.szczepanek@arm.com>
 <CABD7UXPXsa1Psrg4cSLk4u4befxJ4_T7or16KnG1+pcMiGkOuQ@mail.gmail.com>
In-Reply-To: <CABD7UXPXsa1Psrg4cSLk4u4befxJ4_T7or16KnG1+pcMiGkOuQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 22 Sep 2025 17:46:34 -0400
X-Gm-Features: AS18NWCpQECJxKkSmQg7vEOjULg6Iqq9tjyRGqbJT0nukJCwIC8mxr8zL4s6hcw
Message-ID: <CAJvnSUDYOQD5wdJPQbf8MOjqWrPQ5UOhJ9Nf0KnN_DN=EE_ucA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dts: update testsuite docs
To: Dean Marx <dmarx@iol.unh.edu>
Cc: Paul Szczepanek <paul.szczepanek@arm.com>, dev@dpdk.org, 
 Thomas Wilks <thomas.wilks@arm.com>, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000fd0789063f6ac1df"
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

--000000000000fd0789063f6ac1df
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks.

--000000000000fd0789063f6ac1df
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks.</div>

--000000000000fd0789063f6ac1df--
