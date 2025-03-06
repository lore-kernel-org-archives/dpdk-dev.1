Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D48C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C581402F0;
	Thu,  6 Mar 2025 04:05:13 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 16A89402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:05:12 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso299770a91.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230311; x=1741835111; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DE/2wJvjDMLsWzSg/r5ssemQ6vQt5/n6Urc+76RlnM=;
 b=byA1JiSV6kTTR8sEVN5kVAE9EtbN6jTkvBJzTq85Ieng0VgTIYdrJ/ARp72dwujiYv
 tk11RtmxsR+JeU9Ce7cyuP5m2faBTzqiG5MFIeFyRXmtCv5LJoCWOAMDLCOPRXCQJjl/
 tvIm+zBINpKoVo2M4mud1xWQtrVEqalNydhZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230311; x=1741835111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DE/2wJvjDMLsWzSg/r5ssemQ6vQt5/n6Urc+76RlnM=;
 b=BFKaxDZSYhzWDFcpZJZNPU7NioydWcGRDFuMOtGPXzwc9gYYdleprDDpUrgw2GVsed
 whCAFmGO+DhR0f+61Du0JwyTOA+GvxKiBfr0ERsJa6NhhC4mczouLoG4u7XD2geeboZM
 HIFKMedCNAFZ5s4neusz0D0MEwXN8ncmLyTKga7gXHZ0L5aJBSn0Vu+ATZVk5eKuJkA+
 rBOPagr4/5myQlqyuOIrfQhFG11x9A2sHQ8FtWu33gSz6y142g9FQSeJJSnZw9v3RWi+
 krJEkQjxhGgsSXkmifXxWKVNZrYEJh6zqgekojnhYnWCPow5gn8pQcgOTGGG5a3YWZlG
 tQdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXewrKknqv98YS20X0ugX0/9kMdzTN2tnynTCJ3J5bPrwfd6vzQoThrhnIJs2JfdgNLi24=@dpdk.org
X-Gm-Message-State: AOJu0YzC5cLAn7Shm3ACy0bVafv987ZY51+1ExsM1O4mg4+tybvZXPt5
 wFSm/UzPy064M8F7aIzU3RVpmQW2FIsstRlN/G6dIwRS3sUPIcSDImTtxfDpJaS/j9m5y2aez2i
 CqUi/wncIpP5GWmf4/eyP3GYA52VCUl7Abol0vg==
X-Gm-Gg: ASbGncvjd6AqUR6aBbrqSEk+viDz5buQgPYuQL6e0yBpIkuBKmosgPw909igQ2rsx8i
 HG9CK1Qb26O16HGRSJ95XN1LzlA9PY/1Q8rksGIKg54l18g9O1WhMn7PqiUqCp08o7DUMeHoKvt
 ZjClH0Ca8Fbd/+q4TxBBMcs3aYQuWr5FQa87lpwCCkpg==
X-Google-Smtp-Source: AGHT+IH2svK91JTtDYxBeaYor9NA1swypXKrrrXLxOKhJn6vKf4RnGDkckxxxRB6z3tB37QJ0H73O9U7L5SXtFhZ0S8=
X-Received: by 2002:a17:90b:17cc:b0:2fc:350d:9ee7 with SMTP id
 98e67ed59e1d1-2ff49775ba1mr9423796a91.11.1741230311223; Wed, 05 Mar 2025
 19:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20250305132353.46724-1-dsosnowski@nvidia.com>
In-Reply-To: <20250305132353.46724-1-dsosnowski@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 22:01:36 -0500
X-Gm-Features: AQ5f1JolH5gFfvhtE-uFoazV548PwbxlIpdUwlT5V5NADSgvvVw4tx6-ipbDX6w
Message-ID: <CAJvnSUC-8xZDJY4B8_bFdGLGZjYO-zS-Nw25LuyLHSGc1T-j3g@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5/hws: fix incorrect DV FT type convert
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Erez Shitrit <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>, dev@dpdk.org,
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002c50ab062fa3c622"
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

--0000000000002c50ab062fa3c622
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--0000000000002c50ab062fa3c622
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--0000000000002c50ab062fa3c622--
