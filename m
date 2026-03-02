Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2ED58E5F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 06:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E433402B0;
	Mon,  2 Mar 2026 07:37:04 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id EC7144028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 07:37:02 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-506aa68065eso41801981cf.1
 for <dev@dpdk.org>; Sun, 01 Mar 2026 22:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772433422; cv=none;
 d=google.com; s=arc-20240605;
 b=Ez6h4GVEdDUx/hodLkrizSXOUONkCTwc6DC4dZ0FnhzGZ36J/72JYfg1qZFlG/tes1
 z1RxE1fPza5T+NhNiROo+wYg6xy1lGBUnDWCLm+LRdc1gPuRueZHgSdb0dHQu57gRuYk
 Afo+RR4GG297rPsxSmQ1urRnO6NhZBLk5GPyPGvOn18GemlhSfCRKEPX7Ijr17QvrsOq
 HAMqtUoSU43hnhpLlmGnOHQVb8agp/KPkc4HHqxxWIufiEU5p96RLVkQXvJ5MsKqGRBo
 kEBIiRCnUOhXVSMvswE7fSVWo4f5GMboLjS+aWRSr2QXd/HghTMzLUj2IHYWzDvuAJRT
 A5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P3SIyvXUd6XNmRhrFCNzFE/j3kTY/kmNCgOtcHWVEdc=;
 fh=AWWq3WD50/hRgQhFlOlyY9e4SLNDsnHrLOnnoS81ZUI=;
 b=aN89Ep+JJ1jZlNgtYpXyvk2ve/c7bkaSzcpjleU9wmDrvqe28h/mWuRNPGnhV/HQ39
 YqAUrmhyoMENYhwKBqhUGE07H7TNqceZ96FRtqQ/oiJB+K5YCDpowxuRmYPThkHX2EHv
 TSOuA81PEBKUhsaM5xzVLHhPPw1yVJh3X6fzOvakACC8/RPdDL/LrcEoxdExgYgMrzpk
 3TRdYxLgBMl56jT+7xmFg2S5cLqTyXxaBaJ7NiZ+oJAuSjpOy1Qkv4OkliKJacJL82PE
 UAniKzc7Mxnowf8dHSZG29orlVkNdPDBO2v1M1vpgz+1UJg+6qezjnRRH9V9RngFND5l
 NRIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772433422; x=1773038222; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3SIyvXUd6XNmRhrFCNzFE/j3kTY/kmNCgOtcHWVEdc=;
 b=cQMlNGaUqGUGF/trdJzlcwL3vMt60/Uom+WhBp9zJBrVulQpdMION3ZIqY6+7Kh/n7
 EhGf2LzqStF4Xi9yzYUx/AwJNfmIt9z66lRM3RK6AYD5qy9DY6VhEGM04kXKy8WoYLG8
 gzEM4+jiAfdsMHi1exeN9TspbSrqmwtUTrsGG4+OU09k/qGxUsnMkCaaLb9sfOGS4nGT
 xqcjKIo7WF6kFpeGFYi63vxUCq4iNwxH4/MWd80M90MQ/8kOy/M+sDGK7Jk5ltluvYwg
 eeeoBRUMEtP/mcW0XJCEg8vx/7eifkvs06zMchBZIQxYuKHaylLnqGD0+gOc1+wPUh9/
 3vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772433422; x=1773038222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3SIyvXUd6XNmRhrFCNzFE/j3kTY/kmNCgOtcHWVEdc=;
 b=dyve003At7XdQUIGH4GJDWtazem68LLfa4oZiu8ttfxRgC2B/UXZbQCFvPUIB6cn4s
 Lo3AKIye6gqXm9e0ZA2RG7u903B4F+YSbEnKLWGQ03/wH7KoFpaJVT0TCDY7FKOCSmPc
 js0uBLWT7WNAh3htXTnYZORctYq+PjolJkMeySWY5Cv2XRYDMsD2+3NsGNTKdm3s54gN
 Rn7D8eF4qh1ubewk+oI1cGf6li3Gcj/o6Gw1HOSVGkWdT0NyGdpFCrWrpge+DjHeJY2e
 PjKon29GYme06P6/L0i4MlyBJOpaJRywGM6OF5WFpDojJZLSPs7QvkhkTQiVNUP17Zqs
 /bcA==
X-Gm-Message-State: AOJu0YzS7NycAMODX9u1giKK/FXMcFtgvbsMgt7QELQ1ukLXP60Y+F3j
 t47Ipym9npXgQrzaadnEEpVT3DkhP0hEFsrzfkbUmn6FH69Wdg3yResfB9zuKjbrfVtQ+Il9725
 Lyqq9+1U8fC4SM/MwPZZ3PF9uuTMoSms=
X-Gm-Gg: ATEYQzx8u2Uv9ZDQ+1GALz8k36ZjzOXWM/TEBdO8A/1mJur2Op3PwvU8Z4eb2REqBdG
 cknr1+es6gaBfavpJRhljb31e4aTX7V5FwbZNsJVDYhRCwtIm9g7gbE7ILYAIY0E4P8/+gY/q0P
 Y1IjwZqEY1hjt92KUckiqOQCH+wpBE/bUufMFnkl1S297M8+O3NqRsOzinpa4eOww0wO2lQvGD6
 z7hKt3uGSUMToOeaOL1k010ove9eYrCJ2rNZlJxQl2YFnN4vk51v0vBT2pCYjDNnX8P4keqw3e4
 0VQYueogGjZdsQpwIA==
X-Received: by 2002:a05:622a:4d2:b0:501:863a:a881 with SMTP id
 d75a77b69052e-50752a2bc24mr133644561cf.75.1772433422120; Sun, 01 Mar 2026
 22:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260227043723.1986183-1-rbhansali@marvell.com>
 <20260227043723.1986183-8-rbhansali@marvell.com>
In-Reply-To: <20260227043723.1986183-8-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 2 Mar 2026 12:06:36 +0530
X-Gm-Features: AaiRm50KOPH4fpqZXdQkzlRl8FqBtnumaSeDNq2Sae3mJRzfl9yTVaQoyowF3_w
Message-ID: <CALBAE1Nz9gFRiUL45SBeEyvcqjUPqj8DNdTLtp53pf5wU9NNhQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] common/cnxk: enable CPT CQ for inline IPsec inbound
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, Rakesh Kudurumalla <rkudurumalla@marvell.com>
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

On Fri, Feb 27, 2026 at 10:08=E2=80=AFAM Rahul Bhansali <rbhansali@marvell.=
com> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Added support of CPT CQ configurations for inline inbound IPsec.
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
> Changes in v2: fix cleanup on configuration failure case.
> Changes in v3: No change.


Series applied to dpdk-next-net-mrvl/for-main. Thanks
