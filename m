Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E0C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 22:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A88EC40DD2;
	Thu,  6 Mar 2025 23:06:37 +0100 (CET)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9A2DB40DD1
 for <dev@dpdk.org>; Thu,  6 Mar 2025 23:06:36 +0100 (CET)
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so1026334276.3
 for <dev@dpdk.org>; Thu, 06 Mar 2025 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741298796; x=1741903596; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x2BAUAEYCNH65Wctv7qE1vFpRNk2zA7nHR7I963w/i0=;
 b=KjiwF47d1+t7mQma9JqnWdAPxooR3CLAejHfwfC7c5eUnbGrq5HQ/Gln9ucQ3+m0VP
 Nep1zcm6IsA9VwP0OEvTWJWZJtyS9g2HUWCSaBl10WyEsZe5jrPC5hBhVcoPkugm925Q
 uYPpZagUvmliAlUbk9TztHfJHBDH11A3VhivQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298796; x=1741903596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2BAUAEYCNH65Wctv7qE1vFpRNk2zA7nHR7I963w/i0=;
 b=t2K7PQZOi/QinU2kTwgXfyzHR8IBF2meAPWjeTvj0vV0RrhDJNv6F3iujmo3vXR37R
 EVX8evARZX+meKCv/VsTbNd90id4ZpuzzkRaeoAGafxzi7YLzl3BKZRHSxI/PnAlaR/V
 4EMqrvL1geSEKjxNiA10uMsWK2YWDTK2HIATPsoGpuTgBYx0pZN1BgIMT0KQjvHFOuh2
 2tHanSCyITFs37+a/WYNOWasfrdWEUDT+bqtYlShJKKORwDCdkMJzHHXd7OsSUPc3I7K
 RWTxpXfDjXc6aCvQZljzew+QOdks9b1WG+dBR+VgbSLVRR8JoJOwoNxraL6mm9H/k/a0
 BPQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH6xOViKtConlrC8idoqIHv4DARQv+ijjjeCekGxldHUogcGJGfNgfVWQDts+++saP6DU=@dpdk.org
X-Gm-Message-State: AOJu0Ywl3U4pNa/bdaPixB8y9vEypvsi1Hzd4W8WUbOtfjfHDDlWd3AO
 H/stVJ7Qb7YRhP6AmMNCwFmsSygVhrgan+SQ/FI7vPRoxx6j49QpqQCIvrpQMS5qXNMZHpixARg
 rMcrBsSkpKcwxI72IZk3zgKx9r3vIOEM/yJvY0Q==
X-Gm-Gg: ASbGncvHzpe4u2CKyWO9lvJQLC8cnwNd7otPe2GyFmwDZofgf2UPoDESdIXPhbDwH0S
 PAV7vHDHn3Uj7ncxRdqrXllrI33Ta/ZfSRyR1mioqqEHfFFmlZovXoi2NBX00vcdu7wFfaZNkNw
 KHC5q13Y6IIMoQI/NiVxkfurwpSkhXorBvH4qbEaZy+ldkBf+937iaJVLdn/0Q
X-Google-Smtp-Source: AGHT+IHXDh67nOaqqt7jR9GN/G17YGPLuwONUs+mgOKRNf8JocGOshQj9CRW87gVpFD0Sus0zs2FNUzZBpJhs3olp90=
X-Received: by 2002:a05:690c:c08:b0:6fb:47d8:79ba with SMTP id
 00721157ae682-6febf2f1e00mr17595597b3.16.1741298795880; Thu, 06 Mar 2025
 14:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJvnSUCwRgakHWimtK2hjsmF__RKkgRSc5wK-ZyJ6kSp04ddcg@mail.gmail.com>
In-Reply-To: <CAJvnSUCwRgakHWimtK2hjsmF__RKkgRSc5wK-ZyJ6kSp04ddcg@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 6 Mar 2025 17:06:25 -0500
X-Gm-Features: AQ5f1JrF-ID3X-meHTN53DxbfQ-WjFkLNOD-N050bHsbNdXJOFGMMqpoNi7yAG8
Message-ID: <CABD7UXOHriaajKFyuvYy5m6DunD=rEziKbW_124+nsojUTyYJA@mail.gmail.com>
Subject: Re: Ethertype and Rx/Tx offload suites - collaborate with Luca
To: Patrick Robb <probb@iol.unh.edu>
Cc: Nicholas Pratte <npratte@iol.unh.edu>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>, dev <dev@dpdk.org>
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

> rx/tx offload:
>
> 1.Dean has rebased this series but is running into a bug with the capability check test parser returning no flags. He confirmed from running the steps manually that the flags we expect are being reported by testpmd.
>
> 2. Dean please provide a summary to Luca so there is no double work.

Hi Luca,

Essentially what I ran into while trying to rebase the series was an
issue with the parser in the OffloadCapability class. The make_parser
function contains an argument called "find_multiple", which will match
all port/queue capabilities/configurations found in testpmd, rather
than just the first instance. This argument is set to True and runs
during test suite execution, but causes an error because one of the
variables sent to from_list() during the parser creation is not a list
of strings (like it's supposed to be) but instead the string "0". I
moved away from the series to work on some other items in the
meantime, but I was thinking it could be an issue with the regex that
is grabbing an extra string. In this instance, the command "show port
0 rx_offload configuration" is sent to testpmd, which prints something
like the following:

testpmd> show port 0 rx_offload configuration
Rx Offloading Configuration of port 0 :
  Port :
  Queue[ 0] :

If I had to guess, the "0" string is coming from the last line, but
again I never finished debugging so just an educated guess. If you run
into the same problem let me know.

Cheers
