Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22FC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 19:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BA9402DB;
	Wed, 30 Apr 2025 21:45:32 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8F265402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 21:45:30 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so2486255ad.2
 for <dev@dpdk.org>; Wed, 30 Apr 2025 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746042329;
 x=1746647129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKrDZpOmAIdCOYadq9Iz+6hOqG5FFhts5OmkYwUqcV8=;
 b=OzHQpnL0I6Nl5H5axa59QmmUsFQQWkZ6ZUIHhON+SJ1CnGahmMJnevGoqUa0gglaeo
 jMA0H4o6bBnDKSJOILikKAu7Xq00J7pkYPQZdAJfgZN3aWfXz0fQJtE0BAhwB+I5r2TM
 ccRoyiSlUGZJ6+N7UCfTSLTbwOQonOew2z95dc4REdTISIUYffIznf06Nw7BLCHJe0p/
 RlYlIx6TgAamJ8xe1MRzByRdXGuzjvEBnfFpOEm1Y/DXd4EhJWh1oZxPnophBz1WLiVH
 X/DJKik6ddcbg3jgfPEfrp0fF9N1C12mKpveIppiM/nRfsxnOurvQQqge+02Us4Cfvft
 4JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746042329; x=1746647129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKrDZpOmAIdCOYadq9Iz+6hOqG5FFhts5OmkYwUqcV8=;
 b=YSYJ/IrxbpjAXPc35iVruwakO9rRnGguOl8pGWvrKQ2jHQoZPpuPsv6MONK/KMoIP6
 HPSUg5TenhgJ4o8pp/6ISSuaxDn13HPZe+qE4SlQEQG+SDx+2XQvtzk9EC0DRJe+wvAK
 QGLL0hG9s81DFmBDxLudY+PGpI5aMtgOL2TSu5J9cGzuXe5lu7Gg1UJeDPOabh3WuunH
 C5jwpG3AyWZts+ZAAmoMfLbzs/HIaxa2WAPFrey9gVu6m7cf+mm1avfg3gpYyvRiWwUy
 9WbDJ8JRTz+c6OK+ZeQu0vJMjKhNh+LU+jcRuX+Z8XU+r7h5OHrKHR7kF1kW6xDxEzrt
 RdIQ==
X-Gm-Message-State: AOJu0Yy+c8ncKZbqHQdc74FxNNqF19oIaQYQi9lnI8wOBtpe24VHqFS8
 Ghk2XaGrpK+HJ9sUq32v5rnDnyZ5pHm86n5NoLYIVRMTAZLlojaM1WDpoFvSbO65V5ds0Xb8blQ
 w
X-Gm-Gg: ASbGncvsQF/+GWjUjRncNnCYDed3Vn6PbXeAV4fzLk1gK3ScaXja0Ah9PM10s1WST5E
 AB9xCdzfhV9C8ZzhfuhGz5LjQjdDdlxP0GgpS9oK72q+wHsWrH2eJvDQ8lBMPEcFwDX9DB8ar9O
 1iqLjyH4Xn1ePrK+eF7lkTPtdWjwFW53Tas3xIbZdpho4/GIItZm5Kf53QMpd47GjVQt6ZJBhtA
 D8Drh3DIVxwjBrGkpoxdZMsjHMIsNgfgfdRA1aJPLyl/yI4uJR8ZtN9K6ve3lsE4C3wzTYn0U1f
 Z3B81bdxUwcrQ3mHTGr8aADq5ENnVGi8s9eolS2wukc0SzZBi4f0zYFvCmxcpVa+imC/3GyWce2
 hyelWuJdDARf72EWN
X-Google-Smtp-Source: AGHT+IGyOccmpBM9sfC/KHMIXvPfrPWADIs08YSEbceCwVXSeT7qL4LjQiYFSbVZFC7j2fswdYc/jQ==
X-Received: by 2002:a17:902:f711:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-22df34aa149mr76117575ad.11.1746042329454; 
 Wed, 30 Apr 2025 12:45:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5102548sm126482625ad.168.2025.04.30.12.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 12:45:29 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:45:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: Thread priority for background tasks
Message-ID: <20250430124526.6184f79f@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC19@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC19@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 30 Apr 2025 20:40:52 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> There are only two thread priorities in the enum rte_thread_priority: Nor=
mal and Real-time Critical.
>=20
> I would like to poll ethdev counters, collect garbage and perform other j=
itter non-sensitive tasks in a control thread with lower priority than my o=
rdinary control threads, so it will be preempted by any work ready for my o=
rdinary control threads.
>=20
> Which DPDK API am I supposed to use to assign this below-normal priority =
to my "background" control thread?
>=20
> Or: Aren't we missing a priority like Linux' SCHED_BATCH?
>=20
>=20
> Med venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20

Short answer: if your application is running on Linux, only ever use Normal.
DPDK applications usually never sleep and this will starve the OS and cause=
 instability.

Long answer:
Realtime critical was added for Windows, which needs it and doesn't do the
same real RT behavior. Might work on FreeBSD, not sure how the scheduler wo=
rks.

On Linux, it is possible to use but only if the application is not a 100% p=
olling.
(i.e a real time application not a polling application).
It needs to regularly sleep to allow non-RT kernel threads to run, otherwis=
e things
like disk writes that are pending on that CPU may not happen, leading to fi=
lesystem
corruption. Or hangs.

Bottom line:
Real time critical means this needs to run for a short time now (i.e safety=
 switch).
RT does not mean this is more important overall, or needs to run faster.
