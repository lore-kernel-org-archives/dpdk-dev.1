Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636DC369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 15:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E4AD40156;
	Sat, 26 Apr 2025 17:57:49 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id D3789400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 17:57:47 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so3345554a91.1
 for <dev@dpdk.org>; Sat, 26 Apr 2025 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745683067;
 x=1746287867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n44WuSKQMHUBdt6csbb3L2BQPuzKpg47TAwAzeuk3t4=;
 b=TU6DZWoe9l+aABA3muBNrBTpRE+eiTbyp3dxFIp5ALSYlNtmWklf1mA6n5TS9Lq4+k
 OMHNn7xcy6iIknUa0QtSgFhWOE2NpKdlnrubmNHZRRcF9wx3cpJiagO2cRIwG2F7UDzJ
 yY2j6q7cTBcQlZ7BqRtcLzdsJ4mWfwxoZWdTMoUNiREYz0x60Iq20IQaqCvfFRf05AJz
 xVFAH97jwSkPwlDZDZ2SanDN4PXuA3SOGIHz/yw9LVFirjXsMEIOBj0uEHrU5hl0UDX6
 2yL/xYoURzp+PGyWsePPa7Ny3MmXlj8vv7boV0Nv45RSeGHVnxSc/1f8IvXSAIbeH74/
 oSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745683067; x=1746287867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n44WuSKQMHUBdt6csbb3L2BQPuzKpg47TAwAzeuk3t4=;
 b=Y8dOBYuPr5O4Au4RlYk4dDpAZWtPEDT26Xzl/T/anpH0kMm5FkLM8s45/YHnR1Mmca
 t/OMBiPpgO7On2JeBSTc4OM378o/J7J8Y+WzAdNAOY6DX2dQ9fJlUaAqGknskHYjVXKk
 nVAVK6BGGOVWmR2489jRplgoMx8kyg4xrWW/DHANW+Vx+skrFXvgrsBedTT4qfeGPg+d
 i3rCNfcBbtUVO+xAQrX+Flz3sVmLR1cHUaQn/o/y3f7c6SvXjx2SvOZ+P6iPUneZSO1T
 jLrBI72acCwZN8lgBtt3KbTS+t+WUIFzZyKc11bRuZaJgT+LYDPtuDb7O1gsCPg1k/Cd
 m/hA==
X-Gm-Message-State: AOJu0Yw5GRbXPLoNDx61lZopJnUm5r+AC5Ou0lncxMRsgK9KbfiuGa6/
 Ay2gNzdDPNnHyXPliv74wjpLXJAKYr6Asn+JATOdwghQH+2KV9BCAQ1J3em5dMM=
X-Gm-Gg: ASbGncuNFLE7AzA4hCCrfTyfe9uLVYz/rG1F5e+yYdrWZvc8SP/fY2bR4Fy0OVM+rVn
 2QaacT5mvM5R9Fo4E6BX43wmjoEVkZNonRVJFyLF+XqMCr1wQ6N+o16YGsVzgSe8idA2aR6Mt4O
 ZCdmEFCumQu5x2d4sv3obP58hNKtA+OBIk48l2NFavzTZQg1siT/4XY1xTGRq7u/2FtkWZB2pQP
 KBxI9/yNg5+RZuRN5oN15VbsPYxmi5yp5n0Ppt9BAvfU2XZ3vbgKDQl0qajqMUxFc/2DV/RnDBW
 z3zGhO0VKh70y4bBAk02mewZOdcFnVa8MyFHZlNrvEIoBgPEhGmLhlgpd8ad89t63SX/9x7Joff
 vUJS7H+nu57o2B5I0
X-Google-Smtp-Source: AGHT+IFVoVXd72STuaH4bK+7CKWuuUMfcsCPxh8atRakZbzGm2PcJN/uxUlgf7VDcm5JvzLlJx5ZdQ==
X-Received: by 2002:a17:90a:c88b:b0:306:b78a:e22d with SMTP id
 98e67ed59e1d1-309f7df5685mr9017449a91.20.1745683066564; 
 Sat, 26 Apr 2025 08:57:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76fcbsm51407555ad.16.2025.04.26.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 08:57:46 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:57:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 01/13] net/sxe: add base driver directory and doc
Message-ID: <20250426085744.3586d24f@hermes.local>
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:40 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> From: JieLiu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

The build failures are because current main branch detects usage
of Variable Length Array (VLA) in drivers. VLA's don't work on Windows.

Best to just modify the code to have a fixed size buffer and process
in chunks.
