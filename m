Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A897EE6B70
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Feb 2026 01:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D6D8402A9;
	Sat,  7 Feb 2026 02:29:29 +0100 (CET)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) by mails.dpdk.org (Postfix) with ESMTP id 718254029A
 for <dev@dpdk.org>; Sat,  7 Feb 2026 02:29:28 +0100 (CET)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-5fac15a7b88so760544137.3
 for <dev@dpdk.org>; Fri, 06 Feb 2026 17:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770427767; cv=none;
 d=google.com; s=arc-20240605;
 b=CzfrIlHZsCmpsroa8BSb7xHwmeoGFQKwuS9BQXj7Op4EMWXd6XUZJ+6Q5sHCsqZOe2
 Y8RW9iKNhN3yWNsmJtXDn1qJQ1RUF6go4tjPzk9sOyfRK9MOmJ4QxXgkJiCK2kkMZwWr
 ugnmA9cpQhyQDOkXrVA3jiqwUEypeeH3d5wCPSFh24XbfP4CSxtzPPJdJNBiP/OUzZDN
 3az/Ov+JYKHAs5svSEAHgfwPmIL+5DQJsth6qlG0bQ3xNrY33ZRT/mlUJzKH8RF27tXE
 DiXY3/T3YXHyKRkOrdHjYj+kvHvC2TjetAVHuaBv2s5dZzcqEMYk0W3HbeFxdbpnE18O
 6tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=icgDiP3/OSPUKKkTRAl0Q5oGbKog3HHoODAbPNkyMu4=;
 fh=THPRJpyxl06TEArzot6P+5BBwSBCxbxSA5hUAlkz/JQ=;
 b=UXnV7mb0jxWm2RQLptFtEE8asFnREakAEUp/8WLgJuwvqnFW8dH4Ay7VMIVevf4WLn
 F2D1216LyT+5XpdujxOjbQqmEek5UE4LDKwv4CaG3lTIMDNUXbDoxOnoeK7+GT12C5v7
 rIxapLOCrBqUy9R9i+GhQdG3gR2btptMpTeXPrpiIdz47ixm/wnNm7U1YJmDvf9VTvG4
 CepXCpXy719EuCD6psO98gJ1GLXkNdr+emrX9EYnmvjfrwif880umb7luUlSe6r6Lv4O
 JI5NnzYLZYOVANSYn0tyYgVX+/018JeMUrUafSYzzyWmZIrNt6WTONuX0fNVj3wLE7fS
 BH7g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770427767; x=1771032567; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=icgDiP3/OSPUKKkTRAl0Q5oGbKog3HHoODAbPNkyMu4=;
 b=a01hF7MEMgH7cqzqO3Tdc6qv4ktLVVVT4D6trR5BQEcoNLS8+rMJxn9ajBh6HjwFZB
 e8hXpmeYeDXQUA6p2LnYX8J+a3dBlNy5Nv1uAeZ0FWTxyqbihnH5Nr4WoYmcTxR/VBQs
 S0JbxkrlwsRRqtmlNh5NoZzzT3+uKVXQig4/zwB0/y4aTHTUvOx4HPHIIbIhgLRovz0I
 FTxP0W8btEe+HQz6I4msBWnkLP9aPo+wJQurKacOqS+eHCheI5o3A5huqctF+cM/EVxI
 XJAnn5maEDFK36WMANt5fM0wLBjBWmf5E94Ndz06z+WFeAhyPrlo029GzUoGCJatDa4H
 n60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770427767; x=1771032567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icgDiP3/OSPUKKkTRAl0Q5oGbKog3HHoODAbPNkyMu4=;
 b=cLWIFScTFKeGMAevNn2VlQjv7vL+x/EGYAPoKL671QQYm8FGlrt+3KTJdfGLAZyEBN
 XtetFLzsSB4QuwX76ROx/WoZwFKCRJgG9wSVpfrzrSGKQ6dItMNw+da4/azAobWO2HLh
 lXMiguHlG2NT4r8ASLntYwXPUz+iqM1pFyQn3Rp/blry544O5K0F3hKCBu0oCuw0u9x/
 LQN3rFBZO6oLptx9nt5OaXPg5EwsBlfcvS+Euh+9bbKz1x/q7LGHZSUQ2VffFh180s+1
 8XkunA3h7RY73FVAvl7FYsS28GHQSl0X6W+3ChcRSulvgvqcoqd/d9B5o9fBxvQ151A+
 M3SA==
