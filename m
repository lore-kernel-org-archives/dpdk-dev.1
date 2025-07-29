Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A59DC87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 21:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA9740653;
	Tue, 29 Jul 2025 23:46:18 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8ADCB4060F
 for <dev@dpdk.org>; Tue, 29 Jul 2025 23:46:16 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7e2c1dc6567so385347585a.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753825576;
 x=1754430376; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6omSYdlIu4fkBCovVjTFG6zSJ8KMuawaiWODptZnUrg=;
 b=eoEs00dlVKLeUj6EaeBo11uD2xe8CFcKosBjyTYfjRtmBIHuoeFZizuEwjuMUDq4Tf
 R2276tbYDPvByGfa7ioazZ05I7bpS+0oHAHUAqx/MOSye8Unbmq/aeaXNnQPkxhCzACB
 T8X3rTN1d6AQfcl9STkhChilqFDGar0uq29pzznij1MHam2yw/XFcNXTu8P94z8cUuyT
 mJDn6gJj99hhgEfQ3y5bRJuJHeZQS9rGmxAuLX0fmxgEoamAnlyUgRbaYe8tg+0umjo/
 LLNN+NH3ObC2aUk5hjnRmLERNErHN6Ii0NkezCucHR6kUBvDC5Kn7yAJtgIUzzKIdvcA
 Xyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753825576; x=1754430376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6omSYdlIu4fkBCovVjTFG6zSJ8KMuawaiWODptZnUrg=;
 b=sloD2ZJqhoBYu/Rx0sLNMBrLt1on41qzyxa2WEKvl8vWN6jmhMQRqudN2TjjjSKoLV
 I+nk7ts+yk2mm4t1ev+9p7wBMQRFf3w/leMguIUixwENUAGWSuP4umM7b6+mExAGgcf8
 iQs1IS0dM794v39juF9jvQ+peoKmrbdZ+x9SMNFRDJAt4Uauvo56uD1Wdhe8V1Uz0bVq
 WTuEbiHRiV+Wsv6s36Sy6QxP+tyd1OFxabxgz4EOZvIarCmgmHGJ1Z1aKPuzoN32VJTi
 oAEEMxLVMuHb4cW4Arvmq6J7OuuXZX2Dtxp4A4EJEsj/mqf8SkRjJ5FwODgipAV1mp7q
 V7NA==
X-Gm-Message-State: AOJu0YyTSKbGdgf0lUBgcAkCtfFDR2JTqI2Q+j8HM7lpvvkpzngR9+qB
 x/5pYxvVPU/cDJMzhq8d0PZnp7wvoDZjWFk+4HsFcYasVc7/JbYGBn7wQ+/u8+UZGm4=
X-Gm-Gg: ASbGnctiBHRrPPQAXQSI9+I/oMKC23F2/mY2XYyx8Vi4IMw1swWWXxa38xwE44IJRfF
 uwCbuPHcCG+TJE2ixPw3haTYlR+SFeRFPaFljZMtxvIXkYQIAX8/TlCz+H0Xd7llKOeyyTtrSxw
 Hgo6uMY9+MaLpdVu1NzrXVUoVCkT/Uw2qZXG7kLVLj5QupqKV4Nfnl7HSECh4SR65ULumgJhnJX
 giQMj/vLCwoLmmKWe7qDSJzNRwkrO4kXmRpVze7tQqrPSeGcosFOEyNs2D/fB7Q4uPg9CySxG9Y
 vqKD9mE+0CutTwUOvm2RllgnCv0F+LuzXcNL8ZgpfZNhdgSKsKXdeSzCdID0wKrfo9d3oKBzX4M
 hN+oonWze0Rc9WJZ4pq8CYaOxj+2fKbO0EZqMB5AZkewbd1Ilqs05htOtniZPcWJ+oVqDeSm2BL
 4=
X-Google-Smtp-Source: AGHT+IH6xJJMaVu88cNWNIqSqx3wRN1CF9WaA1hv5CHNwg/aWKgJEBOSnaFOOKcTKYBbeUPpU+/qXQ==
X-Received: by 2002:a05:620a:1727:b0:7e6:3168:ce58 with SMTP id
 af79cd13be357-7e66f3a6ba7mr202845685a.48.1753825575814; 
 Tue, 29 Jul 2025 14:46:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64387a19csm483058685a.61.2025.07.29.14.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 14:46:15 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:46:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
Message-ID: <20250729144611.46078d65@hermes.local>
In-Reply-To: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Mon, 21 Jul 2025 03:38:51 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the primary process exits, the shared mlx5 state becomes
> unavailable to secondary processes. If a secondary process attempts
> to query device information (e.g., via testpmd), a NULL dereference
> may occur due to missing shared data.
> 
> This patch adds a check for shared context availability and fails
> gracefully while preventing a crash.
> 
> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---

NAK
As per other thread. Drivers need not worry about this.
If secondary gets to this point it is using freed bus and device information
and nothing is valid.
