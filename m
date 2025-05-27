Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02059C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 10:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E643C402B9;
	Tue, 27 May 2025 12:31:35 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id E916840144
 for <dev@dpdk.org>; Tue, 27 May 2025 12:31:33 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c9376c4bddso332041985a.3
 for <dev@dpdk.org>; Tue, 27 May 2025 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748341893; x=1748946693; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfHGmBRur2BT0r1mTlBFVq9eYYJHvyyppatwBGIkZK8=;
 b=nDWh02aJ7w+r9ldb3GuB4NotS1iwtsqVPTLv4eq8csXU8EoAeVqek7iLnW5PC0RGS4
 O0WiZcEVfE6bDSBBymPDxD37G8t/36uJ9AH1PjdGehaKhm+oMaSgMLlxQEyMxbqxU0ki
 5PorKAiBQMoRhhs3RarTSMp3ggvfWZ1oArGtXcrcwKndd+g+Snm3qLfTUpRPJcnceA7b
 Gv8RyEq/CSqZAs+q0J/U2GLUmL18HPSfGyy54DTFp5Kr8wGzPJzNjpFlbXvrpsjzAN+3
 1ooCXo39cOCrIhNuWXzi5aDkaiGmZxbnVMMdZgcQD0iwkF44LmyGvBXtK0GMekI49SfD
 Ykhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748341893; x=1748946693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfHGmBRur2BT0r1mTlBFVq9eYYJHvyyppatwBGIkZK8=;
 b=PUvVt5T9TSnvLzxZFMiNQjznKDWgaY41vyDgIYAiOFkWIRNs/DwH1ldQ4wtQks6m5V
 7s4icWRJIU7P2bzjdPwQKDsuZAnyY6EHLjkqv7zy0gfTXBUnY7z3SRJU87niu5ael9fE
 E+2adNGTJWTa4d3+p9dUfvF6yroNhsXVUG5vKNoMrFKPMoP+CAlmc4lAUXTqmxf0NV24
 1wI34TxJAaOmWJUa0u6CjEQTh9ucG7kXaOY9lxmsEbMdYa+sV6PQa9XWRROUwcZ6dPsX
 Vx3SOUJxOD3bclcyIA/wmTGJKjBPTGBLq0aVtsiGy/29qlk3RXRN6wDkBFhdTLIyiKOO
 +Lhw==
X-Gm-Message-State: AOJu0YxBUrijVvFMlJjQzkWLm38QU9J9vk+xmAHCfWQZEbYe+737gFjf
 k5d2GxDRXtlYd9vCgCQEMYxqY5MJN2jRc72l4B4e8I7fUAKOFoiykxXNiKNRnvdLYnw0SFrYmWx
 4ak3Hwso+J3k7VuvAvam/D939b8UjtlA=
X-Gm-Gg: ASbGnctR8gU+1qqa9pBJMbB8nhgXmbYFPMGPVx8FWa7z+I3jfYcxEulAoyH/Lz+t3Q/
 /peqBgbgv9oIFKDota+Td5BqaSO5mJDDuUzP+98GbvqPo9tsUpRvz6n4edsksteTqog8+6E7CUh
 kgZ5aQu5oiX03Lyl9XPEucYvgTLHFxzgs=
X-Google-Smtp-Source: AGHT+IHDC6tycjJYxVf0BMxTcsTsTPgeG3n2HDMgItj3NoGHpm8KCSet/4/XhVitVs84LxI+/0JhB9Zfq5BZYPZevos=
X-Received: by 2002:a05:620a:1916:b0:7c7:aed7:907b with SMTP id
 af79cd13be357-7ceecc32828mr2256944385a.54.1748341893222; Tue, 27 May 2025
 03:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
 <20250523155347.1156891-6-rbhansali@marvell.com>
In-Reply-To: <20250523155347.1156891-6-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 27 May 2025 16:01:07 +0530
X-Gm-Features: AX0GCFvNDqNmS5E0gtZl0zCXnaenvUAXj8NTUZEaQ-jWXenOsh62STFGxt8N9rY
Message-ID: <CALBAE1M0wbtBJx6g8Mg3c8O=VP=tUw7PX6--1+WxSrLi3wSrqg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] net/cnxk: fix bufsize in lookup memory
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com
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

On Fri, May 23, 2025 at 9:25=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.c=
om> wrote:
>
> Update bufsize in lookup-mem by default to maintain
> data order.
>
> Fixes: b826d043c01f ("net/cnxk: store pool buffer size in lookup memory")
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
