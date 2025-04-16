Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8852C369AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 00:06:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15DEB40B92;
	Wed, 16 Apr 2025 02:06:35 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3610040655
 for <dev@dpdk.org>; Wed, 16 Apr 2025 02:06:34 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22401f4d35aso71350065ad.2
 for <dev@dpdk.org>; Tue, 15 Apr 2025 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744761993;
 x=1745366793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9ATfa+zMYEhb3euNN6C3YDRajyxfg8ldok8mfLkWpQ=;
 b=v04CbiKKckCpmSyuZSi2hNgPjcbrYIJvFbmH6OvHc4tLXl6aF/xc9wFP8AAJ4moCRE
 /dUnU3ti+DYHpbiEBuwPrR2Y7lsl2oPTkcEdK7mhZIkhXJkpTwnn0lbG8JhQ9TkLlK5K
 8msjTyCH8VXiPSCXQ8eQjko3XKxv/Q3Ii4EmlW3puSNOFOzLdsKeZ2pVZ47hQWHUH2sc
 NKdoZwUP3sK6HezKtHzX1ojIO2fS2hfKD47+qmSsMNF5ycpeoScYaMUQnDUPPzdUaYP6
 oqKoDvqPAPvtxtu+gOTPiLcLCNM8Qd6pHjiM1SaHA9pU3W5XpBIwSJTWG5SV4y12Etri
 bCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744761993; x=1745366793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9ATfa+zMYEhb3euNN6C3YDRajyxfg8ldok8mfLkWpQ=;
 b=iXne0G2DPRR/UhAUTzDsjB+3g8X1i3VNbdXVRL8lNEIfrjn8aDZTUaikRkyFi7w94x
 qAoCHpMGdNc2AWrV7sg6I8W8Tgbq62R3Uneag2ZIgj1NT76hkPaiua/gy/GDLS6TvpBR
 +cdFOC6JrVbsGDiakO1ughsYHZ43j1fTIxU5mjKRu5f69mNtJrxMyCNiQ1YHCpRlLxi8
 7ahDyqMuCUpfQeKIrXCuMr5nwgMCYCMzmtGWPntXgJbVnbd1PyCF+zJbNooWc3UH7afp
 wdCcbmiOBcYM4AUtX6Ys7KASSf4x6FX3jFS9XRbz7VE8CS1wBCQkPF7J/5ugZ0KbHeTx
 zPZg==
X-Gm-Message-State: AOJu0YyUE82hErWlBYioc0ailcd4ueI1uZ+Nm35AMHjNVodU0saPmENZ
 syCRO21qFVEhD4OrC8ZiQ8jI0VZ6Pr0CU4T2ADZ2d8txnSbfk7XdeRWqslG76zk=
X-Gm-Gg: ASbGnctQ1LTl96zKkWBeYBsfp/qffSpDyhyjfgQG+AVL9NVZ1ZbDyN5ajbJg9i+96a9
 upYZ/OLzhgQkJLaqqRIDmMh0DdTprZXTXvlrjnl3+otIdqJu9X701nvDonkDo1ceTqecqcdeJc7
 m/RsNek+ta7/fLx67SXMYONvnBKHh2sscNcuKRmi+3tsm195cVIs4UKwGwvPtX8ViqqrIXhEYiX
 wwzkK4VF1bBvk9tdT58BEIjBZpidqtwzXxmfXY+5S27+ku3JkvpWNFCcizY9OLD48FBBJThpC9K
 i35bGqCSnL7hdKlg4efBXnR30ZHBytjzycWlbd00NdGT76wzcBQ/eVnlSJu2xns/1p2KQ+qW0uN
 Dp38q9Objg4WfHCRc
X-Google-Smtp-Source: AGHT+IGDUTKe6p+okaclPhxWOpK6/y1x6nW6A0T1YLruVVTMLNz8eIvuOkiQ0Z8YKWVj2NFPp+SqXw==
X-Received: by 2002:a17:90b:3ece:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-3085ef0c157mr1744707a91.9.1744761993280; 
 Tue, 15 Apr 2025 17:06:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3086122a8absm207532a91.35.2025.04.15.17.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 17:06:33 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:06:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Chengwen Feng <fengchengwen@huawei.com>,
 Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [RFC 01/13] app/testpmd: revert auto attach/detach
Message-ID: <20250415170628.44bbfac7@hermes.local>
In-Reply-To: <89e4321b-4a28-400a-b54b-b723de2f6730@huawei.com>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-2-stephen@networkplumber.org>
 <89e4321b-4a28-400a-b54b-b723de2f6730@huawei.com>
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

On Tue, 15 Apr 2025 21:28:07 +0800
"lihuisong (C)" <lihuisong@huawei.com> wrote:

> Hi Stephen,
> 
> The main cause of cpfl driver attach failure is the added alarm in new 
> event callback to setup port automatically.
> It's a question of when to set up the new port. Please see the 
> discussion[1]. I have a stupid method, but I'm not very willing to do that.
> For the Bugzilla id1695, I'll take a look at it.
> 
> [1] https://bugs.dpdk.org/show_bug.cgi?id=1671
> 

For now I am going to revert the testpmd change.
Come back when you have something that works without breaking pdump application.
