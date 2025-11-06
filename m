Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C03CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 17:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C6EC4021F;
	Thu,  6 Nov 2025 18:15:13 +0100 (CET)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTP id 075DF4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 18:15:12 +0100 (CET)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-787ab220b1cso19765177b3.0
 for <dev@dpdk.org>; Thu, 06 Nov 2025 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762449311; x=1763054111; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKAvd1p99aC0JpZCr4w3bt0N8NUNgEdI5vIHZ9V7z18=;
 b=Y00P0V+DJH7sfZOYdV9Aac3zcg+7GVDBiaMgW4Jpd/o6hXe/1K+fFplh1ZD+to0EQC
 p1G3yM1GhrTBeg7RxB4uOdzwZM+f+InK3Q4s3yeXhVYQxDIQdU8Icu7eGwZ6+5FHdNdB
 /fgE1Nltn25iNgreNeQTiJdbw1PgqUDFqs4fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762449311; x=1763054111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKAvd1p99aC0JpZCr4w3bt0N8NUNgEdI5vIHZ9V7z18=;
 b=VpUugeA5LoX54Kn3mQeGTdsxIOoCTLXzKWjDTLADTfsih426ZRu/xaEtEex1+d9UUN
 /UTIK3HR7NngrM6jqAnO3RxzNUBXOoQTMLDAaZmRy2bddjZqlmcVYRUtIr/3nCs7JEJ/
 kogt5zyN45AAC2PY6y4m+GbXndDEo4lYBcPm2fuxmMG/Smc/r5Lhc7ccO6De/5ambDVQ
 R6Y+Yyb3XqDfQ9wcva987YcbfO+gbxflFB1qjCZv5kfzeE5cVxGo5E2ZTirAB3Q3l8qL
 wPJgf1cTb4HSt/RfI6Y2rhr9/2KFYp1mVXjMcf3So+w8l+1QzAHXyaSt8R7SJO4hYyPk
 VUFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMVBo87sF9ckJ4ib3w95j+bNKWz57zve/plV5a+iDg6EIZVSOLlUC9mZtUjBmshqG0fGs=@dpdk.org
X-Gm-Message-State: AOJu0YwnU78vH6ZZYXh7h2oZKBDjJftXHzY6+VjKBXRHHe03XRWYEwP9
 vI1fhL6Id7hiUyDMjFRWo9TptxuvKSVaY1SJOuRaxrajK1ukmmDmyPY88QYuDbm2YZQbcdDA353
 +hmeZzKEzvjFMglq3KOcx9fkKEemzBSraYRy6yyNr1A==
X-Gm-Gg: ASbGncv3y+IcnGOQC567cXAJMB4/nmdI/M62I+Tz0AbubOatQYCP4Pc0gS+xrvP63oH
 a2KpIS7WsfWlXIvYscT/uVd/CD6xrXdEAOt1j+HEx9aDWAhzd11S3f0vyRSzWf1IEZi6eHNr5UC
 X6CKUd7fAjvjmKr3Z6J5nYe9tgRR4w4OiD3u4P5QRNmjwsT4iz2caSCQl6Ar1hvmz9v/D9mp5xu
 f2YA51FSz+Nv+GeqY7c58pxGQQJRBN6EzXG4+0AVbfswUmj5T1SLr16/HCCb9lWPEtKztw8rAU+
 IgEwn4tZKn0KIp/BSWg=
X-Google-Smtp-Source: AGHT+IGE2MVN7dgCyL3p90Bn4OsZEtG/KYhluj2ejQ/EGq8QPa/d5iRxbJhbGdwd8S5i70Rn1+9AmbdVpUQuedojJVs=
X-Received: by 2002:a05:690c:5512:10b0:786:8c88:69ed with SMTP id
 00721157ae682-787b14110aemr32752087b3.16.1762449311169; Thu, 06 Nov 2025
 09:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
 <20251105194925.1507334-1-probb@iol.unh.edu>
In-Reply-To: <20251105194925.1507334-1-probb@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 6 Nov 2025 12:14:59 -0500
X-Gm-Features: AWmQ_bmmLbbjZdgwdh2iAVWORVpf0VJN3I5hOxcEvwe35io4CHjPbLD7QcbfTMQ
Message-ID: <CABD7UXOSvFY65O7djZCH7K1C9jwxNNwAq6QJktS1FJDGS2yuaQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: testpmd link check on port start
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 abailey@iol.unh.edu
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

On Wed, Nov 5, 2025 at 2:50=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:
>
> When running our existing DTS testsuites on a new
> NIC we observed packets would not transmit from
> the traffic generator to the system under test
> even after DPDK testpmd and the NIC under test
> had indicated readiness. After investigation, we
> determined that the existing readiness check in DTS
> for testpmd start (checking that port is started)
> is insufficient, because on some systems the link
> will remain down for some measurable time, creating
> a race condition between the testpmd port's link
> coming up and the DTS execution reaching the packet
> transmission step. This change will ensure that
> testpmd start will block until the port is reporting
> that its link is up. In addition, the interval in
> between checking the link state has been reduced in
> order to speed up the execution.
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Tested-by: Patrick Robb <probb@iol.unh.edu>

<snip>
>              if "Link status: up" in port_info:
>                  break
> -            time.sleep(0.5)
> +            time.sleep(0.25)

What's the rationale for changing this, just wondering?

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
