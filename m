Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F97C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:57:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CFD34025D;
	Thu, 26 Jun 2025 15:57:15 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5088540156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:57:14 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so104406285a.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946233;
 x=1751551033; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlsFSOpEmUN5AxMVbG3yg6qKyFq8qmT/vforkhz3Rlk=;
 b=YHHqkXKrPy998KsV4GZ/NpTWTYrgUhInK+Myu9w1c464R7sDAuo37z4DrW22Y05Peu
 LiX+pVweGqjPJF+o3MwoFbppTJvq3mYte4iKYVPkLmRvNS3jloOd25bD768c/4eJs2/u
 G27D/Ugbkap9hStvZ5IMjGwEOH47oZThOEK0ujFPpglQ4gz0pGB0G9BdjGgLqIHbcL1S
 sw46YjItvJbQa6C8j7X9hSx8zep5ZdsYWEPBIxGZg2gAPyyFQ26Dn1lJGki6SCG0MY5f
 CavV40oT5CVDTjFsjbKU9KUivHVsR+cxT7L2bv6H69c7PSU8O3TlZNa7uFr3ITdhc6NM
 vjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750946233; x=1751551033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlsFSOpEmUN5AxMVbG3yg6qKyFq8qmT/vforkhz3Rlk=;
 b=qtc2mDWw/JWErb1+3sLwZ/AuboKDDAYvNmYCAAxCJd4PgcCK3vk2RhovIMRvqqvdH2
 kvOST20xmvVcR0cQJsM1hbNkIQaQE+weTIEbbV1BNrJQ9sIsol/d/JCU4GbkpnypHiao
 R46asyjbcNyQMgbxXZbzXP+c2ucquf2dhQAfhwX9pFMBQiC1tqbKoKQS850l2TiMUEzW
 rz+WhdIgQsxaU5vHohwdeGi8s1ns2aLxSqYm5RYFqkidHYzRdq4BYuGE3Vhh4hpAxaJ3
 aCYy9B/HNVc0ssPqx3u6xMDFM+Esw7BbBpbHUxrbuQ0KyjX4y7yD1VPqpubcS5ofQLaP
 8BZA==
X-Gm-Message-State: AOJu0YzwRBRgJ1pjrig7P5EsyUBSInEwe8BPVGakRge4ZIbkqbdAD7Be
 KJISNXPs0ZuQn7Do8JdcxefiKypyA78wUNjHjTVFfGaRXgcc+a70Kaxe1AIydjYyYrs=
X-Gm-Gg: ASbGncuFQmWWuXjGOWjnRGwQNZC3gZuwjtpGmKyvdNcvlBUNoHym+fA5lTlidUHWkRT
 3tdlpsZ8jWS3D3ZE90p8Q5FNnESj7O/w2YYr4CNVH9uVmhC7lqKTAxl8GvlTW/jZPf/aiWqLbu6
 82A6VYq3oVyPmQ3zyUHpxop8C40Rzzi78q00/WBZF/RE8vkbeDSQs/waHX6QI+7X67yiz2xMqGn
 66HflRRXrqj8sXVitjJxPUBLM8KOxE3ATWXBkXJuAHk+LZWWwVyVlLEZWROGachzT6nalteQ7Iz
 vLlIwht0RZuLHHtdjqCDjML8SvsFD7OCn4xUuvvZ1hE4vMLhyAgQj3t0DG8CT6Qjn05xmjRhdUP
 NdCgIgzJpmXkxCz64X4xZj3Bq4tfFPBJ4JlSrMhE=
X-Google-Smtp-Source: AGHT+IGFzuye4NM5y+TQx2ykUeiQq/N/v5dQPXQw/OxMRoUn71wqK9Iq4hPZGDl4ywSF4Hn+yXRWxQ==
X-Received: by 2002:a05:620a:458b:b0:7d3:9260:6db0 with SMTP id
 af79cd13be357-7d429679ae2mr885991485a.3.1750946233345; 
 Thu, 26 Jun 2025 06:57:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771c0d3esm7667676d6.42.2025.06.26.06.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:57:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:57:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250626065710.771a2b9b@hermes.local>
In-Reply-To: <20250609211937.345620-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250609211937.345620-1-schneide@qti.qualcomm.com>
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

On Mon,  9 Jun 2025 15:19:37 -0600
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
> Cc: stephen@networkplumber.org

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
