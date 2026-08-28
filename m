Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB0C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 16:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C67A4025A;
	Fri, 28 Aug 2026 18:34:37 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id A586C40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 18:34:35 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1269219a91.0
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787934874;
 x=1788539674; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lIMRQRR84nzsepOIaKaLtxWeNkAyPyXQYuWFMejDuyQ=;
 b=N3edzQGs+gd5Ff7YLWalnMUVJ3Aa834DnrMkL4iU+8K1daX1/Mq7pSIwPGb7bY8MAd
 8AQY0sozOJ6blofBwSv9Xd7q4vXoi0BsvyuZZmqRJj8bJZbI7wjMNy3u0Wyxl1CxIQHo
 ymMUGddwAKrVpovJup4XluUvJqQGnPZRzI8cPUz5x9A1S32s/ZCNxVCPGTalMdQWAG6R
 bMd+qWjfuhD5Ck7at/1CDvvduS/RUICTW2ZVsTAcOU11A1YGB43H1nlsA+b2g4hGJOMA
 rt76+vk3XtcqxMFxZGym/vFUiCv3wcD4TSRK80IQGYEUZAfzPWlt6XGhIsgY7Y83h1p2
 pZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787934874; x=1788539674;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lIMRQRR84nzsepOIaKaLtxWeNkAyPyXQYuWFMejDuyQ=;
 b=EZR5CASUE9JXnig+5+9aFLQ/lSZ97BMV+geA3xRxL2ZUxxSHluQG1WT7dlQtCfpe+r
 AIiV+JF+7bvmuslirxKbLSTqZOLJqAEwwMvprR8/Ad96u71dCE8mWfzCJscCH1hfM4GO
 DIMnbU2SYXTll6F/aWdEsZGceLhxZxPnbDDuYVsLgkXlQ83f92nLNhw9N0XbXBfPJbPg
 odfbRKUJpw9hjlbyf3HLjKPTq2UEhrbxMweKi+r91Z6iwOTuNq9sUp8NCeL2rGEv6ZzJ
 /z+AvMxmZeFKeLI6rN3ED/SzunTRhM/oTieG3wNOkD7tFDG6DZEDVrLypv5wRpyZusNv
 k+3w==
X-Gm-Message-State: AFuF++mETJEfLpMZ+M+n5PlhVrjQwF6MObb6bXFPYLCQeNkcgiAwyE+9
 e22sj+vpeM68WqYnOVKo/1XQSyYSDs9Fwvfy62sI1gD0cm5/qSpJ/o6/Ts6f7/3C8yk=
X-Gm-Gg: AR+sD1339AaTwdugccTSse6w99XLK1fDS94MrsrRwFlBZW8pN4FxtVWQPvfbEJ+f/or
 Y82pViEevYlWMSMfwIEjkXh2XEL1KPvsmiZR3enWEB1ki8+NlBERNTzLmXPw/nPUXiX2Go6rRrO
 o0tGhCayl12s8Ad8pugE56srLeEz6XXqoGgKoArufY+dWTNIa+pOvJXQ4UlD47Q4ziWfV/lXKBw
 3WpOw5Qnd/T+GocvsuszOuNueiLoYjbPI7E6ORIRhX0KBiOQSdeNR4P6znQZP9rINFAMYEPzaRF
 IKS9PhgBBvXVihtoMJgWH+QO1Ql/8x+aGPrX8d6MkpCmUqJvIzQUusrxb2amaImXZJCW5kWdUgt
 AoWb5LC7H+O6s4dSRNCcfC4EU3xRSh4V8miL+h1EyjSZaDEpSXrKQkq5kymDrx8yhZTlEA3tWtW
 P0mBygZnLXdyi9AC8WK1dElpgqa1mh/BbM3PClF+m0CGKfJz9Bodl66w7wt9MUM4VTj46cynh4M
 ER3Xcoa9mcmTEbCb07PG5NN5ZIf4zXtRDkE9gi0
X-Received: by 2002:a17:90a:da87:b0:398:9be6:f998 with SMTP id
 98e67ed59e1d1-3989be8468fmr1666470a91.23.1787934874012; 
 Fri, 28 Aug 2026 09:34:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-328713b0451sm7830327eec.16.2026.08.28.09.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 09:34:33 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:34:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prudvi Deti <prudvi.deti@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, orika@nvidia.com,
 nirint.shah@intel.com
Subject: Re: [RFC 0/7] regex/hs: introduce Hyperscan regex PMD
Message-ID: <20260828093424.1ec4204c@phoenix.local>
In-Reply-To: <20260828053629.1224611-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
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

On Fri, 28 Aug 2026 11:05:49 +0530
Prudvi Deti <prudvi.deti@intel.com> wrote:

> This RFC series adds a new regexdev PMD based on Hyperscan.
> 
> Goal: provide a software regex PMD for environments without regex HW,
> while keeping compatibility with the standard ``rte_regexdev`` API.
> The PMD is a virtual device, created with ``--vdev=regex_hs`` at EAL
> init.

There was ongoing discussion in TB that the regexdev PMD should
be deprecated and removed. It turns out that HW regex is slower
than software.

It is good to have a software alternative, but going through
DPDK API's to do regex seems like an awkward way to do it.
For applications simpler/faster to use regex libraries directly.
