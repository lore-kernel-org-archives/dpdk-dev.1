Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79937C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 18:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77BE6402B1;
	Mon, 30 Jun 2025 20:43:52 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id EDDCF4025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 20:43:50 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7d40874b399so216964885a.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751309030;
 x=1751913830; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HriyCuJJNqXF3cEmS4QRwuDWMdblUnFporJSX035IoM=;
 b=LLyMgBSKZF1Je8Nix9oqflb21lz3L+BJJLlQpFHqOGOkOiuc3INS85oCT2wD43QBxE
 DoYDskeuoshxWY7OxFG5WsuqVe9qSmrPNFGfzi6SAWN+Gr4oZlps7kbi5gT4TLSnDWI2
 lyWheDmkRyG+e1OEfhpKB6ZNROnErGzmZrwlCrJYZYFcde6Umw1DoZjODWkKscn09uWT
 Gta5TaFEu5l0Q9SW2R18fyg60iJYgysNKpQ7kNrZXfsfqcdtoxU2vqfcXfa1Vc+IEZpt
 YUW6HxtFZnh93hz2EEi/JraTT+gchXd5xFfJJfLL1+IHypooFE9XaWMUUsvymPRnNdRa
 ayzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751309030; x=1751913830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HriyCuJJNqXF3cEmS4QRwuDWMdblUnFporJSX035IoM=;
 b=P2eTMWZoUGLdaZA2vmf0kwEUKKCAsmxfx+sHDm29SK8o32tF6C13mCLUZQ2lGqSjDz
 WKlTr07s7FhNAbW476Ve57wvgE1RzF9Vr+9QsF8ZEojStrlN0AVJkGOdmZ4b/r5e44Ye
 xHaAs2f9g6vCmTIq41LocnT6VEa0fIy3eQlpZFtap/FRXq9s+hcgiM6HO+xKb3uwUHhB
 61QEqfLTM0qyKz6CPPTC0CHGcsg+X0RdwE69UPJWp0t4fQkGm9YCfXRHJXu1DUE6RDOC
 vYPnp2U+S+6+tfxdtzFATLvHL2ZIam3GyjrWPkSCD7B1uDAYpsyuJPdrrT/ODo9AgrNB
 vKLA==
X-Gm-Message-State: AOJu0YzRqL+2OBXUlagBGr8mCpEc+o/QKNv4S6c23RBXglO97ZR7iHNw
 /qWqguCSliGNOZAWZ34g0HDfYNESCRWkzvR31Jf7lglhF7DahLO2I9j9F0zBC1QdP14=
X-Gm-Gg: ASbGncuJa0L2lMm+e0grRfFrlWuKXo2u4VO/c4vNHKvDRCsxvGAZkWs3TT72Y96C+he
 ZhWeseq4Qm5ECHurv4Q1daz0bi8B4C5y8+L8DsGQ0J36ty+g1dFYasb4rI3s3TYLGaWy7J7ejxo
 /djwRz9LynNN6/0kDWH66t+FWk/eDgZn17hvlhKdsHEdQafETbDlMg0MfxV/CA0erPK83U/c979
 QvlMck8aTaDYc22re+Um7CBXuspvwqFC0tRVqsZo2TVoJD2j1GHXnTkq1Xne0qcz0jB7a9Rd9P7
 QK4kaKExgkTQTLbRvTrenkJ4KfvDFJxUPg1qqpD6p2jU88sWJgFyObBgYUuO799JvCXqGTBpoUw
 U9+tvAUG+rYGNgUXXFM834yeb5bHbIgnQUYSgb8c=
X-Google-Smtp-Source: AGHT+IFyPAIp1ZQTADax87PQjLNdWvWYjPx5A0aZ8EGJ/o7qWmXv6ZrcrrNbv/O0l/7ucmED7OP+1Q==
X-Received: by 2002:a05:620a:1917:b0:7d4:4b09:e327 with SMTP id
 af79cd13be357-7d44b09e4c2mr1577572985a.55.1751309029973; 
 Mon, 30 Jun 2025 11:43:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44e13d800sm453032285a.71.2025.06.30.11.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 11:43:49 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:43:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 0/7] net/ena: release 2.13.0
Message-ID: <20250630114347.35fe0bef@hermes.local>
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
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

On Mon, 30 Jun 2025 14:13:51 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> This patchset includes an upgrade of the ENA HAL,
> introduces a new feature, and addresses three bug fixes.
> 
> Thank you in advance to the net maintainers and community members
> for your time and effort reviewing the code.
> 
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
> 
> ---
> v2:
> Removed patch "net/ena: fix virtual address calc for unaligned BARs"
> which contained a problematic casting when compiling with 32-bit system
> 
> v3:
> no change, there was some technical issue when sending the emails
> where part of the patches apeared on different series.
> 
> v4:
> Each patch in the series should compile independently.  
> Patch 4/7 causes a compile error that was missed,  
> as the full series passed our directed tests when applied together
> 
> v5:
> Reworked the patchset so it applies cleanly on origin/main
> due to release notes mismatch.
> 
> Shai Brandes (7):
>   net/ena/base: avoid recalculating desc per entry
>   net/ena/base: coding style changes
>   net/ena: separate doorbell logic for Rx and Tx
>   net/ena: support fragment bypass mode
>   net/ena: fix unhandled interrupt config failure
>   net/ena: fix aenq timeout with low poll interval
>   net/ena: upgrade driver version to 2.13.0
> 
>  doc/guides/nics/ena.rst                       | 13 ++-
>  doc/guides/rel_notes/release_25_07.rst        |  9 ++
>  drivers/net/ena/base/ena_com.c                | 40 +++++++-
>  drivers/net/ena/base/ena_com.h                |  7 ++
>  .../net/ena/base/ena_defs/ena_admin_defs.h    | 14 +++
>  drivers/net/ena/base/ena_eth_com.c            |  6 +-
>  drivers/net/ena/base/ena_eth_com.h            | 15 ++-
>  drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
>  drivers/net/ena/ena_ethdev.h                  |  4 +-
>  9 files changed, 175 insertions(+), 31 deletions(-)
> 

Ok in next-net branch now
