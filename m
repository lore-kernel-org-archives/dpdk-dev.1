Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025AC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 11:30:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE7040299;
	Mon, 29 Jun 2026 13:30:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F0C34021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782732647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vd6ZxjPsvDdy2i+TGGq/zyJu+LHGrwgTexsoA8nrDes=;
 b=gId1VDzrFSXnIL28kJZBWmVYgBm1IUeDVUZ6EO1SYbcgxWj1MnJM6XT0bbd3QwOlXdmsDM
 /JYglJL8RxNixBFjlbZF6aNuPcyBJagrj3LfeQuQc3QFHkiGW2zPWIpZiERhTVkPCvLBFK
 lwgAFbGK4IK0v5Icm+g1EZa9mWnXfts=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-LRBhjvclPriBgqiaYbSvAw-1; Mon, 29 Jun 2026 07:30:45 -0400
X-MC-Unique: LRBhjvclPriBgqiaYbSvAw-1
X-Mimecast-MFC-AGG-ID: LRBhjvclPriBgqiaYbSvAw_1782732644
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39accc98fffso8820921fa.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 04:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782732644; x=1783337444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vd6ZxjPsvDdy2i+TGGq/zyJu+LHGrwgTexsoA8nrDes=;
 b=BSPAdoXakkeegoM4FNmM0c3XTyxVQtFWl3sJGd8vQA9h7QDP5ahjBRslUsMjk79ikT
 6epizH7oKgOJ5UvVayzWn7kozWV+pqbREOBDcsJzhOLVBgpAK1B569rsRInQdnhVhFdZ
 s280laKtDHyuq8EesqlfS9+fPY8sE6rvqSWE9Y96fjifmghoz5PSfqJDCujINym+SV3y
 CY1kUj0pi+j/axxCfKDR73RM8HTL37KrP6ZB3bNI2fMKuukxfCJCHe1WsULjjxoDpknP
 0OMl1CaR379tFHSQ8yDnDA4oP53zmK1h+U5kC6ns5dspxTZaTBZzRLBshWmjLtuWl3ws
 XTcg==
X-Gm-Message-State: AOJu0YzH4l8UA/cIdsgnRXBIERBiUgDHKWkDX7ZgKQxUHziytAM2IiwP
 I5aZ53ESeoq4dydpMREZskqHWbT6lZc1WiK0aFvV3tc9yg328o8lNrKPyGE7m/BD4f5ZEuGwgoH
 V7DBEBet+WyT+Zh95LzNcLBOPZtprLyU14Wjqid6EUXsYtXHfa2yV6VYe1CVB2xitCSU4IEci6W
 kK64YPQyLHBdvTbzlC93Q=
X-Gm-Gg: AfdE7cmNNj52Gj7VpJ/TLPZD4DFw9vRrEebIyohNcAmsyYTDEGe/sGwU2RFVtkUUkhn
 0PvO95P7ZaYgZ3QBy4PEyhMHenQFqz4T+lLoeq0WfvwKL6yYJbJPJ2AxVOiRzG0uarUZx+Kf08E
 Sa7cB3SIUmuL2So8SprukoSFeCXk3eD1HLjf+4dqxgf4UFkaD/Lm4sEGoE1nBWSmrITUOYx5/ZE
 QcguO3n4b+iZwh1Cjvyhd7dkG4OnYCMhiF39e3ME3Y2CGJHjFrJu1LUvIc=
X-Received: by 2002:a05:6512:400c:b0:5ae:b260:cf4b with SMTP id
 2adb3069b0e04-5aeb260d09emr1476236e87.64.1782732644224; 
 Mon, 29 Jun 2026 04:30:44 -0700 (PDT)
X-Received: by 2002:a05:6512:400c:b0:5ae:b260:cf4b with SMTP id
 2adb3069b0e04-5aeb260d09emr1476225e87.64.1782732643685; Mon, 29 Jun 2026
 04:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260624113550.821516-1-bruce.richardson@intel.com>
 <20260625130813.1527333-1-bruce.richardson@intel.com>
In-Reply-To: <20260625130813.1527333-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 29 Jun 2026 13:30:32 +0200
X-Gm-Features: AVVi8CeNLgOSl7yOuZypUQvP4Q0m82JtnWmUSsPax6HOonivXRf3DENMQOaDjJo
Message-ID: <CAJFAV8yP-Mp75so4qoKqOHUzbgWqBi-e8JDLY6yZDpjhodU-tA@mail.gmail.com>
Subject: Re: [PATCH v2] build: drop dependency on libbsd
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OMKCpkssu-v4RTGq963qMxqwwilsO85xfLQ1X41mt4o_1782732644
X-Mimecast-Originator: redhat.com
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

On Thu, 25 Jun 2026 at 15:08, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Glibc added the strlcpy and strlcat functions to version 2.38, released
> in 2023, meaning they are natively available in modern linux distros. At
> this point, the value of having the libbsd provided versions of these
> functions is reduced, so let's simplify the code options here by
> providing just two options for strlcpy rather than three:
>
> 1. native implementation for BSD and recent Linux
> 2. DPDK-specific fallbacks using snprintf
>
> Since the strlcpy and strlcat functions are the only two items used from
> libbsd, we can then drop completely any DPDK dependency on libbsd.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>
> ---
> V2:
> * took the work further than v1, dropping libbsd dependency entirely.
>   Now DPDK just supports native strlcpy or it's own fallback version.

We still have some references:

$ git grep -i libbsd
.github/workflows/build.yml:        libbsd-dev \
.github/workflows/build.yml:        libbsd-devel \
devtools/process-iwyu.py:def uses_libbsd(builddir):
devtools/process-iwyu.py:    "return whether the build uses libbsd or not"
devtools/process-iwyu.py:    return bool(get_build_config(builddir,
lambda ln: 'RTE_USE_LIBBSD' in ln))
devtools/process-iwyu.py:    keep_str_fns = uses_libbsd(build_dir)  #
check for libbsd
devtools/process-iwyu.py:        print("Warning: libbsd is present,
build will fail to detect incorrect removal of rte_string_fns.h",
doc/guides/howto/af_xdp_dp.rst:          libbsd-devel \


-- 
David Marchand

