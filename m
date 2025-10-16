Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23CECCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 15:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58FC40E48;
	Thu, 16 Oct 2025 17:57:42 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id D090F4026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:57:40 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso1368905b3a.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760630260;
 x=1761235060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1or7BRvrnhIRwmMkdEvWJXKLjDmgjoJaw/L7At9H4ZQ=;
 b=B994vV84OGkbg/qCxah6Fw3EhNmkDPUFrdGuuUDXVc72sKgiWfMEhdtqcaTQBS0PII
 PTYrTlWI5gu1ABLuzFJxMartg4rfdaERBVD1fbWOcMHU/zvY0etw4UsbfBOK/lIu0YvN
 vxE4F7YsHzYEm8ljmF6V0q0SQq4YdbxoHMnHsMHuaap0D3w4onui00v1FKyLDVjc9vIg
 zINZ0ld03t7mnmo1kj0ZeGbtxjSwCSt8YIM33a4FvKFGdpCMJWOk4OSIAFh9cd3ELFZn
 /sOqeftNyXfb4mlzhW4En2hi+44PkgXyiENPCCkv8ST4MEJYglVgc9tt5MI9vJwj9T8n
 Lbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760630260; x=1761235060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1or7BRvrnhIRwmMkdEvWJXKLjDmgjoJaw/L7At9H4ZQ=;
 b=PLZ6UgMGeLEloVU4/YETP5IZgv4BknOhJxzrS8WmoGvuXMgmjLJ7QHYWYO5ap+LbK5
 2NzpuRhS34bheAMSzQFTpE+zBgX1PN4bUQ7zKO44hTVZ6sd8RHNW0qiPUM7h6gqiFpnG
 yiB6buoCPjSriSy3i5O2Yo1etLHMZ8OPczTGh9aAAMa937LGtwSZxurawKgOWSUMVT2S
 2KWY6a6mN5NokXFJc4UpOMs6aW67nUWJVr+6iswwbl9iPTiwWycMtGWBYluPYJMDWQQW
 6xB1TLUkVL3uoYHaH44fRWXd2W5M4Pe9LpgisHjdEcd5uu+9jq9NqyAeea5z+YeEWTGR
 wBFA==
X-Gm-Message-State: AOJu0Ywlf2RthASpG6Tj77BrVFMajcpjvUs1h0ndxEfOqE7Y2BkCBIWn
 PGYJlpQAQZ9CWz7ERqz1Tz0zQukCaUtCNk8K34+RtnY5J2n9g0gEGHc/qnmiOmdG9Z4=
X-Gm-Gg: ASbGncstUflKrOvPDozoitbPbgKiQHosiqWmIm5GSMUBBbJBVjM/jzF8vNAQobv4kpR
 +9KGA9VbK/lw7TAMPZCm0bq04BDfkUTou1aF2WuRzCLTJ3mBfkToO6ZcWRtIJMtrmkjKyOMGiAk
 mdEpUOh92MjmFiqwOmo0evS9iC4Pa6wEEwT6s99fbJf49xux1X85WE3C9PLdAnvBTDbfgNagmLA
 pwH7EK2dN35dYGehScQfupnYOPwR+U6kfE4bC712kAvkzgm4VEYIqu5oM/cTtZ6Y1Cf1hyyFebG
 K0DpGVarIkUHSc8SuuzeS9D9iDiqXcmZv5Lq3DTiaC3eX2vugJFMr+KjrJjEFJCqxn9+oDb/k4D
 4HLt7NfYSdoV1g1Xq/9XJhyMZNLizBw0DK9oDbfdVFLsSybv1DP2tUkCSNkptyOIwEt19tT4nJN
 +4NBi0NY+DbyXs2GDDC79FOnMfdZvgVPnifVPbcGwPmcn/GquV9TRsJvMPJujQJ2o=
X-Google-Smtp-Source: AGHT+IGnDczr1xHwH5z/UBREuOatYb2Z8IuyHT8HG+hebuAMoPfwdgbxaKoJLnkh7ws/5a+bh8Q4QA==
X-Received: by 2002:a05:6a20:3ca5:b0:2ca:83e6:938b with SMTP id
 adf61e73a8af0-334a86383c7mr587194637.45.1760630259817; 
 Thu, 16 Oct 2025 08:57:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a22b9af2asm3259252a12.28.2025.10.16.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:57:39 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:57:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>, <liuyonglong@huawei.com>,
 <kangfenglong@huawei.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>
Subject: Re: [PATCH 0/2] bugfix for hns3
Message-ID: <20251016085736.304878f0@hermes.local>
In-Reply-To: <20250929113554.2443832-1-yangxingui@huawei.com>
References: <20250929113554.2443832-1-yangxingui@huawei.com>
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

On Mon, 29 Sep 2025 19:35:52 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> This patchset fixes some bugs.
> 
> Xingui Yang (2):
>   net/hns3: fix VLAN tag loss for short tunnel frame
>   net/hns3: print invalid MAC address from firmware
> 
>  drivers/net/hns3/hns3_common.c |  6 ++---
>  drivers/net/hns3/hns3_ethdev.h |  1 +
>  drivers/net/hns3/hns3_rxtx.c   | 48 +++++++++++++++++++++++-----------
>  3 files changed, 37 insertions(+), 18 deletions(-)

Queued to next-net
