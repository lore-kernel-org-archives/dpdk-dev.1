Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E6C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B550A42EC6;
	Fri, 20 Jun 2025 12:54:14 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 20FAB42EC5
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:54:13 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c56a3def84so176543085a.0
 for <dev@dpdk.org>; Fri, 20 Jun 2025 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750416852; x=1751021652; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rcf4qnzVgcXe+QIsj1LiFUeYvcUWM1ia7Tm5pBxlY/A=;
 b=WXCDDrMcEw+Zoi7oNbKbGzjgvaRVi8tj3/Op+ydWVHE1lUwdfgsMuevjmZusANGkfF
 lZAsXTpiSWSAIKNfTd7mMkeEiE2W6X9pYJNSoPnfoM+0CxV+DrGKSdnTutuRDj94j8aN
 QI0ObCh9aKmO0Y9Sojkz97EcsHNv46xZ9x+0kJ8fnDrngPkMpUNXEdlzdbEJrVR0xgwZ
 9T4slcRBf1Z/MsmtAHF4z+cNqgLi3IFl4EVpLmG2/GTtNf2aUApag4bhvHk/wBazRsLT
 7z/EH3+qEfzbcpfTM8j+4O3LY1I9w7Mh2c3F94F6cn22ZZe0qmfrZD3S3hlSE4MTd9JR
 d3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750416852; x=1751021652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rcf4qnzVgcXe+QIsj1LiFUeYvcUWM1ia7Tm5pBxlY/A=;
 b=oor2V61Yd1k86Ub+rXSIS8wGfW4NKc8H4Zh43Cp0vYPe2kZ10SIPuTgniwF2qOoSe+
 QLl/8vAGSAIywAusHOLWDYQvJ82YFixCYrdk7Ou3xnHV84s1ZvDy6gplm7De3XWPeMsw
 QzN9Vm37op+7BQ0HQn5T8aAyzFpXjOJ9Pzk9W25KyUZbmxDG3qTfS2ImhNt+IztDPI6F
 SxxO+Ve0PTLV8ji/DHQsxVdUjrsI8Do5+HrxcKD8UrgHmEXCrAXfUf33wBNN59gy0Wql
 9rfYQxljx0DmHtNX7EUxOBB9olaby5m/mVKpzfP1iCwatLZPhEjnI5CBklmR73HtK6Gk
 4vGA==
X-Gm-Message-State: AOJu0YxCJqdsxQOOgdfljL++8fwcWugvZQx0i9D34mancPOkJvSGRapA
 lY/vFEVuPS/fkQ8u5acLoQaR0I/FwUkI4uU7KINgkBrXUeqGDCddPDsI2jl5pDlEmvovSQ3AsMb
 pCOf+k/HydyyShHPa/0IotFHPrMraPGk=
X-Gm-Gg: ASbGnctlj0J/8G9PITuYc9LKjKKXeGufPgR7CMM/mqXG/XsTsHGMRy1Y60Whz4uF1oq
 SVcosSdbG7K2O0WSQMUEycGVdwnszpajIxVX7EL6wSyA8Bp0tFLOOM0OIt8W++5jYLsXPRkwDWA
 aqQto0WkiP/NNKj1tNls1fFwdif6sKSPDUf8nYHV9VVA==
X-Google-Smtp-Source: AGHT+IG55Dgc9cfkVSapsOSSjKBc2yZcwXKuu84xSaTindYaBUJ+0jkNiVdQmlBDr1dAGwI5TEBfhALq3QhH3MQVJwI=
X-Received: by 2002:a05:620a:45a6:b0:7ca:f349:4265 with SMTP id
 af79cd13be357-7d3f98bfd6dmr301180685a.4.1750416852276; Fri, 20 Jun 2025
 03:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250620050950.2548925-1-rbhansali@marvell.com>
 <20250620050950.2548925-2-rbhansali@marvell.com>
In-Reply-To: <20250620050950.2548925-2-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 20 Jun 2025 16:23:46 +0530
X-Gm-Features: AX0GCFstVIzhjFvC9Ad7yIwkku3a_ZIM51F5f7_9WuREBFkLaH6JMoIOlHjGC-E
Message-ID: <CALBAE1N1mSNT55EGG1xd62ac5XJC5+2_H9b3TLVGt672b7cMgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/cnxk: add null pointer checks
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

On Fri, Jun 20, 2025 at 10:57=E2=80=AFAM Rahul Bhansali <rbhansali@marvell.=
com> wrote:
>
> Adds null pointer check before executing CPT instruction.
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Add Fixes tag and start the commit with common/cnxk: fix ...
