Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18296C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 21:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6479A406B8;
	Tue, 29 Apr 2025 23:34:53 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE2940A6F
 for <dev@dpdk.org>; Tue, 29 Apr 2025 23:34:51 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b12b984e791so6294933a12.2
 for <dev@dpdk.org>; Tue, 29 Apr 2025 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745962491; x=1746567291; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+nnH6pqPG8yqyu9P0tyL6TZaBZFZMPvlykJcyU0GDcs=;
 b=Tz8wNN33y2adJo7pxpF1sn5xgD/WBj0zqwzMdX84Tg+Ow1bdmbrAiplhWmcIvGilks
 7WYe2yDbJ1gy+ef+iTCNfhQUvB8/XVtUg9i4KOwRHeXLQGRde0g/TqNhaUZRPRUNqAP0
 NPst7wEFulWw3jhLh7M4Bow8d+5fYMa1PiKnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745962491; x=1746567291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nnH6pqPG8yqyu9P0tyL6TZaBZFZMPvlykJcyU0GDcs=;
 b=IrXWqMq+c/ApgDqsG+pgbDyRBxzffXn+890GC0neqWWWCnVgIyM2XHnjo0t3BQWQxU
 3WIFClhHnCjTem8Rz9FnoYaMSsXhVAoaLkpCkse4ekyt7OOaqqhCiIL98K8x4ZrqNGQ7
 CM3Jz5353Bm1FrueGtVYzEbHS24s6+8UsEFi+oAZ8m7ZEiDk8BhCZU7hh6/4w/js4FRH
 gCvVV0VqsuBzfK+FEs1cK3LeySiqVfmUdsEWT5R1v9OA0/8i4NlbCOtI0NhNPSnkjo3W
 gwckwEXF+Fw4dxYZBAf6sqaZAiS0trsLFI4AUCIe63GEiAM9jLisQW4RxQacPM5THKSn
 2MqQ==
X-Gm-Message-State: AOJu0YyiThdVHjeKj47GWufbxIDys8yzrvGyi1U5o6rRdrPChSJwm/E7
 G/MOHOPM7uGU4splAJVoqCW0gTZg1ujDdrttygmbutZ3hdmKyUb0QKWvyLP6jqSlWstELWrtsoV
 tR9pRzStaURGCIL+wrTvTvvZFbYEtSsl+hYmsbg==
X-Gm-Gg: ASbGncva/38QvOH0UpazsuRoQJDT3yAzWjW9L50Qnp1G2RBVucVosQyJASBLb1epLpC
 BKWjiPjl48FaGmCMUmUzycavieI2JBb0BXgzZybSodFCstXWuT0XJD3WphoVq223FBIOBoEolvP
 yWaGXD4jg5SL8SE5sb6SP0FuDk8J2I45ZYBTdQXHkAAIsWiuE=
X-Google-Smtp-Source: AGHT+IHVUeUuZQJSsN+6hQwdUsl/kMU4JEJOZeKVRBCnMdvKcyL5ngSQkecLtsb353bDTq2VrcNvYaRw4Pe0NwbbZw8=
X-Received: by 2002:a17:90b:534e:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-30a332d60dbmr756319a91.6.1745962490743; Tue, 29 Apr 2025
 14:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250425194913.70742-1-dsosnowski@nvidia.com>
In-Reply-To: <20250425194913.70742-1-dsosnowski@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 29 Apr 2025 17:30:23 -0400
X-Gm-Features: ATxdqUGo5ZZEWT65RoiTi4NR3NLOmIyxXTDhAT13hqQmd66b6zVz6eqHivKHPi0
Message-ID: <CAJvnSUB5V9PNMFmVNMjLb0oGBZ2_Vmp8JTVU0hi5K=6C1MiiNQ@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000d6a980633f192ea"
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

--0000000000000d6a980633f192ea
Content-Type: text/plain; charset="UTF-8"

Hi, it looks like your patch was affected by an infrastructure issue at the
DPDK Community Lab and has a false failure test result on DPDK patchwork.
Issuing a retest to correct this:

Recheck-request: iol-intel-Functional

--0000000000000d6a980633f192ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, it looks=C2=A0like your patch was affected by an infra=
structure issue=C2=A0at the DPDK Community Lab and has a false failure test=
 result on DPDK patchwork. Issuing a retest to correct this:=C2=A0<br><br><=
div>Recheck-request:=C2=A0iol-intel-Functional</div></div>

--0000000000000d6a980633f192ea--
