Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F9ACD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF7D9402C5;
	Mon,  8 Jun 2026 19:27:31 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 8733B4029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:27:30 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-5174a3a025aso47144531cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939650; cv=none;
 d=google.com; s=arc-20240605;
 b=a1i9AW3+qCMK3nT+qJm6PZKriHfpGVMR11z0XaGEcg1tbzmG56+5lBOYN8O54uiNUF
 b8Xv9hBzFpmfkJAAHiVGvAj1OhcoRU7WAbkvVI68M9hV4jTI1j80fR2LemQ/HShkcyze
 ZhS5HNRS1B1FdHsbl1V3eN8fLulEIIhy17Q4UWoGrHSdVv2O+sbhihCSikzP6zgUAMVS
 yl4NFkcRqzVwOXo9rdNaCqliWg0HdxjUnEvyTLMr9YG8IlThB8BADz0E553+cr6rkU5v
 vpoMMhbhEVyS6fH4AQFyc/GeyClFDoaAZFpf4+2aqPnFmw1s9mS6ko3sPEoxkofahhye
 BA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZntXv6MDjo6MKmNrCOedfIg8+pfiuUqkbL5Jnd3IOPs=;
 fh=Rwlt9IST8x0DaeDCQcGvx79HrdOdPJAYSRxD73+kkeI=;
 b=eReldaQ6GTx2IBofjD4NnbuVRhf3aO1FG8XchSEKqR4jLlWstDkvqBwnUxQltDjvyk
 P/+W14B7H9HrxIbv4BCPMLFhrvhj0eKdDbiwlHZCjiTWBIm/UKZicHZWSA2BNiLHSbgU
 z//UJKTp27vO+2Ns2e4iTEhteIvG+GbsHh9V8ZV+YDsQld6e1A34FqS235fxGngXHjia
 kt/SkaHldePCaLhkAOQZ4uIz1Qb3XmWrGCoETLPY/ZTXAlfo4fZ3NMpn82vh07LpxXb3
 UJ/r3NYFfc1LyD01dJxYoxACqQSVIy8mzY1koYnIOFWzcTkCO14qF6RfiokJ0dPTUAYu
 W5nw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780939650; x=1781544450; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZntXv6MDjo6MKmNrCOedfIg8+pfiuUqkbL5Jnd3IOPs=;
 b=Lm48aFS2EP9BRuSO01c2GOa9ENUBUFSflMW9vGTmgxOrUdBUWRbhfH2/Yd/JLYSOgB
 Ad0ZzV0irw5ui80zJtijgNJtjTJ7waTP9ZG+QF+nZHzA0RXdR6K1bq9WIO8qQ/6f2BW2
 Y3F0QEM0YMLwn/6In2emrc+w78jpd5sBXDfguK9BJM2tzjNQzpp0+pb8xZbYZG56Fh0v
 tgUKknCopGxmoDVg4pttPjuTgroGJjL1pfQVU5fD7alHWRo3fO8m8kWp57WdCbEK63Yl
 SKTBmhCcgLEF0zOY2oznLCd1YBXm/Kd2W4OekNFKDY4GJFWLZR4tCjpBk4thhgrsA+oG
 EMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780939650; x=1781544450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZntXv6MDjo6MKmNrCOedfIg8+pfiuUqkbL5Jnd3IOPs=;
 b=WPlB/Q1SbytfnAvVyVntUGWxIPNpqDxFAKABViwQomgqlV6yn6MzM7njJeiehBlt4B
 dV0+vNRUocnYtDXnFU50sKczNjVqufFp0w8s4QD3z2iA/t2EwNXv+7PejNHIJyBcnUcF
 c1H/xq69MPNBt1tlhZ5078rvp3UYjSXjEIqKWVzCvEtTxsQKn0fyyzq1X7YlOwDx6IiJ
 TpqyBQORK+O7BaxJRhbcjQjQw7+xUmanxfF2B2Y9UvP5FlndpgWggpXgvelQaBwYC2zn
 jhsRaOx1yWEWJI48Fpri86jwvvVCVBP4q0MDNLE3Pv9TbhYgu4lB3HtYuXmTc1hv6bX8
 v+Zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MS9svo5zvIAKx+7gORu02ki7VUC1U35MALKqrmHhOJzHNPI2gGQObIwN4ZwIqAF/NX6g=@dpdk.org
X-Gm-Message-State: AOJu0YzwqALwQGrGLJ4dCA9p0QwMjQmPQP7LP9VIwPXf937Qy0sXxUdA
 E3yJiJV4KhOvrgUWF3gw8iNeZN2tNaYmPJzMlzwXM6CsllMAo7hV0PAPLMWZPTezOGtbUSPDZO+
 1LhqL4/Ms59t6Qf/7sTBSRKp90/4p2ck=
X-Gm-Gg: Acq92OGfWi3taw0bjlchWX/c4o7hwa5ZPVb4I/A7DR9PvJJdeka896957fm49EfC3ET
 WSx4BaUZQAZS4rSd6CQg1j2m9/Kp8o23yxRb6fGf7tZ6MDDHOanzOLdwkWi2fH3nxkOZ/MRAuq+
 NU/OszKtFeTkoEArb9cYEBbXfYRXoAyvMhp2YJRD78vCYGKE3sfBeiIDhg//g/EdR5MVrQPSObz
 qF72TAfkhAk0YnT85F6nxc7lGD/1ZQ9A8Uq3rAMeqKfuggalOLHWdSNeur7y1SOyTJhPMPLTV07
 ejGV6Uh4I0FqyA==
X-Received: by 2002:a05:622a:594:b0:50f:c5d3:a191 with SMTP id
 d75a77b69052e-51795ad941bmr244855241cf.13.1780939649695; Mon, 08 Jun 2026
 10:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260505085037.3961519-1-rkudurumalla@marvell.com>
 <20260505085037.3961519-2-rkudurumalla@marvell.com>
In-Reply-To: <20260505085037.3961519-2-rkudurumalla@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 22:57:02 +0530
X-Gm-Features: AVVi8CcLLAbHBa3GbpiBaCJ9FuGdT5wfz1AmM65WwBQw4i6rkq-OB7hJHzlDVro
Message-ID: <CALBAE1N0dukzh+0EB5NnBWtAp5aXGP2PLi5mWpPHxr-Hj+QQmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/cnxk: add PMD API to support custom profile setup
To: rkudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
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

On Tue, May 5, 2026 at 2:36=E2=80=AFPM rkudurumalla <rkudurumalla@marvell.c=
om> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Added new PMD APIS to create custom profile and API to update
> SA table created during profile setup based on profile ID
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
