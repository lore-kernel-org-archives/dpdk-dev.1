Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB26C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 20:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B27402EF;
	Tue, 11 Feb 2025 21:50:38 +0100 (CET)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6E4034027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 21:50:36 +0100 (CET)
Received: by mail-yb1-f175.google.com with SMTP id
 3f1490d57ef6-e5b4d615362so3933824276.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 12:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739307035; x=1739911835; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdyXR7Y+bpZJIu5IoKtmDyAeIbIT4LR3CZ7BmEg+cAU=;
 b=Y7twZUMtQdVRQ6hs+4VByaNMk4+1sed5N/LAPPnwwqnVFejqT8dx9EGb7u4GYcOvId
 Wyim2tRU24TTAgm/G+asqfF9ex9APgO6AtJ3xPBY0+Tu3ZWDEzqjTqAxnRmYXbwX7jsc
 shVGMIS+6yJ6TSBrOLkQmCrUrKhWsDsYuYifo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739307035; x=1739911835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdyXR7Y+bpZJIu5IoKtmDyAeIbIT4LR3CZ7BmEg+cAU=;
 b=REv5VPg4cDIMYdsO+j0Ba+wr5S/y2+v4zwbVUCr/BGvmbvxL5Q3DVFJiH+nGt2vE5P
 kqJ/91yS00PfJA3xEnfkAU2NSrXidtJUlgOmHRi5O89bfGWFZmR2ksfv0GMKfjDv2/EK
 zN1DJdiiGYn+jD5sQq2H7ytCEukVtS57Ib1tMur05SyHY/z9mSvKHhK6WC+sv460+SJU
 SjUd2j5gRE14Jl38Qb9yvuJ3d3/0lNRGVUwcqHkNRWOcm3YYyI30Cmgn/Sz7EsNf2Yd9
 Y+aZwilODd812iC70AyP/Nj6Y4VoIffQfY6ey7SkVtFVqDmN1fhUXG48QTFZDazGOjJh
 tVMA==
X-Gm-Message-State: AOJu0Yyvs8XFBWTilO/X2i6g2INkIdntNEF8aHedj3yg7Flbk2ulYhfP
 we9P0aemWxseFAvssPGU1V3Rhpd8rnSnh5PdLhZFeet76V7uddMMQHERWlIbOw1Rr5+LNgwXG/x
 1tV2rvGFPM7Uyi4dIBLT+aIoRofeISqn4PyDKJQ==
X-Gm-Gg: ASbGncsYbGysj1WC9c32P7MRxf/BamH6O2Fjmnz1pVlGIuqSUgKFt7wHJmBciNPyRMl
 4wwbPysXhsXYZMcGu75bOHKA+mHiXB6MoF93Tqaqz0UEzZBwZp0HPuObXxx7AZfQ4/aMcwbr5VM
 1fv4R0wdHiVZw4J2amvAtYdE2NKdmx/QE=
X-Google-Smtp-Source: AGHT+IFrxRwIYtaYuuHin2Mzk185DvXFa2Z6BfUgYA256OUfu1FImiMaB3kNP3O0fJFzAqrxYJjwqvIWjaEv6sD8OpM=
X-Received: by 2002:a05:6902:1409:b0:e5a:e8e8:b1c7 with SMTP id
 3f1490d57ef6-e5d9f0cfc7emr985893276.8.1739307035582; Tue, 11 Feb 2025
 12:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-8-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-8-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 15:50:24 -0500
X-Gm-Features: AWEUYZlQbN0UduWqXyS9YA7wE3oxi7vzEXYi0vwKW3GyeVkmPCtHgXpZMM_Nf5s
Message-ID: <CABD7UXNk=DVKeoV=UFQixnE9AF-ibqUuDtA7zvwXR=TzTY=sBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] dts: revamp runtime internals
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 3, 2025 at 10:18=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Enforce separation of concerns by letting test runs being isolated
> through a new TestRun class and respective module. This also means that
> any actions taken on the nodes must be handled exclusively by the test
> run. An example being the creation and destruction of the traffic
> generator. TestSuiteWithCases is now redundant as the configuration is
> able to provide all the details about the test run's own test suites.
> Any other runtime state which concerns the test runs, now belongs to
> their class.
>
> Finally, as the test run execution is isolated, all the runtime
> internals are held in the new class. Internals which have been
> completely reworked into a finite state machine (FSM), to simplify the
> use and understanding of the different execution states, while
> rendering the process of handling errors less repetitive and easier.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
