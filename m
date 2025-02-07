Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B6C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 808B4427C0;
	Fri,  7 Feb 2025 09:49:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DECB4427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738918192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMyoiL2/PJGyKcT1nTqZvPNUQAXAxOShkcd3VOsO2vM=;
 b=e9AJX99aGbARkCeaZcUbqhK/G6TvVFcFgpCTWWkfP9c301w5+k7tCBDcA7bQgcm+J5SMY0
 kP4gCMn8eh2Qe2CHrtlZ1AAuCYQsQOCMK0zWTtgQO0IiH/KxumYqY9fVIsTJyF7j0qNWFi
 1MuOJAr/y49Ia2jqXce9NnNmIbfcWUg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-uNdr-yOvOi2hCFToJaFArA-1; Fri, 07 Feb 2025 03:49:49 -0500
X-MC-Unique: uNdr-yOvOi2hCFToJaFArA-1
X-Mimecast-MFC-AGG-ID: uNdr-yOvOi2hCFToJaFArA
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5440b4eb6b6so1031845e87.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 00:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738918188; x=1739522988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMyoiL2/PJGyKcT1nTqZvPNUQAXAxOShkcd3VOsO2vM=;
 b=Cj5VVEOgkdhsalKtdVFTn5WPiirC7noNdY/NHSox07ZOXcT7gc5cisblOyEAP7yhWZ
 sF52OtyNGyHExxu46FFOG10fVtgsHpZQ0/hyqcLYloy0ZfOsNT/XUIj/A+TLm9/e3tWm
 B5QSveaul6ZonrUdeyrOCoKAertrohmmYwg3CDFPRlP/OBPxEmwBRTE6uhSOZpb37m7i
 AN1IzRKDaWwQLHdz0N/+0NZTiQpChFDG+VEzyaPXHvOnjQEojdcDmZpTVjnpOH1SRLkR
 Ok8Xv7s/lMXfRYIvGUx1CNK5u6BTEQwBlUbGu+9EQqtR/s6axDezVgi4BLP/47AaW5p0
 TUiA==
X-Gm-Message-State: AOJu0YzgNjbAbkHuGoskBmVq3AsTkoqO15LOd+3VWcYC+ZMp7f/NcsrC
 p3yHDyf4f/5RpU0RewWPt58tGQ2aiovhRDQTa6HvmEjWQAXaCRxHBxYBqM7eHeVHDzom7d1X1AG
 1M4OTvPunkjSVJYz8dUHo6EwKFSXt1MghXJd+uWMUKxbkOyIPp0cMqpzhw0loWtitqeTrKz4wI6
 3IBcBm3KHqbw2EHkc=
X-Gm-Gg: ASbGncvpuDIccdTqX/F3JkYC8dzYZdRE0Sj2Q8JFwhPKhFUIKIMDUfuvv8bQZUY2Z4o
 9i/QeDKJC4xB+MssvNqsVIhvwFt6ikAXeXysALEyi0NRPc3MFP2JLfvzs6/dRFG8s
X-Received: by 2002:ac2:58ea:0:b0:542:6f78:2ace with SMTP id
 2adb3069b0e04-54414ae6368mr537370e87.47.1738918187727; 
 Fri, 07 Feb 2025 00:49:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhrbqa3rqwSUeECLPLQu7V2S0CDAH4iWftOGL/Qt1yFZZzKUZNFEYEHjnt2AtuHg6wWcc6VFc0Ud7AcnmvsHE=
X-Received: by 2002:ac2:58ea:0:b0:542:6f78:2ace with SMTP id
 2adb3069b0e04-54414ae6368mr537357e87.47.1738918187357; Fri, 07 Feb 2025
 00:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
In-Reply-To: <20250130145849.82003-3-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 09:49:36 +0100
X-Gm-Features: AWEUYZm5VveiqlsWMRWJg5YCOSD7QZkMO9KjL0iKk0wOQGXbyvvgSTeFzofPUVM
Message-ID: <CAJFAV8yvVXqnK0mwngjroV-HgtnBpfG50co-3cMgq3AsPLnzgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] trace: fix undefined behavior in register
To: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Andre Muezerie <andremue@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pNaU6wDO957i3RcAtZcccsCWo027e7occftGQTwUurc_1738918188
X-Mimecast-Originator: redhat.com
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

Hello Jerin, Sunil,

On Thu, Jan 30, 2025 at 3:59=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> Registering a tracepoint handler was resulting so far in undefined
> behavior at runtime.
>
> The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler
> (which expects arguments) to a void (*)(void).
> At runtime, calling this handler while registering resulted in
> reading the current stack with no relation to this function prototype.
>
> Instead, declare an additional inline _register() handler for each
> tracepoint and make sure that the emitting macros in
> rte_trace_point_register.h only work on arguments name and type.
>
> The original tracepoint handler prototype is adjusted by adding a
> __rte_unused for each argument (since emitting macros do nothing
> with them).
> This last part introduces an implementation limit of 15 arguments.
>
> With this change in place, the workaround in dmadev tracepoints can be
> removed.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Can I have your opinion and review on this patch?

Thanks.


--=20
David Marchand

