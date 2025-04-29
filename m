Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20279C3ABA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 21:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11629406B8;
	Tue, 29 Apr 2025 23:33:57 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 370A940277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 23:33:55 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso8369777a12.2
 for <dev@dpdk.org>; Tue, 29 Apr 2025 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745962434; x=1746567234; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4zqBBdfqSk5lYwIxsVmk/ShSdygr5/U1/jENQBeYOjs=;
 b=HJil4PmN4JzpmQTlFAYdcedVvG6IpAA+yIe+blOGBxvuXWQpbGxbF0ltoERsutdb8Q
 y2tkcs+KAIofWh1YJQ+OmqyLYvHF90j8/A9SUy6HbnCO4dhnqKqp2Yenv58cfQIKVEoe
 WOI322uAj5gDR5v4BbEJeoBnUj5fE9uGvequg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745962434; x=1746567234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zqBBdfqSk5lYwIxsVmk/ShSdygr5/U1/jENQBeYOjs=;
 b=rJ3ilq32MAE1AqeDptg2dzzn+iGXPGzPiQnB2HTnas03f4YyFs75IBJsqnP60YvP6V
 4fGfc1scGcxd/kjERJYi0B3nzx8ZOa7vGyyGY8N13LFqTFzKQNHR0wcKZLZ5pWttziO1
 6B7C46IvRyvWZQN0tapfazU1wlEz95o+U+zC/vuHTgBDw5pB1MZoBdCvmCapST8RKiUR
 2LYLomelmKQs1lhO0AG7B1N1j0g9rpomsZ1JBYUEMAeF9/8qRP/AvF+tY7VE9tlkkgDL
 4WmaCThtGhnfu6gco6nKW4ZvcEgT5Jl9S1lcY06t51D1iqLRWljn8dzjzQbQ73nunhbf
 tJow==
X-Gm-Message-State: AOJu0YwDH59nqfac0iDd7nMUebdpH/V7tRDhfIdIR/Buw+fdNkLtexdQ
 4cW+X/UQEXwfZzt7xEQehamekG6JHC+75cVWElg5/0iAzA4xilnId3OYUnNxWRMilgExZYqrfT/
 fTvhghu0T7aZXGY7MD08RB+lSnDbbfRIouHNbTw==
X-Gm-Gg: ASbGncuzHInEhG+R2I+Y/padh5e0sII+iOwiTEG5TZmHuBv9EBqSob7Yfg6EA/B3h89
 QLWfOSA4caDNBAQ2K+T/M0yObPpeT55FL+F5jKNfuS72ZeweSCiv0Uxy4A1lnV5SIYUyNfqnic+
 +EFh4NchNylsJa1FegGUcFIfFzDgLXRKanAFLTImyKRZ3yv/8=
X-Google-Smtp-Source: AGHT+IFfCa+MArWx0uM+oAbWbaXYFAv2gEQ1o7l6AcrXr7EobxBg6NEjds6uXTyJilH1LU8ba+tjerrsrzwPa1zRLeY=
X-Received: by 2002:a17:90b:58ce:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-30a34467f4amr303131a91.27.1745962434430; Tue, 29 Apr 2025
 14:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250427112257.108544-1-mkashani@nvidia.com>
In-Reply-To: <20250427112257.108544-1-mkashani@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 29 Apr 2025 17:29:26 -0400
X-Gm-Features: ATxdqUEWkK-TJtJVTioAMPns5_AU-yb1EaawivuWqWYfXDDrdyEBZb-9EjZPzmg
Message-ID: <CAJvnSUAs9aENhPA+g0Vs6cRJZjrhbOBkUo3SErW8cf61KWS-Og@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/mlx5: non template - fix validation for GENEVE
 options
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b220c00633f18e1b"
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

--000000000000b220c00633f18e1b
Content-Type: text/plain; charset="UTF-8"

Hi, it looks like your patch was affected by an infrastructure issue at the
DPDK Community Lab and has a false failure test result on DPDK patchwork.
Issuing a retest to correct this:

Recheck-request: iol-intel-Functional

--000000000000b220c00633f18e1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, it looks=C2=A0like your patch was affected by an infra=
structure issue=C2=A0at the DPDK Community Lab and has a false failure test=
 result on DPDK patchwork. Issuing a retest to correct this:=C2=A0<br><br><=
div>Recheck-request:=C2=A0iol-intel-Functional</div></div>

--000000000000b220c00633f18e1b--
