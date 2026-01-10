Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD4D277CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 02:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82784402D5;
	Sat, 10 Jan 2026 03:28:52 +0100 (CET)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45]) by mails.dpdk.org (Postfix) with ESMTP id 053284021F
 for <dev@dpdk.org>; Sat, 10 Jan 2026 03:28:50 +0100 (CET)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-93f5774571eso1599039241.1
 for <dev@dpdk.org>; Fri, 09 Jan 2026 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768012130; x=1768616930; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HQd414MAwiVtspSXfeoZLW6ldWKM6F/eF7UlwrDeNf4=;
 b=fRY42jL8LX2Egzk2kNeA4nO+Tmn5IHE4rdHrBftHGsxkKy3aej7/2LMX3UrjJWaL+t
 X0VOzZdx/lgbdJRT+Gq53gSUcQez4mBooBCMH2FAPbB5MeP9iKarj+0ZuLn9WQcdEEc7
 QD7nHyElCX1b8a7oIjT4JYPILHeyA6UCDN+qv5h3ZzdChZMj7uBSB0YoN7GuwW9E8Zm3
 hcLxo/3kj2niONhPlT/tY2yzdMvijsojTIzKDSG7TJTigOQIqD1PDB5zQboG7+3B2Fx5
 RQXddvRIaCtkK0oQELwhlfDKSSZR2z+YE9e8z+ki7bLrUuYx2oxHENVQaoopVB6k9Fil
 qwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768012130; x=1768616930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQd414MAwiVtspSXfeoZLW6ldWKM6F/eF7UlwrDeNf4=;
 b=ccu102vFdFrPkIKdVRcM7cSBDFmZQO3JpjOnlpYV6M02BFkgFmlWLNcQnf3MsFMPEc
 0iYqzAbOJrVskLCFKOP6zIfIS5sL00qFuM8NCl7Eber0mwDJJV8juSVuzYaF8hjOcTy3
 XlOP3S07vVmPUa7PEJBbUUYUBVwiPzc9QOBPPMgf477XGSkgcmayMi2cE64T0gQblGJj
 1Nd2TGwRd0u1w7oobQUb/OmxQLRqDZ+7QCfMEEglXYRmFaVlP8JHbuiCk/BIWmXOrXHM
 dZVJWhVJrb9FZL2LB6Ch+PdY6te1hL5tZgGz++/+5Gq8Roe3eP4IYHe3BY1yh0geT5o2
 k1AA==
X-Gm-Message-State: AOJu0YwWDVFjEMGs8teirKQaKuM1cNkrunTSIMug+aSu4+HTR0pGYgr1
 RNqIo6MttOPWHlfoe3AJR4dBh3vaVXr7TQPcjcvXMm/ycJjlbuR7sdW/j55//tS5n0oJaunwxcn
 zo4jxif18gbN2uDc4aAIR7OVCJRpjA7aie7fn
X-Gm-Gg: AY/fxX6rtFWYP8kw7QR19s3f7lmV82nr7g1DPKr8B3KZSc2afx4+p6H8uUH/1P97g4N
 jAuHDGHhCSzRdaB1VTG3a75B18KT0v6qh9QT9CgHLNialNHfWxwhk2PfEAmktHs8vzbD9avtdZ2
 3taZ34VtpvebgWKlhFpGz2zjsjG0XabEs2hDim25UlV2GXSoBiiAvuBjqpqfdyurl05/doGYlXP
 bSH8AZWIXjIRv0C/y+yIXSjf1ExwlfmLX1bKZiHrbc8EhAwr8lX2F2vB44Zz58/xWvkvkLodgz2
 3kzh2WKfubEqwWgUEG1dIWQ032U=
X-Google-Smtp-Source: AGHT+IFHjcKlX/25pY8rzXC5MoU5PnR8KvTnjSTsk+56oeYf0O0FLio52Fkb+fylhGpTc0xTw1HoCUFjqTk5atfCuyY=
X-Received: by 2002:a05:6102:4405:b0:5df:b3ed:2c8b with SMTP id
 ada2fe7eead31-5ecb6989064mr4310403137.38.1768012130133; Fri, 09 Jan 2026
 18:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-2-scott.k.mitch1@gmail.com>
In-Reply-To: <20260110015651.26201-2-scott.k.mitch1@gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 21:28:39 -0500
X-Gm-Features: AZwV_Qg57cf4plo-WY4cZ_t5VYxBiryvlXEADqVTsKHAu7kn70V-bGPrRtorkrA
Message-ID: <CAFn2buDTyMcuGS1fjWQE8uJ2PeaTDaR8zP-MY2MqLyN0f_1_Hw@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] net: optimize __rte_raw_cksum and add tests
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org, 
 Scott <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
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

I will fix the `ERROR:NO_AUTHOR_SIGN_OFF` issue in a followup submission,
but will wait in case there is other feedback to address.
