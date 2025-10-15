Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA69CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 06:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD0ED402E2;
	Wed, 15 Oct 2025 08:41:30 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 251E6402D1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 08:41:29 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8582a34639aso476561685a.3
 for <dev@dpdk.org>; Tue, 14 Oct 2025 23:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760510488; x=1761115288; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycCfv5cKLf0uynN1y8U5W2VkNux47Q0HumEXx2Mhn/E=;
 b=OIqYMcQhXtUAolgOb/jnUSLJh1fqE37PceAa4nPi+lBgKKS5vgJ3B8OSCko5wZLWer
 a/q8z+PBkPRaESyZufsm9IDpftvzmoK5UfhE9DuzPqe0WNVcbGCnokB0HQVmCKu1fNT2
 tm5gm2EDUUa70FErJ5RsT6i1hZxK+tUOTJnuKBEczB20L473tw+G+53DMWFtTdiHLuxO
 RXfx22H3t9KTlc14NHTypfXPcsOn2VZSLUvlKeGeCzFy00VbA/QnOl8fdU92bsSkqjxY
 VuixffgyZzfyJUU/cbwyaxsGCioMV9E2BgYx/LyorySVNwrfmO3VStEqyGI6lYsB90kt
 M0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760510488; x=1761115288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycCfv5cKLf0uynN1y8U5W2VkNux47Q0HumEXx2Mhn/E=;
 b=ta3cl1+jQHYC7hoglSS6DIVjNYm9258UPKXmSIF4c9607v8GW32H3jbbuF7sD4Dx75
 +Rb1BKzdOtUfJSeRHBgQGrOmFbwHHWxjzaGgNaw7KR/lmhVXOoF6avS51TtKPDv8M0do
 XF5cDgImNaeRGG5tuVYmzLlVHBZ/bh/0fpMCby7J6fyJ6lZx8jfL7enlxGHjkIo/ZfQ2
 z1Na8g8ZcYQvrtD8t7wPE0k04IRgDFkPuwgvwWfNYZfvM456bF3ESouEdUV1kuVFDXYf
 2IbpdL851B5hu2ubdjpj5KrVL4ueivxmdPfHMrm/+R8JQhrI5TZ9bnZ+wmn+i37okExp
 am9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZuFJzt2fMXSyELb0phgbzcYP/+Dl59o4iZ9sqU0MjFVErwH7hWiQSr8D4PgOIt+hCZI=@dpdk.org
X-Gm-Message-State: AOJu0Yz3Bvqzz1TPjGhSITjFoMmbbkXHUHzpasB3XJoEd+XlNoFJ02Yw
 E5dEEAih6/6kUDnPCaoRfGe5ZeXC0bIve9Ow+7mEOhdCd1R9xbJf59lyxx/uZStDRW3jcmBRqAL
 OFwIOEmC0zDCPjlt8SAHjoR8yIpSmoVc=
X-Gm-Gg: ASbGncs02XWSarkedcjrvztvOhzS+R0KbOsMkSPiekjyZudraJWBAEjupC8WY4bIny8
 SlkRgBMd8C4mUBGExR6JakEWHmSpCCVqT17ZiCIGRkLkEdeWmklQYuT8U/k9GMXgq2fp2rdcyAu
 tPyFt0jX9I6DiO6oOFEmj5vm49x184WwJH6FR+mVURPXYWNaR7qpt8pdtq1SD2VUCwvy52Yd6sj
 0kPUflrI0b/tcXHzu82Kix0+PX94zYIa1H5dtnZLb4caBIZXT8LhSxWPoZ59c8HrPcJO4CPKffr
 YjXcL0oKh4IyzIU=
X-Google-Smtp-Source: AGHT+IGHctSaC0x2nD5gNOWSE2C3Y7F2z2cCYWZ2uSuv6l0OCxN5S7WI9UEJEXZd8TVk0cfR0ECDlfaZTU/GRA14QXE=
X-Received: by 2002:a05:622a:988:b0:4b5:f432:c2ec with SMTP id
 d75a77b69052e-4e6ead83e11mr400607021cf.77.1760510488199; Tue, 14 Oct 2025
 23:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
 <20251013065949.200414-19-ndabilpuram@marvell.com>
In-Reply-To: <20251013065949.200414-19-ndabilpuram@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 15 Oct 2025 12:11:12 +0530
X-Gm-Features: AS18NWAP45FFcBFsxmTz2ClCugS-8LLf-Ouri8DqtQVOJF_GJ-QEPI8dMDJFgJw
Message-ID: <CALBAE1Mp4wnhJXvCNz+ApzTCtJESpkz86nTgnDFDJb9S=cRoBA@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] drivers: fix Klocwork issues
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, jerinj@marvell.com, dev@dpdk.org, 
 Aarnav JP <ajp@marvell.com>, stable@dpdk.org
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

On Mon, Oct 13, 2025 at 1:50=E2=80=AFPM Nithin Dabilpuram
<ndabilpuram@marvell.com> wrote:
>
> From: Aarnav JP <ajp@marvell.com>
>
> fixed klocwork suggested issues in
> cnxk component of drivers module
>
> Fixes: db5744d3cd23 ("common/cnxk: support NIX debug for CN20K")
> Fixes: 3c31a7485172 ("common/cnxk: config CPT result address for CN20K")
> Fixes: 4b8eb5bd6627 ("common/cnxk: reserve CPT LF for Rx inject")
> Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
> Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
> Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")
> Cc: stable@dpdk.org



Fix the following issues

### [PATCH] common/cnxk: add support for per packet SQ count update

Warning in drivers/common/cnxk/roc_nix_queue.c:
Use plt_ symbols instead of rte_ API in cnxk base driver

### [PATCH] common/cnxk: add support for SQ resize

Warning in drivers/common/cnxk/roc_nix_queue.c:
Use plt_ symbols instead of rte_ API in cnxk base driver

>
