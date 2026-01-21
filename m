Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F619C44502
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2F54026C;
	Wed, 21 Jan 2026 10:02:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E8CA6400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 10:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768986152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjWf6SzFjNlkIhpc2lhjQM2yT2d/dT5M6ifVpxHspqU=;
 b=bUrTK72RzaLMHxNrZOo3r1zuNPGWxGDT9BHGrFyA8ayp2lQykR2Z319w2kSf+qt1bevMMO
 btRCqiVg44vwdGFq9zRE17e0/z+qank+d4pp/G7vM0w2rOPD9AECrK5ypWPYWvgCwKVk6W
 4vUzosTqQwa4laOgGwohMIjg6e/L9+c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-qtraGPZ6N_y7_wWlbrgmww-1; Wed, 21 Jan 2026 04:02:30 -0500
X-MC-Unique: qtraGPZ6N_y7_wWlbrgmww-1
X-Mimecast-MFC-AGG-ID: qtraGPZ6N_y7_wWlbrgmww_1768986149
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-383140d385aso37779531fa.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 01:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768986149; x=1769590949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjWf6SzFjNlkIhpc2lhjQM2yT2d/dT5M6ifVpxHspqU=;
 b=fwFQBiyrMxlct4Rs1IOU+8T7wqWX9+IxZ1g7iVWidet0eJqXS2h4RGDpqczR070p2q
 NUKy1B48UZ/65cuUvCpXYmcoJg/8AZSdKqoJHy+RLdwqm+OIaczGNU3Dcb1OMKA9EiWT
 dN9BduNqvV1i3A0OZRERECJXbSnbdhfziACwgnMkZSohUHpzO4BkEPqTsB+cBA6Y7SIb
 A5tIWBx1zUgVys26V0XqL6+EsfRbswtJlCKTECKgH5f3u/W3pzGit5q7WR5QgR7nSVFy
 RazlCsST78UZr/YjsXdDSXKQR1PtWU7PKYhaj4Ce985b8L8DkgwIzd3wz0tE0S8nIjcZ
 +o5A==
X-Gm-Message-State: AOJu0Yz6pbZ/lsggq2+yGcPm0h7Vd9i7q1loikx3sRVJajY+Gscx4HcI
 mWdMcFS57F2OpulIxxFQhTrM9XWRb7rluwbFOQiL+FW1imOqsBkdmDtqu6Jf+rrthGl7zzvJay2
 lK599xDfBnZoeRsy/f1fiTdmdjRgEhxs4ILa1rUy7T02T2heilKC8tTNoq/WIkYNjVemVGALD50
 Ga3qSQCmr5xF6st+A0jp8=
X-Gm-Gg: AZuq6aLCLKyTJ7tJCwITWlagGxu0s6RVYvQ3ZwJj23jXJkoKY/6NOWJxeTGOy4t2gQr
 MfliJm1+m4HJWN1RzkyZL0PlMIsxNO89i3R35sHtiBrS6ejmJ5umSN/2ZVsdHwGXtoB46YjUPf/
 oa2QPIEsw7KznQfW0UX7sYaa69iqOyezKE/E1ojMEea8NqKG9/KQpYsKutbWu/BRd1M42H
X-Received: by 2002:a05:651c:18c6:b0:383:161e:af32 with SMTP id
 38308e7fff4ca-3838430e673mr55894651fa.35.1768986149064; 
 Wed, 21 Jan 2026 01:02:29 -0800 (PST)
X-Received: by 2002:a05:651c:18c6:b0:383:161e:af32 with SMTP id
 38308e7fff4ca-3838430e673mr55894571fa.35.1768986148537; Wed, 21 Jan 2026
 01:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20260120231638.194471-1-sismis@dyna-nic.com>
 <20260120231638.194471-2-sismis@dyna-nic.com>
In-Reply-To: <20260120231638.194471-2-sismis@dyna-nic.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 10:02:17 +0100
X-Gm-Features: AZwV_QiaPVrDsna2L-c4AR6VEle0x3888wR4r4mShk1EOirgKInA4lkNWSEtH6w
Message-ID: <CAJFAV8wPT5fTZaOVhMXLHHa0J66kBUaPJX6a-8+-d-hdvNcYiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dts: fix invalid f-string syntax in testpmd API
To: Lukas Sismis <sismis@dyna-nic.com>, Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D5uyLqhrzlXQPLYxt158uv3ufRhKUdk8kz-YdhRcZl4_1768986149
X-Mimecast-Originator: redhat.com
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

Hello Lukas and Luca,

On Wed, 21 Jan 2026 at 00:17, Lukas Sismis <sismis@dyna-nic.com> wrote:
>
> Fix f-string syntax errors where double quotes were nested inside
> f-strings that also use double quotes as delimiters.

This is backport material, since it affects 25.11.

Fixes: 9db52910a8aa ("dts: add mbuf fast free in testpmd shell")
Fixes: 554192dbe9e9 ("dts: add start Tx first method to testpmd
shell")
Fixes: cfd851f264d8 ("dts: add QinQ strip and VLAN extend to testpmd
shell")
Cc: stable@dpdk.org

>
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>

Tested-by: David Marchand <david.marchand@redhat.com>

Thanks, this fixes the warnings I noticed yesterday
(https://inbox.dpdk.org/dev/CAJvnSUDdXrq+=KzXdMU_2oyPQwtHUbpbR6KhV3GOOThcd1G8DA@mail.gmail.com/T/#m28370a7a7dbced0a166da1b364cec0fa8385c24b).

Unless someone has comments, I can merge this patch directly in main
(adjusting .mailmap at the same time).
Luca, wdyt?


-- 
David Marchand

