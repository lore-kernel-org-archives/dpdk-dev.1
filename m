Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B4C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 11:39:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 360DA4021E;
	Mon, 21 Jul 2025 13:39:23 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id C12B64014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 13:39:21 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-313cde344d4so4348147a91.0
 for <dev@dpdk.org>; Mon, 21 Jul 2025 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753097961;
 x=1753702761; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkJxfN0T4T5iQJcj2T4EaSzrA7mQRtGtqYbIznmpc1s=;
 b=Jw4di5pdDp2k20M4iKi0gr7edUlBTVkgc1vVxQ1wXv/ke6ZWB1avLBjwiMRmk6sSw/
 1cWRg2SMN80QFbO+bLOR8RJdhZ08vesV5ulcvMwwy/fl1CpENXZ7ZIbZ8TfQc0XrM088
 mp0IQ26Gp7LG3jC0OKV0JXCzCsZksE9mY/iRgQsiHyRjHB31ihy3Lk7CGCpx0WAEFbIs
 zlnCtneiqxzexrGFtwqym5mGyluImpMtDNv+bRXrbZxesEFgFN7oHJh5z6hPXkkh/Kl+
 fwhU8uebPzadXQxvWDnkzY7KOuM4H43vko6bXmJf/7LObwlk5DDRhjJ5lePsWqaVRXlO
 2OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097961; x=1753702761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkJxfN0T4T5iQJcj2T4EaSzrA7mQRtGtqYbIznmpc1s=;
 b=aVQUryE7/mKHWwg+ec9RHXjfM/Ol2d5q52aY5o7yO+1azXDO12JS7Y1bkmiLTQeZte
 BzCMbBKecwAI8lAP5su76SXOg5kIw9uBjek7d1mXkE/fCiIloi/DsW4SoSVfQkmYsAVc
 fUsVBb83nzTfdhIYA82s1O0oIS1slm3Sdvb2n+2d6oocf3+y3S1jnV+v5Xu9OmiaUapv
 TyOjBBdg0Q0dlYjMhsXSB/lwX5WS3QbO23fqohTnd99kn9YL+xLiPdXd+C1IQnwBDcec
 tfM3B16Uaby6jED7y5C1CVK1wFBL9LNEP5Lc/h9PCxfgTxwgKBQc+G2vCwRTgVl2TAtK
 15ag==
X-Gm-Message-State: AOJu0Yy+JUtFAjCBcshYXbDOwYaD7H53SCRgWLzhA52DhhbS7P55Umku
 z9MeCQ9ZRCfn/ZgC+6DgTXolWFZUr6fzG1UJ/lvpwrACkTJ+mDKbHEmoubaacN41Qqs=
X-Gm-Gg: ASbGncvxCBNr5H5ze2Q6pMcnzLKgwCGM8P9p7Upevsa9TS4NMG+72k3vvNF9WhMUx2F
 2sKC1MVd5S5VNV46F/TbAOUW1i5+m7jdlBo0sGd+93WojgArPGx3N5oP+Z/ZI8Lkzrpv0WwdLo9
 Um2405zzaAsxlZIitSTA58I7tsbW18aoZRjDaGFKffiJyA9dh3NQSxc/Xjzlkg17nakCuQU2lzL
 QtCqhjrhBjNgnCoWw8OxIDtqmp8lPfddYA8/4GHWQX53xdpbDy8qR0+zNMuv6hAiQgJz+i6+oFS
 MN9YcvC9Ow9Gy/3/3cof16qSv/qRvFI9Y0ZiErcABNCqGw2DTKwUznDJsy1HzjJEDpGzFWMLCzz
 40kpLOjr6vQKGWuOov0bJrAmab+SnL5JyCuX1F963skiSQrtp
X-Google-Smtp-Source: AGHT+IF0PqcMHCotoOXGGv5n7pa/ezlsgr6ztLyJspn2wcyjQJ9Sup+wHTc/8QtSy14eCDKVwaj7lw==
X-Received: by 2002:a17:90b:4f49:b0:31a:b92c:d679 with SMTP id
 98e67ed59e1d1-31c9f44e3c1mr27858770a91.35.1753097960797; 
 Mon, 21 Jul 2025 04:39:20 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cc3f2e215sm6035428a91.33.2025.07.21.04.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:39:20 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dsosnowski@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Date: Mon, 21 Jul 2025 07:38:12 -0400
Message-ID: <20250721113822.1029342-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
References: <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
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

Hi Dariusz,
Thanks for the feedback. Agreed, this check only papers over a deeper issue with
multi-process lifecycle in ethdev.

If the primary process exits after freeing ethdev data, all subsequent PMD-level
calls (e.g., dev_infos_get) in secondary are inherently unsafe due to dangling
pointers.

Unless ethdev explicitly invalidates the port (or secondary process detects
primary exit), the current behavior results in use-after-free regardless of PMD.

For now, this patch avoids a crash in one case (dev_infos_get), but long-term
a proper ethdev-level solution is needed — either by:
- Marking ports invalid on primary exit,
- Notifying secondaries to teardown,
- Or refusing API access after shared data disappears.

Until then, we can keep this as a safety patch to prevent segfaults in common test scenarios.
