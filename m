Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89DC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 11:34:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812CB4065B;
	Thu, 10 Apr 2025 13:34:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 54C00402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 13:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744284883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+yEwuhD0fde9BaI2ujrSgw6dQMbgHRbO/5k7SKnZ1s=;
 b=eum/Fm9CFUjHBRxuGI/b3jzlzqF4TH20ceX9TAx7g0RwiKFEg7ksbOvLfWgso+h6MbaKv+
 nYZebqduyVI7QP2xpVGN4k53ALAf3Lal46gyz4t9bQ+gdgaEKdHTM92FACSBxrYxlyxLQz
 xyb2apbeM+grWXpcf4ZN1siQUaJcAUE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692--M2z5slpPHSA9equv5PNLw-1; Thu, 10 Apr 2025 07:34:42 -0400
X-MC-Unique: -M2z5slpPHSA9equv5PNLw-1
X-Mimecast-MFC-AGG-ID: -M2z5slpPHSA9equv5PNLw_1744284881
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54c2a5fd572so358848e87.1
 for <dev@dpdk.org>; Thu, 10 Apr 2025 04:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744284881; x=1744889681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+yEwuhD0fde9BaI2ujrSgw6dQMbgHRbO/5k7SKnZ1s=;
 b=vAK9JunTvoOyG36oYCGveWvpmMSTN20+fRyrOKUTAoWX6OrDN4HahJadF414u4q8UI
 Gujpw8PALd7mrkazJVTpx6/vTqNEQxbx5NtB8BVbFggDL+faLMgUPRV4eE4foAqakliP
 Nsn95AUqrF6NFRJUGZY82QTABmpH0kdDNZekawo5+psWfEXl+mY70peK9rEVVn1fbTWe
 uB56HaBLpzkqzXgY0dtfLfkzHvzL6TJzojZQ3KvV8hKyhQARUqDO33baS+gD8E+3T42b
 cIr+NrLwe30OsTa1fCrIPj82X9xbWfBs2zZ7OfMWBLZSsH+dDx7ZHfGUY/a62s+giLn7
 +MBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JnsIzY1KO6CS8DyKqAgzHaDWIc/apWJ853G3wmdFWMtYnYYqgqvHE/WXIL1LUPfi3Ns=@dpdk.org
X-Gm-Message-State: AOJu0YxEE7dVcXyBh1PsuQnHoFd94wnPPN1MBXMvjxBlB6kL8/i4FvNr
 asrvyyvHB5Quip8aYtz4bL31dHdAyhnGLoPdLrcbqDMgmTV2hmcYTyE4iWDcvZUG9NJmU6ugFsn
 GA7fq7HTiwW/UO3i4Bp+/njWT7Tu2AfxfQHMpn90nhsPjm0wYLgMuMMPOBB9++vtHBuqbcHyPpz
 sLei46LjMJMTZoiwg=
X-Gm-Gg: ASbGncvqa7gSulr2wXL/WnR5weQg6+i2s5Snqu5zlxX9Ha47s8mZrTd7jCj/FKhuAIe
 gBDGJ64qk48fDDKbSJa/4pJT/GtZvsYgJfQJnj05qofIvi32F0mJDgggGTv5e73y8Ho7URx0=
X-Received: by 2002:a05:6512:2350:b0:545:62c:4b13 with SMTP id
 2adb3069b0e04-54cb6880bf5mr765724e87.40.1744284880681; 
 Thu, 10 Apr 2025 04:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21iJa+Qc5zm6uUGhndXae+CcnLsE6g7/zdWk4GKQhWcBtrf6kvOSO5D4CQkhKoydpYJuSBP7+cYcZ1VLE4L0=
X-Received: by 2002:a05:6512:2350:b0:545:62c:4b13 with SMTP id
 2adb3069b0e04-54cb6880bf5mr765718e87.40.1744284880246; Thu, 10 Apr 2025
 04:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744161658-7874-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Apr 2025 13:34:28 +0200
X-Gm-Features: ATxdqUHFTJ0AoaM-amq378eI9Oh0qHgWC68v06nWnGd3RXCpOZpUrvAT6cLwhWU
Message-ID: <CAJFAV8zO2zPcbSPX5MV2r=RuaXoHFGPj6U6KQMM+QCo9601cXQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] fix how large numbers are printed by hash tests
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com, 
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oii4pm_M2xmgz9lSAL1l_T_NQXazDhBp9PFBXmbnQpg_1744284881
X-Mimecast-Originator: redhat.com
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

On Wed, Apr 9, 2025 at 3:21=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> v5:
>  - Rebased and updated to conform to new function versioning mechanism.
>
> v4:
>  - Added parameter "unit", which allows rte_size_to_str() to be smarter
>    about the need to append a space after the number. This keeps the
>    function easy to use and avoids the need for complex explanations
>    about the space that could be needed between number and multiple/unit.
>  - Changed the return type of rte_size_to_str() to be buf, or NULL on
>    error, allowing the function to be inlined.
>  - Removed a line wrap.
>
>  v3:
>  - Added rte_size_to_str to version.map (marked experimental for 25.07) s=
o
>    that symbol gets exported when building with -Ddefault_library=3Dshare=
d
>  - Added sample outputs
>  - Added a space between the number and the postfix (if a postfix is
>    present)
>
> Andre Muezerie (3):
>   eal: add function rte_size_to_str
>   hash_multiwriter_autotest: fix printf parameters
>   hash_readwrite_autotest: fix printf parameters
>
>  app/test/test_hash_multiwriter.c       | 14 +++++--
>  app/test/test_hash_readwrite.c         | 14 ++++++-
>  lib/eal/common/eal_common_string_fns.c | 54 ++++++++++++++++++++++++++
>  lib/eal/include/rte_common.h           | 34 ++++++++++++++++
>  4 files changed, 111 insertions(+), 5 deletions(-)

It looks odd that string formatting helpers are declared in rte_common.h.
I would move those declarations to rte_string_fns.h but this can wait
a followup patch since other helper was already in rte_common.h.


Series applied, thanks.

--=20
David Marchand

