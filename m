Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E4EC145E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 14:37:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FDA3402B0;
	Tue,  3 Mar 2026 15:37:36 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id ABB7D40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 15:37:34 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2be06c02f66so5358505eec.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772548653;
 x=1773153453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bl6+Mp8WqWTYo/GoL9WZNCIS+T9u8+MLF5hTpSQ94Wo=;
 b=j2IMkwul3h7nwUcBrCAGwJ556qzo1jA+AjiSppdztaU4Nn3qIkiujf3XVkpQqofIkz
 wjdm3UQ9yhWxQ766kMDBPLPOZFX86RsmCbhdpxV4Ust+39BhdUga/BPwDVUVipssHGuS
 w8hrxZEC+RsYrVtegLgsAsqas8L7I3WgLF7xSxE4O+nqAT5XlquNvrbkrZbrjEJrrgoW
 7wwg5ADvNFIpQxBqEWt6VpDKf8oLFMGEqz6wNqUCXe6WaPWBmFBf9FDVQH2eAt6q3NCQ
 NH7Ewxib3W/Z9Ct5RN4HsKM+ITYxJ5mMP1TSm0J66AceklrMM/6k28j6mlsEyEohv7ib
 Lhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772548653; x=1773153453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bl6+Mp8WqWTYo/GoL9WZNCIS+T9u8+MLF5hTpSQ94Wo=;
 b=tz9G3xsjLq90I6DJu0aJheXzz7zJTEFfJGPmOpmD0SgcQUDGrKByTVg4tjtcanxZ37
 dti2uzoLQ3Z8+0H97NmCr3DQzzERuDIWol0E1bSRbmrs07xVTG76Qk+MWJ3NFI+LUCu0
 s6vcamBobUwJ485aYe+GXSmx1FGDE0bIko2xFBOVGU7dhOSz4hNH6Gjj89FN/fARgUwA
 HWEdo3++SbPPpGQKGjCl/lrOIDeiihWZA0zgHsw13sPYp5Bvtbd6vWc9Ne7kYITVc7Nt
 TEDbKeRufwEDMQ4Xx0UFeJNWBFNtvC2cIoqAcdE9596K4avIvVEjAWnQ+N5P78QsVnCP
 uHuA==
X-Gm-Message-State: AOJu0Yxgdj7kX8MFibyClNBmi84xfRvE/D8wAbiryJs04+GuNoJ8fSVj
 zvlbLz4/yKIODjpu5BUmsR7rW2/w79Po/xk5v6SDMVc0l60zUo7k47hNM9+siQMJDn1YT1H79qh
 UEEm9
X-Gm-Gg: ATEYQzxf9XI8Z8Y7PZZbTZiNk17NNErid6bS8mGZNRdxDeWSTtggJ+naj80t77/YnTR
 RcM/Yo8rzesaSVHIjUyJWcKH2gMrkoKctPs1CXuULSNzG9GI+MYnDRmMvGvpbO2xia7PNuDrOgW
 CCZFddaPHpoMEGH5KGrYN/DpKDZMYFyD/S/fDt9rPZKSSCcqTR+z3NO6AI7BvwOQ+iVhlLfwo4Z
 coj4EoUanhFD5+MnO098PmK4sWvXo5GrFV5KA6rCxDE6Y6gbPClVFoTq1wpgNE02DpD4/jBAjyG
 O/jBPtcY6R/sRLydZnz1krgmAOKcofgY6ljtG6CEbh8Keg0seAE4caFqnDjpj4snnHSEsztpCl6
 cVkAYH1EJgpYsPKlVbSbNkL7QlCrnTN/EJCQqdXjCVRxhbQ4AeARXJRRxhaqCwUNS8Wrpl0TFaJ
 ggPJ0D5fkHCtfSuBrJY4HEzB1wD2D+o/BZ5SAA//eSHHJJJmZ2bh4N5nUdph9gf0Q7
X-Received: by 2002:a05:7300:2325:b0:2b8:66f3:2502 with SMTP id
 5a478bee46e88-2bde1c0e786mr7224671eec.1.1772548653281; 
 Tue, 03 Mar 2026 06:37:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be220eb5e5sm1466768eec.17.2026.03.03.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 06:37:32 -0800 (PST)
Date: Tue, 3 Mar 2026 06:37:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH] doc: fix documentation for NBL PMD
Message-ID: <20260303063730.5eb4e8d6@phoenix.local>
In-Reply-To: <20260302202144.253145-1-stephen@networkplumber.org>
References: <20260302202144.253145-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  2 Mar 2026 12:21:44 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The revised documentation had some issues with formatting and
> setting up vfio-pci was not described. Use the existing ENA
> documentation as a template to resolve these discrepancies.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Queued to next-net
