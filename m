Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 22:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E30D4026B;
	Mon,  9 Jun 2025 00:30:20 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 99BB14025F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 00:30:18 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6f0ad744811so25399246d6.1
 for <dev@dpdk.org>; Sun, 08 Jun 2025 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749421818;
 x=1750026618; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIUGvWdHJ0jfVhCcz3xU7kf0v2/QR2g8MCSaHbhUNrg=;
 b=T/ImIaBbF5MtDTJfC7p3d+1lacaDN3nLgOv3XCN54eg1jXoiuyICvWDK9uxkfyc4VL
 Lcy6/ymLVNfUc8Ksh3v5yLPI3PhK92R+TMgBNOpAD0KI9ZXNRHIEATPpsxEoIq+5zZ2u
 60gH2xAEkqvIfBUseHDkJ1XqJhSU7htUyDVKNypAjCRyy2nxDZQoN84LthOXfvtmKHUN
 DZfj3/Om+wuU9NJxhZY6O38T5Gyh7a2Y3Fb9Gp1J9eqQlfR4F/SH/LAsXwJqCCTyUW1y
 CS4bV+MjRJ1lfKhD4ilOna7mg7y2P2BWBVV2JuqmR8GhQP58mrSAcMwtVME5yyUxnPfJ
 /+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749421818; x=1750026618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jIUGvWdHJ0jfVhCcz3xU7kf0v2/QR2g8MCSaHbhUNrg=;
 b=aDzTFumJTLLzIAjY+EC/lEWQL5sHRACkIfaarxa3dxbsU+AfTArh4zbaCT5dXnvtmU
 uCU8OI0eUhDrW1I7sKCTns0EW7/uxtSsYAv4NQJJQH8qW5EtklN94Jh4V5vOisGZeZRn
 XJ8CcgdKK8LOJ48ErY6EGMu5W8vq2MHRmYg6izbcrzUs1EbXhZjcB+KJWMH0fAnmOOcf
 oksS5mfeHBDzLdJ24A+7+uL/DdddbET4dJ9mTvH++JczNHs3Bf9OlXPF54bNoMF5J9pT
 cAkJdQKqF7iEs27ifWXfldqrLSW5YYjHAuaYliB5Rne275jYCLOD90lUAqmM2rky479u
 0fSg==
X-Gm-Message-State: AOJu0YwoPUST1ff7hO4trpup6ENZMuijP84cguzhJyJx2Fd4O9pCU/i+
 0DaUvd+gE5uOwS5iSKaFdXiC1Eof4DSmp1didgkE1GVNiG0gseinusxj5aPRL2pW748=
X-Gm-Gg: ASbGncvV3h2cVjc+Ib1TsTnurni1eMULIMbTVpKAOcJCese/bZmUHi+NJtCk4JUrvxU
 Z2zE01xOuvwcNHJgfKuqF2z5HOSyo0UK91mSnZIjEzVSEC4zn8GJd+ySpNwOOw8Dzkog0Y3lvC6
 jxDl+iVrRiL2WpCnFuOm1p+g0KwGvNXA8oZnCsK2D7f+/NBxT7XZKAFb6Wy/QO4gYYlQxMduKJz
 9qq+ukK68XgSH++KjXWFb67fB/3B07XcoUUP3j6yYbu5EX5NxJxceIZboL3UOen99XbG7t1YoY7
 dp1nO3+I6099jStsci1e0GcixIhAooU6XOU96k7IOFg/ZuPlTUt+ho+wssvk5S5JnROWS05bou3
 LXnKZEXve8Fn3AvfE/OS1IwqG+oLD/9c8JQW0BTU=
X-Google-Smtp-Source: AGHT+IEjiFJUtOCaF8/0CTAbHrVCvwc0Mbl57VBXRxOapUOml5T6MdRD7skDLKiBqc/9bzTtuzHoWA==
X-Received: by 2002:a05:6214:d68:b0:6fa:ccb6:6036 with SMTP id
 6a1803df08f44-6fb08f8d31fmr175458426d6.35.1749421817882; 
 Sun, 08 Jun 2025 15:30:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b2a276sm42923896d6.97.2025.06.08.15.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:30:17 -0700 (PDT)
Date: Sun, 8 Jun 2025 15:30:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250608153014.43e47c69@hermes.local>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
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

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>

Applied to next-net with some whitespace fixes (see previous comments).