X-Gm-Message-State: AOJu0YwUXOZoduO1FN6RzbWxdP9NmOq+mO9B6gmhOdvdRm+u+RtNzvRZ
 dljiv7ggO/BSAHhLIpuC9smB6ubtAs99Euz2m0BwmyI1ErRV2P4236PBLWmIrfYQvc7YU3te9Bq
 0RfcWY1y2BOqdX+yBnX/c6PF2bYGF9S0=
X-Gm-Gg: AZuq6aLxiCVIOilNE2CA/5CWFKGYgtikAwZa6Eqkl7J8mPBvfV37D+TMo53UcEfXoMH
 IqvCH+VEv8JY9Zg8PB3WVgXte0fSd4tUjDTRAZM90Px19PoBS1dFXschhrqnCBPLg0cTNe4jKaK
 aYKqKmxCYmo45DBUV+TYFtt9Qex87L3W2JHvR+zsGUgy2mrLjgRrSXCXzB7G9ozHnmDQNidG1Ww
 jX3cFaoBiCgsQiQMjjZ3nU8f4siv+0SPEGzUP1EbLMdeY9r+F9g3e3R0Lv7LNDvN5XzGE8=
X-Received: by 2002:a05:6102:3746:b0:5ee:a53e:d3d with SMTP id
 ada2fe7eead31-5fae8cfb75dmr1080149137.45.1770427767522; Fri, 06 Feb 2026
 17:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
 <CAJFAV8yokz8AG5ZVLBvDSNszY05+81pRWqfWu9FmCgLOvBcZ_A@mail.gmail.com>
In-Reply-To: <CAJFAV8yokz8AG5ZVLBvDSNszY05+81pRWqfWu9FmCgLOvBcZ_A@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 6 Feb 2026 17:29:16 -0800
X-Gm-Features: AZwV_QiBy6aA32VRvQJYKgmc4xHSsbHmM-PTIZGZi5L2ZbLBEtjd_Db0i9VwfkM
Message-ID: <CAFn2buB6yCTZGFOfE-erpU92SRfgGqcvpFrivOLNva3g-pq5Lg@mail.gmail.com>
Subject: Re: [PATCH v19 0/2] net: optimize __rte_raw_cksum
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>
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

Thanks for testing! I included my build/host config, results on the
main branch, and then with this path applied below. What is your build
flags/configuration (e, cpu_instruction_set, march, optimization
level, etc.)? I wasn't able to get any Clang version (18, 19, 20) to
vectorize on Godbolt https://godbolt.org/z/8149r7sq8, and curious if
your config enables vectorization.

#### build / host config
  User defined options
    b_lto              : false
    buildtype          : release
    c_args             : -fno-omit-frame-pointer
-DPACKET_QDISC_BYPASS=1 -DRTE_MEMCPY_AVX512=1
    cpu_instruction_set: cascadelake
    default_library    : static
    max_lcores         : 128
    optimization       : 3
$ clang --version
clang version 18.1.8 (Red Hat, Inc. 18.1.8-3.el9)
$ cat /etc/redhat-release
Red Hat Enterprise Linux release 9.4 (Plow)

#### main branch
$ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
### rte_raw_cksum() performance ###
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                10.0             0.50
Unaligned         20                10.1             0.50
Aligned           21                11.1             0.53
Unaligned         21                11.6             0.55
Aligned          100                39.4             0.39
Unaligned        100                67.3             0.67
Aligned          101                43.3             0.43
Unaligned        101                41.5             0.41
Aligned         1500               728.2             0.49
Unaligned       1500               805.8             0.54
Aligned         1501               768.8             0.51
Unaligned       1501               787.3             0.52
Test OK

#### with this patch
$ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
### rte_raw_cksum() performance ###
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                12.6             0.63
Unaligned         20                12.3             0.62
Aligned           21                13.6             0.65
Unaligned         21                13.6             0.65
Aligned          100                22.7             0.23
Unaligned        100                22.6             0.23
Aligned          101                47.4             0.47
Unaligned        101                23.9             0.24
Aligned         1500                73.9             0.05
Unaligned       1500                73.9             0.05
Aligned         1501                95.7             0.06
Unaligned       1501                73.9             0.05
Aligned         9000               459.8             0.05
Unaligned       9000               523.5             0.06
Aligned         9001               536.7             0.06
Unaligned       9001               507.5             0.06
Aligned        65536              3158.4             0.05
Unaligned      65536              3506.1             0.05
Aligned        65537              3277.6             0.05
Unaligned      65537              3697.6             0.06
Test OK
