Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 20:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A91B402F0;
	Thu, 10 Jul 2025 22:11:54 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id BA3FC4028C
 for <dev@dpdk.org>; Thu, 10 Jul 2025 22:11:53 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-716ee8947cdso15672587b3.0
 for <dev@dpdk.org>; Thu, 10 Jul 2025 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752178313; x=1752783113; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLNRlt5JC4mnWCZTGquu6jfh4BC/OB0ihr+z2o3y+cQ=;
 b=J1rakTmGmGrEVjowTQTtKKFjKXewjQGxV2ZAOKM69hx/F3jcxOJPHWvBK/yDBpGm21
 jQ+4nlxbuU/6amhvdGzRdku0QmB80kWTPBPLd8Ow9xx4NQmI8ojAkCvQXoL8GqFjDdjl
 LdwQwOR9woMoBC2ia/v7XS/XakAsR/mfmtFrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752178313; x=1752783113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLNRlt5JC4mnWCZTGquu6jfh4BC/OB0ihr+z2o3y+cQ=;
 b=oi3iaZhe29d/0FTAYqc1f4H0wkBeETuRS/nFqjJWMfY4Vx7KHigIGkk1hJ3Elppxsg
 yBL3VUGYnjepH6tbjk6rBZLzPJd4JnpVAAuOsucoudtO1SLeazuHD7XcqjquTXqSZyPV
 Vh5aUMi7fL+XB1LpJY7y9pquUK9EZoMDgWxaC5bqVoqOZwaRcp2fXJ4AEe+uPfcwGrKI
 cKLexN7PSDR38TdNGp5enJ42ixGiDNmlHciz/Y65O5PZJQIpD/Rhufht/YtCRPzb13y2
 r6+Udx0NlwvpNDPDnMsDzgQmV2L7GotBa7FnPFemolo1wf0FwQbTRAYALi0qZqQYxmKS
 qenw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRmhe+zJ5WUhScbXtfzJi4RvV5gLWAPvPvNmjuF/3smX7VUbu3B9Uytf0Vk5qbWMOlv2k=@dpdk.org
X-Gm-Message-State: AOJu0YzpxfNdgRDO6A0BQ4Ye04KOtl55cB3xy9g8ojot1s49YSd+jHNf
 ZYBniGqSmNZ/I9yepYaUM4qkSu9ZMxudVRQuT4AHzrI/3s3ImdiOIQBMfJ6DLfkSp5AWH2AX1/B
 1MTnOl8BNLzoTZtHQjG9DouqN0Tv0cE8vVx0JZJKc5A==
X-Gm-Gg: ASbGncu/7iuJ7Mai1zpvL1GN1cKjp7GfpCD0Mbubh3eaGsjdak1uPFzSj7aN5lgHdSv
 qCwB45k12FqQIC+HN0RLI+vLO5ZD13QMZPmRY/9UT97b6mVB9+6MWwCRwlbJS1EiEzGhvaEJ2t3
 Hm541/rusO8O7KKKrlFVE+U+2DCpola3U50HFarSzNFsNXdwPrqrwqalDYNIcN3a1vMg20DMdFY
 YVx1ixWsVfuhrBrlskswmg=
X-Google-Smtp-Source: AGHT+IFtXxE0LHojY8NI4cL6JMni8oNtAdYTKBGl8cOsjWwN56xXTDOQyXJ9znFcTlEk1BB0bxGhZYzDRCZ5pGIj+z4=
X-Received: by 2002:a05:690c:f96:b0:716:59a6:2dc5 with SMTP id
 00721157ae682-717d5bc92damr18039567b3.15.1752178312771; Thu, 10 Jul 2025
 13:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
 <f7tzffp7rqw.fsf@redhat.com>
 <CAJvnSUBh+8--cnqXDtLChD+iK8s98g+t=Hi4x-HEa8iH6fpUiw@mail.gmail.com>
 <CAJvnSUDvPZJvqsiy2J4a-b2i0f-BukJiZt61s6PR55vDh99YzQ@mail.gmail.com>
In-Reply-To: <CAJvnSUDvPZJvqsiy2J4a-b2i0f-BukJiZt61s6PR55vDh99YzQ@mail.gmail.com>
From: Adam Hassick <ahassick@iol.unh.edu>
Date: Thu, 10 Jul 2025 16:11:41 -0400
X-Gm-Features: Ac12FXx9nszQfJ9NQTGmyj8OZwixr7lB2Xb-7Jxt_7wp6vO_CRJAv2Dy89GhS4o
Message-ID: <CAC-YWqh58peBbfAMV0TZ+i=dfsApCXKGgMfOV3LbvX-H4gtS-w@mail.gmail.com>
Subject: Re: Polling for patchseries in DPDK - the /series/ and /events/
 endpoints
To: Patrick Robb <probb@iol.unh.edu>
Cc: ci@dpdk.org, dev <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, 
 "Brandes, Shai" <shaibran@amazon.com>, zhoumin <zhoumin@loongson.cn>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 Aaron Conole <aconole@redhat.com>
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

Hi All,

It appears that there already is a filter for projects for events, but
the filter is configured to be hidden from the HTML view for some
reason. We don't need to make any code changes to enable this feature.
See here: https://github.com/getpatchwork/patchwork/blob/stable/3.2/patchwo=
rk/api/filters.py#L239

If you visit the following URL:
https://patchwork.dpdk.org/api/events/?category=3Dseries-created&project=3D=
CI
You can filter for series created events by project. This query
filters for series created events for the CI repo's project.

Adam

On Fri, May 30, 2025 at 12:07=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
> I went looking through recent series on patchwork and I think this is a g=
ood example of the timestamp condition: https://patchwork.dpdk.org/api/seri=
es/35145/. Looks like the original commits were made on April 18, then the =
newest version was submitted on May 5 but the series record retains the 4/1=
8 date.
>
> And I see that there is no project filter provided by the /events/ endpoi=
nt. https://patchwork.dpdk.org/api/events/
>
> Adam, would you agree the project filter for API requests is pretty low h=
anging fruit? Seems like a common sense improvement to me.
>
> On Tue, May 6, 2025 at 3:08=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:
>>
>> Thanks for the clarification regarding the datetimes. Yes let's clear up=
 any remaining questions offline at Prague. :)
