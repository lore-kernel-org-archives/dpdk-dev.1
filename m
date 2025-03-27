Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DEBC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 15:53:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B59406BB;
	Thu, 27 Mar 2025 16:53:48 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5273940654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 16:53:47 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-224100e9a5cso25009675ad.2
 for <dev@dpdk.org>; Thu, 27 Mar 2025 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743090826;
 x=1743695626; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJY5gdGmElBXxfHgp1lbaSbrp60T3UEj84kbFCDq1Y0=;
 b=3UnVpboX/qxlmiBk2JEbQQbF/lV2ceU7ZS5FxsS/rVi+CpxgEDlnnHErRhAhn3ZqrE
 Feb1Iao8Jwjuyc9Vjt1vHgmywOMavpO+wkLUb+PzDGXQiUMvuEyROtwbgr0u+0DxSobc
 /5oSeQcv9Ebi0SX+ODu2LmxbhsW14yx3bIfOlpCQcwvzGDaRo/2tS50cH6hQnmE8gxdX
 HEkStHooCCAt5R9Oj0EEyaKpP/Pew2586UWoZU9+76gHRUjj9JtHyZNfGg7TIVqxY8KG
 LhDtc8dLzXsOAm+sYMrYBmtIgOsq8EB9Mq1EX0EMB+hBmeOgUf4t2gPF12LnMZ4mxuOI
 0Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743090826; x=1743695626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJY5gdGmElBXxfHgp1lbaSbrp60T3UEj84kbFCDq1Y0=;
 b=FM/79vEBWTrMGaMM3kCvtIpM6gvugKhp8ljx36KZjBPOg286kSwe+vdD0dRVpGdh4U
 Sj+2Dknx2TCsnspF4Pejx8oIlgINqYi/oYaJp7IbB8474QLT/lJJka7YL7UME+qcVyuW
 sfvCzoHogq/ULNel4ilalTI4c9N16qi31lcq9enmyXFN2SkIBehIhHPlkv5tRNU2sJnJ
 qvZYJamCGoeibWPAK6hFOuJnO8t3IpKR9zUQF7xHF2WXtIBjBOOgNeiddXIIzZpL98WV
 B5pMIE49cKwqW8FJkiFFLFuXYKlNfzxJ24sFpLYk0APM0th4SH9YUxi39LMnrxQAixQ9
 vHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPAoGbFbAxFQqfGdEYdz5xPaPl5RSPysKnu9ZW8lg/bnhELmleZxDkhlktQm7SbEK/bMg=@dpdk.org
X-Gm-Message-State: AOJu0YzJaoErNnBQ0cIlGXVoRK7VHJ14HRyQOtEdcHBRL+MN9z26AZRt
 HD1l4/iD8T6Ufo0dCB/XYzXcgqU/DPU8GWbdL9pVWT+fsmR3lyqpGRS8tN5CUJE=
X-Gm-Gg: ASbGncv0Fs3kMusyiXuoXw8O0baxUQvvURhg5EN7pTVtBsdyQkjbCY/B5QJVkaaIynq
 E0mcgvjWKGefGgJ5WXxQ1u4saRzD9QN1Aj/4qVsPpNnWsdWvofciecTOhbMivwVuS18V0L+5zDb
 FJia2e08Wt7yHwTsxPX6oixB+5fRkhFX2GU1iT4AYGewCMHK+zBJkQ6cBeZd+RA9DTdL8Mtb3/+
 atyHJ+TBRZtQQzx8nzQ/bfpY+J+jCEFQd257r/IGUUNiV7agI8qM8DzD+2RunUh5IeJEJqqy1N1
 G9KDMgdrnFS7Qn3Llh5hsxeAoEl+mWrt8eRzBquowXpepAmVtAx6qW8oAJQSkLVJZXgngRqprgr
 fPk1zcO6Mss4gSHf9D6FG6F/22G/Q098=
X-Google-Smtp-Source: AGHT+IFgGgeswyQ3tHUF5VA5VJdhq24ZpAVGGnBuByYkh/9fUVIiUt63IEYPAWPxMAG1HHu2s0V6Ng==
X-Received: by 2002:a05:6a00:3927:b0:732:5611:cbb5 with SMTP id
 d2e1a72fcca58-739610304d9mr5861856b3a.11.1743090826135; 
 Thu, 27 Mar 2025 08:53:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158620sm14883337b3a.136.2025.03.27.08.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 08:53:45 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:53:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/4] enhance testpmd DCB command
Message-ID: <20250327085343.4a98b5db@hermes.local>
In-Reply-To: <20250225091929.25072-1-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
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

On Tue, 25 Feb 2025 17:19:25 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patchset enhance the testpmd DCB command features:
> 1) remove restrict of number of TCs (currently its 4 or 8)
> 2) support config prio-tc map
> 3) support don't adjust queue num
> 4) support disable DCB
> 
> Chengwen Feng (4):
>   app/testpmd: remove restrict of number of TCs in DCB command
>   app/testpmd: support config prio-tc map in DCB command
>   app/testpmd: support don't adjust queue num in DCB command
>   app/testpmd: support disable DCB command
> 
>  app/test-pmd/cmdline.c                      | 184 ++++++++++++++++++--
>  app/test-pmd/testpmd.c                      |  96 ++++++----
>  app/test-pmd/testpmd.h                      |   5 +-
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |   6 +-
>  4 files changed, 236 insertions(+), 55 deletions(-)
> 


This series needs to be rebased for 25.07 release
