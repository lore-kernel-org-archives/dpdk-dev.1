Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5229109C045
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E81E3410F1;
	Wed, 25 Mar 2026 17:51:08 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 14A9E410FA
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:51:08 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2adff872068so125125ad.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774457467;
 x=1775062267; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlwCbcuLvbwoiqA6DYlXV1g7KQXNtQeJk+0M7Qk2pmA=;
 b=Mmx8DWF0c4dQLg/NIdpNfRzUz2Kxn8ASPgi8cYt+Fwxo/8SWUN9HFRypmIZVeMRQ5i
 zJDfQs6nD0g94lvWr9wXecOdxTcmPm+jJ7+Gm1ACvtvnQJHuMpEPPjbbucdVp4kMHZeZ
 fDbICawUJ2BVvNcW+jZlLaif7XHLF4qD8FnNTPErwLyK6jlS/bN+NlgIWFy9lsEjdOE6
 l85NDhD+myXoBM6RV8l+iAlyQzW0nxFrXyhj+J7vH+ZyY+WZVZlgOHnuDMlIstmlCw9a
 XHV92RJu9PuxwnkDY9P1my/d1TFqfEvh54MHOgXb+aO8jrg8ND15s4OjUvSTbV5Ksvur
 O6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457467; x=1775062267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mlwCbcuLvbwoiqA6DYlXV1g7KQXNtQeJk+0M7Qk2pmA=;
 b=oUnaFTTgLeiXXlA/Yf5UJ0XHnUSWNrJvofXAv7yDuZ+EHR1rqCLF4vV2OGHxUyFnhK
 yKa4AFRnb2oInu5W8KNPmzl9/AXtSZmI+/ZFIBgdCxf/7evBwH/aNQhtq2OQ5iey1RDY
 g3fluoZn8PRhDOww1x7158y573Y/QXKgEPS9eHFYxYxiyFW3GDohtPfzLc9g9TG9BBpT
 9E1329N1bW4fTTPa6fmoA/xdeepX8YsTVdZXMfc/F0UOpuCwa3xR/kJ3QhiPIhaD051C
 l4n4TqlpVo4XAyP0wfITI5C1u5ODbVV2KX6vLYffrBHmPCHTISBKUDLz5ROK9VZKxy1g
 2+0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEz2eDsf/pVqd9DlDbqqyuYnLqXS48cKlmViS4I/up6B5jtMotRRs7yghhcB2W97Xpl+M=@dpdk.org
X-Gm-Message-State: AOJu0Yxi3Q35sYYvNy3tyy5lxKNoVHSsysZB1KSbUcetbcQrtBMBEULY
 Xu8WbxwkRTvoZBP0yqD7Yymh0d/CTd0TOWEUwc62A/rpnZkj0vlnfaDebStbYtK9KUo=
X-Gm-Gg: ATEYQzx8oql4iW43Urh/RfEs/PcNqpqJFcMDPF5ZG1OEb/9dXERdacuScO5VN7Az3TS
 Wf1b5CppG25r06CfxG2oHBu8BU3YE+66SXIfQSyku2UR5Wmk7L0QxMv3a5qNxkftW3L4SUP7F6i
 R1gu3980RizP4q7pyQEgJGirY1xQ37p4vhZ5nlZRLudvSLyPfetOF4iong6goggrGJ5vm1ddvnl
 ZStyWO/ij56snoSxplufk/ChSdfQZR2yWBTWTeNZWuR68/WuBrzbwRuigYmmu3MypNBtfeHopNY
 dwDaIH5FrpLm39WxttTi/JBg5nPn6l1yjwZ7IrWbHjXk1cSfbDVQFeJrOu/z6LINmGQ35u8/w4d
 EibPcaXOCHUGhZLc/+jjIiU4a22GX4FotATp/2ojwI9TQB61w7otAktUoE0Po+x6RJagF6v0Mcx
 FaFTK+TodSemnMrpZnyHEYtYAJRh6tmnNPn2LZYt98nUEjAQ==
X-Received: by 2002:a17:903:8c6:b0:2b0:9a61:9da with SMTP id
 d9443c01a7336-2b0b0a8c4b8mr43737525ad.25.1774457467174; 
 Wed, 25 Mar 2026 09:51:07 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87ebf1sm3493955ad.44.2026.03.25.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:51:07 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:49:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH v2 1/2] app/testpmd: assign share group dynamically
Message-ID: <20260325094920.4e086ef0@phoenix.local>
In-Reply-To: <20260324165657.23945-2-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260324165657.23945-2-dsosnowski@nvidia.com>
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

On Tue, 24 Mar 2026 17:56:56 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Testpmd exposes "--rxq-share=3D[N]" parameter which controls
> sharing Rx queues. Before this patch logic was that either:
>=20
> - all queues were assigned to the same share group
>   (when N was not passed),
> - or ports were grouped in subsets of N ports,
>   each subset got different share group index.
>=20
> 2nd option did not work well with dynamic representor probing,
> where new representors would be assigned to new share group.
>=20
> This patch changes the logic in testpmd to dynamically
> assign share group index. Each unique switch and Rx domain
> will get different share group.
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

AI review found that the option definition still expects arg.


Warning: Option definition still uses OPTIONAL_ARG but argument is now igno=
red.
The --rxq-share parameter definition at line 354 in
parameters.c still uses OPTIONAL_ARG(TESTPMD_OPT_RXQ_SHARE) (which maps
to optional_argument in getopt), but the parsing now unconditionally
sets rxq_share =3D 1 and ignores optarg. If a user passes --rxq-share=3D5,
the value is silently discarded. The option definition should be
changed to NO_ARG(TESTPMD_OPT_RXQ_SHARE) to match the new behavior, and
the documentation now correctly documents it as a bare flag.

Warning: share_group_slots entries are never cleared on port removal.
The share_group_slots[] array grows as new (domain_id, rx_domain) pairs
are seen, but entries are never removed when ports are hot-unplugged or
closed. Over many hotplug cycles with distinct domain IDs, slots could
fill up. In practice this is bounded by RTE_MAX_ETHPORTS (default 32)
so it is unlikely to be a real problem, but an RTE_ASSERT will fire if
it does overflow =E2=80=94 worth a comment noting this limitation.

Info: Documentation grammar nit.
In run_app.rst, "This engine does Rx only and update stream statistics acco=
rdingly" =E2=80=94 "update" should be "updates".
