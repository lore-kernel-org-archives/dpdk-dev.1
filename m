Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E35E87834
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B45C4029D;
	Tue,  3 Feb 2026 15:35:13 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 043004013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:35:12 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso27184615e9.2
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770129312;
 x=1770734112; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQpi/RvxkZ+bEC2vxGtuQ6IC2FE9Ayv52LTFxyHpSY0=;
 b=bXmopfV9DaKcDUaCOTtOz3WpH0x2hIO4IGInmiZp2jjLqe+1JbWbm6EtYia8fiSWtj
 SjeDNE+dqX8SV4fB2wYoKtAD29WH9GwvWg3Tb91dtEc5dnQ3Xp3ymbDXoH/xKdRKV52h
 XXINtkGge/JSRYuKdDhm1H75Gf4PZoKgfnNxBjRtWIyx6sIl3jZ9e6HD7hLGqqyRw++J
 5JF1tV1n9iuDw7OQu7hPLD7gWfE+NHcNdX4elEuBEJ5H8dv0qZQA08H+C5mmUMVZjkVZ
 QG0S8a5itOpN20dy17SMkOn7BRfhtiEu2ofuc+PlhcKPD0TzzNSkiUbXZxAdyRkd/7H7
 pO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129312; x=1770734112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eQpi/RvxkZ+bEC2vxGtuQ6IC2FE9Ayv52LTFxyHpSY0=;
 b=dk3OF0C+HotvZkQWDqu3K2e5oRk7uDYYMavafJJkFHPb9JX/n3GwLEPHOM4WEQxcoa
 HcoOcJWSr+xxNp3D0aAnvqwfQ7/u09D0ygNYr3/sP+7l6klP2I/MYvKQnxTD1hvFQ8tx
 trKqHdQGTtlhoRoY3H0d+LFsghwr3/1/sToWTDm6aHwRFpoUJSaD45BKg0X7UQNmBQCQ
 kMKVMK0x+3PtptMwD3n6OWRm0cOn43u0hXfjv9OhqE74H4pE8RtQF5eaZjLqEUPRlolD
 1g3tKKPF8pgM+6U5tVDUeXQzNFj7UCqeHEQP+V0AbJ0XopnKsGhIdIAJvImEBpFv5srH
 9Yfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBxRNgWaObzh7ssz+nuNE3arsmJvgdtokP0/XPnCUbrkSjkMxF260ccSmrEG5YU1U39WM=@dpdk.org
X-Gm-Message-State: AOJu0YwRNnAWt+ckSXVqKX2qNWfSJnunkqpsS7wCw9IDpvHXV8A6fAVL
 5Vl4hGsUZGSQqjmJVtPSDdlhlkY3ZpdiKf+5KymqaVxEOn+RG72CvKwW5f1/Ow/A5Y4=
X-Gm-Gg: AZuq6aIhjl6+BzaDLpDj04X3DjduHvXDVrSUDVtJ0PcqgYpCRDIp6K0ijw+bP6y7Bx7
 ZxKJQjUJz1eLIvHGqzo4DnWPjDnsU9wN4zyHUUGWJVZzm0YFNlKIwdEN6KDILev2aJi3Fji3Rn0
 poVBNkfzWTeXERw4nkzX2pjsFCywSSRcxOfoRiGRBMtM1238rkLew06W/DVvCssYlJ90A3O+nTh
 awsHB9hQMTPrg0NJpmG7h8bqi4RAZ/62snmdWGn1qZoMw/0feHjQRE/ItP6ux4MgdsLbixNvzT1
 J9TvynaqUnQb6BPejIq2AXXtsfrDtti/x/QP/UzmwNgXm9uQuwYrDOc7pIFZDhf2i58NJN96YOU
 zgnvmNycsd+NuVDnpoU2FDJri3XMAVsWIPk60hgRpxLP74QnMZ+v74Cmz2JpAOnLONdT5xfrBb8
 9tW7cLhbN3r1ygMXFY47A7Lc+Nkr2XQBMSgTV8q4g2jChn60cBrbTy
X-Received: by 2002:a05:600c:3b23:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-482db49e661mr203054595e9.13.1770129312477; 
 Tue, 03 Feb 2026 06:35:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd3953esm144878455e9.4.2026.02.03.06.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:35:11 -0800 (PST)
Date: Tue, 3 Feb 2026 06:35:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v3 1/2] net/zxdh: add pcie bar channel check
Message-ID: <20260203063505.7c40cfa7@phoenix.local>
In-Reply-To: <20260203071732.2601630-2-zhang.tianhao2@zte.com.cn>
References: <20251230081127.813605-2-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-1-zhang.tianhao2@zte.com.cn>
 <20260203071732.2601630-2-zhang.tianhao2@zte.com.cn>
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

On Tue,  3 Feb 2026 15:17:28 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> After obtaining the DTB element register, check if the PCIe link is abnormal.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
> ---

Ok, but the commit message is too terse. How about?

Check for PCIe BAR failure after reading the DTB queue
buffer space register. A value of 0x3F in the low bits
indicates the link is down. Also return a specific error
code for DTB timeout instead of the generic ZXDH_ERR.

I can fix during merge.
